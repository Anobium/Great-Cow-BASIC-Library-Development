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
COLOR	EQU	39
COLOR_H	EQU	40
COLSPERFONT	EQU	41
CURRCHARCOL	EQU	42
CURRCHARROW	EQU	43
CURRCHARVAL	EQU	44
CURRCOL	EQU	45
CURRCOL_H	EQU	46
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
DRAWLINE	EQU	47
DRAWLINE_H	EQU	48
GLCDBACKGROUND	EQU	49
GLCDBACKGROUND_H	EQU	50
GLCDCOLOUR	EQU	51
GLCDCOLOUR_H	EQU	52
GLCDFNTDEFAULTSIZE	EQU	53
GLCDFONTWIDTH	EQU	54
GLCDFOREGROUND	EQU	55
GLCDFOREGROUND_H	EQU	56
GLCDPRINTLOC	EQU	57
GLCDPRINTLOC_H	EQU	58
GLCDTEMP	EQU	59
GLCDTEMP_H	EQU	60
GLCDX	EQU	61
GLCDX_H	EQU	62
GLCDY	EQU	63
GLCDY_H	EQU	64
GLCD_YORDINATE	EQU	65
GLCD_YORDINATE_H	EQU	66
ILI9326_ADDRESSTYPE	EQU	67
ILI9326_GLCD_HEIGHT	EQU	68
ILI9326_GLCD_HEIGHT_ADJ	EQU	70
ILI9326_GLCD_HEIGHT_ADJ_H	EQU	71
ILI9326_GLCD_HEIGHT_H	EQU	69
ILI9326_GLCD_WIDTH	EQU	72
ILI9326_GLCD_WIDTH_ADJ	EQU	74
ILI9326_GLCD_WIDTH_ADJ_H	EQU	75
ILI9326_GLCD_WIDTH_H	EQU	73
ILI9326_SENDWORD	EQU	76
ILI9326_SENDWORD_H	EQU	77
INXRADIUS	EQU	78
INXRADIUS_H	EQU	79
LINECOLOUR	EQU	80
LINECOLOUR_H	EQU	81
LINEDIFFX	EQU	82
LINEDIFFX_H	EQU	83
LINEDIFFX_X2	EQU	84
LINEDIFFX_X2_H	EQU	85
LINEDIFFY	EQU	86
LINEDIFFY_H	EQU	87
LINEDIFFY_X2	EQU	88
LINEDIFFY_X2_H	EQU	89
LINEERR	EQU	90
LINEERR_H	EQU	91
LINESTEPX	EQU	92
LINESTEPX_H	EQU	93
LINESTEPY	EQU	94
LINESTEPY_H	EQU	95
LINEX1	EQU	96
LINEX1_H	EQU	97
LINEX2	EQU	98
LINEX2_H	EQU	99
LINEY1	EQU	100
LINEY1_H	EQU	101
LINEY2	EQU	102
LINEY2_H	EQU	103
LOCALCHARCODE	EQU	104
LOCALCHARCODE_H	EQU	105
LOCX	EQU	106
LOCX_H	EQU	107
LOCY	EQU	108
LOCY_H	EQU	109
OLDGLCDFONTWIDTH	EQU	110
PRINTLEN	EQU	111
PRINTLOCX	EQU	160
PRINTLOCX_H	EQU	161
PRINTLOCY	EQU	162
PRINTLOCY_H	EQU	163
RADIUSERR	EQU	164
RADIUSERR_H	EQU	165
ROWSPERFONT	EQU	166
STRINGLOCX	EQU	167
STRINGLOCX_H	EQU	168
STRINGPOINTER	EQU	169
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCHARSHANDLER	EQU	170
SYSCHARSHANDLER_H	EQU	171
SYSDIVLOOP	EQU	116
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSINTEGERTEMPA	EQU	117
SYSINTEGERTEMPA_H	EQU	118
SYSINTEGERTEMPB	EQU	121
SYSINTEGERTEMPB_H	EQU	122
SYSINTEGERTEMPX	EQU	112
SYSINTEGERTEMPX_H	EQU	113
SYSPRINTDATAHANDLER	EQU	172
SYSPRINTDATAHANDLER_H	EQU	173
SYSPRINTTEMP	EQU	174
SYSPRINTTEMP_H	EQU	175
SYSREPEATTEMP1	EQU	176
SYSREPEATTEMP1_H	EQU	177
SYSREPEATTEMP2	EQU	178
SYSSIGNBYTE	EQU	125
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SYSSTRINGPARAM1	EQU	10207
SYSTEMP1	EQU	179
SYSTEMP1_H	EQU	180
SYSTEMP2	EQU	181
SYSTEMP2_H	EQU	182
SYSTEMP3	EQU	183
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWAITTEMPS	EQU	116
SYSWORDTEMPA	EQU	117
SYSWORDTEMPA_H	EQU	118
SYSWORDTEMPB	EQU	121
SYSWORDTEMPB_H	EQU	122
SYSWORDTEMPX	EQU	112
SYSWORDTEMPX_H	EQU	113
XCHAR	EQU	184
XOFFSET	EQU	185
XOFFSET_H	EQU	186
XRADIUS	EQU	187
XRADIUS_H	EQU	188
YOFFSET	EQU	189
YOFFSET_H	EQU	190
YORDINATE	EQU	191

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5

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
;Automatic pin direction setting
	banksel	TRISA
	bcf	TRISA,5
	bcf	TRISA,3
	bcf	TRISA,2
	bcf	TRISA,1
	bcf	TRISA,0

;Start of the main program
;#define GLCD_TYPE GLCD_TYPE_ILI9326
;#define GLCD_RD       porta.3        ' read command line
;#define GLCD_WR       porta.2         ' write command line
;#define GLCD_RS       porta.1         ' Command/Data line
;#define GLCD_CS       porta.0         ' Chip select line
;#define GLCD_RST      porta.5         ' Reset line
;#define GLCD_DB0       portd.0
;#define GLCD_DB1       portd.1
;#define GLCD_DB2       portd.2
;#define GLCD_DB3       portd.3
;#define GLCD_DB4       portd.4
;#define GLCD_DB5       portd.5
;#define GLCD_DB6       portd.6
;#define GLCD_DB7       portd.7
;#define GLCD_DataPort portD
;#define ILI9326_DataPort GLCD_DataPort
;#define ILI9326_GLCD_RST GLCD_RST
;#define ILI9326_GLCD_CS GLCD_CS
;#define ILI9326_GLCD_RS GLCD_RS
;#define ILI9326_GLCD_WR GLCD_WR
;#define ILI9326_GLCD_RD GLCD_RD
;dir ILI9326_dataPort out
	clrf	TRISD
;dim ILI9326_SENDWORD as word
;#define GLCD_WIDTH  240
;#define GLCD_HEIGHT 400
;#define GLCDCLS       GLCDCLS_ILI9326
;#define GLCDRotate    GLCDRotate_ILI9326
;#define PSET          PSet_ILI9326
;#define GLCDDrawChar  GLCDDrawChar_ILI9326
;#define FilledBox     FilledBox_ILI9326
;#define GLCDDrawString GLCDDrawString_ILI9326
TEST
;InitGLCD_ILI9326
	banksel	STATUS
	call	INITGLCD_ILI9326
	pagesel	$
;
;c
;GLCDForeground = ILI9326_BLACK
;GLCDRotate ( LANDSCAPE_REV )
;GLCDCLS ( ILI9326_YELLOW )
;
;GLCDfntDefaultSize = 2
	movlw	2
	movwf	GLCDFNTDEFAULTSIZE
;GLCDFontWidth = 4
	movlw	4
	movwf	GLCDFONTWIDTH
;GLCDCLS ( TFT_RED )
	clrf	GLCDBACKGROUND
	movlw	248
	movwf	GLCDBACKGROUND_H
	pagesel	GLCDCLS_ILI9326
	call	GLCDCLS_ILI9326
	pagesel	$
;wait 1 s
	movlw	1
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;line 0,0,100,100
	clrf	LINEX1
	clrf	LINEX1_H
	clrf	LINEY1
	clrf	LINEY1_H
	movlw	100
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	100
	movwf	LINEY2
	clrf	LINEY2_H
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	LINE
	call	LINE
	pagesel	$
;Box 0, 0, ILI9326_GLCD_WIDTH -1, ILI9326_GLCD_HEIGHT - 1
	clrf	LINEX1
	clrf	LINEX1_H
	clrf	LINEY1
	clrf	LINEY1_H
	movlw	1
	subwf	ILI9326_GLCD_WIDTH,W
	movwf	LINEX2
	movlw	0
	subwfb	ILI9326_GLCD_WIDTH_H,W
	movwf	LINEX2_H
	movlw	1
	subwf	ILI9326_GLCD_HEIGHT,W
	movwf	LINEY2
	movlw	0
	subwfb	ILI9326_GLCD_HEIGHT_H,W
	movwf	LINEY2_H
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	BOX
	call	BOX
	pagesel	$
;GLCDDrawString ( 20, 20, "Evan" )
	movlw	20
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	20
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable1) | 128
	movwf	SysCHARSHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;BigPrint_ILI9326 ( 5, ILI9326_GLCD_HEIGHT - 20 , "BigPrint ILI9326" )
	movlw	5
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	20
	banksel	ILI9326_GLCD_HEIGHT
	subwf	ILI9326_GLCD_HEIGHT,W
	banksel	PRINTLOCY
	movwf	PRINTLOCY
	movlw	0
	banksel	ILI9326_GLCD_HEIGHT_H
	subwfb	ILI9326_GLCD_HEIGHT_H,W
	banksel	PRINTLOCY_H
	movwf	PRINTLOCY_H
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable2
	movwf	SysStringA
	movlw	(high StringTable2) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	COLOR
	movf	GLCDFOREGROUND_H,W
	movwf	COLOR_H
	pagesel	BIGPRINT_ILI9326
	call	BIGPRINT_ILI9326
	pagesel	$
;wait 4 s
	movlw	4
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;do
SysDoLoop_S1
;GLCDCLS ( GLCDBackground )
	pagesel	GLCDCLS_ILI9326
	call	GLCDCLS_ILI9326
	pagesel	$
;Line 0, 0, ILI9326_GLCD_WIDTH -1, ILI9326_GLCD_HEIGHT - 1
	clrf	LINEX1
	clrf	LINEX1_H
	clrf	LINEY1
	clrf	LINEY1_H
	movlw	1
	subwf	ILI9326_GLCD_WIDTH,W
	movwf	LINEX2
	movlw	0
	subwfb	ILI9326_GLCD_WIDTH_H,W
	movwf	LINEX2_H
	movlw	1
	subwf	ILI9326_GLCD_HEIGHT,W
	movwf	LINEY2
	movlw	0
	subwfb	ILI9326_GLCD_HEIGHT_H,W
	movwf	LINEY2_H
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	LINE
	call	LINE
	pagesel	$
;Box 0, 0, 400 - 1, 240 - 1
;Box 0, 0, ILI9326_GLCD_WIDTH -1, ILI9326_GLCD_HEIGHT - 1
	clrf	LINEX1
	clrf	LINEX1_H
	clrf	LINEY1
	clrf	LINEY1_H
	movlw	1
	subwf	ILI9326_GLCD_WIDTH,W
	movwf	LINEX2
	movlw	0
	subwfb	ILI9326_GLCD_WIDTH_H,W
	movwf	LINEX2_H
	movlw	1
	subwf	ILI9326_GLCD_HEIGHT,W
	movwf	LINEY2
	movlw	0
	subwfb	ILI9326_GLCD_HEIGHT_H,W
	movwf	LINEY2_H
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	BOX
	call	BOX
	pagesel	$
;box ILI9326_GLCD_WIDTH -1, ILI9326_GLCD_HEIGHT - 1, ILI9326_GLCD_WIDTH -10, ILI9326_GLCD_HEIGHT - 10
	movlw	1
	subwf	ILI9326_GLCD_WIDTH,W
	movwf	LINEX1
	movlw	0
	subwfb	ILI9326_GLCD_WIDTH_H,W
	movwf	LINEX1_H
	movlw	1
	subwf	ILI9326_GLCD_HEIGHT,W
	movwf	LINEY1
	movlw	0
	subwfb	ILI9326_GLCD_HEIGHT_H,W
	movwf	LINEY1_H
	movlw	10
	subwf	ILI9326_GLCD_WIDTH,W
	movwf	LINEX2
	movlw	0
	subwfb	ILI9326_GLCD_WIDTH_H,W
	movwf	LINEX2_H
	movlw	10
	subwf	ILI9326_GLCD_HEIGHT,W
	movwf	LINEY2
	movlw	0
	subwfb	ILI9326_GLCD_HEIGHT_H,W
	movwf	LINEY2_H
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	BOX
	call	BOX
	pagesel	$
;#define GLCD_OLED_FONT
;GLCDDrawString ( 20, 20, "Evan" )
	movlw	20
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	20
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable1) | 128
	movwf	SysCHARSHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;circle ILI9326_GLCD_WIDTH/2, ILI9326_GLCD_HEIGHT/2, 30
	movf	ILI9326_GLCD_WIDTH,W
	movwf	SysWORDTempA
	movf	ILI9326_GLCD_WIDTH_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	XOFFSET
	movwf	XOFFSET
	movf	SysWORDTempA_H,W
	movwf	XOFFSET_H
	banksel	ILI9326_GLCD_HEIGHT
	movf	ILI9326_GLCD_HEIGHT,W
	movwf	SysWORDTempA
	movf	ILI9326_GLCD_HEIGHT_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	YOFFSET
	movwf	YOFFSET
	movf	SysWORDTempA_H,W
	movwf	YOFFSET_H
	movlw	30
	banksel	INXRADIUS
	movwf	INXRADIUS
	clrf	INXRADIUS_H
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	movf	GLCD_YORDINATE,W
	banksel	YORDINATE
	movwf	YORDINATE
	banksel	STATUS
	pagesel	CIRCLE
	call	CIRCLE
	pagesel	$
;Filledbox ( 120,120,150,150, ILI9326_BLUE  )
	movlw	120
	movwf	LINEX1
	clrf	LINEX1_H
	movlw	120
	movwf	LINEY1
	clrf	LINEY1_H
	movlw	150
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	150
	movwf	LINEY2
	clrf	LINEY2_H
	movlw	31
	movwf	LINECOLOUR
	clrf	LINECOLOUR_H
	pagesel	FILLEDBOX_ILI9326
	call	FILLEDBOX_ILI9326
	pagesel	$
;GLCDBackground = GLCDBackground  + 8
	movlw	8
	addwf	GLCDBACKGROUND,F
	movlw	0
	addwfc	GLCDBACKGROUND_H,F
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;GLCDChar_ili9326( 50, 50 ,10 )
;GLCDChar_ili9326( 60, 50 ,11 )
;GLCDChar_ili9326( 70, 50 ,12 )
;
;sleep
	sleep
;end
	goto	BASPROGRAMEND
;#define ILI9326_WHITE   TFT_WHITE
;#define ILI9326_BLACK   TFT_BLACK
;#define ILI9326_RED     TFT_RED
;#define ILI9326_GREEN   TFT_GREEN
;#define ILI9326_BLUE    TFT_BLUE
;#define ILI9326_YELLOW  TFT_YELLOW
;#define ILI9326_CYAN    TFT_CYAN
;#define ILI9326_MAGENTA TFT_MAGENTA
;#define ILI9326_NAVY          TFT_NAVY
;#define ILI9326_DARKGREEN     TFT_DARKGREEN
;#define ILI9326_DARKCYAN      TFT_DARKCYAN
;#define ILI9326_MAROON        TFT_MAROON
;#define ILI9326_PURPLE        TFT_PURPLE
;#define ILI9326_OLIVE         TFT_OLIVE
;#define ILI9326_LIGHTGREY     TFT_LIGHTGREY
;#define ILI9326_DARKGREY      TFT_DARKGREY
;#define ILI9326_ORANGE        TFT_ORANGE
;#define ILI9326_GREENYELLOW   TFT_GREENYELLOW
;#define ILI9326_PINK          TFT_PINK
;#define ILI9326_LCD_DRV_OUTPUT_CTRL           0x0001
;#define ILI9326_LCD_DRIVING_WAVE_CTRL         0x0002
;#define ILI9326_ENTRY_MODE                    0x0003
;Bits of entry mode
;#define ILI9326_ENTRY_MODE_TRI                0x8000
;#define ILI9326_ENTRY_MODE_DFM                0x4000
;#define ILI9326_ENTRY_MODE_BGR                0x1000
;#define ILI9326_ENTRY_MODE_RGB                0x0000
;#define ILI9326_ENTRY_MODE_HWM                0x0200
;#define ILI9326_ENTRY_MODE_ORG                0x0080
;#define ILI9326_ENTRY_MODE_ID1                0x0020
;#define ILI9326_ENTRY_MODE_ID0                0x0010
;#define ILI9326_ENTRY_MODE_AM                 0x0008
;#define ILI9326_OUTLINE_SHARPENING_CTRL       0x0006
;#define ILI9326_DISP_CTRL_1                   0x0007
;#define ILI9326_DISP_CTRL_2                   0x0008
;#define ILI9326_DISP_CTRL_3                   0x0009
;#define ILI9326_LOW_PWR_CTRL                  0x000b
;#define ILI9326_RGB_DISP_INTF_CTRL_1          0x000c
;#define ILI9326_RGB_DISP_INTF_CTRL_2          0x000f
;#define ILI9326_PANEL_INTF_CTRL_1             0x0010
;#define ILI9326_PANEL_INTF_CTRL_2             0x0011
;#define ILI9326_PANEL_INTF_CTRL_3             0x0012
;#define ILI9326_PANEL_INTF_CTRL_4             0x0020
;#define ILI9326_PANEL_INTF_CTRL_5             0x0021
;#define ILI9326_PANEL_INTF_CTRL_6             0x0022
;#define ILI9326_FRAME_MARKER_POS              0x0090
;#define ILI9326_PWR_CTRL_1                    0x0100
;#define ILI9326_PWR_CTRL_2                    0x0101
;#define ILI9326_PWR_CTRL_3                    0x0102
;#define ILI9326_PWR_CTRL_4                    0x0103
;#define ILI9326_PWR_CTRL_5                    0x0107
;#define ILI9326_GRAM_ADDR_H_SET               0x0200
;#define ILI9326_GRAM_ADDR_V_SET               0x0201
;#define ILI9326_GRAM_WR_DATA                  0x0202
;#define ILI9326_FRAME_RATE_COLOR_CTRL         0x020b
;#define ILI9326_H_ADDR_START_POS              0x0210
;#define ILI9326_H_ADDR_END_POS                0x0211
;#define ILI9326_V_ADDR_START_POS              0x0212
;#define ILI9326_V_ADDR_END_POS                0x0213
;#define ILI9326_UID_CODE                      0x0280
;#define ILI9326_VCOMH                         0x0281
;#define ILI9326_MPT_VCM_PROG                  0x0290
;#define ILI9326_MTP_VCM_STAT_EN               0x0291
;#define ILI9326_MTP_PROG_KEY                  0x0295
;#define ILI9326_GAMMA_CTRL_1                  0x0300
;#define ILI9326_GAMMA_CTRL_2                  0x0301
;#define ILI9326_GAMMA_CTRL_3                  0x0302
;#define ILI9326_GAMMA_CTRL_4                  0x0305
;#define ILI9326_GAMMA_CTRL_5                  0x0306
;#define ILI9326_GAMMA_CTRL_6                  0x0307
;#define ILI9326_GAMMA_CTRL_7                  0x0308
;#define ILI9326_GAMMA_CTRL_8                  0x0309
;#define ILI9326_GAMMA_CTRL_9                  0x030c
;#define ILI9326_GAMMA_CTRL_10                 0x030d
;#define ILI9326_BASE_IMG_DISP_CTRL_1          0x0400
;#define ILI9326_BASE_IMG_DISP_CTRL_2          0x0401
;#define ILI9326_BASE_IMG_DISP_CTRL_3          0x0404
;#define ILI9326_PART_IMG_1_DISP_POS           0x0500
;#define ILI9326_PART_IMG_1_AREA_START         0x0501
;#define ILI9326_PART_IMG_1_AREA_END           0x0502
;#define ILI9326_PART_IMG_2_DISP_POS           0x0503
;#define ILI9326_PART_IMG_2_AREA_START         0x0504
;#define ILI9326_PART_IMG_2_AREA_END           0x0505
;Screen rotation
;#define LANDSCAPE       1
;#define PORTRAIT_REV    2
;#define LANDSCAPE_REV   3
;#define PORTRAIT        4
;Foreground and background colours
;Dim GLCDBackground As Word
;Dim GLCDForeground As Word
;Dim ILI9326_GLCD_WIDTH, ILI9326_GLCD_HEIGHT as word
;''Draws a character at the specified location on the ST7920 GLCD
;''@param StringLocX X coordinate for message
;''@param CharLocY Y coordinate for message
;''@param Chars String to display
;''@param LineColour Line Color, either 1 or 0
;''Draws a character at the specified location on the ST7920 GLCD
;''@param StringLocX X coordinate for message
;''@param CharLocY Y coordinate for message
;''@param Chars String to display
;''@param LineColour Line Color, either 1 or 0
;''Displays a string in a larger fonti.e.  BigPrint_ILI9326 ( 30, ILI9326_GLCD_HEIGHT - 20 , "BigPrint_ILI9326" )
;''@param PrintLocX X coordinate for message
;''@param PrintLocY Y coordinate for message
;''@param PrintData String to display
;''@param Color Optional color
;''Draws a Vertical Line on the GLCD with a
;''@param GLCDY1 Y coordinate of one end of the line
;''@param GLCDY2 Y coordinate of the other end of the line
;''@param GLCDX1 X coordinate of the line
;''@param LineColour color
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

DRAWBIGCHAR_ILI9326
;dim Locx, Locy, CurrCol as Word
;dim CurrCharVal, CurrCharRow, CurrCharCol as byte
;if CharCode <=126 Then
	movf	CHARCODE,W
	sublw	126
	btfss	STATUS, C
	goto	ENDIF12
;CharCode -=32
	movlw	32
	subwf	CHARCODE,F
;Goto GCBBigTables
	goto	GCBBIGTABLES
;end if
ENDIF12
;if CharCode <=210 Then
	movf	CHARCODE,W
	sublw	210
	btfss	STATUS, C
	goto	ENDIF13
;CharCode -=33
	movlw	33
	subwf	CHARCODE,F
;Goto GCBBigTables
	goto	GCBBIGTABLES
;end if
ENDIF13
;if CharCode <= 250 Then
	movf	CHARCODE,W
	sublw	250
	btfss	STATUS, C
	goto	ENDIF14
;CharCode -=34
	movlw	34
	subwf	CHARCODE,F
;Goto GCBBigTables
	goto	GCBBIGTABLES
;end if
ENDIF14
GCBBIGTABLES
;For CurrCharCol = 1 to 24
	clrf	CURRCHARCOL
SysForLoop5
	incf	CURRCHARCOL,F
;CurrCol=CurrCharCol+CharCode*24-(CharCode/10)*240
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempA,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	24
	movwf	SysBYTETempB
	pagesel	SysMultSub
	call	SysMultSub
	pagesel	$
	movf	SysBYTETempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movf	SysTemp1,W
	movwf	SysBYTETempA
	movlw	240
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysMultSub
	call	SysMultSub
	pagesel	$
	banksel	SYSTEMP2
	movf	SysTemp2,W
	banksel	CURRCHARCOL
	addwf	CURRCHARCOL,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysTemp1_H
	btfsc	STATUS,C
	incf	SysTemp1_H,F
	movf	SysBYTETempX,W
	subwf	SysTemp1,W
	banksel	CURRCOL
	movwf	CURRCOL
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	CURRCOL_H
	movwf	CURRCOL_H
;if CharCode>=0 and CharCode<=9 then ReadTable BigFont32_41 , CurrCol, CurrCharVal
	movf	CHARCODE,W
	movwf	SysBYTETempA
	clrf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	9
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF15
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT32_41
	call	BIGFONT32_41
	pagesel	$
	movwf	CURRCHARVAL
ENDIF15
;if CharCode>=10 and CharCode<=19 then ReadTable BigFont42_51 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	19
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF16
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT42_51
	call	BIGFONT42_51
	pagesel	$
	movwf	CURRCHARVAL
ENDIF16
;if CharCode>=20 and CharCode<=29 then ReadTable BigFont52_61 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	20
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	29
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF17
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT52_61
	call	BIGFONT52_61
	pagesel	$
	movwf	CURRCHARVAL
ENDIF17
;if CharCode>=30 and CharCode<=39 then ReadTable BigFont62_71 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	30
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	39
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF18
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT62_71
	call	BIGFONT62_71
	pagesel	$
	movwf	CURRCHARVAL
ENDIF18
;if CharCode>=40 and CharCode<=49 then ReadTable BigFont72_81 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	40
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	49
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF19
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT72_81
	call	BIGFONT72_81
	pagesel	$
	movwf	CURRCHARVAL
ENDIF19
;if CharCode>=50 and CharCode<=59 then ReadTable BigFont82_91 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	50
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	59
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF20
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT82_91
	call	BIGFONT82_91
	pagesel	$
	movwf	CURRCHARVAL
ENDIF20
;if CharCode>=60 and CharCode<=69 then ReadTable BigFont92_101 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	60
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	69
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF21
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT92_101
	call	BIGFONT92_101
	pagesel	$
	movwf	CURRCHARVAL
ENDIF21
;if CharCode>=70 and CharCode<=79 then ReadTable BigFont102_111 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	70
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	79
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF22
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT102_111
	call	BIGFONT102_111
	pagesel	$
	movwf	CURRCHARVAL
ENDIF22
;if CharCode>=80 and CharCode<=89 then ReadTable BigFont112_121 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	80
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	89
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF23
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT112_121
	call	BIGFONT112_121
	pagesel	$
	movwf	CURRCHARVAL
ENDIF23
;if CharCode>=90 and CharCode<=99 then ReadTable BigFont122_126 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	90
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	99
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF24
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT122_126
	call	BIGFONT122_126
	pagesel	$
	movwf	CURRCHARVAL
ENDIF24
;if CharCode>=160 and CharCode<=169 then ReadTable BigFont193_202 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	160
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	169
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF25
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT193_202
	call	BIGFONT193_202
	pagesel	$
	movwf	CURRCHARVAL
ENDIF25
;if CharCode>=170 and CharCode<=179 then ReadTable BigFont203_212 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	170
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	179
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF26
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT203_212
	call	BIGFONT203_212
	pagesel	$
	movwf	CURRCHARVAL
ENDIF26
;if CharCode>=180 and CharCode<=183 then ReadTable BigFont213_216 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	180
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	183
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF27
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT213_216
	call	BIGFONT213_216
	pagesel	$
	movwf	CURRCHARVAL
ENDIF27
;if CurrCharVal=36 then CurrCharVal=33
	movlw	36
	banksel	CURRCHARVAL
	subwf	CURRCHARVAL,W
	btfss	STATUS, Z
	goto	ENDIF28
	movlw	33
	movwf	CURRCHARVAL
ENDIF28
;For CurrCharRow = 1 to 8
	clrf	CURRCHARROW
SysForLoop6
	incf	CURRCHARROW,F
;LocX=[word]CharLocX+CurrCharCol
	movf	CURRCHARCOL,W
	addwf	CHARLOCX,W
	movwf	LOCX
	movlw	0
	addwfc	CHARLOCX_H,W
	movwf	LOCX_H
;LocY=[Word]CharLocY+CurrCharRow
	movf	CURRCHARROW,W
	addwf	CHARLOCY,W
	movwf	LOCY
	movlw	0
	addwfc	CHARLOCY_H,W
	movwf	LOCY_H
;if CurrCharCol>12 then
	movf	CURRCHARCOL,W
	sublw	12
	btfsc	STATUS, C
	goto	ENDIF29
;LocX= LocX - 12
	movlw	12
	subwf	LOCX,F
	movlw	0
	subwfb	LOCX_H,F
;LocY= LocY + 8
	movlw	8
	addwf	LOCY,F
	movlw	0
	addwfc	LOCY_H,F
;end if
ENDIF29
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0
	goto	ENDIF30
;PSet_ILI9326 LocX , LocY , Color
	movf	LOCX,W
	movwf	GLCDX
	movf	LOCX_H,W
	movwf	GLCDX_H
	movf	LOCY,W
	movwf	GLCDY
	movf	LOCY_H,W
	movwf	GLCDY_H
	movf	COLOR,W
	movwf	GLCDCOLOUR
	movf	COLOR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;end if
ENDIF30
;Rotate CurrCharVal Right
	rrf	CURRCHARVAL,F
;Next
	movlw	8
	subwf	CURRCHARROW,W
	btfss	STATUS, C
	goto	SysForLoop6
ENDIF31
SysForLoopEnd6
;Next
	movlw	24
	subwf	CURRCHARCOL,W
	btfss	STATUS, C
	goto	SysForLoop5
ENDIF32
SysForLoopEnd5
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
SysSelect3Case1
	decf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelect3Case2
;CharCode = CharCode - 16
	movlw	16
	subwf	CHARCODE,F
;ReadTable OLEDFont1Index, CharCode, LocalCharCode
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	OLEDFONT1INDEX
	call	OLEDFONT1INDEX
	pagesel	$
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
	banksel	ROWSPERFONT
	movwf	ROWSPERFONT
;case 2 'This is one font table
	goto	SysSelectEnd3
SysSelect3Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelectEnd3
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
	banksel	ROWSPERFONT
	movwf	ROWSPERFONT
;End Select
SysSelectEnd3
;The main loop - loop throught the number of columns
;For CurrCharCol = 0 to COLSperfont  'number of columns in the font , with two row of data
	movlw	255
	banksel	CURRCHARCOL
	movwf	CURRCHARCOL
	movlw	0
	subwf	COLSPERFONT,W
	btfss	STATUS, C
	goto	SysForLoopEnd9
ENDIF56
SysForLoop9
	incf	CURRCHARCOL,F
;Index the pointer to the code that we are looking for as we need to do this lookup many times getting more font data
;LocalCharCode++
	incf	LOCALCHARCODE,F
	btfsc	STATUS,Z
	incf	LOCALCHARCODE_H,F
;Select case GLCDfntDefaultSize
;case 1
SysSelect4Case1
	decf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelect4Case2
;ReadTable OLEDFont1Data, LocalCharCode, CurrCharVal
	movf	LOCALCHARCODE,W
	movwf	SYSSTRINGA
	movf	LOCALCHARCODE_H,W
	movwf	SYSSTRINGA_H
	call	OLEDFONT1DATA
	movwf	CURRCHARVAL
;case 2
	goto	SysSelectEnd4
SysSelect4Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelectEnd4
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
SysSelectEnd4
;we handle 8 or 16 pixels of height
;For CurrCharRow = 0 to ROWSperfont
	movlw	255
	movwf	CURRCHARROW
	movlw	0
	banksel	ROWSPERFONT
	subwf	ROWSPERFONT,W
	btfss	STATUS, C
	goto	SysForLoopEnd10
ENDIF57
SysForLoop10
	banksel	CURRCHARROW
	incf	CURRCHARROW,F
;Set the pixel
;If CurrCharVal.0 = 0 Then
	btfsc	CURRCHARVAL,0
	goto	ELSE58_1
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
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Else
	goto	ENDIF58
ELSE58_1
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
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;End If
ENDIF58
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
	goto	ENDIF59
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
ENDIF59
;It is the intercharacter space, put out one pixel row
;if CurrCharCol = COLSperfont then
	banksel	COLSPERFONT
	movf	COLSPERFONT,W
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	ENDIF60
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
	goto	ENDIF63
;GLCDTemp++
	incf	GLCDTEMP,F
	btfsc	STATUS,Z
	incf	GLCDTEMP_H,F
;end if
ENDIF63
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
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;end if
ENDIF60
;Next
	banksel	ROWSPERFONT
	movf	ROWSPERFONT,W
	banksel	CURRCHARROW
	subwf	CURRCHARROW,W
	btfss	STATUS, C
	goto	SysForLoop10
ENDIF61
SysForLoopEnd10
;Next
	banksel	COLSPERFONT
	movf	COLSPERFONT,W
	subwf	CURRCHARCOL,W
	btfss	STATUS, C
	goto	SysForLoop9
ENDIF62
SysForLoopEnd9
	return

;********************************************************************************

INITGLCD_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	call	SENDDATA_ILI9326
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
	movwf	ILI9326_GLCD_WIDTH
	clrf	ILI9326_GLCD_WIDTH_H
;ILI9326_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	144
	movwf	ILI9326_GLCD_HEIGHT
	movlw	1
	movwf	ILI9326_GLCD_HEIGHT_H
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

;Start of program memory page 1
	ORG	2048
GLCDDRAWSTRING_ILI9326
;dim GLCDPrintLoc as word
;dim xchar as byte
;GLCDPrintLoc = StringLocX
	banksel	STRINGLOCX
	movf	STRINGLOCX,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	banksel	STRINGLOCX_H
	movf	STRINGLOCX_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	movf	GLCDFONTWIDTH,W
	movwf	OLDGLCDFONTWIDTH
;for xchar = 1 to Chars(0)
	banksel	XCHAR
	clrf	XCHAR
	movf	SysCHARSHandler,W
	movwf	AFSR0
	movf	SysCHARSHandler_H,W
	movwf	AFSR0_H
	movlw	1
	subwf	INDF0,W
	btfss	STATUS, C
	goto	SysForLoopEnd3
ENDIF7
SysForLoop3
	incf	XCHAR,F
;GLCDDrawChar GLCDPrintLoc , CharLocY , Chars(xchar), LineColour
	banksel	GLCDPRINTLOC
	movf	GLCDPRINTLOC,W
	movwf	CHARLOCX
	movf	GLCDPRINTLOC_H,W
	movwf	CHARLOCX_H
	banksel	XCHAR
	movf	XCHAR,W
	addwf	SysCHARSHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysCHARSHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	CHARCODE
	movwf	CHARCODE
	pagesel	GLCDDRAWCHAR_ILI9326
	call	GLCDDRAWCHAR_ILI9326
	pagesel	$
;GLCDPrintIncrementPixelPositionMacro
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	movf	GLCDFONTWIDTH,W
	movwf	SysBYTETempA
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempB
	pagesel	SysMultSub
	call	SysMultSub
	pagesel	$
	movf	SysBYTETempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	GLCDPRINTLOC
	addwf	GLCDPRINTLOC,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	0
	banksel	GLCDPRINTLOC_H
	addwfc	GLCDPRINTLOC_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	banksel	GLCDFNTDEFAULTSIZE
	movf	GLCDFNTDEFAULTSIZE,W
	banksel	SYSTEMP2
	addwf	SysTemp2,W
	movwf	SysTemp1
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	SysTemp1_H
	movlw	1
	subwf	SysTemp1,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;next
	banksel	SYSCHARSHANDLER
	movf	SysCHARSHandler,W
	movwf	AFSR0
	movf	SysCHARSHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	subwf	XCHAR,W
	btfss	STATUS, C
	goto	SysForLoop3
ENDIF8
SysForLoopEnd3
;GLCDFontWidth = OldGLCDFontWidth
	banksel	OLDGLCDFONTWIDTH
	movf	OLDGLCDFONTWIDTH,W
	movwf	GLCDFONTWIDTH
	return

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
BIGFONT112_121
	movlw	240
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT112_121
	movwf	SysStringA
	movlw	(high TableBIGFONT112_121) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT112_121
	retlw	240
	retlw	0
	retlw	64
	retlw	192
	retlw	128
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	128
	retlw	255
	retlw	255
	retlw	255
	retlw	144
	retlw	16
	retlw	16
	retlw	31
	retlw	31
	retlw	15
	retlw	0
	retlw	128
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	128
	retlw	192
	retlw	64
	retlw	0
	retlw	0
	retlw	15
	retlw	31
	retlw	31
	retlw	16
	retlw	16
	retlw	144
	retlw	255
	retlw	255
	retlw	255
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	128
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	33
	retlw	0
	retlw	0
	retlw	1
	retlw	1
	retlw	1
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	25
	retlw	59
	retlw	35
	retlw	38
	retlw	38
	retlw	38
	retlw	60
	retlw	61
	retlw	25
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	64
	retlw	224
	retlw	240
	retlw	248
	retlw	64
	retlw	64
	retlw	64
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	32
	retlw	56
	retlw	56
	retlw	24
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	31
	retlw	63
	retlw	32
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	7
	retlw	15
	retlw	31
	retlw	56
	retlw	48
	retlw	56
	retlw	31
	retlw	15
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	7
	retlw	15
	retlw	63
	retlw	56
	retlw	56
	retlw	14
	retlw	56
	retlw	56
	retlw	63
	retlw	15
	retlw	7
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	48
	retlw	57
	retlw	63
	retlw	15
	retlw	15
	retlw	63
	retlw	57
	retlw	48
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	128
	retlw	135
	retlw	143
	retlw	159
	retlw	216
	retlw	248
	retlw	120
	retlw	63
	retlw	15
	retlw	7

;********************************************************************************

BIGFONT42_51
	movlw	240
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT42_51
	movwf	SysStringA
	movlw	(high TableBIGFONT42_51) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT42_51
	retlw	240
	retlw	128
	retlw	136
	retlw	144
	retlw	224
	retlw	224
	retlw	252
	retlw	252
	retlw	224
	retlw	224
	retlw	144
	retlw	136
	retlw	128
	retlw	1
	retlw	17
	retlw	9
	retlw	7
	retlw	7
	retlw	63
	retlw	63
	retlw	7
	retlw	7
	retlw	9
	retlw	17
	retlw	1
	retlw	0
	retlw	0
	retlw	128
	retlw	128
	retlw	128
	retlw	240
	retlw	240
	retlw	128
	retlw	128
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	1
	retlw	1
	retlw	15
	retlw	15
	retlw	1
	retlw	1
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	120
	retlw	120
	retlw	56
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	128
	retlw	128
	retlw	128
	retlw	128
	retlw	128
	retlw	128
	retlw	128
	retlw	128
	retlw	128
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	56
	retlw	56
	retlw	56
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	192
	retlw	224
	retlw	112
	retlw	56
	retlw	0
	retlw	32
	retlw	48
	retlw	56
	retlw	28
	retlw	14
	retlw	7
	retlw	3
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	252
	retlw	252
	retlw	4
	retlw	4
	retlw	4
	retlw	4
	retlw	252
	retlw	252
	retlw	248
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	31
	retlw	0
	retlw	0
	retlw	96
	retlw	96
	retlw	96
	retlw	240
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	24
	retlw	28
	retlw	28
	retlw	4
	retlw	4
	retlw	132
	retlw	204
	retlw	252
	retlw	120
	retlw	48
	retlw	0
	retlw	0
	retlw	48
	retlw	56
	retlw	60
	retlw	46
	retlw	39
	retlw	35
	retlw	33
	retlw	56
	retlw	56
	retlw	56
	retlw	0
	retlw	0
	retlw	24
	retlw	28
	retlw	28
	retlw	132
	retlw	132
	retlw	132
	retlw	204
	retlw	124
	retlw	120
	retlw	48
	retlw	0
	retlw	0
	retlw	24
	retlw	56
	retlw	56
	retlw	36
	retlw	33
	retlw	33
	retlw	51
	retlw	62
	retlw	30
	retlw	12

;********************************************************************************

BIGFONT52_61
	movlw	241
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT52_61
	movwf	SysStringA
	movlw	(high TableBIGFONT52_61) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT52_61
	retlw	240
	retlw	0
	retlw	128
	retlw	192
	retlw	96
	retlw	48
	retlw	24
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	3
	retlw	3
	retlw	3
	retlw	35
	retlw	35
	retlw	63
	retlw	63
	retlw	63
	retlw	35
	retlw	35
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	132
	retlw	132
	retlw	4
	retlw	4
	retlw	0
	retlw	0
	retlw	25
	retlw	57
	retlw	57
	retlw	36
	retlw	33
	retlw	33
	retlw	51
	retlw	63
	retlw	31
	retlw	14
	retlw	0
	retlw	0
	retlw	224
	retlw	240
	retlw	248
	retlw	156
	retlw	140
	retlw	132
	retlw	132
	retlw	132
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	36
	retlw	36
	retlw	33
	retlw	33
	retlw	63
	retlw	63
	retlw	31
	retlw	0
	retlw	0
	retlw	60
	retlw	60
	retlw	60
	retlw	4
	retlw	4
	retlw	4
	retlw	4
	retlw	132
	retlw	252
	retlw	252
	retlw	124
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	56
	retlw	60
	retlw	62
	retlw	7
	retlw	3
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	120
	retlw	124
	retlw	252
	retlw	196
	retlw	196
	retlw	132
	retlw	132
	retlw	252
	retlw	124
	retlw	120
	retlw	0
	retlw	0
	retlw	30
	retlw	62
	retlw	63
	retlw	33
	retlw	33
	retlw	35
	retlw	35
	retlw	63
	retlw	62
	retlw	30
	retlw	0
	retlw	0
	retlw	248
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	132
	retlw	252
	retlw	252
	retlw	248
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	36
	retlw	33
	retlw	33
	retlw	49
	retlw	57
	retlw	31
	retlw	15
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	112
	retlw	112
	retlw	112
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	14
	retlw	14
	retlw	14
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	112
	retlw	112
	retlw	112
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	16
	retlw	30
	retlw	30
	retlw	14
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	224
	retlw	112
	retlw	56
	retlw	28
	retlw	14
	retlw	6
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	3
	retlw	7
	retlw	14
	retlw	28
	retlw	56
	retlw	112
	retlw	96
	retlw	64
	retlw	0
	retlw	0
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	6
	retlw	6
	retlw	6
	retlw	6
	retlw	6
	retlw	6
	retlw	6
	retlw	6
	retlw	6
	retlw	6
	retlw	6
	retlw	6

;********************************************************************************

BIGFONT62_71
	movlw	240
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT62_71
	movwf	SysStringA
	movlw	(high TableBIGFONT62_71) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT62_71
	retlw	240
	retlw	0
	retlw	2
	retlw	6
	retlw	14
	retlw	28
	retlw	56
	retlw	112
	retlw	224
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	96
	retlw	112
	retlw	56
	retlw	28
	retlw	14
	retlw	7
	retlw	3
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	24
	retlw	28
	retlw	12
	retlw	14
	retlw	6
	retlw	134
	retlw	206
	retlw	252
	retlw	124
	retlw	56
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	115
	retlw	115
	retlw	115
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	254
	retlw	254
	retlw	2
	retlw	2
	retlw	194
	retlw	194
	retlw	194
	retlw	254
	retlw	254
	retlw	252
	retlw	0
	retlw	63
	retlw	63
	retlw	127
	retlw	96
	retlw	96
	retlw	99
	retlw	99
	retlw	99
	retlw	99
	retlw	67
	retlw	3
	retlw	0
	retlw	224
	retlw	240
	retlw	248
	retlw	28
	retlw	12
	retlw	12
	retlw	28
	retlw	248
	retlw	240
	retlw	224
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	2
	retlw	2
	retlw	2
	retlw	2
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	252
	retlw	252
	retlw	120
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	36
	retlw	33
	retlw	33
	retlw	63
	retlw	63
	retlw	30
	retlw	0
	retlw	0
	retlw	240
	retlw	248
	retlw	252
	retlw	12
	retlw	4
	retlw	4
	retlw	4
	retlw	28
	retlw	28
	retlw	24
	retlw	0
	retlw	0
	retlw	15
	retlw	31
	retlw	63
	retlw	48
	retlw	32
	retlw	32
	retlw	32
	retlw	56
	retlw	56
	retlw	24
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	4
	retlw	12
	retlw	252
	retlw	248
	retlw	240
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	48
	retlw	63
	retlw	31
	retlw	15
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	196
	retlw	204
	retlw	28
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	36
	retlw	33
	retlw	33
	retlw	35
	retlw	51
	retlw	56
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	196
	retlw	204
	retlw	28
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	33
	retlw	1
	retlw	1
	retlw	3
	retlw	3
	retlw	0
	retlw	0
	retlw	0
	retlw	240
	retlw	248
	retlw	252
	retlw	12
	retlw	4
	retlw	4
	retlw	4
	retlw	60
	retlw	60
	retlw	56
	retlw	0
	retlw	0
	retlw	15
	retlw	31
	retlw	63
	retlw	48
	retlw	32
	retlw	34
	retlw	34
	retlw	62
	retlw	62
	retlw	62

;********************************************************************************

BIGFONT72_81
	movlw	241
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT72_81
	movwf	SysStringA
	movlw	(high TableBIGFONT72_81) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT72_81
	retlw	240
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	128
	retlw	128
	retlw	128
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	1
	retlw	1
	retlw	1
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	4
	retlw	30
	retlw	30
	retlw	62
	retlw	32
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	192
	retlw	224
	retlw	112
	retlw	60
	retlw	28
	retlw	12
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	3
	retlw	7
	retlw	14
	retlw	60
	retlw	56
	retlw	48
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	48
	retlw	56
	retlw	60
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	120
	retlw	240
	retlw	224
	retlw	240
	retlw	120
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	112
	retlw	224
	retlw	192
	retlw	128
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	1
	retlw	3
	retlw	7
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	224
	retlw	240
	retlw	248
	retlw	28
	retlw	12
	retlw	12
	retlw	12
	retlw	28
	retlw	248
	retlw	240
	retlw	224
	retlw	0
	retlw	7
	retlw	15
	retlw	31
	retlw	56
	retlw	48
	retlw	48
	retlw	48
	retlw	56
	retlw	31
	retlw	15
	retlw	7
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	252
	retlw	252
	retlw	120
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	33
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	248
	retlw	248
	retlw	28
	retlw	12
	retlw	4
	retlw	12
	retlw	28
	retlw	248
	retlw	248
	retlw	224
	retlw	0
	retlw	7
	retlw	31
	retlw	31
	retlw	24
	retlw	24
	retlw	92
	retlw	94
	retlw	126
	retlw	127
	retlw	127
	retlw	71

;********************************************************************************

CIRCLE
;dim  radiusErr, xradius as Integer
;xradius = Inxradius
	movf	INXRADIUS,W
	banksel	XRADIUS
	movwf	XRADIUS
	banksel	INXRADIUS_H
	movf	INXRADIUS_H,W
	banksel	XRADIUS_H
	movwf	XRADIUS_H
;radiusErr = -(xradius/2)
	movf	XRADIUS,W
	movwf	SysINTEGERTempA
	movf	XRADIUS_H,W
	movwf	SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SysDivSubINT
	call	SysDivSubINT
	pagesel	$
	movf	SysINTEGERTempA,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysINTEGERTempA_H,W
	movwf	SysTemp1_H
	comf	SysTemp1,W
	movwf	RADIUSERR
	comf	SysTemp1_H,W
	movwf	RADIUSERR_H
	incf	RADIUSERR,F
	btfsc	STATUS,Z
	incf	RADIUSERR_H,F
;Do While xradius >=  yordinate
SysDoLoop_S2
	movf	xradius,W
	movwf	SysINTEGERTempA
	movf	xradius_H,W
	movwf	SysINTEGERTempA_H
	movf	yordinate,W
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	SysDoLoop_E2
;Pset ((xoffset + xradius), (yoffset + yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	XRADIUS_H
	movf	XRADIUS_H,W
	addwfc	XOFFSET_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	YORDINATE
	movf	YORDINATE,W
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Pset ((xoffset + yordinate), (yoffset + xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	movlw	0
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	XRADIUS_H
	movf	XRADIUS_H,W
	addwfc	YOFFSET_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Pset ((xoffset - xradius), (yoffset + yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	XRADIUS_H
	movf	XRADIUS_H,W
	subwfb	XOFFSET_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	YORDINATE
	movf	YORDINATE,W
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Pset ((xoffset - yordinate), (yoffset + xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	movlw	0
	banksel	XOFFSET_H
	subwfb	XOFFSET_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	XRADIUS_H
	movf	XRADIUS_H,W
	addwfc	YOFFSET_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Pset ((xoffset - xradius), (yoffset - yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	XRADIUS_H
	movf	XRADIUS_H,W
	subwfb	XOFFSET_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	YORDINATE
	movf	YORDINATE,W
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Pset ((xoffset - yordinate), (yoffset - xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	movlw	0
	banksel	XOFFSET_H
	subwfb	XOFFSET_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	XRADIUS
	movf	XRADIUS,W
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	XRADIUS_H
	movf	XRADIUS_H,W
	subwfb	YOFFSET_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Pset ((xoffset + xradius), (yoffset - yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	XRADIUS_H
	movf	XRADIUS_H,W
	addwfc	XOFFSET_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	YORDINATE
	movf	YORDINATE,W
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Pset ((xoffset + yordinate), (yoffset - xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	movlw	0
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	XRADIUS
	movf	XRADIUS,W
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	XRADIUS_H
	movf	XRADIUS_H,W
	subwfb	YOFFSET_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;yordinate ++
	banksel	YORDINATE
	incf	YORDINATE,F
;If radiusErr < 0 Then
	movf	RADIUSERR,W
	movwf	SysINTEGERTempA
	movf	RADIUSERR_H,W
	movwf	SysINTEGERTempA_H
	clrf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE39_1
;radiusErr = radiusErr + 2 * yordinate + 1
	bcf	STATUS,C
	banksel	YORDINATE
	rlf	YORDINATE,W
	movwf	SysTemp3
	addwf	RADIUSERR,W
	movwf	SysTemp1
	movlw	0
	addwfc	RADIUSERR_H,W
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	movwf	RADIUSERR
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	RADIUSERR_H
;else
	goto	ENDIF39
ELSE39_1
;xradius --
	movlw	1
	banksel	XRADIUS
	subwf	XRADIUS,F
	movlw	0
	subwfb	XRADIUS_H,F
;radiusErr = radiusErr + 2 * (yordinate - xradius + 1)
	movf	XRADIUS,W
	subwf	YORDINATE,W
	movwf	SysTemp1
	clrf	SysTemp3
	movf	XRADIUS_H,W
	subwfb	SysTemp3,W
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	movwf	SysTemp2
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	SysTemp2_H
	movf	SysTemp2,W
	movwf	SysINTEGERTempA
	movf	SysTemp2_H,W
	movwf	SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SysMultSubINT
	call	SysMultSubINT
	pagesel	$
	movf	SysINTEGERTempX,W
	banksel	RADIUSERR
	addwf	RADIUSERR,F
	movf	SysINTEGERTempX_H,W
	addwfc	RADIUSERR_H,F
;end if
ENDIF39
;Loop
	goto	SysDoLoop_S2
SysDoLoop_E2
	return

;********************************************************************************

FILLEDBOX_ILI9326
;dim GLCDTemp, DrawLine as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	movf	LINEX1,W
	movwf	SysWORDTempB
	movf	LINEX1_H,W
	movwf	SysWORDTempB_H
	movf	LINEX2,W
	movwf	SysWORDTempA
	movf	LINEX2_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF1
;GLCDTemp = LineX1
	movf	LINEX1,W
	movwf	GLCDTEMP
	movf	LINEX1_H,W
	movwf	GLCDTEMP_H
;LineX1 = LineX2
	movf	LINEX2,W
	movwf	LINEX1
	movf	LINEX2_H,W
	movwf	LINEX1_H
;LineX2 = GLCDTemp
	movf	GLCDTEMP,W
	movwf	LINEX2
	movf	GLCDTEMP_H,W
	movwf	LINEX2_H
;End If
ENDIF1
;If LineY1 > LineY2 Then
	movf	LINEY1,W
	movwf	SysWORDTempB
	movf	LINEY1_H,W
	movwf	SysWORDTempB_H
	movf	LINEY2,W
	movwf	SysWORDTempA
	movf	LINEY2_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF2
;GLCDTemp = LineY1
	movf	LINEY1,W
	movwf	GLCDTEMP
	movf	LINEY1_H,W
	movwf	GLCDTEMP_H
;LineY1 = LineY2
	movf	LINEY2,W
	movwf	LINEY1
	movf	LINEY2_H,W
	movwf	LINEY1_H
;LineY2 = GLCDTemp
	movf	GLCDTEMP,W
	movwf	LINEY2
	movf	GLCDTEMP_H,W
	movwf	LINEY2_H
;End If
ENDIF2
;Draw lines going across
;For DrawLine = LineX1 To LineX2
	movlw	1
	subwf	LINEX1,W
	movwf	DRAWLINE
	movlw	0
	subwfb	LINEX1_H,W
	movwf	DRAWLINE_H
	movf	LINEX1,W
	movwf	SysWORDTempB
	movf	LINEX1_H,W
	movwf	SysWORDTempB_H
	movf	LINEX2,W
	movwf	SysWORDTempA
	movf	LINEX2_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd1
ENDIF3
SysForLoop1
	incf	DRAWLINE,F
	btfsc	STATUS,Z
	incf	DRAWLINE_H,F
;For GLCDTemp = LineY1 To LineY2
	movlw	1
	subwf	LINEY1,W
	movwf	GLCDTEMP
	movlw	0
	subwfb	LINEY1_H,W
	movwf	GLCDTEMP_H
	movf	LINEY1,W
	movwf	SysWORDTempB
	movf	LINEY1_H,W
	movwf	SysWORDTempB_H
	movf	LINEY2,W
	movwf	SysWORDTempA
	movf	LINEY2_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd2
ENDIF4
SysForLoop2
	incf	GLCDTEMP,F
	btfsc	STATUS,Z
	incf	GLCDTEMP_H,F
;PSet DrawLine, GLCDTemp, LineColour
	movf	DRAWLINE,W
	movwf	GLCDX
	movf	DRAWLINE_H,W
	movwf	GLCDX_H
	movf	GLCDTEMP,W
	movwf	GLCDY
	movf	GLCDTEMP_H,W
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Next
	movf	GLCDTEMP,W
	movwf	SysWORDTempA
	movf	GLCDTEMP_H,W
	movwf	SysWORDTempA_H
	movf	LINEY2,W
	movwf	SysWORDTempB
	movf	LINEY2_H,W
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop2
ENDIF5
SysForLoopEnd2
;Next
	movf	DRAWLINE,W
	movwf	SysWORDTempA
	movf	DRAWLINE_H,W
	movwf	SysWORDTempA_H
	movf	LINEX2,W
	movwf	SysWORDTempB
	movf	LINEX2_H,W
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop1
ENDIF6
SysForLoopEnd1
	return

;********************************************************************************

LINE
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	clrf	LINEDIFFX
	clrf	LINEDIFFX_H
;LineDiffY = 0
	clrf	LINEDIFFY
	clrf	LINEDIFFY_H
;LineStepX = 0
	clrf	LINESTEPX
	clrf	LINESTEPX_H
;LineStepY = 0
	clrf	LINESTEPY
	clrf	LINESTEPY_H
;LineDiffX_x2 = 0
	clrf	LINEDIFFX_X2
	clrf	LINEDIFFX_X2_H
;LineDiffY_x2 = 0
	clrf	LINEDIFFY_X2
	clrf	LINEDIFFY_X2_H
;LineErr = 0
	clrf	LINEERR
	clrf	LINEERR_H
;LineDiffX =  LineX2 -   LineX1
	movf	LINEX1,W
	subwf	LINEX2,W
	movwf	LINEDIFFX
	movf	LINEX1_H,W
	subwfb	LINEX2_H,W
	movwf	LINEDIFFX_H
;LineDiffY =  LineY2 -   LineY1
	movf	LINEY1,W
	subwf	LINEY2,W
	movwf	LINEDIFFY
	movf	LINEY1_H,W
	subwfb	LINEY2_H,W
	movwf	LINEDIFFY_H
;if (LineDiffX > 0) then
	movf	LINEDIFFX,W
	movwf	SysINTEGERTempB
	movf	LINEDIFFX_H,W
	movwf	SysINTEGERTempB_H
	clrf	SysINTEGERTempA
	clrf	SysINTEGERTempA_H
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE40_1
;LineStepX = 1
	movlw	1
	movwf	LINESTEPX
	clrf	LINESTEPX_H
;else
	goto	ENDIF40
ELSE40_1
;LineStepX = -1
	movlw	255
	movwf	LINESTEPX
	movwf	LINESTEPX_H
;end if
ENDIF40
;if (LineDiffY > 0) then
	movf	LINEDIFFY,W
	movwf	SysINTEGERTempB
	movf	LINEDIFFY_H,W
	movwf	SysINTEGERTempB_H
	clrf	SysINTEGERTempA
	clrf	SysINTEGERTempA_H
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE41_1
;LineStepY = 1
	movlw	1
	movwf	LINESTEPY
	clrf	LINESTEPY_H
;else
	goto	ENDIF41
ELSE41_1
;LineStepY = -1
	movlw	255
	movwf	LINESTEPY
	movwf	LINESTEPY_H
;end if
ENDIF41
;LineDiffX = LineStepX * LineDiffX
	movf	LINESTEPX,W
	movwf	SysINTEGERTempA
	movf	LINESTEPX_H,W
	movwf	SysINTEGERTempA_H
	movf	LINEDIFFX,W
	movwf	SysINTEGERTempB
	movf	LINEDIFFX_H,W
	movwf	SysINTEGERTempB_H
	pagesel	SysMultSubINT
	call	SysMultSubINT
	pagesel	$
	movf	SysINTEGERTempX,W
	movwf	LINEDIFFX
	movf	SysINTEGERTempX_H,W
	movwf	LINEDIFFX_H
;LineDiffY = LineStepY * LineDiffY
	movf	LINESTEPY,W
	movwf	SysINTEGERTempA
	movf	LINESTEPY_H,W
	movwf	SysINTEGERTempA_H
	movf	LINEDIFFY,W
	movwf	SysINTEGERTempB
	movf	LINEDIFFY_H,W
	movwf	SysINTEGERTempB_H
	pagesel	SysMultSubINT
	call	SysMultSubINT
	pagesel	$
	movf	SysINTEGERTempX,W
	movwf	LINEDIFFY
	movf	SysINTEGERTempX_H,W
	movwf	LINEDIFFY_H
;LineDiffX_x2 = LineDiffX*2
	movf	LINEDIFFX,W
	movwf	SysINTEGERTempA
	movf	LINEDIFFX_H,W
	movwf	SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	pagesel	SysMultSubINT
	call	SysMultSubINT
	pagesel	$
	movf	SysINTEGERTempX,W
	movwf	LINEDIFFX_X2
	movf	SysINTEGERTempX_H,W
	movwf	LINEDIFFX_X2_H
;LineDiffY_x2 = LineDiffY*2
	movf	LINEDIFFY,W
	movwf	SysINTEGERTempA
	movf	LINEDIFFY_H,W
	movwf	SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	pagesel	SysMultSubINT
	call	SysMultSubINT
	pagesel	$
	movf	SysINTEGERTempX,W
	movwf	LINEDIFFY_X2
	movf	SysINTEGERTempX_H,W
	movwf	LINEDIFFY_X2_H
;if ( LineDiffX >= LineDiffY) then
	movf	LINEDIFFX,W
	movwf	SysINTEGERTempA
	movf	LINEDIFFX_H,W
	movwf	SysINTEGERTempA_H
	movf	LINEDIFFY,W
	movwf	SysINTEGERTempB
	movf	LINEDIFFY_H,W
	movwf	SysINTEGERTempB_H
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ELSE42_1
;LineErr = LineDiffY_x2 - LineDiffX
	movf	LINEDIFFX,W
	subwf	LINEDIFFY_X2,W
	movwf	LINEERR
	movf	LINEDIFFX_H,W
	subwfb	LINEDIFFY_X2_H,W
	movwf	LINEERR_H
;do while (   LineX1 <>  LineX2 )
SysDoLoop_S3
	movf	linex1,W
	movwf	SysWORDTempA
	movf	linex1_H,W
	movwf	SysWORDTempA_H
	movf	linex2,W
	movwf	SysWORDTempB
	movf	linex2_H,W
	movwf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	SysDoLoop_E3
;PSet (   LineX1,   LineY1, LineColour )
	movf	LINEX1,W
	movwf	GLCDX
	movf	LINEX1_H,W
	movwf	GLCDX_H
	movf	LINEY1,W
	movwf	GLCDY
	movf	LINEY1_H,W
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;LineX1 += LineStepX
	movf	LINESTEPX,W
	addwf	LINEX1,F
	movf	LINESTEPX_H,W
	addwfc	LINEX1_H,F
;if ( LineErr < 0) then
	movf	LINEERR,W
	movwf	SysINTEGERTempA
	movf	LINEERR_H,W
	movwf	SysINTEGERTempA_H
	clrf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE43_1
;LineErr += LineDiffY_x2
	movf	LINEDIFFY_X2,W
	addwf	LINEERR,F
	movf	LINEDIFFY_X2_H,W
	addwfc	LINEERR_H,F
;else
	goto	ENDIF43
ELSE43_1
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	movf	LINEDIFFX_X2,W
	subwf	LINEDIFFY_X2,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	LINEDIFFX_X2_H
	movf	LINEDIFFX_X2_H,W
	subwfb	LINEDIFFY_X2_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movf	SysTemp1,W
	banksel	LINEERR
	addwf	LINEERR,F
	banksel	SYSTEMP1_H
	movf	SysTemp1_H,W
	banksel	LINEERR_H
	addwfc	LINEERR_H,F
;LineY1 += LineStepY
	movf	LINESTEPY,W
	addwf	LINEY1,F
	movf	LINESTEPY_H,W
	addwfc	LINEY1_H,F
;end if
ENDIF43
;loop
	goto	SysDoLoop_S3
SysDoLoop_E3
;PSet (   LineX1,   LineY1, LineColour )
	movf	LINEX1,W
	movwf	GLCDX
	movf	LINEX1_H,W
	movwf	GLCDX_H
	movf	LINEY1,W
	movwf	GLCDY
	movf	LINEY1_H,W
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;else
	goto	ENDIF42
ELSE42_1
;LineErr = LineDiffX_x2 - LineDiffY
	movf	LINEDIFFY,W
	subwf	LINEDIFFX_X2,W
	movwf	LINEERR
	movf	LINEDIFFY_H,W
	subwfb	LINEDIFFX_X2_H,W
	movwf	LINEERR_H
;do while (   LineY1 <>  LineY2)
SysDoLoop_S4
	movf	liney1,W
	movwf	SysWORDTempA
	movf	liney1_H,W
	movwf	SysWORDTempA_H
	movf	liney2,W
	movwf	SysWORDTempB
	movf	liney2_H,W
	movwf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	SysDoLoop_E4
;PSet (   LineX1,   LineY1, LineColour )
	movf	LINEX1,W
	movwf	GLCDX
	movf	LINEX1_H,W
	movwf	GLCDX_H
	movf	LINEY1,W
	movwf	GLCDY
	movf	LINEY1_H,W
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;LineY1 += LineStepY
	movf	LINESTEPY,W
	addwf	LINEY1,F
	movf	LINESTEPY_H,W
	addwfc	LINEY1_H,F
;if ( LineErr < 0) then
	movf	LINEERR,W
	movwf	SysINTEGERTempA
	movf	LINEERR_H,W
	movwf	SysINTEGERTempA_H
	clrf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE44_1
;LineErr += LineDiffX_x2
	movf	LINEDIFFX_X2,W
	addwf	LINEERR,F
	movf	LINEDIFFX_X2_H,W
	addwfc	LINEERR_H,F
;else
	goto	ENDIF44
ELSE44_1
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	movf	LINEDIFFY_X2,W
	subwf	LINEDIFFX_X2,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	LINEDIFFY_X2_H
	movf	LINEDIFFY_X2_H,W
	subwfb	LINEDIFFX_X2_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movf	SysTemp1,W
	banksel	LINEERR
	addwf	LINEERR,F
	banksel	SYSTEMP1_H
	movf	SysTemp1_H,W
	banksel	LINEERR_H
	addwfc	LINEERR_H,F
;LineX1 += LineStepX
	movf	LINESTEPX,W
	addwf	LINEX1,F
	movf	LINESTEPX_H,W
	addwfc	LINEX1_H,F
;end if
ENDIF44
;loop
	goto	SysDoLoop_S4
SysDoLoop_E4
;PSet (   LineX1,   LineY1, LineColour )
	movf	LINEX1,W
	movwf	GLCDX
	movf	LINEX1_H,W
	movwf	GLCDX_H
	movf	LINEY1,W
	movwf	GLCDY
	movf	LINEY1_H,W
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;end if
ENDIF42
	return

;********************************************************************************

;Start of program memory page 3
	ORG	6144
BIGFONT102_111
	movlw	239
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT102_111
	movwf	SysStringA
	movlw	(high TableBIGFONT102_111) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT102_111
	retlw	240
	retlw	0
	retlw	128
	retlw	128
	retlw	248
	retlw	252
	retlw	252
	retlw	132
	retlw	156
	retlw	156
	retlw	24
	retlw	0
	retlw	0
	retlw	0
	retlw	33
	retlw	33
	retlw	63
	retlw	63
	retlw	63
	retlw	33
	retlw	33
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	128
	retlw	192
	retlw	64
	retlw	0
	retlw	0
	retlw	71
	retlw	207
	retlw	223
	retlw	152
	retlw	152
	retlw	152
	retlw	255
	retlw	255
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	128
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	1
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	64
	retlw	64
	retlw	220
	retlw	220
	retlw	220
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	64
	retlw	64
	retlw	220
	retlw	220
	retlw	220
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	96
	retlw	224
	retlw	128
	retlw	128
	retlw	192
	retlw	255
	retlw	255
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	192
	retlw	64
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	2
	retlw	7
	retlw	15
	retlw	61
	retlw	56
	retlw	48
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	4
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	192
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	63
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	31

;********************************************************************************

BIGFONT122_126
	movlw	109
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT122_126
	movwf	SysStringA
	movlw	(high TableBIGFONT122_126) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT122_126
	retlw	120
	retlw	0
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	49
	retlw	56
	retlw	60
	retlw	46
	retlw	39
	retlw	35
	retlw	49
	retlw	56
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	128
	retlw	192
	retlw	120
	retlw	124
	retlw	60
	retlw	4
	retlw	4
	retlw	4
	retlw	4
	retlw	0
	retlw	0
	retlw	1
	retlw	1
	retlw	3
	retlw	30
	retlw	62
	retlw	60
	retlw	32
	retlw	32
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	254
	retlw	254
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	127
	retlw	127
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	4
	retlw	4
	retlw	4
	retlw	60
	retlw	124
	retlw	120
	retlw	192
	retlw	128
	retlw	128
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	32
	retlw	32
	retlw	60
	retlw	62
	retlw	30
	retlw	3
	retlw	1
	retlw	1
	retlw	0
	retlw	56
	retlw	60
	retlw	60
	retlw	4
	retlw	12
	retlw	28
	retlw	56
	retlw	48
	retlw	32
	retlw	60
	retlw	60
	retlw	28

;********************************************************************************

BIGFONT193_202
	movlw	240
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT193_202
	movwf	SysStringA
	movlw	(high TableBIGFONT193_202) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT193_202
	retlw	240
	retlw	0
	retlw	224
	retlw	240
	retlw	248
	retlw	28
	retlw	12
	retlw	12
	retlw	28
	retlw	248
	retlw	240
	retlw	224
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	2
	retlw	2
	retlw	2
	retlw	2
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	252
	retlw	252
	retlw	120
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	36
	retlw	36
	retlw	36
	retlw	63
	retlw	63
	retlw	30
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	12
	retlw	12
	retlw	12
	retlw	12
	retlw	12
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	240
	retlw	248
	retlw	28
	retlw	12
	retlw	12
	retlw	28
	retlw	248
	retlw	240
	retlw	224
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	48
	retlw	48
	retlw	48
	retlw	48
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	196
	retlw	204
	retlw	28
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	36
	retlw	36
	retlw	36
	retlw	35
	retlw	51
	retlw	56
	retlw	0
	retlw	0
	retlw	60
	retlw	28
	retlw	12
	retlw	4
	retlw	132
	retlw	196
	retlw	228
	retlw	124
	retlw	60
	retlw	28
	retlw	0
	retlw	0
	retlw	56
	retlw	60
	retlw	62
	retlw	39
	retlw	35
	retlw	36
	retlw	32
	retlw	48
	retlw	56
	retlw	60
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	128
	retlw	128
	retlw	128
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	1
	retlw	1
	retlw	1
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	240
	retlw	248
	retlw	156
	retlw	140
	retlw	140
	retlw	140
	retlw	156
	retlw	248
	retlw	240
	retlw	224
	retlw	0
	retlw	7
	retlw	15
	retlw	31
	retlw	57
	retlw	49
	retlw	49
	retlw	49
	retlw	57
	retlw	31
	retlw	15
	retlw	7
	retlw	0
	retlw	0
	retlw	4
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	192
	retlw	224
	retlw	112
	retlw	60
	retlw	28
	retlw	12
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	3
	retlw	7
	retlw	14
	retlw	60
	retlw	56
	retlw	48

;********************************************************************************

BIGFONT203_212
	movlw	238
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT203_212
	movwf	SysStringA
	movlw	(high TableBIGFONT203_212) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT203_212
	retlw	240
	retlw	0
	retlw	224
	retlw	240
	retlw	248
	retlw	28
	retlw	12
	retlw	12
	retlw	28
	retlw	248
	retlw	240
	retlw	224
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	120
	retlw	240
	retlw	224
	retlw	240
	retlw	120
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	112
	retlw	224
	retlw	192
	retlw	128
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	1
	retlw	3
	retlw	7
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	28
	retlw	28
	retlw	156
	retlw	156
	retlw	156
	retlw	156
	retlw	156
	retlw	28
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	56
	retlw	56
	retlw	57
	retlw	57
	retlw	57
	retlw	57
	retlw	57
	retlw	56
	retlw	56
	retlw	0
	retlw	0
	retlw	224
	retlw	240
	retlw	248
	retlw	28
	retlw	12
	retlw	12
	retlw	12
	retlw	28
	retlw	248
	retlw	240
	retlw	224
	retlw	0
	retlw	7
	retlw	15
	retlw	31
	retlw	56
	retlw	48
	retlw	48
	retlw	48
	retlw	56
	retlw	31
	retlw	15
	retlw	7
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	28
	retlw	28
	retlw	28
	retlw	28
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	252
	retlw	252
	retlw	120
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	36
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	60
	retlw	124
	retlw	252
	retlw	220
	retlw	156
	retlw	156
	retlw	28
	retlw	28
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	60
	retlw	62
	retlw	63
	retlw	59
	retlw	57
	retlw	57
	retlw	56
	retlw	56
	retlw	56
	retlw	0
	retlw	0
	retlw	28
	retlw	12
	retlw	4
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	4
	retlw	12
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	124
	retlw	252
	retlw	252
	retlw	128
	retlw	0
	retlw	128
	retlw	252
	retlw	252
	retlw	124
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	36
	retlw	63
	retlw	63
	retlw	63
	retlw	36
	retlw	32

;********************************************************************************

BIGFONT32_41
	movlw	239
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT32_41
	movwf	SysStringA
	movlw	(high TableBIGFONT32_41) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT32_41
	retlw	240
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	252
	retlw	252
	retlw	252
	retlw	248
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	115
	retlw	115
	retlw	115
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	30
	retlw	62
	retlw	62
	retlw	0
	retlw	0
	retlw	0
	retlw	62
	retlw	62
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
	retlw	48
	retlw	48
	retlw	254
	retlw	254
	retlw	48
	retlw	48
	retlw	48
	retlw	48
	retlw	254
	retlw	254
	retlw	48
	retlw	48
	retlw	12
	retlw	12
	retlw	127
	retlw	127
	retlw	12
	retlw	12
	retlw	12
	retlw	12
	retlw	127
	retlw	127
	retlw	12
	retlw	12
	retlw	0
	retlw	240
	retlw	248
	retlw	152
	retlw	254
	retlw	152
	retlw	152
	retlw	254
	retlw	152
	retlw	152
	retlw	24
	retlw	0
	retlw	0
	retlw	24
	retlw	25
	retlw	25
	retlw	127
	retlw	25
	retlw	25
	retlw	127
	retlw	25
	retlw	31
	retlw	15
	retlw	0
	retlw	0
	retlw	0
	retlw	56
	retlw	56
	retlw	56
	retlw	128
	retlw	192
	retlw	224
	retlw	112
	retlw	56
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	28
	retlw	14
	retlw	7
	retlw	3
	retlw	1
	retlw	28
	retlw	28
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	56
	retlw	252
	retlw	196
	retlw	196
	retlw	252
	retlw	56
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	0
	retlw	0
	retlw	30
	retlw	63
	retlw	33
	retlw	33
	retlw	51
	retlw	63
	retlw	30
	retlw	30
	retlw	55
	retlw	35
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	60
	retlw	60
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	224
	retlw	240
	retlw	56
	retlw	28
	retlw	12
	retlw	4
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	3
	retlw	7
	retlw	15
	retlw	28
	retlw	56
	retlw	48
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	4
	retlw	12
	retlw	28
	retlw	56
	retlw	240
	retlw	224
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	48
	retlw	56
	retlw	28
	retlw	15
	retlw	7
	retlw	3

;********************************************************************************

BIGFONT82_91
	movlw	239
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT82_91
	movwf	SysStringA
	movlw	(high TableBIGFONT82_91) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT82_91
	retlw	240
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	252
	retlw	252
	retlw	120
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	1
	retlw	1
	retlw	3
	retlw	63
	retlw	63
	retlw	60
	retlw	0
	retlw	0
	retlw	120
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	132
	retlw	188
	retlw	60
	retlw	56
	retlw	0
	retlw	0
	retlw	28
	retlw	60
	retlw	61
	retlw	36
	retlw	36
	retlw	33
	retlw	33
	retlw	63
	retlw	63
	retlw	30
	retlw	0
	retlw	0
	retlw	28
	retlw	12
	retlw	4
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	4
	retlw	12
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	7
	retlw	15
	retlw	31
	retlw	56
	retlw	48
	retlw	56
	retlw	31
	retlw	15
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	128
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	3
	retlw	15
	retlw	63
	retlw	60
	retlw	60
	retlw	15
	retlw	60
	retlw	60
	retlw	63
	retlw	15
	retlw	3
	retlw	0
	retlw	28
	retlw	60
	retlw	124
	retlw	224
	retlw	192
	retlw	224
	retlw	124
	retlw	60
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	56
	retlw	60
	retlw	62
	retlw	7
	retlw	3
	retlw	7
	retlw	62
	retlw	60
	retlw	56
	retlw	0
	retlw	0
	retlw	0
	retlw	124
	retlw	252
	retlw	252
	retlw	128
	retlw	0
	retlw	128
	retlw	252
	retlw	252
	retlw	124
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	33
	retlw	63
	retlw	63
	retlw	63
	retlw	33
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	60
	retlw	28
	retlw	12
	retlw	4
	retlw	132
	retlw	196
	retlw	228
	retlw	124
	retlw	60
	retlw	28
	retlw	0
	retlw	0
	retlw	56
	retlw	60
	retlw	62
	retlw	39
	retlw	35
	retlw	33
	retlw	32
	retlw	48
	retlw	56
	retlw	60
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	4
	retlw	4
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	32

;********************************************************************************

BIGFONT92_101
	movlw	239
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT92_101
	movwf	SysStringA
	movlw	(high TableBIGFONT92_101) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT92_101
	retlw	240
	retlw	0
	retlw	28
	retlw	56
	retlw	112
	retlw	224
	retlw	192
	retlw	128
	retlw	0
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
	retlw	3
	retlw	7
	retlw	14
	retlw	28
	retlw	24
	retlw	48
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	4
	retlw	4
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	48
	retlw	56
	retlw	28
	retlw	14
	retlw	14
	retlw	28
	retlw	56
	retlw	48
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	12
	retlw	12
	retlw	60
	retlw	48
	retlw	48
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	64
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	28
	retlw	62
	retlw	62
	retlw	34
	retlw	34
	retlw	34
	retlw	63
	retlw	31
	retlw	63
	retlw	32
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	31
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	31
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	57
	retlw	57
	retlw	25
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	68
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	31
	retlw	63
	retlw	32
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	34
	retlw	34
	retlw	34
	retlw	59
	retlw	59
	retlw	27

;********************************************************************************

BIGPRINT_ILI9326
;Dim GLCDPrintLoc, SysPrintTemp as word
;Dim PrintLen as byte
;PrintLen = PrintData(0)
	banksel	SYSPRINTDATAHANDLER
	movf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	PRINTLEN
	movwf	PRINTLEN
;If PrintLen = 0 Then Exit Sub
	movf	PRINTLEN,F
	btfsc	STATUS, Z
	return
ENDIF9
;GLCDPrintLoc = PrintLocX
	banksel	PRINTLOCX
	movf	PRINTLOCX,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	banksel	PRINTLOCX_H
	movf	PRINTLOCX_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;For SysPrintTemp = 1 To PrintLen
	banksel	SYSPRINTTEMP
	clrf	SYSPRINTTEMP
	clrf	SYSPRINTTEMP_H
	movlw	1
	banksel	PRINTLEN
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd4
ENDIF10
SysForLoop4
	banksel	SYSPRINTTEMP
	incf	SYSPRINTTEMP,F
	btfsc	STATUS,Z
	incf	SYSPRINTTEMP_H,F
;DrawBigChar_ILI9326 GLCDPrintLoc, PrintLocY, PrintData(SysPrintTemp), Color
	banksel	GLCDPRINTLOC
	movf	GLCDPRINTLOC,W
	movwf	CHARLOCX
	movf	GLCDPRINTLOC_H,W
	movwf	CHARLOCX_H
	banksel	PRINTLOCY
	movf	PRINTLOCY,W
	banksel	CHARLOCY
	movwf	CHARLOCY
	banksel	PRINTLOCY_H
	movf	PRINTLOCY_H,W
	banksel	CHARLOCY_H
	movwf	CHARLOCY_H
	banksel	SYSPRINTTEMP
	movf	SYSPRINTTEMP,W
	addwf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movf	SYSPRINTTEMP_H,W
	addwfc	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	CHARCODE
	movwf	CHARCODE
	pagesel	DRAWBIGCHAR_ILI9326
	call	DRAWBIGCHAR_ILI9326
	pagesel	$
;GLCDPrintLoc += 13
	movlw	13
	addwf	GLCDPRINTLOC,F
	movlw	0
	addwfc	GLCDPRINTLOC_H,F
;Next
	banksel	SYSPRINTTEMP
	movf	SYSPRINTTEMP,W
	movwf	SysWORDTempA
	movf	SYSPRINTTEMP_H,W
	movwf	SysWORDTempA_H
	banksel	PRINTLEN
	movf	PRINTLEN,W
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop4
ENDIF11
SysForLoopEnd4
	return

;********************************************************************************

BOX
;dim GLCDTemp as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	movf	LINEX1,W
	movwf	SysWORDTempB
	movf	LINEX1_H,W
	movwf	SysWORDTempB_H
	movf	LINEX2,W
	movwf	SysWORDTempA
	movf	LINEX2_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF33
;GLCDTemp = LineX1
	movf	LINEX1,W
	movwf	GLCDTEMP
	movf	LINEX1_H,W
	movwf	GLCDTEMP_H
;LineX1 = LineX2
	movf	LINEX2,W
	movwf	LINEX1
	movf	LINEX2_H,W
	movwf	LINEX1_H
;LineX2 = GLCDTemp
	movf	GLCDTEMP,W
	movwf	LINEX2
	movf	GLCDTEMP_H,W
	movwf	LINEX2_H
;End If
ENDIF33
;If LineY1 > LineY2 Then
	movf	LINEY1,W
	movwf	SysWORDTempB
	movf	LINEY1_H,W
	movwf	SysWORDTempB_H
	movf	LINEY2,W
	movwf	SysWORDTempA
	movf	LINEY2_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF34
;GLCDTemp = LineY1
	movf	LINEY1,W
	movwf	GLCDTEMP
	movf	LINEY1_H,W
	movwf	GLCDTEMP_H
;LineY1 = LineY2
	movf	LINEY2,W
	movwf	LINEY1
	movf	LINEY2_H,W
	movwf	LINEY1_H
;LineY2 = GLCDTemp
	movf	GLCDTEMP,W
	movwf	LINEY2
	movf	GLCDTEMP_H,W
	movwf	LINEY2_H
;End If
ENDIF34
;dim DrawLine as word
;Draw lines going across
;For DrawLine = LineX1 To LineX2
	movlw	1
	subwf	LINEX1,W
	movwf	DRAWLINE
	movlw	0
	subwfb	LINEX1_H,W
	movwf	DRAWLINE_H
	movf	LINEX1,W
	movwf	SysWORDTempB
	movf	LINEX1_H,W
	movwf	SysWORDTempB_H
	movf	LINEX2,W
	movwf	SysWORDTempA
	movf	LINEX2_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd7
ENDIF35
SysForLoop7
	incf	DRAWLINE,F
	btfsc	STATUS,Z
	incf	DRAWLINE_H,F
;PSet DrawLine, LineY1, LineColour
	movf	DRAWLINE,W
	movwf	GLCDX
	movf	DRAWLINE_H,W
	movwf	GLCDX_H
	movf	LINEY1,W
	movwf	GLCDY
	movf	LINEY1_H,W
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_ILI9326
;PSet DrawLine, LineY2, LineColour
	movf	DRAWLINE,W
	movwf	GLCDX
	movf	DRAWLINE_H,W
	movwf	GLCDX_H
	movf	LINEY2,W
	movwf	GLCDY
	movf	LINEY2_H,W
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_ILI9326
;Next
	movf	DRAWLINE,W
	movwf	SysWORDTempA
	movf	DRAWLINE_H,W
	movwf	SysWORDTempA_H
	movf	LINEX2,W
	movwf	SysWORDTempB
	movf	LINEX2_H,W
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop7
ENDIF36
SysForLoopEnd7
;Draw lines going down
;For DrawLine = LineY1 To LineY2
	movlw	1
	subwf	LINEY1,W
	movwf	DRAWLINE
	movlw	0
	subwfb	LINEY1_H,W
	movwf	DRAWLINE_H
	movf	LINEY1,W
	movwf	SysWORDTempB
	movf	LINEY1_H,W
	movwf	SysWORDTempB_H
	movf	LINEY2,W
	movwf	SysWORDTempA
	movf	LINEY2_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd8
ENDIF37
SysForLoop8
	incf	DRAWLINE,F
	btfsc	STATUS,Z
	incf	DRAWLINE_H,F
;PSet LineX1, DrawLine, LineColour
	movf	LINEX1,W
	movwf	GLCDX
	movf	LINEX1_H,W
	movwf	GLCDX_H
	movf	DRAWLINE,W
	movwf	GLCDY
	movf	DRAWLINE_H,W
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_ILI9326
;PSet LineX2, DrawLine, LineColour
	movf	LINEX2,W
	movwf	GLCDX
	movf	LINEX2_H,W
	movwf	GLCDX_H
	movf	DRAWLINE,W
	movwf	GLCDY
	movf	DRAWLINE_H,W
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_ILI9326
;Next
	movf	DRAWLINE,W
	movwf	SysWORDTempA
	movf	DRAWLINE_H,W
	movwf	SysWORDTempA_H
	movf	LINEY2,W
	movwf	SysWORDTempB
	movf	LINEY2_H,W
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop8
ENDIF38
SysForLoopEnd8
	return

;********************************************************************************

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

;Start of program memory page 4
	ORG	8192
BIGFONT213_216
	movlw	95
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT213_216
	movwf	SysStringA
	movlw	(high TableBIGFONT213_216) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT213_216
	retlw	96
	retlw	224
	retlw	240
	retlw	248
	retlw	56
	retlw	24
	retlw	252
	retlw	252
	retlw	24
	retlw	56
	retlw	248
	retlw	240
	retlw	224
	retlw	7
	retlw	15
	retlw	31
	retlw	28
	retlw	24
	retlw	63
	retlw	63
	retlw	24
	retlw	28
	retlw	31
	retlw	15
	retlw	7
	retlw	0
	retlw	28
	retlw	60
	retlw	124
	retlw	224
	retlw	192
	retlw	224
	retlw	124
	retlw	60
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	56
	retlw	60
	retlw	62
	retlw	7
	retlw	3
	retlw	7
	retlw	62
	retlw	60
	retlw	56
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	128
	retlw	248
	retlw	248
	retlw	248
	retlw	128
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	1
	retlw	3
	retlw	35
	retlw	63
	retlw	63
	retlw	63
	retlw	35
	retlw	3
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	112
	retlw	252
	retlw	252
	retlw	140
	retlw	140
	retlw	140
	retlw	252
	retlw	252
	retlw	112
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	49
	retlw	51
	retlw	51
	retlw	51
	retlw	51
	retlw	51
	retlw	49

;********************************************************************************

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
	call	SENDCOMMAND_ILI9326
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
	call	SENDCOMMAND_ILI9326
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
	call	SENDCOMMAND_ILI9326
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
	movwf	SysRepeatTemp2
SysRepeatLoop2
;ILI9326_DataPort=GLCDBackground_h
	banksel	GLCDBACKGROUND_H
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
	call	SENDCOMMAND_ILI9326
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
	call	SENDCOMMAND_ILI9326
;sendData_ili9326( 0 )
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	goto	SENDDATA_ILI9326

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

OLEDFONT2_H
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

SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test low, exit if false
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W
;subwf SysWordTempB, W
	subwf	SYSWORDTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test high, exit if false
;movf SysWordTempA_H, W
	movf	SYSWORDTEMPA_H, W
;subwf SysWordTempB_H, W
	subwf	SYSWORDTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSCOMPLESSTHAN
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;bsf STATUS, C
	bsf	STATUS, C
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;subwf SysByteTempA, W
	subwf	SYSBYTETEMPA, W
;btfss STATUS, C
	btfss	STATUS, C
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

SYSCOMPLESSTHANINT
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	clrf	SYSBYTETEMPX
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	btfss	SYSINTEGERTEMPA_H,7
	goto	ELSE53_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7
	goto	ENDIF54
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F
;Exit Sub
	return
;End If
ENDIF54
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,W
	movwf	SYSDIVMULTA
	comf	SYSINTEGERTEMPA_H,W
	movwf	SYSDIVMULTA_H
	incf	SYSDIVMULTA,F
	btfsc	STATUS,Z
	incf	SYSDIVMULTA_H,F
;SysIntegerTempA = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,W
	movwf	SYSINTEGERTEMPA
	comf	SYSINTEGERTEMPB_H,W
	movwf	SYSINTEGERTEMPA_H
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
;SysIntegerTempB = SysDivMultA
	movf	SYSDIVMULTA,W
	movwf	SYSINTEGERTEMPB
	movf	SYSDIVMULTA_H,W
	movwf	SYSINTEGERTEMPB_H
;+A
;Else
	goto	ENDIF53
ELSE53_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7
;Exit Sub
	return
;End If
ENDIF55
;End If
ENDIF53
;Test High, exit if more
;movf SysIntegerTempA_H,W
	movf	SYSINTEGERTEMPA_H,W
;subwf SysIntegerTempB_H,W
	subwf	SYSINTEGERTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;Test high, exit true if less
;movf SysIntegerTempB_H,W
	movf	SYSINTEGERTEMPB_H,W
;subwf SysIntegerTempA_H,W
	subwf	SYSINTEGERTEMPA_H,W
;btfss STATUS,C
	btfss	STATUS,C
;goto SCLTIntTrue
	goto	SCLTINTTRUE
;Test Low, exit if more or equal
;movf SysIntegerTempB,W
	movf	SYSINTEGERTEMPB,W
;subwf SysIntegerTempA,W
	subwf	SYSINTEGERTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLTINTTRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F
;btfsc STATUS, Z
	btfsc	STATUS, Z
;return
	return
;Main calc routine
;SysByteTempX = 0
	clrf	SYSBYTETEMPX
;SysDivLoop = 8
	movlw	8
	movwf	SYSDIVLOOP
SYSDIV8START
;bcf STATUS, C
	bcf	STATUS, C
;rlf SysByteTempA, F
	rlf	SYSBYTETEMPA, F
;rlf SysByteTempX, F
	rlf	SYSBYTETEMPX, F
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;subwf SysByteTempX, F
	subwf	SYSBYTETEMPX, F
;bsf SysByteTempA, 0
	bsf	SYSBYTETEMPA, 0
;btfsc STATUS, C
	btfsc	STATUS, C
;goto Div8NotNeg
	goto	DIV8NOTNEG
;bcf SysByteTempA, 0
	bcf	SYSBYTETEMPA, 0
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F
DIV8NOTNEG
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv8Start
	goto	SYSDIV8START
	return

;********************************************************************************

SYSDIVSUB16
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
;Avoid division by zero
;if SysDivMultB = 0 then
	movf	SYSDIVMULTB,W
	movwf	SysWORDTempA
	movf	SYSDIVMULTB_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	ENDIF48
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF48
;Main calc routine
;SysDivLoop = 16
	movlw	16
	movwf	SYSDIVLOOP
SYSDIV16START
;set C off
	bcf	STATUS,C
;Rotate SysDivMultA Left
	rlf	SYSDIVMULTA,F
	rlf	SYSDIVMULTA_H,F
;Rotate SysDivMultX Left
	rlf	SYSDIVMULTX,F
	rlf	SYSDIVMULTX_H,F
;SysDivMultX = SysDivMultX - SysDivMultB
	movf	SYSDIVMULTB,W
	subwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	subwfb	SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
	bsf	SYSDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF49
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF49
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv16Start
	goto	SYSDIV16START
;SysWordTempA = SysDivMultA
	movf	SYSDIVMULTA,W
	movwf	SYSWORDTEMPA
	movf	SYSDIVMULTA_H,W
	movwf	SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
	return

;********************************************************************************

SYSDIVSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W
	xorwf	SYSINTEGERTEMPB_H,W
	movwf	SYSSIGNBYTE
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7
	goto	ENDIF50
	comf	SYSINTEGERTEMPA,F
	comf	SYSINTEGERTEMPA_H,F
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
ENDIF50
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7
	goto	ENDIF51
	comf	SYSINTEGERTEMPB,F
	comf	SYSINTEGERTEMPB_H,F
	incf	SYSINTEGERTEMPB,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPB_H,F
ENDIF51
;Call word divide routine
;SysDivSub16
	call	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7
	goto	ENDIF52
;SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F
	comf	SYSINTEGERTEMPA_H,F
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
;SysIntegerTempX = -SysIntegerTempX
	comf	SYSINTEGERTEMPX,F
	comf	SYSINTEGERTEMPX_H,F
	incf	SYSINTEGERTEMPX,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPX_H,F
;End If
ENDIF52
	return

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
	goto	ENDIF64
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
ENDIF64
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
ENDIF65
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
	return

;********************************************************************************

SYSMULTSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W
	xorwf	SYSINTEGERTEMPB_H,W
	movwf	SYSSIGNBYTE
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7
	goto	ENDIF45
	comf	SYSINTEGERTEMPA,F
	comf	SYSINTEGERTEMPA_H,F
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
ENDIF45
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7
	goto	ENDIF46
	comf	SYSINTEGERTEMPB,F
	comf	SYSINTEGERTEMPB_H,F
	incf	SYSINTEGERTEMPB,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPB_H,F
ENDIF46
;Call word multiply routine
;SysMultSub16
	call	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	btfss	SYSSIGNBYTE,7
	goto	ENDIF47
	comf	SYSINTEGERTEMPX,F
	comf	SYSINTEGERTEMPX_H,F
	incf	SYSINTEGERTEMPX,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPX_H,F
ENDIF47
	return

;********************************************************************************

SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF1
	movwf	INDF1
;goto SysStringReadCheck
	goto	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F
;Check length
SYSSTRINGREADCHECK
;If length is 0, exit
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F
;btfsc STATUS,Z
	btfsc	STATUS,Z
;return
	return
;Copy
SYSSTRINGREAD
;Get char
;call SysStringTables
	call	SYSSTRINGTABLES
;Set char
;addfsr 1,1
	addfsr	1,1
;movwf INDF1
	movwf	INDF1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F
;goto SysStringRead
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
	retlw	4
	retlw	69	;E
	retlw	118	;v
	retlw	97	;a
	retlw	110	;n


StringTable2
	retlw	16
	retlw	66	;B
	retlw	105	;i
	retlw	103	;g
	retlw	80	;P
	retlw	114	;r
	retlw	105	;i
	retlw	110	;n
	retlw	116	;t
	retlw	32	; 
	retlw	73	;I
	retlw	76	;L
	retlw	73	;I
	retlw	57	;9
	retlw	51	;3
	retlw	50	;2
	retlw	54	;6


;********************************************************************************

;Start of program memory page 5
	ORG	10240
;Start of program memory page 6
	ORG	12288
;Start of program memory page 7
	ORG	14336

 END
