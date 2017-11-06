Attribute VB_Name = "MainModule"
Option Explicit
Public ac As Long
Public enabled As Boolean
Public Form1S As Boolean

'��ֹ����DLL�����BUG
Public Function FBUG() As Long
    '------------
End Function

' ����Ӧ��AuthCode����Q��ȡӦ����Ϣ��������ܸ�Ӧ�ã���������������������AuthCode��
' ��Ҫ�ڱ��������������κδ��룬���ⷢ���쳣���������ִ�г�ʼ����������Startup�¼���ִ�У�Type=1001����
Public Function Initialize(ByVal AuthCode As Long) As Long
    ac = AuthCode
    Initialize = 0
End Function

' ����Ӧ�õ�ApiVer��Appid������󽫲������
Public Function AppInfo() As Long
    Dim zc() As Byte
    zc = StrTByte(CQAPIVERTEXT & "," & CQAPPID)
    AppInfo = VarPtr(zc(0))
End Function

' Type=1001 ��Q����
' ���۱�Ӧ���Ƿ����ã������������ڿ�Q������ִ��һ�Σ���������ִ��Ӧ�ó�ʼ�����롣
' ��Ǳ�Ҫ����������������ش��ڡ���������Ӳ˵������û��ֶ��򿪴��ڣ�
Public Function eventStartup() As Long
    eventStartup = 0
End Function

' Type=1002 ��Q�˳�
' ���۱�Ӧ���Ƿ����ã������������ڿ�Q�˳�ǰִ��һ�Σ���������ִ�в���رմ��롣
' ������������Ϻ󣬿�Q���ܿ�رգ��벻Ҫ��ͨ���̵߳ȷ�ʽִ���������롣
Public Function eventExit() As Long
    TZCL = True
    eventExit = 0
End Function

' Type=1003 Ӧ���ѱ�����
' ��Ӧ�ñ����ú󣬽��յ����¼���
' �����Q����ʱӦ���ѱ����ã�����_eventStartup(Type=1001,��Q����)�����ú󣬱�����Ҳ��������һ�Ρ�
' ��Ǳ�Ҫ����������������ش��ڡ���������Ӳ˵������û��ֶ��򿪴��ڣ�
Public Function eventEnable() As Long
    enabled = True
    TZCL = False
    SFYTB = False
    key = GetSetting(App.Title, CQAPIVERTEXT & "," & CQAPPID, "key", "")
    AutoSync
    eventEnable = 0
End Function

' Type=1004 Ӧ�ý���ͣ��
' ��Ӧ�ñ�ͣ��ǰ�����յ����¼���
' �����Q����ʱӦ���ѱ�ͣ�ã��򱾺���*����*�����á�
' ���۱�Ӧ���Ƿ����ã���Q�ر�ǰ��������*����*�����á�
Public Function eventDisable() As Long
    enabled = False
    eventDisable = 0
End Function

' Type=21 ˽����Ϣ
' subType �����ͣ�11/���Ժ��� 1/��������״̬ 2/����Ⱥ 3/����������
Public Function eventPrivateMsg(ByVal subType As Long, ByVal sendTime As Long, ByVal fromQQ As Currency, ByVal msg As Long, ByVal font As Long) As Long
    '���Ҫ�ظ���Ϣ������ÿ�Q�������ͣ��������� return EVENT_BLOCK - �ضϱ�����Ϣ�����ټ�������  ע�⣺Ӧ�����ȼ�����Ϊ"���"(10000)ʱ������ʹ�ñ�����ֵ
    '������ظ���Ϣ������֮���Ӧ��/�������������� return EVENT_IGNORE - ���Ա�����Ϣ
    If TZCL = True Or SFYTB = False Then
        eventPrivateMsg = EVENT_IGNORE
        Exit Function
    End If

    eventPrivateMsg = JsRun("eventPrivateMsg(""" _
                            & subType & """,""" _
                            & sendTime & """,""" _
                            & fromQQ * 10000 & """,""" _
                            & pGetStringFromPtr(msg) & """,""" _
                            & font _
                            & """);")
    'Dim ZC() As Byte
    'ZC = StrTByte("test")
    'CQ_sendPrivateMsg ac, fromQQ, VarPtr(ZC(0))
    'eventPrivateMsg = EVENT_BLOCK
End Function

' Type=2 Ⱥ��Ϣ
Public Function eventGroupMsg(ByVal subType As Long, ByVal sendTime As Long, ByVal fromGroup As Currency, ByVal fromQQ As Currency, ByVal fromAnonymous As Long, ByVal msg As Long, ByVal font As Long) As Long
    'eventGroupMsg = EVENT_IGNORE '���ڷ���ֵ˵��, ����eventPrivateMsg������
    If TZCL = True Or SFYTB = False Then
        eventGroupMsg = EVENT_IGNORE
        Exit Function
    End If

    eventGroupMsg = JsRun("eventGroupMsg(""" _
                            & subType & """,""" _
                            & sendTime & """,""" _
                            & fromGroup * 10000 & """,""" _
                            & fromQQ * 10000 & """,""" _
                            & fromAnonymous & """,""" _
                            & pGetStringFromPtr(msg) & """,""" _
                            & font _
                            & """);")
End Function

' Type=4 ��������Ϣ
Public Function eventDiscussMsg(ByVal subType As Long, ByVal sendTime As Long, ByVal fromDiscuss As Currency, ByVal fromQQ As Currency, ByVal msg As Long, ByVal font As Long) As Long
    'eventDiscussMsg = EVENT_IGNORE '���ڷ���ֵ˵��, ����eventPrivateMsg������
    If TZCL = True Or SFYTB = False Then
        eventDiscussMsg = EVENT_IGNORE
        Exit Function
    End If

    eventDiscussMsg = JsRun("eventDiscussMsg(""" _
                            & subType & """,""" _
                            & sendTime & """,""" _
                            & fromDiscuss * 10000 & """,""" _
                            & fromQQ * 10000 & """,""" _
                            & pGetStringFromPtr(msg) & """,""" _
                            & font _
                            & """);")
End Function

' Type=101 Ⱥ�¼�-����Ա�䶯
' subType �����ͣ�1/��ȡ������Ա 2/�����ù���Ա
Public Function eventSystem_GroupAdmin(ByVal subType As Long, ByVal sendTime As Long, ByVal fromGroup As Currency, ByVal beingOperateQQ As Currency) As Long
    'eventSystem_GroupAdmin = EVENT_IGNORE '���ڷ���ֵ˵��, ����eventPrivateMsg������
    If TZCL = True Or SFYTB = False Then
        eventSystem_GroupAdmin = EVENT_IGNORE
        Exit Function
    End If

    eventSystem_GroupAdmin = JsRun("eventSystem_GroupAdmin(""" _
                            & subType & """,""" _
                            & sendTime & """,""" _
                            & fromGroup * 10000 & """,""" _
                            & beingOperateQQ * 10000 _
                            & """);")
End Function

' Type=102 Ⱥ�¼�-Ⱥ��Ա����
' subType �����ͣ�1/ȺԱ�뿪 2/ȺԱ���� 3/�Լ�(����¼��)����
' fromQQ ������QQ(��subTypeΪ2��3ʱ����)
' beingOperateQQ ������QQ
Public Function eventSystem_GroupMemberDecrease(ByVal subType As Long, ByVal sendTime As Long, ByVal fromGroup As Currency, ByVal fromQQ As Currency, ByVal beingOperateQQ As Currency) As Long
    'eventSystem_GroupMemberDecrease = EVENT_IGNORE '���ڷ���ֵ˵��, ����eventPrivateMsg������
    If TZCL = True Or SFYTB = False Then
        eventSystem_GroupMemberDecrease = EVENT_IGNORE
        Exit Function
    End If

    eventSystem_GroupMemberDecrease = JsRun("eventSystem_GroupMemberDecrease(""" _
                            & subType & """,""" _
                            & sendTime & """,""" _
                            & fromGroup * 10000 & """,""" _
                            & fromQQ * 10000 & """,""" _
                            & beingOperateQQ * 10000 _
                            & """);")
End Function

' Type=103 Ⱥ�¼�-Ⱥ��Ա����
' subType �����ͣ�1/����Ա��ͬ�� 2/����Ա����
' fromQQ ������QQ(������ԱQQ)
' beingOperateQQ ������QQ(����Ⱥ��QQ)
Public Function eventSystem_GroupMemberIncrease(ByVal subType As Long, ByVal sendTime As Long, ByVal fromGroup As Currency, ByVal fromQQ As Currency, ByVal beingOperateQQ As Currency) As Long
    'eventSystem_GroupMemberIncrease = EVENT_IGNORE '���ڷ���ֵ˵��, ����eventPrivateMsg������
    If TZCL = True Or SFYTB = False Then
        eventSystem_GroupMemberIncrease = EVENT_IGNORE
        Exit Function
    End If

    eventSystem_GroupMemberIncrease = JsRun("eventSystem_GroupMemberIncrease(""" _
                            & subType & """,""" _
                            & sendTime & """,""" _
                            & fromGroup * 10000 & """,""" _
                            & fromQQ * 10000 & """,""" _
                            & beingOperateQQ * 10000 _
                            & """);")
End Function

'Type=201 �����¼�-���������
Public Function eventFriend_Add(ByVal subType As Long, ByVal sendTime As Long, ByVal fromQQ As Currency) As Long
    'eventFriend_Add = EVENT_IGNORE '���ڷ���ֵ˵��, ����eventPrivateMsg������
    If TZCL = True Or SFYTB = False Then
        eventFriend_Add = EVENT_IGNORE
        Exit Function
    End If

    eventFriend_Add = JsRun("eventFriend_Add(""" _
                            & subType & """,""" _
                            & sendTime & """,""" _
                            & fromQQ * 10000 _
                            & """);")
End Function

' Type=301 ����-�������
' msg ����
' responseFlag ������ʶ(����������)
Public Function eventRequest_AddFriend(ByVal subType As Long, ByVal sendTime As Long, ByVal fromQQ As Currency, ByVal msg As Long, ByVal responseflag As Long) As Long
    'CQ_setFriendAddRequest(ac, responseFlag, REQUEST_ALLOW, "");
    'eventRequest_AddFriend = EVENT_IGNORE '���ڷ���ֵ˵��, ����eventPrivateMsg������
    If TZCL = True Or SFYTB = False Then
        eventRequest_AddFriend = EVENT_IGNORE
        Exit Function
    End If

    eventRequest_AddFriend = JsRun("eventRequest_AddFriend(""" _
                            & subType & """,""" _
                            & sendTime & """,""" _
                            & fromQQ * 10000 & """,""" _
                            & pGetStringFromPtr(msg) & """,""" _
                            & responseflag _
                            & """);")
End Function

' Type=302 ����-Ⱥ���
' subType �����ͣ�1/����������Ⱥ 2/�Լ�(����¼��)������Ⱥ
' msg ����
' responseFlag ������ʶ(����������)
Public Function eventRequest_AddGroup(ByVal subType As Long, ByVal sendTime As Long, ByVal fromGroup As Currency, ByVal fromQQ As Currency, ByVal msg As Long, ByVal responseflag As Long) As Long
    'if (subType == 1) {
    '  CQ_setGroupAddRequestV2(ac, responseFlag, REQUEST_GROUPADD, REQUEST_ALLOW, "");
    '} else if (subType == 2) {
    '  CQ_setGroupAddRequestV2(ac, responseFlag, REQUEST_GROUPINVITE, REQUEST_ALLOW, "");
    '}
    'eventRequest_AddGroup = EVENT_IGNORE '���ڷ���ֵ˵��, ����eventPrivateMsg������
    If TZCL = True Or SFYTB = False Then
        eventRequest_AddGroup = EVENT_IGNORE
        Exit Function
    End If

    eventRequest_AddGroup = JsRun("eventRequest_AddGroup(""" _
                            & subType & """,""" _
                            & sendTime & """,""" _
                            & fromGroup * 10000 & """,""" _
                            & fromQQ * 10000 & """,""" _
                            & pGetStringFromPtr(msg) & """,""" _
                            & responseflag _
                            & """);")
End Function

' �˵������� .json �ļ������ò˵���Ŀ��������
' �����ʹ�ò˵������� .json ���˴�ɾ�����ò˵�
Public Function SetMenu() As Long
    If enabled = True Then
        Form1S = True
        Form1.Show
    Else
        MsgBox "�������ò����"
    End If
    SetMenu = 0
End Function

Public Function SyncMenu() As Long
    If enabled = True Then
        If key = "" Then
            MsgBox "��������Key��"
        Else
            Dim zc As String
            zc = HttpGetPost("http://cq.n.xcssa.com/?z=api_getcode&key=" & key)
            If GetJsonv(zc, "status") = "0" Then
                MsgBox "ͬ���ɹ���"
                TZCL = True
                SFYTB = True
                SFDYJSJB = False
                Code = CodeJm(GetJsonv(zc, "data"))
                TZCL = False
            End If
        End If
    Else
        MsgBox "�������ò����"
    End If
    SyncMenu = 0
End Function


