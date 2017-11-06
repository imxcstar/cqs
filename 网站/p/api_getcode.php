<?php


header('Content-Type: application/json;charset=utf-8');

if ('api_getcode' == $sz) {
    $sz = '';
    $code = '';

    $key = rGet('key');
    if (strlen($key) < 1) {
        $key = rPost('key');
    }

    if (strlen($key) < 1) {
        echo '{"status":-2,"info":"Key error"}';
    } else {
        if ($database->has('user', [
            'key' => $key,
    ])) {
            $userinfo = $database->select('user', '*', [
                'key' => $key,
            ]);

            $uid = $userinfo[0]['uid'];

            if ($database->has('data', [
                'uid' => $uid,
            ])) {
                $codes = $database->select('data', '*', [
                    'uid' => $uid,
                ]);

                $code = $codes[0]['cdata'];
            }
            echo '{"status":0,"info":"GetCode success","data":"'.$code.'"}';
        } else {
            echo '{"status":-3,"info":"Key error"}';
        }
    }
} else {
    echo '{"status":-1,"info":"You do not have permissions to have lists and pages within My Site."}';
}
