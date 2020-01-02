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
CHARCODE	EQU	13
CHARCOL	EQU	14
CHARCOL_H	EQU	15
CHARLOCX	EQU	16
CHARLOCX_H	EQU	17
CHARLOCY	EQU	18
CHARLOCY_H	EQU	19
COLSPERFONT	EQU	20
CURRCHARCOL	EQU	21
CURRCHARROW	EQU	22
CURRCHARVAL	EQU	23
DATAVAR	EQU	24
DATAVAR_E	EQU	27
DATAVAR_H	EQU	25
DATAVAR_U	EQU	26
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
EPD2IN13D_COMMAND	EQU	28
EPD2IN13D_DATA	EQU	29
EPD7IN5ADDRESSTYPE	EQU	30
EPD7IN5_COMMAND	EQU	31
EPD7IN5_DATA	EQU	32
EPD7IN5_DATA_BLACK	EQU	33
EPD_BUFFER	EQU	511
EPD_IND	EQU	34
EPD_IND_COL	EQU	38
EPD_IND_COL_H	EQU	39
EPD_IND_E	EQU	37
EPD_IND_H	EQU	35
EPD_IND_RAW	EQU	40
EPD_IND_RAW_H	EQU	41
EPD_IND_TRANS	EQU	42
EPD_IND_TRANS_E	EQU	45
EPD_IND_TRANS_H	EQU	43
EPD_IND_TRANS_U	EQU	44
EPD_IND_U	EQU	36
EPD_N_COL	EQU	46
EPD_N_COL_E	EQU	49
EPD_N_COL_H	EQU	47
EPD_N_COL_U	EQU	48
EPD_N_RAW	EQU	50
EPD_N_RAW_E	EQU	53
EPD_N_RAW_H	EQU	51
EPD_N_RAW_U	EQU	52
GLCDBACKGROUND	EQU	54
GLCDBACKGROUND_H	EQU	55
GLCDCOLOUR	EQU	56
GLCDCOLOUR_H	EQU	57
GLCDDATATEMP	EQU	58
GLCDDATATEMP_E	EQU	61
GLCDDATATEMP_H	EQU	59
GLCDDATATEMP_U	EQU	60
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
GLCD_TIME_BUFF	EQU	82
GLCD_TIME_BUFF_E	EQU	85
GLCD_TIME_BUFF_H	EQU	83
GLCD_TIME_BUFF_U	EQU	84
GLCD_YORDINATE	EQU	86
GLCD_YORDINATE_H	EQU	87
LINECOLOUR	EQU	88
LINECOLOUR_H	EQU	89
LOCALCHARCODE	EQU	90
LOCALCHARCODE_H	EQU	91
OLDGLCDFONTWIDTH	EQU	92
PRINTLOCX	EQU	93
PRINTLOCX_H	EQU	94
PRINTLOCY	EQU	95
PRINTLOCY_H	EQU	96
REMAINDER	EQU	97
REMAINDER_E	EQU	100
REMAINDER_H	EQU	98
REMAINDER_U	EQU	99
ROWSPERFONT	EQU	101
SPICLOCKMODE	EQU	102
SPICURRENTMODE	EQU	103
SPIRXDATA	EQU	104
SPITXDATA	EQU	105
STRINGPOINTER	EQU	106
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSDIVLOOP	EQU	4
SYSDIVMULTA	EQU	7
SYSDIVMULTA_H	EQU	8
SYSDIVMULTB	EQU	11
SYSDIVMULTB_H	EQU	12
SYSDIVMULTX	EQU	2
SYSDIVMULTX_H	EQU	3
SYSLCDPRINTDATAHANDLER	EQU	107
SYSLCDPRINTDATAHANDLER_H	EQU	108
SYSLONGDIVMULTA	EQU	109
SYSLONGDIVMULTA_E	EQU	112
SYSLONGDIVMULTA_H	EQU	110
SYSLONGDIVMULTA_U	EQU	111
SYSLONGDIVMULTB	EQU	113
SYSLONGDIVMULTB_E	EQU	116
SYSLONGDIVMULTB_H	EQU	114
SYSLONGDIVMULTB_U	EQU	115
SYSLONGDIVMULTX	EQU	117
SYSLONGDIVMULTX_E	EQU	120
SYSLONGDIVMULTX_H	EQU	118
SYSLONGDIVMULTX_U	EQU	119
SYSLONGTEMPA	EQU	5
SYSLONGTEMPA_E	EQU	8
SYSLONGTEMPA_H	EQU	6
SYSLONGTEMPA_U	EQU	7
SYSLONGTEMPB	EQU	9
SYSLONGTEMPB_E	EQU	12
SYSLONGTEMPB_H	EQU	10
SYSLONGTEMPB_U	EQU	11
SYSLONGTEMPX	EQU	0
SYSLONGTEMPX_E	EQU	3
SYSLONGTEMPX_H	EQU	1
SYSLONGTEMPX_U	EQU	2
SYSREPEATTEMP1	EQU	121
SYSREPEATTEMP2	EQU	122
SYSREPEATTEMP5	EQU	123
SYSREPEATTEMP6	EQU	124
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	506
SYSTEMP1	EQU	125
SYSTEMP1_E	EQU	128
SYSTEMP1_H	EQU	126
SYSTEMP1_U	EQU	127
SYSTEMP2	EQU	129
SYSTEMP2_H	EQU	130
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
SYSWAITTEMPS	EQU	4
SYSWORDTEMPA	EQU	5
SYSWORDTEMPA_H	EQU	6
SYSWORDTEMPB	EQU	9
SYSWORDTEMPB_H	EQU	10
SYSWORDTEMPX	EQU	0
SYSWORDTEMPX_H	EQU	1
_GLCDPAGE	EQU	131
_GLCDPAGESH	EQU	132
_GLCDPAGESL	EQU	133

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
	rcall	INITSYS
	rcall	INITPPS
	rcall	INIT_EPD2IN13D
	rcall	INIT_EPD7IN5

;Start of the main program
;''A demonstration program for Explicit-Paper.
;''-------------------------------------------------------------------------
;-------------------------------------------------------
;''This has been tested using the hardware and software SPI option.
;''*************************************************************************
;*******
;Chip Settings.
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
;Setup the E-Paper
;#define GLCD_TYPE GLCD_TYPE_EPD_EPD7in5
;#define GLCD_EXTENDEDFONTSET1
;#define GLCD_OLED_FONT
;#define GLCD_TYPE_EPD7in5_LOWMEMORY4_GLCD_MODE    ' fastest
;#define GLCD_TYPE_EPD7in5_LOWMEMORY3_GLCD_MODE
;#define GLCD_TYPE_EPD7in5_LOWMEMORY2_GLCD_MODE
;#define GLCD_TYPE_EPD7in5_LOWMEMORY1_GLCD_MODE
;Pin mappings for SPI - this GLCD driver supports Hardware SPI and Software SPI
;#define GLCD_DC     portA.0   ' Data(hight)/ command(low) line
;#define GLCD_CS     portC.1   ' Chip select line (negate)
;#define GLCD_RESET  portD.2   ' Reset line       (negate)
;#define GLCD_DO     portC.5   ' GLCD MOSI connect to MCU SDO
;#define GLCD_SCK    portC.3   ' Clock Line
;#define GLCD_Busy   portC.0   ' Busy Line
;******************************************************************************************************
;Main program
;GLCDForeground=TFT_BLACK
	clrf	GLCDFOREGROUND,ACCESS
	clrf	GLCDFOREGROUND_H,ACCESS
;GLCDBackground=TFT_WHITE
	setf	GLCDBACKGROUND,ACCESS
	setf	GLCDBACKGROUND_H,ACCESS
;GLCDfntDefaultSize = 2
	movlw	2
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCD_Open_PageTransaction
;Macro Source: EPD_EPD7in5.h (884)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD7in5
	rcall	CLEAR_BUFFER_EPD7IN5
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
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	clrf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	rcall	GLCDLOCATESTRING
;GLCDPrintStringLn "BAR1"
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
	rcall	GLCDPRINTSTRINGLN
;GLCDPrintStringLn "BAR2"
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
	rcall	GLCDPRINTSTRINGLN
;GLCDPrintStringLn "BAR3"
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
	rcall	GLCDPRINTSTRINGLN
;GLCD_Close_PageTransaction
;Macro Source: EPD_EPD7in5.h (897)
;Pixel_To_Display_EPD7in5
	call	PIXEL_TO_DISPLAY_EPD7IN5
;next
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;SendCommand_EPD7in5( DATA_STOP )
	movlw	17
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;Tests
;GLCDRotate Portrait
	movlw	4
	movwf	EPD7IN5ADDRESSTYPE,ACCESS
	call	ROTATE_EPD7IN5
;GLCD_Open_PageTransaction
;Macro Source: EPD_EPD7in5.h (884)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD7in5
	rcall	CLEAR_BUFFER_EPD7IN5
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
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	clrf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	rcall	GLCDLOCATESTRING
;GLCDPrintStringLn "BAR1"
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
	rcall	GLCDPRINTSTRINGLN
;GLCDPrintStringLn "BAR2"
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
	rcall	GLCDPRINTSTRINGLN
;GLCDPrintStringLn "BAR3"
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
	rcall	GLCDPRINTSTRINGLN
;GLCD_Close_PageTransaction
;Macro Source: EPD_EPD7in5.h (897)
;Pixel_To_Display_EPD7in5
	call	PIXEL_TO_DISPLAY_EPD7IN5
;next
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;SendCommand_EPD7in5( DATA_STOP )
	movlw	17
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;GLCDRotate Portrait_rev
	movlw	2
	movwf	EPD7IN5ADDRESSTYPE,ACCESS
	call	ROTATE_EPD7IN5
;GLCD_Open_PageTransaction
;Macro Source: EPD_EPD7in5.h (884)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD7in5
	rcall	CLEAR_BUFFER_EPD7IN5
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
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	clrf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	rcall	GLCDLOCATESTRING
;GLCDPrintStringLn "BAR1"
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
	rcall	GLCDPRINTSTRINGLN
;GLCDPrintStringLn "BAR2"
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
	rcall	GLCDPRINTSTRINGLN
;GLCDPrintStringLn "BAR3"
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
	rcall	GLCDPRINTSTRINGLN
;GLCD_Close_PageTransaction
;Macro Source: EPD_EPD7in5.h (897)
;Pixel_To_Display_EPD7in5
	call	PIXEL_TO_DISPLAY_EPD7IN5
;next
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;SendCommand_EPD7in5( DATA_STOP )
	movlw	17
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;GLCDRotate Landscape
	movlw	1
	movwf	EPD7IN5ADDRESSTYPE,ACCESS
	call	ROTATE_EPD7IN5
;GLCD_Open_PageTransaction
;Macro Source: EPD_EPD7in5.h (884)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD7in5
	rcall	CLEAR_BUFFER_EPD7IN5
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
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	clrf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	rcall	GLCDLOCATESTRING
;GLCDPrintStringLn "BAR1"
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
	rcall	GLCDPRINTSTRINGLN
;GLCDPrintStringLn "BAR2"
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
	rcall	GLCDPRINTSTRINGLN
;GLCDPrintStringLn "BAR3"
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
	rcall	GLCDPRINTSTRINGLN
;GLCD_Close_PageTransaction
;Macro Source: EPD_EPD7in5.h (897)
;Pixel_To_Display_EPD7in5
	call	PIXEL_TO_DISPLAY_EPD7IN5
;next
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
;SendCommand_EPD7in5( DATA_STOP )
	movlw	17
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;GLCDRotate Landscape_Rev
	movlw	3
	movwf	EPD7IN5ADDRESSTYPE,ACCESS
	call	ROTATE_EPD7IN5
;GLCD_Open_PageTransaction
;Macro Source: EPD_EPD7in5.h (884)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD7in5
	rcall	CLEAR_BUFFER_EPD7IN5
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	decf	_GLCDPAGESL,W,BANKED
	movwf	_GLCDPAGE,BANKED
	movf	_GLCDPAGESL,W,BANKED
	subwf	_GLCDPAGESH,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd5
SysForLoop5
	incf	_GLCDPAGE,F,BANKED
;GLCDLocateString 0,0
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	clrf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	rcall	GLCDLOCATESTRING
;GLCDPrintStringLn "BAR1"
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
	rcall	GLCDPRINTSTRINGLN
;GLCDPrintStringLn "BAR2"
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
	rcall	GLCDPRINTSTRINGLN
;GLCDPrintStringLn "BAR3"
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
	rcall	GLCDPRINTSTRINGLN
;GLCD_Close_PageTransaction
;Macro Source: EPD_EPD7in5.h (897)
;Pixel_To_Display_EPD7in5
	call	PIXEL_TO_DISPLAY_EPD7IN5
;next
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
SysForLoopEnd5
;SendCommand_EPD7in5( DATA_STOP )
	movlw	17
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;GLCDCLS
	rcall	CLS_EPD7IN5
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

;Source: EPD_EPD7in5.h (372)
CLEAR_BUFFER_EPD7IN5
;Dim EPD_Ind_raw as Word
;for EPD_Ind_raw=1 to BUFFWIDTH                 'clear the buffer
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop7
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
	clrf	SysWORDTempB,ACCESS
	movlw	30
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop7
SysForLoopEnd7
	return

;********************************************************************************

;Source: EPD_EPD7in5.h (277)
CLS_EPD7IN5
;added CLS_EPD7in5_init to optimise start up process.
;CLS_EPD7in5_init
	rcall	CLS_EPD7IN5_INIT
;Refresh_EPD7in5
	call	REFRESH_EPD7IN5
;No need to call this as it faster to put in GLCDCLS. Keep the method if some one needs it
;Clear_buffer_EPD7in5
	return

;********************************************************************************

;Source: EPD_EPD7in5.h (227)
CLS_EPD7IN5_INIT
;initialise global variable. Required variable for Circle - DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE,ACCESS
	clrf	GLCD_YORDINATE_H,ACCESS
;Dim EPD_Ind_raw, EPD_Ind_col as word
;Dim PrintLocX, PrintLocY as word
;PrintLocX = 0
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
;PrintLocY = 0
	clrf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
;For EPD_Ind_raw=1 to BUFFWIDTH
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop9
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
	clrf	SysWORDTempB,ACCESS
	movlw	30
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop9
SysForLoopEnd9
;SendCommand_EPD7in5(0x04)
	movlw	4
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;do while EPD_Busy=Off
SysDoLoop_S9
	btfsc	PORTC,0,ACCESS
	bra	SysDoLoop_E9
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;loop
	bra	SysDoLoop_S9
SysDoLoop_E9
;SendCommand_EPD7in5(0x12)
	movlw	18
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;do while EPD_Busy=Off
SysDoLoop_S10
	btfsc	PORTC,0,ACCESS
	bra	SysDoLoop_E10
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;loop
	bra	SysDoLoop_S10
SysDoLoop_E10
;Clear data
;SendCommand_EPD7in5(DATA_START_TRANSMISSION_1)
	movlw	16
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
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
;Was.. speed optimised with macro
;Repeat 4
	movlw	4
	movwf	SysRepeatTemp5,BANKED
SysRepeatLoop5
;if GLCDBackground = TFT_BLACK then
	movff	GLCDBACKGROUND,SysWORDTempA
	movff	GLCDBACKGROUND_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE23_1
;EPD7in5_Data = TFT_BLACK
	clrf	EPD7IN5_DATA,ACCESS
;else
	bra	ENDIF23
ELSE23_1
;EPD7in5_Data = EPD_WHITE
	movlw	51
	movwf	EPD7IN5_DATA,ACCESS
;end if
ENDIF23
;SendData_EPD7in5_Macro
;Macro Source: EPD_EPD7in5.h (453)
;FastHWSPITransfer EPD7in5_Data
	movff	EPD7IN5_DATA,SPITXDATA
	rcall	FASTHWSPITRANSFER
;End Repeat
	decfsz	SysRepeatTemp5,F,BANKED
	bra	SysRepeatLoop5
SysRepeatLoopEnd5
;next
	movff	EPD_IND_COL,SysWORDTempA
	movff	EPD_IND_COL_H,SysWORDTempA_H
	movlw	128
	movwf	SysWORDTempB,ACCESS
	movlw	2
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop11
SysForLoopEnd11
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	128
	movwf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop10
SysForLoopEnd10
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
	return

;********************************************************************************

;Source: EPD_EPD7in5.h (502)
DRAWCHAR_EPD7IN5
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
SysSelect2Case1
	decf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
;CharCode = CharCode - 16
	movlw	16
	subwf	CHARCODE,F,ACCESS
;ReadTable OLEDFont1Index, CharCode, LocalCharCode
	movff	CHARCODE,SYSSTRINGA
	rcall	OLEDFONT1INDEX
	movwf	LOCALCHARCODE,ACCESS
	movff	CHARCODE,SYSSTRINGA
	rcall	OLEDFONT1INDEX_H
	movwf	LOCALCHARCODE_H,ACCESS
;ReadTable OLEDFont1Data, LocalCharCode , COLSperfont
	movff	LOCALCHARCODE,SYSSTRINGA
	movff	LOCALCHARCODE_H,SYSSTRINGA_H
	rcall	OLEDFONT1DATA
	movwf	COLSPERFONT,ACCESS
;GLCDFontWidth = COLSperfont + 1
	incf	COLSPERFONT,W,ACCESS
	movwf	GLCDFONTWIDTH,ACCESS
;ROWSperfont = 7  'which is really 8 as we start at 0
	movlw	7
	movwf	ROWSPERFONT,BANKED
;case 2 'This is one font table
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd2
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
SysSelectEnd2
;The main loop - loop throught the number of columns
;For CurrCharCol = 0 to COLSperfont  'number of columns in the font , with two row of data
	setf	CURRCHARCOL,ACCESS
	movlw	0
	subwf	COLSPERFONT,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd12
SysForLoop12
	incf	CURRCHARCOL,F,ACCESS
;Index the pointer to the code that we are looking for as we need to do this lookup many times getting more font data
;LocalCharCode++
	incf	LOCALCHARCODE,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	LOCALCHARCODE_H,F,ACCESS
;Select case GLCDfntDefaultSize
;case 1
SysSelect3Case1
	decf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
;ReadTable OLEDFont1Data, LocalCharCode, CurrCharVal
	movff	LOCALCHARCODE,SYSSTRINGA
	movff	LOCALCHARCODE_H,SYSSTRINGA_H
	rcall	OLEDFONT1DATA
	movwf	CURRCHARVAL,ACCESS
;case 2
	bra	SysSelectEnd3
SysSelect3Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd3
;Read this 20 times... (0..COLSperfont) [ * 2 ]
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	movff	LOCALCHARCODE,SYSSTRINGA
	movff	LOCALCHARCODE_H,SYSSTRINGA_H
	rcall	OLEDFONT2
	movwf	CURRCHARVAL,ACCESS
;End Select
SysSelectEnd3
;we handle 8 or 16 pixels of height
;For CurrCharRow = 0 to ROWSperfont
	setf	CURRCHARROW,ACCESS
	movlw	0
	subwf	ROWSPERFONT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd13
SysForLoop13
	incf	CURRCHARROW,F,ACCESS
;Set the pixel
;If CurrCharVal.0 = 0 Then
	btfsc	CURRCHARVAL,0,ACCESS
	bra	ELSE28_1
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
	call	PSET_EPD7IN5
;Else
	bra	ENDIF28
ELSE28_1
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
	call	PSET_EPD7IN5
;End If
ENDIF28
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
	bra	ENDIF29
;LocalCharCode++
	incf	LOCALCHARCODE,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	LOCALCHARCODE_H,F,ACCESS
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	movff	LOCALCHARCODE,SYSSTRINGA
	movff	LOCALCHARCODE_H,SYSSTRINGA_H
	rcall	OLEDFONT2
	movwf	CURRCHARVAL,ACCESS
;end if
ENDIF29
;It is the intercharacter space, put out one pixel row
;if CurrCharCol = COLSperfont then
	movf	COLSPERFONT,W,ACCESS
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF30
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
	bra	ENDIF33
;GLCDTemp++
	incf	GLCDTEMP,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	GLCDTEMP_H,F,ACCESS
;end if
ENDIF33
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
	call	PSET_EPD7IN5
;end if
ENDIF30
;Next
	movf	ROWSPERFONT,W,BANKED
	subwf	CURRCHARROW,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop13
SysForLoopEnd13
;Next
	movf	COLSPERFONT,W,ACCESS
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop12
SysForLoopEnd12
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
	bra	ELSE11_1
;PrintLocY = 0
	clrf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
;else
	bra	ENDIF11
ELSE11_1
;PrintLocY--
	movlw	1
	subwf	PRINTLOCY,F,ACCESS
	movlw	0
	subwfb	PRINTLOCY_H,F,BANKED
;PrintLocY = ( PrintLocY * ( GLCDfntDefaultHeight * GLCDfntDefaultSize ) ) mod GLCD_HEIGHT
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
	movlw	128
	movwf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempX,PRINTLOCY
	movff	SysWORDTempX_H,PRINTLOCY_H
;end if
ENDIF11
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
	bra	SysForLoopEnd8
SysForLoop8
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
	rcall	DRAWCHAR_EPD7IN5
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
	bra	SysForLoop8
SysForLoopEnd8
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
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
;When using Transaction  PrintLocY will get incremented. This needs to be protected
;PrintLocY = ( PrintLocY + ( GLCDfntDefaultHeight * GLCDfntDefaultSize ) ) mod GLCD_HEIGHT
	movf	GLCDFNTDEFAULTHEIGHT,W,ACCESS
	mulwf	GLCDFNTDEFAULTSIZE,ACCESS
	movffl	PRODL,SysTemp1
	movf	SysTemp1,W,BANKED
	addwf	PRINTLOCY,W,ACCESS
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	PRINTLOCY_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movlw	128
	movwf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempX,PRINTLOCY
	movff	SysWORDTempX_H,PRINTLOCY_H
	return

;********************************************************************************

;Source: BARTEST_E_paper-7in5_18f.gcb (25)
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
	return

;********************************************************************************

;Source: EPD_EPD7in5.h (99)
INIT_EPD7IN5
;dim _GLCDPagesL, _GLCDPagesH  as byte
;asm showdebug Current_buffer_size_is BUFFWIDTH
;current_buffer_size_is 7680
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
;wait 300 ms
	movlw	44
	movwf	SysWaitTempMS,ACCESS
	movlw	1
	movwf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SET EPD_RESET ON
	bsf	LATD,2,ACCESS
;wait 300 ms
	movlw	44
	movwf	SysWaitTempMS,ACCESS
	movlw	1
	movwf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;harware SPI mode
;asm showdebug SPI constant used equates to HWSPIMODESCRIPT
;spi constant used equates to 12
;SPIMode HWSPIMODESCRIPT, 0
	movlw	12
	movwf	SPICURRENTMODE,BANKED
	clrf	SPICLOCKMODE,BANKED
	call	SPIMODE645
;SendCommand_EPD7in5(0x04)
	movlw	4
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;do while EPD_Busy=Off
SysDoLoop_S6
	btfsc	PORTC,0,ACCESS
	bra	SysDoLoop_E6
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;loop
	bra	SysDoLoop_S6
SysDoLoop_E6
;SendCommand_EPD7in5(0x01)
	movlw	1
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0x37)
	movlw	55
	movwf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;SendData_EPD7in5(0x00)
	clrf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0x00)
	clrf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0xCF)
	movlw	207
	movwf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;SendData_EPD7in5(0x08)
	movlw	8
	movwf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0x06)
	movlw	6
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0xC7)
	movlw	199
	movwf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;SendData_EPD7in5(0xcc)
	movlw	204
	movwf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;SendData_EPD7in5(0x28)
	movlw	40
	movwf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0x04)
	movlw	4
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;do while EPD_Busy=Off
SysDoLoop_S7
	btfsc	PORTC,0,ACCESS
	bra	SysDoLoop_E7
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;loop
	bra	SysDoLoop_S7
SysDoLoop_E7
;SendCommand_EPD7in5(0x30)
	movlw	48
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0x3C)
	movlw	60
	movwf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0x41)
	movlw	65
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0x00)
	clrf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0x50)
	movlw	80
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0x77)
	movlw	119
	movwf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0x60)
	movlw	96
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0x22)
	movlw	34
	movwf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0x61)
	movlw	97
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0x02)
	movlw	2
	movwf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;SendData_EPD7in5(0x80)
	movlw	128
	movwf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;SendData_EPD7in5(0x01)
	movlw	1
	movwf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;SendData_EPD7in5(0x80)
	movlw	128
	movwf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0x82)
	movlw	130
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0x1E)
	movlw	30
	movwf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0xE5)
	movlw	229
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0x03)
	movlw	3
	movwf	EPD7IN5_DATA,ACCESS
	call	SENDDATA_EPD7IN5
;May not be required, improves start up by having it removed
;SendCommand_EPD7in5(0x12)
	movlw	18
	movwf	EPD7IN5_COMMAND,ACCESS
	call	SENDCOMMAND_EPD7IN5
;do while EPD_Busy=Off
SysDoLoop_S8
	btfsc	PORTC,0,ACCESS
	bra	SysDoLoop_E8
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;loop
	bra	SysDoLoop_S8
SysDoLoop_E8
;Colours
;GLCDForeground = TFT_BLACK
	clrf	GLCDFOREGROUND,ACCESS
	clrf	GLCDFOREGROUND_H,ACCESS
;Default Colours
;GLCDBackground = TFT_WHITE
	setf	GLCDBACKGROUND,ACCESS
	setf	GLCDBACKGROUND_H,ACCESS
;GLCDFontWidth = 5
	movlw	5
	movwf	GLCDFONTWIDTH,ACCESS
;Variables required for device
;GLCDDeviceWidth = GLCD_WIDTH - 1
	movlw	127
	movwf	GLCDDEVICEWIDTH,ACCESS
	movlw	2
	movwf	GLCDDEVICEWIDTH_H,ACCESS
;GLCDDeviceHeight= GLCD_HEIGHT- 1
	movlw	127
	movwf	GLCDDEVICEHEIGHT,ACCESS
	movlw	1
	movwf	GLCDDEVICEHEIGHT_H,ACCESS
;GLCDRotate Landscape
	movlw	1
	movwf	EPD7IN5ADDRESSTYPE,ACCESS
	call	ROTATE_EPD7IN5
;CLS_EPD7in5
	rcall	CLS_EPD7IN5
;GLCDfntDefault = 0
	clrf	GLCDFNTDEFAULT,ACCESS
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDfntDefaultHeight = 8
	movlw	8
	movwf	GLCDFNTDEFAULTHEIGHT,ACCESS
;asm showdebug EPD_N_PAGE
;4
;_GLCDPagesH = EPD_N_PAGE - 1
	movlw	3
	movwf	_GLCDPAGESH,BANKED
;_GLCDPagesL = 0
	clrf	_GLCDPAGESL,BANKED
;_GLCDPage = 0
	clrf	_GLCDPAGE,BANKED
	return

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

;Source: EPD_EPD7in5.h (292)
PIXEL_TO_DISPLAY_EPD7IN5
;Dim EPD_Ind_raw, EPD_Ind_col as Word
;if _GLCDPage = 0 then
	movf	_GLCDPAGE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF12
;SendCommand_EPD7in5(0x04)
	movlw	4
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
;do
SysDoLoop_S3
;wait 1 ms
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;loop while EPD_Busy=Off
	btfss	PORTC,0,ACCESS
	bra	SysDoLoop_S3
SysDoLoop_E3
;SendCommand_EPD7in5(0x12)
	movlw	18
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
;do while EPD_Busy=Off
SysDoLoop_S4
	btfsc	PORTC,0,ACCESS
	bra	SysDoLoop_E4
;wait 1 ms
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;loop
	bra	SysDoLoop_S4
SysDoLoop_E4
;Commence data
;SendCommand_EPD7in5(DATA_START_TRANSMISSION_1)
	movlw	16
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
;end if
ENDIF12
;dim EPD7in5_Data as byte
;We need to set the signals as we are optimising the code by using the macro
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATA,0,ACCESS
;for EPD_Ind_raw=1 to BUFFWIDTH
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop6
	incf	EPD_IND_RAW,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,ACCESS
;replaced with macro for speed
;dim EPD7in5_Data_Black as byte
;EPD7in5_Data_Black = EPD_Buffer(EPD_Ind_raw)
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_RAW,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_RAW_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,EPD7IN5_DATA_BLACK
;Send the buffer data to the display
;repeat 4
	movlw	4
	movwf	SysRepeatTemp1,BANKED
SysRepeatLoop1
;if EPD7in5_Data_Black.7 = 0 then
	btfsc	EPD7IN5_DATA_BLACK,7,ACCESS
	bra	ELSE13_1
;EPD7in5_Data  = 0x00
	clrf	EPD7IN5_DATA,ACCESS
;else
	bra	ENDIF13
ELSE13_1
;EPD7in5_Data  = 0x03
	movlw	3
	movwf	EPD7IN5_DATA,ACCESS
;end if
ENDIF13
;EPD7in5_Data = EPD7in5_Data * 16
;repeat 4
	movlw	4
	movwf	SysRepeatTemp2,BANKED
SysRepeatLoop2
;Set C Off
	bcf	STATUS,C,ACCESS
;rotate EPD7in5_Data left
	rlcf	EPD7IN5_DATA,F,ACCESS
;end Repeat
	decfsz	SysRepeatTemp2,F,BANKED
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;EPD7in5_Data_Black = EPD7in5_Data_Black * 2
;repeat 1
	movlw	1
	movwf	SysRepeatTemp2,BANKED
SysRepeatLoop3
;Set C Off
	bcf	STATUS,C,ACCESS
;rotate EPD7in5_Data_Black left
	rlcf	EPD7IN5_DATA_BLACK,F,ACCESS
;end Repeat
	decfsz	SysRepeatTemp2,F,BANKED
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
;if EPD7in5_Data_Black.7 = 0 then
	btfsc	EPD7IN5_DATA_BLACK,7,ACCESS
	bra	ELSE14_1
;EPD7in5_Data  = EPD7in5_Data OR 0x00
;else
	bra	ENDIF14
ELSE14_1
;EPD7in5_Data  = EPD7in5_Data OR 0x03
	movlw	3
	iorwf	EPD7IN5_DATA,F,ACCESS
;end if
ENDIF14
;EPD7in5_Data_Black = EPD7in5_Data_Black * 2
;repeat 1
	movlw	1
	movwf	SysRepeatTemp2,BANKED
SysRepeatLoop4
;Set C Off
	bcf	STATUS,C,ACCESS
;rotate EPD7in5_Data_Black left
	rlcf	EPD7IN5_DATA_BLACK,F,ACCESS
;end Repeat
	decfsz	SysRepeatTemp2,F,BANKED
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
;This macro assumes the use of the variable EPD7in5_Data
;SendData_EPD7in5_Macro
;Macro Source: EPD_EPD7in5.h (453)
;FastHWSPITransfer EPD7in5_Data
	movff	EPD7IN5_DATA,SPITXDATA
	call	FASTHWSPITRANSFER
;end Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
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
	clrf	SysWORDTempB,ACCESS
	movlw	30
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop6
SysForLoopEnd6
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
	return

;********************************************************************************

;Source: EPD_EPD7in5.h (649)
PSET_EPD7IN5
;Dim EPD_Ind, EPD_N_Col, EPD_N_raw, EPD_Ind_Trans as long
;Dim remainder as long
;Dim DataVar as long
;Dim value as bit
;Dim GLCD_Time_Buff as long
;Dim GLCDDataTemp as long
;Select Case EPD7in5AddressType
;case Landscape
SysSelect4Case1
	decf	EPD7IN5ADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case2
;Default do nothing
;case Landscape_Rev
	bra	SysSelectEnd4
SysSelect4Case2
	movlw	3
	subwf	EPD7IN5ADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case3
;GLCDY = GLCD_HEIGHT - GLCDY - 1
	movf	GLCDY,W,ACCESS
	sublw	128
	movwf	SysTemp1,BANKED
	movlw	1
	movwf	SysTemp2,BANKED
	movf	GLCDY_H,W,ACCESS
	subwfb	SysTemp2,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	subwf	SysTemp1,W,BANKED
	movwf	GLCDY,ACCESS
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	GLCDY_H,ACCESS
;GLCDX = GLCD_WIDTH - GLCDX - 1
	movf	GLCDX,W,ACCESS
	sublw	128
	movwf	SysTemp1,BANKED
	movlw	2
	movwf	SysTemp2,BANKED
	movf	GLCDX_H,W,ACCESS
	subwfb	SysTemp2,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	subwf	SysTemp1,W,BANKED
	movwf	GLCDX,ACCESS
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	GLCDX_H,ACCESS
;case Portrait
	bra	SysSelectEnd4
SysSelect4Case3
	movlw	4
	subwf	EPD7IN5ADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case4
;GLCDDataTemp = GLCDX
	movff	GLCDX,GLCDDATATEMP
	movff	GLCDX_H,GLCDDATATEMP_H
	clrf	GLCDDATATEMP_U,ACCESS
	clrf	GLCDDATATEMP_E,ACCESS
;GLCDX = GLCDY
	movff	GLCDY,GLCDX
	movff	GLCDY_H,GLCDX_H
;GLCDY = GLCD_HEIGHT - GLCDDataTemp - 1
	movf	GLCDDATATEMP,W,ACCESS
	sublw	128
	movwf	SysTemp1,BANKED
	movlw	1
	movwf	SysTemp2,BANKED
	movf	GLCDDATATEMP_H,W,ACCESS
	subwfb	SysTemp2,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	subwf	SysTemp1,W,BANKED
	movwf	GLCDY,ACCESS
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	GLCDY_H,ACCESS
;case Portrait_Rev
	bra	SysSelectEnd4
SysSelect4Case4
	movlw	2
	subwf	EPD7IN5ADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd4
;GLCDDataTemp = GLCDX
	movff	GLCDX,GLCDDATATEMP
	movff	GLCDX_H,GLCDDATATEMP_H
	clrf	GLCDDATATEMP_U,ACCESS
	clrf	GLCDDATATEMP_E,ACCESS
;GLCDX = GLCD_WIDTH  - GLCDY - 1
	movf	GLCDY,W,ACCESS
	sublw	128
	movwf	SysTemp1,BANKED
	movlw	2
	movwf	SysTemp2,BANKED
	movf	GLCDY_H,W,ACCESS
	subwfb	SysTemp2,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	subwf	SysTemp1,W,BANKED
	movwf	GLCDX,ACCESS
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	GLCDX_H,ACCESS
;GLCDY = GLCDDataTemp
	movff	GLCDDATATEMP,GLCDY
	movff	GLCDDATATEMP_H,GLCDY_H
;end select
SysSelectEnd4
;EPD_N_Col=(GLCDX+1)/8                   'number of the column of the byte to be set
;EPD_N_Col=(GLCDX+1)
	movlw	1
	addwf	GLCDX,W,ACCESS
	movwf	EPD_N_COL,ACCESS
	movlw	0
	addwfc	GLCDX_H,W,ACCESS
	movwf	EPD_N_COL_H,ACCESS
	clrf	EPD_N_COL_U,ACCESS
	btfsc	STATUS,C,ACCESS
	incf	EPD_N_COL_U,F,ACCESS
	clrf	EPD_N_COL_E,ACCESS
;Repeat 3
	movlw	3
	movwf	SysRepeatTemp6,BANKED
SysRepeatLoop6
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate EPD_N_Col Right
	rrcf	EPD_N_COL_E,F,ACCESS
	rrcf	EPD_N_COL_U,F,ACCESS
	rrcf	EPD_N_COL_H,F,ACCESS
	rrcf	EPD_N_COL,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp6,F,BANKED
	bra	SysRepeatLoop6
SysRepeatLoopEnd6
;remainder=(GLCDX+1) % 8
	movlw	1
	addwf	GLCDX,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	GLCDX_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movff	SysTemp1,SysLONGTempA
	movff	SysTemp1_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movlw	8
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysDivSub32
	movff	SysLONGTempX,REMAINDER
	movff	SysLONGTempX_H,REMAINDER_H
	movff	SysLONGTempX_U,REMAINDER_U
	movff	SysLONGTempX_E,REMAINDER_E
;EPD_N_raw=[WORD]GLCDY * [WORD]GLCD_Width8       'number of the column of the byte to be set
	movff	GLCDY,SysLONGTempA
	movff	GLCDY_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movlw	80
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysMultSub32
	movff	SysLONGTempX,EPD_N_RAW
	movff	SysLONGTempX_H,EPD_N_RAW_H
	movff	SysLONGTempX_U,EPD_N_RAW_U
	movff	SysLONGTempX_E,EPD_N_RAW_E
;if remainder=0 then
	movff	REMAINDER,SysLONGTempA
	movff	REMAINDER_H,SysLONGTempA_H
	movff	REMAINDER_U,SysLONGTempA_U
	movff	REMAINDER_E,SysLONGTempA_E
	clrf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysCompEqual32
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE34_1
;EPD_Ind=EPD_N_raw+EPD_N_Col
	movf	EPD_N_COL,W,ACCESS
	addwf	EPD_N_RAW,W,ACCESS
	movwf	EPD_IND,ACCESS
	movf	EPD_N_COL_H,W,ACCESS
	addwfc	EPD_N_RAW_H,W,ACCESS
	movwf	EPD_IND_H,ACCESS
	movf	EPD_N_COL_U,W,ACCESS
	addwfc	EPD_N_RAW_U,W,ACCESS
	movwf	EPD_IND_U,ACCESS
	movf	EPD_N_COL_E,W,ACCESS
	addwfc	EPD_N_RAW_E,W,ACCESS
	movwf	EPD_IND_E,ACCESS
;else
	bra	ENDIF34
ELSE34_1
;EPD_Ind=EPD_N_raw+EPD_N_Col+1       'Number of the byte to be set (starting from 1)
	movf	EPD_N_COL,W,ACCESS
	addwf	EPD_N_RAW,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	EPD_N_COL_H,W,ACCESS
	addwfc	EPD_N_RAW_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	EPD_N_COL_U,W,ACCESS
	addwfc	EPD_N_RAW_U,W,ACCESS
	movwf	SysTemp1_U,BANKED
	movf	EPD_N_COL_E,W,ACCESS
	addwfc	EPD_N_RAW_E,W,ACCESS
	movwf	SysTemp1_E,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	EPD_IND,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	EPD_IND_H,ACCESS
	movlw	0
	addwfc	SysTemp1_U,W,BANKED
	movwf	EPD_IND_U,ACCESS
	movlw	0
	addwfc	SysTemp1_E,W,BANKED
	movwf	EPD_IND_E,ACCESS
;end if
ENDIF34
;GLCD_Time_Buff=_GLCDPage*BUFFWIDTH
	movff	_GLCDPAGE,SysLONGTempA
	clrf	SysLONGTempA_H,ACCESS
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	clrf	SysLONGTempB,ACCESS
	movlw	30
	movwf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysMultSub32
	movff	SysLONGTempX,GLCD_TIME_BUFF
	movff	SysLONGTempX_H,GLCD_TIME_BUFF_H
	movff	SysLONGTempX_U,GLCD_TIME_BUFF_U
	movff	SysLONGTempX_E,GLCD_TIME_BUFF_E
;EPD_Ind_Trans=EPD_Ind
	movff	EPD_IND,EPD_IND_TRANS
	movff	EPD_IND_H,EPD_IND_TRANS_H
	movff	EPD_IND_U,EPD_IND_TRANS_U
	movff	EPD_IND_E,EPD_IND_TRANS_E
;EPD_Ind_Trans=EPD_Ind_Trans-GLCD_Time_Buff
	movf	GLCD_TIME_BUFF,W,ACCESS
	subwf	EPD_IND_TRANS,F,ACCESS
	movf	GLCD_TIME_BUFF_H,W,ACCESS
	subwfb	EPD_IND_TRANS_H,F,ACCESS
	movf	GLCD_TIME_BUFF_U,W,ACCESS
	subwfb	EPD_IND_TRANS_U,F,ACCESS
	movf	GLCD_TIME_BUFF_E,W,ACCESS
	subwfb	EPD_IND_TRANS_E,F,ACCESS
;if EPD_Ind_Trans>BUFFWIDTH then       'NOTE:it should be a control also for a
	movff	EPD_IND_TRANS,SysLONGTempB
	movff	EPD_IND_TRANS_H,SysLONGTempB_H
	movff	EPD_IND_TRANS_U,SysLONGTempB_U
	movff	EPD_IND_TRANS_E,SysLONGTempB_E
	clrf	SysLONGTempA,ACCESS
	movlw	30
	movwf	SysLONGTempA_H,ACCESS
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	rcall	SysCompLessThan32
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
	clrf	DATAVAR_H,ACCESS
	clrf	DATAVAR_U,ACCESS
	clrf	DATAVAR_E,ACCESS
;Select Case remainder                 'non signed arithmetic, it will be very
;case 0                                'large, thus Exits sub is executed.
SysSelect5Case1
	movff	REMAINDER,SysLONGTempA
	movff	REMAINDER_H,SysLONGTempA_H
	movff	REMAINDER_U,SysLONGTempA_U
	movff	REMAINDER_E,SysLONGTempA_E
	clrf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysCompEqual32
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect5Case2
;DataVar.0=GLCDColour.0
	bcf	DATAVAR,0,ACCESS
	btfsc	GLCDCOLOUR,0,ACCESS
	bsf	DATAVAR,0,ACCESS
;case 1
	bra	SysSelectEnd5
SysSelect5Case2
	movff	REMAINDER,SysLONGTempA
	movff	REMAINDER_H,SysLONGTempA_H
	movff	REMAINDER_U,SysLONGTempA_U
	movff	REMAINDER_E,SysLONGTempA_E
	movlw	1
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysCompEqual32
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect5Case3
;DataVar.7=GLCDColour.0
	bcf	DATAVAR,7,ACCESS
	btfsc	GLCDCOLOUR,0,ACCESS
	bsf	DATAVAR,7,ACCESS
;case 2
	bra	SysSelectEnd5
SysSelect5Case3
	movff	REMAINDER,SysLONGTempA
	movff	REMAINDER_H,SysLONGTempA_H
	movff	REMAINDER_U,SysLONGTempA_U
	movff	REMAINDER_E,SysLONGTempA_E
	movlw	2
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysCompEqual32
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect5Case4
;DataVar.6=GLCDColour.0
	bcf	DATAVAR,6,ACCESS
	btfsc	GLCDCOLOUR,0,ACCESS
	bsf	DATAVAR,6,ACCESS
;case 3
	bra	SysSelectEnd5
SysSelect5Case4
	movff	REMAINDER,SysLONGTempA
	movff	REMAINDER_H,SysLONGTempA_H
	movff	REMAINDER_U,SysLONGTempA_U
	movff	REMAINDER_E,SysLONGTempA_E
	movlw	3
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysCompEqual32
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect5Case5
;DataVar.5=GLCDColour.0
	bcf	DATAVAR,5,ACCESS
	btfsc	GLCDCOLOUR,0,ACCESS
	bsf	DATAVAR,5,ACCESS
;case 4
	bra	SysSelectEnd5
SysSelect5Case5
	movff	REMAINDER,SysLONGTempA
	movff	REMAINDER_H,SysLONGTempA_H
	movff	REMAINDER_U,SysLONGTempA_U
	movff	REMAINDER_E,SysLONGTempA_E
	movlw	4
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysCompEqual32
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect5Case6
;DataVar.4=GLCDColour.0
	bcf	DATAVAR,4,ACCESS
	btfsc	GLCDCOLOUR,0,ACCESS
	bsf	DATAVAR,4,ACCESS
;case 5
	bra	SysSelectEnd5
SysSelect5Case6
	movff	REMAINDER,SysLONGTempA
	movff	REMAINDER_H,SysLONGTempA_H
	movff	REMAINDER_U,SysLONGTempA_U
	movff	REMAINDER_E,SysLONGTempA_E
	movlw	5
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysCompEqual32
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect5Case7
;DataVar.3=GLCDColour.0
	bcf	DATAVAR,3,ACCESS
	btfsc	GLCDCOLOUR,0,ACCESS
	bsf	DATAVAR,3,ACCESS
;case 6
	bra	SysSelectEnd5
SysSelect5Case7
	movff	REMAINDER,SysLONGTempA
	movff	REMAINDER_H,SysLONGTempA_H
	movff	REMAINDER_U,SysLONGTempA_U
	movff	REMAINDER_E,SysLONGTempA_E
	movlw	6
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysCompEqual32
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect5Case8
;DataVar.2=GLCDColour.0
	bcf	DATAVAR,2,ACCESS
	btfsc	GLCDCOLOUR,0,ACCESS
	bsf	DATAVAR,2,ACCESS
;case 7
	bra	SysSelectEnd5
SysSelect5Case8
	movff	REMAINDER,SysLONGTempA
	movff	REMAINDER_H,SysLONGTempA_H
	movff	REMAINDER_U,SysLONGTempA_U
	movff	REMAINDER_E,SysLONGTempA_E
	movlw	7
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysCompEqual32
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelectEnd5
;DataVar.1=GLCDColour.0
	bcf	DATAVAR,1,ACCESS
	btfsc	GLCDCOLOUR,0,ACCESS
	bsf	DATAVAR,1,ACCESS
;End Select
SysSelectEnd5
;EPD_Buffer(EPD_Ind_Trans)=DataVar
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_TRANS,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_TRANS_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movffl	DATAVAR,INDF0
	return

;********************************************************************************

;Source: EPD_EPD7in5.h (381)
REFRESH_EPD7IN5
;Not required as this process has already happenend from INIT
;LoadLUTS_EPD7in5
;SendCommand_EPD7in5(DISPLAY_REFRESH)
	movlw	18
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
;do while EPD_Busy=Off
SysDoLoop_S5
	btfsc	PORTC,0,ACCESS
	bra	SysDoLoop_E5
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;loop
	bra	SysDoLoop_S5
SysDoLoop_E5
	return

;********************************************************************************

;Source: EPD_EPD7in5.h (845)
ROTATE_EPD7IN5
;Reset PrintLocY
;PrintLocY = 0
	clrf	PRINTLOCY,ACCESS
;select case EPD7in5AddressType
;case PORTRAIT
SysSelect1Case1
	movlw	4
	subwf	EPD7IN5ADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;GLCDDeviceWidth = GLCD_HEIGHT - 1
	movlw	127
	movwf	GLCDDEVICEWIDTH,ACCESS
	movlw	1
	movwf	GLCDDEVICEWIDTH_H,ACCESS
;GLCDDeviceHeight  = GLCD_WIDTH - 1
	movlw	127
	movwf	GLCDDEVICEHEIGHT,ACCESS
	movlw	2
	movwf	GLCDDEVICEHEIGHT_H,ACCESS
;case LANDSCAPE
	bra	SysSelectEnd1
SysSelect1Case2
	decf	EPD7IN5ADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	127
	movwf	GLCDDEVICEHEIGHT,ACCESS
	movlw	1
	movwf	GLCDDEVICEHEIGHT_H,ACCESS
;GLCDDeviceWidth  = GLCD_WIDTH - 1
	movlw	127
	movwf	GLCDDEVICEWIDTH,ACCESS
	movlw	2
	movwf	GLCDDEVICEWIDTH_H,ACCESS
;case PORTRAIT_REV
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	2
	subwf	EPD7IN5ADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;GLCDDeviceWidth = GLCD_HEIGHT - 1
	movlw	127
	movwf	GLCDDEVICEWIDTH,ACCESS
	movlw	1
	movwf	GLCDDEVICEWIDTH_H,ACCESS
;GLCDDeviceHeight  = GLCD_WIDTH - 1
	movlw	127
	movwf	GLCDDEVICEHEIGHT,ACCESS
	movlw	2
	movwf	GLCDDEVICEHEIGHT_H,ACCESS
;case LANDSCAPE_REV
	bra	SysSelectEnd1
SysSelect1Case4
	movlw	3
	subwf	EPD7IN5ADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case5
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	127
	movwf	GLCDDEVICEHEIGHT,ACCESS
	movlw	1
	movwf	GLCDDEVICEHEIGHT_H,ACCESS
;GLCDDeviceWidth  = GLCD_WIDTH - 1
	movlw	127
	movwf	GLCDDEVICEWIDTH,ACCESS
	movlw	2
	movwf	GLCDDEVICEWIDTH_H,ACCESS
;case else
	bra	SysSelectEnd1
SysSelect1Case5
;EPD7in5AddressType = 1
	movlw	1
	movwf	EPD7IN5ADDRESSTYPE,ACCESS
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	127
	movwf	GLCDDEVICEHEIGHT,ACCESS
	movlw	1
	movwf	GLCDDEVICEHEIGHT_H,ACCESS
;GLCDDeviceWidth  = GLCD_WIDTH - 1
	movlw	127
	movwf	GLCDDEVICEWIDTH,ACCESS
	movlw	2
	movwf	GLCDDEVICEWIDTH_H,ACCESS
;end select
SysSelectEnd1
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
SysDoLoop_S2
;loop while EPD_Busy=Off
	btfss	PORTC,0,ACCESS
	bra	SysDoLoop_S2
SysDoLoop_E2
;Exit sub
	return
	return

;********************************************************************************

;Source: EPD_EPD7in5.h (412)
SENDCOMMAND_EPD7IN5
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC OFF
	bcf	LATA,0,ACCESS
;FastHWSPITransfer EPD7in5_Command
	movff	EPD7IN5_COMMAND,SPITXDATA
	call	FASTHWSPITRANSFER
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
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

;Source: EPD_EPD7in5.h (442)
SENDDATA_EPD7IN5
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATA,0,ACCESS
;SendData_EPD7in5_Macro
;Macro Source: EPD_EPD7in5.h (453)
;FastHWSPITransfer EPD7in5_Data
	movff	EPD7IN5_DATA,SPITXDATA
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
	bra	ENDIF48
;SPI1CON1.CKE = 1
	banksel	SPI1CON1
	bsf	SPI1CON1,CKE,BANKED
;End If
ENDIF48
;If SPIClockMode.1 = On Then
	banksel	SPICLOCKMODE
	btfss	SPICLOCKMODE,1,BANKED
	bra	ENDIF49
;SPI1CON1.CKP = 1
	banksel	SPI1CON1
	bsf	SPI1CON1,CKP,BANKED
;End If
ENDIF49
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

;Source: system.h (2693)
SYSCOMPEQUAL32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test low, exit if false
;movf SysLongTempB, W
	movf	SYSLONGTEMPB, W,ACCESS
;cpfseq SysLongTempA
	cpfseq	SYSLONGTEMPA,ACCESS
;return
	return
;Test high, exit if false
;movf SysLongTempB_H, W
	movf	SYSLONGTEMPB_H, W,ACCESS
;cpfseq SysLongTempA_H
	cpfseq	SYSLONGTEMPA_H,ACCESS
;return
	return
;Test upper, exit if false
;movf SysLongTempB_U, W
	movf	SYSLONGTEMPB_U, W,ACCESS
;cpfseq SysLongTempA_U
	cpfseq	SYSLONGTEMPA_U,ACCESS
;return
	return
;Test exp, exit if false
;movf SysLongTempB_E, W
	movf	SYSLONGTEMPB_E, W,ACCESS
;cpfseq SysLongTempA_E
	cpfseq	SYSLONGTEMPA_E,ACCESS
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

;Source: system.h (2868)
SYSCOMPLESSTHAN32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test Exp, exit if more
;movf SysLongTempA_E,W
	movf	SYSLONGTEMPA_E,W,ACCESS
;subwf SysLongTempB_E,W
	subwf	SYSLONGTEMPB_E,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;If not more and not zero, is less
;bnz SCLT32True
	bnz	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	movf	SYSLONGTEMPA_U,W,ACCESS
;subwf SysLongTempB_U,W
	subwf	SYSLONGTEMPB_U,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;If not more and not zero, is less
;bnz SCLT32True
	bnz	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	movf	SYSLONGTEMPA_H,W,ACCESS
;subwf SysLongTempB_H,W
	subwf	SYSLONGTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;If not more and not zero, is less
;bnz SCLT32True
	bnz	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	movf	SYSLONGTEMPB,W,ACCESS
;subwf SysLongTempA,W
	subwf	SYSLONGTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,C,ACCESS
;return
	return
SCLT32TRUE
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
	bra	ENDIF17
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF17
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
	bra	ENDIF18
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF18
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

;Source: system.h (2533)
SYSDIVSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;#ifdef PIC
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;#endif
;SysLongDivMultA = SysLongTempA
	movff	SYSLONGTEMPA,SYSLONGDIVMULTA
	movff	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	movff	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	movff	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movff	SYSLONGTEMPB,SYSLONGDIVMULTB
	movff	SYSLONGTEMPB_H,SYSLONGDIVMULTB_H
	movff	SYSLONGTEMPB_U,SYSLONGDIVMULTB_U
	movff	SYSLONGTEMPB_E,SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX,BANKED
	clrf	SYSLONGDIVMULTX_H,BANKED
	clrf	SYSLONGDIVMULTX_U,BANKED
	clrf	SYSLONGDIVMULTX_E,BANKED
;Avoid division by zero
;if SysLongDivMultB = 0 then
	movff	SYSLONGDIVMULTB,SysLONGTempA
	movff	SYSLONGDIVMULTB_H,SysLONGTempA_H
	movff	SYSLONGDIVMULTB_U,SysLONGTempA_U
	movff	SYSLONGDIVMULTB_E,SysLONGTempA_E
	clrf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysCompEqual32
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF46
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF46
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP,ACCESS
SYSDIV32START
;set C off
	bcf	STATUS,C,ACCESS
;Rotate SysLongDivMultA Left
	rlcf	SYSLONGDIVMULTA,F,BANKED
	rlcf	SYSLONGDIVMULTA_H,F,BANKED
	rlcf	SYSLONGDIVMULTA_U,F,BANKED
	rlcf	SYSLONGDIVMULTA_E,F,BANKED
;Rotate SysLongDivMultX Left
	rlcf	SYSLONGDIVMULTX,F,BANKED
	rlcf	SYSLONGDIVMULTX_H,F,BANKED
	rlcf	SYSLONGDIVMULTX_U,F,BANKED
	rlcf	SYSLONGDIVMULTX_E,F,BANKED
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,BANKED
	subwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTB_H,W,BANKED
	subwfb	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTB_U,W,BANKED
	subwfb	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTB_E,W,BANKED
	subwfb	SYSLONGDIVMULTX_E,F,BANKED
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0,BANKED
;If C Off Then
	btfsc	STATUS,C,ACCESS
	bra	ENDIF47
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0,BANKED
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,BANKED
	addwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTB_H,W,BANKED
	addwfc	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTB_U,W,BANKED
	addwfc	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTB_E,W,BANKED
	addwfc	SYSLONGDIVMULTX_E,F,BANKED
;End If
ENDIF47
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv32Start
	bra	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	movff	SYSLONGDIVMULTA,SYSLONGTEMPA
	movff	SYSLONGDIVMULTA_H,SYSLONGTEMPA_H
	movff	SYSLONGDIVMULTA_U,SYSLONGTEMPA_U
	movff	SYSLONGDIVMULTA_E,SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	movff	SYSLONGDIVMULTX,SYSLONGTEMPX
	movff	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	movff	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	movff	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
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

;Source: system.h (2329)
SYSMULTSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;Can't use normal SysDivMult variables for 32 bit, they overlap with
;SysLongTemp variables
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;SysLongDivMultA = SysLongTempA
	movff	SYSLONGTEMPA,SYSLONGDIVMULTA
	movff	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	movff	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	movff	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movff	SYSLONGTEMPB,SYSLONGDIVMULTB
	movff	SYSLONGTEMPB_H,SYSLONGDIVMULTB_H
	movff	SYSLONGTEMPB_U,SYSLONGDIVMULTB_U
	movff	SYSLONGTEMPB_E,SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX,BANKED
	clrf	SYSLONGDIVMULTX_H,BANKED
	clrf	SYSLONGDIVMULTX_U,BANKED
	clrf	SYSLONGDIVMULTX_E,BANKED
MUL32LOOP
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	btfss	SYSLONGDIVMULTB,0,BANKED
	bra	ENDIF44
	movf	SYSLONGDIVMULTA,W,BANKED
	addwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTA_H,W,BANKED
	addwfc	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTA_U,W,BANKED
	addwfc	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTA_E,W,BANKED
	addwfc	SYSLONGDIVMULTX_E,F,BANKED
ENDIF44
;set STATUS.C OFF
	bcf	STATUS,C,ACCESS
;rotate SysLongDivMultB right
	rrcf	SYSLONGDIVMULTB_E,F,BANKED
	rrcf	SYSLONGDIVMULTB_U,F,BANKED
	rrcf	SYSLONGDIVMULTB_H,F,BANKED
	rrcf	SYSLONGDIVMULTB,F,BANKED
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate SysLongDivMultA left
	rlcf	SYSLONGDIVMULTA,F,BANKED
	rlcf	SYSLONGDIVMULTA_H,F,BANKED
	rlcf	SYSLONGDIVMULTA_U,F,BANKED
	rlcf	SYSLONGDIVMULTA_E,F,BANKED
;if SysLongDivMultB > 0 then goto MUL32LOOP
	movff	SYSLONGDIVMULTB,SysLONGTempB
	movff	SYSLONGDIVMULTB_H,SysLONGTempB_H
	movff	SYSLONGDIVMULTB_U,SysLONGTempB_U
	movff	SYSLONGDIVMULTB_E,SysLONGTempB_E
	clrf	SysLONGTempA,ACCESS
	clrf	SysLONGTempA_H,ACCESS
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	rcall	SysCompLessThan32
	btfsc	SysByteTempX,0,ACCESS
	bra	MUL32LOOP
;SysLongTempX = SysLongDivMultX
	movff	SYSLONGDIVMULTX,SYSLONGTEMPX
	movff	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	movff	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	movff	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
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
	db	4,66,65,82,49


StringTable2
	db	4,66,65,82,50


StringTable3
	db	4,66,65,82,51


;********************************************************************************


 END
