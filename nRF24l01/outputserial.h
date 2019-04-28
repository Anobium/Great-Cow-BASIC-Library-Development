
' 1.01 added USART SUPPORT and PORT


function crlf (Optional num As byte = 1, Optional nport As byte = 1  )

	#ifdef USART_BAUD_RATE
  	for loopcrlf = 1 to num
    	HSerSend 13
      HSerSend 10
    next
  #endif

  #ifndef USART_BAUD_RATE
    for loopcrlf = 1 to num
      SerSend nport,13
      SerSend nport,10
    next
  #endif
end function

' Position cursor on Terminal
Sub ANSI ( IN xpos, IN ypos )
    HSerSend 27
    HSerPrint "["
    HSerPrint ypos
    HSerSend 59
    HSerPrint xpos
    HSerPrint "H"
End Sub

' Position cursor on Terminal
Sub ANSI_SW ( xpos, ypos, Optional xchannel as Byte = 1 )
    SerSend xchannel,     27
    SerPrint xchannel,    "["
    SerPrint xchannel,    str(xpos)
    SerSend xchannel,     59
    serprint xchannel,    str(ypos)
    serprint xchannel,    "H"
    wait SerSendDelayms ms
End Sub

' Eraase Terminal
Sub ANSIERASECREEN
    HSerSend 27
    HSerPrint "[2J"
end Sub

' Eraase Terminal
Sub ANSIERASECREEN_SW ( Optional xchannel as Byte = 1 )
    wait SerSendDelayms ms
    SerSend  xchannel, 27
    wait SerSendDelayms ms
    SerPrint  xchannel, "[2J"

end Sub


' Clear a specific line on Terminal
Sub ANSICLEARLINE
	'<ESC>[K
  	HSerSend 27
    HSerPrint "[K"
End Sub

'Print a binary number on Termminal
 Sub HSerPrintBin ( In BinNum )
   Repeat 8
     If BinNum.7 = 1 Then
     HSerPrint "1"
     Else
     HSerPrint "0"
     End If
     Rotate BinNum Left
   End Repeat
 End Sub

