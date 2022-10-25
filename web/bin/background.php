<?php
require_once __DIR__ . '/../include/file_handler.php';

set_time_limit(0);

$workDir = $_ENV["WORKDIR"];

$resultDir = $workDir . "/result/";
$jobDir = $workDir . '/work/';

@mkdir($resultDir);
@mkdir($jobDir);

$files = scandir($jobDir);
foreach ($files as $file) {
    if (substr($file, 0, 1) === '.') continue;

    $jobFile = $jobDir . $file;

    if (time() > filemtime($jobFile) + 30) {
        echo "Start work on job: " . $file . "<br>";

        $jobData = file_get_contents($jobFile);
        unlink($jobFile);

        performJob($jobData, $resultDir . $file);

        echo "Job done " . $file . "<br>";
        break;
    }
}

function performJob(string $jobData, string $resultFile) {
    $json = json_decode($jobData);

    $resultFileTmp = $resultFile . '.tmp';

    file_put_contents($resultFileTmp, '[', FILE_APPEND);
    $first = true;

    foreach ($json->downloadFilePaths as $remoteFile) {
        if (!$first) {
            file_put_contents($resultFileTmp, ',', FILE_APPEND);
        }
        $first = false;

        echo "Start work on file: " . $remoteFile . "<br>\n";
        $localFile = getFileFromOneDrive($remoteFile, true);
        if ($localFile === false) {
            $response = new \stdClass;
            $response->uploadFilePath = $remoteFile;
            $response->datetime = date("Y-m-d H:i:s");
            $response->errorMessage = "Could not download file from OneDrive.";
            file_put_contents($resultFileTmp, json_encode($response), FILE_APPEND);
            continue;
        }
        echo "Downloaded: " . $remoteFile . "<br>\n";
        $response = validateFile($localFile, $json->config, $remoteFile);
        system('rm -rf '.escapeshellarg($localFile));
        echo "Done with file: " . $remoteFile . "<br>\n";

        file_put_contents($resultFileTmp, json_encode($response), FILE_APPEND);
    }
    file_put_contents($resultFileTmp, ']', FILE_APPEND);

    rename($resultFileTmp, $resultFile);
}