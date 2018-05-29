;Program compiled by Great Cow BASIC (0.98.<<>> 2018-05-28)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1459, r=DEC
#include <P16F1459.inc>
 __CONFIG _CONFIG1, _MCLRE_OFF & _WDTE_OFF & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_DISABLED & _CPUDIV_NOCLKDIV

;********************************************************************************

;Set aside memory locations for variables
ADREADPORT	EQU	833
COMPORT	EQU	834
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
HEX	EQU	9138
HSERPRINTCRLFCOUNT	EQU	835
MEMDATA	EQU	836
OUTVALUETEMP	EQU	837
PEEK	EQU	838
PRINTLEN	EQU	839
READAD10	EQU	840
READAD10_H	EQU	841
SAVEDELAYTEMP2	EQU	842
SAVEFSR0H	EQU	843
SAVEFSR0L	EQU	844
SAVEFSR1H	EQU	845
SAVEPCLATH	EQU	846
SAVESYSBYTETEMPA	EQU	847
SAVESYSBYTETEMPB	EQU	848
SAVESYSBYTETEMPX	EQU	849
SAVESYSDIVLOOP	EQU	850
SAVESYSSTRINGA	EQU	851
SAVESYSSTRINGA_H	EQU	852
SAVESYSSTRINGLENGTH	EQU	853
SAVESYSTEMP1	EQU	854
SAVESYSTEMP2	EQU	855
SAVESYSWAITTEMPMS	EQU	856
SAVESYSWAITTEMPMS_H	EQU	857
SENSORVALUE1	EQU	858
SENSORVALUE1_H	EQU	859
SENSORVALUE2	EQU	860
SENSORVALUE2_H	EQU	861
SENSORVALUE3	EQU	862
SENSORVALUE3_H	EQU	863
SENSORVALUE4	EQU	864
SENSORVALUE4_H	EQU	865
SERDATA	EQU	866
SERPRINTVAL	EQU	867
STRINGPOINTER	EQU	868
SYSBSR	EQU	869
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCALCTEMPX	EQU	112
SYSDIVLOOP	EQU	116
SYSPRINTDATAHANDLER	EQU	870
SYSPRINTDATAHANDLER_H	EQU	871
SYSPRINTTEMP	EQU	872
SYSREPEATTEMP1	EQU	873
SYSREPEATTEMP2	EQU	874
SYSSTATUS	EQU	127
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SYSSTRINGTEMP	EQU	875
SYSTEMP1	EQU	876
SYSTEMP1_H	EQU	877
SYSTEMP2	EQU	878
SYSVALTEMP	EQU	879
SYSW	EQU	126
SYSWAITTEMP10US	EQU	117
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
USBBMREQUESTTYPE	EQU	928
USBBUFFERSTAT	EQU	929
USBCURRBYTE	EQU	930
USBCURRCONFIGURATION	EQU	931
USBCURRENDPOINT	EQU	932
USBDESCINDEX	EQU	933
USBDESCSIZEIN	EQU	934
USBDESCSTART	EQU	935
USBDESCTYPE	EQU	936
USBHASDATA	EQU	937
USBLASTCONTROL	EQU	938
USBNEWADDRESS	EQU	939
USBPID	EQU	940
USBRAM	EQU	8192
USBSIZE	EQU	941
USBSTATE	EQU	942
USBTEMPBUFFER	EQU	9142
USBTEMPBYTE	EQU	943
USBTEMPSTRING	EQU	9159

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
MEMADR	EQU	4
MEMADR_H	EQU	5
SYSHEX_0	EQU	1506
SYSHEX_1	EQU	1507
SYSHEX_2	EQU	1508
SYSREADAD10WORD	EQU	840
SYSREADAD10WORD_H	EQU	841
SYSUSBTEMPBUFFER_0	EQU	1510
SYSUSBTEMPBUFFER_1	EQU	1511
SYSUSBTEMPBUFFER_2	EQU	1512
SYSUSBTEMPBUFFER_3	EQU	1513
SYSUSBTEMPBUFFER_6	EQU	1516
SYSUSBTEMPSTRING_0	EQU	1575
USB_IN0_ADDR	EQU	38
USB_IN0_ADDR_H	EQU	39
USB_IN0_CNT	EQU	37
USB_IN0_STAT	EQU	36
USB_OUT0_ADDR	EQU	34
USB_OUT0_ADDR_H	EQU	35
USB_OUT0_CNT	EQU	33
USB_OUT0_STAT	EQU	32

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
Interrupt

;********************************************************************************

;Save Context
	movwf	SysW
	swapf	STATUS,W
	movwf	SysSTATUS
	movf	BSR,W
	banksel	STATUS
	banksel	SYSBSR
	movwf	SysBSR
;Store system variables
	movf	SysTemp1,W
	movwf	SaveSysTemp1
	movf	SysByteTempA,W
	movwf	SaveSysByteTempA
	movf	SysByteTempB,W
	movwf	SaveSysByteTempB
	movf	FSR0L,W
	movwf	SaveFSR0L
	movf	FSR0H,W
	movwf	SaveFSR0H
	movf	SysByteTempX,W
	movwf	SaveSysByteTempX
	movf	SysDivLoop,W
	movwf	SaveSysDivLoop
	movf	SysWaitTempMS,W
	movwf	SaveSysWaitTempMS
	movf	SysWaitTempMS_H,W
	movwf	SaveSysWaitTempMS_H
	movf	DelayTemp2,W
	movwf	SaveDelayTemp2
	movf	SysTemp2,W
	movwf	SaveSysTemp2
	movf	SysStringA,W
	movwf	SaveSysStringA
	movf	FSR1H,W
	movwf	SaveFSR1H
	movf	SysStringA_H,W
	movwf	SaveSysStringA_H
	movf	SysStringLength,W
	movwf	SaveSysStringLength
	movf	PCLATH,W
	movwf	SavePCLATH
	clrf	PCLATH
;On Interrupt handlers
	banksel	PIE2
	btfss	PIE2,USBIE
	goto	NotUSBIF
	banksel	PIR2
	btfss	PIR2,USBIF
	goto	NotUSBIF
	call	USBINTERRUPTHANDLER
	bcf	PIR2,USBIF
	goto	INTERRUPTDONE
NotUSBIF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	banksel	SAVESYSTEMP1
	movf	SaveSysTemp1,W
	movwf	SysTemp1
	movf	SaveSysByteTempA,W
	movwf	SysByteTempA
	movf	SaveSysByteTempB,W
	movwf	SysByteTempB
	movf	SaveFSR0L,W
	movwf	FSR0L
	movf	SaveFSR0H,W
	movwf	FSR0H
	movf	SaveSysByteTempX,W
	movwf	SysByteTempX
	movf	SaveSysDivLoop,W
	movwf	SysDivLoop
	movf	SaveSysWaitTempMS,W
	movwf	SysWaitTempMS
	movf	SaveSysWaitTempMS_H,W
	movwf	SysWaitTempMS_H
	movf	SaveDelayTemp2,W
	movwf	DelayTemp2
	movf	SaveSysTemp2,W
	movwf	SysTemp2
	movf	SaveSysStringA,W
	movwf	SysStringA
	movf	SaveFSR1H,W
	movwf	FSR1H
	movf	SaveSysStringA_H,W
	movwf	SysStringA_H
	movf	SaveSysStringLength,W
	movwf	SysStringLength
	movf	SavePCLATH,W
	movwf	PCLATH
	movf	SysBSR,W
	movwf	BSR
	swapf	SysSTATUS,W
	movwf	STATUS
	swapf	SysW,F
	swapf	SysW,W
	retfie
	banksel	STATUS

;********************************************************************************

;Start of program memory page 0
	ORG	95
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	INITUSART
	call	INITUSB
;Enable interrupts
	bsf	INTCON,GIE
	bsf	INTCON,PEIE

;Start of the main program
	banksel	TRISB
	bcf	TRISB,5
	movlw	20
	banksel	SYSREPEATTEMP1
	movwf	SysRepeatTemp1
SysRepeatLoop1
	clrf	SysTemp1
	banksel	PORTB
	btfss	PORTB,5
	goto	ENDIF1
	banksel	SYSTEMP1
	incf	SysTemp1,F
ENDIF1
	banksel	SYSTEMP1
	comf	SysTemp1,F
	banksel	LATB
	bcf	LATB,5
	banksel	SYSTEMP1
	btfss	SysTemp1,0
	goto	ENDIF2
	banksel	LATB
	bsf	LATB,5
ENDIF2
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	call	Delay_MS
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
	banksel	TRISC
	bcf	TRISC,6
	bcf	TRISB,0
	banksel	LATB
	bsf	LATB,0
	movlw	low StringTable2
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable2) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	banksel	STATUS
	call	HSERPRINT264
	movlw	1
	banksel	HSERPRINTCRLFCOUNT
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	banksel	STATUS
	call	HSERPRINTCRLF
	banksel	SYSTEMP1
	clrf	SysTemp1
	banksel	PORTB
	btfss	PORTB,0
	goto	ENDIF3
	banksel	SYSTEMP1
	incf	SysTemp1,F
ENDIF3
	banksel	SYSTEMP1
	comf	SysTemp1,F
	banksel	LATB
	bcf	LATB,0
	banksel	SYSTEMP1
	btfss	SysTemp1,0
	goto	ENDIF4
	banksel	LATB
	bsf	LATB,0
ENDIF4
	banksel	STATUS
	call	INITUSB
SysDoLoop_S1
	banksel	ADREADPORT
	clrf	ADREADPORT
	banksel	STATUS
	call	FN_READAD1016
	banksel	SYSREADAD10WORD
	movf	SYSREADAD10WORD,W
	movwf	SENSORVALUE1
	movf	SYSREADAD10WORD_H,W
	movwf	SENSORVALUE1_H
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	call	Delay_MS
	movlw	1
	banksel	ADREADPORT
	movwf	ADREADPORT
	banksel	STATUS
	call	FN_READAD1016
	banksel	SYSREADAD10WORD
	movf	SYSREADAD10WORD,W
	movwf	SENSORVALUE2
	movf	SYSREADAD10WORD_H,W
	movwf	SENSORVALUE2_H
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	call	Delay_MS
	movlw	2
	banksel	ADREADPORT
	movwf	ADREADPORT
	banksel	STATUS
	call	FN_READAD1016
	banksel	SYSREADAD10WORD
	movf	SYSREADAD10WORD,W
	movwf	SENSORVALUE3
	movf	SYSREADAD10WORD_H,W
	movwf	SENSORVALUE3_H
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	call	Delay_MS
	movlw	3
	banksel	ADREADPORT
	movwf	ADREADPORT
	banksel	STATUS
	call	FN_READAD1016
	banksel	SYSREADAD10WORD
	movf	SYSREADAD10WORD,W
	movwf	SENSORVALUE4
	movf	SYSREADAD10WORD_H,W
	movwf	SENSORVALUE4_H
	goto	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

DESCRIPTORHANDLER
	movlw	low StringTable5
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	banksel	STATUS
	call	HSERPRINT264
	banksel	USBDESCTYPE
	movf	USBDESCTYPE,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	movwf	COMPORT
	banksel	STATUS
	call	HSERPRINT265
	movlw	1
	banksel	HSERPRINTCRLFCOUNT
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	banksel	STATUS
	goto	HSERPRINTCRLF

;********************************************************************************

Delay_10US
D10US_START
	movlw	39
	movwf	DELAYTEMP
DelayUS0
	decfsz	DELAYTEMP,F
	goto	DelayUS0
	decfsz	SysWaitTemp10US, F
	goto	D10US_START
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	179
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	21
	movwf	DELAYTEMP
DMS_INNER
	decfsz	DELAYTEMP, F
	goto	DMS_INNER
	decfsz	DELAYTEMP2, F
	goto	DMS_OUTER
	decfsz	SysWaitTempMS, F
	goto	DMS_START
	decfsz	SysWaitTempMS_H, F
	goto	DMS_START
	return

;********************************************************************************

ERRORHANDLER
	movlw	low StringTable3
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	banksel	STATUS
	call	HSERPRINT264
	banksel	UEIR
	movf	UEIR,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	call	FN_HEX
	movlw	low HEX
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	banksel	STATUS
	call	HSERPRINT264
	movlw	1
	banksel	HSERPRINTCRLFCOUNT
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	banksel	STATUS
	goto	HSERPRINTCRLF

;********************************************************************************

FN_HEX
	movlw	2
	banksel	SYSHEX_0
	movwf	SYSHEX_0
	movlw	15
	banksel	SYSVALTEMP
	andwf	SYSVALTEMP,W
	movwf	SYSSTRINGTEMP
	sublw	9
	btfsc	STATUS, C
	goto	ENDIF44
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF44
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYSHEX_2
	movwf	SYSHEX_2
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP
SysForLoop7
	incf	SYSSTRINGTEMP,F
	rrf	SYSVALTEMP,F
	movlw	4
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop7
ENDIF45
SysForLoopEnd7
	movlw	15
	andwf	SYSVALTEMP,W
	movwf	SYSSTRINGTEMP
	sublw	9
	btfsc	STATUS, C
	goto	ENDIF46
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF46
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYSHEX_1
	movwf	SYSHEX_1
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT264
	banksel	SYSPRINTDATAHANDLER
	movf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	PRINTLEN
	movf	PRINTLEN,F
	btfsc	STATUS, Z
	goto	ENDIF40
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd6
ENDIF41
SysForLoop6
	incf	SYSPRINTTEMP,F
	movf	SYSPRINTTEMP,W
	addwf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SERDATA
	banksel	STATUS
	call	HSERSEND
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
	banksel	PRINTLEN
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop6
ENDIF42
SysForLoopEnd6
ENDIF40
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT265
	banksel	OUTVALUETEMP
	clrf	OUTVALUETEMP
	movlw	100
	subwf	SERPRINTVAL,W
	btfss	STATUS, C
	goto	ENDIF47
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	100
	movwf	SysBYTETempB
	banksel	STATUS
	call	SysDivSub
	movf	SysBYTETempA,W
	banksel	OUTVALUETEMP
	movwf	OUTVALUETEMP
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	banksel	STATUS
	call	HSERSEND
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
ENDIF47
	banksel	OUTVALUETEMP
	movf	OUTVALUETEMP,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	banksel	STATUS
	call	SysCompLessThan
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	banksel	STATUS
	call	SysCompLessThan
	comf	SysByteTempX,F
	banksel	SYSTEMP2
	movf	SysTemp2,W
	iorwf	SysByteTempX,W
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF48
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	banksel	STATUS
	call	SysDivSub
	movf	SysBYTETempA,W
	banksel	OUTVALUETEMP
	movwf	OUTVALUETEMP
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	banksel	STATUS
	call	HSERSEND
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
ENDIF48
	movlw	48
	banksel	SERPRINTVAL
	addwf	SERPRINTVAL,W
	movwf	SERDATA
	banksel	STATUS
	call	HSERSEND
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	goto	Delay_MS

;********************************************************************************

HSERPRINTCRLF
	banksel	HSERPRINTCRLFCOUNT
	movf	HSERPRINTCRLFCOUNT,W
	movwf	SysRepeatTemp2
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd2
SysRepeatLoop2
	movlw	13
	movwf	SERDATA
	banksel	STATUS
	call	HSERSEND
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
	movlw	10
	banksel	SERDATA
	movwf	SERDATA
	banksel	STATUS
	call	HSERSEND
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
	banksel	SYSREPEATTEMP2
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
	banksel	STATUS
	return

;********************************************************************************

HSERSEND
	banksel	COMPORT
	decf	COMPORT,W
	btfss	STATUS, Z
	goto	ENDIF39
SysWaitLoop3
	banksel	PIR1
	btfss	PIR1,TXIF
	goto	SysWaitLoop3
	banksel	SERDATA
	movf	SERDATA,W
	banksel	TXREG
	movwf	TXREG
	banksel	STATUS
	return
ENDIF39
	banksel	STATUS
	return

;********************************************************************************

INITSYS
;osccon type is 105
	banksel	OSCCON
	bsf	OSCCON,IRCF3
	bsf	OSCCON,IRCF2
	bsf	OSCCON,IRCF1
	bsf	OSCCON,IRCF0
	bsf	OSCCON,SPLLMULT
	bsf	OSCCON,SPLLEN
	bcf	ADCON1,ADFM
	bcf	ADCON0,ADON
	banksel	ANSELA
	clrf	ANSELA
	clrf	ANSELB
	clrf	ANSELC
	banksel	CM2CON0
	bcf	CM2CON0,C2ON
	bcf	CM1CON0,C1ON
	banksel	PORTA
	clrf	PORTA
	clrf	PORTB
	clrf	PORTC
	return

;********************************************************************************

INITUSART
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	movlw	103
	banksel	SPBRG
	movwf	SPBRG
	clrf	SPBRGH
	bsf	BAUDCON,BRG16
	bsf	TXSTA,BRGH
	bcf	TXSTA,SYNC
	bsf	RCSTA,SPEN
	bsf	RCSTA,CREN
	bsf	TXSTA,TXEN
	banksel	STATUS
	return

;********************************************************************************

INITUSB
	movlw	2
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
	movlw	127
	banksel	UIE
	movwf	UIE
	movlw	159
	movwf	UEIE
	banksel	PIE2
	bsf	PIE2,USBIE
	banksel	UCFG
	bsf	UCFG,FSEN
	bsf	UCFG,UPUEN
	movlw	8
	banksel	USB_OUT0_STAT
	movwf	USB_OUT0_STAT
	movlw	8
	movwf	USB_IN0_STAT
SysDoLoop_S2
	banksel	UIR
	btfss	UIR,TRNIF
	goto	SysDoLoop_E2
	bcf	UIR,TRNIF
	goto	SysDoLoop_S2
SysDoLoop_E2
	clrf	UEP0
	movlw	64
	banksel	USB_IN0_ADDR
	movwf	USB_IN0_ADDR
	movlw	32
	movwf	USB_IN0_ADDR_H
	movlw	192
	movwf	USB_OUT0_ADDR
	movlw	32
	movwf	USB_OUT0_ADDR_H
	clrf	USB_IN0_CNT
	movlw	128
	movwf	USB_OUT0_CNT
	movlw	8
	movwf	USB_IN0_STAT
	movlw	136
	movwf	USB_OUT0_STAT
	banksel	UCON
	bcf	UCON,PKTDIS
	movlw	22
	movwf	UEP0
	clrf	UIR
	clrf	UEIR
	clrf	UADDR
	banksel	USBSTATE
	clrf	USBSTATE
	clrf	USBCURRCONFIGURATION
	banksel	UCON
	bsf	UCON,USBEN
	banksel	STATUS
	return

;********************************************************************************

FN_PEEK
	movf	MEMADR_H,W
	movwf	FSR0H
	movf	MEMADR,W
	movwf	FSR0L
	movf	INDF0,W
	banksel	PEEK
	movwf	PEEK
	banksel	STATUS
	return

;********************************************************************************

POKE
	banksel	MEMDATA
	movf	MEMDATA,W
	movwf	INDF0
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:
FN_READAD1016
	banksel	ADCON1
	bsf	ADCON1,ADFM
SysSelect6Case1
	banksel	ADREADPORT
	movf	ADREADPORT,F
	btfss	STATUS, Z
	goto	SysSelect6Case2
	banksel	ANSELA
	bsf	ANSELA,0
	goto	SysSelectEnd6
SysSelect6Case2
	decf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case3
	banksel	ANSELA
	bsf	ANSELA,1
	goto	SysSelectEnd6
SysSelect6Case3
	movlw	2
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case4
	banksel	ANSELA
	bsf	ANSELA,2
	goto	SysSelectEnd6
SysSelect6Case4
	movlw	3
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case5
	banksel	ANSELA
	bsf	ANSELA,4
	goto	SysSelectEnd6
SysSelect6Case5
	movlw	4
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case6
	banksel	ANSELC
	bsf	ANSELC,0
	goto	SysSelectEnd6
SysSelect6Case6
	movlw	5
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case7
	banksel	ANSELC
	bsf	ANSELC,1
	goto	SysSelectEnd6
SysSelect6Case7
	movlw	6
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case8
	banksel	ANSELC
	bsf	ANSELC,2
	goto	SysSelectEnd6
SysSelect6Case8
	movlw	7
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case9
	banksel	ANSELC
	bsf	ANSELC,3
	goto	SysSelectEnd6
SysSelect6Case9
	movlw	8
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case10
	banksel	ANSELC
	bsf	ANSELC,6
	goto	SysSelectEnd6
SysSelect6Case10
	movlw	9
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case11
	banksel	ANSELC
	bsf	ANSELC,7
	goto	SysSelectEnd6
SysSelect6Case11
	movlw	10
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case12
	banksel	ANSELB
	bsf	ANSELB,4
	goto	SysSelectEnd6
SysSelect6Case12
	movlw	11
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelectEnd6
	banksel	ANSELB
	bsf	ANSELB,5
SysSelectEnd6
	banksel	ADCON1
	bcf	ADCON1,ADCS2
	bsf	ADCON1,ADCS1
	bcf	ADCON1,ADCS0
	bcf	ADCON0,CHS0
	bcf	ADCON0,CHS1
	bcf	ADCON0,CHS2
	bcf	ADCON0,CHS3
	bcf	ADCON0,CHS4
	banksel	ADREADPORT
	btfss	ADREADPORT,0
	goto	ENDIF34
	banksel	ADCON0
	bsf	ADCON0,CHS0
ENDIF34
	banksel	ADREADPORT
	btfss	ADREADPORT,1
	goto	ENDIF35
	banksel	ADCON0
	bsf	ADCON0,CHS1
ENDIF35
	banksel	ADREADPORT
	btfss	ADREADPORT,2
	goto	ENDIF36
	banksel	ADCON0
	bsf	ADCON0,CHS2
ENDIF36
	banksel	ADREADPORT
	btfss	ADREADPORT,3
	goto	ENDIF37
	banksel	ADCON0
	bsf	ADCON0,CHS3
ENDIF37
	banksel	ADREADPORT
	btfss	ADREADPORT,4
	goto	ENDIF38
	banksel	ADCON0
	bsf	ADCON0,CHS4
ENDIF38
	banksel	ADCON0
	bsf	ADCON0,ADON
	movlw	2
	movwf	SysWaitTemp10US
	banksel	STATUS
	call	Delay_10US
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE
	nop
SysWaitLoop2
	btfsc	ADCON0,GO_NOT_DONE
	goto	SysWaitLoop2
	bcf	ADCON0,ADON
	banksel	ANSELA
	clrf	ANSELA
	clrf	ANSELB
	clrf	ANSELC
	banksel	ADRESL
	movf	ADRESL,W
	banksel	READAD10
	movwf	READAD10
	clrf	READAD10_H
	banksel	ADRESH
	movf	ADRESH,W
	banksel	READAD10_H
	movwf	READAD10_H
	banksel	ADCON1
	bcf	ADCON1,ADFM
	banksel	STATUS
	return

;********************************************************************************

SETUPHANDLER
SysSelect7Case1
	movlw	131
	banksel	SYSUSBTEMPBUFFER_1
	subwf	SYSUSBTEMPBUFFER_1,W
	btfss	STATUS, Z
	goto	SysSelect7Case2
	banksel	LATB
	bsf	LATB,5
	banksel	STATUS
	call	USBSENDDATA1ACK
	goto	SysSelectEnd7
SysSelect7Case2
	movlw	132
	subwf	SYSUSBTEMPBUFFER_1,W
	btfss	STATUS, Z
	goto	SysSelect7Case3
	banksel	LATB
	bcf	LATB,5
	banksel	STATUS
	call	USBSENDDATA1ACK
	goto	SysSelectEnd7
SysSelect7Case3
	movlw	133
	subwf	SYSUSBTEMPBUFFER_1,W
	btfss	STATUS, Z
	goto	SysSelect7Case4
	movlw	8
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT
	movf	USB_IN0_ADDR,W
	movwf	MEMADR
	movf	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	SENSORVALUE1
	movf	SENSORVALUE1,W
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	movlw	1
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	SENSORVALUE1_H
	movf	SENSORVALUE1_H,W
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	movlw	2
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	SENSORVALUE2
	movf	SENSORVALUE2,W
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	movlw	3
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	SENSORVALUE2_H
	movf	SENSORVALUE2_H,W
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	movlw	4
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	SENSORVALUE3
	movf	SENSORVALUE3,W
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	movlw	5
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	SENSORVALUE3_H
	movf	SENSORVALUE3_H,W
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	movlw	6
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	SENSORVALUE4
	movf	SENSORVALUE4,W
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	movlw	7
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	SENSORVALUE4_H
	movf	SENSORVALUE4_H,W
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	btfss	USB_IN0_STAT,6
	goto	ELSE43_1
	movlw	136
	movwf	USB_IN0_STAT
	goto	ENDIF43
ELSE43_1
	movlw	200
	movwf	USB_IN0_STAT
ENDIF43
	goto	SysSelectEnd7
SysSelect7Case4
	movlw	low StringTable4
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	banksel	STATUS
	call	HSERPRINT264
	banksel	SYSUSBTEMPBUFFER_1
	movf	SYSUSBTEMPBUFFER_1,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	movwf	COMPORT
	banksel	STATUS
	call	HSERPRINT265
	movlw	1
	banksel	HSERPRINTCRLFCOUNT
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	banksel	STATUS
	call	HSERPRINTCRLF
SysSelectEnd7
	return

;********************************************************************************

SYSCOMPLESSTHAN
	clrf	SYSBYTETEMPX
	bsf	STATUS, C
	movf	SYSBYTETEMPB, W
	subwf	SYSBYTETEMPA, W
	btfss	STATUS, C
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSDIVSUB
	movf	SYSBYTETEMPB, F
	btfsc	STATUS, Z
	return
	clrf	SYSBYTETEMPX
	movlw	8
	movwf	SYSDIVLOOP
SYSDIV8START
	bcf	STATUS, C
	rlf	SYSBYTETEMPA, F
	rlf	SYSBYTETEMPX, F
	movf	SYSBYTETEMPB, W
	subwf	SYSBYTETEMPX, F
	bsf	SYSBYTETEMPA, 0
	btfsc	STATUS, C
	goto	DIV8NOTNEG
	bcf	SYSBYTETEMPA, 0
	movf	SYSBYTETEMPB, W
	addwf	SYSBYTETEMPX, F
DIV8NOTNEG
	decfsz	SYSDIVLOOP, F
	goto	SYSDIV8START
	return

;********************************************************************************

SYSREADSTRING
	call	SYSSTRINGTABLES
	movwf	SYSCALCTEMPA
	movwf	INDF1
	goto	SYSSTRINGREADCHECK
SYSREADSTRINGPART
	call	SYSSTRINGTABLES
	movwf	SYSCALCTEMPA
	addwf	SYSSTRINGLENGTH,F
SYSSTRINGREADCHECK
	movf	SYSCALCTEMPA,F
	btfsc	STATUS,Z
	return
SYSSTRINGREAD
	call	SYSSTRINGTABLES
	addfsr	1,1
	movwf	INDF1
	decfsz	SYSCALCTEMPA, F
	goto	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable1
	retlw	16
	retlw	71	;G
	retlw	67	;C
	retlw	66	;B
	retlw	65	;A
	retlw	83	;S
	retlw	73	;I
	retlw	67	;C
	retlw	32	; 
	retlw	85	;U
	retlw	83	;S
	retlw	66	;B
	retlw	32	; 
	retlw	84	;T
	retlw	101	;e
	retlw	115	;s
	retlw	116	;t


StringTable2
	retlw	7
	retlw	85	;U
	retlw	83	;S
	retlw	66	;B
	retlw	32	; 
	retlw	67	;C
	retlw	71	;G
	retlw	66	;B


StringTable3
	retlw	1
	retlw	69	;E


StringTable4
	retlw	4
	retlw	82	;R
	retlw	101	;e
	retlw	113	;q
	retlw	32	; 


StringTable5
	retlw	5
	retlw	68	;D
	retlw	101	;e
	retlw	115	;s
	retlw	99	;c
	retlw	32	; 


StringTable6
	retlw	9
	retlw	71	;G
	retlw	114	;r
	retlw	101	;e
	retlw	97	;a
	retlw	116	;t
	retlw	32	; 
	retlw	67	;C
	retlw	111	;o
	retlw	119	;w


StringTable9
	retlw	0


;********************************************************************************

USBCONFIGDESCRIPTOR
	movlw	18
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableUSBCONFIGDESCRIPTOR
	movwf	SysStringA
	movlw	(high TableUSBCONFIGDESCRIPTOR) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableUSBCONFIGDESCRIPTOR
	retlw	18
	retlw	9
	retlw	2
	retlw	18
	retlw	0
	retlw	1
	retlw	1
	retlw	0
	retlw	128
	retlw	25
	retlw	9
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	255

;********************************************************************************

USBDEVICEDESCRIPTOR
	movlw	19
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableUSBDEVICEDESCRIPTOR
	movwf	SysStringA
	movlw	(high TableUSBDEVICEDESCRIPTOR) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableUSBDEVICEDESCRIPTOR
	retlw	18
	retlw	18
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	85
	retlw	240
	retlw	0
	retlw	16
	retlw	1
	retlw	1
	retlw	1
	retlw	2
	retlw	0
	retlw	1

;********************************************************************************

USBDEVICEQUALDESCRIPTOR
	movlw	10
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableUSBDEVICEQUALDESCRIPTOR
	movwf	SysStringA
	movlw	(high TableUSBDEVICEQUALDESCRIPTOR) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableUSBDEVICEQUALDESCRIPTOR
	retlw	10
	retlw	10
	retlw	6
	retlw	0
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	1

;********************************************************************************

USBINTERRUPTHANDLER
	banksel	UIR
	btfss	UIR,URSTIF
	goto	ENDIF5
	movlw	8
	banksel	USB_OUT0_STAT
	movwf	USB_OUT0_STAT
	movlw	8
	movwf	USB_IN0_STAT
SysDoLoop_S3
	banksel	UIR
	btfss	UIR,TRNIF
	goto	SysDoLoop_E3
	bcf	UIR,TRNIF
	goto	SysDoLoop_S3
SysDoLoop_E3
	clrf	UEP0
	movlw	64
	banksel	USB_IN0_ADDR
	movwf	USB_IN0_ADDR
	movlw	32
	movwf	USB_IN0_ADDR_H
	movlw	192
	movwf	USB_OUT0_ADDR
	movlw	32
	movwf	USB_OUT0_ADDR_H
	clrf	USB_IN0_CNT
	movlw	128
	movwf	USB_OUT0_CNT
	movlw	8
	movwf	USB_IN0_STAT
	movlw	136
	movwf	USB_OUT0_STAT
	banksel	UCON
	bcf	UCON,PKTDIS
	movlw	22
	movwf	UEP0
	clrf	UADDR
	clrf	UEIR
	clrf	UIR
	bcf	UCON,SUSPND
SysWaitLoop1
	btfsc	UCON,SE0
	goto	SysWaitLoop1
	movlw	255
	banksel	USBLASTCONTROL
	movwf	USBLASTCONTROL
	movlw	1
	movwf	USBSTATE
	clrf	USBCURRCONFIGURATION
ENDIF5
	banksel	UIR
	btfss	UIR,UERRIF
	goto	ENDIF6
	banksel	STATUS
	call	ERRORHANDLER
	banksel	UEIR
	clrf	UEIR
	bcf	UIR,UERRIF
ENDIF6
	btfss	UIR,ACTVIF
	goto	ENDIF7
	bcf	UCON,SUSPND
	bcf	UIR,ACTVIF
ENDIF7
	btfss	UIR,TRNIF
	goto	ENDIF8
	movlw	120
	andwf	USTAT,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	banksel	STATUS
	call	SysDivSub
	movf	SysBYTETempA,W
	banksel	USBCURRENDPOINT
	movwf	USBCURRENDPOINT
	banksel	USTAT
	btfss	USTAT,DIR
	goto	ELSE12_1
	banksel	USB_IN0_STAT
	movf	USB_IN0_STAT,W
	banksel	USBBUFFERSTAT
	movwf	USBBUFFERSTAT
	goto	ENDIF12
ELSE12_1
	banksel	USB_OUT0_STAT
	movf	USB_OUT0_STAT,W
	banksel	USBBUFFERSTAT
	movwf	USBBUFFERSTAT
	banksel	USB_OUT0_STAT
	bcf	USB_OUT0_STAT,7
ENDIF12
	movlw	60
	banksel	USBBUFFERSTAT
	andwf	USBBUFFERSTAT,W
	movwf	USBPID
SysSelect1Case1
	movlw	4
	subwf	USBPID,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
	movlw	128
	banksel	USB_OUT0_CNT
	movwf	USB_OUT0_CNT
	bsf	USB_OUT0_STAT,7
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	36
	subwf	USBPID,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
SysSelect2Case1
	movlw	5
	subwf	USBLASTCONTROL,W
	btfss	STATUS, Z
	goto	SysSelect2Case2
	movf	USBNEWADDRESS,W
	banksel	UADDR
	movwf	UADDR
	movlw	2
	banksel	USBSTATE
	movwf	USBSTATE
	movlw	255
	movwf	USBLASTCONTROL
	goto	SysSelectEnd2
SysSelect2Case2
	movlw	6
	subwf	USBLASTCONTROL,W
	btfss	STATUS, Z
	goto	SysSelect2Case3
	banksel	STATUS
	call	USBSENDDESCRIPTOR
	goto	SysSelectEnd2
SysSelect2Case3
	movlw	128
	banksel	USB_OUT0_CNT
	movwf	USB_OUT0_CNT
	movlw	136
	movwf	USB_OUT0_STAT
SysSelectEnd2
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	52
	subwf	USBPID,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
	movlw	255
	movwf	USBCURRBYTE
SysForLoop1
	incf	USBCURRBYTE,F
	movf	USBCURRBYTE,W
	banksel	USB_OUT0_ADDR
	addwf	USB_OUT0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_OUT0_ADDR_H,W
	movwf	MEMADR_H
	call	FN_PEEK
	movlw	low(USBTEMPBUFFER)
	banksel	USBCURRBYTE
	addwf	USBCURRBYTE,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(USBTEMPBUFFER)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	PEEK,W
	movwf	INDF0
	movlw	7
	banksel	USBCURRBYTE
	subwf	USBCURRBYTE,W
	btfss	STATUS, C
	goto	SysForLoop1
ENDIF13
SysForLoopEnd1
	movlw	8
	banksel	USB_IN0_STAT
	movwf	USB_IN0_STAT
	movlw	128
	movwf	USB_OUT0_CNT
	movlw	136
	movwf	USB_OUT0_STAT
	call	USBPROCESSSETUP
	goto	SysSelectEnd1
SysSelect1Case4
SysSelectEnd1
	movlw	255
	banksel	USBHASDATA
	movwf	USBHASDATA
	banksel	UIR
	bcf	UIR,TRNIF
ENDIF8
	btfsc	UIR,IDLEIF
	bcf	UIR,IDLEIF
ENDIF9
	btfsc	UIR,STALLIF
	bcf	UIR,STALLIF
ENDIF10
	btfsc	UIR,SOFIF
	bcf	UIR,SOFIF
ENDIF11
	banksel	STATUS
	return

;********************************************************************************

USBPROCESSSETUP
	movlw	127
	banksel	SYSUSBTEMPBUFFER_0
	andwf	SYSUSBTEMPBUFFER_0,W
	banksel	USBBMREQUESTTYPE
	movwf	USBBMREQUESTTYPE
	banksel	UCON
	bcf	UCON,PKTDIS
	banksel	USBBMREQUESTTYPE
	movf	USBBMREQUESTTYPE,F
	btfss	STATUS, Z
	goto	ELSE14_1
	movlw	255
	movwf	USBLASTCONTROL
SysSelect3Case1
	movlw	5
	banksel	SYSUSBTEMPBUFFER_1
	subwf	SYSUSBTEMPBUFFER_1,W
	btfss	STATUS, Z
	goto	SysSelect3Case2
	movlw	5
	banksel	USBLASTCONTROL
	movwf	USBLASTCONTROL
	banksel	SYSUSBTEMPBUFFER_2
	movf	SYSUSBTEMPBUFFER_2,W
	banksel	USBNEWADDRESS
	movwf	USBNEWADDRESS
	banksel	STATUS
	call	USBSENDDATA1ACK
	goto	SysSelectEnd3
SysSelect3Case2
	movlw	6
	subwf	SYSUSBTEMPBUFFER_1,W
	btfss	STATUS, Z
	goto	SysSelect3Case3
	movlw	6
	banksel	USBLASTCONTROL
	movwf	USBLASTCONTROL
	banksel	SYSUSBTEMPBUFFER_3
	movf	SYSUSBTEMPBUFFER_3,W
	banksel	USBDESCTYPE
	movwf	USBDESCTYPE
	banksel	SYSUSBTEMPBUFFER_2
	movf	SYSUSBTEMPBUFFER_2,W
	banksel	USBDESCINDEX
	movwf	USBDESCINDEX
	banksel	SYSUSBTEMPBUFFER_6
	movf	SYSUSBTEMPBUFFER_6,W
	banksel	USBDESCSIZEIN
	movwf	USBDESCSIZEIN
	clrf	USBDESCSTART
	banksel	STATUS
	call	USBSENDDESCRIPTOR
	goto	SysSelectEnd3
SysSelect3Case3
	movlw	9
	subwf	SYSUSBTEMPBUFFER_1,W
	btfss	STATUS, Z
	goto	SysSelect3Case4
	movf	SYSUSBTEMPBUFFER_2,W
	banksel	USBCURRCONFIGURATION
	movwf	USBCURRCONFIGURATION
	movf	USBCURRCONFIGURATION,F
	btfss	STATUS, Z
	goto	ELSE15_1
	movlw	2
	movwf	USBSTATE
	goto	ENDIF15
ELSE15_1
	movlw	3
	movwf	USBSTATE
ENDIF15
	banksel	STATUS
	call	USBSENDDATA1ACK
	goto	SysSelectEnd3
SysSelect3Case4
	banksel	STATUS
	call	SETUPHANDLER
SysSelectEnd3
	goto	ENDIF14
ELSE14_1
	banksel	STATUS
	call	SETUPHANDLER
ENDIF14
	return

;********************************************************************************

USBSENDDATA1ACK
	clrf	USB_IN0_CNT
	movlw	200
	movwf	USB_IN0_STAT
	return

;********************************************************************************

USBSENDDESCRIPTOR
	bcf	USB_IN0_STAT,7
SysSelect4Case1
	banksel	USBDESCTYPE
	decf	USBDESCTYPE,W
	btfss	STATUS, Z
	goto	SysSelect4Case2
	movlw	18
	movwf	USBSIZE
	subwf	USBDESCSIZEIN,W
	btfsc	STATUS, C
	goto	ENDIF16
	movf	USBDESCSIZEIN,W
	movwf	USBSIZE
ENDIF16
	movf	USBSIZE,W
	subwf	USBDESCSTART,W
	btfss	STATUS, C
	goto	ELSE17_1
	clrf	USBSIZE
	movlw	255
	movwf	USBLASTCONTROL
	goto	ENDIF17
ELSE17_1
	movf	USBDESCSTART,W
	subwf	USBSIZE,F
ENDIF17
	clrf	USBCURRBYTE
	movlw	1
	subwf	USBSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd2
ENDIF18
SysForLoop2
	incf	USBCURRBYTE,F
	movf	USBDESCSTART,W
	addwf	USBCURRBYTE,W
	movwf	SYSSTRINGA
	banksel	STATUS
	call	USBDEVICEDESCRIPTOR
	banksel	USBTEMPBYTE
	movwf	USBTEMPBYTE
	decf	USBCURRBYTE,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	USBTEMPBYTE
	movf	USBTEMPBYTE,W
	banksel	MEMDATA
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	banksel	USBSIZE
	movf	USBSIZE,W
	subwf	USBCURRBYTE,W
	btfss	STATUS, C
	goto	SysForLoop2
ENDIF19
SysForLoopEnd2
	movf	USBSIZE,W
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT
	banksel	USBSIZE
	movf	USBSIZE,W
	addwf	USBDESCSTART,F
	goto	SysSelectEnd4
SysSelect4Case2
	movlw	2
	subwf	USBDESCTYPE,W
	btfss	STATUS, Z
	goto	SysSelect4Case3
	movlw	18
	movwf	USBSIZE
	subwf	USBDESCSIZEIN,W
	btfsc	STATUS, C
	goto	ENDIF20
	movf	USBDESCSIZEIN,W
	movwf	USBSIZE
ENDIF20
	movf	USBSIZE,W
	subwf	USBDESCSTART,W
	btfss	STATUS, C
	goto	ELSE21_1
	clrf	USBSIZE
	movlw	255
	movwf	USBLASTCONTROL
	goto	ENDIF21
ELSE21_1
	movf	USBDESCSTART,W
	subwf	USBSIZE,F
ENDIF21
	clrf	USBCURRBYTE
	movlw	1
	subwf	USBSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd3
ENDIF22
SysForLoop3
	incf	USBCURRBYTE,F
	movf	USBDESCSTART,W
	addwf	USBCURRBYTE,W
	movwf	SYSSTRINGA
	banksel	STATUS
	call	USBCONFIGDESCRIPTOR
	banksel	USBTEMPBYTE
	movwf	USBTEMPBYTE
	decf	USBCURRBYTE,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	USBTEMPBYTE
	movf	USBTEMPBYTE,W
	banksel	MEMDATA
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	banksel	USBSIZE
	movf	USBSIZE,W
	subwf	USBCURRBYTE,W
	btfss	STATUS, C
	goto	SysForLoop3
ENDIF23
SysForLoopEnd3
	movf	USBSIZE,W
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT
	banksel	USBSIZE
	movf	USBSIZE,W
	addwf	USBDESCSTART,F
	goto	SysSelectEnd4
SysSelect4Case3
	movlw	6
	subwf	USBDESCTYPE,W
	btfss	STATUS, Z
	goto	SysSelect4Case4
	movlw	10
	movwf	USBSIZE
	subwf	USBDESCSIZEIN,W
	btfsc	STATUS, C
	goto	ENDIF24
	movf	USBDESCSIZEIN,W
	movwf	USBSIZE
ENDIF24
	movf	USBSIZE,W
	subwf	USBDESCSTART,W
	btfss	STATUS, C
	goto	ELSE25_1
	clrf	USBSIZE
	movlw	255
	movwf	USBLASTCONTROL
	goto	ENDIF25
ELSE25_1
	movf	USBDESCSTART,W
	subwf	USBSIZE,F
ENDIF25
	clrf	USBCURRBYTE
	movlw	1
	subwf	USBSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd4
ENDIF26
SysForLoop4
	incf	USBCURRBYTE,F
	movf	USBDESCSTART,W
	addwf	USBCURRBYTE,W
	movwf	SYSSTRINGA
	banksel	STATUS
	call	USBDEVICEQUALDESCRIPTOR
	banksel	USBTEMPBYTE
	movwf	USBTEMPBYTE
	decf	USBCURRBYTE,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	USBTEMPBYTE
	movf	USBTEMPBYTE,W
	banksel	MEMDATA
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	banksel	USBSIZE
	movf	USBSIZE,W
	subwf	USBCURRBYTE,W
	btfss	STATUS, C
	goto	SysForLoop4
ENDIF27
SysForLoopEnd4
	movf	USBSIZE,W
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT
	banksel	USBSIZE
	movf	USBSIZE,W
	addwf	USBDESCSTART,F
	goto	SysSelectEnd4
SysSelect4Case4
	movlw	3
	subwf	USBDESCTYPE,W
	btfss	STATUS, Z
	goto	SysSelect4Case5
	movf	USBDESCINDEX,F
	btfss	STATUS, Z
	goto	ELSE28_1
	movlw	255
	movwf	USBLASTCONTROL
	banksel	USB_IN0_ADDR
	movf	USB_IN0_ADDR,W
	movwf	MEMADR
	movf	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	movlw	4
	banksel	MEMDATA
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	movlw	1
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	movlw	3
	banksel	MEMDATA
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	movlw	2
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	movlw	9
	banksel	MEMDATA
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	movlw	3
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	movlw	4
	banksel	MEMDATA
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	movlw	4
	movwf	USB_IN0_CNT
	goto	ENDIF28
ELSE28_1
SysSelect5Case1
	decf	USBDESCINDEX,W
	btfss	STATUS, Z
	goto	SysSelect5Case2
	movlw	low USBTEMPSTRING
	movwf	FSR1L
	movlw	high USBTEMPSTRING
	movwf	FSR1H
	movlw	low StringTable6
	movwf	SysStringA
	movlw	(high StringTable6) & 127
	movwf	SysStringA_H
	banksel	STATUS
	call	SysReadString
	goto	SysSelectEnd5
SysSelect5Case2
	movlw	2
	subwf	USBDESCINDEX,W
	btfss	STATUS, Z
	goto	SysSelect5Case3
	movlw	low USBTEMPSTRING
	movwf	FSR1L
	movlw	high USBTEMPSTRING
	movwf	FSR1H
	movlw	low StringTable1
	movwf	SysStringA
	movlw	(high StringTable1) & 127
	movwf	SysStringA_H
	banksel	STATUS
	call	SysReadString
	goto	SysSelectEnd5
SysSelect5Case3
	movlw	low USBTEMPSTRING
	movwf	FSR1L
	movlw	high USBTEMPSTRING
	movwf	FSR1H
	movlw	low StringTable9
	movwf	SysStringA
	movlw	(high StringTable9) & 127
	movwf	SysStringA_H
	banksel	STATUS
	call	SysReadString
SysSelectEnd5
	bcf	STATUS,C
	banksel	SYSUSBTEMPSTRING_0
	rlf	SYSUSBTEMPSTRING_0,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	2
	addwf	SysTemp1,W
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT
	banksel	USBDESCSTART
	movf	USBDESCSTART,W
	banksel	USB_IN0_CNT
	subwf	USB_IN0_CNT,W
	btfsc	STATUS, C
	goto	ELSE30_1
	clrf	USB_IN0_CNT
	movlw	255
	banksel	USBLASTCONTROL
	movwf	USBLASTCONTROL
	goto	ENDIF30
ELSE30_1
	banksel	USBDESCSTART
	movf	USBDESCSTART,W
	banksel	USB_IN0_CNT
	subwf	USB_IN0_CNT,F
ENDIF30
	banksel	USB_IN0_ADDR
	movf	USB_IN0_ADDR,W
	movwf	MEMADR
	movf	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	movf	USB_IN0_CNT,W
	banksel	MEMDATA
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	movlw	1
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	movlw	3
	banksel	MEMDATA
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	banksel	USBCURRBYTE
	clrf	USBCURRBYTE
	movlw	1
	banksel	SYSUSBTEMPSTRING_0
	subwf	SYSUSBTEMPSTRING_0,W
	btfss	STATUS, C
	goto	SysForLoopEnd5
ENDIF31
SysForLoop5
	banksel	USBCURRBYTE
	incf	USBCURRBYTE,F
	movlw	low(USBTEMPSTRING)
	addwf	USBCURRBYTE,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(USBTEMPSTRING)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	USBTEMPBYTE
	movwf	USBTEMPBYTE
	bcf	STATUS,C
	rlf	USBCURRBYTE,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	USBTEMPBYTE
	movf	USBTEMPBYTE,W
	banksel	MEMDATA
	movwf	MEMDATA
	banksel	STATUS
	call	POKE
	bcf	STATUS,C
	banksel	USBCURRBYTE
	rlf	USBCURRBYTE,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	incf	SysTemp1,W
	movwf	SysTemp2
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	MEMDATA
	clrf	MEMDATA
	banksel	STATUS
	call	POKE
	banksel	SYSUSBTEMPSTRING_0
	movf	SYSUSBTEMPSTRING_0,W
	banksel	USBCURRBYTE
	subwf	USBCURRBYTE,W
	btfss	STATUS, C
	goto	SysForLoop5
ENDIF32
SysForLoopEnd5
	banksel	USB_IN0_CNT
	movf	USB_IN0_CNT,W
	banksel	USBDESCSIZEIN
	subwf	USBDESCSIZEIN,W
	btfsc	STATUS, C
	goto	ENDIF33
	movf	USBDESCSIZEIN,W
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT
ENDIF33
	banksel	USB_IN0_CNT
	movf	USB_IN0_CNT,W
	banksel	USBDESCSTART
	addwf	USBDESCSTART,F
ENDIF28
	goto	SysSelectEnd4
SysSelect4Case5
	banksel	STATUS
	call	DESCRIPTORHANDLER
	return
SysSelectEnd4
	banksel	USB_IN0_STAT
	btfss	USB_IN0_STAT,6
	goto	ELSE29_1
	movlw	136
	movwf	USB_IN0_STAT
	goto	ENDIF29
ELSE29_1
	movlw	200
	movwf	USB_IN0_STAT
ENDIF29
	return

;********************************************************************************

;Start of program memory page 1
	ORG	2048
;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144

 END
