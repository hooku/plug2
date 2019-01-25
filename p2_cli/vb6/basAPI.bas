Attribute VB_Name = "basAPI"
Option Explicit

' === Bitmap API ===
Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal XSrc As Long, ByVal YSrc As Long, ByVal dwRop As Long) As Long
Private Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long

Private Declare Function GetDesktopWindow Lib "user32" () As Long
Private Declare Function GetWindowDC Lib "user32" (ByVal hWnd As Long) As Long

Private Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function ReleaseDC Lib "user32" (ByVal hWnd As Long, ByVal hdc As Long) As Long

Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long

Private Declare Function OleCreatePictureIndirect Lib "olepro32.dll" (PicDesc As PicBmp, RefIID As GUID, ByVal fPictureOwnsHandle As Long, IPic As IPicture) As Long

Private Type GUID
   Data1 As Long
   Data2 As Integer
   Data3 As Integer
   Data4(7) As Byte
End Type

Private Type PicBmp
    Size As Long
    Type As Long
    hBmp As Long
    hPal As Long
    Reserved As Long
End Type

' === Window API ===
Private Declare Function CallWindowProc Lib "user32" Alias "CallWindowProcA" (ByVal lpPrevWndFunc As Long, ByVal hWnd As Long, ByVal MSG As Long, ByVal wParam As Long, ByVal lParam As Long) As Long

Private Declare Function SetLayeredWindowAttributes Lib "user32" (ByVal hWnd As Long, ByVal crkey As Long, ByVal balpha As Byte, ByVal dwFlags As Long) As Boolean
Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long) As Long

Private Declare Function SetWindowPos Lib "user32" (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long

Private Declare Function GetWindowRect Lib "user32" (ByVal hWnd As Long, lpRect As RECT) As Long
Private Declare Function GetClientRect Lib "user32" (ByVal hWnd As Long, lpRect As RECT) As Long

Private Const HWND_TOPMOST = -1
Private Const HWND_NOTOPMOST = -2

Private Const SWP_NOSIZE = &H1
Private Const SWP_NOMOVE = &H2

Private Const GWL_WNDPROC = -4
Private Const GWL_EXSTYLE = -20

' === Key/Mouse API ===
Private Declare Function RegisterHotKey Lib "user32" (ByVal hWnd As Long, ByVal id As Long, ByVal fsModifiers As Long, ByVal vk As Long) As Long
Private Declare Function UnregisterHotKey Lib "user32" (ByVal hWnd As Long, ByVal id As Long) As Long

Private Declare Function ClientToScreen Lib "user32" (ByVal hWnd As Long, lpPoint As POINTAPI) As Long
Private Declare Function SetCursorPos Lib "user32" (ByVal x As Long, ByVal y As Long) As Long

Private Declare Sub keybd_event Lib "user32" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Long, ByVal dwExtraInfo As Long)
Private Declare Sub mouse_event Lib "user32" (ByVal dwFlags As Long, ByVal dx As Long, ByVal dy As Long, ByVal cButtons As Long, ByVal dwExtraInfo As Long)

Private Const MOD_ALT = &H1
Private Const MOD_CONTROL = &H2
Private Const MOD_SHIFT = &H4
Private Const MOD_NOREPEAT = &H4000

Private Const VK_F1 = &H70
Private Const VK_F10 = &H79
Private Const VK_F11 = &H7A
Private Const VK_F12 = &H7B
Private Const VK_F2 = &H71
Private Const VK_F3 = &H72
Private Const VK_F4 = &H73
Private Const VK_F5 = &H74
Private Const VK_F6 = &H75
Private Const VK_F7 = &H76
Private Const VK_F8 = &H77
Private Const VK_F9 = &H78
Private Const VK_RETURN = &HD
Private Const VK_ESCAPE = &H1B

Private Const KEYEVENTF_KEYUP = &H2

Private Const MOUSEEVENTF_LEFTDOWN = &H2
Private Const MOUSEEVENTF_LEFTUP = &H4

' === Process API ===
Private Declare Function ReadProcessMemory Lib "kernel32" (ByVal hProcess As Long, lpBaseAddress As Any, lpBuffer As Any, ByVal nSize As Long, lpNumberOfBytesWritten As Long) As Long
Private Declare Function WriteProcessMemory Lib "kernel32" (ByVal hProcess As Long, lpBaseAddress As Any, lpBuffer As Any, ByVal nSize As Long, lpNumberOfBytesWritten As Long) As Long
Private Declare Function OpenProcess Lib "kernel32" (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal dwProcessId As Long) As Long
Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Private Declare Sub GetSystemInfo Lib "kernel32" (lpSystemInfo As SYSTEM_INFO)
Private Declare Function VirtualQueryEx Lib "kernel32" (ByVal hProcess As Long, lpAddress As Any, lpBuffer As MEMORY_BASIC_INFORMATION, ByVal dwLength As Long) As Long

Private Declare Function CreateToolhelp32Snapshot Lib "kernel32" (ByVal dwFlags As Long, ByVal th32ProcessID As Long) As Long
Private Declare Function Process32First Lib "kernel32" (ByVal hSnapshot As Long, lppe As PROCESSENTRY32) As Long
Private Declare Function Process32Next Lib "kernel32" (ByVal hSnapshot As Long, lppe As PROCESSENTRY32) As Long


Private Const PROCESS_QUERY_INFORMATION = &H400
Private Const PROCESS_VM_OPERATION = &H8
Private Const PROCESS_VM_READ = &H10
Private Const PROCESS_VM_WRITE = &H20


Private Const PAGE_READONLY = &H2
Private Const PAGE_READWRITE = &H4
Private Const PAGE_WRITECOPY = &H8
Private Const PAGE_EXECUTE = &H10
Private Const PAGE_EXECUTE_READ = &H20
Private Const PAGE_EXECUTE_READWRITE = &H40
Private Const PAGE_EXECUTE_WRITECOPY = &H80

Private Const TH32CS_SNAPPROCESS = &H2


Private Const MEM_COMMIT = &H1000

Private Type SYSTEM_INFO
        dwOemID As Long
        dwPageSize As Long
        lpMinimumApplicationAddress As Long
        lpMaximumApplicationAddress As Long
        dwActiveProcessorMask As Long
        dwNumberOrfProcessors As Long
        dwProcessorType As Long
        dwAllocationGranularity As Long
        dwReserved As Long
End Type

Private Type MEMORY_BASIC_INFORMATION
     BaseAddress As Long
     AllocationBase As Long
     AllocationProtect As Long
     RegionSize As Long
     State As Long
     Protect As Long
     lType As Long
End Type

' stackoverflow.com/questions/25358015/how-to-open-switch-to-a-process-in-task-manager
Private Type PROCESSENTRY32
     dwSize As Long
     cntUsage As Long
     th32ProcessID As Long           ' This process
     th32DefaultHeapID As Long
     th32ModuleID As Long            ' Associated exe
     cntThreads As Long
     th32ParentProcessID As Long     ' This process's parent process
     pcPriClassBase As Long          ' Base priority of process threads
     dwFlags As Long
     szExeFile As String * 260 ' MAX_PATH
End Type

' === Misc API ===
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Private Declare Function GetLastError Lib "kernel32" () As Long

Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Private Declare Function GetProcessHeap Lib "kernel32" () As Long
Private Declare Function HeapAlloc Lib "kernel32" (ByVal hHeap As Long, ByVal dwFlags As Long, ByVal dwBytes As Long) As Long
Private Declare Function HeapFree Lib "kernel32" (ByVal hHeap As Long, ByVal dwFlags As Long, lpMem As Any) As Long

Private h_con As Long

Private Type POINTAPI
    x As Long
    y As Long
End Type

Public Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type

Private Const LWA_COLORKEY = 1
Private Const LWA_ALPHA = 2

Private Const WS_EX_LAYERED = &H80000
Private Const WS_EX_TRANSPARENT = &H20

Private Const WM_NCDESTROY = &H82
Private Const WM_ENTERSIZEMOVE = &H231
Private Const WM_EXITSIZEMOVE = &H232
Private Const WM_HOTKEY = &H312

Private Type MSG
    hWnd As Long
    message As Long
    wParam As Long
    lParam As Long
    time As Long
    pt As POINTAPI
End Type

' === Custom Type ===
Public Type key_bind
    name As Integer
    Modifier As Long
    key As Long
End Type

Private Const MOUSEDOWN_TIME = 40   'ms
Private Const KEYDOWN_TIME = 5   'ms

Private old_window_proc As Long

' === Bitmap Function ===
' vbnet.mvps.org/index.html?code/bitmap/printscreenole.htm
Public Function convert_bmp_to_pic(ByVal h_bmp As Long) As Picture  ' make picturebox able to eat the result
    Dim pic As PicBmp
    Dim i_pic As IPicture   ' IPicture requires a reference to "Standard OLE Types."
    Dim IID_IDispatch As GUID
    
    With IID_IDispatch
       .Data1 = &H20400
       .Data4(0) = &HC0
       .Data4(7) = &H46
    End With
    
    With pic
       .Size = Len(pic)         ' Length of structure.
       .Type = vbPicTypeBitmap  ' Type of Picture (bitmap).
       .hBmp = h_bmp            ' Handle to bitmap.
       .hPal = 0                ' Handle to palette (may be null).
    End With
    
    ' Create Picture object
    Call OleCreatePictureIndirect(pic, IID_IDispatch, 1, i_pic)
    
    ' Return the new Picture object
    Set convert_bmp_to_pic = i_pic
End Function

Public Function delete_bmp(h_bmp As Long) As Long
    delete_bmp = DeleteObject(h_bmp)
End Function

Public Function capture_region(region As RECT) As Long
    Dim width As Long, height As Long
    width = region.Right - region.Left
    height = region.Bottom - region.Top
    'pic = basShot.CaptureScreen2(region.Left, region.Top, width, height)
    
    Dim hwnd_screen As Long, hdc_screen As Long
    Dim hdc_mem As Long
    Dim hbmp_mem As Long, hbmp_prev_mem As Long
    
    hwnd_screen = GetDesktopWindow()
    hdc_screen = GetWindowDC(hwnd_screen)
    
    hdc_mem = CreateCompatibleDC(hdc_screen)
    hbmp_mem = CreateCompatibleBitmap(hdc_screen, width, height)
    
    hbmp_prev_mem = SelectObject(hdc_mem, hbmp_mem)
    BitBlt hdc_mem, 0, 0, width, height, hdc_screen, region.Left, region.Top, vbSrcCopy
    hbmp_mem = SelectObject(hdc_mem, hbmp_prev_mem)
    
    DeleteDC hdc_mem
    ReleaseDC hwnd_screen, hdc_screen
    
    capture_region = hbmp_mem
End Function

Public Function get_region(hWnd As Long) As RECT
    Dim region As RECT
    Call GetWindowRect(hWnd, region)
    get_region = region
End Function

' === Window Function ===
Private Function new_window_proc(ByVal hWnd As Long, ByVal uMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long

    Select Case uMsg
    Case WM_NCDESTROY
        SetWindowLong hWnd, GWL_WNDPROC, old_window_proc
    Case WM_ENTERSIZEMOVE
        frmPlug2.form_begin_move
    Case WM_EXITSIZEMOVE
        frmPlug2.form_end_move
    Case WM_HOTKEY
        'process_key wParam
    End Select

    new_window_proc = CallWindowProc(old_window_proc, hWnd, uMsg, wParam, lParam)
End Function

Public Function init_subclassing(hWnd As Long)
    old_window_proc = SetWindowLong(hWnd, GWL_WNDPROC, AddressOf new_window_proc)
End Function

Public Sub set_window_transparent(hWnd As Long, crkey As Long, balpha As Byte)
    SetWindowLong hWnd, GWL_EXSTYLE, GetWindowLong(hWnd, GWL_EXSTYLE) Or WS_EX_LAYERED

    If balpha = 255 Then
        SetLayeredWindowAttributes hWnd, crkey, 0, LWA_COLORKEY
    Else
        SetLayeredWindowAttributes hWnd, 0, balpha, LWA_ALPHA
    End If
End Sub

Public Sub set_window_hit_through(hWnd As Long, is_hit_through As Boolean)
    If is_hit_through = True Then
        SetWindowLong hWnd, GWL_EXSTYLE, GetWindowLong(hWnd, GWL_EXSTYLE) Or WS_EX_LAYERED Or WS_EX_TRANSPARENT
    Else
        SetWindowLong hWnd, GWL_EXSTYLE, GetWindowLong(hWnd, GWL_EXSTYLE) Or WS_EX_LAYERED And (Not WS_EX_TRANSPARENT)
    End If
End Sub

Public Sub set_window_topmost(hWnd As Long, is_top_most As Boolean)
    If is_top_most = True Then
        SetWindowPos hWnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE Or SWP_NOMOVE
    Else
        SetWindowPos hWnd, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOSIZE Or SWP_NOMOVE
    End If
End Sub

' === Key/Mouse Function ===
Public Sub reg_all_hot_key(hWnd As Long, kb() As key_bind)
    Dim Modifier As Long
    Dim i As Long

    For i = 0 To UBound(kb)
        'Select Case kb(i).Mod
        'Case vbShiftMask
        '    Modifier = MOD_SHIFT
        'Case vbCtrlMask
        '    Modifier = MOD_CONTROL
        'Case vbAltMask
        '    Modifier = MOD_ALT
        'End Select

       ' RegisterHotKey hWnd, kb(i).Index, Modifier, kb(i).key
    Next i
End Sub

Public Sub unreg_all_hot_key(hWnd As Long, kb() As key_bind)
    Dim i As Long

    For i = 0 To UBound(kb)
        'UnregisterHotKey hWnd, kb(i).Index
    Next i
End Sub

Public Sub key_down_up(vk_code As Byte)
    keybd_event vk_code, 0, 0, 0
    'DoEvents
    Sleep KEYDOWN_TIME
    'DoEvents
    keybd_event vk_code, 0, KEYEVENTF_KEYUP, 0
End Sub

Public Sub mouse_down_up()
    mouse_event MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0
    'DoEvents
    Sleep MOUSEDOWN_TIME
    'DoEvents
    mouse_event MOUSEEVENTF_LEFTUP, 0, 0, 0, 0
End Sub

Public Sub mouse_move_to_control(hWnd As Long)
    Dim point As POINTAPI
    Dim rectangle As RECT
    Dim mid_x As Long, mid_y As Long

    ClientToScreen hWnd, point
    GetClientRect hWnd, rectangle

    mid_x = point.x + rectangle.Right / 2
    mid_y = point.y + rectangle.Bottom / 2

    SetCursorPos mid_x, mid_y
End Sub

' === Process Function ===
Public Function process_find(process_name As String, Optional module_name As String) As Long
    Dim process_id As Long
    
    Dim h_snap As Long, proc As PROCESSENTRY32
    'h_snap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)
    proc.dwSize = LenB(proc)
    'f = Process32First(h_snap, proc)
    
    'f = Process32Next(h_snap, proc)
    
    process_find = process_id
End Function

Public Function process_open(process_id As Long) As Long
    Dim process_handle As Long
    
    process_handle = OpenProcess(PROCESS_QUERY_INFORMATION Or PROCESS_VM_OPERATION Or PROCESS_VM_READ Or PROCESS_VM_WRITE, 0, process_id)
    log "Handle " & CStr(process_handle)
    
    process_open = process_handle
End Function

Public Function process_close(process_handle As Long)
    CloseHandle process_handle
End Function

Public Function process_mem_replace(process_handle As Long, old_data() As Byte, new_data() As Byte, Optional find_more As Boolean) As Long
    Dim api_result As Long

    Dim find_count As Long
    Dim process_min_addr As Long, process_max_addr As Long
    Dim sys_info As SYSTEM_INFO
    Dim mem_info As MEMORY_BASIC_INFORMATION
    Dim mem_protect_mask As Long
    Dim bytes_read As Long, bytes_written As Long
    Dim addr_offset As Long, addr As Long, data_len As Long
    
    If process_handle = 0 Then
        Exit Function
    End If
    
    GetSystemInfo sys_info
    
    process_min_addr = sys_info.lpMinimumApplicationAddress
    process_max_addr = sys_info.lpMaximumApplicationAddress
    
    log "min=0x" & Hex(process_min_addr) & ", max=0x" & Hex(process_max_addr)
    
    Do While process_min_addr < process_max_addr
        VirtualQueryEx process_handle, ByVal process_min_addr, mem_info, LenB(mem_info)  'sizeof

        If (mem_info.Protect = PAGE_READWRITE Or _
            mem_info.Protect = PAGE_READONLY Or _
            mem_info.Protect = PAGE_READWRITE Or _
            mem_info.Protect = PAGE_WRITECOPY Or _
            mem_info.Protect = PAGE_EXECUTE Or _
            mem_info.Protect = PAGE_EXECUTE_READ Or _
            mem_info.Protect = PAGE_EXECUTE_READWRITE Or _
            mem_info.Protect = PAGE_EXECUTE_WRITECOPY) _
            And mem_info.RegionSize > 0 Then 'And mem_info.State = MEM_COMMIT
            Dim p_read_buffer() As Byte
            
            ReDim p_read_buffer(mem_info.RegionSize - 1)
            ReadProcessMemory process_handle, ByVal mem_info.BaseAddress, ByVal VarPtr(p_read_buffer(0)), mem_info.RegionSize, bytes_read
            
            addr_offset = InStrB(1, p_read_buffer, old_data, vbBinaryCompare) - 1
                        
            If addr_offset > 0 Then
                addr = mem_info.BaseAddress + addr_offset
                log "addr=0x" & Hex(addr)
                Dim debug_buffer(10) As Byte
                Dim i As Integer
                For i = 0 To 10
                    debug_buffer(i) = p_read_buffer(addr_offset + i)
                Next

                data_len = UBound(old_data) + 1
                api_result = WriteProcessMemory(process_handle, ByVal addr, ByVal VarPtr(new_data(0)), data_len, bytes_written)
                log "Written:" & CStr(bytes_written)
                
                find_count = find_count + 1
            End If
        End If
        process_min_addr = process_min_addr + mem_info.RegionSize
    Loop
    
    If find_count = 0 Then
        log "Not Found"
    End If
    
    process_mem_replace = find_count
End Function

' === Misc Function ===
Public Function get_last_error()
log "LAST ERR: " & CStr(GetLastError())
End Function

Public Function mem_alloc(Size As Long)
    Dim heap_handle As Long
    Dim ptr As Long
    heap_handle = GetProcessHeap()
    ptr = HeapAlloc(heap_handle, 0, Size)
    mem_alloc = ptr
End Function

Public Function mem_free(ptr As Long)
    Dim heap_handle As Long
    heap_handle = GetProcessHeap()
    HeapFree heap_handle, 0, ptr
End Function

Public Function mem_cpy(var As Variant, ptr As Long, num As Long)
    CopyMemory var, ptr, num
End Function

Public Sub thread_sleep(ms As Long)
    Sleep ms
End Sub

' stackoverflow.com/questions/28798759/how-convert-hex-string-into-byte-array-in-vb6
Public Function bytes_to_hex(ByRef Bytes() As Byte) As String
    'Quick and dirty Byte array to hex String, format:
    '
    '   "HH HH HH"

    Dim LB As Long
    Dim ByteCount As Long
    Dim BytePos As Integer

    LB = LBound(Bytes)
    ByteCount = UBound(Bytes) - LB + 1
    If ByteCount < 1 Then Exit Function
    bytes_to_hex = Space$(3 * (ByteCount - 1) + 2)
    For BytePos = LB To UBound(Bytes)
        Mid$(bytes_to_hex, 3 * (BytePos - LB) + 1, 2) = _
            Right$("0" & Hex$(Bytes(BytePos)), 2)
    Next
End Function

Public Function hex_to_bytes(ByVal hex_string As String) As Byte()
    'Quick and dirty hex String to Byte array.  Accepts:
    '
    '   "HH HH HH"
    '   "HHHHHH"
    '   "H HH H"
    '   "HH,HH,     HH" and so on.

    Dim Bytes() As Byte
    Dim HexPos As Integer
    Dim HexDigit As Integer
    Dim BytePos As Integer
    Dim Digits As Integer

    ReDim Bytes(Len(hex_string) \ 2)  'Initial estimate.
    For HexPos = 1 To Len(hex_string)
        HexDigit = InStr("0123456789ABCDEF", _
                         UCase$(Mid$(hex_string, HexPos, 1))) - 1
        If HexDigit >= 0 Then
            If BytePos > UBound(Bytes) Then
                'Add some room, we'll add room for 4 more to decrease
                'how often we end up doing this expensive step:
                ReDim Preserve Bytes(UBound(Bytes) + 4)
            End If
            Bytes(BytePos) = Bytes(BytePos) * &H10 + HexDigit
            Digits = Digits + 1
        End If
        If Digits = 2 Or HexDigit < 0 Then
            If Digits > 0 Then BytePos = BytePos + 1
            Digits = 0
        End If
    Next
    If Digits = 0 Then BytePos = BytePos - 1
    If BytePos < 0 Then
        Bytes = "" 'Empty.
    Else
        ReDim Preserve Bytes(BytePos)
    End If
    hex_to_bytes = Bytes
End Function

Public Sub sync_time()
    Shell "cmd /c ""net start w32time & w32tm /config /update /manualpeerlist:time.pool.aliyun.com & w32tm /resync /force""", vbNormalFocus
End Sub
