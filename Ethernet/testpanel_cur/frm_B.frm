VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form frm_B 
   Caption         =   "UDP Test Panel @Great Cow BASIC 2019"
   ClientHeight    =   6225
   ClientLeft      =   4995
   ClientTop       =   3360
   ClientWidth     =   6675
   Icon            =   "frm_B.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6225
   ScaleWidth      =   6675
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame framesocket 
      Caption         =   "Addressing"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1455
      Left            =   600
      TabIndex        =   10
      Top             =   1680
      Width           =   5535
      Begin VB.Frame frameport 
         Caption         =   "Target Port "
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   2760
         TabIndex        =   12
         ToolTipText     =   "Specify the port supporting the LCD handler."
         Top             =   480
         Width           =   2295
         Begin VB.TextBox txtport 
            Alignment       =   2  'Center
            BeginProperty Font 
               Name            =   "Verdana"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Left            =   240
            TabIndex        =   1
            ToolTipText     =   "Port number on remote device"
            Top             =   240
            Width           =   1815
         End
      End
      Begin VB.Frame frameip 
         Caption         =   "Target IP Address"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   360
         TabIndex        =   11
         ToolTipText     =   "Specify the IP address supporting the LCD handler"
         Top             =   480
         Width           =   2295
         Begin VB.TextBox txtip 
            Alignment       =   2  'Center
            BeginProperty Font 
               Name            =   "Verdana"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Left            =   240
            TabIndex        =   0
            ToolTipText     =   "IP address of remote device"
            Top             =   240
            Width           =   1815
         End
      End
   End
   Begin VB.Frame frameecho 
      Caption         =   "UDP: Port 7 Echo Function"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2295
      Left            =   240
      TabIndex        =   7
      ToolTipText     =   "Test the UDP Echo Port 7 capabilities"
      Top             =   3720
      Width           =   6135
      Begin VB.Frame framesend 
         Caption         =   "Original Data"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   120
         TabIndex        =   9
         Top             =   360
         Width           =   5895
         Begin VB.TextBox txtsend 
            BeginProperty Font 
               Name            =   "Verdana"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Left            =   240
            TabIndex        =   2
            ToolTipText     =   "Enter Data to Echo"
            Top             =   240
            Width           =   5415
         End
      End
      Begin VB.Frame framereceive 
         Caption         =   "Echoed Data"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   855
         Left            =   120
         TabIndex        =   8
         ToolTipText     =   "Data echoed from remote device"
         Top             =   1200
         Width           =   5895
         Begin VB.TextBox txtreceive 
            BackColor       =   &H00C0C0C0&
            BeginProperty Font 
               Name            =   "Verdana"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Left            =   240
            TabIndex        =   3
            ToolTipText     =   "Data echoed from remote device"
            Top             =   240
            Width           =   5415
         End
         Begin VB.Label Label1 
            Caption         =   "Echoed Data"
            BeginProperty Font 
               Name            =   "Verdana"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   120
            TabIndex        =   17
            ToolTipText     =   "Data returned from target server"
            Top             =   0
            Width           =   1215
         End
      End
   End
   Begin VB.Frame framedata 
      Caption         =   " UDP:Remote LCD Data Entry"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3255
      Left            =   240
      TabIndex        =   6
      ToolTipText     =   "Manipulate the LCD"
      Top             =   120
      Width           =   6135
      Begin VB.CommandButton btnline4 
         BackColor       =   &H00FFFF80&
         Caption         =   "Line 4"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   3480
         Style           =   1  'Graphical
         TabIndex        =   16
         ToolTipText     =   "Clear the specific line on the LCD "
         Top             =   1080
         Width           =   735
      End
      Begin VB.CommandButton btnline3 
         BackColor       =   &H0000FF00&
         Caption         =   "Line 3"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2400
         Style           =   1  'Graphical
         TabIndex        =   15
         ToolTipText     =   "Clear the specific line on the LCD "
         Top             =   1080
         Width           =   735
      End
      Begin VB.CommandButton btnline2 
         BackColor       =   &H0000FFFF&
         Caption         =   "Line 2"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1440
         Style           =   1  'Graphical
         TabIndex        =   14
         ToolTipText     =   "Clear the specific line on the LCD "
         Top             =   1080
         Width           =   735
      End
      Begin VB.CommandButton btnline1 
         BackColor       =   &H008080FF&
         Caption         =   "Line 1"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   480
         Style           =   1  'Graphical
         TabIndex        =   13
         ToolTipText     =   "Clear the specific line on the LCD "
         Top             =   1080
         Width           =   735
      End
      Begin VB.CommandButton btnclear 
         BackColor       =   &H000000FF&
         Caption         =   "CLEAR LCD"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   4680
         Style           =   1  'Graphical
         TabIndex        =   5
         ToolTipText     =   "Clear the LCD"
         Top             =   1080
         Width           =   1215
      End
      Begin VB.TextBox txtlcdin 
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   390
         Left            =   360
         MaxLength       =   20
         TabIndex        =   4
         ToolTipText     =   "Enter data for the LCD"
         Top             =   480
         Width           =   5535
      End
   End
   Begin MSWinsockLib.Winsock udp_PC 
      Left            =   0
      Top             =   0
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      Protocol        =   1
   End
End
Attribute VB_Name = "frm_B"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Ethernet Development Board Test Panel
'Version 04.06.25
'Copyright E D Technical Publications 2000, 2004
'Copyright Evan R. Venn 2016
'Last Updated 27/4/2016
Dim X As Integer

Private Sub btnclear_Click()
On Error Resume Next
udp_PC.RemotePort = txtport.Text
udp_PC.SendData &H0
txtlcdin = ""

End Sub

Private Sub btnline1_Click()
On Error Resume Next
udp_PC.RemotePort = txtport.Text
udp_PC.SendData &H1
txtlcdin = ""
End Sub

Private Sub btnline2_Click()
On Error Resume Next
udp_PC.RemotePort = txtport.Text
udp_PC.SendData &H2
txtlcdin = ""

End Sub

Private Sub btnline3_Click()
On Error Resume Next
udp_PC.RemotePort = txtport.Text
udp_PC.SendData &H3
txtlcdin = ""

End Sub

Private Sub btnline4_Click()
On Error Resume Next
udp_PC.RemotePort = txtport.Text
udp_PC.SendData &H4
txtlcdin = ""

End Sub

Private Sub Form_Load()
On Error Resume Next
txtip.Text = "192.168.0.1"
txtport.Text = "5002"
With udp_PC
.RemoteHost = txtip.Text
.RemotePort = Val(txtport.Text)
.Bind 5002
End With
frm_B.Show
End Sub


Private Sub txtip_Change()
On Error Resume Next
udp_PC.RemoteHost = txtip.Text
End Sub

Private Sub txtport_Change()
On Error Resume Next
udp_PC.RemotePort = Val(txtport.Text)
End Sub

Private Sub udp_PC_DataArrival(ByVal bytesTotal As Long)
On Error Resume Next
udp_PC.RemoteHost = txtip.Text
Dim strData As String
udp_PC.GetData strData
txtreceive.Text = strData

End Sub
Private Sub txtsend_Change()
If Len(txtsend.Text) = 0 Then
    txtreceive.Text = ""
End If
On Error Resume Next
udp_PC.RemoteHost = txtip.Text
udp_PC.RemotePort = 7
udp_PC.SendData txtsend.Text
udp_PC.RemotePort = txtport.Text


End Sub
Private Sub txtlcdin_Change()
On Error Resume Next
udp_PC.RemoteHost = txtip.Text
udp_PC.RemotePort = Val(txtport.Text)
udp_PC.SendData Right(txtlcdin.Text, 1)
udp_PC.RemotePort = txtport.Text

End Sub
