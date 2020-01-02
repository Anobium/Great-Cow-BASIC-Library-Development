;Program compiled by Great Cow BASIC (0.98.<<>> 2019-11-14 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F47K42, r=DEC
#include <P18F47K42.inc>
 CONFIG CP = OFF, LVP = OFF, WRTD = OFF, WDTE = OFF, MVECEN = OFF, MCLRE = EXTMCLR, CLKOUTEN = OFF, RSTOSC = HFINTOSC_1MHZ, FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
CHARCODE	EQU	14
CHARCOL	EQU	15
CHARCOL_H	EQU	16
CHARLOCX	EQU	17
CHARLOCX_H	EQU	18
CHARLOCY	EQU	19
CHARLOCY_H	EQU	20
COLSPERFONT	EQU	21
CURRCHARCOL	EQU	22
CURRCHARROW	EQU	23
CURRCHARVAL	EQU	24
DATAVAR	EQU	25
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
DRAWLINE	EQU	26
DRAWLINE_H	EQU	27
DXOFFSET01	EQU	28
DXOFFSET01_H	EQU	29
DXOFFSET02	EQU	30
DXOFFSET02_H	EQU	31
DXOFFSET12	EQU	32
DXOFFSET12_H	EQU	33
DYOFFSET01	EQU	34
DYOFFSET01_H	EQU	35
DYOFFSET02	EQU	36
DYOFFSET02_H	EQU	37
DYOFFSET12	EQU	38
DYOFFSET12_H	EQU	39
EPD2IN13DADDRESSTYPE	EQU	40
EPD2IN13D_COMMAND	EQU	41
EPD2IN13D_DATA	EQU	42
EPD_BUFFER	EQU	6813
EPD_COUNTER	EQU	43
EPD_IND	EQU	44
EPD_IND_COL	EQU	46
EPD_IND_COL_H	EQU	47
EPD_IND_H	EQU	45
EPD_IND_RAW	EQU	48
EPD_IND_RAW_H	EQU	49
EPD_IND_TRANS	EQU	50
EPD_IND_TRANS_H	EQU	51
EPD_N_COL	EQU	52
EPD_N_COL_H	EQU	53
EPD_N_RAW	EQU	54
EPD_N_RAW_H	EQU	55
GLCDBACKGROUND	EQU	56
GLCDBACKGROUND_H	EQU	57
GLCDCOLOUR	EQU	58
GLCDCOLOUR_H	EQU	59
GLCDDATATEMP	EQU	60
GLCDDATATEMP_H	EQU	61
GLCDDEVICEHEIGHT	EQU	62
GLCDDEVICEHEIGHT_H	EQU	63
GLCDDEVICEWIDTH	EQU	64
GLCDDEVICEWIDTH_H	EQU	65
GLCDFNTDEFAULT	EQU	66
GLCDFNTDEFAULTHEIGHT	EQU	67
GLCDFNTDEFAULTSIZE	EQU	68
GLCDFONTWIDTH	EQU	69
GLCDFOREGROUND	EQU	70
GLCDFOREGROUND_H	EQU	71
GLCDPRINTLEN	EQU	72
GLCDPRINTLOC	EQU	73
GLCDPRINTLOC_H	EQU	74
GLCDPRINT_STRING_COUNTER	EQU	75
GLCDTEMP	EQU	76
GLCDTEMP_H	EQU	77
GLCDX	EQU	78
GLCDX_H	EQU	79
GLCDY	EQU	80
GLCDY_H	EQU	81
GLCD_AA	EQU	82
GLCD_AA_H	EQU	83
GLCD_BB	EQU	84
GLCD_BB_H	EQU	85
GLCD_LAST	EQU	86
GLCD_LAST_H	EQU	87
GLCD_SA	EQU	88
GLCD_SA_H	EQU	89
GLCD_SB	EQU	90
GLCD_SB_H	EQU	91
GLCD_TIME_BUFF	EQU	92
GLCD_TIME_BUFF_H	EQU	93
GLCD_Y	EQU	94
GLCD_YORDINATE	EQU	96
GLCD_YORDINATE_H	EQU	97
GLCD_Y_H	EQU	95
INXRADIUS	EQU	98
INXRADIUS_H	EQU	99
LINECOLOUR	EQU	100
LINECOLOUR_H	EQU	101
LINEDIFFX	EQU	102
LINEDIFFX_H	EQU	103
LINEDIFFX_X2	EQU	104
LINEDIFFX_X2_H	EQU	105
LINEDIFFY	EQU	106
LINEDIFFY_H	EQU	107
LINEDIFFY_X2	EQU	108
LINEDIFFY_X2_H	EQU	109
LINEERR	EQU	110
LINEERR_H	EQU	111
LINESTEPX	EQU	112
LINESTEPX_H	EQU	113
LINESTEPY	EQU	114
LINESTEPY_H	EQU	115
LINEX1	EQU	116
LINEX1_H	EQU	117
LINEX2	EQU	118
LINEX2_H	EQU	119
LINEY1	EQU	120
LINEY1_H	EQU	121
LINEY2	EQU	122
LINEY2_H	EQU	123
LOCALCHARCODE	EQU	124
LOCALCHARCODE_H	EQU	125
LOWERPAGE	EQU	126
OLDGLCDFONTWIDTH	EQU	127
PRINTLOCX	EQU	128
PRINTLOCX_H	EQU	129
PRINTLOCY	EQU	130
PRINTLOCY_H	EQU	131
RADIUSERR	EQU	132
RADIUSERR_H	EQU	133
REMAINDER	EQU	134
ROWSPERFONT	EQU	135
SPICLOCKMODE	EQU	136
SPICURRENTMODE	EQU	137
SPIRXDATA	EQU	138
SPITXDATA	EQU	139
STRINGPOINTER	EQU	140
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSCALCTEMPA_H	EQU	6
SYSCALCTEMPB	EQU	9
SYSCALCTEMPB_H	EQU	10
SYSCALCTEMPX	EQU	0
SYSCALCTEMPX_H	EQU	1
SYSDIVLOOP	EQU	4
SYSDIVMULTA	EQU	7
SYSDIVMULTA_H	EQU	8
SYSDIVMULTB	EQU	11
SYSDIVMULTB_H	EQU	12
SYSDIVMULTX	EQU	2
SYSDIVMULTX_H	EQU	3
SYSINTEGERTEMPA	EQU	5
SYSINTEGERTEMPA_H	EQU	6
SYSINTEGERTEMPB	EQU	9
SYSINTEGERTEMPB_H	EQU	10
SYSINTEGERTEMPX	EQU	0
SYSINTEGERTEMPX_H	EQU	1
SYSLCDPRINTDATAHANDLER	EQU	141
SYSLCDPRINTDATAHANDLER_H	EQU	142
SYSREPEATTEMP1	EQU	143
SYSSIGNBYTE	EQU	13
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	6792
SYSTEMP1	EQU	144
SYSTEMP1_H	EQU	145
SYSTEMP2	EQU	146
SYSTEMP2_H	EQU	147
SYSTEMP3	EQU	148
SYSTEMP3_H	EQU	149
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
SYSWAITTEMPS	EQU	4
SYSWORDTEMPA	EQU	5
SYSWORDTEMPA_H	EQU	6
SYSWORDTEMPB	EQU	9
SYSWORDTEMPB_H	EQU	10
SYSWORDTEMPX	EQU	0
SYSWORDTEMPX_H	EQU	1
UC1601_BUFFERLOCATIONCALC	EQU	150
UC1601_BUFFERLOCATIONCALC_H	EQU	151
UPPERPAGE	EQU	152
XOFFSET	EQU	153
XOFFSET2	EQU	155
XOFFSET2_H	EQU	156
XOFFSET3	EQU	157
XOFFSET3_H	EQU	158
XOFFSET_H	EQU	154
XRADIUS	EQU	159
XRADIUS_H	EQU	160
YOFFSET	EQU	161
YOFFSET2	EQU	163
YOFFSET2_H	EQU	164
YOFFSET3	EQU	165
YOFFSET3_H	EQU	166
YOFFSET_H	EQU	162
YORDINATE	EQU	167
_GLCDPAGE	EQU	168
_GLCDPAGESH	EQU	169
_GLCDPAGESL	EQU	170

;********************************************************************************

;Alias variables
AFSR0	EQU	16361
AFSR0_H	EQU	16362

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
	call	INITPPS
	call	INIT_EPD2IN13D

;Start of the main program
;''A demonstration program for Explicit-Paper.
;''-------------------------------------------------------------------------
;-------------------------------------------------------
;''This has been tested using the hardware and software SPI option.
;''*************************************************************************
;*******
;Chip Settings.
;PPS Tool version: 0.0.5.27
;PinManager data: v1.78
;Generated for 18F47K42
;
;Template comment at the start of the config file
;
;#define PPSToolPart 18F47K42
;Template comment at the end of the config file
;******************************************************************************************************
;The following should be used   '#define EPD_HardwareSPI     'remove comment out if you want to use software SPI.
;#define EPD_HardwareSPI
;***************************************************************************
;***************************
;Setup the E-Paper
;#define GLCD_TYPE GLCD_TYPE_EPD_EPD2in13D
;#define GLCD_EXTENDEDFONTSET1
;#define GLCD_TYPE_EPD2in13D_LOWMEMORY4_GLCD_MODE
;#define GLCD_OLED_FONT
;#define GLCD_PROTECTOVERRUN
;Pin mappings for SPI - this GLCD driver supports Hardware SPI and Software SPI
;#define GLCD_DC     portA.0   ' Data(hight)/ command(low) line
;#define GLCD_CS     portC.1   ' Chip select line (negate)
;#define GLCD_RESET  portD.2   ' Reset line       (negate)
;#define GLCD_DO     portC.5   ' GLCD MOSI connect to MCU SDO
;#define GLCD_SCK    portC.3   ' Clock Line
;#define GLCD_Busy   portC.0   ' Busy Line
;******************************************************************************************************
;******************************************************************************************************
;Main program
;dim upperPage, lowerPage as Byte
;upperPage = 0
	clrf	UPPERPAGE,BANKED
;lowerPage = EPD_N_PAGE-1
	movlw	1
	movwf	LOWERPAGE,BANKED
;GLCDForeground = TFT_BLACK
	clrf	GLCDFOREGROUND,ACCESS
	clrf	GLCDFOREGROUND_H,ACCESS
;GLCDBackground = TFT_WHITE
	setf	GLCDBACKGROUND,ACCESS
	setf	GLCDBACKGROUND_H,ACCESS
;Tests
;GLCDRotate Portrait
	movlw	4
	movwf	EPD2IN13DADDRESSTYPE,ACCESS
	call	ROTATE_EPD2IN13D
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (938)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	call	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	decf	_GLCDPAGESL,W,BANKED
	movwf	_GLCDPAGE,BANKED
	movf	_GLCDPAGESL,W,BANKED
	subwf	_GLCDPAGESH,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd1
SysForLoop1
	incf	_GLCDPAGE,F,BANKED
;GLCDLocateString 0,0
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	call	GLCDLOCATESTRING
;GLCDPrint 0,0, "Test @ Portrait"
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable1
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINT4
;line 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	clrf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movff	GLCDDEVICEWIDTH,LINEX2
	movff	GLCDDEVICEWIDTH_H,LINEX2_H
	movff	GLCDDEVICEHEIGHT,LINEY2
	movff	GLCDDEVICEHEIGHT_H,LINEY2_H
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	LINE
;box 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	clrf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movff	GLCDDEVICEWIDTH,LINEX2
	movff	GLCDDEVICEWIDTH_H,LINEX2_H
	movff	GLCDDEVICEHEIGHT,LINEY2
	movff	GLCDDEVICEHEIGHT_H,LINEY2_H
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	BOX
;Circle GLCDDeviceWidth/2, GLCDDeviceHeight/2, 20
	movff	GLCDDEVICEWIDTH,SysWORDTempA
	movff	GLCDDEVICEWIDTH_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,XOFFSET
	movff	SysWORDTempA_H,XOFFSET_H
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,YOFFSET
	movff	SysWORDTempA_H,YOFFSET_H
	movlw	20
	movwf	INXRADIUS,BANKED
	clrf	INXRADIUS_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	movff	GLCD_YORDINATE,YORDINATE
	rcall	CIRCLE
;FilledBox( 12, 12,20, 80, GLCDForeground)  'Filled Rectangle
	movlw	12
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	12
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	20
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	80
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledTriangle(12,80, 20,80,16,90, GLCDForeground)  'Filled Triangle
	movlw	12
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	80
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	20
	movwf	XOFFSET2,BANKED
	clrf	XOFFSET2_H,BANKED
	movlw	80
	movwf	YOFFSET2,BANKED
	clrf	YOFFSET2_H,BANKED
	movlw	16
	movwf	XOFFSET3,BANKED
	clrf	XOFFSET3_H,BANKED
	movlw	90
	movwf	YOFFSET3,BANKED
	clrf	YOFFSET3_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDTRIANGLE
;GLCDLocateString (20, 4)
	movlw	20
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	4
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	call	GLCDLOCATESTRING
;GLCDPrintStringLN "Line 4"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINTSTRINGLN
;GLCDPrintStringLN "Line 5"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable3
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINTSTRINGLN
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (951)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;GLCDRotate Portrait_rev
	movlw	2
	movwf	EPD2IN13DADDRESSTYPE,ACCESS
	call	ROTATE_EPD2IN13D
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (938)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	rcall	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	decf	_GLCDPAGESL,W,BANKED
	movwf	_GLCDPAGE,BANKED
	movf	_GLCDPAGESL,W,BANKED
	subwf	_GLCDPAGESH,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd2
SysForLoop2
	incf	_GLCDPAGE,F,BANKED
;GLCDLocateString 0,0
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	call	GLCDLOCATESTRING
;GLCDPrint 0,0, "Test @ Portrait_rev"
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable4
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINT4
;line 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	clrf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movff	GLCDDEVICEWIDTH,LINEX2
	movff	GLCDDEVICEWIDTH_H,LINEX2_H
	movff	GLCDDEVICEHEIGHT,LINEY2
	movff	GLCDDEVICEHEIGHT_H,LINEY2_H
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	LINE
;box 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	clrf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movff	GLCDDEVICEWIDTH,LINEX2
	movff	GLCDDEVICEWIDTH_H,LINEX2_H
	movff	GLCDDEVICEHEIGHT,LINEY2
	movff	GLCDDEVICEHEIGHT_H,LINEY2_H
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	BOX
;Circle GLCDDeviceWidth/2, GLCDDeviceHeight/2, 20
	movff	GLCDDEVICEWIDTH,SysWORDTempA
	movff	GLCDDEVICEWIDTH_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,XOFFSET
	movff	SysWORDTempA_H,XOFFSET_H
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,YOFFSET
	movff	SysWORDTempA_H,YOFFSET_H
	movlw	20
	movwf	INXRADIUS,BANKED
	clrf	INXRADIUS_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	movff	GLCD_YORDINATE,YORDINATE
	rcall	CIRCLE
;FilledBox( 12, 12,20, 80, GLCDForeground)  'Filled Rectangle
	movlw	12
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	12
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	20
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	80
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledTriangle(12,80, 20,80,16,90, GLCDForeground)  'Filled Triangle
	movlw	12
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	80
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	20
	movwf	XOFFSET2,BANKED
	clrf	XOFFSET2_H,BANKED
	movlw	80
	movwf	YOFFSET2,BANKED
	clrf	YOFFSET2_H,BANKED
	movlw	16
	movwf	XOFFSET3,BANKED
	clrf	XOFFSET3_H,BANKED
	movlw	90
	movwf	YOFFSET3,BANKED
	clrf	YOFFSET3_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDTRIANGLE
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (951)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;GLCDRotate Landscape
	movlw	1
	movwf	EPD2IN13DADDRESSTYPE,ACCESS
	call	ROTATE_EPD2IN13D
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (938)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	rcall	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	decf	_GLCDPAGESL,W,BANKED
	movwf	_GLCDPAGE,BANKED
	movf	_GLCDPAGESL,W,BANKED
	subwf	_GLCDPAGESH,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd3
SysForLoop3
	incf	_GLCDPAGE,F,BANKED
;GLCDLocateString 0,0
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	call	GLCDLOCATESTRING
;GLCDPrint 0,0, "Test @ Landscape"
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable5
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINT4
;line 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	clrf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movff	GLCDDEVICEWIDTH,LINEX2
	movff	GLCDDEVICEWIDTH_H,LINEX2_H
	movff	GLCDDEVICEHEIGHT,LINEY2
	movff	GLCDDEVICEHEIGHT_H,LINEY2_H
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	LINE
;box 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	clrf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movff	GLCDDEVICEWIDTH,LINEX2
	movff	GLCDDEVICEWIDTH_H,LINEX2_H
	movff	GLCDDEVICEHEIGHT,LINEY2
	movff	GLCDDEVICEHEIGHT_H,LINEY2_H
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	BOX
;Circle GLCDDeviceWidth/2, GLCDDeviceHeight/2, 20
	movff	GLCDDEVICEWIDTH,SysWORDTempA
	movff	GLCDDEVICEWIDTH_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,XOFFSET
	movff	SysWORDTempA_H,XOFFSET_H
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,YOFFSET
	movff	SysWORDTempA_H,YOFFSET_H
	movlw	20
	movwf	INXRADIUS,BANKED
	clrf	INXRADIUS_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	movff	GLCD_YORDINATE,YORDINATE
	rcall	CIRCLE
;FilledBox( 12, 12,20, 80, GLCDForeground)  'Filled Rectangle
	movlw	12
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	12
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	20
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	80
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledTriangle(12,80, 20,80,16,90, GLCDForeground)  'Filled Triangle
	movlw	12
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	80
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	20
	movwf	XOFFSET2,BANKED
	clrf	XOFFSET2_H,BANKED
	movlw	80
	movwf	YOFFSET2,BANKED
	clrf	YOFFSET2_H,BANKED
	movlw	16
	movwf	XOFFSET3,BANKED
	clrf	XOFFSET3_H,BANKED
	movlw	90
	movwf	YOFFSET3,BANKED
	clrf	YOFFSET3_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDTRIANGLE
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (951)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;GLCDRotate Landscape_Rev
	movlw	3
	movwf	EPD2IN13DADDRESSTYPE,ACCESS
	call	ROTATE_EPD2IN13D
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (938)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	rcall	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	decf	_GLCDPAGESL,W,BANKED
	movwf	_GLCDPAGE,BANKED
	movf	_GLCDPAGESL,W,BANKED
	subwf	_GLCDPAGESH,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
SysForLoop4
	incf	_GLCDPAGE,F,BANKED
;GLCDLocateString 0,0
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	call	GLCDLOCATESTRING
;GLCDPrint 0,0, "Test @ Landscape_Rev"
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable6
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINT4
;line 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	clrf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movff	GLCDDEVICEWIDTH,LINEX2
	movff	GLCDDEVICEWIDTH_H,LINEX2_H
	movff	GLCDDEVICEHEIGHT,LINEY2
	movff	GLCDDEVICEHEIGHT_H,LINEY2_H
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	LINE
;box 0,0,GLCDDeviceWidth, GLCDDeviceHeight
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	clrf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movff	GLCDDEVICEWIDTH,LINEX2
	movff	GLCDDEVICEWIDTH_H,LINEX2_H
	movff	GLCDDEVICEHEIGHT,LINEY2
	movff	GLCDDEVICEHEIGHT_H,LINEY2_H
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	BOX
;Circle GLCDDeviceWidth/2, GLCDDeviceHeight/2, 20
	movff	GLCDDEVICEWIDTH,SysWORDTempA
	movff	GLCDDEVICEWIDTH_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,XOFFSET
	movff	SysWORDTempA_H,XOFFSET_H
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,YOFFSET
	movff	SysWORDTempA_H,YOFFSET_H
	movlw	20
	movwf	INXRADIUS,BANKED
	clrf	INXRADIUS_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	movff	GLCD_YORDINATE,YORDINATE
	rcall	CIRCLE
;FilledBox( 12, 12,20, 80, GLCDForeground)  'Filled Rectangle
	movlw	12
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	12
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	20
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	80
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	FILLEDBOX_EPD2IN13D
;FilledTriangle(12,80, 20,80,16,90, GLCDForeground)  'Filled Triangle
	movlw	12
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	80
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	20
	movwf	XOFFSET2,BANKED
	clrf	XOFFSET2_H,BANKED
	movlw	80
	movwf	YOFFSET2,BANKED
	clrf	YOFFSET2_H,BANKED
	movlw	16
	movwf	XOFFSET3,BANKED
	clrf	XOFFSET3_H,BANKED
	movlw	90
	movwf	YOFFSET3,BANKED
	clrf	YOFFSET3_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	FILLEDTRIANGLE
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (951)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;GLCDCLS
	rcall	CLS_EPD2IN13D
;GLCDSleep
	call	SLEEP_EPD2IN13D
;do
SysDoLoop_S1
;loop
	bra	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Source: glcd.h (1353)
BOX
;dim GLCDTemp as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF13
;GLCDTemp = LineX1
	movff	LINEX1,GLCDTEMP
	movff	LINEX1_H,GLCDTEMP_H
;LineX1 = LineX2
	movff	LINEX2,LINEX1
	movff	LINEX2_H,LINEX1_H
;LineX2 = GLCDTemp
	movff	GLCDTEMP,LINEX2
	movff	GLCDTEMP_H,LINEX2_H
;End If
ENDIF13
;If LineY1 > LineY2 Then
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF14
;GLCDTemp = LineY1
	movff	LINEY1,GLCDTEMP
	movff	LINEY1_H,GLCDTEMP_H
;LineY1 = LineY2
	movff	LINEY2,LINEY1
	movff	LINEY2_H,LINEY1_H
;LineY2 = GLCDTemp
	movff	GLCDTEMP,LINEY2
	movff	GLCDTEMP_H,LINEY2_H
;End If
ENDIF14
;dim DrawLine as word
;Draw lines going across
;For DrawLine = LineX1 To LineX2
	movlw	1
	subwf	LINEX1,W,BANKED
	movwf	DRAWLINE,ACCESS
	movlw	0
	subwfb	LINEX1_H,W,BANKED
	movwf	DRAWLINE_H,ACCESS
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd6
SysForLoop6
	incf	DRAWLINE,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	DRAWLINE_H,F,ACCESS
;PSet DrawLine, LineY1, LineColour
	movff	DRAWLINE,GLCDX
	movff	DRAWLINE_H,GLCDX_H
	movff	LINEY1,GLCDY
	movff	LINEY1_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;PSet DrawLine, LineY2, LineColour
	movff	DRAWLINE,GLCDX
	movff	DRAWLINE_H,GLCDX_H
	movff	LINEY2,GLCDY
	movff	LINEY2_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Next
	movff	DRAWLINE,SysWORDTempA
	movff	DRAWLINE_H,SysWORDTempA_H
	movff	LINEX2,SysWORDTempB
	movff	LINEX2_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop6
SysForLoopEnd6
;Draw lines going down
;For DrawLine = LineY1 To LineY2
	movlw	1
	subwf	LINEY1,W,BANKED
	movwf	DRAWLINE,ACCESS
	movlw	0
	subwfb	LINEY1_H,W,BANKED
	movwf	DRAWLINE_H,ACCESS
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd7
SysForLoop7
	incf	DRAWLINE,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	DRAWLINE_H,F,ACCESS
;PSet LineX1, DrawLine, LineColour
	movff	LINEX1,GLCDX
	movff	LINEX1_H,GLCDX_H
	movff	DRAWLINE,GLCDY
	movff	DRAWLINE_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;PSet LineX2, DrawLine, LineColour
	movff	LINEX2,GLCDX
	movff	LINEX2_H,GLCDX_H
	movff	DRAWLINE,GLCDY
	movff	DRAWLINE_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Next
	movff	DRAWLINE,SysWORDTempA
	movff	DRAWLINE_H,SysWORDTempA_H
	movff	LINEY2,SysWORDTempB
	movff	LINEY2_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop7
SysForLoopEnd7
	return

;********************************************************************************

;Source: glcd.h (1400)
CIRCLE
;dim  radiusErr, xradius as Integer
;xradius = Inxradius
	movff	INXRADIUS,XRADIUS
	movff	INXRADIUS_H,XRADIUS_H
;radiusErr = -(xradius/2)
	movff	XRADIUS,SysINTEGERTempA
	movff	XRADIUS_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysDivSubINT
	movff	SysINTEGERTempA,SysTemp1
	movff	SysINTEGERTempA_H,SysTemp1_H
	comf	SysTemp1,W,BANKED
	movwf	RADIUSERR,BANKED
	comf	SysTemp1_H,W,BANKED
	movwf	RADIUSERR_H,BANKED
	incf	RADIUSERR,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	RADIUSERR_H,F,BANKED
;Do While xradius >=  yordinate
SysDoLoop_S2
	movff	xradius,SysINTEGERTempA
	movff	xradius_H,SysINTEGERTempA_H
	movff	yordinate,SysINTEGERTempB
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysCompLessThanINT
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E2
;Pset ((xoffset + xradius), (yoffset + yordinate), LineColour)
	movf	XRADIUS,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	XRADIUS_H,W,BANKED
	addwfc	XOFFSET_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	YORDINATE,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movlw	0
	addwfc	YOFFSET_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Pset ((xoffset + yordinate), (yoffset + xradius), LineColour)
	movf	YORDINATE,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movlw	0
	addwfc	XOFFSET_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	XRADIUS,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movf	XRADIUS_H,W,BANKED
	addwfc	YOFFSET_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Pset ((xoffset - xradius), (yoffset + yordinate), LineColour)
	movf	XRADIUS,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	XRADIUS_H,W,BANKED
	subwfb	XOFFSET_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	YORDINATE,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movlw	0
	addwfc	YOFFSET_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Pset ((xoffset - yordinate), (yoffset + xradius), LineColour)
	movf	YORDINATE,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movlw	0
	subwfb	XOFFSET_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	XRADIUS,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movf	XRADIUS_H,W,BANKED
	addwfc	YOFFSET_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Pset ((xoffset - xradius), (yoffset - yordinate), LineColour)
	movf	XRADIUS,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	XRADIUS_H,W,BANKED
	subwfb	XOFFSET_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	YORDINATE,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movlw	0
	subwfb	YOFFSET_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Pset ((xoffset - yordinate), (yoffset - xradius), LineColour)
	movf	YORDINATE,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movlw	0
	subwfb	XOFFSET_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	XRADIUS,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movf	XRADIUS_H,W,BANKED
	subwfb	YOFFSET_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Pset ((xoffset + xradius), (yoffset - yordinate), LineColour)
	movf	XRADIUS,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	XRADIUS_H,W,BANKED
	addwfc	XOFFSET_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	YORDINATE,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movlw	0
	subwfb	YOFFSET_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Pset ((xoffset + yordinate), (yoffset - xradius), LineColour)
	movf	YORDINATE,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movlw	0
	addwfc	XOFFSET_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	XRADIUS,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movf	XRADIUS_H,W,BANKED
	subwfb	YOFFSET_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;yordinate ++
	incf	YORDINATE,F,BANKED
;If radiusErr < 0 Then
	movff	RADIUSERR,SysINTEGERTempA
	movff	RADIUSERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE19_1
;radiusErr = radiusErr + 2 * yordinate + 1
	movf	YORDINATE,W,BANKED
	mullw	2
	movf	PRODL,W,ACCESS
	addwf	RADIUSERR,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	RADIUSERR_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	RADIUSERR,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	RADIUSERR_H,BANKED
;else
	bra	ENDIF19
ELSE19_1
;xradius --
	movlw	1
	subwf	XRADIUS,F,BANKED
	movlw	0
	subwfb	XRADIUS_H,F,BANKED
;radiusErr = radiusErr + 2 * (yordinate - xradius + 1)
	movf	XRADIUS,W,BANKED
	subwf	YORDINATE,W,BANKED
	movwf	SysTemp1,BANKED
	clrf	SysTemp2,BANKED
	movf	XRADIUS_H,W,BANKED
	subwfb	SysTemp2,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp3,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	SysTemp3_H,BANKED
	movff	SysTemp3,SysINTEGERTempA
	movff	SysTemp3_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysMultSubINT
	movf	SysINTEGERTempX,W,ACCESS
	addwf	RADIUSERR,F,BANKED
	movf	SysINTEGERTempX_H,W,ACCESS
	addwfc	RADIUSERR_H,F,BANKED
;end if
ENDIF19
;Loop
	bra	SysDoLoop_S2
SysDoLoop_E2
	return

;********************************************************************************

;Source: epd_epd2in13d.h (412)
CLEAR_BUFFER_EPD2IN13D
;initialise global variable. Required variable for Circle - DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE,BANKED
	clrf	GLCD_YORDINATE_H,BANKED
;Dim EPD_Ind_raw, EPD_Ind_col as word
;Dim PrintLocX, PrintLocY as word
;PrintLocX = 0
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
;PrintLocY = 0
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
;Dim EPD_Ind_raw as Word
;for EPD_Ind_raw=1 to BUFFWIDTH                 'clear the buffer
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop13
	incf	EPD_IND_RAW,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,ACCESS
;EPD_Buffer(EPD_Ind_raw)=GLCDBackground
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_RAW,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_RAW_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movffl	GLCDBACKGROUND,INDF0
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	98
	movwf	SysWORDTempB,ACCESS
	movlw	5
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop13
SysForLoopEnd13
	return

;********************************************************************************

;Source: epd_epd2in13d.h (352)
CLS_EPD2IN13D
;CLS_EPD2in13D_init
	rcall	CLS_EPD2IN13D_INIT
;Refresh_EPD2in13D
	goto	REFRESH_EPD2IN13D

;********************************************************************************

;Source: epd_epd2in13d.h (303)
CLS_EPD2IN13D_INIT
;initialise global variable. Required variable for Circle - DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE,BANKED
	clrf	GLCD_YORDINATE_H,BANKED
;Dim EPD_Ind_raw, EPD_Ind_col as word
;Dim PrintLocX, PrintLocY as word
;PrintLocX = 0
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
;PrintLocY = 0
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
;For EPD_Ind_raw=1 to BUFFWIDTH
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop23
	incf	EPD_IND_RAW,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,ACCESS
;EPD_Buffer(EPD_Ind_raw)=GLCDBackground
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_RAW,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_RAW_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movffl	GLCDBACKGROUND,INDF0
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	98
	movwf	SysWORDTempB,ACCESS
	movlw	5
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop23
SysForLoopEnd23
;Clear down "OLD" data
;SendCommand_EPD2in13D(Data_Transmission_1)
	movlw	16
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;for EPD_Ind_raw=1 to GLCD_Height
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop24
	incf	EPD_IND_RAW,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,ACCESS
;for EPD_Ind_col=1 to GLCD_Width
	clrf	EPD_IND_COL,ACCESS
	clrf	EPD_IND_COL_H,ACCESS
SysForLoop25
	incf	EPD_IND_COL,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_COL_H,F,ACCESS
;Was.. speed optimised with macro              SendData_EPD2in13D(GLCDBackGround)
;EPD2in13D_Data = GLCDBackGround
	movff	GLCDBACKGROUND,EPD2IN13D_DATA
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATA,0,ACCESS
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (495)
;FastHWSPITransfer EPD2in13D_Data
	movff	EPD2IN13D_DATA,SPITXDATA
	rcall	FASTHWSPITRANSFER
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
;next
	movff	EPD_IND_COL,SysWORDTempA
	movff	EPD_IND_COL_H,SysWORDTempA_H
	movlw	104
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop25
SysForLoopEnd25
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	212
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop24
SysForLoopEnd24
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Clear down "NEW" data
;SendCommand_EPD2in13D(Data_Transmission_2)
	movlw	19
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;for EPD_Ind_raw=1 to GLCD_Height
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop26
	incf	EPD_IND_RAW,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,ACCESS
;for EPD_Ind_col=1 to GLCD_Width
	clrf	EPD_IND_COL,ACCESS
	clrf	EPD_IND_COL_H,ACCESS
SysForLoop27
	incf	EPD_IND_COL,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_COL_H,F,ACCESS
;Was.. speed optimised with macro              SendData_EPD2in13D(GLCDBackGround)
;EPD2in13D_Data = GLCDBackGround
	movff	GLCDBACKGROUND,EPD2IN13D_DATA
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATA,0,ACCESS
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (495)
;FastHWSPITransfer EPD2in13D_Data
	movff	EPD2IN13D_DATA,SPITXDATA
	rcall	FASTHWSPITRANSFER
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
;next
	movff	EPD_IND_COL,SysWORDTempA
	movff	EPD_IND_COL_H,SysWORDTempA_H
	movlw	104
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop27
SysForLoopEnd27
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	212
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop26
SysForLoopEnd26
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	bra	Delay_MS

;********************************************************************************

;Source: epd_epd2in13d.h (544)
DRAWCHAR_EPD2IN13D
;This has got a tad complex
;We have three major pieces
;1 The preamble - this just adjusted color and the input character
;2 The code that deals with GCB fontset
;3 The code that deals with OLED fontset
;
;You can make independent change to section 2 and 3 but they are mutual exclusive with many common pieces
;dim CharCol, CharRow, GLCDTemp as word
;CharCode -= 15
	movlw	15
	subwf	CHARCODE,F,ACCESS
;CharCode needs to have 15 subtracted, table starts at char 16 not char 0
;CharCol=0
	clrf	CHARCOL,ACCESS
	clrf	CHARCOL_H,ACCESS
;Calculate the pointer to the OLED fonts.
;These fonts are not multiple tables one is a straight list the other is a lookup table with data.
;Dim LocalCharCode as word
;Get key information and set up the fonts parameters
;Select case GLCDfntDefaultSize
;case 1 'This font is two font tables of an index and data
SysSelect1Case1
	decf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;CharCode = CharCode - 16
	movlw	16
	subwf	CHARCODE,F,ACCESS
;ReadTable OLEDFont1Index, CharCode, LocalCharCode
	movff	CHARCODE,SYSSTRINGA
	call	OLEDFONT1INDEX
	movwf	LOCALCHARCODE,BANKED
	movff	CHARCODE,SYSSTRINGA
	call	OLEDFONT1INDEX_H
	movwf	LOCALCHARCODE_H,BANKED
;ReadTable OLEDFont1Data, LocalCharCode , COLSperfont
	movff	LOCALCHARCODE,SYSSTRINGA
	movff	LOCALCHARCODE_H,SYSSTRINGA_H
	call	OLEDFONT1DATA
	movwf	COLSPERFONT,ACCESS
;GLCDFontWidth = COLSperfont + 1
	incf	COLSPERFONT,W,ACCESS
	movwf	GLCDFONTWIDTH,ACCESS
;ROWSperfont = 7  'which is really 8 as we start at 0
	movlw	7
	movwf	ROWSPERFONT,BANKED
;case 2 'This is one font table
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd1
;CharCode = CharCode - 17
	movlw	17
	subwf	CHARCODE,F,ACCESS
;Pointer to table of font elements
;LocalCharCode = (CharCode * 20)
	movff	CHARCODE,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	movlw	20
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,LOCALCHARCODE
	movff	SysWORDTempX_H,LOCALCHARCODE_H
;COLSperfont = 9  'which is really 10 as we start at 0
	movlw	9
	movwf	COLSPERFONT,ACCESS
;ROWSperfont=15  'which is really 16 as we start at 0
	movlw	15
	movwf	ROWSPERFONT,BANKED
;End Select
SysSelectEnd1
;The main loop - loop throught the number of columns
;For CurrCharCol = 0 to COLSperfont  'number of columns in the font , with two row of data
	setf	CURRCHARCOL,ACCESS
	movlw	0
	subwf	COLSPERFONT,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd14
SysForLoop14
	incf	CURRCHARCOL,F,ACCESS
;Index the pointer to the code that we are looking for as we need to do this lookup many times getting more font data
;LocalCharCode++
	incf	LOCALCHARCODE,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	LOCALCHARCODE_H,F,BANKED
;Select case GLCDfntDefaultSize
;case 1
SysSelect2Case1
	decf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
;ReadTable OLEDFont1Data, LocalCharCode, CurrCharVal
	movff	LOCALCHARCODE,SYSSTRINGA
	movff	LOCALCHARCODE_H,SYSSTRINGA_H
	call	OLEDFONT1DATA
	movwf	CURRCHARVAL,ACCESS
;case 2
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd2
;Read this 20 times... (0..COLSperfont) [ * 2 ]
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	movff	LOCALCHARCODE,SYSSTRINGA
	movff	LOCALCHARCODE_H,SYSSTRINGA_H
	call	OLEDFONT2
	movwf	CURRCHARVAL,ACCESS
;End Select
SysSelectEnd2
;we handle 8 or 16 pixels of height
;For CurrCharRow = 0 to ROWSperfont
	setf	CURRCHARROW,ACCESS
	movlw	0
	subwf	ROWSPERFONT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd15
SysForLoop15
	incf	CURRCHARROW,F,ACCESS
;Set the pixel
;If CurrCharVal.0 = 0 Then
	btfsc	CURRCHARVAL,0,ACCESS
	bra	ELSE45_1
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, GLCDBACKGROUND
	movf	CURRCHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	GLCDX,ACCESS
	movlw	0
	addwfc	CHARLOCX_H,W,ACCESS
	movwf	GLCDX_H,ACCESS
	movf	CURRCHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	GLCDY,ACCESS
	movlw	0
	addwfc	CHARLOCY_H,W,ACCESS
	movwf	GLCDY_H,ACCESS
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Else
	bra	ENDIF45
ELSE45_1
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, LineColour
	movf	CURRCHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	GLCDX,ACCESS
	movlw	0
	addwfc	CHARLOCX_H,W,ACCESS
	movwf	GLCDX_H,ACCESS
	movf	CURRCHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	GLCDY,ACCESS
	movlw	0
	addwfc	CHARLOCY_H,W,ACCESS
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;End If
ENDIF45
;Rotate CurrCharVal Right
	rrcf	CURRCHARVAL,F,ACCESS
;Set to next row of date, a second row
;if GLCDfntDefaultSize = 2 and CurrCharRow = 7 then
	movff	GLCDFNTDEFAULTSIZE,SysBYTETempA
	movlw	2
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	movff	SysByteTempX,SysTemp1
	movff	CURRCHARROW,SysBYTETempA
	movlw	7
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF46
;LocalCharCode++
	incf	LOCALCHARCODE,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	LOCALCHARCODE_H,F,BANKED
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	movff	LOCALCHARCODE,SYSSTRINGA
	movff	LOCALCHARCODE_H,SYSSTRINGA_H
	call	OLEDFONT2
	movwf	CURRCHARVAL,ACCESS
;end if
ENDIF46
;It is the intercharacter space, put out one pixel row
;if CurrCharCol = COLSperfont then
	movf	COLSPERFONT,W,ACCESS
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF47
;Put out a white intercharacter pixel/space
;GLCDTemp = CharLocX + CurrCharCol
	movf	CURRCHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	GLCDTEMP,ACCESS
	movlw	0
	addwfc	CHARLOCX_H,W,ACCESS
	movwf	GLCDTEMP_H,ACCESS
;if GLCDfntDefaultSize = 2 then
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF50
;GLCDTemp++
	incf	GLCDTEMP,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	GLCDTEMP_H,F,ACCESS
;end if
ENDIF50
;PSet GLCDTemp , CharLocY + CurrCharRow, GLCDBACKGROUND
	movff	GLCDTEMP,GLCDX
	movff	GLCDTEMP_H,GLCDX_H
	movf	CURRCHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	GLCDY,ACCESS
	movlw	0
	addwfc	CHARLOCY_H,W,ACCESS
	movwf	GLCDY_H,ACCESS
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;end if
ENDIF47
;Next
	movf	ROWSPERFONT,W,BANKED
	subwf	CURRCHARROW,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop15
SysForLoopEnd15
;Next
	movf	COLSPERFONT,W,ACCESS
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop14
SysForLoopEnd14
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	129
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	40
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

Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	decfsz	SysWaitTempS, F,ACCESS
	bra	DS_START
	return

;********************************************************************************

;Source: hwspi.h (665)
FASTHWSPITRANSFER
;Master mode only
;One byte transfer count
;SPI1TCNTL = 1
	movlw	1
	banksel	SPI1TCNTL
	movwf	SPI1TCNTL,BANKED
;SPI1TXB = SPITxData
	movffl	SPITXDATA,SPI1TXB
;wait while SPI1RXIF = SPI_RX_IN_PROGRESS
SysWaitLoop1
	banksel	PIR2
	btfss	PIR2,SPI1RXIF,BANKED
	bra	SysWaitLoop1
;SPIRxData = SPI1RXB
	movffl	SPI1RXB,SPIRXDATA
	banksel	0
	return

;********************************************************************************

;Source: epd_epd2in13d.h (797)
FILLEDBOX_EPD2IN13D
;Make sure that starting point (1) is always less than end point (2)
;Dim EPD_Ind_raw, EPD_Ind_col as Word
;If LineX1 > LineX2 Then
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF62
;GLCDTemp = LineX1
	movff	LINEX1,GLCDTEMP
;LineX1 = LineX2
	movff	LINEX2,LINEX1
	movff	LINEX2_H,LINEX1_H
;LineX2 = GLCDTemp
	movff	GLCDTEMP,LINEX2
	clrf	LINEX2_H,BANKED
;End If
ENDIF62
;If LineY1 > LineY2 Then
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF63
;GLCDTemp = LineY1
	movff	LINEY1,GLCDTEMP
;LineY1 = LineY2
	movff	LINEY2,LINEY1
	movff	LINEY2_H,LINEY1_H
;LineY2 = GLCDTemp
	movff	GLCDTEMP,LINEY2
	clrf	LINEY2_H,BANKED
;End If
ENDIF63
;for EPD_Ind_raw=LineY1  to LineY2
	movlw	1
	subwf	LINEY1,W,BANKED
	movwf	EPD_IND_RAW,ACCESS
	movlw	0
	subwfb	LINEY1_H,W,BANKED
	movwf	EPD_IND_RAW_H,ACCESS
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd16
SysForLoop16
	incf	EPD_IND_RAW,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,ACCESS
;for EPD_Ind_col=LineX1 to lineX2
	movlw	1
	subwf	LINEX1,W,BANKED
	movwf	EPD_IND_COL,ACCESS
	movlw	0
	subwfb	LINEX1_H,W,BANKED
	movwf	EPD_IND_COL_H,ACCESS
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd17
SysForLoop17
	incf	EPD_IND_COL,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_COL_H,F,ACCESS
;PSet_EPD2in13D(EPD_Ind_Col, EPD_Ind_raw, LineColour)
	movff	EPD_IND_COL,GLCDX
	movff	EPD_IND_COL_H,GLCDX_H
	movff	EPD_IND_RAW,GLCDY
	movff	EPD_IND_RAW_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;next
	movff	EPD_IND_COL,SysWORDTempA
	movff	EPD_IND_COL_H,SysWORDTempA_H
	movff	LINEX2,SysWORDTempB
	movff	LINEX2_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop17
SysForLoopEnd17
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movff	LINEY2,SysWORDTempB
	movff	LINEY2_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop16
SysForLoopEnd16
	return

;********************************************************************************

;Source: glcd.h (4073)
FILLEDTRIANGLE
;dim  GLCD_aa, GLCD_bb, GLCD_last as word
;Sort coordinates by Y order (yoffset3 >= yoffset2 >= yoffset)
;if (yoffset > yoffset2) then
	movff	YOFFSET,SysWORDTempB
	movff	YOFFSET_H,SysWORDTempB_H
	movff	YOFFSET2,SysWORDTempA
	movff	YOFFSET2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF25
;swap(yoffset, yoffset2)
	movff	YOFFSET,SYSCALCTEMPA
	movff	YOFFSET_H,SYSCALCTEMPA_H
	movff	YOFFSET2,SYSCALCTEMPB
	movff	YOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP510
	movff	SYSCALCTEMPA,YOFFSET
	movff	SYSCALCTEMPA_H,YOFFSET_H
	movff	SYSCALCTEMPB,YOFFSET2
	movff	SYSCALCTEMPB_H,YOFFSET2_H
;swap(xoffset, xoffset2)
	movff	XOFFSET,SYSCALCTEMPA
	movff	XOFFSET_H,SYSCALCTEMPA_H
	movff	XOFFSET2,SYSCALCTEMPB
	movff	XOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP510
	movff	SYSCALCTEMPA,XOFFSET
	movff	SYSCALCTEMPA_H,XOFFSET_H
	movff	SYSCALCTEMPB,XOFFSET2
	movff	SYSCALCTEMPB_H,XOFFSET2_H
;end if
ENDIF25
;if (yoffset2 > yoffset3) then
	movff	YOFFSET2,SysWORDTempB
	movff	YOFFSET2_H,SysWORDTempB_H
	movff	YOFFSET3,SysWORDTempA
	movff	YOFFSET3_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF26
;swap(yoffset3, yoffset2)
	movff	YOFFSET3,SYSCALCTEMPA
	movff	YOFFSET3_H,SYSCALCTEMPA_H
	movff	YOFFSET2,SYSCALCTEMPB
	movff	YOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP510
	movff	SYSCALCTEMPA,YOFFSET3
	movff	SYSCALCTEMPA_H,YOFFSET3_H
	movff	SYSCALCTEMPB,YOFFSET2
	movff	SYSCALCTEMPB_H,YOFFSET2_H
;swap(xoffset3, xoffset2)
	movff	XOFFSET3,SYSCALCTEMPA
	movff	XOFFSET3_H,SYSCALCTEMPA_H
	movff	XOFFSET2,SYSCALCTEMPB
	movff	XOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP510
	movff	SYSCALCTEMPA,XOFFSET3
	movff	SYSCALCTEMPA_H,XOFFSET3_H
	movff	SYSCALCTEMPB,XOFFSET2
	movff	SYSCALCTEMPB_H,XOFFSET2_H
;end if
ENDIF26
;if (yoffset > yoffset2) then
	movff	YOFFSET,SysWORDTempB
	movff	YOFFSET_H,SysWORDTempB_H
	movff	YOFFSET2,SysWORDTempA
	movff	YOFFSET2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF27
;swap(yoffset, yoffset2)
	movff	YOFFSET,SYSCALCTEMPA
	movff	YOFFSET_H,SYSCALCTEMPA_H
	movff	YOFFSET2,SYSCALCTEMPB
	movff	YOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP510
	movff	SYSCALCTEMPA,YOFFSET
	movff	SYSCALCTEMPA_H,YOFFSET_H
	movff	SYSCALCTEMPB,YOFFSET2
	movff	SYSCALCTEMPB_H,YOFFSET2_H
;swap(xoffset, xoffset2)
	movff	XOFFSET,SYSCALCTEMPA
	movff	XOFFSET_H,SYSCALCTEMPA_H
	movff	XOFFSET2,SYSCALCTEMPB
	movff	XOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP510
	movff	SYSCALCTEMPA,XOFFSET
	movff	SYSCALCTEMPA_H,XOFFSET_H
	movff	SYSCALCTEMPB,XOFFSET2
	movff	SYSCALCTEMPB_H,XOFFSET2_H
;end if
ENDIF27
;Handle awkward all-on-same-line case as its own thing
;if (yoffset = yoffset3) then
	movff	YOFFSET,SysWORDTempA
	movff	YOFFSET_H,SysWORDTempA_H
	movff	YOFFSET3,SysWORDTempB
	movff	YOFFSET3_H,SysWORDTempB_H
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF28
;GLCD_bb = xoffset
	movff	XOFFSET,GLCD_BB
	movff	XOFFSET_H,GLCD_BB_H
;GLCD_aa = xoffset
	movff	XOFFSET,GLCD_AA
	movff	XOFFSET_H,GLCD_AA_H
;if (xoffset2 < GLCD_aa ) Then
	movff	XOFFSET2,SysWORDTempA
	movff	XOFFSET2_H,SysWORDTempA_H
	movff	GLCD_AA,SysWORDTempB
	movff	GLCD_AA_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE36_1
;GLCD_aa = xoffset2
	movff	XOFFSET2,GLCD_AA
	movff	XOFFSET2_H,GLCD_AA_H
;else if (xoffset2 > GLCD_bb ) then
	bra	ENDIF36
ELSE36_1
	movff	XOFFSET2,SysWORDTempB
	movff	XOFFSET2_H,SysWORDTempB_H
	movff	GLCD_BB,SysWORDTempA
	movff	GLCD_BB_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF36
;GLCD_bb = xoffset2
	movff	XOFFSET2,GLCD_BB
	movff	XOFFSET2_H,GLCD_BB_H
;end if
ENDIF36
;if (xoffset3 < GLCD_aa) Then
	movff	XOFFSET3,SysWORDTempA
	movff	XOFFSET3_H,SysWORDTempA_H
	movff	GLCD_AA,SysWORDTempB
	movff	GLCD_AA_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE37_1
;GLCD_aa = xoffset3
	movff	XOFFSET3,GLCD_AA
	movff	XOFFSET3_H,GLCD_AA_H
;else if ( xoffset3 > GLCD_bb) then
	bra	ENDIF37
ELSE37_1
	movff	XOFFSET3,SysWORDTempB
	movff	XOFFSET3_H,SysWORDTempB_H
	movff	GLCD_BB,SysWORDTempA
	movff	GLCD_BB_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF37
;GLCD_bb = xoffset3
	movff	XOFFSET3,GLCD_BB
	movff	XOFFSET3_H,GLCD_BB_H
;end if
ENDIF37
;Line( GLCD_aa, yoffset, GLCD_bb - GLCD_aa + 1, yoffset, LineColour)
	movff	GLCD_AA,LINEX1
	movff	GLCD_AA_H,LINEX1_H
	movff	YOFFSET,LINEY1
	movff	YOFFSET_H,LINEY1_H
	movf	GLCD_AA,W,ACCESS
	subwf	GLCD_BB,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	GLCD_AA_H,W,ACCESS
	subwfb	GLCD_BB_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movff	YOFFSET,LINEY2
	movff	YOFFSET_H,LINEY2_H
	rcall	LINE
;exit sub
	return
;end if
ENDIF28
;dim dxoffset01, dyoffset01, dxoffset02, dyoffset02, dxoffset12, dyoffset12, glcd_y as word
;dim glcd_sa, glcd_sb as Integer
;dxoffset01 = xoffset2 - xoffset
	movf	XOFFSET,W,BANKED
	subwf	XOFFSET2,W,BANKED
	movwf	DXOFFSET01,ACCESS
	movf	XOFFSET_H,W,BANKED
	subwfb	XOFFSET2_H,W,BANKED
	movwf	DXOFFSET01_H,ACCESS
;dyoffset01 = yoffset2 - yoffset
	movf	YOFFSET,W,BANKED
	subwf	YOFFSET2,W,BANKED
	movwf	DYOFFSET01,ACCESS
	movf	YOFFSET_H,W,BANKED
	subwfb	YOFFSET2_H,W,BANKED
	movwf	DYOFFSET01_H,ACCESS
;dxoffset02 = xoffset3 - xoffset
	movf	XOFFSET,W,BANKED
	subwf	XOFFSET3,W,BANKED
	movwf	DXOFFSET02,ACCESS
	movf	XOFFSET_H,W,BANKED
	subwfb	XOFFSET3_H,W,BANKED
	movwf	DXOFFSET02_H,ACCESS
;dyoffset02 = yoffset3 - yoffset
	movf	YOFFSET,W,BANKED
	subwf	YOFFSET3,W,BANKED
	movwf	DYOFFSET02,ACCESS
	movf	YOFFSET_H,W,BANKED
	subwfb	YOFFSET3_H,W,BANKED
	movwf	DYOFFSET02_H,ACCESS
;dxoffset12 = xoffset3 - xoffset2
	movf	XOFFSET2,W,BANKED
	subwf	XOFFSET3,W,BANKED
	movwf	DXOFFSET12,ACCESS
	movf	XOFFSET2_H,W,BANKED
	subwfb	XOFFSET3_H,W,BANKED
	movwf	DXOFFSET12_H,ACCESS
;dyoffset12 = yoffset3 - yoffset2
	movf	YOFFSET2,W,BANKED
	subwf	YOFFSET3,W,BANKED
	movwf	DYOFFSET12,ACCESS
	movf	YOFFSET2_H,W,BANKED
	subwfb	YOFFSET3_H,W,BANKED
	movwf	DYOFFSET12_H,ACCESS
;glcd_sa   = 0
	clrf	GLCD_SA,ACCESS
	clrf	GLCD_SA_H,ACCESS
;glcd_sb   = 0
	clrf	GLCD_SB,ACCESS
	clrf	GLCD_SB_H,ACCESS
;
;For upper part of triangle, find scanline crossings for segments
;0-1 and 0-2.  If yoffset2=yoffset3 (flat-bottomed triangle), the scanline yoffset2
;is included here (and second loop will be skipped, avoiding a /0
;error there), otherwise scanline yoffset2 is skipped here and handled
;in the second loop...which also avoids a /0 error here if yoffset=yoffset2
;(flat-topped triangle).
;if ( yoffset2 = yoffset3) then
	movff	YOFFSET2,SysWORDTempA
	movff	YOFFSET2_H,SysWORDTempA_H
	movff	YOFFSET3,SysWORDTempB
	movff	YOFFSET3_H,SysWORDTempB_H
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE29_1
;GLCD_last = yoffset2 ;   Include yoffset2 scanline
	movff	YOFFSET2,GLCD_LAST
	movff	YOFFSET2_H,GLCD_LAST_H
;else
	bra	ENDIF29
ELSE29_1
;GLCD_last = yoffset2 - 1;  Skip it
	movlw	1
	subwf	YOFFSET2,W,BANKED
	movwf	GLCD_LAST,ACCESS
	movlw	0
	subwfb	YOFFSET2_H,W,BANKED
	movwf	GLCD_LAST_H,ACCESS
;end if
ENDIF29
;for glcd_y = yoffset to glcd_last
	movlw	1
	subwf	YOFFSET,W,BANKED
	movwf	GLCD_Y,ACCESS
	movlw	0
	subwfb	YOFFSET_H,W,BANKED
	movwf	GLCD_Y_H,ACCESS
	movff	YOFFSET,SysWORDTempB
	movff	YOFFSET_H,SysWORDTempB_H
	movff	GLCD_LAST,SysWORDTempA
	movff	GLCD_LAST_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd8
SysForLoop8
	incf	GLCD_Y,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	GLCD_Y_H,F,ACCESS
;glcd_aa   = xoffset +  glcd_sa / dyoffset01
	movff	GLCD_SA,SysINTEGERTempA
	movff	GLCD_SA_H,SysINTEGERTempA_H
	movff	DYOFFSET01,SysINTEGERTempB
	movff	DYOFFSET01_H,SysINTEGERTempB_H
	call	SysDivSubINT
	movf	SysINTEGERTempA,W,ACCESS
	addwf	XOFFSET,W,BANKED
	movwf	GLCD_AA,ACCESS
	movf	SysINTEGERTempA_H,W,ACCESS
	addwfc	XOFFSET_H,W,BANKED
	movwf	GLCD_AA_H,ACCESS
;glcd_bb   = xoffset +  glcd_sb / dyoffset02
	movff	GLCD_SB,SysINTEGERTempA
	movff	GLCD_SB_H,SysINTEGERTempA_H
	movff	DYOFFSET02,SysINTEGERTempB
	movff	DYOFFSET02_H,SysINTEGERTempB_H
	call	SysDivSubINT
	movf	SysINTEGERTempA,W,ACCESS
	addwf	XOFFSET,W,BANKED
	movwf	GLCD_BB,ACCESS
	movf	SysINTEGERTempA_H,W,ACCESS
	addwfc	XOFFSET_H,W,BANKED
	movwf	GLCD_BB_H,ACCESS
;glcd_sa = glcd_sa + dxoffset01
	movf	DXOFFSET01,W,ACCESS
	addwf	GLCD_SA,F,ACCESS
	movf	DXOFFSET01_H,W,ACCESS
	addwfc	GLCD_SA_H,F,ACCESS
;glcd_sb = glcd_sb + dxoffset02
	movf	DXOFFSET02,W,ACCESS
	addwf	GLCD_SB,F,ACCESS
	movf	DXOFFSET02_H,W,ACCESS
	addwfc	GLCD_SB_H,F,ACCESS
;if (glcd_aa > glcd_bb)  then
	movff	GLCD_AA,SysWORDTempB
	movff	GLCD_AA_H,SysWORDTempB_H
	movff	GLCD_BB,SysWORDTempA
	movff	GLCD_BB_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF31
;swap(glcd_aa, glcd_bb)
	movff	GLCD_AA,SYSCALCTEMPA
	movff	GLCD_AA_H,SYSCALCTEMPA_H
	movff	GLCD_BB,SYSCALCTEMPB
	movff	GLCD_BB_H,SYSCALCTEMPB_H
	call	SWAP510
	movff	SYSCALCTEMPA,GLCD_AA
	movff	SYSCALCTEMPA_H,GLCD_AA_H
	movff	SYSCALCTEMPB,GLCD_BB
	movff	SYSCALCTEMPB_H,GLCD_BB_H
;end if
ENDIF31
;Line(glcd_aa, glcd_y, glcd_bb , glcd_y, LineColour)
	movff	GLCD_AA,LINEX1
	movff	GLCD_AA_H,LINEX1_H
	movff	GLCD_Y,LINEY1
	movff	GLCD_Y_H,LINEY1_H
	movff	GLCD_BB,LINEX2
	movff	GLCD_BB_H,LINEX2_H
	movff	GLCD_Y,LINEY2
	movff	GLCD_Y_H,LINEY2_H
	rcall	LINE
;next
	movff	GLCD_Y,SysWORDTempA
	movff	GLCD_Y_H,SysWORDTempA_H
	movff	GLCD_LAST,SysWORDTempB
	movff	GLCD_LAST_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop8
SysForLoopEnd8
;For lower part of triangle, find scanline crossings for segments
;0-2 and 1-2.  This loop is skipped if yoffset2=yoffset3.
;glcd_sa = dxoffset12 * (glcd_y - yoffset2);
	movf	YOFFSET2,W,BANKED
	subwf	GLCD_Y,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	YOFFSET2_H,W,BANKED
	subwfb	GLCD_Y_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movff	DXOFFSET12,SysINTEGERTempA
	movff	DXOFFSET12_H,SysINTEGERTempA_H
	movff	SysTemp2,SysINTEGERTempB
	movff	SysTemp2_H,SysINTEGERTempB_H
	call	SysMultSubINT
	movff	SysINTEGERTempX,GLCD_SA
	movff	SysINTEGERTempX_H,GLCD_SA_H
;glcd_sb = dxoffset02 * (glcd_y - yoffset);
	movf	YOFFSET,W,BANKED
	subwf	GLCD_Y,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	YOFFSET_H,W,BANKED
	subwfb	GLCD_Y_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movff	DXOFFSET02,SysINTEGERTempA
	movff	DXOFFSET02_H,SysINTEGERTempA_H
	movff	SysTemp2,SysINTEGERTempB
	movff	SysTemp2_H,SysINTEGERTempB_H
	call	SysMultSubINT
	movff	SysINTEGERTempX,GLCD_SB
	movff	SysINTEGERTempX_H,GLCD_SB_H
;for glcd_y = glcd_last to yoffset3
	movlw	1
	subwf	GLCD_LAST,W,ACCESS
	movwf	GLCD_Y,ACCESS
	movlw	0
	subwfb	GLCD_LAST_H,W,ACCESS
	movwf	GLCD_Y_H,ACCESS
	movff	GLCD_LAST,SysWORDTempB
	movff	GLCD_LAST_H,SysWORDTempB_H
	movff	YOFFSET3,SysWORDTempA
	movff	YOFFSET3_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd9
SysForLoop9
	incf	GLCD_Y,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	GLCD_Y_H,F,ACCESS
;glcd_aa   = xoffset2 +  glcd_sa / dyoffset12
	movff	GLCD_SA,SysINTEGERTempA
	movff	GLCD_SA_H,SysINTEGERTempA_H
	movff	DYOFFSET12,SysINTEGERTempB
	movff	DYOFFSET12_H,SysINTEGERTempB_H
	call	SysDivSubINT
	movf	SysINTEGERTempA,W,ACCESS
	addwf	XOFFSET2,W,BANKED
	movwf	GLCD_AA,ACCESS
	movf	SysINTEGERTempA_H,W,ACCESS
	addwfc	XOFFSET2_H,W,BANKED
	movwf	GLCD_AA_H,ACCESS
;glcd_bb   = xoffset +  glcd_sb / dyoffset02
	movff	GLCD_SB,SysINTEGERTempA
	movff	GLCD_SB_H,SysINTEGERTempA_H
	movff	DYOFFSET02,SysINTEGERTempB
	movff	DYOFFSET02_H,SysINTEGERTempB_H
	call	SysDivSubINT
	movf	SysINTEGERTempA,W,ACCESS
	addwf	XOFFSET,W,BANKED
	movwf	GLCD_BB,ACCESS
	movf	SysINTEGERTempA_H,W,ACCESS
	addwfc	XOFFSET_H,W,BANKED
	movwf	GLCD_BB_H,ACCESS
;glcd_sa = glcd_sa + dxoffset12
	movf	DXOFFSET12,W,ACCESS
	addwf	GLCD_SA,F,ACCESS
	movf	DXOFFSET12_H,W,ACCESS
	addwfc	GLCD_SA_H,F,ACCESS
;glcd_sb = glcd_sb + dxoffset02
	movf	DXOFFSET02,W,ACCESS
	addwf	GLCD_SB,F,ACCESS
	movf	DXOFFSET02_H,W,ACCESS
	addwfc	GLCD_SB_H,F,ACCESS
;if (glcd_aa > glcd_bb)  then
	movff	GLCD_AA,SysWORDTempB
	movff	GLCD_AA_H,SysWORDTempB_H
	movff	GLCD_BB,SysWORDTempA
	movff	GLCD_BB_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF34
;swap(glcd_aa, glcd_bb)
	movff	GLCD_AA,SYSCALCTEMPA
	movff	GLCD_AA_H,SYSCALCTEMPA_H
	movff	GLCD_BB,SYSCALCTEMPB
	movff	GLCD_BB_H,SYSCALCTEMPB_H
	call	SWAP510
	movff	SYSCALCTEMPA,GLCD_AA
	movff	SYSCALCTEMPA_H,GLCD_AA_H
	movff	SYSCALCTEMPB,GLCD_BB
	movff	SYSCALCTEMPB_H,GLCD_BB_H
;end if
ENDIF34
;Line(glcd_aa, glcd_y, glcd_bb , glcd_y, LineColour)
	movff	GLCD_AA,LINEX1
	movff	GLCD_AA_H,LINEX1_H
	movff	GLCD_Y,LINEY1
	movff	GLCD_Y_H,LINEY1_H
	movff	GLCD_BB,LINEX2
	movff	GLCD_BB_H,LINEX2_H
	movff	GLCD_Y,LINEY2
	movff	GLCD_Y_H,LINEY2_H
	rcall	LINE
;next
	movff	GLCD_Y,SysWORDTempA
	movff	GLCD_Y_H,SysWORDTempA_H
	movff	YOFFSET3,SysWORDTempB
	movff	YOFFSET3_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop9
SysForLoopEnd9
	return

;********************************************************************************

;Source: glcd.h (1129)
GLCDLOCATESTRING
;dim PrintLocY as word
;if PrintLocY < 2 then
	movff	PRINTLOCY,SysWORDTempA
	movff	PRINTLOCY_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE12_1
;PrintLocY = 0
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
;else
	bra	ENDIF12
ELSE12_1
;PrintLocY--
	movlw	1
	subwf	PRINTLOCY,F,BANKED
	movlw	0
	subwfb	PRINTLOCY_H,F,BANKED
;PrintLocY = ( PrintLocY * ( GLCDfntDefaultHeight * GLCDfntDefaultSize ) ) mod EPD_CORRECTED_HEIGHT
	movf	GLCDFNTDEFAULTHEIGHT,W,ACCESS
	mulwf	GLCDFNTDEFAULTSIZE,ACCESS
	movffl	PRODL,SysTemp1
	movff	PRINTLOCY,SysWORDTempA
	movff	PRINTLOCY_H,SysWORDTempA_H
	movff	SysTemp1,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,SysTemp2
	movff	SysWORDTempX_H,SysTemp2_H
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movlw	208
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempX,PRINTLOCY
	movff	SysWORDTempX_H,PRINTLOCY_H
;end if
ENDIF12
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:, Source: glcd.h (850)
GLCDPRINT4
;GLCD.h Sub GLCDPrint
;Dim GLCDPrintLoc  as word
;Dim GLCDPrint_String_Counter, GLCDPrintLen as byte
;GLCDPrintLen = LCDPrintData(0)
	movffl	SysLCDPRINTDATAHandler,AFSR0
	movffl	SysLCDPRINTDATAHandler_H,AFSR0_H
	movffl	INDF0,GLCDPRINTLEN
;If GLCDPrintLen = 0 Then Exit Sub
	movf	GLCDPRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	return
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	movff	GLCDFONTWIDTH,OLDGLCDFONTWIDTH
;GLCDPrintLoc = PrintLocX
	movff	PRINTLOCX,GLCDPRINTLOC
	movff	PRINTLOCX_H,GLCDPRINTLOC_H
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
	clrf	GLCDPRINT_STRING_COUNTER,ACCESS
	movlw	1
	subwf	GLCDPRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd5
SysForLoop5
	incf	GLCDPRINT_STRING_COUNTER,F,ACCESS
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	movff	GLCDPRINTLOC,CHARLOCX
	movff	GLCDPRINTLOC_H,CHARLOCX_H
	movff	PRINTLOCY,CHARLOCY
	movff	PRINTLOCY_H,CHARLOCY_H
	movf	GLCDPRINT_STRING_COUNTER,W,ACCESS
	addwf	SysLCDPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysLCDPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,CHARCODE
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	DRAWCHAR_EPD2IN13D
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1088)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	movf	GLCDFONTWIDTH,W,ACCESS
	mulwf	GLCDFNTDEFAULTSIZE,ACCESS
	movffl	PRODL,SysTemp1
	movf	SysTemp1,W,BANKED
	addwf	GLCDPRINTLOC,W,ACCESS
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	GLCDPRINTLOC_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	addwf	SysTemp2,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	subwf	SysTemp1,W,BANKED
	movwf	GLCDPRINTLOC,ACCESS
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	GLCDPRINTLOC_H,ACCESS
;Next
	movf	GLCDPRINTLEN,W,ACCESS
	subwf	GLCDPRINT_STRING_COUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
SysForLoopEnd5
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movff	GLCDPRINTLOC,PRINTLOCX
	movff	GLCDPRINTLOC_H,PRINTLOCX_H
;GLCDFontWidth = OldGLCDFontWidth
	movff	OLDGLCDFONTWIDTH,GLCDFONTWIDTH
	return

;********************************************************************************

;Source: glcd.h (1109)
GLCDPRINTSTRINGLN
;dim PrintLocX, PrintLocY as word
;GLCDPrint( PrintLocX , PrintLocY , LCDPrintData )
	movff	SysLCDPRINTDATAHandler,SysLCDPRINTDATAHandler
	movff	SysLCDPRINTDATAHandler_H,SysLCDPRINTDATAHandler_H
	rcall	GLCDPRINT4
;Update the current X and Y position
;PrintLocX = 0
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
;When using Transaction  PrintLocY will get incremented. This needs to be protected
;PrintLocY = ( PrintLocY + ( GLCDfntDefaultHeight * GLCDfntDefaultSize ) ) mod EPD_CORRECTED_HEIGHT
	movf	GLCDFNTDEFAULTHEIGHT,W,ACCESS
	mulwf	GLCDFNTDEFAULTSIZE,ACCESS
	movffl	PRODL,SysTemp1
	movf	SysTemp1,W,BANKED
	addwf	PRINTLOCY,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	PRINTLOCY_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movlw	208
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempX,PRINTLOCY
	movff	SysWORDTempX_H,PRINTLOCY_H
	return

;********************************************************************************

;Source: E_paper-2in13_PIC_RotateTest.gcb (24)
INITPPS
;This has been added to turn off PPS SPI when in SPI software mode
;Module: SPI1
;RC3PPS = 0x001E    'SCK1 > RC3
	movlw	30
	banksel	RC3PPS
	movwf	RC3PPS,BANKED
;SPI1SCKPPS = 0x0013    'RC3 > SCK1 (bi-directional)
	movlw	19
	movwf	SPI1SCKPPS,BANKED
;RC5PPS = 0x001F    'SDO1 > RC5
	movlw	31
	movwf	RC5PPS,BANKED
	banksel	0
	return

;********************************************************************************

;Source: system.h (99)
INITSYS
;Set up internal oscillator
;Handle OSCCON1 register for parts that have this register
;asm showdebug OSCCON type is 100 'This is the routine to support OSCCON1 config addresss
;osccon type is 100
;OSCCON1 = 0x60 ' NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
	movlw	96
	banksel	OSCCON1
	movwf	OSCCON1,BANKED
;OSCCON3 = 0x00 ' CSWHOLD may proceed; SOSCPWR Low power
	clrf	OSCCON3,BANKED
;OSCEN = 0x00   ' MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
	clrf	OSCEN,BANKED
;OSCTUNE = 0x00 ' HFTUN 0
	clrf	OSCTUNE,BANKED
;The MCU is a ChipFamily16
;Section support many MCUs, 18FxxK40, 18FxxK42 etc etc all have NDIV3 bit
;asm showdebug OSCCON type is 101 ' ChipFamily16 and NDIV3 bit
;osccon type is 101
;Clear NDIV3:0
;NDIV3 = 0
	bcf	OSCCON1,NDIV3,BANKED
;NDIV2 = 0
	bcf	OSCCON1,NDIV2,BANKED
;NDIV1 = 0
	bcf	OSCCON1,NDIV1,BANKED
;NDIV0 = 0
	bcf	OSCCON1,NDIV0,BANKED
;OSCFRQ = 0b00001000  '64mhz
	movlw	8
	movwf	OSCFRQ,BANKED
;Clear BSR on ChipFamily16 MCUs
;BSR = 0
	clrf	BSR,ACCESS
;Clear TBLPTRU on MCUs with this bit as this must be zero
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,BANKED
;Commence clearing any ANSEL variants in the part
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA,BANKED
;ANSELB = 0
	clrf	ANSELB,BANKED
;ANSELC = 0
	clrf	ANSELC,BANKED
;ANSELD = 0
	clrf	ANSELD,BANKED
;ANSELE = 0
	clrf	ANSELE,BANKED
;End clearing any ANSEL variants in the part
;Set comparator register bits for many MCUs with register CM2CON0
;C2EN = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2EN,BANKED
;C1EN = 0
	bcf	CM1CON0,C1EN,BANKED
;Turn off all ports
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
	banksel	0
	return

;********************************************************************************

;Source: epd_epd2in13d.h (160)
INIT_EPD2IN13D
;dim _GLCDPagesL, _GLCDPagesH  as byte
;asm showdebug Current_buffer_size_is BUFFWIDTH
;current_buffer_size_is 1378
;Dir   EPD_DC     OUT
	bcf	TRISA,0,ACCESS
;Dir   EPD_CS     OUT
	bcf	TRISC,1,ACCESS
;Dir   EPD_RESET  OUT
	bcf	TRISD,2,ACCESS
;Dir   EPD_DO     OUT
	bcf	TRISC,5,ACCESS
;Dir   EPD_SCK    OUT
	bcf	TRISC,3,ACCESS
;Dir   EPD_Busy   IN
	bsf	TRISC,0,ACCESS
;SET EPD_RESET ON
	bsf	LATD,2,ACCESS
;wait 200 ms
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SET EPD_RESET OFF
	bcf	LATD,2,ACCESS
;wait 20 ms
	movlw	20
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SET EPD_RESET ON
	bsf	LATD,2,ACCESS
;wait 200 ms
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;harware SPI mode
;asm showdebug SPI constant used equates to HWSPIMODESCRIPT
;spi constant used equates to 12
;SPIMode HWSPIMODESCRIPT, 0
	movlw	12
	movwf	SPICURRENTMODE,BANKED
	clrf	SPICLOCKMODE,BANKED
	call	SPIMODE645
;SendCommand_EPD2in13D(BOOSTER_SOFT_START)
	movlw	6
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x17)
	movlw	23
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x17)
	movlw	23
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x17)
	movlw	23
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;wait 200 ms
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_EPD2in13D(POWER_SETTING)
	movlw	1
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x03)
	movlw	3
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x00)
	clrf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x2B)
	movlw	43
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x2B)
	movlw	43
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x03)
	movlw	3
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;wait 200 ms
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;SendCommand_EPD2in13D(POWER_ON)
	movlw	4
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;SendCommand_EPD2in13D(PANEL_SETTING)
	clrf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(PANEL_SETTING_VALUE or PANEL_SETTING_KWR )
	movlw	191
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(PLL_CONTROL)
	movlw	48
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x3C)
	movlw	60
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(RESOLUTION_SETTING)
	movlw	97
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x68)
	movlw	104
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x00)
	clrf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0xD4)
	movlw	212
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(VCM_DC_SETTING)
	movlw	130
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x12)
	movlw	18
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;LoadLUTS_EPD2in13D
	rcall	LOADLUTS_EPD2IN13D
;Colours
;GLCDForeground =TFT_WHITE
	setf	GLCDFOREGROUND,ACCESS
	setf	GLCDFOREGROUND_H,ACCESS
;Default Colours
;GLCDBackground = TFT_BLACK
	clrf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
;GLCDFontWidth = 5
	movlw	5
	movwf	GLCDFONTWIDTH,ACCESS
;Variables required for device
;GLCDDeviceWidth = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEWIDTH,ACCESS
	clrf	GLCDDEVICEWIDTH_H,ACCESS
;GLCDDeviceHeight= GLCD_HEIGHT- 1
	movlw	211
	movwf	GLCDDEVICEHEIGHT,ACCESS
	clrf	GLCDDEVICEHEIGHT_H,ACCESS
;GLCDRotate Portrait
	movlw	4
	movwf	EPD2IN13DADDRESSTYPE,ACCESS
	call	ROTATE_EPD2IN13D
;GLCDfntDefault = 0
	clrf	GLCDFNTDEFAULT,ACCESS
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDfntDefaultHeight = 8
	movlw	8
	movwf	GLCDFNTDEFAULTHEIGHT,ACCESS
;CLS_EPD2in13D_init
	call	CLS_EPD2IN13D_INIT
;_GLCDPagesH = EPD_N_PAGE - 1
	movlw	1
	movwf	_GLCDPAGESH,BANKED
;_GLCDPagesL = 0
	clrf	_GLCDPAGESL,BANKED
;_GLCDPage = 0
	clrf	_GLCDPAGE,BANKED
	return

;********************************************************************************

;Source: glcd.h (1482)
LINE
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	clrf	LINEDIFFX,BANKED
	clrf	LINEDIFFX_H,BANKED
;LineDiffY = 0
	clrf	LINEDIFFY,BANKED
	clrf	LINEDIFFY_H,BANKED
;LineStepX = 0
	clrf	LINESTEPX,BANKED
	clrf	LINESTEPX_H,BANKED
;LineStepY = 0
	clrf	LINESTEPY,BANKED
	clrf	LINESTEPY_H,BANKED
;LineDiffX_x2 = 0
	clrf	LINEDIFFX_X2,BANKED
	clrf	LINEDIFFX_X2_H,BANKED
;LineDiffY_x2 = 0
	clrf	LINEDIFFY_X2,BANKED
	clrf	LINEDIFFY_X2_H,BANKED
;LineErr = 0
	clrf	LINEERR,BANKED
	clrf	LINEERR_H,BANKED
;LineDiffX =  LineX2 -   LineX1
	movf	LINEX1,W,BANKED
	subwf	LINEX2,W,BANKED
	movwf	LINEDIFFX,BANKED
	movf	LINEX1_H,W,BANKED
	subwfb	LINEX2_H,W,BANKED
	movwf	LINEDIFFX_H,BANKED
;LineDiffY =  LineY2 -   LineY1
	movf	LINEY1,W,BANKED
	subwf	LINEY2,W,BANKED
	movwf	LINEDIFFY,BANKED
	movf	LINEY1_H,W,BANKED
	subwfb	LINEY2_H,W,BANKED
	movwf	LINEDIFFY_H,BANKED
;if (LineDiffX > 0) then
	movff	LINEDIFFX,SysINTEGERTempB
	movff	LINEDIFFX_H,SysINTEGERTempB_H
	clrf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	call	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE20_1
;LineStepX = 1
	movlw	1
	movwf	LINESTEPX,BANKED
	clrf	LINESTEPX_H,BANKED
;else
	bra	ENDIF20
ELSE20_1
;LineStepX = -1
	setf	LINESTEPX,BANKED
	setf	LINESTEPX_H,BANKED
;end if
ENDIF20
;if (LineDiffY > 0) then
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	clrf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	call	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE21_1
;LineStepY = 1
	movlw	1
	movwf	LINESTEPY,BANKED
	clrf	LINESTEPY_H,BANKED
;else
	bra	ENDIF21
ELSE21_1
;LineStepY = -1
	setf	LINESTEPY,BANKED
	setf	LINESTEPY_H,BANKED
;end if
ENDIF21
;LineDiffX = LineStepX * LineDiffX
	movff	LINESTEPX,SysINTEGERTempA
	movff	LINESTEPX_H,SysINTEGERTempA_H
	movff	LINEDIFFX,SysINTEGERTempB
	movff	LINEDIFFX_H,SysINTEGERTempB_H
	call	SysMultSubINT
	movff	SysINTEGERTempX,LINEDIFFX
	movff	SysINTEGERTempX_H,LINEDIFFX_H
;LineDiffY = LineStepY * LineDiffY
	movff	LINESTEPY,SysINTEGERTempA
	movff	LINESTEPY_H,SysINTEGERTempA_H
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	call	SysMultSubINT
	movff	SysINTEGERTempX,LINEDIFFY
	movff	SysINTEGERTempX_H,LINEDIFFY_H
;LineDiffX_x2 = LineDiffX*2
	movff	LINEDIFFX,SysINTEGERTempA
	movff	LINEDIFFX_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysMultSubINT
	movff	SysINTEGERTempX,LINEDIFFX_X2
	movff	SysINTEGERTempX_H,LINEDIFFX_X2_H
;LineDiffY_x2 = LineDiffY*2
	movff	LINEDIFFY,SysINTEGERTempA
	movff	LINEDIFFY_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysMultSubINT
	movff	SysINTEGERTempX,LINEDIFFY_X2
	movff	SysINTEGERTempX_H,LINEDIFFY_X2_H
;if ( LineDiffX >= LineDiffY) then
	movff	LINEDIFFX,SysINTEGERTempA
	movff	LINEDIFFX_H,SysINTEGERTempA_H
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	call	SysCompLessThanINT
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE22_1
;LineErr = LineDiffY_x2 - LineDiffX
	movf	LINEDIFFX,W,BANKED
	subwf	LINEDIFFY_X2,W,BANKED
	movwf	LINEERR,BANKED
	movf	LINEDIFFX_H,W,BANKED
	subwfb	LINEDIFFY_X2_H,W,BANKED
	movwf	LINEERR_H,BANKED
;do while (   LineX1 <>  LineX2 )
SysDoLoop_S3
	movff	linex1,SysWORDTempA
	movff	linex1_H,SysWORDTempA_H
	movff	linex2,SysWORDTempB
	movff	linex2_H,SysWORDTempB_H
	call	SysCompEqual16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E3
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEX1_H,GLCDX_H
	movff	LINEY1,GLCDY
	movff	LINEY1_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;LineX1 += LineStepX
	movf	LINESTEPX,W,BANKED
	addwf	LINEX1,F,BANKED
	movf	LINESTEPX_H,W,BANKED
	addwfc	LINEX1_H,F,BANKED
;if ( LineErr < 0) then
	movff	LINEERR,SysINTEGERTempA
	movff	LINEERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE23_1
;LineErr += LineDiffY_x2
	movf	LINEDIFFY_X2,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	LINEDIFFY_X2_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;else
	bra	ENDIF23
ELSE23_1
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	movf	LINEDIFFX_X2,W,BANKED
	subwf	LINEDIFFY_X2,W,BANKED
	movwf	SysTemp1,BANKED
	movf	LINEDIFFX_X2_H,W,BANKED
	subwfb	LINEDIFFY_X2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movf	SysTemp1,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	SysTemp1_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;LineY1 += LineStepY
	movf	LINESTEPY,W,BANKED
	addwf	LINEY1,F,BANKED
	movf	LINESTEPY_H,W,BANKED
	addwfc	LINEY1_H,F,BANKED
;end if
ENDIF23
;loop
	bra	SysDoLoop_S3
SysDoLoop_E3
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEX1_H,GLCDX_H
	movff	LINEY1,GLCDY
	movff	LINEY1_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;else
	bra	ENDIF22
ELSE22_1
;LineErr = LineDiffX_x2 - LineDiffY
	movf	LINEDIFFY,W,BANKED
	subwf	LINEDIFFX_X2,W,BANKED
	movwf	LINEERR,BANKED
	movf	LINEDIFFY_H,W,BANKED
	subwfb	LINEDIFFX_X2_H,W,BANKED
	movwf	LINEERR_H,BANKED
;do while (   LineY1 <>  LineY2)
SysDoLoop_S4
	movff	liney1,SysWORDTempA
	movff	liney1_H,SysWORDTempA_H
	movff	liney2,SysWORDTempB
	movff	liney2_H,SysWORDTempB_H
	call	SysCompEqual16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E4
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEX1_H,GLCDX_H
	movff	LINEY1,GLCDY
	movff	LINEY1_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;LineY1 += LineStepY
	movf	LINESTEPY,W,BANKED
	addwf	LINEY1,F,BANKED
	movf	LINESTEPY_H,W,BANKED
	addwfc	LINEY1_H,F,BANKED
;if ( LineErr < 0) then
	movff	LINEERR,SysINTEGERTempA
	movff	LINEERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE24_1
;LineErr += LineDiffX_x2
	movf	LINEDIFFX_X2,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	LINEDIFFX_X2_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;else
	bra	ENDIF24
ELSE24_1
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	movf	LINEDIFFY_X2,W,BANKED
	subwf	LINEDIFFX_X2,W,BANKED
	movwf	SysTemp1,BANKED
	movf	LINEDIFFY_X2_H,W,BANKED
	subwfb	LINEDIFFX_X2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movf	SysTemp1,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	SysTemp1_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;LineX1 += LineStepX
	movf	LINESTEPX,W,BANKED
	addwf	LINEX1,F,BANKED
	movf	LINESTEPX_H,W,BANKED
	addwfc	LINEX1_H,F,BANKED
;end if
ENDIF24
;loop
	bra	SysDoLoop_S4
SysDoLoop_E4
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEX1_H,GLCDX_H
	movff	LINEY1,GLCDY
	movff	LINEY1_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;end if
ENDIF22
	return

;********************************************************************************

;Source: epd_epd2in13d.h (256)
LOADLUTS_EPD2IN13D
;Dim DataVar as byte
;Dim Counter as Word
;SendCommand_EPD2in13D(VCM_DC_SETTING)
	movlw	130
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x00)
	clrf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(VCOM_AND_DATA_INTERVAL_SETTING)
	movlw	80
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;Mask VCOM_AND_DATA_INTERVAL bits and then Mask the user bits.
;SendData_EPD2in13D( (0x90 AND 0xF0 ) or ( VCOM_AND_DATA_INTERVAL AND 0X0F ))
	movlw	151
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(0x20) 'VCOM LUT
	movlw	32
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 44
	clrf	EPD_COUNTER,ACCESS
SysForLoop18
	incf	EPD_COUNTER,F,ACCESS
;ReadTable Lut_Vcom, EPD_Counter, DataVar
	movff	EPD_COUNTER,SYSSTRINGA
	rcall	LUT_VCOM
	movwf	DATAVAR,ACCESS
;SendData_EPD2in13D(DataVar)
	movff	DATAVAR,EPD2IN13D_DATA
	call	SENDDATA_EPD2IN13D
;next
	movlw	44
	subwf	EPD_COUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop18
SysForLoopEnd18
;SendCommand_EPD2in13D(0x21) 'WW LUT
	movlw	33
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	clrf	EPD_COUNTER,ACCESS
SysForLoop19
	incf	EPD_COUNTER,F,ACCESS
;ReadTable Lut_WW, EPD_Counter, DataVar
	movff	EPD_COUNTER,SYSSTRINGA
	rcall	LUT_WW
	movwf	DATAVAR,ACCESS
;SendData_EPD2in13D(DataVar)
	movff	DATAVAR,EPD2IN13D_DATA
	call	SENDDATA_EPD2IN13D
;next
	movlw	42
	subwf	EPD_COUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop19
SysForLoopEnd19
;SendCommand_EPD2in13D(0x22) 'BW LUT
	movlw	34
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	clrf	EPD_COUNTER,ACCESS
SysForLoop20
	incf	EPD_COUNTER,F,ACCESS
;ReadTable Lut_BW, EPD_Counter, DataVar
	movff	EPD_COUNTER,SYSSTRINGA
	rcall	LUT_BW
	movwf	DATAVAR,ACCESS
;SendData_EPD2in13D(DataVar)
	movff	DATAVAR,EPD2IN13D_DATA
	call	SENDDATA_EPD2IN13D
;next
	movlw	42
	subwf	EPD_COUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop20
SysForLoopEnd20
;SendCommand_EPD2in13D(0x23) 'WB LUT
	movlw	35
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	clrf	EPD_COUNTER,ACCESS
SysForLoop21
	incf	EPD_COUNTER,F,ACCESS
;ReadTable Lut_WB, EPD_Counter, DataVar
	movff	EPD_COUNTER,SYSSTRINGA
	rcall	LUT_WB
	movwf	DATAVAR,ACCESS
;SendData_EPD2in13D(DataVar)
	movff	DATAVAR,EPD2IN13D_DATA
	call	SENDDATA_EPD2IN13D
;next
	movlw	42
	subwf	EPD_COUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop21
SysForLoopEnd21
;SendCommand_EPD2in13D(0x24) 'BB LUT
	movlw	36
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	clrf	EPD_COUNTER,ACCESS
SysForLoop22
	incf	EPD_COUNTER,F,ACCESS
;ReadTable Lut_BB, EPD_Counter, DataVar
	movff	EPD_COUNTER,SYSSTRINGA
	rcall	LUT_BB
	movwf	DATAVAR,ACCESS
;SendData_EPD2in13D(DataVar)
	movff	DATAVAR,EPD2IN13D_DATA
	call	SENDDATA_EPD2IN13D
;next
	movlw	42
	subwf	EPD_COUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop22
SysForLoopEnd22
	return

;********************************************************************************

LUT_BB
	movlw	25
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableLUT_BB
	movwf	TBLPTRL,ACCESS
	movlw	high TableLUT_BB
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TableLUT_BB
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableLUT_BB
	db	42,128,8,0,0,0,2,144,40,40,0,0,1,128,20,0,0,0,1,80,18,18,0,0,1

;********************************************************************************

LUT_BW
	movlw	25
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableLUT_BW
	movwf	TBLPTRL,ACCESS
	movlw	high TableLUT_BW
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TableLUT_BW
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableLUT_BW
	db	42,64,23,0,0,0,2,144,15,15,0,0,3,64,10,1,0,0,1,160,14,14,0,0,2

;********************************************************************************

LUT_VCOM
	movlw	25
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableLUT_VCOM
	movwf	TBLPTRL,ACCESS
	movlw	high TableLUT_VCOM
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TableLUT_VCOM
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableLUT_VCOM
	db	44,0,8,0,0,0,2,96,40,40,0,0,1,0,20,0,0,0,1,0,18,18,0,0,1

;********************************************************************************

LUT_WB
	movlw	25
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableLUT_WB
	movwf	TBLPTRL,ACCESS
	movlw	high TableLUT_WB
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TableLUT_WB
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableLUT_WB
	db	42,128,8,0,0,0,2,144,40,40,0,0,1,128,20,0,0,0,1,80,18,18,0,0,1

;********************************************************************************

LUT_WW
	movlw	25
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableLUT_WW
	movwf	TBLPTRL,ACCESS
	movlw	high TableLUT_WW
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TableLUT_WW
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableLUT_WW
	db	42,64,8,0,0,0,2,144,40,40,0,0,1,64,20,0,0,0,1,160,18,18,0,0,1

;********************************************************************************

OLEDFONT1DATA
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	165
	movwf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableOLEDFONT1DATA
	movwf	TBLPTRL,ACCESS
	movlw	high TableOLEDFONT1DATA
	addwfc	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	movlw	upper TableOLEDFONT1DATA
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableOLEDFONT1DATA
	db	165,1,0,1,94,3,6,0,6,5,40,124,40,124,40,5,36,42,127,42,16,3,98,24,70,5,48,76,90,36
	db	80,1,6,2,60,66,2,66,60,5,40,16,124,16,40,3,16,56,16,1,192,3,16,16,16,1,64,3,96,24
	db	6,4,60,66,66,60,3,68,126,64,4,68,98,82,76,3,74,74,52,4,30,16,124,16,3,78,74,50
	db	4,60,74,74,48,3,98,18,14,4,52,74,74,52,4,12,82,82,60,1,72,2,128,104,3,16,40,68
	db	3,40,40,40,3,68,40,16,3,2,82,12,5,56,68,84,84,88,4,124,18,18,124,4,126,74,74,52
	db	4,60,66,66,36,4,126,66,66,60,3,126,74,74,3,126,10,10,4,60,66,82,52,4,126,8,8,126
	db	3,66,126,66,3,66,66,62,4,126,8,20,98,3,126,64,64,5,126,4,8,4,126,5,126,4,24,32
	db	126,4,60,66,66,60,4,126,18,18,12,4,60,66,66,188,4,126,18,18,108,4,68,74,74,48,3,2
	db	126,2,4,62,64,64,62,5,6,24,96,24,6,5,62,64,62,64,62,5,66,36,24,36,66,4,158,160
	db	160,126,4,98,82,74,70,2,126,66,3,6,24,96,2,66,126,3,32,16,32,4,128,128,128,128
	db	2,4,8,4,32,84,84,120,4,126,68,68,56,4,56,68,68,40,4,56,68,68,126,4,56,84,84,88
	db	2,124,10,4,152,164,164,124,4,126,4,4,120,1,122,2,64,58,4,126,16,40,68,1,126,5
	db	124,4,120,4,120,4,124,4,4,120,4,56,68,68,56,4,252,36,36,24,4,24,36,36,252,2,124,4
	db	4,72,84,84,32,3,4,62,68,4,60,64,64,60,5,12,48,64,48,12,5,60,64,60,64,60,5,68,40,16
	db	40,68,4,156,160,160,124,3,100,84,76,3,8,54,65,1,255,3,65,54,8,4,32,16,32,16,1

;********************************************************************************

OLEDFONT1DATA_H
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableOLEDFONT1DATA_H
	movwf	TBLPTRL,ACCESS
	movlw	high TableOLEDFONT1DATA_H
	addwfc	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	movlw	upper TableOLEDFONT1DATA_H
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableOLEDFONT1DATA_H
	db	1

;********************************************************************************

OLEDFONT1INDEX
	movlw	97
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableOLEDFONT1INDEX
	movwf	TBLPTRL,ACCESS
	movlw	high TableOLEDFONT1INDEX
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TableOLEDFONT1INDEX
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableOLEDFONT1INDEX
	db	96,1,3,5,9,15,21,25,31,33,36,39,45,49,51,55,57,61,66,70,75,79,84,88,93,97,102,107
	db	109,112,116,120,124,128,134,139,144,149,154,158,162,167,172,176,180,185,189,195
	db	201,206,211,216,221,226,230,235,241,247,253,2,7,10,14,17,21,26,29,34,39,44,49,54
	db	57,62,67,69,72,77,79,85,90,95,100,105,108,113,117,122,128,134,140,145,149,153
	db	155,159,164

;********************************************************************************

OLEDFONT1INDEX_H
	movlw	97
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableOLEDFONT1INDEX_H
	movwf	TBLPTRL,ACCESS
	movlw	high TableOLEDFONT1INDEX_H
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TableOLEDFONT1INDEX_H
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableOLEDFONT1INDEX_H
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

;********************************************************************************

OLEDFONT2
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	145
	movwf	SysWORDTempB,ACCESS
	movlw	7
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableOLEDFONT2
	movwf	TBLPTRL,ACCESS
	movlw	high TableOLEDFONT2
	addwfc	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	movlw	upper TableOLEDFONT2
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableOLEDFONT2
	db	147,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,254,27,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,0,1,32,25,160,7,120,1,38,25,160
	db	7,120,1,38,1,32,1,0,0,0,0,0,0,28,24,38,16,66,16,255,63,130,17,2,15,0,0,0,0,28
	db	16,34,8,34,4,34,3,156,0,64,14,48,17,8,17,4,17,2,14,0,7,128,8,92,16,98,16,162,17,50
	db	19,28,28,0,24,0,22,128,1,0,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,224
	db	7,24,24,12,48,4,32,2,64,2,64,0,0,0,0,2,64,2,64,4,32,12,48,24,24,224,7,0,0,0,0,0
	db	0,0,0,8,0,24,0,240,0,78,0,240,0,24,0,8,0,0,0,0,0,0,2,0,2,0,2,0,2,224,31,0,2,0,2,0
	db	2,0,2,0,0,0,0,0,0,0,0,0,152,0,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0
	db	1,0,1,0,0,0,0,0,0,0,0,0,0,0,24,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,48,0,12,0,3,192
	db	0,48,0,12,0,2,0,0,0,0,0,240,3,12,12,2,16,2,16,2,16,12,12,240,3,0,0,0,0,0,0,4,16,4
	db	16,4,16,254,31,0,16,0,16,0,16,0,0,0,0,0,0,6,24,2,20,2,18,2,17,194,16,60,16,0,0,0
	db	0,0,0,0,0,0,0,2,16,66,16,66,16,66,16,188,15,0,0,0,0,0,0,0,3,192,2,32,2,24,2,4,2,254
	db	31,0,2,0,2,0,0,0,0,0,0,0,0,62,16,34,16,34,16,66,8,130,7,0,0,0,0,0,0,0,0,240,7,76
	db	8,34,16,34,16,34,16,66,8,128,7,0,0,0,0,0,0,2,0,2,24,2,7,194,0,50,0,10,0,6,0,0,0,0
	db	0,0,0,28,15,162,16,66,16,66,16,162,16,162,9,28,6,0,0,0,0,0,0,120,0,132,16,2,17,2
	db	17,2,17,132,12,248,3,0,0,0,0,0,0,0,0,0,0,96,24,96,24,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,96,152,96,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,3,128,4,128,4,64,8,64,8,32
	db	16,0,0,0,0,128,4,128,4,128,4,128,4,128,4,128,4,128,4,128,4,0,0,0,0,32,16,64,8,64
	db	8,128,4,128,4,0,3,0,3,0,0,0,0,0,0,14,0,2,0,2,27,130,0,66,0,38,0,28,0,0,0,0,0,240
	db	3,24,12,4,24,226,19,18,20,10,22,138,27,252,7,0,4,0,4,0,16,0,14,128,3,112,2,24,2,48
	db	2,192,2,0,3,0,12,0,16,0,0,248,31,136,16,136,16,136,16,136,16,72,17,48,14,0,0,0
	db	0,192,3,48,12,16,8,8,16,8,16,8,16,8,16,24,16,0,0,0,0,0,0,248,31,8,16,8,16,8,16,8
	db	16,16,8,224,7,0,0,0,0,0,0,248,31,8,17,8,17,8,17,8,17,8,17,8,16,0,0,0,0,0,0,248
	db	31,8,1,8,1,8,1,8,1,8,1,8,0,0,0,0,0,0,0,192,3,48,12,16,8,8,16,8,16,8,17,8,17,24
	db	31,0,0,0,0,248,31,0,1,0,1,0,1,0,1,0,1,248,31,0,0,0,0,0,0,8,16,8,16,8,16,248,31,8
	db	16,8,16,8,16,0,0,0,0,0,0,0,0,0,16,8,16,8,16,8,16,248,15,0,0,0,0,0,0,0,0,248,31,128
	db	0,128,1,64,2,32,4,16,4,8,8,0,16,0,0,0,0,248,31,0,16,0,16,0,16,0,16,0,16,0,16,0
	db	0,0,0,248,31,56,0,224,1,0,7,0,6,192,1,56,0,248,31,0,0,0,0,0,0,248,31,16,0,96,0,128
	db	1,0,6,0,8,248,31,0,0,0,0,0,0,224,7,16,8,8,16,8,16,8,16,8,16,16,8,224,7,0,0,0,0,248
	db	31,8,1,8,1,8,1,8,1,136,0,112,0,0,0,0,0,0,0,224,7,16,8,8,16,8,16,8,16,8,48,16,72,224
	db	71,0,0,0,0,248,31,8,1,8,1,8,3,136,4,112,8,0,16,0,0,0,0,0,0,112,24,72,16,136,16,136
	db	16,8,17,8,9,24,14,0,0,0,0,8,0,8,0,8,0,8,0,248,31,8,0,8,0,8,0,8,0,0,0,0,0,248,7,0
	db	24,0,16,0,16,0,16,0,8,248,7,0,0,0,0,8,0,48,0,192,1,0,6,0,24,0,24,0,7,192,0,48,0,8
	db	0,24,0,224,3,0,28,0,15,224,0,192,1,0,14,0,28,224,3,24,0,8,16,16,8,32,4,64,2,128
	db	1,128,1,64,2,32,4,16,8,8,16,8,0,16,0,96,0,128,0,0,31,128,0,64,0,32,0,16,0,8,0,0
	db	0,8,24,8,20,8,18,8,17,136,16,72,16,40,16,24,16,0,0,0,0,0,0,0,0,254,127,2,64,2
	db	64,2,64,2,64,0,0,0,0,0,0,2,0,12,0,48,0,192,0,0,3,0,12,0,48,0,64,0,0,0,0,2,64,2
	db	64,2,64,2,64,254,127,0,0,0,0,0,0,0,0,0,0,0,4,0,3,224,0,56,0,14,0,112,0,128,3,0
	db	4,0,0,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,0,0,0,0,0,0,0,1,0,2,0,0
	db	0,0,0,0,0,0,0,0,0,0,12,32,18,32,17,32,17,32,9,192,31,0,16,0,0,0,0,0,0,254,31,64
	db	8,32,16,32,16,32,16,96,8,128,7,0,0,0,0,0,0,128,7,64,8,32,16,32,16,32,16,32,16,32
	db	16,0,0,0,0,0,0,128,7,64,24,32,16,32,16,32,16,64,8,254,31,0,0,0,0,0,0,128,7,64,9,32
	db	17,32,17,32,17,32,17,192,17,0,0,0,0,0,0,32,0,32,0,252,31,36,0,34,0,34,0,34,0,34
	db	0,0,0,0,0,128,7,64,152,32,144,32,144,32,144,64,72,224,63,0,0,0,0,0,0,254,31,128
	db	0,64,0,32,0,32,0,32,0,192,31,0,0,0,0,0,0,32,0,32,0,38,0,230,31,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,128,32,128,32,128,38,128,230,127,0,0,0,0,0,0,0,0,0,0,254,31,0,1,0,3,128
	db	4,64,4,64,8,32,16,0,0,0,0,0,0,0,0,2,0,2,0,2,0,254,31,0,0,0,0,0,0,0,0,224,31,64
	db	0,32,0,32,0,192,31,64,0,32,0,32,0,192,31,0,0,0,0,224,31,192,0,64,0,32,0,32,0,32
	db	0,192,31,0,0,0,0,0,0,128,7,64,8,32,16,32,16,32,16,64,8,128,7,0,0,0,0,0,0,224
	db	255,64,8,32,16,32,16,32,16,96,8,128,7,0,0,0,0,0,0,128,7,64,24,32,16,32,16,32,16,64
	db	8,224,255,0,0,0,0,0,0,0,0,224,31,128,0,64,0,32,0,32,0,224,0,0,0,0,0,0,0,192,24,32
	db	17,32,17,32,18,32,18,32,12,0,0,0,0,0,0,0,0,32,0,32,0,248,15,32,16,32,16,32,16,32
	db	16,0,0,0,0,0,0,224,15,0,16,0,16,0,16,0,8,224,31,0,0,0,0,0,0,32,0,192,1,0,6,0,24,0
	db	16,0,12,0,3,192,0,32,0,0,0,96,0,128,7,0,24,0,14,192,1,128,1,0,14,0,24,128,7,96
	db	0,0,0,32,16,64,8,128,4,0,3,0,3,128,4,64,8,32,16,0,0,32,128,192,128,0,131,0,70,0
	db	56,0,24,0,6,0,1,192,0,32,0,0,0,32,16,32,24,32,20,32,18,32,17,160,16,96,16,32,16,0
	db	0,0,0,0,0,0,1,0,1,252,62,2,64,2,64,2,64,0,0,0,0,0,0,0,0,0,0,0,0,254,127,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,2,64,2,64,2,64,252,62,0,1,0,1,0,0,0,0,0,3,128,0,128,0,128,0,0
	db	1,0,1,0,2,0,2,0,2,128,1,0,0,128,31,192,16,32,16,16,16,32,16,192,16,128,31,0,0,0
	db	0,192,3,48,12,16,8,8,16,8,16,8,144,8,176,24,208

;********************************************************************************

OLEDFONT2_H
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableOLEDFONT2_H
	movwf	TBLPTRL,ACCESS
	movlw	high TableOLEDFONT2_H
	addwfc	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	movlw	upper TableOLEDFONT2_H
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableOLEDFONT2_H
	db	7

;********************************************************************************

;Source: epd_epd2in13d.h (361)
PIXEL_TO_DISPLAY_EPD2IN13D
;Dim EPD_Ind_raw, EPD_Ind_col as Word
;if _GLCDPage = 0 then
	movf	_GLCDPAGE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF38
;Clear down 'OLD' data - to prevent flashing
;SendCommand_EPD2in13D(Data_Transmission_1)
	movlw	16
	movwf	EPD2IN13D_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD2IN13D
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATA,0,ACCESS
;for EPD_Ind_raw=1 to GLCD_Height
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop10
	incf	EPD_IND_RAW,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,ACCESS
;for EPD_Ind_col=1 to GLCD_Width
	clrf	EPD_IND_COL,ACCESS
	clrf	EPD_IND_COL_H,ACCESS
SysForLoop11
	incf	EPD_IND_COL,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_COL_H,F,ACCESS
;Replaced with macro for speed              SendData_EPD2in13D(GLCDBackGround)
;EPD2in13D_Data = GLCDBackGround
	movff	GLCDBACKGROUND,EPD2IN13D_DATA
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (495)
;FastHWSPITransfer EPD2in13D_Data
	movff	EPD2IN13D_DATA,SPITXDATA
	call	FASTHWSPITRANSFER
;next
	movff	EPD_IND_COL,SysWORDTempA
	movff	EPD_IND_COL_H,SysWORDTempA_H
	movlw	104
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop11
SysForLoopEnd11
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	212
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop10
SysForLoopEnd10
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
;SendCommand_EPD2in13D(DATA_TRANSMISSION_2)
	movlw	19
	movwf	EPD2IN13D_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD2IN13D
;end if
ENDIF38
;dim EPD2in13D_Data as byte
;We need to set the signals as we are optimising the code by using the macro
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATA,0,ACCESS
;for EPD_Ind_raw=1 to BUFFWIDTH
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop12
	incf	EPD_IND_RAW,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,ACCESS
;replaced with macro for speed
;SendData_EPD2in13D(EPD_Buffer(EPD_Ind_raw))
;EPD2in13D_Data = EPD_Buffer(EPD_Ind_raw)
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_RAW,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_RAW_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,EPD2IN13D_DATA
;The following line is intentionally commented out, but, it shows the orientation of the pixels to the array. Uncomment to force a two (when the value is 3!) byte write to the Display
;You can then examine the display to see the orientation of the pixels.
;This will write the bytes at the top of each page - so, do not be surprised!
;if EPD_Ind_raw < 3 then EPD2in13D_Data = GLCDForeground
;This macro assumes the use of the variable EPD2in13D_Data
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (495)
;FastHWSPITransfer EPD2in13D_Data
	movff	EPD2IN13D_DATA,SPITXDATA
	call	FASTHWSPITRANSFER
;Now clear the buffer
;EPD_Buffer(EPD_Ind_raw) = GLCDBackground
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_RAW,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_RAW_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movffl	GLCDBACKGROUND,INDF0
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	98
	movwf	SysWORDTempB,ACCESS
	movlw	5
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop12
SysForLoopEnd12
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
	return

;********************************************************************************

;Source: epd_epd2in13d.h (691)
PSET_EPD2IN13D
;Dim EPD_Ind, EPD_N_Col, EPD_N_raw, EPD_Ind_Trans as word
;Dim remainder as byte
;Dim DataVar as byte
;Dim value as bit
;Dim GLCD_Time_Buff as word
;Dim GLCDDataTemp, GLCDY_Temp, GLCDY_withinPage  as word
;Select Case EPD2in13DAddressType
;case Landscape
SysSelect3Case1
	decf	EPD2IN13DADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
;GLCDDataTemp = GLCDX
	movff	GLCDX,GLCDDATATEMP
	movff	GLCDX_H,GLCDDATATEMP_H
;GLCDX = GLCDY
	movff	GLCDY,GLCDX
	movff	GLCDY_H,GLCDX_H
;GLCDY = GLCD_HEIGHT - GLCDDataTemp - 1
	movf	GLCDDATATEMP,W,ACCESS
	sublw	212
	movwf	SysTemp2,BANKED
	clrf	SysTemp1,BANKED
	movf	GLCDDATATEMP_H,W,ACCESS
	subwfb	SysTemp1,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	1
	subwf	SysTemp2,W,BANKED
	movwf	GLCDY,ACCESS
	movlw	0
	subwfb	SysTemp2_H,W,BANKED
	movwf	GLCDY_H,ACCESS
;case Landscape_Rev
	bra	SysSelectEnd3
SysSelect3Case2
	movlw	3
	subwf	EPD2IN13DADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case3
;GLCDDataTemp = GLCDX
	movff	GLCDX,GLCDDATATEMP
	movff	GLCDX_H,GLCDDATATEMP_H
;GLCDX = GLCD_WIDTH  - GLCDY - 1
	movf	GLCDY,W,ACCESS
	sublw	104
	movwf	SysTemp2,BANKED
	clrf	SysTemp1,BANKED
	movf	GLCDY_H,W,ACCESS
	subwfb	SysTemp1,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	1
	subwf	SysTemp2,W,BANKED
	movwf	GLCDX,ACCESS
	movlw	0
	subwfb	SysTemp2_H,W,BANKED
	movwf	GLCDX_H,ACCESS
;GLCDY = GLCDDataTemp
	movff	GLCDDATATEMP,GLCDY
	movff	GLCDDATATEMP_H,GLCDY_H
;case Portrait
	bra	SysSelectEnd3
SysSelect3Case3
	movlw	4
	subwf	EPD2IN13DADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case4
;Default do nothing
;case Portrait_Rev
	bra	SysSelectEnd3
SysSelect3Case4
	movlw	2
	subwf	EPD2IN13DADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd3
;GLCDY = GLCD_HEIGHT - GLCDY - 1
	movf	GLCDY,W,ACCESS
	sublw	212
	movwf	SysTemp2,BANKED
	clrf	SysTemp1,BANKED
	movf	GLCDY_H,W,ACCESS
	subwfb	SysTemp1,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	1
	subwf	SysTemp2,W,BANKED
	movwf	GLCDY,ACCESS
	movlw	0
	subwfb	SysTemp2_H,W,BANKED
	movwf	GLCDY_H,ACCESS
;GLCDX = GLCD_WIDTH - GLCDX - 1
	movf	GLCDX,W,ACCESS
	sublw	104
	movwf	SysTemp2,BANKED
	clrf	SysTemp1,BANKED
	movf	GLCDX_H,W,ACCESS
	subwfb	SysTemp1,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	1
	subwf	SysTemp2,W,BANKED
	movwf	GLCDX,ACCESS
	movlw	0
	subwfb	SysTemp2_H,W,BANKED
	movwf	GLCDX_H,ACCESS
;end select
SysSelectEnd3
;Exit if not the current page.
;if  ( GLCDY / EPD_PIXELS_PER_PAGE  ) <> _GLCDPage then
	movff	GLCDY,SysWORDTempA
	movff	GLCDY_H,SysWORDTempA_H
	movlw	106
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,SysTemp2
	movff	SysWORDTempA_H,SysTemp2_H
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movff	_GLCDPAGE,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompEqual16
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
;exit sub
	return
;end if
;buffer location in LOWMEMORY_GLCD_MODE always equals GLCDX + 1
;UC1601_BufferLocationCalc = GLCDX + 1
	movlw	1
	addwf	GLCDX,W,ACCESS
	movwf	UC1601_BUFFERLOCATIONCALC,BANKED
	movlw	0
	addwfc	GLCDX_H,W,ACCESS
	movwf	UC1601_BUFFERLOCATIONCALC_H,BANKED
;EPD_N_Col=(GLCDX+1)/8                   'number of the column of the byte to be set
;EPD_N_Col=(GLCDX+1)
	movlw	1
	addwf	GLCDX,W,ACCESS
	movwf	EPD_N_COL,ACCESS
	movlw	0
	addwfc	GLCDX_H,W,ACCESS
	movwf	EPD_N_COL_H,ACCESS
;Repeat 3
	movlw	3
	movwf	SysRepeatTemp1,BANKED
SysRepeatLoop1
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate EPD_N_Col Right
	rrcf	EPD_N_COL_H,F,ACCESS
	rrcf	EPD_N_COL,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;remainder=(GLCDX+1) % 8
	movlw	1
	addwf	GLCDX,W,ACCESS
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	GLCDX_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movlw	8
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempX,REMAINDER
;EPD_N_raw=GLCDY * GLCD_Width8       'number of the column of the byte to be set
	movff	GLCDY,SysWORDTempA
	movff	GLCDY_H,SysWORDTempA_H
	movlw	13
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysMultSub16
	movff	SysWORDTempX,EPD_N_RAW
	movff	SysWORDTempX_H,EPD_N_RAW_H
;if remainder=0 then
	movf	REMAINDER,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE52_1
;EPD_Ind=EPD_N_raw+EPD_N_Col
	movf	EPD_N_COL,W,ACCESS
	addwf	EPD_N_RAW,W,ACCESS
	movwf	EPD_IND,ACCESS
	movf	EPD_N_COL_H,W,ACCESS
	addwfc	EPD_N_RAW_H,W,ACCESS
	movwf	EPD_IND_H,ACCESS
;else
	bra	ENDIF52
ELSE52_1
;EPD_Ind=EPD_N_raw+EPD_N_Col+1       'Number of the byte to be set (starting from 1)
	movf	EPD_N_COL,W,ACCESS
	addwf	EPD_N_RAW,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	EPD_N_COL_H,W,ACCESS
	addwfc	EPD_N_RAW_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	EPD_IND,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	EPD_IND_H,ACCESS
;end if
ENDIF52
;GLCD_Time_Buff=_GLCDPage*BUFFWIDTH
	movff	_GLCDPAGE,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	movlw	98
	movwf	SysWORDTempB,ACCESS
	movlw	5
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysMultSub16
	movff	SysWORDTempX,GLCD_TIME_BUFF
	movff	SysWORDTempX_H,GLCD_TIME_BUFF_H
;EPD_Ind_Trans=EPD_Ind
	movff	EPD_IND,EPD_IND_TRANS
	movff	EPD_IND_H,EPD_IND_TRANS_H
;EPD_Ind_Trans=EPD_Ind_Trans-GLCD_Time_Buff
	movf	GLCD_TIME_BUFF,W,ACCESS
	subwf	EPD_IND_TRANS,F,ACCESS
	movf	GLCD_TIME_BUFF_H,W,ACCESS
	subwfb	EPD_IND_TRANS_H,F,ACCESS
;if EPD_Ind_Trans>BUFFWIDTH then       'NOTE:it should be a control also for a
	movff	EPD_IND_TRANS,SysWORDTempB
	movff	EPD_IND_TRANS_H,SysWORDTempB_H
	movlw	98
	movwf	SysWORDTempA,ACCESS
	movlw	5
	movwf	SysWORDTempA_H,ACCESS
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
;EXIT SUB                            'lower bound of ind (ind>GLCD_Time_Buff)
	return
;end if                                'However when the lower bound is violated,
;DataVar=EPD_Buffer(EPD_Ind_Trans)     'Ind_Trans should be negative and, due to
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_TRANS,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_TRANS_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,DATAVAR
;Select Case remainder                 'non signed arithmetic, it will be very
;case 0                                'large, thus Exits sub is executed.
SysSelect4Case1
	movf	REMAINDER,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case2
;DataVar.0=GLCDColour.0
	bcf	DATAVAR,0,ACCESS
	btfsc	GLCDCOLOUR,0,ACCESS
	bsf	DATAVAR,0,ACCESS
;case 1
	bra	SysSelectEnd4
SysSelect4Case2
	decf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case3
;DataVar.7=GLCDColour.0
	bcf	DATAVAR,7,ACCESS
	btfsc	GLCDCOLOUR,0,ACCESS
	bsf	DATAVAR,7,ACCESS
;case 2
	bra	SysSelectEnd4
SysSelect4Case3
	movlw	2
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case4
;DataVar.6=GLCDColour.0
	bcf	DATAVAR,6,ACCESS
	btfsc	GLCDCOLOUR,0,ACCESS
	bsf	DATAVAR,6,ACCESS
;case 3
	bra	SysSelectEnd4
SysSelect4Case4
	movlw	3
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case5
;DataVar.5=GLCDColour.0
	bcf	DATAVAR,5,ACCESS
	btfsc	GLCDCOLOUR,0,ACCESS
	bsf	DATAVAR,5,ACCESS
;case 4
	bra	SysSelectEnd4
SysSelect4Case5
	movlw	4
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case6
;DataVar.4=GLCDColour.0
	bcf	DATAVAR,4,ACCESS
	btfsc	GLCDCOLOUR,0,ACCESS
	bsf	DATAVAR,4,ACCESS
;case 5
	bra	SysSelectEnd4
SysSelect4Case6
	movlw	5
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case7
;DataVar.3=GLCDColour.0
	bcf	DATAVAR,3,ACCESS
	btfsc	GLCDCOLOUR,0,ACCESS
	bsf	DATAVAR,3,ACCESS
;case 6
	bra	SysSelectEnd4
SysSelect4Case7
	movlw	6
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case8
;DataVar.2=GLCDColour.0
	bcf	DATAVAR,2,ACCESS
	btfsc	GLCDCOLOUR,0,ACCESS
	bsf	DATAVAR,2,ACCESS
;case 7
	bra	SysSelectEnd4
SysSelect4Case8
	movlw	7
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd4
;DataVar.1=GLCDColour.0
	bcf	DATAVAR,1,ACCESS
	btfsc	GLCDCOLOUR,0,ACCESS
	bsf	DATAVAR,1,ACCESS
;End Select
SysSelectEnd4
;EPD_Buffer(EPD_Ind_Trans)=DataVar
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_TRANS,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_TRANS_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movffl	DATAVAR,INDF0
	return

;********************************************************************************

;Source: epd_epd2in13d.h (432)
REFRESH_EPD2IN13D
;Not required as this process has already happenend from INIT
;LoadLUTS_EPD2in13D
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	movwf	EPD2IN13D_COMMAND,ACCESS
	bra	SENDCOMMAND_EPD2IN13D

;********************************************************************************

;Source: epd_epd2in13d.h (898)
ROTATE_EPD2IN13D
;DIM GLCDDataTemp, PrintLocY, PrintLocX as word
;PrintLocY = 0
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
;PrintLocX = 0
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
;select case EPD2in13DAddressType
;case PORTRAIT
SysSelect5Case1
	movlw	4
	subwf	EPD2IN13DADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case2
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	211
	movwf	GLCDDEVICEHEIGHT,ACCESS
	clrf	GLCDDEVICEHEIGHT_H,ACCESS
;GLCDDeviceWidth = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEWIDTH,ACCESS
	clrf	GLCDDEVICEWIDTH_H,ACCESS
;case LANDSCAPE
	bra	SysSelectEnd5
SysSelect5Case2
	decf	EPD2IN13DADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case3
;GLCDDeviceHeight = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEHEIGHT,ACCESS
	clrf	GLCDDEVICEHEIGHT_H,ACCESS
;GLCDDeviceWidth  = GLCD_HEIGHT - 1
	movlw	211
	movwf	GLCDDEVICEWIDTH,ACCESS
	clrf	GLCDDEVICEWIDTH_H,ACCESS
;case PORTRAIT_REV
	bra	SysSelectEnd5
SysSelect5Case3
	movlw	2
	subwf	EPD2IN13DADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case4
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	211
	movwf	GLCDDEVICEHEIGHT,ACCESS
	clrf	GLCDDEVICEHEIGHT_H,ACCESS
;GLCDDeviceWidth  = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEWIDTH,ACCESS
	clrf	GLCDDEVICEWIDTH_H,ACCESS
;case LANDSCAPE_REV
	bra	SysSelectEnd5
SysSelect5Case4
	movlw	3
	subwf	EPD2IN13DADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case5
;GLCDDeviceHeight = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEHEIGHT,ACCESS
	clrf	GLCDDEVICEHEIGHT_H,ACCESS
;GLCDDeviceWidth  = GLCD_HEIGHT - 1
	movlw	211
	movwf	GLCDDEVICEWIDTH,ACCESS
	clrf	GLCDDEVICEWIDTH_H,ACCESS
;case else
	bra	SysSelectEnd5
SysSelect5Case5
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	211
	movwf	GLCDDEVICEHEIGHT,ACCESS
	clrf	GLCDDEVICEHEIGHT_H,ACCESS
;GLCDDeviceWidth  = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEWIDTH,ACCESS
	clrf	GLCDDEVICEWIDTH_H,ACCESS
;end select
SysSelectEnd5
	return

;********************************************************************************

;Source: epd_epd2in13d.h (452)
SENDCOMMAND_EPD2IN13D
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC OFF
	bcf	LATA,0,ACCESS
;FastHWSPITransfer EPD2in13D_Command
	movff	EPD2IN13D_COMMAND,SPITXDATA
	call	FASTHWSPITRANSFER
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
;do
SysDoLoop_S5
;loop while EPD_Busy=Off
	btfss	PORTC,0,ACCESS
	bra	SysDoLoop_S5
SysDoLoop_E5
;Exit sub
	return
	return

;********************************************************************************

;Source: epd_epd2in13d.h (485)
SENDDATA_EPD2IN13D
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATA,0,ACCESS
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (495)
;FastHWSPITransfer EPD2in13D_Data
	movff	EPD2IN13D_DATA,SPITXDATA
	call	FASTHWSPITRANSFER
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
	return

;********************************************************************************

;Source: epd_epd2in13d.h (440)
SLEEP_EPD2IN13D
;SendCommand_EPD2in13D(Vcom_and_data_interval_setting)
	movlw	80
	movwf	EPD2IN13D_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0xF7)
	movlw	247
	movwf	EPD2IN13D_DATA,ACCESS
	rcall	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(POWER_OFF)
	movlw	2
	movwf	EPD2IN13D_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD2IN13D
;SendCommand_EPD2in13D(DEEP_SLEEP)
	movlw	7
	movwf	EPD2IN13D_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(DEEP_SLEEP_CHECK_CODE)
	movlw	165
	movwf	EPD2IN13D_DATA,ACCESS
	bra	SENDDATA_EPD2IN13D

;********************************************************************************

;Overloaded signature: BYTE:BYTE:, Source: hwspi.h (354)
SPIMODE645
;Supports K mode SPI using the specific SPI module
;Turn off SPI
;(Prevents any weird glitches during setup)
;SPI1CON0_EN = 0
	banksel	SPI1CON0
	bcf	SPI1CON0,SPI1CON0_EN,BANKED
;Set clock pulse settings to middle
;SPI1CON1.SMP = 0
	bcf	SPI1CON1,SMP,BANKED
;Data write on rising (idle > active) clock (CPHA = 1)
;SPI1CON1.CKE = 0
	bcf	SPI1CON1,CKE,BANKED
;Clock idle low (CPOL = 0)
;SPI1CON1.CKP = 0
	bcf	SPI1CON1,CKP,BANKED
;If SPIClockMode.0 = Off Then
	banksel	SPICLOCKMODE
	btfsc	SPICLOCKMODE,0,BANKED
	bra	ENDIF89
;SPI1CON1.CKE = 1
	banksel	SPI1CON1
	bsf	SPI1CON1,CKE,BANKED
;End If
ENDIF89
;If SPIClockMode.1 = On Then
	banksel	SPICLOCKMODE
	btfss	SPICLOCKMODE,1,BANKED
	bra	ENDIF90
;SPI1CON1.CKP = 1
	banksel	SPI1CON1
	bsf	SPI1CON1,CKP,BANKED
;End If
ENDIF90
;SPI1CON1 = 0x40
	movlw	64
	banksel	SPI1CON1
	movwf	SPI1CON1,BANKED
;Transfer
;SPI1CON2 = SPI1CON2 or 3
	movlw	3
	iorwf	SPI1CON2,F,BANKED
;Select mode and clock
;SPI1CLK = SSP1_FOSC
	clrf	SPI1CLK,BANKED
;Select Case SPICurrentMode
;Case MasterFast or MasterUltraFast
SysSelect6Case1
	movff	SPICURRENTMODE,SysBYTETempA
	movlw	13
	movwf	SysBYTETempB,ACCESS
	banksel	0
	rcall	SysCompEqual
	movlw	14
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfss	SysTemp1,0,BANKED
	bra	SysSelect6Case2
;asm showdebug Script value is calculated as SPIBAUDRATE_SCRIPT
;script sysbitvar0.2 is calculated as 3
;SPI1BAUD = SPIBAUDRATE_SCRIPT
	movlw	3
	banksel	SPI1BAUD
	movwf	SPI1BAUD,BANKED
;SPI1CON0.MST = 1
	bsf	SPI1CON0,MST,BANKED
;Case Master
	bra	SysSelectEnd6
SysSelect6Case2
	movlw	12
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case3
;asm showdebug Script value is calculated as SPIBAUDRATE_SCRIPT_MASTER
;script sysbitvar0.2 is calculated as 9
;SPI1BAUD = SPIBAUDRATE_SCRIPT_MASTER
	movlw	9
	banksel	SPI1BAUD
	movwf	SPI1BAUD,BANKED
;SPI1CON0.MST = 1
	bsf	SPI1CON0,MST,BANKED
;Case MasterSlow
	bra	SysSelectEnd6
SysSelect6Case3
	movlw	11
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case4
;asm showdebug Script value is calculated as SPIBAUDRATE_SCRIPT_MASTERSLOW
;script sysbitvar0.2 is calculated as 33
;SPI1BAUD = SPIBAUDRATE_SCRIPT_MASTERSLOW
	movlw	33
	banksel	SPI1BAUD
	movwf	SPI1BAUD,BANKED
;SPI1CON0.MST = 1
	bsf	SPI1CON0,MST,BANKED
;Case Slave
	bra	SysSelectEnd6
SysSelect6Case4
	movf	SPICURRENTMODE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case5
;SPI1CON0.MST = 0
	banksel	SPI1CON0
	bcf	SPI1CON0,MST,BANKED
;Case SlaveSS
	bra	SysSelectEnd6
SysSelect6Case5
	decf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd6
;SPI1CON0.MST = 0
	banksel	SPI1CON0
	bcf	SPI1CON0,MST,BANKED
;End Select
SysSelectEnd6
;Enable SPI
;SPI1CON0.EN = 1
	banksel	SPI1CON0
	bsf	SPI1CON0,EN,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:, Source: stdbasic.h (284)
SWAP510
;Dim SysCalcTempX As Word
;SysCalcTempX = SysCalcTempA
	movff	SYSCALCTEMPA,SYSCALCTEMPX
	movff	SYSCALCTEMPA_H,SYSCALCTEMPX_H
;SysCalcTempA = SysCalcTempB
	movff	SYSCALCTEMPB,SYSCALCTEMPA
	movff	SYSCALCTEMPB_H,SYSCALCTEMPA_H
;SysCalcTempB = SysCalcTempX
	movff	SYSCALCTEMPX,SYSCALCTEMPB
	movff	SYSCALCTEMPX_H,SYSCALCTEMPB_H
	return

;********************************************************************************

;Source: system.h (2613)
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

;Source: system.h (2639)
SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test low, exit if false
;movf SysWordTempB, W
	movf	SYSWORDTEMPB, W,ACCESS
;cpfseq SysWordTempA
	cpfseq	SYSWORDTEMPA,ACCESS
;return
	return
;Test high, exit if false
;movf SysWordTempB_H, W
	movf	SYSWORDTEMPB_H, W,ACCESS
;cpfseq SysWordTempA_H
	cpfseq	SYSWORDTEMPA_H,ACCESS
;return
	return
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

;Source: system.h (2810)
SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test High, exit if more
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W,ACCESS
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;Test high, exit true if less
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W,ACCESS
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W,ACCESS
;bnc SCLT16True
	bnc	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	movf	SYSWORDTEMPB,W,ACCESS
;subwf SysWordTempA,W
	subwf	SYSWORDTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,C,ACCESS
;return
	return
SCLT16TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

;Source: system.h (2962)
SYSCOMPLESSTHANINT
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ELSE76_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF77
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F,ACCESS
;Exit Sub
	return
;End If
ENDIF77
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,W,ACCESS
	movwf	SYSDIVMULTA,ACCESS
	comf	SYSINTEGERTEMPA_H,W,ACCESS
	movwf	SYSDIVMULTA_H,ACCESS
	incf	SYSDIVMULTA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSDIVMULTA_H,F,ACCESS
;SysIntegerTempA = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,W,ACCESS
	movwf	SYSINTEGERTEMPA,ACCESS
	comf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSINTEGERTEMPA_H,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;SysIntegerTempB = SysDivMultA
	movff	SYSDIVMULTA,SYSINTEGERTEMPB
	movff	SYSDIVMULTA_H,SYSINTEGERTEMPB_H
;+A
;Else
	bra	ENDIF76
ELSE76_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
;Exit Sub
	return
;End If
;End If
ENDIF76
;Test High, exit if more
;movf SysIntegerTempA_H,W
	movf	SYSINTEGERTEMPA_H,W,ACCESS
;subwf SysIntegerTempB_H,W
	subwf	SYSINTEGERTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;Test high, exit true if less
;movf SysIntegerTempB_H,W
	movf	SYSINTEGERTEMPB_H,W,ACCESS
;subwf SysIntegerTempA_H,W
	subwf	SYSINTEGERTEMPA_H,W,ACCESS
;bnc SCLTIntTrue
	bnc	SCLTINTTRUE
;Test Low, exit if more or equal
;movf SysIntegerTempB,W
	movf	SYSINTEGERTEMPB,W,ACCESS
;subwf SysIntegerTempA,W
	subwf	SYSINTEGERTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,C,ACCESS
;return
	return
SCLTINTTRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

;Source: system.h (2457)
SYSDIVSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	movff	SYSWORDTEMPA,SYSDIVMULTA
	movff	SYSWORDTEMPA_H,SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movff	SYSWORDTEMPB,SYSDIVMULTB
	movff	SYSWORDTEMPB_H,SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX,ACCESS
	clrf	SYSDIVMULTX_H,ACCESS
;Avoid division by zero
;if SysDivMultB = 0 then
	movff	SYSDIVMULTB,SysWORDTempA
	movff	SYSDIVMULTB_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF71
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF71
;Main calc routine
;SysDivLoop = 16
	movlw	16
	movwf	SYSDIVLOOP,ACCESS
SYSDIV16START
;set C off
	bcf	STATUS,C,ACCESS
;Rotate SysDivMultA Left
	rlcf	SYSDIVMULTA,F,ACCESS
	rlcf	SYSDIVMULTA_H,F,ACCESS
;Rotate SysDivMultX Left
	rlcf	SYSDIVMULTX,F,ACCESS
	rlcf	SYSDIVMULTX_H,F,ACCESS
;SysDivMultX = SysDivMultX - SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	subwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	subwfb	SYSDIVMULTX_H,F,ACCESS
;Set SysDivMultA.0 On
	bsf	SYSDIVMULTA,0,ACCESS
;If C Off Then
	btfsc	STATUS,C,ACCESS
	bra	ENDIF72
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF72
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv16Start
	bra	SYSDIV16START
;SysWordTempA = SysDivMultA
	movff	SYSDIVMULTA,SYSWORDTEMPA
	movff	SYSDIVMULTA_H,SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	movff	SYSDIVMULTX,SYSWORDTEMPX
	movff	SYSDIVMULTX_H,SYSWORDTEMPX_H
	return

;********************************************************************************

;Source: system.h (2511)
SYSDIVSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W,ACCESS
	xorwf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSSIGNBYTE,ACCESS
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ENDIF73
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
ENDIF73
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF74
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
ENDIF74
;Call word divide routine
;SysDivSub16
	rcall	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF75
;SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;SysIntegerTempX = -SysIntegerTempX
	comf	SYSINTEGERTEMPX,F,ACCESS
	comf	SYSINTEGERTEMPX_H,F,ACCESS
	incf	SYSINTEGERTEMPX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPX_H,F,ACCESS
;End If
ENDIF75
	return

;********************************************************************************

;Source: system.h (2212)
SYSMULTSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;X = LowA * LowB
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W,ACCESS
;mulwf SysWordTempB
	mulwf	SYSWORDTEMPB,ACCESS
;movff PRODL, SysWordTempX
	movffl	PRODL,SYSWORDTEMPX
;movff PRODH, SysWordTempX_H
	movffl	PRODH,SYSWORDTEMPX_H
;HighX += LowA * HighB
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W,ACCESS
;mulwf SysWordTempB_H
	mulwf	SYSWORDTEMPB_H,ACCESS
;movf PRODL, W
	movf	PRODL, W,ACCESS
;addwf SysWordTempX_H, F
	addwf	SYSWORDTEMPX_H, F,ACCESS
;HighX += HighA * LowB
;movf SysWordTempA_H, W
	movf	SYSWORDTEMPA_H, W,ACCESS
;mulwf SysWordTempB
	mulwf	SYSWORDTEMPB,ACCESS
;movf PRODL, W
	movf	PRODL, W,ACCESS
;addwf SysWordTempX_H, F
	addwf	SYSWORDTEMPX_H, F,ACCESS
;PRODL = HighA * HighB
;movf SysWordTempA_H, F
	movf	SYSWORDTEMPA_H, F,ACCESS
;mulwf SysWordTempB_H
	mulwf	SYSWORDTEMPB_H,ACCESS
	return

;********************************************************************************

;Source: system.h (2310)
SYSMULTSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W,ACCESS
	xorwf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSSIGNBYTE,ACCESS
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ENDIF68
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
ENDIF68
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF69
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
ENDIF69
;Call word multiply routine
;SysMultSub16
	rcall	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF70
	comf	SYSINTEGERTEMPX,F,ACCESS
	comf	SYSINTEGERTEMPX_H,F,ACCESS
	incf	SYSINTEGERTEMPX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPX_H,F,ACCESS
ENDIF70
	return

;********************************************************************************

;Source: system.h (1240)
SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get length
;TBLRD*+
	tblrd*+
;movff TABLAT,SysCalcTempA
	movffl	TABLAT,SYSCALCTEMPA
;movff TABLAT,INDF1
	movffl	TABLAT,INDF1
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
;Check length
SYSSTRINGREADCHECK
;If length is 0, exit
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
;Copy
SYSSTRINGREAD
;Copy char
;TBLRD*+
	tblrd*+
;movff TABLAT,PREINC1
	movffl	TABLAT,PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringRead
	bra	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables

StringTable1
	db	15,84,101,115,116,32,64,32,80,111,114,116,114,97,105,116


StringTable2
	db	6,76,105,110,101,32,52


StringTable3
	db	6,76,105,110,101,32,53


StringTable4
	db	19,84,101,115,116,32,64,32,80,111,114,116,114,97,105,116,95,114,101,118


StringTable5
	db	16,84,101,115,116,32,64,32,76,97,110,100,115,99,97,112,101


StringTable6
	db	20,84,101,115,116,32,64,32,76,97,110,100,115,99,97,112,101,95,82,101,118


;********************************************************************************


 END
