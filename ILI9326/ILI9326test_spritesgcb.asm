;Program compiled by Great Cow BASIC (0.98.<<>> 2018-09-23)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1789, r=DEC
#include <P16F1789.inc>
 __CONFIG _CONFIG1, _MCLRE_ON & _WDTE_OFF & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_OFF

;********************************************************************************

;Set aside memory locations for variables
CHARCODE	EQU	32
CHARCOL	EQU	33
CHARCOL_H	EQU	34
CHARLOCX	EQU	35
CHARLOCX_H	EQU	36
CHARLOCY	EQU	37
CHARLOCY_H	EQU	38
COLSPERFONT	EQU	39
CURRCHARCOL	EQU	40
CURRCHARROW	EQU	41
CURRCHARVAL	EQU	42
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
DX	EQU	10206
DY	EQU	10188
FRAME	EQU	43
FRAME_COUNT	EQU	44
GLCDBACKGROUND	EQU	45
GLCDBACKGROUND_H	EQU	46
GLCDCOLOUR	EQU	47
GLCDCOLOUR_H	EQU	48
GLCDDEVICEHEIGHT	EQU	49
GLCDDEVICEHEIGHT_H	EQU	50
GLCDDEVICEWIDTH	EQU	51
GLCDDEVICEWIDTH_H	EQU	52
GLCDFNTDEFAULTSIZE	EQU	53
GLCDFONTWIDTH	EQU	54
GLCDFOREGROUND	EQU	55
GLCDFOREGROUND_H	EQU	56
GLCDPRINTLEN	EQU	57
GLCDPRINTLOC	EQU	58
GLCDPRINTLOC_H	EQU	59
GLCDPRINT_STRING_COUNTER	EQU	60
GLCDTEMP	EQU	61
GLCDTEMP_H	EQU	62
GLCDX	EQU	63
GLCDX_H	EQU	64
GLCDY	EQU	65
GLCDY_H	EQU	66
GLCD_YORDINATE	EQU	67
GLCD_YORDINATE_H	EQU	68
ILI9326_ADDRESSTYPE	EQU	69
ILI9326_GLCD_HEIGHT_ADJ	EQU	70
ILI9326_GLCD_HEIGHT_ADJ_H	EQU	71
ILI9326_GLCD_WIDTH_ADJ	EQU	72
ILI9326_GLCD_WIDTH_ADJ_H	EQU	73
ILI9326_SENDWORD	EQU	74
ILI9326_SENDWORD_H	EQU	75
LINECOLOUR	EQU	76
LINECOLOUR_H	EQU	77
LOCALCHARCODE	EQU	78
LOCALCHARCODE_H	EQU	79
OLDGLCDFONTWIDTH	EQU	80
OLDSPX	EQU	10170
OLDSPY	EQU	10152
PIXEL	EQU	81
PIXEL_H	EQU	82
PRINTLOCX	EQU	83
PRINTLOCX_H	EQU	84
PRINTLOCY	EQU	85
PRINTLOCY_H	EQU	86
PTR	EQU	87
PTRX	EQU	89
PTRX_H	EQU	90
PTRY	EQU	91
PTRY_H	EQU	92
PTR_H	EQU	88
ROWSPERFONT	EQU	93
SPRITEDATA_PTR	EQU	94
SPRITEDATA_PTR_H	EQU	95
SPRITE_HEIGHT	EQU	96
SPRITE_WIDTH	EQU	97
SPRITE_X	EQU	98
SPRITE_X_H	EQU	99
SPRITE_Y	EQU	100
SPRITE_Y_H	EQU	101
SPX	EQU	10134
SPY	EQU	10116
STRINGPOINTER	EQU	102
SYSARRAYTEMP1	EQU	103
SYSARRAYTEMP1_H	EQU	104
SYSARRAYTEMP2	EQU	105
SYSARRAYTEMP2_H	EQU	106
SYSARRAYTEMP3	EQU	107
SYSARRAYTEMP3_H	EQU	108
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSLCDPRINTDATAHANDLER	EQU	109
SYSLCDPRINTDATAHANDLER_H	EQU	110
SYSREPEATTEMP1	EQU	160
SYSREPEATTEMP1_H	EQU	161
SYSREPEATTEMP2	EQU	111
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSTEMP1	EQU	162
SYSTEMP1_H	EQU	163
SYSTEMP2	EQU	164
SYSTEMP2_H	EQU	165
SYSTEMP3	EQU	166
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWAITTEMPS	EQU	116
SYSWORDTEMPA	EQU	117
SYSWORDTEMPA_H	EQU	118
SYSWORDTEMPB	EQU	121
SYSWORDTEMPB_H	EQU	122
SYSWORDTEMPX	EQU	112
SYSWORDTEMPX_H	EQU	113
TEMP	EQU	167

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
SYSDX_1	EQU	3248
SYSDX_1_H	EQU	3249
SYSDX_2	EQU	3250
SYSDX_2_H	EQU	3251
SYSDX_3	EQU	3252
SYSDX_3_H	EQU	3253
SYSDX_4	EQU	3254
SYSDX_4_H	EQU	3255
SYSDX_5	EQU	3256
SYSDX_5_H	EQU	3257
SYSDX_6	EQU	3258
SYSDX_6_H	EQU	3259
SYSDX_7	EQU	3260
SYSDX_7_H	EQU	3261
SYSDX_8	EQU	3262
SYSDX_8_H	EQU	3263
SYSDY_1	EQU	3182
SYSDY_1_H	EQU	3183
SYSDY_2	EQU	3232
SYSDY_2_H	EQU	3233
SYSDY_3	EQU	3234
SYSDY_3_H	EQU	3235
SYSDY_4	EQU	3236
SYSDY_4_H	EQU	3237
SYSDY_5	EQU	3238
SYSDY_5_H	EQU	3239
SYSDY_6	EQU	3240
SYSDY_6_H	EQU	3241
SYSDY_7	EQU	3242
SYSDY_7_H	EQU	3243
SYSDY_8	EQU	3244
SYSDY_8_H	EQU	3245
SYSSPX_1	EQU	3128
SYSSPX_1_H	EQU	3129
SYSSPX_2	EQU	3130
SYSSPX_2_H	EQU	3131
SYSSPX_3	EQU	3132
SYSSPX_3_H	EQU	3133
SYSSPX_4	EQU	3134
SYSSPX_4_H	EQU	3135
SYSSPX_5	EQU	3136
SYSSPX_5_H	EQU	3137
SYSSPX_6	EQU	3138
SYSSPX_6_H	EQU	3139
SYSSPX_7	EQU	3140
SYSSPX_7_H	EQU	3141
SYSSPX_8	EQU	3142
SYSSPX_8_H	EQU	3143
SYSSPY_1	EQU	3110
SYSSPY_1_H	EQU	3111
SYSSPY_2	EQU	3112
SYSSPY_2_H	EQU	3113
SYSSPY_3	EQU	3114
SYSSPY_3_H	EQU	3115
SYSSPY_4	EQU	3116
SYSSPY_4_H	EQU	3117
SYSSPY_5	EQU	3118
SYSSPY_5_H	EQU	3119
SYSSPY_6	EQU	3120
SYSSPY_6_H	EQU	3121
SYSSPY_7	EQU	3122
SYSSPY_7_H	EQU	3123
SYSSPY_8	EQU	3124
SYSSPY_8_H	EQU	3125

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
	retfie

;********************************************************************************

;Start of program memory page 0
	ORG	5
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	INITGLCD_ILI9326
	pagesel	$

;Start of the main program
;#define GLCD_TYPE GLCD_TYPE_ILI9326
;#define GLCD_RD       porta.3        ' read command line
;#define GLCD_WR       porta.2         ' write command line
;#define GLCD_RS       porta.1         ' Command/Data line
;#define GLCD_CS       porta.0         ' Chip select line
;#define GLCD_RST      porta.5         ' Reset line
;#define GLCD_DataPort portD
;define the frame_refresh
;#define frame_refresh 3  '1 to 5 is advised
;
;now rename colours to make it easier to set up sprite data
;#define bk ILI9326_BLACK
;#define re ILI9326_RED
;#define gr ILI9326_GREEN
;#define bl ILI9326_BLUE
;#define wh ILI9326_WHITE
;#define pu ILI9326_PURPLE
;#define ye ILI9326_YELLOW
;#define cy ILI9326_CYAN
;#define dg ILI9326_D_GRAY
;#define lg ILI9326_L_GRAY
;#define si ILI9326_SILVER
;#define ma ILI9326_MAROON
;#define ol ILI9326_OLIVE
;#define li ILI9326_LIME
;#define aq ILI9326_AQUA
;#define te ILI9326_TEAL
;#define na ILI9326_NAVY
;#define fu ILI9326_FUCHSIA
;backgroung color
;#define bg bk
;#define GLCD_OLED_FONT
;GLCDfntDefaultsize = 2
	movlw	2
	movwf	GLCDFNTDEFAULTSIZE
;GLCDPrint 30,50, " Great Cow BASIC"
	movlw	30
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	50
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable1
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable1) | 128
	movwf	SysLCDPRINTDATAHandler_H
	call	GLCDPRINT5
;GLCDPrint 30,70, "   Sprite Demo"
	movlw	30
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	70
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable2
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable2) | 128
	movwf	SysLCDPRINTDATAHandler_H
	call	GLCDPRINT5
;GLCDPrint 30,90, "  ILI9326 @ 2018"
	movlw	30
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	90
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable3
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysLCDPRINTDATAHandler_H
	call	GLCDPRINT5
;Wait 6 s
	movlw	6
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;GLCDRotate Portrait
	movlw	4
	movwf	ILI9326_ADDRESSTYPE
	pagesel	GLCDROTATE_ILI9326
	call	GLCDROTATE_ILI9326
	pagesel	$
;GLCDCLS bg
	clrf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
	pagesel	GLCDCLS_ILI9326
	call	GLCDCLS_ILI9326
	pagesel	$
;
;dim sprite_height,sprite_width as byte ;height and width of sprite in pixels
;dim spritedata as byte;data to make sprite
;dim sprite_x,sprite_y as Word
;dim ptr,spritedata_ptr,pixel as word
;
;demo vars
;dim temp,frame,frame_count as byte
;dim dx(8),dy(8) as word
;dim spy(8),oldspy(8) as word
;dim spx(8),oldspx(8) as word
;set up start sprite positions and directions
;dx(1)=2:dx(2)=3:dx(3)=65536-4:dx(4)=6
	movlw	2
	banksel	SYSDX_1
	movwf	SYSDX_1
	clrf	SYSDX_1_H
	movlw	3
	movwf	SYSDX_2
	clrf	SYSDX_2_H
	movlw	252
	movwf	SYSDX_3
	movlw	255
	movwf	SYSDX_3_H
	movlw	6
	movwf	SYSDX_4
	clrf	SYSDX_4_H
;dx(5)=65536-8:dx(6)=65536-8:dx(7)=65536-8:dx(8)=65536-8
	movlw	248
	movwf	SYSDX_5
	movlw	255
	movwf	SYSDX_5_H
	movlw	248
	movwf	SYSDX_6
	movlw	255
	movwf	SYSDX_6_H
	movlw	248
	movwf	SYSDX_7
	movlw	255
	movwf	SYSDX_7_H
	movlw	248
	movwf	SYSDX_8
	movlw	255
	movwf	SYSDX_8_H
;dy(1)=65536-5:dy(2)=65536-3:dy(3)=65536-8:dy(4)=3
	movlw	251
	banksel	SYSDY_1
	movwf	SYSDY_1
	movlw	255
	movwf	SYSDY_1_H
	movlw	253
	banksel	SYSDY_2
	movwf	SYSDY_2
	movlw	255
	movwf	SYSDY_2_H
	movlw	248
	movwf	SYSDY_3
	movlw	255
	movwf	SYSDY_3_H
	movlw	3
	movwf	SYSDY_4
	clrf	SYSDY_4_H
;dy(5)=2:dy(6)=7:dy(7)=2:dy(8)=8
	movlw	2
	movwf	SYSDY_5
	clrf	SYSDY_5_H
	movlw	7
	movwf	SYSDY_6
	clrf	SYSDY_6_H
	movlw	2
	movwf	SYSDY_7
	clrf	SYSDY_7_H
	movlw	8
	movwf	SYSDY_8
	clrf	SYSDY_8_H
;
;spx(1)=30:spx(2)=100:spx(3)=150:spx(4)=50
	movlw	30
	banksel	SYSSPX_1
	movwf	SYSSPX_1
	clrf	SYSSPX_1_H
	movlw	100
	movwf	SYSSPX_2
	clrf	SYSSPX_2_H
	movlw	150
	movwf	SYSSPX_3
	clrf	SYSSPX_3_H
	movlw	50
	movwf	SYSSPX_4
	clrf	SYSSPX_4_H
;spx(5)=160:spx(6)=100:spx(7)=80:spx(8)=30
	movlw	160
	movwf	SYSSPX_5
	clrf	SYSSPX_5_H
	movlw	100
	movwf	SYSSPX_6
	clrf	SYSSPX_6_H
	movlw	80
	movwf	SYSSPX_7
	clrf	SYSSPX_7_H
	movlw	30
	movwf	SYSSPX_8
	clrf	SYSSPX_8_H
;spy(1)=20:spy(2)=20:spy(3)=16:spy(4)=50:spy(5)=60:spy(6)=40
	movlw	20
	movwf	SYSSPY_1
	clrf	SYSSPY_1_H
	movlw	20
	movwf	SYSSPY_2
	clrf	SYSSPY_2_H
	movlw	16
	movwf	SYSSPY_3
	clrf	SYSSPY_3_H
	movlw	50
	movwf	SYSSPY_4
	clrf	SYSSPY_4_H
	movlw	60
	movwf	SYSSPY_5
	clrf	SYSSPY_5_H
	movlw	40
	movwf	SYSSPY_6
	clrf	SYSSPY_6_H
;spy(5)=20:spy(6)=30:spy(7)=24:spy(8)=36
	movlw	20
	movwf	SYSSPY_5
	clrf	SYSSPY_5_H
	movlw	30
	movwf	SYSSPY_6
	clrf	SYSSPY_6_H
	movlw	24
	movwf	SYSSPY_7
	clrf	SYSSPY_7_H
	movlw	36
	movwf	SYSSPY_8
	clrf	SYSSPY_8_H
;sprite_height=16:sprite_width=16
	movlw	16
	banksel	SPRITE_HEIGHT
	movwf	SPRITE_HEIGHT
	movlw	16
	movwf	SPRITE_WIDTH
;spritedata_ptr=1
	movlw	1
	movwf	SPRITEDATA_PTR
	clrf	SPRITEDATA_PTR_H
;frame=0:frame_count=0
	clrf	FRAME
	clrf	FRAME_COUNT
;
;do ;demo moving sprite
SysDoLoop_S1
;for temp=1 to 8
	banksel	TEMP
	clrf	TEMP
SysForLoop1
	incf	TEMP,F
;if spx(temp)> (399-sprite_width) then ;check right edge
	bcf	STATUS,C
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(SPX)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(SPX)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	movf	SPRITE_WIDTH,W
	sublw	143
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	1
	movwf	SysTemp2
	movlw	0
	subwfb	SysTemp2,W
	movwf	SysTemp1_H
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	SysWORDTempB
	movf	SysArrayTemp1_H,W
	movwf	SysWORDTempB_H
	banksel	SYSTEMP1
	movf	SysTemp1,W
	movwf	SysWORDTempA
	movf	SysTemp1_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF1
;dx(temp)= 65536-dx(temp)
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(DX)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(DX)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP2
	movwf	SysArrayTemp2
	clrf	SysArrayTemp2_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp2_H
	movf	SysArrayTemp2,W
	sublw	0
	movwf	SysArrayTemp1
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	SYSARRAYTEMP2_H
	movf	SysArrayTemp2_H,W
	banksel	SYSTEMP2
	subwfb	SysTemp2,W
	banksel	SYSARRAYTEMP1_H
	movwf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(DX)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(DX)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp1_H,W
	movwf	INDF0
;end if
ENDIF1
;if spx(temp)<8 then ;check left edge
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(SPX)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(SPX)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	movf	SysArrayTemp1,W
	movwf	SysWORDTempA
	movf	SysArrayTemp1_H,W
	movwf	SysWORDTempA_H
	movlw	8
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF2
;dx(temp)= 65536-dx(temp)
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(DX)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(DX)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP2
	movwf	SysArrayTemp2
	clrf	SysArrayTemp2_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp2_H
	movf	SysArrayTemp2,W
	sublw	0
	movwf	SysArrayTemp1
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	SYSARRAYTEMP2_H
	movf	SysArrayTemp2_H,W
	banksel	SYSTEMP2
	subwfb	SysTemp2,W
	banksel	SYSARRAYTEMP1_H
	movwf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(DX)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(DX)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp1_H,W
	movwf	INDF0
;end if
ENDIF2
;if spy(temp)> (229-sprite_height) then ;check bottom edge
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(SPY)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(SPY)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	movf	SPRITE_HEIGHT,W
	sublw	229
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	SysWORDTempB
	movf	SysArrayTemp1_H,W
	movwf	SysWORDTempB_H
	banksel	SYSTEMP2
	movf	SysTemp2,W
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF3
;dy(temp)= 65536-dy(temp)
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(DY)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(DY)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP2
	movwf	SysArrayTemp2
	clrf	SysArrayTemp2_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp2_H
	movf	SysArrayTemp2,W
	sublw	0
	movwf	SysArrayTemp1
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	SYSARRAYTEMP2_H
	movf	SysArrayTemp2_H,W
	banksel	SYSTEMP2
	subwfb	SysTemp2,W
	banksel	SYSARRAYTEMP1_H
	movwf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(DY)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(DY)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp1_H,W
	movwf	INDF0
;end if
ENDIF3
;if spy(temp)<8 then ;check top edge
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(SPY)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(SPY)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	movf	SysArrayTemp1,W
	movwf	SysWORDTempA
	movf	SysArrayTemp1_H,W
	movwf	SysWORDTempA_H
	movlw	8
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF4
;dy(temp)= 65536-dy(temp)
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(DY)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(DY)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP2
	movwf	SysArrayTemp2
	clrf	SysArrayTemp2_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp2_H
	movf	SysArrayTemp2,W
	sublw	0
	movwf	SysArrayTemp1
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	SYSARRAYTEMP2_H
	movf	SysArrayTemp2_H,W
	banksel	SYSTEMP2
	subwfb	SysTemp2,W
	banksel	SYSARRAYTEMP1_H
	movwf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(DY)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(DY)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp1_H,W
	movwf	INDF0
;end if
ENDIF4
;
;oldspx(temp)=spx(temp):oldspy(temp)=spy(temp) ;get last position for erase
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(SPX)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(SPX)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP2
	movwf	SysArrayTemp2
	clrf	SysArrayTemp2_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp2_H
	movf	SysArrayTemp2,W
	movwf	SysArrayTemp1
	movf	SysArrayTemp2_H,W
	movwf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(OLDSPX)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(OLDSPX)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp1_H,W
	movwf	INDF0
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(SPY)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(SPY)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP2
	movwf	SysArrayTemp2
	clrf	SysArrayTemp2_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp2_H
	movf	SysArrayTemp2,W
	movwf	SysArrayTemp1
	movf	SysArrayTemp2_H,W
	movwf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(OLDSPY)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(OLDSPY)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp1_H,W
	movwf	INDF0
;spx(temp)=spx(temp)+dx(temp):spy(temp)=spy(temp)+dy(temp) ;get new position for draw
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(DX)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(DX)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(SPX)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(SPX)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP3
	movwf	SysArrayTemp3
	clrf	SysArrayTemp3_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp3_H
	movf	SysArrayTemp1,W
	addwf	SysArrayTemp3,W
	movwf	SysArrayTemp2
	movf	SysArrayTemp1_H,W
	addwfc	SysArrayTemp3_H,W
	movwf	SysArrayTemp2_H
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(SPX)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(SPX)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP2
	movf	SysArrayTemp2,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp2_H,W
	movwf	INDF0
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(DY)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(DY)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(SPY)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(SPY)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP3
	movwf	SysArrayTemp3
	clrf	SysArrayTemp3_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp3_H
	movf	SysArrayTemp1,W
	addwf	SysArrayTemp3,W
	movwf	SysArrayTemp2
	movf	SysArrayTemp1_H,W
	addwfc	SysArrayTemp3_H,W
	movwf	SysArrayTemp2_H
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(SPY)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(SPY)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP2
	movf	SysArrayTemp2,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp2_H,W
	movwf	INDF0
;
;if frame=0 then;which sprite to draw
	movf	FRAME,F
	btfss	STATUS, Z
	goto	ELSE5_1
;erase_sprite (oldspx(temp),oldspy(temp)) ;erase sprite at last position
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(OLDSPX)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(OLDSPX)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	movf	SysArrayTemp1,W
	movwf	SPRITE_X
	movf	SysArrayTemp1_H,W
	movwf	SPRITE_X_H
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(OLDSPY)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(OLDSPY)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	movf	SysArrayTemp1,W
	movwf	SPRITE_Y
	movf	SysArrayTemp1_H,W
	movwf	SPRITE_Y_H
	pagesel	ERASE_SPRITE
	call	ERASE_SPRITE
	pagesel	$
;1 ;pointer to sprite 1 in table
;sprite (spx(temp),spy(temp), 1 ) ;draw sprite1 at new position
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(SPX)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(SPX)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	movf	SysArrayTemp1,W
	movwf	SPRITE_X
	movf	SysArrayTemp1_H,W
	movwf	SPRITE_X_H
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(SPY)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(SPY)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	movf	SysArrayTemp1,W
	movwf	SPRITE_Y
	movf	SysArrayTemp1_H,W
	movwf	SPRITE_Y_H
	movlw	1
	movwf	SPRITEDATA_PTR
	clrf	SPRITEDATA_PTR_H
	pagesel	SPRITE
	call	SPRITE
	pagesel	$
;else
	goto	ENDIF5
ELSE5_1
;erase_sprite (oldspx(temp),oldspy(temp)) ;erase sprite at last position
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(OLDSPX)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(OLDSPX)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	movf	SysArrayTemp1,W
	movwf	SPRITE_X
	movf	SysArrayTemp1_H,W
	movwf	SPRITE_X_H
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(OLDSPY)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(OLDSPY)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	movf	SysArrayTemp1,W
	movwf	SPRITE_Y
	movf	SysArrayTemp1_H,W
	movwf	SPRITE_Y_H
	pagesel	ERASE_SPRITE
	call	ERASE_SPRITE
	pagesel	$
;257 ;pointer to sprite 2 in table
;sprite (spx(temp),spy(temp), 257) ;draw sprite2 at new position
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(SPX)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(SPX)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	movf	SysArrayTemp1,W
	movwf	SPRITE_X
	movf	SysArrayTemp1_H,W
	movwf	SPRITE_X_H
	bcf	STATUS,C
	banksel	TEMP
	rlf	TEMP,W
	movwf	SysTemp2
	movlw	low(SPY)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(SPY)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	movf	SysArrayTemp1,W
	movwf	SPRITE_Y
	movf	SysArrayTemp1_H,W
	movwf	SPRITE_Y_H
	movlw	1
	movwf	SPRITEDATA_PTR
	movwf	SPRITEDATA_PTR_H
	pagesel	SPRITE
	call	SPRITE
	pagesel	$
;end if
ENDIF5
;
;next temp
	movlw	8
	banksel	TEMP
	subwf	TEMP,W
	btfss	STATUS, C
	goto	SysForLoop1
ENDIF6
SysForLoopEnd1
;frame_count++ ;when to change spritedata_ptr
	banksel	FRAME_COUNT
	incf	FRAME_COUNT,F
;if frame_count=frame_refresh then
	movlw	3
	subwf	FRAME_COUNT,W
	btfss	STATUS, Z
	goto	ENDIF7
;frame=!frame
	comf	FRAME,F
;frame_count=0
	clrf	FRAME_COUNT
;end if
ENDIF7
;loop ;end demo
	goto	SysDoLoop_S1
SysDoLoop_E1
;
;
;
;end
	goto	BASPROGRAMEND
TABLEFOROLEDFONT2
INDEXFOROLEDEXTENDEDFONT1
DATAFOROLEDFONT1
TABLEFOROLEDEXTENDEDFONT2
;#define KS0108ReadDelay   9     ; 2 normal usage, 3 for 32 mhz!
;#define KS0108WriteDelay  1     ; 1 normal usage, 0 works
;#define KS0108ClockDelay  1     ; 1 normal usage, 0 works
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
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:
GLCDPRINT5
;Dim GLCDPrintLoc  as word
;Dim GLCDPrint_String_Counter, GLCDPrintLen as byte
;GLCDPrintLen = LCDPrintData(0)
	movf	SysLCDPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysLCDPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	GLCDPRINTLEN
;If GLCDPrintLen = 0 Then Exit Sub
	movf	GLCDPRINTLEN,F
	btfsc	STATUS, Z
	return
ENDIF16
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	movf	GLCDFONTWIDTH,W
	movwf	OLDGLCDFONTWIDTH
;GLCDPrintLoc = PrintLocX
	movf	PRINTLOCX,W
	movwf	GLCDPRINTLOC
	movf	PRINTLOCX_H,W
	movwf	GLCDPRINTLOC_H
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
	clrf	GLCDPRINT_STRING_COUNTER
	movlw	1
	subwf	GLCDPRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd6
ENDIF17
SysForLoop6
	incf	GLCDPRINT_STRING_COUNTER,F
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	movf	GLCDPRINTLOC,W
	movwf	CHARLOCX
	movf	GLCDPRINTLOC_H,W
	movwf	CHARLOCX_H
	movf	PRINTLOCY,W
	movwf	CHARLOCY
	movf	PRINTLOCY_H,W
	movwf	CHARLOCY_H
	movf	GLCDPRINT_STRING_COUNTER,W
	addwf	SysLCDPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysLCDPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	CHARCODE
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWCHAR_ILI9326
	call	GLCDDRAWCHAR_ILI9326
	pagesel	$
;GLCDPrintIncrementPixelPositionMacro
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	movf	GLCDFONTWIDTH,W
	movwf	SysBYTETempA
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempB
	call	SysMultSub
	movf	SysBYTETempX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	GLCDPRINTLOC
	addwf	GLCDPRINTLOC,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	GLCDPRINTLOC_H
	addwfc	GLCDPRINTLOC_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	banksel	GLCDFNTDEFAULTSIZE
	movf	GLCDFNTDEFAULTSIZE,W
	banksel	SYSTEMP1
	addwf	SysTemp1,W
	movwf	SysTemp2
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	SysTemp2_H
	movlw	1
	subwf	SysTemp2,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	movlw	0
	banksel	SYSTEMP2_H
	subwfb	SysTemp2_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;Next
	movf	GLCDPRINTLEN,W
	subwf	GLCDPRINT_STRING_COUNTER,W
	btfss	STATUS, C
	goto	SysForLoop6
ENDIF18
SysForLoopEnd6
;GLCDFontWidth = OldGLCDFontWidth
	movf	OLDGLCDFONTWIDTH,W
	movwf	GLCDFONTWIDTH
	return

;********************************************************************************

INITGLCD_ILI9326
;dir ILI9326_dataPort out
	banksel	TRISD
	clrf	TRISD
;dir ILI9326_GLCD_RST out
	bcf	TRISA,5
;dir ILI9326_GLCD_CS  out
	bcf	TRISA,0
;dir ILI9326_GLCD_RS  out
	bcf	TRISA,1
;dir ILI9326_GLCD_WR  out
	bcf	TRISA,2
;dir ILI9326_GLCD_RD  out
	bcf	TRISA,3
;Dim ILI9326_GLCD_WIDTH, ILI9326_GLCD_HEIGHT as word
;Dim ILI9326_GLCD_WIDTH_ADJ, ILI9326_GLCD_HEIGHT_ADJ as word
;Dim ILI9326_AddressType as byte
;Reset*********************
;Set ILI9326_GLCD_RST On
	banksel	LATA
	bsf	LATA,5
;Wait 15 ms
	movlw	15
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Set ILI9326_GLCD_RST Off
	banksel	LATA
	bcf	LATA,5
;Wait 15 ms
	movlw	15
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Set ILI9326_GLCD_RST On
	banksel	LATA
	bsf	LATA,5
;Wait 15 ms
	movlw	15
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;//*************Power On sequence ****************//
;parameters below taken from...
;*  Module for Microchip Graphics Library
;*  LCD controller driver*  ILI9326
;discharge*********************
;SendCommand_ILI9326(ILI9326_PWR_CTRL_1)
	clrf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_PWR_CTRL_3)
	movlw	2
	movwf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_PWR_CTRL_4)
	movlw	3
	movwf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;wait 200 ms 'power settings*****
	movlw	200
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ILI9326(ILI9326_PWR_CTRL_1)
	clrf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x1190)
	movlw	144
	movwf	ILI9326_SENDWORD
	movlw	17
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_PWR_CTRL_2)
	movlw	1
	movwf	ILI9326_SENDWORD
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0017)
	movlw	23
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_PWR_CTRL_3)
	movlw	2
	movwf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x01BD)
	movlw	189
	movwf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_PWR_CTRL_4)
	movlw	3
	movwf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0350)
	movlw	80
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_VCOMH)
	movlw	129
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0017)
	movlw	23
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_GRAM_ADDR_H_SET)
	clrf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_GRAM_ADDR_V_SET)
	movlw	1
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;set gamma curve**************
;SendCommand_ILI9326(0x0300)
	clrf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x0301)
	movlw	1
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0707)
	movlw	7
	movwf	ILI9326_SENDWORD
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x0302)
	movlw	2
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0606)
	movlw	6
	movwf	ILI9326_SENDWORD
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x0305)
	movlw	5
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0006)
	movlw	6
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x0306)
	movlw	6
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0A09)
	movlw	9
	movwf	ILI9326_SENDWORD
	movlw	10
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x0307)
	movlw	7
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0203)
	movlw	3
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x0308)
	movlw	8
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0005)
	movlw	5
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x0309)
	movlw	9
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0007)
	movlw	7
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x030C)
	movlw	12
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0400)
	clrf	ILI9326_SENDWORD
	movlw	4
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x030D)
	movlw	13
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x000A)
	movlw	10
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;set GRAM area**************
;SendCommand_ILI9326(ILI9326_H_ADDR_START_POS)
	movlw	16
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_H_ADDR_END_POS)
	movlw	17
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x00EF)' 240 pixels
	movlw	239
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_V_ADDR_START_POS)
	movlw	18
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_V_ADDR_END_POS)
	movlw	19
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x018F) '400 pixels
	movlw	143
	movwf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_BASE_IMG_DISP_CTRL_1)
	clrf	ILI9326_SENDWORD
	movlw	4
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x3500)
	clrf	ILI9326_SENDWORD
	movlw	53
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_BASE_IMG_DISP_CTRL_2)
	movlw	1
	movwf	ILI9326_SENDWORD
	movlw	4
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0001)
	movlw	1
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_BASE_IMG_DISP_CTRL_3)
	movlw	4
	movwf	ILI9326_SENDWORD
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_PANEL_INTF_CTRL_1) 'set screen defaults
	movlw	16
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0010)
	movlw	16
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_PANEL_INTF_CTRL_2) 'last set of commands
	movlw	17
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_FRAME_RATE_COLOR_CTRL)
	movlw	11
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_DISP_CTRL_1)
	movlw	7
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0173) 'display on
	movlw	115
	movwf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;Change to RGB TFT color and standard orientation
;SendCommand_ILI9326(ILI9326_ENTRY_MODE)
	movlw	3
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326( ILI9326_ENTRY_MODE_BGR )
	clrf	ILI9326_SENDWORD
	movlw	16
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;ILI9326_AddressType = Portrait
	movlw	4
	movwf	ILI9326_ADDRESSTYPE
;ILI9326_GLCD_WIDTH_ADJ = 0
	clrf	ILI9326_GLCD_WIDTH_ADJ
	clrf	ILI9326_GLCD_WIDTH_ADJ_H
;ILI9326_GLCD_HEIGHT_ADJ = GLCD_HEIGHT - 1
	movlw	143
	movwf	ILI9326_GLCD_HEIGHT_ADJ
	movlw	1
	movwf	ILI9326_GLCD_HEIGHT_ADJ_H
;Default Colours
;GLCDBackground = ILI9326_BLACK
	clrf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
;GLCDForeground = ILI9326_WHITE
	movlw	255
	movwf	GLCDFOREGROUND
	movwf	GLCDFOREGROUND_H
;Variables required for device
;ILI9326_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;ILI9326_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	144
	movwf	GLCDDEVICEHEIGHT
	movlw	1
	movwf	GLCDDEVICEHEIGHT_H
;GLCDFontWidth = 5
	movlw	5
	movwf	GLCDFONTWIDTH
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE
;GLCDRotate( Portrait  )
;Clear screen
;GLCDCLS ( GLCDBackground )
	pagesel	GLCDCLS_ILI9326
	goto	GLCDCLS_ILI9326

;********************************************************************************

INITSYS
;asm showdebug OSCCON type is 105 'Bit(SPLLEN) Or Bit(IRCF3) And NoBit(INTSRC) and ifdef Bit(IRCF3)
;osccon type is 105
;Same as for 8, assuming 32 MHz clock is 8 MHz x 4
;OSCCON = OSCCON AND b'10000111'
;OSCCON = OSCCON OR b'11110000'
;Set IRCF3 On
	banksel	OSCCON
	bsf	OSCCON,IRCF3
;Set IRCF2 On
	bsf	OSCCON,IRCF2
;Set IRCF1 On
	bsf	OSCCON,IRCF1
;Set IRCF0 Off
	bcf	OSCCON,IRCF0
;Set SPLLEN On
	bsf	OSCCON,SPLLEN
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	bcf	ADCON1,ADFM
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;Commence clearing any ANSEL variants in the part
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELC = 0
	clrf	ANSELC
;ANSELD = 0
	clrf	ANSELD
;ANSELE = 0
	clrf	ANSELE
;End clearing any ANSEL variants in the part
;Comparator register bits for 12F510,16F506, PIC16F1535 classes
;C2ON = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2ON
;C1ON = 0
	bcf	CM1CON0,C1ON
;Turn off all ports
;PORTA = 0
	banksel	PORTA
	clrf	PORTA
;PORTB = 0
	clrf	PORTB
;PORTC = 0
	clrf	PORTC
;PORTD = 0
	clrf	PORTD
;PORTE = 0
	clrf	PORTE
	return

;********************************************************************************

SPRITEDATA
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	251
	movwf	SysWORDTempB
	movlw	1
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableSPRITEDATA
	movwf	SysStringA
	movlw	(high TableSPRITEDATA) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableSPRITEDATA
	retlw	0
	retlw	255
	retlw	31
	retlw	31
	retlw	31
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	31
	retlw	31
	retlw	31
	retlw	255
	retlw	0
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	31
	retlw	0
	retlw	0
	retlw	31
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	0
	retlw	0
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	0
	retlw	255
	retlw	31
	retlw	0
	retlw	0
	retlw	31
	retlw	255
	retlw	0
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	255
	retlw	31
	retlw	0
	retlw	0
	retlw	31
	retlw	255
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	31
	retlw	0
	retlw	0
	retlw	31
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	224
	retlw	224
	retlw	0
	retlw	0
	retlw	224
	retlw	224
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	224
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	224
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	31
	retlw	31
	retlw	31
	retlw	31
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	31
	retlw	31
	retlw	31
	retlw	31
	retlw	0
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	31
	retlw	0
	retlw	0
	retlw	31
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	255
	retlw	255
	retlw	0
	retlw	31
	retlw	0
	retlw	0
	retlw	31
	retlw	0
	retlw	255
	retlw	255
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	0
	retlw	255
	retlw	31
	retlw	0
	retlw	0
	retlw	31
	retlw	255
	retlw	0
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	255
	retlw	31
	retlw	0
	retlw	0
	retlw	31
	retlw	255
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	31
	retlw	0
	retlw	0
	retlw	31
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	224
	retlw	0
	retlw	0
	retlw	224
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	224

;********************************************************************************

SYSMULTSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
MUL8LOOP
;movf SysByteTempA, W
	movf	SYSBYTETEMPA, W
;btfsc SysByteTempB, 0
	btfsc	SYSBYTETEMPB, 0
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F
;bcf STATUS, C
	bcf	STATUS, C
;rrf SysByteTempB, F
	rrf	SYSBYTETEMPB, F
;bcf STATUS, C
	bcf	STATUS, C
;rlf SysByteTempA, F
	rlf	SYSBYTETEMPA, F
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F
;btfss STATUS, Z
	btfss	STATUS, Z
;goto MUL8LOOP
	goto	MUL8LOOP
	return

;********************************************************************************

;Start of program memory page 1
	ORG	2048
GLCDCLS_ILI9326
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE
	clrf	GLCD_YORDINATE_H
;sendCommand_ili9326(ILI9326_GRAM_ADDR_V_SET)
	movlw	1
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;sendData_ili9326( 0 )
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;sendCommand_ili9326(ILI9326_GRAM_ADDR_H_SET)
	clrf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;sendData_ili9326( 0 )
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ili9326(ILI9326_GRAM_WR_DATA)
	movlw	2
	movwf	ILI9326_SENDWORD
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;Use this method rather then call SendData_ili9326( as this is faster
;set ILI9326_GLCD_RS ON
	banksel	LATA
	bsf	LATA,1
;repeat GLCD_HEIGHT
	movlw	144
	banksel	SYSREPEATTEMP1
	movwf	SysRepeatTemp1
	movlw	2
	movwf	SysRepeatTemp1_H
SysRepeatLoop1
;repeat GLCD_WIDTH
	movlw	240
	banksel	SYSREPEATTEMP2
	movwf	SysRepeatTemp2
SysRepeatLoop2
;ILI9326_DataPort=GLCDBackground_h
	movf	GLCDBACKGROUND_H,W
	movwf	PORTD
;set ILI9326_GLCD_WR OFF
	banksel	LATA
	bcf	LATA,2
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
;ILI9326_DataPort=GLCDBackground
	banksel	GLCDBACKGROUND
	movf	GLCDBACKGROUND,W
	movwf	PORTD
;set ILI9326_GLCD_WR OFF
	banksel	LATA
	bcf	LATA,2
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
;end repeat
	banksel	SYSREPEATTEMP2
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
;end repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
	decfsz	SysRepeatTemp1_H,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;sendCommand_ili9326(ILI9326_GRAM_ADDR_V_SET)
	movlw	1
	banksel	ILI9326_SENDWORD
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;sendData_ili9326( 0 )
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;sendCommand_ili9326(ILI9326_GRAM_ADDR_H_SET)
	clrf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;sendData_ili9326( 0 )
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	goto	SENDDATA_ILI9326

;********************************************************************************

OLEDFONT2
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	145
	movwf	SysWORDTempB
	movlw	7
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableOLEDFONT2
	movwf	SysStringA
	movlw	(high TableOLEDFONT2) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableOLEDFONT2
	retlw	147
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	27
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	30
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	30
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	32
	retlw	25
	retlw	160
	retlw	7
	retlw	120
	retlw	1
	retlw	38
	retlw	25
	retlw	160
	retlw	7
	retlw	120
	retlw	1
	retlw	38
	retlw	1
	retlw	32
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	28
	retlw	24
	retlw	38
	retlw	16
	retlw	66
	retlw	16
	retlw	255
	retlw	63
	retlw	130
	retlw	17
	retlw	2
	retlw	15
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	28
	retlw	16
	retlw	34
	retlw	8
	retlw	34
	retlw	4
	retlw	34
	retlw	3
	retlw	156
	retlw	0
	retlw	64
	retlw	14
	retlw	48
	retlw	17
	retlw	8
	retlw	17
	retlw	4
	retlw	17
	retlw	2
	retlw	14
	retlw	0
	retlw	7
	retlw	128
	retlw	8
	retlw	92
	retlw	16
	retlw	98
	retlw	16
	retlw	162
	retlw	17
	retlw	50
	retlw	19
	retlw	28
	retlw	28
	retlw	0
	retlw	24
	retlw	0
	retlw	22
	retlw	128
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	30
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	7
	retlw	24
	retlw	24
	retlw	12
	retlw	48
	retlw	4
	retlw	32
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	4
	retlw	32
	retlw	12
	retlw	48
	retlw	24
	retlw	24
	retlw	224
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	8
	retlw	0
	retlw	24
	retlw	0
	retlw	240
	retlw	0
	retlw	78
	retlw	0
	retlw	240
	retlw	0
	retlw	24
	retlw	0
	retlw	8
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	224
	retlw	31
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	152
	retlw	0
	retlw	120
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	24
	retlw	0
	retlw	24
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	0
	retlw	48
	retlw	0
	retlw	12
	retlw	0
	retlw	3
	retlw	192
	retlw	0
	retlw	48
	retlw	0
	retlw	12
	retlw	0
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	240
	retlw	3
	retlw	12
	retlw	12
	retlw	2
	retlw	16
	retlw	2
	retlw	16
	retlw	2
	retlw	16
	retlw	12
	retlw	12
	retlw	240
	retlw	3
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	16
	retlw	4
	retlw	16
	retlw	4
	retlw	16
	retlw	254
	retlw	31
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	6
	retlw	24
	retlw	2
	retlw	20
	retlw	2
	retlw	18
	retlw	2
	retlw	17
	retlw	194
	retlw	16
	retlw	60
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	16
	retlw	66
	retlw	16
	retlw	66
	retlw	16
	retlw	66
	retlw	16
	retlw	188
	retlw	15
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	3
	retlw	192
	retlw	2
	retlw	32
	retlw	2
	retlw	24
	retlw	2
	retlw	4
	retlw	2
	retlw	254
	retlw	31
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	62
	retlw	16
	retlw	34
	retlw	16
	retlw	34
	retlw	16
	retlw	66
	retlw	8
	retlw	130
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	240
	retlw	7
	retlw	76
	retlw	8
	retlw	34
	retlw	16
	retlw	34
	retlw	16
	retlw	34
	retlw	16
	retlw	66
	retlw	8
	retlw	128
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	24
	retlw	2
	retlw	7
	retlw	194
	retlw	0
	retlw	50
	retlw	0
	retlw	10
	retlw	0
	retlw	6
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	28
	retlw	15
	retlw	162
	retlw	16
	retlw	66
	retlw	16
	retlw	66
	retlw	16
	retlw	162
	retlw	16
	retlw	162
	retlw	9
	retlw	28
	retlw	6
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	120
	retlw	0
	retlw	132
	retlw	16
	retlw	2
	retlw	17
	retlw	2
	retlw	17
	retlw	2
	retlw	17
	retlw	132
	retlw	12
	retlw	248
	retlw	3
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	96
	retlw	24
	retlw	96
	retlw	24
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	96
	retlw	152
	retlw	96
	retlw	120
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	64
	retlw	8
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	16
	retlw	64
	retlw	8
	retlw	64
	retlw	8
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	14
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	27
	retlw	130
	retlw	0
	retlw	66
	retlw	0
	retlw	38
	retlw	0
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	240
	retlw	3
	retlw	24
	retlw	12
	retlw	4
	retlw	24
	retlw	226
	retlw	19
	retlw	18
	retlw	20
	retlw	10
	retlw	22
	retlw	138
	retlw	27
	retlw	252
	retlw	7
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	16
	retlw	0
	retlw	14
	retlw	128
	retlw	3
	retlw	112
	retlw	2
	retlw	24
	retlw	2
	retlw	48
	retlw	2
	retlw	192
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	12
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	136
	retlw	16
	retlw	136
	retlw	16
	retlw	136
	retlw	16
	retlw	136
	retlw	16
	retlw	72
	retlw	17
	retlw	48
	retlw	14
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	3
	retlw	48
	retlw	12
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	24
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	16
	retlw	8
	retlw	224
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	17
	retlw	8
	retlw	17
	retlw	8
	retlw	17
	retlw	8
	retlw	17
	retlw	8
	retlw	17
	retlw	8
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	3
	retlw	48
	retlw	12
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	17
	retlw	8
	retlw	17
	retlw	24
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	248
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	248
	retlw	31
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	248
	retlw	15
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	128
	retlw	0
	retlw	128
	retlw	1
	retlw	64
	retlw	2
	retlw	32
	retlw	4
	retlw	16
	retlw	4
	retlw	8
	retlw	8
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	56
	retlw	0
	retlw	224
	retlw	1
	retlw	0
	retlw	7
	retlw	0
	retlw	6
	retlw	192
	retlw	1
	retlw	56
	retlw	0
	retlw	248
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	16
	retlw	0
	retlw	96
	retlw	0
	retlw	128
	retlw	1
	retlw	0
	retlw	6
	retlw	0
	retlw	8
	retlw	248
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	7
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	16
	retlw	8
	retlw	224
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	136
	retlw	0
	retlw	112
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	7
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	48
	retlw	16
	retlw	72
	retlw	224
	retlw	71
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	3
	retlw	136
	retlw	4
	retlw	112
	retlw	8
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	112
	retlw	24
	retlw	72
	retlw	16
	retlw	136
	retlw	16
	retlw	136
	retlw	16
	retlw	8
	retlw	17
	retlw	8
	retlw	9
	retlw	24
	retlw	14
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	7
	retlw	0
	retlw	24
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	8
	retlw	248
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	8
	retlw	0
	retlw	48
	retlw	0
	retlw	192
	retlw	1
	retlw	0
	retlw	6
	retlw	0
	retlw	24
	retlw	0
	retlw	24
	retlw	0
	retlw	7
	retlw	192
	retlw	0
	retlw	48
	retlw	0
	retlw	8
	retlw	0
	retlw	24
	retlw	0
	retlw	224
	retlw	3
	retlw	0
	retlw	28
	retlw	0
	retlw	15
	retlw	224
	retlw	0
	retlw	192
	retlw	1
	retlw	0
	retlw	14
	retlw	0
	retlw	28
	retlw	224
	retlw	3
	retlw	24
	retlw	0
	retlw	8
	retlw	16
	retlw	16
	retlw	8
	retlw	32
	retlw	4
	retlw	64
	retlw	2
	retlw	128
	retlw	1
	retlw	128
	retlw	1
	retlw	64
	retlw	2
	retlw	32
	retlw	4
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	0
	retlw	16
	retlw	0
	retlw	96
	retlw	0
	retlw	128
	retlw	0
	retlw	0
	retlw	31
	retlw	128
	retlw	0
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	16
	retlw	0
	retlw	8
	retlw	0
	retlw	0
	retlw	0
	retlw	8
	retlw	24
	retlw	8
	retlw	20
	retlw	8
	retlw	18
	retlw	8
	retlw	17
	retlw	136
	retlw	16
	retlw	72
	retlw	16
	retlw	40
	retlw	16
	retlw	24
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	127
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	0
	retlw	12
	retlw	0
	retlw	48
	retlw	0
	retlw	192
	retlw	0
	retlw	0
	retlw	3
	retlw	0
	retlw	12
	retlw	0
	retlw	48
	retlw	0
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	254
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	0
	retlw	3
	retlw	224
	retlw	0
	retlw	56
	retlw	0
	retlw	14
	retlw	0
	retlw	112
	retlw	0
	retlw	128
	retlw	3
	retlw	0
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	12
	retlw	32
	retlw	18
	retlw	32
	retlw	17
	retlw	32
	retlw	17
	retlw	32
	retlw	9
	retlw	192
	retlw	31
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	31
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	96
	retlw	8
	retlw	128
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	24
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	64
	retlw	8
	retlw	254
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	9
	retlw	32
	retlw	17
	retlw	32
	retlw	17
	retlw	32
	retlw	17
	retlw	32
	retlw	17
	retlw	192
	retlw	17
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	252
	retlw	31
	retlw	36
	retlw	0
	retlw	34
	retlw	0
	retlw	34
	retlw	0
	retlw	34
	retlw	0
	retlw	34
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	152
	retlw	32
	retlw	144
	retlw	32
	retlw	144
	retlw	32
	retlw	144
	retlw	64
	retlw	72
	retlw	224
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	31
	retlw	128
	retlw	0
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	192
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	38
	retlw	0
	retlw	230
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	32
	retlw	128
	retlw	32
	retlw	128
	retlw	38
	retlw	128
	retlw	230
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	31
	retlw	0
	retlw	1
	retlw	0
	retlw	3
	retlw	128
	retlw	4
	retlw	64
	retlw	4
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	254
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	31
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	192
	retlw	31
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	192
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	31
	retlw	192
	retlw	0
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	192
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	64
	retlw	8
	retlw	128
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	255
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	96
	retlw	8
	retlw	128
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	24
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	64
	retlw	8
	retlw	224
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	31
	retlw	128
	retlw	0
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	24
	retlw	32
	retlw	17
	retlw	32
	retlw	17
	retlw	32
	retlw	18
	retlw	32
	retlw	18
	retlw	32
	retlw	12
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	248
	retlw	15
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	15
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	8
	retlw	224
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	0
	retlw	192
	retlw	1
	retlw	0
	retlw	6
	retlw	0
	retlw	24
	retlw	0
	retlw	16
	retlw	0
	retlw	12
	retlw	0
	retlw	3
	retlw	192
	retlw	0
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	96
	retlw	0
	retlw	128
	retlw	7
	retlw	0
	retlw	24
	retlw	0
	retlw	14
	retlw	192
	retlw	1
	retlw	128
	retlw	1
	retlw	0
	retlw	14
	retlw	0
	retlw	24
	retlw	128
	retlw	7
	retlw	96
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	16
	retlw	64
	retlw	8
	retlw	128
	retlw	4
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	128
	retlw	4
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	32
	retlw	128
	retlw	192
	retlw	128
	retlw	0
	retlw	131
	retlw	0
	retlw	70
	retlw	0
	retlw	56
	retlw	0
	retlw	24
	retlw	0
	retlw	6
	retlw	0
	retlw	1
	retlw	192
	retlw	0
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	16
	retlw	32
	retlw	24
	retlw	32
	retlw	20
	retlw	32
	retlw	18
	retlw	32
	retlw	17
	retlw	160
	retlw	16
	retlw	96
	retlw	16
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	252
	retlw	62
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	252
	retlw	62
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	3
	retlw	128
	retlw	0
	retlw	128
	retlw	0
	retlw	128
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	128
	retlw	1
	retlw	0
	retlw	0
	retlw	128
	retlw	31
	retlw	192
	retlw	16
	retlw	32
	retlw	16
	retlw	16
	retlw	16
	retlw	32
	retlw	16
	retlw	192
	retlw	16
	retlw	128
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	3
	retlw	48
	retlw	12
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	144
	retlw	8
	retlw	176
	retlw	24
	retlw	208

;********************************************************************************

;Start of program memory page 2
	ORG	4096
Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS
	movlw	3
	movwf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
	decfsz	SysWaitTempS, F
	goto	DS_START
	return

;********************************************************************************

ERASE_SPRITE
;dim ptrx, ptry as word
;for ptry = sprite_x+1 to sprite_x+16
	movlw	1
	addwf	SPRITE_X,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	SPRITE_X_H
	addwfc	SPRITE_X_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	1
	subwf	SysTemp1,W
	banksel	PTRY
	movwf	PTRY
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	PTRY_H
	movwf	PTRY_H
	movlw	1
	addwf	SPRITE_X,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	SPRITE_X_H
	addwfc	SPRITE_X_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	16
	banksel	SPRITE_X
	addwf	SPRITE_X,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	0
	banksel	SPRITE_X_H
	addwfc	SPRITE_X_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	movf	SysTemp1,W
	movwf	SysWORDTempB
	movf	SysTemp1_H,W
	movwf	SysWORDTempB_H
	movf	SysTemp2,W
	movwf	SysWORDTempA
	movf	SysTemp2_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd4
ENDIF12
SysForLoop4
	incf	PTRY,F
	btfsc	STATUS,Z
	incf	PTRY_H,F
;for ptrx = sprite_y+1 to sprite_y+16
	movlw	1
	addwf	SPRITE_Y,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	SPRITE_Y_H
	addwfc	SPRITE_Y_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	1
	subwf	SysTemp1,W
	banksel	PTRX
	movwf	PTRX
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	PTRX_H
	movwf	PTRX_H
	movlw	1
	addwf	SPRITE_Y,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	SPRITE_Y_H
	addwfc	SPRITE_Y_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	16
	banksel	SPRITE_Y
	addwf	SPRITE_Y,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	0
	banksel	SPRITE_Y_H
	addwfc	SPRITE_Y_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	movf	SysTemp1,W
	movwf	SysWORDTempB
	movf	SysTemp1_H,W
	movwf	SysWORDTempB_H
	movf	SysTemp2,W
	movwf	SysWORDTempA
	movf	SysTemp2_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd5
ENDIF13
SysForLoop5
	incf	PTRX,F
	btfsc	STATUS,Z
	incf	PTRX_H,F
;Pset ptrx, ptry, bg
	movf	PTRX,W
	movwf	GLCDX
	movf	PTRX_H,W
	movwf	GLCDX_H
	movf	PTRY,W
	movwf	GLCDY
	movf	PTRY_H,W
	movwf	GLCDY_H
	clrf	GLCDCOLOUR
	clrf	GLCDCOLOUR_H
	call	PSET_ILI9326
;next
	movlw	16
	addwf	SPRITE_Y,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	SPRITE_Y_H
	addwfc	SPRITE_Y_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	banksel	PTRX
	movf	PTRX,W
	movwf	SysWORDTempA
	movf	PTRX_H,W
	movwf	SysWORDTempA_H
	banksel	SYSTEMP1
	movf	SysTemp1,W
	movwf	SysWORDTempB
	movf	SysTemp1_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop5
ENDIF14
SysForLoopEnd5
;next
	movlw	16
	addwf	SPRITE_X,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	SPRITE_X_H
	addwfc	SPRITE_X_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	banksel	PTRY
	movf	PTRY,W
	movwf	SysWORDTempA
	movf	PTRY_H,W
	movwf	SysWORDTempA_H
	banksel	SYSTEMP1
	movf	SysTemp1,W
	movwf	SysWORDTempB
	movf	SysTemp1_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop4
ENDIF15
SysForLoopEnd4
	return

;********************************************************************************

GLCDDRAWCHAR_ILI9326
;This has got a tad complex
;We have three major pieces
;1 The preamble - this just adjusted color and the input character
;2 The code that deals with GCB fontset
;3 The code that deals with OLED fontset
;
;You can make independent change to section 2 and 3 but they are mutual exclusive with many common pieces
;dim CharCol, CharRow, GLCDTemp as word
;dim COLSperfont, CurrCharVal, CurrCharRow, CurrCharCol, ROWSperfont as byte
;CharCode -= 15
	movlw	15
	subwf	CHARCODE,F
;CharCol=0
	clrf	CHARCOL
	clrf	CHARCOL_H
;Calculate the pointer to the OLED fonts.
;These fonts are not multiple tables one is a straight list the other is a lookup table with data.
;Dim LocalCharCode as word
;Get key information and set up the fonts parameters
;Select case GLCDfntDefaultSize
;case 1 'This font is two font tables of an index and data
SysSelect4Case1
	decf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelect4Case2
;CharCode = CharCode - 16
	movlw	16
	subwf	CHARCODE,F
;ReadTable OLEDFont1Index, CharCode, LocalCharCode
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	call	OLEDFONT1INDEX
	movwf	LOCALCHARCODE
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	OLEDFONT1INDEX_H
	call	OLEDFONT1INDEX_H
	pagesel	$
	movwf	LOCALCHARCODE_H
;ReadTable OLEDFont1Data, LocalCharCode , COLSperfont
	movf	LOCALCHARCODE,W
	movwf	SYSSTRINGA
	movf	LOCALCHARCODE_H,W
	movwf	SYSSTRINGA_H
	call	OLEDFONT1DATA
	movwf	COLSPERFONT
;GLCDFontWidth = COLSperfont + 1
	incf	COLSPERFONT,W
	movwf	GLCDFONTWIDTH
;ROWSperfont = 7  'which is really 8 as we start at 0
	movlw	7
	movwf	ROWSPERFONT
;case 2 'This is one font table
	goto	SysSelectEnd4
SysSelect4Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelectEnd4
;CharCode = CharCode - 17
	movlw	17
	subwf	CHARCODE,F
;Pointer to table of font elements
;LocalCharCode = (CharCode * 20)
	movf	CHARCODE,W
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	movlw	20
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysMultSub16
	call	SysMultSub16
	pagesel	$
	movf	SysWORDTempX,W
	movwf	LOCALCHARCODE
	movf	SysWORDTempX_H,W
	movwf	LOCALCHARCODE_H
;COLSperfont = 9  'which is really 10 as we start at 0
	movlw	9
	movwf	COLSPERFONT
;ROWSperfont=15  'which is really 16 as we start at 0
	movlw	15
	movwf	ROWSPERFONT
;End Select
SysSelectEnd4
;The main loop - loop throught the number of columns
;For CurrCharCol = 0 to COLSperfont  'number of columns in the font , with two row of data
	movlw	255
	movwf	CURRCHARCOL
	movlw	0
	subwf	COLSPERFONT,W
	btfss	STATUS, C
	goto	SysForLoopEnd7
ENDIF19
SysForLoop7
	incf	CURRCHARCOL,F
;Index the pointer to the code that we are looking for as we need to do this lookup many times getting more font data
;LocalCharCode++
	incf	LOCALCHARCODE,F
	btfsc	STATUS,Z
	incf	LOCALCHARCODE_H,F
;Select case GLCDfntDefaultSize
;case 1
SysSelect5Case1
	decf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelect5Case2
;ReadTable OLEDFont1Data, LocalCharCode, CurrCharVal
	movf	LOCALCHARCODE,W
	movwf	SYSSTRINGA
	movf	LOCALCHARCODE_H,W
	movwf	SYSSTRINGA_H
	call	OLEDFONT1DATA
	movwf	CURRCHARVAL
;case 2
	goto	SysSelectEnd5
SysSelect5Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelectEnd5
;Read this 20 times... (0..COLSperfont) [ * 2 ]
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	movf	LOCALCHARCODE,W
	movwf	SYSSTRINGA
	movf	LOCALCHARCODE_H,W
	movwf	SYSSTRINGA_H
	pagesel	OLEDFONT2
	call	OLEDFONT2
	pagesel	$
	movwf	CURRCHARVAL
;End Select
SysSelectEnd5
;we handle 8 or 16 pixels of height
;For CurrCharRow = 0 to ROWSperfont
	movlw	255
	movwf	CURRCHARROW
	movlw	0
	subwf	ROWSPERFONT,W
	btfss	STATUS, C
	goto	SysForLoopEnd8
ENDIF20
SysForLoop8
	incf	CURRCHARROW,F
;Set the pixel
;If CurrCharVal.0 = 0 Then
	btfsc	CURRCHARVAL,0
	goto	ELSE21_1
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, GLCDBackground
	movf	CURRCHARCOL,W
	addwf	CHARLOCX,W
	movwf	GLCDX
	movlw	0
	addwfc	CHARLOCX_H,W
	movwf	GLCDX_H
	movf	CURRCHARROW,W
	addwf	CHARLOCY,W
	movwf	GLCDY
	movlw	0
	addwfc	CHARLOCY_H,W
	movwf	GLCDY_H
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_ILI9326
;Else
	goto	ENDIF21
ELSE21_1
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, GLCDForeground
	movf	CURRCHARCOL,W
	addwf	CHARLOCX,W
	movwf	GLCDX
	movlw	0
	addwfc	CHARLOCX_H,W
	movwf	GLCDX_H
	movf	CURRCHARROW,W
	addwf	CHARLOCY,W
	movwf	GLCDY
	movlw	0
	addwfc	CHARLOCY_H,W
	movwf	GLCDY_H
	movf	GLCDFOREGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_ILI9326
;End If
ENDIF21
;Rotate CurrCharVal Right
	rrf	CURRCHARVAL,F
;Set to next row of date, a second row
;if GLCDfntDefaultSize = 2 and CurrCharRow = 7 then
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempA
	movlw	2
	movwf	SysBYTETempB
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	CURRCHARROW
	movf	CURRCHARROW,W
	movwf	SysBYTETempA
	movlw	7
	movwf	SysBYTETempB
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	banksel	SYSTEMP3
	movf	SysTemp3,W
	andwf	SysByteTempX,W
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF22
;LocalCharCode++
	banksel	LOCALCHARCODE
	incf	LOCALCHARCODE,F
	btfsc	STATUS,Z
	incf	LOCALCHARCODE_H,F
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	movf	LOCALCHARCODE,W
	movwf	SYSSTRINGA
	movf	LOCALCHARCODE_H,W
	movwf	SYSSTRINGA_H
	pagesel	OLEDFONT2
	call	OLEDFONT2
	pagesel	$
	movwf	CURRCHARVAL
;end if
ENDIF22
;It is the intercharacter space, put out one pixel row
;if CurrCharCol = COLSperfont then
	banksel	COLSPERFONT
	movf	COLSPERFONT,W
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	ENDIF23
;Put out a white intercharacter pixel/space
;GLCDTemp = CharLocX + CurrCharCol
	movf	CURRCHARCOL,W
	addwf	CHARLOCX,W
	movwf	GLCDTEMP
	movlw	0
	addwfc	CHARLOCX_H,W
	movwf	GLCDTEMP_H
;if GLCDfntDefaultSize = 2 then
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	ENDIF26
;GLCDTemp++
	incf	GLCDTEMP,F
	btfsc	STATUS,Z
	incf	GLCDTEMP_H,F
;end if
ENDIF26
;PSet GLCDTemp , CharLocY + CurrCharRow, GLCDBackground
	movf	GLCDTEMP,W
	movwf	GLCDX
	movf	GLCDTEMP_H,W
	movwf	GLCDX_H
	movf	CURRCHARROW,W
	addwf	CHARLOCY,W
	movwf	GLCDY
	movlw	0
	addwfc	CHARLOCY_H,W
	movwf	GLCDY_H
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_ILI9326
;end if
ENDIF23
;Next
	movf	ROWSPERFONT,W
	subwf	CURRCHARROW,W
	btfss	STATUS, C
	goto	SysForLoop8
ENDIF24
SysForLoopEnd8
;Next
	movf	COLSPERFONT,W
	subwf	CURRCHARCOL,W
	btfss	STATUS, C
	goto	SysForLoop7
ENDIF25
SysForLoopEnd7
	return

;********************************************************************************

GLCDROTATE_ILI9326
;Dim ILI9326_GLCD_WIDTH, ILI9326_GLCD_HEIGHT as word
;Dim ILI9326_GLCD_WIDTH_ADJ, ILI9326_GLCD_HEIGHT_ADJ as word
;Select case ILI9326_AddressType
;Case PORTRAIT
SysSelect3Case1
	movlw	4
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect3Case2
;ILI9326_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;ILI9326_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	144
	movwf	GLCDDEVICEHEIGHT
	movlw	1
	movwf	GLCDDEVICEHEIGHT_H
;ILI9326_GLCD_WIDTH_ADJ = 0
	clrf	ILI9326_GLCD_WIDTH_ADJ
	clrf	ILI9326_GLCD_WIDTH_ADJ_H
;ILI9326_GLCD_HEIGHT_ADJ = GLCD_HEIGHT - 1
	movlw	143
	movwf	ILI9326_GLCD_HEIGHT_ADJ
	movlw	1
	movwf	ILI9326_GLCD_HEIGHT_ADJ_H
;Change to RGB TFT color and standard orientation
;SendCommand_ILI9326(ILI9326_ENTRY_MODE)
	movlw	3
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326( ILI9326_ENTRY_MODE_BGR )
	clrf	ILI9326_SENDWORD
	movlw	16
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;Case Landscape
	goto	SysSelectEnd3
SysSelect3Case2
	decf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect3Case3
;ILI9326_GLCD_WIDTH = GLCD_HEIGHT
	movlw	144
	movwf	GLCDDEVICEWIDTH
	movlw	1
	movwf	GLCDDEVICEWIDTH_H
;ILI9326_GLCD_HEIGHT = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;ILI9326_GLCD_WIDTH_ADJ = GLCD_HEIGHT - 1
	movlw	143
	movwf	ILI9326_GLCD_WIDTH_ADJ
	movlw	1
	movwf	ILI9326_GLCD_WIDTH_ADJ_H
;ILI9326_GLCD_HEIGHT_ADJ = GLCD_WIDTH - 1
	movlw	239
	movwf	ILI9326_GLCD_HEIGHT_ADJ
	clrf	ILI9326_GLCD_HEIGHT_ADJ_H
;SendCommand_ILI9326(ILI9326_ENTRY_MODE)
	movlw	3
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326( ILI9326_ENTRY_MODE_BGR | ILI9326_ENTRY_MODE_ID1 | ILI9326_ENTRY_MODE_AM )
	movlw	40
	movwf	ILI9326_SENDWORD
	movlw	16
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;Case Portrait_Rev
	goto	SysSelectEnd3
SysSelect3Case3
	movlw	2
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect3Case4
;ILI9326_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;ILI9326_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	144
	movwf	GLCDDEVICEHEIGHT
	movlw	1
	movwf	GLCDDEVICEHEIGHT_H
;ILI9326_GLCD_WIDTH_ADJ = GLCD_WIDTH - 1
	movlw	239
	movwf	ILI9326_GLCD_WIDTH_ADJ
	clrf	ILI9326_GLCD_WIDTH_ADJ_H
;ILI9326_GLCD_HEIGHT_ADJ = 0
	clrf	ILI9326_GLCD_HEIGHT_ADJ
	clrf	ILI9326_GLCD_HEIGHT_ADJ_H
;SendCommand_ILI9326(ILI9326_ENTRY_MODE)
	movlw	3
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326( ILI9326_ENTRY_MODE_BGR | ILI9326_ENTRY_MODE_ID1 )
	movlw	32
	movwf	ILI9326_SENDWORD
	movlw	16
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;Case Landscape_Rev
	goto	SysSelectEnd3
SysSelect3Case4
	movlw	3
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect3Case5
;ILI9326_GLCD_WIDTH = GLCD_HEIGHT
	movlw	144
	movwf	GLCDDEVICEWIDTH
	movlw	1
	movwf	GLCDDEVICEWIDTH_H
;ILI9326_GLCD_HEIGHT = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;ILI9326_GLCD_WIDTH_ADJ = 0
	clrf	ILI9326_GLCD_WIDTH_ADJ
	clrf	ILI9326_GLCD_WIDTH_ADJ_H
;ILI9326_GLCD_HEIGHT_ADJ = 0
	clrf	ILI9326_GLCD_HEIGHT_ADJ
	clrf	ILI9326_GLCD_HEIGHT_ADJ_H
;SendCommand_ILI9326(ILI9326_ENTRY_MODE)
	movlw	3
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326( ILI9326_ENTRY_MODE_BGR | ILI9326_ENTRY_MODE_ID0 | ILI9326_ENTRY_MODE_ID1 | ILI9326_ENTRY_MODE_AM )
	movlw	56
	movwf	ILI9326_SENDWORD
	movlw	16
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;Case Else
	goto	SysSelectEnd3
SysSelect3Case5
;ILI9326_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;ILI9326_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	144
	movwf	GLCDDEVICEHEIGHT
	movlw	1
	movwf	GLCDDEVICEHEIGHT_H
;ILI9326_GLCD_WIDTH_ADJ = 0
	clrf	ILI9326_GLCD_WIDTH_ADJ
	clrf	ILI9326_GLCD_WIDTH_ADJ_H
;ILI9326_GLCD_HEIGHT_ADJ = GLCD_HEIGHT - 1
	movlw	143
	movwf	ILI9326_GLCD_HEIGHT_ADJ
	movlw	1
	movwf	ILI9326_GLCD_HEIGHT_ADJ_H
;Change to RGB TFT color and standard orientation
;SendCommand_ILI9326(ILI9326_ENTRY_MODE)
	movlw	3
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326( ILI9326_ENTRY_MODE_BGR )
	clrf	ILI9326_SENDWORD
	movlw	16
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;End Select
SysSelectEnd3
	return

;********************************************************************************

OLEDFONT1DATA
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	165
	movwf	SysWORDTempB
	movlw	1
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableOLEDFONT1DATA
	movwf	SysStringA
	movlw	(high TableOLEDFONT1DATA) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableOLEDFONT1DATA
	retlw	165
	retlw	1
	retlw	0
	retlw	1
	retlw	94
	retlw	3
	retlw	6
	retlw	0
	retlw	6
	retlw	5
	retlw	40
	retlw	124
	retlw	40
	retlw	124
	retlw	40
	retlw	5
	retlw	36
	retlw	42
	retlw	127
	retlw	42
	retlw	16
	retlw	3
	retlw	98
	retlw	24
	retlw	70
	retlw	5
	retlw	48
	retlw	76
	retlw	90
	retlw	36
	retlw	80
	retlw	1
	retlw	6
	retlw	2
	retlw	60
	retlw	66
	retlw	2
	retlw	66
	retlw	60
	retlw	5
	retlw	40
	retlw	16
	retlw	124
	retlw	16
	retlw	40
	retlw	3
	retlw	16
	retlw	56
	retlw	16
	retlw	1
	retlw	192
	retlw	3
	retlw	16
	retlw	16
	retlw	16
	retlw	1
	retlw	64
	retlw	3
	retlw	96
	retlw	24
	retlw	6
	retlw	4
	retlw	60
	retlw	66
	retlw	66
	retlw	60
	retlw	3
	retlw	68
	retlw	126
	retlw	64
	retlw	4
	retlw	68
	retlw	98
	retlw	82
	retlw	76
	retlw	3
	retlw	74
	retlw	74
	retlw	52
	retlw	4
	retlw	30
	retlw	16
	retlw	124
	retlw	16
	retlw	3
	retlw	78
	retlw	74
	retlw	50
	retlw	4
	retlw	60
	retlw	74
	retlw	74
	retlw	48
	retlw	3
	retlw	98
	retlw	18
	retlw	14
	retlw	4
	retlw	52
	retlw	74
	retlw	74
	retlw	52
	retlw	4
	retlw	12
	retlw	82
	retlw	82
	retlw	60
	retlw	1
	retlw	72
	retlw	2
	retlw	128
	retlw	104
	retlw	3
	retlw	16
	retlw	40
	retlw	68
	retlw	3
	retlw	40
	retlw	40
	retlw	40
	retlw	3
	retlw	68
	retlw	40
	retlw	16
	retlw	3
	retlw	2
	retlw	82
	retlw	12
	retlw	5
	retlw	56
	retlw	68
	retlw	84
	retlw	84
	retlw	88
	retlw	4
	retlw	124
	retlw	18
	retlw	18
	retlw	124
	retlw	4
	retlw	126
	retlw	74
	retlw	74
	retlw	52
	retlw	4
	retlw	60
	retlw	66
	retlw	66
	retlw	36
	retlw	4
	retlw	126
	retlw	66
	retlw	66
	retlw	60
	retlw	3
	retlw	126
	retlw	74
	retlw	74
	retlw	3
	retlw	126
	retlw	10
	retlw	10
	retlw	4
	retlw	60
	retlw	66
	retlw	82
	retlw	52
	retlw	4
	retlw	126
	retlw	8
	retlw	8
	retlw	126
	retlw	3
	retlw	66
	retlw	126
	retlw	66
	retlw	3
	retlw	66
	retlw	66
	retlw	62
	retlw	4
	retlw	126
	retlw	8
	retlw	20
	retlw	98
	retlw	3
	retlw	126
	retlw	64
	retlw	64
	retlw	5
	retlw	126
	retlw	4
	retlw	8
	retlw	4
	retlw	126
	retlw	5
	retlw	126
	retlw	4
	retlw	24
	retlw	32
	retlw	126
	retlw	4
	retlw	60
	retlw	66
	retlw	66
	retlw	60
	retlw	4
	retlw	126
	retlw	18
	retlw	18
	retlw	12
	retlw	4
	retlw	60
	retlw	66
	retlw	66
	retlw	188
	retlw	4
	retlw	126
	retlw	18
	retlw	18
	retlw	108
	retlw	4
	retlw	68
	retlw	74
	retlw	74
	retlw	48
	retlw	3
	retlw	2
	retlw	126
	retlw	2
	retlw	4
	retlw	62
	retlw	64
	retlw	64
	retlw	62
	retlw	5
	retlw	6
	retlw	24
	retlw	96
	retlw	24
	retlw	6
	retlw	5
	retlw	62
	retlw	64
	retlw	62
	retlw	64
	retlw	62
	retlw	5
	retlw	66
	retlw	36
	retlw	24
	retlw	36
	retlw	66
	retlw	4
	retlw	158
	retlw	160
	retlw	160
	retlw	126
	retlw	4
	retlw	98
	retlw	82
	retlw	74
	retlw	70
	retlw	2
	retlw	126
	retlw	66
	retlw	3
	retlw	6
	retlw	24
	retlw	96
	retlw	2
	retlw	66
	retlw	126
	retlw	3
	retlw	32
	retlw	16
	retlw	32
	retlw	4
	retlw	128
	retlw	128
	retlw	128
	retlw	128
	retlw	2
	retlw	4
	retlw	8
	retlw	4
	retlw	32
	retlw	84
	retlw	84
	retlw	120
	retlw	4
	retlw	126
	retlw	68
	retlw	68
	retlw	56
	retlw	4
	retlw	56
	retlw	68
	retlw	68
	retlw	40
	retlw	4
	retlw	56
	retlw	68
	retlw	68
	retlw	126
	retlw	4
	retlw	56
	retlw	84
	retlw	84
	retlw	88
	retlw	2
	retlw	124
	retlw	10
	retlw	4
	retlw	152
	retlw	164
	retlw	164
	retlw	124
	retlw	4
	retlw	126
	retlw	4
	retlw	4
	retlw	120
	retlw	1
	retlw	122
	retlw	2
	retlw	64
	retlw	58
	retlw	4
	retlw	126
	retlw	16
	retlw	40
	retlw	68
	retlw	1
	retlw	126
	retlw	5
	retlw	124
	retlw	4
	retlw	120
	retlw	4
	retlw	120
	retlw	4
	retlw	124
	retlw	4
	retlw	4
	retlw	120
	retlw	4
	retlw	56
	retlw	68
	retlw	68
	retlw	56
	retlw	4
	retlw	252
	retlw	36
	retlw	36
	retlw	24
	retlw	4
	retlw	24
	retlw	36
	retlw	36
	retlw	252
	retlw	2
	retlw	124
	retlw	4
	retlw	4
	retlw	72
	retlw	84
	retlw	84
	retlw	32
	retlw	3
	retlw	4
	retlw	62
	retlw	68
	retlw	4
	retlw	60
	retlw	64
	retlw	64
	retlw	60
	retlw	5
	retlw	12
	retlw	48
	retlw	64
	retlw	48
	retlw	12
	retlw	5
	retlw	60
	retlw	64
	retlw	60
	retlw	64
	retlw	60
	retlw	5
	retlw	68
	retlw	40
	retlw	16
	retlw	40
	retlw	68
	retlw	4
	retlw	156
	retlw	160
	retlw	160
	retlw	124
	retlw	3
	retlw	100
	retlw	84
	retlw	76
	retlw	3
	retlw	8
	retlw	54
	retlw	65
	retlw	1
	retlw	255
	retlw	3
	retlw	65
	retlw	54
	retlw	8
	retlw	4
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	1

;********************************************************************************

OLEDFONT1INDEX
	movlw	97
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableOLEDFONT1INDEX
	movwf	SysStringA
	movlw	(high TableOLEDFONT1INDEX) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableOLEDFONT1INDEX
	retlw	96
	retlw	1
	retlw	3
	retlw	5
	retlw	9
	retlw	15
	retlw	21
	retlw	25
	retlw	31
	retlw	33
	retlw	36
	retlw	39
	retlw	45
	retlw	49
	retlw	51
	retlw	55
	retlw	57
	retlw	61
	retlw	66
	retlw	70
	retlw	75
	retlw	79
	retlw	84
	retlw	88
	retlw	93
	retlw	97
	retlw	102
	retlw	107
	retlw	109
	retlw	112
	retlw	116
	retlw	120
	retlw	124
	retlw	128
	retlw	134
	retlw	139
	retlw	144
	retlw	149
	retlw	154
	retlw	158
	retlw	162
	retlw	167
	retlw	172
	retlw	176
	retlw	180
	retlw	185
	retlw	189
	retlw	195
	retlw	201
	retlw	206
	retlw	211
	retlw	216
	retlw	221
	retlw	226
	retlw	230
	retlw	235
	retlw	241
	retlw	247
	retlw	253
	retlw	2
	retlw	7
	retlw	10
	retlw	14
	retlw	17
	retlw	21
	retlw	26
	retlw	29
	retlw	34
	retlw	39
	retlw	44
	retlw	49
	retlw	54
	retlw	57
	retlw	62
	retlw	67
	retlw	69
	retlw	72
	retlw	77
	retlw	79
	retlw	85
	retlw	90
	retlw	95
	retlw	100
	retlw	105
	retlw	108
	retlw	113
	retlw	117
	retlw	122
	retlw	128
	retlw	134
	retlw	140
	retlw	145
	retlw	149
	retlw	153
	retlw	155
	retlw	159
	retlw	164

;********************************************************************************

OLEDFONT2_H
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableOLEDFONT2_H
	movwf	SysStringA
	movlw	(high TableOLEDFONT2_H) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableOLEDFONT2_H
	retlw	7

;********************************************************************************

PSET_ILI9326
;Dim ILI9326_GLCD_WIDTH_ADJ, ILI9326_GLCD_HEIGHT_ADJ as word
;Dim ILI9326_AddressType as byte
;sendCommand_ili9326(ILI9326_GRAM_ADDR_H_SET)
	clrf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;select case ILI9326_AddressType
;case Portrait
SysSelect1Case1
	movlw	4
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
;sendData_ili9326( GLCDX )
	movf	GLCDX,W
	movwf	ILI9326_SENDWORD
	movf	GLCDX_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
	movf	ILI9326_SENDWORD,W
	movwf	GLCDX
	movf	ILI9326_SENDWORD_H,W
	movwf	GLCDX_H
;case Portrait_Rev
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;sendData_ili9326( ILI9326_GLCD_WIDTH_ADJ - GLCDX )
	movf	GLCDX,W
	subwf	ILI9326_GLCD_WIDTH_ADJ,W
	movwf	ILI9326_SENDWORD
	movf	GLCDX_H,W
	subwfb	ILI9326_GLCD_WIDTH_ADJ_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;case Landscape
	goto	SysSelectEnd1
SysSelect1Case3
	decf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
;sendData_ili9326( ILI9326_GLCD_HEIGHT_ADJ - GLCDY )
	movf	GLCDY,W
	subwf	ILI9326_GLCD_HEIGHT_ADJ,W
	movwf	ILI9326_SENDWORD
	movf	GLCDY_H,W
	subwfb	ILI9326_GLCD_HEIGHT_ADJ_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;case Landscape_Rev
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	3
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelectEnd1
;sendData_ili9326( GLCDY )
	movf	GLCDY,W
	movwf	ILI9326_SENDWORD
	movf	GLCDY_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
	movf	ILI9326_SENDWORD,W
	movwf	GLCDY
	movf	ILI9326_SENDWORD_H,W
	movwf	GLCDY_H
;end select
SysSelectEnd1
;sendCommand_ili9326(ILI9326_GRAM_ADDR_V_SET)
	movlw	1
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;select case ILI9326_AddressType
;case Portrait
SysSelect2Case1
	movlw	4
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect2Case2
;sendData_ili9326( ILI9326_GLCD_HEIGHT_ADJ - GLCDY )
	movf	GLCDY,W
	subwf	ILI9326_GLCD_HEIGHT_ADJ,W
	movwf	ILI9326_SENDWORD
	movf	GLCDY_H,W
	subwfb	ILI9326_GLCD_HEIGHT_ADJ_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;case Portrait_Rev
	goto	SysSelectEnd2
SysSelect2Case2
	movlw	2
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect2Case3
;sendData_ili9326( GLCDY )
	movf	GLCDY,W
	movwf	ILI9326_SENDWORD
	movf	GLCDY_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
	movf	ILI9326_SENDWORD,W
	movwf	GLCDY
	movf	ILI9326_SENDWORD_H,W
	movwf	GLCDY_H
;case Landscape
	goto	SysSelectEnd2
SysSelect2Case3
	decf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect2Case4
;sendData_ili9326( ILI9326_GLCD_WIDTH_ADJ - GLCDX )
	movf	GLCDX,W
	subwf	ILI9326_GLCD_WIDTH_ADJ,W
	movwf	ILI9326_SENDWORD
	movf	GLCDX_H,W
	subwfb	ILI9326_GLCD_WIDTH_ADJ_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;case Landscape_Rev
	goto	SysSelectEnd2
SysSelect2Case4
	movlw	3
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelectEnd2
;sendData_ili9326( GLCDX )
	movf	GLCDX,W
	movwf	ILI9326_SENDWORD
	movf	GLCDX_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
	movf	ILI9326_SENDWORD,W
	movwf	GLCDX
	movf	ILI9326_SENDWORD_H,W
	movwf	GLCDX_H
;end select
SysSelectEnd2
;sendCommand_ili9326(ILI9326_GRAM_WR_DATA)
	movlw	2
	movwf	ILI9326_SENDWORD
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;sendData_ili9326( GLCDColour )
	movf	GLCDCOLOUR,W
	movwf	ILI9326_SENDWORD
	movf	GLCDCOLOUR_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
	movf	ILI9326_SENDWORD,W
	movwf	GLCDCOLOUR
	movf	ILI9326_SENDWORD_H,W
	movwf	GLCDCOLOUR_H
	return

;********************************************************************************

SPRITE
;dim ptrx, ptry as word
;ptr = spritedata_ptr
	movf	SPRITEDATA_PTR,W
	movwf	PTR
	movf	SPRITEDATA_PTR_H,W
	movwf	PTR_H
;for ptry = sprite_x+1 to sprite_x+16
	movlw	1
	addwf	SPRITE_X,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	SPRITE_X_H
	addwfc	SPRITE_X_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	1
	subwf	SysTemp1,W
	banksel	PTRY
	movwf	PTRY
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	PTRY_H
	movwf	PTRY_H
	movlw	1
	addwf	SPRITE_X,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	SPRITE_X_H
	addwfc	SPRITE_X_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	16
	banksel	SPRITE_X
	addwf	SPRITE_X,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	0
	banksel	SPRITE_X_H
	addwfc	SPRITE_X_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	movf	SysTemp1,W
	movwf	SysWORDTempB
	movf	SysTemp1_H,W
	movwf	SysWORDTempB_H
	movf	SysTemp2,W
	movwf	SysWORDTempA
	movf	SysTemp2_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd2
ENDIF8
SysForLoop2
	incf	PTRY,F
	btfsc	STATUS,Z
	incf	PTRY_H,F
;for ptrx = sprite_y+1 to sprite_y+16
	movlw	1
	addwf	SPRITE_Y,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	SPRITE_Y_H
	addwfc	SPRITE_Y_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	1
	subwf	SysTemp1,W
	banksel	PTRX
	movwf	PTRX
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	PTRX_H
	movwf	PTRX_H
	movlw	1
	addwf	SPRITE_Y,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	SPRITE_Y_H
	addwfc	SPRITE_Y_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	16
	banksel	SPRITE_Y
	addwf	SPRITE_Y,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	0
	banksel	SPRITE_Y_H
	addwfc	SPRITE_Y_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	movf	SysTemp1,W
	movwf	SysWORDTempB
	movf	SysTemp1_H,W
	movwf	SysWORDTempB_H
	movf	SysTemp2,W
	movwf	SysWORDTempA
	movf	SysTemp2_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd3
ENDIF9
SysForLoop3
	incf	PTRX,F
	btfsc	STATUS,Z
	incf	PTRX_H,F
;ReadTable spritedata,ptr,pixel
	movf	PTR,W
	movwf	SYSSTRINGA
	movf	PTR_H,W
	movwf	SYSSTRINGA_H
	pagesel	SPRITEDATA
	call	SPRITEDATA
	pagesel	$
	movwf	PIXEL
	movf	PTR,W
	movwf	SYSSTRINGA
	movf	PTR_H,W
	movwf	SYSSTRINGA_H
	call	SPRITEDATA_H
	movwf	PIXEL_H
;Pset ptrx, ptry, pixel
	movf	PTRX,W
	movwf	GLCDX
	movf	PTRX_H,W
	movwf	GLCDX_H
	movf	PTRY,W
	movwf	GLCDY
	movf	PTRY_H,W
	movwf	GLCDY_H
	movf	PIXEL,W
	movwf	GLCDCOLOUR
	movf	PIXEL_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_ILI9326
;ptr++
	incf	PTR,F
	btfsc	STATUS,Z
	incf	PTR_H,F
;next
	movlw	16
	addwf	SPRITE_Y,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	SPRITE_Y_H
	addwfc	SPRITE_Y_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	banksel	PTRX
	movf	PTRX,W
	movwf	SysWORDTempA
	movf	PTRX_H,W
	movwf	SysWORDTempA_H
	banksel	SYSTEMP1
	movf	SysTemp1,W
	movwf	SysWORDTempB
	movf	SysTemp1_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop3
ENDIF10
SysForLoopEnd3
;next
	movlw	16
	addwf	SPRITE_X,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	SPRITE_X_H
	addwfc	SPRITE_X_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	banksel	PTRY
	movf	PTRY,W
	movwf	SysWORDTempA
	movf	PTRY_H,W
	movwf	SysWORDTempA_H
	banksel	SYSTEMP1
	movf	SysTemp1,W
	movwf	SysWORDTempB
	movf	SysTemp1_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop2
ENDIF11
SysForLoopEnd2
	return

;********************************************************************************

SPRITEDATA_H
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	251
	movwf	SysWORDTempB
	movlw	1
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableSPRITEDATA_H
	movwf	SysStringA
	movlw	(high TableSPRITEDATA_H) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableSPRITEDATA_H
	retlw	2
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	248
	retlw	248
	retlw	248
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	248
	retlw	248
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	248
	retlw	248
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	248
	retlw	248
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	248
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	248
	retlw	248
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	248
	retlw	248
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	248
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	248
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	255

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
	retlw	32	; 
	retlw	71	;G
	retlw	114	;r
	retlw	101	;e
	retlw	97	;a
	retlw	116	;t
	retlw	32	; 
	retlw	67	;C
	retlw	111	;o
	retlw	119	;w
	retlw	32	; 
	retlw	66	;B
	retlw	65	;A
	retlw	83	;S
	retlw	73	;I
	retlw	67	;C


StringTable2
	retlw	14
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	83	;S
	retlw	112	;p
	retlw	114	;r
	retlw	105	;i
	retlw	116	;t
	retlw	101	;e
	retlw	32	; 
	retlw	68	;D
	retlw	101	;e
	retlw	109	;m
	retlw	111	;o


StringTable3
	retlw	16
	retlw	32	; 
	retlw	32	; 
	retlw	73	;I
	retlw	76	;L
	retlw	73	;I
	retlw	57	;9
	retlw	51	;3
	retlw	50	;2
	retlw	54	;6
	retlw	32	; 
	retlw	64	;
	retlw	32	; 
	retlw	50	;2
	retlw	48	;0
	retlw	49	;1
	retlw	56	;8


;********************************************************************************

;Start of program memory page 3
	ORG	6144
Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	14
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	189
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

OLEDFONT1DATA_H
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableOLEDFONT1DATA_H
	movwf	SysStringA
	movlw	(high TableOLEDFONT1DATA_H) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableOLEDFONT1DATA_H
	retlw	1

;********************************************************************************

OLEDFONT1INDEX_H
	movlw	97
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableOLEDFONT1INDEX_H
	movwf	SysStringA
	movlw	(high TableOLEDFONT1INDEX_H) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableOLEDFONT1INDEX_H
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1

;********************************************************************************

SENDCOMMAND_ILI9326
;set ILI9326_GLCD_CS OFF
	banksel	LATA
	bcf	LATA,0
;set ILI9326_GLCD_RS OFF
	bcf	LATA,1
;set ILI9326_GLCD_RD ON
	bsf	LATA,3
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
;ILI9326_DataPort = ILI9326_SENDWORD_h
	banksel	ILI9326_SENDWORD_H
	movf	ILI9326_SENDWORD_H,W
	movwf	PORTD
;set ILI9326_GLCD_WR OFF
	banksel	LATA
	bcf	LATA,2
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
;ILI9326_DataPort = ILI9326_SENDWORD
	banksel	ILI9326_SENDWORD
	movf	ILI9326_SENDWORD,W
	movwf	PORTD
;set ILI9326_GLCD_WR OFF
	banksel	LATA
	bcf	LATA,2
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
	banksel	STATUS
	return

;********************************************************************************

SENDDATA_ILI9326
;set ILI9326_GLCD_RS ON
	banksel	LATA
	bsf	LATA,1
;ILI9326_DataPort=ILI9326_SENDWORD_h
	banksel	ILI9326_SENDWORD_H
	movf	ILI9326_SENDWORD_H,W
	movwf	PORTD
;set ILI9326_GLCD_WR OFF
	banksel	LATA
	bcf	LATA,2
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
;ILI9326_DataPort=ILI9326_SENDWORD
	banksel	ILI9326_SENDWORD
	movf	ILI9326_SENDWORD,W
	movwf	PORTD
;set ILI9326_GLCD_WR OFF
	banksel	LATA
	bcf	LATA,2
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
	banksel	STATUS
	return

;********************************************************************************

SYSCOMPEQUAL
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;movf SysByteTempA, W
	movf	SYSBYTETEMPA, W
;subwf SysByteTempB, W
	subwf	SYSBYTETEMPB, W
;btfsc STATUS, Z
	btfsc	STATUS, Z
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test High, exit if more
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;Test high, exit true if less
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W
;btfss STATUS,C
	btfss	STATUS,C
;goto SCLT16True
	goto	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	movf	SYSWORDTEMPB,W
;subwf SysWordTempA,W
	subwf	SYSWORDTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLT16TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSMULTSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	movf	SYSWORDTEMPA,W
	movwf	SYSDIVMULTA
	movf	SYSWORDTEMPA_H,W
	movwf	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movf	SYSWORDTEMPB,W
	movwf	SYSDIVMULTB
	movf	SYSWORDTEMPB_H,W
	movwf	SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX
	clrf	SYSDIVMULTX_H
MUL16LOOP
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
	btfss	SYSDIVMULTB,0
	goto	ENDIF27
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
ENDIF27
;set STATUS.C OFF
	bcf	STATUS,C
;rotate SysDivMultB right
	rrf	SYSDIVMULTB_H,F
	rrf	SYSDIVMULTB,F
;set STATUS.C off
	bcf	STATUS,C
;rotate SysDivMultA left
	rlf	SYSDIVMULTA,F
	rlf	SYSDIVMULTA_H,F
;if SysDivMultB > 0 then goto MUL16LOOP
	movf	SYSDIVMULTB,W
	movwf	SysWORDTempB
	movf	SYSDIVMULTB_H,W
	movwf	SysWORDTempB_H
	clrf	SysWORDTempA
	clrf	SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	MUL16LOOP
ENDIF28
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
	return

;********************************************************************************

;Start of program memory page 4
	ORG	8192
;Start of program memory page 5
	ORG	10240
;Start of program memory page 6
	ORG	12288
;Start of program memory page 7
	ORG	14336

 END
