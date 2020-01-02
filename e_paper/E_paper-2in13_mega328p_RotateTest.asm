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
.EQU	CHARCODE=384
.EQU	CHARCOL=385
.EQU	CHARCOL_H=386
.EQU	CHARLOCX=387
.EQU	CHARLOCX_H=388
.EQU	CHARLOCY=389
.EQU	CHARLOCY_H=390
.EQU	COLSPERFONT=391
.EQU	CURRCHARCOL=392
.EQU	CURRCHARROW=393
.EQU	CURRCHARVAL=394
.EQU	DATAVAR=395
.EQU	DRAWLINE=396
.EQU	DRAWLINE_H=397
.EQU	DXOFFSET01=398
.EQU	DXOFFSET01_H=399
.EQU	DXOFFSET02=400
.EQU	DXOFFSET02_H=401
.EQU	DXOFFSET12=402
.EQU	DXOFFSET12_H=403
.EQU	DYOFFSET01=404
.EQU	DYOFFSET01_H=405
.EQU	DYOFFSET02=406
.EQU	DYOFFSET02_H=407
.EQU	DYOFFSET12=408
.EQU	DYOFFSET12_H=409
.EQU	EPD2IN13DADDRESSTYPE=410
.EQU	EPD2IN13D_COMMAND=411
.EQU	EPD2IN13D_DATA=412
.EQU	EPD_BUFFER=256
.EQU	EPD_COUNTER=413
.EQU	EPD_IND=414
.EQU	EPD_IND_COL=416
.EQU	EPD_IND_COL_H=417
.EQU	EPD_IND_H=415
.EQU	EPD_IND_RAW=418
.EQU	EPD_IND_RAW_H=419
.EQU	EPD_IND_TRANS=420
.EQU	EPD_IND_TRANS_H=421
.EQU	EPD_N_COL=422
.EQU	EPD_N_COL_H=423
.EQU	EPD_N_RAW=424
.EQU	EPD_N_RAW_H=425
.EQU	GLCDBACKGROUND=426
.EQU	GLCDBACKGROUND_H=427
.EQU	GLCDCOLOUR=428
.EQU	GLCDCOLOUR_H=429
.EQU	GLCDDATATEMP=430
.EQU	GLCDDATATEMP_H=431
.EQU	GLCDDEVICEHEIGHT=432
.EQU	GLCDDEVICEHEIGHT_H=433
.EQU	GLCDDEVICEWIDTH=434
.EQU	GLCDDEVICEWIDTH_H=435
.EQU	GLCDFNTDEFAULT=436
.EQU	GLCDFNTDEFAULTHEIGHT=437
.EQU	GLCDFNTDEFAULTSIZE=438
.EQU	GLCDFONTWIDTH=439
.EQU	GLCDFOREGROUND=440
.EQU	GLCDFOREGROUND_H=441
.EQU	GLCDPRINTLEN=442
.EQU	GLCDPRINTLOC=443
.EQU	GLCDPRINTLOC_H=444
.EQU	GLCDPRINT_STRING_COUNTER=445
.EQU	GLCDTEMP=446
.EQU	GLCDTEMP_H=447
.EQU	GLCDX=448
.EQU	GLCDX_H=449
.EQU	GLCDY=450
.EQU	GLCDY_H=451
.EQU	GLCD_AA=452
.EQU	GLCD_AA_H=453
.EQU	GLCD_BB=454
.EQU	GLCD_BB_H=455
.EQU	GLCD_LAST=456
.EQU	GLCD_LAST_H=457
.EQU	GLCD_SA=458
.EQU	GLCD_SA_H=459
.EQU	GLCD_SB=460
.EQU	GLCD_SB_H=461
.EQU	GLCD_TIME_BUFF=462
.EQU	GLCD_TIME_BUFF_H=463
.EQU	GLCD_Y=464
.EQU	GLCD_YORDINATE=466
.EQU	GLCD_YORDINATE_H=467
.EQU	GLCD_Y_H=465
.EQU	INXRADIUS=468
.EQU	INXRADIUS_H=469
.EQU	LINECOLOUR=470
.EQU	LINECOLOUR_H=471
.EQU	LINEDIFFX=472
.EQU	LINEDIFFX_H=473
.EQU	LINEDIFFX_X2=474
.EQU	LINEDIFFX_X2_H=475
.EQU	LINEDIFFY=476
.EQU	LINEDIFFY_H=477
.EQU	LINEDIFFY_X2=478
.EQU	LINEDIFFY_X2_H=479
.EQU	LINEERR=480
.EQU	LINEERR_H=481
.EQU	LINESTEPX=482
.EQU	LINESTEPX_H=483
.EQU	LINESTEPY=484
.EQU	LINESTEPY_H=485
.EQU	LINEX1=486
.EQU	LINEX1_H=487
.EQU	LINEX2=488
.EQU	LINEX2_H=489
.EQU	LINEY1=490
.EQU	LINEY1_H=491
.EQU	LINEY2=492
.EQU	LINEY2_H=493
.EQU	LOCALCHARCODE=494
.EQU	LOCALCHARCODE_H=495
.EQU	LOWERPAGE=496
.EQU	OLDGLCDFONTWIDTH=497
.EQU	PRINTLOCX=498
.EQU	PRINTLOCX_H=499
.EQU	PRINTLOCY=500
.EQU	PRINTLOCY_H=501
.EQU	RADIUSERR=502
.EQU	RADIUSERR_H=503
.EQU	REMAINDER=504
.EQU	ROWSPERFONT=505
.EQU	SPICLOCKMODE=506
.EQU	SPICURRENTMODE=507
.EQU	SPITXDATA=508
.EQU	STRINGPOINTER=509
.EQU	SYSLCDPRINTDATAHANDLER=510
.EQU	SYSLCDPRINTDATAHANDLER_H=511
.EQU	SYSREPEATTEMP1=512
.EQU	SYSSTRINGPARAM1=363
.EQU	UC1601_BUFFERLOCATIONCALC=513
.EQU	UC1601_BUFFERLOCATIONCALC_H=514
.EQU	UPPERPAGE=515
.EQU	XOFFSET=516
.EQU	XOFFSET2=518
.EQU	XOFFSET2_H=519
.EQU	XOFFSET3=520
.EQU	XOFFSET3_H=521
.EQU	XOFFSET_H=517
.EQU	XRADIUS=522
.EQU	XRADIUS_H=523
.EQU	YOFFSET=524
.EQU	YOFFSET2=526
.EQU	YOFFSET2_H=527
.EQU	YOFFSET3=528
.EQU	YOFFSET3_H=529
.EQU	YOFFSET_H=525
.EQU	YORDINATE=530
.EQU	_GLCDPAGE=531
.EQU	_GLCDPAGESH=532
.EQU	_GLCDPAGESL=533

;********************************************************************************

;Register variables
.DEF	DELAYTEMP=r25
.DEF	DELAYTEMP2=r26
.DEF	SYSBITTEST=r5
.DEF	SYSBYTETEMPA=r22
.DEF	SYSBYTETEMPB=r28
.DEF	SYSBYTETEMPX=r0
.DEF	SYSCALCTEMPA=r22
.DEF	SYSCALCTEMPA_H=r23
.DEF	SYSCALCTEMPB=r28
.DEF	SYSCALCTEMPB_H=r29
.DEF	SYSCALCTEMPX=r0
.DEF	SYSCALCTEMPX_H=r1
.DEF	SYSDIVLOOP=r5
.DEF	SYSDIVMULTA=r24
.DEF	SYSDIVMULTA_H=r25
.DEF	SYSDIVMULTB=r30
.DEF	SYSDIVMULTB_H=r31
.DEF	SYSDIVMULTX=r2
.DEF	SYSDIVMULTX_H=r3
.DEF	SYSINTEGERTEMPA=r22
.DEF	SYSINTEGERTEMPA_H=r23
.DEF	SYSINTEGERTEMPB=r28
.DEF	SYSINTEGERTEMPB_H=r29
.DEF	SYSINTEGERTEMPX=r0
.DEF	SYSINTEGERTEMPX_H=r1
.DEF	SYSREADA=r30
.DEF	SYSREADA_H=r31
.DEF	SYSSIGNBYTE=r4
.DEF	SYSSTRINGA=r26
.DEF	SYSSTRINGA_H=r27
.DEF	SYSSTRINGB=r28
.DEF	SYSSTRINGB_H=r29
.DEF	SYSSTRINGLENGTH=r25
.DEF	SYSVALUECOPY=r21
.DEF	SYSWAITTEMPMS=r29
.DEF	SYSWAITTEMPMS_H=r30
.DEF	SYSWAITTEMPS=r31
.DEF	SYSWORDTEMPA=r22
.DEF	SYSWORDTEMPA_H=r23
.DEF	SYSWORDTEMPB=r28
.DEF	SYSWORDTEMPB_H=r29
.DEF	SYSWORDTEMPX=r0
.DEF	SYSWORDTEMPX_H=r1
.DEF	SYSTEMP1=r6
.DEF	SYSTEMP1_H=r7
.DEF	SYSTEMP2=r8
.DEF	SYSTEMP2_H=r9
.DEF	SYSTEMP3=r16

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
	call	INITSYS
	call	INIT_EPD2IN13D

;Start of the main program
;''A demonstration program for Explicit-Paper.
;''-------------------------------------------------------------------------
;-------------------------------------------------------
;''This has been tested using the hardware and software SPI option.
;''*************************************************************************
;*******
;Chip Settings.
;USART settings
;#define USART_BAUD_RATE 9600
;#define USART_TX_BLOCKING
;______________
;USART
;#define USART_BAUD_RATE 57600'9600
;#define USART_DELAY     5 ms
;#define USART_BLOCKING
;Set pin USART directions
;******************************************************************************************************
;The following should be used   '#define EPD_HardwareSPI     'remove comment out if you want to use software SPI.
;#define EPD_HardwareSPI
;#define HWSPIMode MasterUltraFast
;***************************************************************************
;***************************
;Setup the E-Paper
;#define GLCD_TYPE GLCD_TYPE_EPD_EPD2in13D
;#define GLCD_EXTENDEDFONTSET1
;#define GLCD_TYPE_EPD2in13D_LOWMEMORY2_GLCD_MODE
;#define GLCD_OLED_FONT
;#define GLCD_PROTECTOVERRUN
;Pin mappings for SPI - this GLCD driver supports Hardware SPI and Software SPI
;#define GLCD_DC     DIGITAL_9
;#define GLCD_CS     DIGITAL_10
;#define GLCD_RESET  DIGITAL_8
;#define GLCD_DO     DIGITAL_11
;#define GLCD_SCK    DIGITAL_13
;#define GLCD_Busy   DIGITAL_7
;Dim ind, counter, ind_raw, ind_col as word
;Dim DataVar, dummy, Flag, VERBOSE as byte
;Dim x_min, x_max, y_min, y_max as Word
;Dim MyString, MyString1 as String
;******************************************************************************************************
;******************************************************************************************************
;Main program
;dim upperPage, lowerPage as Byte
;upperPage = 0
	ldi	SysValueCopy,0
	sts	UPPERPAGE,SysValueCopy
;lowerPage = EPD_N_PAGE-1
	ldi	SysValueCopy,25
	sts	LOWERPAGE,SysValueCopy
;GLCDForeground = TFT_BLACK
	ldi	SysValueCopy,0
	sts	GLCDFOREGROUND,SysValueCopy
	sts	GLCDFOREGROUND_H,SysValueCopy
;GLCDBackground = TFT_WHITE
	ldi	SysValueCopy,255
	sts	GLCDBACKGROUND,SysValueCopy
	sts	GLCDBACKGROUND_H,SysValueCopy
;do
SysDoLoop_S1:
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (938)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	call	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	lds	SysTemp1,_GLCDPAGESL
	dec	SysTemp1
	sts	_GLCDPAGE,SysTemp1
	lds	SysCalcTempA,_GLCDPAGESH
	lds	SysCalcTempB,_GLCDPAGESL
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF1
	rjmp	SysForLoopEnd1
ENDIF1:
SysForLoop1:
	lds	SysTemp1,_GLCDPAGE
	inc	SysTemp1
	sts	_GLCDPAGE,SysTemp1
;GLCDLocateString 0,0
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
	call	GLCDLOCATESTRING
;GLCDPrint 0,0, "Test @ Default"
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
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;line 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	ldi	SysValueCopy,0
	sts	LINEX1,SysValueCopy
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1,SysValueCopy
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH_H
	sts	LINEX2_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT_H
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	LINE
;box 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	ldi	SysValueCopy,0
	sts	LINEX1,SysValueCopy
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1,SysValueCopy
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH_H
	sts	LINEX2_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT_H
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	BOX
;Circle GLCDDeviceWidth/2, GLCDDeviceHeight/2, 20
	lds	SysWORDTempA,GLCDDEVICEWIDTH
	lds	SysWORDTempA_H,GLCDDEVICEWIDTH_H
	ldi	SysWORDTempB,2
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	XOFFSET,SysWORDTempA
	sts	XOFFSET_H,SysWORDTempA_H
	lds	SysWORDTempA,GLCDDEVICEHEIGHT
	lds	SysWORDTempA_H,GLCDDEVICEHEIGHT_H
	ldi	SysWORDTempB,2
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	YOFFSET,SysWORDTempA
	sts	YOFFSET_H,SysWORDTempA_H
	ldi	SysValueCopy,20
	sts	INXRADIUS,SysValueCopy
	ldi	SysValueCopy,0
	sts	INXRADIUS_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	lds	SysValueCopy,GLCD_YORDINATE
	sts	YORDINATE,SysValueCopy
	rcall	CIRCLE
;FilledBox( 12, 12,20, 80, GLCDForeground)  'Filled Rectangle
	ldi	SysValueCopy,12
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,80
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDBOX_EPD2IN13D
;FilledTriangle(12,80, 20,80,16,90, GLCDForeground)  'Filled Triangle
	ldi	SysValueCopy,12
	sts	XOFFSET,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET_H,SysValueCopy
	ldi	SysValueCopy,80
	sts	YOFFSET,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	XOFFSET2,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET2_H,SysValueCopy
	ldi	SysValueCopy,80
	sts	YOFFSET2,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET2_H,SysValueCopy
	ldi	SysValueCopy,16
	sts	XOFFSET3,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET3_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	YOFFSET3,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET3_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDTRIANGLE
;GLCDPrintStringLN " line1"
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable2<<1)
	ldi	SysReadA_H,high(StringTable2<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINTSTRINGLN
;GLCDLocateString (20, 4)
	ldi	SysValueCopy,20
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,4
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	call	GLCDLOCATESTRING
;GLCDPrintStringLN "Line 4"
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable3<<1)
	ldi	SysReadA_H,high(StringTable3<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINTSTRINGLN
;GLCDPrintStringLN "Line 5"
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable4<<1)
	ldi	SysReadA_H,high(StringTable4<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINTSTRINGLN
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (951)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	lds	SysCalcTempA,_GLCDPAGE
	lds	SysCalcTempB,_GLCDPAGESH
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF2
	rjmp	SysForLoop1
ENDIF2:
SysForLoopEnd1:
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	ldi	SysValueCopy,18
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;wait 2 s
	ldi	SysWaitTempS,2
	call	Delay_S
;GLCDRotate Portrait
	ldi	SysValueCopy,4
	sts	EPD2IN13DADDRESSTYPE,SysValueCopy
	call	ROTATE_EPD2IN13D
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (938)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	rcall	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	lds	SysTemp1,_GLCDPAGESL
	dec	SysTemp1
	sts	_GLCDPAGE,SysTemp1
	lds	SysCalcTempA,_GLCDPAGESH
	lds	SysCalcTempB,_GLCDPAGESL
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF3
	rjmp	SysForLoopEnd2
ENDIF3:
SysForLoop2:
	lds	SysTemp1,_GLCDPAGE
	inc	SysTemp1
	sts	_GLCDPAGE,SysTemp1
;GLCDLocateString 0,0
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
	call	GLCDLOCATESTRING
;GLCDPrint 0,0, "Test @ Portrait"
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable5<<1)
	ldi	SysReadA_H,high(StringTable5<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;line 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	ldi	SysValueCopy,0
	sts	LINEX1,SysValueCopy
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1,SysValueCopy
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH_H
	sts	LINEX2_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT_H
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	LINE
;box 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	ldi	SysValueCopy,0
	sts	LINEX1,SysValueCopy
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1,SysValueCopy
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH_H
	sts	LINEX2_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT_H
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	BOX
;Circle GLCDDeviceWidth/2, GLCDDeviceHeight/2, 20
	lds	SysWORDTempA,GLCDDEVICEWIDTH
	lds	SysWORDTempA_H,GLCDDEVICEWIDTH_H
	ldi	SysWORDTempB,2
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	XOFFSET,SysWORDTempA
	sts	XOFFSET_H,SysWORDTempA_H
	lds	SysWORDTempA,GLCDDEVICEHEIGHT
	lds	SysWORDTempA_H,GLCDDEVICEHEIGHT_H
	ldi	SysWORDTempB,2
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	YOFFSET,SysWORDTempA
	sts	YOFFSET_H,SysWORDTempA_H
	ldi	SysValueCopy,20
	sts	INXRADIUS,SysValueCopy
	ldi	SysValueCopy,0
	sts	INXRADIUS_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	lds	SysValueCopy,GLCD_YORDINATE
	sts	YORDINATE,SysValueCopy
	rcall	CIRCLE
;FilledBox( 12, 12,20, 80, GLCDForeground)  'Filled Rectangle
	ldi	SysValueCopy,12
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,80
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDBOX_EPD2IN13D
;FilledTriangle(12,80, 20,80,16,90, GLCDForeground)  'Filled Triangle
	ldi	SysValueCopy,12
	sts	XOFFSET,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET_H,SysValueCopy
	ldi	SysValueCopy,80
	sts	YOFFSET,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	XOFFSET2,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET2_H,SysValueCopy
	ldi	SysValueCopy,80
	sts	YOFFSET2,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET2_H,SysValueCopy
	ldi	SysValueCopy,16
	sts	XOFFSET3,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET3_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	YOFFSET3,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET3_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDTRIANGLE
;GLCDPrintStringLN " line1"
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable2<<1)
	ldi	SysReadA_H,high(StringTable2<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINTSTRINGLN
;GLCDLocateString (20, 4)
	ldi	SysValueCopy,20
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,4
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	call	GLCDLOCATESTRING
;GLCDPrintStringLN "Line 4"
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable3<<1)
	ldi	SysReadA_H,high(StringTable3<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINTSTRINGLN
;GLCDPrintStringLN "Line 5"
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable4<<1)
	ldi	SysReadA_H,high(StringTable4<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINTSTRINGLN
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (951)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	lds	SysCalcTempA,_GLCDPAGE
	lds	SysCalcTempB,_GLCDPAGESH
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF4
	rjmp	SysForLoop2
ENDIF4:
SysForLoopEnd2:
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	ldi	SysValueCopy,18
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;wait 2 s
	ldi	SysWaitTempS,2
	call	Delay_S
;GLCDRotate Portrait_rev
	ldi	SysValueCopy,2
	sts	EPD2IN13DADDRESSTYPE,SysValueCopy
	call	ROTATE_EPD2IN13D
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (938)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	rcall	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	lds	SysTemp1,_GLCDPAGESL
	dec	SysTemp1
	sts	_GLCDPAGE,SysTemp1
	lds	SysCalcTempA,_GLCDPAGESH
	lds	SysCalcTempB,_GLCDPAGESL
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF5
	rjmp	SysForLoopEnd3
ENDIF5:
SysForLoop3:
	lds	SysTemp1,_GLCDPAGE
	inc	SysTemp1
	sts	_GLCDPAGE,SysTemp1
;GLCDLocateString 0,0
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
	call	GLCDLOCATESTRING
;GLCDPrint 0,0, "Test @ Portrait_rev"
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable6<<1)
	ldi	SysReadA_H,high(StringTable6<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;line 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	ldi	SysValueCopy,0
	sts	LINEX1,SysValueCopy
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1,SysValueCopy
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH_H
	sts	LINEX2_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT_H
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	LINE
;box 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	ldi	SysValueCopy,0
	sts	LINEX1,SysValueCopy
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1,SysValueCopy
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH_H
	sts	LINEX2_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT_H
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	BOX
;Circle GLCDDeviceWidth/2, GLCDDeviceHeight/2, 20
	lds	SysWORDTempA,GLCDDEVICEWIDTH
	lds	SysWORDTempA_H,GLCDDEVICEWIDTH_H
	ldi	SysWORDTempB,2
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	XOFFSET,SysWORDTempA
	sts	XOFFSET_H,SysWORDTempA_H
	lds	SysWORDTempA,GLCDDEVICEHEIGHT
	lds	SysWORDTempA_H,GLCDDEVICEHEIGHT_H
	ldi	SysWORDTempB,2
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	YOFFSET,SysWORDTempA
	sts	YOFFSET_H,SysWORDTempA_H
	ldi	SysValueCopy,20
	sts	INXRADIUS,SysValueCopy
	ldi	SysValueCopy,0
	sts	INXRADIUS_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	lds	SysValueCopy,GLCD_YORDINATE
	sts	YORDINATE,SysValueCopy
	rcall	CIRCLE
;FilledBox( 12, 12,20, 80, GLCDForeground)  'Filled Rectangle
	ldi	SysValueCopy,12
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,80
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDBOX_EPD2IN13D
;FilledTriangle(12,80, 20,80,16,90, GLCDForeground)  'Filled Triangle
	ldi	SysValueCopy,12
	sts	XOFFSET,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET_H,SysValueCopy
	ldi	SysValueCopy,80
	sts	YOFFSET,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	XOFFSET2,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET2_H,SysValueCopy
	ldi	SysValueCopy,80
	sts	YOFFSET2,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET2_H,SysValueCopy
	ldi	SysValueCopy,16
	sts	XOFFSET3,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET3_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	YOFFSET3,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET3_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDTRIANGLE
;GLCDPrintStringLN " line1"
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable2<<1)
	ldi	SysReadA_H,high(StringTable2<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINTSTRINGLN
;GLCDLocateString (20, 4)
	ldi	SysValueCopy,20
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,4
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	call	GLCDLOCATESTRING
;GLCDPrintStringLN "Line 4"
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable3<<1)
	ldi	SysReadA_H,high(StringTable3<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINTSTRINGLN
;GLCDPrintStringLN "Line 5"
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable4<<1)
	ldi	SysReadA_H,high(StringTable4<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINTSTRINGLN
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (951)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	lds	SysCalcTempA,_GLCDPAGE
	lds	SysCalcTempB,_GLCDPAGESH
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF6
	rjmp	SysForLoop3
ENDIF6:
SysForLoopEnd3:
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	ldi	SysValueCopy,18
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;wait 2 s
	ldi	SysWaitTempS,2
	rcall	Delay_S
;GLCDRotate Landscape
	ldi	SysValueCopy,1
	sts	EPD2IN13DADDRESSTYPE,SysValueCopy
	call	ROTATE_EPD2IN13D
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (938)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	rcall	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	lds	SysTemp1,_GLCDPAGESL
	dec	SysTemp1
	sts	_GLCDPAGE,SysTemp1
	lds	SysCalcTempA,_GLCDPAGESH
	lds	SysCalcTempB,_GLCDPAGESL
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF7
	rjmp	SysForLoopEnd4
ENDIF7:
SysForLoop4:
	lds	SysTemp1,_GLCDPAGE
	inc	SysTemp1
	sts	_GLCDPAGE,SysTemp1
;GLCDLocateString 0,0
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
	call	GLCDLOCATESTRING
;GLCDPrint 0,0, "Test @ Landscape"
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable7<<1)
	ldi	SysReadA_H,high(StringTable7<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;line 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	ldi	SysValueCopy,0
	sts	LINEX1,SysValueCopy
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1,SysValueCopy
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH_H
	sts	LINEX2_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT_H
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	LINE
;box 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	ldi	SysValueCopy,0
	sts	LINEX1,SysValueCopy
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1,SysValueCopy
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH_H
	sts	LINEX2_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT_H
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	BOX
;Circle GLCDDeviceWidth/2, GLCDDeviceHeight/2, 20
	lds	SysWORDTempA,GLCDDEVICEWIDTH
	lds	SysWORDTempA_H,GLCDDEVICEWIDTH_H
	ldi	SysWORDTempB,2
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	XOFFSET,SysWORDTempA
	sts	XOFFSET_H,SysWORDTempA_H
	lds	SysWORDTempA,GLCDDEVICEHEIGHT
	lds	SysWORDTempA_H,GLCDDEVICEHEIGHT_H
	ldi	SysWORDTempB,2
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	YOFFSET,SysWORDTempA
	sts	YOFFSET_H,SysWORDTempA_H
	ldi	SysValueCopy,20
	sts	INXRADIUS,SysValueCopy
	ldi	SysValueCopy,0
	sts	INXRADIUS_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	lds	SysValueCopy,GLCD_YORDINATE
	sts	YORDINATE,SysValueCopy
	rcall	CIRCLE
;FilledBox( 12, 12,20, 80, GLCDForeground)  'Filled Rectangle
	ldi	SysValueCopy,12
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,80
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	FILLEDBOX_EPD2IN13D
;FilledTriangle(12,80, 20,80,16,90, GLCDForeground)  'Filled Triangle
	ldi	SysValueCopy,12
	sts	XOFFSET,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET_H,SysValueCopy
	ldi	SysValueCopy,80
	sts	YOFFSET,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	XOFFSET2,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET2_H,SysValueCopy
	ldi	SysValueCopy,80
	sts	YOFFSET2,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET2_H,SysValueCopy
	ldi	SysValueCopy,16
	sts	XOFFSET3,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET3_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	YOFFSET3,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET3_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	FILLEDTRIANGLE
;GLCDPrintStringLN " line1"
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable2<<1)
	ldi	SysReadA_H,high(StringTable2<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINTSTRINGLN
;GLCDLocateString (20, 4)
	ldi	SysValueCopy,20
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,4
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	call	GLCDLOCATESTRING
;GLCDPrintStringLN "Line 4"
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable3<<1)
	ldi	SysReadA_H,high(StringTable3<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINTSTRINGLN
;GLCDPrintStringLN "Line 5"
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable4<<1)
	ldi	SysReadA_H,high(StringTable4<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINTSTRINGLN
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (951)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	lds	SysCalcTempA,_GLCDPAGE
	lds	SysCalcTempB,_GLCDPAGESH
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF8
	rjmp	SysForLoop4
ENDIF8:
SysForLoopEnd4:
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	ldi	SysValueCopy,18
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;wait 2 s
	ldi	SysWaitTempS,2
	rcall	Delay_S
;GLCDRotate Landscape_Rev
	ldi	SysValueCopy,3
	sts	EPD2IN13DADDRESSTYPE,SysValueCopy
	call	ROTATE_EPD2IN13D
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (938)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	rcall	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	lds	SysTemp1,_GLCDPAGESL
	dec	SysTemp1
	sts	_GLCDPAGE,SysTemp1
	lds	SysCalcTempA,_GLCDPAGESH
	lds	SysCalcTempB,_GLCDPAGESL
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF9
	rjmp	SysForLoopEnd5
ENDIF9:
SysForLoop5:
	lds	SysTemp1,_GLCDPAGE
	inc	SysTemp1
	sts	_GLCDPAGE,SysTemp1
;GLCDLocateString 0,0
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
	call	GLCDLOCATESTRING
;GLCDPrint 0,0, "Test @ Landscape_Rev"
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable8<<1)
	ldi	SysReadA_H,high(StringTable8<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;line 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	ldi	SysValueCopy,0
	sts	LINEX1,SysValueCopy
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1,SysValueCopy
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH_H
	sts	LINEX2_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT_H
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	LINE
;box 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	ldi	SysValueCopy,0
	sts	LINEX1,SysValueCopy
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1,SysValueCopy
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEWIDTH_H
	sts	LINEX2_H,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,GLCDDEVICEHEIGHT_H
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	BOX
;Circle GLCDDeviceWidth/2, GLCDDeviceHeight/2, 20
	lds	SysWORDTempA,GLCDDEVICEWIDTH
	lds	SysWORDTempA_H,GLCDDEVICEWIDTH_H
	ldi	SysWORDTempB,2
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	XOFFSET,SysWORDTempA
	sts	XOFFSET_H,SysWORDTempA_H
	lds	SysWORDTempA,GLCDDEVICEHEIGHT
	lds	SysWORDTempA_H,GLCDDEVICEHEIGHT_H
	ldi	SysWORDTempB,2
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	YOFFSET,SysWORDTempA
	sts	YOFFSET_H,SysWORDTempA_H
	ldi	SysValueCopy,20
	sts	INXRADIUS,SysValueCopy
	ldi	SysValueCopy,0
	sts	INXRADIUS_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	lds	SysValueCopy,GLCD_YORDINATE
	sts	YORDINATE,SysValueCopy
	rcall	CIRCLE
;FilledBox( 12, 12,20, 80, GLCDForeground)  'Filled Rectangle
	ldi	SysValueCopy,12
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,80
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	FILLEDBOX_EPD2IN13D
;FilledTriangle(12,80, 20,80,16,90, GLCDForeground)  'Filled Triangle
	ldi	SysValueCopy,12
	sts	XOFFSET,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET_H,SysValueCopy
	ldi	SysValueCopy,80
	sts	YOFFSET,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	XOFFSET2,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET2_H,SysValueCopy
	ldi	SysValueCopy,80
	sts	YOFFSET2,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET2_H,SysValueCopy
	ldi	SysValueCopy,16
	sts	XOFFSET3,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET3_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	YOFFSET3,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET3_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	FILLEDTRIANGLE
;GLCDPrintStringLN " line1"
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable2<<1)
	ldi	SysReadA_H,high(StringTable2<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINTSTRINGLN
;GLCDLocateString (20, 4)
	ldi	SysValueCopy,20
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,4
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	call	GLCDLOCATESTRING
;GLCDPrintStringLN "Line 4"
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable3<<1)
	ldi	SysReadA_H,high(StringTable3<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINTSTRINGLN
;GLCDPrintStringLN "Line 5"
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable4<<1)
	ldi	SysReadA_H,high(StringTable4<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINTSTRINGLN
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (951)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	lds	SysCalcTempA,_GLCDPAGE
	lds	SysCalcTempB,_GLCDPAGESH
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF10
	rjmp	SysForLoop5
ENDIF10:
SysForLoopEnd5:
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	ldi	SysValueCopy,18
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;wait 2 s
	ldi	SysWaitTempS,2
	rcall	Delay_S
;loop
	rjmp	SysDoLoop_S1
SysDoLoop_E1:
;GLCDCLS
	rcall	CLS_EPD2IN13D
;GLCDSleep
	call	SLEEP_EPD2IN13D
;do
SysDoLoop_S2:
;loop
	rjmp	SysDoLoop_S2
SysDoLoop_E2:
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

;Source: glcd.h (1353)
BOX:
;dim GLCDTemp as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	lds	SysWORDTempB,LINEX1
	lds	SysWORDTempB_H,LINEX1_H
	lds	SysWORDTempA,LINEX2
	lds	SysWORDTempA_H,LINEX2_H
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF15
;GLCDTemp = LineX1
	lds	SysValueCopy,LINEX1
	sts	GLCDTEMP,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	GLCDTEMP_H,SysValueCopy
;LineX1 = LineX2
	lds	SysValueCopy,LINEX2
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,LINEX2_H
	sts	LINEX1_H,SysValueCopy
;LineX2 = GLCDTemp
	lds	SysValueCopy,GLCDTEMP
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,GLCDTEMP_H
	sts	LINEX2_H,SysValueCopy
;End If
ENDIF15:
;If LineY1 > LineY2 Then
	lds	SysWORDTempB,LINEY1
	lds	SysWORDTempB_H,LINEY1_H
	lds	SysWORDTempA,LINEY2
	lds	SysWORDTempA_H,LINEY2_H
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF16
;GLCDTemp = LineY1
	lds	SysValueCopy,LINEY1
	sts	GLCDTEMP,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	GLCDTEMP_H,SysValueCopy
;LineY1 = LineY2
	lds	SysValueCopy,LINEY2
	sts	LINEY1,SysValueCopy
	lds	SysValueCopy,LINEY2_H
	sts	LINEY1_H,SysValueCopy
;LineY2 = GLCDTemp
	lds	SysValueCopy,GLCDTEMP
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,GLCDTEMP_H
	sts	LINEY2_H,SysValueCopy
;End If
ENDIF16:
;dim DrawLine as word
;Draw lines going across
;For DrawLine = LineX1 To LineX2
	lds	SysTemp1,LINEX1
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	DRAWLINE,SysTemp1
	lds	SysTemp1,LINEX1_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	DRAWLINE_H,SysTemp1
	lds	SysWORDTempB,LINEX1
	lds	SysWORDTempB_H,LINEX1_H
	lds	SysWORDTempA,LINEX2
	lds	SysWORDTempA_H,LINEX2_H
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoopEnd7
SysForLoop7:
	lds	SysTemp1,DRAWLINE
	inc	SysTemp1
	sts	DRAWLINE,SysTemp1
	lds	SysTemp1,DRAWLINE_H
	brne	PC + 2
	inc	SysTemp1
	sts	DRAWLINE_H,SysTemp1
;PSet DrawLine, LineY1, LineColour
	lds	SysValueCopy,DRAWLINE
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,DRAWLINE_H
	sts	GLCDX_H,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	GLCDY_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;PSet DrawLine, LineY2, LineColour
	lds	SysValueCopy,DRAWLINE
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,DRAWLINE_H
	sts	GLCDX_H,SysValueCopy
	lds	SysValueCopy,LINEY2
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINEY2_H
	sts	GLCDY_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;Next
	lds	SysWORDTempA,DRAWLINE
	lds	SysWORDTempA_H,DRAWLINE_H
	lds	SysWORDTempB,LINEX2
	lds	SysWORDTempB_H,LINEX2_H
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop7
SysForLoopEnd7:
;Draw lines going down
;For DrawLine = LineY1 To LineY2
	lds	SysTemp1,LINEY1
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	DRAWLINE,SysTemp1
	lds	SysTemp1,LINEY1_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	DRAWLINE_H,SysTemp1
	lds	SysWORDTempB,LINEY1
	lds	SysWORDTempB_H,LINEY1_H
	lds	SysWORDTempA,LINEY2
	lds	SysWORDTempA_H,LINEY2_H
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoopEnd8
SysForLoop8:
	lds	SysTemp1,DRAWLINE
	inc	SysTemp1
	sts	DRAWLINE,SysTemp1
	lds	SysTemp1,DRAWLINE_H
	brne	PC + 2
	inc	SysTemp1
	sts	DRAWLINE_H,SysTemp1
;PSet LineX1, DrawLine, LineColour
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	GLCDX_H,SysValueCopy
	lds	SysValueCopy,DRAWLINE
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,DRAWLINE_H
	sts	GLCDY_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;PSet LineX2, DrawLine, LineColour
	lds	SysValueCopy,LINEX2
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEX2_H
	sts	GLCDX_H,SysValueCopy
	lds	SysValueCopy,DRAWLINE
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,DRAWLINE_H
	sts	GLCDY_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;Next
	lds	SysWORDTempA,DRAWLINE
	lds	SysWORDTempA_H,DRAWLINE_H
	lds	SysWORDTempB,LINEY2
	lds	SysWORDTempB_H,LINEY2_H
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop8
SysForLoopEnd8:
	ret

;********************************************************************************

;Source: glcd.h (1400)
CIRCLE:
;dim  radiusErr, xradius as Integer
;xradius = Inxradius
	lds	SysValueCopy,INXRADIUS
	sts	XRADIUS,SysValueCopy
	lds	SysValueCopy,INXRADIUS_H
	sts	XRADIUS_H,SysValueCopy
;radiusErr = -(xradius/2)
	lds	SysINTEGERTempA,XRADIUS
	lds	SysINTEGERTempA_H,XRADIUS_H
	ldi	SysINTEGERTempB,2
	ldi	SysINTEGERTempB_H,0
	call	SysDivSubINT
	mov	SysTemp1,SysINTEGERTempA
	mov	SysTemp1_H,SysINTEGERTempA_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	sts	RADIUSERR,SysTemp1
	sts	RADIUSERR_H,SysTemp1_H
;Do While xradius >=  yordinate
SysDoLoop_S3:
	lds	SysINTEGERTempA,xradius
	lds	SysINTEGERTempA_H,xradius_H
	lds	SysINTEGERTempB,yordinate
	ldi	SysINTEGERTempB_H,0
	call	SysCompLessThanINT
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	SysDoLoop_E3
;Pset ((xoffset + xradius), (yoffset + yordinate), LineColour)
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,XRADIUS
	add	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,XOFFSET_H
	lds	SysTemp2,XRADIUS_H
	adc	SysTemp1,SysTemp2
	sts	GLCDX_H,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,YORDINATE
	add	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysTemp1,YOFFSET_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	GLCDY_H,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;Pset ((xoffset + yordinate), (yoffset + xradius), LineColour)
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,YORDINATE
	add	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,XOFFSET_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	GLCDX_H,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,XRADIUS
	add	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysTemp1,YOFFSET_H
	lds	SysTemp2,XRADIUS_H
	adc	SysTemp1,SysTemp2
	sts	GLCDY_H,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;Pset ((xoffset - xradius), (yoffset + yordinate), LineColour)
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,XRADIUS
	sub	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,XOFFSET_H
	lds	SysTemp2,XRADIUS_H
	sbc	SysTemp1,SysTemp2
	sts	GLCDX_H,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,YORDINATE
	add	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysTemp1,YOFFSET_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	GLCDY_H,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;Pset ((xoffset - yordinate), (yoffset + xradius), LineColour)
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,YORDINATE
	sub	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,XOFFSET_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	GLCDX_H,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,XRADIUS
	add	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysTemp1,YOFFSET_H
	lds	SysTemp2,XRADIUS_H
	adc	SysTemp1,SysTemp2
	sts	GLCDY_H,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;Pset ((xoffset - xradius), (yoffset - yordinate), LineColour)
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,XRADIUS
	sub	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,XOFFSET_H
	lds	SysTemp2,XRADIUS_H
	sbc	SysTemp1,SysTemp2
	sts	GLCDX_H,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,YORDINATE
	sub	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysTemp1,YOFFSET_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	GLCDY_H,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;Pset ((xoffset - yordinate), (yoffset - xradius), LineColour)
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,YORDINATE
	sub	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,XOFFSET_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	GLCDX_H,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,XRADIUS
	sub	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysTemp1,YOFFSET_H
	lds	SysTemp2,XRADIUS_H
	sbc	SysTemp1,SysTemp2
	sts	GLCDY_H,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;Pset ((xoffset + xradius), (yoffset - yordinate), LineColour)
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,XRADIUS
	add	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,XOFFSET_H
	lds	SysTemp2,XRADIUS_H
	adc	SysTemp1,SysTemp2
	sts	GLCDX_H,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,YORDINATE
	sub	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysTemp1,YOFFSET_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	GLCDY_H,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;Pset ((xoffset + yordinate), (yoffset - xradius), LineColour)
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,YORDINATE
	add	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,XOFFSET_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	GLCDX_H,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,XRADIUS
	sub	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysTemp1,YOFFSET_H
	lds	SysTemp2,XRADIUS_H
	sbc	SysTemp1,SysTemp2
	sts	GLCDY_H,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;yordinate ++
	lds	SysTemp1,YORDINATE
	inc	SysTemp1
	sts	YORDINATE,SysTemp1
;If radiusErr < 0 Then
	lds	SysINTEGERTempA,RADIUSERR
	lds	SysINTEGERTempA_H,RADIUSERR_H
	ldi	SysINTEGERTempB,0
	ldi	SysINTEGERTempB_H,0
	call	SysCompLessThanINT
	sbrs	SysByteTempX,0
	rjmp	ELSE21_1
;radiusErr = radiusErr + 2 * yordinate + 1
	lds	SysTemp2,YORDINATE
	lsl	SysTemp2
	lds	SysTemp3,RADIUSERR
	add	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	lds	SysTemp2,RADIUSERR_H
	ldi	SysTemp3,0
	adc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	ldi	SysTemp3,1
	add	SysTemp1,SysTemp3
	sts	RADIUSERR,SysTemp1
	ldi	SysTemp3,0
	adc	SysTemp1_H,SysTemp3
	sts	RADIUSERR_H,SysTemp1_H
;else
	rjmp	ENDIF21
ELSE21_1:
;xradius --
	lds	SysTemp1,XRADIUS
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	XRADIUS,SysTemp1
	lds	SysTemp1,XRADIUS_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	XRADIUS_H,SysTemp1
;radiusErr = radiusErr + 2 * (yordinate - xradius + 1)
	lds	SysTemp2,YORDINATE
	lds	SysTemp3,XRADIUS
	sub	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	ldi	SysTemp3,0
	lds	SysTemp2,XRADIUS_H
	sbc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp3,1
	add	SysTemp1,SysTemp3
	mov	SysTemp2,SysTemp1
	ldi	SysTemp3,0
	adc	SysTemp1_H,SysTemp3
	mov	SysTemp2_H,SysTemp1_H
	mov	SysINTEGERTempA,SysTemp2
	mov	SysINTEGERTempA_H,SysTemp2_H
	ldi	SysINTEGERTempB,2
	ldi	SysINTEGERTempB_H,0
	call	SysMultSubINT
	lds	SysTemp1,RADIUSERR
	add	SysTemp1,SysINTEGERTempX
	sts	RADIUSERR,SysTemp1
	lds	SysTemp1,RADIUSERR_H
	adc	SysTemp1,SysINTEGERTempX_H
	sts	RADIUSERR_H,SysTemp1
;end if
ENDIF21:
;Loop
	rjmp	SysDoLoop_S3
SysDoLoop_E3:
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (412)
CLEAR_BUFFER_EPD2IN13D:
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
;Dim EPD_Ind_raw as Word
;for EPD_Ind_raw=1 to BUFFWIDTH                 'clear the buffer
	ldi	SysValueCopy,0
	sts	EPD_IND_RAW,SysValueCopy
	sts	EPD_IND_RAW_H,SysValueCopy
SysForLoop14:
	lds	SysTemp1,EPD_IND_RAW
	inc	SysTemp1
	sts	EPD_IND_RAW,SysTemp1
	lds	SysTemp1,EPD_IND_RAW_H
	brne	PC + 2
	inc	SysTemp1
	sts	EPD_IND_RAW_H,SysTemp1
;EPD_Buffer(EPD_Ind_raw)=GLCDBackground
	lds	SysTemp1,EPD_IND_RAW
	ldi	SysTemp3,low(EPD_BUFFER)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	lds	SysTemp1,EPD_IND_RAW_H
	ldi	SysTemp3,high(EPD_BUFFER)
	adc	SysTemp1,SysTemp3
	mov	SysStringA_H,SysTemp1
	lds	SysValueCopy,GLCDBACKGROUND
	st	X,SysValueCopy
;next
	lds	SysWORDTempA,EPD_IND_RAW
	lds	SysWORDTempA_H,EPD_IND_RAW_H
	ldi	SysWORDTempB,106
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop14
SysForLoopEnd14:
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (352)
CLS_EPD2IN13D:
;CLS_EPD2in13D_init
	rcall	CLS_EPD2IN13D_INIT
;Refresh_EPD2in13D
	jmp	REFRESH_EPD2IN13D

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
SysForLoop24:
	lds	SysTemp1,EPD_IND_RAW
	inc	SysTemp1
	sts	EPD_IND_RAW,SysTemp1
	lds	SysTemp1,EPD_IND_RAW_H
	brne	PC + 2
	inc	SysTemp1
	sts	EPD_IND_RAW_H,SysTemp1
;EPD_Buffer(EPD_Ind_raw)=GLCDBackground
	lds	SysTemp1,EPD_IND_RAW
	ldi	SysTemp3,low(EPD_BUFFER)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	lds	SysTemp1,EPD_IND_RAW_H
	ldi	SysTemp3,high(EPD_BUFFER)
	adc	SysTemp1,SysTemp3
	mov	SysStringA_H,SysTemp1
	lds	SysValueCopy,GLCDBACKGROUND
	st	X,SysValueCopy
;next
	lds	SysWORDTempA,EPD_IND_RAW
	lds	SysWORDTempA_H,EPD_IND_RAW_H
	ldi	SysWORDTempB,106
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop24
SysForLoopEnd24:
;Clear down "OLD" data
;SendCommand_EPD2in13D(Data_Transmission_1)
	ldi	SysValueCopy,16
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;wait 2 ms
	ldi	SysWaitTempMS,2
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;for EPD_Ind_raw=1 to GLCD_Height
	ldi	SysValueCopy,0
	sts	EPD_IND_RAW,SysValueCopy
	sts	EPD_IND_RAW_H,SysValueCopy
SysForLoop25:
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
SysForLoop26:
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
;FastHWSPITransfer EPD2in13D_Data
	lds	SysValueCopy,EPD2IN13D_DATA
	sts	SPITXDATA,SysValueCopy
	rcall	FASTHWSPITRANSFER
;SET EPD_CS ON
	sbi	PORTB,2
;next
	lds	SysWORDTempA,EPD_IND_COL
	lds	SysWORDTempA_H,EPD_IND_COL_H
	ldi	SysWORDTempB,104
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop26
SysForLoopEnd26:
;next
	lds	SysWORDTempA,EPD_IND_RAW
	lds	SysWORDTempA_H,EPD_IND_RAW_H
	ldi	SysWORDTempB,212
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop25
SysForLoopEnd25:
;wait 10 ms
	ldi	SysWaitTempMS,10
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Clear down "NEW" data
;SendCommand_EPD2in13D(Data_Transmission_2)
	ldi	SysValueCopy,19
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;wait 2 ms
	ldi	SysWaitTempMS,2
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;for EPD_Ind_raw=1 to GLCD_Height
	ldi	SysValueCopy,0
	sts	EPD_IND_RAW,SysValueCopy
	sts	EPD_IND_RAW_H,SysValueCopy
SysForLoop27:
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
SysForLoop28:
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
;FastHWSPITransfer EPD2in13D_Data
	lds	SysValueCopy,EPD2IN13D_DATA
	sts	SPITXDATA,SysValueCopy
	rcall	FASTHWSPITRANSFER
;SET EPD_CS ON
	sbi	PORTB,2
;next
	lds	SysWORDTempA,EPD_IND_COL
	lds	SysWORDTempA_H,EPD_IND_COL_H
	ldi	SysWORDTempB,104
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop28
SysForLoopEnd28:
;next
	lds	SysWORDTempA,EPD_IND_RAW
	lds	SysWORDTempA_H,EPD_IND_RAW_H
	ldi	SysWORDTempB,212
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop27
SysForLoopEnd27:
;wait 10 ms
	ldi	SysWaitTempMS,10
	ldi	SysWaitTempMS_H,0
	rjmp	Delay_MS

;********************************************************************************

;Source: epd_epd2in13d.h (544)
DRAWCHAR_EPD2IN13D:
;This has got a tad complex
;We have three major pieces
;1 The preamble - this just adjusted color and the input character
;2 The code that deals with GCB fontset
;3 The code that deals with OLED fontset
;
;You can make independent change to section 2 and 3 but they are mutual exclusive with many common pieces
;dim CharCol, CharRow, GLCDTemp as word
;CharCode -= 15
	lds	SysTemp1,CHARCODE
	ldi	SysTemp3,15
	sub	SysTemp1,SysTemp3
	sts	CHARCODE,SysTemp1
;CharCode needs to have 15 subtracted, table starts at char 16 not char 0
;CharCol=0
	ldi	SysValueCopy,0
	sts	CHARCOL,SysValueCopy
	sts	CHARCOL_H,SysValueCopy
;Calculate the pointer to the OLED fonts.
;These fonts are not multiple tables one is a straight list the other is a lookup table with data.
;Dim LocalCharCode as word
;Get key information and set up the fonts parameters
;Select case GLCDfntDefaultSize
;case 1 'This font is two font tables of an index and data
SysSelect1Case1:
	lds	SysCalcTempA,GLCDFNTDEFAULTSIZE
	cpi	SysCalcTempA,1
	brne	SysSelect1Case2
;CharCode = CharCode - 16
	lds	SysTemp1,CHARCODE
	ldi	SysTemp3,16
	sub	SysTemp1,SysTemp3
	sts	CHARCODE,SysTemp1
;ReadTable OLEDFont1Index, CharCode, LocalCharCode
	lds	SYSSTRINGA,CHARCODE
	call	OLEDFONT1INDEX
	sts	LOCALCHARCODE,SysByteTempX
	lds	SYSSTRINGA,CHARCODE
	call	OLEDFONT1INDEX_H
	sts	LOCALCHARCODE_H,SysByteTempX
;ReadTable OLEDFont1Data, LocalCharCode , COLSperfont
	lds	SYSSTRINGA,LOCALCHARCODE
	lds	SYSSTRINGA_H,LOCALCHARCODE_H
	call	OLEDFONT1DATA
	sts	COLSPERFONT,SysByteTempX
;GLCDFontWidth = COLSperfont + 1
	lds	SysTemp1,COLSPERFONT
	inc	SysTemp1
	sts	GLCDFONTWIDTH,SysTemp1
;ROWSperfont = 7  'which is really 8 as we start at 0
	ldi	SysValueCopy,7
	sts	ROWSPERFONT,SysValueCopy
;case 2 'This is one font table
	rjmp	SysSelectEnd1
SysSelect1Case2:
	lds	SysCalcTempA,GLCDFNTDEFAULTSIZE
	cpi	SysCalcTempA,2
	brne	SysSelectEnd1
;CharCode = CharCode - 17
	lds	SysTemp1,CHARCODE
	ldi	SysTemp3,17
	sub	SysTemp1,SysTemp3
	sts	CHARCODE,SysTemp1
;Pointer to table of font elements
;LocalCharCode = (CharCode * 20)
	lds	SysWORDTempA,CHARCODE
	ldi	SysWORDTempA_H,0
	ldi	SysWORDTempB,20
	ldi	SysWORDTempB_H,0
	call	SysMultSub16
	sts	LOCALCHARCODE,SysWORDTempX
	sts	LOCALCHARCODE_H,SysWORDTempX_H
;COLSperfont = 9  'which is really 10 as we start at 0
	ldi	SysValueCopy,9
	sts	COLSPERFONT,SysValueCopy
;ROWSperfont=15  'which is really 16 as we start at 0
	ldi	SysValueCopy,15
	sts	ROWSPERFONT,SysValueCopy
;End Select
SysSelectEnd1:
;The main loop - loop throught the number of columns
;For CurrCharCol = 0 to COLSperfont  'number of columns in the font , with two row of data
	ldi	SysValueCopy,255
	sts	CURRCHARCOL,SysValueCopy
	lds	SysCalcTempA,COLSPERFONT
	cpi	SysCalcTempA,0
	brsh	ENDIF45
	rjmp	SysForLoopEnd15
ENDIF45:
SysForLoop15:
	lds	SysTemp1,CURRCHARCOL
	inc	SysTemp1
	sts	CURRCHARCOL,SysTemp1
;Index the pointer to the code that we are looking for as we need to do this lookup many times getting more font data
;LocalCharCode++
	lds	SysTemp1,LOCALCHARCODE
	inc	SysTemp1
	sts	LOCALCHARCODE,SysTemp1
	lds	SysTemp1,LOCALCHARCODE_H
	brne	PC + 2
	inc	SysTemp1
	sts	LOCALCHARCODE_H,SysTemp1
;Select case GLCDfntDefaultSize
;case 1
SysSelect2Case1:
	lds	SysCalcTempA,GLCDFNTDEFAULTSIZE
	cpi	SysCalcTempA,1
	brne	SysSelect2Case2
;ReadTable OLEDFont1Data, LocalCharCode, CurrCharVal
	lds	SYSSTRINGA,LOCALCHARCODE
	lds	SYSSTRINGA_H,LOCALCHARCODE_H
	call	OLEDFONT1DATA
	sts	CURRCHARVAL,SysByteTempX
;case 2
	rjmp	SysSelectEnd2
SysSelect2Case2:
	lds	SysCalcTempA,GLCDFNTDEFAULTSIZE
	cpi	SysCalcTempA,2
	brne	SysSelectEnd2
;Read this 20 times... (0..COLSperfont) [ * 2 ]
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	lds	SYSSTRINGA,LOCALCHARCODE
	lds	SYSSTRINGA_H,LOCALCHARCODE_H
	call	OLEDFONT2
	sts	CURRCHARVAL,SysByteTempX
;End Select
SysSelectEnd2:
;we handle 8 or 16 pixels of height
;For CurrCharRow = 0 to ROWSperfont
	ldi	SysValueCopy,255
	sts	CURRCHARROW,SysValueCopy
	lds	SysCalcTempA,ROWSPERFONT
	cpi	SysCalcTempA,0
	brsh	ENDIF46
	rjmp	SysForLoopEnd16
ENDIF46:
SysForLoop16:
	lds	SysTemp1,CURRCHARROW
	inc	SysTemp1
	sts	CURRCHARROW,SysTemp1
;Set the pixel
;If CurrCharVal.0 = 0 Then
	lds	SysBitTest,CURRCHARVAL
	sbrc	SysBitTest,0
	rjmp	ELSE47_1
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, GLCDBACKGROUND
	lds	SysTemp1,CHARLOCX
	lds	SysTemp2,CURRCHARCOL
	add	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,CHARLOCX_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	GLCDX_H,SysTemp1
	lds	SysTemp1,CHARLOCY
	lds	SysTemp2,CURRCHARROW
	add	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysTemp1,CHARLOCY_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	GLCDY_H,SysTemp1
	lds	SysValueCopy,GLCDBACKGROUND
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDBACKGROUND_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;Else
	rjmp	ENDIF47
ELSE47_1:
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, LineColour
	lds	SysTemp1,CHARLOCX
	lds	SysTemp2,CURRCHARCOL
	add	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,CHARLOCX_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	GLCDX_H,SysTemp1
	lds	SysTemp1,CHARLOCY
	lds	SysTemp2,CURRCHARROW
	add	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysTemp1,CHARLOCY_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	GLCDY_H,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;End If
ENDIF47:
;Rotate CurrCharVal Right
	lds	SysValueCopy,CURRCHARVAL
	ror	SysValueCopy
	sts	CURRCHARVAL,SysValueCopy
;Set to next row of date, a second row
;if GLCDfntDefaultSize = 2 and CurrCharRow = 7 then
	lds	SysBYTETempA,GLCDFNTDEFAULTSIZE
	ldi	SysBYTETempB,2
	call	SysCompEqual
	mov	SysTemp1,SysByteTempX
	lds	SysBYTETempA,CURRCHARROW
	ldi	SysBYTETempB,7
	call	SysCompEqual
	mov	SysTemp3,SysByteTempX
	and	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	sbrs	SysTemp2,0
	rjmp	ENDIF48
;LocalCharCode++
	lds	SysTemp1,LOCALCHARCODE
	inc	SysTemp1
	sts	LOCALCHARCODE,SysTemp1
	lds	SysTemp1,LOCALCHARCODE_H
	brne	PC + 2
	inc	SysTemp1
	sts	LOCALCHARCODE_H,SysTemp1
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	lds	SYSSTRINGA,LOCALCHARCODE
	lds	SYSSTRINGA_H,LOCALCHARCODE_H
	call	OLEDFONT2
	sts	CURRCHARVAL,SysByteTempX
;end if
ENDIF48:
;It is the intercharacter space, put out one pixel row
;if CurrCharCol = COLSperfont then
	lds	SysCalcTempA,CURRCHARCOL
	lds	SysCalcTempB,COLSPERFONT
	cp	SysCalcTempA,SysCalcTempB
	brne	ENDIF49
;Put out a white intercharacter pixel/space
;GLCDTemp = CharLocX + CurrCharCol
	lds	SysTemp1,CHARLOCX
	lds	SysTemp2,CURRCHARCOL
	add	SysTemp1,SysTemp2
	sts	GLCDTEMP,SysTemp1
	lds	SysTemp1,CHARLOCX_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	GLCDTEMP_H,SysTemp1
;if GLCDfntDefaultSize = 2 then
	lds	SysCalcTempA,GLCDFNTDEFAULTSIZE
	cpi	SysCalcTempA,2
	brne	ENDIF52
;GLCDTemp++
	lds	SysTemp1,GLCDTEMP
	inc	SysTemp1
	sts	GLCDTEMP,SysTemp1
	lds	SysTemp1,GLCDTEMP_H
	brne	PC + 2
	inc	SysTemp1
	sts	GLCDTEMP_H,SysTemp1
;end if
ENDIF52:
;PSet GLCDTemp , CharLocY + CurrCharRow, GLCDBACKGROUND
	lds	SysValueCopy,GLCDTEMP
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,GLCDTEMP_H
	sts	GLCDX_H,SysValueCopy
	lds	SysTemp1,CHARLOCY
	lds	SysTemp2,CURRCHARROW
	add	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysTemp1,CHARLOCY_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	GLCDY_H,SysTemp1
	lds	SysValueCopy,GLCDBACKGROUND
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDBACKGROUND_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;end if
ENDIF49:
;Next
	lds	SysCalcTempA,CURRCHARROW
	lds	SysCalcTempB,ROWSPERFONT
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF50
	rjmp	SysForLoop16
ENDIF50:
SysForLoopEnd16:
;Next
	lds	SysCalcTempA,CURRCHARCOL
	lds	SysCalcTempB,COLSPERFONT
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF51
	rjmp	SysForLoop15
ENDIF51:
SysForLoopEnd15:
	ret

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

Delay_S:
DS_START:
	ldi	SysWaitTempMS,232
	ldi	SysWaitTempMS_H,3
	rcall	Delay_MS
	dec	SysWaitTempS
	brne	DS_START
	ret

;********************************************************************************

;Source: hwspi.h (665)
FASTHWSPITRANSFER:
;Master mode only
;Master mode only
;Do
SysDoLoop_S7:
;SPDR = SPITxData
	lds	SysValueCopy,SPITXDATA
	out	SPDR,SysValueCopy
;Loop While SPSR.WCOL
	in	SysBitTest,SPSR
	sbrc	SysBitTest,WCOL
	rjmp	SysDoLoop_S7
SysDoLoop_E7:
;Read buffer
;Same for master and slave
;Wait While SPSR.SPIF = Off
SysWaitLoop1:
	in	SysBitTest,SPSR
	sbrs	SysBitTest,SPIF
	rjmp	SysWaitLoop1
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (797)
FILLEDBOX_EPD2IN13D:
;Make sure that starting point (1) is always less than end point (2)
;Dim EPD_Ind_raw, EPD_Ind_col as Word
;If LineX1 > LineX2 Then
	lds	SysWORDTempB,LINEX1
	lds	SysWORDTempB_H,LINEX1_H
	lds	SysWORDTempA,LINEX2
	lds	SysWORDTempA_H,LINEX2_H
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF57
;GLCDTemp = LineX1
	lds	SysValueCopy,LINEX1
	sts	GLCDTEMP,SysValueCopy
;LineX1 = LineX2
	lds	SysValueCopy,LINEX2
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,LINEX2_H
	sts	LINEX1_H,SysValueCopy
;LineX2 = GLCDTemp
	lds	SysValueCopy,GLCDTEMP
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX2_H,SysValueCopy
;End If
ENDIF57:
;If LineY1 > LineY2 Then
	lds	SysWORDTempB,LINEY1
	lds	SysWORDTempB_H,LINEY1_H
	lds	SysWORDTempA,LINEY2
	lds	SysWORDTempA_H,LINEY2_H
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF58
;GLCDTemp = LineY1
	lds	SysValueCopy,LINEY1
	sts	GLCDTEMP,SysValueCopy
;LineY1 = LineY2
	lds	SysValueCopy,LINEY2
	sts	LINEY1,SysValueCopy
	lds	SysValueCopy,LINEY2_H
	sts	LINEY1_H,SysValueCopy
;LineY2 = GLCDTemp
	lds	SysValueCopy,GLCDTEMP
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
;End If
ENDIF58:
;for EPD_Ind_raw=LineY1  to LineY2
	lds	SysTemp1,LINEY1
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	EPD_IND_RAW,SysTemp1
	lds	SysTemp1,LINEY1_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	EPD_IND_RAW_H,SysTemp1
	lds	SysWORDTempB,LINEY1
	lds	SysWORDTempB_H,LINEY1_H
	lds	SysWORDTempA,LINEY2
	lds	SysWORDTempA_H,LINEY2_H
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoopEnd17
SysForLoop17:
	lds	SysTemp1,EPD_IND_RAW
	inc	SysTemp1
	sts	EPD_IND_RAW,SysTemp1
	lds	SysTemp1,EPD_IND_RAW_H
	brne	PC + 2
	inc	SysTemp1
	sts	EPD_IND_RAW_H,SysTemp1
;for EPD_Ind_col=LineX1 to lineX2
	lds	SysTemp1,LINEX1
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	EPD_IND_COL,SysTemp1
	lds	SysTemp1,LINEX1_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	EPD_IND_COL_H,SysTemp1
	lds	SysWORDTempB,LINEX1
	lds	SysWORDTempB_H,LINEX1_H
	lds	SysWORDTempA,LINEX2
	lds	SysWORDTempA_H,LINEX2_H
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoopEnd18
SysForLoop18:
	lds	SysTemp1,EPD_IND_COL
	inc	SysTemp1
	sts	EPD_IND_COL,SysTemp1
	lds	SysTemp1,EPD_IND_COL_H
	brne	PC + 2
	inc	SysTemp1
	sts	EPD_IND_COL_H,SysTemp1
;PSet_EPD2in13D(EPD_Ind_Col, EPD_Ind_raw, LineColour)
	lds	SysValueCopy,EPD_IND_COL
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,EPD_IND_COL_H
	sts	GLCDX_H,SysValueCopy
	lds	SysValueCopy,EPD_IND_RAW
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,EPD_IND_RAW_H
	sts	GLCDY_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;next
	lds	SysWORDTempA,EPD_IND_COL
	lds	SysWORDTempA_H,EPD_IND_COL_H
	lds	SysWORDTempB,LINEX2
	lds	SysWORDTempB_H,LINEX2_H
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop18
SysForLoopEnd18:
;next
	lds	SysWORDTempA,EPD_IND_RAW
	lds	SysWORDTempA_H,EPD_IND_RAW_H
	lds	SysWORDTempB,LINEY2
	lds	SysWORDTempB_H,LINEY2_H
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop17
SysForLoopEnd17:
	ret

;********************************************************************************

;Source: glcd.h (4073)
FILLEDTRIANGLE:
;dim  GLCD_aa, GLCD_bb, GLCD_last as word
;Sort coordinates by Y order (yoffset3 >= yoffset2 >= yoffset)
;if (yoffset > yoffset2) then
	lds	SysWORDTempB,YOFFSET
	lds	SysWORDTempB_H,YOFFSET_H
	lds	SysWORDTempA,YOFFSET2
	lds	SysWORDTempA_H,YOFFSET2_H
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF27
;swap(yoffset, yoffset2)
	lds	SYSCALCTEMPA,YOFFSET
	lds	SYSCALCTEMPA_H,YOFFSET_H
	lds	SYSCALCTEMPB,YOFFSET2
	lds	SYSCALCTEMPB_H,YOFFSET2_H
	call	SWAP510
	sts	YOFFSET,SYSCALCTEMPA
	sts	YOFFSET_H,SYSCALCTEMPA_H
	sts	YOFFSET2,SYSCALCTEMPB
	sts	YOFFSET2_H,SYSCALCTEMPB_H
;swap(xoffset, xoffset2)
	lds	SYSCALCTEMPA,XOFFSET
	lds	SYSCALCTEMPA_H,XOFFSET_H
	lds	SYSCALCTEMPB,XOFFSET2
	lds	SYSCALCTEMPB_H,XOFFSET2_H
	call	SWAP510
	sts	XOFFSET,SYSCALCTEMPA
	sts	XOFFSET_H,SYSCALCTEMPA_H
	sts	XOFFSET2,SYSCALCTEMPB
	sts	XOFFSET2_H,SYSCALCTEMPB_H
;end if
ENDIF27:
;if (yoffset2 > yoffset3) then
	lds	SysWORDTempB,YOFFSET2
	lds	SysWORDTempB_H,YOFFSET2_H
	lds	SysWORDTempA,YOFFSET3
	lds	SysWORDTempA_H,YOFFSET3_H
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF28
;swap(yoffset3, yoffset2)
	lds	SYSCALCTEMPA,YOFFSET3
	lds	SYSCALCTEMPA_H,YOFFSET3_H
	lds	SYSCALCTEMPB,YOFFSET2
	lds	SYSCALCTEMPB_H,YOFFSET2_H
	call	SWAP510
	sts	YOFFSET3,SYSCALCTEMPA
	sts	YOFFSET3_H,SYSCALCTEMPA_H
	sts	YOFFSET2,SYSCALCTEMPB
	sts	YOFFSET2_H,SYSCALCTEMPB_H
;swap(xoffset3, xoffset2)
	lds	SYSCALCTEMPA,XOFFSET3
	lds	SYSCALCTEMPA_H,XOFFSET3_H
	lds	SYSCALCTEMPB,XOFFSET2
	lds	SYSCALCTEMPB_H,XOFFSET2_H
	call	SWAP510
	sts	XOFFSET3,SYSCALCTEMPA
	sts	XOFFSET3_H,SYSCALCTEMPA_H
	sts	XOFFSET2,SYSCALCTEMPB
	sts	XOFFSET2_H,SYSCALCTEMPB_H
;end if
ENDIF28:
;if (yoffset > yoffset2) then
	lds	SysWORDTempB,YOFFSET
	lds	SysWORDTempB_H,YOFFSET_H
	lds	SysWORDTempA,YOFFSET2
	lds	SysWORDTempA_H,YOFFSET2_H
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF29
;swap(yoffset, yoffset2)
	lds	SYSCALCTEMPA,YOFFSET
	lds	SYSCALCTEMPA_H,YOFFSET_H
	lds	SYSCALCTEMPB,YOFFSET2
	lds	SYSCALCTEMPB_H,YOFFSET2_H
	call	SWAP510
	sts	YOFFSET,SYSCALCTEMPA
	sts	YOFFSET_H,SYSCALCTEMPA_H
	sts	YOFFSET2,SYSCALCTEMPB
	sts	YOFFSET2_H,SYSCALCTEMPB_H
;swap(xoffset, xoffset2)
	lds	SYSCALCTEMPA,XOFFSET
	lds	SYSCALCTEMPA_H,XOFFSET_H
	lds	SYSCALCTEMPB,XOFFSET2
	lds	SYSCALCTEMPB_H,XOFFSET2_H
	call	SWAP510
	sts	XOFFSET,SYSCALCTEMPA
	sts	XOFFSET_H,SYSCALCTEMPA_H
	sts	XOFFSET2,SYSCALCTEMPB
	sts	XOFFSET2_H,SYSCALCTEMPB_H
;end if
ENDIF29:
;Handle awkward all-on-same-line case as its own thing
;if (yoffset = yoffset3) then
	lds	SysWORDTempA,YOFFSET
	lds	SysWORDTempA_H,YOFFSET_H
	lds	SysWORDTempB,YOFFSET3
	lds	SysWORDTempB_H,YOFFSET3_H
	call	SysCompEqual16
	sbrs	SysByteTempX,0
	rjmp	ENDIF30
;GLCD_bb = xoffset
	lds	SysValueCopy,XOFFSET
	sts	GLCD_BB,SysValueCopy
	lds	SysValueCopy,XOFFSET_H
	sts	GLCD_BB_H,SysValueCopy
;GLCD_aa = xoffset
	lds	SysValueCopy,XOFFSET
	sts	GLCD_AA,SysValueCopy
	lds	SysValueCopy,XOFFSET_H
	sts	GLCD_AA_H,SysValueCopy
;if (xoffset2 < GLCD_aa ) Then
	lds	SysWORDTempA,XOFFSET2
	lds	SysWORDTempA_H,XOFFSET2_H
	lds	SysWORDTempB,GLCD_AA
	lds	SysWORDTempB_H,GLCD_AA_H
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ELSE38_1
;GLCD_aa = xoffset2
	lds	SysValueCopy,XOFFSET2
	sts	GLCD_AA,SysValueCopy
	lds	SysValueCopy,XOFFSET2_H
	sts	GLCD_AA_H,SysValueCopy
;else if (xoffset2 > GLCD_bb ) then
	rjmp	ENDIF38
ELSE38_1:
	lds	SysWORDTempB,XOFFSET2
	lds	SysWORDTempB_H,XOFFSET2_H
	lds	SysWORDTempA,GLCD_BB
	lds	SysWORDTempA_H,GLCD_BB_H
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF38
;GLCD_bb = xoffset2
	lds	SysValueCopy,XOFFSET2
	sts	GLCD_BB,SysValueCopy
	lds	SysValueCopy,XOFFSET2_H
	sts	GLCD_BB_H,SysValueCopy
;end if
ENDIF38:
;if (xoffset3 < GLCD_aa) Then
	lds	SysWORDTempA,XOFFSET3
	lds	SysWORDTempA_H,XOFFSET3_H
	lds	SysWORDTempB,GLCD_AA
	lds	SysWORDTempB_H,GLCD_AA_H
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ELSE39_1
;GLCD_aa = xoffset3
	lds	SysValueCopy,XOFFSET3
	sts	GLCD_AA,SysValueCopy
	lds	SysValueCopy,XOFFSET3_H
	sts	GLCD_AA_H,SysValueCopy
;else if ( xoffset3 > GLCD_bb) then
	rjmp	ENDIF39
ELSE39_1:
	lds	SysWORDTempB,XOFFSET3
	lds	SysWORDTempB_H,XOFFSET3_H
	lds	SysWORDTempA,GLCD_BB
	lds	SysWORDTempA_H,GLCD_BB_H
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF39
;GLCD_bb = xoffset3
	lds	SysValueCopy,XOFFSET3
	sts	GLCD_BB,SysValueCopy
	lds	SysValueCopy,XOFFSET3_H
	sts	GLCD_BB_H,SysValueCopy
;end if
ENDIF39:
;Line( GLCD_aa, yoffset, GLCD_bb - GLCD_aa + 1, yoffset, LineColour)
	lds	SysValueCopy,GLCD_AA
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,GLCD_AA_H
	sts	LINEX1_H,SysValueCopy
	lds	SysValueCopy,YOFFSET
	sts	LINEY1,SysValueCopy
	lds	SysValueCopy,YOFFSET_H
	sts	LINEY1_H,SysValueCopy
	lds	SysTemp2,GLCD_BB
	lds	SysTemp3,GLCD_AA
	sub	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,GLCD_BB_H
	lds	SysTemp3,GLCD_AA_H
	sbc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	ldi	SysTemp3,1
	add	SysTemp1,SysTemp3
	sts	LINEX2,SysTemp1
	ldi	SysTemp3,0
	adc	SysTemp1_H,SysTemp3
	sts	LINEX2_H,SysTemp1_H
	lds	SysValueCopy,YOFFSET
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,YOFFSET_H
	sts	LINEY2_H,SysValueCopy
	rcall	LINE
;exit sub
	ret
;end if
ENDIF30:
;dim dxoffset01, dyoffset01, dxoffset02, dyoffset02, dxoffset12, dyoffset12, glcd_y as word
;dim glcd_sa, glcd_sb as Integer
;dxoffset01 = xoffset2 - xoffset
	lds	SysTemp1,XOFFSET2
	lds	SysTemp2,XOFFSET
	sub	SysTemp1,SysTemp2
	sts	DXOFFSET01,SysTemp1
	lds	SysTemp1,XOFFSET2_H
	lds	SysTemp2,XOFFSET_H
	sbc	SysTemp1,SysTemp2
	sts	DXOFFSET01_H,SysTemp1
;dyoffset01 = yoffset2 - yoffset
	lds	SysTemp1,YOFFSET2
	lds	SysTemp2,YOFFSET
	sub	SysTemp1,SysTemp2
	sts	DYOFFSET01,SysTemp1
	lds	SysTemp1,YOFFSET2_H
	lds	SysTemp2,YOFFSET_H
	sbc	SysTemp1,SysTemp2
	sts	DYOFFSET01_H,SysTemp1
;dxoffset02 = xoffset3 - xoffset
	lds	SysTemp1,XOFFSET3
	lds	SysTemp2,XOFFSET
	sub	SysTemp1,SysTemp2
	sts	DXOFFSET02,SysTemp1
	lds	SysTemp1,XOFFSET3_H
	lds	SysTemp2,XOFFSET_H
	sbc	SysTemp1,SysTemp2
	sts	DXOFFSET02_H,SysTemp1
;dyoffset02 = yoffset3 - yoffset
	lds	SysTemp1,YOFFSET3
	lds	SysTemp2,YOFFSET
	sub	SysTemp1,SysTemp2
	sts	DYOFFSET02,SysTemp1
	lds	SysTemp1,YOFFSET3_H
	lds	SysTemp2,YOFFSET_H
	sbc	SysTemp1,SysTemp2
	sts	DYOFFSET02_H,SysTemp1
;dxoffset12 = xoffset3 - xoffset2
	lds	SysTemp1,XOFFSET3
	lds	SysTemp2,XOFFSET2
	sub	SysTemp1,SysTemp2
	sts	DXOFFSET12,SysTemp1
	lds	SysTemp1,XOFFSET3_H
	lds	SysTemp2,XOFFSET2_H
	sbc	SysTemp1,SysTemp2
	sts	DXOFFSET12_H,SysTemp1
;dyoffset12 = yoffset3 - yoffset2
	lds	SysTemp1,YOFFSET3
	lds	SysTemp2,YOFFSET2
	sub	SysTemp1,SysTemp2
	sts	DYOFFSET12,SysTemp1
	lds	SysTemp1,YOFFSET3_H
	lds	SysTemp2,YOFFSET2_H
	sbc	SysTemp1,SysTemp2
	sts	DYOFFSET12_H,SysTemp1
;glcd_sa   = 0
	ldi	SysValueCopy,0
	sts	GLCD_SA,SysValueCopy
	sts	GLCD_SA_H,SysValueCopy
;glcd_sb   = 0
	ldi	SysValueCopy,0
	sts	GLCD_SB,SysValueCopy
	sts	GLCD_SB_H,SysValueCopy
;
;For upper part of triangle, find scanline crossings for segments
;0-1 and 0-2.  If yoffset2=yoffset3 (flat-bottomed triangle), the scanline yoffset2
;is included here (and second loop will be skipped, avoiding a /0
;error there), otherwise scanline yoffset2 is skipped here and handled
;in the second loop...which also avoids a /0 error here if yoffset=yoffset2
;(flat-topped triangle).
;if ( yoffset2 = yoffset3) then
	lds	SysWORDTempA,YOFFSET2
	lds	SysWORDTempA_H,YOFFSET2_H
	lds	SysWORDTempB,YOFFSET3
	lds	SysWORDTempB_H,YOFFSET3_H
	call	SysCompEqual16
	sbrs	SysByteTempX,0
	rjmp	ELSE31_1
;GLCD_last = yoffset2 ;   Include yoffset2 scanline
	lds	SysValueCopy,YOFFSET2
	sts	GLCD_LAST,SysValueCopy
	lds	SysValueCopy,YOFFSET2_H
	sts	GLCD_LAST_H,SysValueCopy
;else
	rjmp	ENDIF31
ELSE31_1:
;GLCD_last = yoffset2 - 1;  Skip it
	lds	SysTemp1,YOFFSET2
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	GLCD_LAST,SysTemp1
	lds	SysTemp1,YOFFSET2_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	GLCD_LAST_H,SysTemp1
;end if
ENDIF31:
;for glcd_y = yoffset to glcd_last
	lds	SysTemp1,YOFFSET
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	GLCD_Y,SysTemp1
	lds	SysTemp1,YOFFSET_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	GLCD_Y_H,SysTemp1
	lds	SysWORDTempB,YOFFSET
	lds	SysWORDTempB_H,YOFFSET_H
	lds	SysWORDTempA,GLCD_LAST
	lds	SysWORDTempA_H,GLCD_LAST_H
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoopEnd9
SysForLoop9:
	lds	SysTemp1,GLCD_Y
	inc	SysTemp1
	sts	GLCD_Y,SysTemp1
	lds	SysTemp1,GLCD_Y_H
	brne	PC + 2
	inc	SysTemp1
	sts	GLCD_Y_H,SysTemp1
;glcd_aa   = xoffset +  glcd_sa / dyoffset01
	lds	SysINTEGERTempA,GLCD_SA
	lds	SysINTEGERTempA_H,GLCD_SA_H
	lds	SysINTEGERTempB,DYOFFSET01
	lds	SysINTEGERTempB_H,DYOFFSET01_H
	call	SysDivSubINT
	lds	SysTemp1,XOFFSET
	add	SysTemp1,SysINTEGERTempA
	sts	GLCD_AA,SysTemp1
	lds	SysTemp1,XOFFSET_H
	adc	SysTemp1,SysINTEGERTempA_H
	sts	GLCD_AA_H,SysTemp1
;glcd_bb   = xoffset +  glcd_sb / dyoffset02
	lds	SysINTEGERTempA,GLCD_SB
	lds	SysINTEGERTempA_H,GLCD_SB_H
	lds	SysINTEGERTempB,DYOFFSET02
	lds	SysINTEGERTempB_H,DYOFFSET02_H
	call	SysDivSubINT
	lds	SysTemp1,XOFFSET
	add	SysTemp1,SysINTEGERTempA
	sts	GLCD_BB,SysTemp1
	lds	SysTemp1,XOFFSET_H
	adc	SysTemp1,SysINTEGERTempA_H
	sts	GLCD_BB_H,SysTemp1
;glcd_sa = glcd_sa + dxoffset01
	lds	SysTemp1,GLCD_SA
	lds	SysTemp2,DXOFFSET01
	add	SysTemp1,SysTemp2
	sts	GLCD_SA,SysTemp1
	lds	SysTemp1,GLCD_SA_H
	lds	SysTemp2,DXOFFSET01_H
	adc	SysTemp1,SysTemp2
	sts	GLCD_SA_H,SysTemp1
;glcd_sb = glcd_sb + dxoffset02
	lds	SysTemp1,GLCD_SB
	lds	SysTemp2,DXOFFSET02
	add	SysTemp1,SysTemp2
	sts	GLCD_SB,SysTemp1
	lds	SysTemp1,GLCD_SB_H
	lds	SysTemp2,DXOFFSET02_H
	adc	SysTemp1,SysTemp2
	sts	GLCD_SB_H,SysTemp1
;if (glcd_aa > glcd_bb)  then
	lds	SysWORDTempB,GLCD_AA
	lds	SysWORDTempB_H,GLCD_AA_H
	lds	SysWORDTempA,GLCD_BB
	lds	SysWORDTempA_H,GLCD_BB_H
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF33
;swap(glcd_aa, glcd_bb)
	lds	SYSCALCTEMPA,GLCD_AA
	lds	SYSCALCTEMPA_H,GLCD_AA_H
	lds	SYSCALCTEMPB,GLCD_BB
	lds	SYSCALCTEMPB_H,GLCD_BB_H
	call	SWAP510
	sts	GLCD_AA,SYSCALCTEMPA
	sts	GLCD_AA_H,SYSCALCTEMPA_H
	sts	GLCD_BB,SYSCALCTEMPB
	sts	GLCD_BB_H,SYSCALCTEMPB_H
;end if
ENDIF33:
;Line(glcd_aa, glcd_y, glcd_bb , glcd_y, LineColour)
	lds	SysValueCopy,GLCD_AA
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,GLCD_AA_H
	sts	LINEX1_H,SysValueCopy
	lds	SysValueCopy,GLCD_Y
	sts	LINEY1,SysValueCopy
	lds	SysValueCopy,GLCD_Y_H
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,GLCD_BB
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,GLCD_BB_H
	sts	LINEX2_H,SysValueCopy
	lds	SysValueCopy,GLCD_Y
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,GLCD_Y_H
	sts	LINEY2_H,SysValueCopy
	rcall	LINE
;next
	lds	SysWORDTempA,GLCD_Y
	lds	SysWORDTempA_H,GLCD_Y_H
	lds	SysWORDTempB,GLCD_LAST
	lds	SysWORDTempB_H,GLCD_LAST_H
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop9
SysForLoopEnd9:
;For lower part of triangle, find scanline crossings for segments
;0-2 and 1-2.  This loop is skipped if yoffset2=yoffset3.
;glcd_sa = dxoffset12 * (glcd_y - yoffset2);
	lds	SysTemp2,GLCD_Y
	lds	SysTemp3,YOFFSET2
	sub	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,GLCD_Y_H
	lds	SysTemp3,YOFFSET2_H
	sbc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	lds	SysINTEGERTempA,DXOFFSET12
	lds	SysINTEGERTempA_H,DXOFFSET12_H
	mov	SysINTEGERTempB,SysTemp1
	mov	SysINTEGERTempB_H,SysTemp1_H
	call	SysMultSubINT
	sts	GLCD_SA,SysINTEGERTempX
	sts	GLCD_SA_H,SysINTEGERTempX_H
;glcd_sb = dxoffset02 * (glcd_y - yoffset);
	lds	SysTemp2,GLCD_Y
	lds	SysTemp3,YOFFSET
	sub	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,GLCD_Y_H
	lds	SysTemp3,YOFFSET_H
	sbc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	lds	SysINTEGERTempA,DXOFFSET02
	lds	SysINTEGERTempA_H,DXOFFSET02_H
	mov	SysINTEGERTempB,SysTemp1
	mov	SysINTEGERTempB_H,SysTemp1_H
	call	SysMultSubINT
	sts	GLCD_SB,SysINTEGERTempX
	sts	GLCD_SB_H,SysINTEGERTempX_H
;for glcd_y = glcd_last to yoffset3
	lds	SysTemp1,GLCD_LAST
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	GLCD_Y,SysTemp1
	lds	SysTemp1,GLCD_LAST_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	GLCD_Y_H,SysTemp1
	lds	SysWORDTempB,GLCD_LAST
	lds	SysWORDTempB_H,GLCD_LAST_H
	lds	SysWORDTempA,YOFFSET3
	lds	SysWORDTempA_H,YOFFSET3_H
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoopEnd10
SysForLoop10:
	lds	SysTemp1,GLCD_Y
	inc	SysTemp1
	sts	GLCD_Y,SysTemp1
	lds	SysTemp1,GLCD_Y_H
	brne	PC + 2
	inc	SysTemp1
	sts	GLCD_Y_H,SysTemp1
;glcd_aa   = xoffset2 +  glcd_sa / dyoffset12
	lds	SysINTEGERTempA,GLCD_SA
	lds	SysINTEGERTempA_H,GLCD_SA_H
	lds	SysINTEGERTempB,DYOFFSET12
	lds	SysINTEGERTempB_H,DYOFFSET12_H
	call	SysDivSubINT
	lds	SysTemp1,XOFFSET2
	add	SysTemp1,SysINTEGERTempA
	sts	GLCD_AA,SysTemp1
	lds	SysTemp1,XOFFSET2_H
	adc	SysTemp1,SysINTEGERTempA_H
	sts	GLCD_AA_H,SysTemp1
;glcd_bb   = xoffset +  glcd_sb / dyoffset02
	lds	SysINTEGERTempA,GLCD_SB
	lds	SysINTEGERTempA_H,GLCD_SB_H
	lds	SysINTEGERTempB,DYOFFSET02
	lds	SysINTEGERTempB_H,DYOFFSET02_H
	call	SysDivSubINT
	lds	SysTemp1,XOFFSET
	add	SysTemp1,SysINTEGERTempA
	sts	GLCD_BB,SysTemp1
	lds	SysTemp1,XOFFSET_H
	adc	SysTemp1,SysINTEGERTempA_H
	sts	GLCD_BB_H,SysTemp1
;glcd_sa = glcd_sa + dxoffset12
	lds	SysTemp1,GLCD_SA
	lds	SysTemp2,DXOFFSET12
	add	SysTemp1,SysTemp2
	sts	GLCD_SA,SysTemp1
	lds	SysTemp1,GLCD_SA_H
	lds	SysTemp2,DXOFFSET12_H
	adc	SysTemp1,SysTemp2
	sts	GLCD_SA_H,SysTemp1
;glcd_sb = glcd_sb + dxoffset02
	lds	SysTemp1,GLCD_SB
	lds	SysTemp2,DXOFFSET02
	add	SysTemp1,SysTemp2
	sts	GLCD_SB,SysTemp1
	lds	SysTemp1,GLCD_SB_H
	lds	SysTemp2,DXOFFSET02_H
	adc	SysTemp1,SysTemp2
	sts	GLCD_SB_H,SysTemp1
;if (glcd_aa > glcd_bb)  then
	lds	SysWORDTempB,GLCD_AA
	lds	SysWORDTempB_H,GLCD_AA_H
	lds	SysWORDTempA,GLCD_BB
	lds	SysWORDTempA_H,GLCD_BB_H
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF36
;swap(glcd_aa, glcd_bb)
	lds	SYSCALCTEMPA,GLCD_AA
	lds	SYSCALCTEMPA_H,GLCD_AA_H
	lds	SYSCALCTEMPB,GLCD_BB
	lds	SYSCALCTEMPB_H,GLCD_BB_H
	call	SWAP510
	sts	GLCD_AA,SYSCALCTEMPA
	sts	GLCD_AA_H,SYSCALCTEMPA_H
	sts	GLCD_BB,SYSCALCTEMPB
	sts	GLCD_BB_H,SYSCALCTEMPB_H
;end if
ENDIF36:
;Line(glcd_aa, glcd_y, glcd_bb , glcd_y, LineColour)
	lds	SysValueCopy,GLCD_AA
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,GLCD_AA_H
	sts	LINEX1_H,SysValueCopy
	lds	SysValueCopy,GLCD_Y
	sts	LINEY1,SysValueCopy
	lds	SysValueCopy,GLCD_Y_H
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,GLCD_BB
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,GLCD_BB_H
	sts	LINEX2_H,SysValueCopy
	lds	SysValueCopy,GLCD_Y
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,GLCD_Y_H
	sts	LINEY2_H,SysValueCopy
	rcall	LINE
;next
	lds	SysWORDTempA,GLCD_Y
	lds	SysWORDTempA_H,GLCD_Y_H
	lds	SysWORDTempB,YOFFSET3
	lds	SysWORDTempB_H,YOFFSET3_H
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop10
SysForLoopEnd10:
	ret

;********************************************************************************

;Source: glcd.h (1129)
GLCDLOCATESTRING:
;dim PrintLocY as word
;if PrintLocY < 2 then
	lds	SysWORDTempA,PRINTLOCY
	lds	SysWORDTempA_H,PRINTLOCY_H
	ldi	SysWORDTempB,2
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ELSE14_1
;PrintLocY = 0
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
;else
	rjmp	ENDIF14
ELSE14_1:
;PrintLocY--
	lds	SysTemp1,PRINTLOCY
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	PRINTLOCY,SysTemp1
	lds	SysTemp1,PRINTLOCY_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	PRINTLOCY_H,SysTemp1
;PrintLocY = ( PrintLocY * ( GLCDfntDefaultHeight * GLCDfntDefaultSize ) ) mod EPD_CORRECTED_HEIGHT
	lds	SysBYTETempA,GLCDFNTDEFAULTHEIGHT
	lds	SysBYTETempB,GLCDFNTDEFAULTSIZE
	mul	SysByteTempA,SysByteTempB
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempA,PRINTLOCY
	lds	SysWORDTempA_H,PRINTLOCY_H
	mov	SysWORDTempB,SysTemp1
	ldi	SysWORDTempB_H,0
	call	SysMultSub16
	mov	SysTemp2,SysWORDTempX
	mov	SysTemp2_H,SysWORDTempX_H
	mov	SysWORDTempA,SysTemp2
	mov	SysWORDTempA_H,SysTemp2_H
	ldi	SysWORDTempB,208
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	PRINTLOCY,SysWORDTempX
	sts	PRINTLOCY_H,SysWORDTempX_H
;end if
ENDIF14:
	ret

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:, Source: glcd.h (850)
GLCDPRINT4:
;GLCD.h Sub GLCDPrint
;Dim GLCDPrintLoc  as word
;Dim GLCDPrint_String_Counter, GLCDPrintLen as byte
;GLCDPrintLen = LCDPrintData(0)
	lds	SysStringA,SysLCDPRINTDATAHandler
	lds	SysStringA_H,SysLCDPRINTDATAHandler_H
	ld	SysValueCopy,X
	sts	GLCDPRINTLEN,SysValueCopy
;If GLCDPrintLen = 0 Then Exit Sub
	lds	SysCalcTempA,GLCDPRINTLEN
	tst	SysCalcTempA
	brne	ENDIF11
	ret
ENDIF11:
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	lds	SysValueCopy,GLCDFONTWIDTH
	sts	OLDGLCDFONTWIDTH,SysValueCopy
;GLCDPrintLoc = PrintLocX
	lds	SysValueCopy,PRINTLOCX
	sts	GLCDPRINTLOC,SysValueCopy
	lds	SysValueCopy,PRINTLOCX_H
	sts	GLCDPRINTLOC_H,SysValueCopy
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
	ldi	SysValueCopy,0
	sts	GLCDPRINT_STRING_COUNTER,SysValueCopy
	lds	SysCalcTempA,GLCDPRINTLEN
	cpi	SysCalcTempA,1
	brsh	ENDIF12
	rjmp	SysForLoopEnd6
ENDIF12:
SysForLoop6:
	lds	SysTemp1,GLCDPRINT_STRING_COUNTER
	inc	SysTemp1
	sts	GLCDPRINT_STRING_COUNTER,SysTemp1
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	lds	SysValueCopy,GLCDPRINTLOC
	sts	CHARLOCX,SysValueCopy
	lds	SysValueCopy,GLCDPRINTLOC_H
	sts	CHARLOCX_H,SysValueCopy
	lds	SysValueCopy,PRINTLOCY
	sts	CHARLOCY,SysValueCopy
	lds	SysValueCopy,PRINTLOCY_H
	sts	CHARLOCY_H,SysValueCopy
	lds	SysTemp1,SysLCDPRINTDATAHandler
	lds	SysTemp2,GLCDPRINT_STRING_COUNTER
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	lds	SysTemp1,SysLCDPRINTDATAHandler_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	mov	SysStringA_H,SysTemp1
	ld	SysValueCopy,X
	sts	CHARCODE,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	DRAWCHAR_EPD2IN13D
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1088)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	lds	SysBYTETempA,GLCDFONTWIDTH
	lds	SysBYTETempB,GLCDFNTDEFAULTSIZE
	mul	SysByteTempA,SysByteTempB
	mov	SysTemp1,SysByteTempX
	lds	SysTemp3,GLCDPRINTLOC
	add	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	lds	SysTemp1,GLCDPRINTLOC_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	mov	SysTemp2_H,SysTemp1
	lds	SysTemp3,GLCDFNTDEFAULTSIZE
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	ldi	SysTemp3,0
	adc	SysTemp2_H,SysTemp3
	mov	SysTemp1_H,SysTemp2_H
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	GLCDPRINTLOC,SysTemp1
	ldi	SysTemp3,0
	sbc	SysTemp1_H,SysTemp3
	sts	GLCDPRINTLOC_H,SysTemp1_H
;Next
	lds	SysCalcTempA,GLCDPRINT_STRING_COUNTER
	lds	SysCalcTempB,GLCDPRINTLEN
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF13
	rjmp	SysForLoop6
ENDIF13:
SysForLoopEnd6:
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	lds	SysValueCopy,GLCDPRINTLOC
	sts	PRINTLOCX,SysValueCopy
	lds	SysValueCopy,GLCDPRINTLOC_H
	sts	PRINTLOCX_H,SysValueCopy
;GLCDFontWidth = OldGLCDFontWidth
	lds	SysValueCopy,OLDGLCDFONTWIDTH
	sts	GLCDFONTWIDTH,SysValueCopy
	ret

;********************************************************************************

;Source: glcd.h (1109)
GLCDPRINTSTRINGLN:
;dim PrintLocX, PrintLocY as word
;GLCDPrint( PrintLocX , PrintLocY , LCDPrintData )
	lds	SysValueCopy,SysLCDPRINTDATAHandler
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	lds	SysValueCopy,SysLCDPRINTDATAHandler_H
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	rcall	GLCDPRINT4
;Update the current X and Y position
;PrintLocX = 0
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
;When using Transaction  PrintLocY will get incremented. This needs to be protected
;PrintLocY = ( PrintLocY + ( GLCDfntDefaultHeight * GLCDfntDefaultSize ) ) mod EPD_CORRECTED_HEIGHT
	lds	SysBYTETempA,GLCDFNTDEFAULTHEIGHT
	lds	SysBYTETempB,GLCDFNTDEFAULTSIZE
	mul	SysByteTempA,SysByteTempB
	mov	SysTemp1,SysByteTempX
	lds	SysTemp3,PRINTLOCY
	add	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	lds	SysTemp1,PRINTLOCY_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	mov	SysTemp2_H,SysTemp1
	mov	SysWORDTempA,SysTemp2
	mov	SysWORDTempA_H,SysTemp2_H
	ldi	SysWORDTempB,208
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	PRINTLOCY,SysWORDTempX
	sts	PRINTLOCY_H,SysWORDTempX_H
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
;harware SPI mode
;asm showdebug SPI constant used equates to HWSPIMODESCRIPT
;spi constant used equates to 14
;SPIMode HWSPIMODESCRIPT, 0
	ldi	SysValueCopy,14
	sts	SPICURRENTMODE,SysValueCopy
	ldi	SysValueCopy,0
	sts	SPICLOCKMODE,SysValueCopy
	call	SPIMODE645
;SendCommand_EPD2in13D(BOOSTER_SOFT_START)
	ldi	SysValueCopy,6
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x17)
	ldi	SysValueCopy,23
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x17)
	ldi	SysValueCopy,23
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x17)
	ldi	SysValueCopy,23
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;wait 200 ms
	ldi	SysWaitTempMS,200
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;SendCommand_EPD2in13D(POWER_SETTING)
	ldi	SysValueCopy,1
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x03)
	ldi	SysValueCopy,3
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x00)
	ldi	SysValueCopy,0
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x2B)
	ldi	SysValueCopy,43
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x2B)
	ldi	SysValueCopy,43
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x03)
	ldi	SysValueCopy,3
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;wait 200 ms
	ldi	SysWaitTempMS,200
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;SendCommand_EPD2in13D(POWER_ON)
	ldi	SysValueCopy,4
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;SendCommand_EPD2in13D(PANEL_SETTING)
	ldi	SysValueCopy,0
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(PANEL_SETTING_VALUE or PANEL_SETTING_KWR )
	ldi	SysValueCopy,191
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(PLL_CONTROL)
	ldi	SysValueCopy,48
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x3C)
	ldi	SysValueCopy,60
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(RESOLUTION_SETTING)
	ldi	SysValueCopy,97
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x68)
	ldi	SysValueCopy,104
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x00)
	ldi	SysValueCopy,0
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0xD4)
	ldi	SysValueCopy,212
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(VCM_DC_SETTING)
	ldi	SysValueCopy,130
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x12)
	ldi	SysValueCopy,18
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
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
;GLCDFontWidth = 5
	ldi	SysValueCopy,5
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
	call	ROTATE_EPD2IN13D
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

;Source: glcd.h (1482)
LINE:
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	ldi	SysValueCopy,0
	sts	LINEDIFFX,SysValueCopy
	sts	LINEDIFFX_H,SysValueCopy
;LineDiffY = 0
	ldi	SysValueCopy,0
	sts	LINEDIFFY,SysValueCopy
	sts	LINEDIFFY_H,SysValueCopy
;LineStepX = 0
	ldi	SysValueCopy,0
	sts	LINESTEPX,SysValueCopy
	sts	LINESTEPX_H,SysValueCopy
;LineStepY = 0
	ldi	SysValueCopy,0
	sts	LINESTEPY,SysValueCopy
	sts	LINESTEPY_H,SysValueCopy
;LineDiffX_x2 = 0
	ldi	SysValueCopy,0
	sts	LINEDIFFX_X2,SysValueCopy
	sts	LINEDIFFX_X2_H,SysValueCopy
;LineDiffY_x2 = 0
	ldi	SysValueCopy,0
	sts	LINEDIFFY_X2,SysValueCopy
	sts	LINEDIFFY_X2_H,SysValueCopy
;LineErr = 0
	ldi	SysValueCopy,0
	sts	LINEERR,SysValueCopy
	sts	LINEERR_H,SysValueCopy
;LineDiffX =  LineX2 -   LineX1
	lds	SysTemp1,LINEX2
	lds	SysTemp2,LINEX1
	sub	SysTemp1,SysTemp2
	sts	LINEDIFFX,SysTemp1
	lds	SysTemp1,LINEX2_H
	lds	SysTemp2,LINEX1_H
	sbc	SysTemp1,SysTemp2
	sts	LINEDIFFX_H,SysTemp1
;LineDiffY =  LineY2 -   LineY1
	lds	SysTemp1,LINEY2
	lds	SysTemp2,LINEY1
	sub	SysTemp1,SysTemp2
	sts	LINEDIFFY,SysTemp1
	lds	SysTemp1,LINEY2_H
	lds	SysTemp2,LINEY1_H
	sbc	SysTemp1,SysTemp2
	sts	LINEDIFFY_H,SysTemp1
;if (LineDiffX > 0) then
	lds	SysINTEGERTempB,LINEDIFFX
	lds	SysINTEGERTempB_H,LINEDIFFX_H
	ldi	SysINTEGERTempA,0
	ldi	SysINTEGERTempA_H,0
	call	SysCompLessThanINT
	sbrs	SysByteTempX,0
	rjmp	ELSE22_1
;LineStepX = 1
	ldi	SysValueCopy,1
	sts	LINESTEPX,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINESTEPX_H,SysValueCopy
;else
	rjmp	ENDIF22
ELSE22_1:
;LineStepX = -1
	ldi	SysValueCopy,255
	sts	LINESTEPX,SysValueCopy
	sts	LINESTEPX_H,SysValueCopy
;end if
ENDIF22:
;if (LineDiffY > 0) then
	lds	SysINTEGERTempB,LINEDIFFY
	lds	SysINTEGERTempB_H,LINEDIFFY_H
	ldi	SysINTEGERTempA,0
	ldi	SysINTEGERTempA_H,0
	call	SysCompLessThanINT
	sbrs	SysByteTempX,0
	rjmp	ELSE23_1
;LineStepY = 1
	ldi	SysValueCopy,1
	sts	LINESTEPY,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINESTEPY_H,SysValueCopy
;else
	rjmp	ENDIF23
ELSE23_1:
;LineStepY = -1
	ldi	SysValueCopy,255
	sts	LINESTEPY,SysValueCopy
	sts	LINESTEPY_H,SysValueCopy
;end if
ENDIF23:
;LineDiffX = LineStepX * LineDiffX
	lds	SysINTEGERTempA,LINESTEPX
	lds	SysINTEGERTempA_H,LINESTEPX_H
	lds	SysINTEGERTempB,LINEDIFFX
	lds	SysINTEGERTempB_H,LINEDIFFX_H
	call	SysMultSubINT
	sts	LINEDIFFX,SysINTEGERTempX
	sts	LINEDIFFX_H,SysINTEGERTempX_H
;LineDiffY = LineStepY * LineDiffY
	lds	SysINTEGERTempA,LINESTEPY
	lds	SysINTEGERTempA_H,LINESTEPY_H
	lds	SysINTEGERTempB,LINEDIFFY
	lds	SysINTEGERTempB_H,LINEDIFFY_H
	call	SysMultSubINT
	sts	LINEDIFFY,SysINTEGERTempX
	sts	LINEDIFFY_H,SysINTEGERTempX_H
;LineDiffX_x2 = LineDiffX*2
	lds	SysINTEGERTempA,LINEDIFFX
	lds	SysINTEGERTempA_H,LINEDIFFX_H
	ldi	SysINTEGERTempB,2
	ldi	SysINTEGERTempB_H,0
	call	SysMultSubINT
	sts	LINEDIFFX_X2,SysINTEGERTempX
	sts	LINEDIFFX_X2_H,SysINTEGERTempX_H
;LineDiffY_x2 = LineDiffY*2
	lds	SysINTEGERTempA,LINEDIFFY
	lds	SysINTEGERTempA_H,LINEDIFFY_H
	ldi	SysINTEGERTempB,2
	ldi	SysINTEGERTempB_H,0
	call	SysMultSubINT
	sts	LINEDIFFY_X2,SysINTEGERTempX
	sts	LINEDIFFY_X2_H,SysINTEGERTempX_H
;if ( LineDiffX >= LineDiffY) then
	lds	SysINTEGERTempA,LINEDIFFX
	lds	SysINTEGERTempA_H,LINEDIFFX_H
	lds	SysINTEGERTempB,LINEDIFFY
	lds	SysINTEGERTempB_H,LINEDIFFY_H
	call	SysCompLessThanINT
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ELSE24_1
;LineErr = LineDiffY_x2 - LineDiffX
	lds	SysTemp1,LINEDIFFY_X2
	lds	SysTemp2,LINEDIFFX
	sub	SysTemp1,SysTemp2
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEDIFFY_X2_H
	lds	SysTemp2,LINEDIFFX_H
	sbc	SysTemp1,SysTemp2
	sts	LINEERR_H,SysTemp1
;do while (   LineX1 <>  LineX2 )
SysDoLoop_S4:
	lds	SysWORDTempA,linex1
	lds	SysWORDTempA_H,linex1_H
	lds	SysWORDTempB,linex2
	lds	SysWORDTempB_H,linex2_H
	call	SysCompEqual16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	SysDoLoop_E4
;PSet (   LineX1,   LineY1, LineColour )
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	GLCDX_H,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	GLCDY_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_EPD2IN13D
;LineX1 += LineStepX
	lds	SysTemp1,LINEX1
	lds	SysTemp2,LINESTEPX
	add	SysTemp1,SysTemp2
	sts	LINEX1,SysTemp1
	lds	SysTemp1,LINEX1_H
	lds	SysTemp2,LINESTEPX_H
	adc	SysTemp1,SysTemp2
	sts	LINEX1_H,SysTemp1
;if ( LineErr < 0) then
	lds	SysINTEGERTempA,LINEERR
	lds	SysINTEGERTempA_H,LINEERR_H
	ldi	SysINTEGERTempB,0
	ldi	SysINTEGERTempB_H,0
	call	SysCompLessThanINT
	sbrs	SysByteTempX,0
	rjmp	ELSE25_1
;LineErr += LineDiffY_x2
	lds	SysTemp1,LINEERR
	lds	SysTemp2,LINEDIFFY_X2
	add	SysTemp1,SysTemp2
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEERR_H
	lds	SysTemp2,LINEDIFFY_X2_H
	adc	SysTemp1,SysTemp2
	sts	LINEERR_H,SysTemp1
;else
	rjmp	ENDIF25
ELSE25_1:
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	lds	SysTemp2,LINEDIFFY_X2
	lds	SysTemp3,LINEDIFFX_X2
	sub	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,LINEDIFFY_X2_H
	lds	SysTemp3,LINEDIFFX_X2_H
	sbc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	lds	SysTemp2,LINEERR
	add	SysTemp2,SysTemp1
	sts	LINEERR,SysTemp2
	lds	SysTemp1,LINEERR_H
	adc	SysTemp1,SysTemp1_H
	sts	LINEERR_H,SysTemp1
;LineY1 += LineStepY
	lds	SysTemp1,LINEY1
	lds	SysTemp2,LINESTEPY
	add	SysTemp1,SysTemp2
	sts	LINEY1,SysTemp1
	lds	SysTemp1,LINEY1_H
	lds	SysTemp2,LINESTEPY_H
	adc	SysTemp1,SysTemp2
	sts	LINEY1_H,SysTemp1
;end if
ENDIF25:
;loop
	rjmp	SysDoLoop_S4
SysDoLoop_E4:
;PSet (   LineX1,   LineY1, LineColour )
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	GLCDX_H,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	GLCDY_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_EPD2IN13D
;else
	rjmp	ENDIF24
ELSE24_1:
;LineErr = LineDiffX_x2 - LineDiffY
	lds	SysTemp1,LINEDIFFX_X2
	lds	SysTemp2,LINEDIFFY
	sub	SysTemp1,SysTemp2
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEDIFFX_X2_H
	lds	SysTemp2,LINEDIFFY_H
	sbc	SysTemp1,SysTemp2
	sts	LINEERR_H,SysTemp1
;do while (   LineY1 <>  LineY2)
SysDoLoop_S5:
	lds	SysWORDTempA,liney1
	lds	SysWORDTempA_H,liney1_H
	lds	SysWORDTempB,liney2
	lds	SysWORDTempB_H,liney2_H
	call	SysCompEqual16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	SysDoLoop_E5
;PSet (   LineX1,   LineY1, LineColour )
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	GLCDX_H,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	GLCDY_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_EPD2IN13D
;LineY1 += LineStepY
	lds	SysTemp1,LINEY1
	lds	SysTemp2,LINESTEPY
	add	SysTemp1,SysTemp2
	sts	LINEY1,SysTemp1
	lds	SysTemp1,LINEY1_H
	lds	SysTemp2,LINESTEPY_H
	adc	SysTemp1,SysTemp2
	sts	LINEY1_H,SysTemp1
;if ( LineErr < 0) then
	lds	SysINTEGERTempA,LINEERR
	lds	SysINTEGERTempA_H,LINEERR_H
	ldi	SysINTEGERTempB,0
	ldi	SysINTEGERTempB_H,0
	call	SysCompLessThanINT
	sbrs	SysByteTempX,0
	rjmp	ELSE26_1
;LineErr += LineDiffX_x2
	lds	SysTemp1,LINEERR
	lds	SysTemp2,LINEDIFFX_X2
	add	SysTemp1,SysTemp2
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEERR_H
	lds	SysTemp2,LINEDIFFX_X2_H
	adc	SysTemp1,SysTemp2
	sts	LINEERR_H,SysTemp1
;else
	rjmp	ENDIF26
ELSE26_1:
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	lds	SysTemp2,LINEDIFFX_X2
	lds	SysTemp3,LINEDIFFY_X2
	sub	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,LINEDIFFX_X2_H
	lds	SysTemp3,LINEDIFFY_X2_H
	sbc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	lds	SysTemp2,LINEERR
	add	SysTemp2,SysTemp1
	sts	LINEERR,SysTemp2
	lds	SysTemp1,LINEERR_H
	adc	SysTemp1,SysTemp1_H
	sts	LINEERR_H,SysTemp1
;LineX1 += LineStepX
	lds	SysTemp1,LINEX1
	lds	SysTemp2,LINESTEPX
	add	SysTemp1,SysTemp2
	sts	LINEX1,SysTemp1
	lds	SysTemp1,LINEX1_H
	lds	SysTemp2,LINESTEPX_H
	adc	SysTemp1,SysTemp2
	sts	LINEX1_H,SysTemp1
;end if
ENDIF26:
;loop
	rjmp	SysDoLoop_S5
SysDoLoop_E5:
;PSet (   LineX1,   LineY1, LineColour )
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	GLCDX_H,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	GLCDY_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_EPD2IN13D
;end if
ENDIF24:
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (256)
LOADLUTS_EPD2IN13D:
;Dim DataVar as byte
;Dim Counter as Word
;SendCommand_EPD2in13D(VCM_DC_SETTING)
	ldi	SysValueCopy,130
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x00)
	ldi	SysValueCopy,0
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(VCOM_AND_DATA_INTERVAL_SETTING)
	ldi	SysValueCopy,80
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;Mask VCOM_AND_DATA_INTERVAL bits and then Mask the user bits.
;SendData_EPD2in13D( (0x90 AND 0xF0 ) or ( VCOM_AND_DATA_INTERVAL AND 0X0F ))
	ldi	SysValueCopy,151
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(0x20) 'VCOM LUT
	ldi	SysValueCopy,32
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 44
	ldi	SysValueCopy,0
	sts	EPD_COUNTER,SysValueCopy
SysForLoop19:
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
	call	SENDDATA_EPD2IN13D
;next
	lds	SysCalcTempA,EPD_COUNTER
	cpi	SysCalcTempA,44
	brlo	SysForLoop19
SysForLoopEnd19:
;SendCommand_EPD2in13D(0x21) 'WW LUT
	ldi	SysValueCopy,33
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	ldi	SysValueCopy,0
	sts	EPD_COUNTER,SysValueCopy
SysForLoop20:
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
	call	SENDDATA_EPD2IN13D
;next
	lds	SysCalcTempA,EPD_COUNTER
	cpi	SysCalcTempA,42
	brlo	SysForLoop20
SysForLoopEnd20:
;SendCommand_EPD2in13D(0x22) 'BW LUT
	ldi	SysValueCopy,34
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	ldi	SysValueCopy,0
	sts	EPD_COUNTER,SysValueCopy
SysForLoop21:
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
	call	SENDDATA_EPD2IN13D
;next
	lds	SysCalcTempA,EPD_COUNTER
	cpi	SysCalcTempA,42
	brlo	SysForLoop21
SysForLoopEnd21:
;SendCommand_EPD2in13D(0x23) 'WB LUT
	ldi	SysValueCopy,35
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	ldi	SysValueCopy,0
	sts	EPD_COUNTER,SysValueCopy
SysForLoop22:
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
	call	SENDDATA_EPD2IN13D
;next
	lds	SysCalcTempA,EPD_COUNTER
	cpi	SysCalcTempA,42
	brlo	SysForLoop22
SysForLoopEnd22:
;SendCommand_EPD2in13D(0x24) 'BB LUT
	ldi	SysValueCopy,36
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	ldi	SysValueCopy,0
	sts	EPD_COUNTER,SysValueCopy
SysForLoop23:
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
	call	SENDDATA_EPD2IN13D
;next
	lds	SysCalcTempA,EPD_COUNTER
	cpi	SysCalcTempA,42
	brlo	SysForLoop23
SysForLoopEnd23:
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

OLEDFONT1DATA:
	mov	SysWORDTempA,SYSSTRINGA
	mov	SysWORDTempA_H,SYSSTRINGA_H
	ldi	SysWORDTempB,165
	ldi	SysWORDTempB_H,1
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	ret
	ldi	SysReadA, low(TableOLEDFONT1DATA<<1)
	ldi	SysReadA_H, high(TableOLEDFONT1DATA<<1)
	add	SysReadA, SysStringA
	adc	SysReadA_H, SysStringA_H
	lpm
	ret
TableOLEDFONT1DATA:
	.DB	165,1,0,1,94,3,6,0,6,5,40,124,40,124,40,5,36,42,127,42,16,3,98,24,70,5,48,76,90,36
	.DB	80,1,6,2,60,66,2,66,60,5,40,16,124,16,40,3,16,56,16,1,192,3,16,16,16,1,64,3,96,24
	.DB	6,4,60,66,66,60,3,68,126,64,4,68,98,82,76,3,74,74,52,4,30,16,124,16,3,78,74,50
	.DB	4,60,74,74,48,3,98,18,14,4,52,74,74,52,4,12,82,82,60,1,72,2,128,104,3,16,40,68
	.DB	3,40,40,40,3,68,40,16,3,2,82,12,5,56,68,84,84,88,4,124,18,18,124,4,126,74,74,52
	.DB	4,60,66,66,36,4,126,66,66,60,3,126,74,74,3,126,10,10,4,60,66,82,52,4,126,8,8,126
	.DB	3,66,126,66,3,66,66,62,4,126,8,20,98,3,126,64,64,5,126,4,8,4,126,5,126,4,24,32
	.DB	126,4,60,66,66,60,4,126,18,18,12,4,60,66,66,188,4,126,18,18,108,4,68,74,74,48,3,2
	.DB	126,2,4,62,64,64,62,5,6,24,96,24,6,5,62,64,62,64,62,5,66,36,24,36,66,4,158,160
	.DB	160,126,4,98,82,74,70,2,126,66,3,6,24,96,2,66,126,3,32,16,32,4,128,128,128,128
	.DB	2,4,8,4,32,84,84,120,4,126,68,68,56,4,56,68,68,40,4,56,68,68,126,4,56,84,84,88
	.DB	2,124,10,4,152,164,164,124,4,126,4,4,120,1,122,2,64,58,4,126,16,40,68,1,126,5
	.DB	124,4,120,4,120,4,124,4,4,120,4,56,68,68,56,4,252,36,36,24,4,24,36,36,252,2,124,4
	.DB	4,72,84,84,32,3,4,62,68,4,60,64,64,60,5,12,48,64,48,12,5,60,64,60,64,60,5,68,40,16
	.DB	40,68,4,156,160,160,124,3,100,84,76,3,8,54,65,1,255,3,65,54,8,4,32,16,32,16,1

;********************************************************************************

OLEDFONT1DATA_H:
	mov	SysWORDTempA,SYSSTRINGA
	mov	SysWORDTempA_H,SYSSTRINGA_H
	ldi	SysWORDTempB,1
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrs	SysByteTempX,0
	ret
	ldi	SysReadA, low(TableOLEDFONT1DATA_H<<1)
	ldi	SysReadA_H, high(TableOLEDFONT1DATA_H<<1)
	add	SysReadA, SysStringA
	adc	SysReadA_H, SysStringA_H
	lpm
	ret
TableOLEDFONT1DATA_H:
	.DB	1

;********************************************************************************

OLEDFONT1INDEX:
	cpi	SysStringA, 97
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableOLEDFONT1INDEX<<1)
	ldi	SysReadA_H, high(TableOLEDFONT1INDEX<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableOLEDFONT1INDEX:
	.DB	96,1,3,5,9,15,21,25,31,33,36,39,45,49,51,55,57,61,66,70,75,79,84,88,93,97,102,107
	.DB	109,112,116,120,124,128,134,139,144,149,154,158,162,167,172,176,180,185,189,195
	.DB	201,206,211,216,221,226,230,235,241,247,253,2,7,10,14,17,21,26,29,34,39,44,49,54
	.DB	57,62,67,69,72,77,79,85,90,95,100,105,108,113,117,122,128,134,140,145,149,153
	.DB	155,159,164

;********************************************************************************

OLEDFONT1INDEX_H:
	cpi	SysStringA, 97
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableOLEDFONT1INDEX_H<<1)
	ldi	SysReadA_H, high(TableOLEDFONT1INDEX_H<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableOLEDFONT1INDEX_H:
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	.DB	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

;********************************************************************************

OLEDFONT2:
	mov	SysWORDTempA,SYSSTRINGA
	mov	SysWORDTempA_H,SYSSTRINGA_H
	ldi	SysWORDTempB,145
	ldi	SysWORDTempB_H,7
	rcall	SysCompLessThan16
	sbrs	SysByteTempX,0
	ret
	ldi	SysReadA, low(TableOLEDFONT2<<1)
	ldi	SysReadA_H, high(TableOLEDFONT2<<1)
	add	SysReadA, SysStringA
	adc	SysReadA_H, SysStringA_H
	lpm
	ret
TableOLEDFONT2:
	.DB	147,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,254,27,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,0,1,32,25,160,7,120,1,38,25,160
	.DB	7,120,1,38,1,32,1,0,0,0,0,0,0,28,24,38,16,66,16,255,63,130,17,2,15,0,0,0,0,28
	.DB	16,34,8,34,4,34,3,156,0,64,14,48,17,8,17,4,17,2,14,0,7,128,8,92,16,98,16,162,17,50
	.DB	19,28,28,0,24,0,22,128,1,0,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,224
	.DB	7,24,24,12,48,4,32,2,64,2,64,0,0,0,0,2,64,2,64,4,32,12,48,24,24,224,7,0,0,0,0,0
	.DB	0,0,0,8,0,24,0,240,0,78,0,240,0,24,0,8,0,0,0,0,0,0,2,0,2,0,2,0,2,224,31,0,2,0,2,0
	.DB	2,0,2,0,0,0,0,0,0,0,0,0,152,0,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0
	.DB	1,0,1,0,0,0,0,0,0,0,0,0,0,0,24,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,48,0,12,0,3,192
	.DB	0,48,0,12,0,2,0,0,0,0,0,240,3,12,12,2,16,2,16,2,16,12,12,240,3,0,0,0,0,0,0,4,16,4
	.DB	16,4,16,254,31,0,16,0,16,0,16,0,0,0,0,0,0,6,24,2,20,2,18,2,17,194,16,60,16,0,0,0
	.DB	0,0,0,0,0,0,0,2,16,66,16,66,16,66,16,188,15,0,0,0,0,0,0,0,3,192,2,32,2,24,2,4,2,254
	.DB	31,0,2,0,2,0,0,0,0,0,0,0,0,62,16,34,16,34,16,66,8,130,7,0,0,0,0,0,0,0,0,240,7,76
	.DB	8,34,16,34,16,34,16,66,8,128,7,0,0,0,0,0,0,2,0,2,24,2,7,194,0,50,0,10,0,6,0,0,0,0
	.DB	0,0,0,28,15,162,16,66,16,66,16,162,16,162,9,28,6,0,0,0,0,0,0,120,0,132,16,2,17,2
	.DB	17,2,17,132,12,248,3,0,0,0,0,0,0,0,0,0,0,96,24,96,24,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,96,152,96,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,3,128,4,128,4,64,8,64,8,32
	.DB	16,0,0,0,0,128,4,128,4,128,4,128,4,128,4,128,4,128,4,128,4,0,0,0,0,32,16,64,8,64
	.DB	8,128,4,128,4,0,3,0,3,0,0,0,0,0,0,14,0,2,0,2,27,130,0,66,0,38,0,28,0,0,0,0,0,240
	.DB	3,24,12,4,24,226,19,18,20,10,22,138,27,252,7,0,4,0,4,0,16,0,14,128,3,112,2,24,2,48
	.DB	2,192,2,0,3,0,12,0,16,0,0,248,31,136,16,136,16,136,16,136,16,72,17,48,14,0,0,0
	.DB	0,192,3,48,12,16,8,8,16,8,16,8,16,8,16,24,16,0,0,0,0,0,0,248,31,8,16,8,16,8,16,8
	.DB	16,16,8,224,7,0,0,0,0,0,0,248,31,8,17,8,17,8,17,8,17,8,17,8,16,0,0,0,0,0,0,248
	.DB	31,8,1,8,1,8,1,8,1,8,1,8,0,0,0,0,0,0,0,192,3,48,12,16,8,8,16,8,16,8,17,8,17,24
	.DB	31,0,0,0,0,248,31,0,1,0,1,0,1,0,1,0,1,248,31,0,0,0,0,0,0,8,16,8,16,8,16,248,31,8
	.DB	16,8,16,8,16,0,0,0,0,0,0,0,0,0,16,8,16,8,16,8,16,248,15,0,0,0,0,0,0,0,0,248,31,128
	.DB	0,128,1,64,2,32,4,16,4,8,8,0,16,0,0,0,0,248,31,0,16,0,16,0,16,0,16,0,16,0,16,0
	.DB	0,0,0,248,31,56,0,224,1,0,7,0,6,192,1,56,0,248,31,0,0,0,0,0,0,248,31,16,0,96,0,128
	.DB	1,0,6,0,8,248,31,0,0,0,0,0,0,224,7,16,8,8,16,8,16,8,16,8,16,16,8,224,7,0,0,0,0,248
	.DB	31,8,1,8,1,8,1,8,1,136,0,112,0,0,0,0,0,0,0,224,7,16,8,8,16,8,16,8,16,8,48,16,72,224
	.DB	71,0,0,0,0,248,31,8,1,8,1,8,3,136,4,112,8,0,16,0,0,0,0,0,0,112,24,72,16,136,16,136
	.DB	16,8,17,8,9,24,14,0,0,0,0,8,0,8,0,8,0,8,0,248,31,8,0,8,0,8,0,8,0,0,0,0,0,248,7,0
	.DB	24,0,16,0,16,0,16,0,8,248,7,0,0,0,0,8,0,48,0,192,1,0,6,0,24,0,24,0,7,192,0,48,0,8
	.DB	0,24,0,224,3,0,28,0,15,224,0,192,1,0,14,0,28,224,3,24,0,8,16,16,8,32,4,64,2,128
	.DB	1,128,1,64,2,32,4,16,8,8,16,8,0,16,0,96,0,128,0,0,31,128,0,64,0,32,0,16,0,8,0,0
	.DB	0,8,24,8,20,8,18,8,17,136,16,72,16,40,16,24,16,0,0,0,0,0,0,0,0,254,127,2,64,2
	.DB	64,2,64,2,64,0,0,0,0,0,0,2,0,12,0,48,0,192,0,0,3,0,12,0,48,0,64,0,0,0,0,2,64,2
	.DB	64,2,64,2,64,254,127,0,0,0,0,0,0,0,0,0,0,0,4,0,3,224,0,56,0,14,0,112,0,128,3,0
	.DB	4,0,0,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,0,0,0,0,0,0,0,1,0,2,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,12,32,18,32,17,32,17,32,9,192,31,0,16,0,0,0,0,0,0,254,31,64
	.DB	8,32,16,32,16,32,16,96,8,128,7,0,0,0,0,0,0,128,7,64,8,32,16,32,16,32,16,32,16,32
	.DB	16,0,0,0,0,0,0,128,7,64,24,32,16,32,16,32,16,64,8,254,31,0,0,0,0,0,0,128,7,64,9,32
	.DB	17,32,17,32,17,32,17,192,17,0,0,0,0,0,0,32,0,32,0,252,31,36,0,34,0,34,0,34,0,34
	.DB	0,0,0,0,0,128,7,64,152,32,144,32,144,32,144,64,72,224,63,0,0,0,0,0,0,254,31,128
	.DB	0,64,0,32,0,32,0,32,0,192,31,0,0,0,0,0,0,32,0,32,0,38,0,230,31,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,128,32,128,32,128,38,128,230,127,0,0,0,0,0,0,0,0,0,0,254,31,0,1,0,3,128
	.DB	4,64,4,64,8,32,16,0,0,0,0,0,0,0,0,2,0,2,0,2,0,254,31,0,0,0,0,0,0,0,0,224,31,64
	.DB	0,32,0,32,0,192,31,64,0,32,0,32,0,192,31,0,0,0,0,224,31,192,0,64,0,32,0,32,0,32
	.DB	0,192,31,0,0,0,0,0,0,128,7,64,8,32,16,32,16,32,16,64,8,128,7,0,0,0,0,0,0,224
	.DB	255,64,8,32,16,32,16,32,16,96,8,128,7,0,0,0,0,0,0,128,7,64,24,32,16,32,16,32,16,64
	.DB	8,224,255,0,0,0,0,0,0,0,0,224,31,128,0,64,0,32,0,32,0,224,0,0,0,0,0,0,0,192,24,32
	.DB	17,32,17,32,18,32,18,32,12,0,0,0,0,0,0,0,0,32,0,32,0,248,15,32,16,32,16,32,16,32
	.DB	16,0,0,0,0,0,0,224,15,0,16,0,16,0,16,0,8,224,31,0,0,0,0,0,0,32,0,192,1,0,6,0,24,0
	.DB	16,0,12,0,3,192,0,32,0,0,0,96,0,128,7,0,24,0,14,192,1,128,1,0,14,0,24,128,7,96
	.DB	0,0,0,32,16,64,8,128,4,0,3,0,3,128,4,64,8,32,16,0,0,32,128,192,128,0,131,0,70,0
	.DB	56,0,24,0,6,0,1,192,0,32,0,0,0,32,16,32,24,32,20,32,18,32,17,160,16,96,16,32,16,0
	.DB	0,0,0,0,0,0,1,0,1,252,62,2,64,2,64,2,64,0,0,0,0,0,0,0,0,0,0,0,0,254,127,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,2,64,2,64,2,64,252,62,0,1,0,1,0,0,0,0,0,3,128,0,128,0,128,0,0
	.DB	1,0,1,0,2,0,2,0,2,128,1,0,0,128,31,192,16,32,16,16,16,32,16,192,16,128,31,0,0,0
	.DB	0,192,3,48,12,16,8,8,16,8,16,8,144,8,176,24,208

;********************************************************************************

OLEDFONT2_H:
	mov	SysWORDTempA,SYSSTRINGA
	mov	SysWORDTempA_H,SYSSTRINGA_H
	ldi	SysWORDTempB,1
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrs	SysByteTempX,0
	ret
	ldi	SysReadA, low(TableOLEDFONT2_H<<1)
	ldi	SysReadA_H, high(TableOLEDFONT2_H<<1)
	add	SysReadA, SysStringA
	adc	SysReadA_H, SysStringA_H
	lpm
	ret
TableOLEDFONT2_H:
	.DB	7

;********************************************************************************

;Source: epd_epd2in13d.h (361)
PIXEL_TO_DISPLAY_EPD2IN13D:
;Dim EPD_Ind_raw, EPD_Ind_col as Word
;if _GLCDPage = 0 then
	lds	SysCalcTempA,_GLCDPAGE
	tst	SysCalcTempA
	breq	PC + 2
	rjmp	ENDIF40
;Clear down 'OLD' data - to prevent flashing
;SendCommand_EPD2in13D(Data_Transmission_1)
	ldi	SysValueCopy,16
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;SET EPD_CS OFF
	cbi	PORTB,2
;SET EPD_DC ON
	sbi	PORTB,1
;for EPD_Ind_raw=1 to GLCD_Height
	ldi	SysValueCopy,0
	sts	EPD_IND_RAW,SysValueCopy
	sts	EPD_IND_RAW_H,SysValueCopy
SysForLoop11:
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
SysForLoop12:
	lds	SysTemp1,EPD_IND_COL
	inc	SysTemp1
	sts	EPD_IND_COL,SysTemp1
	lds	SysTemp1,EPD_IND_COL_H
	brne	PC + 2
	inc	SysTemp1
	sts	EPD_IND_COL_H,SysTemp1
;Replaced with macro for speed              SendData_EPD2in13D(GLCDBackGround)
;EPD2in13D_Data = GLCDBackGround
	lds	SysValueCopy,GLCDBACKGROUND
	sts	EPD2IN13D_DATA,SysValueCopy
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (495)
;FastHWSPITransfer EPD2in13D_Data
	sts	SPITXDATA,SysValueCopy
	call	FASTHWSPITRANSFER
;next
	lds	SysWORDTempA,EPD_IND_COL
	lds	SysWORDTempA_H,EPD_IND_COL_H
	ldi	SysWORDTempB,104
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop12
SysForLoopEnd12:
;next
	lds	SysWORDTempA,EPD_IND_RAW
	lds	SysWORDTempA_H,EPD_IND_RAW_H
	ldi	SysWORDTempB,212
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop11
SysForLoopEnd11:
;SET EPD_CS ON
	sbi	PORTB,2
;SendCommand_EPD2in13D(DATA_TRANSMISSION_2)
	ldi	SysValueCopy,19
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;end if
ENDIF40:
;dim EPD2in13D_Data as byte
;We need to set the signals as we are optimising the code by using the macro
;SET EPD_CS OFF
	cbi	PORTB,2
;SET EPD_DC ON
	sbi	PORTB,1
;for EPD_Ind_raw=1 to BUFFWIDTH
	ldi	SysValueCopy,0
	sts	EPD_IND_RAW,SysValueCopy
	sts	EPD_IND_RAW_H,SysValueCopy
SysForLoop13:
	lds	SysTemp1,EPD_IND_RAW
	inc	SysTemp1
	sts	EPD_IND_RAW,SysTemp1
	lds	SysTemp1,EPD_IND_RAW_H
	brne	PC + 2
	inc	SysTemp1
	sts	EPD_IND_RAW_H,SysTemp1
;replaced with macro for speed
;SendData_EPD2in13D(EPD_Buffer(EPD_Ind_raw))
;EPD2in13D_Data = EPD_Buffer(EPD_Ind_raw)
	lds	SysTemp1,EPD_IND_RAW
	ldi	SysTemp3,low(EPD_BUFFER)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	lds	SysTemp1,EPD_IND_RAW_H
	ldi	SysTemp3,high(EPD_BUFFER)
	adc	SysTemp1,SysTemp3
	mov	SysStringA_H,SysTemp1
	ld	SysValueCopy,X
	sts	EPD2IN13D_DATA,SysValueCopy
;The following line is intentionally commented out, but, it shows the orientation of the pixels to the array. Uncomment to force a two (when the value is 3!) byte write to the Display
;You can then examine the display to see the orientation of the pixels.
;This will write the bytes at the top of each page - so, do not be surprised!
;if EPD_Ind_raw < 3 then EPD2in13D_Data = GLCDForeground
;This macro assumes the use of the variable EPD2in13D_Data
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (495)
;FastHWSPITransfer EPD2in13D_Data
	sts	SPITXDATA,SysValueCopy
	call	FASTHWSPITRANSFER
;Now clear the buffer
;EPD_Buffer(EPD_Ind_raw) = GLCDBackground
	lds	SysTemp1,EPD_IND_RAW
	ldi	SysTemp3,low(EPD_BUFFER)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	lds	SysTemp1,EPD_IND_RAW_H
	ldi	SysTemp3,high(EPD_BUFFER)
	adc	SysTemp1,SysTemp3
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
	rjmp	SysForLoop13
SysForLoopEnd13:
;SET EPD_CS ON
	sbi	PORTB,2
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (691)
PSET_EPD2IN13D:
;Dim EPD_Ind, EPD_N_Col, EPD_N_raw, EPD_Ind_Trans as word
;Dim remainder as byte
;Dim DataVar as byte
;Dim value as bit
;Dim GLCD_Time_Buff as word
;Dim GLCDDataTemp, GLCDY_Temp, GLCDY_withinPage  as word
;anything off screen with be rejected
;if GLCDX > GLCDDeviceWidth OR GLCDY > GLCDDeviceHeight Then
	lds	SysWORDTempB,GLCDX
	lds	SysWORDTempB_H,GLCDX_H
	lds	SysWORDTempA,GLCDDEVICEWIDTH
	lds	SysWORDTempA_H,GLCDDEVICEWIDTH_H
	rcall	SysCompLessThan16
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,GLCDY
	lds	SysWORDTempB_H,GLCDY_H
	lds	SysWORDTempA,GLCDDEVICEHEIGHT
	lds	SysWORDTempA_H,GLCDDEVICEHEIGHT_H
	rcall	SysCompLessThan16
	mov	SysTemp3,SysByteTempX
	or	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	sbrc	SysTemp2,0
;exit sub
	ret
;end if
;Select Case EPD2in13DAddressType
;case Landscape
SysSelect3Case1:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,1
	brne	SysSelect3Case2
;GLCDDataTemp = GLCDX
	lds	SysValueCopy,GLCDX
	sts	GLCDDATATEMP,SysValueCopy
	lds	SysValueCopy,GLCDX_H
	sts	GLCDDATATEMP_H,SysValueCopy
;GLCDX = GLCDY
	lds	SysValueCopy,GLCDY
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,GLCDY_H
	sts	GLCDX_H,SysValueCopy
;GLCDY = GLCD_HEIGHT - GLCDDataTemp - 1
	ldi	SysTemp3,212
	lds	SysTemp2,GLCDDATATEMP
	sub	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	ldi	SysTemp3,0
	lds	SysTemp2,GLCDDATATEMP_H
	sbc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	GLCDY,SysTemp1
	ldi	SysTemp3,0
	sbc	SysTemp1_H,SysTemp3
	sts	GLCDY_H,SysTemp1_H
;case Landscape_Rev
	rjmp	SysSelectEnd3
SysSelect3Case2:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,3
	brne	SysSelect3Case3
;GLCDDataTemp = GLCDX
	lds	SysValueCopy,GLCDX
	sts	GLCDDATATEMP,SysValueCopy
	lds	SysValueCopy,GLCDX_H
	sts	GLCDDATATEMP_H,SysValueCopy
;GLCDX = GLCD_WIDTH  - GLCDY - 1
	ldi	SysTemp3,104
	lds	SysTemp2,GLCDY
	sub	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	ldi	SysTemp3,0
	lds	SysTemp2,GLCDY_H
	sbc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	GLCDX,SysTemp1
	ldi	SysTemp3,0
	sbc	SysTemp1_H,SysTemp3
	sts	GLCDX_H,SysTemp1_H
;GLCDY = GLCDDataTemp
	lds	SysValueCopy,GLCDDATATEMP
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,GLCDDATATEMP_H
	sts	GLCDY_H,SysValueCopy
;case Portrait
	rjmp	SysSelectEnd3
SysSelect3Case3:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,4
	brne	SysSelect3Case4
;Default do nothing
;case Portrait_Rev
	rjmp	SysSelectEnd3
SysSelect3Case4:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,2
	brne	SysSelectEnd3
;GLCDY = GLCD_HEIGHT - GLCDY - 1
	ldi	SysTemp3,212
	lds	SysTemp2,GLCDY
	sub	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	ldi	SysTemp3,0
	lds	SysTemp2,GLCDY_H
	sbc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	GLCDY,SysTemp1
	ldi	SysTemp3,0
	sbc	SysTemp1_H,SysTemp3
	sts	GLCDY_H,SysTemp1_H
;GLCDX = GLCD_WIDTH - GLCDX - 1
	ldi	SysTemp3,104
	lds	SysTemp2,GLCDX
	sub	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	ldi	SysTemp3,0
	lds	SysTemp2,GLCDX_H
	sbc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	GLCDX,SysTemp1
	ldi	SysTemp3,0
	sbc	SysTemp1_H,SysTemp3
	sts	GLCDX_H,SysTemp1_H
;end select
SysSelectEnd3:
;Exit if not the current page.
;if  ( GLCDY / EPD_PIXELS_PER_PAGE  ) <> _GLCDPage then
	lds	SysWORDTempA,GLCDY
	lds	SysWORDTempA_H,GLCDY_H
	ldi	SysWORDTempB,8
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	mov	SysTemp1,SysWORDTempA
	mov	SysTemp1_H,SysWORDTempA_H
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	lds	SysWORDTempB,_GLCDPAGE
	ldi	SysWORDTempB_H,0
	rcall	SysCompEqual16
	com	SysByteTempX
	sbrc	SysByteTempX,0
;exit sub
	ret
;end if
;buffer location in LOWMEMORY_GLCD_MODE always equals GLCDX + 1
;UC1601_BufferLocationCalc = GLCDX + 1
	lds	SysTemp1,GLCDX
	ldi	SysTemp3,1
	add	SysTemp1,SysTemp3
	sts	UC1601_BUFFERLOCATIONCALC,SysTemp1
	lds	SysTemp1,GLCDX_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	UC1601_BUFFERLOCATIONCALC_H,SysTemp1
;EPD_N_Col=(GLCDX+1)/8                   'number of the column of the byte to be set
;EPD_N_Col=(GLCDX+1)
	lds	SysTemp1,GLCDX
	ldi	SysTemp3,1
	add	SysTemp1,SysTemp3
	sts	EPD_N_COL,SysTemp1
	lds	SysTemp1,GLCDX_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	EPD_N_COL_H,SysTemp1
;Repeat 3
	ldi	SysValueCopy,3
	sts	SysRepeatTemp1,SysValueCopy
SysRepeatLoop1:
;Set C Off
	clc
;Rotate EPD_N_Col Right
	lds	SysValueCopy,EPD_N_COL_H
	ror	SysValueCopy
	sts	EPD_N_COL_H,SysValueCopy
	lds	SysValueCopy,EPD_N_COL
	ror	SysValueCopy
	sts	EPD_N_COL,SysValueCopy
;End Repeat
	lds	SysTemp1,SysRepeatTemp1
	dec	SysTemp1
	sts	SysRepeatTemp1,SysTemp1
	brne	SysRepeatLoop1
SysRepeatLoopEnd1:
;remainder=(GLCDX+1) % 8
	lds	SysTemp2,GLCDX
	ldi	SysTemp3,1
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,GLCDX_H
	ldi	SysTemp3,0
	adc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	ldi	SysWORDTempB,8
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	sts	REMAINDER,SysWORDTempX
;EPD_N_raw=GLCDY * GLCD_Width8       'number of the column of the byte to be set
	lds	SysWORDTempA,GLCDY
	lds	SysWORDTempA_H,GLCDY_H
	ldi	SysWORDTempB,13
	ldi	SysWORDTempB_H,0
	rcall	SysMultSub16
	sts	EPD_N_RAW,SysWORDTempX
	sts	EPD_N_RAW_H,SysWORDTempX_H
;if remainder=0 then
	lds	SysCalcTempA,REMAINDER
	tst	SysCalcTempA
	brne	ELSE55_1
;EPD_Ind=EPD_N_raw+EPD_N_Col
	lds	SysTemp1,EPD_N_RAW
	lds	SysTemp2,EPD_N_COL
	add	SysTemp1,SysTemp2
	sts	EPD_IND,SysTemp1
	lds	SysTemp1,EPD_N_RAW_H
	lds	SysTemp2,EPD_N_COL_H
	adc	SysTemp1,SysTemp2
	sts	EPD_IND_H,SysTemp1
;else
	rjmp	ENDIF55
ELSE55_1:
;EPD_Ind=EPD_N_raw+EPD_N_Col+1       'Number of the byte to be set (starting from 1)
	lds	SysTemp2,EPD_N_RAW
	lds	SysTemp3,EPD_N_COL
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,EPD_N_RAW_H
	lds	SysTemp3,EPD_N_COL_H
	adc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	ldi	SysTemp3,1
	add	SysTemp1,SysTemp3
	sts	EPD_IND,SysTemp1
	ldi	SysTemp3,0
	adc	SysTemp1_H,SysTemp3
	sts	EPD_IND_H,SysTemp1_H
;end if
ENDIF55:
;GLCD_Time_Buff=_GLCDPage*BUFFWIDTH
	lds	SysWORDTempA,_GLCDPAGE
	ldi	SysWORDTempA_H,0
	ldi	SysWORDTempB,106
	ldi	SysWORDTempB_H,0
	rcall	SysMultSub16
	sts	GLCD_TIME_BUFF,SysWORDTempX
	sts	GLCD_TIME_BUFF_H,SysWORDTempX_H
;EPD_Ind_Trans=EPD_Ind
	lds	SysValueCopy,EPD_IND
	sts	EPD_IND_TRANS,SysValueCopy
	lds	SysValueCopy,EPD_IND_H
	sts	EPD_IND_TRANS_H,SysValueCopy
;EPD_Ind_Trans=EPD_Ind_Trans-GLCD_Time_Buff
	lds	SysTemp1,EPD_IND_TRANS
	lds	SysTemp2,GLCD_TIME_BUFF
	sub	SysTemp1,SysTemp2
	sts	EPD_IND_TRANS,SysTemp1
	lds	SysTemp1,EPD_IND_TRANS_H
	lds	SysTemp2,GLCD_TIME_BUFF_H
	sbc	SysTemp1,SysTemp2
	sts	EPD_IND_TRANS_H,SysTemp1
;if EPD_Ind_Trans>BUFFWIDTH then       'NOTE:it should be a control also for a
	lds	SysWORDTempB,EPD_IND_TRANS
	lds	SysWORDTempB_H,EPD_IND_TRANS_H
	ldi	SysWORDTempA,106
	ldi	SysWORDTempA_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
;EXIT SUB                            'lower bound of ind (ind>GLCD_Time_Buff)
	ret
;end if                                'However when the lower bound is violated,
;DataVar=EPD_Buffer(EPD_Ind_Trans)     'Ind_Trans should be negative and, due to
	lds	SysTemp1,EPD_IND_TRANS
	ldi	SysTemp3,low(EPD_BUFFER)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	lds	SysTemp1,EPD_IND_TRANS_H
	ldi	SysTemp3,high(EPD_BUFFER)
	adc	SysTemp1,SysTemp3
	mov	SysStringA_H,SysTemp1
	ld	SysValueCopy,X
	sts	DATAVAR,SysValueCopy
;Select Case remainder                 'non signed arithmetic, it will be very
;case 0                                'large, thus Exits sub is executed.
SysSelect4Case1:
	lds	SysCalcTempA,REMAINDER
	tst	SysCalcTempA
	brne	SysSelect4Case2
;DataVar.0=GLCDColour.0
	lds	SysValueCopy,DATAVAR
	cbr	SysValueCopy,1<<0
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<0
	sts	DATAVAR,SysValueCopy
;case 1
	rjmp	SysSelectEnd4
SysSelect4Case2:
	lds	SysCalcTempA,REMAINDER
	cpi	SysCalcTempA,1
	brne	SysSelect4Case3
;DataVar.7=GLCDColour.0
	lds	SysValueCopy,DATAVAR
	cbr	SysValueCopy,1<<7
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<7
	sts	DATAVAR,SysValueCopy
;case 2
	rjmp	SysSelectEnd4
SysSelect4Case3:
	lds	SysCalcTempA,REMAINDER
	cpi	SysCalcTempA,2
	brne	SysSelect4Case4
;DataVar.6=GLCDColour.0
	lds	SysValueCopy,DATAVAR
	cbr	SysValueCopy,1<<6
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<6
	sts	DATAVAR,SysValueCopy
;case 3
	rjmp	SysSelectEnd4
SysSelect4Case4:
	lds	SysCalcTempA,REMAINDER
	cpi	SysCalcTempA,3
	brne	SysSelect4Case5
;DataVar.5=GLCDColour.0
	lds	SysValueCopy,DATAVAR
	cbr	SysValueCopy,1<<5
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<5
	sts	DATAVAR,SysValueCopy
;case 4
	rjmp	SysSelectEnd4
SysSelect4Case5:
	lds	SysCalcTempA,REMAINDER
	cpi	SysCalcTempA,4
	brne	SysSelect4Case6
;DataVar.4=GLCDColour.0
	lds	SysValueCopy,DATAVAR
	cbr	SysValueCopy,1<<4
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<4
	sts	DATAVAR,SysValueCopy
;case 5
	rjmp	SysSelectEnd4
SysSelect4Case6:
	lds	SysCalcTempA,REMAINDER
	cpi	SysCalcTempA,5
	brne	SysSelect4Case7
;DataVar.3=GLCDColour.0
	lds	SysValueCopy,DATAVAR
	cbr	SysValueCopy,1<<3
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<3
	sts	DATAVAR,SysValueCopy
;case 6
	rjmp	SysSelectEnd4
SysSelect4Case7:
	lds	SysCalcTempA,REMAINDER
	cpi	SysCalcTempA,6
	brne	SysSelect4Case8
;DataVar.2=GLCDColour.0
	lds	SysValueCopy,DATAVAR
	cbr	SysValueCopy,1<<2
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<2
	sts	DATAVAR,SysValueCopy
;case 7
	rjmp	SysSelectEnd4
SysSelect4Case8:
	lds	SysCalcTempA,REMAINDER
	cpi	SysCalcTempA,7
	brne	SysSelectEnd4
;DataVar.1=GLCDColour.0
	lds	SysValueCopy,DATAVAR
	cbr	SysValueCopy,1<<1
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<1
	sts	DATAVAR,SysValueCopy
;End Select
SysSelectEnd4:
;EPD_Buffer(EPD_Ind_Trans)=DataVar
	lds	SysTemp1,EPD_IND_TRANS
	ldi	SysTemp3,low(EPD_BUFFER)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	lds	SysTemp1,EPD_IND_TRANS_H
	ldi	SysTemp3,high(EPD_BUFFER)
	adc	SysTemp1,SysTemp3
	mov	SysStringA_H,SysTemp1
	lds	SysValueCopy,DATAVAR
	st	X,SysValueCopy
	ret

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

;Source: epd_epd2in13d.h (898)
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
SysSelect5Case1:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,4
	brne	SysSelect5Case2
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
	rjmp	SysSelectEnd5
SysSelect5Case2:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,1
	brne	SysSelect5Case3
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
	rjmp	SysSelectEnd5
SysSelect5Case3:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,2
	brne	SysSelect5Case4
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
	rjmp	SysSelectEnd5
SysSelect5Case4:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,3
	brne	SysSelect5Case5
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
	rjmp	SysSelectEnd5
SysSelect5Case5:
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
SysSelectEnd5:
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (452)
SENDCOMMAND_EPD2IN13D:
;SET EPD_CS OFF
	cbi	PORTB,2
;SET EPD_DC OFF
	cbi	PORTB,1
;FastHWSPITransfer EPD2in13D_Command
	lds	SysValueCopy,EPD2IN13D_COMMAND
	sts	SPITXDATA,SysValueCopy
	call	FASTHWSPITRANSFER
;SET EPD_CS ON
	sbi	PORTB,2
;do
SysDoLoop_S6:
;loop while EPD_Busy=Off
	sbis	PIND,7
	rjmp	SysDoLoop_S6
SysDoLoop_E6:
;Exit sub
	ret
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
;FastHWSPITransfer EPD2in13D_Data
	lds	SysValueCopy,EPD2IN13D_DATA
	sts	SPITXDATA,SysValueCopy
	call	FASTHWSPITRANSFER
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

;Overloaded signature: BYTE:BYTE:, Source: hwspi.h (354)
SPIMODE645:
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
	rjmp	ENDIF84
;Set SPCR.CPHA On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<CPHA
	out	SPCR,SysValueCopy
;End If
ENDIF84:
;Set SPCR.CPOL Off
	in	SysValueCopy,SPCR
	cbr	SysValueCopy,1<<CPOL
	out	SPCR,SysValueCopy
;If SPIClockMode.1 = On Then
	lds	SysBitTest,SPICLOCKMODE
	sbrs	SysBitTest,1
	rjmp	ENDIF85
;Set SPCR.CPOL On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<CPOL
	out	SPCR,SysValueCopy
;End If
ENDIF85:
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
SysSelect6Case1:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,14
	brne	SysSelect6Case2
;Set SPCR.MSTR On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Set SPSR.SPI2X On
	in	SysValueCopy,SPSR
	sbr	SysValueCopy,1<<SPI2X
	out	SPSR,SysValueCopy
;Case MasterFast
	rjmp	SysSelectEnd6
SysSelect6Case2:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,13
	brne	SysSelect6Case3
;Set SPCR.MSTR On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Case Master
	rjmp	SysSelectEnd6
SysSelect6Case3:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,12
	brne	SysSelect6Case4
;Set SPCR.MSTR On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Set SPCR.SPR0 On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<SPR0
	out	SPCR,SysValueCopy
;Case MasterSlow
	rjmp	SysSelectEnd6
SysSelect6Case4:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,11
	brne	SysSelectEnd6
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
SysSelectEnd6:
;Enable SPI
;Set SPCR.SPE On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<SPE
	out	SPCR,SysValueCopy
	ret

;********************************************************************************

;Overloaded signature: WORD:WORD:, Source: stdbasic.h (284)
SWAP510:
;Dim SysCalcTempX As Word
;SysCalcTempX = SysCalcTempA
	mov	SYSCALCTEMPX,SYSCALCTEMPA
	mov	SYSCALCTEMPX_H,SYSCALCTEMPA_H
;SysCalcTempA = SysCalcTempB
	mov	SYSCALCTEMPA,SYSCALCTEMPB
	mov	SYSCALCTEMPA_H,SYSCALCTEMPB_H
;SysCalcTempB = SysCalcTempX
	mov	SYSCALCTEMPB,SYSCALCTEMPX
	mov	SYSCALCTEMPB_H,SYSCALCTEMPX_H
	ret

;********************************************************************************

;Source: system.h (2613)
SYSCOMPEQUAL:
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clr SysByteTempX
	clr	SYSBYTETEMPX
;cpse SysByteTempA, SysByteTempB
	cpse	SYSBYTETEMPA, SYSBYTETEMPB
;return
	ret
;com SysByteTempX
	com	SYSBYTETEMPX
	ret

;********************************************************************************

;Source: system.h (2639)
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

;Source: system.h (2962)
SYSCOMPLESSTHANINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	ldi	SysValueCopy,0
	mov	SYSBYTETEMPX,SysValueCopy
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	sbrs	SYSINTEGERTEMPA_H,7
	rjmp	ELSE71_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	sbrc	SYSINTEGERTEMPB_H,7
	rjmp	ENDIF72
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	mov	SysTemp1,SYSBYTETEMPX
	com	SysTemp1
	mov	SYSBYTETEMPX,SysTemp1
;Exit Sub
	ret
;End If
ENDIF72:
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	mov	SysTemp1,SYSINTEGERTEMPA
	mov	SysTemp1_H,SYSINTEGERTEMPA_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSDIVMULTA,SysTemp1
	mov	SYSDIVMULTA_H,SysTemp1_H
;SysIntegerTempA = -SysIntegerTempB
	mov	SysTemp1,SYSINTEGERTEMPB
	mov	SysTemp1_H,SYSINTEGERTEMPB_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPA,SysTemp1
	mov	SYSINTEGERTEMPA_H,SysTemp1_H
;SysIntegerTempB = SysDivMultA
	mov	SYSINTEGERTEMPB,SYSDIVMULTA
	mov	SYSINTEGERTEMPB_H,SYSDIVMULTA_H
;+A
;Else
	rjmp	ENDIF71
ELSE71_1:
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	sbrc	SYSINTEGERTEMPB_H,7
;Exit Sub
	ret
;End If
;End If
ENDIF71:
;Test High, exit false if more
;cp SysIntegerTempB_H,SysIntegerTempA_H
	cp	SYSINTEGERTEMPB_H,SYSINTEGERTEMPA_H
;brlo SCLTIntFalse
	brlo	SCLTINTFALSE
;Test high, exit true if less
;cp SysIntegerTempA_H,SysIntegerTempB_H
	cp	SYSINTEGERTEMPA_H,SYSINTEGERTEMPB_H
;brlo SCLTIntTrue
	brlo	SCLTINTTRUE
;Test Low, exit if more or equal
;cp SysIntegerTempA,SysIntegerTempB
	cp	SYSINTEGERTEMPA,SYSINTEGERTEMPB
;brlo SCLTIntTrue
	brlo	SCLTINTTRUE
;ret
	ret
SCLTINTTRUE:
;com SysByteTempX
	com	SYSBYTETEMPX
SCLTINTFALSE:
	ret

;********************************************************************************

;Source: system.h (2457)
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
	rjmp	ENDIF66
;SysWordTempA = 0
	ldi	SYSWORDTEMPA,0
	ldi	SYSWORDTEMPA_H,0
;exit sub
	ret
;end if
ENDIF66:
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
	mov	SysTemp1,SYSDIVMULTX
	sub	SysTemp1,SYSDIVMULTB
	mov	SYSDIVMULTX,SysTemp1
	mov	SysTemp1,SYSDIVMULTX_H
	sbc	SysTemp1,SYSDIVMULTB_H
	mov	SYSDIVMULTX_H,SysTemp1
;Set SysDivMultA.0 On
	sbr	 SYSDIVMULTA,1<<0
;If C On Then
	brbc	C,ENDIF67
;Set SysDivMultA.0 Off
	cbr	 SYSDIVMULTA,1<<0
;SysDivMultX = SysDivMultX + SysDivMultB
	mov	SysTemp1,SYSDIVMULTX
	add	SysTemp1,SYSDIVMULTB
	mov	SYSDIVMULTX,SysTemp1
	mov	SysTemp1,SYSDIVMULTX_H
	adc	SysTemp1,SYSDIVMULTB_H
	mov	SYSDIVMULTX_H,SysTemp1
;End If
ENDIF67:
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

;Source: system.h (2511)
SYSDIVSUBINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	mov	SysTemp1,SYSINTEGERTEMPB_H
	eor	SysTemp1,SYSINTEGERTEMPA_H
	mov	SYSSIGNBYTE,SysTemp1
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	sbrs	SYSINTEGERTEMPA_H,7
	rjmp	ENDIF68
	mov	SysTemp1,SYSINTEGERTEMPA
	mov	SysTemp1_H,SYSINTEGERTEMPA_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPA,SysTemp1
	mov	SYSINTEGERTEMPA_H,SysTemp1_H
ENDIF68:
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	sbrs	SYSINTEGERTEMPB_H,7
	rjmp	ENDIF69
	mov	SysTemp1,SYSINTEGERTEMPB
	mov	SysTemp1_H,SYSINTEGERTEMPB_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPB,SysTemp1
	mov	SYSINTEGERTEMPB_H,SysTemp1_H
ENDIF69:
;Call word divide routine
;SysDivSub16
	rcall	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	sbrs	SYSSIGNBYTE,7
	rjmp	ENDIF70
;SysIntegerTempA = -SysIntegerTempA
	mov	SysTemp1,SYSINTEGERTEMPA
	mov	SysTemp1_H,SYSINTEGERTEMPA_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPA,SysTemp1
	mov	SYSINTEGERTEMPA_H,SysTemp1_H
;SysIntegerTempX = -SysIntegerTempX
	mov	SysTemp1,SYSINTEGERTEMPX
	mov	SysTemp1_H,SYSINTEGERTEMPX_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPX,SysTemp1
	mov	SYSINTEGERTEMPX_H,SysTemp1_H
;End If
ENDIF70:
	ret

;********************************************************************************

;Source: system.h (2212)
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

;Source: system.h (2310)
SYSMULTSUBINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	mov	SysTemp1,SYSINTEGERTEMPB_H
	eor	SysTemp1,SYSINTEGERTEMPA_H
	mov	SYSSIGNBYTE,SysTemp1
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	sbrs	SYSINTEGERTEMPA_H,7
	rjmp	ENDIF63
	mov	SysTemp1,SYSINTEGERTEMPA
	mov	SysTemp1_H,SYSINTEGERTEMPA_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPA,SysTemp1
	mov	SYSINTEGERTEMPA_H,SysTemp1_H
ENDIF63:
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	sbrs	SYSINTEGERTEMPB_H,7
	rjmp	ENDIF64
	mov	SysTemp1,SYSINTEGERTEMPB
	mov	SysTemp1_H,SYSINTEGERTEMPB_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPB,SysTemp1
	mov	SYSINTEGERTEMPB_H,SysTemp1_H
ENDIF64:
;Call word multiply routine
;SysMultSub16
	rcall	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	sbrs	SYSSIGNBYTE,7
	rjmp	ENDIF65
	mov	SysTemp1,SYSINTEGERTEMPX
	mov	SysTemp1_H,SYSINTEGERTEMPX_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPX,SysTemp1
	mov	SYSINTEGERTEMPX_H,SysTemp1_H
ENDIF65:
	ret

;********************************************************************************

;Source: system.h (1240)
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
.DB	14,84,101,115,116,32,64,32,68,101,102,97,117,108,116,0


StringTable2:
.DB	6,32,108,105,110,101,49,0


StringTable3:
.DB	6,76,105,110,101,32,52,0


StringTable4:
.DB	6,76,105,110,101,32,53,0


StringTable5:
.DB	15,84,101,115,116,32,64,32,80,111,114,116,114,97,105,116


StringTable6:
.DB	19,84,101,115,116,32,64,32,80,111,114,116,114,97,105,116,95,114,101,118


StringTable7:
.DB	16,84,101,115,116,32,64,32,76,97,110,100,115,99,97,112,101,0


StringTable8:
.DB	20,84,101,115,116,32,64,32,76,97,110,100,115,99,97,112,101,95,82,101,118,0


;********************************************************************************


