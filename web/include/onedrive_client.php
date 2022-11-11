<?php
class OneDriveClient
{
  private $loggedIn = false;
  private $accessToken = null;
  private $baseurl = null;
  private $currentDirectory = false;

  public function __construct() {}

  public function __destruct()
  {
    $this->logout();
  }

  public function login(string $userAccount, string $appIdAndTenant, string $secret)
  {
    list($appId, $tenant) = explode('|', $appIdAndTenant, 2);

    if ($this->loggedIn) {
      return true;
    }

    $postdata = http_build_query([
      'client_id'     => $appId,
      'client_secret' => $secret,
      'resource'      => 'https://graph.microsoft.com/',
      'grant_type'    => 'client_credentials',
    ]);

    $context = stream_context_create([
      'http' => [
        'method'  => 'POST',
        'header'  => 'Content-Type: application/x-www-form-urlencoded',
        'content' => $postdata
      ]
    ]);

    $token = @json_decode(@file_get_contents(
      "https://login.microsoftonline.com/{$tenant}/oauth2/token?api-version=1.0", false, $context
    ));

    if ($token !== null) {
      $this->baseurl = "https://graph.microsoft.com/v1.0/users/{$userAccount}/drive/root:";
      $this->accessToken = $token->access_token;
      $this->loggedIn = true;
    }

    return $this->loggedIn;
  }

  public function logout()
  {
    $this->accessToken = null;
    $this->loggedIn = false;
  }

  private function getFileFromURL(string $url, string $localFile, bool $background)
  {
    $targetFile = fopen( $localFile, 'w' );

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array("Authorization: Bearer {$this->accessToken}"));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    if ($background) {
      curl_setopt($ch, CURLOPT_PROGRESSFUNCTION, array($this, 'progress'));
      curl_setopt($ch, CURLOPT_NOPROGRESS, false);
    }
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 0);
    curl_setopt($ch, CURLOPT_NOSIGNAL, 1);
    curl_setopt($ch, CURLOPT_TIMEOUT, 3600);
    curl_setopt($ch, CURLOPT_FILE, $targetFile );
    curl_exec($ch);
    fclose( $targetFile );

    if (curl_errno($ch)) {
      echo "CURL ERROR - " . curl_error($ch);
      return false;
    } else {
      $information = curl_getinfo($ch);

      if ($information['http_code'] === 302) {
        return $this->getFileFromURL($information['redirect_url'], $localFile, $background);
      } else if ($information['http_code'] !== 200) {
        echo "HTTP CODE - " . $information['http_code'];
        return false;
      }
    }
    return true;
  }

  public function getFile(string $remoteFile, string $localFile, bool $background)
  {
    if (!$this->loggedIn || !$this->currentDirectory) {
      return false;
    }

    $remotePath = $this->normalizePath($this->currentDirectory . '/' . $remoteFile);
    return $this->getFileFromURL($this->baseurl . $remotePath . ':/content', $localFile, $background);
  }

  public function progress($resource,$download_size, $downloaded, $upload_size, $uploaded)
  {
    if($download_size > 0) {
      echo $downloaded . "/" . $download_size . " " .($downloaded / $download_size  * 100) . "% <br>\n";
    }
    sleep(1); // just to see effect
  }

  public function hasFile(string $remoteFile, int $minimumAgeInSeconds = 0)
  {
    if (!$this->loggedIn || !$this->currentDirectory) {
      return false;
    }

    $remotePath = $this->normalizePath($this->currentDirectory . '/' . $remoteFile);

    $result = @file_get_contents($this->baseurl . $remotePath, false, $this->getContext('GET'));
    if ($result !== false) {
      $jsonObj = @json_decode($result);
      return
        $jsonObj !== null &&
        !property_exists($jsonObj, 'folder') &&
        time() - strtotime($jsonObj->lastModifiedDateTime) > $minimumAgeInSeconds;
    }

    return false;
  }

  private function putLargeFile(string $remoteFile, string $localFile)
  {
    $remotePath = $this->normalizePath($this->currentDirectory . '/' . $remoteFile);

    $fileUploadCommand = [
      'item' => [
        '@odata.type' => 'microsoft.graph.driveItemUploadableProperties',
        '@microsoft.graph.conflictBehavior' => 'replace',
        'name' => $remoteFile
      ]
    ];

    $result = @file_get_contents($this->baseurl . $remotePath . ':/createUploadSession', false, $this->getContext('PUT', json_encode($fileUploadCommand)));
    if ($result !== false) {
      $json_result = json_decode($result);

      $data = @file_get_contents($localFile);

      $length = strlen($data);
      $startPos = 0;

      $dataArr = str_split($data, 1024 * 1024);

      foreach($dataArr as $chunkData) {
        $chunkLen = strlen($chunkData);
        $endPos = $startPos + $chunkLen - 1;

        $uploadContext = stream_context_create([
          'http' => [
            'method'  => 'PUT',
            'header'  =>
              "Content-Length: $chunkLen\r\n" .
              "Content-Range: bytes $startPos-$endPos/$length\r\n" .
              "Content-Type: application/json\r\n" .
              "Authorization: Bearer {$this->accessToken}",
            'content' => $chunkData
          ]
        ]);
        $result = @file_get_contents($json_result->uploadUrl, false, $uploadContext);

        $startPos += $chunkLen;

        if ($result === false) {
          return false;
        }
      }

      return true;
    }

    return false;
  }

  public function putFile(string $remoteFile, string $localFile)
  {
    if (!$this->loggedIn || !$this->currentDirectory) {
      return false;
    }

    if (filesize($localFile) > 3 * 1024 * 1024) {
      return $this->putLargeFile($remoteFile, $localFile);
    }

    $data = @file_get_contents($localFile);
    if ($data !== false) {
      $remotePath = $this->normalizePath($this->currentDirectory . '/' . $remoteFile);

      $result = @file_get_contents($this->baseurl . $remotePath . ':/content', false, $this->getContext('PUT', $data));
      if ($result !== false) {
        return true;
      }
    }

    return false;
  }

  public function deleteFile(string $remoteFile)
  {
    if (!$this->loggedIn || !$this->currentDirectory) {
      return false;
    }

    $remotePath = $this->normalizePath($this->currentDirectory . '/' . $remoteFile);

    $result = @file_get_contents($this->baseurl . $remotePath, false, $this->getContext('DELETE'));
    if ($result !== false) {
      return true;
    }

    return false;
  }

  public function hasDir(string $remoteDir)
  {
    if (!$this->loggedIn) {
      return false;
    }

    if ($this->currentDirectory !== false) {
      $remotePath = $this->normalizePath($this->currentDirectory . '/' . $remoteDir);
    }

    $result = @file_get_contents($this->baseurl . $remotePath, false, $this->getContext('GET'));
    if ($result !== false) {
      $jsonObj = @json_decode($result);
      return $jsonObj !== null && property_exists($jsonObj, 'folder');
    }

    return false;
  }

  public function createDir(string $remoteDir)
  {
    if (!$this->loggedIn || !$this->currentDirectory) {
      return false;
    }

    $data = [
      'name' => $remoteDir,
      'folder' => new stdClass(),
      '@microsoft.graph.conflictBehavior' => 'fail'
    ];

    $result = @file_get_contents($this->baseurl . $this->currentDirectory . ':/children', false, $this->getContext('POST', json_encode($data)));
    if ($result !== false) {
      return true;
    }

    return false;
  }

  public function changeDir(string $remoteDir)
  {
    if (!$this->loggedIn) {
      return false;
    }

    if (strpos($remoteDir, '/') !== 0) {
      $remoteDir = $this->normalizePath($this->currentDirectory . '/' . $remoteDir);
    }

    $result = file_get_contents($this->baseurl . $remoteDir, false, $this->getContext('GET'));
    if ($result !== false) {
      $this->currentDirectory = $remoteDir;
      return true;
    }

    return false;
  }

  public function getFileList(string $path = '.')
  {
    if (!$this->loggedIn || !$this->currentDirectory) {
      return [];
    }

    $fileList = [];

    $remoteDir = $this->normalizePath($this->currentDirectory . '/' . $path);

    $result = @file_get_contents($this->baseurl . $remoteDir . ':/children', false, $this->getContext('GET'));
    if ($result !== false) {
      $jsonObj = json_decode($result);
      if ($jsonObj !== null) {
        foreach ($jsonObj->value as $file) {
          $fileList[] = $file->name;
        }
      }
    }

    return $fileList;
  }

  private function getContext(string $method, string $content = null)
  {
    if ($content !== null) {
      return stream_context_create([
        'http' => [
          'method'  => $method,
          'header'  => "Content-Type: application/json\r\nAuthorization: Bearer {$this->accessToken}",
          'content' => $content
        ]
      ]);
    } else {
      return stream_context_create([
        'http' => [
          'method'  => $method,
          'header'  => "Authorization: Bearer {$this->accessToken}",
        ]
      ]);
    }
  }

  /**
   * Get normalized path, like realpath() for non-existing path or file
   *
   * @param string $path path to be normalized
   * @return false|string|string[]
   */
  private function normalizePath(string $path)
  {
    return array_reduce(explode('/', $path), function($a, $b) {
      if ($a === null) {
        $a = '/';
      }
      if ($b === '' || $b === '.') {
        return $a;
      }
      if ($b === '..') {
        return dirname($a);
      }

      return preg_replace("/\/+/", '/', "$a/$b");
    });
  }
}
