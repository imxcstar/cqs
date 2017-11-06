<?php


header('Content-Type: application/json;charset=utf-8');

if ('getcode' == $sz) {
    $sz = '';
    $code = '';
    $uid = $_SESSION['uid'];

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
    echo '{"status":-1,"info":"You do not have permissions to have lists and pages within My Site."}';
}
