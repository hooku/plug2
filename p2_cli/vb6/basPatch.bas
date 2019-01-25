Attribute VB_Name = "basPatch"
Option Explicit

Private Function patch_process(process_id As Long, old_bytes() As Byte, new_bytes() As Byte)
    Dim process_handle As Long
    Dim patch_address As Long
    
    process_handle = basAPI.process_open(process_id)
    
    patch_address = basAPI.process_mem_replace(process_handle, old_bytes, new_bytes)
    
    basAPI.process_close process_id
End Function

' this function search the flash ocx/dll in IE/Chrome/FF
Private Function patch_find_flash()
    '"iexplore.exe"
    '"chrome.exe"
    '"pl_btn_ctl_paipai"
    
    'TODO: add fuzzy search for FF flash plugin
    

End Function

Public Function patch_mem_manual(process_id As Long) As Boolean
    Dim old_bytes() As Byte, new_bytes() As Byte
    old_bytes = hex_to_bytes(InputBox("Hex to find", , "25E8072406A2"))
    new_bytes = hex_to_bytes(InputBox("Replace with", , "25E8072401A2"))
    patch_process process_id, old_bytes, new_bytes
End Function

Public Function patch_mem_defined(process_id As Long) As Boolean
    Dim result As Boolean
    Dim old_bytes() As Byte, new_bytes() As Byte
    
    If MsgBox("Do you want to apply pattern 1 for settimeout6000?", vbYesNo Or vbDefaultButton1) = vbYes Then
        old_bytes = hex_to_bytes("25 E8 07 24 06 A2")
        new_bytes = hex_to_bytes("25 E8 07 24 01 A2")
        log "Patch settimeout 6000.."
        patch_process process_id, old_bytes, new_bytes
    End If
    
    If MsgBox("Do you want to try pattern 2 for settimeout6000?", vbYesNo Or vbDefaultButton2) = vbYes Then
        old_bytes = hex_to_bytes("25 F0 2E")
        new_bytes = hex_to_bytes("25 E8 07")
        log "Patch settimeout6000 II.."
        patch_process process_id, old_bytes, new_bytes
    End If

    If MsgBox("Do you want to patch bidresult?", vbYesNo Or vbDefaultButton1) = vbYes Then
        old_bytes = hex_to_bytes("24 06 27 4A 93 02 02")
        new_bytes = hex_to_bytes("24 06 26 4A 93 02 02")
        log "Patch bidresult.."
        patch_process process_id, old_bytes, new_bytes
    End If

    patch_mem_defined = result
End Function

