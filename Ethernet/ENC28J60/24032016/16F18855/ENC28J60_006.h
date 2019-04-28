
dim macaddr(6)


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
    		while ((ENC28J60_ReadReg(MISTAT) & MISTAT_BUSY ) = 1)

				ENC28J60_writeReg( MIREGADR, PhyRegaddr )
        ENC28J60_writeReg( MIWRL, ENC_Outbyte1 )
        ENC28J60_writeReg( MIWRH, ENC_Outbyte2 )

end sub

sub ENC28J60_selectBank ( in banktobeselected, in addr )



'				'These registers (EIE, EIR, ESTAT, ECON2, ECON1)
'				'are present in all banks, no need to switch bank
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


'004 new

dim enc_last_txbuf as Word


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
'      'Read data from the Ethernet buffer at ERDPT location
'      sub eth_read( in buf() as byte , in buf_len as word )
'        dim eth_counter as Word
'
'        ' Initiate SPI command
'        ENC_SS = 0
'        ' Send command
'        SPISEND(ETH_READMEM());
'        ' Read bytes
'        for eth_counter = 0 to buf_len -1
'          SPISEND(0)
'          buf( eth_counter ) = ENC_SSPBUF
'        next
'        ' Finish SPI command
'        ENC_SS = 1
'      end Sub
'
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

'Set ENC28J60 Memory locations
#script
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
#endscript

'
' ENC28J60 Control Registers
#define WCRCMD  0b01000000      ; write control register
#define BFCCMD  0b10100000      ; bit field clear
#define BFSCMD  0b10000000      ; bit field set

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
#define MAPHSUP		(0x0D|0x40|SPRD_MASK)
#define MICON		(0x11|0x40|SPRD_MASK)
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
#define TXSTART_INIT		0x1A00
#define TXEND_INIT		0x1FFF

'  Put RX buffer at 0 as suggested by the Errata datasheet'
#define RXSTART_INIT		0x0000
#define RXEND_INIT		0x19FF

'  maximum ethernet frame length'
#define MAX_FRAMELEN		1518

'  Preferred half duplex: LEDA: Link status LEDB: Rx/Tx activity'
#define ENC28J60_LAMPS_MODE	0x3476


