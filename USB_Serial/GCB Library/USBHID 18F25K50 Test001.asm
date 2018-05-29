;Program compiled by Great Cow BASIC (0.98.<<>> 2018-05-28)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18LF25K50, r=DEC
#include <P18LF25K50.inc>
 CONFIG LVP = OFF, MCLRE = OFF, WDTEN = OFF, FOSC = INTOSCIO, CPUDIV = NOCLKDIV

;********************************************************************************

;Set aside memory locations for variables
ADREADPORT	EQU	10
COMPORT	EQU	11
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
GCBBUILDSTR	EQU	1901
GCBBUILDTIMESTR	EQU	1944
HEX	EQU	1897
HSERPRINTCRLFCOUNT	EQU	12
MEMDATA	EQU	13
OUTVALUETEMP	EQU	16
PEEK	EQU	17
PRINTLEN	EQU	18
READAD10	EQU	19
READAD10_H	EQU	20
SAVEDELAYTEMP2	EQU	21
SAVEFSR0H	EQU	22
SAVEFSR0L	EQU	23
SAVEFSR1H	EQU	24
SAVEFSR1L	EQU	25
SAVESYSBYTETEMPA	EQU	26
SAVESYSBYTETEMPB	EQU	27
SAVESYSBYTETEMPX	EQU	28
SAVESYSDIVLOOP	EQU	29
SAVESYSSTRINGA	EQU	30
SAVESYSSTRINGLENGTH	EQU	31
SAVESYSTEMP1	EQU	32
SAVESYSTEMP2	EQU	33
SAVESYSWAITTEMPMS	EQU	34
SAVESYSWAITTEMPMS_H	EQU	35
SENSORVALUE1	EQU	36
SENSORVALUE1_H	EQU	37
SENSORVALUE2	EQU	38
SENSORVALUE2_H	EQU	39
SENSORVALUE3	EQU	40
SENSORVALUE3_H	EQU	41
SENSORVALUE4	EQU	42
SENSORVALUE4_H	EQU	43
SERDATA	EQU	44
SERPRINTVAL	EQU	45
STRINGPOINTER	EQU	46
SYSBSR	EQU	47
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSCALCTEMPX	EQU	0
SYSDIVLOOP	EQU	4
SYSPRINTDATAHANDLER	EQU	48
SYSPRINTDATAHANDLER_H	EQU	49
SYSPRINTTEMP	EQU	50
SYSREPEATTEMP1	EQU	51
SYSREPEATTEMP2	EQU	52
SYSSTATUS	EQU	15
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	1917
SYSSTRINGPARAM2	EQU	1907
SYSSTRINGTEMP	EQU	53
SYSTEMP1	EQU	54
SYSTEMP1_H	EQU	55
SYSTEMP2	EQU	56
SYSVALTEMP	EQU	57
SYSW	EQU	14
SYSWAITTEMP10US	EQU	5
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
USBBMREQUESTTYPE	EQU	58
USBBUFFERSTAT	EQU	59
USBCURRBYTE	EQU	60
USBCURRCONFIGURATION	EQU	61
USBCURRENDPOINT	EQU	62
USBDESCINDEX	EQU	63
USBDESCSIZEIN	EQU	64
USBDESCSTART	EQU	65
USBDESCTYPE	EQU	66
USBHASDATA	EQU	67
USBLASTCONTROL	EQU	68
USBNEWADDRESS	EQU	69
USBPID	EQU	70
USBRAM	EQU	1024
USBSIZE	EQU	71
USBSTATE	EQU	72
USBTEMPBUFFER	EQU	1927
USBTEMPBYTE	EQU	73
USBTEMPSTRING	EQU	2005
VERSIONSTRING	EQU	1964

;********************************************************************************

;Alias variables
AFSR0	EQU	4073
AFSR0_H	EQU	4074
MEMADR	EQU	4073
MEMADR_H	EQU	4074
SYSHEX_0	EQU	1897
SYSHEX_1	EQU	1898
SYSHEX_2	EQU	1899
SYSREADAD10WORD	EQU	19
SYSREADAD10WORD_H	EQU	20
SYSUSBTEMPBUFFER_0	EQU	1927
SYSUSBTEMPBUFFER_1	EQU	1928
SYSUSBTEMPBUFFER_2	EQU	1929
SYSUSBTEMPBUFFER_3	EQU	1930
SYSUSBTEMPBUFFER_6	EQU	1933
SYSUSBTEMPSTRING_0	EQU	2005
USB_IN0_ADDR	EQU	1030
USB_IN0_ADDR_H	EQU	1031
USB_IN0_CNT	EQU	1029
USB_IN0_STAT	EQU	1028
USB_OUT0_ADDR	EQU	1026
USB_OUT0_ADDR_H	EQU	1027
USB_OUT0_CNT	EQU	1025
USB_OUT0_STAT	EQU	1024

;********************************************************************************

;Vectors
	ORG	0
	goto	BASPROGRAMSTART
	ORG	8
	bra	INTERRUPT

;********************************************************************************

;Start of program memory page 0
	ORG	12
BASPROGRAMSTART
;Call initialisation routines
	rcall	INITSYS
	rcall	INITUSART
	rcall	INITUSB
;Enable interrupts
	bsf	INTCON,GIE,ACCESS
	bsf	INTCON,PEIE,ACCESS
;Automatic pin direction setting
	bcf	TRISB,5,ACCESS

;Start of the main program
	bcf	TRISC,6,ACCESS
	bcf	TRISB,0,ACCESS
	bsf	LATB,0,ACCESS
	movlw	15
	movwf	SysRepeatTemp1,BANKED
SysRepeatLoop1
	clrf	SysTemp1,BANKED
	btfsc	PORTB,0,ACCESS
	incf	SysTemp1,F,BANKED
ENDIF1
	comf	SysTemp1,F,BANKED
	bcf	LATB,0,ACCESS
	btfsc	SysTemp1,0,BANKED
	bsf	LATB,0,ACCESS
ENDIF2
	movlw	50
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	clrf	SysTemp1,BANKED
	btfsc	PORTB,0,ACCESS
	incf	SysTemp1,F,BANKED
ENDIF3
	comf	SysTemp1,F,BANKED
	bcf	LATB,0,ACCESS
	btfsc	SysTemp1,0,BANKED
	bsf	LATB,0,ACCESS
ENDIF4
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
	rcall	FN_GCBBUILDSTR
	lfsr	1,VERSIONSTRING
	clrf	SysStringLength,ACCESS
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	rcall	SysReadStringPart
	lfsr	0,GCBBUILDSTR
	rcall	SysCopyStringPart
	lfsr	0,VERSIONSTRING
	movff	SysStringLength, INDF0
	rcall	FN_GCBBUILDTIMESTR
	lfsr	1,VERSIONSTRING
	clrf	SysStringLength,ACCESS
	lfsr	0,VERSIONSTRING
	rcall	SysCopyStringPart
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	rcall	SysReadStringPart
	lfsr	0,GCBBUILDTIMESTR
	rcall	SysCopyStringPart
	lfsr	0,VERSIONSTRING
	movff	SysStringLength, INDF0
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
	rcall	HSERPRINT266
	movlw	low VERSIONSTRING
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high VERSIONSTRING
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT266
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
	rcall	INITUSB
SysDoLoop_S1
	clrf	ADREADPORT,BANKED
	rcall	FN_READAD1018
	movff	SYSREADAD10WORD,SENSORVALUE1
	movff	SYSREADAD10WORD_H,SENSORVALUE1_H
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	movlw	1
	movwf	ADREADPORT,BANKED
	rcall	FN_READAD1018
	movff	SYSREADAD10WORD,SENSORVALUE2
	movff	SYSREADAD10WORD_H,SENSORVALUE2_H
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	movlw	2
	movwf	ADREADPORT,BANKED
	rcall	FN_READAD1018
	movff	SYSREADAD10WORD,SENSORVALUE3
	movff	SYSREADAD10WORD_H,SENSORVALUE3_H
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	movlw	3
	movwf	ADREADPORT,BANKED
	rcall	FN_READAD1018
	movff	SYSREADAD10WORD,SENSORVALUE4
	movff	SYSREADAD10WORD_H,SENSORVALUE4_H
	bra	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

DESCRIPTORHANDLER
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT266
	movff	USBDESCTYPE,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT267
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	bra	HSERPRINTCRLF

;********************************************************************************

Delay_10US
D10US_START
	movlw	39
	movwf	DELAYTEMP,ACCESS
DelayUS0
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS0
	decfsz	SysWaitTemp10US, F,ACCESS
	bra	D10US_START
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	179
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	21
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

ERRORHANDLER
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT266
	movff	UEIR,SYSVALTEMP
	rcall	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT266
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	bra	HSERPRINTCRLF

;********************************************************************************

FN_GCBBUILDSTR
	lfsr	1,GCBBUILDSTR
	movlw	low StringTable20
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable20
	movwf	TBLPTRH,ACCESS
	bra	SysReadString

;********************************************************************************

FN_GCBBUILDTIMESTR
	lfsr	1,GCBBUILDTIMESTR
	movlw	low StringTable21
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable21
	movwf	TBLPTRH,ACCESS
	bra	SysReadString

;********************************************************************************

FN_HEX
	movlw	2
	banksel	SYSHEX_0
	movwf	SYSHEX_0,BANKED
	movlw	15
	banksel	SYSVALTEMP
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF44
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF44
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_2
	movwf	SYSHEX_2,BANKED
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
SysForLoop7
	incf	SYSSTRINGTEMP,F,BANKED
	rrcf	SYSVALTEMP,F,BANKED
	movlw	4
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop7
ENDIF45
SysForLoopEnd7
	movlw	15
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF46
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF46
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_1
	movwf	SYSHEX_1,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT266
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF40
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd6
ENDIF41
SysForLoop6
	incf	SYSPRINTTEMP,F,BANKED
	movf	SYSPRINTTEMP,W,BANKED
	addwf	SysPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SERDATA
	rcall	HSERSEND
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	movf	PRINTLEN,W,BANKED
	subwf	SYSPRINTTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop6
ENDIF42
SysForLoopEnd6
ENDIF40
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT267
	clrf	OUTVALUETEMP,BANKED
	movlw	100
	subwf	SERPRINTVAL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ENDIF47
	movff	SERPRINTVAL,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempA,OUTVALUETEMP
	movff	SYSCALCTEMPX,SERPRINTVAL
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
ENDIF47
	movff	OUTVALUETEMP,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	rcall	SysCompLessThan
	movff	SysByteTempX,SysTemp2
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp2,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfss	SysTemp1,0,BANKED
	bra	ENDIF48
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempA,OUTVALUETEMP
	movff	SYSCALCTEMPX,SERPRINTVAL
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
ENDIF48
	movlw	48
	addwf	SERPRINTVAL,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	bra	Delay_MS

;********************************************************************************

HSERPRINTCRLF
	movff	HSERPRINTCRLFCOUNT,SysRepeatTemp2
	movf	SYSREPEATTEMP2,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd2
SysRepeatLoop2
	movlw	13
	movwf	SERDATA,BANKED
	rcall	HSERSEND
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	movlw	10
	movwf	SERDATA,BANKED
	rcall	HSERSEND
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	decfsz	SysRepeatTemp2,F,BANKED
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
	return

;********************************************************************************

HSERSEND
	decf	COMPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF39
SysWaitLoop4
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop4
SysWaitLoop5
	btfss	PIR1,TX1IF,ACCESS
	bra	SysWaitLoop5
	movff	SERDATA,TXREG
	return
	movff	SERDATA,TXREG1
	return
ENDIF39
	return

;********************************************************************************

INITSYS
;osccon type is 104
;the chip mhz is 48, therefore probably an 18f usb part
	bsf	OSCCON,IRCF2,ACCESS
	bsf	OSCCON,IRCF1,ACCESS
	bsf	OSCCON,IRCF0,ACCESS
	bsf	OSCTUNE,SPLLMULT,ACCESS
	bsf	OSCCON2,PLLEN,ACCESS
SysWaitLoop3
	btfss	OSCCON2,PLLRDY,ACCESS
	bra	SysWaitLoop3
	clrf	BSR,ACCESS
	clrf	TBLPTRU,ACCESS
	bcf	ADCON2,ADFM,ACCESS
	bcf	ADCON0,ADON,ACCESS
	banksel	ANSELA
	clrf	ANSELA,BANKED
	clrf	ANSELB,BANKED
	clrf	ANSELC,BANKED
	bcf	CM2CON0,C2ON,ACCESS
	bcf	CM1CON0,C1ON,ACCESS
	clrf	PORTA,ACCESS
	clrf	PORTB,ACCESS
	clrf	PORTC,ACCESS
	clrf	PORTE,ACCESS
	banksel	0
	return

;********************************************************************************

INITUSART
	movlw	1
	movwf	COMPORT,BANKED
	movlw	103
	movwf	SPBRG,ACCESS
	clrf	SPBRGH,ACCESS
	bsf	BAUDCON,BRG16,ACCESS
	bsf	TXSTA,BRGH,ACCESS
	bcf	TXSTA,SYNC,ACCESS
	bsf	RCSTA,SPEN,ACCESS
	bsf	RCSTA,CREN,ACCESS
	bsf	TXSTA,TXEN,ACCESS
	return

;********************************************************************************

INITUSB
	movlw	2
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	movlw	127
	movwf	UIE,ACCESS
	movlw	159
	movwf	UEIE,ACCESS
	bsf	PIE3,USBIE,ACCESS
	bsf	UCFG,FSEN,ACCESS
	bcf	UCFG,UTRDIS,ACCESS
	bsf	UCFG,UPUEN,ACCESS
	movlw	8
	banksel	USB_OUT0_STAT
	movwf	USB_OUT0_STAT,BANKED
	movlw	8
	movwf	USB_IN0_STAT,BANKED
SysDoLoop_S2
	btfss	UIR,TRNIF,ACCESS
	bra	SysDoLoop_E2
	bcf	UIR,TRNIF,ACCESS
	bra	SysDoLoop_S2
SysDoLoop_E2
	clrf	UEP0,ACCESS
	movlw	64
	movwf	USB_IN0_ADDR,BANKED
	movlw	4
	movwf	USB_IN0_ADDR_H,BANKED
	movlw	192
	movwf	USB_OUT0_ADDR,BANKED
	movlw	4
	movwf	USB_OUT0_ADDR_H,BANKED
	clrf	USB_IN0_CNT,BANKED
	movlw	128
	movwf	USB_OUT0_CNT,BANKED
	movlw	8
	movwf	USB_IN0_STAT,BANKED
	movlw	136
	movwf	USB_OUT0_STAT,BANKED
	bcf	UCON,PKTDIS,ACCESS
	movlw	22
	movwf	UEP0,ACCESS
	clrf	UIR,ACCESS
	clrf	UEIR,ACCESS
	clrf	UADDR,ACCESS
	banksel	USBSTATE
	clrf	USBSTATE,BANKED
	clrf	USBCURRCONFIGURATION,BANKED
	bsf	UCON,USBEN,ACCESS
	return

;********************************************************************************

Interrupt
;Save Context
	movff	WREG,SysW
	movff	STATUS,SysSTATUS
	movff	BSR,SysBSR
;Store system variables
	movff	SysTemp1,SaveSysTemp1
	movff	SysByteTempA,SaveSysByteTempA
	movff	SysByteTempB,SaveSysByteTempB
	movff	FSR0L,SaveFSR0L
	movff	FSR0H,SaveFSR0H
	movff	SysByteTempX,SaveSysByteTempX
	movff	SysDivLoop,SaveSysDivLoop
	movff	FSR1L,SaveFSR1L
	movff	FSR1H,SaveFSR1H
	movff	SysStringLength,SaveSysStringLength
	movff	SysWaitTempMS,SaveSysWaitTempMS
	movff	SysWaitTempMS_H,SaveSysWaitTempMS_H
	movff	DelayTemp2,SaveDelayTemp2
	movff	SysTemp2,SaveSysTemp2
	movff	SysStringA,SaveSysStringA
;On Interrupt handlers
	btfss	PIE3,USBIE,ACCESS
	bra	NotUSBIF
	btfss	PIR3,USBIF,ACCESS
	bra	NotUSBIF
	rcall	USBINTERRUPTHANDLER
	bcf	PIR3,USBIF,ACCESS
	bra	INTERRUPTDONE
NotUSBIF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	movff	SaveSysTemp1,SysTemp1
	movff	SaveSysByteTempA,SysByteTempA
	movff	SaveSysByteTempB,SysByteTempB
	movff	SaveFSR0L,FSR0L
	movff	SaveFSR0H,FSR0H
	movff	SaveSysByteTempX,SysByteTempX
	movff	SaveSysDivLoop,SysDivLoop
	movff	SaveFSR1L,FSR1L
	movff	SaveFSR1H,FSR1H
	movff	SaveSysStringLength,SysStringLength
	movff	SaveSysWaitTempMS,SysWaitTempMS
	movff	SaveSysWaitTempMS_H,SysWaitTempMS_H
	movff	SaveDelayTemp2,DelayTemp2
	movff	SaveSysTemp2,SysTemp2
	movff	SaveSysStringA,SysStringA
	movff	SysW,WREG
	movff	SysSTATUS,STATUS
	movff	SysBSR,BSR
	retfie	0

;********************************************************************************

FN_PEEK
	movff	MEMADR_H,FSR0H
	movff	MEMADR,FSR0L
	movff	INDF0,PEEK
	return

;********************************************************************************

POKE
	movff	MEMDATA,INDF0
	return

;********************************************************************************

;Overloaded signature: BYTE:
FN_READAD1018
	bsf	ADCON2,ADFM,ACCESS
SysSelect6Case1
	movf	ADREADPORT,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case2
	banksel	ANSELA
	bsf	ANSELA,0,BANKED
	bra	SysSelectEnd6
SysSelect6Case2
	decf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case3
	banksel	ANSELA
	bsf	ANSELA,1,BANKED
	bra	SysSelectEnd6
SysSelect6Case3
	movlw	2
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case4
	banksel	ANSELA
	bsf	ANSELA,2,BANKED
	bra	SysSelectEnd6
SysSelect6Case4
	movlw	3
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case5
	banksel	ANSELA
	bsf	ANSELA,3,BANKED
	bra	SysSelectEnd6
SysSelect6Case5
	movlw	4
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case6
	banksel	ANSELA
	bsf	ANSELA,5,BANKED
	bra	SysSelectEnd6
SysSelect6Case6
	movlw	12
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case7
	banksel	ANSELB
	bsf	ANSELB,0,BANKED
	bra	SysSelectEnd6
SysSelect6Case7
	movlw	10
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case8
	banksel	ANSELB
	bsf	ANSELB,1,BANKED
	bra	SysSelectEnd6
SysSelect6Case8
	movlw	8
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case9
	banksel	ANSELB
	bsf	ANSELB,2,BANKED
	bra	SysSelectEnd6
SysSelect6Case9
	movlw	9
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case10
	banksel	ANSELB
	bsf	ANSELB,3,BANKED
	bra	SysSelectEnd6
SysSelect6Case10
	movlw	11
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case11
	banksel	ANSELB
	bsf	ANSELB,4,BANKED
	bra	SysSelectEnd6
SysSelect6Case11
	movlw	13
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case12
	banksel	ANSELB
	bsf	ANSELB,5,BANKED
	bra	SysSelectEnd6
SysSelect6Case12
	movlw	14
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case13
	banksel	ANSELC
	bsf	ANSELC,2,BANKED
	bra	SysSelectEnd6
SysSelect6Case13
	movlw	15
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case14
	banksel	ANSELC
	bsf	ANSELC,3,BANKED
	bra	SysSelectEnd6
SysSelect6Case14
	movlw	16
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case15
	banksel	ANSELC
	bsf	ANSELC,4,BANKED
	bra	SysSelectEnd6
SysSelect6Case15
	movlw	17
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case16
	banksel	ANSELC
	bsf	ANSELC,5,BANKED
	bra	SysSelectEnd6
SysSelect6Case16
	movlw	18
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case17
	banksel	ANSELC
	bsf	ANSELC,6,BANKED
	bra	SysSelectEnd6
SysSelect6Case17
	movlw	19
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd6
	banksel	ANSELC
	bsf	ANSELC,7,BANKED
SysSelectEnd6
	bcf	ADCON2,ADCS2,ACCESS
	bsf	ADCON2,ADCS1,ACCESS
	bcf	ADCON2,ADCS0,ACCESS
	bcf	ADCON0,CHS0,ACCESS
	bcf	ADCON0,CHS1,ACCESS
	bcf	ADCON0,CHS2,ACCESS
	bcf	ADCON0,CHS3,ACCESS
	bcf	ADCON0,CHS4,ACCESS
	banksel	ADREADPORT
	btfsc	ADREADPORT,0,BANKED
	bsf	ADCON0,CHS0,ACCESS
ENDIF34
	btfsc	ADREADPORT,1,BANKED
	bsf	ADCON0,CHS1,ACCESS
ENDIF35
	btfsc	ADREADPORT,2,BANKED
	bsf	ADCON0,CHS2,ACCESS
ENDIF36
	btfsc	ADREADPORT,3,BANKED
	bsf	ADCON0,CHS3,ACCESS
ENDIF37
	btfsc	ADREADPORT,4,BANKED
	bsf	ADCON0,CHS4,ACCESS
ENDIF38
	bsf	ADCON0,ADON,ACCESS
	movlw	2
	movwf	SysWaitTemp10US,ACCESS
	rcall	Delay_10US
	bsf	ADCON0,GO_NOT_DONE,ACCESS
	nop
SysWaitLoop2
	btfsc	ADCON0,GO_NOT_DONE,ACCESS
	bra	SysWaitLoop2
	bcf	ADCON0,ADON,ACCESS
	banksel	ANSELA
	clrf	ANSELA,BANKED
	clrf	ANSELB,BANKED
	clrf	ANSELC,BANKED
	movff	ADRESL,READAD10
	banksel	READAD10_H
	clrf	READAD10_H,BANKED
	movff	ADRESH,READAD10_H
	bcf	ADCON2,ADFM,ACCESS
	return

;********************************************************************************

SETUPHANDLER
SysSelect7Case1
	movlw	131
	banksel	SYSUSBTEMPBUFFER_1
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case2
	bsf	LATB,5,ACCESS
	banksel	0
	rcall	USBSENDDATA1ACK
	bra	SysSelectEnd7
SysSelect7Case2
	movlw	132
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case3
	bcf	LATB,5,ACCESS
	banksel	0
	rcall	USBSENDDATA1ACK
	bra	SysSelectEnd7
SysSelect7Case3
	movlw	133
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case4
	movlw	8
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT,BANKED
	movff	USB_IN0_ADDR,MEMADR
	movff	USB_IN0_ADDR_H,MEMADR_H
	movff	SENSORVALUE1,MEMDATA
	banksel	0
	rcall	POKE
	movlw	1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	SENSORVALUE1_H,MEMDATA
	banksel	0
	rcall	POKE
	movlw	2
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	SENSORVALUE2,MEMDATA
	banksel	0
	rcall	POKE
	movlw	3
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	SENSORVALUE2_H,MEMDATA
	banksel	0
	rcall	POKE
	movlw	4
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	SENSORVALUE3,MEMDATA
	banksel	0
	rcall	POKE
	movlw	5
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	SENSORVALUE3_H,MEMDATA
	banksel	0
	rcall	POKE
	movlw	6
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	SENSORVALUE4,MEMDATA
	banksel	0
	rcall	POKE
	movlw	7
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	SENSORVALUE4_H,MEMDATA
	banksel	0
	rcall	POKE
	banksel	USB_IN0_STAT
	btfss	USB_IN0_STAT,6,BANKED
	bra	ELSE43_1
	movlw	136
	movwf	USB_IN0_STAT,BANKED
	bra	ENDIF43
ELSE43_1
	movlw	200
	movwf	USB_IN0_STAT,BANKED
ENDIF43
	bra	SysSelectEnd7
SysSelect7Case4
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT266
	movff	SYSUSBTEMPBUFFER_1,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT267
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
SysSelectEnd7
	banksel	0
	return

;********************************************************************************

SYSCOMPLESSTHAN
	setf	SYSBYTETEMPX,ACCESS
	movf	SYSBYTETEMPB, W,ACCESS
	cpfslt	SYSBYTETEMPA,ACCESS
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

SYSCOPYSTRING
	movff	INDF0, SYSCALCTEMPA
	movff	SYSCALCTEMPA, INDF1
	bra	SYSCOPYSTRINGCHECK
SYSCOPYSTRINGPART
	movf	INDF0, W,ACCESS
	movwf	SYSCALCTEMPA,ACCESS
	addwf	SYSSTRINGLENGTH, F,ACCESS
SYSCOPYSTRINGCHECK
	movf	SYSCALCTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	return
SYSSTRINGCOPY
	movff	PREINC0, PREINC1
	decfsz	SYSCALCTEMPA, F,ACCESS
	bra	SYSSTRINGCOPY
	return

;********************************************************************************

SYSDIVSUB
	movf	SYSBYTETEMPB, F,ACCESS
	btfsc	STATUS, Z,ACCESS
	return
	clrf	SYSBYTETEMPX,ACCESS
	movlw	8
	movwf	SYSDIVLOOP,ACCESS
SYSDIV8START
	bcf	STATUS, C,ACCESS
	rlcf	SYSBYTETEMPA, F,ACCESS
	rlcf	SYSBYTETEMPX, F,ACCESS
	movf	SYSBYTETEMPB, W,ACCESS
	subwf	SYSBYTETEMPX, F,ACCESS
	bsf	SYSBYTETEMPA, 0,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	DIV8NOTNEG
	bcf	SYSBYTETEMPA, 0,ACCESS
	movf	SYSBYTETEMPB, W,ACCESS
	addwf	SYSBYTETEMPX, F,ACCESS
DIV8NOTNEG
	decfsz	SYSDIVLOOP, F,ACCESS
	bra	SYSDIV8START
	return

;********************************************************************************

SYSREADSTRING
	tblrd*+
	movff	TABLAT,SYSCALCTEMPA
	movff	TABLAT,INDF1
	bra	SYSSTRINGREADCHECK
SYSREADSTRINGPART
	tblrd*+
	movf	TABLAT, W,ACCESS
	movwf	SYSCALCTEMPA,ACCESS
	addwf	SYSSTRINGLENGTH,F,ACCESS
SYSSTRINGREADCHECK
	movf	SYSCALCTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	return
SYSSTRINGREAD
	tblrd*+
	movff	TABLAT,PREINC1
	decfsz	SYSCALCTEMPA, F,ACCESS
	bra	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables

StringTable1
	db	17,71,67,66,65,83,73,67,32,85,83,66,32,84,101,115,116,58


StringTable3
	db	5,66,117,105,108,100


StringTable4
	db	1,64


StringTable5
	db	9,85,83,66,32,67,71,66,32,32


StringTable6
	db	1,69


StringTable7
	db	4,82,101,113,32


StringTable8
	db	5,68,101,115,99,32


StringTable9
	db	9,71,114,101,97,116,32,67,111,119


StringTable13
	db	0


StringTable20
	db	2,53,57


StringTable21
	db	19,48,53,45,50,56,45,50,48,49,56,32,49,54,58,51,54,58,52,52


;********************************************************************************

USBCONFIGDESCRIPTOR
	movlw	18
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableUSBCONFIGDESCRIPTOR
	movwf	TBLPTRL,ACCESS
	movlw	high TableUSBCONFIGDESCRIPTOR
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableUSBCONFIGDESCRIPTOR
	db	18,9,2,18,0,1,1,0,128,25,9,4,0,0,0,255,0,255

;********************************************************************************

USBDEVICEDESCRIPTOR
	movlw	19
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableUSBDEVICEDESCRIPTOR
	movwf	TBLPTRL,ACCESS
	movlw	high TableUSBDEVICEDESCRIPTOR
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableUSBDEVICEDESCRIPTOR
	db	18,18,1,0,2,0,0,0,64,85,240,0,16,1,1,1,2,0,1

;********************************************************************************

USBDEVICEQUALDESCRIPTOR
	movlw	10
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableUSBDEVICEQUALDESCRIPTOR
	movwf	TBLPTRL,ACCESS
	movlw	high TableUSBDEVICEQUALDESCRIPTOR
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableUSBDEVICEQUALDESCRIPTOR
	db	10,10,6,0,2,0,0,0,64,1

;********************************************************************************

USBINTERRUPTHANDLER
	btfss	UIR,URSTIF,ACCESS
	bra	ENDIF5
	movlw	8
	banksel	USB_OUT0_STAT
	movwf	USB_OUT0_STAT,BANKED
	movlw	8
	movwf	USB_IN0_STAT,BANKED
SysDoLoop_S3
	btfss	UIR,TRNIF,ACCESS
	bra	SysDoLoop_E3
	bcf	UIR,TRNIF,ACCESS
	bra	SysDoLoop_S3
SysDoLoop_E3
	clrf	UEP0,ACCESS
	movlw	64
	movwf	USB_IN0_ADDR,BANKED
	movlw	4
	movwf	USB_IN0_ADDR_H,BANKED
	movlw	192
	movwf	USB_OUT0_ADDR,BANKED
	movlw	4
	movwf	USB_OUT0_ADDR_H,BANKED
	clrf	USB_IN0_CNT,BANKED
	movlw	128
	movwf	USB_OUT0_CNT,BANKED
	movlw	8
	movwf	USB_IN0_STAT,BANKED
	movlw	136
	movwf	USB_OUT0_STAT,BANKED
	bcf	UCON,PKTDIS,ACCESS
	movlw	22
	movwf	UEP0,ACCESS
	clrf	UADDR,ACCESS
	clrf	UEIR,ACCESS
	clrf	UIR,ACCESS
	bcf	UCON,SUSPND,ACCESS
SysWaitLoop1
	btfsc	UCON,SE0,ACCESS
	bra	SysWaitLoop1
	banksel	USBLASTCONTROL
	setf	USBLASTCONTROL,BANKED
	movlw	1
	movwf	USBSTATE,BANKED
	clrf	USBCURRCONFIGURATION,BANKED
ENDIF5
	btfss	UIR,UERRIF,ACCESS
	bra	ENDIF6
	rcall	ERRORHANDLER
	clrf	UEIR,ACCESS
	bcf	UIR,UERRIF,ACCESS
ENDIF6
	btfss	UIR,ACTVIF,ACCESS
	bra	ENDIF7
	bcf	UCON,SUSPND,ACCESS
	bcf	UIR,ACTVIF,ACCESS
ENDIF7
	btfss	UIR,TRNIF,ACCESS
	bra	ENDIF8
	movlw	120
	andwf	USTAT,W,ACCESS
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempA,USBCURRENDPOINT
	btfss	USTAT,DIR,ACCESS
	bra	ELSE12_1
	movff	USB_IN0_STAT,USBBUFFERSTAT
	bra	ENDIF12
ELSE12_1
	movff	USB_OUT0_STAT,USBBUFFERSTAT
	banksel	USB_OUT0_STAT
	bcf	USB_OUT0_STAT,7,BANKED
ENDIF12
	movlw	60
	banksel	USBBUFFERSTAT
	andwf	USBBUFFERSTAT,W,BANKED
	movwf	USBPID,BANKED
SysSelect1Case1
	movlw	4
	subwf	USBPID,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
	movlw	128
	banksel	USB_OUT0_CNT
	movwf	USB_OUT0_CNT,BANKED
	bsf	USB_OUT0_STAT,7,BANKED
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	36
	subwf	USBPID,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
SysSelect2Case1
	movlw	5
	subwf	USBLASTCONTROL,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
	movff	USBNEWADDRESS,UADDR
	movlw	2
	movwf	USBSTATE,BANKED
	setf	USBLASTCONTROL,BANKED
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	6
	subwf	USBLASTCONTROL,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case3
	rcall	USBSENDDESCRIPTOR
	bra	SysSelectEnd2
SysSelect2Case3
	movlw	128
	banksel	USB_OUT0_CNT
	movwf	USB_OUT0_CNT,BANKED
	movlw	136
	movwf	USB_OUT0_STAT,BANKED
SysSelectEnd2
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	52
	subwf	USBPID,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
	setf	USBCURRBYTE,BANKED
SysForLoop1
	incf	USBCURRBYTE,F,BANKED
	movf	USBCURRBYTE,W,BANKED
	banksel	USB_OUT0_ADDR
	addwf	USB_OUT0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_OUT0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	banksel	0
	rcall	FN_PEEK
	lfsr	0,USBTEMPBUFFER
	movf	USBCURRBYTE,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	PEEK,INDF0
	movlw	7
	subwf	USBCURRBYTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
ENDIF13
SysForLoopEnd1
	movlw	8
	banksel	USB_IN0_STAT
	movwf	USB_IN0_STAT,BANKED
	movlw	128
	movwf	USB_OUT0_CNT,BANKED
	movlw	136
	movwf	USB_OUT0_STAT,BANKED
	banksel	0
	rcall	USBPROCESSSETUP
	bra	SysSelectEnd1
SysSelect1Case4
SysSelectEnd1
	banksel	USBHASDATA
	setf	USBHASDATA,BANKED
	bcf	UIR,TRNIF,ACCESS
ENDIF8
	btfsc	UIR,IDLEIF,ACCESS
	bcf	UIR,IDLEIF,ACCESS
ENDIF9
	btfsc	UIR,STALLIF,ACCESS
	bcf	UIR,STALLIF,ACCESS
ENDIF10
	btfsc	UIR,SOFIF,ACCESS
	bcf	UIR,SOFIF,ACCESS
ENDIF11
	return

;********************************************************************************

USBPROCESSSETUP
	movlw	127
	banksel	SYSUSBTEMPBUFFER_0
	andwf	SYSUSBTEMPBUFFER_0,W,BANKED
	banksel	USBBMREQUESTTYPE
	movwf	USBBMREQUESTTYPE,BANKED
	bcf	UCON,PKTDIS,ACCESS
	movf	USBBMREQUESTTYPE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE14_1
	setf	USBLASTCONTROL,BANKED
SysSelect3Case1
	movlw	5
	banksel	SYSUSBTEMPBUFFER_1
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
	movlw	5
	banksel	USBLASTCONTROL
	movwf	USBLASTCONTROL,BANKED
	movff	SYSUSBTEMPBUFFER_2,USBNEWADDRESS
	rcall	USBSENDDATA1ACK
	bra	SysSelectEnd3
SysSelect3Case2
	movlw	6
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case3
	movlw	6
	banksel	USBLASTCONTROL
	movwf	USBLASTCONTROL,BANKED
	movff	SYSUSBTEMPBUFFER_3,USBDESCTYPE
	movff	SYSUSBTEMPBUFFER_2,USBDESCINDEX
	movff	SYSUSBTEMPBUFFER_6,USBDESCSIZEIN
	clrf	USBDESCSTART,BANKED
	rcall	USBSENDDESCRIPTOR
	bra	SysSelectEnd3
SysSelect3Case3
	movlw	9
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case4
	movff	SYSUSBTEMPBUFFER_2,USBCURRCONFIGURATION
	banksel	USBCURRCONFIGURATION
	movf	USBCURRCONFIGURATION,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE15_1
	movlw	2
	movwf	USBSTATE,BANKED
	bra	ENDIF15
ELSE15_1
	movlw	3
	movwf	USBSTATE,BANKED
ENDIF15
	rcall	USBSENDDATA1ACK
	bra	SysSelectEnd3
SysSelect3Case4
	banksel	0
	rcall	SETUPHANDLER
SysSelectEnd3
	bra	ENDIF14
ELSE14_1
	rcall	SETUPHANDLER
ENDIF14
	return

;********************************************************************************

USBSENDDATA1ACK
	banksel	USB_IN0_CNT
	clrf	USB_IN0_CNT,BANKED
	movlw	200
	movwf	USB_IN0_STAT,BANKED
	banksel	0
	return

;********************************************************************************

USBSENDDESCRIPTOR
	banksel	USB_IN0_STAT
	bcf	USB_IN0_STAT,7,BANKED
SysSelect4Case1
	banksel	USBDESCTYPE
	decf	USBDESCTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case2
	movlw	18
	movwf	USBSIZE,BANKED
	subwf	USBDESCSIZEIN,W,BANKED
	btfss	STATUS, C,ACCESS
	movff	USBDESCSIZEIN,USBSIZE
ENDIF16
	movf	USBSIZE,W,BANKED
	subwf	USBDESCSTART,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ELSE17_1
	clrf	USBSIZE,BANKED
	setf	USBLASTCONTROL,BANKED
	bra	ENDIF17
ELSE17_1
	movf	USBDESCSTART,W,BANKED
	subwf	USBSIZE,F,BANKED
ENDIF17
	clrf	USBCURRBYTE,BANKED
	movlw	1
	subwf	USBSIZE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd2
ENDIF18
SysForLoop2
	incf	USBCURRBYTE,F,BANKED
	movf	USBDESCSTART,W,BANKED
	addwf	USBCURRBYTE,W,BANKED
	movwf	SYSSTRINGA,ACCESS
	rcall	USBDEVICEDESCRIPTOR
	movwf	USBTEMPBYTE,BANKED
	decf	USBCURRBYTE,W,BANKED
	movwf	SysTemp1,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	USBTEMPBYTE,MEMDATA
	banksel	0
	rcall	POKE
	movf	USBSIZE,W,BANKED
	subwf	USBCURRBYTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
ENDIF19
SysForLoopEnd2
	movff	USBSIZE,USB_IN0_CNT
	movf	USBSIZE,W,BANKED
	addwf	USBDESCSTART,F,BANKED
	bra	SysSelectEnd4
SysSelect4Case2
	movlw	2
	subwf	USBDESCTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case3
	movlw	18
	movwf	USBSIZE,BANKED
	subwf	USBDESCSIZEIN,W,BANKED
	btfss	STATUS, C,ACCESS
	movff	USBDESCSIZEIN,USBSIZE
ENDIF20
	movf	USBSIZE,W,BANKED
	subwf	USBDESCSTART,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ELSE21_1
	clrf	USBSIZE,BANKED
	setf	USBLASTCONTROL,BANKED
	bra	ENDIF21
ELSE21_1
	movf	USBDESCSTART,W,BANKED
	subwf	USBSIZE,F,BANKED
ENDIF21
	clrf	USBCURRBYTE,BANKED
	movlw	1
	subwf	USBSIZE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd3
ENDIF22
SysForLoop3
	incf	USBCURRBYTE,F,BANKED
	movf	USBDESCSTART,W,BANKED
	addwf	USBCURRBYTE,W,BANKED
	movwf	SYSSTRINGA,ACCESS
	rcall	USBCONFIGDESCRIPTOR
	movwf	USBTEMPBYTE,BANKED
	decf	USBCURRBYTE,W,BANKED
	movwf	SysTemp1,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	USBTEMPBYTE,MEMDATA
	banksel	0
	rcall	POKE
	movf	USBSIZE,W,BANKED
	subwf	USBCURRBYTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
ENDIF23
SysForLoopEnd3
	movff	USBSIZE,USB_IN0_CNT
	movf	USBSIZE,W,BANKED
	addwf	USBDESCSTART,F,BANKED
	bra	SysSelectEnd4
SysSelect4Case3
	movlw	6
	subwf	USBDESCTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case4
	movlw	10
	movwf	USBSIZE,BANKED
	subwf	USBDESCSIZEIN,W,BANKED
	btfss	STATUS, C,ACCESS
	movff	USBDESCSIZEIN,USBSIZE
ENDIF24
	movf	USBSIZE,W,BANKED
	subwf	USBDESCSTART,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ELSE25_1
	clrf	USBSIZE,BANKED
	setf	USBLASTCONTROL,BANKED
	bra	ENDIF25
ELSE25_1
	movf	USBDESCSTART,W,BANKED
	subwf	USBSIZE,F,BANKED
ENDIF25
	clrf	USBCURRBYTE,BANKED
	movlw	1
	subwf	USBSIZE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
ENDIF26
SysForLoop4
	incf	USBCURRBYTE,F,BANKED
	movf	USBDESCSTART,W,BANKED
	addwf	USBCURRBYTE,W,BANKED
	movwf	SYSSTRINGA,ACCESS
	rcall	USBDEVICEQUALDESCRIPTOR
	movwf	USBTEMPBYTE,BANKED
	decf	USBCURRBYTE,W,BANKED
	movwf	SysTemp1,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	USBTEMPBYTE,MEMDATA
	banksel	0
	rcall	POKE
	movf	USBSIZE,W,BANKED
	subwf	USBCURRBYTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
ENDIF27
SysForLoopEnd4
	movff	USBSIZE,USB_IN0_CNT
	movf	USBSIZE,W,BANKED
	addwf	USBDESCSTART,F,BANKED
	bra	SysSelectEnd4
SysSelect4Case4
	movlw	3
	subwf	USBDESCTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case5
	movf	USBDESCINDEX,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE28_1
	setf	USBLASTCONTROL,BANKED
	movff	USB_IN0_ADDR,MEMADR
	movff	USB_IN0_ADDR_H,MEMADR_H
	movlw	4
	movwf	MEMDATA,BANKED
	rcall	POKE
	movlw	1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movlw	3
	banksel	MEMDATA
	movwf	MEMDATA,BANKED
	rcall	POKE
	movlw	2
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movlw	9
	banksel	MEMDATA
	movwf	MEMDATA,BANKED
	rcall	POKE
	movlw	3
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movlw	4
	banksel	MEMDATA
	movwf	MEMDATA,BANKED
	rcall	POKE
	movlw	4
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT,BANKED
	bra	ENDIF28
ELSE28_1
SysSelect5Case1
	decf	USBDESCINDEX,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case2
	lfsr	1,USBTEMPSTRING
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	bra	SysSelectEnd5
SysSelect5Case2
	movlw	2
	subwf	USBDESCINDEX,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case3
	lfsr	1,USBTEMPSTRING
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	bra	SysSelectEnd5
SysSelect5Case3
	lfsr	1,USBTEMPSTRING
	movlw	low StringTable13
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable13
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
SysSelectEnd5
	banksel	SYSUSBTEMPSTRING_0
	movf	SYSUSBTEMPSTRING_0,W,BANKED
	mullw	2
	movff	PRODL,SysTemp1
	movlw	2
	banksel	SYSTEMP1
	addwf	SysTemp1,W,BANKED
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT,BANKED
	banksel	USBDESCSTART
	movf	USBDESCSTART,W,BANKED
	banksel	USB_IN0_CNT
	subwf	USB_IN0_CNT,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ELSE30_1
	clrf	USB_IN0_CNT,BANKED
	banksel	USBLASTCONTROL
	setf	USBLASTCONTROL,BANKED
	bra	ENDIF30
ELSE30_1
	banksel	USBDESCSTART
	movf	USBDESCSTART,W,BANKED
	banksel	USB_IN0_CNT
	subwf	USB_IN0_CNT,F,BANKED
ENDIF30
	movff	USB_IN0_ADDR,MEMADR
	movff	USB_IN0_ADDR_H,MEMADR_H
	movff	USB_IN0_CNT,MEMDATA
	banksel	0
	rcall	POKE
	movlw	1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movlw	3
	banksel	MEMDATA
	movwf	MEMDATA,BANKED
	rcall	POKE
	clrf	USBCURRBYTE,BANKED
	movlw	1
	banksel	SYSUSBTEMPSTRING_0
	subwf	SYSUSBTEMPSTRING_0,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd5
ENDIF31
SysForLoop5
	banksel	USBCURRBYTE
	incf	USBCURRBYTE,F,BANKED
	lfsr	0,USBTEMPSTRING
	movf	USBCURRBYTE,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,USBTEMPBYTE
	movf	USBCURRBYTE,W,BANKED
	mullw	2
	movff	PRODL,SysTemp1
	movf	SysTemp1,W,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	USBTEMPBYTE,MEMDATA
	banksel	0
	rcall	POKE
	movf	USBCURRBYTE,W,BANKED
	mullw	2
	movff	PRODL,SysTemp1
	incf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	banksel	MEMDATA
	clrf	MEMDATA,BANKED
	rcall	POKE
	banksel	SYSUSBTEMPSTRING_0
	movf	SYSUSBTEMPSTRING_0,W,BANKED
	banksel	USBCURRBYTE
	subwf	USBCURRBYTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
ENDIF32
SysForLoopEnd5
	banksel	USB_IN0_CNT
	movf	USB_IN0_CNT,W,BANKED
	banksel	USBDESCSIZEIN
	subwf	USBDESCSIZEIN,W,BANKED
	btfss	STATUS, C,ACCESS
	movff	USBDESCSIZEIN,USB_IN0_CNT
ENDIF33
	banksel	USB_IN0_CNT
	movf	USB_IN0_CNT,W,BANKED
	banksel	USBDESCSTART
	addwf	USBDESCSTART,F,BANKED
ENDIF28
	bra	SysSelectEnd4
SysSelect4Case5
	call	DESCRIPTORHANDLER
	return
SysSelectEnd4
	banksel	USB_IN0_STAT
	btfss	USB_IN0_STAT,6,BANKED
	bra	ELSE29_1
	movlw	136
	movwf	USB_IN0_STAT,BANKED
	bra	ENDIF29
ELSE29_1
	movlw	200
	movwf	USB_IN0_STAT,BANKED
ENDIF29
	banksel	0
	return

;********************************************************************************


 END
