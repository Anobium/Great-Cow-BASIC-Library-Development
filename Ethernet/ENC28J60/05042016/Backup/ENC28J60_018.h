''

#startup ENC28J60_Initialise

    dim macaddr(6)
    dim ipaddr(4)
    dim ipserver(4)
    dim iprouter(4)
    dim macaddrrouter(4)
    dim ntpserveraddr(4)
    dim ipport as byte
    #define etherBufferSize 128
    dim etherbuffer(etherBufferSize)
    dim nextpacketptr, I_checksum16 as word
    dim packetCounterOut, packetCounterIn as long
    Dim Ip_id As Word

sub ENC28J60_Initialise
'    IF NOT_TO = 0 THEN
'        crash++
'    ELSE

        macaddr =   0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ipaddr =    0,0,0,0
        ipserver =  0,0,0,0
        ipport = 80   'set a default value
        packetCounterOut = 0
        packetCounterIn = 0
        Ip_id = 0
        crash = 0

'    END IF



end sub


sub ENC28J60_Init ( in macaddr() )

      ''' Device ChipSelect control
      '''
      #define ENC28J60_Select         Set ENC28J60_CS off
      #define ENC28J60_Deselect       Set ENC28J60_CS on
      #define ENC28J60_Reset_CMD			Set ENC28J60_RESET on: Wait 10 ms :Set ENC28J60_RESET off: Wait 10 ms :Set ENC28J60_RESET on: Wait 10 ms


      Dir ENC28J60_DI in
      Dir ENC28J60_DO Out
      Dir ENC28J60_SCK Out
      Dir ENC28J60_CS out
      Dir ENC28J60_RESET out

      'Initial state of ports required for SW SPI
      set ENC28J60_DO off
      set ENC28J60_SCK off
      set ENC28J60_CS off


			'Reset the NIC
      ENC28J60_Deselect

      Repeat 5
          ENC28J60_Reset_CMD
      End Repeat

      ENC28J60_Select
      SPIMode Master, 0
      FastHWSPITransfer( ENC28J60_SOFT_RESET, temp )

      lastselectedBank = 99
			wait while ( (ENC28J60_ReadReg( ESTAT ) & ESTAT_CLKRDY ) <> ESTAT_CLKRDY)

      'Initialize NIC
      ENC28J60_writeReg(ECON1, 0xC0) 'Hold it in Reset
      ENC28J60_writeReg(ECON2, 0x80) 'Set the AUTOINC bit

      'Configure interrupts
      ENC28J60_writeReg(EIR, 0x00) 'Reset interrupt flags
      ENC28J60_writeReg(EIE,  0xC0)  'Interrupts: Packet reception
      ENC28J60_writeReg(EWOLIE, 0x00)  'Disable wake-on-lan interrupts
      ENC28J60_writeReg(EWOLIR, 0x00)  'Clear wake-on-lan interrupt flags

      'Allocate TX & RX buffers
      ENC28J60_writeReg(ETXSTL, ENC_TXBUF_STL)
      ENC28J60_writeReg(ETXSTH, ENC_TXBUF_STH)
      ENC28J60_writeReg(ETXNDL, ENC_TXBUF_NDL)
      ENC28J60_writeReg(ETXNDH, ENC_TXBUF_NDH)  'TX Buffer : 1800 bytes
      ENC28J60_writeReg(ERXSTL, ENC_RXBUF_STL)
      ENC28J60_writeReg(ERXSTH, ENC_RXBUF_STH)
      ENC28J60_writeReg(ERXNDL, ENC_RXBUF_NDL)
      ENC28J60_writeReg(ERXNDH, ENC_RXBUF_NDH)  'RX Buffer : 6390 bytes
      ENC28J60_writeReg(ERDPTL, ENC_RXBUF_STL)
      ENC28J60_writeReg(ERDPTH, ENC_RXBUF_STH)

'      ERXND

      ENC28J60_writeReg(ERXRDPTL, ENC_RXBUF_STL)
      ENC28J60_writeReg(ERXRDPTH, ENC_RXBUF_STH) 'RX Pointers (same)

      nextpacketptr = ENC_RXBUF_ST

      'Set Receive Filters
      ENC28J60_writeReg(ERXFCON, 0xA1) 'Receive unicasts or broadcasts

      'Miscancellous
      ENC28J60_writeReg(EFLOCON, 0x00) 'Disable flow control sending
      ENC28J60_writeReg(ECOCON, 0x00) 'Disable Clock Out pin
      ENC28J60_writeReg(EBSTCON, 0x00) 'Disable built-in self test controller

      'Wait for the MAC & PHY parts to be operational
      wait while ( (ENC28J60_ReadReg(ESTAT) & ESTAT_CLKRDY) <> ESTAT_CLKRDY)

      'Initialize MII interface
      ENC28J60_writeReg(MISTAT, 0x00)  'Clear MII status register
      ENC28J60_writeReg(MICMD, 0x00)   'Clear MII command register
'      ENC28J60_writeReg(MICON1, 0x02)  'Fast MII operation
'      ENC28J60_writeReg(MICON2, 0x00)  'Release MII interface from reset

      'Initialize MAC subsystem
      ENC28J60_writeReg(MACON1, b'00001101' )  'Enable packet reception
'      ENC28J60_writeReg(MACON2, 0x00)  'Release the MAC subsystem from reset
'      ENC28J60_writeReg(MACON3, 0xB1)  'Auto Pad + CRC + Full Duplex
      ENC28J60_writeReg(MACON3, 0x32)  'Auto Pad to 60 bytes + CRC + Half Duplex + Check frame length
      ENC28J60_writeReg(MACON4, 0x01)  'Need valid preamble
'      ENC28J60_writeReg(MAPHSUP, b'00010000') 'Release MAC-PHY support from Reset
      ENC28J60_writeReg(MAMXFLL, 0xEE)
      ENC28J60_writeReg(MAMXFLH, 0x05)  'Maximum frame length
      ENC28J60_writeReg(MABBIPG, 0x12) 'IEEE BTB Inter Packet Gap
      ENC28J60_writeReg(MAIPGL, 0x12)
      ENC28J60_writeReg(MAIPGH, 0x0C)  'IEEE Non BTB Inter Packet Gap

      'Leave MACLCON1 and MACLCON2 to their default values
			'Set MAC Address
	    ENC28J60_writeReg(MAADR0, macaddr(2))
      ENC28J60_writeReg(MAADR1, macaddr(1))
      ENC28J60_writeReg(MAADR2, macaddr(4))
      ENC28J60_writeReg(MAADR3, macaddr(3))
      ENC28J60_writeReg(MAADR4, macaddr(6))
      ENC28J60_writeReg(MAADR5, macaddr(5))



'      'Initialize PHY subsystem
      ENC28J60_writePhyReg(PHCON1, 0x00, 0x00)  'Half duplex
      ENC28J60_writePhyReg(PHCON2, 0x00, 0x00)
      ENC28J60_writePhyReg(PHLCON, B'00000100', B'01110110')
      ENC28J60_writePhyReg(PHIE, 0x00, 0x00)  'Disable interrupts

      'Initialization done, release the NIC from reset
      ENC28J60_writeReg(ECON1, B'00010100')
'      ENC28J60_writeReg(ECON1, B'00000100')
      'We are done!!
      'A real highLIGHT, a led test. If your RJ45-connector has LED's for LINK and DATA you can test them with this small line. Put it somewhere after the ENC28J60init.
      'Set address of PHY register to write
'      ENC28J60_writePhyReg ( PHLCON, 0xA2, 0x0A )
'      wait 5 s

      'Set LEDs to the normal settings
       ENC28J60_writePhyReg ( PHLCON, 0x76, 0x04 )

End Sub


Sub memory

      'Allocate TX & RX buffers
      ENC28J60_writeReg(ETXSTL, ENC_TXBUF_STL)
      ENC28J60_writeReg(ETXSTH, ENC_TXBUF_STH)
      ENC28J60_writeReg(ETXNDL, ENC_TXBUF_NDL)
      ENC28J60_writeReg(ETXNDH, ENC_TXBUF_NDH)  'TX Buffer : 1800 bytes
      ENC28J60_writeReg(ERXSTL, ENC_RXBUF_STL)
      ENC28J60_writeReg(ERXSTH, ENC_RXBUF_STH)
      ENC28J60_writeReg(ERXNDL, ENC_RXBUF_NDL)
      ENC28J60_writeReg(ERXNDH, ENC_RXBUF_NDH)  'RX Buffer : 6390 bytes
      ENC28J60_writeReg(ERDPTL, ENC_RXBUF_STL)
      ENC28J60_writeReg(ERDPTH, ENC_RXBUF_STH)

End Sub

; writes byte ENC_Outbyte in ENC register addr of the current bank
sub ENC28J60_writeReg( in addr,  in ENC_Outbyte as byte )
				banktobeselected = ( addr & BANK_MASK) / 32
				' was...this @005  ENC28J60_selectBank ( banktobeselected, addr )

        if lastselectedBank <> banktobeselected then
          if ( ( addr & ADDR_MASK )  <= EIE  ) then
              ENC28J60_selectBank ( banktobeselected, addr )
          end if
        Else
          lastselectedBank = banktobeselected
        end if

        ENC28J60_Select
        FastHWSPITransfer( ENC28J60_WRITE_CTRL_REG | (addr AND ADDR_MASK ), temp )
        FastHWSPITransfer( ENC_Outbyte, temp )
        ENC28J60_Deselect

end sub


'sub ENC28J60_writeReg( in addr,  in ENC_Outbyte as word )
'
'				bankselected = ( addr & BANK_MASK) / 32
'				ENC28J60_selectBank ( bankselected )
'
'        ENC28J60_Select
'        SPITransfer( ENC28J60_WRITE_CTRL_REG | (addr AND ADDR_MASK ), temp )
'        SPITransfer( ENC_Outbyte_h, temp )
'        SPITransfer( [byte]ENC_Outbyte, temp )
'        ENC28J60_Deselect
'end sub

sub ENC28J60_writePhyReg( in PhyRegaddr,  in ENC_Outbyte1 as byte , in ENC_Outbyte2 as byte )

				'Wait for the MII interface to be ready
    		while ((ENC28J60_ReadReg(MISTAT) & MISTAT_BUSY ) = MISTAT_BUSY )

				ENC28J60_writeReg( MIREGADR, PhyRegaddr )
'        temp = ENC28J60_ReadReg( MIREGADR )
        ENC28J60_writeReg( MIWRL, ENC_Outbyte1 )
        ENC28J60_writeReg( MIWRH, ENC_Outbyte2 )

				'Wait for the MII interface to be ready
        wait while ( (ENC28J60_ReadReg( MISTAT ) & MISTAT_BUSY ) = MISTAT_BUSY )
end sub

sub ENC28J60_selectBank ( in banktobeselected, in addr )

				'Set to ENC memory bank addr
        ENC28J60_Select
        FastHWSPITransfer(BFCCMD | ECON1, temp)
        FastHWSPITransfer(b'00000011', temp)
        ENC28J60_Deselect

				'Set to ENC memory bank addr
				Select case banktobeselected

          case 1

            ENC28J60_Select
            FastHWSPITransfer(BFSCMD | ECON1, temp)
            FastHWSPITransfer(b'00000001' , temp)
            ENC28J60_Deselect

          case 2

          	ENC28J60_Select
            FastHWSPITransfer(BFSCMD | ECON1, temp)
            FastHWSPITransfer(b'00000010' , temp)
            ENC28J60_Deselect


          case 3

          	ENC28J60_Select
            FastHWSPITransfer(BFSCMD | ECON1, temp)
            FastHWSPITransfer(b'00000011' , temp)
            ENC28J60_Deselect

        End Select

        lastselectedBank = banktobeselected
end sub


function ENC28J60_ReadReg( in addr ) as byte

        banktobeselected =  ( addr & BANK_MASK) / 32

'				'These registers (EIE, EIR, ESTAT, ECON2, ECON1)
'				'are present in all banks, no need to switch bank
        if lastselectedBank <> banktobeselected then

          if ( ( addr & ADDR_MASK ) <= EIE  ) then
              ENC28J60_selectBank ( banktobeselected, addr )
          else
              lastselectedBank = banktobeselected
          end if
        end if

        ENC28J60_Select

       'Send Read address
        Set WCOL Off
        'Put byte to send into buffer
        'Will start transfer
        SSPBUF = ENC28J60_READ_CTRL_REG | ( addr AND ADDR_MASK )
        'Read buffer
        Wait While BF = Off
        temp = SSPBUF


        Set WCOL Off
         'Put byte to send into buffer
        'Will start transfer
        SSPBUF = temp
        'Read dummy
        Wait While BF = Off
        temp = SSPBUF


        Set WCOL Off
        'Put byte to send into buffer
        'Will start transfer
        SSPBUF = temp
        'Read dummy value
        Wait While BF = Off
        'Set data result
        ENC28J60_ReadReg = SSPBUF

        ENC28J60_Deselect


end function


'/* Sets bits in a register */
Sub ENC28J60_bitSet( in addr,  in ENC_Outbyte as byte )
				banktobeselected = ( addr & BANK_MASK) / 32
				' was...this @005  ENC28J60_selectBank ( banktobeselected, addr )

        if lastselectedBank <> banktobeselected then
          if ( ( addr & ADDR_MASK )  <= EIE  ) then
              ENC28J60_selectBank ( banktobeselected, addr )
          end if
        Else
          lastselectedBank = banktobeselected
        end if

        ENC28J60_Select
        FastHWSPITransfer( ENC28J60_BIT_FIELD_SET | (addr AND ADDR_MASK ), temp )
        FastHWSPITransfer( ENC_Outbyte, temp )
        ENC28J60_Deselect

end sub

Sub ENC28J60_bitClear( in addr,  in ENC_Outbyte as byte )
				banktobeselected = ( addr & BANK_MASK) / 32
				' was...this @005  ENC28J60_selectBank ( banktobeselected, addr )

        if lastselectedBank <> banktobeselected then
          if ( ( addr & ADDR_MASK )  <= EIE  ) then
              ENC28J60_selectBank ( banktobeselected, addr )
          end if
        Else
          lastselectedBank = banktobeselected
        end if
        ENC28J60_Select
        FastHWSPITransfer( ENC28J60_BIT_FIELD_CLR | (addr AND ADDR_MASK ), temp )
        FastHWSPITransfer( ENC_Outbyte, temp )
        ENC28J60_Deselect

end sub

'004 new

dim enc_last_txbuf as Word

'Make sure we have enough data readable and read it
function stack_read( optional in etherGetLength as word = 1 )

  if etherGetLength > etherSize then
    stack_read = false
    exit Function
  end if
  etherSize -= etherGetLength
  eth_read( etherGetLength )
  stack_read = true
end function




'      'Computes an address int the receive buffer
'      'check constants value
'      function eth_rx_addr( in from as word, in offset as word ) as word
'
'        dim memaddr as word
'        memaddr = from + offset
'
'        ' Wrap lower boundary
'        if ( memaddr < ENC_RXBUF_ST ) then
'          eth_rx_addr = ENC_RXBUF_ND - ENC_RXBUF_ST + memaddr + 1
'          exit Function
'        end if
'        ' Wrap higher boundary
'        if ( memaddr > ENC_RXBUF_ND ) then
'          eth_rx_addr = ENC_RXBUF_ST + memaddr - ENC_RXBUF_ND - 1
'          exit Function
'        end if
'
'        eth_rx_addr = memaddr
'
'      end Function
'
'
'
'
'
'Read data from the Ethernet buffer at ERDPT location
sub eth_read( optional in etherGetLength as word = 1 )
  dim eth_counter as Word

  ' Initiate SPI command
  ENC28J60_Select
  ' Send command

  ' Read bytes
  Set WCOL Off
  'Put byte to send into buffer
  'Will start transfer
  SSPBUF = ENC28J60_READ_BUF_MEM
  Wait While BF = Off
  'Set data result
  temp = SSPBUF

  for eth_counter = 0 to buf_len -1
    SSPBUF = 0
    Wait While BF = Off
    etherbuffer( eth_counter ) = SSPBUF
  next

  ' Finish SPI command
  ENC28J60_Deselect
end Sub

'      ' Skip bytes in the reception buffer
'      sub eth_skip(  in buf_len as word  )
'
'        ' Initiate SPI command
'        ENC_SS = 0;
'        ' Send command
'        SPISEND(ETH_READMEM())
'        ' Read bytes
'        repeat buf_len
'          SPISEND(0)
'        end Repeat
'        ' Finish SPI command
'        ENC_SS = 1;
'      end Sub
'
'      ' Initialize write location depending on the TX buffer number
'      sub eth_write_to( in eth_position as Word )
'
'        dim eth_pos as Word
'        eth_ctl = 0
'
'        ' Save buffer index
'        enc_last_txbuf = eth_position
'        ' Get buffer pointer
'        eth_pos_l = enc_tx_buf_l( eth_position )
'        eth_pos_h = enc_tx_buf_h( eth_position )
'        ' Wait for the transmit logic to be ready
'        wait while ((eth_read_reg(ECON1) & TXRTS))
'        ' Set buffer pointers
'        eth_write_reg(ETXSTL, eth_pos_l )
'        eth_write_reg(ETXSTH, eth_pos_h )
'        eth_write_reg(EWRPTL, eth_pos_l )
'        eth_write_reg(EWRPTH, eth_pos_h )
'        ' Write per-packet control byte
'        eth_write( eth_ctl , 1 )
'      end Sub
'
'      ' Transmits a packet given its length
'      sub eth_xmit(  in buf_len as word )
'
'        dim eth_pos as Word
'
'        ' Wait for last transmission to complete
'        wait while ((eth_read_reg(ECON1) & TXRTS))
'        ' Set the transmit end pointer (data length + per-packet control byte - 1 [end pointer is inclusive]) */
'        eth_pos  = enc_tx_buf( enc_last_txbuf ) + buf_len
'        eth_write_reg(ETXNDL, eth_pos_l)
'        eth_write_reg(ETXNDH, eth_pos_h)
'        ' Start transmission
'        eth_bit_set(ECON1, TXRTS)
'        ' Debug, wait for transmission to complete
'        wait while ((eth_read_reg(ECON1) & TXRTS))
'      end sub
'
'      ' Write data in the Ethernet buffer at EWRPT location
'      sub eth_write( in buf() as byte , in buf_len as word )
'        dim eth_counter as Word
'
'        'Initiate SPI command
'        ENC_SS = 0
'        ' Send write command
'        SPISEND(ETH_WRITEMEM())
'        ' Send bytes
'        for eth_counter = 1 to buf_len
'          SPISEND( buf( eth_counter ) )
'        next
'        ' Finish SPI command
'        ENC_SS = 1
'      end Sub
'
'
'      ' Reads a PHY reg
'      function eth_read_phy_reg( in reg as byte ) as word
'
'        ushort_t  ret;
'
'        ' Wait for the MII interface to be ready
'        wait while ((eth_read_reg(MISTAT) & BUSY));
'        ' Set address and start reading */
'        eth_write_reg(MIREGADR, reg);
'        eth_bit_set(MICMD, MIIRD);
'        ' Wait for the MII interface to be ready */
'        while ((eth_read_reg(MISTAT) & BUSY));
'        ' Clear the read operation */
'        eth_bit_clear(MICMD, MIIRD);
'        ' Read the data */
'        ret.c.l = eth_read_reg(MIRDL);
'        ret.c.h = eth_read_reg(MIRDH);
'        return (ret.s);
'      end Function
'
'
'      ' Resets the NIC and wait for it to be ready
'      sub eth_reset
'
'        ' Configure buffers
'        ' Initiate SPI command
'        ENC28J60_Select
'        ' Send reset
'        SPISEND(ETH_RESET())
'        ' Finish SPI command
'        ENC28J60_Deselect
'        ' Wait at least 1 ms
'        wait 1 ms
'        ' Switch to BANK0
'        selectBank_ENC28J6 (0)
'      end sub



Sub Enc28j60packetsend( in pcktlen As Word )

  ENC28J60_bitSet( ECON1 , econ1_txrst )
  ENC28J60_bitClear( ECON1 , econ1_txrst )
'added
  ENC28J60_bitClear( EIR , EIR_TXERIF )

  wait while ( (ENC28J60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )

  'set the TXND pointer to correspond to the packet size given
  ENC28J60_writeReg(etxndl , (ENC_TXBUF_STL + pcktlen ) & 0xFF )
  ENC28J60_writeReg(etxndh , ENC_TXBUF_STH + pcktlen_h )

  ENC28J60_bitSet( EIR , EIR_TXIF )
  ENC28J60_bitClear( EIE , EIE_TXIE )

  'send the contents of the transmit buffer onto the network
  ENC28J60_bitSet( ECON1 , econ1_txrts )

  wait while ( (ENC28J60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )

  packetCounterOut++
'      Value = 0
'      Value.econ1_txrst = 1
'      Call Enc28j60bitfield_set(econ1 , Value)
'
'      Value.econ1_txrst = 1
'      Call Enc28j60bitfield_clear(econ1 , Value)
'
'      'set the write pointer to start of transmit buffer area
'      Value = Low(txstart_init)
'      Call Enc28j60writecontrolregbyte(ewrptl , Value)
'
'      Value = High(txstart_init)
'      Call Enc28j60writecontrolregbyte(ewrpth , Value)
'
'      'set the TXND pointer to correspond to the packet size given
'      Value = Low(txstart_init)
'      Value = Value + Low(pcktlen)
'      Call Enc28j60writecontrolregbyte(etxndl , Value)
'
'      Value = High(txstart_init)
'      Value = Value + High(pcktlen)
'
'      Call Enc28j60writecontrolregbyte(etxndh , Value)
'
'      'send the contents of the transmit buffer onto the network
'      Value = 0
'      Value.econ1_txrts = 1
'      Call Enc28j60bitfield_set(econ1 , Value)
End Sub




Sub Enc28j60writebufferARP

    'ARP
    etherbuffer(1) = 0xFF 'Broadcast
    etherbuffer(2) = 0xFF
    etherbuffer(3) = 0xFF
    etherbuffer(4) = 0xFF
    etherbuffer(5) = 0xFF
    etherbuffer(6) = 0xFF

    etherbuffer(7)  = macaddr(1)
    etherbuffer(8)  = macaddr(2)
    etherbuffer(9)  = macaddr(3)
    etherbuffer(10) = macaddr(4)
    etherbuffer(11) = macaddr(5)
    etherbuffer(12) = macaddr(6)

    etherbuffer(13) = 0x08
    etherbuffer(14) = 0x06
'arp
    etherbuffer(15) = 0x00
    etherbuffer(16) = 0x01

    etherbuffer(17) = 0x08
    etherbuffer(18) = 0x00

    etherbuffer(19) = 0x06

    etherbuffer(20) = 0x04

    etherbuffer(21) = 0x00
    etherbuffer(22) = 0x01

    etherbuffer(23) = macaddr(1)
    etherbuffer(24) = macaddr(2)
    etherbuffer(25) = macaddr(3)
    etherbuffer(26) = macaddr(4)
    etherbuffer(27) = macaddr(5)
    etherbuffer(28) = macaddr(6)

    etherbuffer(29) = ipaddr(1) 'own TUX-IP-number
    etherbuffer(30) = ipaddr(2)
    etherbuffer(31) = ipaddr(3)
    etherbuffer(32) = ipaddr(4)

    etherbuffer(33) = 0x00 'MAC-address router
    etherbuffer(34) = 0x00
    etherbuffer(35) = 0x00
    etherbuffer(36) = 0x00
    etherbuffer(37) = 0x00
    etherbuffer(38) = 0x00

    etherbuffer(39) = iprouter(1) 'IP-number router
    etherbuffer(40) = iprouter(2)
    etherbuffer(41) = iprouter(3)
    etherbuffer(42) = iprouter(4)

    Enc28j60writebuffer( 42 )' as 60 is the true length of ARP packet
    Enc28j60packetsend( 60 )

End Sub


Sub Enc28j60writebuffer ( in pcktlen As Word )

    dim eth_counter as Word

    'set the write pointer to start of transmit buffer area
    ENC28J60_writeReg(ewrptl, ENC_TXBUF_STL)
    ENC28J60_writeReg(ewrpth, ENC_TXBUF_STH)

    'Send as fast as we can
    ENC28J60_Select

   'Send Read address
    Set WCOL Off
    'Put byte to send into buffer
    'Will start transfer
    SSPBUF = Enc28j60_write_buf_mem
    'Read buffer
    Wait While BF = Off
    temp = SSPBUF

    SSPBUF = 0x0E
    'Read buffer
    Wait While BF = Off
    temp = SSPBUF


    for eth_counter = 1 to pcktlen
      if eth_counter > etherBufferSize then Exit For
      SSPBUF = etherbuffer(eth_counter)
      'Read buffer
       Wait While BF = Off
       temp = SSPBUF
    next
    ENC28J60_Deselect


End Sub


Sub Enc28j60readbuffer( optional in etherGetLength as word = 1 )
  dim eth_counter as Word

  if etherGetLength  > 1518 then Exit Sub

  ' Initiate SPI command
  ENC28J60_Select
  ' Send command

  ' Read bytes
  Set WCOL Off
  'Send Read Buffer Memory command
  SSPBUF = ENC28J60_READ_BUF_MEM
  Wait While BF = Off
  'Set data result
  temp = SSPBUF

  if etherGetLength < etherBufferSize+1 then

    for eth_counter = 1 to etherGetLength
      SSPBUF = 0
      Wait While BF = Off
      etherbuffer( eth_counter ) = SSPBUF
    next

  End if

'  if etherGetLength > etherBufferSize then
'
'    for eth_counter = 65 to etherGetLength
'      SSPBUF = 0
'      Wait While BF = Off
'      temp = SSPBUF
'
'    next
'
'  End if

  #ifdef debug
      HSerPrint " Rd: 0x"
      HSerPrint hex(eth_counter_h)
      HSerPrint hex([byte]eth_counter)
      HSerPrint " : "
  #endif

  ' Finish SPI command
  ENC28J60_Deselect
End Sub

Sub Enc28j60packetreceive( in maxlen As Word )
    Dim eth_counter, eth_frameLength As Word
    Dim previous_nextpacketptr as word

    'Check if this was an errata error. Exit.
    ENC28J60_temp = ENC28J60_ReadReg (eir) and EIR_PKTIF
    If ENC28J60_temp <> EIR_PKTIF Then
        HSerPrint "No packet"
        'decrement the packet counter indicate we are done with this packet
        ENC28J60_bitSet( ECON2, ECON2_PKTDEC )

        Exit Sub
    End If
    packetCounterIn++
    Enc28j60_data = ENC28J60_ReadReg( erevid )

    'Debug
    'Pointers are not always updated (seems to depend on the size of
    'the received packet)
    'Workaround : write and verify until it is done
'    do

      ENC28J60_writeReg(ERDPTL, [byte]nextpacketptr )
      ENC28J60_writeReg(ERDPTH, nextpacketptr_h )

    'Verify */
'    loop while (ENC28J60_ReadReg(ERDPTL) <>  [byte]nextpacketptr) or (ENC28J60_ReadReg(ERDPTH) <> nextpacketptr_h )
    'Packet is finished


    #ifdef debug
      HSerPrintCRLF 2
      HSerPrint "RXWRPT RXRDPT PKTCNT"
      HSerPrintCRLF
      do
        cnt = ENC28J60_ReadReg(epktcnt)
        Enc28j60_datal = ENC28J60_ReadReg(erxwrptl)
        Enc28j60_datah = ENC28J60_ReadReg(erxwrpth)
      while cnt <> ENC28J60_ReadReg(epktcnt)
      HSerPrint Hex(enc28j60_datah);
      HSerPrint Hex(enc28j60_datal);

      Enc28j60_data = ENC28J60_ReadReg(erxrdpth)
      HSerPrint "   " + Hex(enc28j60_data);
      Enc28j60_data = ENC28J60_ReadReg(erxrdptl)
      HSerPrint Hex(enc28j60_data);

      Enc28j60_data = ENC28J60_ReadReg(epktcnt)
      HSerPrint "     " + Hex(enc28j60_data);
      HSerPrintCRLF
    #endif

   'read the next packet pointer(s)
      Enc28j60readbuffer(6)
      #ifdef Debug
        for tt = 1 to 6
          HSerPrint hex(etherbuffer(tt))
          HSerPrint ","

        next
      #endif

    'Set next packet
      nextpacketptr = etherbuffer(1)
      nextpacketptr_h = etherbuffer(2)

    'read the packet length
      eth_frameLength = etherbuffer(3)
      eth_frameLength_h = etherbuffer(4)
      #ifdef debug
        HSerPrint "Len:" :
        HserPrint Hex( eth_frameLength_h ) : HserPrint Hex( eth_frameLength ): HSerPrintCRLF
      #endif
    'read the receive status
      RxStat = etherbuffer(5)
      RxStat_h = etherbuffer(6)
      #ifdef debug
        HSerPrint " - Rxstat:" : HserPrint ByteToBin( RxStat_h ) : HserPrint ByteToBin(RxStat )
      #endif
'      HSerPrint hex(etherbuffer(5))
'      HSerSend 9
'      HSerPrint hex(etherbuffer(5) and 0x80 )
'      HSerPrintCRLF
'      HSerPrint hex(etherbuffer(6))
'      HSerPrintCRLF

      'copy the packet from the receive buffer
       if ( etherbuffer(5) AND 0x80 ) = 0x80 then
          Enc28j60readbuffer(eth_frameLength)
       end if

endpacket:
    'Pointers are not always updated (seems to depend on the size of
    'the received packet)
    'Workaround : write and verify until it is done
    'write the memory read pointer
      do
          ENC28J60_writeReg(ERDPTL, [byte]nextpacketptr )
          ENC28J60_writeReg(ERDPTH, nextpacketptr_h )
      loop while (ENC28J60_ReadReg(ERDPTL) <>  [byte]nextpacketptr) or (ENC28J60_ReadReg(ERDPTH) <> nextpacketptr_h )
    'Packet is finished

      IF ( nextpacketptr and 1 ) = 0 THEN
          eth_counter = nextpacketptr -1
      END IF
      ENC28J60_writeReg(ERXRDPTL, [byte]eth_counter )
      ENC28J60_writeReg(ERXRDPTH, eth_counter_h )

    'decrement the packet counter indicate we are done with this packet
      ENC28J60_bitSet( ECON2, ECON2_PKTDEC )
'
'      HSerPrintCRLF
'      HSerSend 9
'      HSerSend 9
'
'      for ii = 1 to 24
'        HSerPrint hex(etherbuffer(ii))
'        HSerPrint ":"
'      next
'      HSerPrintCRLF

    'Handle the packet
    If etherBuffer(13) = 0X08 Then
'      HSerPrint "13@1,"
      If etherBuffer(14) = 0X06 Then                             'Type:ARP
'        HSerPrint "14@1,"
         If etherBuffer(21) = 0X00 Then                          'ARP request
            If etherBuffer(22) = 0X01 Then                       'ARP request
              If etherBuffer(39) = ipaddr(1) Then                  'ARP for us
                If etherBuffer(40) = ipaddr(2) Then
                   If etherBuffer(41) = ipaddr(3) Then
                      If etherBuffer(42) = ipaddr(4) Then
                          Arpreply
'                          HSerPrint "ARP Replied": HSerPrintCRLF
                      End If
                   End If
                End If
              End If
            End If
         End If
      End If

      If etherBuffer(14) = 0X00 Then                             'Type:IP
'        HSerPrint "14@2,"
         If etherBuffer(15) = 0X45 Then                          'We handle only simple IP packets
'         HSerPrint "15@2,"
            If etherBuffer(21) = 0 or etherBuffer(21) = 0x40 Then                          'We handle only non fragmented packets
'            HSerPrint "21@2,"
              If etherBuffer(31) = ipaddr(1) Then                  'Ip packet for us
                If etherBuffer(32) = ipaddr(2) Then
                   If etherBuffer(33) = ipaddr(3) Then
                      If etherBuffer(34) = ipaddr(4) Then
                        If etherBuffer(24) = 1 Then              'Protocol:ICMP
                           If etherBuffer(35) = 0X08 Then        'ICMP echo request
                                Pingreply
'                                HSerPrint "Pinged ": HSerPrintCRLF
                           End If
                        End If
                        If etherBuffer(24) = 17 Then             'Protocol:UDP
'                          Udp_receive                    'werkt wel
                           ENC28J60_Udp
                        End If
                        If etherBuffer(24) = 6 Then              'Protocol:TCP
'                          Tcp                            'werkt niet
                          HSerPrint "TCP Reply Needed": HSerPrintCRLF
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


Sub Enc28j60poll

    'Force a bank switch
'    ENC28J60_selectBank ( 0x20, epktcnt )
    Enc28j60_data = ENC28J60_ReadReg( erevid )
    cnt = ENC28J60_ReadReg( epktcnt )
    If cnt > 0 Then
       Enc28j60packetreceive(etherBufferSize)
    End If


End Sub


ConfigurationDetails:




'Important bit maps
#define EPKTDEC 0x40
#define DMAST   0x20
#define CSUMEN  0x10
#define TXRTS   0x08
#define MIIRD   0x01
#define BUSY    0x01
#define CLKRDY  0x01
#define RXEN    0x04

Memory_Locations_Script:
'Set ENC28J60 Memory locations
#script

'  buffer boundaries applied to internal 8K ram
' entire available packet buffer space is allocated.
' Give TX buffer space for one full ethernet frame (~1500 bytes)
' receive buffer gets the rest'
'erv these still used? todo
  TXSTART_INIT	=	0x1A00
  TXSTART_INITL = INT(TXSTART_INIT) AND 255
  TXSTART_INITH = INT( INT( TXSTART_INIT ) / 0x100 )

  ENC_TXBUF_ST = 0x1670

  ENC_TXBUF_STL = INT(ENC_TXBUF_ST) AND 255
  ENC_TXBUF_STH = INT( INT( ENC_TXBUF_ST ) / 0x100 )
  ENC_TXBUF_ND = 0x1FFF
  ENC_TXBUF_NDL = INT(ENC_TXBUF_ND) AND 255
  ENC_TXBUF_NDH = INT( INT(ENC_TXBUF_ND) / 0x100 )

  ENC_RXBUF_ST  = 0x0000
  ENC_RXBUF_STL = INT(ENC_RXBUF_ST)  AND 255
  ENC_RXBUF_STH = INT( INT( ENC_RXBUF_ST ) / 0x100 )
  ENC_RXBUF_ND  = 0x166E

  ENC_RXBUF_NDL = INT(ENC_RXBUF_ND) AND 255
  ENC_RXBUF_NDH = INT( INT(ENC_RXBUF_ND) / 0x100 )

  ENC_TX_BUF1 =  ENC_TXBUF_ST
  ENC_TX_BUF2 =  ENC_TX_BUF1 + 300
  ENC_TX_BUF3 =  ENC_TX_BUF2 + 300
  ENC_TX_BUF4 =  ENC_TX_BUF3 + 300
  ENC_TX_BUF5 =  ENC_TX_BUF4 + 300
  ENC_TX_BUF6 =  ENC_TX_BUF5 + 300
  ENC_TX_BUF7 =  ENC_TX_BUF6 + 300
  ENC_TX_BUF8 =  ENC_TX_BUF7 + 300
  ENC_TX_BUFNB = 8
#endscript

'
' ENC28J60 Control Registers
#define WCRCMD  b'01000000'      ; write control register
#define BFCCMD  b'10100000'      ; bit field clear
#define BFSCMD  b'10000000'      ; bit field set

' Control register definitions are a combination of address,
' bank number, and Ethernet/MAC/PHY indicator bits.
' - Register address	(bits 0-4)
' - Bank number	(bits 5-6)
' - MAC/MII indicator	(bit 7)
'
#define ADDR_MASK	0x1F
#define BANK_MASK	0x60
#define SPRD_MASK	0x80
'  All-bank registers'
#define BANK0 	0
#define BANK1 	1
#define BANK2 	2
#define BANK3 	3


#define EIE		0x1B
#define EIR		0x1C
#define ESTAT		0x1D
#define ECON2		0x1E
#define ECON1		0x1F
'  Bank 0 registers'
#define ERDPTL		(0x00|0x00)
#define ERDPTH		(0x01|0x00)
#define EWRPTL		(0x02|0x00)
#define EWRPTH		(0x03|0x00)
#define ETXSTL		(0x04|0x00)
#define ETXSTH		(0x05|0x00)
#define ETXNDL		(0x06|0x00)
#define ETXNDH		(0x07|0x00)
#define ERXSTL		(0x08|0x00)
#define ERXSTH		(0x09|0x00)
#define ERXNDL		(0x0A|0x00)
#define ERXNDH		(0x0B|0x00)
#define ERXRDPTL	(0x0C|0x00)
#define ERXRDPTH	(0x0D|0x00)
#define ERXWRPTL	(0x0E|0x00)
#define ERXWRPTH	(0x0F|0x00)
#define EDMASTL		(0x10|0x00)
#define EDMASTH		(0x11|0x00)
#define EDMANDL		(0x12|0x00)
#define EDMANDH		(0x13|0x00)
#define EDMADSTL	(0x14|0x00)
#define EDMADSTH	(0x15|0x00)
#define EDMACSL		(0x16|0x00)
#define EDMACSH		(0x17|0x00)
'  Bank 1 registers'
#define EHT0		(0x00|0x20)
#define EHT1		(0x01|0x20)
#define EHT2		(0x02|0x20)
#define EHT3		(0x03|0x20)
#define EHT4		(0x04|0x20)
#define EHT5		(0x05|0x20)
#define EHT6		(0x06|0x20)
#define EHT7		(0x07|0x20)
#define EPMM0		(0x08|0x20)
#define EPMM1		(0x09|0x20)
#define EPMM2		(0x0A|0x20)
#define EPMM3		(0x0B|0x20)
#define EPMM4		(0x0C|0x20)
#define EPMM5		(0x0D|0x20)
#define EPMM6		(0x0E|0x20)
#define EPMM7		(0x0F|0x20)
#define EPMCSL		(0x10|0x20)
#define EPMCSH		(0x11|0x20)
#define EPMOL		(0x14|0x20)
#define EPMOH		(0x15|0x20)
#define EWOLIE		(0x16|0x20)
#define EWOLIR		(0x17|0x20)
#define ERXFCON		(0x18|0x20)
#define EPKTCNT		(0x19|0x20)
'  Bank 2 registers'
#define MACON1		(0x00|0x40|SPRD_MASK)
'  #define MACON2	(0x01|0x40|SPRD_MASK)'
#define MACON3		(0x02|0x40|SPRD_MASK)
#define MACON4		(0x03|0x40|SPRD_MASK)
#define MABBIPG		(0x04|0x40|SPRD_MASK)
#define MAIPGL		(0x06|0x40|SPRD_MASK)
#define MAIPGH		(0x07|0x40|SPRD_MASK)
#define MACLCON1	(0x08|0x40|SPRD_MASK)
#define MACLCON2	(0x09|0x40|SPRD_MASK)
#define MAMXFLL		(0x0A|0x40|SPRD_MASK)
#define MAMXFLH		(0x0B|0x40|SPRD_MASK)
'#define MAPHSUP		(0x0D|0x40|SPRD_MASK)
'#define MICON		(0x11|0x40|SPRD_MASK)
#define MICMD		(0x12|0x40|SPRD_MASK)
#define MIREGADR	(0x14|0x40|SPRD_MASK)
#define MIWRL		(0x16|0x40|SPRD_MASK)
#define MIWRH		(0x17|0x40|SPRD_MASK)
#define MIRDL		(0x18|0x40|SPRD_MASK)
#define MIRDH		(0x19|0x40|SPRD_MASK)
'  Bank 3 registers'
#define MAADR1		(0x00|0x60|SPRD_MASK)
#define MAADR0		(0x01|0x60|SPRD_MASK)
#define MAADR3		(0x02|0x60|SPRD_MASK)
#define MAADR2		(0x03|0x60|SPRD_MASK)
#define MAADR5		(0x04|0x60|SPRD_MASK)
#define MAADR4  	(0x05|0x60|SPRD_MASK)
#define EBSTSD		(0x06|0x60)
#define EBSTCON		(0x07|0x60)
#define EBSTCSL		(0x08|0x60)
#define EBSTCSH		(0x09|0x60)
#define MISTAT		(0x0A|0x60|SPRD_MASK)
#define EREVID		(0x12|0x60)
#define ECOCON		(0x15|0x60)
#define EFLOCON		(0x17|0x60)
#define EPAUSL		(0x18|0x60)
#define EPAUSH		(0x19|0x60)
'  PHY registers'
#define PHCON1		0x00
#define PHSTAT1		0x01
#define PHHID1		0x02
#define PHHID2		0x03
#define PHCON2		0x10
#define PHSTAT2		0x11
#define PHIE		0x12
#define PHIR		0x13
#define PHLCON		0x14

'  ENC28J60 EIE Register Bit Definitions'
#define EIE_INTIE	0x80
#define EIE_PKTIE	0x40
#define EIE_DMAIE	0x20
#define EIE_LINKIE	0x10
#define EIE_TXIE	0x08
'  #define EIE_WOLIE	0x04 (reserved)'
#define EIE_TXERIE	0x02
#define EIE_RXERIE	0x01
'  ENC28J60 EIR Register Bit Definitions'
#define EIR_PKTIF	0x40
#define EIR_DMAIF	0x20
#define EIR_LINKIF	0x10
#define EIR_TXIF	0x08
'  #define EIR_WOLIF	0x04 (reserved)'
#define EIR_TXERIF	0x02
#define EIR_RXERIF	0x01
'  ENC28J60 ESTAT Register Bit Definitions'
#define ESTAT_INT	0x80
#define ESTAT_LATECOL	0x10
#define ESTAT_RXBUSY	0x04
#define ESTAT_TXABRT	0x02
#define ESTAT_CLKRDY	0x01
'  ENC28J60 ECON2 Register Bit Definitions'
#define ECON2_AUTOINC	0x80
#define ECON2_PKTDEC	0x40
#define ECON2_PWRSV	0x20
#define ECON2_VRPS	0x08
'  ENC28J60 ECON1 Register Bit Definitions'
#define ECON1_TXRST	0x80
#define ECON1_RXRST	0x40
#define ECON1_DMAST	0x20
#define ECON1_CSUMEN	0x10
#define ECON1_TXRTS	0x08
#define ECON1_RXEN	0x04
#define ECON1_BSEL1	0x02
#define ECON1_BSEL0	0x01
'  ENC28J60 MACON1 Register Bit Definitions'
#define MACON1_LOOPBK	0x10
#define MACON1_TXPAUS	0x08
#define MACON1_RXPAUS	0x04
#define MACON1_PASSALL	0x02
#define MACON1_MARXEN	0x01
'  ENC28J60 MACON2 Register Bit Definitions'
#define MACON2_MARST	0x80
#define MACON2_RNDRST	0x40
#define MACON2_MARXRST	0x08
#define MACON2_RFUNRST	0x04
#define MACON2_MATXRST	0x02
#define MACON2_TFUNRST	0x01
'  ENC28J60 MACON3 Register Bit Definitions'
#define MACON3_PADCFG2	0x80
#define MACON3_PADCFG1	0x40
#define MACON3_PADCFG0	0x20
#define MACON3_TXCRCEN	0x10
#define MACON3_PHDRLEN	0x08
#define MACON3_HFRMLEN	0x04
#define MACON3_FRMLNEN	0x02
#define MACON3_FULDPX	0x01
'  ENC28J60 MICMD Register Bit Definitions'
#define MICMD_MIISCAN	0x02
#define MICMD_MIIRD	0x01
'  ENC28J60 MISTAT Register Bit Definitions'
#define MISTAT_NVALID	0x04
#define MISTAT_SCAN	0x02
#define MISTAT_BUSY	0x01
'  ENC28J60 ERXFCON Register Bit Definitions'
#define ERXFCON_UCEN	0x80
#define ERXFCON_ANDOR	0x40
#define ERXFCON_CRCEN	0x20
#define ERXFCON_PMEN	0x10
#define ERXFCON_MPEN	0x08
#define ERXFCON_HTEN	0x04
#define ERXFCON_MCEN	0x02
#define ERXFCON_BCEN	0x01

'  ENC28J60 PHY PHCON1 Register Bit Definitions'
#define PHCON1_PRST	0x8000
#define PHCON1_PLOOPBK	0x4000
#define PHCON1_PPWRSV	0x0800
#define PHCON1_PDPXMD	0x0100
'  ENC28J60 PHY PHSTAT1 Register Bit Definitions'
#define PHSTAT1_PFDPX	0x1000
#define PHSTAT1_PHDPX	0x0800
#define PHSTAT1_LLSTAT	0x0004
#define PHSTAT1_JBSTAT	0x0002
'  ENC28J60 PHY PHSTAT2 Register Bit Definitions'
#define PHSTAT2_TXSTAT	(1 << 13)
#define PHSTAT2_RXSTAT	(1 << 12)
#define PHSTAT2_COLSTAT	(1 << 11)
#define PHSTAT2_LSTAT	(1 << 10)
#define PHSTAT2_DPXSTAT	(1 << 9)
#define PHSTAT2_PLRITY	(1 << 5)
'  ENC28J60 PHY PHCON2 Register Bit Definitions'
#define PHCON2_FRCLINK	0x4000
#define PHCON2_TXDIS	0x2000
#define PHCON2_JABBER	0x0400
#define PHCON2_HDLDIS	0x0100
'  ENC28J60 PHY PHIE Register Bit Definitions'
#define PHIE_PLNKIE	(1 << 4)
#define PHIE_PGEIE	(1 << 1)
'  ENC28J60 PHY PHIR Register Bit Definitions'
#define PHIR_PLNKIF	(1 << 4)
#define PHIR_PGEIF	(1 << 1)

'  ENC28J60 Packet Control Byte Bit Definitions'
#define PKTCTRL_PHUGEEN		0x08
#define PKTCTRL_PPADEN		0x04
#define PKTCTRL_PCRCEN		0x02
#define PKTCTRL_POVERRIDE	0x01

'  ENC28J60 Transmit Status Vector'
#define TSV_TXBYTECNT		0
#define TSV_TXCOLLISIONCNT	16
#define TSV_TXCRCERROR		20
#define TSV_TXLENCHKERROR	21
#define TSV_TXLENOUTOFRANGE	22
#define TSV_TXDONE		23
#define TSV_TXMULTICAST		24
#define TSV_TXBROADCAST		25
#define TSV_TXPACKETDEFER	26
#define TSV_TXEXDEFER		27
#define TSV_TXEXCOLLISION	28
#define TSV_TXLATECOLLISION	29
#define TSV_TXGIANT		30
#define TSV_TXUNDERRUN		31
#define TSV_TOTBYTETXONWIRE	32
#define TSV_TXCONTROLFRAME	48
#define TSV_TXPAUSEFRAME	49
#define TSV_BACKPRESSUREAPP	50
#define TSV_TXVLANTAGFRAME	51

#define TSV_SIZE		7
'#define TSV_BYTEOF(x)		((x) / 8)
'#define TSV_BITMASK(x)		(1 << ((x) % 8))
'#define TSV_GETBIT(x, y)	(((x)[TSV_BYTEOF(y)] & TSV_BITMASK(y)) ? 1 : 0)

'  ENC28J60 Receive Status Vector'
#define RSV_RXLONGEVDROPEV	16
#define RSV_CARRIEREV		18
#define RSV_CRCERROR		20
#define RSV_LENCHECKERR		21
#define RSV_LENOUTOFRANGE	22
#define RSV_RXOK		23
#define RSV_RXMULTICAST		24
#define RSV_RXBROADCAST		25
#define RSV_DRIBBLENIBBLE	26
#define RSV_RXCONTROLFRAME	27
#define RSV_RXPAUSEFRAME	28
#define RSV_RXUNKNOWNOPCODE	29
#define RSV_RXTYPEVLAN		30

#define RSV_SIZE		6
'#define RSV_BITMASK(x)		(1 << ((x) - 16))
'#define RSV_GETBIT(x, y)	(((x) & RSV_BITMASK(y)) ? 1 : 0)


'  SPI operation codes'
#define ENC28J60_READ_CTRL_REG	0x00
#define ENC28J60_READ_BUF_MEM	0x3A
#define ENC28J60_WRITE_CTRL_REG 0x40
#define ENC28J60_WRITE_BUF_MEM	0x7A
#define ENC28J60_BIT_FIELD_SET	0x80
#define ENC28J60_BIT_FIELD_CLR	0xA0
#define ENC28J60_SOFT_RESET	0xFF


'  buffer boundaries applied to internal 8K ram
' entire available packet buffer space is allocated.
' Give TX buffer space for one full ethernet frame (~1500 bytes)
' receive buffer gets the rest'

'moved to script
'#define TXSTART_INIT		0x1A00
'  #define TXSTART_INIT_b		0x00
'  #define TXSTART_INIT_h		0x1A



#define TXEND_INIT		0x1FFF
  #define TXEND_INIT_b		0x1F
  #define TXEND_INIT_h		0xFF

'  Put RX buffer at 0 as suggested by the Errata datasheet'
#define RXSTART_INIT		0x0000
  #define RXSTART_INIT_b		0x00
  #define RXSTART_INIT_h		0x00

#define RXEND_INIT		0x19FF
  #define RXEND_INIT_b		0xFF
  #define RXEND_INIT_h		0x19


'  maximum ethernet frame length'
#define MAX_FRAMELEN		1518

'  Preferred half duplex: LEDA: Link status LEDB: Rx/Tx activity'
#define ENC28J60_LAMPS_MODE	0x3476




Sub Enc28j60regdump
    HSerPrintCRLF
    HSerPrint "Registerdump ENC28J60"

    Enc28j60_data = ENC28J60_ReadReg( erevid)
    HSerPrint " Version: " + str( Enc28j60_data )
    HSerPrintCRLF
    'ok
    HSerPrint "Cntrl: ECON1 ECON2 ESTAT  EIR  EIE"
    HSerPrintCRLF
    Enc28j60_data = ENC28J60_ReadReg( econ1)
    HSerPrint "       " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg( econ2)
    HSerPrint "    " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg( estat)
    HSerPrint "    " + Hex(enc28j60_data);
    ENC28J60_ReadReg (eir)
    HSerPrint "     " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg( eie)
    HSerPrint "   " + Hex(enc28j60_data)
    HSerPrintCRLF
    'ok
    HSerPrint "MAC  : MACON1  MACON2  MACON3  MACON4  MAC-Address"
    HSerPrintCRLF
    Enc28j60_data = ENC28J60_ReadReg( macon1)
    HSerPrint "       " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg( macon2)
    HSerPrint "      " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg( macon3)
    HSerPrint "      " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg( macon4)
    HSerPrint "      " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg( maadr5)
    HSerPrint "      " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg( maadr4)
    HSerPrint "." + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg( maadr3)
    HSerPrint "." + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg( maadr2)
    HSerPrint "." + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg( maadr1)
    HSerPrint "." + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg( maadr0)
    HSerPrint "." + Hex(enc28j60_data)
    HSerPrintCRLF

    HSerPrint "Rx   : ERXST  ERXND  ERXWRPT ERXRDPT ERXFCON EPKTCNT MAMXFL"
    HSerPrintCRLF
    Enc28j60_data = ENC28J60_ReadReg(erxsth)
    HSerPrint "       " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(erxstl)
    HSerPrint Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(erxndh)
    HSerPrint "   " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(erxndl)
    HSerPrint Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(erxwrpth)
    HSerPrint "   " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(erxwrptl)
    HSerPrint Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(erxrdpth)
    HSerPrint "    " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(erxrdptl)
    HSerPrint Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(erxfcon)
    HSerPrint "    " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(epktcnt)
    HSerPrint "      " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(mamxflh)
    HSerPrint "      " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(mamxfll)
    HSerPrint Hex(enc28j60_data)
    HSerPrintCRLF
    HSerPrint "Tx   : ETXST  ETXND  EWRPT  MACLCON1 MACLCON2 MAPHSUP"
    HSerPrintCRLF
    Enc28j60_data = ENC28J60_ReadReg(etxsth)
    HSerPrint "       " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(etxstl)
    HSerPrint Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(etxndh)
    HSerPrint "   " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(etxndl)
    HSerPrint Hex(enc28j60_data);

    Enc28j60_data = ENC28J60_ReadReg(EWRPTH)
    HSerPrint "   " +  Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(EWRPTl)
    HSerPrint Hex(enc28j60_data);


    Enc28j60_data = ENC28J60_ReadReg(maclcon1)
    HSerPrint "   " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(maclcon2)
    HSerPrint "       " + Hex(enc28j60_data);
    Enc28j60_data = ENC28J60_ReadReg(maphsup)
    HSerPrint "       " + Hex(enc28j60_data)
    HSerPrintCRLF 2


End Sub



'/* Read a transmit buffer, for debug purpose */
sub eth_read_at( in position as word, in xlen)
'  /* Save Read Pointers */
  dim pos as word
  bkup_ll = ENC28J60_ReadReg(ERDPTL);
  bkup_hh = ENC28J60_ReadReg(ERDPTH);
'  /* Set Read pointer */
  posl = position &0xff
  ENC28J60_WriteReg(ERDPTL , posl)
  posh = [byte]position_h
  ENC28J60_WriteReg(ERDPTH , posh)

'  /* Read data */
  eth_read(xlen);


'  /* Restore read pointers */
  ENC28J60_WriteReg(ERDPTL , bkup_ll)
  ENC28J60_WriteReg(ERDPTH , bkup_hh)

'  /* Done */
end sub


'/* Read data from the Ethernet buffer at ERDPT location */
sub eth_read( in xlen )

    HSerPrintCRLF
    dim  eth_counter  as word
    ENC28J60_Select
    FastHWSPITransfer( ENC28J60_READ_BUF_MEM , temp)
    for eth_counter = 1 to xlen
      SPITransfer( temp, etherbuffer(eth_counter) )
      HSerPrint hex(etherbuffer(eth_counter))
      HSerPrint ","
    next
    ENC28J60_Deselect
    HSerPrintCRLF

end sub

'
'COCON2:COCON0: Clock Output Configuration bits
'111 = Reserved for factory test. Do not use. Glitch prevention not assured.
'110 = Reserved for factory test. Do not use. Glitch prevention not assured.
'101 = CLKOUT outputs main clock divided by 8 (3.125 MHz)
'100 = CLKOUT outputs main clock divided by 4 (6.25 MHz)
'011 = CLKOUT outputs main clock divided by 3 (8.333333 MHz)
'010 = CLKOUT outputs main clock divided by 2 (12.5 MHz)
'001 = CLKOUT outputs main clock divided by 1 (25 MHz)
'000 = CLKOUT is disabled. The pin is driven low
sub ENC28J60_SetFrequency ( in ENC_Outbyte as byte )

    'Has to be less then 5
     if ENC_Outbyte > 5 then ENC_Outbyte = 5
     ENC28J60_WriteReg( ECOCON, ENC_Outbyte )

end sub


Sub ENC28J60_Setst_mac

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

Sub Arpreply
   'The original request packet is in the buffer, we just change some things

   'Swap MAC addresses
   ENC28J60_Setst_mac

   'Copy target MAC in ARP packet - starting at pos 33, copy from pos 1
   For II = 1 To 6
      etherBuffer(32 + II) = etherBuffer(II)
   Next
   'Set target IP in ARP packet - starting at pos 39, original starting at pos 29
   For II = 1 To 4
      etherBuffer(38 + II) = etherBuffer(28 + II)
   Next

   'Copy source MAC to ARP packet pos 23 from pos 7
   For II = 1 To 6
      etherBuffer(22 + II) = etherBuffer(6 + II)
   Next
   'Set source IP to ARP packet pos 29
   etherBuffer(29) = ipaddr(1)
   etherBuffer(30) = ipaddr(2)
   etherBuffer(31) = ipaddr(3)
   etherBuffer(32) = ipaddr(4)

   'Set ARP type from Request to Reply
   etherBuffer(22) = 2

'      HSerSend 9
'      HSerPrint "       >"
'
'      for ii = 1 to 24
'        HSerPrint hex(etherbuffer(ii))
'        HSerPrint ":"
'      next
'      HSerPrintCRLF

   ' as 60 is the true length of ARP packet
   Enc28j60writebuffer( 42 )
   'Send the reply packet
   Enc28j60packetsend(42)

End Sub


Sub ENC28J60_UDP

  dim T_udp_destport as word
  Dim hulp2 As Word
  T_udp_destport = ( T_udp_destport0 * 256 ) + T_udp_destport1

  select case T_udp_srcport1
      case 0x25
          '0x0025 NTP protocol
          ENC28J60_NTP
          Exit Sub

  end select

  select case T_udp_destport
      case 6000
          if T_udp_data = "R" then
              ENC28J60_Initialise
              goto Restart
          end if

          if T_udp_data = "D" then
              Enc28j60regdump
          end if

      case 5000
         'non-echo on PORT 5000
         Select Case T_udp_data
               Case "A" : HSerPrint "Action A"
               Case "B" : HSerPrint "Action B"
               Case "C" : HSerPrint "Action C"
               Case "D" : HSerPrint "Action D"
               Case "E" : HSerPrint "Action E"
               Case "T" : HserPrint "Time..."
                          ENC28J60_Ntp_get
                          HSerPrintCRLF

               Case "a" : HSerPrint "Action a"
               Case "b" : HSerPrint "Action b"
               Case "c" : HSerPrint "Action c"
               Case "d" : HSerPrint "Action d"
               Case "e" : HSerPrint "Action e"

               Case Else : HSerPrint "Action F"
         End Select
         HSerPrintCRLF
       case 7

          'echo on PORT 7
          'Build The Ip Header
          ENC28J60_Setipaddrs

         'swap the UDP source and destinations port
          Swap T_udp_srcport0 , T_udp_destport0
          Swap T_udp_srcport1 , T_udp_destport1

          ENC28J60_Udp_checksum
          'Packetlength
          Hulp2 = T_udp_len0 * 256
          Hulp2 = Hulp2 + T_udp_len1
          Hulp2 = Hulp2 + 34

          Enc28j60writebuffer( hulp2 )
          Enc28j60packetsend( hulp2 )

  end select

End Sub


' Routine to get the NetWork Time from a time-server
'
Sub ENC28J60_Ntp_get
    'MAC-header
    'Destination hardware address            ' You have to put your router-mac-address here
    T_enetpacketdest0 = macaddrrouter(1)                  ' 00-50-7f-dc-64-48 MAC-address of my router
    T_enetpacketdest1 = macaddrrouter(2)
    T_enetpacketdest2 = macaddrrouter(3)
    T_enetpacketdest3 = macaddrrouter(4)
    T_enetpacketdest4 = macaddrrouter(5)
    T_enetpacketdest5 = macaddrrouter(6)
    ' source (own source)
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
    'protocol (ICMP=1, TCP=6, UDP=11)
    T_ip_proto = 0X11
    'header checksum
    'IP address of source
    T_ip_srcaddr0 = ipaddr(1)
    T_ip_srcaddr1 = ipaddr(2)
    T_ip_srcaddr2 = ipaddr(3)
    T_ip_srcaddr3 = ipaddr(4)
    'IP address of destination                                      'you have to put the IP-number of
'    Nist - time.Nist.gov
'    Nist IP:
'    128.138.141.172
    T_ip_destaddr0 = ntpserveraddr(1)                                            ' the NTP-server here
    T_ip_destaddr1 = ntpserveraddr(2)
    T_ip_destaddr2 = ntpserveraddr(3)
    T_ip_destaddr3 = ntpserveraddr(4)
    'UDP-header
    T_udp_srcport0 = 0X13
    T_udp_srcport1 = 0X88
    T_udp_destport0 = 0X00                                        'port 0025 = 37 NTP
    T_udp_destport1 = 0X25
    T_udp_len0 = 0X00
    T_udp_len1 = 0X1C
    T_udp_data0 = Asc( "X")
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

    ENC28J60_Ip_header_checksum
    ENC28J60_Udp_checksum
'    ENC28J60_Echopacket

    'Packetlength
    Hulp2 = T_udp_len0 * 256
    Hulp2 = Hulp2 + T_udp_len1
    Hulp2 = Hulp2 + 34

    Enc28j60writebuffer( 45 )
    Enc28j60packetsend( hulp2 )

End Sub



' Routine to convert the LONG from the NTP-server in to date and time
'
Sub ENC28J60_NTP
    dim l1 as long

    HSerPrint hex(T_udp_data0)
    HSerPrint hex(T_udp_data1)
    HSerPrint hex(T_udp_data2)
    HSerPrint hex(T_udp_data3)
    HSerPrintCRLF
    L1 = T_udp_data0
    L1_H = T_udp_data1
    L1_U = T_udp_data2
    L1_E   = T_udp_data3
    L2 = L1 + 1139293696
    L2 = L2 + 3600 ' offset UTC + 1 hour
    HserPrint "Date : "
    HSerPrintCRLF
    HserPrint "Time : "
    HSerPrint L2
    HSerPrintCRLF


End Sub

' Routine to calculate the IP-checkum
'
Sub ENC28J60_Udp_checksum

   dim I_chksum32 as long
   dim I_value16, Result16, I_checksum16, Hulp2, I_x as word
   T_udp_chksum0 = 0x00
   T_udp_chksum1 = 0x00

'    tmp = T_id0
'    T_id0 = T_id1
'    T_id1 = tmp
'    T_flags=0x40

   'checksum TCP header
   I_chksum32 = 0
   I_value16 = 0

   I_chksum32 = I_value16 + I_chksum32

   I_value16 = FnLsl( T_ip_srcaddr2, 8 ) + T_ip_srcaddr3
   I_chksum32 = I_value16 + I_chksum32

   I_value16 = FnLsl( T_ip_destaddr0, 8 ) + T_ip_destaddr1
   I_chksum32 = I_value16 + I_chksum32

   I_value16 = FnLsl( T_ip_destaddr2, 8 ) + T_ip_destaddr3
   I_chksum32 = I_value16 + I_chksum32

   'proto
   I_chksum32 = I_chksum32 + T_ip_proto


   'packet length
   I_value16 = FnLsl( T_udp_len0, 8 ) + T_udp_len1
   I_chksum32 = I_value16 + I_chksum32


   I_odd = T_udp_len1 Mod 2
   Result16 = FnLsl( T_udp_len0, 8 ) + T_udp_len1

   Hulp1 = 0x2B
   Hulp2 = 0x2B + Result16
   Hulp2 = Hulp2 - 12

   For I_x = Hulp1 To Hulp2 Step 2
      I_value16 = FnLsl( etherbuffer(i_x), 8 )
      Hulp3 = I_x + 1
      I_value16 = I_value16 + etherbuffer(hulp3)
      I_chksum32 = I_chksum32 + I_value16
   Next I_x
   If I_odd = 1 Then
      Hulp2 = Hulp2 + 3
'      I_value16 = 0
      I_value16 = FnLsl( etherbuffer(hulp2), 8 )
      'I_value16l = 0
      I_chksum32 = I_chksum32 + I_value16
   End If

   'was changed to .... below.. I_checksum16 = Highw(i_chksum32)

   I_checksum16 =  FnLsr( i_chksum32, 16 )

   I_checksum16 = I_checksum16 + [word]I_chksum32                 ' only 16 lower bits of i_chksum32 is taken...

   I_checksum16 = Not I_checksum16

   T_udp_chksum0 = i_checksum16_h
   T_udp_chksum1 = i_checksum16
   T_udp_chksum0 = 0
   T_udp_chksum1 = 0


End Sub

Sub ENC28J60_Setipaddrs
   T_ip_destaddr0 = T_ip_srcaddr0
   T_ip_destaddr1 = T_ip_srcaddr1
   T_ip_destaddr2 = T_ip_srcaddr2
   T_ip_destaddr3 = T_ip_srcaddr3

   'make ethernet module IP address source address
   T_ip_srcaddr0 = ipaddr(1)
   T_ip_srcaddr1 = ipaddr(2)
   T_ip_srcaddr2 = ipaddr(3)
   T_ip_srcaddr3 = ipaddr(4)

   ENC28J60_Setst_mac
   ENC28J60_Ip_header_checksum
'   Calcchecksum(15 , 33 , 25)
End Sub

' Routine to echo packet
'ERV NOT REQUIRED
Sub ENC28J60_Echopacket
   Dim hulp2 As Word
   'Print "Echopacket"
   'packetlengte
   Hulp2 = T_udp_len0 * 256
   Hulp2 = Hulp2 + T_udp_len1
   Hulp2 = Hulp2 + 34
   Enc28j60packetsend(hulp2)
End Sub

Sub ENC28J60_Ip_header_checksum
    Dim Ip_x As Byte
    Dim Ip_hulp1 As Byte
    Dim Ip_chksum32 As Long
    Dim Ip_checksum16 As Word
    Dim Ip_temp16 As Word
    Dim Ip_header_length As Byte
    Dim Val2 as word
    'calculate the IP header checksum
    T_ip_hdr_cksum = 0x00
    I_chksum32 = 0
    Ip_header_length = T_ip_vers_len And 0x0F

    Ip_header_length = 4 * Ip_header_length

    I_chksum32 = 0
    I_odd = 0

    Val1 = 15
    Val2 = 0x0E + Ip_header_length - 1
    T_ip_hdr_cksum0 = 0
    T_ip_hdr_cksum1 = 0
    General_part_checksum(val1 , Val2)
    T_ip_hdr_cksum0 = Val3
    T_ip_hdr_cksum1 = Val4

End Sub

'' Overall routine for checksum
''
'Sub General_part_checksum( in Val1 As Byte , in Val2 As Word)
'    dim I_value16, I_x as word
'HSerPrintCRLF
'HSerPrint val1
'HSerSend 9
'HSerPrint val2
'
'HSerPrintCRLF
'
'    For I_x = Val1 To Val2 Step 2
''        I_value16h = etherBuffer(i_x)
''        Hulp3 = I_x + 1
''        I_value16l = etherBuffer(hulp3)
'HSerPrint hex(etherbuffer(i_x))
'HSerPrint" "
'        I_value16 = FnLsl( etherbuffer(i_x), 8 )
'        Hulp3 = I_x + 1
'HSerPrint hex(etherbuffer(hulp3))
'HSerPrint " "
'
'        I_value16 = I_value16 + etherBuffer(hulp3)
'        I_chksum32 = I_chksum32 + I_value16
'    Next I_x
'
'    If I_odd = 1 Then
'        Val2 = Val2 + 3
'HSerPrint hex(etherbuffer(val2))
'HSerPrint " * "
'HSerPrintCRLF
'
'        I_value16 = FnLsl( etherbuffer(val2), 8 )
'        I_chksum32 = I_chksum32 + I_value16
'    End If
'    'todo erv
'
'    I_checksum16 = (i_chksum32_e*256)+i_chksum32_u
'    I_checksum16 = I_checksum16 + I_chksum32 ' only 16 lower bits of i_chksum32 is taken...
'    I_checksum16 = Not I_checksum16
'    Val3 = i_checksum16_h
'    'todo erv
'    Val4 = i_checksum16
'End Sub

' Overall routine for checksum
'
Sub General_part_checksum( in Val1 As Byte , in Val2 As Word)
    dim I_value16, I_x as word
    dim I_chksum32 as long
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

'    HSerPrint hex(I_checksum16_h)
'    HSerPrint hex(I_checksum16)
'    HSerPrintCRLF
    I_checksum16 = I_checksum16 + I_chksum32 ' only 16 lower bits of i_chksum32 is taken...
'    HSerPrint hex(I_checksum16_h)
'    HSerPrint hex(I_checksum16)
'    HSerPrintCRLF

    I_checksum16 = Not I_checksum16
'    HSerPrint hex(I_checksum16_h)
'    HSerPrint hex(I_checksum16)
'    HSerPrintCRLF

    Val3 = i_checksum16_h
    Val4 = i_checksum16
'    HSerPrint hex(val3)
'    HSerPrint hex(val4)
'    HSerPrintCRLF



End Sub

Sub Pingreply
   'The original request packet is in the buffer, we just change some things
   Dim Packetlength As Word

   'Swap MAC addresses
   ENC28J60_Setst_mac

   'Set IP ID field
   Setip_id

   'Swap IP addresses
   Setst_ip

   'Zero out original IP checksum fields
   etherBuffer(25) = 0
   etherBuffer(26) = 0
   'Calc new IP checksum
   Calcchecksum(15 , 33 , 25)

   'Set ICMP type to Echo reply
   etherBuffer(35) = 0
   'Zero out original ICPM checksum fields
   etherBuffer(37) = 0
   etherBuffer(38) = 0
   'Calc new ICPM checksum, length calculated from IP packet length
   Packetlength = etherBuffer(17) * 256
   Packetlength = Packetlength + etherBuffer(18)
   Packetlength = Packetlength + 13                         'We are going to calculate the checksum till the end of packet (IP length + 14 byte of the ethernet stuff), -1 to get word start
   Calcchecksum(35 , Packetlength , 37)

   'Setting packetlength to the correct value
   Packetlength = Packetlength + 1
   Enc28j60writebuffer( packetlength )
   'Send the reply packet
   Enc28j60packetsend(packetlength)

End Sub

Sub Setip_id
   etherBuffer(19) = ip_id_h
   etherBuffer(20) = [byte]ip_id
   Ip_id = Ip_id + 1
End Sub

Sub Setst_ip
   Dim II As Byte
   'Set target IP in IP header - starting at pos 31, original starting at pos 27
   For II = 1 To 4
      etherBuffer(30 + II) = etherBuffer(26 + II)
   Next I
   'Set source IP in IP header, pos 27
   etherBuffer(27) = ipaddr(1)
   etherBuffer(28) = ipaddr(2)
   etherBuffer(29) = ipaddr(3)
   etherBuffer(30) = ipaddr(4)
End Sub

Sub Calcchecksum( in startptr As Word , in Endptr As Word , in Result As Word)
  Dim II As Word
  Dim LocalTmp As Word
  Dim Sum As Long
  Sum = 0
  For II = Startptr To Endptr Step 2
      Sum = Sum + etherBuffer(II + 1)
      LocalTmp  = etherBuffer(II) * 256
      Sum = Sum + LocalTmp
  Next I
  II = FnLsr( sum, 16 )
  LocalTmp  = [word]Sum
  LocalTmp  = LocalTmp  + II
  LocalTmp  = Not LocalTmp
  etherBuffer(result) = LocalTmp_h
  etherBuffer(result + 1) = [byte]LocalTmp
End Sub

Sub xCalcchecksum(startptr As Word , Endptr As Word , Result As Word)
  Dim Ii As Word
  Dim Tmp As Word
  Dim Sum As Long
  Sum = 0
  For Ii = Startptr To Endptr Step 2
      Sum = Sum + etherbuffer(ii + 1)
      Tmp = etherbuffer(ii) * 256
      Sum = Sum + Tmp
  Next I
  Ii = sum_e+sum_u
  Tmp = Sum
  Tmp = Tmp + Ii
  Tmp = Not Tmp
  etherbuffer(result) = tmp_h
  etherbuffer(result + 1) = [byte]tmp
End Sub
