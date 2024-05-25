<?php

session_start();

// $key = json_decode(file_get_contents("check-c.json"),true);

if(isset($_SESSION['IAm-logined'])){
	header('location: ./Panel.php');
	exit;
}

else{
	header("location: ./auth/login.php");
	exit;
}

?>