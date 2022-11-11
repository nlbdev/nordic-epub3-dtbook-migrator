<?php
require_once __DIR__ . '/../include/onedrive_client.php';

function oneDriveLogin(OneDriveClient $client) {
    return $client->login(
        $_ENV['ONEDRIVE_USERACCOUNT'],
        $_ENV['ONEDRIVE_APP_ID'] . '|' . $_ENV['ONEDRIVE_TENANT'],
        $_ENV['ONEDRIVE_SECRET']
    );
}

function getFileFromLocalPath($filename, $background = false) {
    $localFile = tempnam(sys_get_temp_dir(), 'LOCAL_EPUB');

    copy($filename, $localFile);

    $temp_file = tempnam(sys_get_temp_dir(), 'EPUB');
    unlink($temp_file);
    system("mkdir -p $temp_file");

    $result = array();
    exec("unzip -d $temp_file $localFile", $result, $returnval);

    system("rm -rf ".escapeshellarg($localFile));

    return $temp_file;
}

function getFileFromOneDrive($filename, $background = false) {
    $localFile = tempnam(sys_get_temp_dir(), pathinfo($filename)['filename']);

    $oneDriveClient = new OneDriveClient();
    if (!oneDriveLogin($oneDriveClient)) {
        echo "- Could not login.\n";
        return false;
    }

    $remoteDir = $_ENV['ONEDRIVE_PATH'];
    if (!$oneDriveClient->changeDir($remoteDir)) {
        echo "- Could not change dir to '{$remoteDir}'.\n";
        return false;
    }

    if (!$oneDriveClient->getFile($filename, $localFile, $background)) {
        echo "- Could not download file '{$filename}'.\n";
        return false;
    }
    $oneDriveClient->logout();

    return $localFile;
}

function filesExistOnOneDrive($filenames) {
    $oneDriveClient = new OneDriveClient();
    if (!oneDriveLogin($oneDriveClient)) {
        echo "- Could not login.\n";
        die();
    }
    $remoteDir = $_ENV['ONEDRIVE_PATH'];
    if (!$oneDriveClient->changeDir($remoteDir)) {
        echo "- Could not change dir to '{$remoteDir}'.\n";
    }

    foreach($filenames as $filename) {
        if (!$oneDriveClient->hasFile($filename)) {
            $oneDriveClient->logout();
            return "File missing: " . $filename;
        }
    }
    $oneDriveClient->logout();

    return true;
}

function putFileOnOneDrive(string $localFile, string $remoteFile, bool $overwrite = true) {
    $oneDriveClient = new OneDriveClient();
    if (!oneDriveLogin($oneDriveClient)) {
        echo "- Could not login.\n";
        return false;
    }

    $remoteDir = $_ENV['ONEDRIVE_PATH'];
    if (!$oneDriveClient->changeDir($remoteDir)) {
        echo "- Could not change dir to '{$remoteDir}'.\n";
    }

    if ($oneDriveClient->hasFile($remoteFile)) {
        if ($overwrite) {
            $oneDriveClient->deleteFile($remoteFile);
        } else {
            return false;
        }
    }

    $success = $oneDriveClient->putFile($remoteFile, $localFile);
    $oneDriveClient->logout();

    return $success;
}

function checkLocalFiles($localPath, $filenames) {
    foreach($filenames as $filename) {
        if (!file_exists($localPath . '/' . $filename)) {
            return "File missing: " . $filename;
        }
    }
    return true;
}

function checkFiles($filenames) {
    $oneDriveClient = new OneDriveClient();
    if (!$oneDriveClient->login(
        $_ENV['ONEDRIVE_USERACCOUNT'],
        $_ENV['ONEDRIVE_APP_ID'] . '|' . $_ENV['ONEDRIVE_TENANT'],
        $_ENV['ONEDRIVE_SECRET']
    )) {
        echo "- Could not login.\n";
        die();
    }
    $remoteDir = $_ENV['ONEDRIVE_PATH'];
    if (!$oneDriveClient->changeDir($remoteDir)) {
        echo "- Could not change dir to '{$remoteDir}'.\n";
    }

    foreach($filenames as $filename) {
        if (!$oneDriveClient->hasFile($filename)) {
            $oneDriveClient->logout();
            return "File missing: " . $filename;
        }
    }
    $oneDriveClient->logout();

    return true;
}

function getFileFromUpload($filedata) {
    $localFile = tempnam(sys_get_temp_dir(), 'LOCAL_EPUB');

    if (move_uploaded_file($filedata['tmp_name'], $localFile)) {
        return $localFile;
    } else {
        system("rm -rf ".escapeshellarg($localFile));
        return null;
    }
}

function getTitle($localFile) {
    $zip = new ZipArchive();
    if ($zip->open($localFile) !== true) {
        return false;
    }

    $title = false;

    for ($i = 0; $i < $zip->numFiles; ++$i) {
        $name = $zip->getNameIndex($i);
        if (strpos(strtolower($name), 'ncc.html') !== false) {
            // Handle DTBook
            $nccHtml = $zip->getFromIndex($i);
            $doc = new DOMDocument();
            if ($doc->loadHTML($nccHtml) !== false) {
                $xpath = new DOMXPath($doc);
                $xpath->registerNamespace("x", "http://www.w3.org/1999/xhtml");
                if ($xpath->query("//x:title")->item(0) !== null) {
                    $title = trim($xpath->query("//x:title")->item(0)->textContent);
                }
            }
        } else if (strpos(strtolower($name), 'package.opf') !== false) {
            // Handle epub
            $opfXml = $zip->getFromIndex($i);
            $doc = new DOMDocument();
            if ($doc->loadXML($opfXml) !== false) {
                $xpath = new DOMXPath($doc);
                if ($xpath->query("//dc:title")->item(0) !== null) {
                    $title = trim($xpath->query("//dc:title")->item(0)->textContent);
                }
            }
        }
    }

    $zip->close();

    return $title;
}


function validateFile($localFile, $reportConfiguration, $remoteFilename) {
    $response = new \stdClass;

    $title = getTitle($localFile);
    $response->uploadFilePath = $remoteFilename;
    $response->datetime = date("Y-m-d H:i:s");
    $response->book = $title;
    $response->schema = '2020-1';
    $response->report = '';

	$flags = '';
	if ($reportConfiguration !== null && $reportConfiguration->noEPUBCheck) {
		$flags = ' --no-epubcheck';
	}
	if ($reportConfiguration !== null && $reportConfiguration->noACE) {
		$flags = ' --no-ace';
	}

    $tempJsonReport = tempnam(sys_get_temp_dir(), 'validation-report-json-');
    $tempHtmlReport = tempnam(sys_get_temp_dir(), 'validation-report-html-');
    $validatorPath = realpath(__DIR__.'/../bin/NordicValidator.jar');
    $cmd = '/usr/bin/java -Xmx3g -jar '.escapeshellarg($validatorPath) .
           ' ' . escapeshellarg($localFile) . $flags .
           ' --output-json ' . escapeshellarg($tempJsonReport) .
           ' --output-html ' . escapeshellarg($tempHtmlReport) .
           ' --original-file ' . escapeshellarg(basename($remoteFilename));
    if ($reportConfiguration !== null) {
        switch ($reportConfiguration->schema) {
            case '2020-1':
                $cmd .= ' --schema 2020-1';
                $response->schema = '2020-1';
                break;
            case '2015-1':
                $cmd .= ' --schema 2015-1';
                $response->schema = '2015-1';
                break;
        }
    }
    $output = [];
    exec($cmd, $output, $retval);
    $output = implode("\n", $output);

    if (is_string($reportConfiguration->uploadFilePath) && $reportConfiguration->uploadFilePath !== '') {
        $htmlReportPath = $reportConfiguration->uploadFilePath;
        if (!putFileOnOneDrive($tempHtmlReport, $htmlReportPath, true)) {
            echo '- Failed to store html report to OneDrive: "'.$htmlReportPath."\"\n";
        }
    }

    $jsonReport = json_decode(file_get_contents($tempJsonReport));
    system("rm -rf ".escapeshellarg($localFile));

    $response->report = $jsonReport;

    return $response;
}
