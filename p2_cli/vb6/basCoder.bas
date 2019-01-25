Attribute VB_Name = "basCoder"
Option Explicit

Const key As String = "!" & "@" & "p" & "!"
Const tbl As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" & "abcdefghijklmnopqrstuvwxyz" & "0123456789" & "+/="
Const delt As Currency = 2654435769# '&H9E3779B9
Const SIGN_BIT = &H80000000
Const MAX_LONG = &H7FFFFFFF

Function p_lsh(ByVal ptr As Long, ByVal amount As Long) As Long
    If amount <= 0 Then p_lsh = ptr
    If amount = 31 Then p_lsh = ptr And 1
    If (amount <= 0) Or (amount >= 31) Then Exit Function
    
    If ptr < 0 Then
        p_lsh = (ptr And &H7FFFFFFF) \ (2 ^ amount) Or 2 ^ (31 - amount)
    Else
        p_lsh = ptr \ (2 ^ amount)
    End If
End Function

Function p_rsh(ByVal ptr As Long, ByVal amount As Long) As Long
    If amount <= 0 Then p_rsh = ptr
    If (amount <= 0) Or (amount > 31) Then Exit Function
    
    p_rsh = (ptr And (2 ^ (31 - amount) - 1)) * _
        IIf(amount = 31, SIGN_BIT, 2 ^ amount) Or _
        IIf((ptr And 2 ^ (31 - amount)) = 2 ^ (31 - amount), _
        SIGN_BIT, 0)
End Function

Private Function p_add(ByVal ptr As Long, ByVal amount As Long) As Long
    Dim adj As Long
    If amount < 0& Then adj = SIGN_BIT
    p_add = ((ptr Xor SIGN_BIT) + (amount Xor adj)) Xor (SIGN_BIT Xor adj)
End Function

Private Function p_sub(ByVal ptr As Long, ByVal amount As Long) As Long
    Dim adj As Long
    If amount < 0& Then adj = SIGN_BIT
    p_sub = ((ptr Xor SIGN_BIT) - (amount Xor adj)) Xor (SIGN_BIT Xor adj)
End Function

Private Function p_mul(ByVal ptr As Long, ByVal amount As Long) As Long
    Dim ptr_cur As Currency, amount_cur As Currency
    ptr_cur = CCur(ptr)
    amount_cur = CCur(amount)
    ptr_cur = ptr_cur * amount_cur
    ptr_cur = ptr_cur And MAX_LONG
    p_mul = CLng(ptr_cur)
End Function

Private Function decode_str_to_byte(param1 As String) As Byte()
    Dim v6 As Long
    Dim v7 As Long
    Dim v2() As Byte
    Dim v3(4) As Long
    Dim v4(4) As Long
    Dim v5 As Long
    
    ReDim v2(0)

    Do While (v5 < Len(param1))
        v6 = 0
        Do While ((v6 < 4) And ((p_add(v5, v6)) < Len(param1)))
            v3(v6) = InStr(1, tbl, Mid(param1, p_add(v5, 6), 1))
            v6 = p_add(v6, 1)
        Loop
        v4(0) = p_add(p_lsh(v3(0), 2), (p_rsh((v3(1) And 48), 4)))
        v4(1) = p_add(p_lsh((v3(1) And 15), 4), p_rsh((v3(2) And 60), 2))
        v4(2) = p_add(p_lsh((v3(2) And 3), 6), v3(3))
        v7 = 0
        Do While (v7 < UBound(v4))
            If (v3(p_add(v7, 1)) = 64) Then
                Exit Do
            End If
            ReDim Preserve v2(UBound(v2) + 1)
            v2(UBound(v2)) = v4(v7)
            v7 = p_add(v7, 1)
        Loop
        v5 = p_add(v5, 4)
    Loop
    decode_str_to_byte = v2
End Function

Private Function decode_decrypt(param1() As Byte, param2() As Byte) As Byte()
    Dim v8 As Long, v9 As Long, v10 As Long
    If (UBound(param1) = 0) Then
        Return
    End If
    Dim v3() As Long
    Dim v4() As Long
    v3 = dec2(param1, False)
    v4 = dec2(param1, False)
    If (UBound(v4) < 4) Then
        ReDim Preserve v4(4)
    End If
    Dim v5 As Long, v6 As Long, v7 As Long, v11 As Long
    Dim v12 As Long
    Dim v11_cur As Currency, v12_cur As Currency
    v5 = UBound(v3) - 1
    v6 = v3(v5 - 1)
    v7 = v3(0)
    v11 = Abs(6 + 52 / (v5 + 1))    'uint
    v11_cur = v11
    v12_cur = v11_cur * delt
    'v12_cur = BigMod(v12_cur, u32mask)
    v12 = CLng(v12_cur)
    Do While (v12 <> 0)
        v9 = p_rsh(v12, 2) And 3  '_v12_ >>> 2 & 3;
        v10 = v5
        Do While (v10 > 0)
            v6 = v3(v10 - 1)
            '_v8_ = (_v6_ >>> 4 ^ _v7_ << 2) + (_v7_ >>> 3 ^ _v6_ << 6) ^ (_v12_ ^ _v7_) + (_v4_[_v10_ & 3 ^ _v9_] ^ _v6_);
            v8 = (p_rsh(v6, 4) Xor p_lsh(v7, 2)) + (p_rsh(v7, 3) Xor (p_lsh(v6, 6))) Xor (v12 Xor v7) + (v4((v10 And 3) Xor v9) Xor v6)
            v3(v10) = v3(v10) - v8    '_v7_ = _v3_[_v10_] = _v3_[_v10_] - _v8_;
            v7 = v3(v10)
            v10 = v10 - 1
        Loop
    Loop
    
    v6 = v3(v5)
    '_v8_ = (_v6_ >>> 4 ^ _v7_ << 2) + (_v7_ >>> 3 ^ _v6_ << 6) ^ (_v12_ ^ _v7_) + (_v4_[_v10_ & 3 ^ _v9_] ^ _v6_);
    v8 = (p_rsh(v6, 4) Xor p_lsh(v7, 2)) + (p_rsh(v7, 3) Xor p_lsh(v6, 6)) Xor (v12 Xor v7) + (v4((v10 And 3) Xor v9) Xor v6)
    v3(0) = v3(0) - v8    '_v7_ = _v3_[0] = _v3_[0] - _v8_;
    v7 = v3(0)
    v12 = v12 - delt
    
    decode_decrypt = dec3(v3, True)
End Function

Private Function dec2(param1() As Byte, param2 As Boolean) As Long()
    Dim v3 As Long, v4 As Long
    v3 = UBound(param1)
    v4 = p_rsh(v3, 2)
    If ((v3 Mod 4) > 0) Then
        v4 = v4 + 1
        ReDim Preserve param1(UBound(param1) + (4 - (v3 Mod 4)))
    End If
    
    Dim param1_len As Long
    param1_len = UBound(param1) \ 4
    
    Dim v5() As Long
    Dim v6 As Long
    
    ReDim v5(UBound(param1) \ 4)
    
    'param1.endian = Endian.LITTLE_ENDIAN;
    'convert byte array to int array
    'v5
    Dim int_arr() As Long
    Dim int_arr_index As Integer
    ReDim int_arr(param1_len)
    mem_cpy int_arr(0), VarPtr(param1(0)), param1_len
    
    Do While (v6 < v4)
        v5(v6) = int_arr(int_arr_index)
        int_arr_index = int_arr_index + 1
        v6 = v6 + 1
    Loop
    
    If (param2 = True) Then
        v5(v4) = v3
    End If
    
    ReDim Preserve param1(v3)
    dec2 = v5
End Function

Private Function dec3(param1() As Long, param2 As Boolean) As Byte()
    Dim v7 As Long, v3 As Long, v4 As Long
    v7 = 0
    v3 = UBound(param1)
    v4 = v3 - p_lsh(1, 2)
    If (param2 = True) Then
        v7 = param1(v3 - 1)
        If ((v7 < v4 - 3) Or (v7 > v4)) Then
            Return  'return null;
        End If
        Dim v5() As Byte
        Dim v5_index As Integer
        Dim v5_len As Long
        v5_len = UBound(param1) * 4
        ReDim v5(v5_len)
        mem_cpy v5(0), param1(0), v5_len
        
        Dim v6 As Long
        Do While (v6 < v3)
            'convert int array to byte array
            '_v5_.writeUnsignedInt(param1[_v6_]);
            v5(v5_index) = param1(v6)
            v5_index = v5_index + 1
            v6 = v6 + 1
        Loop
        If (param2 = True) Then
            ReDim Preserve v5(v4)
            dec3 = v5
            Return
        End If
        dec3 = v5
        Return
    End If
End Function

Private Function to_utf(param1 As String) As String
    Dim v2() As Byte
    v2 = decode_str_to_byte(param1)
    to_utf = v2   'return _v2_.readUTFBytes(_v2_.length);
End Function

Public Function ws2015_decode_str(param1 As String) As String
    Dim key_byte() As Byte
    Dim key_byte_len As Long
    'string to byte
    'key_str
    Dim key_str As String
    key_str = Mid(key, 2, 4)
    
    key_byte_len = 4 * 2 '2~5
    ReDim key_byte(key_byte_len)
    mem_cpy key_byte(0), VarPtr(key_str), key_byte_len
    
    Dim v2() As Byte, v3() As Byte
    v2 = decode_str_to_byte(param1)
    v3 = decode_decrypt(v2, key_byte)
    
    Dim v4 As String
    v4 = Space(UBound(v3) / 2)
    'byte to string
    'v4 = v3
    mem_cpy VarPtr(v4), VarPtr(v3(0)), UBound(v3)
    
    Dim v5 As String
    v5 = to_utf(v4)
    ws2015_decode_str = v5
End Function

Public Function test_decode()
    Dim decoded_str As String
    
    Dim a As Long, b As Long
    a = &H7FFFFFFF
    b = 30
    'b = 2 ^ 31 - 1
    MsgBox Hex(a) & "+" & Hex(b) & "=" & Hex(p_add(a, b))
    MsgBox Hex(a) & "<<" & Hex(b) & "=" & Hex(p_lsh(a, b))
    MsgBox Hex(a) & ">>" & Hex(b) & "=" & Hex(p_rsh(a, b))
    
'    decoded_str = ws2015_decode_str("IdnuLqUI1+4Q5/phsCiYFI5l+O69RGJdX4DYyA==")
'    decoded_str = ws2015_decode_str("AK8zg5S1r1KPhYSkKO0SZ6ZNsiCX9EZd")
'    decoded_str = ws2015_decode_str("bKxMP5orgHP61x+pkiealBjrfmfeYymMwzFGFw==")
'    decoded_str = ws2015_decode_str("uBcAruIhUM39xKi+/vmDS6D0o4K4KxpFMThKIzV223A95nOan7FaDguegWbWtASOKV8KXeAxVgV3mHTjZTXBtJHQVMBmQA/z70Bqf5a33bSq3fAHm7spNdhTEmXiNT9Y5BDixqGo8t2tIfXFW6FPHdmLrLqECgv02MuRqe/l4rIIsidX3j9uYNRXicGEeThipiwdC46nAtqpgWiqjDTqQWe7bcSu6A0EdOkKSbQD7UrX1fCc5vTLVJsSj9dWXfdRRtzwZZJWbvRBNbHa7k6SlPIAPCbQ/qRNfQzai1Wf1LbpGZTtLDctYGE995w69dyfsSCx27EvtrDktlfueRcsAL5SSA2oJqvHssc3fLBdE1FF0iyrxrXykatUa6rZ+u8rwHE1PG3G8MGZwVKSVSBzvj5mWIsK7Y4x4EX8XlGwBp79IORoRUO3Ey2eOP65Zlz3X/BNhmAXNvxOhu7m+uVMwjYlEQ/wdJSBdEWqxiPGN41votVOitSN9vwl68UtElZnxGeDO7uphSe6POLp+oH27h0bUZl2JMoLJGJMtc4DCVdWMmMhxWGy+s/m/jgGuItw7z1v64syUT6lhiVFh0mAORRthZ6gWUwRUVuN9/qftDZcTsP2GcIjqEWOY802GkMlkh0tAJ2cs7/sjWwOAwIGOA==")

    MsgBox decoded_str
End Function

