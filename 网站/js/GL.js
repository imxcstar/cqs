//PHP ASP ASP.NET Python C C++ C# Java JavaScript VBScript VB.NET HTML CSS JSON Ruby Perl JSP Lua SQL XML
function GLKZFH(modeZ){
    return {
        lineNumbers: true,
        mode: modeZ,
        indentUnit: 4,
        indentWithTabs: true
    };
}
function GLKZFH2(modeZ){
    return {
        lineNumbers: true,
        mode: modeZ,
        indentUnit: 4
    };
}
function GLKZFH3(modeZ){
    CCCJDY();
    return {
        lineNumbers: true,
        matchBrackets: true,
        mode: modeZ
    };
}
function GLKZFH4(modeZ){
    return {
        lineNumbers: true,
        matchBrackets: true,
        mode: modeZ,
        continueComments: "Enter",
        extraKeys: {"Ctrl-Q": "toggleComment"}
    };
}
function GLKZFH5(modeZ){
    return {
        lineNumbers: true,
        mode: modeZ,
        readOnly: false
    };
}
function GLKZFH6(modeZ){
    return {
        mode: modeZ,
        lineNumbers: true
    };
}
function GLKZFH7(modeZ){
    return {
        mode: modeZ,
        extraKeys: {"Ctrl-Space": "autocomplete"}
    };
}
function CCCJDY(){
    var mac = CodeMirror.keyMap.default == CodeMirror.keyMap.macDefault;
    CodeMirror.keyMap.default[(mac ? "Cmd" : "Ctrl") + "-Space"] = "autocomplete";
}
var PHPMode={
        lineNumbers: true,
        matchBrackets: true,
        mode: "application/x-httpd-php",
        indentUnit: 4,
        indentWithTabs: true
};
var ASPMode=GLKZFH("application/x-aspx");
var ASPNETMode=GLKZFH("application/x-aspx");
var PythonMode={
        mode: {name: "python",
               version: 3,
               singleLineStringErrors: false},
        lineNumbers: true,
        indentUnit: 4,
        matchBrackets: true
};
var CMode=GLKZFH3("text/x-csrc");
var CJJMode=GLKZFH3("text/x-c++src");
var CCMode=GLKZFH3("text/x-csharp");
var JavaMode=GLKZFH3("text/x-java");
var JavaScriptMode=GLKZFH4("text/javascript");
var VBScriptMode=GLKZFH2("text/vbscript");
var VBNETMode=GLKZFH5("text/x-vb");
var HtmlMode=GLKZFH6("text/html");
var CssMode=GLKZFH7("text/css");
var JsonMode=GLKZFH4("application/json");
var RubyMode={
        mode: "text/x-ruby",
        matchBrackets: true,
        indentUnit: 4
};
var PerlMode=GLKZFH6("text/x-perl");
var JSPMode=GLKZFH("application/x-jsp");
var LuaMode={
        mode: "text/x-lua",
        matchBrackets: true
};
var SqlMode={
    mode: "text/x-sql",
    indentWithTabs: true,
    smartIndent: true,
    lineNumbers: true,
    matchBrackets : true,
    autofocus: true,
    extraKeys: {"Ctrl-Space": "autocomplete"},
    hintOptions: {tables: {
      users: {name: null, score: null, birthDate: null},
      countries: {name: null, population: null, size: null}
    }}
};
var XmllMode=GLKZFH6("application/xml")