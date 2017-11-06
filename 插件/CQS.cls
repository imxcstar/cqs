VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CQS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Private Declare Function MessageBox Lib "user32" Alias "MessageBoxA" (ByVal hwnd As Long, ByVal lpText As String, ByVal lpCaption As String, ByVal wType As Long) As Long

'------------------------------------------------------------------------------------------------------

' 发送私聊消息
' QQID 目标QQ号
' msg 消息内容
Public Function C_SendMsg_QQ(QQ As String, msg As String) As Long
    Dim zc() As Byte
    zc = StrTByte(msg)
    C_SendMsg_QQ = CQ_sendPrivateMsg(MainModule.ac, Val(QQ) / 10000, VarPtr(zc(0)))
End Function

' 发送群消息
' groupid 群号
' msg 消息内容
Public Function C_SendMsg_Group(groupid As String, msg As String) As Long
    Dim zc() As Byte
    zc = StrTByte(msg)
    C_SendMsg_Group = CQ_sendGroupMsg(MainModule.ac, Val(groupid) / 10000, VarPtr(zc(0)))
End Function

' 发送讨论组消息
' discussid 讨论组号
' msg 消息内容
Public Function C_SendMsg_Discuss(discussid As String, msg As String) As Long
    Dim zc() As Byte
    zc = StrTByte(msg)
    C_SendMsg_Discuss = CQ_sendDiscussMsg(MainModule.ac, Val(discussid) / 10000, VarPtr(zc(0)))
End Function

' 发送赞 发送手机赞
' QQID QQ号
Public Function C_SendLike(QQ As String)
    C_SendLike = CQ_sendLike(MainModule.ac, Val(QQ) / 10000)
End Function

' 置群员移除
' groupid 目标群
' QQID QQ号
' rejectaddrequest 不再接收此人加群申请，请慎用
Public Function C_SetGroupKick(groupid As String, QQID As String, rejectaddrequest As String)
    C_SetGroupKick = CQ_setGroupKick(MainModule.ac, Val(groupid) / 10000, Val(QQID) / 10000, Val(rejectaddrequest))
End Function

' 置群员禁言
' groupid 目标群
' QQID QQ号
' duration 禁言的时间，单位为秒。如果要解禁，这里填写0。
Public Function C_SetGroupBan(groupid As String, QQID As String, duration As String)
    C_SetGroupBan = CQ_setGroupBan(MainModule.ac, Val(groupid) / 10000, Val(QQID) / 10000, Val(duration) / 10000)
End Function

' 置群管理员
' groupid 目标群
' QQID QQ号
' setadmin true:设置管理员 false:取消管理员
Public Function C_SetGroupAdmin(groupid As String, QQID As String, setadmin As String) As Long
    C_SetGroupAdmin = CQ_setGroupAdmin(MainModule.ac, Val(groupid) / 10000, Val(QQID) / 10000, Val(setadmin))
End Function

' 置全群禁言
' groupid 目标群
' enableban true:开启 false:关闭
Public Function C_SetGroupWholeBan(groupid As String, enableban As String) As Long
    C_SetGroupWholeBan = CQ_setGroupWholeBan(MainModule.ac, Val(groupid) / 10000, Val(enableban))
End Function

' 置匿名群员禁言
' groupid 目标群
' anomymous 群消息事件收到的 anomymous 参数
' duration 禁言的时间，单位为秒。不支持解禁。
Public Function C_SetGroupAnonymousBan(groupid As String, anomymous As String, duration As String) As Long
    C_SetGroupAnonymousBan = CQ_setGroupAnonymousBan(MainModule.ac, Val(groupid) / 10000, Val(anomymous), Val(duration) / 10000)
End Function

' 置群匿名设置
' groupid 目标群
' enableanomymous true:开启 false:关闭
Public Function C_SetGroupAnonymous(groupid As String, enableanomymous As String) As Long
    C_SetGroupAnonymous = CQ_setGroupAnonymous(MainModule.ac, Val(groupid) / 10000, Val(enableanomymous))
End Function

' 置群成员名片
' groupid 目标群
' QQID 目标QQ
' newcard 新名片(昵称)
Public Function C_SetGroupCard(groupid As String, QQID As String, newcard As String) As Long
    Dim zc() As Byte
    zc = StrTByte(newcard)
    C_SetGroupCard = CQ_setGroupCard(MainModule.ac, Val(groupid) / 10000, Val(QQID) / 10000, VarPtr(zc(0)))
End Function

' 置群退出 慎用, 此接口需要严格授权
' groupid 目标群
' isdismiss 是否解散 true:解散本群(群主) false:退出本群(管理、群成员)
Public Function C_SetGroupLeave(groupid As String, isdismiss As String) As Long
    C_SetGroupLeave = CQ_setGroupLeave(MainModule.ac, Val(groupid) / 10000, Val(isdismiss))
End Function

' 置群成员专属头衔 需群主权限
' groupid 目标群
' QQID 目标QQ
' newspecialtitle 头衔（如果要删除，这里填空）
' duration 专属头衔有效期，单位为秒。如果永久有效，这里填写-1。
Public Function C_SetGroupSpecialTitle(groupid As String, QQID As String, newspecialtitle As String, duration As String) As Long
    Dim zc() As Byte
    zc = StrTByte(newspecialtitle)
    C_SetGroupSpecialTitle = CQ_setGroupSpecialTitle(MainModule.ac, Val(groupid) / 10000, Val(QQID) / 10000, VarPtr(zc(0)), Val(duration) / 10000)
End Function

' 置讨论组退出
' discussid 目标讨论组号
Public Function C_SetDiscussLeave(discussid As String) As Long
    C_SetDiscussLeave = CQ_setDiscussLeave(MainModule.ac, Val(discussid) / 10000)
End Function

' 置好友添加请求
' responseflag 请求事件收到的 responseflag 参数
' responseoperation REQUEST_ALLOW 或 REQUEST_DENY
' remark 添加后的好友备注
Public Function C_SetFriendAddRequest(responseflag As String, responseoperation As String, remark As String) As Long
    Dim zc() As Byte
    zc = StrTByte(remark)
    C_SetFriendAddRequest = CQ_setFriendAddRequest(MainModule.ac, Val(responseflag), Val(responseoperation), VarPtr(zc(0)))
End Function

' 置群添加请求
' responseflag 请求事件收到的 responseflag 参数
' requesttype根据请求事件的子类型区分 REQUEST_GROUPADD 或 REQUEST_GROUPINVITE
' responseoperation  REQUEST_ALLOW 或 REQUEST_DENY
' reason 操作理由，仅 REQUEST_GROUPADD 且 REQUEST_DENY 时可用
Public Function C_SetGroupAddRequestV2(responseflag As String, requesttype As String, responseoperation As String, reason As String) As Long
    Dim zc() As Byte
    zc = StrTByte(reason)
    C_SetGroupAddRequestV2 = CQ_setGroupAddRequestV2(MainModule.ac, Val(responseflag), Val(requesttype), Val(responseoperation), VarPtr(zc(0)))
End Function

' 取群成员信息
' groupid 目标QQ所在群
' QQID 目标QQ号
' nocache 不使用缓存
Public Function C_GetGroupMemberInfoV2(groupid As String, QQID As String, nocache As String) As String
    Dim zc As String
    zc = pGetStringFromPtr(CQ_getGroupMemberInfoV2(MainModule.ac, Val(groupid) / 10000, Val(QQID) / 10000, Val(nocache)))
    C_GetGroupMemberInfoV2 = zc
End Function

' 取陌生人信息
' QQID 目标QQ
' nocache 不使用缓存
Public Function C_GetStrangerInfo(QQID As String, nocache As String) As String
    Dim zc As String
    zc = pGetStringFromPtr(CQ_getStrangerInfo(MainModule.ac, Val(QQID) / 10000, Val(nocache)))
    C_GetStrangerInfo = zc
End Function

' 日志
' priority 优先级，CQLOG 开头的常量
' category 类型
' content 内容
Public Function C_AddLog(priority As String, category As String, content As String) As Long
    Dim zc() As Byte
    zc = StrTByte(content)
    C_AddLog = CQ_addLog(MainModule.ac, Val(priority), Val(category), VarPtr(zc(0)))
End Function

' 取Cookies 慎用, 此接口需要严格授权
Public Function C_GetCookies() As String
    Dim zc As String
    zc = pGetStringFromPtr(CQ_getCookies(MainModule.ac))
    C_GetCookies = zc
End Function

' 取CsrfToken 慎用, 此接口需要严格授权
Public Function C_GetCsrfToken() As String
    Dim zc As String
    zc = pGetStringFromPtr(CQ_getCsrfToken(MainModule.ac))
    C_GetCsrfToken = zc
End Function

' 取登录QQ
Public Function C_GetLoginQQ() As String
    Dim zc As String
    zc = pGetStringFromPtr(CQ_getLoginQQ(MainModule.ac))
    C_GetLoginQQ = zc
End Function

' 取登录QQ昵称
Public Function C_GetLoginNick() As String
    Dim zc As String
    zc = pGetStringFromPtr(CQ_getLoginNick(MainModule.ac))
    C_GetLoginNick = zc
End Function

' 取应用目录，返回的路径末尾带"\"
Public Function C_GetAppDirectory() As String
    Dim zc As String
    zc = pGetStringFromPtr(CQ_getAppDirectory(MainModule.ac))
    C_GetAppDirectory = zc
End Function

' 置致命错误提示
' errorinfo 错误信息
Public Function C_SetFatal(errorinfo As String) As Long
    Dim zc() As Byte
    zc = StrTByte(errorinfo)
    C_SetFatal = CQ_setFatal(MainModule.ac, VarPtr(zc(0)))
End Function

' 接收语音，接收消息中的语音(record),返回保存在 \data\record\ 目录下的文件名
' file 收到消息中的语音文件名(file)
' outformat 应用所需的语音文件格式，目前支持 mp3 amr wma m4a spx ogg wav flac
Public Function C_GetRecord(file As String, outformat As String) As String
    Dim zc As String
    Dim zc2() As Byte
    Dim zc3() As Byte
    zc2 = StrTByte(file)
    zc3 = StrTByte(outformat)
    zc = pGetStringFromPtr(CQ_getRecord(MainModule.ac, VarPtr(zc2(0)), VarPtr(zc3(0))))
    C_GetRecord = zc
End Function

' 获取图片URL
' a 收到消息中的图片文件名
Public Function C_GetPicUrl(a As String) As String
    Dim zc As String
    zc = App.Path
    If Right(zc, 1) <> "\" Then zc = zc & "\"
    zc = zc & "data\image\" & a & ".cqimg"
    If Dir(zc) <> "" Then
        Dim TempFile As Long
        Dim LoadBytes() As Byte
        TempFile = FreeFile
        Open zc For Binary As #TempFile
        ReDim LoadBytes(0 To LOF(TempFile) - 1) As Byte
        Get #TempFile, , LoadBytes
        Close TempFile
        zc = StrConv(LoadBytes, vbUnicode)
        C_GetPicUrl = MyModule.sMid(zc, "url=", vbCrLf, , , 1)
    End If
End Function

'------------------------------------------------------------------------------------------------------

Public Function C_Msgbox(a As String, Optional b As String = CQAPPID) As Long
    C_Msgbox = MessageBox(0, a, b, 0)
End Function

Public Function C_HttpGet(url As String, Optional head As String = "") As String
    C_HttpGet = MyModule.HttpGetPost(url, "GET", head)
End Function

Public Function C_HttpPost(url As String, Optional head As String = "", Optional data As String = "") As String
    C_HttpPost = MyModule.HttpGetPost(url, "POST", head, data)
End Function

Public Function C_Smid(zhong As String, Optional qian As String, Optional hou As String, Optional QnH As Integer = 0, Optional QHJ As Integer = 0, Optional QK As Integer = 0) As String
    C_Smid = MyModule.sMid(zhong, qian, hou, QnH, QHJ, QK)
End Function

Public Function C_Len(a As String) As Long
    C_Len = Len(a)
End Function

Public Function C_Mid(a As String, b As Long, Optional c As Long = 0) As String
    If c <= 0 Then
        C_Mid = Mid(a, b)
    Else
        C_Mid = Mid(a, b, c)
    End If
End Function

Public Function C_Left(a As String, b As Long) As String
    C_Left = Left(a, b)
End Function

Public Function C_Right(a As String, b As Long) As String
    C_Right = Right(a, b)
End Function

Public Sub C_Sync()
    If key <> "" Then
        Dim zc As String
        zc = MyModule.HttpGetPost("http://cq.n.xcssa.com/?z=api_getcode&key=" & MyModule.key)
        If MyModule.GetJsonv(zc, "status") = "0" Then
            MyModule.TZCL = True
            MyModule.SFYTB = True
            MyModule.SFDYJSJB = False
            MyModule.Code = MyModule.CodeJm(MyModule.GetJsonv(zc, "data"))
            MyModule.TZCL = False
        End If
    End If
End Sub

Public Function C_trim(a As String) As String
    C_trim = Trim(a)
End Function

Public Function C_replace(a As String, b As String, c As String) As String
    C_replace = Replace(a, b, c)
End Function
