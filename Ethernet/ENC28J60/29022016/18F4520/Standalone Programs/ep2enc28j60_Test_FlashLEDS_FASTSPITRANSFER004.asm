;Program compiled by Great Cow BASIC (0.95 2016-02-24)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F4520, r=DEC
#include <P18F4520.inc>
 CONFIG LVP = OFF, MCLRE = ON, WDT = OFF, OSC = HS

;********************************************************************************

;Set aside memory locations for variables
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
SYSCALCTEMPA	EQU	5
SYSSTRINGLENGTH	EQU	6
SysStringA	EQU	7
SysStringA_H	EQU	8
SysWaitTempMS	EQU	2
SysWaitTempMS_H	EQU	3
SysWaitTempS	EQU	4
SYSSTRINGPARAM1	EQU	1493
ADDR	EQU	9
COMPORT	EQU	10
ENC_OUTBYTE	EQU	11
HSERPRINTCRLFCOUNT	EQU	12
PRINTLEN	EQU	13
SERDATA	EQU	14
SPICLOCKMODE	EQU	15
SPICURRENTMODE	EQU	16
SPIRXDATA	EQU	17
SPITXDATA	EQU	18
SYSPRINTTEMP	EQU	19
SYSREPEATTEMP1	EQU	20
StringPointer	EQU	21
SysPRINTDATAHandler	EQU	22
SysPRINTDATAHandler_H	EQU	23

;********************************************************************************

;Alias variables
AFSR0	EQU	4073
AFSR0_H	EQU	4074

;********************************************************************************

;Vectors
	ORG	0
	goto	BASPROGRAMSTART
	ORG	8
	retfie

;********************************************************************************

;Start of program memory page 0
	ORG	12
BASPROGRAMSTART
;Call initialisation routines
	rcall	INITSYS
	rcall	INITUSART
;Automatic pin direction setting
	bcf	TRISB,0,ACCESS
	bcf	TRISC,2,ACCESS

;Start of the main program
;'' Description  :
;''      this code sets LEDA as link status display using FASTSPITRANSER
;''      and makes LEDB blink permamently
;'' target devices :
;''      any PIC with integrated SPI on PORTC
;''      the ENC28J60 SPI plus CLK, SO, SI must be connected to the corresponding SPI pins of the PIC
;''      the INT and WOL signals from the ENC are not used
;'' If LEDA is off and LEDB starts blinking, that is good news : the PIC can talk to the ENC controller through SPI communication.
;'' If it does not, it should, check again your solderings & connections until it works.
;''
;''  Then connect your board to a hub with a straight cable : LEDA should now turn on with LEDB still blinking. LEDA on means that the adapter is correctly linked to the network. The network link LED of the other side hub should also turn on.
;----- Constants
;#Define Heartbeat 			PortC.2
;#Define ENC28J60_DI			PortC.4							'Connected to Device SO
;#Define ENC28J60_DO			PortC.5							'Connected to Device SI
;#Define ENC28J60_SCK		PortC.3							'Connected to Clock
;#Define ENC28J60_CS 		PortA.5							'Chip select line
;#Define ENC28J60_RESET  PortD.2							'Reset line
;#Define TX 							PortC.7
;#Define RX							PortC.6
;#define debugport portb.0
;set debugport off
	bcf	LATB,0,ACCESS
;USART settings
;#Define USART_BAUD_RATE 9600
;#Define USART_BLOCKING
;#Define USART_TX_BLOCKING
;Dir TX Out
	bcf	TRISC,7,ACCESS
;Dir RX In
	bsf	TRISC,6,ACCESS
;wait 1 s
	movlw	1
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;HserPrint "ENC28J60 Ethernet Driver - Flash LED Test" : HSerPrintCRLF
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT208
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;HserPrint "Init Test": HSerPrintCRLF
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT208
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;#define ENC28J60_Select         Set ENC28J60_CS off
;#define ENC28J60_Deselect       Set ENC28J60_CS on
;#define ENC28J60_Reset_CMD			Set ENC28J60_RESET on: Wait 10 ms :Set ENC28J60_RESET off: Wait 10 ms :Set ENC28J60_RESET on: Wait 10 ms
;Dir ENC28J60_DI in
	bsf	TRISC,4,ACCESS
;Dir ENC28J60_DO Out
	bcf	TRISC,5,ACCESS
;Dir ENC28J60_SCK Out
	bcf	TRISC,3,ACCESS
;Dir ENC28J60_CS out
	bcf	TRISA,5,ACCESS
;Dir ENC28J60_RESET out
	bcf	TRISD,2,ACCESS
;set ENC28J60_DO off
	bcf	LATC,5,ACCESS
;set ENC28J60_SCK off
	bcf	LATC,3,ACCESS
;set ENC28J60_CS off
	bcf	LATA,5,ACCESS
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
;SPIMode MasterFast, 0
	movlw	13
	movwf	SPICURRENTMODE,BANKED
	clrf	SPICLOCKMODE,BANKED
	rcall	SPIMODE164
;ENC28J60_Reset_CMD
	bsf	LATD,2,ACCESS
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	bcf	LATD,2,ACCESS
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	bsf	LATD,2,ACCESS
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer( BFCCMD | ECON1 )
	movlw	191
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer( 0b00000001  )
	movlw	1
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer( BFSCMD | ECON1 )
	movlw	159
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer( 0b00000010 )
	movlw	2
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
;ENC28J60_writeReg(MIREGADR, PHLCON)
	movlw	20
	movwf	ADDR,BANKED
	movlw	20
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MIWRL, 0b10100010)
	movlw	22
	movwf	ADDR,BANKED
	movlw	162
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MIWRH, 0b00000100)
	movlw	23
	movwf	ADDR,BANKED
	movlw	4
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC SPI commands
;#define WCRCMD  0b01000000      'write control register
;#define BFCCMD  0b10100000      'bit field clear
;#define BFSCMD  0b10000000      'bit field set
;#define BFCCMD  0b10100000      'bit field clear
;ENC SFR
;#define MIREGADR        0x14
;#define ECON1           0x1f
;#define PHLCON          0x14
;#define MIWRL           0x16
;	ENC PHY register
;#define MIWRH   0x17
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	227
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	6
	movwf	DELAYTEMP,ACCESS
DMS_INNER
	decfsz	DELAYTEMP, F,ACCESS
	bra	DMS_INNER
	decfsz	DELAYTEMP2, F,ACCESS
	bra	DMS_OUTER
	decfsz	SysWaitTempMS, F,ACCESS
	bra	DMS_START
	decfsz	SysWaitTempMS_H, F,ACCESS
	bra	DMS_START
	return

;********************************************************************************

Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	decfsz	SysWaitTempS, F,ACCESS
	bra	DS_START
	return

;********************************************************************************

ENC28J60_WRITEREG
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer( addr OR WCRCMD )
	movlw	64
	iorwf	ADDR,W,BANKED
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer( ENC_Outbyte )
	movff	ENC_OUTBYTE,SPITXDATA
	rcall	FASTHWSPITRANSFER
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
;PulseOut Heartbeat, 15 Ms
;Set Pin On
	bsf	LATC,2,ACCESS
;Wait Time
	movlw	15
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set Pin Off
	bcf	LATC,2,ACCESS
	return

;********************************************************************************

FASTHWSPITRANSFER
;Set SSPCON1.WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = SPITxData
	movff	SPITXDATA,SSPBUF
;Wait While SSPSTAT.BF = Off
SysWaitLoop1
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop1
;SPIRxData = SSPBUF
	movff	SSPBUF,SPIRXDATA
;Set SSPSTAT.BF Off
	bcf	SSPSTAT,BF,ACCESS
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT208
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF4
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd1
SysForLoop1
	incf	SYSPRINTTEMP,F,BANKED
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,BANKED
	addwf	SysPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SERDATA
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;next
	movf	PRINTLEN,W,BANKED
	subwf	SYSPRINTTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;End If
ENDIF4
	return

;********************************************************************************

HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movff	HSERPRINTCRLFCOUNT,SysRepeatTemp1
	movf	SYSREPEATTEMP1,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd1
SysRepeatLoop1
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;end Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
	return

;********************************************************************************

HSERSEND
;if comport = 1 Then
	decf	COMPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF3
;Wait While TXIF = Off
SysWaitLoop2
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop2
;Wait While TXIF = Off
SysWaitLoop3
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop3
;TXREG = SerData
	movff	SERDATA,TXREG
;end if
ENDIF3
	return

;********************************************************************************

INITSYS
;BSR = 0
	clrf	BSR,ACCESS
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;SET ADFM OFF
	bcf	ADCON2,ADFM,ACCESS
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,ACCESS
;SET PCFG3 ON
	bsf	ADCON1,PCFG3,ACCESS
;SET PCFG2 ON
	bsf	ADCON1,PCFG2,ACCESS
;SET PCFG1 ON
	bsf	ADCON1,PCFG1,ACCESS
;SET PCFG0 ON
	bsf	ADCON1,PCFG0,ACCESS
;CMCON = 7
	movlw	7
	movwf	CMCON,ACCESS
;PORTA = 0
	clrf	PORTA,ACCESS
;PORTB = 0
	clrf	PORTB,ACCESS
;PORTC = 0
	clrf	PORTC,ACCESS
;PORTD = 0
	clrf	PORTD,ACCESS
;PORTE = 0
	clrf	PORTE,ACCESS
	return

;********************************************************************************

INITUSART
;comport = 1
	movlw	1
	movwf	COMPORT,BANKED
;SPBRG = SPBRGL_TEMP
	movlw	7
	movwf	SPBRG,ACCESS
;SPBRGH = SPBRGH_TEMP
	movlw	2
	movwf	SPBRGH,ACCESS
;BRG16 = BRG16_TEMP
	bsf	BAUDCON,BRG16,ACCESS
;BRGH = BRGH_TEMP
	bsf	TXSTA,BRGH,ACCESS
;Set SYNC Off
	bcf	TXSTA,SYNC,ACCESS
;Set SPEN On
	bsf	RCSTA,SPEN,ACCESS
;Set CREN On
	bsf	RCSTA,CREN,ACCESS
;Set TXEN On
	bsf	TXSTA,TXEN,ACCESS
;PIC USART 2 Init
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SPIMODE164
;Set SSPCON1.SSPEN Off
	bcf	SSPCON1,SSPEN,ACCESS
;Set SSPSTAT.SMP Off
	bcf	SSPSTAT,SMP,ACCESS
;Set SSPSTAT.CKE Off
	bcf	SSPSTAT,CKE,ACCESS
;If SPIClockMode.0 = Off Then
	btfss	SPICLOCKMODE,0,BANKED
;Set SSPSTAT.CKE On
	bsf	SSPSTAT,CKE,ACCESS
;End If
;Set SSPCON1.CKP Off
	bcf	SSPCON1,CKP,ACCESS
;If SPIClockMode.1 = On Then
	btfsc	SPICLOCKMODE,1,BANKED
;Set SSPCON1.CKP On
	bsf	SSPCON1,CKP,ACCESS
;End If
;Set SSPCON1.SSPM3 Off
	bcf	SSPCON1,SSPM3,ACCESS
;Set SSPCON1.SSPM2 Off
	bcf	SSPCON1,SSPM2,ACCESS
;Set SSPCON1.SSPM1 Off
	bcf	SSPCON1,SSPM1,ACCESS
;Set SSPCON1.SSPM0 Off
	bcf	SSPCON1,SSPM0,ACCESS
;Select Case SPICurrentMode
;Case MasterFast
SysSelect1Case1
	movlw	13
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;Case Master
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	12
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;Set SSPCON1.SSPM0 On
	bsf	SSPCON1,SSPM0,ACCESS
;Case MasterSlow
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	11
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;Set SSPCON1.SSPM1 On
	bsf	SSPCON1,SSPM1,ACCESS
;Case Slave
	bra	SysSelectEnd1
SysSelect1Case4
	movf	SPICURRENTMODE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case5
;Set SSPCON1.SSPM2 On
	bsf	SSPCON1,SSPM2,ACCESS
;Set SSPCON1.SSPM0 On
	bsf	SSPCON1,SSPM0,ACCESS
;Case SlaveSS
	bra	SysSelectEnd1
SysSelect1Case5
	decf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case6
;Set SSPCON1.SSPM2 On
	bsf	SSPCON1,SSPM2,ACCESS
;End Select
SysSelect1Case6
SysSelectEnd1
;Set SSPCON1.SSPEN On
	bsf	SSPCON1,SSPEN,ACCESS
	return

;********************************************************************************

SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;TBLRD*+
	tblrd*+
;movff TABLAT,SysCalcTempA
	movff	TABLAT,SYSCALCTEMPA
;movff TABLAT,INDF1
	movff	TABLAT,INDF1
;TBLRD*+
	tblrd*+
;goto SysStringReadCheck
	bra	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;TBLRD*+
	tblrd*+
;movf TABLAT, W
	movf	TABLAT, W,ACCESS
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA,ACCESS
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F,ACCESS
;TBLRD*+
	tblrd*+
SYSSTRINGREADCHECK
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
SYSSTRINGREAD
;TBLRD*+
	tblrd*+
;movff TABLAT,PREINC1
	movff	TABLAT,PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringRead
	bra	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables

StringTable1
	dw	10537,"ENC28J60 Ethernet Driver - Flash LED Test"


StringTable2
	dw	2313,"Init Test"


;********************************************************************************


 END
