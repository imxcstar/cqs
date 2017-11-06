VERSION 5.00
Begin VB.Form Form1 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "CQS"
   ClientHeight    =   1740
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   4020
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1740
   ScaleWidth      =   4020
   StartUpPosition =   2  '屏幕中心
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
      Height          =   270
      Left            =   840
      TabIndex        =   1
      Top             =   480
      Width           =   2895
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "还还没有账号？点这里注册！"
      ForeColor       =   &H8000000D&
      Height          =   180
      Left            =   240
      MousePointer    =   99  'Custom
      TabIndex        =   3
      Top             =   1080
      Width           =   2340
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "同步"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   15.75
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   360
      Left            =   2760
      TabIndex        =   2
      Top             =   960
      Width           =   960
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "key："
      Height          =   180
      Index           =   0
      Left            =   240
      TabIndex        =   0
      Top             =   540
      Width           =   450
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Const IDC_HAND As Long = 32649&
Private Declare Function LoadCursorA Lib "user32" (ByVal hInstance As Long, ByVal lpCursorName As Long) As Long
Private Declare Function SetCursor Lib "user32" (ByVal hCursor As Long) As Long
Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Private hHandCur As Long

Private Sub Form_Load()
    hHandCur = LoadCursorA(0&, IDC_HAND)
    Text1.Text = key
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    Form1S = False
    Me.Hide
    Cancel = 1
End Sub

Private Sub Label2_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Label2.BackColor = &HE0E0E0
End Sub

Private Sub Label2_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    On Error GoTo ErrCw
    Label2.BackColor = &HFFFFFF
    If Text1.Text = "" Then MsgBox "请输入key": Exit Sub
    key = Text1.Text
    Dim zc As String
    zc = HttpGetPost("http://cq.n.xcssa.com/?z=api_getcode&key=" & key)
    If GetJsonv(zc, "status") = "0" Then
        MsgBox "同步成功！"
        SaveSetting App.Title, CQAPIVERTEXT & "," & CQAPPID, "key", key
        TZCL = True
        SFYTB = True
        SFDYJSJB = False
        Code = CodeJm(GetJsonv(zc, "data"))
        TZCL = False
    End If
    Exit Sub
ErrCw:
    MsgBox Err.Description
End Sub

Private Sub Label3_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    SetCursor hHandCur
    Label3.font.Underline = True
End Sub

Private Sub Label3_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    SetCursor hHandCur
End Sub

Private Sub Label3_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    SetCursor hHandCur
    Label3.font.Underline = False
    ShellExecute 0, vbNullString, "http://cq.n.xcssa.com", vbNullString, vbNullString, vbNormalFocus
End Sub
