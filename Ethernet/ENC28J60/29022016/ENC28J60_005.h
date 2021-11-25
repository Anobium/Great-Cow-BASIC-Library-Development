
dim macaddr(6)


sub ENC28J60_Init ( in macaddr() )

      ''' Device ChipSelect control
      '''
      #DEFINE ENC28J60_Select         Set ENC28J60_CS off
      #DEFINE ENC28J60_Deselect       Set ENC28J60_CS on
      #DEFINE ENC28J60_Reset_CMD      Set ENC28J60_RESET on: Wait 10 ms :Set ENC28J60_RESET off: Wait 10 ms :Set ENC28J60_RESET on: Wait 10 ms


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
      SPIMode MasterFast, 0
      ENC28J60_Reset_CMD

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
      ENC28J60_writeReg(ERXRDPTL, ENC_RXBUF_STL)
      ENC28J60_writeReg(ERXRDPTH, ENC_RXBUF_STH) 'RX Pointers (same)

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
      ENC28J60_writeReg(MICON1, 0x02)  'Fast MII operation
      ENC28J60_writeReg(MICON2, 0x00)  'Release MII interface from reset

      'Initialize MAC subsystem
      ENC28J60_writeReg(MACON1, 0b00001101 )  'Enable packet reception
      ENC28J60_writeReg(MACON2, 0x00)  'Release the MAC subsystem from reset
      ENC28J60_writeReg(MACON3, 0xF0)  'Auto Pad + CRC + Half Duplex
      ENC28J60_writeReg(MACON4, 0x01)  'Need valid preamble
      ENC28J60_writeReg(MAPHSUP, 0b00010000) 'Release MAC-PHY support from Reset
      ENC28J60_writeReg(MAMXFLL, 0xEE)
      ENC28J60_writeReg(MAMXFLH, 0x5)  'Maximum frame length
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
      ENC28J60_writePhyReg(PHLCON, 0B00000100, 0B01110110)
      ENC28J60_writePhyReg(PHIE, 0x00, 0x00)  'Disable interrupts

      'Initialization done, release the NIC from reset
      ENC28J60_writeReg(ECON1, 0B00010100)

      'We are done!!






End Sub


; writes byte ENC_Outbyte in ENC register addr of the current bank
sub ENC28J60_writeReg( in addr,  in ENC_Outbyte as byte )

        banktobeselected = ( addr & BANK_MASK) / 32
        ENC28J60_selectBank ( banktobeselected, addr )

        ENC28J60_Select
        FastHWSPITransfer( ENC28J60_WRITE_CTRL_REG | (addr AND ADDR_MASK ), temp )
        FastHWSPITransfer( ENC_Outbyte, temp )
        ENC28J60_Deselect

end sub

sub ENC28J60_writePhyReg( in PhyRegaddr,  in ENC_Outbyte1 as byte , in ENC_Outbyte2 as byte )

        'Wait for the MII interface to be ready
        do while ((ENC28J60_ReadReg(MISTAT) & MISTAT_BUSY ) = 1)

        ENC28J60_writeReg( MIREGADR, PhyRegaddr )
        ENC28J60_writeReg( MIWRL, ENC_Outbyte1 )
        ENC28J60_writeReg( MIWRH, ENC_Outbyte2 )

end sub

sub ENC28J60_selectBank ( in banktobeselected, in addr )

'       'These registers (EIE, EIR, ESTAT, ECON2, ECON1)
'       'are present in all banks, no need to switch bank
        if ( addr >= EIE & addr <= ECON1 ) then
          exit Sub
        end if

        if lastselectedBank = banktobeselected then
          exit sub
        end if


        'Set to ENC memory bank addr
        ENC28J60_Select
        FastHWSPITransfer(BFCCMD | ECON1, temp)
        FastHWSPITransfer(0b00000011, temp)
        ENC28J60_Deselect

        'Set to ENC memory bank addr
        Select case banktobeselected

          case 1

            ENC28J60_Select
            FastHWSPITransfer(BFSCMD | ECON1, temp)
            FastHWSPITransfer(0b00000001 , temp)
            ENC28J60_Deselect

          case 2

            ENC28J60_Select
            FastHWSPITransfer(BFSCMD | ECON1, temp)
            FastHWSPITransfer(0b00000010 , temp)
            ENC28J60_Deselect


          case 3

            ENC28J60_Select
            FastHWSPITransfer(BFSCMD | ECON1, temp)
            FastHWSPITransfer(0b00000011 , temp)
            ENC28J60_Deselect

        End Select

        lastselectedBank = banktobeselected

end sub


function ENC28J60_ReadReg( in addr ) as byte

        banktobeselected =  ( addr & BANK_MASK) / 32
        ENC28J60_selectBank ( banktobeselected, addr )

        ENC28J60_Select
        'Read address

            #ifndef Var(SSPCON1)

              #ifdef Var(SSPCON)
                Dim SSPCON1 Alias SSPCON
              #endif

            #endif

            Set SSPCON1.WCOL Off
            'Put byte to send into buffer
            'Will start transfer
            SSPBUF = ENC28J60_READ_CTRL_REG | ( addr AND ADDR_MASK )

            'Read buffer
            Wait While SSPSTAT.BF = Off
            temp = SSPBUF
            Set SSPSTAT.BF Off

            Set SSPCON1.WCOL Off
            'Put byte to send into buffer
            'Will start transfer
            SSPBUF = 0

            'Read buffer
            Wait While SSPSTAT.BF = Off
            ENC_Inbyte = SSPBUF
            Set SSPSTAT.BF Off

            Set SSPCON1.WCOL Off
            'Put byte to send into buffer
            'Will start transfer
            SSPBUF = 0

            'Read dummy value
            Wait While SSPSTAT.BF = Off
            ENC_Inbyte = SSPBUF
            Set SSPSTAT.BF Off

            'Set data result
            ENC28J60_Deselect
            ENC28J60_ReadReg = ENC_Inbyte

end function




dim enc_last_txbuf as Word
ConfigurationDetails:




'Important bit maps
#DEFINE EPKTDEC 0x40
#DEFINE DMAST   0x20
#DEFINE CSUMEN  0x10
#DEFINE TXRTS   0x08
#DEFINE MIIRD   0x01
#DEFINE BUSY    0x01
#DEFINE CLKRDY  0x01
#DEFINE RXEN    0x04

'Set ENC28J60 Memory locations
#SCRIPT
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
  ENC_RXBUF_NDH = INT( INT(ENC_RXBUF ) / 0x100 )

  ENC_TX_BUF1 =  ENC_TXBUF_ST
  ENC_TX_BUF2 =  ENC_TX_BUF1 + 300
  ENC_TX_BUF3 =  ENC_TX_BUF2 + 300
  ENC_TX_BUF4 =  ENC_TX_BUF3 + 300
  ENC_TX_BUF5 =  ENC_TX_BUF4 + 300
  ENC_TX_BUF6 =  ENC_TX_BUF5 + 300
  ENC_TX_BUF7 =  ENC_TX_BUF6 + 300
  ENC_TX_BUF8 =  ENC_TX_BUF7 + 300
  ENC_TX_BUFNB = 8
#ENDSCRIPT

'
' ENC28J60 Control Registers
#DEFINE WCRCMD  0b01000000      ; write control register
#DEFINE BFCCMD  0b10100000      ; bit field clear
#DEFINE BFSCMD  0b10000000      ; bit field set

' Control register definitions are a combination of address,
' bank number, and Ethernet/MAC/PHY indicator bits.
' - Register address  (bits 0-4)
' - Bank number (bits 5-6)
' - MAC/MII indicator (bit 7)
'
#DEFINE ADDR_MASK 0x1F
#DEFINE BANK_MASK 0x60
#DEFINE SPRD_MASK 0x80
'  All-bank registers'
#DEFINE BANK0   0
#DEFINE BANK1   1
#DEFINE BANK2   2
#DEFINE BANK3   3


#DEFINE EIE   0x1B
#DEFINE EIR   0x1C
#DEFINE ESTAT   0x1D
#DEFINE ECON2   0x1E
#DEFINE ECON1   0x1F
'  Bank 0 registers'
#DEFINE ERDPTL    (0x00|0x00)
#DEFINE ERDPTH    (0x01|0x00)
#DEFINE EWRPTL    (0x02|0x00)
#DEFINE EWRPTH    (0x03|0x00)
#DEFINE ETXSTL    (0x04|0x00)
#DEFINE ETXSTH    (0x05|0x00)
#DEFINE ETXNDL    (0x06|0x00)
#DEFINE ETXNDH    (0x07|0x00)
#DEFINE ERXSTL    (0x08|0x00)
#DEFINE ERXSTH    (0x09|0x00)
#DEFINE ERXNDL    (0x0A|0x00)
#DEFINE ERXNDH    (0x0B|0x00)
#DEFINE ERXRDPTL  (0x0C|0x00)
#DEFINE ERXRDPTH  (0x0D|0x00)
#DEFINE ERXWRPTL  (0x0E|0x00)
#DEFINE ERXWRPTH  (0x0F|0x00)
#DEFINE EDMASTL   (0x10|0x00)
#DEFINE EDMASTH   (0x11|0x00)
#DEFINE EDMANDL   (0x12|0x00)
#DEFINE EDMANDH   (0x13|0x00)
#DEFINE EDMADSTL  (0x14|0x00)
#DEFINE EDMADSTH  (0x15|0x00)
#DEFINE EDMACSL   (0x16|0x00)
#DEFINE EDMACSH   (0x17|0x00)
'  Bank 1 registers'
#DEFINE EHT0    (0x00|0x20)
#DEFINE EHT1    (0x01|0x20)
#DEFINE EHT2    (0x02|0x20)
#DEFINE EHT3    (0x03|0x20)
#DEFINE EHT4    (0x04|0x20)
#DEFINE EHT5    (0x05|0x20)
#DEFINE EHT6    (0x06|0x20)
#DEFINE EHT7    (0x07|0x20)
#DEFINE EPMM0   (0x08|0x20)
#DEFINE EPMM1   (0x09|0x20)
#DEFINE EPMM2   (0x0A|0x20)
#DEFINE EPMM3   (0x0B|0x20)
#DEFINE EPMM4   (0x0C|0x20)
#DEFINE EPMM5   (0x0D|0x20)
#DEFINE EPMM6   (0x0E|0x20)
#DEFINE EPMM7   (0x0F|0x20)
#DEFINE EPMCSL    (0x10|0x20)
#DEFINE EPMCSH    (0x11|0x20)
#DEFINE EPMOL   (0x14|0x20)
#DEFINE EPMOH   (0x15|0x20)
#DEFINE EWOLIE    (0x16|0x20)
#DEFINE EWOLIR    (0x17|0x20)
#DEFINE ERXFCON   (0x18|0x20)
#DEFINE EPKTCNT   (0x19|0x20)
'  Bank 2 registers'
#DEFINE MACON1    (0x00|0x40|SPRD_MASK)
'  #DEFINE MACON2 (0x01|0x40|SPRD_MASK)'
#DEFINE MACON3    (0x02|0x40|SPRD_MASK)
#DEFINE MACON4    (0x03|0x40|SPRD_MASK)
#DEFINE MABBIPG   (0x04|0x40|SPRD_MASK)
#DEFINE MAIPGL    (0x06|0x40|SPRD_MASK)
#DEFINE MAIPGH    (0x07|0x40|SPRD_MASK)
#DEFINE MACLCON1  (0x08|0x40|SPRD_MASK)
#DEFINE MACLCON2  (0x09|0x40|SPRD_MASK)
#DEFINE MAMXFLL   (0x0A|0x40|SPRD_MASK)
#DEFINE MAMXFLH   (0x0B|0x40|SPRD_MASK)
#DEFINE MAPHSUP   (0x0D|0x40|SPRD_MASK)
#DEFINE MICON   (0x11|0x40|SPRD_MASK)
#DEFINE MICMD   (0x12|0x40|SPRD_MASK)
#DEFINE MIREGADR  (0x14|0x40|SPRD_MASK)
#DEFINE MIWRL   (0x16|0x40|SPRD_MASK)
#DEFINE MIWRH   (0x17|0x40|SPRD_MASK)
#DEFINE MIRDL   (0x18|0x40|SPRD_MASK)
#DEFINE MIRDH   (0x19|0x40|SPRD_MASK)
'  Bank 3 registers'
#DEFINE MAADR1    (0x00|0x60|SPRD_MASK)
#DEFINE MAADR0    (0x01|0x60|SPRD_MASK)
#DEFINE MAADR3    (0x02|0x60|SPRD_MASK)
#DEFINE MAADR2    (0x03|0x60|SPRD_MASK)
#DEFINE MAADR5    (0x04|0x60|SPRD_MASK)
#DEFINE MAADR4    (0x05|0x60|SPRD_MASK)
#DEFINE EBSTSD    (0x06|0x60)
#DEFINE EBSTCON   (0x07|0x60)
#DEFINE EBSTCSL   (0x08|0x60)
#DEFINE EBSTCSH   (0x09|0x60)
#DEFINE MISTAT    (0x0A|0x60|SPRD_MASK)
#DEFINE EREVID    (0x12|0x60)
#DEFINE ECOCON    (0x15|0x60)
#DEFINE EFLOCON   (0x17|0x60)
#DEFINE EPAUSL    (0x18|0x60)
#DEFINE EPAUSH    (0x19|0x60)
'  PHY registers'
#DEFINE PHCON1    0x00
#DEFINE PHSTAT1   0x01
#DEFINE PHHID1    0x02
#DEFINE PHHID2    0x03
#DEFINE PHCON2    0x10
#DEFINE PHSTAT2   0x11
#DEFINE PHIE    0x12
#DEFINE PHIR    0x13
#DEFINE PHLCON    0x14

'  ENC28J60 EIE Register Bit Definitions'
#DEFINE EIE_INTIE 0x80
#DEFINE EIE_PKTIE 0x40
#DEFINE EIE_DMAIE 0x20
#DEFINE EIE_LINKIE  0x10
#DEFINE EIE_TXIE  0x08
'  #DEFINE EIE_WOLIE  0x04 (reserved)'
#DEFINE EIE_TXERIE  0x02
#DEFINE EIE_RXERIE  0x01
'  ENC28J60 EIR Register Bit Definitions'
#DEFINE EIR_PKTIF 0x40
#DEFINE EIR_DMAIF 0x20
#DEFINE EIR_LINKIF  0x10
#DEFINE EIR_TXIF  0x08
'  #DEFINE EIR_WOLIF  0x04 (reserved)'
#DEFINE EIR_TXERIF  0x02
#DEFINE EIR_RXERIF  0x01
'  ENC28J60 ESTAT Register Bit Definitions'
#DEFINE ESTAT_INT 0x80
#DEFINE ESTAT_LATECOL 0x10
#DEFINE ESTAT_RXBUSY  0x04
#DEFINE ESTAT_TXABRT  0x02
#DEFINE ESTAT_CLKRDY  0x01
'  ENC28J60 ECON2 Register Bit Definitions'
#DEFINE ECON2_AUTOINC 0x80
#DEFINE ECON2_PKTDEC  0x40
#DEFINE ECON2_PWRSV 0x20
#DEFINE ECON2_VRPS  0x08
'  ENC28J60 ECON1 Register Bit Definitions'
#DEFINE ECON1_TXRST 0x80
#DEFINE ECON1_RXRST 0x40
#DEFINE ECON1_DMAST 0x20
#DEFINE ECON1_CSUMEN  0x10
#DEFINE ECON1_TXRTS 0x08
#DEFINE ECON1_RXEN  0x04
#DEFINE ECON1_BSEL1 0x02
#DEFINE ECON1_BSEL0 0x01
'  ENC28J60 MACON1 Register Bit Definitions'
#DEFINE MACON1_LOOPBK 0x10
#DEFINE MACON1_TXPAUS 0x08
#DEFINE MACON1_RXPAUS 0x04
#DEFINE MACON1_PASSALL  0x02
#DEFINE MACON1_MARXEN 0x01
'  ENC28J60 MACON2 Register Bit Definitions'
#DEFINE MACON2_MARST  0x80
#DEFINE MACON2_RNDRST 0x40
#DEFINE MACON2_MARXRST  0x08
#DEFINE MACON2_RFUNRST  0x04
#DEFINE MACON2_MATXRST  0x02
#DEFINE MACON2_TFUNRST  0x01
'  ENC28J60 MACON3 Register Bit Definitions'
#DEFINE MACON3_PADCFG2  0x80
#DEFINE MACON3_PADCFG1  0x40
#DEFINE MACON3_PADCFG0  0x20
#DEFINE MACON3_TXCRCEN  0x10
#DEFINE MACON3_PHDRLEN  0x08
#DEFINE MACON3_HFRMLEN  0x04
#DEFINE MACON3_FRMLNEN  0x02
#DEFINE MACON3_FULDPX 0x01
'  ENC28J60 MICMD Register Bit Definitions'
#DEFINE MICMD_MIISCAN 0x02
#DEFINE MICMD_MIIRD 0x01
'  ENC28J60 MISTAT Register Bit Definitions'
#DEFINE MISTAT_NVALID 0x04
#DEFINE MISTAT_SCAN 0x02
#DEFINE MISTAT_BUSY 0x01
'  ENC28J60 ERXFCON Register Bit Definitions'
#DEFINE ERXFCON_UCEN  0x80
#DEFINE ERXFCON_ANDOR 0x40
#DEFINE ERXFCON_CRCEN 0x20
#DEFINE ERXFCON_PMEN  0x10
#DEFINE ERXFCON_MPEN  0x08
#DEFINE ERXFCON_HTEN  0x04
#DEFINE ERXFCON_MCEN  0x02
#DEFINE ERXFCON_BCEN  0x01

'  ENC28J60 PHY PHCON1 Register Bit Definitions'
#DEFINE PHCON1_PRST 0x8000
#DEFINE PHCON1_PLOOPBK  0x4000
#DEFINE PHCON1_PPWRSV 0x0800
#DEFINE PHCON1_PDPXMD 0x0100
'  ENC28J60 PHY PHSTAT1 Register Bit Definitions'
#DEFINE PHSTAT1_PFDPX 0x1000
#DEFINE PHSTAT1_PHDPX 0x0800
#DEFINE PHSTAT1_LLSTAT  0x0004
#DEFINE PHSTAT1_JBSTAT  0x0002
'  ENC28J60 PHY PHSTAT2 Register Bit Definitions'
#DEFINE PHSTAT2_TXSTAT  (1 << 13)
#DEFINE PHSTAT2_RXSTAT  (1 << 12)
#DEFINE PHSTAT2_COLSTAT (1 << 11)
#DEFINE PHSTAT2_LSTAT (1 << 10)
#DEFINE PHSTAT2_DPXSTAT (1 << 9)
#DEFINE PHSTAT2_PLRITY  (1 << 5)
'  ENC28J60 PHY PHCON2 Register Bit Definitions'
#DEFINE PHCON2_FRCLINK  0x4000
#DEFINE PHCON2_TXDIS  0x2000
#DEFINE PHCON2_JABBER 0x0400
#DEFINE PHCON2_HDLDIS 0x0100
'  ENC28J60 PHY PHIE Register Bit Definitions'
#DEFINE PHIE_PLNKIE (1 << 4)
#DEFINE PHIE_PGEIE  (1 << 1)
'  ENC28J60 PHY PHIR Register Bit Definitions'
#DEFINE PHIR_PLNKIF (1 << 4)
#DEFINE PHIR_PGEIF  (1 << 1)

'  ENC28J60 Packet Control Byte Bit Definitions'
#DEFINE PKTCTRL_PHUGEEN   0x08
#DEFINE PKTCTRL_PPADEN    0x04
#DEFINE PKTCTRL_PCRCEN    0x02
#DEFINE PKTCTRL_POVERRIDE 0x01

'  ENC28J60 Transmit Status Vector'
#DEFINE TSV_TXBYTECNT   0
#DEFINE TSV_TXCOLLISIONCNT  16
#DEFINE TSV_TXCRCERROR    20
#DEFINE TSV_TXLENCHKERROR 21
#DEFINE TSV_TXLENOUTOFRANGE 22
#DEFINE TSV_TXDONE    23
#DEFINE TSV_TXMULTICAST   24
#DEFINE TSV_TXBROADCAST   25
#DEFINE TSV_TXPACKETDEFER 26
#DEFINE TSV_TXEXDEFER   27
#DEFINE TSV_TXEXCOLLISION 28
#DEFINE TSV_TXLATECOLLISION 29
#DEFINE TSV_TXGIANT   30
#DEFINE TSV_TXUNDERRUN    31
#DEFINE TSV_TOTBYTETXONWIRE 32
#DEFINE TSV_TXCONTROLFRAME  48
#DEFINE TSV_TXPAUSEFRAME  49
#DEFINE TSV_BACKPRESSUREAPP 50
#DEFINE TSV_TXVLANTAGFRAME  51

#DEFINE TSV_SIZE    7
'#DEFINE TSV_BYTEOF(x)    ((x) / 8)
'#DEFINE TSV_BITMASK(x)   (1 << ((x) % 8))
'#DEFINE TSV_GETBIT(x, y) (((x)[TSV_BYTEOF(y)] & TSV_BITMASK(y)) ? 1 : 0)

'  ENC28J60 Receive Status Vector'
#DEFINE RSV_RXLONGEVDROPEV  16
#DEFINE RSV_CARRIEREV   18
#DEFINE RSV_CRCERROR    20
#DEFINE RSV_LENCHECKERR   21
#DEFINE RSV_LENOUTOFRANGE 22
#DEFINE RSV_RXOK    23
#DEFINE RSV_RXMULTICAST   24
#DEFINE RSV_RXBROADCAST   25
#DEFINE RSV_DRIBBLENIBBLE 26
#DEFINE RSV_RXCONTROLFRAME  27
#DEFINE RSV_RXPAUSEFRAME  28
#DEFINE RSV_RXUNKNOWNOPCODE 29
#DEFINE RSV_RXTYPEVLAN    30

#DEFINE RSV_SIZE    6
'#DEFINE RSV_BITMASK(x)   (1 << ((x) - 16))
'#DEFINE RSV_GETBIT(x, y) (((x) & RSV_BITMASK(y)) ? 1 : 0)


'  SPI operation codes'
#DEFINE ENC28J60_READ_CTRL_REG  0x00
#DEFINE ENC28J60_READ_BUF_MEM 0x3A
#DEFINE ENC28J60_WRITE_CTRL_REG 0x40
#DEFINE ENC28J60_WRITE_BUF_MEM  0x7A
#DEFINE ENC28J60_BIT_FIELD_SET  0x80
#DEFINE ENC28J60_BIT_FIELD_CLR  0xA0
#DEFINE ENC28J60_SOFT_RESET 0xFF


'  buffer boundaries applied to internal 8K ram
' entire available packet buffer space is allocated.
' Give TX buffer space for one full ethernet frame (~1500 bytes)
' receive buffer gets the rest'
#DEFINE TXSTART_INIT    0x1A00
#DEFINE TXEND_INIT    0x1FFF

'  Put RX buffer at 0 as suggested by the Errata datasheet'
#DEFINE RXSTART_INIT    0x0000
#DEFINE RXEND_INIT    0x19FF

'  maximum ethernet frame length'
#DEFINE MAX_FRAMELEN    1518

'  Preferred half duplex: LEDA: Link status LEDB: Rx/Tx activity'
#DEFINE ENC28J60_LAMPS_MODE 0x3476
