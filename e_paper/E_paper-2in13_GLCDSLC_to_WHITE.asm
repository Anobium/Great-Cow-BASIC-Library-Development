;Program compiled by Great Cow BASIC (0.98.<<>> 2019-11-14 (Windows 32 bit))
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
.EQU	DATAVAR=363
.EQU	EPD2IN13DADDRESSTYPE=364
.EQU	EPD2IN13D_COMMAND=365
.EQU	EPD2IN13D_DATA=366
.EQU	EPD_BUFFER=256
.EQU	EPD_COUNTER=367
.EQU	EPD_IND_COL=368
.EQU	EPD_IND_COL_H=369
.EQU	EPD_IND_RAW=370
.EQU	EPD_IND_RAW_H=371
.EQU	GLCDBACKGROUND=372
.EQU	GLCDBACKGROUND_H=373
.EQU	GLCDDEVICEHEIGHT=374
.EQU	GLCDDEVICEHEIGHT_H=375
.EQU	GLCDDEVICEWIDTH=376
.EQU	GLCDDEVICEWIDTH_H=377
.EQU	GLCDFNTDEFAULT=378
.EQU	GLCDFNTDEFAULTHEIGHT=379
.EQU	GLCDFNTDEFAULTSIZE=380
.EQU	GLCDFONTWIDTH=381
.EQU	GLCDFOREGROUND=382
.EQU	GLCDFOREGROUND_H=383
.EQU	GLCD_YORDINATE=384
.EQU	GLCD_YORDINATE_H=385
.EQU	PRINTLOCX=386
.EQU	PRINTLOCX_H=387
.EQU	PRINTLOCY=388
.EQU	PRINTLOCY_H=389
.EQU	SYSREPEATTEMP1=390
.EQU	SYSREPEATTEMP2=391
.EQU	SYSREPEATTEMP3=392
.EQU	VER1=393
.EQU	VER2=394
.EQU	_GLCDPAGE=395
.EQU	_GLCDPAGESH=396
.EQU	_GLCDPAGESL=397

;********************************************************************************

;Register variables
.DEF	DELAYTEMP=r25
.DEF	DELAYTEMP2=r26
.DEF	SYSBITTEST=r5
.DEF	SYSBYTETEMPX=r0
.DEF	SYSCALCTEMPA=r22
.DEF	SYSREADA=r30
.DEF	SYSREADA_H=r31
.DEF	SYSSTRINGA=r26
.DEF	SYSSTRINGA_H=r27
.DEF	SYSVALUECOPY=r21
.DEF	SYSWAITTEMPMS=r29
.DEF	SYSWAITTEMPMS_H=r30
.DEF	SYSWORDTEMPA=r22
.DEF	SYSWORDTEMPA_H=r23
.DEF	SYSWORDTEMPB=r28
.DEF	SYSWORDTEMPB_H=r29
.DEF	SYSTEMP1=r1
.DEF	SYSTEMP1_H=r2
.DEF	SYSTEMP2=r16

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
	rcall	INIT_EPD2IN13D

;Start of the main program
;''A demonstration program for Explicit-Paper.
;''-------------------------------------------------------------------------
;-------------------------------------------------------
;''This has been tested using the hardware and software SPI option.
;''*************************************************************************
;*******
;Chip Settings.
;#define GLCD_TYPE GLCD_TYPE_EPD_EPD2in13D
;#define GLCD_TYPE_EPD2in13D_LOWMEMORY2_GLCD_MODE
;Pin mappings for SPI - this GLCD driver supports Hardware SPI and Software SPI
;#define GLCD_DC     DIGITAL_9
;#define GLCD_CS     DIGITAL_10
;#define GLCD_RESET  DIGITAL_8
;#define GLCD_DO     DIGITAL_11
;#define GLCD_SCK    DIGITAL_13
;#define GLCD_Busy   DIGITAL_7
;******************************************************************************************************
;dim ver1 as byte
;dim ver2 as byte
;ver1 = EPD2_13VERSION
	ldi	SysValueCopy,8
	sts	VER1,SysValueCopy
;ver2 = GLCDVERSION
	ldi	SysValueCopy,4
	sts	VER2,SysValueCopy
;GLCDForeground=TFT_BLACK
	ldi	SysValueCopy,0
	sts	GLCDFOREGROUND,SysValueCopy
	sts	GLCDFOREGROUND_H,SysValueCopy
;GLCDBackground=TFT_WHITE
	ldi	SysValueCopy,255
	sts	GLCDBACKGROUND,SysValueCopy
	sts	GLCDBACKGROUND_H,SysValueCopy
;GLCDCLS
	rcall	CLS_EPD2IN13D
;GLCDSleep
	rcall	SLEEP_EPD2IN13D
;look at the ASM for the version
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

;Source: epd_epd2in13d.h (352)
CLS_EPD2IN13D:
;CLS_EPD2in13D_init
	rcall	CLS_EPD2IN13D_INIT
;Refresh_EPD2in13D
	rjmp	REFRESH_EPD2IN13D

;********************************************************************************

;Source: epd_epd2in13d.h (303)
CLS_EPD2IN13D_INIT:
;initialise global variable. Required variable for Circle - DO NOT DELETE
;GLCD_yordinate = 0
	ldi	SysValueCopy,0
	sts	GLCD_YORDINATE,SysValueCopy
	sts	GLCD_YORDINATE_H,SysValueCopy
;Dim EPD_Ind_raw, EPD_Ind_col as word
;Dim PrintLocX, PrintLocY as word
;PrintLocX = 0
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
;PrintLocY = 0
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
;For EPD_Ind_raw=1 to BUFFWIDTH
	ldi	SysValueCopy,0
	sts	EPD_IND_RAW,SysValueCopy
	sts	EPD_IND_RAW_H,SysValueCopy
SysForLoop6:
	lds	SysTemp1,EPD_IND_RAW
	inc	SysTemp1
	sts	EPD_IND_RAW,SysTemp1
	lds	SysTemp1,EPD_IND_RAW_H
	brne	PC + 2
	inc	SysTemp1
	sts	EPD_IND_RAW_H,SysTemp1
;EPD_Buffer(EPD_Ind_raw)=GLCDBackground
	lds	SysTemp1,EPD_IND_RAW
	ldi	SysTemp2,low(EPD_BUFFER)
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	lds	SysTemp1,EPD_IND_RAW_H
	ldi	SysTemp2,high(EPD_BUFFER)
	adc	SysTemp1,SysTemp2
	mov	SysStringA_H,SysTemp1
	lds	SysValueCopy,GLCDBACKGROUND
	st	X,SysValueCopy
;next
	lds	SysWORDTempA,EPD_IND_RAW
	lds	SysWORDTempA_H,EPD_IND_RAW_H
	ldi	SysWORDTempB,106
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop6
SysForLoopEnd6:
;Clear down "OLD" data
;SendCommand_EPD2in13D(Data_Transmission_1)
	ldi	SysValueCopy,16
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;wait 2 ms
	ldi	SysWaitTempMS,2
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;for EPD_Ind_raw=1 to GLCD_Height
	ldi	SysValueCopy,0
	sts	EPD_IND_RAW,SysValueCopy
	sts	EPD_IND_RAW_H,SysValueCopy
SysForLoop7:
	lds	SysTemp1,EPD_IND_RAW
	inc	SysTemp1
	sts	EPD_IND_RAW,SysTemp1
	lds	SysTemp1,EPD_IND_RAW_H
	brne	PC + 2
	inc	SysTemp1
	sts	EPD_IND_RAW_H,SysTemp1
;for EPD_Ind_col=1 to GLCD_Width
	ldi	SysValueCopy,0
	sts	EPD_IND_COL,SysValueCopy
	sts	EPD_IND_COL_H,SysValueCopy
SysForLoop8:
	lds	SysTemp1,EPD_IND_COL
	inc	SysTemp1
	sts	EPD_IND_COL,SysTemp1
	lds	SysTemp1,EPD_IND_COL_H
	brne	PC + 2
	inc	SysTemp1
	sts	EPD_IND_COL_H,SysTemp1
;Was.. speed optimised with macro              SendData_EPD2in13D(GLCDBackGround)
;EPD2in13D_Data = GLCDBackGround
	lds	SysValueCopy,GLCDBACKGROUND
	sts	EPD2IN13D_DATA,SysValueCopy
;SET EPD_CS OFF
	cbi	PORTB,2
;SET EPD_DC ON
	sbi	PORTB,1
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (495)
;REPEAT 8
	ldi	SysValueCopy,8
	sts	SysRepeatTemp3,SysValueCopy
SysRepeatLoop3:
;IF EPD2in13D_Data.7 = ON THEN
	lds	SysBitTest,EPD2IN13D_DATA
	sbrs	SysBitTest,7
	rjmp	ELSE9_1
;Set EPD_DO ON
	sbi	PORTB,3
;ELSE
	rjmp	ENDIF9
ELSE9_1:
;Set EPD_DO OFF
	cbi	PORTB,3
;END IF
ENDIF9:
;SET EPD_SCK On
	sbi	PORTB,5
;Rotate EPD2in13D_Data left
	lds	SysValueCopy,EPD2IN13D_DATA
	rol	SysValueCopy
	sts	EPD2IN13D_DATA,SysValueCopy
;Set EPD_SCK Off
	cbi	PORTB,5
;END REPEAT
	lds	SysTemp1,SysRepeatTemp3
	dec	SysTemp1
	sts	SysRepeatTemp3,SysTemp1
	brne	SysRepeatLoop3
SysRepeatLoopEnd3:
;SET EPD_CS ON
	sbi	PORTB,2
;next
	lds	SysWORDTempA,EPD_IND_COL
	lds	SysWORDTempA_H,EPD_IND_COL_H
	ldi	SysWORDTempB,104
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop8
SysForLoopEnd8:
;next
	lds	SysWORDTempA,EPD_IND_RAW
	lds	SysWORDTempA_H,EPD_IND_RAW_H
	ldi	SysWORDTempB,212
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop7
SysForLoopEnd7:
;wait 10 ms
	ldi	SysWaitTempMS,10
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Clear down "NEW" data
;SendCommand_EPD2in13D(Data_Transmission_2)
	ldi	SysValueCopy,19
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;wait 2 ms
	ldi	SysWaitTempMS,2
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;for EPD_Ind_raw=1 to GLCD_Height
	ldi	SysValueCopy,0
	sts	EPD_IND_RAW,SysValueCopy
	sts	EPD_IND_RAW_H,SysValueCopy
SysForLoop9:
	lds	SysTemp1,EPD_IND_RAW
	inc	SysTemp1
	sts	EPD_IND_RAW,SysTemp1
	lds	SysTemp1,EPD_IND_RAW_H
	brne	PC + 2
	inc	SysTemp1
	sts	EPD_IND_RAW_H,SysTemp1
;for EPD_Ind_col=1 to GLCD_Width
	ldi	SysValueCopy,0
	sts	EPD_IND_COL,SysValueCopy
	sts	EPD_IND_COL_H,SysValueCopy
SysForLoop10:
	lds	SysTemp1,EPD_IND_COL
	inc	SysTemp1
	sts	EPD_IND_COL,SysTemp1
	lds	SysTemp1,EPD_IND_COL_H
	brne	PC + 2
	inc	SysTemp1
	sts	EPD_IND_COL_H,SysTemp1
;Was.. speed optimised with macro              SendData_EPD2in13D(GLCDBackGround)
;EPD2in13D_Data = GLCDBackGround
	lds	SysValueCopy,GLCDBACKGROUND
	sts	EPD2IN13D_DATA,SysValueCopy
;SET EPD_CS OFF
	cbi	PORTB,2
;SET EPD_DC ON
	sbi	PORTB,1
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (495)
;REPEAT 8
	ldi	SysValueCopy,8
	sts	SysRepeatTemp3,SysValueCopy
SysRepeatLoop4:
;IF EPD2in13D_Data.7 = ON THEN
	lds	SysBitTest,EPD2IN13D_DATA
	sbrs	SysBitTest,7
	rjmp	ELSE12_1
;Set EPD_DO ON
	sbi	PORTB,3
;ELSE
	rjmp	ENDIF12
ELSE12_1:
;Set EPD_DO OFF
	cbi	PORTB,3
;END IF
ENDIF12:
;SET EPD_SCK On
	sbi	PORTB,5
;Rotate EPD2in13D_Data left
	lds	SysValueCopy,EPD2IN13D_DATA
	rol	SysValueCopy
	sts	EPD2IN13D_DATA,SysValueCopy
;Set EPD_SCK Off
	cbi	PORTB,5
;END REPEAT
	lds	SysTemp1,SysRepeatTemp3
	dec	SysTemp1
	sts	SysRepeatTemp3,SysTemp1
	brne	SysRepeatLoop4
SysRepeatLoopEnd4:
;SET EPD_CS ON
	sbi	PORTB,2
;next
	lds	SysWORDTempA,EPD_IND_COL
	lds	SysWORDTempA_H,EPD_IND_COL_H
	ldi	SysWORDTempB,104
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop10
SysForLoopEnd10:
;next
	lds	SysWORDTempA,EPD_IND_RAW
	lds	SysWORDTempA_H,EPD_IND_RAW_H
	ldi	SysWORDTempB,212
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop9
SysForLoopEnd9:
;wait 10 ms
	ldi	SysWaitTempMS,10
	ldi	SysWaitTempMS_H,0
	rjmp	Delay_MS

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

;Source: system.h (99)
INITSYS:
;Commence clearing any ANSEL variants in the part
;End clearing any ANSEL variants in the part
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

;Source: epd_epd2in13d.h (160)
INIT_EPD2IN13D:
;dim _GLCDPagesL, _GLCDPagesH  as byte
;asm showdebug Current_buffer_size_is BUFFWIDTH
;current_buffer_size_is 106
;Dir   EPD_DC     OUT
	sbi	DDRB,1
;Dir   EPD_CS     OUT
	sbi	DDRB,2
;Dir   EPD_RESET  OUT
	sbi	DDRB,0
;Dir   EPD_DO     OUT
	sbi	DDRB,3
;Dir   EPD_SCK    OUT
	sbi	DDRB,5
;Dir   EPD_Busy   IN
	cbi	DDRD,7
;SET EPD_RESET ON
	sbi	PORTB,0
;wait 200 ms
	ldi	SysWaitTempMS,200
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;SET EPD_RESET OFF
	cbi	PORTB,0
;wait 20 ms
	ldi	SysWaitTempMS,20
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;SET EPD_RESET ON
	sbi	PORTB,0
;wait 200 ms
	ldi	SysWaitTempMS,200
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;SendCommand_EPD2in13D(BOOSTER_SOFT_START)
	ldi	SysValueCopy,6
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x17)
	ldi	SysValueCopy,23
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x17)
	ldi	SysValueCopy,23
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x17)
	ldi	SysValueCopy,23
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;wait 200 ms
	ldi	SysWaitTempMS,200
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;SendCommand_EPD2in13D(POWER_SETTING)
	ldi	SysValueCopy,1
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x03)
	ldi	SysValueCopy,3
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x00)
	ldi	SysValueCopy,0
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x2B)
	ldi	SysValueCopy,43
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x2B)
	ldi	SysValueCopy,43
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x03)
	ldi	SysValueCopy,3
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;wait 200 ms
	ldi	SysWaitTempMS,200
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;SendCommand_EPD2in13D(POWER_ON)
	ldi	SysValueCopy,4
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;SendCommand_EPD2in13D(PANEL_SETTING)
	ldi	SysValueCopy,0
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(PANEL_SETTING_VALUE or PANEL_SETTING_KWR )
	ldi	SysValueCopy,191
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(PLL_CONTROL)
	ldi	SysValueCopy,48
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x3C)
	ldi	SysValueCopy,60
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(RESOLUTION_SETTING)
	ldi	SysValueCopy,97
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x68)
	ldi	SysValueCopy,104
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x00)
	ldi	SysValueCopy,0
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0xD4)
	ldi	SysValueCopy,212
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(VCM_DC_SETTING)
	ldi	SysValueCopy,130
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x12)
	ldi	SysValueCopy,18
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;LoadLUTS_EPD2in13D
	rcall	LOADLUTS_EPD2IN13D
;Colours
;GLCDForeground =TFT_WHITE
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND,SysValueCopy
	sts	GLCDFOREGROUND_H,SysValueCopy
;Default Colours
;GLCDBackground = TFT_BLACK
	ldi	SysValueCopy,0
	sts	GLCDBACKGROUND,SysValueCopy
	sts	GLCDBACKGROUND_H,SysValueCopy
;GLCDFontWidth = 6
	ldi	SysValueCopy,6
	sts	GLCDFONTWIDTH,SysValueCopy
;Variables required for device
;GLCDDeviceWidth = GLCD_WIDTH - 1
	ldi	SysValueCopy,103
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;GLCDDeviceHeight= GLCD_HEIGHT- 1
	ldi	SysValueCopy,211
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;GLCDRotate Portrait
	ldi	SysValueCopy,4
	sts	EPD2IN13DADDRESSTYPE,SysValueCopy
	rcall	ROTATE_EPD2IN13D
;GLCDfntDefault = 0
	ldi	SysValueCopy,0
	sts	GLCDFNTDEFAULT,SysValueCopy
;GLCDfntDefaultsize = 1
	ldi	SysValueCopy,1
	sts	GLCDFNTDEFAULTSIZE,SysValueCopy
;GLCDfntDefaultHeight = 8
	ldi	SysValueCopy,8
	sts	GLCDFNTDEFAULTHEIGHT,SysValueCopy
;CLS_EPD2in13D_init
	rcall	CLS_EPD2IN13D_INIT
;_GLCDPagesH = EPD_N_PAGE - 1
	ldi	SysValueCopy,25
	sts	_GLCDPAGESH,SysValueCopy
;_GLCDPagesL = 0
	ldi	SysValueCopy,0
	sts	_GLCDPAGESL,SysValueCopy
;_GLCDPage = 0
	ldi	SysValueCopy,0
	sts	_GLCDPAGE,SysValueCopy
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (256)
LOADLUTS_EPD2IN13D:
;Dim DataVar as byte
;Dim Counter as Word
;SendCommand_EPD2in13D(VCM_DC_SETTING)
	ldi	SysValueCopy,130
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x00)
	ldi	SysValueCopy,0
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(VCOM_AND_DATA_INTERVAL_SETTING)
	ldi	SysValueCopy,80
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;Mask VCOM_AND_DATA_INTERVAL bits and then Mask the user bits.
;SendData_EPD2in13D( (0x90 AND 0xF0 ) or ( VCOM_AND_DATA_INTERVAL AND 0X0F ))
	ldi	SysValueCopy,151
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(0x20) 'VCOM LUT
	ldi	SysValueCopy,32
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 44
	ldi	SysValueCopy,0
	sts	EPD_COUNTER,SysValueCopy
SysForLoop1:
	lds	SysTemp1,EPD_COUNTER
	inc	SysTemp1
	sts	EPD_COUNTER,SysTemp1
;ReadTable Lut_Vcom, EPD_Counter, DataVar
	lds	SYSSTRINGA,EPD_COUNTER
	rcall	LUT_VCOM
	sts	DATAVAR,SysByteTempX
;SendData_EPD2in13D(DataVar)
	lds	SysValueCopy,DATAVAR
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;next
	lds	SysCalcTempA,EPD_COUNTER
	cpi	SysCalcTempA,44
	brlo	SysForLoop1
SysForLoopEnd1:
;SendCommand_EPD2in13D(0x21) 'WW LUT
	ldi	SysValueCopy,33
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	ldi	SysValueCopy,0
	sts	EPD_COUNTER,SysValueCopy
SysForLoop2:
	lds	SysTemp1,EPD_COUNTER
	inc	SysTemp1
	sts	EPD_COUNTER,SysTemp1
;ReadTable Lut_WW, EPD_Counter, DataVar
	lds	SYSSTRINGA,EPD_COUNTER
	rcall	LUT_WW
	sts	DATAVAR,SysByteTempX
;SendData_EPD2in13D(DataVar)
	lds	SysValueCopy,DATAVAR
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;next
	lds	SysCalcTempA,EPD_COUNTER
	cpi	SysCalcTempA,42
	brlo	SysForLoop2
SysForLoopEnd2:
;SendCommand_EPD2in13D(0x22) 'BW LUT
	ldi	SysValueCopy,34
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	ldi	SysValueCopy,0
	sts	EPD_COUNTER,SysValueCopy
SysForLoop3:
	lds	SysTemp1,EPD_COUNTER
	inc	SysTemp1
	sts	EPD_COUNTER,SysTemp1
;ReadTable Lut_BW, EPD_Counter, DataVar
	lds	SYSSTRINGA,EPD_COUNTER
	rcall	LUT_BW
	sts	DATAVAR,SysByteTempX
;SendData_EPD2in13D(DataVar)
	lds	SysValueCopy,DATAVAR
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;next
	lds	SysCalcTempA,EPD_COUNTER
	cpi	SysCalcTempA,42
	brlo	SysForLoop3
SysForLoopEnd3:
;SendCommand_EPD2in13D(0x23) 'WB LUT
	ldi	SysValueCopy,35
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	ldi	SysValueCopy,0
	sts	EPD_COUNTER,SysValueCopy
SysForLoop4:
	lds	SysTemp1,EPD_COUNTER
	inc	SysTemp1
	sts	EPD_COUNTER,SysTemp1
;ReadTable Lut_WB, EPD_Counter, DataVar
	lds	SYSSTRINGA,EPD_COUNTER
	rcall	LUT_WB
	sts	DATAVAR,SysByteTempX
;SendData_EPD2in13D(DataVar)
	lds	SysValueCopy,DATAVAR
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;next
	lds	SysCalcTempA,EPD_COUNTER
	cpi	SysCalcTempA,42
	brlo	SysForLoop4
SysForLoopEnd4:
;SendCommand_EPD2in13D(0x24) 'BB LUT
	ldi	SysValueCopy,36
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	ldi	SysValueCopy,0
	sts	EPD_COUNTER,SysValueCopy
SysForLoop5:
	lds	SysTemp1,EPD_COUNTER
	inc	SysTemp1
	sts	EPD_COUNTER,SysTemp1
;ReadTable Lut_BB, EPD_Counter, DataVar
	lds	SYSSTRINGA,EPD_COUNTER
	rcall	LUT_BB
	sts	DATAVAR,SysByteTempX
;SendData_EPD2in13D(DataVar)
	lds	SysValueCopy,DATAVAR
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;next
	lds	SysCalcTempA,EPD_COUNTER
	cpi	SysCalcTempA,42
	brlo	SysForLoop5
SysForLoopEnd5:
	ret

;********************************************************************************

LUT_BB:
	cpi	SysStringA, 25
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableLUT_BB<<1)
	ldi	SysReadA_H, high(TableLUT_BB<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableLUT_BB:
	.DB	42,128,8,0,0,0,2,144,40,40,0,0,1,128,20,0,0,0,1,80,18,18,0,0,1

;********************************************************************************

LUT_BW:
	cpi	SysStringA, 25
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableLUT_BW<<1)
	ldi	SysReadA_H, high(TableLUT_BW<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableLUT_BW:
	.DB	42,64,23,0,0,0,2,144,15,15,0,0,3,64,10,1,0,0,1,160,14,14,0,0,2

;********************************************************************************

LUT_VCOM:
	cpi	SysStringA, 25
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableLUT_VCOM<<1)
	ldi	SysReadA_H, high(TableLUT_VCOM<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableLUT_VCOM:
	.DB	44,0,8,0,0,0,2,96,40,40,0,0,1,0,20,0,0,0,1,0,18,18,0,0,1

;********************************************************************************

LUT_WB:
	cpi	SysStringA, 25
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableLUT_WB<<1)
	ldi	SysReadA_H, high(TableLUT_WB<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableLUT_WB:
	.DB	42,128,8,0,0,0,2,144,40,40,0,0,1,128,20,0,0,0,1,80,18,18,0,0,1

;********************************************************************************

LUT_WW:
	cpi	SysStringA, 25
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableLUT_WW<<1)
	ldi	SysReadA_H, high(TableLUT_WW<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableLUT_WW:
	.DB	42,64,8,0,0,0,2,144,40,40,0,0,1,64,20,0,0,0,1,160,18,18,0,0,1

;********************************************************************************

;Source: epd_epd2in13d.h (432)
REFRESH_EPD2IN13D:
;Not required as this process has already happenend from INIT
;LoadLUTS_EPD2in13D
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	ldi	SysValueCopy,18
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rjmp	SENDCOMMAND_EPD2IN13D

;********************************************************************************

;Source: epd_epd2in13d.h (892)
ROTATE_EPD2IN13D:
;DIM GLCDDataTemp, PrintLocY, PrintLocX as word
;PrintLocY = 0
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
;PrintLocX = 0
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
;select case EPD2in13DAddressType
;case PORTRAIT
SysSelect1Case1:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,4
	brne	SysSelect1Case2
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	ldi	SysValueCopy,211
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;GLCDDeviceWidth = GLCD_WIDTH - 1
	ldi	SysValueCopy,103
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;case LANDSCAPE
	rjmp	SysSelectEnd1
SysSelect1Case2:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,1
	brne	SysSelect1Case3
;GLCDDeviceHeight = GLCD_WIDTH - 1
	ldi	SysValueCopy,103
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;GLCDDeviceWidth  = GLCD_HEIGHT - 1
	ldi	SysValueCopy,211
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;case PORTRAIT_REV
	rjmp	SysSelectEnd1
SysSelect1Case3:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,2
	brne	SysSelect1Case4
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	ldi	SysValueCopy,211
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;GLCDDeviceWidth  = GLCD_WIDTH - 1
	ldi	SysValueCopy,103
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;case LANDSCAPE_REV
	rjmp	SysSelectEnd1
SysSelect1Case4:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,3
	brne	SysSelect1Case5
;GLCDDeviceHeight = GLCD_WIDTH - 1
	ldi	SysValueCopy,103
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;GLCDDeviceWidth  = GLCD_HEIGHT - 1
	ldi	SysValueCopy,211
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;case else
	rjmp	SysSelectEnd1
SysSelect1Case5:
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	ldi	SysValueCopy,211
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;GLCDDeviceWidth  = GLCD_WIDTH - 1
	ldi	SysValueCopy,103
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;end select
SysSelectEnd1:
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (452)
SENDCOMMAND_EPD2IN13D:
;SET EPD_CS OFF
	cbi	PORTB,2
;SET EPD_DC OFF
	cbi	PORTB,1
;REPEAT 8
	ldi	SysValueCopy,8
	sts	SysRepeatTemp1,SysValueCopy
SysRepeatLoop1:
;IF EPD2in13D_Command.7 = ON THEN
	lds	SysBitTest,EPD2IN13D_COMMAND
	sbrs	SysBitTest,7
	rjmp	ELSE1_1
;Set EPD_DO ON
	sbi	PORTB,3
;ELSE
	rjmp	ENDIF1
ELSE1_1:
;Set EPD_DO OFF
	cbi	PORTB,3
;END IF
ENDIF1:
;SET EPD_SCK On
	sbi	PORTB,5
;Rotate EPD2in13D_Command left
	lds	SysValueCopy,EPD2IN13D_COMMAND
	rol	SysValueCopy
	sts	EPD2IN13D_COMMAND,SysValueCopy
;Set EPD_SCK Off
	cbi	PORTB,5
;END REPEAT
	lds	SysTemp1,SysRepeatTemp1
	dec	SysTemp1
	sts	SysRepeatTemp1,SysTemp1
	brne	SysRepeatLoop1
SysRepeatLoopEnd1:
;Set EPD_CS ON
	sbi	PORTB,2
;do
SysDoLoop_S1:
;loop while EPD_Busy=Off
	sbis	PIND,7
	rjmp	SysDoLoop_S1
SysDoLoop_E1:
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (485)
SENDDATA_EPD2IN13D:
;SET EPD_CS OFF
	cbi	PORTB,2
;SET EPD_DC ON
	sbi	PORTB,1
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (495)
;REPEAT 8
	ldi	SysValueCopy,8
	sts	SysRepeatTemp2,SysValueCopy
SysRepeatLoop2:
;IF EPD2in13D_Data.7 = ON THEN
	lds	SysBitTest,EPD2IN13D_DATA
	sbrs	SysBitTest,7
	rjmp	ELSE2_1
;Set EPD_DO ON
	sbi	PORTB,3
;ELSE
	rjmp	ENDIF2
ELSE2_1:
;Set EPD_DO OFF
	cbi	PORTB,3
;END IF
ENDIF2:
;SET EPD_SCK On
	sbi	PORTB,5
;Rotate EPD2in13D_Data left
	lds	SysValueCopy,EPD2IN13D_DATA
	rol	SysValueCopy
	sts	EPD2IN13D_DATA,SysValueCopy
;Set EPD_SCK Off
	cbi	PORTB,5
;END REPEAT
	lds	SysTemp1,SysRepeatTemp2
	dec	SysTemp1
	sts	SysRepeatTemp2,SysTemp1
	brne	SysRepeatLoop2
SysRepeatLoopEnd2:
;SET EPD_CS ON
	sbi	PORTB,2
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (440)
SLEEP_EPD2IN13D:
;SendCommand_EPD2in13D(Vcom_and_data_interval_setting)
	ldi	SysValueCopy,80
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0xF7)
	ldi	SysValueCopy,247
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(POWER_OFF)
	ldi	SysValueCopy,2
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;SendCommand_EPD2in13D(DEEP_SLEEP)
	ldi	SysValueCopy,7
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(DEEP_SLEEP_CHECK_CODE)
	ldi	SysValueCopy,165
	sts	EPD2IN13D_DATA,SysValueCopy
	rjmp	SENDDATA_EPD2IN13D

;********************************************************************************

;Source: system.h (2810)
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


