;Program compiled by Great Cow BASIC (0.98.04 2018-10-20 (Windows 32 bit))
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
.EQU	ABS=424
.EQU	ABS_H=425
.EQU	CHARCODE=426
.EQU	CHARCOL=427
.EQU	CHARCOL_H=428
.EQU	CHARLOCX=429
.EQU	CHARLOCX_H=430
.EQU	CHARLOCY=431
.EQU	CHARLOCY_H=432
.EQU	COLSPERFONT=433
.EQU	CURRCHARCOL=434
.EQU	CURRCHARROW=435
.EQU	CURRCHARVAL=436
.EQU	CURRENT_GLCD_HEIGHT=437
.EQU	CURRENT_GLCD_HEIGHT_H=438
.EQU	CURRENT_GLCD_WIDTH=439
.EQU	CURRENT_GLCD_WIDTH_H=440
.EQU	DDF_X=441
.EQU	DDF_X_H=442
.EQU	DDF_Y=443
.EQU	DDF_Y_H=444
.EQU	DRAWLINE=445
.EQU	DRAWLINE_H=446
.EQU	FF=447
.EQU	FF_H=448
.EQU	FILLCIRCLEXX=449
.EQU	FILLCIRCLEYY=450
.EQU	GCBBUILDSTR=412
.EQU	GCBBUILDTIMESTR=392
.EQU	GLCDBACKGROUND=451
.EQU	GLCDBACKGROUND_H=452
.EQU	GLCDCLS_HIBYTEPORTION1=453
.EQU	GLCDCLS_HIBYTEPORTION2=454
.EQU	GLCDCLS_LOBYTEPORTION1=455
.EQU	GLCDCLS_LOBYTEPORTION2=456
.EQU	GLCDCOLOUR=457
.EQU	GLCDCOLOUR_H=458
.EQU	GLCDDEVICEHEIGHT=459
.EQU	GLCDDEVICEHEIGHT_H=460
.EQU	GLCDDEVICEWIDTH=461
.EQU	GLCDDEVICEWIDTH_H=462
.EQU	GLCDFNTDEFAULT=463
.EQU	GLCDFNTDEFAULTSIZE=464
.EQU	GLCDFONTWIDTH=465
.EQU	GLCDFOREGROUND=466
.EQU	GLCDFOREGROUND_H=467
.EQU	GLCDPRINTLEN=468
.EQU	GLCDPRINTLOC=469
.EQU	GLCDPRINTLOC_H=470
.EQU	GLCDPRINT_STRING_COUNTER=471
.EQU	GLCDROTATESTATE=472
.EQU	GLCDTEMP=473
.EQU	GLCDTEMP_H=474
.EQU	GLCDX=475
.EQU	GLCDX_H=476
.EQU	GLCDY=477
.EQU	GLCDY_H=478
.EQU	GLCD_YORDINATE=479
.EQU	GLCD_YORDINATE_H=480
.EQU	ILI9481SENDWORD=481
.EQU	ILI9481SENDWORD_H=482
.EQU	ILI9486LSENDBYTE=483
.EQU	ILI9486LSENDWORD=484
.EQU	ILI9486LSENDWORD_H=485
.EQU	ILI9486LTEMPOUT=486
.EQU	LINECOLOUR=487
.EQU	LINECOLOUR_H=488
.EQU	LINEDIFFX=489
.EQU	LINEDIFFX_H=490
.EQU	LINEDIFFX_X2=491
.EQU	LINEDIFFX_X2_H=492
.EQU	LINEDIFFY=493
.EQU	LINEDIFFY_H=494
.EQU	LINEDIFFY_X2=495
.EQU	LINEDIFFY_X2_H=496
.EQU	LINEERR=497
.EQU	LINEERR_H=498
.EQU	LINESTEPX=499
.EQU	LINESTEPX_H=500
.EQU	LINESTEPY=501
.EQU	LINESTEPY_H=502
.EQU	LINEX1=503
.EQU	LINEX1_H=504
.EQU	LINEX2=505
.EQU	LINEX2_H=506
.EQU	LINEY1=507
.EQU	LINEY1_H=508
.EQU	LINEY2=509
.EQU	LINEY2_H=510
.EQU	LOCALCHARCODE=511
.EQU	LOCALCHARCODE_H=512
.EQU	L_CALIBRATE=513
.EQU	L_CALIBRATE_H=514
.EQU	L_FROMHIGH=515
.EQU	L_FROMHIGH_H=516
.EQU	L_FROMLOW=517
.EQU	L_FROMLOW_H=518
.EQU	L_MAP=519
.EQU	L_MAP_H=520
.EQU	L_SYSCALC=521
.EQU	L_SYSCALCF=523
.EQU	L_SYSCALCF_E=526
.EQU	L_SYSCALCF_H=524
.EQU	L_SYSCALCF_U=525
.EQU	L_SYSCALC_H=522
.EQU	L_TOHIGH=527
.EQU	L_TOHIGH_H=528
.EQU	L_TOLOW=529
.EQU	L_TOLOW_H=530
.EQU	NEWXTOUCHPOINT_XPT2046=531
.EQU	NEWXTOUCHPOINT_XPT2046_H=532
.EQU	NEWYTOUCHPOINT_XPT2046=533
.EQU	NEWYTOUCHPOINT_XPT2046_H=534
.EQU	OLDGLCDBACKGROUND=535
.EQU	OLDGLCDBACKGROUND_H=536
.EQU	OLDGLCDFONTWIDTH=537
.EQU	PAD=256
.EQU	PRECISION=538
.EQU	PRINTLOCX=539
.EQU	PRINTLOCX_H=540
.EQU	PRINTLOCY=541
.EQU	PRINTLOCY_H=542
.EQU	ROWSPERFONT=543
.EQU	SCALE=544
.EQU	SCALE_H=545
.EQU	SPICLOCKMODE=546
.EQU	SPICURRENTMODE=547
.EQU	SPIRXDATA=548
.EQU	SPITXDATA=549
.EQU	STR=418
.EQU	STRINGPOINTER=550
.EQU	SYSARRAYTEMP1=551
.EQU	SYSARRAYTEMP2=552
.EQU	SYSCHARCOUNT=553
.EQU	SYSFNINTEGER1=554
.EQU	SYSFNINTEGER1_H=555
.EQU	SYSLCDPRINTDATAHANDLER=556
.EQU	SYSLCDPRINTDATAHANDLER_H=557
.EQU	SYSLONGDIVMULTA=558
.EQU	SYSLONGDIVMULTA_E=561
.EQU	SYSLONGDIVMULTA_H=559
.EQU	SYSLONGDIVMULTA_U=560
.EQU	SYSLONGDIVMULTB=562
.EQU	SYSLONGDIVMULTB_E=565
.EQU	SYSLONGDIVMULTB_H=563
.EQU	SYSLONGDIVMULTB_U=564
.EQU	SYSLONGDIVMULTX=566
.EQU	SYSLONGDIVMULTX_E=569
.EQU	SYSLONGDIVMULTX_H=567
.EQU	SYSLONGDIVMULTX_U=568
.EQU	SYSREPEATTEMP1=570
.EQU	SYSREPEATTEMP2=571
.EQU	SYSREPEATTEMP3=572
.EQU	SYSREPEATTEMP5=573
.EQU	SYSREPEATTEMP6=574
.EQU	SYSREPEATTEMP7=575
.EQU	SYSSTRDATA=576
.EQU	SYSSTRINGPARAM1=338
.EQU	SYSSTRINGPARAM2=365
.EQU	SYSSTRINGTEMP=577
.EQU	SYSSTRLEN=578
.EQU	SYSSYSINSTRING3HANDLER=579
.EQU	SYSSYSINSTRING3HANDLER_H=580
.EQU	SYSSYSINSTRINGHANDLER=581
.EQU	SYSSYSINSTRINGHANDLER_H=582
.EQU	SYSVALTEMP=583
.EQU	SYSVALTEMP_H=584
.EQU	VERSIONSTRING=297
.EQU	XCONVERGE=585
.EQU	XCONVERGE_H=586
.EQU	XOFFSET=587
.EQU	XOFFSET_H=588
.EQU	XPT2046OUTBYTE=589
.EQU	XPT2046SENDBYTE=590
.EQU	XPT2046TEMPOUT=591
.EQU	XPT2046_XMAX=592
.EQU	XPT2046_XMAX_H=593
.EQU	XPT2046_XMIN=594
.EQU	XPT2046_XMIN_H=595
.EQU	XPT2046_YMAX=596
.EQU	XPT2046_YMAX_H=597
.EQU	XPT2046_YMIN=598
.EQU	XPT2046_YMIN_H=599
.EQU	XRADIUS=600
.EQU	XRADIUS_H=601
.EQU	XTOUCHPOINT_XPT2046=602
.EQU	XTOUCHPOINT_XPT2046RAW=604
.EQU	XTOUCHPOINT_XPT2046RAW_H=605
.EQU	XTOUCHPOINT_XPT2046_H=603
.EQU	YCALC1=606
.EQU	YCALC1_H=607
.EQU	YCALC2=608
.EQU	YCALC2_H=609
.EQU	YCONVERGE=610
.EQU	YCONVERGE_H=611
.EQU	YOFFSET=612
.EQU	YOFFSET_H=613
.EQU	YTOUCHPOINT_XPT2046=614
.EQU	YTOUCHPOINT_XPT2046RAW=616
.EQU	YTOUCHPOINT_XPT2046RAW_H=617
.EQU	YTOUCHPOINT_XPT2046_H=615
.EQU	_X1=618
.EQU	_X1_H=619
.EQU	_X2=620
.EQU	_X2_H=621
.EQU	_Y1=622
.EQU	_Y1_H=623
.EQU	_Y2=624
.EQU	_Y2_H=625

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
.DEF	SYSLONGTEMPA=r22
.DEF	SYSLONGTEMPA_H=r23
.DEF	SYSLONGTEMPA_U=r24
.DEF	SYSLONGTEMPA_E=r25
.DEF	SYSLONGTEMPB=r28
.DEF	SYSLONGTEMPB_H=r29
.DEF	SYSLONGTEMPB_U=r30
.DEF	SYSLONGTEMPB_E=r31
.DEF	SYSLONGTEMPX=r0
.DEF	SYSLONGTEMPX_H=r1
.DEF	SYSLONGTEMPX_U=r2
.DEF	SYSLONGTEMPX_E=r3
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
.DEF	SYSWAITTEMPUS=r27
.DEF	SYSWAITTEMPUS_H=r28
.DEF	SYSWORDTEMPA=r22
.DEF	SYSWORDTEMPA_H=r23
.DEF	SYSWORDTEMPB=r28
.DEF	SYSWORDTEMPB_H=r29
.DEF	SYSWORDTEMPX=r0
.DEF	SYSWORDTEMPX_H=r1
.DEF	SYSTEMP1=r6
.DEF	SYSTEMP1_H=r7
.DEF	SYSTEMP1_U=r8
.DEF	SYSTEMP1_E=r9
.DEF	SYSTEMP2=r10
.DEF	SYSTEMP2_H=r11
.DEF	SYSTEMP3=r12
.DEF	SYSTEMP4=r16
.DEF	SYSTEMP5=r17

;********************************************************************************

;Alias variables
#define	SYSPAD_0	256
#define	SYSSTR_0	418

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
	call	INITUNO
	call	INIT_XPT2046
	call	INITGLCD_ILI9486L

;Start of the main program
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program is a GLCD demonstration maps the #1 character for the OLED font 1
;''The GLCD is connected to the microprocessor as shown in the hardware section of this code.
;''@author  EvanV
;''@licence GPL
;''@version 1.0
;''@date    05.01.17
;''********************************************************************************
;Chip Settings.
;#define GLCD_TYPE GLCD_TYPE_ILI9486L
;Pin mappings for SPI - this GLCD driver supports Hardware SPI and Software SPI
;#define GLCD_DC       DIGITAL_8         ' Data command line
;#define GLCD_CS       DIGITAL_10        ' Chip select line
;#define GLCD_RST      DIGITAL_9         ' Reset line
;#define GLCD_DI       DIGITAL_12          ' Data in | MISO
;#define GLCD_DO       DIGITAL_11          ' Data out | MOSI
;#define GLCD_SCK      DIGITAL_13          ' Clock Line
;#define ILI9486L_HardwareSPI    ' remove/comment out if you want to use software SPI.
;End of GLCD specific setup
;*****************************************************************************************
;Setup the XPT2046
;Typical calibration range for Hardware SPI when using XPT2046
;for 320 * 240 screeen... may be different for others
;#define XPT2046XMIN   12
;#define XPT2046YMIN   10
;#define XPT2046XMAX   108
;#define XPT2046YMAX   117
;#define XPT2046_ReadSamples 15
;Typical Calibration range for Software SPI when using XPT2046
;#define XPT2046XMIN   30
;#define XPT2046YMIN   25
;#define XPT2046XMAX   210
;#define XPT2046YMAX   225
;#define XPT2046_DI       DIGITAL_12          ' Data in | MISO
;#define XPT2046_DO       DIGITAL_11          ' Data out | MOSI
;#define XPT2046_SCK      DIGITAL_13          ' Clock Line
;#define XPT2046_CS       DIGITAL_2           ' Chip select line
;#define XPT2046_IRQ      ANALOG_5
;#define XPT2046_HardwareSPI                  ' remove/comment out if you want to use software SPI - must use same method as GLCD
;Set the initial calibration - shown here to show the method
;SetCalibation_XPT2046 ( XPT2046XMIN, XPT2046XMAX, XPT2046YMIN, XPT2046YMAX, GLCD_WIDTH, GLCD_HEIGHT )
	ldi	SysValueCopy,12
	sts	XPT2046_XMIN,SysValueCopy
	ldi	SysValueCopy,0
	sts	XPT2046_XMIN_H,SysValueCopy
	ldi	SysValueCopy,108
	sts	XPT2046_XMAX,SysValueCopy
	ldi	SysValueCopy,0
	sts	XPT2046_XMAX_H,SysValueCopy
	ldi	SysValueCopy,10
	sts	XPT2046_YMIN,SysValueCopy
	ldi	SysValueCopy,0
	sts	XPT2046_YMIN_H,SysValueCopy
	ldi	SysValueCopy,117
	sts	XPT2046_YMAX,SysValueCopy
	ldi	SysValueCopy,0
	sts	XPT2046_YMAX_H,SysValueCopy
	ldi	SysValueCopy,64
	sts	CURRENT_GLCD_WIDTH,SysValueCopy
	ldi	SysValueCopy,1
	sts	CURRENT_GLCD_WIDTH_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	CURRENT_GLCD_HEIGHT,SysValueCopy
	ldi	SysValueCopy,1
	sts	CURRENT_GLCD_HEIGHT_H,SysValueCopy
	call	SETCALIBATION_XPT204637
;******************************************************************************************************
;Main program
;GLCDCLS TFT_NAVY
	ldi	SysValueCopy,15
	sts	GLCDBACKGROUND,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDBACKGROUND_H,SysValueCopy
	rcall	GLCDCLS_ILI9486L
;ScreenLayout
	call	SCREENLAYOUT
;dim Xconverge, Yconverge as Integer
;do
SysDoLoop_S1:
;Xconverge = 0
	ldi	SysValueCopy,0
	sts	XCONVERGE,SysValueCopy
	sts	XCONVERGE_H,SysValueCopy
;Yconverge = 0
	ldi	SysValueCopy,0
	sts	YCONVERGE,SysValueCopy
	sts	YCONVERGE_H,SysValueCopy
;filledbox Current_GLCD_WIDTH, 0, Current_GLCD_WIDTH-10, 10, TFT_RED
	lds	SysValueCopy,CURRENT_GLCD_WIDTH
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_WIDTH_H
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1,SysValueCopy
	sts	LINEY1_H,SysValueCopy
	lds	SysTemp3,CURRENT_GLCD_WIDTH
	ldi	SysTemp4,10
	sub	SysTemp3,SysTemp4
	sts	LINEX2,SysTemp3
	lds	SysTemp3,CURRENT_GLCD_WIDTH_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	LINEX2_H,SysTemp3
	ldi	SysValueCopy,10
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,248
	sts	LINECOLOUR_H,SysValueCopy
	rcall	FILLEDBOX_ILI9486L
;always wait for touch event
;wait while isTouched_XPT2046
SysWaitLoop1:
	sbic	PINC,5
	rjmp	SysWaitLoop1
;filledbox Current_GLCD_WIDTH, 0, Current_GLCD_WIDTH-10, 10, TFT_YELLOW
	lds	SysValueCopy,CURRENT_GLCD_WIDTH
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_WIDTH_H
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1,SysValueCopy
	sts	LINEY1_H,SysValueCopy
	lds	SysTemp3,CURRENT_GLCD_WIDTH
	ldi	SysTemp4,10
	sub	SysTemp3,SysTemp4
	sts	LINEX2,SysTemp3
	lds	SysTemp3,CURRENT_GLCD_WIDTH_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	LINEX2_H,SysTemp3
	ldi	SysValueCopy,10
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,255
	sts	LINECOLOUR_H,SysValueCopy
	rcall	FILLEDBOX_ILI9486L
;do
SysDoLoop_S2:
;repeat 5
	ldi	SysValueCopy,5
	sts	SysRepeatTemp1,SysValueCopy
SysRepeatLoop1:
;get the values -
;GetXY_XPT2046( XTouchPoint_XPT2046, YTouchPoint_XPT2046 )
	rcall	GETXY_XPT2046
;end Repeat
	lds	SysTemp1,SysRepeatTemp1
	dec	SysTemp1
	sts	SysRepeatTemp1,SysTemp1
	brne	SysRepeatLoop1
SysRepeatLoopEnd1:
;test for settling by testing for convergance
;if ABS( ( Xconverge - XTouchPoint_XPT2046 ) ) > 1  or  ABS( ( Yconverge - YTouchPoint_XPT2046 ) ) > 1  then
	lds	SysTemp3,XCONVERGE
	lds	SysTemp1,XTOUCHPOINT_XPT2046
	sub	SysTemp3,SysTemp1
	mov	SYSCALCTEMPA,SysTemp3
	lds	SysTemp3,XCONVERGE_H
	lds	SysTemp1,XTOUCHPOINT_XPT2046_H
	sbc	SysTemp3,SysTemp1
	mov	SYSCALCTEMPA_H,SysTemp3
	rcall	FN_ABS
	lds	SysValueCopy,ABS
	sts	SysFnINTEGER1,SysValueCopy
	lds	SysValueCopy,ABS_H
	sts	SysFnINTEGER1_H,SysValueCopy
	lds	SysTemp3,YCONVERGE
	lds	SysTemp1,YTOUCHPOINT_XPT2046
	sub	SysTemp3,SysTemp1
	mov	SYSCALCTEMPA,SysTemp3
	lds	SysTemp3,YCONVERGE_H
	lds	SysTemp1,YTOUCHPOINT_XPT2046_H
	sbc	SysTemp3,SysTemp1
	mov	SYSCALCTEMPA_H,SysTemp3
	rcall	FN_ABS
	lds	SysINTEGERTempB,SysFnINTEGER1
	lds	SysINTEGERTempB_H,SysFnINTEGER1_H
	ldi	SysINTEGERTempA,1
	ldi	SysINTEGERTempA_H,0
	call	SysCompLessThanINT
	mov	SysTemp1,SysByteTempX
	lds	SysINTEGERTempB,ABS
	lds	SysINTEGERTempB_H,ABS_H
	ldi	SysINTEGERTempA,1
	ldi	SysINTEGERTempA_H,0
	call	SysCompLessThanINT
	mov	SysTemp3,SysByteTempX
	or	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	sbrs	SysTemp2,0
	rjmp	ELSE1_1
;Xconverge = XTouchPoint_XPT2046
	lds	SysValueCopy,XTOUCHPOINT_XPT2046
	sts	XCONVERGE,SysValueCopy
	lds	SysValueCopy,XTOUCHPOINT_XPT2046_H
	sts	XCONVERGE_H,SysValueCopy
;Yconverge = YTouchPoint_XPT2046
	lds	SysValueCopy,YTOUCHPOINT_XPT2046
	sts	YCONVERGE,SysValueCopy
	lds	SysValueCopy,YTOUCHPOINT_XPT2046_H
	sts	YCONVERGE_H,SysValueCopy
;Else
	rjmp	ENDIF1
ELSE1_1:
;converged
;exit do
	rjmp	SysDoLoop_E2
;end if
ENDIF1:
;Loop
	rjmp	SysDoLoop_S2
SysDoLoop_E2:
;Flip the data to handle for the screen rotation
;YTouchPoint_XPT2046 = Current_GLCD_HEIGHT - YTouchPoint_XPT2046
	lds	SysTemp3,CURRENT_GLCD_HEIGHT
	lds	SysTemp1,YTOUCHPOINT_XPT2046
	sub	SysTemp3,SysTemp1
	sts	YTOUCHPOINT_XPT2046,SysTemp3
	lds	SysTemp3,CURRENT_GLCD_HEIGHT_H
	lds	SysTemp1,YTOUCHPOINT_XPT2046_H
	sbc	SysTemp3,SysTemp1
	sts	YTOUCHPOINT_XPT2046_H,SysTemp3
;filledbox Current_GLCD_WIDTH, 0, Current_GLCD_WIDTH-10, 10, TFT_GREEN
	lds	SysValueCopy,CURRENT_GLCD_WIDTH
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_WIDTH_H
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1,SysValueCopy
	sts	LINEY1_H,SysValueCopy
	lds	SysTemp3,CURRENT_GLCD_WIDTH
	ldi	SysTemp4,10
	sub	SysTemp3,SysTemp4
	sts	LINEX2,SysTemp3
	lds	SysTemp3,CURRENT_GLCD_WIDTH_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	LINEX2_H,SysTemp3
	ldi	SysValueCopy,10
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,7
	sts	LINECOLOUR_H,SysValueCopy
	rcall	FILLEDBOX_ILI9486L
;if XTouchPoint_XPT2046 > Current_GLCD_WIDTH-59 and YTouchPoint_XPT2046 > Current_GLCD_HEIGHT-20  then
	lds	SysTemp2,CURRENT_GLCD_WIDTH
	ldi	SysTemp4,59
	sub	SysTemp2,SysTemp4
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,CURRENT_GLCD_WIDTH_H
	ldi	SysTemp4,0
	sbc	SysTemp2,SysTemp4
	mov	SysTemp1_H,SysTemp2
	lds	SysTemp3,CURRENT_GLCD_HEIGHT
	ldi	SysTemp4,20
	sub	SysTemp3,SysTemp4
	mov	SysTemp2,SysTemp3
	lds	SysTemp3,CURRENT_GLCD_HEIGHT_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	mov	SysTemp2_H,SysTemp3
	lds	SysWORDTempB,XTOUCHPOINT_XPT2046
	lds	SysWORDTempB_H,XTOUCHPOINT_XPT2046_H
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	call	SysCompLessThan16
	mov	SysTemp3,SysByteTempX
	lds	SysWORDTempB,YTOUCHPOINT_XPT2046
	lds	SysWORDTempB_H,YTOUCHPOINT_XPT2046_H
	mov	SysWORDTempA,SysTemp2
	mov	SysWORDTempA_H,SysTemp2_H
	call	SysCompLessThan16
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	sbrs	SysTemp1,0
	rjmp	ELSE2_1
;if XTouchPoint_XPT2046 < Current_GLCD_WIDTH and  YTouchPoint_XPT2046 < Current_GLCD_HEIGHT then
	lds	SysWORDTempA,XTOUCHPOINT_XPT2046
	lds	SysWORDTempA_H,XTOUCHPOINT_XPT2046_H
	lds	SysWORDTempB,CURRENT_GLCD_WIDTH
	lds	SysWORDTempB_H,CURRENT_GLCD_WIDTH_H
	call	SysCompLessThan16
	mov	SysTemp3,SysByteTempX
	lds	SysWORDTempA,YTOUCHPOINT_XPT2046
	lds	SysWORDTempA_H,YTOUCHPOINT_XPT2046_H
	lds	SysWORDTempB,CURRENT_GLCD_HEIGHT
	lds	SysWORDTempB_H,CURRENT_GLCD_HEIGHT_H
	call	SysCompLessThan16
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	sbrc	SysTemp1,0
;clear
;ScreenLayout
	call	SCREENLAYOUT
;end if
ENDIF3:
;else
	rjmp	ENDIF2
ELSE2_1:
;FilledCircle XTouchPoint_XPT2046, YTouchPoint_XPT2046, 3, TFT_LIGHTGREY
	lds	SysValueCopy,XTOUCHPOINT_XPT2046
	sts	XOFFSET,SysValueCopy
	lds	SysValueCopy,XTOUCHPOINT_XPT2046_H
	sts	XOFFSET_H,SysValueCopy
	lds	SysValueCopy,YTOUCHPOINT_XPT2046
	sts	YOFFSET,SysValueCopy
	lds	SysValueCopy,YTOUCHPOINT_XPT2046_H
	sts	YOFFSET_H,SysValueCopy
	ldi	SysValueCopy,3
	sts	XRADIUS,SysValueCopy
	ldi	SysValueCopy,0
	sts	XRADIUS_H,SysValueCopy
	ldi	SysValueCopy,24
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,198
	sts	LINECOLOUR_H,SysValueCopy
	rcall	FILLEDCIRCLE
;Show the raw data
;GLCDPrint ( 24, 56, pad(str(XTouchPoint_XPT2046raw),3 ) )
	ldi	SysValueCopy,24
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,56
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,XTOUCHPOINT_XPT2046RAW
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,XTOUCHPOINT_XPT2046RAW_H
	sts	SYSVALTEMP_H,SysValueCopy
	call	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,3
	sts	SYSSTRLEN,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable50<<1)
	ldi	SysReadA_H,high(StringTable50<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler_H,SysValueCopy
	call	FN_PAD
	ldi	SysValueCopy,low(PAD)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(PAD)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	rcall	GLCDPRINT4
;GLCDPrint ( 24, 72, pad(str(YTouchPoint_XPT2046raw),3 ) )
	ldi	SysValueCopy,24
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,72
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,YTOUCHPOINT_XPT2046RAW
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,YTOUCHPOINT_XPT2046RAW_H
	sts	SYSVALTEMP_H,SysValueCopy
	call	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,3
	sts	SYSSTRLEN,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable50<<1)
	ldi	SysReadA_H,high(StringTable50<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler_H,SysValueCopy
	call	FN_PAD
	ldi	SysValueCopy,low(PAD)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(PAD)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	rcall	GLCDPRINT4
;Automatically adjust the values to min and max
;Not needed in a real program use SetCalibation_XPT2046( XPT2046_Xmin, XPT2046_Xmax, XPT2046_Ymin, XPT2046_Ymax )
;if XTouchPoint_XPT2046raw < XPT2046_Xmin then XPT2046_Xmin = XTouchPoint_XPT2046raw
	lds	SysWORDTempA,XTOUCHPOINT_XPT2046RAW
	lds	SysWORDTempA_H,XTOUCHPOINT_XPT2046RAW_H
	lds	SysWORDTempB,XPT2046_XMIN
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF4
	lds	SysValueCopy,XTOUCHPOINT_XPT2046RAW
	sts	XPT2046_XMIN,SysValueCopy
ENDIF4:
;if YTouchPoint_XPT2046raw < XPT2046_Ymin then XPT2046_Ymin = YTouchPoint_XPT2046raw
	lds	SysWORDTempA,YTOUCHPOINT_XPT2046RAW
	lds	SysWORDTempA_H,YTOUCHPOINT_XPT2046RAW_H
	lds	SysWORDTempB,XPT2046_YMIN
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF5
	lds	SysValueCopy,YTOUCHPOINT_XPT2046RAW
	sts	XPT2046_YMIN,SysValueCopy
ENDIF5:
;if XTouchPoint_XPT2046raw > XPT2046_Xmax then XPT2046_Xmax = XTouchPoint_XPT2046raw
	lds	SysWORDTempB,XTOUCHPOINT_XPT2046RAW
	lds	SysWORDTempB_H,XTOUCHPOINT_XPT2046RAW_H
	lds	SysWORDTempA,XPT2046_XMAX
	ldi	SysWORDTempA_H,0
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF6
	lds	SysValueCopy,XTOUCHPOINT_XPT2046RAW
	sts	XPT2046_XMAX,SysValueCopy
ENDIF6:
;if YTouchPoint_XPT2046raw  > XPT2046_Ymax then XPT2046_Ymax = YTouchPoint_XPT2046raw
	lds	SysWORDTempB,YTOUCHPOINT_XPT2046RAW
	lds	SysWORDTempB_H,YTOUCHPOINT_XPT2046RAW_H
	lds	SysWORDTempA,XPT2046_YMAX
	ldi	SysWORDTempA_H,0
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF7
	lds	SysValueCopy,YTOUCHPOINT_XPT2046RAW
	sts	XPT2046_YMAX,SysValueCopy
ENDIF7:
;show the values
;GLCDPrint ( 102, 56, pad(str(XPT2046_Xmin),3 ) )
	ldi	SysValueCopy,102
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,56
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,XPT2046_XMIN
	sts	SYSVALTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSVALTEMP_H,SysValueCopy
	call	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,3
	sts	SYSSTRLEN,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable50<<1)
	ldi	SysReadA_H,high(StringTable50<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler_H,SysValueCopy
	call	FN_PAD
	ldi	SysValueCopy,low(PAD)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(PAD)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	rcall	GLCDPRINT4
;GLCDPrint ( 102, 72, pad(str(XPT2046_Ymin),3 ) )
	ldi	SysValueCopy,102
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,72
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,XPT2046_YMIN
	sts	SYSVALTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSVALTEMP_H,SysValueCopy
	call	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,3
	sts	SYSSTRLEN,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable50<<1)
	ldi	SysReadA_H,high(StringTable50<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler_H,SysValueCopy
	call	FN_PAD
	ldi	SysValueCopy,low(PAD)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(PAD)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	rcall	GLCDPRINT4
;GLCDPrint ( 162, 56, pad(str(XPT2046_Xmax),3 ) )
	ldi	SysValueCopy,162
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,56
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,XPT2046_XMAX
	sts	SYSVALTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSVALTEMP_H,SysValueCopy
	call	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,3
	sts	SYSSTRLEN,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable50<<1)
	ldi	SysReadA_H,high(StringTable50<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler_H,SysValueCopy
	call	FN_PAD
	ldi	SysValueCopy,low(PAD)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(PAD)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	rcall	GLCDPRINT4
;GLCDPrint ( 162, 72, pad(str(XPT2046_Ymax),3 ) )
	ldi	SysValueCopy,162
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,72
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,XPT2046_YMAX
	sts	SYSVALTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSVALTEMP_H,SysValueCopy
	call	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,3
	sts	SYSSTRLEN,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable50<<1)
	ldi	SysReadA_H,high(StringTable50<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler_H,SysValueCopy
	call	FN_PAD
	ldi	SysValueCopy,low(PAD)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(PAD)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	rcall	GLCDPRINT4
;GLCDPrint ( 24, 230, pad(str(XTouchPoint_XPT2046),5 ))
	ldi	SysValueCopy,24
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,230
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,XTOUCHPOINT_XPT2046
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,XTOUCHPOINT_XPT2046_H
	sts	SYSVALTEMP_H,SysValueCopy
	call	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,5
	sts	SYSSTRLEN,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable50<<1)
	ldi	SysReadA_H,high(StringTable50<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler_H,SysValueCopy
	call	FN_PAD
	ldi	SysValueCopy,low(PAD)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(PAD)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	rcall	GLCDPRINT4
;GLCDPrint ( 24, 246, pad(str(YTouchPoint_XPT2046),5 ))
	ldi	SysValueCopy,24
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,246
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,YTOUCHPOINT_XPT2046
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,YTOUCHPOINT_XPT2046_H
	sts	SYSVALTEMP_H,SysValueCopy
	call	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,5
	sts	SYSSTRLEN,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable50<<1)
	ldi	SysReadA_H,high(StringTable50<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler_H,SysValueCopy
	call	FN_PAD
	ldi	SysValueCopy,low(PAD)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(PAD)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	rcall	GLCDPRINT4
;do not hammer the touch
;wait 20 ms
	ldi	SysWaitTempMS,20
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;end if
ENDIF2:
;loop
	rjmp	SysDoLoop_S1
SysDoLoop_E1:
;#define GLCD_OLED_FONT
TABLEFOROLEDFONT2:
INDEXFOROLEDEXTENDEDFONT1:
DATAFOROLEDFONT1:
TABLEFOROLEDEXTENDEDFONT2:
;#define isTouched_XPT2046  XPT2046_IRQ = 1
;#define KS0108ReadDelay   9     ; 2 normal usage, 3 for 32 mhz!
;#define KS0108WriteDelay  1     ; 1 normal usage, 0 works
;#define KS0108ClockDelay  1     ; 1 normal usage, 0 works
;#define GLCDDirection     0     ; 0 normal mode
;#define NT7108CReadDelay    7      ; = 7 normal usage, 5 or above is OK at 32 mhz!
;#define NT7108CWriteDelay   7      ; = 7 normal usage you may get away with other lower values
;#define NT7108CClockDelay   7      ; = 7 normal usage you may get away with other lower values
;#define GLCDDirection     0     ; 0 normal mode
;#define InitGLCD_ILI9341 nop
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
;#define HX8347_GLCD_RST GLCD_RST
;#define HX8347_GLCD_CS GLCD_CS
;#define HX8347_GLCD_RS GLCD_RS
;#define HX8347_GLCD_WR GLCD_WR
;#define HX8347_GLCD_RD GLCD_RD
;#define HX8347_GLCD_DB0 GLCD_DB0
;#define HX8347_GLCD_DB1 GLCD_DB1
;#define HX8347_GLCD_DB2 GLCD_DB2
;#define HX8347_GLCD_DB3 GLCD_DB3
;#define HX8347_GLCD_DB4 GLCD_DB4
;#define HX8347_GLCD_DB5 GLCD_DB5
;#define HX8347_GLCD_DB6 GLCD_DB6
;#define HX8347_GLCD_DB7 GLCD_DB7
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

FN_ABS:
;If SysCalcTempA.15 Then
	sbrs	SYSCALCTEMPA_H,7
	rjmp	ELSE34_1
;Abs = -SysCalcTempA
	com	SYSCALCTEMPA
	com	SYSCALCTEMPA_H
	inc	SYSCALCTEMPA
	brne	PC + 2
	inc	SYSCALCTEMPA_H
	sts	ABS,SYSCALCTEMPA
	sts	ABS_H,SYSCALCTEMPA_H
;Else
	rjmp	ENDIF34
ELSE34_1:
;Abs = SysCalcTempA
	sts	ABS,SYSCALCTEMPA
	sts	ABS_H,SYSCALCTEMPA_H
;End If
ENDIF34:
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

ENABLEIRQ_XPT2046:
;set XPT2046_CS OFF
	cbi	PORTD,2
;SendData_XPT2046( XPT2046_CFG_START | XPT2046_CFG_8BIT | XPT2046_CFG_DFR | XPT2046_MUX_Y )
	ldi	SysValueCopy,216
	sts	XPT2046SENDBYTE,SysValueCopy
	call	SENDDATA_XPT2046
;wait 1 ms
	ldi	SysWaitTempMS,1
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;set XPT2046_CS ON
	sbi	PORTD,2
	ret

;********************************************************************************

FILLEDBOX_ILI9486L:
;dim GLCDTemp, DrawLine as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	lds	SysWORDTempB,LINEX1
	lds	SysWORDTempB_H,LINEX1_H
	lds	SysWORDTempA,LINEX2
	lds	SysWORDTempA_H,LINEX2_H
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF28
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
ENDIF28:
;If LineY1 > LineY2 Then
	lds	SysWORDTempB,LINEY1
	lds	SysWORDTempB_H,LINEY1_H
	lds	SysWORDTempA,LINEY2
	lds	SysWORDTempA_H,LINEY2_H
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF29
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
ENDIF29:
;Fill with colour
;Draw lines going across
;For DrawLine = LineX1 To LineX2
	lds	SysTemp3,LINEX1
	ldi	SysTemp4,1
	sub	SysTemp3,SysTemp4
	sts	DRAWLINE,SysTemp3
	lds	SysTemp3,LINEX1_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	DRAWLINE_H,SysTemp3
	lds	SysWORDTempB,LINEX1
	lds	SysWORDTempB_H,LINEX1_H
	lds	SysWORDTempA,LINEX2
	lds	SysWORDTempA_H,LINEX2_H
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoopEnd5
ENDIF30:
SysForLoop5:
	lds	SysTemp3,DRAWLINE
	inc	SysTemp3
	sts	DRAWLINE,SysTemp3
	lds	SysTemp3,DRAWLINE_H
	brne	PC + 2
	inc	SysTemp3
	sts	DRAWLINE_H,SysTemp3
;For GLCDTemp = LineY1 To LineY2
	lds	SysTemp3,LINEY1
	ldi	SysTemp4,1
	sub	SysTemp3,SysTemp4
	sts	GLCDTEMP,SysTemp3
	lds	SysTemp3,LINEY1_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	GLCDTEMP_H,SysTemp3
	lds	SysWORDTempB,LINEY1
	lds	SysWORDTempB_H,LINEY1_H
	lds	SysWORDTempA,LINEY2
	lds	SysWORDTempA_H,LINEY2_H
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoopEnd6
ENDIF31:
SysForLoop6:
	lds	SysTemp3,GLCDTEMP
	inc	SysTemp3
	sts	GLCDTEMP,SysTemp3
	lds	SysTemp3,GLCDTEMP_H
	brne	PC + 2
	inc	SysTemp3
	sts	GLCDTEMP_H,SysTemp3
;PSet DrawLine, GLCDTemp, LineColour
	lds	SysValueCopy,DRAWLINE
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,DRAWLINE_H
	sts	GLCDX_H,SysValueCopy
	lds	SysValueCopy,GLCDTEMP
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,GLCDTEMP_H
	sts	GLCDY_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_ILI9486L
;Next
	lds	SysWORDTempA,GLCDTEMP
	lds	SysWORDTempA_H,GLCDTEMP_H
	lds	SysWORDTempB,LINEY2
	lds	SysWORDTempB_H,LINEY2_H
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop6
ENDIF32:
SysForLoopEnd6:
;Next
	lds	SysWORDTempA,DRAWLINE
	lds	SysWORDTempA_H,DRAWLINE_H
	lds	SysWORDTempB,LINEX2
	lds	SysWORDTempB_H,LINEX2_H
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop5
ENDIF33:
SysForLoopEnd5:
	ret

;********************************************************************************

FILLEDCIRCLE:
;Circle fill Code is merely a modification of the midpoint
;circle algorithem which is an adaption of Bresenham's line algorithm
;http://en.wikipedia.org/wiki/Midpoint_circle_algorithm
;http://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
;dim ff, ddF_x, ddF_y as integer
;dim YCalc2, YCalc1 as word
;ff = 1 - xradius
	ldi	SysTemp4,1
	lds	SysTemp3,XRADIUS
	sub	SysTemp4,SysTemp3
	sts	FF,SysTemp4
	ldi	SysTemp4,0
	lds	SysTemp3,XRADIUS_H
	sbc	SysTemp4,SysTemp3
	sts	FF_H,SysTemp4
;ddF_x = 1
	ldi	SysValueCopy,1
	sts	DDF_X,SysValueCopy
	ldi	SysValueCopy,0
	sts	DDF_X_H,SysValueCopy
;ddF_y = -2 * xradius
	lds	SysINTEGERTempA,XRADIUS
	lds	SysINTEGERTempA_H,XRADIUS_H
	ldi	SysINTEGERTempB,254
	ldi	SysINTEGERTempB_H,255
	call	SysMultSubINT
	sts	DDF_Y,SysINTEGERTempX
	sts	DDF_Y_H,SysINTEGERTempX_H
;FillCircleXX = 0
	ldi	SysValueCopy,0
	sts	FILLCIRCLEXX,SysValueCopy
;FillCircleYY = xradius
	lds	SysValueCopy,XRADIUS
	sts	FILLCIRCLEYY,SysValueCopy
;Fill in the center between the two halves
;YCalc2 = yoffset+xradius
	lds	SysTemp3,YOFFSET
	lds	SysTemp1,XRADIUS
	add	SysTemp3,SysTemp1
	sts	YCALC2,SysTemp3
	lds	SysTemp3,YOFFSET_H
	lds	SysTemp1,XRADIUS_H
	adc	SysTemp3,SysTemp1
	sts	YCALC2_H,SysTemp3
;YCalc1 = yoffset-xradius
	lds	SysTemp3,YOFFSET
	lds	SysTemp1,XRADIUS
	sub	SysTemp3,SysTemp1
	sts	YCALC1,SysTemp3
	lds	SysTemp3,YOFFSET_H
	lds	SysTemp1,XRADIUS_H
	sbc	SysTemp3,SysTemp1
	sts	YCALC1_H,SysTemp3
;Line( xoffset, YCalc1 , xoffset, YCalc2, LineColour)
	lds	SysValueCopy,XOFFSET
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,XOFFSET_H
	sts	LINEX1_H,SysValueCopy
	lds	SysValueCopy,YCALC1
	sts	LINEY1,SysValueCopy
	lds	SysValueCopy,YCALC1_H
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,XOFFSET
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,XOFFSET_H
	sts	LINEX2_H,SysValueCopy
	lds	SysValueCopy,YCALC2
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,YCALC2_H
	sts	LINEY2_H,SysValueCopy
	rcall	LINE
;do while (FillCircleXX < FillCircleYY)
SysDoLoop_S3:
	lds	SysCalcTempA,FILLCIRCLEXX
	lds	SysCalcTempB,FILLCIRCLEYY
	cp	SysCalcTempA,SysCalcTempB
	brlo	PC + 2
	rjmp	SysDoLoop_E3
;if ff >= 0 then
	lds	SysINTEGERTempA,FF
	lds	SysINTEGERTempA_H,FF_H
	ldi	SysINTEGERTempB,0
	ldi	SysINTEGERTempB_H,0
	call	SysCompLessThanINT
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF14
;FillCircleYY--
	lds	SysTemp3,FILLCIRCLEYY
	dec	SysTemp3
	sts	FILLCIRCLEYY,SysTemp3
;ddF_y += 2
	lds	SysTemp3,DDF_Y
	ldi	SysTemp4,2
	add	SysTemp3,SysTemp4
	sts	DDF_Y,SysTemp3
	lds	SysTemp3,DDF_Y_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	DDF_Y_H,SysTemp3
;ff += ddF_y
	lds	SysTemp3,FF
	lds	SysTemp1,DDF_Y
	add	SysTemp3,SysTemp1
	sts	FF,SysTemp3
	lds	SysTemp3,FF_H
	lds	SysTemp1,DDF_Y_H
	adc	SysTemp3,SysTemp1
	sts	FF_H,SysTemp3
;end if
ENDIF14:
;FillCircleXX++
	lds	SysTemp3,FILLCIRCLEXX
	inc	SysTemp3
	sts	FILLCIRCLEXX,SysTemp3
;ddF_x += 2
	lds	SysTemp3,DDF_X
	ldi	SysTemp4,2
	add	SysTemp3,SysTemp4
	sts	DDF_X,SysTemp3
	lds	SysTemp3,DDF_X_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	DDF_X_H,SysTemp3
;ff += ddF_x
	lds	SysTemp3,FF
	lds	SysTemp1,DDF_X
	add	SysTemp3,SysTemp1
	sts	FF,SysTemp3
	lds	SysTemp3,FF_H
	lds	SysTemp1,DDF_X_H
	adc	SysTemp3,SysTemp1
	sts	FF_H,SysTemp3
;Now draw vertical lines between the points on the circle rather than
;draw the points of the circle. This draws lines between the
;perimeter points on the upper and lower quadrants of the 2 halves of the circle.
;Line(xoffset+FillCircleXX, yoffset+FillCircleYY, xoffset+FillCircleXX, yoffset-FillCircleYY, LineColour);
	lds	SysTemp3,XOFFSET
	lds	SysTemp1,FILLCIRCLEXX
	add	SysTemp3,SysTemp1
	sts	LINEX1,SysTemp3
	lds	SysTemp3,XOFFSET_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	LINEX1_H,SysTemp3
	lds	SysTemp3,YOFFSET
	lds	SysTemp1,FILLCIRCLEYY
	add	SysTemp3,SysTemp1
	sts	LINEY1,SysTemp3
	lds	SysTemp3,YOFFSET_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	LINEY1_H,SysTemp3
	lds	SysTemp3,XOFFSET
	lds	SysTemp1,FILLCIRCLEXX
	add	SysTemp3,SysTemp1
	sts	LINEX2,SysTemp3
	lds	SysTemp3,XOFFSET_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	LINEX2_H,SysTemp3
	lds	SysTemp3,YOFFSET
	lds	SysTemp1,FILLCIRCLEYY
	sub	SysTemp3,SysTemp1
	sts	LINEY2,SysTemp3
	lds	SysTemp3,YOFFSET_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	LINEY2_H,SysTemp3
	rcall	LINE
;Line(xoffset-FillCircleXX, yoffset+FillCircleYY, xoffset-FillCircleXX, yoffset-FillCircleYY, LineColour);
	lds	SysTemp3,XOFFSET
	lds	SysTemp1,FILLCIRCLEXX
	sub	SysTemp3,SysTemp1
	sts	LINEX1,SysTemp3
	lds	SysTemp3,XOFFSET_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	LINEX1_H,SysTemp3
	lds	SysTemp3,YOFFSET
	lds	SysTemp1,FILLCIRCLEYY
	add	SysTemp3,SysTemp1
	sts	LINEY1,SysTemp3
	lds	SysTemp3,YOFFSET_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	LINEY1_H,SysTemp3
	lds	SysTemp3,XOFFSET
	lds	SysTemp1,FILLCIRCLEXX
	sub	SysTemp3,SysTemp1
	sts	LINEX2,SysTemp3
	lds	SysTemp3,XOFFSET_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	LINEX2_H,SysTemp3
	lds	SysTemp3,YOFFSET
	lds	SysTemp1,FILLCIRCLEYY
	sub	SysTemp3,SysTemp1
	sts	LINEY2,SysTemp3
	lds	SysTemp3,YOFFSET_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	LINEY2_H,SysTemp3
	rcall	LINE
;Line(xoffset+FillCircleYY, yoffset+FillCircleXX, FillCircleYY+xoffset, yoffset-FillCircleXX, LineColour);
	lds	SysTemp3,XOFFSET
	lds	SysTemp1,FILLCIRCLEYY
	add	SysTemp3,SysTemp1
	sts	LINEX1,SysTemp3
	lds	SysTemp3,XOFFSET_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	LINEX1_H,SysTemp3
	lds	SysTemp3,YOFFSET
	lds	SysTemp1,FILLCIRCLEXX
	add	SysTemp3,SysTemp1
	sts	LINEY1,SysTemp3
	lds	SysTemp3,YOFFSET_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	LINEY1_H,SysTemp3
	lds	SysTemp3,FILLCIRCLEYY
	lds	SysTemp1,XOFFSET
	add	SysTemp3,SysTemp1
	sts	LINEX2,SysTemp3
	ldi	SysTemp4,0
	lds	SysTemp3,XOFFSET_H
	adc	SysTemp4,SysTemp3
	sts	LINEX2_H,SysTemp4
	lds	SysTemp3,YOFFSET
	lds	SysTemp1,FILLCIRCLEXX
	sub	SysTemp3,SysTemp1
	sts	LINEY2,SysTemp3
	lds	SysTemp3,YOFFSET_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	LINEY2_H,SysTemp3
	rcall	LINE
;Line(xoffset-FillCircleYY, yoffset+FillCircleXX, xoffset-FillCircleYY, yoffset-FillCircleXX, LineColour);
	lds	SysTemp3,XOFFSET
	lds	SysTemp1,FILLCIRCLEYY
	sub	SysTemp3,SysTemp1
	sts	LINEX1,SysTemp3
	lds	SysTemp3,XOFFSET_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	LINEX1_H,SysTemp3
	lds	SysTemp3,YOFFSET
	lds	SysTemp1,FILLCIRCLEXX
	add	SysTemp3,SysTemp1
	sts	LINEY1,SysTemp3
	lds	SysTemp3,YOFFSET_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	LINEY1_H,SysTemp3
	lds	SysTemp3,XOFFSET
	lds	SysTemp1,FILLCIRCLEYY
	sub	SysTemp3,SysTemp1
	sts	LINEX2,SysTemp3
	lds	SysTemp3,XOFFSET_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	LINEX2_H,SysTemp3
	lds	SysTemp3,YOFFSET
	lds	SysTemp1,FILLCIRCLEXX
	sub	SysTemp3,SysTemp1
	sts	LINEY2,SysTemp3
	lds	SysTemp3,YOFFSET_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	LINEY2_H,SysTemp3
	rcall	LINE
;loop
	rjmp	SysDoLoop_S3
SysDoLoop_E3:
	ret

;********************************************************************************

FN_GCBBUILDSTR:
;GCBBuildStr="40"
	ldi	SysStringB,low(GCBBUILDSTR)
	ldi	SysStringB_H,high(GCBBUILDSTR)
	ldi	SysReadA,low(StringTable36<<1)
	ldi	SysReadA_H,high(StringTable36<<1)
	jmp	SysReadString

;********************************************************************************

FN_GCBBUILDTIMESTR:
;GCBBuildTimeStr="12-30-2018 16:00:55"
	ldi	SysStringB,low(GCBBUILDTIMESTR)
	ldi	SysStringB_H,high(GCBBUILDTIMESTR)
	ldi	SysReadA,low(StringTable37<<1)
	ldi	SysReadA_H,high(StringTable37<<1)
	jmp	SysReadString

;********************************************************************************

GETXY_XPT2046:
;dim XTouchPoint_XPT2046, YTouchPoint_XPT2046 as Word
;dim NewXTouchPoint_XPT2046, NewYTouchPoint_XPT2046 as Word
;dim XTouchPoint_XPT2046raw, YTouchPoint_XPT2046Raw as word
;dim Current_GLCD_WIDTH, Current_GLCD_HEIGHT as word
;set XPT2046_CS OFF
	cbi	PORTD,2
;Repeat 10
	ldi	SysValueCopy,10
	sts	SysRepeatTemp3,SysValueCopy
SysRepeatLoop3:
;TransferData_XPT2046  ( XPT2046_CFG_START | XPT2046_CFG_8BIT | XPT2046_CFG_DFR | XPT2046_MUX_X  | XPT2046_CFG_PWR ), XPT2046TempOut
	ldi	SysValueCopy,152
	sts	XPT2046SENDBYTE,SysValueCopy
	lds	SysValueCopy,XPT2046TEMPOUT
	sts	XPT2046OUTBYTE,SysValueCopy
	call	TRANSFERDATA_XPT2046
	lds	SysValueCopy,XPT2046OUTBYTE
	sts	XPT2046TEMPOUT,SysValueCopy
;TransferData_XPT2046  0,  YTouchPoint_XPT2046
	ldi	SysValueCopy,0
	sts	XPT2046SENDBYTE,SysValueCopy
	lds	SysValueCopy,YTOUCHPOINT_XPT2046
	sts	XPT2046OUTBYTE,SysValueCopy
	call	TRANSFERDATA_XPT2046
	lds	SysValueCopy,XPT2046OUTBYTE
	sts	YTOUCHPOINT_XPT2046,SysValueCopy
	ldi	SysValueCopy,0
	sts	YTOUCHPOINT_XPT2046_H,SysValueCopy
;TransferData_XPT2046  ( XPT2046_CFG_START | XPT2046_CFG_8BIT | XPT2046_CFG_DFR | XPT2046_MUX_Y  | XPT2046_CFG_PWR ), XPT2046TempOut
	ldi	SysValueCopy,216
	sts	XPT2046SENDBYTE,SysValueCopy
	lds	SysValueCopy,XPT2046TEMPOUT
	sts	XPT2046OUTBYTE,SysValueCopy
	call	TRANSFERDATA_XPT2046
	lds	SysValueCopy,XPT2046OUTBYTE
	sts	XPT2046TEMPOUT,SysValueCopy
;TransferData_XPT2046  0, XTouchPoint_XPT2046
	ldi	SysValueCopy,0
	sts	XPT2046SENDBYTE,SysValueCopy
	lds	SysValueCopy,XTOUCHPOINT_XPT2046
	sts	XPT2046OUTBYTE,SysValueCopy
	call	TRANSFERDATA_XPT2046
	lds	SysValueCopy,XPT2046OUTBYTE
	sts	XTOUCHPOINT_XPT2046,SysValueCopy
	ldi	SysValueCopy,0
	sts	XTOUCHPOINT_XPT2046_H,SysValueCopy
;TransferData_XPT2046  0, XPT2046TempOut
	ldi	SysValueCopy,0
	sts	XPT2046SENDBYTE,SysValueCopy
	lds	SysValueCopy,XPT2046TEMPOUT
	sts	XPT2046OUTBYTE,SysValueCopy
	call	TRANSFERDATA_XPT2046
	lds	SysValueCopy,XPT2046OUTBYTE
	sts	XPT2046TEMPOUT,SysValueCopy
;end Repeat
	lds	SysTemp3,SysRepeatTemp3
	dec	SysTemp3
	sts	SysRepeatTemp3,SysTemp3
	breq	PC + 2
	rjmp	SysRepeatLoop3
SysRepeatLoopEnd3:
;XTouchPoint_XPT2046 = 0
	ldi	SysValueCopy,0
	sts	XTOUCHPOINT_XPT2046,SysValueCopy
	sts	XTOUCHPOINT_XPT2046_H,SysValueCopy
;YTouchPoint_XPT2046 = 0
	ldi	SysValueCopy,0
	sts	YTOUCHPOINT_XPT2046,SysValueCopy
	sts	YTOUCHPOINT_XPT2046_H,SysValueCopy
;Repeat XPT2046_ReadSamples
	ldi	SysValueCopy,15
	sts	SysRepeatTemp3,SysValueCopy
SysRepeatLoop4:
;TransferData_XPT2046  XPT2046_CFG_START | XPT2046_CFG_8BIT | XPT2046_CFG_DFR | XPT2046_MUX_X  | XPT2046_CFG_PWR, XPT2046TempOut
	ldi	SysValueCopy,152
	sts	XPT2046SENDBYTE,SysValueCopy
	lds	SysValueCopy,XPT2046TEMPOUT
	sts	XPT2046OUTBYTE,SysValueCopy
	call	TRANSFERDATA_XPT2046
	lds	SysValueCopy,XPT2046OUTBYTE
	sts	XPT2046TEMPOUT,SysValueCopy
;wait 20 us
	ldi	DELAYTEMP,106
DelayUS2:
	dec	DELAYTEMP
	brne	DelayUS2
	rjmp	PC + 1
;TransferData_XPT2046  0,  NewYTouchPoint_XPT2046
	ldi	SysValueCopy,0
	sts	XPT2046SENDBYTE,SysValueCopy
	lds	SysValueCopy,NEWYTOUCHPOINT_XPT2046
	sts	XPT2046OUTBYTE,SysValueCopy
	call	TRANSFERDATA_XPT2046
	lds	SysValueCopy,XPT2046OUTBYTE
	sts	NEWYTOUCHPOINT_XPT2046,SysValueCopy
	ldi	SysValueCopy,0
	sts	NEWYTOUCHPOINT_XPT2046_H,SysValueCopy
;TransferData_XPT2046  XPT2046_CFG_START | XPT2046_CFG_8BIT | XPT2046_CFG_DFR | XPT2046_MUX_Y  | XPT2046_CFG_PWR, XPT2046TempOut
	ldi	SysValueCopy,216
	sts	XPT2046SENDBYTE,SysValueCopy
	lds	SysValueCopy,XPT2046TEMPOUT
	sts	XPT2046OUTBYTE,SysValueCopy
	call	TRANSFERDATA_XPT2046
	lds	SysValueCopy,XPT2046OUTBYTE
	sts	XPT2046TEMPOUT,SysValueCopy
;wait 20 us
	ldi	DELAYTEMP,106
DelayUS3:
	dec	DELAYTEMP
	brne	DelayUS3
	rjmp	PC + 1
;TransferData_XPT2046  0, NewXTouchPoint_XPT2046
	ldi	SysValueCopy,0
	sts	XPT2046SENDBYTE,SysValueCopy
	lds	SysValueCopy,NEWXTOUCHPOINT_XPT2046
	sts	XPT2046OUTBYTE,SysValueCopy
	call	TRANSFERDATA_XPT2046
	lds	SysValueCopy,XPT2046OUTBYTE
	sts	NEWXTOUCHPOINT_XPT2046,SysValueCopy
	ldi	SysValueCopy,0
	sts	NEWXTOUCHPOINT_XPT2046_H,SysValueCopy
;TransferData_XPT2046  0, XPT2046TempOut
	ldi	SysValueCopy,0
	sts	XPT2046SENDBYTE,SysValueCopy
	lds	SysValueCopy,XPT2046TEMPOUT
	sts	XPT2046OUTBYTE,SysValueCopy
	call	TRANSFERDATA_XPT2046
	lds	SysValueCopy,XPT2046OUTBYTE
	sts	XPT2046TEMPOUT,SysValueCopy
;yTouchPoint_XPT2046 = ( yTouchPoint_XPT2046 + NewyTouchPoint_XPT2046 )
	lds	SysTemp3,YTOUCHPOINT_XPT2046
	lds	SysTemp1,NEWYTOUCHPOINT_XPT2046
	add	SysTemp3,SysTemp1
	sts	YTOUCHPOINT_XPT2046,SysTemp3
	lds	SysTemp3,YTOUCHPOINT_XPT2046_H
	lds	SysTemp1,NEWYTOUCHPOINT_XPT2046_H
	adc	SysTemp3,SysTemp1
	sts	YTOUCHPOINT_XPT2046_H,SysTemp3
;XTouchPoint_XPT2046 = ( XTouchPoint_XPT2046 + NewXTouchPoint_XPT2046 )
	lds	SysTemp3,XTOUCHPOINT_XPT2046
	lds	SysTemp1,NEWXTOUCHPOINT_XPT2046
	add	SysTemp3,SysTemp1
	sts	XTOUCHPOINT_XPT2046,SysTemp3
	lds	SysTemp3,XTOUCHPOINT_XPT2046_H
	lds	SysTemp1,NEWXTOUCHPOINT_XPT2046_H
	adc	SysTemp3,SysTemp1
	sts	XTOUCHPOINT_XPT2046_H,SysTemp3
;End Repeat
	lds	SysTemp3,SysRepeatTemp3
	dec	SysTemp3
	sts	SysRepeatTemp3,SysTemp3
	breq	PC + 2
	rjmp	SysRepeatLoop4
SysRepeatLoopEnd4:
;yTouchPoint_XPT2046 = yTouchPoint_XPT2046 /(XPT2046_ReadSamples )
	lds	SysWORDTempA,YTOUCHPOINT_XPT2046
	lds	SysWORDTempA_H,YTOUCHPOINT_XPT2046_H
	ldi	SysWORDTempB,15
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	YTOUCHPOINT_XPT2046,SysWORDTempA
	sts	YTOUCHPOINT_XPT2046_H,SysWORDTempA_H
;xTouchPoint_XPT2046 = xTouchPoint_XPT2046 /(XPT2046_ReadSamples )
	lds	SysWORDTempA,XTOUCHPOINT_XPT2046
	lds	SysWORDTempA_H,XTOUCHPOINT_XPT2046_H
	ldi	SysWORDTempB,15
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	XTOUCHPOINT_XPT2046,SysWORDTempA
	sts	XTOUCHPOINT_XPT2046_H,SysWORDTempA_H
;SendData_XPT2046( XPT2046_CFG_START | XPT2046_CFG_8BIT | XPT2046_CFG_DFR | XPT2046_CFG_PWR )
	ldi	SysValueCopy,136
	sts	XPT2046SENDBYTE,SysValueCopy
	call	SENDDATA_XPT2046
;set XPT2046_CS ON
	sbi	PORTD,2
;Set the raw values, folks may want to know this
;XTouchPoint_XPT2046raw = XTouchPoint_XPT2046
	lds	SysValueCopy,XTOUCHPOINT_XPT2046
	sts	XTOUCHPOINT_XPT2046RAW,SysValueCopy
	lds	SysValueCopy,XTOUCHPOINT_XPT2046_H
	sts	XTOUCHPOINT_XPT2046RAW_H,SysValueCopy
;YTouchPoint_XPT2046Raw = yTouchPoint_XPT2046
	lds	SysValueCopy,YTOUCHPOINT_XPT2046
	sts	YTOUCHPOINT_XPT2046RAW,SysValueCopy
	lds	SysValueCopy,YTOUCHPOINT_XPT2046_H
	sts	YTOUCHPOINT_XPT2046RAW_H,SysValueCopy
;Scale to calibration
;XTouchPoint_XPT2046 = scale ( XTouchPoint_XPT2046, XPT2046_Xmin, XPT2046_Xmax, 0, Current_GLCD_WIDTH )
	lds	SysValueCopy,XTOUCHPOINT_XPT2046
	sts	L_MAP,SysValueCopy
	lds	SysValueCopy,XTOUCHPOINT_XPT2046_H
	sts	L_MAP_H,SysValueCopy
	lds	SysValueCopy,XPT2046_XMIN
	sts	L_FROMLOW,SysValueCopy
	ldi	SysValueCopy,0
	sts	L_FROMLOW_H,SysValueCopy
	lds	SysValueCopy,XPT2046_XMAX
	sts	L_FROMHIGH,SysValueCopy
	ldi	SysValueCopy,0
	sts	L_FROMHIGH_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	L_TOLOW,SysValueCopy
	sts	L_TOLOW_H,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_WIDTH
	sts	L_TOHIGH,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_WIDTH_H
	sts	L_TOHIGH_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	L_CALIBRATE,SysValueCopy
	sts	L_CALIBRATE_H,SysValueCopy
	call	FN_SCALE
	lds	SysValueCopy,SCALE
	sts	XTOUCHPOINT_XPT2046,SysValueCopy
	lds	SysValueCopy,SCALE_H
	sts	XTOUCHPOINT_XPT2046_H,SysValueCopy
;YTouchPoint_XPT2046 = scale ( YTouchPoint_XPT2046, XPT2046_Ymin, XPT2046_Ymax, 0, Current_GLCD_HEIGHT )
	lds	SysValueCopy,YTOUCHPOINT_XPT2046
	sts	L_MAP,SysValueCopy
	lds	SysValueCopy,YTOUCHPOINT_XPT2046_H
	sts	L_MAP_H,SysValueCopy
	lds	SysValueCopy,XPT2046_YMIN
	sts	L_FROMLOW,SysValueCopy
	ldi	SysValueCopy,0
	sts	L_FROMLOW_H,SysValueCopy
	lds	SysValueCopy,XPT2046_YMAX
	sts	L_FROMHIGH,SysValueCopy
	ldi	SysValueCopy,0
	sts	L_FROMHIGH_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	L_TOLOW,SysValueCopy
	sts	L_TOLOW_H,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_HEIGHT
	sts	L_TOHIGH,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_HEIGHT_H
	sts	L_TOHIGH_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	L_CALIBRATE,SysValueCopy
	sts	L_CALIBRATE_H,SysValueCopy
	call	FN_SCALE
	lds	SysValueCopy,SCALE
	sts	YTOUCHPOINT_XPT2046,SysValueCopy
	lds	SysValueCopy,SCALE_H
	sts	YTOUCHPOINT_XPT2046_H,SysValueCopy
	ret

;********************************************************************************

GLCDCLS_ILI9486L:
;dim ILI9486LSendWord as word
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	ldi	SysValueCopy,0
	sts	GLCD_YORDINATE,SysValueCopy
	sts	GLCD_YORDINATE_H,SysValueCopy
;SetAddressWindow_ILI9486L ( 0, 0, GLCD_WIDTH  , GLCD_HEIGHT )
	ldi	SysValueCopy,0
	sts	_X1,SysValueCopy
	sts	_X1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	_Y1,SysValueCopy
	sts	_Y1_H,SysValueCopy
	ldi	SysValueCopy,64
	sts	_X2,SysValueCopy
	ldi	SysValueCopy,1
	sts	_X2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	_Y2,SysValueCopy
	ldi	SysValueCopy,1
	sts	_Y2_H,SysValueCopy
	call	SETADDRESSWINDOW_ILI9486L
;ILI9486LSendWord = GLCDBackground
	lds	SysValueCopy,GLCDBACKGROUND
	sts	ILI9486LSENDWORD,SysValueCopy
	lds	SysValueCopy,GLCDBACKGROUND_H
	sts	ILI9486LSENDWORD_H,SysValueCopy
;GLCDCLS_HiBytePortion1 = (PORTD & 0B00000011) | ((ILI9481SendWord_H) & 0B11111100);
	ldi	SysTemp4,3
	in	SysTemp1,PORTD
	and	SysTemp1,SysTemp4
	mov	SysTemp3,SysTemp1
	ldi	SysTemp4,252
	lds	SysTemp2,ILI9481SENDWORD_H
	and	SysTemp2,SysTemp4
	mov	SysTemp1,SysTemp2
	or	SysTemp1,SysTemp3
	sts	GLCDCLS_HIBYTEPORTION1,SysTemp1
;GLCDCLS_HiBytePortion2 = (PORTB & 0B11111100) | ((ILI9481SendWord_H) & 0B00000011);
	ldi	SysTemp4,252
	in	SysTemp1,PORTB
	and	SysTemp1,SysTemp4
	mov	SysTemp3,SysTemp1
	ldi	SysTemp4,3
	lds	SysTemp2,ILI9481SENDWORD_H
	and	SysTemp2,SysTemp4
	mov	SysTemp1,SysTemp2
	or	SysTemp1,SysTemp3
	sts	GLCDCLS_HIBYTEPORTION2,SysTemp1
;GLCDCLS_LoBytePortion1 =  (PORTD & 0B00000011) | ((ILI9481SendWord) & 0B11111100);
	ldi	SysTemp4,3
	in	SysTemp1,PORTD
	and	SysTemp1,SysTemp4
	mov	SysTemp3,SysTemp1
	ldi	SysTemp4,252
	lds	SysTemp2,ILI9481SENDWORD
	and	SysTemp2,SysTemp4
	mov	SysTemp1,SysTemp2
	or	SysTemp1,SysTemp3
	sts	GLCDCLS_LOBYTEPORTION1,SysTemp1
;GLCDCLS_LoBytePortion2 =  (PORTB & 0B11111100) | ((ILI9481SendWord) & 0B00000011);
	ldi	SysTemp4,252
	in	SysTemp1,PORTB
	and	SysTemp1,SysTemp4
	mov	SysTemp3,SysTemp1
	ldi	SysTemp4,3
	lds	SysTemp2,ILI9481SENDWORD
	and	SysTemp2,SysTemp4
	mov	SysTemp1,SysTemp2
	or	SysTemp1,SysTemp3
	sts	GLCDCLS_LOBYTEPORTION2,SysTemp1
;set ILI9486L_CS OFF
	cbi	PORTB,2
;set ILI9486L_DC ON
	sbi	PORTB,0
;Repeat 100
	ldi	SysValueCopy,100
	sts	SysRepeatTemp5,SysValueCopy
SysRepeatLoop5:
;Repeat 48
	ldi	SysValueCopy,48
	sts	SysRepeatTemp6,SysValueCopy
SysRepeatLoop6:
;Repeat 32
	ldi	SysValueCopy,32
	sts	SysRepeatTemp7,SysValueCopy
SysRepeatLoop7:
;Could use these as an alternative
;FastHWSPITransfer  ILI9486LSendWord_h
;FastHWSPITransfer  ILI9486LSendWord
;was thjs slower code
;FastHWSPITransfer  ILI9486LSendWord_h
;FastHWSPITransfer  ILI9486LSendWord
;Master mode only
;SPDR = ILI9486LSendWord_h
	lds	SysValueCopy,ILI9486LSENDWORD_H
	out	SPDR,SysValueCopy
;Do
SysDoLoop_S6:
;Loop While SPSR.WCOL
	in	SysBitTest,SPSR
	sbrc	SysBitTest,WCOL
	rjmp	SysDoLoop_S6
SysDoLoop_E6:
;Read buffer
;Same for master and slave
;Wait While SPSR.SPIF = Off
SysWaitLoop2:
	in	SysBitTest,SPSR
	sbrs	SysBitTest,SPIF
	rjmp	SysWaitLoop2
;Master mode only
;SPDR = ILI9486LSendWord
	lds	SysValueCopy,ILI9486LSENDWORD
	out	SPDR,SysValueCopy
;Do
SysDoLoop_S7:
;Loop While SPSR.WCOL
	in	SysBitTest,SPSR
	sbrc	SysBitTest,WCOL
	rjmp	SysDoLoop_S7
SysDoLoop_E7:
;Read buffer
;Same for master and slave
;Wait While SPSR.SPIF = Off
SysWaitLoop3:
	in	SysBitTest,SPSR
	sbrs	SysBitTest,SPIF
	rjmp	SysWaitLoop3
;end repeat
	lds	SysTemp3,SysRepeatTemp7
	dec	SysTemp3
	sts	SysRepeatTemp7,SysTemp3
	brne	SysRepeatLoop7
SysRepeatLoopEnd7:
;end repeat
	lds	SysTemp3,SysRepeatTemp6
	dec	SysTemp3
	sts	SysRepeatTemp6,SysTemp3
	brne	SysRepeatLoop6
SysRepeatLoopEnd6:
;end repeat
	lds	SysTemp3,SysRepeatTemp5
	dec	SysTemp3
	sts	SysRepeatTemp5,SysTemp3
	brne	SysRepeatLoop5
SysRepeatLoopEnd5:
;set ILI9486L_CS ON;
	sbi	PORTB,2
	ret

;********************************************************************************

GLCDDRAWCHAR_ILI9486L:
;This has got a tad complex
;We have three major pieces
;1 The preamble - this just adjusted color and the input character
;2 The code that deals with GCB fontset
;3 The code that deals with OLED fontset
;
;You can make independent change to section 2 and 3 but they are mutual exclusive with many common pieces
;dim CharCol, CharRow, GLCDTemp as word
;CharCode -= 15
	lds	SysTemp3,CHARCODE
	ldi	SysTemp4,15
	sub	SysTemp3,SysTemp4
	sts	CHARCODE,SysTemp3
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
	lds	SysTemp3,CHARCODE
	ldi	SysTemp4,16
	sub	SysTemp3,SysTemp4
	sts	CHARCODE,SysTemp3
;ReadTable OLEDFont1Index, CharCode, LocalCharCode
	lds	SYSSTRINGA,CHARCODE
	rcall	OLEDFONT1INDEX
	sts	LOCALCHARCODE,SysByteTempX
	lds	SYSSTRINGA,CHARCODE
	rcall	OLEDFONT1INDEX_H
	sts	LOCALCHARCODE_H,SysByteTempX
;ReadTable OLEDFont1Data, LocalCharCode , COLSperfont
	lds	SYSSTRINGA,LOCALCHARCODE
	lds	SYSSTRINGA_H,LOCALCHARCODE_H
	rcall	OLEDFONT1DATA
	sts	COLSPERFONT,SysByteTempX
;GLCDFontWidth = COLSperfont + 1
	lds	SysTemp3,COLSPERFONT
	inc	SysTemp3
	sts	GLCDFONTWIDTH,SysTemp3
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
	lds	SysTemp3,CHARCODE
	ldi	SysTemp4,17
	sub	SysTemp3,SysTemp4
	sts	CHARCODE,SysTemp3
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
	brsh	ENDIF20
	rjmp	SysForLoopEnd3
ENDIF20:
SysForLoop3:
	lds	SysTemp3,CURRCHARCOL
	inc	SysTemp3
	sts	CURRCHARCOL,SysTemp3
;Index the pointer to the code that we are looking for as we need to do this lookup many times getting more font data
;LocalCharCode++
	lds	SysTemp3,LOCALCHARCODE
	inc	SysTemp3
	sts	LOCALCHARCODE,SysTemp3
	lds	SysTemp3,LOCALCHARCODE_H
	brne	PC + 2
	inc	SysTemp3
	sts	LOCALCHARCODE_H,SysTemp3
;Select case GLCDfntDefaultSize
;case 1
SysSelect2Case1:
	lds	SysCalcTempA,GLCDFNTDEFAULTSIZE
	cpi	SysCalcTempA,1
	brne	SysSelect2Case2
;ReadTable OLEDFont1Data, LocalCharCode, CurrCharVal
	lds	SYSSTRINGA,LOCALCHARCODE
	lds	SYSSTRINGA_H,LOCALCHARCODE_H
	rcall	OLEDFONT1DATA
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
	rcall	OLEDFONT2
	sts	CURRCHARVAL,SysByteTempX
;End Select
SysSelectEnd2:
;we handle 8 or 16 pixels of height
;For CurrCharRow = 0 to ROWSperfont
	ldi	SysValueCopy,255
	sts	CURRCHARROW,SysValueCopy
	lds	SysCalcTempA,ROWSPERFONT
	cpi	SysCalcTempA,0
	brsh	ENDIF21
	rjmp	SysForLoopEnd4
ENDIF21:
SysForLoop4:
	lds	SysTemp3,CURRCHARROW
	inc	SysTemp3
	sts	CURRCHARROW,SysTemp3
;Set the pixel
;If CurrCharVal.0 = 0 Then
	lds	SysBitTest,CURRCHARVAL
	sbrc	SysBitTest,0
	rjmp	ELSE22_1
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, GLCDBackground
	lds	SysTemp3,CHARLOCX
	lds	SysTemp1,CURRCHARCOL
	add	SysTemp3,SysTemp1
	sts	GLCDX,SysTemp3
	lds	SysTemp3,CHARLOCX_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	GLCDX_H,SysTemp3
	lds	SysTemp3,CHARLOCY
	lds	SysTemp1,CURRCHARROW
	add	SysTemp3,SysTemp1
	sts	GLCDY,SysTemp3
	lds	SysTemp3,CHARLOCY_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	GLCDY_H,SysTemp3
	lds	SysValueCopy,GLCDBACKGROUND
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDBACKGROUND_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_ILI9486L
;Else
	rjmp	ENDIF22
ELSE22_1:
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, LineColour
	lds	SysTemp3,CHARLOCX
	lds	SysTemp1,CURRCHARCOL
	add	SysTemp3,SysTemp1
	sts	GLCDX,SysTemp3
	lds	SysTemp3,CHARLOCX_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	GLCDX_H,SysTemp3
	lds	SysTemp3,CHARLOCY
	lds	SysTemp1,CURRCHARROW
	add	SysTemp3,SysTemp1
	sts	GLCDY,SysTemp3
	lds	SysTemp3,CHARLOCY_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	GLCDY_H,SysTemp3
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_ILI9486L
;End If
ENDIF22:
;Rotate CurrCharVal Right
	lds	SysValueCopy,CURRCHARVAL
	ror	SysValueCopy
	sts	CURRCHARVAL,SysValueCopy
;Set to next row of date, a second row
;if GLCDfntDefaultSize = 2 and CurrCharRow = 7 then
	lds	SysBYTETempA,GLCDFNTDEFAULTSIZE
	ldi	SysBYTETempB,2
	call	SysCompEqual
	mov	SysTemp3,SysByteTempX
	lds	SysBYTETempA,CURRCHARROW
	ldi	SysBYTETempB,7
	call	SysCompEqual
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	sbrs	SysTemp1,0
	rjmp	ENDIF23
;LocalCharCode++
	lds	SysTemp3,LOCALCHARCODE
	inc	SysTemp3
	sts	LOCALCHARCODE,SysTemp3
	lds	SysTemp3,LOCALCHARCODE_H
	brne	PC + 2
	inc	SysTemp3
	sts	LOCALCHARCODE_H,SysTemp3
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	lds	SYSSTRINGA,LOCALCHARCODE
	lds	SYSSTRINGA_H,LOCALCHARCODE_H
	rcall	OLEDFONT2
	sts	CURRCHARVAL,SysByteTempX
;end if
ENDIF23:
;It is the intercharacter space, put out one pixel row
;if CurrCharCol = COLSperfont then
	lds	SysCalcTempA,CURRCHARCOL
	lds	SysCalcTempB,COLSPERFONT
	cp	SysCalcTempA,SysCalcTempB
	brne	ENDIF24
;Put out a white intercharacter pixel/space
;GLCDTemp = CharLocX + CurrCharCol
	lds	SysTemp3,CHARLOCX
	lds	SysTemp1,CURRCHARCOL
	add	SysTemp3,SysTemp1
	sts	GLCDTEMP,SysTemp3
	lds	SysTemp3,CHARLOCX_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	GLCDTEMP_H,SysTemp3
;if GLCDfntDefaultSize = 2 then
	lds	SysCalcTempA,GLCDFNTDEFAULTSIZE
	cpi	SysCalcTempA,2
	brne	ENDIF27
;GLCDTemp++
	lds	SysTemp3,GLCDTEMP
	inc	SysTemp3
	sts	GLCDTEMP,SysTemp3
	lds	SysTemp3,GLCDTEMP_H
	brne	PC + 2
	inc	SysTemp3
	sts	GLCDTEMP_H,SysTemp3
;end if
ENDIF27:
;PSet GLCDTemp , CharLocY + CurrCharRow, GLCDBackground
	lds	SysValueCopy,GLCDTEMP
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,GLCDTEMP_H
	sts	GLCDX_H,SysValueCopy
	lds	SysTemp3,CHARLOCY
	lds	SysTemp1,CURRCHARROW
	add	SysTemp3,SysTemp1
	sts	GLCDY,SysTemp3
	lds	SysTemp3,CHARLOCY_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	GLCDY_H,SysTemp3
	lds	SysValueCopy,GLCDBACKGROUND
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDBACKGROUND_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_ILI9486L
;end if
ENDIF24:
;Next
	lds	SysCalcTempA,CURRCHARROW
	lds	SysCalcTempB,ROWSPERFONT
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF25
	rjmp	SysForLoop4
ENDIF25:
SysForLoopEnd4:
;Next
	lds	SysCalcTempA,CURRCHARCOL
	lds	SysCalcTempB,COLSPERFONT
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF26
	rjmp	SysForLoop3
ENDIF26:
SysForLoopEnd3:
	ret

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:
GLCDPRINT4:
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
	brne	ENDIF8
	ret
ENDIF8:
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
	brsh	ENDIF9
	rjmp	SysForLoopEnd1
ENDIF9:
SysForLoop1:
	lds	SysTemp3,GLCDPRINT_STRING_COUNTER
	inc	SysTemp3
	sts	GLCDPRINT_STRING_COUNTER,SysTemp3
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	lds	SysValueCopy,GLCDPRINTLOC
	sts	CHARLOCX,SysValueCopy
	lds	SysValueCopy,GLCDPRINTLOC_H
	sts	CHARLOCX_H,SysValueCopy
	lds	SysValueCopy,PRINTLOCY
	sts	CHARLOCY,SysValueCopy
	lds	SysValueCopy,PRINTLOCY_H
	sts	CHARLOCY_H,SysValueCopy
	lds	SysTemp3,SysLCDPRINTDATAHandler
	lds	SysTemp1,GLCDPRINT_STRING_COUNTER
	add	SysTemp3,SysTemp1
	mov	SysStringA,SysTemp3
	lds	SysTemp3,SysLCDPRINTDATAHandler_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X
	sts	CHARCODE,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	GLCDDRAWCHAR_ILI9486L
;GLCDPrintIncrementPixelPositionMacro
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	lds	SysBYTETempA,GLCDFONTWIDTH
	lds	SysBYTETempB,GLCDFNTDEFAULTSIZE
	mul	SysByteTempA,SysByteTempB
	mov	SysTemp3,SysByteTempX
	lds	SysTemp2,GLCDPRINTLOC
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp3,GLCDPRINTLOC_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,GLCDFNTDEFAULTSIZE
	add	SysTemp1,SysTemp3
	mov	SysTemp2,SysTemp1
	ldi	SysTemp4,0
	adc	SysTemp1_H,SysTemp4
	mov	SysTemp2_H,SysTemp1_H
	ldi	SysTemp4,1
	sub	SysTemp2,SysTemp4
	sts	GLCDPRINTLOC,SysTemp2
	ldi	SysTemp4,0
	sbc	SysTemp2_H,SysTemp4
	sts	GLCDPRINTLOC_H,SysTemp2_H
;Next
	lds	SysCalcTempA,GLCDPRINT_STRING_COUNTER
	lds	SysCalcTempB,GLCDPRINTLEN
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF10
	rjmp	SysForLoop1
ENDIF10:
SysForLoopEnd1:
;GLCDFontWidth = OldGLCDFontWidth
	lds	SysValueCopy,OLDGLCDFONTWIDTH
	sts	GLCDFONTWIDTH,SysValueCopy
	ret

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:WORD:
GLCDPRINT5:
;Dim GLCDPrintLoc as word
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
	rjmp	SysForLoopEnd2
ENDIF12:
SysForLoop2:
	lds	SysTemp3,GLCDPRINT_STRING_COUNTER
	inc	SysTemp3
	sts	GLCDPRINT_STRING_COUNTER,SysTemp3
;GLCDDrawChar GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter), LineColour
	lds	SysValueCopy,GLCDPRINTLOC
	sts	CHARLOCX,SysValueCopy
	lds	SysValueCopy,GLCDPRINTLOC_H
	sts	CHARLOCX_H,SysValueCopy
	lds	SysValueCopy,PRINTLOCY
	sts	CHARLOCY,SysValueCopy
	lds	SysValueCopy,PRINTLOCY_H
	sts	CHARLOCY_H,SysValueCopy
	lds	SysTemp3,SysLCDPRINTDATAHandler
	lds	SysTemp1,GLCDPRINT_STRING_COUNTER
	add	SysTemp3,SysTemp1
	mov	SysStringA,SysTemp3
	lds	SysTemp3,SysLCDPRINTDATAHandler_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X
	sts	CHARCODE,SysValueCopy
	rcall	GLCDDRAWCHAR_ILI9486L
;GLCDPrintIncrementPixelPositionMacro
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	lds	SysBYTETempA,GLCDFONTWIDTH
	lds	SysBYTETempB,GLCDFNTDEFAULTSIZE
	mul	SysByteTempA,SysByteTempB
	mov	SysTemp3,SysByteTempX
	lds	SysTemp2,GLCDPRINTLOC
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp3,GLCDPRINTLOC_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,GLCDFNTDEFAULTSIZE
	add	SysTemp1,SysTemp3
	mov	SysTemp2,SysTemp1
	ldi	SysTemp4,0
	adc	SysTemp1_H,SysTemp4
	mov	SysTemp2_H,SysTemp1_H
	ldi	SysTemp4,1
	sub	SysTemp2,SysTemp4
	sts	GLCDPRINTLOC,SysTemp2
	ldi	SysTemp4,0
	sbc	SysTemp2_H,SysTemp4
	sts	GLCDPRINTLOC_H,SysTemp2_H
;Next
	lds	SysCalcTempA,GLCDPRINT_STRING_COUNTER
	lds	SysCalcTempB,GLCDPRINTLEN
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF13
	rjmp	SysForLoop2
ENDIF13:
SysForLoopEnd2:
;GLCDFontWidth = OldGLCDFontWidth
	lds	SysValueCopy,OLDGLCDFONTWIDTH
	sts	GLCDFONTWIDTH,SysValueCopy
	ret

;********************************************************************************

GLCDROTATE_ILI9486L:
;
;#define ILI9486L_MADCTL_MY  0x80
;#define ILI9486L_MADCTL_MX  0x40
;#define ILI9486L_MADCTL_MV  0x20
;#define ILI9486L_MADCTL_ML  0x10
;#define ILI9486L_MADCTL_RGB 0x00
;#define ILI9486L_MADCTL_BGR 0x08
;#define ILI9486L_MADCTL_MH  0x04
;select case GLCDRotateState
;case PORTRAIT  '0 degree
SysSelect5Case1:
	lds	SysCalcTempA,GLCDROTATESTATE
	cpi	SysCalcTempA,4
	brne	SysSelect5Case2
;ILI9486L_GLCD_WIDTH = GLCD_WIDTH
	ldi	SysValueCopy,64
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;ILI9486L_GLCD_HEIGHT = GLCD_HEIGHT
	ldi	SysValueCopy,224
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;case LANDSCAPE
	rjmp	SysSelectEnd5
SysSelect5Case2:
	lds	SysCalcTempA,GLCDROTATESTATE
	cpi	SysCalcTempA,1
	brne	SysSelect5Case3
;ILI9486L_GLCD_WIDTH = GLCD_HEIGHT
	ldi	SysValueCopy,224
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;ILI9486L_GLCD_HEIGHT = GLCD_WIDTH
	ldi	SysValueCopy,64
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;case PORTRAIT_REV
	rjmp	SysSelectEnd5
SysSelect5Case3:
	lds	SysCalcTempA,GLCDROTATESTATE
	cpi	SysCalcTempA,2
	brne	SysSelect5Case4
;ILI9486L_GLCD_WIDTH = GLCD_WIDTH
	ldi	SysValueCopy,64
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;ILI9486L_GLCD_HEIGHT = GLCD_HEIGHT
	ldi	SysValueCopy,224
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;case LANDSCAPE_REV
	rjmp	SysSelectEnd5
SysSelect5Case4:
	lds	SysCalcTempA,GLCDROTATESTATE
	cpi	SysCalcTempA,3
	brne	SysSelect5Case5
;ILI9486L_GLCD_WIDTH = GLCD_HEIGHT
	ldi	SysValueCopy,224
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;ILI9486L_GLCD_HEIGHT = GLCD_WIDTH
	ldi	SysValueCopy,64
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;case else
	rjmp	SysSelectEnd5
SysSelect5Case5:
;ILI9486L_GLCD_WIDTH = GLCD_WIDTH
	ldi	SysValueCopy,64
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;ILI9486L_GLCD_HEIGHT = GLCD_HEIGHT
	ldi	SysValueCopy,224
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;end select
SysSelectEnd5:
	ret

;********************************************************************************

HWSPITRANSFER:
;Master mode
;If SPICurrentMode > 10 Then
	ldi	SysCalcTempA,10
	lds	SysCalcTempB,SPICURRENTMODE
	cp	SysCalcTempA,SysCalcTempB
	brsh	ELSE49_1
;Put byte to send into buffer
;Will start transfer
;Do
SysDoLoop_S8:
;SPDR = SPITxData
	lds	SysValueCopy,SPITXDATA
	out	SPDR,SysValueCopy
;Loop While SPSR.WCOL
	in	SysBitTest,SPSR
	sbrc	SysBitTest,WCOL
	rjmp	SysDoLoop_S8
SysDoLoop_E8:
;Slave mode
;Else
	rjmp	ENDIF49
ELSE49_1:
;Retry until send succeeds
;Do
SysDoLoop_S9:
;SPDR = SPITxData
	lds	SysValueCopy,SPITXDATA
	out	SPDR,SysValueCopy
;Loop While SPSR.WCOL = On
	in	SysBitTest,SPSR
	sbrc	SysBitTest,WCOL
	rjmp	SysDoLoop_S9
SysDoLoop_E9:
;End If
ENDIF49:
;Read buffer
;Same for master and slave
;Wait While SPSR.SPIF = Off
SysWaitLoop4:
	in	SysBitTest,SPSR
	sbrs	SysBitTest,SPIF
	rjmp	SysWaitLoop4
;SPIRxData = SPDR
	in	SysValueCopy,SPDR
	sts	SPIRXDATA,SysValueCopy
	ret

;********************************************************************************

INITGLCD_ILI9486L:
;Mapped to global variables to same RAM
;dim ILI9486L_GLCD_HEIGHT, ILI9486L_GLCD_WIDTH as word
;Setup code for ILI9486L controllers
;SPI Pin directions
;Dir ILI9486L_CS Out
	sbi	DDRB,2
;Dir ILI9486L_DC Out
	sbi	DDRB,0
;Dir ILI9486L_RST Out
	sbi	DDRB,1
;Dir ILI9486L_DI In
	cbi	DDRB,4
;Dir ILI9486L_DO Out
	sbi	DDRB,3
;Dir ILI9486L_SCK Out
	sbi	DDRB,5
;harware SPI mode
;SPIMode MasterFast, 0
	ldi	SysValueCopy,13
	sts	SPICURRENTMODE,SysValueCopy
	ldi	SysValueCopy,0
	sts	SPICLOCKMODE,SysValueCopy
	call	SPIMODE516
;Set ILI9486L_CS On
	sbi	PORTB,2
;Set ILI9486L_DC On
	sbi	PORTB,0
;Reset display
;Wait 50 ms
	ldi	SysWaitTempMS,50
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Set ILI9486L_RST On
	sbi	PORTB,1
;Wait 5 ms
	ldi	SysWaitTempMS,5
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Reset sequence (lower line for at least 10 us)
;Set ILI9486L_RST Off
	cbi	PORTB,1
;Wait 20 us
	ldi	DELAYTEMP,106
DelayUS4:
	dec	DELAYTEMP
	brne	DelayUS4
	rjmp	PC + 1
;Set ILI9486L_RST On
	sbi	PORTB,1
;Wait 150 ms
	ldi	SysWaitTempMS,150
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;SendCommand_ILI9486L(0XF2)
	ldi	SysValueCopy,242
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDCOMMAND_ILI9486L
;SendData_ILI9486L(0x18)
	ldi	SysValueCopy,24
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0xA3)
	ldi	SysValueCopy,163
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x12)
	ldi	SysValueCopy,18
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x02)
	ldi	SysValueCopy,2
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0XB2)
	ldi	SysValueCopy,178
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x12)
	ldi	SysValueCopy,18
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0xFF)
	ldi	SysValueCopy,255
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x10)
	ldi	SysValueCopy,16
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x00)
	ldi	SysValueCopy,0
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendCommand_ILI9486L(0XF8)
	ldi	SysValueCopy,248
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDCOMMAND_ILI9486L
;SendData_ILI9486L(0x21)
	ldi	SysValueCopy,33
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x04)
	ldi	SysValueCopy,4
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendCommand_ILI9486L(0XF9)
	ldi	SysValueCopy,249
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDCOMMAND_ILI9486L
;SendData_ILI9486L(0x00)
	ldi	SysValueCopy,0
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x08)
	ldi	SysValueCopy,8
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendCommand_ILI9486L(0x36)
	ldi	SysValueCopy,54
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDCOMMAND_ILI9486L
;SendData_ILI9486L(0x08)
	ldi	SysValueCopy,8
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendCommand_ILI9486L(0x3A)
	ldi	SysValueCopy,58
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDCOMMAND_ILI9486L
;SendData_ILI9486L(0x05)
	ldi	SysValueCopy,5
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendCommand_ILI9486L(0xB4)
	ldi	SysValueCopy,180
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDCOMMAND_ILI9486L
;SendData_ILI9486L(0x01)
	ldi	SysValueCopy,1
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendCommand_ILI9486L(0xB6)
	ldi	SysValueCopy,182
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDCOMMAND_ILI9486L
;SendData_ILI9486L(0x02)
	ldi	SysValueCopy,2
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x22)
	ldi	SysValueCopy,34
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendCommand_ILI9486L(0xC1)
	ldi	SysValueCopy,193
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDCOMMAND_ILI9486L
;SendData_ILI9486L(0x41)
	ldi	SysValueCopy,65
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendCommand_ILI9486L(0xC5)
	ldi	SysValueCopy,197
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDCOMMAND_ILI9486L
;SendData_ILI9486L(0x00)
	ldi	SysValueCopy,0
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x07)
	ldi	SysValueCopy,7
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendCommand_ILI9486L(0xE0)
	ldi	SysValueCopy,224
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDCOMMAND_ILI9486L
;SendData_ILI9486L(0x0F)
	ldi	SysValueCopy,15
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x1F)
	ldi	SysValueCopy,31
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x1C)
	ldi	SysValueCopy,28
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x0C)
	ldi	SysValueCopy,12
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x0F)
	ldi	SysValueCopy,15
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x08)
	ldi	SysValueCopy,8
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x48)
	ldi	SysValueCopy,72
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x98)
	ldi	SysValueCopy,152
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x37)
	ldi	SysValueCopy,55
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x0A)
	ldi	SysValueCopy,10
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x13)
	ldi	SysValueCopy,19
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x04)
	ldi	SysValueCopy,4
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x11)
	ldi	SysValueCopy,17
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x0D)
	ldi	SysValueCopy,13
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x00)
	ldi	SysValueCopy,0
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendCommand_ILI9486L(0xE1)
	ldi	SysValueCopy,225
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDCOMMAND_ILI9486L
;SendData_ILI9486L(0x0F)
	ldi	SysValueCopy,15
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x32)
	ldi	SysValueCopy,50
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x2E)
	ldi	SysValueCopy,46
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x0B)
	ldi	SysValueCopy,11
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x0D)
	ldi	SysValueCopy,13
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x05)
	ldi	SysValueCopy,5
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x47)
	ldi	SysValueCopy,71
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x75)
	ldi	SysValueCopy,117
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x37)
	ldi	SysValueCopy,55
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x06)
	ldi	SysValueCopy,6
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x10)
	ldi	SysValueCopy,16
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x03)
	ldi	SysValueCopy,3
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x24)
	ldi	SysValueCopy,36
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x20)
	ldi	SysValueCopy,32
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendData_ILI9486L(0x00)
	ldi	SysValueCopy,0
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDDATA_ILI9486L
;SendCommand_ILI9486L(0x11)
	ldi	SysValueCopy,17
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDCOMMAND_ILI9486L
;wait 120 ms
	ldi	SysWaitTempMS,120
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
;SendCommand_ILI9486L(0x29)
	ldi	SysValueCopy,41
	sts	ILI9486LSENDBYTE,SysValueCopy
	call	SENDCOMMAND_ILI9486L
;Default Colours
;GLCDBackground = ILI9486L_BLACK
	ldi	SysValueCopy,0
	sts	GLCDBACKGROUND,SysValueCopy
	sts	GLCDBACKGROUND_H,SysValueCopy
;GLCDForeground = ILI9486L_WHITE
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND,SysValueCopy
	sts	GLCDFOREGROUND_H,SysValueCopy
;Variables required for device
;ILI9486L_GLCD_WIDTH = GLCD_WIDTH
	ldi	SysValueCopy,64
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;ILI9486L_GLCD_HEIGHT = GLCD_HEIGHT
	ldi	SysValueCopy,224
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;GLCDFontWidth = 6
	ldi	SysValueCopy,6
	sts	GLCDFONTWIDTH,SysValueCopy
;GLCDfntDefault = 0
	ldi	SysValueCopy,0
	sts	GLCDFNTDEFAULT,SysValueCopy
;GLCDfntDefaultsize = 2
	ldi	SysValueCopy,2
	sts	GLCDFNTDEFAULTSIZE,SysValueCopy
;GLCDRotate Portrait
	ldi	SysValueCopy,4
	sts	GLCDROTATESTATE,SysValueCopy
	rcall	GLCDROTATE_ILI9486L
;GLCDCLS_ILI9486L
	rjmp	GLCDCLS_ILI9486L

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

INITUNO:
;Set UART pin directions
;Dir PORTD.0 In
	cbi	DDRD,0
;Dir PORTD.1 Out
	sbi	DDRD,1
	ret

;********************************************************************************

INIT_XPT2046:
;XPT2046_Xmin =  XPT2046XMIN
	ldi	SysValueCopy,12
	sts	XPT2046_XMIN,SysValueCopy
;XPT2046_Ymin =  XPT2046YMIN
	ldi	SysValueCopy,10
	sts	XPT2046_YMIN,SysValueCopy
;XPT2046_Xmax =  XPT2046XMAX
	ldi	SysValueCopy,108
	sts	XPT2046_XMAX,SysValueCopy
;XPT2046_Ymax =  XPT2046YMAX
	ldi	SysValueCopy,117
	sts	XPT2046_YMAX,SysValueCopy
;DIR XPT2046_DI IN
	cbi	DDRB,4
;DIR XPT2046_IRQ IN
	cbi	DDRC,5
;DIR XPT2046_DO OUT
	sbi	DDRB,3
;DIR XPT2046_SCK OUT
	sbi	DDRB,5
;DIR XPT2046_CS  OUT
	sbi	DDRD,2
;harware SPI mode
;SPIMode MasterFast, 0
	ldi	SysValueCopy,13
	sts	SPICURRENTMODE,SysValueCopy
	ldi	SysValueCopy,0
	sts	SPICLOCKMODE,SysValueCopy
	call	SPIMODE516
;Repeat 4
	ldi	SysValueCopy,4
	sts	SysRepeatTemp2,SysValueCopy
SysRepeatLoop2:
;set XPT2046_CS OFF
	cbi	PORTD,2
;wait 10 ms
	ldi	SysWaitTempMS,10
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
;set XPT2046_CS ON
	sbi	PORTD,2
;wait 10 ms
	ldi	SysWaitTempMS,10
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
;End Repeat
	lds	SysTemp3,SysRepeatTemp2
	dec	SysTemp3
	sts	SysRepeatTemp2,SysTemp3
	brne	SysRepeatLoop2
SysRepeatLoopEnd2:
;EnableIRQ_XPT2046
	jmp	ENABLEIRQ_XPT2046

;********************************************************************************

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
	lds	SysTemp3,LINEX2
	lds	SysTemp1,LINEX1
	sub	SysTemp3,SysTemp1
	sts	LINEDIFFX,SysTemp3
	lds	SysTemp3,LINEX2_H
	lds	SysTemp1,LINEX1_H
	sbc	SysTemp3,SysTemp1
	sts	LINEDIFFX_H,SysTemp3
;LineDiffY =  LineY2 -   LineY1
	lds	SysTemp3,LINEY2
	lds	SysTemp1,LINEY1
	sub	SysTemp3,SysTemp1
	sts	LINEDIFFY,SysTemp3
	lds	SysTemp3,LINEY2_H
	lds	SysTemp1,LINEY1_H
	sbc	SysTemp3,SysTemp1
	sts	LINEDIFFY_H,SysTemp3
;if (LineDiffX > 0) then
	lds	SysINTEGERTempB,LINEDIFFX
	lds	SysINTEGERTempB_H,LINEDIFFX_H
	ldi	SysINTEGERTempA,0
	ldi	SysINTEGERTempA_H,0
	call	SysCompLessThanINT
	sbrs	SysByteTempX,0
	rjmp	ELSE15_1
;LineStepX = 1
	ldi	SysValueCopy,1
	sts	LINESTEPX,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINESTEPX_H,SysValueCopy
;else
	rjmp	ENDIF15
ELSE15_1:
;LineStepX = -1
	ldi	SysValueCopy,255
	sts	LINESTEPX,SysValueCopy
	sts	LINESTEPX_H,SysValueCopy
;end if
ENDIF15:
;if (LineDiffY > 0) then
	lds	SysINTEGERTempB,LINEDIFFY
	lds	SysINTEGERTempB_H,LINEDIFFY_H
	ldi	SysINTEGERTempA,0
	ldi	SysINTEGERTempA_H,0
	call	SysCompLessThanINT
	sbrs	SysByteTempX,0
	rjmp	ELSE16_1
;LineStepY = 1
	ldi	SysValueCopy,1
	sts	LINESTEPY,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINESTEPY_H,SysValueCopy
;else
	rjmp	ENDIF16
ELSE16_1:
;LineStepY = -1
	ldi	SysValueCopy,255
	sts	LINESTEPY,SysValueCopy
	sts	LINESTEPY_H,SysValueCopy
;end if
ENDIF16:
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
	rjmp	ELSE17_1
;LineErr = LineDiffY_x2 - LineDiffX
	lds	SysTemp3,LINEDIFFY_X2
	lds	SysTemp1,LINEDIFFX
	sub	SysTemp3,SysTemp1
	sts	LINEERR,SysTemp3
	lds	SysTemp3,LINEDIFFY_X2_H
	lds	SysTemp1,LINEDIFFX_H
	sbc	SysTemp3,SysTemp1
	sts	LINEERR_H,SysTemp3
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
	rcall	PSET_ILI9486L
;LineX1 += LineStepX
	lds	SysTemp3,LINEX1
	lds	SysTemp1,LINESTEPX
	add	SysTemp3,SysTemp1
	sts	LINEX1,SysTemp3
	lds	SysTemp3,LINEX1_H
	lds	SysTemp1,LINESTEPX_H
	adc	SysTemp3,SysTemp1
	sts	LINEX1_H,SysTemp3
;if ( LineErr < 0) then
	lds	SysINTEGERTempA,LINEERR
	lds	SysINTEGERTempA_H,LINEERR_H
	ldi	SysINTEGERTempB,0
	ldi	SysINTEGERTempB_H,0
	call	SysCompLessThanINT
	sbrs	SysByteTempX,0
	rjmp	ELSE18_1
;LineErr += LineDiffY_x2
	lds	SysTemp3,LINEERR
	lds	SysTemp1,LINEDIFFY_X2
	add	SysTemp3,SysTemp1
	sts	LINEERR,SysTemp3
	lds	SysTemp3,LINEERR_H
	lds	SysTemp1,LINEDIFFY_X2_H
	adc	SysTemp3,SysTemp1
	sts	LINEERR_H,SysTemp3
;else
	rjmp	ENDIF18
ELSE18_1:
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	lds	SysTemp3,LINEDIFFY_X2
	lds	SysTemp2,LINEDIFFX_X2
	sub	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,LINEDIFFY_X2_H
	lds	SysTemp2,LINEDIFFX_X2_H
	sbc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,LINEERR
	add	SysTemp3,SysTemp1
	sts	LINEERR,SysTemp3
	lds	SysTemp3,LINEERR_H
	adc	SysTemp3,SysTemp1_H
	sts	LINEERR_H,SysTemp3
;LineY1 += LineStepY
	lds	SysTemp3,LINEY1
	lds	SysTemp1,LINESTEPY
	add	SysTemp3,SysTemp1
	sts	LINEY1,SysTemp3
	lds	SysTemp3,LINEY1_H
	lds	SysTemp1,LINESTEPY_H
	adc	SysTemp3,SysTemp1
	sts	LINEY1_H,SysTemp3
;end if
ENDIF18:
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
	rcall	PSET_ILI9486L
;else
	rjmp	ENDIF17
ELSE17_1:
;LineErr = LineDiffX_x2 - LineDiffY
	lds	SysTemp3,LINEDIFFX_X2
	lds	SysTemp1,LINEDIFFY
	sub	SysTemp3,SysTemp1
	sts	LINEERR,SysTemp3
	lds	SysTemp3,LINEDIFFX_X2_H
	lds	SysTemp1,LINEDIFFY_H
	sbc	SysTemp3,SysTemp1
	sts	LINEERR_H,SysTemp3
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
	rcall	PSET_ILI9486L
;LineY1 += LineStepY
	lds	SysTemp3,LINEY1
	lds	SysTemp1,LINESTEPY
	add	SysTemp3,SysTemp1
	sts	LINEY1,SysTemp3
	lds	SysTemp3,LINEY1_H
	lds	SysTemp1,LINESTEPY_H
	adc	SysTemp3,SysTemp1
	sts	LINEY1_H,SysTemp3
;if ( LineErr < 0) then
	lds	SysINTEGERTempA,LINEERR
	lds	SysINTEGERTempA_H,LINEERR_H
	ldi	SysINTEGERTempB,0
	ldi	SysINTEGERTempB_H,0
	call	SysCompLessThanINT
	sbrs	SysByteTempX,0
	rjmp	ELSE19_1
;LineErr += LineDiffX_x2
	lds	SysTemp3,LINEERR
	lds	SysTemp1,LINEDIFFX_X2
	add	SysTemp3,SysTemp1
	sts	LINEERR,SysTemp3
	lds	SysTemp3,LINEERR_H
	lds	SysTemp1,LINEDIFFX_X2_H
	adc	SysTemp3,SysTemp1
	sts	LINEERR_H,SysTemp3
;else
	rjmp	ENDIF19
ELSE19_1:
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	lds	SysTemp3,LINEDIFFX_X2
	lds	SysTemp2,LINEDIFFY_X2
	sub	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,LINEDIFFX_X2_H
	lds	SysTemp2,LINEDIFFY_X2_H
	sbc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,LINEERR
	add	SysTemp3,SysTemp1
	sts	LINEERR,SysTemp3
	lds	SysTemp3,LINEERR_H
	adc	SysTemp3,SysTemp1_H
	sts	LINEERR_H,SysTemp3
;LineX1 += LineStepX
	lds	SysTemp3,LINEX1
	lds	SysTemp1,LINESTEPX
	add	SysTemp3,SysTemp1
	sts	LINEX1,SysTemp3
	lds	SysTemp3,LINEX1_H
	lds	SysTemp1,LINESTEPX_H
	adc	SysTemp3,SysTemp1
	sts	LINEX1_H,SysTemp3
;end if
ENDIF19:
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
	rcall	PSET_ILI9486L
;end if
ENDIF17:
	ret

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
	call	SysCompLessThan16
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
	call	SysCompLessThan16
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

FN_PAD:
;Check length of SysInString
;If SysInString(0) = longer or equal SysStrLen then
;give back SysInString and exit function
;If SysInString(0) < SysStrLen Then
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysCalcTempA,X
	lds	SysCalcTempB,SYSSTRLEN
	cp	SysCalcTempA,SysCalcTempB
	brlo	PC + 2
	rjmp	ELSE54_1
;SysCharCount = SysInString(0)
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysValueCopy,X
	sts	SYSCHARCOUNT,SysValueCopy
;clear output string
;Pad=""
	ldi	SysStringB,low(PAD)
	ldi	SysStringB_H,high(PAD)
	ldi	SysReadA,low(StringTable74<<1)
	ldi	SysReadA_H,high(StringTable74<<1)
	call	SysReadString
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
	ldi	SysValueCopy,0
	sts	SYSSTRINGTEMP,SysValueCopy
	lds	SysCalcTempA,SYSCHARCOUNT
	cpi	SysCalcTempA,1
	brlo	SysForLoopEnd7
SysForLoop7:
	lds	SysTemp3,SYSSTRINGTEMP
	inc	SysTemp3
	sts	SYSSTRINGTEMP,SysTemp3
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	lds	SysTemp3,SysSYSINSTRINGHandler
	lds	SysTemp1,SYSSTRINGTEMP
	add	SysTemp3,SysTemp1
	mov	SysStringA,SysTemp3
	lds	SysTemp3,SysSYSINSTRINGHandler_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X+
	sts	SysArrayTemp1,SysValueCopy
	sts	SysArrayTemp2,SysValueCopy
	lds	SysTemp3,SYSSTRINGTEMP
	ldi	SysTemp4,low(PAD)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(PAD)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysValueCopy,SysArrayTemp2
	st	X+,SysValueCopy
;Next
	lds	SysCalcTempA,SYSSTRINGTEMP
	lds	SysCalcTempB,SYSCHARCOUNT
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop7
SysForLoopEnd7:
;For SysStringTemp = SysCharCount+1 to SysStrLen
	lds	SysTemp1,SYSCHARCOUNT
	inc	SysTemp1
	dec	SysTemp1
	sts	SYSSTRINGTEMP,SysTemp1
	lds	SysTemp1,SYSCHARCOUNT
	inc	SysTemp1
	mov	SysBYTETempB,SysTemp1
	lds	SysBYTETempA,SYSSTRLEN
	rcall	SysCompLessThan
	sbrc	SysByteTempX,0
	rjmp	SysForLoopEnd8
ENDIF57:
SysForLoop8:
	lds	SysTemp3,SYSSTRINGTEMP
	inc	SysTemp3
	sts	SYSSTRINGTEMP,SysTemp3
;Pad(SysStringTemp) = SysInString3(1)
	lds	SysTemp3,SysSYSINSTRING3Handler
	ldi	SysTemp4,1
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	lds	SysTemp3,SysSYSINSTRING3Handler_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X+
	sts	SysArrayTemp2,SysValueCopy
	sts	SysArrayTemp1,SysValueCopy
	lds	SysTemp3,SYSSTRINGTEMP
	ldi	SysTemp4,low(PAD)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(PAD)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysValueCopy,SysArrayTemp1
	st	X+,SysValueCopy
;Next
	lds	SysCalcTempA,SYSSTRINGTEMP
	lds	SysCalcTempB,SYSSTRLEN
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop8
SysForLoopEnd8:
;set new length to PAD
;Pad(0) = SysStrLen
	lds	SysValueCopy,SYSSTRLEN
	sts	SYSPAD_0,SysValueCopy
;else
	rjmp	ENDIF54
ELSE54_1:
;SysInString is equal or longer than SysStrLen
;give back old string; copy SysInString to Pad
;For SysStringTemp = 1 To SysInString(0)
	ldi	SysValueCopy,0
	sts	SYSSTRINGTEMP,SysValueCopy
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysCalcTempA,X
	cpi	SysCalcTempA,1
	brlo	SysForLoopEnd9
SysForLoop9:
	lds	SysTemp3,SYSSTRINGTEMP
	inc	SysTemp3
	sts	SYSSTRINGTEMP,SysTemp3
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	lds	SysTemp3,SysSYSINSTRINGHandler
	lds	SysTemp1,SYSSTRINGTEMP
	add	SysTemp3,SysTemp1
	mov	SysStringA,SysTemp3
	lds	SysTemp3,SysSYSINSTRINGHandler_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X+
	sts	SysArrayTemp1,SysValueCopy
	sts	SysArrayTemp2,SysValueCopy
	lds	SysTemp3,SYSSTRINGTEMP
	ldi	SysTemp4,low(PAD)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(PAD)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysValueCopy,SysArrayTemp2
	st	X+,SysValueCopy
;Next
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	lds	SysCalcTempA,SYSSTRINGTEMP
	ld	SysCalcTempB,X
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop9
SysForLoopEnd9:
;PAD(0) = SysInString(0)
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysValueCopy,X+
	sts	SysArrayTemp1,SysValueCopy
	sts	SYSPAD_0,SysValueCopy
;End If
ENDIF54:
	ret

;********************************************************************************

PSET_ILI9486L:
;select case GLCDRotateState
;case PORTRAIT  '0 degree
SysSelect3Case1:
	lds	SysCalcTempA,GLCDROTATESTATE
	cpi	SysCalcTempA,4
	brne	SysSelect3Case2
;SetAddressWindow_ILI9486L ( GLCDX, GLCDY, GLCDX, GLCDY )
	lds	SysValueCopy,GLCDX
	sts	_X1,SysValueCopy
	lds	SysValueCopy,GLCDX_H
	sts	_X1_H,SysValueCopy
	lds	SysValueCopy,GLCDY
	sts	_Y1,SysValueCopy
	lds	SysValueCopy,GLCDY_H
	sts	_Y1_H,SysValueCopy
	lds	SysValueCopy,GLCDX
	sts	_X2,SysValueCopy
	lds	SysValueCopy,GLCDX_H
	sts	_X2_H,SysValueCopy
	lds	SysValueCopy,GLCDY
	sts	_Y2,SysValueCopy
	lds	SysValueCopy,GLCDY_H
	sts	_Y2_H,SysValueCopy
	rcall	SETADDRESSWINDOW_ILI9486L
;SendWord_ILI9486L GLCDColour
	lds	SysValueCopy,GLCDCOLOUR
	sts	ILI9486LSENDWORD,SysValueCopy
	lds	SysValueCopy,GLCDCOLOUR_H
	sts	ILI9486LSENDWORD_H,SysValueCopy
	rcall	SENDWORD_ILI9486L
;case LANDSCAPE
	rjmp	SysSelectEnd3
SysSelect3Case2:
	lds	SysCalcTempA,GLCDROTATESTATE
	cpi	SysCalcTempA,1
	breq	PC + 2
	rjmp	SysSelect3Case3
;SetAddressWindow_ILI9486L ( GLCDy, ILI9486L_GLCD_WIDTH -GLCDx -0, GLCDy, ILI9486L_GLCD_WIDTH -GLCDx -0 )
	lds	SysValueCopy,GLCDY
	sts	_X1,SysValueCopy
	lds	SysValueCopy,GLCDY_H
	sts	_X1_H,SysValueCopy
	lds	SysTemp3,GLCDDEVICEWIDTH
	lds	SysTemp1,GLCDX
	sub	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	lds	SysTemp3,GLCDDEVICEWIDTH_H
	lds	SysTemp1,GLCDX_H
	sbc	SysTemp3,SysTemp1
	mov	SysTemp2_H,SysTemp3
	ldi	SysTemp4,0
	sub	SysTemp2,SysTemp4
	sts	_Y1,SysTemp2
	ldi	SysTemp4,0
	sbc	SysTemp2_H,SysTemp4
	sts	_Y1_H,SysTemp2_H
	lds	SysValueCopy,GLCDY
	sts	_X2,SysValueCopy
	lds	SysValueCopy,GLCDY_H
	sts	_X2_H,SysValueCopy
	lds	SysTemp3,GLCDDEVICEWIDTH
	lds	SysTemp1,GLCDX
	sub	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	lds	SysTemp3,GLCDDEVICEWIDTH_H
	lds	SysTemp1,GLCDX_H
	sbc	SysTemp3,SysTemp1
	mov	SysTemp2_H,SysTemp3
	ldi	SysTemp4,0
	sub	SysTemp2,SysTemp4
	sts	_Y2,SysTemp2
	ldi	SysTemp4,0
	sbc	SysTemp2_H,SysTemp4
	sts	_Y2_H,SysTemp2_H
	rcall	SETADDRESSWINDOW_ILI9486L
;SendWord_ILI9486L GLCDColour
	lds	SysValueCopy,GLCDCOLOUR
	sts	ILI9486LSENDWORD,SysValueCopy
	lds	SysValueCopy,GLCDCOLOUR_H
	sts	ILI9486LSENDWORD_H,SysValueCopy
	rcall	SENDWORD_ILI9486L
;case PORTRAIT_REV
	rjmp	SysSelectEnd3
SysSelect3Case3:
	lds	SysCalcTempA,GLCDROTATESTATE
	cpi	SysCalcTempA,2
	breq	PC + 2
	rjmp	SysSelect3Case4
;SetAddressWindow_ILI9486L ( ILI9486L_GLCD_WIDTH - GLCDX-0, ILI9486L_GLCD_HEIGHT - GLCDY-0, ILI9486L_GLCD_WIDTH - GLCDX-0, ILI9486L_GLCD_HEIGHT - GLCDY-0 )
	lds	SysTemp3,GLCDDEVICEWIDTH
	lds	SysTemp1,GLCDX
	sub	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	lds	SysTemp3,GLCDDEVICEWIDTH_H
	lds	SysTemp1,GLCDX_H
	sbc	SysTemp3,SysTemp1
	mov	SysTemp2_H,SysTemp3
	ldi	SysTemp4,0
	sub	SysTemp2,SysTemp4
	sts	_X1,SysTemp2
	ldi	SysTemp4,0
	sbc	SysTemp2_H,SysTemp4
	sts	_X1_H,SysTemp2_H
	lds	SysTemp3,GLCDDEVICEHEIGHT
	lds	SysTemp1,GLCDY
	sub	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	lds	SysTemp3,GLCDDEVICEHEIGHT_H
	lds	SysTemp1,GLCDY_H
	sbc	SysTemp3,SysTemp1
	mov	SysTemp2_H,SysTemp3
	ldi	SysTemp4,0
	sub	SysTemp2,SysTemp4
	sts	_Y1,SysTemp2
	ldi	SysTemp4,0
	sbc	SysTemp2_H,SysTemp4
	sts	_Y1_H,SysTemp2_H
	lds	SysTemp3,GLCDDEVICEWIDTH
	lds	SysTemp1,GLCDX
	sub	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	lds	SysTemp3,GLCDDEVICEWIDTH_H
	lds	SysTemp1,GLCDX_H
	sbc	SysTemp3,SysTemp1
	mov	SysTemp2_H,SysTemp3
	ldi	SysTemp4,0
	sub	SysTemp2,SysTemp4
	sts	_X2,SysTemp2
	ldi	SysTemp4,0
	sbc	SysTemp2_H,SysTemp4
	sts	_X2_H,SysTemp2_H
	lds	SysTemp3,GLCDDEVICEHEIGHT
	lds	SysTemp1,GLCDY
	sub	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	lds	SysTemp3,GLCDDEVICEHEIGHT_H
	lds	SysTemp1,GLCDY_H
	sbc	SysTemp3,SysTemp1
	mov	SysTemp2_H,SysTemp3
	ldi	SysTemp4,0
	sub	SysTemp2,SysTemp4
	sts	_Y2,SysTemp2
	ldi	SysTemp4,0
	sbc	SysTemp2_H,SysTemp4
	sts	_Y2_H,SysTemp2_H
	rcall	SETADDRESSWINDOW_ILI9486L
;SendWord_ILI9486L GLCDColour
	lds	SysValueCopy,GLCDCOLOUR
	sts	ILI9486LSENDWORD,SysValueCopy
	lds	SysValueCopy,GLCDCOLOUR_H
	sts	ILI9486LSENDWORD_H,SysValueCopy
	rcall	SENDWORD_ILI9486L
;case LANDSCAPE_REV
	rjmp	SysSelectEnd3
SysSelect3Case4:
	lds	SysCalcTempA,GLCDROTATESTATE
	cpi	SysCalcTempA,3
	breq	PC + 2
	rjmp	SysSelect3Case5
;SetAddressWindow_ILI9486L ( ILI9486L_GLCD_HEIGHT - GLCDy-0, GLCDx, ILI9486L_GLCD_HEIGHT - GLCDy-0, GLCDx )
	lds	SysTemp3,GLCDDEVICEHEIGHT
	lds	SysTemp1,GLCDY
	sub	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	lds	SysTemp3,GLCDDEVICEHEIGHT_H
	lds	SysTemp1,GLCDY_H
	sbc	SysTemp3,SysTemp1
	mov	SysTemp2_H,SysTemp3
	ldi	SysTemp4,0
	sub	SysTemp2,SysTemp4
	sts	_X1,SysTemp2
	ldi	SysTemp4,0
	sbc	SysTemp2_H,SysTemp4
	sts	_X1_H,SysTemp2_H
	lds	SysValueCopy,GLCDX
	sts	_Y1,SysValueCopy
	lds	SysValueCopy,GLCDX_H
	sts	_Y1_H,SysValueCopy
	lds	SysTemp3,GLCDDEVICEHEIGHT
	lds	SysTemp1,GLCDY
	sub	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	lds	SysTemp3,GLCDDEVICEHEIGHT_H
	lds	SysTemp1,GLCDY_H
	sbc	SysTemp3,SysTemp1
	mov	SysTemp2_H,SysTemp3
	ldi	SysTemp4,0
	sub	SysTemp2,SysTemp4
	sts	_X2,SysTemp2
	ldi	SysTemp4,0
	sbc	SysTemp2_H,SysTemp4
	sts	_X2_H,SysTemp2_H
	lds	SysValueCopy,GLCDX
	sts	_Y2,SysValueCopy
	lds	SysValueCopy,GLCDX_H
	sts	_Y2_H,SysValueCopy
	rcall	SETADDRESSWINDOW_ILI9486L
;SendWord_ILI9486L GLCDColour
	lds	SysValueCopy,GLCDCOLOUR
	sts	ILI9486LSENDWORD,SysValueCopy
	lds	SysValueCopy,GLCDCOLOUR_H
	sts	ILI9486LSENDWORD_H,SysValueCopy
	rcall	SENDWORD_ILI9486L
;case else
	rjmp	SysSelectEnd3
SysSelect3Case5:
;SetAddressWindow_ILI9486L ( GLCDX, GLCDY, GLCDX, GLCDY )
	lds	SysValueCopy,GLCDX
	sts	_X1,SysValueCopy
	lds	SysValueCopy,GLCDX_H
	sts	_X1_H,SysValueCopy
	lds	SysValueCopy,GLCDY
	sts	_Y1,SysValueCopy
	lds	SysValueCopy,GLCDY_H
	sts	_Y1_H,SysValueCopy
	lds	SysValueCopy,GLCDX
	sts	_X2,SysValueCopy
	lds	SysValueCopy,GLCDX_H
	sts	_X2_H,SysValueCopy
	lds	SysValueCopy,GLCDY
	sts	_Y2,SysValueCopy
	lds	SysValueCopy,GLCDY_H
	sts	_Y2_H,SysValueCopy
	rcall	SETADDRESSWINDOW_ILI9486L
;SendWord_ILI9486L GLCDColour
	lds	SysValueCopy,GLCDCOLOUR
	sts	ILI9486LSENDWORD,SysValueCopy
	lds	SysValueCopy,GLCDCOLOUR_H
	sts	ILI9486LSENDWORD_H,SysValueCopy
	rcall	SENDWORD_ILI9486L
;end select
SysSelectEnd3:
	ret

;********************************************************************************

FN_SCALE:
;dim l_syscalc as integer
;dim l_syscalcF as long
;l_syscalcf =  [long]( l_map - l_fromLow ) * [long](l_toHigh   - l_toLow)
	lds	SysTemp3,L_MAP
	lds	SysTemp2,L_FROMLOW
	sub	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,L_MAP_H
	lds	SysTemp2,L_FROMLOW_H
	sbc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,L_TOHIGH
	lds	SysTemp4,L_TOLOW
	sub	SysTemp3,SysTemp4
	mov	SysTemp2,SysTemp3
	lds	SysTemp3,L_TOHIGH_H
	lds	SysTemp4,L_TOLOW_H
	sbc	SysTemp3,SysTemp4
	mov	SysTemp2_H,SysTemp3
	mov	SysLONGTempA,SYSTEMP1
	mov	SysLONGTempA_H,SYSTEMP1_H
	ldi	SysLONGTempA_U,0
	ldi	SysLONGTempA_E,0
	mov	SysLONGTempB,SYSTEMP2
	mov	SysLONGTempB_H,SYSTEMP2_H
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	rcall	SysMultSub32
	sts	L_SYSCALCF,SysLONGTempX
	sts	L_SYSCALCF_H,SysLONGTempX_H
	sts	L_SYSCALCF_U,SysLONGTempX_U
	sts	L_SYSCALCF_E,SysLONGTempX_E
;l_syscalc = (  l_fromHigh - l_fromLow )
	lds	SysTemp3,L_FROMHIGH
	lds	SysTemp1,L_FROMLOW
	sub	SysTemp3,SysTemp1
	sts	L_SYSCALC,SysTemp3
	lds	SysTemp3,L_FROMHIGH_H
	lds	SysTemp1,L_FROMLOW_H
	sbc	SysTemp3,SysTemp1
	sts	L_SYSCALC_H,SysTemp3
;scale = (l_syscalcf / l_syscalc) + l_toLow + l_calibrate
	lds	SysLONGTempA,L_SYSCALCF
	lds	SysLONGTempA_H,L_SYSCALCF_H
	lds	SysLONGTempA_U,L_SYSCALCF_U
	lds	SysLONGTempA_E,L_SYSCALCF_E
	lds	SysLONGTempB,L_SYSCALC
	lds	SysLONGTempB_H,L_SYSCALC_H
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	rcall	SysDivSub32
	mov	SysTemp1,SysLONGTempA
	mov	SysTemp1_H,SysLONGTempA_H
	mov	SysTemp1_U,SysLONGTempA_U
	mov	SysTemp1_E,SysLONGTempA_E
	lds	SysTemp3,L_TOLOW
	add	SysTemp1,SysTemp3
	mov	SysTemp2,SysTemp1
	lds	SysTemp3,L_TOLOW_H
	adc	SysTemp1_H,SysTemp3
	mov	SysTemp2_H,SysTemp1_H
	lds	SysTemp3,L_CALIBRATE
	add	SysTemp2,SysTemp3
	sts	SCALE,SysTemp2
	lds	SysTemp3,L_CALIBRATE_H
	adc	SysTemp2_H,SysTemp3
	sts	SCALE_H,SysTemp2_H
	ret

;********************************************************************************

SCREENLAYOUT:
;GLCDfntDefaultsize = 2
	ldi	SysValueCopy,2
	sts	GLCDFNTDEFAULTSIZE,SysValueCopy
;GLCDFontWidth = 5
	ldi	SysValueCopy,5
	sts	GLCDFONTWIDTH,SysValueCopy
;Layout the screen
;GLCDCLS
	call	GLCDCLS_ILI9486L
;GLCDPrint ( 2, 3, "XPT2046 demonstration 2018")
	ldi	SysValueCopy,2
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,3
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable1<<1)
	ldi	SysReadA_H,high(StringTable1<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;line 0, 34, Current_GLCD_WIDTH, 34
	ldi	SysValueCopy,0
	sts	LINEX1,SysValueCopy
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,34
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_WIDTH
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_WIDTH_H
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,34
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	LINE
;line 0, 128, Current_GLCD_WIDTH, 128
	ldi	SysValueCopy,0
	sts	LINEX1,SysValueCopy
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,128
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_WIDTH
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_WIDTH_H
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,128
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	LINE
;line 0, 220, Current_GLCD_WIDTH, 220
	ldi	SysValueCopy,0
	sts	LINEX1,SysValueCopy
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,220
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_WIDTH
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_WIDTH_H
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,220
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	LINE
;GLCDPrint ( 2, 25, "Dynamic Calibration")
	ldi	SysValueCopy,2
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,25
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable2<<1)
	ldi	SysReadA_H,high(StringTable2<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 22, 40, "Raw    Min   Max")
	ldi	SysValueCopy,22
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,40
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable3<<1)
	ldi	SysReadA_H,high(StringTable3<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 2, 56, "X:")
	ldi	SysValueCopy,2
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,56
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable4<<1)
	ldi	SysReadA_H,high(StringTable4<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 2, 72, "Y:")
	ldi	SysValueCopy,2
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,72
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable5<<1)
	ldi	SysReadA_H,high(StringTable5<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 2, 122, "Current Calibration")
	ldi	SysValueCopy,2
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,122
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable6<<1)
	ldi	SysReadA_H,high(StringTable6<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 2, 146, "X:")
	ldi	SysValueCopy,2
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,146
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable4<<1)
	ldi	SysReadA_H,high(StringTable4<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 2, 162, "Y:")
	ldi	SysValueCopy,2
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,162
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable5<<1)
	ldi	SysReadA_H,high(StringTable5<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 102, 146, pad(str(XPT2046_Xmin),3 ) )
	ldi	SysValueCopy,102
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,146
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,XPT2046_XMIN
	sts	SYSVALTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,3
	sts	SYSSTRLEN,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable50<<1)
	ldi	SysReadA_H,high(StringTable50<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysSYSINSTRING3Handler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysSYSINSTRING3Handler_H,SysValueCopy
	rcall	FN_PAD
	ldi	SysValueCopy,low(PAD)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(PAD)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 102, 162, pad(str(XPT2046_Ymin),3 ) )
	ldi	SysValueCopy,102
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,162
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,XPT2046_YMIN
	sts	SYSVALTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,3
	sts	SYSSTRLEN,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable50<<1)
	ldi	SysReadA_H,high(StringTable50<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysSYSINSTRING3Handler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysSYSINSTRING3Handler_H,SysValueCopy
	rcall	FN_PAD
	ldi	SysValueCopy,low(PAD)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(PAD)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 162, 146, pad(str(XPT2046_Xmax),3 ) )
	ldi	SysValueCopy,162
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,146
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,XPT2046_XMAX
	sts	SYSVALTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,3
	sts	SYSSTRLEN,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable50<<1)
	ldi	SysReadA_H,high(StringTable50<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysSYSINSTRING3Handler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysSYSINSTRING3Handler_H,SysValueCopy
	rcall	FN_PAD
	ldi	SysValueCopy,low(PAD)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(PAD)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 162, 162, pad(str(XPT2046_Ymax),3 ) )
	ldi	SysValueCopy,162
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,162
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,XPT2046_YMAX
	sts	SYSVALTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,3
	sts	SYSSTRLEN,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable50<<1)
	ldi	SysReadA_H,high(StringTable50<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysSYSINSTRING3Handler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysSYSINSTRING3Handler_H,SysValueCopy
	rcall	FN_PAD
	ldi	SysValueCopy,low(PAD)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(PAD)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 2, 214, "Scaled")
	ldi	SysValueCopy,2
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,214
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable7<<1)
	ldi	SysReadA_H,high(StringTable7<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 2, 230, "X:")
	ldi	SysValueCopy,2
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,230
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable4<<1)
	ldi	SysReadA_H,high(StringTable4<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 2, 246, "Y:")
	ldi	SysValueCopy,2
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,246
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable5<<1)
	ldi	SysReadA_H,high(StringTable5<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 120, 214, "GLCD Size")
	ldi	SysValueCopy,120
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,214
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable8<<1)
	ldi	SysReadA_H,high(StringTable8<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 120, 230, "X:" + Str( Current_GLCD_WIDTH ) )
	ldi	SysValueCopy,120
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,230
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_WIDTH
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_WIDTH_H
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable4<<1)
	ldi	SysReadA_H,high(StringTable4<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	rcall	SysCopyStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM2)
	ldi	SysStringA_H,high(SYSSTRINGPARAM2)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 120, 246, "Y:" + Str( Current_GLCD_HEIGHT ) )
	ldi	SysValueCopy,120
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,246
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_HEIGHT
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_HEIGHT_H
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable5<<1)
	ldi	SysReadA_H,high(StringTable5<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	rcall	SysCopyStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM2)
	ldi	SysStringA_H,high(SYSSTRINGPARAM2)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDfntDefaultsize = 1
	ldi	SysValueCopy,1
	sts	GLCDFNTDEFAULTSIZE,SysValueCopy
;GLCDPrint ( 2, Current_GLCD_HEIGHT-17, "v0.9b")
	ldi	SysValueCopy,2
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	lds	SysTemp3,CURRENT_GLCD_HEIGHT
	ldi	SysTemp4,17
	sub	SysTemp3,SysTemp4
	sts	PRINTLOCY,SysTemp3
	lds	SysTemp3,CURRENT_GLCD_HEIGHT_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	PRINTLOCY_H,SysTemp3
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable9<<1)
	ldi	SysReadA_H,high(StringTable9<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDfntDefaultsize = 2
	ldi	SysValueCopy,2
	sts	GLCDFNTDEFAULTSIZE,SysValueCopy
;filledbox Current_GLCD_WIDTH, 0, Current_GLCD_WIDTH-10, 10, TFT_RED
	lds	SysValueCopy,CURRENT_GLCD_WIDTH
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,CURRENT_GLCD_WIDTH_H
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1,SysValueCopy
	sts	LINEY1_H,SysValueCopy
	lds	SysTemp3,CURRENT_GLCD_WIDTH
	ldi	SysTemp4,10
	sub	SysTemp3,SysTemp4
	sts	LINEX2,SysTemp3
	lds	SysTemp3,CURRENT_GLCD_WIDTH_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	LINEX2_H,SysTemp3
	ldi	SysValueCopy,10
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,248
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDBOX_ILI9486L
;Dim oldGLCDBackground as word
;oldGLCDBackground = GLCDBackground
	lds	SysValueCopy,GLCDBACKGROUND
	sts	OLDGLCDBACKGROUND,SysValueCopy
	lds	SysValueCopy,GLCDBACKGROUND_H
	sts	OLDGLCDBACKGROUND_H,SysValueCopy
;GLCDBackground = TFT_WHITE
	ldi	SysValueCopy,255
	sts	GLCDBACKGROUND,SysValueCopy
	sts	GLCDBACKGROUND_H,SysValueCopy
;GLCDPrint ( Current_GLCD_WIDTH-58, Current_GLCD_HEIGHT-18, "Clear", TFT_BLACK )
	lds	SysTemp3,CURRENT_GLCD_WIDTH
	ldi	SysTemp4,58
	sub	SysTemp3,SysTemp4
	sts	PRINTLOCX,SysTemp3
	lds	SysTemp3,CURRENT_GLCD_WIDTH_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	PRINTLOCX_H,SysTemp3
	lds	SysTemp3,CURRENT_GLCD_HEIGHT
	ldi	SysTemp4,18
	sub	SysTemp3,SysTemp4
	sts	PRINTLOCY,SysTemp3
	lds	SysTemp3,CURRENT_GLCD_HEIGHT_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	PRINTLOCY_H,SysTemp3
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR,SysValueCopy
	sts	LINECOLOUR_H,SysValueCopy
	call	GLCDPRINT5
;GLCDBackground = oldGLCDBackground
	lds	SysValueCopy,OLDGLCDBACKGROUND
	sts	GLCDBACKGROUND,SysValueCopy
	lds	SysValueCopy,OLDGLCDBACKGROUND_H
	sts	GLCDBACKGROUND_H,SysValueCopy
;------ Version Control - optional
;Include the GCBVersionNumber.cnt to increment versionString and create the build time string called GCBBuildTimeStr.
;versionString a string is created automatically.
;GCBBuildTimeStr is a string that is also created automatically.
;use "GCBVersionNumber.cnt" as this will create a local copy of the versionString tracker.
;if you use <GCBVersionNumber.cnt> this is a system wide versionString tracker.
;dim versionString as string * 40
;versionString = "Build: "+GCBBuildStr
	call	FN_GCBBUILDSTR
	ldi	SysStringB,low(VERSIONSTRING)
	ldi	SysStringB_H,high(VERSIONSTRING)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable12<<1)
	ldi	SysReadA_H,high(StringTable12<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(GCBBUILDSTR)
	ldi	SysStringA_H,high(GCBBUILDSTR)
	rcall	SysCopyStringPart
	ldi	SysStringA,low(VERSIONSTRING)
	ldi	SysStringA_H,high(VERSIONSTRING)
	st	X, SysStringLength
;versionString = versionString + "@"+GCBBuildTimeStr
	call	FN_GCBBUILDTIMESTR
	ldi	SysStringB,low(VERSIONSTRING)
	ldi	SysStringB_H,high(VERSIONSTRING)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(VERSIONSTRING)
	ldi	SysStringA_H,high(VERSIONSTRING)
	rcall	SysCopyStringPart
	ldi	SysReadA,low(StringTable13<<1)
	ldi	SysReadA_H,high(StringTable13<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(GCBBUILDTIMESTR)
	ldi	SysStringA_H,high(GCBBUILDTIMESTR)
	rcall	SysCopyStringPart
	ldi	SysStringA,low(VERSIONSTRING)
	ldi	SysStringA_H,high(VERSIONSTRING)
	st	X, SysStringLength
;GLCDfntDefaultsize = 1
	ldi	SysValueCopy,1
	sts	GLCDFNTDEFAULTSIZE,SysValueCopy
;GLCDPrint ( 2, Current_GLCD_HEIGHT-10, versionString)
	ldi	SysValueCopy,2
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	lds	SysTemp3,CURRENT_GLCD_HEIGHT
	ldi	SysTemp4,10
	sub	SysTemp3,SysTemp4
	sts	PRINTLOCY,SysTemp3
	lds	SysTemp3,CURRENT_GLCD_HEIGHT_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	sts	PRINTLOCY_H,SysTemp3
	ldi	SysValueCopy,low(VERSIONSTRING)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(VERSIONSTRING)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDfntDefaultsize = 2
	ldi	SysValueCopy,2
	sts	GLCDFNTDEFAULTSIZE,SysValueCopy
;------ End of Version Control - optional
	ret

;********************************************************************************

SENDCOMMAND_ILI9486L:
;set ILI9486L_CS OFF;
	cbi	PORTB,2
;set ILI9486L_DC OFF;
	cbi	PORTB,0
;SPITransfer  ILI9486LSendByte,  ILI9486LTempOut
	lds	SysValueCopy,ILI9486LSENDBYTE
	sts	SPITXDATA,SysValueCopy
	call	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	ILI9486LTEMPOUT,SysValueCopy
;set ILI9486L_CS ON;
	sbi	PORTB,2
;exit sub
	ret
	ret

;********************************************************************************

SENDDATA_ILI9486L:
;set ILI9486L_CS OFF;
	cbi	PORTB,2
;set ILI9486L_DC ON;
	sbi	PORTB,0
;SPITransfer  ILI9486LSendByte,  ILI9486LTempOut
	lds	SysValueCopy,ILI9486LSENDBYTE
	sts	SPITXDATA,SysValueCopy
	call	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	ILI9486LTEMPOUT,SysValueCopy
;set ILI9486L_CS ON;
	sbi	PORTB,2
;exit sub
	ret
	ret

;********************************************************************************

SENDDATA_XPT2046:
;SPITransfer  XPT2046SendByte,  XPT2046TempOut
	lds	SysValueCopy,XPT2046SENDBYTE
	sts	SPITXDATA,SysValueCopy
	call	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	XPT2046TEMPOUT,SysValueCopy
	ret

;********************************************************************************

SENDWORD_ILI9486L:
;set ILI9486L_CS OFF;
	cbi	PORTB,2
;set ILI9486L_DC ON;
	sbi	PORTB,0
;SPITransfer  ILI9486LSendWord_H,  ILI9486LTempOut
	lds	SysValueCopy,ILI9486LSENDWORD_H
	sts	SPITXDATA,SysValueCopy
	call	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	ILI9486LTEMPOUT,SysValueCopy
;SPITransfer  ILI9486LSendWord,  ILI9486LTempOut
	lds	SysValueCopy,ILI9486LSENDWORD
	sts	SPITXDATA,SysValueCopy
	call	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	ILI9486LTEMPOUT,SysValueCopy
;set ILI9486L_CS ON;
	sbi	PORTB,2
;exit sub
	ret
	ret

;********************************************************************************

SETADDRESSWINDOW_ILI9486L:
;SendCommand_ILI9486L(ILI9486L_CASET)  'Column addr set
	ldi	SysValueCopy,42
	sts	ILI9486LSENDBYTE,SysValueCopy
	rcall	SENDCOMMAND_ILI9486L
;SendData_ILI9486L _x1_H
	lds	SysValueCopy,_X1_H
	sts	ILI9486LSENDBYTE,SysValueCopy
	rcall	SENDDATA_ILI9486L
;SendData_ILI9486L _x1
	lds	SysValueCopy,_X1
	sts	ILI9486LSENDBYTE,SysValueCopy
	rcall	SENDDATA_ILI9486L
;SendData_ILI9486L _x2_H
	lds	SysValueCopy,_X2_H
	sts	ILI9486LSENDBYTE,SysValueCopy
	rcall	SENDDATA_ILI9486L
;SendData_ILI9486L _x2
	lds	SysValueCopy,_X2
	sts	ILI9486LSENDBYTE,SysValueCopy
	rcall	SENDDATA_ILI9486L
;SendCommand_ILI9486L(ILI9486L_PASET)  'Row addr set
	ldi	SysValueCopy,43
	sts	ILI9486LSENDBYTE,SysValueCopy
	rcall	SENDCOMMAND_ILI9486L
;SendData_ILI9486L _y1_H
	lds	SysValueCopy,_Y1_H
	sts	ILI9486LSENDBYTE,SysValueCopy
	rcall	SENDDATA_ILI9486L
;SendData_ILI9486L _y1
	lds	SysValueCopy,_Y1
	sts	ILI9486LSENDBYTE,SysValueCopy
	rcall	SENDDATA_ILI9486L
;SendData_ILI9486L _y2_H
	lds	SysValueCopy,_Y2_H
	sts	ILI9486LSENDBYTE,SysValueCopy
	rcall	SENDDATA_ILI9486L
;SendData_ILI9486L _y2
	lds	SysValueCopy,_Y2
	sts	ILI9486LSENDBYTE,SysValueCopy
	rcall	SENDDATA_ILI9486L
;SendCommand_ILI9486L(ILI9486L_RAMWR)  'write to RAM
	ldi	SysValueCopy,44
	sts	ILI9486LSENDBYTE,SysValueCopy
	rjmp	SENDCOMMAND_ILI9486L

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:WORD:WORD:
SETCALIBATION_XPT204637:
;this simply set the variables
	ret

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SPIMODE516:
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
	rjmp	ENDIF47
;Set SPCR.CPHA On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<CPHA
	out	SPCR,SysValueCopy
;End If
ENDIF47:
;Set SPCR.CPOL Off
	in	SysValueCopy,SPCR
	cbr	SysValueCopy,1<<CPOL
	out	SPCR,SysValueCopy
;If SPIClockMode.1 = On Then
	lds	SysBitTest,SPICLOCKMODE
	sbrs	SysBitTest,1
	rjmp	ENDIF48
;Set SPCR.CPOL On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<CPOL
	out	SPCR,SysValueCopy
;End If
ENDIF48:
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
;Case MasterFast
SysSelect4Case1:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,13
	brne	SysSelect4Case2
;Set SPCR.MSTR On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Case Master
	rjmp	SysSelectEnd4
SysSelect4Case2:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,12
	brne	SysSelect4Case3
;Set SPCR.MSTR On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Set SPCR.SPR0 On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<SPR0
	out	SPCR,SysValueCopy
;Case MasterSlow
	rjmp	SysSelectEnd4
SysSelect4Case3:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,11
	brne	SysSelectEnd4
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
SysSelectEnd4:
;Enable SPI
;Set SPCR.SPE On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<SPE
	out	SPCR,SysValueCopy
	ret

;********************************************************************************

FN_STR:
;SysCharCount = 0
	ldi	SysValueCopy,0
	sts	SYSCHARCOUNT,SysValueCopy
;Dim SysCalcTempX As Word
;Ten Thousands
;IF SysValTemp >= 10000 then
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,16
	ldi	SysWORDTempB_H,39
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF50
;SysStrData = SysValTemp / 10000
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,16
	ldi	SysWORDTempB_H,39
	rcall	SysDivSub16
	sts	SYSSTRDATA,SysWORDTempA
;SysValTemp = SysCalcTempX
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
;SysCharCount += 1
	lds	SysTemp3,SYSCHARCOUNT
	inc	SysTemp3
	sts	SYSCHARCOUNT,SysTemp3
;Str(SysCharCount) = SysStrData + 48
	ldi	SysTemp4,low(STR)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(STR)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysTemp3,SYSSTRDATA
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	st	X,SysTemp3
;Goto SysValThousands
	rjmp	SYSVALTHOUSANDS
;End If
ENDIF50:
;Thousands
;IF SysValTemp >= 1000 then
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,232
	ldi	SysWORDTempB_H,3
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF51
SYSVALTHOUSANDS:
;SysStrData = SysValTemp / 1000
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,232
	ldi	SysWORDTempB_H,3
	rcall	SysDivSub16
	sts	SYSSTRDATA,SysWORDTempA
;SysValTemp = SysCalcTempX
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
;SysCharCount += 1
	lds	SysTemp3,SYSCHARCOUNT
	inc	SysTemp3
	sts	SYSCHARCOUNT,SysTemp3
;Str(SysCharCount) = SysStrData + 48
	ldi	SysTemp4,low(STR)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(STR)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysTemp3,SYSSTRDATA
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	st	X,SysTemp3
;Goto SysValHundreds
	rjmp	SYSVALHUNDREDS
;End If
ENDIF51:
;Hundreds
;IF SysValTemp >= 100 then
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF52
SYSVALHUNDREDS:
;SysStrData = SysValTemp / 100
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	sts	SYSSTRDATA,SysWORDTempA
;SysValTemp = SysCalcTempX
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
;SysCharCount += 1
	lds	SysTemp3,SYSCHARCOUNT
	inc	SysTemp3
	sts	SYSCHARCOUNT,SysTemp3
;Str(SysCharCount) = SysStrData + 48
	ldi	SysTemp4,low(STR)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(STR)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysTemp3,SYSSTRDATA
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	st	X,SysTemp3
;Goto SysValTens
	rjmp	SYSVALTENS
;End If
ENDIF52:
;Tens
;IF SysValTemp >= 10 Then
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF53
SYSVALTENS:
;SysStrData = SysValTemp / 10
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	sts	SYSSTRDATA,SysWORDTempA
;SysValTemp = SysCalcTempX
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
;SysCharCount += 1
	lds	SysTemp3,SYSCHARCOUNT
	inc	SysTemp3
	sts	SYSCHARCOUNT,SysTemp3
;Str(SysCharCount) = SysStrData + 48
	ldi	SysTemp4,low(STR)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(STR)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysTemp3,SYSSTRDATA
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	st	X,SysTemp3
;End If
ENDIF53:
;Ones
;SysCharCount += 1
	lds	SysTemp3,SYSCHARCOUNT
	inc	SysTemp3
	sts	SYSCHARCOUNT,SysTemp3
;Str(SysCharCount) = SysValTemp + 48
	ldi	SysTemp4,low(STR)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(STR)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysTemp3,SYSVALTEMP
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	st	X,SysTemp3
;SysValTemp = SysCalcTempX
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
;Str(0) = SysCharCount
	lds	SysValueCopy,SYSCHARCOUNT
	sts	SYSSTR_0,SysValueCopy
	ret

;********************************************************************************

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

SYSCOMPEQUAL32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clr SysByteTempX
	clr	SYSBYTETEMPX
;cp SysLongTempA, SysLongTempB
	cp	SYSLONGTEMPA, SYSLONGTEMPB
;brne SCE32False
	brne	SCE32FALSE
;cp SysLongTempA_H, SysLongTempB_H
	cp	SYSLONGTEMPA_H, SYSLONGTEMPB_H
;brne SCE32False
	brne	SCE32FALSE
;cp SysLongTempA_U, SysLongTempB_U
	cp	SYSLONGTEMPA_U, SYSLONGTEMPB_U
;brne SCE32False
	brne	SCE32FALSE
;cp SysLongTempA_E, SysLongTempB_E
	cp	SYSLONGTEMPA_E, SYSLONGTEMPB_E
;brne SCE32False
	brne	SCE32FALSE
;com SysByteTempX
	com	SYSBYTETEMPX
SCE32FALSE:
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

SYSCOMPLESSTHAN32:
;clr SysByteTempX
	clr	SYSBYTETEMPX
;Test Exp, exit false if more
;cp SysLongTempB_E,SysLongTempA_E
	cp	SYSLONGTEMPB_E,SYSLONGTEMPA_E
;brlo SCLT32False
	brlo	SCLT32FALSE
;Test Exp, exit true not equal
;brne SCLT32True
	brne	SCLT32TRUE
;Test Upper, exit false if more
;cp SysLongTempB_U,SysLongTempA_U
	cp	SYSLONGTEMPB_U,SYSLONGTEMPA_U
;brlo SCLT32False
	brlo	SCLT32FALSE
;Test Upper, exit true not equal
;brne SCLT32True
	brne	SCLT32TRUE
;Test High, exit false if more
;cp SysLongTempB_H,SysLongTempA_H
	cp	SYSLONGTEMPB_H,SYSLONGTEMPA_H
;brlo SCLT32False
	brlo	SCLT32FALSE
;Test high, exit true not equal
;brne SCLT32True
	brne	SCLT32TRUE
;Test Low, exit if more or equal
;cp SysLongTempA,SysLongTempB
	cp	SYSLONGTEMPA,SYSLONGTEMPB
;brlo SCLT32True
	brlo	SCLT32TRUE
;ret
	ret
SCLT32TRUE:
;com SysByteTempX
	com	SYSBYTETEMPX
SCLT32FALSE:
	ret

;********************************************************************************

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
	rjmp	ELSE44_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	sbrc	SYSINTEGERTEMPB_H,7
	rjmp	ENDIF45
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	mov	SysTemp3,SYSBYTETEMPX
	com	SysTemp3
	mov	SYSBYTETEMPX,SysTemp3
;Exit Sub
	ret
;End If
ENDIF45:
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	mov	SysTemp2,SYSINTEGERTEMPA
	mov	SysTemp2_H,SYSINTEGERTEMPA_H
	com	SysTemp2
	com	SysTemp2_H
	inc	SysTemp2
	brne	PC + 2
	inc	SysTemp2_H
	mov	SYSDIVMULTA,SysTemp2
	mov	SYSDIVMULTA_H,SysTemp2_H
;SysIntegerTempA = -SysIntegerTempB
	mov	SysTemp2,SYSINTEGERTEMPB
	mov	SysTemp2_H,SYSINTEGERTEMPB_H
	com	SysTemp2
	com	SysTemp2_H
	inc	SysTemp2
	brne	PC + 2
	inc	SysTemp2_H
	mov	SYSINTEGERTEMPA,SysTemp2
	mov	SYSINTEGERTEMPA_H,SysTemp2_H
;SysIntegerTempB = SysDivMultA
	mov	SYSINTEGERTEMPB,SYSDIVMULTA
	mov	SYSINTEGERTEMPB_H,SYSDIVMULTA_H
;+A
;Else
	rjmp	ENDIF44
ELSE44_1:
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	sbrc	SYSINTEGERTEMPB_H,7
;Exit Sub
	ret
;End If
ENDIF46:
;End If
ENDIF44:
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
	rjmp	ENDIF40
;SysWordTempA = 0
	ldi	SYSWORDTEMPA,0
	ldi	SYSWORDTEMPA_H,0
;exit sub
	ret
;end if
ENDIF40:
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
	mov	SysTemp3,SYSDIVMULTX
	sub	SysTemp3,SYSDIVMULTB
	mov	SYSDIVMULTX,SysTemp3
	mov	SysTemp3,SYSDIVMULTX_H
	sbc	SysTemp3,SYSDIVMULTB_H
	mov	SYSDIVMULTX_H,SysTemp3
;Set SysDivMultA.0 On
	sbr	 SYSDIVMULTA,1<<0
;If C On Then
	brbc	C,ENDIF41
;Set SysDivMultA.0 Off
	cbr	 SYSDIVMULTA,1<<0
;SysDivMultX = SysDivMultX + SysDivMultB
	mov	SysTemp3,SYSDIVMULTX
	add	SysTemp3,SYSDIVMULTB
	mov	SYSDIVMULTX,SysTemp3
	mov	SysTemp3,SYSDIVMULTX_H
	adc	SysTemp3,SYSDIVMULTB_H
	mov	SYSDIVMULTX_H,SysTemp3
;End If
ENDIF41:
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

SYSDIVSUB32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;#ifdef PIC
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;#endif
;SysLongDivMultA = SysLongTempA
	sts	SYSLONGDIVMULTA,SYSLONGTEMPA
	sts	SYSLONGDIVMULTA_H,SYSLONGTEMPA_H
	sts	SYSLONGDIVMULTA_U,SYSLONGTEMPA_U
	sts	SYSLONGDIVMULTA_E,SYSLONGTEMPA_E
;SysLongDivMultB = SysLongTempB
	sts	SYSLONGDIVMULTB,SYSLONGTEMPB
	sts	SYSLONGDIVMULTB_H,SYSLONGTEMPB_H
	sts	SYSLONGDIVMULTB_U,SYSLONGTEMPB_U
	sts	SYSLONGDIVMULTB_E,SYSLONGTEMPB_E
;SysLongDivMultX = 0
	ldi	SysValueCopy,0
	sts	SYSLONGDIVMULTX,SysValueCopy
	sts	SYSLONGDIVMULTX_H,SysValueCopy
	sts	SYSLONGDIVMULTX_U,SysValueCopy
	sts	SYSLONGDIVMULTX_E,SysValueCopy
;Avoid division by zero
;if SysLongDivMultB = 0 then
	lds	SysLONGTempA,SYSLONGDIVMULTB
	lds	SysLONGTempA_H,SYSLONGDIVMULTB_H
	lds	SysLONGTempA_U,SYSLONGDIVMULTB_U
	lds	SysLONGTempA_E,SYSLONGDIVMULTB_E
	ldi	SysLONGTempB,0
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	rcall	SysCompEqual32
	sbrs	SysByteTempX,0
	rjmp	ENDIF42
;SysLongTempA = 0
	ldi	SYSLONGTEMPA,0
	ldi	SYSLONGTEMPA_H,0
	ldi	SYSLONGTEMPA_U,0
	ldi	SYSLONGTEMPA_E,0
;exit sub
	ret
;end if
ENDIF42:
;Main calc routine
;SysDivLoop = 32
	ldi	SysValueCopy,32
	mov	SYSDIVLOOP,SysValueCopy
SYSDIV32START:
;set C off
	clc
;Rotate SysLongDivMultA Left
	lds	SysValueCopy,SYSLONGDIVMULTA
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_H
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_H,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_U
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_U,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_E
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_E,SysValueCopy
;Rotate SysLongDivMultX Left
	lds	SysValueCopy,SYSLONGDIVMULTX
	rol	SysValueCopy
	sts	SYSLONGDIVMULTX,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTX_H
	rol	SysValueCopy
	sts	SYSLONGDIVMULTX_H,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTX_U
	rol	SysValueCopy
	sts	SYSLONGDIVMULTX_U,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTX_E
	rol	SysValueCopy
	sts	SYSLONGDIVMULTX_E,SysValueCopy
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	lds	SysTemp3,SYSLONGDIVMULTX
	lds	SysTemp1,SYSLONGDIVMULTB
	sub	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_H
	lds	SysTemp1,SYSLONGDIVMULTB_H
	sbc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_H,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_U
	lds	SysTemp1,SYSLONGDIVMULTB_U
	sbc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_U,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_E
	lds	SysTemp1,SYSLONGDIVMULTB_E
	sbc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_E,SysTemp3
;Set SysLongDivMultA.0 On
	lds	SysValueCopy,SYSLONGDIVMULTA
	sbr	SysValueCopy,1<<0
	sts	SYSLONGDIVMULTA,SysValueCopy
;If C On Then
	brbc	C,ENDIF43
;Set SysLongDivMultA.0 Off
	lds	SysValueCopy,SYSLONGDIVMULTA
	cbr	SysValueCopy,1<<0
	sts	SYSLONGDIVMULTA,SysValueCopy
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	lds	SysTemp3,SYSLONGDIVMULTX
	lds	SysTemp1,SYSLONGDIVMULTB
	add	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_H
	lds	SysTemp1,SYSLONGDIVMULTB_H
	adc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_H,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_U
	lds	SysTemp1,SYSLONGDIVMULTB_U
	adc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_U,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_E
	lds	SysTemp1,SYSLONGDIVMULTB_E
	adc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_E,SysTemp3
;End If
ENDIF43:
;dec SysDivLoop
	dec	SYSDIVLOOP
;breq SysDiv32End
	breq	SYSDIV32END
;goto SysDiv32Start
	rjmp	SYSDIV32START
SYSDIV32END:
;SysLongTempA = SysLongDivMultA
	lds	SYSLONGTEMPA,SYSLONGDIVMULTA
	lds	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	lds	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	lds	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongTempX = SysLongDivMultX
	lds	SYSLONGTEMPX,SYSLONGDIVMULTX
	lds	SYSLONGTEMPX_H,SYSLONGDIVMULTX_H
	lds	SYSLONGTEMPX_U,SYSLONGDIVMULTX_U
	lds	SYSLONGTEMPX_E,SYSLONGDIVMULTX_E
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

SYSMULTSUB32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;SysLongDivMultA = SysLongTempA
	sts	SYSLONGDIVMULTA,SYSLONGTEMPA
	sts	SYSLONGDIVMULTA_H,SYSLONGTEMPA_H
	sts	SYSLONGDIVMULTA_U,SYSLONGTEMPA_U
	sts	SYSLONGDIVMULTA_E,SYSLONGTEMPA_E
;SysLongDivMultB = SysLongTempB
	sts	SYSLONGDIVMULTB,SYSLONGTEMPB
	sts	SYSLONGDIVMULTB_H,SYSLONGTEMPB_H
	sts	SYSLONGDIVMULTB_U,SYSLONGTEMPB_U
	sts	SYSLONGDIVMULTB_E,SYSLONGTEMPB_E
;SysLongDivMultX = 0
	ldi	SysValueCopy,0
	sts	SYSLONGDIVMULTX,SysValueCopy
	sts	SYSLONGDIVMULTX_H,SysValueCopy
	sts	SYSLONGDIVMULTX_U,SysValueCopy
	sts	SYSLONGDIVMULTX_E,SysValueCopy
MUL32LOOP:
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	lds	SysBitTest,SYSLONGDIVMULTB
	sbrs	SysBitTest,0
	rjmp	ENDIF38
	lds	SysTemp3,SYSLONGDIVMULTX
	lds	SysTemp1,SYSLONGDIVMULTA
	add	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_H
	lds	SysTemp1,SYSLONGDIVMULTA_H
	adc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_H,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_U
	lds	SysTemp1,SYSLONGDIVMULTA_U
	adc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_U,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_E
	lds	SysTemp1,SYSLONGDIVMULTA_E
	adc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_E,SysTemp3
ENDIF38:
;Set C Off
	clc
;rotate SysLongDivMultB right
	lds	SysValueCopy,SYSLONGDIVMULTB_E
	ror	SysValueCopy
	sts	SYSLONGDIVMULTB_E,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTB_U
	ror	SysValueCopy
	sts	SYSLONGDIVMULTB_U,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTB_H
	ror	SysValueCopy
	sts	SYSLONGDIVMULTB_H,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTB
	ror	SysValueCopy
	sts	SYSLONGDIVMULTB,SysValueCopy
;Set C Off
	clc
;rotate SysLongDivMultA left
	lds	SysValueCopy,SYSLONGDIVMULTA
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_H
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_H,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_U
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_U,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_E
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_E,SysValueCopy
;if SysLongDivMultB > 0 then goto MUL32LOOP
	lds	SysLONGTempB,SYSLONGDIVMULTB
	lds	SysLONGTempB_H,SYSLONGDIVMULTB_H
	lds	SysLONGTempB_U,SYSLONGDIVMULTB_U
	lds	SysLONGTempB_E,SYSLONGDIVMULTB_E
	ldi	SysLONGTempA,0
	ldi	SysLONGTempA_H,0
	ldi	SysLONGTempA_U,0
	ldi	SysLONGTempA_E,0
	rcall	SysCompLessThan32
	sbrc	SysByteTempX,0
	rjmp	MUL32LOOP
ENDIF39:
;SysLongTempX = SysLongDivMultX
	lds	SYSLONGTEMPX,SYSLONGDIVMULTX
	lds	SYSLONGTEMPX_H,SYSLONGDIVMULTX_H
	lds	SYSLONGTEMPX_U,SYSLONGDIVMULTX_U
	lds	SYSLONGTEMPX_E,SYSLONGDIVMULTX_E
	ret

;********************************************************************************

SYSMULTSUBINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	mov	SysTemp3,SYSINTEGERTEMPB_H
	eor	SysTemp3,SYSINTEGERTEMPA_H
	mov	SYSSIGNBYTE,SysTemp3
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	sbrs	SYSINTEGERTEMPA_H,7
	rjmp	ENDIF35
	mov	SysTemp2,SYSINTEGERTEMPA
	mov	SysTemp2_H,SYSINTEGERTEMPA_H
	com	SysTemp2
	com	SysTemp2_H
	inc	SysTemp2
	brne	PC + 2
	inc	SysTemp2_H
	mov	SYSINTEGERTEMPA,SysTemp2
	mov	SYSINTEGERTEMPA_H,SysTemp2_H
ENDIF35:
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	sbrs	SYSINTEGERTEMPB_H,7
	rjmp	ENDIF36
	mov	SysTemp2,SYSINTEGERTEMPB
	mov	SysTemp2_H,SYSINTEGERTEMPB_H
	com	SysTemp2
	com	SysTemp2_H
	inc	SysTemp2
	brne	PC + 2
	inc	SysTemp2_H
	mov	SYSINTEGERTEMPB,SysTemp2
	mov	SYSINTEGERTEMPB_H,SysTemp2_H
ENDIF36:
;Call word multiply routine
;SysMultSub16
	rcall	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	sbrs	SYSSIGNBYTE,7
	rjmp	ENDIF37
	mov	SysTemp2,SYSINTEGERTEMPX
	mov	SysTemp2_H,SYSINTEGERTEMPX_H
	com	SysTemp2
	com	SysTemp2_H
	inc	SysTemp2
	brne	PC + 2
	inc	SysTemp2_H
	mov	SYSINTEGERTEMPX,SysTemp2
	mov	SYSINTEGERTEMPX_H,SysTemp2_H
ENDIF37:
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
.DB	26,88,80,84,50,48,52,54,32,100,101,109,111,110,115,116,114,97,116,105,111,110,32,50,48,49,56,0


StringTable2:
.DB	19,68,121,110,97,109,105,99,32,67,97,108,105,98,114,97,116,105,111,110


StringTable3:
.DB	16,82,97,119,32,32,32,32,77,105,110,32,32,32,77,97,120,0


StringTable4:
.DB	2,88,58,0


StringTable5:
.DB	2,89,58,0


StringTable6:
.DB	19,67,117,114,114,101,110,116,32,67,97,108,105,98,114,97,116,105,111,110


StringTable7:
.DB	6,83,99,97,108,101,100,0


StringTable8:
.DB	9,71,76,67,68,32,83,105,122,101


StringTable9:
.DB	5,118,48,46,57,98


StringTable10:
.DB	5,67,108,101,97,114


StringTable12:
.DB	7,66,117,105,108,100,58,32


StringTable13:
.DB	1,64


StringTable36:
.DB	2,52,48,0


StringTable37:
.DB	19,49,50,45,51,48,45,50,48,49,56,32,49,54,58,48,48,58,53,53


StringTable50:
.DB	1,32


StringTable74:
.DB	0,0


;********************************************************************************

TRANSFERDATA_XPT2046:
;Dim XPT2046OutByte as byte
;XPT2046OutByte = 0
	ldi	SysValueCopy,0
	sts	XPT2046OUTBYTE,SysValueCopy
;SPITransfer  XPT2046SendByte,  XPT2046OutByte
	lds	SysValueCopy,XPT2046SENDBYTE
	sts	SPITXDATA,SysValueCopy
	call	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	XPT2046OUTBYTE,SysValueCopy
;wait 250 us
	ret

;********************************************************************************


