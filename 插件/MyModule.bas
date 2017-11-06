Attribute VB_Name = "MyModule"
Option Explicit
Public Declare Function lstrlen Lib "kernel32" Alias "lstrlenA" (ByVal lpString As Long) As Long
Private Declare Function lstrcpy Lib "kernel32" Alias "lstrcpyA" (lpString1 As Any, lpString2 As Any) As Long
Public SFDYJSJB As Boolean
Public TZCL As Boolean
Public SFYTB As Boolean
Public key As String
Public Code As String

Public Function BytesToBstr(bytes)
    On Error GoTo CuoWu
    Dim SFCW As Boolean
    Dim Unicode As String
    If IsUTF8(bytes) Then
        Unicode = "UTF-8"
    Else
        Unicode = "GB2312"
    End If
TG:
    Dim objstream As Object
    Set objstream = CreateObject("ADODB.Stream")
    With objstream
        .Type = 1
        .Mode = 3
        .Open
        If SFCW = False Then .Write bytes
        .position = 0
        .Type = 2
        .Charset = Unicode
        BytesToBstr = .ReadText
        .Close
    End With
    Exit Function
CuoWu:
    Unicode = "GB2312"
    SFCW = True
    GoTo TG
End Function

Private Function IsUTF8(bytes) As Boolean
    On Error GoTo CuoWu
    Dim i As Long, AscN As Long, Length As Long
    Length = UBound(bytes) + 1
    
    If Length < 3 Then
        IsUTF8 = False
        Exit Function
    ElseIf bytes(0) = &HEF And bytes(1) = &HBB And bytes(2) = &HBF Then
        IsUTF8 = True
        Exit Function
    End If
    
    Do While i <= Length - 1
        If bytes(i) < 128 Then
            i = i + 1
            AscN = AscN + 1
        ElseIf (bytes(i) And &HE0) = &HC0 And (bytes(i + 1) And &HC0) = &H80 Then
            i = i + 2
            
        ElseIf i + 2 < Length Then
            If (bytes(i) And &HF0) = &HE0 And (bytes(i + 1) And &HC0) = &H80 And (bytes(i + 2) And &HC0) = &H80 Then
                i = i + 3
            Else
                IsUTF8 = False
                Exit Function
            End If
        Else
            IsUTF8 = False
            Exit Function
        End If
    Loop
    
    If AscN = Length Then
        IsUTF8 = False
    Else
        IsUTF8 = True
    End If
    Exit Function
CuoWu:
    IsUTF8 = False
End Function

Public Function StrTByte(Str As String) As Byte()
    Dim zc() As Byte
    zc = StrConv(Str, vbFromUnicode)
    ReDim Preserve zc(UBound(zc) + 1)
    zc(UBound(zc)) = 0
    StrTByte = zc
End Function

Public Function pGetStringFromPtr(ByVal lPtr As Long) As String
    Dim Buff() As Byte '声明一个Byte数组
    Dim lPointer As Long '声明一个变量，用于存储指针
    lPointer = lPtr
    ReDim Buff(0 To lstrlen(lPointer) * 2 - 1) As Byte  '分配缓存大小,由于得到的是Unicode，所以乘以2
    lstrcpy Buff(0), ByVal lPointer '复制到缓存Buff中
    pGetStringFromPtr = BytesToBstr(Buff)
End Function

Public Function CodeJm(Code As String) As String
    Dim JsRun As Object
    Set JsRun = CreateObject("MSScriptControl.ScriptControl")
    'JsRun.AllowUI = True
    JsRun.Language = "JavaScript"
    JsRun.AddCode HttpGetPost("http://cq.n.xcssa.com/js/cqs.js")
    CodeJm = JsRun.eval("sjjm(""" & Code & """);")
    Set JsRun = Nothing
End Function

Public Function GetJsonv(ByVal data As String, ByVal key As String) As String
On Error GoTo CuoWu
    Dim js
    Set js = CreateObject("scriptcontrol")
    js.Language = "javascript"
    GetJsonv = js.eval("(function(){return " & data & "." & key & ";})()")
    Set js = Nothing
    Exit Function
CuoWu:
    GetJsonv = "错误!"
End Function

Public Function HttpGetPost(url As String, Optional lx As String = "GET", Optional head As String = "", Optional data As String = "") As String
On Error GoTo CuoWu
    Dim zc() As String
    Dim i As Long, j As Long, z As Long
    Dim h
    Set h = CreateObject("WinHttp.WinHttpRequest.5.1")
    h.SetTimeouts 10000, 10000, 10000, 10000
    h.Open UCase(lx), url, True
    If head <> "" Then
        zc = Split(head, vbCrLf)
        For i = 0 To UBound(zc)
            zc(i) = Trim(zc(i))
            For j = 1 To Len(zc(i))
                If Left(zc(i), 1) = ":" Then
                    z = z + 1
                Else
                    Exit For
                End If
            Next j
            If z <> Len(zc(i)) Then
                If z <> 0 Then
                    zc(i) = Mid(zc(i), z + 1)
                End If
                h.SetRequestHeader String(z, ":") & Trim(Split(zc(i), ":")(0)), Trim(Mid(zc(i), InStr(zc(i), ":")))
            End If
        Next i
    End If
    If UCase(lx) = "POST" And data <> "" Then
        h.send data
    Else
        h.send
    End If
    h.WaitForResponse
    HttpGetPost = BytesToBstr(h.ResponseBody)
    Set h = Nothing
    Exit Function
CuoWu:
    HttpGetPost = ""
End Function

Public Sub AutoSync()
On Error GoTo CuoWu
    If key <> "" Then
        Dim zc As String
        zc = HttpGetPost("http://cq.n.xcssa.com/?z=api_getcode&key=" & key)
        If GetJsonv(zc, "status") = "0" Then
            'Msgbox "自动同步成功！"
            TZCL = True
            SFYTB = True
            SFDYJSJB = False
            Code = CodeJm(GetJsonv(zc, "data"))
            TZCL = False
        End If
    End If
    Exit Sub
CuoWu:
    MsgBox "自动同步错误！", 64
End Sub

Public Function JsRun(s As String) As Long
On Error GoTo CuoWu
    Dim zc As String
    zc = Replace(Replace(Replace(s, Chr(0), ""), Chr(10), ""), Chr(13), "")
    'If SFDYJSJB = False Then
        'SFDYJSJB = True
        Dim JSJB As Object
        Dim CQSM As New CQS
        Set JSJB = CreateObject("MSScriptControl.ScriptControl")
        JSJB.Language = "JavaScript"
        JSJB.AddObject "CQS", CQSM
        JSJB.AddCode Code
    'End If
    JsRun = Val(JSJB.eval(zc))
    Set JSJB = Nothing
    Exit Function
CuoWu:
    MsgBox Err.Description
    JsRun = EVENT_IGNORE
End Function

Public Function sMid(zhong As String, Optional qian As String, Optional hou As String, Optional QnH As Integer = 0, Optional QHJ As Integer = 0, Optional QK As Integer = 0) As String
On Error Resume Next
DoEvents
Dim P1 As Double, P2 As Double
If zhong = "" Then sMid = "0": Exit Function
If qian <> "" And QHJ = 0 Then P1 = InStr(zhong, qian)
If qian <> "" And QHJ = 1 Then P1 = InStrRev(zhong, qian)
If qian = "" Then P1 = 1
If P1 = 0 And qian <> "" Then sMid = "1": Exit Function
If QnH = 0 And QK = 0 And hou <> "" Then P2 = InStr(zhong, hou)
If QnH = 0 And QK = 1 And hou <> "" Then P2 = InStr(P1 + Len(qian), zhong, hou)
If QnH = 1 And hou <> "" Then P2 = InStrRev(zhong, hou)
If P2 = 0 And hou <> "" Then sMid = "2": Exit Function
If P2 < P1 + Len(qian) And hou <> "" Then sMid = "0": Exit Function
If hou <> "" Then sMid = Mid(zhong, P1 + Len(qian), P2 - (P1 + Len(qian)))
If hou = "" Then sMid = Mid(zhong, P1 + Len(qian))
End Function
