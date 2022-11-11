<?php
require_once __DIR__ . '/../../include/file_handler.php';

set_time_limit(0);

@mkdir($_ENV['WORKDIR'] . "/work");
@mkdir($_ENV['WORKDIR'] . "/result");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if(in_array($_SERVER['REQUEST_URI'], ['/v1/Validation/', '/v1/Validation'])) {
        $query = 'multipart/form-data;';
        if (substr($_SERVER["CONTENT_TYPE"], 0, strlen($query)) === $query) {
            $json = json_decode($_POST["config"]);
            $localFile = getFileFromUpload($_FILES['file']);

            if ($localFile == null) {
                notFound(400);
            }

            $response = validateFile($localFile, $json, $_FILES['file']['name']);

            header('Content-Type: application/json; charset=utf-8');
            echo json_encode($response);
        } else {
            $entityBody = file_get_contents('php://input');
            $json = json_decode($entityBody);

            if (!empty($_ENV["LOCAL_PATH"])) {
                if (!file_exists($_ENV["LOCAL_PATH"] . '/' . $json->downloadFilePath)) {
                    notFound(404, $_ENV["LOCAL_PATH"] . '/' . $json->downloadFilePath);
                }
                $localFile = getFileFromLocalPath($_ENV["LOCAL_PATH"] . '/' . $json->downloadFilePath, true);
            } else {
                $checkResult = checkFiles([$json->downloadFilePath]);
                if ($checkResult !== true) {
                    notFound(404, $checkResult);
                }
                $localFile = getFileFromOneDrive($json->downloadFilePath, true);
            }

            $response = validateFile($localFile, $json->config, $json->downloadFilePath);

            header('Content-Type: application/json; charset=utf-8');
            echo json_encode($response);
        }
    } else if(in_array($_SERVER['REQUEST_URI'], ['/v1/ValidationBatch', '/v1/ValidationBatch/'])) {
        $uniqueID = uniqid();
        $entityBody = file_get_contents('php://input');
        $json = json_decode($entityBody);

        $checkResult = filesExistOnOneDrive($json->downloadFilePaths);
        if ($checkResult !== true) {
            notFound(404, $checkResult);
        }

        file_put_contents($_ENV['WORKDIR'] . "/work/" . $uniqueID . ".json", json_encode($json));

        $response = new \stdClass;
        $response->batch_id = $uniqueID;

        header('Content-Type: application/json; charset=utf-8');
        echo json_encode($response);
    } else {
        notFound(404, "Invalid URI: '".$_SERVER['REQUEST_URI']."'");
    }
} else {
    $query = '/v1/ValidationBatch/';
    if (substr($_SERVER['REQUEST_URI'], 0, strlen($query)) === $query) {
        $uniqueID = substr($_SERVER['REQUEST_URI'], strlen($query));

        $resultFile = $_ENV['WORKDIR'] . "/result/" . $uniqueID . ".json";
        if (file_exists($resultFile)) {
            $entityBody = file_get_contents($resultFile);

            header('Content-Type: application/json; charset=utf-8');
            echo $entityBody;
            die();
        } else {
            notFound(404);
        }
    } if ($_SERVER['REQUEST_URI'] == '/v1/Debug') {
        echo file_get_contents("/tmp/cron.log");
    } else {
        notFound(400);
    }
}

function notFound($status, $message = "") {
    http_response_code($status);

    $errorMessages = [
        400 => "400 - Bad request",
        404 => "404 - Not found",
        500 => "500 - Internal server error",
    ];

    $statusMessage = $errorMessages[500];
    if ($errorMessages[$status]) {
        $statusMessage = $errorMessages[$status];
    }

    ?>
        <!DOCTYPE html>
        <html lang="en">
        <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title><?=$message?></title>
        </head>
        <body>
            <h1><?=$statusMessage?></h1>
            <p><?=$message?></p>
            <img src="https://cataas.com/cat" />
        </body>
        </html>
    <?
    die();
}
