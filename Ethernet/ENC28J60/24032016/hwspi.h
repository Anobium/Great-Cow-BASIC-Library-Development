'    Hardware SPI routines for Great Cow BASIC
'    Copyright (C) 2006 - 2011 Hugh Considine
'    Copyright (C) 2015 - Evan R. Venn
'    Copyright (C) 2016 - Evan R. Venn

'    This library is free software; you can redistribute it and/or
'    modify it under the terms of the GNU Lesser General Public
'    License as published by the Free Software Foundation; either
'    version 2.1 of the License, or (at your option) any later version.

'    This library is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY; without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
'    Lesser General Public License for more details.

'    You should have received a copy of the GNU Lesser General Public
'    License along with this library; if not, write to the Free Software
'    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

'********************************************************************************
'IMPORTANT:
'THIS FILE IS ESSENTIAL FOR SOME OF THE COMMANDS IN GCBASIC. DO NOT ALTER THIS FILE
'UNLESS YOU KNOW WHAT YOU ARE DOING. CHANGING THIS FILE COULD RENDER SOME GCBASIC
'COMMANDS UNUSABLE!
'********************************************************************************

'Changes:
' 3/2/2011: Some minor tweaks to reduce code size and make code neater
' 5/2/2011: Added AVR support, new version of SPIMode to set clock mode
' 14/6/2015: Adapted tp support software SPI by addressing SPITransfer via HWSPITransfer
' 25/3/2016: Adapted to add 16f18855 support
' 29/3/2016: Adapted to add 18f support in FastHWSPITransfer

'To make the PIC pause until it receives an SPI message while in slave mode, set the
'constant "WaitForSPI" at the start of the program. The value does not matter.

'Subs
' SPIMode(Mode)			Set the SPI mode. See the list of constants below
' SPITransfer(Tx, Rx)		Simultaneously send and receive an SPI byte

'SPI mode constants
'Also used for hardware I2C
#define MasterFast 13
#define Master 12
#define MasterSlow 11
#define SlaveSS 1
#define Slave 0

'SPI clock options
'For SPIMode (mode, clock)
#define SPI_CPOL_0 0
#define SPI_CPOL_1 2
#define SPI_CPHA_0 0
#define SPI_CPHA_1 1

'Initialisation sub
'Used to set mode
'Overloaded: Other version also allows clock options to be set
Sub SPIMode (In SPICurrentMode)

	#ifdef PIC
		#ifndef Var(SSPCON1)
			#ifdef Var(SSPCON)
				Dim SSPCON1 Alias SSPCON
			#endif
		#endif

		'Turn off SPI
		'(Prevents any weird glitches during setup)
		Set SSPCON1.SSPEN Off

		'Set clock pulse settings
		Set SSPSTAT.SMP Off
		'Data write on rising (idle > active) clock (CPHA = 1)
		Set SSPSTAT.CKE Off
		'Clock idle low (CPOL = 0)
		Set SSPCON1.CKP Off

		'Select mode and clock
		'Set some mode bits off, can set on later
		Set SSPCON1.SSPM3 Off
		Set SSPCON1.SSPM2 Off
		Set SSPCON1.SSPM1 Off
		Set SSPCON1.SSPM0 Off

		Select Case SPICurrentMode
		Case MasterFast
			'Nothing to do
		Case Master
			Set SSPCON1.SSPM0 On
		Case MasterSlow
			Set SSPCON1.SSPM1 On
		Case Slave
			Set SSPCON1.SSPM2 On
			Set SSPCON1.SSPM0 On
		Case SlaveSS
			Set SSPCON1.SSPM2 On
		End Select

		'Enable SPI
		Set SSPCON1.SSPEN On
	#endif

	#ifdef AVR
		'Turn off SPI
		'(Prevents any weird glitches during setup)
		Set SPCR.SPE Off

		'Set clock pulse settings
		'Need CPHA = 1 to match default PIC settings
		'(CPOL = 0 matches PIC)
		Set SPCR.CPHA On

		'Select mode and clock
		'Set some mode bits off, can set on later
		Set SPCR.MSTR Off
		Set SPSR.SPI2X Off
		Set SPCR.SPR0 Off
		Set SPCR.SPR1 Off

		Select Case SPICurrentMode
		Case MasterFast
			Set SPCR.MSTR On

		Case Master
			Set SPCR.MSTR On
			Set SPCR.SPR0 On

		Case MasterSlow
			Set SPCR.MSTR On
			Set SPCR.SPR1 On

		'Nothing needed for slave
		'Case Slave
		'Case SlaveSS

		End Select

		'Enable SPI
		Set SPCR.SPE On
	#endif

End Sub

'Initialisation sub
'Used to set mode and clock options
'Overloaded: Other version is more compact but doesn't allow clock options to be set
Sub SPIMode (In SPICurrentMode, In SPIClockMode)



	#ifdef PIC
		#ifndef Var(SSPCON1)
			#ifdef Var(SSPCON)
				Dim SSPCON1 Alias SSPCON
			#endif
		#endif

    'added for 16f18855
		#ifndef Var(SSPCON1)
			#ifdef Var(SSP1CON1)
				Dim SSPCON1 Alias SSP1CON1 ;added for 18f18855
			#endif
		#endif
    'added for 16f18855
		#ifndef Var(SSPSTAT)
			#ifdef Var(SSP1STAT)
				Dim SSPSTAT Alias SSP1STAT ;added for 18f18855
			#endif
		#endif
    'added for 16f18855
    #ifndef Var(SSPBUF)
			#ifdef Var(SSP1BUF)
				Dim SSPBUF Alias SSP1BUF
			#endif
		#endif



		'Turn off SPI
		'(Prevents any weird glitches during setup)
		Set SSPCON1.SSPEN Off ;(Prevents any weird glitches during setup)

		'Set clock pulse settings
		Set SSPSTAT.SMP Off

		Set SSPSTAT.CKE Off
		If SPIClockMode.0 = Off Then
			Set SSPSTAT.CKE On
		End If
		Set SSPCON1.CKP Off
		If SPIClockMode.1 = On Then
			Set SSPCON1.CKP On
		End If

		'Select mode and clock
		'Set some mode bits off, can set on later
		Set SSPCON1.SSPM3 Off
		Set SSPCON1.SSPM2 Off
		Set SSPCON1.SSPM1 Off
		Set SSPCON1.SSPM0 Off

		Select Case SPICurrentMode
		Case MasterFast
			'Nothing to do
		Case Master
			Set SSPCON1.SSPM0 On
		Case MasterSlow
			Set SSPCON1.SSPM1 On
		Case Slave
			Set SSPCON1.SSPM2 On
			Set SSPCON1.SSPM0 On
		Case SlaveSS
			Set SSPCON1.SSPM2 On
		End Select

		'Enable SPI
		Set SSPCON1.SSPEN On
	#endif

	#ifdef AVR
		'Turn off SPI
		'(Prevents any weird glitches during setup)
		Set SPCR.SPE Off

		'Set clock pulse settings
		Set SPCR.CPHA Off
		If SPIClockMode.0 = On Then
			Set SPCR.CPHA On
		End If
		Set SPCR.CPOL Off
		If SPIClockMode.1 = On Then
			Set SPCR.CPOL On
		End If

		'Select mode and clock
		'Set some mode bits off, can set on later
		Set SPCR.MSTR Off
		Set SPSR.SPI2X Off
		Set SPCR.SPR0 Off
		Set SPCR.SPR1 Off

		Select Case SPICurrentMode
		Case MasterFast
			Set SPCR.MSTR On

		Case Master
			Set SPCR.MSTR On
			Set SPCR.SPR0 On

		Case MasterSlow
			Set SPCR.MSTR On
			Set SPCR.SPR1 On

		'Nothing needed for slave
		'Case Slave
		'Case SlaveSS

		End Select

		'Enable SPI
		Set SPCR.SPE On
	#endif

End Sub

'Turn off SSP
Sub SSPOFF
	#ifdef PIC
		Set SSPEN Off
	#endif

	#ifdef AVR
		Set SPE Off
	#endif

End Sub
#define SPITransfer HWSPITransfer
'Sub to handle SPI data send/receive
Sub HWSPITransfer(In SPITxData, Out SPIRxData)

	#ifdef PIC

		'Master mode
		If SPICurrentMode > 10 Then
			'Clear WCOL
			Set SSPCON1.WCOL Off

			'Put byte to send into buffer
			'Will start transfer
			SSPBUF = SPITxData

		'Slave mode
		Else
			'Retry until send succeeds
			Do
				SET SSPCON1.WCOL OFF
				SSPBUF = SPITxData
			Loop While SSPCON1.WCOL = On
		End If

		'Read buffer
		'Same for master and slave
		Wait While SSPSTAT.BF = Off
		SPIRxData = SSPBUF
		Set SSPSTAT.BF Off

	#endif

	#ifdef AVR
		'Master mode
		If SPICurrentMode > 10 Then
			'Put byte to send into buffer
			'Will start transfer
			Do
				SPDR = SPITxData
			Loop While SPSR.WCOL

		'Slave mode
		Else
			'Retry until send succeeds
			Do
				SPDR = SPITxData
			Loop While SPSR.WCOL = On
		End If

		'Read buffer
		'Same for master and slave
		Wait While SPSR.SPIF = Off
		SPIRxData = SPDR
	#endif

End Sub


'Sub to handle SPI data send - Master mode only
Sub FastHWSPITransfer( In SPITxData )
  'Master mode only
  #ifdef PIC

    'Clear WCOL
    Set SSPCON1.WCOL Off

    'Put byte to send into buffer
    'Will start transfer
    SSPBUF = SPITxData
    'Same for master and slave
    Wait While SSPSTAT.BF = Off
    Set SSPSTAT.BF Off

    'Handle 18F chips
    #if ChipFamily 16
      SPIRxData = SSPBUF
    #endif

  #endif

	#ifdef AVR
		'Master mode only
    Do
      SPDR = SPITxData
    Loop While SPSR.WCOL
		'Read buffer
		'Same for master and slave
		Wait While SPSR.SPIF = Off
	#endif

End Sub
