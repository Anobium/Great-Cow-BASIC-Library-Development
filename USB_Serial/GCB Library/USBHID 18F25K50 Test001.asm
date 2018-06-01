;Program compiled by Great Cow BASIC (0.98.<<>> 2018-05-30)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18LF25K50, r=DEC
#include <P18LF25K50.inc>
 CONFIG LVP = OFF, MCLRE = OFF, WDTEN = OFF, FOSC = INTOSCIO, CPUDIV = NOCLKDIV

;********************************************************************************

;Set aside memory locations for variables
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
MEMDATA	EQU	10
PEEK	EQU	11
SAVEFSR0H	EQU	12
SAVEFSR0L	EQU	13
SAVEFSR1H	EQU	16
SAVEFSR1L	EQU	17
SAVESYSBYTETEMPA	EQU	18
SAVESYSBYTETEMPB	EQU	19
SAVESYSBYTETEMPX	EQU	20
SAVESYSDIVLOOP	EQU	21
SAVESYSSTRINGA	EQU	22
SAVESYSSTRINGLENGTH	EQU	23
SAVESYSTEMP1	EQU	24
SAVESYSTEMP2	EQU	25
STRINGPOINTER	EQU	26
SYSBSR	EQU	27
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSDIVLOOP	EQU	4
SYSSTATUS	EQU	15
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSTEMP1	EQU	28
SYSTEMP1_H	EQU	29
SYSTEMP2	EQU	30
SYSW	EQU	14
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
USBBMREQUESTTYPE	EQU	31
USBBUFFERSTAT	EQU	32
USBCURRBYTE	EQU	33
USBCURRCONFIGURATION	EQU	34
USBCURRENDPOINT	EQU	35
USBDESCINDEX	EQU	36
USBDESCSIZEIN	EQU	37
USBDESCSTART	EQU	38
USBDESCTYPE	EQU	39
USBHASDATA	EQU	40
USBLASTCONTROL	EQU	41
USBNEWADDRESS	EQU	42
USBPID	EQU	43
USBRAM	EQU	1024
USBSIZE	EQU	44
USBSTATE	EQU	45
USBTEMPBUFFER	EQU	1988
USBTEMPBYTE	EQU	46
USBTEMPSTRING	EQU	2005

;********************************************************************************

;Alias variables
AFSR0	EQU	4073
AFSR0_H	EQU	4074
MEMADR	EQU	4073
MEMADR_H	EQU	4074
SYSUSBTEMPBUFFER_0	EQU	1988
SYSUSBTEMPBUFFER_1	EQU	1989
SYSUSBTEMPBUFFER_2	EQU	1990
SYSUSBTEMPBUFFER_3	EQU	1991
SYSUSBTEMPBUFFER_6	EQU	1994
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
	rcall	INITUSB
;Enable interrupts
	bsf	INTCON,GIE,ACCESS
	bsf	INTCON,PEIE,ACCESS

;Start of the main program
	bcf	TRISC,6,ACCESS
SysDoLoop_S1
	bra	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

DESCRIPTORHANDLER
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
SysWaitLoop2
	btfss	OSCCON2,PLLRDY,ACCESS
	bra	SysWaitLoop2
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
	movff	SysStringA,SaveSysStringA
	movff	FSR1L,SaveFSR1L
	movff	FSR1H,SaveFSR1H
	movff	SysTemp2,SaveSysTemp2
	movff	SysStringLength,SaveSysStringLength
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
	movff	SaveSysStringA,SysStringA
	movff	SaveFSR1L,FSR1L
	movff	SaveFSR1H,FSR1H
	movff	SaveSysTemp2,SysTemp2
	movff	SaveSysStringLength,SysStringLength
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

SETUPHANDLER
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


StringTable2
	db	9,71,114,101,97,116,32,67,111,119


StringTable6
	db	0


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
	bra	ENDIF2
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
ENDIF2
	btfss	UIR,UERRIF,ACCESS
	bra	ENDIF3
	rcall	ERRORHANDLER
	clrf	UEIR,ACCESS
	bcf	UIR,UERRIF,ACCESS
ENDIF3
	btfss	UIR,ACTVIF,ACCESS
	bra	ENDIF4
	bcf	UCON,SUSPND,ACCESS
	bcf	UIR,ACTVIF,ACCESS
ENDIF4
	btfss	UIR,TRNIF,ACCESS
	bra	ENDIF5
	movlw	120
	andwf	USTAT,W,ACCESS
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempA,USBCURRENDPOINT
	btfss	USTAT,DIR,ACCESS
	bra	ELSE9_1
	movff	USB_IN0_STAT,USBBUFFERSTAT
	bra	ENDIF9
ELSE9_1
	movff	USB_OUT0_STAT,USBBUFFERSTAT
	banksel	USB_OUT0_STAT
	bcf	USB_OUT0_STAT,7,BANKED
ENDIF9
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
ENDIF10
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
ENDIF5
	btfsc	UIR,IDLEIF,ACCESS
	bcf	UIR,IDLEIF,ACCESS
ENDIF6
	btfsc	UIR,STALLIF,ACCESS
	bcf	UIR,STALLIF,ACCESS
ENDIF7
	btfsc	UIR,SOFIF,ACCESS
	bcf	UIR,SOFIF,ACCESS
ENDIF8
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
	bra	ELSE11_1
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
	bra	ELSE12_1
	movlw	2
	movwf	USBSTATE,BANKED
	bra	ENDIF12
ELSE12_1
	movlw	3
	movwf	USBSTATE,BANKED
ENDIF12
	rcall	USBSENDDATA1ACK
	bra	SysSelectEnd3
SysSelect3Case4
	banksel	0
	rcall	SETUPHANDLER
SysSelectEnd3
	bra	ENDIF11
ELSE11_1
	rcall	SETUPHANDLER
ENDIF11
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
ENDIF13
	movf	USBSIZE,W,BANKED
	subwf	USBDESCSTART,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ELSE14_1
	clrf	USBSIZE,BANKED
	setf	USBLASTCONTROL,BANKED
	bra	ENDIF14
ELSE14_1
	movf	USBDESCSTART,W,BANKED
	subwf	USBSIZE,F,BANKED
ENDIF14
	clrf	USBCURRBYTE,BANKED
	movlw	1
	subwf	USBSIZE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd2
ENDIF15
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
ENDIF16
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
ENDIF17
	movf	USBSIZE,W,BANKED
	subwf	USBDESCSTART,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ELSE18_1
	clrf	USBSIZE,BANKED
	setf	USBLASTCONTROL,BANKED
	bra	ENDIF18
ELSE18_1
	movf	USBDESCSTART,W,BANKED
	subwf	USBSIZE,F,BANKED
ENDIF18
	clrf	USBCURRBYTE,BANKED
	movlw	1
	subwf	USBSIZE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd3
ENDIF19
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
ENDIF20
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
ENDIF21
	movf	USBSIZE,W,BANKED
	subwf	USBDESCSTART,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ELSE22_1
	clrf	USBSIZE,BANKED
	setf	USBLASTCONTROL,BANKED
	bra	ENDIF22
ELSE22_1
	movf	USBDESCSTART,W,BANKED
	subwf	USBSIZE,F,BANKED
ENDIF22
	clrf	USBCURRBYTE,BANKED
	movlw	1
	subwf	USBSIZE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
ENDIF23
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
ENDIF24
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
	bra	ELSE25_1
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
	bra	ENDIF25
ELSE25_1
SysSelect5Case1
	decf	USBDESCINDEX,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case2
	lfsr	1,USBTEMPSTRING
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
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
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
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
	bra	ELSE27_1
	clrf	USB_IN0_CNT,BANKED
	banksel	USBLASTCONTROL
	setf	USBLASTCONTROL,BANKED
	bra	ENDIF27
ELSE27_1
	banksel	USBDESCSTART
	movf	USBDESCSTART,W,BANKED
	banksel	USB_IN0_CNT
	subwf	USB_IN0_CNT,F,BANKED
ENDIF27
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
ENDIF28
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
ENDIF29
SysForLoopEnd5
	banksel	USB_IN0_CNT
	movf	USB_IN0_CNT,W,BANKED
	banksel	USBDESCSIZEIN
	subwf	USBDESCSIZEIN,W,BANKED
	btfss	STATUS, C,ACCESS
	movff	USBDESCSIZEIN,USB_IN0_CNT
ENDIF30
	banksel	USB_IN0_CNT
	movf	USB_IN0_CNT,W,BANKED
	banksel	USBDESCSTART
	addwf	USBDESCSTART,F,BANKED
ENDIF25
	bra	SysSelectEnd4
SysSelect4Case5
	rcall	DESCRIPTORHANDLER
	return
SysSelectEnd4
	banksel	USB_IN0_STAT
	btfss	USB_IN0_STAT,6,BANKED
	bra	ELSE26_1
	movlw	136
	movwf	USB_IN0_STAT,BANKED
	bra	ENDIF26
ELSE26_1
	movlw	200
	movwf	USB_IN0_STAT,BANKED
ENDIF26
	banksel	0
	return

;********************************************************************************


 END
