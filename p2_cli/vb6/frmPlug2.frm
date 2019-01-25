VERSION 5.00
Begin VB.Form frmPlug2 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "carrot"
   ClientHeight    =   7005
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   19410
   Icon            =   "frmPlug2.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "frmPlug2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7005
   ScaleWidth      =   19410
   StartUpPosition =   1  'CenterOwner
   Begin VB.ListBox pl_lst_log 
      Height          =   5520
      Left            =   16200
      TabIndex        =   28
      Top             =   60
      Width           =   3195
   End
   Begin VB.PictureBox pl_pic_container_mid 
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   6975
      Left            =   3300
      ScaleHeight     =   6975
      ScaleWidth      =   12855
      TabIndex        =   1
      Top             =   0
      Width           =   12855
      Begin VB.CommandButton pl_btn_ctl 
         Caption         =   "pl_btn_ctl"
         Height          =   375
         Index           =   5
         Left            =   1320
         TabIndex        =   34
         Top             =   900
         Width           =   1215
      End
      Begin VB.CommandButton pl_btn_ctl 
         Caption         =   "pl_btn_ctl"
         Height          =   375
         Index           =   4
         Left            =   60
         TabIndex        =   33
         Top             =   900
         Width           =   1215
      End
      Begin VB.ComboBox pl_cmb 
         Height          =   315
         Index           =   5
         ItemData        =   "frmPlug2.frx":000C
         Left            =   6060
         List            =   "frmPlug2.frx":000E
         Style           =   2  'Dropdown List
         TabIndex        =   32
         Top             =   840
         Width           =   735
      End
      Begin VB.ComboBox pl_cmb 
         Height          =   315
         Index           =   4
         ItemData        =   "frmPlug2.frx":0010
         Left            =   5160
         List            =   "frmPlug2.frx":0012
         Style           =   2  'Dropdown List
         TabIndex        =   31
         Top             =   840
         Width           =   855
      End
      Begin VB.ComboBox pl_cmb 
         Height          =   315
         Index           =   3
         ItemData        =   "frmPlug2.frx":0014
         Left            =   6060
         List            =   "frmPlug2.frx":0016
         Style           =   2  'Dropdown List
         TabIndex        =   30
         Top             =   480
         Width           =   735
      End
      Begin VB.ComboBox pl_cmb 
         Height          =   315
         Index           =   2
         ItemData        =   "frmPlug2.frx":0018
         Left            =   5160
         List            =   "frmPlug2.frx":001A
         Style           =   2  'Dropdown List
         TabIndex        =   29
         Top             =   480
         Width           =   855
      End
      Begin VB.PictureBox pl_pic_trans 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0FF&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   5025
         Left            =   0
         ScaleHeight     =   335
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   857
         TabIndex        =   13
         Top             =   1320
         Visible         =   0   'False
         Width           =   12855
         Begin VB.TextBox pl_txt_mm 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            Height          =   255
            Index           =   1
            Left            =   780
            TabIndex        =   35
            Text            =   "88888"
            Top             =   2820
            Width           =   1035
         End
         Begin VB.TextBox pl_txt_mm 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            Height          =   435
            Index           =   4
            Left            =   9780
            TabIndex        =   27
            Text            =   "10000"
            Top             =   2220
            Width           =   1935
         End
         Begin VB.TextBox pl_txt_mm 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            Height          =   255
            Index           =   0
            Left            =   780
            TabIndex        =   26
            Text            =   "88888"
            Top             =   2460
            Width           =   1035
         End
         Begin VB.CommandButton pl_btn_mm 
            BackColor       =   &H0000FFFF&
            Caption         =   "Code"
            Height          =   435
            Index           =   4
            Left            =   7080
            Style           =   1  'Graphical
            TabIndex        =   25
            Top             =   2280
            Width           =   1695
         End
         Begin VB.CommandButton pl_btn_mm 
            BackColor       =   &H0000FFFF&
            Caption         =   "OK!!!"
            Height          =   435
            Index           =   7
            Left            =   8700
            Style           =   1  'Graphical
            TabIndex        =   24
            Top             =   3180
            Width           =   1695
         End
         Begin VB.CommandButton pl_btn_mm 
            BackColor       =   &H0000FFFF&
            Caption         =   "Cancel"
            Height          =   435
            Index           =   8
            Left            =   9960
            Style           =   1  'Graphical
            TabIndex        =   23
            Top             =   3480
            Width           =   1695
         End
         Begin VB.CommandButton pl_btn_mm 
            BackColor       =   &H0000FFFF&
            Caption         =   "OK"
            Height          =   435
            Index           =   6
            Left            =   7080
            Style           =   1  'Graphical
            TabIndex        =   22
            Top             =   3480
            Width           =   1695
         End
         Begin VB.CommandButton pl_btn_mm 
            BackColor       =   &H008080FF&
            Caption         =   "Apply"
            Height          =   375
            Index           =   9
            Left            =   10800
            Style           =   1  'Graphical
            TabIndex        =   21
            Top             =   60
            Visible         =   0   'False
            Width           =   1935
         End
         Begin VB.CommandButton pl_btn_mm 
            BackColor       =   &H0000FFFF&
            Caption         =   "Add"
            Height          =   375
            Index           =   0
            Left            =   11160
            Style           =   1  'Graphical
            TabIndex        =   20
            Top             =   720
            Width           =   975
         End
         Begin VB.TextBox pl_txt_mm 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            Height          =   435
            Index           =   3
            Left            =   8820
            TabIndex        =   19
            Text            =   "10000"
            Top             =   2280
            Width           =   1935
         End
         Begin VB.CommandButton pl_btn_mm 
            BackColor       =   &H0000FFFF&
            Caption         =   "Bid"
            Height          =   375
            Index           =   5
            Left            =   11160
            Style           =   1  'Graphical
            TabIndex        =   18
            Top             =   2340
            Width           =   975
         End
         Begin VB.CommandButton pl_btn_mm 
            BackColor       =   &H0000FFFF&
            Caption         =   "+300"
            Height          =   495
            Index           =   3
            Left            =   11160
            Style           =   1  'Graphical
            TabIndex        =   17
            Top             =   1740
            Width           =   915
         End
         Begin VB.CommandButton pl_btn_mm 
            BackColor       =   &H0000FFFF&
            Caption         =   "+200"
            Height          =   495
            Index           =   2
            Left            =   10020
            Style           =   1  'Graphical
            TabIndex        =   16
            Top             =   1740
            Width           =   915
         End
         Begin VB.TextBox pl_txt_mm 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            Height          =   435
            Index           =   2
            Left            =   9120
            TabIndex        =   15
            Text            =   "700"
            Top             =   720
            Width           =   1575
         End
         Begin VB.CommandButton pl_btn_mm 
            BackColor       =   &H0000FFFF&
            Caption         =   "+100"
            Height          =   495
            Index           =   1
            Left            =   8880
            Style           =   1  'Graphical
            TabIndex        =   14
            Top             =   1740
            Width           =   915
         End
      End
      Begin VB.CommandButton pl_btn_ctl 
         Caption         =   "pl_btn_ctl"
         Height          =   375
         Index           =   0
         Left            =   60
         TabIndex        =   12
         Top             =   60
         Width           =   1215
      End
      Begin VB.CheckBox pl_chk_ctl 
         Caption         =   "pl_chk_ctl"
         Height          =   255
         Index           =   1
         Left            =   2580
         TabIndex        =   11
         Top             =   420
         Width           =   1575
      End
      Begin VB.CheckBox pl_chk_ctl 
         Caption         =   "pl_chk_ctl"
         Height          =   255
         Index           =   0
         Left            =   2580
         TabIndex        =   10
         Top             =   120
         Width           =   1575
      End
      Begin VB.CommandButton pl_btn_ctl 
         Caption         =   "pl_btn_ctl"
         Height          =   375
         Index           =   2
         Left            =   60
         TabIndex        =   9
         Top             =   480
         Width           =   1215
      End
      Begin VB.PictureBox pl_pic_status 
         BorderStyle     =   0  'None
         Height          =   1215
         Left            =   9900
         ScaleHeight     =   1215
         ScaleWidth      =   2955
         TabIndex        =   8
         Top             =   60
         Width           =   2955
      End
      Begin VB.CommandButton pl_btn_ctl 
         Caption         =   "pl_btn_ctl"
         Height          =   375
         Index           =   1
         Left            =   1320
         TabIndex        =   7
         Top             =   60
         Width           =   1215
      End
      Begin VB.CheckBox pl_chk_ctl 
         Caption         =   "pl_chk_ctl"
         Height          =   255
         Index           =   3
         Left            =   2580
         TabIndex        =   6
         Top             =   720
         Width           =   1575
      End
      Begin VB.ComboBox pl_cmb 
         Height          =   315
         Index           =   0
         ItemData        =   "frmPlug2.frx":001C
         Left            =   5160
         List            =   "frmPlug2.frx":001E
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   120
         Width           =   855
      End
      Begin VB.ComboBox pl_cmb 
         Height          =   315
         Index           =   1
         ItemData        =   "frmPlug2.frx":0020
         Left            =   6060
         List            =   "frmPlug2.frx":0022
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   120
         Width           =   735
      End
      Begin VB.CommandButton pl_btn_ctl 
         Caption         =   "pl_btn_ctl"
         Height          =   375
         Index           =   3
         Left            =   1320
         TabIndex        =   3
         Top             =   480
         Width           =   1215
      End
      Begin VB.CheckBox pl_chk_ctl 
         Caption         =   "pl_chk_ctl"
         Height          =   255
         Index           =   2
         Left            =   2580
         TabIndex        =   2
         Top             =   1020
         Width           =   1575
      End
      Begin VB.Shape maskBg 
         BackColor       =   &H00C0C0FF&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H000000FF&
         Height          =   5025
         Left            =   0
         Top             =   1320
         Width           =   12855
      End
   End
   Begin VB.Timer refreshTimer 
      Interval        =   50
      Left            =   0
      Top             =   0
   End
   Begin VB.PictureBox pl_pic_dbg 
      BackColor       =   &H00FFFFFF&
      Height          =   6915
      Left            =   0
      ScaleHeight     =   457
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   213
      TabIndex        =   0
      Top             =   60
      Width           =   3255
   End
End
Attribute VB_Name = "frmPlug2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If Shift = vbCtrlMask Then
        Select Case KeyCode
            Case vbKeyLeft
                Me.Left = Me.Left - Screen.TwipsPerPixelX
            Case vbKeyRight
                Me.Left = Me.Left + Screen.TwipsPerPixelX
            Case vbKeyUp
                Me.Top = Me.Top - Screen.TwipsPerPixelY
            Case vbKeyDown
                Me.Top = Me.Top + Screen.TwipsPerPixelY
        End Select
    ElseIf Shift = vbShiftMask Then
        basAPI.set_window_hit_through Me.hWnd, True
    End If
End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)
    If Shift = vbShiftMask Then
        basAPI.set_window_hit_through Me.hWnd, False
    End If
End Sub

Private Sub Form_Load()
    basAPI.set_window_transparent Me.hWnd, Me.maskBg.BackColor, 255

    basAPI.init_subclassing Me.hWnd
    ' hotkey processing will use form subclassing
    'basAPI.reg_all_hot_key Me.hwnd, kb
    
    basUI.pl_btn_ctl_init Me.pl_btn_ctl
    basUI.pl_chk_ctl_init Me.pl_chk_ctl
    basUI.pl_cmb_init Me.pl_cmb
    basUI.pl_mm_init Me.pl_txt_mm
        
    Me.Caption = App.ProductName & " V" & CStr(App.Major) & "." & CStr(App.Minor) & " Build " & CStr(App.Revision)
End Sub

Private Sub Form_Unload(Cancel As Integer)
    basPlug2.AppExit
End Sub

Private Sub pl_btn_ctl_Click(Index As Integer)
    basUI.pl_btn_ctl_Click Index
End Sub

Public Sub form_begin_move()
    Me.pl_pic_trans.Visible = True
    basAPI.set_window_transparent Me.hWnd, 0, 128
End Sub

Public Sub form_end_move()
    Me.pl_pic_trans.Visible = False
    basAPI.set_window_transparent Me.hWnd, Me.maskBg.BackColor, 255
End Sub

Private Sub pl_lst_log_DblClick()
    Me.pl_lst_log.Clear
End Sub

Private Sub refreshTimer_Timer()
    Dim l1 As String, l2 As String, l3 As String
    
    l1 = "NOW=" & Format(Now, "HH:mm:ss") & "." & Int((Timer - Int(Timer)) * 10)
    l1 = l1 & "    Delta=0.1"
    
    l2 = "OCR=" & Now
    
    l3 = ""
    
    Me.pl_pic_status.Cls
    Me.pl_pic_status.Print l1
    Me.pl_pic_status.Print l2
    Me.pl_pic_status.Print l3
    
    basUI.pl_refresh_timer Me.pl_txt_mm
End Sub

Private Sub tsyncButton_Click()
    basAPI.sync_time
End Sub
