<?php

$id = uniqid();
file_put_contents("/tmp/$id.json", json_encode($_GET));

header("Location: https://effective-space-umbrella-x5rgrr7qgj6hpjr-7681.app.github.dev/?arg=$id");
