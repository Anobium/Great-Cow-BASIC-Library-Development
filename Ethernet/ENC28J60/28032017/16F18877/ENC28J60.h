''FILE:ENC28J60.h

'
'It is needed to called EtherParameters to setup the essential variables before we call any hardware specific methods.
#startup  EtherParameters 99

#define Ethernet_Initialise  ENC28j60_Init

#define ETHERNET_TYPE                 ETHERNET_TYPE_ENC28j60
#define ENC28j60_SPI_Command          SPIMode MasterSlow, 0

    #Define ENC28j60_DI     Ethernet_DI
    #Define ENC28j60_DO     Ethernet_DO
    #Define ENC28j60_SCK    Ethernet_SCK
    #Define ENC28j60_CS     Ethernet_CS
    #Define ENC28j60_RESET  Ethernet_RESET


sub ENC28j60_Init( in macaddr() )

      ''' Device ChipSelect control
      '''
      #define ENC28j60_Select         Set ENC28j60_CS off
      #define ENC28j60_Deselect       Set ENC28j60_CS on
      #define ENC28j60_Reset_CMD      Set ENC28j60_RESET on: Wait 20 ms :Set ENC28j60_RESET off: Wait 20 ms :Set ENC28j60_RESET on: Wait 20 ms


      Dir ENC28j60_DI in
      Dir ENC28j60_DO Out
      Dir ENC28j60_SCK Out
      Dir ENC28j60_CS out
      Dir ENC28j60_RESET out

      'Initial state of ports required for SW SPI
      set ENC28j60_DO off
      set ENC28j60_SCK off
      set ENC28j60_CS off


      'Reset the NIC
      ENC28j60_Deselect

      Repeat 5
          ENC28j60_Reset_CMD
      End Repeat

      ENC28j60_Select
      ENC28j60_SPI_Command
      FastHWSPITransfer( ENC28j60_SOFT_RESET, temp )

      lastselectedBank = 99
      wait while ( (ENC28j60_ReadReg( ESTAT ) & ESTAT_CLKRDY ) <> ESTAT_CLKRDY)

      'Initialize NIC
      ENC28j60_writeReg(ECON1, 0xC1) 'Hold it in Reset
      ENC28j60_writeReg(ECON2, 0x80) 'Set the AUTOINC bit

      'Configure interrupts
      ENC28j60_writeReg(EIR, 0x00) 'Reset interrupt flags
      ENC28j60_writeReg(EIE,  0xC1)  'Interrupts: Packet reception and buffer errors
      ENC28j60_writeReg(EWOLIE, 0x00)  'Disable wake-on-lan interrupts
      ENC28j60_writeReg(EWOLIR, 0x00)  'Clear wake-on-lan interrupt flags

      'Allocate TX & RX buffers
      ENC28j60_writeReg(ETXSTL, ENC_TXBUF_STL)
      ENC28j60_writeReg(ETXSTH, ENC_TXBUF_STH)
      ENC28j60_writeReg(ETXNDL, ENC_TXBUF_NDL)
      ENC28j60_writeReg(ETXNDH, ENC_TXBUF_NDH)  'TX Buffer : 1800 bytes
      ENC28j60_writeReg(ERXSTL, ENC_RXBUF_STL)
      ENC28j60_writeReg(ERXSTH, ENC_RXBUF_STH)
      ENC28j60_writeReg(ERXNDL, ENC_RXBUF_NDL)
      ENC28j60_writeReg(ERXNDH, ENC_RXBUF_NDH)  'RX Buffer : 6390 bytes
      ENC28j60_writeReg(ERDPTL, ENC_RXBUF_STL)
      ENC28j60_writeReg(ERDPTH, ENC_RXBUF_STH)

      ENC28j60_writeReg(ERXRDPTL, ENC_RXBUF_STL)
      ENC28j60_writeReg(ERXRDPTH, ENC_RXBUF_STH) 'RX Pointers (same)

      nextpacketptr = ENC_RXBUF_ST

      'Set Receive Filters
'      ENC28j60_writeReg( ERXFCON, 0xA1) 'Receive unicasts or broadcasts


' For broadcast packets we allow only ARP packtets
' All other packets should be unicast only for our mac (MAADR)
'
' The pattern to match on is therefore
' Type     ETH.DST
' ARP      BROADCAST
' 06 08 -- ff ff ff ff ff ff -> ip checksum for theses bytes=f7f9
' in binary these poitions are:11 0000 0011 1111
' This is hex 303F->EPMM0=0x3f,EPMM1=0x30

'      ENC28j60_writeReg( EPMCSH, 0xf7)
'      ENC28j60_writeReg( EPMCSL, 0xf9)
'      ENC28j60_writeReg( EPMM0, 0x3f)
'      ENC28j60_writeReg( EPMM1, 0x30)

'      ENC28j60_bitClear( ERXFCON, ERXFCON_ANDOR ) 'Set filter bit
'
'      Enc28j60_bitSet( ERXFCON, ERXFCON_UCEN ) 'Set filter bit
'
'      ENC28j60_bitClear( ERXFCON, ERXFCON_CRCEN ) 'Set filter bit
'
'      Enc28j60_bitSet( ERXFCON, ERXFCON_BCEN ) 'Set filter bit
'
'      ENC28j60_bitClear( ERXFCON, ERXFCON_MPEN ) 'UnSet filter bit
'
'      Enc28j60_bitSet( ERXFCON, ERXFCON_PMEN ) 'Set filter bit

'      ENC28j60_writeReg( ERXFCON, ERXFCON_UCEN | ERXFCON_MCEN | ERXFCON_BCEN | ERXFCON_PMEN)
;      Cannot get filter to Work, so use the folllowing
      ENC28j60_writeReg( ERXFCON, ERXFCON_CRCEN )

      'Miscancellous
      ENC28j60_writeReg(EFLOCON, 0x00) 'Disable flow control sending
      ENC28j60_writeReg(ECOCON, 0x00) 'Disable Clock Out pin
      ENC28j60_writeReg(EBSTCON, 0x00) 'Disable built-in self test controller

      'Wait for the MAC & PHY parts to be operational
      wait while ( (ENC28j60_ReadReg(ESTAT) & ESTAT_CLKRDY) <> ESTAT_CLKRDY)

      'Initialize MII interface
      ENC28j60_writeReg(MISTAT, 0x00)  'Clear MII status register
      ENC28j60_writeReg(MICMD, 0x00)   'Clear MII command register
'      ENC28j60_writeReg(MICON1, 0x02)  'Fast MII operation
'      ENC28j60_writeReg(MICON2, 0x00)  'Release MII interface from reset

      'Initialize MAC subsystem
      ENC28j60_writeReg(MACON1, b'00001101' )  'Enable packet reception
'      ENC28j60_writeReg(MACON2, 0x00)  'Release the MAC subsystem from reset
'      ENC28j60_writeReg(MACON3, 0xB1)  'Auto Pad + CRC + Full Duplex
      ENC28j60_writeReg(MACON3, 0x32)  'Auto Pad to 60 bytes + CRC + Half Duplex + Check frame length
      ENC28j60_writeReg(MACON4, 0x01)  'Need valid preamble
'      ENC28j60_writeReg(MAPHSUP, b'00010000') 'Release MAC-PHY support from Reset
      ENC28j60_writeReg(MAMXFLL, 0xEE)
      ENC28j60_writeReg(MAMXFLH, 0x05)  'Maximum frame length
      ENC28j60_writeReg(MABBIPG, 0x12) 'IEEE BTB Inter Packet Gap
      ENC28j60_writeReg(MAIPGL, 0x12)
      ENC28j60_writeReg(MAIPGH, 0x0C)  'IEEE Non BTB Inter Packet Gap

      'Leave MACLCON1 and MACLCON2 to their default values
      'Set MAC Address
      ENC28j60_writeReg(MAADR0, macaddr(2))
      ENC28j60_writeReg(MAADR1, macaddr(1))
      ENC28j60_writeReg(MAADR2, macaddr(4))
      ENC28j60_writeReg(MAADR3, macaddr(3))
      ENC28j60_writeReg(MAADR4, macaddr(6))
      ENC28j60_writeReg(MAADR5, macaddr(5))



'      'Initialize PHY subsystem
      ENC28j60_writePhyReg(PHCON1, 0x00, 0x00)  'Half duplex
      ENC28j60_writePhyReg(PHCON2, 0x00, 0x00)
      ENC28j60_writePhyReg(PHLCON, B'00000100', B'01110110')
      ENC28j60_writePhyReg(PHIE, 0x00, 0x00)  'Disable interrupts

      'Initialization done, release the NIC from reset
      ENC28j60_writeReg(ECON1, B'00010100')
'      ENC28j60_writeReg(ECON1, B'00000100')
      'We are done!!
      'A real highLIGHT, a led test. If your RJ45-connector has LED's for LINK and DATA you can test them with this small line. Put it somewhere after the ENC28j60init.
      'Set address of PHY register to write
'      ENC28j60_writePhyReg ( PHLCON, 0xA2, 0x0A )
'      wait 5 s

      'Set LEDs to the normal settings
       ENC28j60_writePhyReg ( PHLCON, 0x76, 0x04 )

End Sub





'/* Sets bits in a register */
Sub ENC28j60_bitSet( in addr,  in ENC_Outbyte as byte )
'       banktobeselected = ( addr & BANK_MASK) / 32
'        HSerPrintByteCRLF banktobeselected

        banktobeselected = ( addr & BANK_MASK)
        Repeat 5
            set c off
            rotate banktobeselected right
        end repeat
'        HSerPrintByteCRLF banktobeselected
'        HSerPrintCRLF

        if lastselectedBank <> banktobeselected then
          if ( ( addr & ADDR_MASK )  <= EIE  ) then
              ENC28j60_selectBank ( banktobeselected, addr )
          end if
        Else
          lastselectedBank = banktobeselected
        end if

        ENC28j60_Select
        FastHWSPITransfer( ENC28j60_BIT_FIELD_SET | (addr AND ADDR_MASK ), temp )
        FastHWSPITransfer( ENC_Outbyte, temp )
        ENC28j60_Deselect

end sub


Sub ENC28j60_bitClear( in addr,  in ENC_Outbyte as byte )
'       banktobeselected = ( addr & BANK_MASK) / 32
        banktobeselected = ( addr & BANK_MASK)
        Repeat 5
            set c off
            rotate banktobeselected right
        end repeat

        if lastselectedBank <> banktobeselected then
          if ( ( addr & ADDR_MASK )  <= EIE  ) then
              ENC28j60_selectBank ( banktobeselected, addr )
          end if
        Else
          lastselectedBank = banktobeselected
        end if

        ENC28j60_Select
        FastHWSPITransfer( ENC28j60_BIT_FIELD_CLR | (addr AND ADDR_MASK ), temp )
        FastHWSPITransfer( ENC_Outbyte, temp )
        ENC28j60_Deselect

end sub


Sub ENC28j60_writebuffer ( in pcktlen As Word )

    dim eth_counter as Word

    'set the write pointer to start of transmit buffer area
    ENC28j60_writeReg(ewrptl, ENC_TXBUF_STL)
    ENC28j60_writeReg(ewrpth, ENC_TXBUF_STH)

    'Send as fast as we can
    ENC28j60_Select

   'Send Read address
    Set WCOL Off
    'Put byte to send into buffer
    'Will start transfer
    SSPBUF = ENC28j60_write_buf_mem
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
    ENC28j60_Deselect


End Sub

; writes byte ENC_Outbyte in ENC register addr of the current bank
sub ENC28j60_writeReg( in addr,  in ENC_Outbyte as byte )
'       banktobeselected = ( addr & BANK_MASK) / 32
        banktobeselected =  ( addr & BANK_MASK)
        Repeat 5
            set c off
            rotate banktobeselected right
        end Repeat

        if lastselectedBank <> banktobeselected then
          if ( ( addr & ADDR_MASK )  <= EIE  ) then
              ENC28j60_selectBank ( banktobeselected, addr )
          end if
        Else
          lastselectedBank = banktobeselected
        end if

        ENC28j60_Select
        FastHWSPITransfer( ENC28j60_WRITE_CTRL_REG | (addr AND ADDR_MASK ), temp )
        FastHWSPITransfer( ENC_Outbyte, temp )
        ENC28j60_Deselect

end sub


sub ENC28j60_writePhyReg( in PhyRegaddr,  in ENC_Outbyte1 as byte , in ENC_Outbyte2 as byte )

        'Wait for the MII interface to be ready
        while ((ENC28j60_ReadReg(MISTAT) & MISTAT_BUSY ) = MISTAT_BUSY )
        ENC28j60_writeReg( MIREGADR, PhyRegaddr )
        ENC28j60_writeReg( MIWRL, ENC_Outbyte1 )
        ENC28j60_writeReg( MIWRH, ENC_Outbyte2 )

        'Wait for the MII interface to be ready
        wait while ( (ENC28j60_ReadReg( MISTAT ) & MISTAT_BUSY ) = MISTAT_BUSY )

end sub


Sub ENC28j60_regdump

#define ENC28j60_Detailed_RegDump
    HSerPrintCRLF
    HSerPrint "Registerdump ENC28j60"

    ENC28j60_data = ENC28j60_ReadReg( erevid)
    HSerPrint " ENC Rev " + str( ENC28j60_data )
    HSerPrint " Build 037"
    HSerPrintCRLF

    HSerPrintCRLF

    'ok
    HSerPrint "Cntrl: ECON1 ECON2 ESTAT  EIR  EIE"
    HSerPrintCRLF
    ENC28j60_data = ENC28j60_ReadReg( econ1)
    HSerPrint "       " + Hex(ENC28j60_data)
    ;
    ENC28j60_data = ENC28j60_ReadReg( econ2)
    HSerPrint "    " + Hex(ENC28j60_data);

    ENC28j60_data = ENC28j60_ReadReg( estat)
    HSerPrint "    " + Hex(ENC28j60_data);

    ENC28j60_data = ENC28j60_ReadReg (eir)
    HSerPrint "     " + Hex(ENC28j60_data);

    ENC28j60_data = ENC28j60_ReadReg( eie)
    HSerPrint "   " + Hex(ENC28j60_data)
    HSerPrintCRLF

    'ok
    HSerPrint "MAC  : MACON1  MACON3  MACON4  MAC-Address"
    HSerPrintCRLF
    ENC28j60_data = ENC28j60_ReadReg( macon1)
    HSerPrint "       " + Hex(ENC28j60_data);
'    ENC28j60_data = ENC28j60_ReadReg( macon2)
'    HSerPrint "      " + Hex(ENC28j60_data);
    ENC28j60_data = ENC28j60_ReadReg( macon3)
    HSerPrint "      " + Hex(ENC28j60_data);
    ENC28j60_data = ENC28j60_ReadReg( macon4)
    HSerPrint "      " + Hex(ENC28j60_data);
    ENC28j60_data = ENC28j60_ReadReg( maadr5)
    HSerPrint "      " + Hex(ENC28j60_data);
    ENC28j60_data = ENC28j60_ReadReg( maadr4)
    HSerPrint "." + Hex(ENC28j60_data);
    ENC28j60_data = ENC28j60_ReadReg( maadr3)
    HSerPrint "." + Hex(ENC28j60_data);
    ENC28j60_data = ENC28j60_ReadReg( maadr2)
    HSerPrint "." + Hex(ENC28j60_data);
    ENC28j60_data = ENC28j60_ReadReg( maadr1)
    HSerPrint "." + Hex(ENC28j60_data);
    ENC28j60_data = ENC28j60_ReadReg( maadr0)
    HSerPrint "." + Hex(ENC28j60_data)
    HSerPrintCRLF

    HSerPrint "Rx   : ERXST  ERXND  ERXWRPT ERXRDPT ERXFCON EPKTCNT MAMXFL"
    HSerPrintCRLF
    ENC28j60_data = ENC28j60_ReadReg(erxsth)
    HSerPrint "       " + Hex(ENC28j60_data);
    ENC28j60_data = ENC28j60_ReadReg(erxstl)
    HSerPrint Hex(ENC28j60_data);

    ENC28j60_data = ENC28j60_ReadReg(erxndh)
    HSerPrint "   " + Hex(ENC28j60_data);
    ENC28j60_data = ENC28j60_ReadReg(erxndl)
    HSerPrint Hex(ENC28j60_data);

dim t1, t2 as word
    ENC28j60_data = ENC28j60_ReadReg(erxwrpth)
    HSerPrint "   " + Hex(ENC28j60_data);
    t1_h = ENC28j60_data
    ENC28j60_data = ENC28j60_ReadReg(erxwrptl)
    HSerPrint Hex(ENC28j60_data);
    [byte]t1 = ENC28j60_data

    ENC28j60_data = ENC28j60_ReadReg(erxrdpth)
    HSerPrint "    " + Hex(ENC28j60_data);
    t2_h = ENC28j60_data
    ENC28j60_data = ENC28j60_ReadReg(erxrdptl)
    HSerPrint Hex(ENC28j60_data);
    [byte]t2 = ENC28j60_data


    'Byte value to show. The ERXFCON: ETHERNET RECEIVE FILTER CONTROL REGISTER
    ENC28j60_data = ENC28j60_ReadReg(erxfcon)
    HSerPrint "    " + Hex(ENC28j60_data);

    'Byte value to show
    ENC28j60_data = ENC28j60_ReadReg(epktcnt)
    HSerPrint "      " + Hex(ENC28j60_data);

    'Byte value to show. Maximum Frame Length hi Byte
    ENC28j60_data = ENC28j60_ReadReg(mamxflh)
    HSerPrint "      " + Hex(ENC28j60_data);

    'Byte value to show. Maximum Frame Length lo Byte
    ENC28j60_data = ENC28j60_ReadReg(mamxfll)
    HSerPrint Hex(ENC28j60_data)


    HSerPrintCRLF
    HSerPrint "Tx   : ETXST  ETXND  EWRPT  MACLCON1 MACLCON2"
    HSerPrintCRLF
    ENC28j60_data = ENC28j60_ReadReg(etxsth)
    HSerPrint "       " + Hex(ENC28j60_data);
    ENC28j60_data = ENC28j60_ReadReg(etxstl)
    HSerPrint Hex(ENC28j60_data);
    ENC28j60_data = ENC28j60_ReadReg(etxndh)
    HSerPrint "   " + Hex(ENC28j60_data);
    ENC28j60_data = ENC28j60_ReadReg(etxndl)
    HSerPrint Hex(ENC28j60_data);

    ENC28j60_data = ENC28j60_ReadReg(EWRPTH)
    HSerPrint "   " +  Hex(ENC28j60_data);
    ENC28j60_data = ENC28j60_ReadReg(EWRPTl)
    HSerPrint Hex(ENC28j60_data);


    ENC28j60_data = ENC28j60_ReadReg(maclcon1)
    HSerPrint "   " + Hex(ENC28j60_data);
    ENC28j60_data = ENC28j60_ReadReg(maclcon2)
    HSerPrint "       " + Hex(ENC28j60_data);
'    ENC28j60_data = ENC28j60_ReadReg(maphsup)
'    HSerPrint "       " + Hex(ENC28j60_data)
    HSerPrintCRLF 2


End Sub


sub ENC28j60_selectBank ( in banktobeselected, in addr )

        'Set to ENC memory bank addr
        ENC28j60_Select
        FastHWSPITransfer(BFCCMD | ECON1, temp)
        FastHWSPITransfer(b'00000011', temp)
        ENC28j60_Deselect

        'Set to ENC memory bank addr
        ENC28j60_Select
        FastHWSPITransfer(BFSCMD | ECON1, temp)
        Select case banktobeselected

          case 1

            FastHWSPITransfer(b'00000001' , temp)

          case 2

            FastHWSPITransfer(b'00000010' , temp)

          case 3

            FastHWSPITransfer(b'00000011' , temp)

        End Select
        ENC28j60_Deselect
        lastselectedBank = banktobeselected
end sub

'COCON2:COCON0: Clock Output Configuration bits
'111 = Reserved for factory test. Do not use. Glitch prevention not assured.
'110 = Reserved for factory test. Do not use. Glitch prevention not assured.
'101 = CLKOUT outputs main clock divided by 8 (3.125 MHz)
'100 = CLKOUT outputs main clock divided by 4 (6.25 MHz)
'011 = CLKOUT outputs main clock divided by 3 (8.333333 MHz)
'010 = CLKOUT outputs main clock divided by 2 (12.5 MHz)
'001 = CLKOUT outputs main clock divided by 1 (25 MHz)
'000 = CLKOUT is disabled. The pin is driven low
sub ENC28j60_setfrequency ( in ENC_Outbyte as byte )

    'Has to be less then 5
     if ENC_Outbyte > 5 then ENC_Outbyte = 5
     ENC28j60_WriteReg( ECOCON, ENC_Outbyte )

end sub




Sub ENC28j60_readbuffer( optional in etherGetLength as word = 1 )
  dim eth_counter as Word
'ENC28j60_regdump
'  if etherGetLength  > 1518 then Exit Sub

  ' Initiate SPI command
  ENC28j60_Select
  ' Send command

  ' Read bytes
  Set WCOL Off
  'Send Read Buffer Memory command
  SSPBUF = ENC28j60_READ_BUF_MEM
  Wait While BF = Off
  'Set data result
  temp = SSPBUF


  for eth_counter = 1 to etherGetLength
    if eth_counter > etherBufferSize then
        exit for
    end if
    SSPBUF = 0
    Wait While BF = Off
    etherbuffer( eth_counter ) = SSPBUF
  next



  if etherGetLength > etherBufferSize then

    for eth_counter = etherBufferSize+1 to etherGetLength
      SSPBUF = 0
      Wait While BF = Off
      temp = SSPBUF
    next

  End if

  #ifdef debug
      HSersend 9
      HSerPrint " Rd: 0x"
      HSerPrint eth_counter
      HSersend 9
  #endif

  ' Finish SPI command
  ENC28j60_Deselect
End Sub

function ENC28j60_readReg( in addr ) as byte
'        banktobeselected =  ( addr & BANK_MASK) / 32
        banktobeselected =  ( addr & BANK_MASK)
        Repeat 5
            set c off
            rotate banktobeselected right
        end repeat
'HSerPrint "$"
'HSerPrint banktobeselected
'HSerPrint ":"
'       'These registers (EIE, EIR, ESTAT, ECON2, ECON1)
'       'are present in all banks, no need to switch bank
        if lastselectedBank <> banktobeselected then

          if ( ( addr & ADDR_MASK ) <= EIE  ) then
              ENC28j60_selectBank ( banktobeselected, addr )
          else
              lastselectedBank = banktobeselected
          end if
        end if

        ENC28j60_Select

        #ifdef PIC
             'Send Read address
              Set WCOL Off
              'Put byte to send into buffer
              'Will start transfer
              SSPBUF = ENC28j60_READ_CTRL_REG | ( addr AND ADDR_MASK )
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
              ENC28j60_ReadReg = SSPBUF
        #endif

        #ifdef aVR

        #endif
        ENC28j60_Deselect


end function




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
'Set ENC28j60 Memory locations
#script

' Buffer boundaries applied to internal 8K ram
' Entire available packet buffer space is allocated.
' Give TX buffer space for one full ethernet frame (~1500 bytes)
' Receive buffer gets the remainder

  TXSTART_INIT  = 0x1A00
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


' ENC28j60 Control Registers
#define WCRCMD  b'01000000'      ; write control register
#define BFCCMD  b'10100000'      ; bit field clear
#define BFSCMD  b'10000000'      ; bit field set

' Control register definitions are a combination of address,
' bank number, and Ethernet/MAC/PHY indicator bits.
' - Register address  (bits 0-4)
' - Bank number (bits 5-6)
' - MAC/MII indicator (bit 7)
'
#define ADDR_MASK 0x1F
#define BANK_MASK 0x60
#define SPRD_MASK 0x80
'  All-bank registers'
#define BANK0   0
#define BANK1   1
#define BANK2   2
#define BANK3   3


#define EIE   0x1B
#define EIR   0x1C
#define ESTAT   0x1D
#define ECON2   0x1E
#define ECON1   0x1F
'  Bank 0 registers'
#define ERDPTL    (0x00|0x00)
#define ERDPTH    (0x01|0x00)
#define EWRPTL    (0x02|0x00)
#define EWRPTH    (0x03|0x00)
#define ETXSTL    (0x04|0x00)
#define ETXSTH    (0x05|0x00)
#define ETXNDL    (0x06|0x00)
#define ETXNDH    (0x07|0x00)
#define ERXSTL    (0x08|0x00)
#define ERXSTH    (0x09|0x00)
#define ERXNDL    (0x0A|0x00)
#define ERXNDH    (0x0B|0x00)
#define ERXRDPTL  (0x0C|0x00)
#define ERXRDPTH  (0x0D|0x00)
#define ERXWRPTL  (0x0E|0x00)
#define ERXWRPTH  (0x0F|0x00)
#define EDMASTL   (0x10|0x00)
#define EDMASTH   (0x11|0x00)
#define EDMANDL   (0x12|0x00)
#define EDMANDH   (0x13|0x00)
#define EDMADSTL  (0x14|0x00)
#define EDMADSTH  (0x15|0x00)
#define EDMACSL   (0x16|0x00)
#define EDMACSH   (0x17|0x00)
'  Bank 1 registers'
#define EHT0    (0x00|0x20)
#define EHT1    (0x01|0x20)
#define EHT2    (0x02|0x20)
#define EHT3    (0x03|0x20)
#define EHT4    (0x04|0x20)
#define EHT5    (0x05|0x20)
#define EHT6    (0x06|0x20)
#define EHT7    (0x07|0x20)
#define EPMM0   (0x08|0x20)
#define EPMM1   (0x09|0x20)
#define EPMM2   (0x0A|0x20)
#define EPMM3   (0x0B|0x20)
#define EPMM4   (0x0C|0x20)
#define EPMM5   (0x0D|0x20)
#define EPMM6   (0x0E|0x20)
#define EPMM7   (0x0F|0x20)
#define EPMCSL    (0x10|0x20)
#define EPMCSH    (0x11|0x20)
#define EPMOL   (0x14|0x20)
#define EPMOH   (0x15|0x20)
#define EWOLIE    (0x16|0x20)
#define EWOLIR    (0x17|0x20)
#define ERXFCON   (0x18|0x20)
#define EPKTCNT   (0x19|0x20)
'  Bank 2 registers'
#define MACON1    (0x00|0x40|SPRD_MASK)
'  #define MACON2 (0x01|0x40|SPRD_MASK)'
#define MACON3    (0x02|0x40|SPRD_MASK)
#define MACON4    (0x03|0x40|SPRD_MASK)
#define MABBIPG   (0x04|0x40|SPRD_MASK)
#define MAIPGL    (0x06|0x40|SPRD_MASK)
#define MAIPGH    (0x07|0x40|SPRD_MASK)
#define MACLCON1  (0x08|0x40|SPRD_MASK)
#define MACLCON2  (0x09|0x40|SPRD_MASK)
#define MAMXFLL   (0x0A|0x40|SPRD_MASK)
#define MAMXFLH   (0x0B|0x40|SPRD_MASK)
'#define MAPHSUP    (0x0D|0x40|SPRD_MASK)
'#define MICON    (0x11|0x40|SPRD_MASK)
#define MICMD   (0x12|0x40|SPRD_MASK)
#define MIREGADR  (0x14|0x40|SPRD_MASK)
#define MIWRL   (0x16|0x40|SPRD_MASK)
#define MIWRH   (0x17|0x40|SPRD_MASK)
#define MIRDL   (0x18|0x40|SPRD_MASK)
#define MIRDH   (0x19|0x40|SPRD_MASK)
'  Bank 3 registers'
#define MAADR1    (0x00|0x60|SPRD_MASK)
#define MAADR0    (0x01|0x60|SPRD_MASK)
#define MAADR3    (0x02|0x60|SPRD_MASK)
#define MAADR2    (0x03|0x60|SPRD_MASK)
#define MAADR5    (0x04|0x60|SPRD_MASK)
#define MAADR4    (0x05|0x60|SPRD_MASK)
#define EBSTSD    (0x06|0x60)
#define EBSTCON   (0x07|0x60)
#define EBSTCSL   (0x08|0x60)
#define EBSTCSH   (0x09|0x60)
#define MISTAT    (0x0A|0x60|SPRD_MASK)
#define EREVID    (0x12|0x60)
#define ECOCON    (0x15|0x60)
#define EFLOCON   (0x17|0x60)
#define EPAUSL    (0x18|0x60)
#define EPAUSH    (0x19|0x60)
'  PHY registers'
#define PHCON1    0x00
#define PHSTAT1   0x01
#define PHHID1    0x02
#define PHHID2    0x03
#define PHCON2    0x10
#define PHSTAT2   0x11
#define PHIE    0x12
#define PHIR    0x13
#define PHLCON    0x14

'  ENC28j60 EIE Register Bit Definitions'
#define EIE_INTIE 0x80
#define EIE_PKTIE 0x40
#define EIE_DMAIE 0x20
#define EIE_LINKIE  0x10
#define EIE_TXIE  0x08
'  #define EIE_WOLIE  0x04 (reserved)'
#define EIE_TXERIE  0x02
#define EIE_RXERIE  0x01
'  ENC28j60 EIR Register Bit Definitions'
#define EIR_PKTIF 0x40
#define EIR_DMAIF 0x20
#define EIR_LINKIF  0x10
#define EIR_TXIF  0x08
'  #define EIR_WOLIF  0x04 (reserved)'
#define EIR_TXERIF  0x02
#define EIR_RXERIF  0x01
'  ENC28j60 ESTAT Register Bit Definitions'
#define ESTAT_INT 0x80
#define ESTAT_LATECOL 0x10
#define ESTAT_RXBUSY  0x04
#define ESTAT_TXABRT  0x02
#define ESTAT_CLKRDY  0x01
'  ENC28j60 ECON2 Register Bit Definitions'
#define ECON2_AUTOINC 0x80
#define ECON2_PKTDEC  0x40
#define ECON2_PWRSV 0x20
#define ECON2_VRPS  0x08
'  ENC28j60 ECON1 Register Bit Definitions'
#define ECON1_TXRST 0x80
#define ECON1_RXRST 0x40
#define ECON1_DMAST 0x20
#define ECON1_CSUMEN  0x10
#define ECON1_TXRTS 0x08
#define ECON1_RXEN  0x04
#define ECON1_BSEL1 0x02
#define ECON1_BSEL0 0x01
'  ENC28j60 MACON1 Register Bit Definitions'
#define MACON1_LOOPBK 0x10
#define MACON1_TXPAUS 0x08
#define MACON1_RXPAUS 0x04
#define MACON1_PASSALL  0x02
#define MACON1_MARXEN 0x01
'  ENC28j60 MACON2 Register Bit Definitions'
#define MACON2_MARST  0x80
#define MACON2_RNDRST 0x40
#define MACON2_MARXRST  0x08
#define MACON2_RFUNRST  0x04
#define MACON2_MATXRST  0x02
#define MACON2_TFUNRST  0x01
'  ENC28j60 MACON3 Register Bit Definitions'
#define MACON3_PADCFG2  0x80
#define MACON3_PADCFG1  0x40
#define MACON3_PADCFG0  0x20
#define MACON3_TXCRCEN  0x10
#define MACON3_PHDRLEN  0x08
#define MACON3_HFRMLEN  0x04
#define MACON3_FRMLNEN  0x02
#define MACON3_FULDPX 0x01
'  ENC28j60 MICMD Register Bit Definitions'
#define MICMD_MIISCAN 0x02
#define MICMD_MIIRD 0x01
'  ENC28j60 MISTAT Register Bit Definitions'
#define MISTAT_NVALID 0x04
#define MISTAT_SCAN 0x02
#define MISTAT_BUSY 0x01
'  ENC28j60 ERXFCON Register Bit Definitions'
#define ERXFCON_UCEN  0x80
#define ERXFCON_ANDOR 0x40
#define ERXFCON_CRCEN 0x20
#define ERXFCON_PMEN  0x10
#define ERXFCON_MPEN  0x08
#define ERXFCON_HTEN  0x04
#define ERXFCON_MCEN  0x02
#define ERXFCON_BCEN  0x01

'  ENC28j60 PHY PHCON1 Register Bit Definitions'
#define PHCON1_PRST 0x8000
#define PHCON1_PLOOPBK  0x4000
#define PHCON1_PPWRSV 0x0800
#define PHCON1_PDPXMD 0x0100
'  ENC28j60 PHY PHSTAT1 Register Bit Definitions'
#define PHSTAT1_PFDPX 0x1000
#define PHSTAT1_PHDPX 0x0800
#define PHSTAT1_LLSTAT  0x0004
#define PHSTAT1_JBSTAT  0x0002
'  ENC28j60 PHY PHSTAT2 Register Bit Definitions'
#define PHSTAT2_TXSTAT  (1 << 13)
#define PHSTAT2_RXSTAT  (1 << 12)
#define PHSTAT2_COLSTAT (1 << 11)
#define PHSTAT2_LSTAT (1 << 10)
#define PHSTAT2_DPXSTAT (1 << 9)
#define PHSTAT2_PLRITY  (1 << 5)
'  ENC28j60 PHY PHCON2 Register Bit Definitions'
#define PHCON2_FRCLINK  0x4000
#define PHCON2_TXDIS  0x2000
#define PHCON2_JABBER 0x0400
#define PHCON2_HDLDIS 0x0100
'  ENC28j60 PHY PHIE Register Bit Definitions'
#define PHIE_PLNKIE (1 << 4)
#define PHIE_PGEIE  (1 << 1)
'  ENC28j60 PHY PHIR Register Bit Definitions'
#define PHIR_PLNKIF (1 << 4)
#define PHIR_PGEIF  (1 << 1)

'  ENC28j60 Packet Control Byte Bit Definitions'
#define PKTCTRL_PHUGEEN   0x08
#define PKTCTRL_PPADEN    0x04
#define PKTCTRL_PCRCEN    0x02
#define PKTCTRL_POVERRIDE 0x01

'  ENC28j60 Transmit Status Vector'
#define TSV_TXBYTECNT   0
#define TSV_TXCOLLISIONCNT  16
#define TSV_TXCRCERROR    20
#define TSV_TXLENCHKERROR 21
#define TSV_TXLENOUTOFRANGE 22
#define TSV_TXDONE    23
#define TSV_TXMULTICAST   24
#define TSV_TXBROADCAST   25
#define TSV_TXPACKETDEFER 26
#define TSV_TXEXDEFER   27
#define TSV_TXEXCOLLISION 28
#define TSV_TXLATECOLLISION 29
#define TSV_TXGIANT   30
#define TSV_TXUNDERRUN    31
#define TSV_TOTBYTETXONWIRE 32
#define TSV_TXCONTROLFRAME  48
#define TSV_TXPAUSEFRAME  49
#define TSV_BACKPRESSUREAPP 50
#define TSV_TXVLANTAGFRAME  51

#define TSV_SIZE    7
'#define TSV_BYTEOF(x)    ((x) / 8)
'#define TSV_BITMASK(x)   (1 << ((x) % 8))
'#define TSV_GETBIT(x, y) (((x)[TSV_BYTEOF(y)] & TSV_BITMASK(y)) ? 1 : 0)

'  ENC28j60 Receive Status Vector'
#define RSV_RXLONGEVDROPEV  16
#define RSV_CARRIEREV   18
#define RSV_CRCERROR    20
#define RSV_LENCHECKERR   21
#define RSV_LENOUTOFRANGE 22
#define RSV_RXOK    23
#define RSV_RXMULTICAST   24
#define RSV_RXBROADCAST   25
#define RSV_DRIBBLENIBBLE 26
#define RSV_RXCONTROLFRAME  27
#define RSV_RXPAUSEFRAME  28
#define RSV_RXUNKNOWNOPCODE 29
#define RSV_RXTYPEVLAN    30

#define RSV_SIZE    6
'#define RSV_BITMASK(x)   (1 << ((x) - 16))
'#define RSV_GETBIT(x, y) (((x) & RSV_BITMASK(y)) ? 1 : 0)


'  SPI operation codes'
#define ENC28j60_READ_CTRL_REG  0x00
#define ENC28j60_READ_BUF_MEM 0x3A
#define ENC28j60_WRITE_CTRL_REG 0x40
#define ENC28j60_WRITE_BUF_MEM  0x7A
#define ENC28j60_BIT_FIELD_SET  0x80
#define ENC28j60_BIT_FIELD_CLR  0xA0
#define ENC28j60_SOFT_RESET 0xFF


#define TXEND_INIT    0x1FFF
  #define TXEND_INIT_b    0x1F
  #define TXEND_INIT_h    0xFF

'  Put RX buffer at 0 as suggested by the Errata datasheet'
#define RXSTART_INIT    0x0000
  #define RXSTART_INIT_b    0x00
  #define RXSTART_INIT_h    0x00

#define RXEND_INIT    0x19FF
  #define RXEND_INIT_b    0xFF
  #define RXEND_INIT_h    0x19


'  maximum ethernet frame length'
#define MAX_FRAMELEN    1518

'  Preferred half duplex: LEDA: Link status LEDB: Rx/Tx activity'
#define ENC28j60_LAMPS_MODE 0x3476
