<?php


header('Content-Type: application/json;charset=utf-8');

if ('register' == $sz) {
    $sz = '';

    $name = strtolower(rPost('name'));

    $pass = strtolower(rPost('pass'));

    $key = $mymod->ckey($name.$pass);
    if (strlen($name) >= 5 && strlen($name) <= 10 && strlen($pass) >= 6 && strlen($pass) <= 10) {
        if (!$database->has('user', [
            'name' => $name,
        ])) {
            $database->insert('user', [
                'name' => $name,

                'password' => $pass,

                'key' => $key,
            ]);
            $uid = $database->id();
            $_SESSION['slogin'] = true;
            $_SESSION['uid'] = $uid;
            $_SESSION['username'] = $name;
            $_SESSION['key'] = $key;

            echo '{"status":0,"info":"Register success"}';
        } else {
            echo '{"status":-3,"info":"Register error"}';
        }
    } else {
        echo '{"status":-2,"info":"The length of the registration information is not enough!"}';
    }
} else {
    echo '{"status":-1,"info":"You do not have permissions to have lists and pages within My Site."}';
}
