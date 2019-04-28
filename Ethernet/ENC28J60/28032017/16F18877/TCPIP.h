'TCP


Sub ENC28j60_arpreply
   'The original request packet is in the buffer, we just change some things

   'Swap MAC addresses
   ENC28j60_set_response_macaddress

   'Copy target MAC in ARP packet - starting at pos 33, copy from pos 1
'   For II = 1 To 6
'      etherBuffer(32 + II) = etherBuffer(II)
'   Next

  T_arp_dest_enetpacket0 = T_enetpacketdest0
  T_arp_dest_enetpacket1 = T_enetpacketdest1
  T_arp_dest_enetpacket2 = T_enetpacketdest2
  T_arp_dest_enetpacket3 = T_enetpacketdest3
  T_arp_dest_enetpacket4 = T_enetpacketdest4
  T_arp_dest_enetpacket5 = T_enetpacketdest5

   'Set target IP in ARP packet - starting at pos 39, original starting at pos 29
'   For II = 1 To 4
'      etherBuffer(38 + II) = etherBuffer(28 + II)
'   Next

  T_arp_tipaddr0 = T_arp_sipaddr0
  T_arp_tipaddr1 = T_arp_sipaddr1
  T_arp_tipaddr2 = T_arp_sipaddr2
  T_arp_tipaddr3 = T_arp_sipaddr3

   'Copy source MAC to ARP packet pos 23 from pos 7
'   For II = 1 To 6
'      etherBuffer(22 + II) = etherBuffer(6 + II)
'   Next
   T_arp_src_enetpacket0 = T_enetpacketsrc0
   T_arp_src_enetpacket1 = T_enetpacketsrc1
   T_arp_src_enetpacket2 = T_enetpacketsrc2
   T_arp_src_enetpacket3 = T_enetpacketsrc3
   T_arp_src_enetpacket4 = T_enetpacketsrc4
   T_arp_src_enetpacket5 = T_enetpacketsrc5




   'Set source IP to ARP packet pos 29
   T_arp_sipaddr0 = ipaddr(1)
   T_arp_sipaddr1 = ipaddr(2)
   T_arp_sipaddr2 = ipaddr(3)
   T_arp_sipaddr3 = ipaddr(4)

   'Set ARP type from Request to Reply
   etherBuffer(22) = 2

   ' as 60 is the true length of ARP packet
   ENC28j60_writebuffer( 42 )
   'Send the reply packet
   ENC28j60_packetsend(42)

End Sub

'''Private - optimed code
sub ENC28j60_calc_ippartial_checksum
       I_chksum32 = 0

       I_value16_h = T_ip_srcaddr0
       [byte]I_value16 = T_ip_srcaddr1
       I_chksum32 = I_value16 + I_chksum32

       I_value16_h = T_ip_srcaddr2
       [byte]I_value16 = T_ip_srcaddr3
       I_chksum32 = I_value16 + I_chksum32

       I_value16_h = T_ip_destaddr0
       [byte]I_value16 = T_ip_destaddr1
       I_chksum32 = I_value16 + I_chksum32

       I_value16_h = T_ip_destaddr2
       [byte]I_value16 = T_ip_destaddr3
       I_chksum32 = I_value16 + I_chksum32

       I_chksum32 = I_chksum32 + T_ip_proto
End sub

Sub ENC28j60_calcchecksum( in startptr As Word , in Endptr As Word , in Result As Word)
    Dim II As Word
    Dim LocalTmp As Word
    Dim Sum As Long
    Sum = 0
    LocalTmp = 0

    I_odd = (Endptr - startptr ) Mod 2
    if I_odd = 1 then HSerPrint "!"

    For II = Startptr To Endptr Step 2
        Sum = Sum + etherBuffer(II + 1)
        LocalTmp_h  = etherBuffer(II)
        Sum = Sum + LocalTmp
    Next I
    II = FnLsr( sum, 16 )
    LocalTmp  = [word]Sum
    LocalTmp  = LocalTmp  + II
    LocalTmp  = Not LocalTmp
    etherBuffer(result) = LocalTmp_h
    etherBuffer(result + 1) = [byte]LocalTmp
End Sub

' Overall routine for checksum
Sub ENC28j60_general_checksum( in Val1 As Byte , in Val2 As Word)
    dim I_x as word
    dim I_chksum32 as long

    X_odd = (Val2 - Val1 ) Mod 2
    'todo erv
'    if X_odd = 1 then HSerPrint "$"

    I_chksum32 = 0
    For I_x = Val1 To Val2 Step 2
        I_value16 = FnLsl( etherbuffer(i_x), 8 )
        Hulp3 = I_x + 1
        I_value16 = I_value16 + etherBuffer(hulp3)
        I_chksum32 = I_chksum32 + I_value16
    Next I_x

    If I_odd = 1 Then
        Val2 = Val2 + 3
        I_value16 = FnLsl( etherbuffer(val2), 8 )
        I_chksum32 = I_chksum32 + I_value16
    End If

    I_checksum16 = Fnlsr(i_chksum32, 16)

    I_checksum16 = I_checksum16 + I_chksum32 ' only 16 lower bits of i_chksum32 is taken...

    I_checksum16 = Not I_checksum16

    Val3 = i_checksum16_h
    Val4 = i_checksum16

End Sub

Sub ENC28j60_ip_header_checksum
    Dim Ip_x As Byte
    Dim Ip_hulp1 As Byte
    Dim Ip_chksum32 As Long
    Dim Ip_checksum16 As Word
    Dim Ip_temp16 As Word
    Dim Ip_header_length As Byte
    Dim Val2 as word
    'calculate the IP header checksum

    I_chksum32 = 0
    Ip_header_length = T_ip_vers_len And 0x0F

'    Ip_header_length = 4 * Ip_header_length

    ' used to remove mutlipy routines
    repeat 2
      set C off
      rotate Ip_header_length left
    end repeat

    I_chksum32 = 0
    I_odd = 0

    Val1 = 15
    Val2 = 0x0E + Ip_header_length - 1
    T_ip_hdr_cksum0 = 0
    T_ip_hdr_cksum1 = 0
    ENC28j60_General_checksum(val1 , Val2)
    T_ip_hdr_cksum0 = Val3
    T_ip_hdr_cksum1 = Val4

End Sub


Sub ENC28j60_packetreceive( in maxlen As Word )
    Dim eth_counter, eth_frameLength As Word
    Dim previous_nextpacketptr as word

    'Check if this was an errata error. Exit.
    ENC28j60_temp = ENC28j60_ReadReg (eir) and EIR_PKTIF
    If ENC28j60_temp <> EIR_PKTIF Then
'        #ifdef ENC28j60_Hserial_Supported
'todo erv
'            HSerPrint "No packet"
'            reset
'        #endif
        'decrement the packet counter indicate we are done with this packet
'        ENC28j60_bitSet( ECON2, ECON2_PKTDEC )
        goto Reset_ENC26j60
        Exit Sub
    End If

    #ifdef ENC28j60_packetCounting_Supported
        packetCounterIn++
    #endif

    ENC28j60_data = ENC28j60_ReadReg( erevid )

    'Debug
    'Pointers are not always updated (seems to depend on the size of
    'the received packet)
    'Workaround : write and verify until it is done
     eth_counter = 1
     do
'        HSerPrint "2"
        ENC28j60_writeReg(ERDPTL, [byte]nextpacketptr )
        ENC28j60_writeReg(ERDPTH, nextpacketptr_h )

        eth_counter++
        if eth_counter = 0 then
          'todo erv
'          HSerPrint "#1ERDPTL and ERDPTH error"
'          HSerPrintCRLF
          exit do
        end if

    'Verify */
     loop while (ENC28j60_ReadReg(ERDPTL) <>  [byte]nextpacketptr) or (ENC28j60_ReadReg(ERDPTH) <> nextpacketptr_h )
    'Packet is finished

'    HSerPrint "4"
   'read the next packet pointer(s)
      ENC28j60_readbuffer(6)
'    HSerPrint "5"
    'Set next packet
      nextpacketptr = etherbuffer(1)
      nextpacketptr_h = etherbuffer(2)

    'read the packet length
      eth_frameLength = etherbuffer(3)
      eth_frameLength_h = etherbuffer(4)

    'read the receive status
      RxStat = etherbuffer(5)
      RxStat_h = etherbuffer(6)

  #ifdef debug
      HSerPrint " Rx:"
      HSerPrint ByteToBin(eth_counter_h)
      HSerPrint ByteToBin(eth_counter)
      HSersend 9
  #endif

    'copy the packet from the receive buffer
'     if ( etherbuffer(5) AND 0x80 ) = 0x80 then
        ENC28j60_readbuffer(eth_frameLength)
'     end if
'    HSerPrint "6"

endpacket:
    'Pointers are not always updated (seems to depend on the size of
    'the received packet)
    'Workaround : write and verify until it is done
    'write the memory read pointer
    eth_counter = 1
    do
        ENC28j60_writeReg(ERDPTL, [byte]nextpacketptr )
        ENC28j60_writeReg(ERDPTH, nextpacketptr_h )
    '          wait 5 ms

        eth_counter++
        if eth_counter = 0 then
          #ifdef ENC28j60_BufferErrorMessages_Supported
              HSerSend 7
              HSerPrint "#2ERDPTL and ERDPTH error"
              HSerPrintCRLF
              ENC28j60_regdump
          #endif
          exit do
        end if

    loop while (ENC28j60_ReadReg(ERDPTL) <>  [byte]nextpacketptr) or (ENC28j60_ReadReg(ERDPTH) <> nextpacketptr_h )
'    'Packet is finished
'HSerPrint eth_counter
'HSerPrintCRLF
      IF ( nextpacketptr and 1 ) = 0 THEN
          eth_counter = nextpacketptr -1
      END IF
      ENC28j60_writeReg(ERXRDPTL, [byte]eth_counter )
      ENC28j60_writeReg(ERXRDPTH, [byte]eth_counter_h )

    'decrement the packet counter indicate we are done with this packet
      ENC28j60_bitSet( ECON2, ECON2_PKTDEC )

    #ifdef ReceivePacketDebug_Supported

      HSerPrint leftpad(str(T_ip_srcaddr0),3,"0")
      HSerPrint ","
      HSerPrint leftpad(str(T_ip_srcaddr1),3,"0")
      HSerPrint ","
      HSerPrint leftpad(str(T_ip_srcaddr2),3,"0")
      HSerPrint ","
      HSerPrint leftpad(str(T_ip_srcaddr3),3,"0")
      HSerPrint ": "

      HSerPrint leftpad(str(T_ip_destaddr0),3,"0")
      HSerPrint ","
      HSerPrint leftpad(str(T_ip_destaddr1),3,"0")
      HSerPrint ","
      HSerPrint leftpad(str(T_ip_destaddr2),3,"0")
      HSerPrint ","
      HSerPrint leftpad(str(T_ip_destaddr3),3,"0")

      HSerSend 9
      HSerPrint "Arp/Frg:"
      HSerPrint etherBuffer(21)
      HSerSend 9
      HSerPrint "Type:"
      HSerPrint leftpad(str(etherBuffer(14)),3,"0")
      HSerSend 9
      HSerPrint "proto:"
      HSerPrint hex(etherBuffer(24))
      HSerSend 9
      HSerPrint hex(etherBuffer(15))
      HSerSend 9
      HSerPrint "port:"
      HSerPrint hex(Tcp_destporth)
      HSerPrint hex(Tcp_destportl)
      HSerPrintCRLF

    #endif



    'Handle the packet
    If etherBuffer(13) = 0X08 Then                               'TYPE: IP
      If etherBuffer(14) = 0X06 Then                             'Type:ARP
         If etherBuffer(21) = 0X00 Then                          'ARP request
            If etherBuffer(22) = 0X01 Then                       'ARP request
              If etherBuffer(39) = ipaddr(1) Then                  'ARP for us
                If etherBuffer(40) = ipaddr(2) Then
                   If etherBuffer(41) = ipaddr(3) Then
                      If etherBuffer(42) = ipaddr(4) Then
                          ENC28j60_Arpreply
                      End If
                   End If
                End If
              End If
            End If
         End If
      End If

      If etherBuffer(14) = 0X00 Then                             'Type:IP
         If etherBuffer(15) = 0X45 Then                          'We handle only simple IP packets
            If etherBuffer(21) = 0 or etherBuffer(21) = 0x40 Then                          'We handle only non fragmented packets
              If etherBuffer(31) = ipaddr(1) Then                  'Ip packet for us
                If etherBuffer(32) = ipaddr(2) Then
                   If etherBuffer(33) = ipaddr(3) Then
                      If etherBuffer(34) = ipaddr(4) Then
                        If etherBuffer(24) = 1 Then              'Protocol:ICMP
                          #ifdef ENC28j60_ping_Supported
                           If etherBuffer(35) = 0X08 Then        'ICMP echo request
                           PORTA.0 = 1
                                ENC28j60_Pingreply
                           PORTA.0 = 0
                           End If
                          #endif
                        End If
                        #ifdef ENC28j60_UDP_Supported
                            If etherBuffer(24) = 17 Then             'Protocol:UDP

                                T_udp_destport = ( T_udp_destport0 * 256 ) + T_udp_destport1

                                'Can be handled by users
                                ENC28j60_Udp_Handler
                                #ifdef ENC28j60_sntp_Supported

                                    select case T_udp_srcport1
                                        case 0x25
                                            '0x0025 SNTP protocol
                                            ENC28j60_sntp_handler
                                            Exit Sub

                                    end select
                                #endif

                                #ifdef ENC28j60_Echo7_Supported
                                    if T_udp_destport = 7 then

                                      'echo on PORT 7
                                      'Build The IP Header
                                      ENC28j60_Setipaddrs
                                      'swap the UDP source and destinations port
                                      Swap T_udp_srcport0 , T_udp_destport0
                                      Swap T_udp_srcport1 , T_udp_destport1
                                      'add the checksum
                                      ENC28j60_Udp_checksum
                                      'Calculate packetlength
                                      Hulp2 = T_udp_len0 * 256
                                      Hulp2 = Hulp2 + T_udp_len1
                                      Hulp2 = Hulp2 + 34
                                      ENC28j60_writebuffer( hulp2 )
                                      ENC28j60_packetsend( hulp2 )

                                    end if
                                #endif

                            End If
                        #endif
                        If etherBuffer(24) = 6 Then              'Protocol:TCP

                           If Tcp_destporth = 0 Then
                              #ifdef ENC28j60_tcp_supported

                                   Select Case Tcp_destportl
                                          #ifdef ENC28j60_http_supported

                                            Case 80 :
                                                #ifdef ShowTCPHeader
                                                    HSerPrintCRLF
                                                    'Create a vertical column of numbers
                                                    for DeviceID = 0 to 47
                                                      DisplayNewLine = DeviceID % 16
                                                      if DisplayNewLine = 0 Then
                                                        HSerPrintCRLF
                                                        HserPrint hex(DeviceID)
                                                        if DisplayNewLine > 0 then
                                                          HSerPrint " "
                                                        end if
                                                      end if
                                                      HSerPrint " "
                                                      HSerPrint   hex( etherbuffer( DeviceID + 1 ) )
                                                    next

                                                    HSerPrintCRLF
                                                #endif

                                                #ifdef ShowHTTPHeader_Supported                                                                                                    HSerPrintCRLF
                                                    if Tcp_flags.5 = 1 then
                                                        HSerPrint "U"
                                                    else
                                                        HSerPrint " "
                                                    end if
                                                    if Tcp_flags.4 = 1 then
                                                        HSerPrint "A"
                                                    else
                                                        HSerPrint " "
                                                    end if
                                                    if Tcp_flags.3 = 1 then
                                                        HSerPrint "P"
                                                    else
                                                        HSerPrint " "
                                                    end if
                                                    if Tcp_flags.2 = 1 then
                                                        HSerPrint "R"
                                                    else
                                                        HSerPrint " "
                                                    end if
                                                    if Tcp_flags.1 = 1 then
                                                        HSerPrint "S"
                                                    else
                                                        HSerPrint " "
                                                    end if
                                                    if Tcp_flags.0 = 1 then
                                                        HSerPrint "F"
                                                    else
                                                        HSerPrint " "
                                                    end if

                                                    HSerPrintCRLF
                                                    'Create a vertical column of numbers
                                                    for DeviceID = 32 to 79
                                                      DisplayNewLine = DeviceID % 16
                                                      if DisplayNewLine = 0 Then
                                                        HSerPrintCRLF
                                                        HserPrint hex(DeviceID)
                                                      end if
                                                      HSerSend etherbuffer( DeviceID + 1 )
                                                    next
                                                    HSerPrintCRLF
                                                #endif


                                            ENC28j60_http

                                          #endif

                                          #ifdef ENC28j60_telnet_supported

                                            Case 23 : ENC28j60_telnet

                                          #endif

                                   End Select

                              #endif
                           End If

                        End If
                      End If
                   End If
                End If
              End If
            End If
         End If
      End If
    End If

End Sub

Sub ENC28j60_packetsend( in pcktlen As Word )

  ENC28j60_bitSet( ECON1 , econ1_txrst )
  ENC28j60_bitClear( ECON1 , econ1_txrst )
  ENC28j60_bitClear( EIR , EIR_TXERIF )

  wait while ( (ENC28j60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )

  'set the TXND pointer to correspond to the packet size given
'  ENC28j60_writeReg(etxndl , (ENC_TXBUF_STL + pcktlen ) & 0xFF )
'  ENC28j60_writeReg(etxndh , ENC_TXBUF_STH + pcktlen_h )

'todo erv
hulp2 =  ENC_TXBUF_ST + pcktlen
'HSerPrint hex(hulp2_h)
'HSerPrint hex(hulp2)
'HSerPrintCRLF
ENC28j60_writeReg(etxndl , hulp2 & 0xFF )
ENC28j60_writeReg(etxndh , hulp2_h )

  ENC28j60_bitSet( EIR , EIR_TXIF )
  ENC28j60_bitClear( EIE , EIE_TXIE )

  'send the contents of the transmit buffer onto the network
  ENC28j60_bitSet( ECON1 , econ1_txrts )

  wait while ( (ENC28j60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )

  #ifdef ENC28j60_packetCounting_Supported
      packetCounterOut++
  #endif

End Sub


Sub ENC28j60_packetshape
   'move hardware source address to destination address
   T_enetpacketdest0 = T_enetpacketsrc0
   T_enetpacketdest1 = T_enetpacketsrc1
   T_enetpacketdest2 = T_enetpacketsrc2
   T_enetpacketdest3 = T_enetpacketsrc3
   T_enetpacketdest4 = T_enetpacketsrc4
   T_enetpacketdest5 = T_enetpacketsrc5
   ' 'Make ethernet module mac address the source address
   T_enetpacketsrc0 = macaddr(1)
   T_enetpacketsrc1 = macaddr(2)
   T_enetpacketsrc2 = macaddr(3)
   T_enetpacketsrc3 = macaddr(4)
   T_enetpacketsrc4 = macaddr(5)
   T_enetpacketsrc5 = macaddr(6)
End Sub

Sub ENC28j60_pingreply
   'The original request packet is in the buffer, we just change some things
   Dim Packetlength As Word



   'Set IP ID field as part of the protocol
    T_id0 = ip_id_h
    T_id1 = [byte]ip_id
    Ip_id = Ip_id + 1

    ENC28j60_set_response_IPpacket
'   'Swap IP addresses
'   T_ip_destaddr0 = T_ip_srcaddr0
'   T_ip_destaddr1 = T_ip_srcaddr1
'   T_ip_destaddr2 = T_ip_srcaddr2
'   T_ip_destaddr3 = T_ip_srcaddr3
'
'   'Set source IP in IP header, pos 27
'    T_ip_srcaddr0 = ipaddr(1)
'    T_ip_srcaddr1 = ipaddr(2)
'    T_ip_srcaddr2 = ipaddr(3)
'    T_ip_srcaddr3 = ipaddr(4)
'   'Swap MAC addresses
'   ENC28j60_set_response_macaddress

   'Zero out original IP checksum fields
   T_ip_hdr_cksum0 = 0
   T_ip_hdr_cksum1 = 0
   'Calc new IP checksum
   ENC28j60_Calcchecksum( T_ip_header_pointer0 , T_ip_header_pointer1 , T_ip_hdr_cksum0_pointer )

   'Set ICMP type to Echo reply
   T_icmp_type = 0
   'Zero out original ICPM checksum fields
   T_icmp_cksum0 = 0
   T_icmp_cksum1 = 0
   'Calc new ICPM checksum, length calculated from IP packet length


   Packetlength_h = etherBuffer(17)
   [byte]Packetlength = etherBuffer(18)

'   Packetlength = etherBuffer(17) * 256
'   Packetlength = Packetlength + etherBuffer(18)
   Packetlength = Packetlength + 13                         'We are going to calculate the checksum till the end of packet (IP length + 14 byte of the ethernet stuff), -1 to get word start
   ENC28j60_Calcchecksum(35 , Packetlength , 37)

   'Setting packetlength to the correct value
   Packetlength = Packetlength + 1

   ENC28j60_writebuffer( packetlength )
   'Send the reply packet
   ENC28j60_packetsend(packetlength)

End Sub

Sub ENC28j60_poll


      if ENC28j60_ReadReg( epktcnt ) > 0 Then
          ENC28j60_packetreceive( etherBufferSize )
      end if

      'buffer - packet received greater than the incoming buffer.
      'Recover the error and move on!
      if ENC28j60_ReadReg( EIR ) & EIR_RXERIF = EIR_RXERIF Then

          ENC28j60_bitClear( EIR, EIR_RXERIF )

      end if

End Sub


Sub ENC28j60_set_response_IPpacket

   T_ip_destaddr0 = T_ip_srcaddr0
   T_ip_destaddr1 = T_ip_srcaddr1
   T_ip_destaddr2 = T_ip_srcaddr2
   T_ip_destaddr3 = T_ip_srcaddr3

   'make ethernet module IP address source address
   T_ip_srcaddr0 = ipaddr(1)
   T_ip_srcaddr1 = ipaddr(2)
   T_ip_srcaddr2 = ipaddr(3)
   T_ip_srcaddr3 = ipaddr(4)

   ENC28j60_set_response_macaddress
   ENC28j60_Ip_header_checksum

End sub

Sub ENC28j60_set_response_macaddress

   'Set target MAC in ethernet frame - starting at pos 1, original starting at pos 7
   For II = 1 To 6
      etherBuffer(II)= etherBuffer(6 + II)
   Next
   'Set source MAC in ethernet frame, pos 7
   etherBuffer(7) = macaddr(1)
   etherBuffer(8) = macaddr(2)
   etherBuffer(9) = macaddr(3)
   etherBuffer(10) = macaddr(4)
   etherBuffer(11) = macaddr(5)
   etherBuffer(12) = macaddr(6)
End Sub



' Routine to get the NetWork Time from a time-server
'
Sub ENC28j60_sntp_get
    'MAC-header
    'Destination hardware address            '
    'Local router-mac-address here
    T_enetpacketdest0 = macaddrrouter(1)
    T_enetpacketdest1 = macaddrrouter(2)
    T_enetpacketdest2 = macaddrrouter(3)
    T_enetpacketdest3 = macaddrrouter(4)
    T_enetpacketdest4 = macaddrrouter(5)
    T_enetpacketdest5 = macaddrrouter(6)
    ' source (this source mac address)
    T_enetpacketsrc0 = macaddr(1)
    T_enetpacketsrc1 = macaddr(2)
    T_enetpacketsrc2 = macaddr(3)
    T_enetpacketsrc3 = macaddr(4)
    T_enetpacketsrc4 = macaddr(5)
    T_enetpacketsrc5 = macaddr(6)
    T_enetpackettype0 = 0X08
    T_enetpackettype1 = 0X00                              ' = 0X0800
    ' fill IP-header
    T_ip_vers_len = 0X45
    T_tos = 0X00
    T_ip_pktlen0 = 0X00
    T_ip_pktlen1 = 0X30
    T_id0 = 0X4A
    T_id1 = 0XA5
    T_flags = 0X00
    T_offset = 0X00
    T_ttl = 0X80
    'protocol (ICMP=1, TCP=6, UDP=0x11)
    T_ip_proto = 0X11
    'header checksum
    'IP address of source
    T_ip_srcaddr0 = ipaddr(1)
    T_ip_srcaddr1 = ipaddr(2)
    T_ip_srcaddr2 = ipaddr(3)
    T_ip_srcaddr3 = ipaddr(4)
    'IP address of destination                                      'you have to put the IP-number of
    T_ip_destaddr0 = sntpserveraddr(1)                               'the NTP-server here
    T_ip_destaddr1 = sntpserveraddr(2)
    T_ip_destaddr2 = sntpserveraddr(3)
    T_ip_destaddr3 = sntpserveraddr(4)
    'UDP-header
    T_udp_srcport0 = 0X13
    T_udp_srcport1 = 0X88
    T_udp_destport0 = 0X00                                        'port 0025 = 37 SNTP
    T_udp_destport1 = 0X25
    T_udp_len0 = 0X00
    T_udp_len1 = 0X1C
    T_udp_data0 = 0X58 'Asc( "X")
    T_udp_data1 = 0X0A ' lf
    T_udp_data2 = 0X0D ' cr
    T_udp_data4 = 0
    T_udp_data5 = 0
    T_udp_data6 = 0
    T_udp_data7 = 0
    T_udp_data8 = 0
    T_udp_data9 = 0
    T_udp_data10 = 0
    T_udp_data11 = 0
    T_udp_data12 = 0
    T_udp_data13 = 0
    T_udp_data14 = 0
    T_udp_data15 = 0
    T_udp_data16 = 0
    T_udp_data17 = 0
    T_udp_data18 = 0
    T_udp_data19 = 0
    T_udp_data20 = 0
    T_udp_data21 = 0
    T_udp_data22 = 0
    T_udp_data23 = 0
    T_udp_data24 = 0
    T_udp_data25 = 0
    T_udp_data26 = 0
    T_udp_data27 = 0

    ENC28j60_Ip_header_checksum
    ENC28j60_Udp_checksum

    'Packetlength
    Hulp2 = T_udp_len0 * 256
    Hulp2 = Hulp2 + T_udp_len1
    Hulp2 = Hulp2 + 34

    ENC28j60_writebuffer( 45 )
    ENC28j60_packetsend( hulp2 )
HSerPrint "*"
End Sub

' Routine to convert the LONG from the NTP-server in to date and time
'
Sub ENC28j60_sntp_handler
    dim Epoch_seconds as long
    DIM L2 AS long

    Epoch_seconds = T_udp_data3
    Epoch_seconds_H = T_udp_data2
    Epoch_seconds_U = T_udp_data1
    Epoch_seconds_E   = T_udp_data0
    Epoch_seconds = Epoch_seconds - [Long]3660595200  'ADJUSTS TO 1/1/2016
    #ifdef ENC28j60_sntp_Remote_Supported

      ENC28j60_UTC_Adjust ( Epoch_seconds )

    #endif


    HserPrint "Date "
    l2 = ( Epoch_seconds / 86400 ) + 1
    HSerPrint l2

    'WORKS ... isleap( Epoch_seconds / 31536000 )

    l2 = Epoch_seconds / 31536000  ' CALC year
    l2 = l2 + 2016
    HSerPrint "D/"
    HSerPrint l2
    HSerPrintCRLF


    HserPrint "Time "
    l2 = Epoch_seconds % 86400
    l2 = l2 / 3600
    if l2 < 10 then HSerPrint "0"
    HSerPrint l2
    HSerPrint ":"
    l2 = Epoch_seconds % 3600
    l2 = l2 / 60
    if l2 < 10 then HSerPrint "0"
    HSerPrint l2
    l2 = Epoch_seconds % [LONG]60
    HSerPrint ":"
    if l2 < 10 then HSerPrint "0"
    HSerPrint l2
    HSerPrintCRLF


End Sub




Sub ENC28j60_setipaddrs
   T_ip_destaddr0 = T_ip_srcaddr0
   T_ip_destaddr1 = T_ip_srcaddr1
   T_ip_destaddr2 = T_ip_srcaddr2
   T_ip_destaddr3 = T_ip_srcaddr3

   'make ethernet module IP address source address
   T_ip_srcaddr0 = ipaddr(1)
   T_ip_srcaddr1 = ipaddr(2)
   T_ip_srcaddr2 = ipaddr(3)
   T_ip_srcaddr3 = ipaddr(4)

   ENC28j60_set_response_macaddress
   ENC28j60_Ip_header_checksum

End Sub

sub ENC28j60_tcp_checksum

'   Dim Whulp1 As Word
'   Dim Tempword2 As Word




   dim I_chksum32 as long
   dim Hulp2, I_x as word


   tcp_cksum0 = 0x00
   tcp_cksum1 = 0x00

       I_chksum32 = 0

       I_value16_h = T_ip_srcaddr0
       [byte]I_value16 = T_ip_srcaddr1
       I_chksum32 = I_value16 + I_chksum32

       I_value16_h = T_ip_srcaddr2
       [byte]I_value16 = T_ip_srcaddr3
       I_chksum32 = I_value16 + I_chksum32

       I_value16_h = T_ip_destaddr0
       [byte]I_value16 = T_ip_destaddr1
       I_chksum32 = I_value16 + I_chksum32

       I_value16_h = T_ip_destaddr2
       [byte]I_value16 = T_ip_destaddr3
       I_chksum32 = I_value16 + I_chksum32

       I_chksum32 = I_chksum32 + T_ip_proto

'       ENC28j60_calc_ippartial_checksum

       I_value16 = T_ip_vers_len And 0x0F
       I_value16 = I_value16 * 4
       I_chksum32 = I_chksum32 - I_value16

       I_value16_h = T_ip_pktlen0
       [byte]I_value16 = T_ip_pktlen1
       I_chksum32 = I_value16 + I_chksum32

       I_odd = I_value16 Mod 2

       Hulp2 = 0x23 + I_value16 - 22 'should be 20 bytes (for the IP Header ) be two bytes less for gcb For-next loop

        I_odd = T_udp_len1 Mod 2
       'Pad out the buffer
        If I_odd = 1 Then
          'add one to the length of the For-next
          Hulp2 =  Hulp2 + 1
          'pad with a zero
          etherbuffer( Hulp2 + 1 ) = 0x00
        End If

        For I_x = 0x23 To Hulp2 Step 2
          I_value16_h = etherbuffer(i_x)
          [byte]I_value16 = etherbuffer( i_x + 1 )
          I_chksum32 = I_value16 + I_chksum32
        Next

       I_checksum16 = i_chksum32
       I_checksum16 = I_checksum16 + [byte]I_chksum32_u
       I_checksum16 = Not [word]I_checksum16

       [byte]tcp_cksum0 = I_checksum16_h
       [byte]tcp_cksum1 = I_checksum16

end sub

sub ENC28j60_telnet

end sub

'these are examples
Sub ENC28j60_udp_handler


;  Uncomment to show UDP packet data
      '  dim I_x as word
      '  'Calcualte UDP packet length
      '  I_value16_h = T_udp_len0
      '  [byte]I_value16 = T_udp_len1
      '  I_value16 = I_value16 - 8
      '
      '  For I_x = T_udp_data_pointer To ( T_udp_data_pointer + I_value16 - 1 )
      '    HSerPrint hex(etherbuffer(i_x))
      '    HSerPrint " "
      '  Next
      '  HSerPrintCRLF
      '
      '  For I_x = T_udp_data_pointer To ( T_udp_data_pointer + I_value16 - 1 )
      '      HSerPrint chr(etherbuffer(i_x))
      '    Next
      '  HSerPrintCRLF

  select case T_udp_destport
      case 6000

          #ifdef ENC28j60_reinitialisation_Supported
              if T_udp_data = "R" then
                  ENC28j60_Initialise
                  goto Reset_ENC26j60
              end if
          #endif

          #ifdef ENC28j60regdump_Supported
              if T_udp_data = "D" then
                  ENC28j60_regdump
              end if
          #endif
      case 5000
         'non-echo on PORT 5000
         Select Case T_udp_data
'               Case "A" : HSerPrint "Action A"
'               Case "B" : HSerPrint "Action B"
'               Case "C" : HSerPrint "Action C"
'               Case "D" : HSerPrint "Action D"
'               Case "E" : HSerPrint "Action E"
'               Case "T" : HserPrint "Time..."
                #ifdef ENC28j60_sntp_Remote_Supported
                  CASE "T"
                    ENC28j60_sntp_get
                #endif
'               Case "a" : HSerPrint "Action a"
'               Case "b" : HSerPrint "Action b"
'               Case "c" : HSerPrint "Action c"
'               Case "d" : HSerPrint "Action d"
'               Case "e" : HSerPrint "Action e"
'
'               Case Else : HSerPrint "Action F"
         End Select
''         HSerPrintCRLF

  end select

End Sub


Sub ENC28j60_udp_checksum
  'init
   dim I_chksum32 as long
   dim Hulp2, I_x as word

   T_udp_chksum0 = 0x00
   T_udp_chksum1 = 0x00
   #ifdef ENC28j60_UDP_checkSum_Supported

'       I_chksum32 = 0
'
'       I_value16_h = T_ip_srcaddr0
'       [byte]I_value16 = T_ip_srcaddr1
'       I_chksum32 = I_value16 + I_chksum32
'
'       I_value16_h = T_ip_srcaddr2
'       [byte]I_value16 = T_ip_srcaddr3
'       I_chksum32 = I_value16 + I_chksum32
'
'       I_value16_h = T_ip_destaddr0
'       [byte]I_value16 = T_ip_destaddr1
'       I_chksum32 = I_value16 + I_chksum32
'
'       I_value16_h = T_ip_destaddr2
'       [byte]I_value16 = T_ip_destaddr3
'       I_chksum32 = I_value16 + I_chksum32
'
'       I_chksum32 = I_chksum32 + T_ip_proto

       'Calc psudo header
       ENC28j60_calc_ippartial_checksum

       'packet length
       I_value16_h = T_udp_len0
       [byte]I_value16 = T_udp_len1
       I_chksum32 = I_value16 + I_chksum32

       I_value16_h = T_udp_srcport0
       [byte]I_value16 = T_udp_srcport1
       I_chksum32 = I_value16 + I_chksum32

       I_value16_h = T_udp_destport0
       [byte]I_value16 = T_udp_destport1
       I_chksum32 = I_value16 + I_chksum32

       'packet length, again
       I_value16_h = T_udp_len0
       [byte]I_value16 = T_udp_len1
       I_chksum32 = I_value16 + I_chksum32
       'and, now I_value16 is the packet length

       Hulp2 = T_udp_data_pointer + I_value16
       Hulp2 = Hulp2 - 10  'this is should be 8 for the real packet but 10 for gcb For-next loop support

        I_odd = T_udp_len1 Mod 2
       'Pad out the buffer
        If I_odd = 1 Then
          'add one to the length of the For-next
          Hulp2 =  Hulp2 + 1
          'pad with a zero
          etherbuffer( Hulp2 + 1 ) = 0x00
        End If

        For I_x = T_udp_data_pointer To Hulp2 Step 2
          I_value16_h = etherbuffer(i_x)
          [byte]I_value16 = etherbuffer( i_x + 1 )
          I_chksum32 = I_value16 + I_chksum32
        Next

       I_checksum16 = i_chksum32
       I_checksum16 = I_checksum16 + [byte]I_chksum32_u
       I_checksum16 = Not [word]I_checksum16

       [byte]T_udp_chksum0 = I_checksum16_h
       [byte]T_udp_chksum1 = I_checksum16

   #endif
end sub
