SUB Sertxd(in CRLF1 as byte, in stringa as string, in inputS as String,in CRLF2 as byte)

  if CRLF1 >0 Then
    HSerPrintCRLF CRLF1     'carriage return + line feed
  Else
    HSerSend CRLF1
  End if


  HSerPrint stringa
  HSerPrint inputS

  if CRLF2 >0 Then
    HSerPrintCRLF CRLF2
  Else
    HSerSend CRLF2
  End if

END SUB

SUB Sertxd(in CRLF1 as byte, in stringa as String, in inputB as Byte , in CRLF2 as Byte )

  if CRLF1 >0 Then
    HSerPrintCRLF CRLF1
  Else
    HSerSend CRLF1
  End if

  HSerPrint stringa
  HSerPrint inputB

  if CRLF2 > 0 Then
    HSerPrintCRLF CRLF2
  Else
    HSerSend CRLF2
  End if

END SUB

SUB Sertxd(in CRLF1 as byte, in stringa as string, in inputW as Word, in CRLF2 as byte)

  if CRLF1 >0 Then
    HSerPrintCRLF CRLF1     'se 1 cambia riga, se 0 no
  Else
    HSerSend CRLF1
  End if

  HSerPrint stringa
  HSerPrint inputW

  if CRLF2 > 0 Then
    HSerPrintCRLF CRLF2
  Else
    HSerSend CRLF2
  End if

END SUB

SUB Sertxd(in CRLF1 as byte, in stringa as string, in inputL as Long, in CRLF2 as byte)

  if CRLF1 > 0 Then
    HSerPrintCRLF CRLF1     'se 1 cambia riga, se 0 no
  Else
    HSerSend CRLF1
  End if

  HSerPrint stringa
  HSerPrint inputL

  if CRLF2 > 0 Then
    HSerPrintCRLF CRLF2
  Else
    HSerSend CRLF2
  End if

END SUB
SUB Draw_Line(in Line_Type as byte, in N_Char as byte, in Char as String)

  If N_Char <100 then
    HSerPrintCRLF 1
  else
    N_Char=N_Char-100
  end if
  Select Case Line_Type
  Case 1
    repeat N_Char
      HSerprint Char
    end repeat
  Case 2
    repeat N_Char
      HSerprint Char
      HSerPrint " "
    end repeat
  End Select
End Sub
