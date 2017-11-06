var sleep = function (numberMillis) {
    var now = new Date();
    var exitTime = now.getTime() + numberMillis;
    while (true) {
        now = new Date();
        if (now.getTime() > exitTime)
            return;
    }
}

$("#login").click(function () {
    if ($('#username').val().length < 5) {
        new $.zui.Messager('账号长度至少需要5位数！', {
            icon: 'info',
            type: 'info'
        }).show();
        return;
    }
    if ($('#password').val().length < 6) {
        new $.zui.Messager('密码长度至少需要6位数！', {
            icon: 'info',
            type: 'info'
        }).show();
        return;
    }
    $.ajax({
        url: '/?z=login',
        type: 'POST',
        dataType: 'json',
        data: {
            name: $('#username').val(),
            pass: $('#password').val()
        },
        success: function (data) {
            if (data.status === 0) {
                location.reload();
            } else {
                $.ajax({
                    url: '/?z=register',
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        name: $('#username').val(),
                        pass: $('#password').val()
                    },
                    success: function (data) {
                        if (data.status === 0) {
                            location.reload();
                        } else {
                            new $.zui.Messager(data.info, {
                                icon: 'info',
                                type: 'info'
                            }).show();
                        }
                    }
                });
            }
        }
    });
});