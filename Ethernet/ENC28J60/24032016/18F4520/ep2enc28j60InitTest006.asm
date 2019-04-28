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
SYSCALCTEMPX	EQU	0
SysBYTETempA	EQU	5
SysBYTETempB	EQU	9
SysBYTETempX	EQU	0
SysDivLoop	EQU	4
SysStringA	EQU	7
SysStringA_H	EQU	8
SysStringLength	EQU	6
SysWaitTempMS	EQU	2
SysWaitTempMS_H	EQU	3
ETHERBUFFER	EQU	1405
SYSSTRINGPARAM1	EQU	1364
MACADDR	EQU	1357
IPADDR	EQU	1352
IPSERVER	EQU	1347
HEX	EQU	1343
ADDR	EQU	10
BANKTOBESELECTED	EQU	11
COMPORT	EQU	12
ENC28J60_READREG	EQU	13
ENC_LAST_TXBUF	EQU	14
ENC_LAST_TXBUF_H	EQU	15
ENC_OUTBYTE	EQU	16
ENC_OUTBYTE1	EQU	17
ENC_OUTBYTE2	EQU	18
FRAMELENGTH	EQU	19
HSERPRINTCRLFCOUNT	EQU	20
IPPORT	EQU	21
LASTSELECTEDBANK	EQU	22
MACON2	EQU	23
MICON1	EQU	24
MICON2	EQU	25
OUTVALUETEMP	EQU	26
PHYREGADDR	EQU	27
PRINTLEN	EQU	28
SERDATA	EQU	29
SERPRINTVAL	EQU	30
SPICLOCKMODE	EQU	31
SPICURRENTMODE	EQU	32
SPIRXDATA	EQU	33
SPITXDATA	EQU	34
SYSPRINTTEMP	EQU	35
SYSREPEATTEMP1	EQU	36
SYSSTRINGTEMP	EQU	37
SYSVALTEMP	EQU	38
StringPointer	EQU	39
SysMACADDRHandler	EQU	40
SysMACADDRHandler_H	EQU	41
SysPRINTDATAHandler	EQU	42
SysPRINTDATAHandler_H	EQU	43
SysTemp1	EQU	44
SysTemp2	EQU	45
TEMP	EQU	46
XX	EQU	47

;********************************************************************************

;Alias variables
AFSR0	EQU	4073
AFSR0_H	EQU	4074
SYSHEX_0	EQU	1343
SYSHEX_1	EQU	1344
SYSHEX_2	EQU	1345
SYSMACADDR_1	EQU	1358
SYSMACADDR_2	EQU	1359
SYSMACADDR_3	EQU	1360
SYSMACADDR_4	EQU	1361
SYSMACADDR_5	EQU	1362
SYSMACADDR_6	EQU	1363

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
	call	INITSYS
	rcall	ENC28J60_INITIALISE
	call	INITUSART

;Start of the main program
;''A program  for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;'' Description  :  Setup ENC28J60, then reads data from the Ethernet stream to a PC terminal.
;''
;''	You NEED a PC terminal connected to the serial out on the microprocessor.
;''
;''@author 		[todo]
;''@licence		GPL
;''@version		[todo]
;''@date   		[todo]
;''********************************************************************************
;#define USART_BAUD_RATE 9600
;#define USART_BLOCKING
;#define USART_TX_BLOCKING
;----- Define Hardware settings
;#Define ENC28J60_DI			PortC.4							'Connected to Device SO
;#Define ENC28J60_DO			PortC.5							'Connected to Device SI
;#Define ENC28J60_SCK		PortC.3							'Connected to Clock
;#Define ENC28J60_CS 		PortA.5							'Chip select line
;#Define ENC28J60_RESET  PortD.2							'Reset line
;#Define Heartbeat 			PortC.2
;#Define TX 							PortC.7
;#Define RX							PortC.6
;----- Variables
;----- Quick Command Reference:
;----- Main body of program commences here.
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HserPrint "ENC28J60 Ethernet Driver 006" : HSerPrintCRLF
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT215
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HserPrint "Init Test": HSerPrintCRLF
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT215
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;ipaddr = 192,168,0,1
	lfsr	0,IPADDR
	movlw	4
	movwf	POSTINC0,ACCESS
	movlw	192
	movwf	POSTINC0,ACCESS
	movlw	168
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	movlw	1
	movwf	POSTINC0,ACCESS
;ipport = 80
	movlw	80
	movwf	IPPORT,BANKED
;ipserver = 192,168,0,249
	lfsr	0,IPSERVER
	movlw	4
	movwf	POSTINC0,ACCESS
	movlw	192
	movwf	POSTINC0,ACCESS
	movlw	168
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	movlw	249
	movwf	POSTINC0,ACCESS
;macaddr = 0x42, 0x00, 0x33, 0x44, 0x55, 0x65
	lfsr	0,MACADDR
	movlw	6
	movwf	POSTINC0,ACCESS
	movlw	66
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	movlw	51
	movwf	POSTINC0,ACCESS
	movlw	68
	movwf	POSTINC0,ACCESS
	movlw	85
	movwf	POSTINC0,ACCESS
	movlw	101
	movwf	POSTINC0,ACCESS
;ENC28J60_Init ( macaddr )
	movlw	low MACADDR
	movwf	SysMACADDRHandler,BANKED
	movlw	high MACADDR
	movwf	SysMACADDRHandler_H,BANKED
	rcall	ENC28J60_INIT
;ENC28J60_WriteReg(MIREGADR, PHLCON)
	movlw	212
	movwf	ADDR,BANKED
	movlw	20
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_WriteReg(MIWRL, 0b01110010)
;ENC28J60_WriteReg(MIWRH, 0b00000100)
;ENC28J60_WriteReg( MIWRL, 0x04 )
	movlw	214
	movwf	ADDR,BANKED
	movlw	4
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_WriteReg( MIWRH, 0x76 )
	movlw	215
	movwf	ADDR,BANKED
	movlw	118
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;for xx = 1 to 5
	clrf	XX,BANKED
SysForLoop1
	incf	XX,F,BANKED
;ENC28J60_WriteReg(ECOCON, xx)
	movlw	117
	movwf	ADDR,BANKED
	movff	XX,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;next
	movlw	5
	subwf	XX,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;HserPrint         "Mac Address:         "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
;HserPrint hex(ENC28J60_ReadReg(MAADR1))+"-"
	movlw	224
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,SYSVALTEMP
	rcall	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	lfsr	0,HEX
	call	SysCopyStringPart
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
;HserPrint hex(ENC28J60_ReadReg(MAADR0))+"-"
	movlw	225
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,SYSVALTEMP
	rcall	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	lfsr	0,HEX
	call	SysCopyStringPart
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
;HserPrint hex(ENC28J60_ReadReg(MAADR3))+"-"
	movlw	226
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,SYSVALTEMP
	rcall	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	lfsr	0,HEX
	call	SysCopyStringPart
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
;HserPrint hex(ENC28J60_ReadReg(MAADR2))+"-"
	movlw	227
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,SYSVALTEMP
	rcall	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	lfsr	0,HEX
	call	SysCopyStringPart
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
;HserPrint hex(ENC28J60_ReadReg(MAADR5))+"-"
	movlw	228
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,SYSVALTEMP
	rcall	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	lfsr	0,HEX
	call	SysCopyStringPart
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
;HserPrint hex(ENC28J60_ReadReg(MAADR4)): HSerPrintCRLF
	movlw	229
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,SYSVALTEMP
	rcall	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;do
SysDoLoop_S1
;if (ENC28J60_ReadReg(EPKTCNT) = 1 ) then '* We received a packet
	movlw	57
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	decf	ENC28J60_READREG,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE2_1
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer  0b00111010, temp
	movlw	58
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;for xx = 1 to 6
	clrf	XX,BANKED
SysForLoop2
	incf	XX,F,BANKED
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = ENC28J60_READ_CTRL_REG | ( addr AND ADDR_MASK )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SSPBUF
;Wait While BF = Off
SysWaitLoop1
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop1
;Set BF Off
	bcf	SSPSTAT,BF,ACCESS
;next
	movlw	6
	subwf	XX,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;HSerPrint "Destination address: "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
;for xx = 1 to 6
	clrf	XX,BANKED
SysForLoop3
	incf	XX,F,BANKED
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = ENC28J60_READ_CTRL_REG | ( addr AND ADDR_MASK )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SSPBUF
;Wait While BF = Off
SysWaitLoop2
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop2
;HSerPrint hex(SSPBUF)
	movff	SSPBUF,SYSVALTEMP
	rcall	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
;Set BF Off
	bcf	SSPSTAT,BF,ACCESS
;if xx < 6 then HSerPrint "-"
	movlw	6
	subwf	XX,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF4
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
ENDIF4
;next
	movlw	6
	subwf	XX,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;HSerPrint "Source address:      "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
;for xx = 1 to 6
	clrf	XX,BANKED
SysForLoop4
	incf	XX,F,BANKED
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = ENC28J60_READ_CTRL_REG | ( addr AND ADDR_MASK )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SSPBUF
;Wait While BF = Off
SysWaitLoop3
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop3
;HSerPrint hex(SSPBUF)
	movff	SSPBUF,SYSVALTEMP
	rcall	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
;Set BF Off
	bcf	SSPSTAT,BF,ACCESS
;if xx < 6 then HSerPrint "-"
	movlw	6
	subwf	XX,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF6
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
ENDIF6
;next
	movlw	6
	subwf	XX,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;HSerPrint "Type/Length:         "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = ENC28J60_READ_CTRL_REG | ( addr AND ADDR_MASK )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SSPBUF
;Wait While BF = Off
SysWaitLoop4
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop4
;temp = SSPBUF
	movff	SSPBUF,TEMP
;HSerPrint hex(temp)
	movff	TEMP,SYSVALTEMP
	rcall	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = ENC28J60_READ_CTRL_REG | ( addr AND ADDR_MASK )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SSPBUF
;Wait While BF = Off
SysWaitLoop5
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop5
;framelength = SSPBUF
	movff	SSPBUF,FRAMELENGTH
;Set BF Off
	bcf	SSPSTAT,BF,ACCESS
;HSerPrint hex(framelength)
	movff	FRAMELENGTH,SYSVALTEMP
	rcall	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;for xx = 14 to 59
	movlw	13
	movwf	XX,BANKED
SysForLoop5
	incf	XX,F,BANKED
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = ENC28J60_READ_CTRL_REG | ( addr AND ADDR_MASK )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SSPBUF
;Wait While BF = Off
SysWaitLoop6
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop6
;HSerPrint SSPBUF
	movff	SSPBUF,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT216
;Set BF Off
	bcf	SSPSTAT,BF,ACCESS
;HSerPrint ","
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT215
;next
	movlw	59
	subwf	XX,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
SysForLoopEnd5
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;ENC28J60_DeSelect
	bsf	LATA,5,ACCESS
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer(BFSCMD | ECON2, temp)
	movlw	158
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer(EPKTDEC , temp)
	movlw	64
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
;else
ELSE2_1
;end if
;loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;end
	bra	BASPROGRAMEND
;----- Support methods.  Subroutines and Functions
;#define ENC28J60_Select         Set ENC28J60_CS off
;#define ENC28J60_Deselect       Set ENC28J60_CS on
;#define ENC28J60_Reset_CMD			Set ENC28J60_RESET on: Wait 10 ms :Set ENC28J60_RESET off: Wait 10 ms :Set ENC28J60_RESET on: Wait 10 ms
CONFIGURATIONDETAILS
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

ENC28J60_INIT
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
;SPIMode Master, 0
	movlw	12
	movwf	SPICURRENTMODE,BANKED
	clrf	SPICLOCKMODE,BANKED
	rcall	SPIMODE171
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
;FastHWSPITransfer( ENC28J60_SOFT_RESET, temp )
	setf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;lastselectedBank = 99
	movlw	99
	movwf	LASTSELECTEDBANK,BANKED
;wait while ( (ENC28J60_ReadReg( ESTAT ) & ESTAT_CLKRDY ) <> ESTAT_CLKRDY)
SysWaitLoop7
	movlw	29
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movlw	1
	andwf	ENC28J60_READREG,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	1
	movwf	SysBYTETempB,ACCESS
	rcall	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
	bra	SysWaitLoop7
;ENC28J60_writeReg(ECON1, 0xC0) 'Hold it in Reset
	movlw	31
	movwf	ADDR,BANKED
	movlw	192
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(ECON2, 0x80) 'Set the AUTOINC bit
	movlw	30
	movwf	ADDR,BANKED
	movlw	128
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(EIR, 0x00) 'Reset interrupt flags
	movlw	28
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(EIE,  0xC0)  'Interrupts: Packet reception
	movlw	27
	movwf	ADDR,BANKED
	movlw	192
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(EWOLIE, 0x00)  'Disable wake-on-lan interrupts
	movlw	54
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(EWOLIR, 0x00)  'Clear wake-on-lan interrupt flags
	movlw	55
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(ETXSTL, ENC_TXBUF_STL)
	movlw	4
	movwf	ADDR,BANKED
	movlw	112
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(ETXSTH, ENC_TXBUF_STH)
	movlw	5
	movwf	ADDR,BANKED
	movlw	22
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(ETXNDL, ENC_TXBUF_NDL)
	movlw	6
	movwf	ADDR,BANKED
	setf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(ETXNDH, ENC_TXBUF_NDH)  'TX Buffer : 1800 bytes
	movlw	7
	movwf	ADDR,BANKED
	movlw	31
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXSTL, ENC_RXBUF_STL)
	movlw	8
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXSTH, ENC_RXBUF_STH)
	movlw	9
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXNDL, ENC_RXBUF_NDL)
	movlw	10
	movwf	ADDR,BANKED
	movlw	110
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXNDH, ENC_RXBUF_NDH)  'RX Buffer : 6390 bytes
	movlw	11
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERDPTL, ENC_RXBUF_STL)
	clrf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERDPTH, ENC_RXBUF_STH)
	movlw	1
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXRDPTL, ENC_RXBUF_STL)
	movlw	12
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXRDPTH, ENC_RXBUF_STH) 'RX Pointers (same)
	movlw	13
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXFCON, 0xA1) 'Receive unicasts or broadcasts
	movlw	56
	movwf	ADDR,BANKED
	movlw	161
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(EFLOCON, 0x00) 'Disable flow control sending
	movlw	119
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(ECOCON, 0x00) 'Disable Clock Out pin
	movlw	117
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(EBSTCON, 0x00) 'Disable built-in self test controller
	movlw	103
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;wait while ( (ENC28J60_ReadReg(ESTAT) & ESTAT_CLKRDY) <> ESTAT_CLKRDY)
SysWaitLoop8
	movlw	29
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movlw	1
	andwf	ENC28J60_READREG,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	1
	movwf	SysBYTETempB,ACCESS
	rcall	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
	bra	SysWaitLoop8
;ENC28J60_writeReg(MISTAT, 0x00)  'Clear MII status register
	movlw	234
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MICMD, 0x00)   'Clear MII command register
	movlw	210
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MICON1, 0x02)  'Fast MII operation
	movff	MICON1,ADDR
	movlw	2
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MICON2, 0x00)  'Release MII interface from reset
	movff	MICON2,ADDR
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MACON1, b'00001101' )  'Enable packet reception
	movlw	192
	movwf	ADDR,BANKED
	movlw	13
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MACON2, 0x00)  'Release the MAC subsystem from reset
	movff	MACON2,ADDR
	clrf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MACON3, 0xF0)  'Auto Pad + CRC + Half Duplex
	movlw	194
	movwf	ADDR,BANKED
	movlw	240
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MACON4, 0x01)  'Need valid preamble
	movlw	195
	movwf	ADDR,BANKED
	movlw	1
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAPHSUP, b'00010000') 'Release MAC-PHY support from Reset
	movlw	205
	movwf	ADDR,BANKED
	movlw	16
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAMXFLL, 0xEE)
	movlw	202
	movwf	ADDR,BANKED
	movlw	238
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAMXFLH, 0x5)  'Maximum frame length
	movlw	203
	movwf	ADDR,BANKED
	movlw	5
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MABBIPG, 0x12) 'IEEE BTB Inter Packet Gap
	movlw	196
	movwf	ADDR,BANKED
	movlw	18
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAIPGL, 0x12)
	movlw	198
	movwf	ADDR,BANKED
	movlw	18
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAIPGH, 0x0C)  'IEEE Non BTB Inter Packet Gap
	movlw	199
	movwf	ADDR,BANKED
	movlw	12
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAADR0, macaddr(2))
	movlw	225
	movwf	ADDR,BANKED
	movff	SYSMACADDR_2,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAADR1, macaddr(1))
	movlw	224
	movwf	ADDR,BANKED
	movff	SYSMACADDR_1,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAADR2, macaddr(4))
	movlw	227
	movwf	ADDR,BANKED
	movff	SYSMACADDR_4,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAADR3, macaddr(3))
	movlw	226
	movwf	ADDR,BANKED
	movff	SYSMACADDR_3,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAADR4, macaddr(6))
	movlw	229
	movwf	ADDR,BANKED
	movff	SYSMACADDR_6,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAADR5, macaddr(5))
	movlw	228
	movwf	ADDR,BANKED
	movff	SYSMACADDR_5,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;'Initialize PHY subsystem
;ENC28J60_writePhyReg(PHCON1, 0x00, 0x00)  'Half duplex
	clrf	PHYREGADDR,BANKED
	clrf	ENC_OUTBYTE1,BANKED
	clrf	ENC_OUTBYTE2,BANKED
	rcall	ENC28J60_WRITEPHYREG
;ENC28J60_writePhyReg(PHCON2, 0x00, 0x00)
	movlw	16
	movwf	PHYREGADDR,BANKED
	clrf	ENC_OUTBYTE1,BANKED
	clrf	ENC_OUTBYTE2,BANKED
	rcall	ENC28J60_WRITEPHYREG
;ENC28J60_writePhyReg(PHLCON, B'00000100', B'01110110')
	movlw	20
	movwf	PHYREGADDR,BANKED
	movlw	4
	movwf	ENC_OUTBYTE1,BANKED
	movlw	118
	movwf	ENC_OUTBYTE2,BANKED
	rcall	ENC28J60_WRITEPHYREG
;ENC28J60_writePhyReg(PHIE, 0x00, 0x00)  'Disable interrupts
	movlw	18
	movwf	PHYREGADDR,BANKED
	clrf	ENC_OUTBYTE1,BANKED
	clrf	ENC_OUTBYTE2,BANKED
	rcall	ENC28J60_WRITEPHYREG
;ENC28J60_writeReg(ECON1, B'00010100')
	movlw	31
	movwf	ADDR,BANKED
	movlw	20
	movwf	ENC_OUTBYTE,BANKED
	bra	ENC28J60_WRITEREG

;********************************************************************************

ENC28J60_INITIALISE
;macaddr =   0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	lfsr	0,MACADDR
	movlw	6
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
;ipaddr =    0,0,0,0
	lfsr	0,IPADDR
	movlw	4
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
;ipserver =  0,0,0,0
	lfsr	0,IPSERVER
	movlw	4
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
;ipport = 80   'set a default value
	movlw	80
	movwf	IPPORT,BANKED
	return

;********************************************************************************

FN_ENC28J60_READREG
;banktobeselected =  ( addr & BANK_MASK) / 32
	movlw	96
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	32
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempA,BANKTOBESELECTED
;				'These registers (EIE, EIR, ESTAT, ECON2, ECON1)
;				'are present in all banks, no need to switch bank
;if lastselectedBank <> banktobeselected then
	movf	BANKTOBESELECTED,W,BANKED
	subwf	LASTSELECTEDBANK,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF11
;if ( ( addr & ADDR_MASK ) <= EIE  ) then
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempB
	movlw	27
	movwf	SysBYTETempA,ACCESS
	rcall	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE12_1
;ENC28J60_selectBank ( banktobeselected, addr )
	rcall	ENC28J60_SELECTBANK
;else
	bra	ENDIF12
ELSE12_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF12
;end if
ENDIF11
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = ENC28J60_READ_CTRL_REG | ( addr AND ADDR_MASK )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SSPBUF
;Wait While BF = Off
SysWaitLoop9
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop9
;temp = SSPBUF
	movff	SSPBUF,TEMP
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = temp
	movff	TEMP,SSPBUF
;Wait While BF = Off
SysWaitLoop10
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop10
;temp = SSPBUF
	movff	SSPBUF,TEMP
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = temp
	movff	TEMP,SSPBUF
;Wait While BF = Off
SysWaitLoop11
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop11
;ENC28J60_ReadReg = SSPBUF
	movff	SSPBUF,ENC28J60_READREG
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

ENC28J60_SELECTBANK
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer(BFCCMD | ECON1, temp)
	movlw	191
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer(b'00000011', temp)
	movlw	3
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
;Select case banktobeselected
;case 1
SysSelect1Case1
	decf	BANKTOBESELECTED,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer(BFSCMD | ECON1, temp)
	movlw	159
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer(b'00000001' , temp)
	movlw	1
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
;case 2
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	BANKTOBESELECTED,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;	ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer(BFSCMD | ECON1, temp)
	movlw	159
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer(b'00000010' , temp)
	movlw	2
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
;case 3
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	BANKTOBESELECTED,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;	ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer(BFSCMD | ECON1, temp)
	movlw	159
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer(b'00000011' , temp)
	movlw	3
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
;End Select
SysSelect1Case4
SysSelectEnd1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
	return

;********************************************************************************

ENC28J60_WRITEPHYREG
;		while ((ENC28J60_ReadReg(MISTAT) & MISTAT_BUSY ) = 1)
SysDoLoop_S2
	movlw	234
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
;ENC28J60_writeReg( MIREGADR, PhyRegaddr )
	movlw	212
	movwf	ADDR,BANKED
	movff	PHYREGADDR,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg( MIWRL, ENC_Outbyte1 )
	movlw	214
	movwf	ADDR,BANKED
	movff	ENC_OUTBYTE1,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg( MIWRH, ENC_Outbyte2 )
	movlw	215
	movwf	ADDR,BANKED
	movff	ENC_OUTBYTE2,ENC_OUTBYTE
	bra	ENC28J60_WRITEREG

;********************************************************************************

ENC28J60_WRITEREG
;banktobeselected = ( addr & BANK_MASK) / 32
	movlw	96
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	32
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempA,BANKTOBESELECTED
;if lastselectedBank <> banktobeselected then
	movf	BANKTOBESELECTED,W,BANKED
	subwf	LASTSELECTEDBANK,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ELSE9_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempB
	movlw	27
	movwf	SysBYTETempA,ACCESS
	rcall	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
;ENC28J60_selectBank ( banktobeselected, addr )
	rcall	ENC28J60_SELECTBANK
;end if
;Else
	bra	ENDIF9
ELSE9_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF9
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer( ENC28J60_WRITE_CTRL_REG | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	64
	iorwf	SysTemp1,W,BANKED
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer( ENC_Outbyte, temp )
	movff	ENC_OUTBYTE,SPITXDATA
	rcall	FASTHWSPITRANSFER
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

FASTHWSPITRANSFER
;Set SSPCON1.WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = SPITxData
	movff	SPITXDATA,SSPBUF
;Wait While SSPSTAT.BF = Off
SysWaitLoop12
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop12
;Set SSPSTAT.BF Off
	bcf	SSPSTAT,BF,ACCESS
;SPIRxData = SSPBUF
	movff	SSPBUF,SPIRXDATA
	return

;********************************************************************************

FN_HEX
;Hex(0) = 2
	movlw	2
	banksel	SYSHEX_0
	movwf	SYSHEX_0,BANKED
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	banksel	SYSVALTEMP
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF15
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF15
;Hex(2) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_2
	movwf	SYSHEX_2,BANKED
;For SysStringTemp = 1 to 4
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
SysForLoop6
	incf	SYSSTRINGTEMP,F,BANKED
;Rotate SysValTemp Right
	rrcf	SYSVALTEMP,F,BANKED
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop6
SysForLoopEnd6
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF17
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF17
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_1
	movwf	SYSHEX_1,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT215
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF19
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd7
SysForLoop7
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
	bra	SysForLoop7
SysForLoopEnd7
;End If
ENDIF19
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT216
;OutValueTemp = 0
	clrf	OUTVALUETEMP,BANKED
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ENDIF22
;OutValueTemp = SerPrintVal / 100
	movff	SERPRINTVAL,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;End If
ENDIF22
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movff	OUTVALUETEMP,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	rcall	SysCompLessThan
	movff	SysByteTempX,SysTemp1
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF23
;OutValueTemp = SerPrintVal / 10
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;End If
ENDIF23
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	addwf	SERPRINTVAL,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	bra	Delay_MS

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
	bra	ENDIF18
;Wait While TXIF = Off
SysWaitLoop13
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop13
;Wait While TXIF = Off
SysWaitLoop14
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop14
;TXREG = SerData
	movff	SERDATA,TXREG
;end if
ENDIF18
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
SPIMODE171
;Set SSPCON1.SSPEN Off ;(Prevents any weird glitches during setup)
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
SysSelect2Case1
	movlw	13
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
;Case Master
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	12
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case3
;Set SSPCON1.SSPM0 On
	bsf	SSPCON1,SSPM0,ACCESS
;Case MasterSlow
	bra	SysSelectEnd2
SysSelect2Case3
	movlw	11
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case4
;Set SSPCON1.SSPM1 On
	bsf	SSPCON1,SSPM1,ACCESS
;Case Slave
	bra	SysSelectEnd2
SysSelect2Case4
	movf	SPICURRENTMODE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case5
;Set SSPCON1.SSPM2 On
	bsf	SSPCON1,SSPM2,ACCESS
;Set SSPCON1.SSPM0 On
	bsf	SSPCON1,SSPM0,ACCESS
;Case SlaveSS
	bra	SysSelectEnd2
SysSelect2Case5
	decf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case6
;Set SSPCON1.SSPM2 On
	bsf	SSPCON1,SSPM2,ACCESS
;End Select
SysSelect2Case6
SysSelectEnd2
;Set SSPCON1.SSPEN On
	bsf	SSPCON1,SSPEN,ACCESS
	return

;********************************************************************************

SYSCOMPEQUAL
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;cpfseq SysByteTempA
	cpfseq	SYSBYTETEMPA,ACCESS
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

SYSCOMPLESSTHAN
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;cpfslt SysByteTempA
	cpfslt	SYSBYTETEMPA,ACCESS
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

SYSCOPYSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;movff INDF0, SysCalcTempA
	movff	INDF0, SYSCALCTEMPA
;movff SysCalcTempA, INDF1
	movff	SYSCALCTEMPA, INDF1
;goto SysCopyStringCheck
	bra	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART
;movf INDF0, W
	movf	INDF0, W,ACCESS
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA,ACCESS
;addwf SysStringLength, F
	addwf	SYSSTRINGLENGTH, F,ACCESS
SYSCOPYSTRINGCHECK
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
SYSSTRINGCOPY
;movff PREINC0, PREINC1
	movff	PREINC0, PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringCopy
	bra	SYSSTRINGCOPY
	return

;********************************************************************************

SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;SysDivLoop = 8
	movlw	8
	movwf	SYSDIVLOOP,ACCESS
SYSDIV8START
;bcf STATUS, C
	bcf	STATUS, C,ACCESS
;rlf SysByteTempA, F
	rlcf	SYSBYTETEMPA, F,ACCESS
;rlf SysByteTempX, F
	rlcf	SYSBYTETEMPX, F,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;subwf SysByteTempX, F
	subwf	SYSBYTETEMPX, F,ACCESS
;bsf SysByteTempA, 0
	bsf	SYSBYTETEMPA, 0,ACCESS
;btfsc STATUS, C
	btfsc	STATUS, C,ACCESS
;goto Div8NotNeg
	bra	DIV8NOTNEG
;bcf SysByteTempA, 0
	bcf	SYSBYTETEMPA, 0,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F,ACCESS
DIV8NOTNEG
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv8Start
	bra	SYSDIV8START
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
	dw	7196,"ENC28J60 Ethernet Driver 006"


StringTable2
	dw	2313,"Init Test"


StringTable3
	dw	5397,"Mac Address:         "


StringTable4
	dw	257,"-"


StringTable5
	dw	5397,"Destination address: "


StringTable6
	dw	5397,"Source address:      "


StringTable7
	dw	5397,"Type/Length:         "


StringTable8
	dw	257,","


;********************************************************************************


 END
