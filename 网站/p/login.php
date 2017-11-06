<?php


header('Content-Type: application/json;charset=utf-8');

if ('login' == $sz) {
    $sz = '';

    $name = strtolower(rPost('name'));

    $pass = strtolower(rPost('pass'));

    if ($database->has('user', [
        'AND' => [
            'name' => $name,

            'password' => $pass,
        ],
    ])) {
        $userinfo = $database->select('user', '*', [
            'name' => $name,

            'password' => $pass,
        ]);

        $_SESSION['slogin'] = true;
        $_SESSION['uid'] = $userinfo[0]['uid'];
        $_SESSION['username'] = $name;
        $_SESSION['key'] = $userinfo[0]['key'];

        echo '{"status":0,"info":"Login success"}';
    } else {
        echo '{"status":-2,"info":"Login error"}';
    }
} else {
    echo '{"status":-1,"info":"You do not have permissions to have lists and pages within My Site."}';
}
