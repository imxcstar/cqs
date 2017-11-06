<?php

header('Content-Type: application/json;charset=utf-8');

require './p/Medoo.php';
require './p/mod.php';

use Medoo\Medoo;

$database = new medoo([
    'database_type' => 'mysql',

    'database_name' => '',

    'server' => 'localhost',

    'username' => '',

    'password' => '',

    'charset' => 'utf8',
]);

session_start();
setcookie(session_name(), session_id(), time() + 24 * 3600, '/');

function rGet($zz)
{
    return trim(htmlentities($_GET[$zz]));
}

function rPost($zz)
{
    return trim(htmlentities($_POST[$zz]));
}

$slogin = $_SESSION['slogin'];
$mymod = new Mymod();
$z = strtolower(rGet('z'));
$sz = $z;

if (true == $slogin) {
    switch ($z) {
        case 'logout':
            require './p/logout.php';
            break;
        case 'getuserinfo':
            require './p/getuserinfo.php';
            break;
        case 'savecode':
            require './p/savecode.php';
            break;
        case 'getcode':
            require './p/getcode.php';
            break;
        case 'api_getcode':
            require './p/api_getcode.php';
            break;
        case 'fun':
            header('Content-Type: text/html;charset=utf-8');
            echo file_get_contents('./html/fun.html');
            break;
        default:
            //echo '{"status":-1,"info":"You do not have permissions to have lists and pages within My Site."}';
            $sz = '';
            header('Content-Type: text/html;charset=utf-8');
            echo file_get_contents('./html/login.html');
    }
} else {
    switch ($z) {
        case 'login':
            require './p/login.php';
            break;
        case 'logout':
            require './p/logout.php';
            break;
        case 'register':
            require './p/register.php';
            break;
        case 'api_getcode':
            require './p/api_getcode.php';
            break;
        case 'fun':
            header('Content-Type: text/html;charset=utf-8');
            echo file_get_contents('./html/fun.html');
            break;
        default:
            //echo '{"status":-1,"info":"You do not have permissions to have lists and pages within My Site."}';
            $sz = '';
            header('Content-Type: text/html;charset=utf-8');
            echo file_get_contents('./html/index.html');
    }
}
