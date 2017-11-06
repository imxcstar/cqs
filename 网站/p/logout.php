<?php


header('Content-Type: application/json;charset=utf-8');

if ('logout' == $sz && true == $_SESSION['slogin']) {
    $sz = '';

    $_SESSION['slogin'] = false;

    echo '{"status":0,"info":"logout success"}';
} else {
    echo '{"status":-1,"info":"You do not have permissions to have lists and pages within My Site."}';
}
