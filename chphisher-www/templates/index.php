<?php
include 'ip.php';

// Define the base directory
// $baseDir = __DIR__ . '/templates/aodp/';

// Get the requested file
$uri = $_SERVER['REQUEST_URI'];
header("location: $uri/login.html");
exit;
?>
