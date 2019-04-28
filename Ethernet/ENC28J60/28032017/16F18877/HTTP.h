
sub ENC28j60_http


#define Synflag = 0
#define Finflag = 1


  Dim Tcp_fin As Bit
  Dim Tcp_syn As Bit
  Dim Tcp_rst As Bit
  Dim Tcp_psh As Bit
  Dim Tcp_ack As Bit
  Dim Tcp_urg As Bit
  Dim Tcpdatalen_in As Word
  Dim Tcpdatalen_out As Word
  Dim Expected_ack As Long
  Dim Flags As Byte
  Dim Client_seqnum As Long



   Dim Msg_temp2 As String * 10
'   dim Tempword3 As Word
   dim Tempstring1 As String * 1
   Dim Ackpsh As Byte

   Work = Tcp_flags   'in the TCP Buffer, see aliases
   Tcp_fin = Work.0
   Tcp_syn = Work.1
   Tcp_rst = Work.2
   Tcp_psh = Work.3
   Tcp_ack = Work.4
   Tcp_urg = Work.5

          #ifdef ShowHTTPFlags
          '   HserPrint "Handling HTTP"
             HSerPrintCRLF 2
             HSerPrint "Flags:"
              HSerPrint T_ip_srcaddr0
              HSerPrint ","
              HSerPrint T_ip_srcaddr1
              HSerPrint ","
              HSerPrint T_ip_srcaddr2
              HSerPrint ","
              HSerPrint T_ip_srcaddr3
              HSerPrintCRLF

             HserPrint "FIN "
             HSerSend 9
             HserPrint "SYN "
             HSerSend 9
             HserPrint  "RST "
             HSerSend 9
             HserPrint  "PSH "
             HSerSend 9
             HserPrint  "ACK "
             HSerSend 9
             HserPrint "TCP_URG "
             HSerPrintCRLF

              HserPrint Tcp_fin
              HSerSend 9

              HserPrint Tcp_syn
              HSerSend 9
              HserPrint Tcp_rst
              HSerSend 9

              HserPrint Tcp_psh
              HSerSend 9
              HserPrint Tcp_ack
              HSerSend 9
              HserPrint Tcp_urg
              HSerPrintCRLF
          #endif


HTTPPart1:
    ' This code segment processes the incoming SYN from the client
   ' and sends back the initial sequence number (ISN) and acknowledges
   ' the incoming SYN packet

   If Tcp_syn = 1 and Tcp_fin = 0 Then
HSerPrint "syn&!fin"
HSerPrintCRLF
        'IP Packet
        ENC28j60_set_response_IPpacket
'        T_ip_destaddr0 = T_ip_srcaddr0
'        T_ip_destaddr1 = T_ip_srcaddr1
'        T_ip_destaddr2 = T_ip_srcaddr2
'        T_ip_destaddr3 = T_ip_srcaddr3
'
'        'Set source IP in IP header, pos 27
'        T_ip_srcaddr0 = ipaddr(1)
'        T_ip_srcaddr1 = ipaddr(2)
'        T_ip_srcaddr2 = ipaddr(3)
'        T_ip_srcaddr3 = ipaddr(4)
'
'        ENC28j60_packetshape
'        ENC28j60_ip_header_checksum

        'TCP Packet
        Swap Tcp_srcportl , Tcp_destportl
        Swap Tcp_srcporth , Tcp_destporth

        Tcpdatalen_in = 1
        [byte]Client_seqnum_E = Tcp_seqnum3
        [byte]Client_seqnum_U = Tcp_seqnum2
        [byte]Client_seqnum_H = Tcp_seqnum1
        [byte]Client_seqnum   = Tcp_seqnum0

         Client_seqnum = Client_seqnum + Tcpdatalen_in

         Tcp_acknum0 = Client_seqnum
         Tcp_acknum1 = Client_seqnum_H
         Tcp_acknum2 = Client_seqnum_U
         Tcp_acknum3 = Client_seqnum_E

         Tcp_seqnum0 = 0xFF                                 'Initial sequencenumber
         Tcp_seqnum1 = 0xFF                                 '
         Tcp_seqnum2 = 0x10                                 '
         Tcp_seqnum3 = 0x11                                 '

         Flags.synflag = 1
         Tcp_flags = 0
         Tcp_flags.1 = 1
         Tcp_flags.4 = 1

         'window size - does means some frames will be lost.
         etherbuffer(49) = 0x20
         etherbuffer(50) = 0x00
         etherbuffer(60) = 0x01
         etherbuffer(61) = 0x01


         I_value16 = T_ip_vers_len And 0x0F
         I_value16 = I_value16 * 4

         tt = (( T_ip_pktlen0 * 256 )+ T_ip_pktlen1 ) + 14

         ENC28j60_Ip_header_checksum
         ENC28j60_tcp_checksum
         ENC28j60_writebuffer(tt)
         ENC28j60_packetsend(tt)
         Ackpsh = 0

   End If

HTTPPart2:

'   ' If an ACK and PSH is received and the destination port address is valid
   If Tcp_ack = 1 Then

        if Tcp_fin = 0 then

        'Swap IP addresses
        T_ip_destaddr0 = T_ip_srcaddr0
        T_ip_destaddr1 = T_ip_srcaddr1
        T_ip_destaddr2 = T_ip_srcaddr2
        T_ip_destaddr3 = T_ip_srcaddr3

        'Set source IP in IP header, pos 27
        T_ip_srcaddr0 = ipaddr(1)
        T_ip_srcaddr1 = ipaddr(2)
        T_ip_srcaddr2 = ipaddr(3)
        T_ip_srcaddr3 = ipaddr(4)

        Swap Tcp_srcportl , Tcp_destportl
        Swap Tcp_srcporth , Tcp_destporth

        'swap mac
        ENC28j60_Packetshape

        [byte]Incoming_ack_E = Tcp_seqnum3
        [byte]Incoming_ack_U = Tcp_seqnum2
        [byte]Incoming_ack_H = Tcp_seqnum1
        [byte]Incoming_ack   = Tcp_seqnum0


           Incoming_ack = Incoming_ack + ((( T_ip_pktlen0 * 256 )+ T_ip_pktlen1 )) - 40         '489 - 14

           Tcp_seqnum0 = Tcp_acknum0
           Tcp_seqnum1 = Tcp_acknum1
           Tcp_seqnum2 = Tcp_acknum2
           Tcp_seqnum3 = Tcp_acknum3

           Tcp_acknum0 = Incoming_ack
           Tcp_acknum1 = Incoming_ack_H
           Tcp_acknum2 = Incoming_ack_U
           Tcp_acknum3 = Incoming_ack_E

        end if

        If Tcp_psh = 1 Then
HSerPrint "ack&psh"
HSerPrintCRLF
'GET / HTTP/1.1

            #ifdef ENC28j60_ShowHTTPInfo_Supported
                HSerPrint T_ip_srcaddr0
                HSerPrint "."
                HSerPrint T_ip_srcaddr1
                HSerPrint "."
                HSerPrint T_ip_srcaddr2
                HSerPrint "."
                HSerPrint T_ip_srcaddr3
            #endif


'           'ACK and PSH
'
'           'set flags
           Tcp_flags = 0
           Tcp_flags.4 = 1                           'ack

'
''           'Move IP source address to destination address
''           T_ip_destaddr = T_ip_srcaddr
''           'Make ethernet module IP address source address
''           T_ip_srcaddr = My_ip
''           Swap Tcp_srcportl , Tcp_destportl
''           Swap Tcp_srcporth , Tcp_destporth

'        'Swap IP addresses
'
'        T_ip_destaddr0 = T_ip_srcaddr0
'        T_ip_destaddr1 = T_ip_srcaddr1
'        T_ip_destaddr2 = T_ip_srcaddr2
'        T_ip_destaddr3 = T_ip_srcaddr3
'
'        'Set source IP in IP header, pos 27
'        T_ip_srcaddr0 = ipaddr(1)
'        T_ip_srcaddr1 = ipaddr(2)
'        T_ip_srcaddr2 = ipaddr(3)
'        T_ip_srcaddr3 = ipaddr(4)
'
'        Swap Tcp_srcportl , Tcp_destportl
'        Swap Tcp_srcporth , Tcp_destporth
'
'''           'swap mac
'        ENC28j60_Packetshape
'
'
'        [byte]Incoming_ack_E = Tcp_seqnum3
'        [byte]Incoming_ack_U = Tcp_seqnum2
'        [byte]Incoming_ack_H = Tcp_seqnum1
'        [byte]Incoming_ack   = Tcp_seqnum0
'
'
'           Incoming_ack = Incoming_ack + ((( T_ip_pktlen0 * 256 )+ T_ip_pktlen1 )) - 40         '489 - 14
'
'           Tcp_seqnum0 = Tcp_acknum0
'           Tcp_seqnum1 = Tcp_acknum1
'           Tcp_seqnum2 = Tcp_acknum2
'           Tcp_seqnum3 = Tcp_acknum3
'
'           Tcp_acknum0 = Incoming_ack
'           Tcp_acknum1 = Incoming_ack_H
'           Tcp_acknum2 = Incoming_ack_U
'           Tcp_acknum3 = Incoming_ack_E

           #ifdef HTTP_HANDLER
              HTTPCommandLine
           #endif

           etherBuffer(17) = 0
           etherBuffer(18) = 40

'           '5 x 4 = 20 bytes
           etherBuffer(47) = 0x50
'           'flag ACK
           etherBuffer(48) = 0x10

         'window size - does means some frames will be lost.
         etherbuffer(49) = 0X20
         etherbuffer(50) = 0X00


'           'padding
           etherBuffer(55) = 0x00
           etherBuffer(56) = 0x00
           etherBuffer(57) = 0x00
           etherBuffer(58) = 0x00
           etherBuffer(59) = 0x00
           etherBuffer(60) = 0x00

           ENC28j60_ip_header_checksum
           ENC28j60_tcp_checksum

'         tt = (( T_ip_pktlen0 * 256 )+ T_ip_pktlen1 ) + 14

           T_ip_pktlen0 = 0
           T_ip_pktlen1 = 40
           ENC28j60_writebuffer(60)
           ENC28j60_packetsend(60)

           'Set variables for the next part of the HTTP handler - HTTP Part3
           Ackpsh = 1
           TableStartPoint = 1

        End If
    End If

    if Tcp_fin = 0  then
      HTTPPart3
    Else
      HTTPPart4
    end if


end sub

sub HTTPPart3

  If Tcp_ack = 1 Then
       If etherBuffer(17) = 0 Then
          If etherBuffer(18) = 40 Then
             If Ackpsh = 1 Then
              'ACK after a ACK-PSH
HSerPrint "ack&ackpush=1"
HSerPrintCRLF
                  ; Do not change this.
                  ; Start of mandated HTTP output
                  arrayloc = 0x0037   'start of HTTP header within the TCP Packet

                  #ifndef HTTP_HANDLER
                     HSerPrint "TableStartPoint = "
                     HSerPrint TableStartPoint
                     HSerPrintCRLF
                      if TableStartPoint = 1 then
                        'Set a variable to track whether we are part of a multiple package comms
                        'This needs to be before any call to the HTPPPrint routines
                        HTTPSentTCPPacket = 0
                        HTTPPrintStandardHeader ;print the header
                        HTTPPrint( "", HTTPPrintCRLF )
                      end if

                      eth_counter = 0
                      commandlineString = ""
                      For [word]TableLoc = TableStartPoint to SizeofTable1
                          eth_counter += 1

                          ReadTable ivalid351, TableLoc, commandlineString(eth_counter)
                          commandlineString(0) = eth_counter

                          eth_counter = eth_counter % 12

                          'add stuff here to handle run out of table data

                          ' Send the bytes in the commandlineString variable
                          if eth_counter = 0 then
                              HTTPPrint( commandlineString )
                              'has the buffer been sent? If the arrayloc does equal 0x0037 the it has!
                              'if so, exit sub as we have to process the ACK
                              if HTTPSentTCPPacket = 1 then
                                HSerPrint "exiting@1 "
                                TableStartPoint = TableLoc - 11
                                HTTPSentTCPPacket = 0
                                exit sub
                              end if
                              commandlineString = ""
                          end if
                      Next


'                      eth_counter = eth_counter - 2
                      'The buffer has not been emptied, string still has chars in it.
                      if eth_counter <> 0 then
                          'Get the last chars in the table
                          ReadTable ivalid351, TableLoc, commandlineString( eth_counter )
                          commandlineString(0) = eth_counter
                          HTTPPrint( commandlineString )
                          'has the buffer been sent? If the arrayloc does equal 0x0037 the it has!
                          'if so, exit sub as we have to process the ACK
                          if HTTPSentTCPPacket = 1 then
                            HSerPrint "exiting@2 "
                            TableStartPoint = TableLoc - 1
                            exit sub
                          end if
                      end if
                      HSerPrint "HTTPSend@3"
                      HTTPSend
                      commandlineString="index.htm"
                  #endif

                  #ifdef HTTP_HANDLER
                      HTTPPrintStandardHeader
                      HTTP_HANDLER
                  #endif

                 End If
              End If
           End If

  End If
end sub


sub HTTPPart4

'   ' If an ACK and FIN is received and the destination port address is valid
   If Tcp_ack = 1 Then
        If Tcp_fin = 1 Then
HSerPrint "ack&fin"
HSerPrintCRLF

'           'set flags
           Tcp_flags = 0
           Tcp_flags.4 = 1                           'ack

          'Swap IP addresses

          T_ip_destaddr0 = T_ip_srcaddr0
          T_ip_destaddr1 = T_ip_srcaddr1
          T_ip_destaddr2 = T_ip_srcaddr2
          T_ip_destaddr3 = T_ip_srcaddr3

          'Set source IP in IP header, pos 27
          T_ip_srcaddr0 = ipaddr(1)
          T_ip_srcaddr1 = ipaddr(2)
          T_ip_srcaddr2 = ipaddr(3)
          T_ip_srcaddr3 = ipaddr(4)

          Swap Tcp_srcportl , Tcp_destportl
          Swap Tcp_srcporth , Tcp_destporth

'           'swap mac
          ENC28j60_Packetshape

          [byte]Client_seqnum_E = Tcp_seqnum3
          [byte]Client_seqnum_U = Tcp_seqnum2
          [byte]Client_seqnum_H = Tcp_seqnum1
          [byte]Client_seqnum   = Tcp_seqnum0

          Tcp_seqnum0 = Tcp_acknum0
          Tcp_seqnum1 = Tcp_acknum1
          Tcp_seqnum2 = Tcp_acknum2
          Tcp_seqnum3 = Tcp_acknum3

          Client_seqnum = Client_seqnum + 1

          Tcp_acknum0 = Client_seqnum
          Tcp_acknum1 = Client_seqnum_H
          Tcp_acknum2 = Client_seqnum_U
          Tcp_acknum3 = Client_seqnum_E

           etherBuffer(17) = 0
           etherBuffer(18) = 40

'           '5 x 4 = 20 bytes
           etherBuffer(47) = 0x50
'           'flag ACK
           etherBuffer(48) = 0x10

'
           etherBuffer(49) = 0x00
           etherBuffer(50) = 0x72


'           'padding
           etherBuffer(55) = 0x00
           etherBuffer(56) = 0x00
           etherBuffer(57) = 0x00
           etherBuffer(58) = 0x00
           etherBuffer(59) = 0x00
           etherBuffer(60) = 0x00

           ENC28j60_ip_header_checksum
           ENC28j60_tcp_checksum

           T_ip_pktlen0 = 0
           T_ip_pktlen1 = 40
           ENC28j60_writebuffer(60)
           ENC28j60_packetsend(60)

        End If
    End If


end sub

Sub HTTPPrintStandardHeader

        HTTPPrint( "HTTP/1.0 200 OK", HTTPPrintCRLF )
'        HTTPPrint( "X-Pad: avoid browser bug", HTTPPrintCRLF )
'bad        HTTPPrint( "Cache-Control: no-cache, no-store, must-revalidate", HTTPPrintCRLF )
'        HTTPPrint( "Pragma: no-cache", HTTPPrintCRLF )
'        HTTPPrint( "Content-Type: text/html", HTTPPrintCRLF )
'         HTTPPrint( "<!DOCTYPE HTML>", HTTPPrintCRLF )

End Sub


Sub HTTPPrint( HTTPData As String, optional in HTTPPrintCRLFflag = 0  )
'HSerPrint HTTPData
'HSerPrintCRLF

    dim hulp2 as word
    hulp2 = arrayloc + HTTPData(0) + 6

    'is buffer full
    If hulp2 > etherBufferSize Then
        'send the buffer!!
        HSerPrintCRLF
        HSerPrint "empty the buffer"
        HSerPrintCRLF
        HTTPSend ( false )
        ' RESET buffer
        arrayloc = 0x0037   'start of HTTP header within the TCP Packet
        HTTPSentTCPPacket = 1
    End IF
    'Copy data to buffer
    For currbyte = 1 to HTTPData(0)
        etherBuffer(arrayloc) = HTTPData(currbyte)
        arrayloc += 1
    Next
    if HTTPPrintCRLFflag = 1 then
      etherBuffer(arrayloc) = 0x0d: arrayloc += 1
      etherBuffer(arrayloc) = 0x0a: arrayloc += 1
    end if
End Sub



Sub HTTPSend ( optional in HTTPCloseTransaction = true )

'HSerPrintCRLF
'HSerPrint "HTTPSend = "
'HSerPrintCRLF HTTPCloseTransaction

    ;set flags
    Tcp_flags = 0
    Tcp_flags.4  = 1                          'ack

    if HTTPCloseTransaction = true then
      Tcp_flags.3  = 1                          'psh
      Tcp_flags.0  = 1                          'fin
      ; Do not change this.
      ; Start of mandated HTTP output
      etherBuffer(arrayloc) = 0x0d: arrayloc = arrayloc +1
      etherBuffer(arrayloc) = 0x0a: arrayloc = arrayloc +1
      etherBuffer(arrayloc) = 0x0d: arrayloc = arrayloc +1
      etherBuffer(arrayloc) = 0x0a: arrayloc = arrayloc +1

      'Adjust buffer to trim the last char as this has been indexed +1, this normalising the string length
      arrayloc = arrayloc - 1

      if arrayloc Mod 2 = 0 then
        HSerPrint "  PAD! "
        arrayloc += 1
        etherBuffer(arrayloc) = 0x00 'added to pad out, should the
      end if
      ; Do not change this.
      ; End of mandated HTTP output
      Ackpsh = 0
'
'HSerPrintCRLF
'FOR hulp2 = 0X0037 TO arrayloc
'HSerSend etherbuffer(HULP2)
'Next
'HSerPrintCRLF


    Else
      arrayloc = arrayloc - 1
      Tcp_flags.3  = 0                          'psh
      Tcp_flags.0  = 0
    end if

             HSerPrintCRLF
             HSerPrint "Send:"
              HSerPrint T_ip_srcaddr0
              HSerPrint ","
              HSerPrint T_ip_srcaddr1
              HSerPrint ","
              HSerPrint T_ip_srcaddr2
              HSerPrint ","
              HSerPrint T_ip_srcaddr3
              HSerPrintCRLF

    Tcp_acknum0 = Incoming_ack
    Tcp_acknum1 = Incoming_ack_H
    Tcp_acknum2 = Incoming_ack_U
    Tcp_acknum3 = Incoming_ack_E


    ;Calculate packet size etc and display
    TCPresult16 = [word]arrayloc - [byte]IP_HeaderSize

    #ifdef ENC28j60_ShowHTTPInfo_Supported
        HSerSend 9
        HSerPrint "B/Wire:"
        HSerPrint ( TCPresult16 + [byte]IP_HeaderSize )

        HSerPrint ", TCP Pkt:"
        HSerPrint ( TCPresult16 - 40 )

        HSerPrint ", HTML:"
        HSerPrint ( TCPresult16 - 88 )
        HSerPrintCRLF
    #endif

    T_ip_pktlen0 = TCPresult16_H                             'HTML-code + 40
    T_ip_pktlen1 = TCPresult16

    ENC28j60_ip_header_checksum

    ENC28j60_tcp_checksum

    ENC28j60_writebuffer( TCPresult16 + IP_HeaderSize   )
    ENC28j60_packetsend( TCPresult16 + IP_HeaderSize   )

End Sub

Sub HTTPCommandLine
    dim CommandLineString as string * 12
        ' walk through the packet until GET / is found
    dim zzz, TableLoc as word

    TableLoc = 1
    For zz = 1 to 2
        For TableLoc = 40 To 120
           GetString ( TableLoc )
           if zz = 1 then
               If Left(CommandLineString,5) = "GET /" Then
'                  HSerPrintCRLF
'                  HSerPrint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
'                  HSerPrintCRLF
'                  HSerPrint commandlineString
'                  HSerPrintCRLF
'                  HSerPrint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
'                  HSerPrintCRLF

                  lastGet = 1
                  TableLoc += 5
                  GetString ( TableLoc )
'                          HSerPrintCRLF
'                          HSerPrint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
'                          HSerPrintCRLF
'                          HSerPrint commandlineString
'                          HSerPrintCRLF
'                          HSerPrint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
'                          HSerPrintCRLF
                   If Left(CommandLineString , 6) = " HTTP/" Then
                      CommandLineString = "index.htm"
                      Exit sub
                   End if


                   Exit For  'no longer look for GET / as we have found it.

               End IF
           Else
              if lastGet = 1 then
'                HSerPrint "!!"
'                HSerPrintCRLF
                'scan for a space
                zzz = instr( CommandLineString , " " )
                CommandLineString = left( CommandLineString, zzz - 1 )
                'commandlineString is done
              end if
              exit sub
           End if

        Next

    Next
    CommandLineString = "400"
End Sub

sub GetString ( in EtherBufferIndex as word )
           CommandLineString(0)=12
           CommandLineString(1) = EtherBuffer(EtherBufferIndex)
           CommandLineString(2) = EtherBuffer(EtherBufferIndex+1)
           CommandLineString(3) = EtherBuffer(EtherBufferIndex+2)
           CommandLineString(4) = EtherBuffer(EtherBufferIndex+3)
           CommandLineString(5) = EtherBuffer(EtherBufferIndex+4)
           CommandLineString(6) = EtherBuffer(EtherBufferIndex+5)
           CommandLineString(7) = EtherBuffer(EtherBufferIndex+6)
           CommandLineString(8) = EtherBuffer(EtherBufferIndex+7)
           CommandLineString(9) = EtherBuffer(EtherBufferIndex+8)
           CommandLineString(10) = EtherBuffer(EtherBufferIndex+9)
           CommandLineString(11) = EtherBuffer(EtherBufferIndex+10)
           CommandLineString(12) = EtherBuffer(EtherBufferIndex+11)

'HSerPrint "*"
'HSerPrint commandlineString
'HSerSend 9
'for ttttt = 1 to 12
'  AA = commandlineString( ttttt )
'  IF AA > 31 Then
'    HSerPrint AA
'  Else
'    HSerPrint HEX(AA )
'  END IF
'  HSerPrint ","
'next
'HSerPrint "*"
'HSerPrintCRLF

end sub
