<?php

if (isset($_GET['destination']) && !preg_match('/^[\w@._-]+$/', $_GET['destination'])) {
    http_response_code(403);
    exit;
}

if (isset($_GET['port']) && !preg_match('/^\d+$/', $_GET['port'])) {
    http_response_code(403);
    exit;
}

if (isset($_GET['password']) && !preg_match('/^[\w_-]+$/', $_GET['password'])) {
    http_response_code(403);
    exit;
}

if (isset($_GET['key']) && !preg_match('/\A[\r\n A-Z0-9a-z+\/=\-]+\z/', $_GET['key'])) {
    http_response_code(403);
    exit;
}

$id = uniqid();
file_put_contents("/tmp/$id.json", json_encode($_GET));

header("Location: https://effective-space-umbrella-x5rgrr7qgj6hpjr-7681.app.github.dev/?arg=$id");
