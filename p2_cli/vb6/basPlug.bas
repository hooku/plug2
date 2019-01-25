Attribute VB_Name = "basPlug2"
Option Explicit

Dim old_win_proc As Long, new_win_proc As Long
Attribute new_win_proc.VB_VarUserMemId = 1073741824

Private Enum HotKey_Name
    HK_ADD
    HK_BID
    HK_ADD_100
    HK_ADD_200
    HK_ADD_300
    HK_MADD_600
    HK_MADD_700
    HK_MADD_800
    HK_MADD_900
    HK_OK
    HK_CANCEL
End Enum

Public Enum PLP_Status
    PLP_STOP
    PLP_START
    PLP_1030_TO_1100
    PLP_1100_TO_1129
    PLP_PEEP_CODE
End Enum

Const DESC_PLP_STAT_STOP = "PLP Stopped"
Const DESC_PLP_STAT_START = "PLP Started"
Const DESC_PLP_STAT_1030_TO_1100 = "Bid 1st"
Const DESC_PLP_STAT_1100_TO_1129 = "Wait for bid 2nd"
Const DESC_PLP_STAT_PEEP_CODE = "Peep code!!"

Private Type PLP_FSM
    plp_stat As PLP_Status
    plp_desc As String
    'plp_time as
End Type

Public kb(14) As key_bind
Attribute kb.VB_VarUserMemId = 1073741826
Public plp_stat As PLP_Status
Attribute plp_stat.VB_VarUserMemId = 1073741827

Private Sub draw_mm_text()
    Dim i As Integer

    For i = 0 To UBound(kb)
        'RegisterHotKey frmPlug2.hWnd, key_bind(i).Index, key_bind(i).mod, key_bind(i).key
        'If key_bind(i).key >= VK_F1 And key_bind(i).key < VK_F12 And i < 10 Then
        '    frmPlug2.mmButton(i).Caption = "f" & key_bind(i).key + 1 - VK_F1
        'Else
        '    Select Case key_bind(i).key
        '    Case VK_RETURN
        '        frmPlug2.mmButton(i).Caption = "enter"
        '    Case VK_ESCAPE
        '        frmPlug2.mmButton(i).Caption = "esc"
        '    End Select
        'End If
    Next i
End Sub

Private Sub simulate_key(Text As String)
    Dim i As Integer
    For i = 1 To Len(Text)
        basAPI.key_down_up vbKey0 + Mid(Text, i, 1)
    Next i
End Sub

Private Sub simulate_click(Optional dblclick = False)
    basAPI.mouse_down_up
    If dblclick = True Then
        basAPI.mouse_down_up
    End If
End Sub

Private Sub simulate_move_Button(Index As Integer)
    'basAPI.mouse_move_to_control frmPlug2.mmButton(kb(Index).Index).hWnd
End Sub

Private Sub simulate_move_Text(Index As Integer)
    'basAPI.mouse_move_to_control frmPlug2.mmText(Index).hWnd
End Sub

Public Sub process_key(Index As Integer)
    Select Case Index
    Case 0 To 1
        simulate_move_Button Index
        simulate_click
    Case 2 To 4
        simulate_move_Button 8
        simulate_click
        simulate_move_Button Index
        simulate_click
        simulate_move_Button 1
        simulate_click
    Case 5
        frmPlug2.Show
    Case 6 To 8
        simulate_move_Button Index
        simulate_click
    Case 9
        simulate_move_Button Index
        simulate_click
        simulate_move_Text 3
        simulate_click True
    Case 11
        simulate_move_Text 0
        simulate_click True
        simulate_key "600"
        simulate_move_Button 0
        simulate_click
    Case 12
        simulate_move_Text 0
        simulate_click True
        simulate_key "700"
        simulate_move_Button 0
        simulate_click
    Case 13
        simulate_move_Text 0
        simulate_click True
        simulate_key "800"
        simulate_move_Button 0
        simulate_click
    Case 14
        'unregister_key
        AppExit
    End Select
End Sub

Private Sub init_hot_key()
    kb(0).name = 0
    kb(0).key = vbKeyF9
    kb(1).name = 1
    kb(1).key = vbKeyF10
    kb(2).name = 2
    kb(2).key = vbKeyF1
    kb(3).name = 3
    kb(3).key = vbKeyF2
    kb(4).name = 4
    kb(4).key = vbKeyF3
    kb(5).name = 5
    kb(5).key = vbKeyF8
    kb(5).Modifier = vbAltMask
    kb(6).name = 6
    kb(6).key = vbKeyReturn
    kb(7).name = 7
    kb(7).key = vbKeyEscape
    kb(8).name = 8
    kb(8).key = vbKeyReturn
    kb(8).Modifier = vbAltMask
    kb(9).name = 9
    kb(9).key = vbKeyF5
    kb(10).name = 10
    kb(10).key = vbKeyF4    ' disable f4
    kb(11).name = 11
    kb(11).key = vbKeyF6
    kb(12).name = 12
    kb(12).key = vbKeyF7
    kb(13).name = 13
    kb(13).key = vbKeyF8
    kb(14).name = 14
    kb(14).Modifier = vbCtrlMask
    kb(14).key = vbKeyC
End Sub

Private Sub Main()
    'test_decode
    'End

    plp_stat = PLP_STOP

    init_hot_key

    Load frmPlug2
    frmPlug2.Show

    log "Application Start"
End Sub

Public Sub log(txt As String)
    Dim top_index As Integer

    frmPlug2.pl_lst_log.AddItem "[" & Format(Now, "HH:mm:ss") & "." & Int((Timer - Int(Timer)) * 10) & "] " & txt
    
    top_index = frmPlug2.pl_lst_log.ListCount - 4
    If top_index < 0 Then
        top_index = 0
    End If
    frmPlug2.pl_lst_log.TopIndex = top_index
    DoEvents
End Sub

Public Sub AppExit()
    Unload frmPlug2

    'basAPI.unreg_all_hot_key kb
End Sub
