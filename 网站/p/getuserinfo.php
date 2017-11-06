<?php


header('Content-Type: application/json;charset=utf-8');

if ('getuserinfo' == $sz) {
    $sz = '';
    $userinfo = array();
    $userinfo['status'] = 0;
    $userinfo['info'] = 'GetUserInfo success';
    $userinfo['uid'] = $_SESSION['uid'];
    $userinfo['username'] = $_SESSION['username'];
    $userinfo['key'] = $_SESSION['key'];

    echo json_encode($userinfo);
} else {
    echo '{"status":-1,"info":"You do not have permissions to have lists and pages within My Site."}';
}
