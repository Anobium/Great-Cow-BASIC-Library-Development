;Program compiled by Great Cow BASIC (0.98.<<>> 2019-02-14 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Chip Model: MEGA328P
;Assembler header file
.INCLUDE "m328pdef.inc"

;SREG bit names (for AVR Assembler compatibility, GCBASIC uses different names)
#define C 0
#define H 5
#define I 7
#define N 2
#define S 4
#define T 6
#define V 3
#define Z 1

;********************************************************************************

;Set aside memory locations for variables
.EQU	CHARCODE=360
.EQU	CHARLOCX=361
.EQU	CHARLOCX_H=362
.EQU	CHARLOCY=363
.EQU	CHARLOCY_H=364
.EQU	COMPORT=365
.EQU	CURRCHARCOL=366
.EQU	CURRCHARROW=367
.EQU	CURRCHARVAL=368
.EQU	CURRPIXELY=369
.EQU	ELEMENT=370
.EQU	ELEMENTBIT=371
.EQU	FNLSL=372
.EQU	FNLSL_E=375
.EQU	FNLSL_H=373
.EQU	FNLSL_U=374
.EQU	GLCDBACKGROUND=376
.EQU	GLCDBACKGROUND_H=377
.EQU	GLCDFONTWIDTH=378
.EQU	GLCDFOREGROUND=379
.EQU	GLCDFOREGROUND_H=380
.EQU	GLCDPRINTLOC=381
.EQU	GLCDPRINTLOC_H=382
.EQU	GLCD_YORDINATE=383
.EQU	GLCD_YORDINATE_H=384
.EQU	HSERINBYTE=385
.EQU	HSERINDEX=386
.EQU	HSERRECEIVE=387
.EQU	LEN=388
.EQU	LINECOLOUR=389
.EQU	LINECOLOUR_H=390
.EQU	MAX7219_BRIGHTNESS_VALUE=391
.EQU	MAX7219_CURRENTMATRIX=392
.EQU	MAX7219_CURRPIXELX=393
.EQU	MAX7219_DEVICEADDRESS=394
.EQU	MAX7219_IMAGE_BUFFER=256
.EQU	MAX7219_LOCX=395
.EQU	MAX7219_LOCX_H=396
.EQU	MAX7219_LOCY=397
.EQU	MAX7219_LOCY_H=398
.EQU	MAX7219_MESSAGETIME=399
.EQU	MAX7219_MESSAGETIME_H=400
.EQU	MAX7219_PIXELCOUNTER=401
.EQU	MAX7219_ROWADDRESS=402
.EQU	MAX7219_SCROLLLEN=403
.EQU	MAX7219_SCROLLLEN_H=404
.EQU	MAX7219_SCROLLPOSITION=405
.EQU	MAX7219_SCROLLPOSITION_H=406
.EQU	MAX7219_XSCROLLPOSITION=407
.EQU	MAX7219_XSCROLLPOSITION_H=408
.EQU	MYSTRING=321
.EQU	NUMBITS=409
.EQU	PIXELCOL=410
.EQU	PRINTLEN=411
.EQU	PRINTLOCX=412
.EQU	PRINTLOCX_H=413
.EQU	PRINTLOCY=414
.EQU	PRINTLOCY_H=415
.EQU	SERDATA=416
.EQU	SPICLOCKMODE=417
.EQU	SPICURRENTMODE=418
.EQU	SPITXDATA=419
.EQU	STRINGPOINTER=420
.EQU	SYSARRAYTEMP1=421
.EQU	SYSARRAYTEMP2=422
.EQU	SYSHSERSTRINGHANDLER=423
.EQU	SYSHSERSTRINGHANDLER_H=424
.EQU	SYSLCDPRINTDATAHANDLER=425
.EQU	SYSLCDPRINTDATAHANDLER_H=426
.EQU	SYSLENTEMPHANDLER=427
.EQU	SYSLENTEMPHANDLER_H=428
.EQU	SYSOUTMESSAGEHANDLER=429
.EQU	SYSOUTMESSAGEHANDLER_H=430
.EQU	SYSPRINTTEMP=431
.EQU	SYSREPEATTEMP1=432
.EQU	SYSREPEATTEMP3=433
.EQU	SYSREPEATTEMP4=434
.EQU	SYSREPEATTEMP6=435
.EQU	SYSSTRINGPARAM1=354
.EQU	_MAX7219_DDATA=436
.EQU	_MAX7219_REG=437

;********************************************************************************

;Register variables
.DEF	DELAYTEMP=r25
.DEF	DELAYTEMP2=r26
.DEF	SYSBITTEST=r5
.DEF	SYSBYTETEMPA=r22
.DEF	SYSBYTETEMPB=r28
.DEF	SYSBYTETEMPX=r0
.DEF	SYSCALCTEMPA=r22
.DEF	SYSCALCTEMPB=r28
.DEF	SYSCALCTEMPX=r0
.DEF	SYSDIVLOOP=r5
.DEF	SYSDIVMULTA=r24
.DEF	SYSDIVMULTA_H=r25
.DEF	SYSDIVMULTB=r30
.DEF	SYSDIVMULTB_H=r31
.DEF	SYSDIVMULTX=r2
.DEF	SYSDIVMULTX_H=r3
.DEF	SYSREADA=r30
.DEF	SYSREADA_H=r31
.DEF	SYSSTRINGA=r26
.DEF	SYSSTRINGA_H=r27
.DEF	SYSSTRINGB=r28
.DEF	SYSSTRINGB_H=r29
.DEF	SYSSTRINGLENGTH=r25
.DEF	SYSVALUECOPY=r21
.DEF	SYSWAITTEMPMS=r29
.DEF	SYSWAITTEMPMS_H=r30
.DEF	SYSWORDTEMPA=r22
.DEF	SYSWORDTEMPA_H=r23
.DEF	SYSWORDTEMPB=r28
.DEF	SYSWORDTEMPB_H=r29
.DEF	SYSWORDTEMPX=r0
.DEF	SYSWORDTEMPX_H=r1
.DEF	SYSTEMP1=r6
.DEF	SYSTEMP1_H=r7
.DEF	SYSTEMP2=r16
.DEF	SYSTEMP2_H=r17
.DEF	SYSTEMP3=r18
.DEF	SYSTEMP4=r4

;********************************************************************************

;Alias variables
#define	SYSFNLSLBYTE	372
#define	SYSMYSTRING_0	321

;********************************************************************************

;Vectors
;Interrupt vectors
.ORG	0
	rjmp	BASPROGRAMSTART ;Reset
.ORG	2
	reti	;INT0
.ORG	4
	reti	;INT1
.ORG	6
	reti	;PCINT0
.ORG	8
	reti	;PCINT1
.ORG	10
	reti	;PCINT2
.ORG	12
	reti	;WDT
.ORG	14
	reti	;TIMER2_COMPA
.ORG	16
	reti	;TIMER2_COMPB
.ORG	18
	reti	;TIMER2_OVF
.ORG	20
	reti	;TIMER1_CAPT
.ORG	22
	reti	;TIMER1_COMPA
.ORG	24
	reti	;TIMER1_COMPB
.ORG	26
	reti	;TIMER1_OVF
.ORG	28
	reti	;TIMER0_COMPA
.ORG	30
	reti	;TIMER0_COMPB
.ORG	32
	reti	;TIMER0_OVF
.ORG	34
	reti	;SPI_STC
.ORG	36
	reti	;USART_RX
.ORG	38
	reti	;USART_UDRE
.ORG	40
	reti	;USART_TX
.ORG	42
	reti	;ADC
.ORG	44
	reti	;EE_READY
.ORG	46
	reti	;ANALOG_COMP
.ORG	48
	reti	;TWI
.ORG	50
	reti	;SPM_READY

;********************************************************************************

;Start of program memory page 0
.ORG	52
BASPROGRAMSTART:
;Initialise stack
	ldi	SysValueCopy,high(RAMEND)
	out	SPH, SysValueCopy
	ldi	SysValueCopy,low(RAMEND)
	out	SPL, SysValueCopy
;Call initialisation routines
	rcall	INITSYS
	rcall	INITUSART
	rcall	MAX7219_LEDMATRIX_INIT

;Start of the main program
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program to show text on the LED Matrix.
;'':
;''The parameters are passed from a Small BASIC program
;'':
;''@author  Evan R. Venn
;''@licence GPL
;''@version 1.00
;''@date    02.03.2019
;''********************************************************************************
;----- Configuration
;#option Explicit
;----- Constants
;Set SPI pins for the Max7219
;#define Max7219_DI    portb.4    'pin12
;#define Max7219_DO    portb.3    'pin11
;#define Max7219_SCK   portb.5    'pin13
;#define Max7219_CS    portb.2    'pin10
;Specifics for device configuration
;#define MAX7219_X_Devices 8
;#define MAX7219_LEDMatrix_HardwareSPI     ' remove and make a comment out if you want to use Software SPI for this device
;#define HWSPIMode MasterSlow
;; ----- Main body of program commences here.
;Set the pin directions
;#define USART_BAUD_RATE 9600
;#define USART_BLOCKING
;dim myString as string * 32
;Max7219_LEDMatrix_Brightness ( 1 )
	ldi	SysValueCopy,1
	sts	MAX7219_BRIGHTNESS_VALUE,SysValueCopy
	rcall	MAX7219_LEDMATRIX_BRIGHTNESS
;GLCDPrint ( 0, 0, "Reset" )
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable1<<1)
	ldi	SysReadA_H,high(StringTable1<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	rcall	MAX7219_LEDMATRIX_GLCDPRINT16
;Max7219_LEDMatrix_Update
	rcall	MAX7219_LEDMATRIX_SENDBUFFER
;do Forever
SysDoLoop_S1:
;myString = ""
	ldi	SysStringB,low(MYSTRING)
	ldi	SysStringB_H,high(MYSTRING)
	ldi	SysReadA,low(StringTable2<<1)
	ldi	SysReadA_H,high(StringTable2<<1)
	rcall	SysReadString
;Do while len(myString) = 0
SysDoLoop_S2:
	ldi	SysValueCopy,low(MYSTRING)
	sts	SysLENTEMPHandler,SysValueCopy
	ldi	SysValueCopy,high(MYSTRING)
	sts	SysLENTEMPHandler_H,SysValueCopy
	rcall	FN_LEN
	lds	SysCalcTempA,LEN
	tst	SysCalcTempA
	brne	SysDoLoop_E2
;HSerGetString MyString
	ldi	SysValueCopy,low(MYSTRING)
	sts	SysHSERSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(MYSTRING)
	sts	SysHSERSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERGETSTRING
;Loop
	rjmp	SysDoLoop_S2
SysDoLoop_E2:
;GLCDCLS
	rcall	MAX7219_LEDMATRIX_GLCDCLS
;if myString(0) > ( MAX7219_X_Devices / 4 )* 5 then  '5 chars per matrix
	lds	SysBYTETempB,SYSMYSTRING_0
	ldi	SysBYTETempA,10
	rcall	SysCompLessThan
	sbrs	SysByteTempX,0
	rjmp	ELSE1_1
;myString = myString + "       "
	ldi	SysStringB,low(MYSTRING)
	ldi	SysStringB_H,high(MYSTRING)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(MYSTRING)
	ldi	SysStringA_H,high(MYSTRING)
	rcall	SysCopyStringPart
	ldi	SysReadA,low(StringTable3<<1)
	ldi	SysReadA_H,high(StringTable3<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(MYSTRING)
	ldi	SysStringA_H,high(MYSTRING)
	st	X, SysStringLength
;Max7219_LEDMatrix_ScrollMessage ( myString , 0 )
	ldi	SysValueCopy,low(MYSTRING)
	sts	SysOUTMESSAGEHandler,SysValueCopy
	ldi	SysValueCopy,high(MYSTRING)
	sts	SysOUTMESSAGEHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	MAX7219_MESSAGETIME,SysValueCopy
	sts	MAX7219_MESSAGETIME_H,SysValueCopy
	rcall	MAX7219_LEDMATRIX_SCROLLMESSAGE
;else
	rjmp	ENDIF1
ELSE1_1:
;GLCDPrint ( 0, 0, myString )
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,low(MYSTRING)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(MYSTRING)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	rcall	MAX7219_LEDMATRIX_GLCDPRINT16
;Max7219_LEDMatrix_Update
	rcall	MAX7219_LEDMATRIX_SENDBUFFER
;end if
ENDIF1:
;loop
	rjmp	SysDoLoop_S1
SysDoLoop_E1:
;#define ST7920ReadDelay = 20
;#define ST7920WriteDelay = 2
;#define ILI9326_DataPort GLCD_DataPort
;#define ILI9326_GLCD_RST GLCD_RST
;#define ILI9326_GLCD_CS  GLCD_CS
;#define ILI9326_GLCD_RS  GLCD_RS
;#define ILI9326_GLCD_WR  GLCD_WR
;#define ILI9326_GLCD_RD  GLCD_RD
;#define ILI9486L_RST GLCD_RST
;#define ILI9486L_CS GLCD_CS
;#define ILI9486L_DC GLCD_DC
;#define ILI9486L_WR GLCD_WR
;#define ILI9486L_RD GLCD_RD
;#define ILI9486L_DB0 GLCD_DB0
;#define ILI9486L_DB1 GLCD_DB1
;#define ILI9486L_DB2 GLCD_DB2
;#define ILI9486L_DB3 GLCD_DB3
;#define ILI9486L_DB4 GLCD_DB4
;#define ILI9486L_DB5 GLCD_DB5
;#define ILI9486L_DB6 GLCD_DB6
;#define ILI9486L_DB7 GLCD_DB7
;#define ILI9486L_RST GLCD_RST
;#define ILI9486L_CS GLCD_CS
;#define ILI9486L_DC GLCD_DC
;#define ILI9486L_WR GLCD_WR
;#define ILI9486L_RD GLCD_RD
;#define tinyDelay nop:nop
;#define ILI9481_GLCD_RST GLCD_RST
;#define ILI9481_GLCD_CS GLCD_CS
;#define ILI9481_GLCD_RS GLCD_RS
;#define ILI9481_GLCD_WR GLCD_WR
;#define ILI9481_GLCD_RD GLCD_RD
;#define ILI9481_GLCD_DB0 GLCD_DB0
;#define ILI9481_GLCD_DB1 GLCD_DB1
;#define ILI9481_GLCD_DB2 GLCD_DB2
;#define ILI9481_GLCD_DB3 GLCD_DB3
;#define ILI9481_GLCD_DB4 GLCD_DB4
;#define ILI9481_GLCD_DB5 GLCD_DB5
;#define ILI9481_GLCD_DB6 GLCD_DB6
;#define ILI9481_GLCD_DB7 GLCD_DB7
;#define ILI9481_GLCD_RST GLCD_RST
;#define ILI9481_GLCD_CS GLCD_CS
;#define ILI9481_GLCD_RS GLCD_RS
;#define ILI9481_GLCD_WR GLCD_WR
;#define LCDON 4
;#define FLASHON 3
;#define FLASH 3
;#define CursorON 2
;#define FLASHOFF 0xFC   'an AND MASK
;#define CursorOFF 0xFD  'an AND MASK
;#define LCDOFF 0xFB     'an AND MASK
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

Delay_MS:
	inc	SysWaitTempMS_H
DMS_START:
	ldi	DELAYTEMP2,254
DMS_OUTER:
	ldi	DELAYTEMP,20
DMS_INNER:
	dec	DELAYTEMP
	brne	DMS_INNER
	dec	DELAYTEMP2
	brne	DMS_OUTER
	dec	SysWaitTempMS
	brne	DMS_START
	dec	SysWaitTempMS_H
	brne	DMS_START
	ret

;********************************************************************************

FASTHWSPITRANSFER:
;Master mode only
;Master mode only
;Do
SysDoLoop_S3:
;SPDR = SPITxData
	lds	SysValueCopy,SPITXDATA
	out	SPDR,SysValueCopy
;Loop While SPSR.WCOL
	in	SysBitTest,SPSR
	sbrc	SysBitTest,WCOL
	rjmp	SysDoLoop_S3
SysDoLoop_E3:
;Read buffer
;Same for master and slave
;Wait While SPSR.SPIF = Off
SysWaitLoop1:
	in	SysBitTest,SPSR
	sbrs	SysBitTest,SPIF
	rjmp	SysWaitLoop1
	ret

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
FN_FNLSL430:
;Repeat NumBits
	lds	SysValueCopy,NUMBITS
	sts	SysRepeatTemp6,SysValueCopy
	lds	SysCalcTempA,SYSREPEATTEMP6
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	SysRepeatLoopEnd6
SysRepeatLoop6:
;Set C Off
	clc
;Rotate SysByteTempB Left
	rol	SYSBYTETEMPB
;End Repeat
	lds	SysTemp4,SysRepeatTemp6
	dec	SysTemp4
	sts	SysRepeatTemp6,SysTemp4
	brne	SysRepeatLoop6
SysRepeatLoopEnd6:
;FnLSL = SysByteTempB
	sts	FNLSL,SYSBYTETEMPB
	ret

;********************************************************************************

GLCDCHARCOL3:
	cpi	SysStringA, 113
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableGLCDCHARCOL3<<1)
	ldi	SysReadA_H, high(TableGLCDCHARCOL3<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableGLCDCHARCOL3:
	.DB	112,0,16,12,10,136,34,56,32,8,32,16,16,128,128,64,4,0,0,0,40,72,70,108,0,0,0,40
	.DB	16,0,16,0,64,124,0,132,130,48,78,120,6,108,12,0,0,16,40,0,4,100,248,254,124,254
	.DB	254,254,124,254,0,64,254,254,254,254,124,254,124,254,76,2,126,62,126,198,14,194
	.DB	0,4,0,8,128,0,64,254,112,112,112,16,16,254,0,64,254,0,248,248,112,248,16,248
	.DB	144,16,120,56,120,136,24,136,0,0,0,32,120

;********************************************************************************

GLCDCHARCOL4:
	cpi	SysStringA, 113
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableGLCDCHARCOL4<<1)
	ldi	SysReadA_H, high(TableGLCDCHARCOL4<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableGLCDCHARCOL4:
	.DB	112,254,56,10,6,204,102,124,112,4,64,16,56,136,162,112,28,0,0,14,254,84,38,146
	.DB	10,56,130,16,16,160,16,192,32,162,132,194,130,40,138,148,2,146,146,108,172,40
	.DB	40,130,2,146,36,146,130,130,146,18,130,16,130,128,16,128,4,8,130,18,130,18,146,2
	.DB	128,64,128,40,16,162,254,8,130,4,128,2,168,144,136,136,168,252,168,16,144,128
	.DB	32,130,8,16,136,40,40,16,168,124,128,64,128,80,160,200,16,0,130,16,68

;********************************************************************************

GLCDCHARCOL5:
	cpi	SysStringA, 113
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableGLCDCHARCOL5<<1)
	ldi	SysReadA_H, high(TableGLCDCHARCOL5<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableGLCDCHARCOL5:
	.DB	112,124,124,0,0,238,238,124,168,254,254,84,84,148,148,124,124,0,158,0,40,254,16,170
	.DB	6,68,68,124,124,96,16,192,16,146,254,162,138,36,138,146,226,146,146,108,108,68
	.DB	40,68,162,242,34,146,130,130,146,18,146,16,254,130,40,128,24,16,130,18,162,50
	.DB	146,254,128,128,112,16,224,146,130,16,130,2,128,4,168,136,136,136,168,18,168,8
	.DB	250,136,80,254,240,8,136,40,40,8,168,144,128,128,96,32,160,168,108,254,108,16
	.DB	66

;********************************************************************************

GLCDCHARCOL6:
	cpi	SysStringA, 113
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableGLCDCHARCOL6<<1)
	ldi	SysReadA_H, high(TableGLCDCHARCOL6<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableGLCDCHARCOL6:
	.DB	112,56,254,12,10,204,102,124,32,4,64,56,16,162,136,112,28,0,0,14,254,84,200,68
	.DB	0,130,56,16,16,0,16,0,8,138,128,146,150,254,138,146,18,146,82,0,0,130,40,40,18,130
	.DB	36,146,130,68,146,18,146,16,130,126,68,128,4,32,130,18,66,82,146,2,128,64,128,40
	.DB	16,138,130,32,254,4,128,8,168,136,136,144,168,2,168,8,128,122,136,128,8,8,136,40
	.DB	48,8,168,128,64,64,128,80,160,152,130,0,16,32,68

;********************************************************************************

GLCDCHARCOL7:
	cpi	SysStringA, 113
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableGLCDCHARCOL7<<1)
	ldi	SysReadA_H, high(TableGLCDCHARCOL7<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableGLCDCHARCOL7:
	.DB	112,16,0,10,6,136,34,56,62,8,32,16,16,128,128,64,4,0,0,0,40,36,196,160,0,0,0,40
	.DB	16,0,16,0,4,124,0,140,98,32,114,96,14,108,60,0,0,0,40,16,12,124,248,108,68,56
	.DB	130,2,244,254,0,2,130,128,254,254,124,12,188,140,100,2,126,62,126,198,14,134,0,64
	.DB	0,8,128,0,240,112,64,254,48,4,120,240,0,0,0,0,240,240,112,16,248,16,64,64,248,56
	.DB	120,136,120,136,0,0,0,16,120

;********************************************************************************

HSERGETSTRING:
;HSerIndex = 0
	ldi	SysValueCopy,0
	sts	HSERINDEX,SysValueCopy
;Do
SysDoLoop_S4:
;comport = comport 'not really required but added for clarity
;HSerReceive ( HSerInByte )
	rcall	HSERRECEIVE595
	lds	SysValueCopy,SERDATA
	sts	HSERINBYTE,SysValueCopy
;Enter key?
;If HSerInByte = 13 Then
	lds	SysCalcTempA,HSERINBYTE
	cpi	SysCalcTempA,13
	brne	ENDIF23
;Exit Sub
	ret
;End If
ENDIF23:
;letters,numbers,punctuation
;If HSerInByte >= 32 and HSerInByte <= 126 Then
	lds	SysBYTETempA,HSERINBYTE
	ldi	SysBYTETempB,32
	rcall	SysCompLessThan
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysBYTETempB,HSERINBYTE
	ldi	SysBYTETempA,126
	rcall	SysCompLessThan
	com	SysByteTempX
	mov	SysTemp3,SysByteTempX
	and	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	sbrs	SysTemp2,0
	rjmp	ENDIF24
;HSerIndex++
	lds	SysTemp1,HSERINDEX
	inc	SysTemp1
	sts	HSERINDEX,SysTemp1
;HSerString(HSerIndex) = HSerInByte
	lds	SysTemp1,SysHSERSTRINGHandler
	lds	SysTemp2,HSERINDEX
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	lds	SysTemp1,SysHSERSTRINGHandler_H
	ldi	SysTemp2,0
	adc	SysTemp1,SysTemp2
	mov	SysStringA_H,SysTemp1
	lds	SysValueCopy,HSERINBYTE
	st	X,SysValueCopy
;HSerString(0) = HSerIndex
	lds	SysStringA,SysHSERSTRINGHandler
	lds	SysStringA_H,SysHSERSTRINGHandler_H
	lds	SysValueCopy,HSERINDEX
	st	X,SysValueCopy
;End If
ENDIF24:
;Loop
	rjmp	SysDoLoop_S4
SysDoLoop_E4:
	ret

;********************************************************************************

;Overloaded signature: BYTE:
HSERRECEIVE595:
;Needs comport to be set first
;AVR USART 1 receive
;if comport = 1 Then
	lds	SysCalcTempA,COMPORT
	cpi	SysCalcTempA,1
	brne	ENDIF29
;SerData = DefaultUsartReturnValue
	ldi	SysValueCopy,255
	sts	SERDATA,SysValueCopy
;If set up to block, wait for data
;Wait Until USARTHasData
SysWaitLoop2:
	lds	SysBitTest,UCSR0A
	sbrs	SysBitTest,RXC0
	rjmp	SysWaitLoop2
;If USARTHasData Then
	lds	SysBitTest,UCSR0A
	sbrs	SysBitTest,RXC0
	rjmp	ENDIF30
;SerData = UDR0
	lds	SysValueCopy,UDR0
	sts	SERDATA,SysValueCopy
;End If
ENDIF30:
;End If
ENDIF29:
	ret

;********************************************************************************

INITSYS:
;Turn off all ports
;PORTB = 0
	ldi	SysValueCopy,0
	out	PORTB,SysValueCopy
;PORTC = 0
	ldi	SysValueCopy,0
	out	PORTC,SysValueCopy
;PORTD = 0
	ldi	SysValueCopy,0
	out	PORTD,SysValueCopy
	ret

;********************************************************************************

INITUSART:
;Set the default value for comport
;comport = 1
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
;Set baud rate
;U2X0 = U2X0_TEMP        'U2X0 ex: mega328P
	lds	SysValueCopy,UCSR0A
	sbr	SysValueCopy,1<<U2X0
	sts	UCSR0A,SysValueCopy
;UBRR0L = UBRRL_TEMP
	ldi	SysValueCopy,207
	sts	UBRR0L,SysValueCopy
;UBRR0H = UBRRH_TEMP
	ldi	SysValueCopy,0
	sts	UBRR0H,SysValueCopy
;Enable TX and RX
;RXEN0 = On
	lds	SysValueCopy,UCSR0B
	sbr	SysValueCopy,1<<RXEN0
	sts	UCSR0B,SysValueCopy
;TXEN0 = On
	sbr	SysValueCopy,1<<TXEN0
	sts	UCSR0B,SysValueCopy
	ret

;********************************************************************************

FN_LEN:
;Len = LENTemp(0)
	lds	SysStringA,SysLENTEMPHandler
	lds	SysStringA_H,SysLENTEMPHandler_H
	ld	SysValueCopy,X
	sts	LEN,SysValueCopy
	ret

;********************************************************************************

MAX7219_LEDMATRIX_BRIGHTNESS:
;if Max7219_Brightness_Value > 0x0f then Max7219_Brightness_Value = 0x0f
	ldi	SysCalcTempA,15
	lds	SysCalcTempB,MAX7219_BRIGHTNESS_VALUE
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF8
	ldi	SysValueCopy,15
	sts	MAX7219_BRIGHTNESS_VALUE,SysValueCopy
ENDIF8:
;repeat Max7219_Devices
	ldi	SysValueCopy,8
	sts	SYSREPEATTEMP3,SysValueCopy
	lds	SysCalcTempA,SYSREPEATTEMP3
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	SysRepeatLoopEnd3
SysRepeatLoop3:
;Max7219_sendByte( MAX7219_REG_INTENSITY , Max7219_Brightness_Value )
	ldi	SysValueCopy,10
	sts	_MAX7219_REG,SysValueCopy
	lds	SysValueCopy,MAX7219_BRIGHTNESS_VALUE
	sts	_MAX7219_DDATA,SysValueCopy
	rcall	MAX7219_SENDBYTE
;end Repeat
	lds	SysTemp1,SysRepeatTemp3
	dec	SysTemp1
	sts	SysRepeatTemp3,SysTemp1
	brne	SysRepeatLoop3
SysRepeatLoopEnd3:
	ret

;********************************************************************************

MAX7219_LEDMATRIX_CLEARBUFFER:
;For Max7219_CurrPixelX = 1 to Max7219_PixelBytes
	ldi	SysValueCopy,0
	sts	MAX7219_CURRPIXELX,SysValueCopy
SysForLoop5:
	lds	SysTemp1,MAX7219_CURRPIXELX
	inc	SysTemp1
	sts	MAX7219_CURRPIXELX,SysTemp1
;Max7219_Image_Buffer(Max7219_CurrPixelX) = 0
	ldi	SysTemp2,low(MAX7219_IMAGE_BUFFER)
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	ldi	SysTemp2,0
	ldi	SysTemp3,high(MAX7219_IMAGE_BUFFER)
	adc	SysTemp2,SysTemp3
	mov	SysStringA_H,SysTemp2
	ldi	SysValueCopy,0
	st	X,SysValueCopy
;Next
	lds	SysBYTETempA,MAX7219_CURRPIXELX
	ldi	SysBYTETempB,64
	rcall	SysCompLessThan
	sbrc	SysByteTempX,0
	rjmp	SysForLoop5
ENDIF13:
SysForLoopEnd5:
	ret

;********************************************************************************

MAX7219_LEDMATRIX_GLCDCLS:
;initialise global variable. Required variable for Circle - DO NOT DELETE
;GLCD_yordinate = 0
	ldi	SysValueCopy,0
	sts	GLCD_YORDINATE,SysValueCopy
	sts	GLCD_YORDINATE_H,SysValueCopy
;Dim Max7219_PixelCounter , Max7219_DeviceAddress as byte
;Max7219_DeviceAddress = 1
	ldi	SysValueCopy,1
	sts	MAX7219_DEVICEADDRESS,SysValueCopy
;For Max7219_PixelCounter = 1 to Max7219_PixelBytes
	ldi	SysValueCopy,0
	sts	MAX7219_PIXELCOUNTER,SysValueCopy
SysForLoop1:
	lds	SysTemp1,MAX7219_PIXELCOUNTER
	inc	SysTemp1
	sts	MAX7219_PIXELCOUNTER,SysTemp1
;MAX7219_Image_Buffer( Max7219_PixelCounter ) = 0
	ldi	SysTemp2,low(MAX7219_IMAGE_BUFFER)
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	ldi	SysTemp2,0
	ldi	SysTemp3,high(MAX7219_IMAGE_BUFFER)
	adc	SysTemp2,SysTemp3
	mov	SysStringA_H,SysTemp2
	ldi	SysValueCopy,0
	st	X,SysValueCopy
;Max7219_RowAddress = ( ( Max7219_PixelCounter mod 8 ) )
	lds	SysBYTETempA,MAX7219_PIXELCOUNTER
	ldi	SysBYTETempB,8
	rcall	SysDivSub
	sts	MAX7219_ROWADDRESS,SysBYTETempX
;Send a number of NOPS
;Repeat ( Max7219_Devices - Max7219_DeviceAddress )
	ldi	SysTemp2,8
	lds	SysTemp1,MAX7219_DEVICEADDRESS
	sub	SysTemp2,SysTemp1
	sts	SYSREPEATTEMP1,SysTemp2
	lds	SysCalcTempA,SYSREPEATTEMP1
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	SysRepeatLoopEnd1
SysRepeatLoop1:
;Max7219_sendByte(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
	ldi	SysValueCopy,0
	sts	_MAX7219_REG,SysValueCopy
	ldi	SysValueCopy,0
	sts	_MAX7219_DDATA,SysValueCopy
	rcall	MAX7219_SENDBYTE
;End Repeat
	lds	SysTemp1,SysRepeatTemp1
	dec	SysTemp1
	sts	SysRepeatTemp1,SysTemp1
	brne	SysRepeatLoop1
SysRepeatLoopEnd1:
;Send data to the specific Device and Row
;Max7219_sendByte( Max7219_RowAddress, GLCDBackground )
	lds	SysValueCopy,MAX7219_ROWADDRESS
	sts	_MAX7219_REG,SysValueCopy
	lds	SysValueCopy,GLCDBACKGROUND
	sts	_MAX7219_DDATA,SysValueCopy
	rcall	MAX7219_SENDBYTE
;Send a number of NOPS
;Repeat Max7219_DeviceAddress - 1
	lds	SysTemp1,MAX7219_DEVICEADDRESS
	dec	SysTemp1
	sts	SYSREPEATTEMP1,SysTemp1
	lds	SysCalcTempA,SYSREPEATTEMP1
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	SysRepeatLoopEnd2
SysRepeatLoop2:
;Max7219_sendByte(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
	ldi	SysValueCopy,0
	sts	_MAX7219_REG,SysValueCopy
	ldi	SysValueCopy,0
	sts	_MAX7219_DDATA,SysValueCopy
	rcall	MAX7219_SENDBYTE
;End Repeat
	lds	SysTemp1,SysRepeatTemp1
	dec	SysTemp1
	sts	SysRepeatTemp1,SysTemp1
	brne	SysRepeatLoop2
SysRepeatLoopEnd2:
;Increment the Device address
;If Max7219_RowAddress = 8 then
	lds	SysCalcTempA,MAX7219_ROWADDRESS
	cpi	SysCalcTempA,8
	brne	ENDIF3
;Max7219_DeviceAddress++
	lds	SysTemp1,MAX7219_DEVICEADDRESS
	inc	SysTemp1
	sts	MAX7219_DEVICEADDRESS,SysTemp1
;end if
ENDIF3:
;Next
	lds	SysBYTETempA,MAX7219_PIXELCOUNTER
	ldi	SysBYTETempB,64
	rcall	SysCompLessThan
	sbrc	SysByteTempX,0
	rjmp	SysForLoop1
ENDIF4:
SysForLoopEnd1:
	ret

;********************************************************************************

MAX7219_LEDMATRIX_GLCDDRAWCHAR:
;CharCode needs to have 16 subtracted, table starts at char 16 not char 0
;CharCode -= 15
	lds	SysTemp1,CHARCODE
	ldi	SysTemp2,15
	sub	SysTemp1,SysTemp2
	sts	CHARCODE,SysTemp1
;invert colors if required
;if LineColour <> GLCDForeground  then
	lds	SysWORDTempA,LINECOLOUR
	lds	SysWORDTempA_H,LINECOLOUR_H
	lds	SysWORDTempB,GLCDFOREGROUND
	lds	SysWORDTempB_H,GLCDFOREGROUND_H
	rcall	SysCompEqual16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF17
;Inverted Colours
;GLCDBackground = 1
	ldi	SysValueCopy,1
	sts	GLCDBACKGROUND,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDBACKGROUND_H,SysValueCopy
;GLCDForeground = 0
	ldi	SysValueCopy,0
	sts	GLCDFOREGROUND,SysValueCopy
	sts	GLCDFOREGROUND_H,SysValueCopy
;end if
ENDIF17:
;Need to read characters from CharColn (n = 0:7) tables
;(First 3, ie 0:2 are blank, so can ignore)
;For CurrCharCol = 1 to 5
	ldi	SysValueCopy,0
	sts	CURRCHARCOL,SysValueCopy
SysForLoop7:
	lds	SysTemp1,CURRCHARCOL
	inc	SysTemp1
	sts	CURRCHARCOL,SysTemp1
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
SysSelect1Case1:
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,1
	brne	SysSelect1Case2
	lds	SYSSTRINGA,CHARCODE
	rcall	GLCDCHARCOL3
	sts	CURRCHARVAL,SysByteTempX
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	rjmp	SysSelectEnd1
SysSelect1Case2:
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,2
	brne	SysSelect1Case3
	lds	SYSSTRINGA,CHARCODE
	rcall	GLCDCHARCOL4
	sts	CURRCHARVAL,SysByteTempX
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	rjmp	SysSelectEnd1
SysSelect1Case3:
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,3
	brne	SysSelect1Case4
	lds	SYSSTRINGA,CHARCODE
	rcall	GLCDCHARCOL5
	sts	CURRCHARVAL,SysByteTempX
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	rjmp	SysSelectEnd1
SysSelect1Case4:
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,4
	brne	SysSelect1Case5
	lds	SYSSTRINGA,CHARCODE
	rcall	GLCDCHARCOL6
	sts	CURRCHARVAL,SysByteTempX
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	rjmp	SysSelectEnd1
SysSelect1Case5:
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,5
	brne	SysSelectEnd1
	lds	SYSSTRINGA,CHARCODE
	rcall	GLCDCHARCOL7
	sts	CURRCHARVAL,SysByteTempX
;End Select
SysSelectEnd1:
;For CurrCharRow = 0 to 7
	ldi	SysValueCopy,255
	sts	CURRCHARROW,SysValueCopy
SysForLoop8:
	lds	SysTemp1,CURRCHARROW
	inc	SysTemp1
	sts	CURRCHARROW,SysTemp1
;If CurrCharVal.0 = 0 Then
	lds	SysBitTest,CURRCHARVAL
	sbrc	SysBitTest,0
	rjmp	ELSE18_1
;PSet CharLocX + CurrCharCol-1, CharLocY + CurrCharRow, GLCDBackground
	lds	SysTemp2,CHARLOCX
	lds	SysTemp3,CURRCHARCOL
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,CHARLOCX_H
	ldi	SysTemp3,0
	adc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	ldi	SysTemp2,1
	sub	SysTemp1,SysTemp2
	sts	MAX7219_LOCX,SysTemp1
	ldi	SysTemp2,0
	sbc	SysTemp1_H,SysTemp2
	sts	MAX7219_LOCX_H,SysTemp1_H
	lds	SysTemp1,CHARLOCY
	lds	SysTemp2,CURRCHARROW
	add	SysTemp1,SysTemp2
	sts	MAX7219_LOCY,SysTemp1
	lds	SysTemp1,CHARLOCY_H
	ldi	SysTemp2,0
	adc	SysTemp1,SysTemp2
	sts	MAX7219_LOCY_H,SysTemp1
	lds	SysValueCopy,GLCDBACKGROUND
	sts	PIXELCOL,SysValueCopy
	rcall	MAX7219_LEDMATRIX_PSET_0
	lds	SysValueCopy,PIXELCOL
	sts	GLCDBACKGROUND,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDBACKGROUND_H,SysValueCopy
;Else
	rjmp	ENDIF18
ELSE18_1:
;PSet CharLocX + CurrCharCol-1, CharLocY + CurrCharRow, GLCDForeground
	lds	SysTemp2,CHARLOCX
	lds	SysTemp3,CURRCHARCOL
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,CHARLOCX_H
	ldi	SysTemp3,0
	adc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	ldi	SysTemp2,1
	sub	SysTemp1,SysTemp2
	sts	MAX7219_LOCX,SysTemp1
	ldi	SysTemp2,0
	sbc	SysTemp1_H,SysTemp2
	sts	MAX7219_LOCX_H,SysTemp1_H
	lds	SysTemp1,CHARLOCY
	lds	SysTemp2,CURRCHARROW
	add	SysTemp1,SysTemp2
	sts	MAX7219_LOCY,SysTemp1
	lds	SysTemp1,CHARLOCY_H
	ldi	SysTemp2,0
	adc	SysTemp1,SysTemp2
	sts	MAX7219_LOCY_H,SysTemp1
	lds	SysValueCopy,GLCDFOREGROUND
	sts	PIXELCOL,SysValueCopy
	rcall	MAX7219_LEDMATRIX_PSET_0
	lds	SysValueCopy,PIXELCOL
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDFOREGROUND_H,SysValueCopy
;End If
ENDIF18:
;Rotate CurrCharVal Right
	lds	SysValueCopy,CURRCHARVAL
	ror	SysValueCopy
	sts	CURRCHARVAL,SysValueCopy
;Next
	lds	SysCalcTempA,CURRCHARROW
	cpi	SysCalcTempA,7
	brsh	ENDIF19
	rjmp	SysForLoop8
ENDIF19:
SysForLoopEnd8:
;Next
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,5
	brsh	ENDIF20
	rjmp	SysForLoop7
ENDIF20:
SysForLoopEnd7:
;Restore
;GLCDBackground = 0
	ldi	SysValueCopy,0
	sts	GLCDBACKGROUND,SysValueCopy
	sts	GLCDBACKGROUND_H,SysValueCopy
;GLCDForeground = 1
	ldi	SysValueCopy,1
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDFOREGROUND_H,SysValueCopy
	ret

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:
MAX7219_LEDMATRIX_GLCDPRINT16:
;Dim GLCDPrintLoc as word
;PrintLen = LCDPrintData(0)
	lds	SysStringA,SysLCDPRINTDATAHandler
	lds	SysStringA_H,SysLCDPRINTDATAHandler_H
	ld	SysValueCopy,X
	sts	PRINTLEN,SysValueCopy
;If PrintLen = 0 Then Exit Sub
	lds	SysCalcTempA,PRINTLEN
	tst	SysCalcTempA
	brne	ENDIF14
	ret
ENDIF14:
;GLCDPrintLoc = PrintLocX
	lds	SysValueCopy,PRINTLOCX
	sts	GLCDPRINTLOC,SysValueCopy
	lds	SysValueCopy,PRINTLOCX_H
	sts	GLCDPRINTLOC_H,SysValueCopy
;Write Data
;For SysPrintTemp = 1 To PrintLen
	ldi	SysValueCopy,0
	sts	SYSPRINTTEMP,SysValueCopy
	lds	SysCalcTempA,PRINTLEN
	cpi	SysCalcTempA,1
	brsh	ENDIF15
	rjmp	SysForLoopEnd6
ENDIF15:
SysForLoop6:
	lds	SysTemp1,SYSPRINTTEMP
	inc	SysTemp1
	sts	SYSPRINTTEMP,SysTemp1
;GLCDDrawChar GLCDPrintLoc, PrintLocY, LCDPrintData(SysPrintTemp)
	lds	SysValueCopy,GLCDPRINTLOC
	sts	CHARLOCX,SysValueCopy
	lds	SysValueCopy,GLCDPRINTLOC_H
	sts	CHARLOCX_H,SysValueCopy
	lds	SysValueCopy,PRINTLOCY
	sts	CHARLOCY,SysValueCopy
	lds	SysValueCopy,PRINTLOCY_H
	sts	CHARLOCY_H,SysValueCopy
	lds	SysTemp1,SysLCDPRINTDATAHandler
	lds	SysTemp2,SYSPRINTTEMP
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	lds	SysTemp1,SysLCDPRINTDATAHandler_H
	ldi	SysTemp2,0
	adc	SysTemp1,SysTemp2
	mov	SysStringA_H,SysTemp1
	ld	SysValueCopy,X
	sts	CHARCODE,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	MAX7219_LEDMATRIX_GLCDDRAWCHAR
;GLCDPrintLoc += GLCDFontWidth
	lds	SysTemp1,GLCDPRINTLOC
	lds	SysTemp2,GLCDFONTWIDTH
	add	SysTemp1,SysTemp2
	sts	GLCDPRINTLOC,SysTemp1
	lds	SysTemp1,GLCDPRINTLOC_H
	ldi	SysTemp2,0
	adc	SysTemp1,SysTemp2
	sts	GLCDPRINTLOC_H,SysTemp1
;Next
	lds	SysCalcTempA,SYSPRINTTEMP
	lds	SysCalcTempB,PRINTLEN
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF16
	rjmp	SysForLoop6
ENDIF16:
SysForLoopEnd6:
	ret

;********************************************************************************

MAX7219_LEDMATRIX_INIT:
;GLCDBackground = 0
	ldi	SysValueCopy,0
	sts	GLCDBACKGROUND,SysValueCopy
	sts	GLCDBACKGROUND_H,SysValueCopy
;GLCDForeground = 1
	ldi	SysValueCopy,1
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDFOREGROUND_H,SysValueCopy
;Dir Max7219_DO  Out
	sbi	DDRB,3
;Dir Max7219_SCK Out
	sbi	DDRB,5
;Dir Max7219_CS  out
	sbi	DDRB,2
;wait 100 ms
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;SPIMode HWSPIMODESCRIPT, SPI_CPOL_0 + SPI_CPHA_0
	ldi	SysValueCopy,11
	sts	SPICURRENTMODE,SysValueCopy
	ldi	SysValueCopy,0
	sts	SPICLOCKMODE,SysValueCopy
	rcall	SPIMODE554
;Set Max7219_DO  off
	cbi	PORTB,3
;wait 100 ms
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;initialise
;Max7219_sendByte(MAX7219_REG_SCANLIMIT, 0x07)'Scan limit = 7
	ldi	SysValueCopy,11
	sts	_MAX7219_REG,SysValueCopy
	ldi	SysValueCopy,7
	sts	_MAX7219_DDATA,SysValueCopy
	rcall	MAX7219_SENDBYTE
;Max7219_sendByte(MAX7219_REG_DECODEMODE, 0x00)'Decoding off
	ldi	SysValueCopy,9
	sts	_MAX7219_REG,SysValueCopy
	ldi	SysValueCopy,0
	sts	_MAX7219_DDATA,SysValueCopy
	rcall	MAX7219_SENDBYTE
;Max7219_sendByte(MAX7219_REG_SHUTDOWN, 0x01)'Normal operation mode
	ldi	SysValueCopy,12
	sts	_MAX7219_REG,SysValueCopy
	ldi	SysValueCopy,1
	sts	_MAX7219_DDATA,SysValueCopy
	rcall	MAX7219_SENDBYTE
;Max7219_sendByte(MAX7219_REG_DISPLAYTEST, 0x00)
	ldi	SysValueCopy,15
	sts	_MAX7219_REG,SysValueCopy
	ldi	SysValueCopy,0
	sts	_MAX7219_DDATA,SysValueCopy
	rcall	MAX7219_SENDBYTE
;Max7219_sendByte(MAX7219_REG_INTENSITY, 0x00)'Brightness to minimum
	ldi	SysValueCopy,10
	sts	_MAX7219_REG,SysValueCopy
	ldi	SysValueCopy,0
	sts	_MAX7219_DDATA,SysValueCopy
	rcall	MAX7219_SENDBYTE
;wait Max7219_PowerOnTestWait_ms ms
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Max7219_CS = 1
	sbi	PORTB,2
;wait Max7219_PowerOnTestWait_ms ms
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Max7219_CS = 0
	cbi	PORTB,2
;wait Max7219_PowerOnTestWait_ms ms
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Max7219_CS = 1
	sbi	PORTB,2
;wait Max7219_PowerOnTestWait_ms ms
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;GLCDFontWidth = 6
	ldi	SysValueCopy,6
	sts	GLCDFONTWIDTH,SysValueCopy
;GLCDCLS
	rjmp	MAX7219_LEDMATRIX_GLCDCLS

;********************************************************************************

MAX7219_LEDMATRIX_PSET_0:
;Protect the buffer - by extreme X Y locations
;if max7219_LocX > ( MAX7219_X_Devices * 8 ) - 1  then Exit sub
	lds	SysWORDTempB,MAX7219_LOCX
	lds	SysWORDTempB_H,MAX7219_LOCX_H
	ldi	SysWORDTempA,63
	ldi	SysWORDTempA_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	ret
ENDIF25:
;elementbit =  max7219_LocY / 8
	lds	SysWORDTempA,MAX7219_LOCY
	lds	SysWORDTempA_H,MAX7219_LOCY_H
	ldi	SysWORDTempB,8
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	sts	ELEMENTBIT,SysWORDTempA
;if elementbit >  MAX7219_Y_Devices - 1 then Exit Sub
	lds	SysBYTETempB,ELEMENTBIT
	ldi	SysBYTETempA,0
	rcall	SysCompLessThan
	sbrc	SysByteTempX,0
	ret
ENDIF26:
;elementbit = max7219_LocX mod 8
	lds	SysWORDTempA,MAX7219_LOCX
	lds	SysWORDTempA_H,MAX7219_LOCX_H
	ldi	SysWORDTempB,8
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	sts	ELEMENTBIT,SysWORDTempX
;element = ( ( max7219_LocX / 8 ) * 8 ) + (8-max7219_LocY)
	lds	SysWORDTempA,MAX7219_LOCX
	lds	SysWORDTempA_H,MAX7219_LOCX_H
	ldi	SysWORDTempB,8
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	mov	SysTemp1,SysWORDTempA
	mov	SysTemp1_H,SysWORDTempA_H
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	ldi	SysWORDTempB,8
	ldi	SysWORDTempB_H,0
	rcall	SysMultSub16
	mov	SysTemp2,SysWORDTempX
	mov	SysTemp2_H,SysWORDTempX_H
	ldi	SysTemp3,8
	lds	SysTemp4,MAX7219_LOCY
	sub	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	ldi	SysTemp3,0
	lds	SysTemp4,MAX7219_LOCY_H
	sbc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	add	SysTemp2,SysTemp1
	sts	ELEMENT,SysTemp2
;Max7219_Image_Buffer( element ) = Max7219_Image_Buffer( element ) OR FnLSL( PixelCol, elementbit )
	lds	SYSBYTETEMPB,PIXELCOL
	lds	SysValueCopy,ELEMENTBIT
	sts	NUMBITS,SysValueCopy
	rcall	FN_FNLSL430
	lds	SysTemp4,ELEMENT
	ldi	SysTemp3,low(MAX7219_IMAGE_BUFFER)
	add	SysTemp4,SysTemp3
	mov	SysStringA,SysTemp4
	ldi	SysTemp3,0
	ldi	SysTemp2,high(MAX7219_IMAGE_BUFFER)
	adc	SysTemp3,SysTemp2
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X+
	sts	SysArrayTemp2,SysValueCopy
	lds	SysTemp4,SysArrayTemp2
	lds	SysTemp1,SYSFNLSLBYTE
	or	SysTemp1,SysTemp4
	sts	SysArrayTemp1,SysTemp1
	lds	SysTemp4,ELEMENT
	ldi	SysTemp3,low(MAX7219_IMAGE_BUFFER)
	add	SysTemp4,SysTemp3
	mov	SysStringA,SysTemp4
	ldi	SysTemp3,0
	ldi	SysTemp2,high(MAX7219_IMAGE_BUFFER)
	adc	SysTemp3,SysTemp2
	mov	SysStringA_H,SysTemp3
	lds	SysValueCopy,SysArrayTemp1
	st	X+,SysValueCopy
	ret

;********************************************************************************

MAX7219_LEDMATRIX_SCROLLMESSAGE:
;dim max7219_ScrollLen, max7219_ScrollPosition, max7219_XScrollPosition as word
;max7219_ScrollLen = OutMessage(0) * GLCDFontWidth
	lds	SysStringA,SysOUTMESSAGEHandler
	lds	SysStringA_H,SysOUTMESSAGEHandler_H
	ld	SysWORDTempA,X
	ldi	SysWORDTempA_H,0
	lds	SysWORDTempB,GLCDFONTWIDTH
	ldi	SysWORDTempB_H,0
	rcall	SysMultSub16
	sts	MAX7219_SCROLLLEN,SysWORDTempX
	sts	MAX7219_SCROLLLEN_H,SysWORDTempX_H
;max7219_XScrollPosition = Max7219_PixelBytes-1
	ldi	SysValueCopy,63
	sts	MAX7219_XSCROLLPOSITION,SysValueCopy
	ldi	SysValueCopy,0
	sts	MAX7219_XSCROLLPOSITION_H,SysValueCopy
;For max7219_ScrollPosition = 0 to max7219_ScrollLen-1
	ldi	SysValueCopy,255
	sts	MAX7219_SCROLLPOSITION,SysValueCopy
	sts	MAX7219_SCROLLPOSITION_H,SysValueCopy
	lds	SysTemp2,MAX7219_SCROLLLEN
	ldi	SysTemp3,1
	sub	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,MAX7219_SCROLLLEN_H
	ldi	SysTemp3,0
	sbc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	ldi	SysWORDTempB,0
	ldi	SysWORDTempB_H,0
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoopEnd2
ENDIF5:
SysForLoop2:
	lds	SysTemp1,MAX7219_SCROLLPOSITION
	inc	SysTemp1
	sts	MAX7219_SCROLLPOSITION,SysTemp1
	lds	SysTemp1,MAX7219_SCROLLPOSITION_H
	brne	PC + 2
	inc	SysTemp1
	sts	MAX7219_SCROLLPOSITION_H,SysTemp1
;Max7219_LEDMatrix_ClearBuffer ( Max7219_Image_Buffer() ,Max7219_PixelBytes)
	rcall	MAX7219_LEDMATRIX_CLEARBUFFER
;GLCDPrint(max7219_XScrollPosition, 0,  OutMessage)
	lds	SysValueCopy,MAX7219_XSCROLLPOSITION
	sts	PRINTLOCX,SysValueCopy
	lds	SysValueCopy,MAX7219_XSCROLLPOSITION_H
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,SysOUTMESSAGEHandler
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	lds	SysValueCopy,SysOUTMESSAGEHandler_H
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	rcall	MAX7219_LEDMATRIX_GLCDPRINT16
;max7219_XScrollPosition--
	lds	SysTemp1,MAX7219_XSCROLLPOSITION
	ldi	SysTemp2,1
	sub	SysTemp1,SysTemp2
	sts	MAX7219_XSCROLLPOSITION,SysTemp1
	lds	SysTemp1,MAX7219_XSCROLLPOSITION_H
	ldi	SysTemp2,0
	sbc	SysTemp1,SysTemp2
	sts	MAX7219_XSCROLLPOSITION_H,SysTemp1
;Max7219_LEDMatrix_SendBuffer ( Max7219_Image_Buffer() ,Max7219_PixelBytes)
	rcall	MAX7219_LEDMATRIX_SENDBUFFER
;if max7219_MessageTime > 0 then
	lds	SysWORDTempB,MAX7219_MESSAGETIME
	lds	SysWORDTempB_H,MAX7219_MESSAGETIME_H
	ldi	SysWORDTempA,0
	ldi	SysWORDTempA_H,0
	rcall	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF6
;Wait max7219_MessageTime ms
	lds	SysWaitTempMS,MAX7219_MESSAGETIME
	lds	SysWaitTempMS_H,MAX7219_MESSAGETIME_H
	rcall	Delay_MS
;end if
ENDIF6:
;Next
	lds	SysTemp2,MAX7219_SCROLLLEN
	ldi	SysTemp3,1
	sub	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,MAX7219_SCROLLLEN_H
	ldi	SysTemp3,0
	sbc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	lds	SysWORDTempA,MAX7219_SCROLLPOSITION
	lds	SysWORDTempA_H,MAX7219_SCROLLPOSITION_H
	mov	SysWORDTempB,SysTemp1
	mov	SysWORDTempB_H,SysTemp1_H
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop2
ENDIF7:
SysForLoopEnd2:
	ret

;********************************************************************************

MAX7219_LEDMATRIX_SENDBUFFER:
;Dim Max7219_ByteValue, Max7219_PixelCounter As Byte
;Max7219_PixelCounter = 1
	ldi	SysValueCopy,1
	sts	MAX7219_PIXELCOUNTER,SysValueCopy
;Max7219_CS = 1
	sbi	PORTB,2
;For Max7219_CurrentMatrix = 1 to Max7219_Devices
	ldi	SysValueCopy,0
	sts	MAX7219_CURRENTMATRIX,SysValueCopy
SysForLoop3:
	lds	SysTemp1,MAX7219_CURRENTMATRIX
	inc	SysTemp1
	sts	MAX7219_CURRENTMATRIX,SysTemp1
;For CurrPixelY = 1 to 8
	ldi	SysValueCopy,0
	sts	CURRPIXELY,SysValueCopy
SysForLoop4:
	lds	SysTemp1,CURRPIXELY
	inc	SysTemp1
	sts	CURRPIXELY,SysTemp1
;Max7219_CS = 0
	cbi	PORTB,2
;Send a number of NOPS
;Repeat ( Max7219_Devices - Max7219_CurrentMatrix )
	ldi	SysTemp2,8
	lds	SysTemp1,MAX7219_CURRENTMATRIX
	sub	SysTemp2,SysTemp1
	sts	SYSREPEATTEMP4,SysTemp2
	lds	SysCalcTempA,SYSREPEATTEMP4
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	SysRepeatLoopEnd4
SysRepeatLoop4:
;Max7219_SendByteStream(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
	ldi	SysValueCopy,0
	sts	_MAX7219_REG,SysValueCopy
	ldi	SysValueCopy,0
	sts	_MAX7219_DDATA,SysValueCopy
	rcall	MAX7219_SENDBYTESTREAM
;End Repeat
	lds	SysTemp1,SysRepeatTemp4
	dec	SysTemp1
	sts	SysRepeatTemp4,SysTemp1
	brne	SysRepeatLoop4
SysRepeatLoopEnd4:
;Send data to the specific Device and Row
;Max7219_SendByteStream( CurrPixelY, Max7219_Image_Buffer ( Max7219_PixelCounter) )
	lds	SysValueCopy,CURRPIXELY
	sts	_MAX7219_REG,SysValueCopy
	lds	SysTemp1,MAX7219_PIXELCOUNTER
	ldi	SysTemp2,low(MAX7219_IMAGE_BUFFER)
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	ldi	SysTemp2,0
	ldi	SysTemp3,high(MAX7219_IMAGE_BUFFER)
	adc	SysTemp2,SysTemp3
	mov	SysStringA_H,SysTemp2
	ld	SysValueCopy,X
	sts	_MAX7219_DDATA,SysValueCopy
	rcall	MAX7219_SENDBYTESTREAM
;Send a number of NOPS
;Repeat Max7219_CurrentMatrix - 1
	lds	SysTemp1,MAX7219_CURRENTMATRIX
	dec	SysTemp1
	sts	SYSREPEATTEMP4,SysTemp1
	lds	SysCalcTempA,SYSREPEATTEMP4
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	SysRepeatLoopEnd5
SysRepeatLoop5:
;Max7219_SendByteStream(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
	ldi	SysValueCopy,0
	sts	_MAX7219_REG,SysValueCopy
	ldi	SysValueCopy,0
	sts	_MAX7219_DDATA,SysValueCopy
	rcall	MAX7219_SENDBYTESTREAM
;End Repeat
	lds	SysTemp1,SysRepeatTemp4
	dec	SysTemp1
	sts	SysRepeatTemp4,SysTemp1
	brne	SysRepeatLoop5
SysRepeatLoopEnd5:
;Max7219_PixelCounter++
	lds	SysTemp1,MAX7219_PIXELCOUNTER
	inc	SysTemp1
	sts	MAX7219_PIXELCOUNTER,SysTemp1
;Max7219_CS = 1
	sbi	PORTB,2
;Next
	lds	SysCalcTempA,CURRPIXELY
	cpi	SysCalcTempA,8
	brsh	ENDIF10
	rjmp	SysForLoop4
ENDIF10:
SysForLoopEnd4:
;Next
	lds	SysBYTETempA,MAX7219_CURRENTMATRIX
	ldi	SysBYTETempB,8
	rcall	SysCompLessThan
	sbrc	SysByteTempX,0
	rjmp	SysForLoop3
ENDIF11:
SysForLoopEnd3:
	ret

;********************************************************************************

MAX7219_SENDBYTE:
;Max7219_CS = 0
	cbi	PORTB,2
;FastHWSPITransfer  _MAX7219_reg
	lds	SysValueCopy,_MAX7219_REG
	sts	SPITXDATA,SysValueCopy
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer  _MAX7219_ddata
	lds	SysValueCopy,_MAX7219_DDATA
	sts	SPITXDATA,SysValueCopy
	rcall	FASTHWSPITRANSFER
;Max7219_CS = 1
	sbi	PORTB,2
	ret

;********************************************************************************

MAX7219_SENDBYTESTREAM:
;FastHWSPITransfer  _MAX7219_reg
	lds	SysValueCopy,_MAX7219_REG
	sts	SPITXDATA,SysValueCopy
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer  _MAX7219_ddata
	lds	SysValueCopy,_MAX7219_DDATA
	sts	SPITXDATA,SysValueCopy
	rjmp	FASTHWSPITRANSFER

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SPIMODE554:
;Turn off SPI
;(Prevents any weird glitches during setup)
;Set SPCR.SPE Off
	in	SysValueCopy,SPCR
	cbr	SysValueCopy,1<<SPE
	out	SPCR,SysValueCopy
;Set clock pulse settings
;Set SPCR.CPHA Off
	in	SysValueCopy,SPCR
	cbr	SysValueCopy,1<<CPHA
	out	SPCR,SysValueCopy
;If SPIClockMode.0 = On Then
	lds	SysBitTest,SPICLOCKMODE
	sbrs	SysBitTest,0
	rjmp	ENDIF21
;Set SPCR.CPHA On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<CPHA
	out	SPCR,SysValueCopy
;End If
ENDIF21:
;Set SPCR.CPOL Off
	in	SysValueCopy,SPCR
	cbr	SysValueCopy,1<<CPOL
	out	SPCR,SysValueCopy
;If SPIClockMode.1 = On Then
	lds	SysBitTest,SPICLOCKMODE
	sbrs	SysBitTest,1
	rjmp	ENDIF22
;Set SPCR.CPOL On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<CPOL
	out	SPCR,SysValueCopy
;End If
ENDIF22:
;Select mode and clock
;Set some mode bits off, can set on later
;Set SPCR.MSTR Off
	in	SysValueCopy,SPCR
	cbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Set SPSR.SPI2X Off
	in	SysValueCopy,SPSR
	cbr	SysValueCopy,1<<SPI2X
	out	SPSR,SysValueCopy
;Set SPCR.SPR0 Off
	in	SysValueCopy,SPCR
	cbr	SysValueCopy,1<<SPR0
	out	SPCR,SysValueCopy
;Set SPCR.SPR1 Off
	in	SysValueCopy,SPCR
	cbr	SysValueCopy,1<<SPR1
	out	SPCR,SysValueCopy
;Select Case SPICurrentMode
;Case MasterUltraFast
SysSelect2Case1:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,14
	brne	SysSelect2Case2
;Set SPCR.MSTR On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Set SPSR.SPI2X On
	in	SysValueCopy,SPSR
	sbr	SysValueCopy,1<<SPI2X
	out	SPSR,SysValueCopy
;Case MasterFast
	rjmp	SysSelectEnd2
SysSelect2Case2:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,13
	brne	SysSelect2Case3
;Set SPCR.MSTR On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Case Master
	rjmp	SysSelectEnd2
SysSelect2Case3:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,12
	brne	SysSelect2Case4
;Set SPCR.MSTR On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Set SPCR.SPR0 On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<SPR0
	out	SPCR,SysValueCopy
;Case MasterSlow
	rjmp	SysSelectEnd2
SysSelect2Case4:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,11
	brne	SysSelectEnd2
;Set SPCR.MSTR On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Set SPCR.SPR1 On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<SPR1
	out	SPCR,SysValueCopy
;Nothing needed for slave
;Case Slave
;Case SlaveSS
;End Select
SysSelectEnd2:
;Enable SPI
;Set SPCR.SPE On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<SPE
	out	SPCR,SysValueCopy
	ret

;********************************************************************************

SYSCOMPEQUAL16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clr SysByteTempX
	clr	SYSBYTETEMPX
;cp SysWordTempA, SysWordTempB
	cp	SYSWORDTEMPA, SYSWORDTEMPB
;brne SCE16False
	brne	SCE16FALSE
;cp SysWordTempA_H, SysWordTempB_H
	cp	SYSWORDTEMPA_H, SYSWORDTEMPB_H
;brne SCE16False
	brne	SCE16FALSE
;com SysByteTempX
	com	SYSBYTETEMPX
SCE16FALSE:
	ret

;********************************************************************************

SYSCOMPLESSTHAN:
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clr SysByteTempX
	clr	SYSBYTETEMPX
;cp SysByteTempA,SysByteTempB
	cp	SYSBYTETEMPA,SYSBYTETEMPB
;brlo SCLTTrue
	brlo	SCLTTRUE
;ret
	ret
SCLTTRUE:
;com SysByteTempX
	com	SYSBYTETEMPX
	ret

;********************************************************************************

SYSCOMPLESSTHAN16:
;clr SysByteTempX
	clr	SYSBYTETEMPX
;Test High, exit false if more
;cp SysWordTempB_H,SysWordTempA_H
	cp	SYSWORDTEMPB_H,SYSWORDTEMPA_H
;brlo SCLT16False
	brlo	SCLT16FALSE
;Test high, exit true if less
;cp SysWordTempA_H,SysWordTempB_H
	cp	SYSWORDTEMPA_H,SYSWORDTEMPB_H
;brlo SCLT16True
	brlo	SCLT16TRUE
;Test Low, exit if more or equal
;cp SysWordTempA,SysWordTempB
	cp	SYSWORDTEMPA,SYSWORDTEMPB
;brlo SCLT16True
	brlo	SCLT16TRUE
;ret
	ret
SCLT16TRUE:
;com SysByteTempX
	com	SYSBYTETEMPX
SCLT16FALSE:
	ret

;********************************************************************************

SYSCOPYSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;SysStringA (X) stores source
;SysStringB (Y) stores destination
;SysStringLength is counter, keeps track of size of destination string
;SysCalcTempA is loop counter
;Dim SysReadA As Byte
;Get and copy length
;ld SysCalcTempA, X+
	ld	SYSCALCTEMPA, X+
;st Y+, SysCalcTempA
	st	Y+, SYSCALCTEMPA
;rjmp SysCopyStringCheck
	rjmp	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART:
;ld SysCalcTempA, X+
	ld	SYSCALCTEMPA, X+
;add SysStringLength, SysCalcTempA
	add	SYSSTRINGLENGTH, SYSCALCTEMPA
SYSCOPYSTRINGCHECK:
;Exit if length = 0
;cpi SysCalcTempA,0
	cpi	SYSCALCTEMPA,0
;brne SysStringCopy
	brne	SYSSTRINGCOPY
;ret
	ret
SYSSTRINGCOPY:
;Copy character
;ld SysReadA, X+
	ld	SYSREADA, X+
;st Y+, SysReadA
	st	Y+, SYSREADA
;dec SysCalcTempA
	dec	SYSCALCTEMPA
;brne SysStringCopy
	brne	SYSSTRINGCOPY
	ret

;********************************************************************************

SYSDIVSUB:
;Check for div/0
;tst SysByteTempB
	tst	SYSBYTETEMPB
;brne DIV8Cont
	brne	DIV8CONT
;ret
	ret
DIV8CONT:
;Main calc routine
;clr SysByteTempX
	clr	SYSBYTETEMPX
;SysDivLoop = 8
	ldi	SysValueCopy,8
	mov	SYSDIVLOOP,SysValueCopy
SYSDIV8START:
;lsl SysByteTempA
	lsl	SYSBYTETEMPA
;rol SysByteTempX
	rol	SYSBYTETEMPX
;asm sub SysByteTempX,SysByteTempB 'asm needed, or else sub will be used as start of sub
	sub	SYSBYTETEMPX,SYSBYTETEMPB
;sbr SysByteTempA,1
	sbr	SYSBYTETEMPA,1
;brsh Div8NotNeg
	brsh	DIV8NOTNEG
;cbr SysByteTempA,1
	cbr	SYSBYTETEMPA,1
;add SysByteTempX,SysByteTempB
	add	SYSBYTETEMPX,SYSBYTETEMPB
DIV8NOTNEG:
;dec SysDivLoop
	dec	SYSDIVLOOP
;brne SysDiv8Start
	brne	SYSDIV8START
	ret

;********************************************************************************

SYSDIVSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	mov	SYSDIVMULTA,SYSWORDTEMPA
	mov	SYSDIVMULTA_H,SYSWORDTEMPA_H
;SysDivMultB = SysWordTempB
	mov	SYSDIVMULTB,SYSWORDTEMPB
	mov	SYSDIVMULTB_H,SYSWORDTEMPB_H
;SysDivMultX = 0
	ldi	SysValueCopy,0
	mov	SYSDIVMULTX,SysValueCopy
	ldi	SysValueCopy,0
	mov	SYSDIVMULTX_H,SysValueCopy
;Avoid division by zero
;if SysDivMultB = 0 then
	mov	SysWORDTempA,SYSDIVMULTB
	mov	SysWORDTempA_H,SYSDIVMULTB_H
	ldi	SysWORDTempB,0
	ldi	SysWORDTempB_H,0
	rcall	SysCompEqual16
	sbrs	SysByteTempX,0
	rjmp	ENDIF27
;SysWordTempA = 0
	ldi	SYSWORDTEMPA,0
	ldi	SYSWORDTEMPA_H,0
;exit sub
	ret
;end if
ENDIF27:
;Main calc routine
;SysDivLoop = 16
	ldi	SysValueCopy,16
	mov	SYSDIVLOOP,SysValueCopy
SYSDIV16START:
;set C off
	clc
;Rotate SysDivMultA Left
	rol	SYSDIVMULTA
	rol	SYSDIVMULTA_H
;Rotate SysDivMultX Left
	rol	SYSDIVMULTX
	rol	SYSDIVMULTX_H
;SysDivMultX = SysDivMultX - SysDivMultB
	mov	SysTemp4,SYSDIVMULTX
	sub	SysTemp4,SYSDIVMULTB
	mov	SYSDIVMULTX,SysTemp4
	mov	SysTemp4,SYSDIVMULTX_H
	sbc	SysTemp4,SYSDIVMULTB_H
	mov	SYSDIVMULTX_H,SysTemp4
;Set SysDivMultA.0 On
	sbr	 SYSDIVMULTA,1<<0
;If C On Then
	brbc	C,ENDIF28
;Set SysDivMultA.0 Off
	cbr	 SYSDIVMULTA,1<<0
;SysDivMultX = SysDivMultX + SysDivMultB
	mov	SysTemp4,SYSDIVMULTX
	add	SysTemp4,SYSDIVMULTB
	mov	SYSDIVMULTX,SysTemp4
	mov	SysTemp4,SYSDIVMULTX_H
	adc	SysTemp4,SYSDIVMULTB_H
	mov	SYSDIVMULTX_H,SysTemp4
;End If
ENDIF28:
;dec SysDivLoop
	dec	SYSDIVLOOP
;brne SysDiv16Start
	brne	SYSDIV16START
;SysWordTempA = SysDivMultA
	mov	SYSWORDTEMPA,SYSDIVMULTA
	mov	SYSWORDTEMPA_H,SYSDIVMULTA_H
;SysWordTempX = SysDivMultX
	mov	SYSWORDTEMPX,SYSDIVMULTX
	mov	SYSWORDTEMPX_H,SYSDIVMULTX_H
	ret

;********************************************************************************

SYSMULTSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;Need to keep result in here because SysWordTempX[_H] gets overwritten by mul
;dim SysDivMultX as word ' alias SysWordTempX_U, SysWordTempX_H
;X = LowA * LowB
;mul SysWordTempA, SysWordTempB
	mul	SYSWORDTEMPA, SYSWORDTEMPB
;movff PRODL, SysWordTempX
;movff PRODH, SysWordTempX_H
;SysDivMultX = SysWordTempX
	mov	SYSDIVMULTX,SYSWORDTEMPX
	mov	SYSDIVMULTX_H,SYSWORDTEMPX_H
;HighX += LowA * HighB
;mul SysWordTempA, SysWordTempB_H
	mul	SYSWORDTEMPA, SYSWORDTEMPB_H
;add SysDivMultX_H, SysWordTempX
	add	SYSDIVMULTX_H, SYSWORDTEMPX
;HighX += HighA * LowB
;mul SysWordTempA_H, SysWordTempB
	mul	SYSWORDTEMPA_H, SYSWORDTEMPB
;add SysDivMultX_H, SysWordTempX
	add	SYSDIVMULTX_H, SYSWORDTEMPX
;Copy result back
;SysWordTempX = SysDivMultX
	mov	SYSWORDTEMPX,SYSDIVMULTX
	mov	SYSWORDTEMPX_H,SYSDIVMULTX_H
	ret

;********************************************************************************

SYSREADSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Dim SysCalcTempX As Byte
;Get length
;lpm SysCalcTempA, Z+
;lpm
	lpm
;mov SysCalcTempA, SysCalcTempX
	mov	SYSCALCTEMPA, SYSCALCTEMPX
;SysReadA += 1
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
;st Y+, SysCalcTempA
	st	Y+, SYSCALCTEMPA
;rjmp SysStringReadCheck
	rjmp	SYSSTRINGREADCHECK
SYSREADSTRINGPART:
;lpm SysCalcTempA, Z+
;lpm
	lpm
;mov SysCalcTempA, SysCalcTempX
	mov	SYSCALCTEMPA, SYSCALCTEMPX
;SysReadA += 1
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
;add SysStringLength, SysCalcTempA
	add	SYSSTRINGLENGTH, SYSCALCTEMPA
;Check length
SYSSTRINGREADCHECK:
;If length is 0, exit
;cpi SysCalcTempA, 0
	cpi	SYSCALCTEMPA, 0
;brne SysStringRead
	brne	SYSSTRINGREAD
;ret
	ret
;Copy
SYSSTRINGREAD:
;Copy char
;lpm SysCalcTempX, Z+
;lpm
	lpm
;SysReadA += 1
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
;st Y+, SysCalcTempX
	st	Y+, SYSCALCTEMPX
;dec SysCalcTempA
	dec	SYSCALCTEMPA
;brne SysStringRead
	brne	SYSSTRINGREAD
	ret

;********************************************************************************

SysStringTables:

StringTable1:
.DB	5,82,101,115,101,116


StringTable2:
.DB	0,0


StringTable3:
.DB	7,32,32,32,32,32,32,32


;********************************************************************************


