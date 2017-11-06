<?php


header('Content-Type: application/json;charset=utf-8');

if ('savecode' == $sz) {
    $sz = '';
    $code = rPost('code');
    $uid = $_SESSION['uid'];

    if ($database->has('data', [
        'uid' => $uid,
    ])) {
        $database->update('data', [
            'cdata' => base64_encode($code),
        ], [
            'uid' => $uid,
        ]);
    } else {
        $database->insert('data', [
            'uid' => $uid,

            'cdata' => base64_encode($code),
        ]);
    }
    echo '{"status":0,"info":"SaveCode success"}';
} else {
    echo '{"status":-1,"info":"You do not have permissions to have lists and pages within My Site."}';
}
