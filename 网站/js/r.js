var yyc = ["PHP", "ASP", "ASP.NET", "Python", "C", "C++", "C#", "Java", "JavaScript", "VBScript", "VB.NET", "HTML", "CSS", "JSON", "Ruby", "Perl", "JSP", "Lua", "SQL", "XML"];
var yym = [PHPMode, ASPMode, ASPNETMode, PythonMode, CMode, CJJMode, CCMode, JavaMode, JavaScriptMode, VBScriptMode, VBNETMode, HtmlMode, CssMode, JsonMode, RubyMode, PerlMode, JSPMode, LuaMode, SqlMode, XmllMode];
var yychasht = new HashTable();
var base = new Base64();
var editor = null;
var key = "";
$(document).ready(function () {

    $("html").css("overflow", "hidden");

    function SZGL(YY) {
        var zcz = "";
        if (editor != null)
            zcz = editor.getValue();
        editor = CodeMirror.fromTextArea(document.getElementById("code"), YY);
        if (zcz == "")
            zcz = editor.getValue();
        if ($(".cbl").is(":hidden")) {
            editor.setSize($(window).width(), $(window).height() - 31);
        } else {
            $(".cbl").css("height", $(window).height() - 31);
            editor.setSize($(window).width() - $(".cbl").width(), $(window).height() - 31);
        }
        editor.setOption("theme", "elegant");
        editor.setValue(zcz);
        $.ajax({
            url: "/?z=GetCode&t=" + (new Date()).getTime(),
            type: "get",
            dataType: "json",
            success: function (data) {
                if (data.status === 0) {
                    var zcfh = decodeURIComponent(base.decode(data.data));
                    if (zcfh.length > 0) {
                        editor.setValue(zcfh);
                    }
                } else {
                    new $.zui.Messager(data.info, {
                        icon: 'info',
                        type: 'info'
                    }).show();
                }
            }
        });
    }

    $(window).resize(function () {
        editor.setSize($(window).width(), $(window).height() - 31);
    });

    SZGL(JavaScriptMode);

    $("#save").click(function () {
        $.ajax({
            url: '/?z=SaveCode',
            type: 'POST',
            dataType: 'json',
            data: {
                code: encodeURIComponent(editor.getValue())
            },
            success: function (data) {
                if (data.status === 0) {
                    new $.zui.Messager(data.info, {
                        icon: 'save',
                        type: 'success'
                    }).show();
                } else {
                    new $.zui.Messager(data.info, {
                        icon: 'info',
                        type: 'info'
                    }).show();
                }
            }
        });
    });

    $("#logout").click(function () {
        $.ajax({
            url: "/?z=logout&t=" + (new Date()).getTime(),
            type: "get",
            dataType: "json",
            success: function (data) {
                location.reload();
            }
        });
    });

    $("#gkey").click(function () {
        (new $.zui.ModalTrigger({ custom: '<h1>' + key + '</h1>', title: 'key' })).show();
    });
});