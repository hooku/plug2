Attribute VB_Name = "basUI"
Option Explicit

Private Enum BTN_CTL
    BTN_CTL_PAIPAI
    BTN_CTL_PATCH_AUTO
    BTN_CTL_TRAINING
    BTN_CTL_PATCH_MANUAL
End Enum

Private Enum CMB
    CMB_1ST_SEC
    CMB_1ST_PRICE
    CMB_BREAK1_SEC
    CMB_BREAK1_PRICE
    CMB_BREAK2_SEC
    CMB_BREAK2_PRICE
End Enum

Private Enum CMB_SECOND
    [SEC_BEGIN] = 40#
    SEC_400 = SEC_BEGIN
    SEC_405 = 40.5
    SEC_410 = 41#
    SEC_415 = 41.5
    SEC_420 = 42#
    SEC_425 = 42.5
    SEC_430 = 43#
    SEC_435 = 43.5
    SEC_440 = 44#
    SEC_445 = 44.5
    SEC_450 = 45#
    SEC_455 = 45.5
    SEC_460 = 46#
    SEC_465 = 46.5
    SEC_470 = 47#
    SEC_475 = 47.5
    SEC_480 = 48#
    SEC_485 = 48.5
    SEC_490 = 49#
    SEC_495 = 49.5
    SEC_500 = 50#
    SEC_505 = 50.5
    SEC_510 = 51#
    SEC_515 = 51.5
    SEC_520 = 52#
    SEC_525 = 52.5
    SEC_530 = 53#
    SEC_535 = 53.5
    SEC_540 = 54#
    SEC_545 = 54.5
    SEC_550 = 55#
    SEC_555 = 55.5
    SEC_560 = 56#
    SEC_565 = 56.5
    SEC_570 = 57#
    SEC_575 = 57.5
    SEC_580 = 58#
    SEC_585 = 58.5
    SEC_590 = 59#
    SEC_595 = 59.5
    [SEC_END] = SEC_595
End Enum

Private Enum CMB_PRICE
    [PRICE_BEGIN] = 100
    PRICE_100 = PRICE_BEGIN
    PRICE_200 = 200
    PRICE_300 = 300
    PRICE_400 = 400
    PRICE_500 = 500
    PRICE_600 = 600
    PRICE_700 = 700
    PRICE_800 = 800
    PRICE_900 = 900
    PRICE_1000 = 1000
    [PRICE_END]
End Enum

Private Enum TIMER_FREQ
    FREQ_10HZ = 2
    FREQ_5HZ = 4
    FREQ_2HZ = 10
    FREQ_1HZ = 20
End Enum

Const STR_MM_OCR_TIME As String = "OCR_TIME"
Const STR_MM_OCR_PRICE As String = "OCR_PRICE"
Const STR_MM_TXT_AMOUNT As String = "TXT_AMOUNT"
Const STR_MM_TXT_PRICE As String = "TXT_PRICE"
Const STR_MM_TXT_CODE As String = "TXT_CODE"

Const STR_BTN_CTL_PAIPAI As String = "Start"
Const STR_BTN_CTL_PATCH_AUTO As String = "Patch &Auto"
Const STR_BTN_CTL_TRAINING As String = "&Training"
Const STR_BTN_CTL_PATCH_MANUAL As String = "Patch &Manual"

Const STR_BTN_CTL_PATCH_PROMPT_PID As String = "Process ID"

Const STR_CHK_CTL_ALIGN_POS As String = "Button Position"

Const STR_CMB_SEC_STEP = 0.5
Const STR_CMB_PRICE_STEP = 100

Const STR_CMB_1ST_SEC = "Sec"
Const STR_CMB_1ST_PRICE = "Price"
Const STR_CMB_BREAK1_SEC = "Sec"
Const STR_CMB_BREAK1_PRICE = "Price"
Const STR_CMB_BREAK2_SEC = "Sec"
Const STR_CMB_BREAK2_PRICE = "Price"

Const INT_DBG_TXT_LEFT = 0
Const INT_DBG_BOX_LEFT = 20
Const INT_DBG_BOX_GAP = 5
Const INT_DBG_BOX_BORDER = 1
Const DBG_BOX_BORDER_COLOR = &HFFC0C0

Dim str_mm_ocr As Variant, str_mm_txt As Variant
Dim str_btn_ctl As Variant, str_chk_ctl As Variant, str_cmb As Variant

Dim dbg_box_left As Integer, dbg_box_top As Integer
Dim refresh_count As Long

Private Sub print_dbg_img(picbox As Control, txt As String, h_pic As Long, width As Integer, height As Integer, Optional wrap As Boolean = False)
'    dbg_box_left = INT_DBG_BOX_LEFT
'    ' print title
'    picbox.CurrentX = INT_DBG_TXT_LEFT
'    picbox.CurrentY = dbg_box_top + (height - picbox.TextHeight("H")) / 2
'    picbox.Print txt
'
'    ' print picture
'    picbox.Line (dbg_box_left, dbg_box_top)-Step(width + INT_DBG_BOX_BORDER, height + INT_DBG_BOX_BORDER), DBG_BOX_BORDER_COLOR, B
'
'    Dim pic As Picture
'    Set pic = basAPI.convert_bmp_to_pic(h_pic)
'    picbox.PaintPicture pic, dbg_box_left + INT_DBG_BOX_BORDER, dbg_box_top + INT_DBG_BOX_BORDER
'
'    dbg_box_top = dbg_box_top + INT_DBG_BOX_BORDER + height + INT_DBG_BOX_BORDER + INT_DBG_BOX_GAP
End Sub

Private Sub dbg_ocr(pl_txt_ocr As Variant)
    Dim i As Integer
    
    Dim region As RECT
    Dim dbg_box_width As Integer, dbg_box_height As Integer
    Dim h_pic As Long
    Dim picbox As Control
    
    For i = 0 To UBound(str_mm_ocr)
        Set picbox = pl_txt_ocr(i)
        region = basAPI.get_region(picbox.hWnd)
        dbg_box_width = region.Right - region.Left
        dbg_box_height = region.Bottom - region.Top
        
        h_pic = basAPI.capture_region(region)
        
        print_dbg_img picbox, "Cap:", h_pic, dbg_box_width, dbg_box_height
    Next i
End Sub

' === MM ===
Public Function pl_mm_init(pl_txt_mm As Variant)
    str_mm_ocr = Array(STR_MM_OCR_TIME, STR_MM_OCR_PRICE)
    str_mm_txt = Array(STR_MM_TXT_AMOUNT, STR_MM_TXT_PRICE, STR_MM_TXT_CODE)
End Function

' === BTN ===
Private Function pl_btn_ctl_paipai()
    'dbg_ocr
End Function

Private Function pl_prompt_pid() As Long
    Dim process_id As Long
    Dim process_id_string As String
    process_id_string = InputBox(STR_BTN_CTL_PATCH_PROMPT_PID)
    
    If LenB(process_id_string) > 0 Then
        process_id = CLng(process_id_string)
    End If
    
    pl_prompt_pid = process_id
End Function

Private Function pl_btn_ctl_patch_auto()
    Dim process_id As Long
    process_id = pl_prompt_pid
    basPatch.patch_mem_defined process_id
End Function

Private Function pl_btn_ctl_patch_manual()
    Dim process_id As Long
    process_id = pl_prompt_pid
    basPatch.patch_mem_manual process_id
End Function

' === BTN ===
Public Function pl_btn_ctl_init(pl_btn_ctl As Variant)
    Dim i As Integer
    
    str_btn_ctl = Array(STR_BTN_CTL_PAIPAI, STR_BTN_CTL_PATCH_AUTO, STR_BTN_CTL_TRAINING, STR_BTN_CTL_PATCH_MANUAL)
    
    For i = 0 To UBound(str_btn_ctl)
        pl_btn_ctl(i).Caption = str_btn_ctl(i)
    Next i
End Function

Public Function pl_btn_ctl_Click(Index As Integer)
    Select Case Index
    Case BTN_CTL_PAIPAI
        pl_btn_ctl_paipai
    Case BTN_CTL_PATCH_AUTO
        pl_btn_ctl_patch_auto
    Case BTN_CTL_TRAINING
    Case BTN_CTL_PATCH_MANUAL
        pl_btn_ctl_patch_manual
    End Select
End Function

' === CHK ===
Public Function pl_chk_ctl_init(pl_chk_ctl As Variant)
    Dim i As Integer
    
    str_chk_ctl = Array(STR_CHK_CTL_ALIGN_POS)
    
    For i = 0 To UBound(str_chk_ctl)
        pl_chk_ctl(i).Caption = str_chk_ctl(i)
    Next i
End Function

Public Function pl_chk_ctl_Changed(Index As Integer)
    Select Case Index
        
    End Select
End Function

' === CMB ===
Public Function pl_cmb_init(pl_cmb As Variant)
    Dim i As Integer
    Dim sec As Single
    Dim price As Integer
    
    str_cmb = Array(STR_CMB_1ST_SEC, STR_CMB_1ST_PRICE, _
                    STR_CMB_BREAK1_SEC, STR_CMB_BREAK1_SEC, _
                    STR_CMB_BREAK2_SEC, STR_CMB_BREAK2_SEC)
    
    For i = 0 To UBound(str_cmb)
        Select Case i
        Case CMB_1ST_SEC, CMB_BREAK1_SEC, CMB_BREAK2_SEC
            For sec = SEC_BEGIN To SEC_END Step STR_CMB_SEC_STEP
                pl_cmb(i).AddItem (sec)
            Next sec
        Case CMB_1ST_PRICE, CMB_BREAK1_PRICE, CMB_BREAK2_PRICE
            For price = PRICE_BEGIN To PRICE_END Step STR_CMB_PRICE_STEP
                pl_cmb(i).AddItem (price)
            Next price
        End Select
    Next i
End Function

Private Function freq_10(para As Variant)

End Function

Private Function freq_5(para As Variant)

End Function

Private Function freq_2(para As Variant)

End Function

Private Function freq_1(para As Variant)
    dbg_ocr para
End Function

Public Function pl_refresh_timer(para As Variant)
    ' this function should return asap
    refresh_count = refresh_count + 1
    
    If refresh_count Mod FREQ_10HZ = 0 Then freq_10 para
    If refresh_count Mod FREQ_5HZ = 0 Then freq_5 para
    If refresh_count Mod FREQ_2HZ = 0 Then freq_2 para
    If refresh_count Mod FREQ_1HZ = 0 Then freq_1 para
End Function
