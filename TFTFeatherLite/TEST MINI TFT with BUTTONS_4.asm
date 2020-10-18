;Program compiled by Great Cow BASIC (0.98.<<>> 2020-04-09 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F4550, r=DEC
#include <P18F4550.inc>
 CONFIG WRTD = OFF, CPD = OFF, XINST = OFF, LVP = OFF, MCLRE = ON, WDT = OFF, FOSC = HSPLL_HS, CPUDIV = OSC1_PLL2, PLLDIV = 1

;********************************************************************************

;Set aside memory locations for variables
BUTTON_ABS	EQU	11
BUTTON_XY	EQU	12
BYTENUM	EQU	13
BYTETOBIN	EQU	2025
CHARCODE	EQU	14
CHARLOCX	EQU	15
CHARLOCX_H	EQU	16
CHARLOCY	EQU	17
CHARLOCY_H	EQU	18
CNT_1	EQU	19
COLOR	EQU	20
COLOR_H	EQU	21
CURRCHARCOL	EQU	22
CURRCHARROW	EQU	23
CURRCHARVAL	EQU	24
CURRCOL	EQU	25
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
FOURTH_BYTE	EQU	26
GLCDBACKGROUND	EQU	27
GLCDBACKGROUND_H	EQU	28
GLCDCOLOUR	EQU	29
GLCDCOLOUR_H	EQU	30
GLCDDEVICEHEIGHT	EQU	31
GLCDDEVICEHEIGHT_H	EQU	32
GLCDDEVICEWIDTH	EQU	33
GLCDDEVICEWIDTH_H	EQU	34
GLCDFNTDEFAULT	EQU	35
GLCDFNTDEFAULTHEIGHT	EQU	36
GLCDFNTDEFAULTSIZE	EQU	37
GLCDFONTWIDTH	EQU	38
GLCDFOREGROUND	EQU	39
GLCDFOREGROUND_H	EQU	40
GLCDPRINTLOC	EQU	41
GLCDPRINTLOC_H	EQU	42
GLCDROTATESTATE	EQU	43
GLCDX	EQU	44
GLCDY	EQU	45
GLCD_YORDINATE	EQU	46
GLCD_YORDINATE_H	EQU	47
HI2CACKPOLLSTATE	EQU	48
HI2CCURRENTMODE	EQU	49
HI2CGETACK	EQU	50
HI2CWAITMSSPTIMEOUT	EQU	51
I2CBYTE	EQU	52
LCD2BYTE	EQU	53
LCDBYTE	EQU	54
LCDCOLUMN	EQU	55
LCDLINE	EQU	56
LCDTEMP	EQU	57
LCDVALUE	EQU	58
LCDVALUETEMP	EQU	59
LCD_STATE	EQU	60
LOCX	EQU	61
LOCX_H	EQU	62
LOCY	EQU	63
LOCY_H	EQU	64
PRINTLEN	EQU	65
PRINTLOCX	EQU	66
PRINTLOCX_H	EQU	67
PRINTLOCY	EQU	68
PRINTLOCY_H	EQU	69
ST7735ADDRESSTYPE	EQU	70
ST7735END	EQU	71
ST7735END_H	EQU	72
ST7735SENDBYTE	EQU	73
ST7735SENDWORD	EQU	74
ST7735SENDWORD_H	EQU	75
ST7735START	EQU	76
ST7735START_H	EQU	77
STRINGPOINTER	EQU	78
SWAP4	EQU	79
SWAP4IN	EQU	80
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSCALCTEMPX	EQU	0
SYSDIVLOOP	EQU	4
SYSLCDTEMP	EQU	81
SYSPRINTDATAHANDLER	EQU	82
SYSPRINTDATAHANDLER_H	EQU	83
SYSPRINTTEMP	EQU	84
SYSREPEATTEMP1	EQU	85
SYSREPEATTEMP1_H	EQU	86
SYSREPEATTEMP2	EQU	87
SYSREPEATTEMP3	EQU	88
SYSREPEATTEMP4	EQU	89
SYSREPEATTEMP6	EQU	90
SYSREPEATTEMP7	EQU	91
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	2034
SYSTEMP1	EQU	92
SYSTEMP2	EQU	93
SYSTEMP3	EQU	94
SYSWAITTEMP10US	EQU	5
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
SYSWAITTEMPS	EQU	4
SYSWAITTEMPUS	EQU	5
SYSWAITTEMPUS_H	EQU	6
SYSWORDTEMPA	EQU	5
SYSWORDTEMPA_H	EQU	6
SYSWORDTEMPB	EQU	9
SYSWORDTEMPB_H	EQU	10
THIRD_BYTE	EQU	95

;********************************************************************************

;Alias variables
AFSR0	EQU	4073
AFSR0_H	EQU	4074

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
	call	HIC2INIT
	call	INITGLCD_ST7735
	call	INITGLCD_ST7735R
	call	INITLCD

;Start of the main program
;Chip Settings.
;#option explicit
;#define LCD_IO 2
;#define LCD_CB PORTE.1
;#define LCD_DB PORTE.0
;#define HI2C_BAUD_RATE 100
;#define HI2C_DATA PORTB.0 ;Brown
;#define HI2C_CLOCK PORTB.1 ;Green This was same CLOCK as SPI below. Is this allowed ??????  Changed below to D.7  ????????
;#define MiniTFT_WRITEADDR 188 ;0xBC
;#define MiniTFT_READADDR 189 ;0xBD
;#define GLCD_TYPE GLCD_TYPE_ST7735R_160_80
;'''   #define ST7735R_HardwareSPI     ' remove comment out if you want to use software SPI.
;#define GLCD_TYPE GLCD_TYPE_ST7735  ' can be GLCD_TYPE_ST7735 OR GLCD_TYPE_ST7735R OR GLCD_TYPE_ST7735R_160_80
;#define ST7735TABCOLOR ST7735_GREENTAB  ' can be ST7735_BLACKTAB, ST7735_GREENTAB or ST7735_REDTAB.  Each tab is a different ST7735 configuration.
;you may have to try all three - if you do not know what chipset you have.
;#option Explicit
;Pin mappings for SPI ST7735
;#define GLCD_DC         portE.2              'Data/Command select   Purple Wire
;#define GLCD_CS         portB.2              'CS Chip select        White
;#define GLCD_RESET      portC.6              'Through pin 7 of ATSAMD09D14A-MU chip - i.e. no direct connection
;#define GLCD_DO         portC.7              'SPI SDO (MOSI)        Blue
;#define GLCD_DI         portC.7              'SPI SDI (MISO)  assume bi-directional DO/DI
;#define GLCD_SCK        portD.7              'SPI SCK               Green
;#define RESET_Pin 28 ;PA28_RESET pin 18
;#define CTRL_Reset 0 ;Reset the SAM-D09 pg 51
;Buttons
;#define DirClr_GPIO 3 ;0x03 Pg 22 of Seesaw Tutorial - Writing a 1 to any bit in this register sets the direction of the corresponding pin to INPUT.
;#define PullenSet_GPIO 11 ;0x0B Pg 23 of Seesaw Tutorial - Writing a 1 to any bit in this register enables the internal pullup or pulldown on the corresponding pin.
;#define Set_FunctionReg 5 ;Writing a 1 to any bit in this register writes the corresponding pin HIGH. pg 22
;#define Module_Base_Address_GPIO 1 ;GPIO = 1  Pg 21 of Seesaw Tutorial
;#define GPIO_BULK 4 ;GPIO = 4 Reading this register reads all pins on PORTA of the seesaw device.
;#define Module_Base_Address_AD 9 ;AD = 9  Pg 24 of Seesaw Tutorial
;#define Module_function_register_address_AD0 7 ;PA02_A0 AD  = 7
;#define Module_function_register_address_AD1 8 ;PA03_A1 AD  = 8
;Dir HI2C_DATA in
	bsf	TRISB,0,ACCESS
;Dir HI2C_CLOCK in
	bsf	TRISB,1,ACCESS
;HI2CMode Master
	movlw	12
	movwf	HI2CCURRENTMODE,ACCESS
	call	HI2CMODE
;seesaw is on I2C, it is a pre-programmed ATSAMD09 chip which will listen to commands over I2C and read buttons,
;dim the backlight and toggle the display reset line.
;locate 0, 0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;print "Mini TFT with"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;locate 1, 0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;print "Buttons_4"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;locate 2, 0
	movlw	2
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;print "Dec. 10, 2019"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;wait 1 s
	movlw	1
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;cls
	call	CLS
;The Mini TFT needs 4.1 VDC for the GLCD good display quality.  PIC needs to run at 5 VDC.
;It will work with 3.5 VDC but colors may blur.
;CAUTION: Exceeding 3.8 VDC could damage ATSAMD09D14A-MU chip. (Spec says Max voltage is 3.8 VDC)
;
;Button B now working - BUT Reset Switch causes displays to print out ALL buttons/Switches continuously.  WHY ?????????????????????
;**********************************************************************
;GLCDCLS
	call	GLCDCLS_ST7735
;GLCDRotate ( Landscape )
	movlw	1
	movwf	GLCDROTATESTATE,ACCESS
	call	GLCDROTATE_ST7735
;GLCDPrintLargeFont(4, 0, "Great", TFT_YELLOW )
	movlw	4
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	clrf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	224
	movwf	COLOR,ACCESS
	setf	COLOR_H,ACCESS
	call	GLCDPRINTLARGEFONT
;GLCDPrintLargeFont(4, 20, "Cow", TFT_GREEN )
	movlw	4
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	20
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	224
	movwf	COLOR,ACCESS
	movlw	7
	movwf	COLOR_H,ACCESS
	call	GLCDPRINTLARGEFONT
;GLCDPrintLargeFont(4, 40, "Basic", TFT_WHITE )
	movlw	4
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	40
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	setf	COLOR,ACCESS
	setf	COLOR_H,ACCESS
	call	GLCDPRINTLARGEFONT
;wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;GLCDCLS
	call	GLCDCLS_ST7735
;Do_Again:
;Button B problem occurs AFTER it prints "Button B" on the GLCD.  i.e. it happens after the HI2C WRITES or READ. The LCD still works properly.
;HI2CStart
	call	HI2CSTART
;HI2CSend MiniTFT_WRITEADDR
	movlw	188
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend Module_Base_Address_GPIO
	movlw	1
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend DirClr_GPIO
	movlw	3
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend 211 ;Writing a 1 to any bit in this register sets the direction of the corresponding pin to INPUT.
	movlw	211
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend 195 ;Writing zeros to this register has no effect.
	movlw	195
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend 207 ;PA15:PA08 = 1100 1111 - Pin 12 to Pin 7
	movlw	207
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend 220 ;PA07:PA02 = 1101 1100 - Pin 6 to Pin 1   LSB
	movlw	220
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CStop
	call	HI2CSTOP
;HI2CStart
	call	HI2CSTART
;HI2CSend MiniTFT_WRITEADDR
	movlw	188
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend Module_Base_Address_GPIO ;Writing a 1 to any bit in this register enables the internal pullup or pulldown on the corresponding pin. The pull direction
	movlw	1
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend PullenSet_GPIO ;(up/down) is determined by the GPIO (output) value - if the corresponding GPIO register bit is low, its a pulldown. High, its a pullup.
	movlw	11
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend 211
	movlw	211
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend 195
	movlw	195
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend 207
	movlw	207
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend 220
	movlw	220
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CStop
	call	HI2CSTOP
;HI2CStart
	call	HI2CSTART
;HI2CSend MiniTFT_WRITEADDR
	movlw	188
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend Module_Base_Address_GPIO ;Writing a 1 to any bit in this register writes the corresponding pin HIGH.  Writing zeros to this register has no effect.
	movlw	1
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend Set_FunctionReg
	movlw	5
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend 211
	movlw	211
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend 195
	movlw	195
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend 207
	movlw	207
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend 220
	movlw	220
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CStop
	call	HI2CSTOP
;Cnt_1 = 1
	movlw	1
	movwf	CNT_1,ACCESS
DO_AGAIN
;locate 0, 17
	clrf	LCDLINE,ACCESS
	movlw	17
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
;print Cnt_1
	movff	CNT_1,LCDVALUE
	call	PRINT546
;HI2CStart
	call	HI2CSTART
;HI2CSend MiniTFT_WRITEADDR
	movlw	188
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend Module_Base_Address_GPIO
	movlw	1
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend GPIO_BULK ;Reading this register reads all pins on PORTA of the seesaw device.
	movlw	4
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CRestart
	call	HI2CRESTART
;HI2CSend MiniTFT_READADDR
	movlw	189
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CReceive Fourth_Byte ;Bits [31:24] MSB      Seems like BIG_ENDIAN is being used - Data sheet says LITTLE_ENDIAN ????????????
	movlw	1
	movwf	HI2CGETACK,ACCESS
	call	HI2CRECEIVE
	movff	I2CBYTE,FOURTH_BYTE
;HI2CReceive Third_Byte ;Bits [23:16]         I show bit order as if it is BIG ENDIAN
	movlw	1
	movwf	HI2CGETACK,ACCESS
	call	HI2CRECEIVE
	movff	I2CBYTE,THIRD_BYTE
;HI2CReceive Button_ABS ;Bits [15:8]
	movlw	1
	movwf	HI2CGETACK,ACCESS
	call	HI2CRECEIVE
	movff	I2CBYTE,BUTTON_ABS
;HI2CReceive Button_XY, Nack ;Bits [7:0] LSB
	clrf	HI2CGETACK,ACCESS
	call	HI2CRECEIVE
	movff	I2CBYTE,BUTTON_XY
;HI2CStop
	call	HI2CSTOP
;locate 0, 0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;print Fourth_Byte
	movff	FOURTH_BYTE,LCDVALUE
	call	PRINT546
;print " "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;print ByteToBin(Fourth_Byte)
	movff	FOURTH_BYTE,BYTENUM
	call	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;locate 1, 0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;print Third_Byte
	movff	THIRD_BYTE,LCDVALUE
	call	PRINT546
;print " "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;print ByteToBin(Third_Byte)
	movff	THIRD_BYTE,BYTENUM
	call	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;locate 2, 0
	movlw	2
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;print Button_ABS
	movff	BUTTON_ABS,LCDVALUE
	call	PRINT546
;print " "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;print ByteToBin(Button_ABS)
	movff	BUTTON_ABS,BYTENUM
	call	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;locate 3, 0
	movlw	3
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;print Button_XY
	movff	BUTTON_XY,LCDVALUE
	call	PRINT546
;print " "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;print ByteToBin(Button_XY)
	movff	BUTTON_XY,BYTENUM
	call	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;print "  "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;If Fourth_Byte = 255 then RESET ;To recover from Reset Button problem
	incf	FOURTH_BYTE,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	reset
;locate 3, 0
;CHECK FOR SHORT ON BUTTON B
;If Button_ABS.1 = 0 then
	btfsc	BUTTON_ABS,1,ACCESS
	bra	ENDIF2
;print "B" ;Button_ABS = 204
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;GLCDPrintLargeFont(4, 0, "Button B", TFT_RED )
	movlw	4
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	clrf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	clrf	COLOR,ACCESS
	movlw	248
	movwf	COLOR_H,ACCESS
	call	GLCDPRINTLARGEFONT
;RESET ;To recover from Button B white screen problem - Press long enough for LCD to show "B"
;End If
ENDIF2
;If Button_ABS.2 = 0 then
	btfsc	BUTTON_ABS,2,ACCESS
	bra	ENDIF3
;print "A" ;Button_ABS = 202
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable11
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable11
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;GLCDPrintLargeFont(4, 10, "Button A", TFT_YELLOW )
	movlw	4
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	10
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	224
	movwf	COLOR,ACCESS
	setf	COLOR_H,ACCESS
	call	GLCDPRINTLARGEFONT
;End If
ENDIF3
;If Button_ABS.3 = 0 then
	btfsc	BUTTON_ABS,3,ACCESS
	bra	ENDIF4
;print "SELECT" ;Button_ABS = 198 - Push for Select
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable13
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable13
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;GLCDPrintLargeFont(4, 20, "SELECT", TFT_Green )
	movlw	4
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	20
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable13
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable13
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	224
	movwf	COLOR,ACCESS
	movlw	7
	movwf	COLOR_H,ACCESS
	call	GLCDPRINTLARGEFONT
;End If
ENDIF4
;If Button_XY.2 = 0 then
	btfsc	BUTTON_XY,2,ACCESS
	bra	ENDIF5
;print "UP" ;Button_XY = 216
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable14
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable14
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;GLCDPrintLargeFont(4, 30, "UP", TFT_RED )
	movlw	4
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	30
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable14
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable14
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	clrf	COLOR,ACCESS
	movlw	248
	movwf	COLOR_H,ACCESS
	call	GLCDPRINTLARGEFONT
;End If
ENDIF5
;If Button_XY.3 = 0 then
	btfsc	BUTTON_XY,3,ACCESS
	bra	ENDIF6
;print "LEFT" ;Button_XY = 212
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable15
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable15
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;GLCDPrintLargeFont(4, 40, "LEFT", TFT_YELLOW )
	movlw	4
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	40
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable15
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable15
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	224
	movwf	COLOR,ACCESS
	setf	COLOR_H,ACCESS
	call	GLCDPRINTLARGEFONT
;End If
ENDIF6
;If Button_XY.4 = 0 then
	btfsc	BUTTON_XY,4,ACCESS
	bra	ENDIF7
;print "DOWN" ;Button_XY = 204
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable16
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable16
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;GLCDPrintLargeFont(4, 50, "DOWN", TFT_GREEN )
	movlw	4
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	50
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable16
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable16
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	224
	movwf	COLOR,ACCESS
	movlw	7
	movwf	COLOR_H,ACCESS
	call	GLCDPRINTLARGEFONT
;End If
ENDIF7
;If Button_XY.7 = 0 then
	btfsc	BUTTON_XY,7,ACCESS
	bra	ENDIF8
;print "RIGHT" ;Button_XY = 92
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable17
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable17
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	call	PRINT545
;GLCDPrintLargeFont(4, 60, "RIGHT", TFT_CYAN )
	movlw	4
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	60
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable17
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable17
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	setf	COLOR,ACCESS
	movlw	7
	movwf	COLOR_H,ACCESS
	call	GLCDPRINTLARGEFONT
;End If
ENDIF8
;Cnt_1 = Cnt_1 + 1
	incf	CNT_1,F,ACCESS
;If Cnt_1 = 255 then Cnt_1 = 1
	incf	CNT_1,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF9
	movlw	1
	movwf	CNT_1,ACCESS
ENDIF9
;wait 1 s
	movlw	1
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;GLCDCLS
	call	GLCDCLS_ST7735
;cls
	call	CLS
;Goto Do_Again
	bra	DO_AGAIN
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

BIGFONT102_111
	movlw	239
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableBIGFONT102_111
	movwf	TBLPTRL,ACCESS
	movlw	high TableBIGFONT102_111
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableBIGFONT102_111
	db	240,0,128,128,248,252,252,132,156,156,24,0,0,0,33,33,63,63,63,33,33,1,0,0,0,0
	db	128,192,192,64,64,64,192,128,192,64,0,0,71,207,223,152,152,152,255,255,127,0,0,0
	db	4,252,252,252,128,64,64,192,192,128,0,0,32,63,63,63,1,0,0,63,63,63,0,0,0,64,64,64
	db	220,220,220,0,0,0,0,0,0,32,32,32,63,63,63,32,32,32,0,0,0,0,0,64,64,64,220,220
	db	220,0,0,0,32,96,224,128,128,192,255,255,127,0,0,0,4,252,252,252,0,0,128,192,192,64
	db	0,0,32,63,63,63,2,7,15,61,56,48,0,0,0,4,4,4,252,252,252,0,0,0,0,0,0,32,32,32,63,63
	db	63,32,32,32,0,0,192,192,192,64,64,192,64,64,192,192,128,0,63,63,63,0,0,63,0,0
	db	63,63,63,0,192,192,192,64,64,64,192,192,128,0,0,0,63,63,63,0,0,0,63,63,63,0,0,0
	db	128,192,192,64,64,64,192,192,128,0,0,0,31,63,63,32,32,32,63,63,31

;********************************************************************************

BIGFONT112_121
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableBIGFONT112_121
	movwf	TBLPTRL,ACCESS
	movlw	high TableBIGFONT112_121
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableBIGFONT112_121
	db	240,0,64,192,128,192,64,64,64,192,192,128,0,0,128,255,255,255,144,16,16,31,31,15
	db	0,128,192,192,64,64,64,192,128,192,64,0,0,15,31,31,16,16,144,255,255,255,128,0
	db	0,0,64,192,192,192,128,192,192,192,192,128,0,0,32,63,63,63,33,0,0,1,1,1,0,0,128,192
	db	192,64,64,64,64,192,128,0,0,0,25,59,35,38,38,38,60,61,25,0,0,0,64,64,224,240
	db	248,64,64,64,64,0,0,0,0,0,31,63,63,32,56,56,24,0,0,0,192,192,192,0,0,0,192,192
	db	192,0,0,0,31,63,63,32,32,32,63,31,63,32,0,0,192,192,192,0,0,0,192,192,192,0,0,0
	db	7,15,31,56,48,56,31,15,7,0,0,0,192,192,192,0,0,0,0,0,192,192,192,0,7,15,63,56
	db	56,14,56,56,63,15,7,0,192,192,192,0,0,192,192,192,0,0,0,0,48,57,63,15,15,63,57,48
	db	0,0,0,0,0,192,192,192,0,0,0,192,192,192,0,0,128,135,143,159,216,248,120,63,15,7

;********************************************************************************

BIGFONT122_126
	movlw	109
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableBIGFONT122_126
	movwf	TBLPTRL,ACCESS
	movlw	high TableBIGFONT122_126
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableBIGFONT122_126
	db	120,0,192,192,64,64,64,192,192,192,0,0,0,0,49,56,60,46,39,35,49,56,0,0,0,0,128,128
	db	192,120,124,60,4,4,4,4,0,0,1,1,3,30,62,60,32,32,32,32,0,0,0,0,0,0,254,254,254,0
	db	0,0,0,0,0,0,0,0,127,127,127,0,0,0,0,0,4,4,4,4,60,124,120,192,128,128,0,0,32,32
	db	32,32,60,62,30,3,1,1,0,56,60,60,4,12,28,56,48,32,60,60,28

;********************************************************************************

BIGFONT193_202
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableBIGFONT193_202
	movwf	TBLPTRL,ACCESS
	movlw	high TableBIGFONT193_202
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableBIGFONT193_202
	db	240,0,224,240,248,28,12,12,28,248,240,224,0,0,63,63,63,2,2,2,2,63,63,63,0,0,4,252
	db	252,252,132,132,132,252,252,120,0,0,32,63,63,63,36,36,36,63,63,30,0,0,0,252,252,252
	db	12,12,12,12,12,0,0,0,0,63,63,63,0,0,0,0,0,0,0,0,224,240,248,28,12,12,28,248,240,224
	db	0,0,63,63,63,48,48,48,48,63,63,63,0,0,4,252,252,252,132,132,132,196,204,28,0,0
	db	32,63,63,63,36,36,36,35,51,56,0,0,60,28,12,4,132,196,228,124,60,28,0,0,56,60,62,39
	db	35,36,32,48,56,60,0,0,252,252,252,128,128,128,252,252,252,0,0,0,63,63,63,1,1,1
	db	63,63,63,0,0,0,224,240,248,156,140,140,140,156,248,240,224,0,7,15,31,57,49,49
	db	49,57,31,15,7,0,0,4,4,252,252,252,4,4,0,0,0,0,0,32,32,63,63,63,32,32,0,0,0,0,4,252
	db	252,252,192,224,112,60,28,12,0,0,32,63,63,63,3,7,14,60,56,48

;********************************************************************************

BIGFONT203_212
	movlw	238
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableBIGFONT203_212
	movwf	TBLPTRL,ACCESS
	movlw	high TableBIGFONT203_212
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableBIGFONT203_212
	db	240,0,224,240,248,28,12,12,28,248,240,224,0,0,63,63,63,0,0,0,0,63,63,63,0,0,252,252
	db	252,120,240,224,240,120,252,252,252,0,63,63,63,0,0,1,0,0,63,63,63,0,252,252,252,112
	db	224,192,128,0,252,252,252,0,63,63,63,0,0,1,3,7,63,63,63,0,0,28,28,156,156,156
	db	156,156,28,28,0,0,0,56,56,57,57,57,57,57,56,56,0,0,224,240,248,28,12,12,12,28
	db	248,240,224,0,7,15,31,56,48,48,48,56,31,15,7,0,252,252,252,28,28,28,28,252,252,252
	db	0,0,63,63,63,0,0,0,0,63,63,63,0,0,4,252,252,252,132,132,132,252,252,120,0,0,32,63
	db	63,63,36,1,1,1,1,0,0,0,0,60,124,252,220,156,156,28,28,28,0,0,0,60,62,63,59,57
	db	57,56,56,56,0,0,28,12,4,4,252,252,252,4,4,12,28,0,0,0,32,32,63,63,63,32,32,0,0,0
	db	124,252,252,128,0,128,252,252,124,0,0,0,0,32,36,63,63,63,36,32

;********************************************************************************

BIGFONT213_216
	movlw	95
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableBIGFONT213_216
	movwf	TBLPTRL,ACCESS
	movlw	high TableBIGFONT213_216
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableBIGFONT213_216
	db	96,224,240,248,56,24,252,252,24,56,248,240,224,7,15,31,28,24,63,63,24,28,31,15
	db	7,0,28,60,124,224,192,224,124,60,28,0,0,0,56,60,62,7,3,7,62,60,56,0,0,0,252,252
	db	252,128,248,248,248,128,252,252,252,0,0,1,3,35,63,63,63,35,3,1,0,0,0,112,252,252
	db	140,140,140,252,252,112,0,0,0,0,49,51,51,51,51,51,49

;********************************************************************************

BIGFONT32_41
	movlw	239
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableBIGFONT32_41
	movwf	TBLPTRL,ACCESS
	movlw	high TableBIGFONT32_41
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableBIGFONT32_41
	db	240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,248,252,252,252,248,0,0
	db	0,0,0,0,0,0,115,115,115,0,0,0,0,0,0,0,0,30,62,62,0,0,0,62,62,30,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,48,48,254,254,48,48,48,48,254,254,48,48,12,12,127,127,12,12,12,12,127
	db	127,12,12,0,240,248,152,254,152,152,254,152,152,24,0,0,24,25,25,127,25,25,127,25
	db	31,15,0,0,0,56,56,56,128,192,224,112,56,0,0,0,0,28,14,7,3,1,28,28,28,0,0,0,56,252
	db	196,196,252,56,0,0,0,128,0,0,30,63,33,33,51,63,30,30,55,35,0,0,0,32,60,60,28,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,192,224,240,56,28,12,4,4,0,0,0,0,3,7,15
	db	28,56,48,32,32,0,0,0,0,4,4,12,28,56,240,224,192,0,0,0,0,32,32,48,56,28,15,7,3

;********************************************************************************

BIGFONT42_51
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableBIGFONT42_51
	movwf	TBLPTRL,ACCESS
	movlw	high TableBIGFONT42_51
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableBIGFONT42_51
	db	240,128,136,144,224,224,252,252,224,224,144,136,128,1,17,9,7,7,63,63,7,7,9,17,1,0
	db	0,128,128,128,240,240,128,128,128,0,0,0,0,1,1,1,15,15,1,1,1,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,64,120,120,56,0,0,0,0,0,0,0,128,128,128,128,128,128,128,128,128,128,0,0
	db	1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,56,56,56,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,128,192,224,112,56,0,32,48,56,28,14,7,3,1,0,0,0,0,248,252,252,4,4,4,4,252
	db	252,248,0,0,31,63,63,32,32,32,32,63,63,31,0,0,96,96,96,240,252,252,0,0,0,0,0,0
	db	32,32,32,63,63,63,32,32,32,0,0,0,24,28,28,4,4,132,204,252,120,48,0,0,48,56,60,46
	db	39,35,33,56,56,56,0,0,24,28,28,132,132,132,204,124,120,48,0,0,24,56,56,36,33,33
	db	51,62,30,12

;********************************************************************************

BIGFONT52_61
	movlw	241
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableBIGFONT52_61
	movwf	TBLPTRL,ACCESS
	movlw	high TableBIGFONT52_61
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableBIGFONT52_61
	db	240,0,128,192,96,48,24,252,252,252,0,0,0,0,3,3,3,35,35,63,63,63,35,35,0,0,252,252
	db	252,132,132,132,132,132,4,4,0,0,25,57,57,36,33,33,51,63,31,14,0,0,224,240,248,156
	db	140,132,132,132,128,0,0,0,31,63,63,36,36,33,33,63,63,31,0,0,60,60,60,4,4,4,4,132
	db	252,252,124,0,0,0,0,56,60,62,7,3,1,0,0,0,120,124,252,196,196,132,132,252,124,120
	db	0,0,30,62,63,33,33,35,35,63,62,30,0,0,248,252,252,132,132,132,132,252,252,248,0,0
	db	0,1,36,33,33,49,57,31,15,7,0,0,0,0,0,112,112,112,0,0,0,0,0,0,0,0,0,14,14,14,0,0
	db	0,0,0,0,0,0,0,112,112,112,0,0,0,0,0,0,0,0,16,30,30,14,0,0,0,0,0,0,128,192,224,112
	db	56,28,14,6,2,0,0,0,1,3,7,14,28,56,112,96,64,0,0,96,96,96,96,96,96,96,96,96,96,96
	db	96,6,6,6,6,6,6,6,6,6,6,6,6

;********************************************************************************

BIGFONT62_71
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableBIGFONT62_71
	movwf	TBLPTRL,ACCESS
	movlw	high TableBIGFONT62_71
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableBIGFONT62_71
	db	240,0,2,6,14,28,56,112,224,192,128,0,0,0,64,96,112,56,28,14,7,3,1,0,0,0,24,28
	db	12,14,6,134,206,252,124,56,0,0,0,0,0,0,115,115,115,0,0,0,0,0,252,254,254,2,2,194
	db	194,194,254,254,252,0,63,63,127,96,96,99,99,99,99,67,3,0,224,240,248,28,12,12
	db	28,248,240,224,0,0,63,63,63,2,2,2,2,63,63,63,0,0,4,252,252,252,132,132,132,252
	db	252,120,0,0,32,63,63,63,36,33,33,63,63,30,0,0,240,248,252,12,4,4,4,28,28,24,0,0
	db	15,31,63,48,32,32,32,56,56,24,0,0,4,252,252,252,4,4,12,252,248,240,0,0,32,63,63,63
	db	32,32,48,63,31,15,0,0,4,252,252,252,132,132,132,196,204,28,0,0,32,63,63,63,36,33
	db	33,35,51,56,0,0,4,252,252,252,132,132,132,196,204,28,0,0,32,63,63,63,33,1,1,3,3,0
	db	0,0,240,248,252,12,4,4,4,60,60,56,0,0,15,31,63,48,32,34,34,62,62,62

;********************************************************************************

BIGFONT72_81
	movlw	241
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableBIGFONT72_81
	movwf	TBLPTRL,ACCESS
	movlw	high TableBIGFONT72_81
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableBIGFONT72_81
	db	240,0,252,252,252,128,128,128,252,252,252,0,0,0,63,63,63,1,1,1,63,63,63,0,0,0,0,4
	db	4,252,252,252,4,4,0,0,0,0,0,32,32,63,63,63,32,32,0,0,0,0,0,0,0,0,4,4,252,252
	db	252,4,4,30,30,62,32,32,32,32,63,63,31,0,0,0,4,252,252,252,192,224,112,60,28,12
	db	0,0,32,63,63,63,3,7,14,60,56,48,0,0,4,252,252,252,4,0,0,0,0,0,0,0,32,63,63,63
	db	32,32,32,48,56,60,0,0,252,252,252,120,240,224,240,120,252,252,252,0,63,63,63,0
	db	0,1,0,0,63,63,63,0,252,252,252,112,224,192,128,0,252,252,252,0,63,63,63,0,0,1,3,7
	db	63,63,63,0,224,240,248,28,12,12,12,28,248,240,224,0,7,15,31,56,48,48,48,56,31,15
	db	7,0,4,252,252,252,132,132,132,252,252,120,0,0,32,63,63,63,33,1,1,1,1,0,0,0,224,248
	db	248,28,12,4,12,28,248,248,224,0,7,31,31,24,24,92,94,126,127,127,71

;********************************************************************************

BIGFONT82_91
	movlw	239
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableBIGFONT82_91
	movwf	TBLPTRL,ACCESS
	movlw	high TableBIGFONT82_91
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableBIGFONT82_91
	db	240,0,4,252,252,252,132,132,132,252,252,120,0,0,32,63,63,63,1,1,3,63,63,60,0,0
	db	120,252,252,132,132,132,132,188,60,56,0,0,28,60,61,36,36,33,33,63,63,30,0,0,28,12
	db	4,4,252,252,252,4,4,12,28,0,0,0,32,32,63,63,63,32,32,0,0,0,252,252,252,0,0,0
	db	252,252,252,0,0,0,31,63,63,32,32,32,63,63,31,0,0,0,252,252,252,0,0,0,252,252
	db	252,0,0,0,7,15,31,56,48,56,31,15,7,0,0,0,252,252,252,0,0,128,0,0,252,252,252,0
	db	3,15,63,60,60,15,60,60,63,15,3,0,28,60,124,224,192,224,124,60,28,0,0,0,56,60,62,7
	db	3,7,62,60,56,0,0,0,124,252,252,128,0,128,252,252,124,0,0,0,0,32,33,63,63,63,33,32
	db	0,0,0,0,60,28,12,4,132,196,228,124,60,28,0,0,56,60,62,39,35,33,32,48,56,60,0,0
	db	0,0,252,252,252,4,4,4,4,0,0,0,0,0,63,63,63,32,32,32,32

;********************************************************************************

BIGFONT92_101
	movlw	239
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableBIGFONT92_101
	movwf	TBLPTRL,ACCESS
	movlw	high TableBIGFONT92_101
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableBIGFONT92_101
	db	240,0,28,56,112,224,192,128,0,0,0,0,0,0,0,0,0,0,1,3,7,14,28,24,48,0,0,0,4,4,4,4
	db	252,252,252,0,0,0,0,0,32,32,32,32,63,63,63,0,0,0,32,48,56,28,14,14,28,56,48,32
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,192,192,192,192,192,192,192
	db	192,192,192,192,192,0,12,12,60,48,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64
	db	64,64,64,64,192,192,128,0,0,0,28,62,62,34,34,34,63,31,63,32,0,0,4,252,252,252
	db	64,64,64,192,192,128,0,0,32,63,31,63,32,32,32,63,63,31,0,0,128,192,192,64,64,64
	db	192,192,128,0,0,0,31,63,63,32,32,32,57,57,25,0,0,0,128,192,192,64,64,68,252,252
	db	252,4,0,0,31,63,63,32,32,32,63,31,63,32,0,0,128,192,192,64,64,64,192,192,128,0
	db	0,0,31,63,63,34,34,34,59,59,27

;********************************************************************************

;Source: string.h (551)
FN_BYTETOBIN
;ByteToBin = ""
	lfsr	1,BYTETOBIN
	movlw	low StringTable98
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable98
	movwf	TBLPTRH,ACCESS
	call	SysReadString
;Repeat 8
	movlw	8
	movwf	SysRepeatTemp6,ACCESS
SysRepeatLoop6
;If ByteNum.7 = 1 Then
	btfss	BYTENUM,7,ACCESS
	bra	ELSE58_1
;ByteToBin = ByteToBin +"1"
	lfsr	1,BYTETOBIN
	clrf	SysStringLength,ACCESS
	lfsr	0,BYTETOBIN
	call	SysCopyStringPart
	movlw	low StringTable99
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable99
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,BYTETOBIN
	movff	SysStringLength, INDF0
;Else
	bra	ENDIF58
ELSE58_1
;ByteToBin = ByteToBin +"0"
	lfsr	1,BYTETOBIN
	clrf	SysStringLength,ACCESS
	lfsr	0,BYTETOBIN
	call	SysCopyStringPart
	movlw	low StringTable66
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable66
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,BYTETOBIN
	movff	SysStringLength, INDF0
;End If
ENDIF58
;Rotate ByteNum Left
	rlcf	BYTENUM,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp6,F,ACCESS
	bra	SysRepeatLoop6
SysRepeatLoopEnd6
	return

;********************************************************************************

;Source: lcd.h (362)
CLS
;Sub to clear the LCD
;SET LCD_RS OFF
	bcf	SYSLCDTEMP,1,ACCESS
;Clear screen
;LCDWriteByte (0b00000001)
	movlw	1
	movwf	LCDBYTE,ACCESS
	call	LCDNORMALWRITEBYTE
;Wait 4 ms
	movlw	4
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Move to start of visible DDRAM
;LCDWriteByte(0x80)
	movlw	128
	movwf	LCDBYTE,ACCESS
	call	LCDNORMALWRITEBYTE
;Wait 50 us
	movlw	200
	movwf	DELAYTEMP,ACCESS
DelayUS1
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS1
	return

;********************************************************************************

;Source: glcd.h (4316)
DRAWBIGCHAR
;Dim LocX , LocY as Word
;if CharCode <=126 Then
	movf	CHARCODE,W,ACCESS
	sublw	126
	btfss	STATUS, C,ACCESS
	bra	ENDIF13
;CharCode -=32
	movlw	32
	subwf	CHARCODE,F,ACCESS
;Goto Tables
	bra	TABLES
;end if
ENDIF13
;if CharCode <=210 Then
	movf	CHARCODE,W,ACCESS
	sublw	210
	btfss	STATUS, C,ACCESS
	bra	ENDIF14
;CharCode -=33
	movlw	33
	subwf	CHARCODE,F,ACCESS
;Goto Tables
	bra	TABLES
;end if
ENDIF14
;if CharCode <= 250 Then
	movf	CHARCODE,W,ACCESS
	sublw	250
	btfss	STATUS, C,ACCESS
	bra	ENDIF15
;CharCode -=34
	movlw	34
	subwf	CHARCODE,F,ACCESS
;Goto Tables
	bra	TABLES
;end if
ENDIF15
TABLES
;For CurrCharCol = 1 to 24
	clrf	CURRCHARCOL,ACCESS
SysForLoop2
	incf	CURRCHARCOL,F,ACCESS
;CurrCol=CurrCharCol+CharCode*24-(CharCode/10)*240
	movff	CHARCODE,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SysDivSub
	movff	SysBYTETempA,SysTemp1
	movf	CHARCODE,W,ACCESS
	mullw	24
	movff	PRODL,SysTemp2
	movf	SysTemp1,W,ACCESS
	mullw	240
	movf	SysTemp2,W,ACCESS
	addwf	CURRCHARCOL,W,ACCESS
	movwf	SysTemp1,ACCESS
	movf	PRODL,W,ACCESS
	subwf	SysTemp1,W,ACCESS
	movwf	CURRCOL,ACCESS
;if CharCode>=0 and CharCode<=9 then ReadTable BigFont32_41 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	9
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ENDIF16
	movff	CURRCOL,SYSSTRINGA
	call	BIGFONT32_41
	movwf	CURRCHARVAL,ACCESS
ENDIF16
;if CharCode>=10 and CharCode<=19 then ReadTable BigFont42_51 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	19
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ENDIF17
	movff	CURRCOL,SYSSTRINGA
	rcall	BIGFONT42_51
	movwf	CURRCHARVAL,ACCESS
ENDIF17
;if CharCode>=20 and CharCode<=29 then ReadTable BigFont52_61 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	20
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	29
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ENDIF18
	movff	CURRCOL,SYSSTRINGA
	rcall	BIGFONT52_61
	movwf	CURRCHARVAL,ACCESS
ENDIF18
;if CharCode>=30 and CharCode<=39 then ReadTable BigFont62_71 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	30
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	39
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ENDIF19
	movff	CURRCOL,SYSSTRINGA
	rcall	BIGFONT62_71
	movwf	CURRCHARVAL,ACCESS
ENDIF19
;if CharCode>=40 and CharCode<=49 then ReadTable BigFont72_81 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	40
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	49
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ENDIF20
	movff	CURRCOL,SYSSTRINGA
	rcall	BIGFONT72_81
	movwf	CURRCHARVAL,ACCESS
ENDIF20
;if CharCode>=50 and CharCode<=59 then ReadTable BigFont82_91 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	50
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	59
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ENDIF21
	movff	CURRCOL,SYSSTRINGA
	rcall	BIGFONT82_91
	movwf	CURRCHARVAL,ACCESS
ENDIF21
;if CharCode>=60 and CharCode<=69 then ReadTable BigFont92_101 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	60
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	69
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ENDIF22
	movff	CURRCOL,SYSSTRINGA
	rcall	BIGFONT92_101
	movwf	CURRCHARVAL,ACCESS
ENDIF22
;if CharCode>=70 and CharCode<=79 then ReadTable BigFont102_111 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	70
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	79
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ENDIF23
	movff	CURRCOL,SYSSTRINGA
	call	BIGFONT102_111
	movwf	CURRCHARVAL,ACCESS
ENDIF23
;if CharCode>=80 and CharCode<=89 then ReadTable BigFont112_121 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	80
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	89
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ENDIF24
	movff	CURRCOL,SYSSTRINGA
	call	BIGFONT112_121
	movwf	CURRCHARVAL,ACCESS
ENDIF24
;if CharCode>=90 and CharCode<=99 then ReadTable BigFont122_126 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	90
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	99
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ENDIF25
	movff	CURRCOL,SYSSTRINGA
	call	BIGFONT122_126
	movwf	CURRCHARVAL,ACCESS
ENDIF25
;if CharCode>=160 and CharCode<=169 then ReadTable BigFont193_202 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	160
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	169
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ENDIF26
	movff	CURRCOL,SYSSTRINGA
	call	BIGFONT193_202
	movwf	CURRCHARVAL,ACCESS
ENDIF26
;if CharCode>=170 and CharCode<=179 then ReadTable BigFont203_212 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	170
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	179
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ENDIF27
	movff	CURRCOL,SYSSTRINGA
	call	BIGFONT203_212
	movwf	CURRCHARVAL,ACCESS
ENDIF27
;if CharCode>=180 and CharCode<=183 then ReadTable BigFont213_216 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	180
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	183
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ENDIF28
	movff	CURRCOL,SYSSTRINGA
	call	BIGFONT213_216
	movwf	CURRCHARVAL,ACCESS
ENDIF28
;if CurrCharVal=36 then CurrCharVal=33
	movlw	36
	subwf	CURRCHARVAL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF29
	movlw	33
	movwf	CURRCHARVAL,ACCESS
ENDIF29
;For CurrCharRow = 1 to 8
	clrf	CURRCHARROW,ACCESS
SysForLoop3
	incf	CURRCHARROW,F,ACCESS
;LocX=[word]CharLocX+CurrCharCol
	movf	CURRCHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	LOCX,ACCESS
	movlw	0
	addwfc	CHARLOCX_H,W,ACCESS
	movwf	LOCX_H,ACCESS
;LocY=[word]CharLocY+CurrCharRow
	movf	CURRCHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	LOCY,ACCESS
	movlw	0
	addwfc	CHARLOCY_H,W,ACCESS
	movwf	LOCY_H,ACCESS
;if CurrCharCol>12 then
	movf	CURRCHARCOL,W,ACCESS
	sublw	12
	btfsc	STATUS, C,ACCESS
	bra	ENDIF30
;LocX= LocX - 12
	movlw	12
	subwf	LOCX,F,ACCESS
	movlw	0
	subwfb	LOCX_H,F,ACCESS
;LocY= LocY + 8
	movlw	8
	addwf	LOCY,F,ACCESS
	movlw	0
	addwfc	LOCY_H,F,ACCESS
;end if
ENDIF30
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0,ACCESS
	bra	ELSE31_1
;PSet LocX , LocY , Color
	movff	LOCX,GLCDX
	movff	LOCY,GLCDY
	movff	COLOR,GLCDCOLOUR
	movff	COLOR_H,GLCDCOLOUR_H
	rcall	PSET_ST7735R
;else
	bra	ENDIF31
ELSE31_1
;PSet LocX , LocY , GLCDBackground
	movff	LOCX,GLCDX
	movff	LOCY,GLCDY
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	rcall	PSET_ST7735R
;end if
ENDIF31
;Rotate CurrCharVal Right
	rrcf	CURRCHARVAL,F,ACCESS
;Next
	movlw	8
	subwf	CURRCHARROW,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;Next
	movlw	24
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
	return

;********************************************************************************

Delay_10US
D10US_START
	movlw	39
	movwf	DELAYTEMP,ACCESS
DelayUS0
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS0
	decfsz	SysWaitTemp10US, F,ACCESS
	bra	D10US_START
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

;Source: glcd_st7735.h (602)
GLCDCLS_ST7735
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE,ACCESS
	clrf	GLCD_YORDINATE_H,ACCESS
;Dim PrintLocX, PrintLocY as word
;PrintLocX = 0
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
;PrintLocY = 0
	clrf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,ACCESS
;SetAddress_ST7735 ST7735_COLUMN, 0, GLCDDeviceWidth
	movlw	42
	movwf	ST7735ADDRESSTYPE,ACCESS
	clrf	ST7735START,ACCESS
	clrf	ST7735START_H,ACCESS
	movff	GLCDDEVICEWIDTH,ST7735END
	movff	GLCDDEVICEWIDTH_H,ST7735END_H
	rcall	SETADDRESS_ST7735
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SetAddress_ST7735 ST7735_ROW, 0, GLCDDeviceHeight
	movlw	43
	movwf	ST7735ADDRESSTYPE,ACCESS
	clrf	ST7735START,ACCESS
	clrf	ST7735START_H,ACCESS
	movff	GLCDDEVICEHEIGHT,ST7735END
	movff	GLCDDEVICEHEIGHT_H,ST7735END_H
	rcall	SETADDRESS_ST7735
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_ST7735 ST7735_RAMWR
	movlw	44
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Repeat [word] GLCD_WIDTH * GLCD_HEIGHT
	clrf	SYSREPEATTEMP1,ACCESS
	movlw	50
	movwf	SYSREPEATTEMP1_H,ACCESS
	movff	SYSREPEATTEMP1,SysWORDTempA
	movff	SYSREPEATTEMP1_H,SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysRepeatLoopEnd1
	movf	SYSREPEATTEMP1,F,ACCESS
	btfss	STATUS, Z,ACCESS
	incf	SysRepeatTemp1_H,F,ACCESS
SysRepeatLoop1
;SendWord_ST7735 GLCDBackground
	movff	GLCDBACKGROUND,ST7735SENDWORD
	movff	GLCDBACKGROUND_H,ST7735SENDWORD_H
	rcall	SENDWORD_ST7735
;End Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop1
	decfsz	SysRepeatTemp1_H,F,ACCESS
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
	return

;********************************************************************************

;Source: glcd.h (4303)
GLCDPRINTLARGEFONT
;Ported from SSD1289 library to break the dependency on the SSD1289 library
;Dim GLCDPrintLoc as Word
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen = 0 Then Exit Sub
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	return
;GLCDPrintLoc = PrintLocX
	movff	PRINTLOCX,GLCDPRINTLOC
	movff	PRINTLOCX_H,GLCDPRINTLOC_H
;For SysPrintTemp = 1 To PrintLen
	clrf	SYSPRINTTEMP,ACCESS
	movlw	1
	subwf	PRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd1
SysForLoop1
	incf	SYSPRINTTEMP,F,ACCESS
;DrawBigChar GLCDPrintLoc, PrintLocY, PrintData(SysPrintTemp), Color
	movff	GLCDPRINTLOC,CHARLOCX
	movff	GLCDPRINTLOC_H,CHARLOCX_H
	movff	PRINTLOCY,CHARLOCY
	movff	PRINTLOCY_H,CHARLOCY_H
	movf	SYSPRINTTEMP,W,ACCESS
	addwf	SysPRINTDATAHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	INDF0,CHARCODE
	rcall	DRAWBIGCHAR
;GLCDPrintLoc += 13
	movlw	13
	addwf	GLCDPRINTLOC,F,ACCESS
	movlw	0
	addwfc	GLCDPRINTLOC_H,F,ACCESS
;Next
	movf	PRINTLEN,W,ACCESS
	subwf	SYSPRINTTEMP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
	return

;********************************************************************************

;Source: glcd_st7735.h (1060)
GLCDROTATE_ST7735
;SendCommand_ST7735 ( ST7735_MADCTL )
	movlw	54
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;select case GLCDRotateState
;case LANDSCAPE
SysSelect1Case1
	decf	GLCDROTATESTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;IF ST7735TABCOLOR = ST7735_BLACKTAB or ST7735TABCOLOR = ST7735_MINI160x80 or GLCD_TYPE = GLCD_TYPE_ST7735R_160_80 then
;SendData_ST7735( ST7735_MADCTL_MX | ST7735_MADCTL_MV |  ST7735_MADCTL_RGB )
	movlw	96
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;else
;GLCDDeviceWidth = GLCD_HEIGHT - 1
	movlw	159
	movwf	GLCDDEVICEWIDTH,ACCESS
	clrf	GLCDDEVICEWIDTH_H,ACCESS
;GLCDDeviceHeight = GLCD_WIDTH - 1
	movlw	79
	movwf	GLCDDEVICEHEIGHT,ACCESS
	clrf	GLCDDEVICEHEIGHT_H,ACCESS
;case PORTRAIT_REV
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	GLCDROTATESTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;GLCDDeviceWidth = GLCD_WIDTH - 1
	movlw	79
	movwf	GLCDDEVICEWIDTH,ACCESS
	clrf	GLCDDEVICEWIDTH_H,ACCESS
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	159
	movwf	GLCDDEVICEHEIGHT,ACCESS
	clrf	GLCDDEVICEHEIGHT_H,ACCESS
;IF ST7735TABCOLOR = ST7735_BLACKTAB or ST7735TABCOLOR = ST7735_MINI160x80 or GLCD_TYPE = GLCD_TYPE_ST7735R_160_80 then
;SendData_ST7735( ST7735_MADCTL_RGB )
	clrf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;else
;case LANDSCAPE_REV
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	GLCDROTATESTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;IF ST7735TABCOLOR = ST7735_BLACKTAB or ST7735TABCOLOR = ST7735_MINI160x80 or GLCD_TYPE = GLCD_TYPE_ST7735R_160_80 then
;SendData_ST7735( ST7735_MADCTL_MV | ST7735_MADCTL_MY | ST7735_MADCTL_RGB )
	movlw	160
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;else
;GLCDDeviceWidth = GLCD_HEIGHT - 1
	movlw	159
	movwf	GLCDDEVICEWIDTH,ACCESS
	clrf	GLCDDEVICEWIDTH_H,ACCESS
;GLCDDeviceHeight = GLCD_WIDTH - 1
	movlw	79
	movwf	GLCDDEVICEHEIGHT,ACCESS
	clrf	GLCDDEVICEHEIGHT_H,ACCESS
;case PORTRAIT
	bra	SysSelectEnd1
SysSelect1Case4
	movlw	4
	subwf	GLCDROTATESTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case5
;GLCDDeviceWidth = GLCD_WIDTH - 1
	movlw	79
	movwf	GLCDDEVICEWIDTH,ACCESS
	clrf	GLCDDEVICEWIDTH_H,ACCESS
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	159
	movwf	GLCDDEVICEHEIGHT,ACCESS
	clrf	GLCDDEVICEHEIGHT_H,ACCESS
;IF ST7735TABCOLOR = ST7735_BLACKTAB or ST7735TABCOLOR = ST7735_MINI160x80 or GLCD_TYPE = GLCD_TYPE_ST7735R_160_80 then
;SendData_ST7735( ST7735_MADCTL_MX | ST7735_MADCTL_MY | ST7735_MADCTL_RGB )
	movlw	192
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;else
;case else
	bra	SysSelectEnd1
SysSelect1Case5
;GLCDDeviceWidth = GLCD_WIDTH - 1
	movlw	79
	movwf	GLCDDEVICEWIDTH,ACCESS
	clrf	GLCDDEVICEWIDTH_H,ACCESS
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	159
	movwf	GLCDDEVICEHEIGHT,ACCESS
	clrf	GLCDDEVICEHEIGHT_H,ACCESS
;IF ST7735TABCOLOR = ST7735_BLACKTAB or ST7735TABCOLOR = ST7735_MINI160x80 or GLCD_TYPE = GLCD_TYPE_ST7735R_160_80 then
;SendData_ST7735( ST7735_MADCTL_MX | ST7735_MADCTL_MY | ST7735_MADCTL_RGB )
	movlw	192
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;else
;end select
SysSelectEnd1
	return

;********************************************************************************

;Source: hwi2c.h (246)
HI2CMODE
;asm showdebug  This method sets the variable `HI2CCurrentMode`, and, if required, sets the SSPCON1.bits
;this method sets the variable `hi2ccurrentmode`, &, if required, sets the sspcon1.bits
;#ifdef var(SSPCON1) added to separate from newer i2C module which does not have an SSPCON1
;set SSPSTAT.SMP on
	bsf	SSPSTAT,SMP,ACCESS
;set SSPCON1.CKP on
	bsf	SSPCON1,CKP,ACCESS
;set SSPCON1.WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;Select mode and clock
;If HI2CCurrentMode = Master Then
	movlw	12
	subwf	HI2CCURRENTMODE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF59
;set SSPCON1.SSPM3 on
	bsf	SSPCON1,SSPM3,ACCESS
;set SSPCON1.SSPM2 off
	bcf	SSPCON1,SSPM2,ACCESS
;set SSPCON1.SSPM1 off
	bcf	SSPCON1,SSPM1,ACCESS
;set SSPCON1.SSPM0 off
	bcf	SSPCON1,SSPM0,ACCESS
;SSPADD = HI2C_BAUD_TEMP and 127
	movlw	119
	movwf	SSPADD,ACCESS
;end if
ENDIF59
;if HI2CCurrentMode = Slave then
	movf	HI2CCURRENTMODE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF60
;set SSPCON1.SSPM3 off
	bcf	SSPCON1,SSPM3,ACCESS
;set SSPCON1.SSPM2 on
	bsf	SSPCON1,SSPM2,ACCESS
;set SSPCON1.SSPM1 on
	bsf	SSPCON1,SSPM1,ACCESS
;set SSPCON1.SSPM0 off
	bcf	SSPCON1,SSPM0,ACCESS
;end if
ENDIF60
;if HI2CCurrentMode = Slave10 then
	movlw	3
	subwf	HI2CCURRENTMODE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF61
;set SSPCON1.SSPM3 off
	bcf	SSPCON1,SSPM3,ACCESS
;set SSPCON1.SSPM2 on
	bsf	SSPCON1,SSPM2,ACCESS
;set SSPCON1.SSPM1 on
	bsf	SSPCON1,SSPM1,ACCESS
;set SSPCON1.SSPM0 on
	bsf	SSPCON1,SSPM0,ACCESS
;end if
ENDIF61
;Enable I2C
;set SSPCON1.SSPEN on
	bsf	SSPCON1,SSPEN,ACCESS
	return

;********************************************************************************

;Source: hwi2c.h (441)
HI2CRECEIVE
;Enable receive
;Master_mode
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ELSE69_1
;if HI2CGetAck.0 = 1 then
	btfss	HI2CGETACK,0,ACCESS
	bra	ELSE71_1
;Acknowledge
;ACKDT = 0
	bcf	SSPCON2,ACKDT,ACCESS
;else
	bra	ENDIF71
ELSE71_1
;Not Acknowledge
;ACKDT = 1
	bsf	SSPCON2,ACKDT,ACCESS
;end if
ENDIF71
;RCEN = 1
	bsf	SSPCON2,RCEN,ACCESS
;Slave mode
;Else
	bra	ENDIF69
ELSE69_1
;SET SSPSTAT.R_NOT_W ON
	bsf	SSPSTAT,R_NOT_W,ACCESS
;End If
ENDIF69
;Clear Collisions
;SET SSPCON1.WCOL OFF
	bcf	SSPCON1,WCOL,ACCESS
;SET SSPCON1.SSPOV Off
	bcf	SSPCON1,SSPOV,ACCESS
;Wait for receive
;Wait Until SSPSTAT.BF = 1 AND SSPIF = 1
SysWaitLoop4
	clrf	SysByteTempX,ACCESS
	btfsc	SSPSTAT,BF,ACCESS
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	clrf	SysByteTempX,ACCESS
	btfsc	PIR1,SSPIF,ACCESS
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	SysWaitLoop4
;I2CByte = SSPBUF
	movff	SSPBUF,I2CBYTE
;SSPIF = 0''Support for SSPIF
	bcf	PIR1,SSPIF,ACCESS
;ACKEN = 1; Send ACK DATA now. ' bsf SSPCON2,ACKEN
	bsf	SSPCON2,ACKEN,ACCESS
;Clear flag - this is required
;SSPSTAT.BF = 0
	bcf	SSPSTAT,BF,ACCESS
;HI2CWaitMSSP
	rcall	HI2CWAITMSSP
;Disable receive (Master_mode)
;Master_mode
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ELSE70_1
;Set SSPCON2.RCEN Off
	bcf	SSPCON2,RCEN,ACCESS
;Slave mode
;Else
	bra	ENDIF70
ELSE70_1
;SET SSPSTAT.R_NOT_W Off
	bcf	SSPSTAT,R_NOT_W,ACCESS
;End If
ENDIF70
	return

;********************************************************************************

;Source: hwi2c.h (331)
HI2CRESTART
;asm showdebug  This method sets the registers and register bits to generate the I2C  RESTART signal
;this method sets the registers & register bits to generate the i2c restart signal
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ENDIF63
;Master_mode operational
;Set RSEN On
	bsf	SSPCON2,RSEN,ACCESS
;HI2CWaitMSSP
	rcall	HI2CWAITMSSP
;End If
ENDIF63
	return

;********************************************************************************

;Source: hwi2c.h (413)
HI2CSEND
;asm showdebug  This method sets the registers and register bits to send I2C data
;this method sets the registers & register bits to send i2c data
RETRYHI2CSEND
;Clear WCOL
;SET SSPCON1.WCOL OFF
	bcf	SSPCON1,WCOL,ACCESS
;Load data to send
;SSPBUF = I2CByte
	movff	I2CBYTE,SSPBUF
;HI2CWaitMSSP
	rcall	HI2CWAITMSSP
;if ACKSTAT =  1 then
	btfss	SSPCON2,ACKSTAT,ACCESS
	bra	ELSE65_1
;HI2CAckPollState = true
	setf	HI2CACKPOLLSTATE,ACCESS
;else
	bra	ENDIF65
ELSE65_1
;HI2CAckPollState = false
	clrf	HI2CACKPOLLSTATE,ACCESS
;end if
ENDIF65
;If SSPCON1.WCOL = On Then
	btfss	SSPCON1,WCOL,ACCESS
	bra	ENDIF66
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	RETRYHI2CSEND
;End If
ENDIF66
;Release clock (only needed by slave)
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bsf	SSPCON1,CKP,ACCESS
	return

;********************************************************************************

;Source: hwi2c.h (301)
HI2CSTART
;asm showdebug  This method sets the registers and register bits to generate the I2C  START signal
;this method sets the registers & register bits to generate the i2c start signal
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ELSE62_1
;Master_mode operational
;Set SEN On
	bsf	SSPCON2,SEN,ACCESS
;HI2CWaitMSSP
	rcall	HI2CWAITMSSP
;for device with SEN_SSP1CON2 and therefore devices including the 18FxxK40
;Else
	bra	ENDIF62
ELSE62_1
;Slave mode operational
;Wait Until SSPSTAT.S = On
SysWaitLoop1
	btfss	SSPSTAT,S,ACCESS
	bra	SysWaitLoop1
;End If
ENDIF62
	return

;********************************************************************************

;Source: hwi2c.h (348)
HI2CSTOP
;Master_mode
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ELSE64_1
;set SSPIE OFF; disable SSP interrupt, tested by Anobium but not implemented.
;wait while R_NOT_W = 1   'wait for completion of activities
SysWaitLoop2
	btfsc	SSPSTAT,R_NOT_W,ACCESS
	bra	SysWaitLoop2
;Set SSPCON2.PEN On
	bsf	SSPCON2,PEN,ACCESS
;HI2CWaitMSSP
	rcall	HI2CWAITMSSP
;Slave mode
;Else
	bra	ENDIF64
ELSE64_1
;Wait Until SSPSTAT.P = On
SysWaitLoop3
	btfss	SSPSTAT,P,ACCESS
	bra	SysWaitLoop3
;End If
ENDIF64
	return

;********************************************************************************

;Source: hwi2c.h (499)
HI2CWAITMSSP
;HI2CWaitMSSPTimeout = 0
	clrf	HI2CWAITMSSPTIMEOUT,ACCESS
HI2CWAITMSSPWAIT
;HI2CWaitMSSPTimeout++
	incf	HI2CWAITMSSPTIMEOUT,F,ACCESS
;if HI2CWaitMSSPTimeout < 255 then
	movlw	255
	subwf	HI2CWAITMSSPTIMEOUT,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF72
;'Support for SSP1IF
;if SSP1IF = 0 then goto HI2CWaitMSSPWait
	btfss	PIR1,SSPIF,ACCESS
	bra	HI2CWAITMSSPWAIT
;SSP1IF = 0
	bcf	PIR1,SSPIF,ACCESS
;exit Sub
	return
;'Support for SSPIF
;if SSPIF = 0 then goto HI2CWaitMSSPWait
	btfss	PIR1,SSPIF,ACCESS
	bra	HI2CWAITMSSPWAIT
;SSPIF = 0
	bcf	PIR1,SSPIF,ACCESS
;exit Sub
	return
;end if
ENDIF72
	return

;********************************************************************************

;Source: hwi2c.h (695)
HIC2INIT
;asm showdebug  This method sets the variable `HI2CCurrentMode`, and, if required calls the method `SI2CInit` to set up new MSSP modules - aka K42s family chips
;this method sets the variable `hi2ccurrentmode`, &, if required calls the method `si2cinit` to set up new mssp modules - aka k42s family chips
;HI2CCurrentMode = 0
	clrf	HI2CCURRENTMODE,ACCESS
;Initialise the I2C module
	return

;********************************************************************************

;Source: glcd_st7735.h (238)
INITGLCD_ST7735
;This method is called when the about GLCD types are selected.
;Why? This is a shared library and therefore this INIT is called, but, this will be empty. Cannot avoid this.
	return

;********************************************************************************

;Source: glcd_st7735r.h (54)
INITGLCD_ST7735R
;Setup code for GLCD_TYPE_ST7735R  or GLCD_TYPE_ST7735R_160_80
;mapped to global variable
;dim GLCDDeviceWidth, GLCDDeviceHeight as byte
;dim GLCDForeground, GLCDBackground as word
;Pin directions
;Dir ST7735_CS Out
	bcf	TRISB,2,ACCESS
;Dir ST7735_DC Out
	bcf	TRISE,2,ACCESS
;Dir ST7735_RST Out
	bcf	TRISC,6,ACCESS
;Dir ST7735_DO Out
	bcf	TRISC,7,ACCESS
;Dir ST7735_SCK Out
	bcf	TRISD,7,ACCESS
;Reset display
;Set ST7735_RST On
	bsf	LATC,6,ACCESS
;Wait 150 ms
	movlw	150
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Reset sequence (lower line for at least 10 us)
;Set ST7735_RST Off
	bcf	LATC,6,ACCESS
;Wait 150 us
	movlw	2
	movwf	DELAYTEMP2,ACCESS
DelayUSO2
	clrf	DELAYTEMP,ACCESS
DelayUS2
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS2
	decfsz	DELAYTEMP2,F,ACCESS
	bra	DelayUSO2
	movlw	85
	movwf	DELAYTEMP,ACCESS
DelayUS3
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS3
	nop
;Set ST7735_RST On
	bsf	LATC,6,ACCESS
;Wait 150 ms
	movlw	150
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Software reset
;SendCommand_ST7735 ST7735_SWRESET
	movlw	1
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;Wait 150 ms
	movlw	150
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Software reset
;SendCommand_ST7735 ST7735_SWRESET
	movlw	1
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;Wait 150 ms
	movlw	150
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Out of sleep mode
;SendCommand_ST7735 ST7735_SLPOUT
	movlw	17
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;Wait 1 s
	movlw	1
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;asm showdebug _GLCD_TYPE_ST7735R_160_80
;_glcd_type_st7735r_160_80
;SendCommand_ST7735(ST7735_FRMCTR1)
	movlw	177
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;SendData_ST7735(0x01)
	movlw	1
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x2C)
	movlw	44
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x2D)
	movlw	45
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;Wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_ST7735(ST7735_FRMCTR2)
	movlw	178
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;SendData_ST7735(0x01)
	movlw	1
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x2C)
	movlw	44
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x2D)
	movlw	45
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;Wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_ST7735(ST7735_FRMCTR3)
	movlw	179
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;SendData_ST7735(0x01)
	movlw	1
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x2C)
	movlw	44
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x2D)
	movlw	45
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x01)
	movlw	1
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x2C)
	movlw	44
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x2D)
	movlw	45
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;Wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_ST7735(ST7735_INVCTR)
	movlw	180
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;SendData_ST7735(0x07)
	movlw	7
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;wait 10 ms;
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_ST7735(ST7735_PWCTR1)
	movlw	192
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;SendData_ST7735(0xA2)
	movlw	162
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x02)
	movlw	2
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x84)
	movlw	132
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;wait 10 ms;
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_ST7735(ST7735_PWCTR2)
	movlw	193
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;SendData_ST7735(0xC5)
	movlw	197
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;wait 10 ms;
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_ST7735(ST7735_PWCTR3)
	movlw	194
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;SendData_ST7735(0x0A)
	movlw	10
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x00)
	clrf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;wait 10 ms;
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_ST7735(ST7735_PWCTR4)
	movlw	195
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;SendData_ST7735(0x8A)
	movlw	138
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x2A)
	movlw	42
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;wait 10 ms;
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_ST7735(ST7735_PWCTR5)
	movlw	196
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;SendData_ST7735(0x8A)
	movlw	138
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0xEE)
	movlw	238
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;wait 10 ms;
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_ST7735(ST7735_VMCTR1)
	movlw	197
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;SendData_ST7735(0x0E)
	movlw	14
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;wait 10 ms;
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_ST7735(ST7735_INVOFF)
	movlw	32
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;wait 10 ms;
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_ST7735(ST7735_MADCTL)
	movlw	54
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;SendData_ST7735(0xC8)     'row address/col address, bottom to top refresh/GBR.
	movlw	200
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;wait 20 ms
	movlw	20
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_ST7735(ST7735_COLMOD)
	movlw	58
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;SendData_ST7735(0x05)
	movlw	5
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendCommand_ST7735(ST7735_CASET)
	movlw	42
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;GreenTab
;SendData_ST7735(0x00)
	clrf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x00+ST7735_CASET_ADJUSTMENT)
	clrf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x00)
	clrf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(GLCD_WIDTH -1 +ST7735_CASET_ADJUSTMENT)
	movlw	79
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;wait 20 ms
	movlw	20
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_ST7735(ST7735_RASET)
	movlw	43
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;GreenTab
;SendData_ST7735(0x00)
	clrf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x00+ST7735_RASET_ADJUSTMENT)
	clrf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x00)
	clrf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(GLCD_HEIGHT -1 +ST7735_RASET_ADJUSTMENT)
	movlw	159
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;wait 20 ms
	movlw	20
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_ST7735(ST7735_GMCTRP1)
	movlw	224
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;SendData_ST7735(0x02)
	movlw	2
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x1c)
	movlw	28
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x07)
	movlw	7
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x12)
	movlw	18
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x37)
	movlw	55
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x32)
	movlw	50
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x29)
	movlw	41
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x2d)
	movlw	45
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x29)
	movlw	41
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x25)
	movlw	37
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x2b)
	movlw	43
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x39)
	movlw	57
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x00)
	clrf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x01)
	movlw	1
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x03)
	movlw	3
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x10)
	movlw	16
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SendCommand_ST7735(ST7735_GMCTRN1)
	movlw	225
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;SendData_ST7735(0x03)
	movlw	3
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x1d)
	movlw	29
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x07)
	movlw	7
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x06)
	movlw	6
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x2e)
	movlw	46
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x2c)
	movlw	44
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x29)
	movlw	41
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x2d)
	movlw	45
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x2e)
	movlw	46
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x2e)
	movlw	46
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x37)
	movlw	55
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x37)
	movlw	55
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x00)
	clrf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x00)
	clrf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x02)
	movlw	2
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;SendData_ST7735(0x10)
	movlw	16
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDDATA_ST7735
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Display on
;SendCommand_ST7735 ST7735_NORON
	movlw	19
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;Wait 100 ms
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Display on
;SendCommand_ST7735 ST7735_DISPON
	movlw	41
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;Wait 100 ms
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Colours
;GLCDForeground = TFT_WHITE
	setf	GLCDFOREGROUND,ACCESS
	setf	GLCDFOREGROUND_H,ACCESS
;Default Colours
;GLCDBackground = TFT_BLACK
	clrf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
;Variables required for device
;GLCDDeviceWidth = GLCD_WIDTH - 1
	movlw	79
	movwf	GLCDDEVICEWIDTH,ACCESS
	clrf	GLCDDEVICEWIDTH_H,ACCESS
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	159
	movwf	GLCDDEVICEHEIGHT,ACCESS
	clrf	GLCDDEVICEHEIGHT_H,ACCESS
;GLCDFontWidth = 6
	movlw	6
	movwf	GLCDFONTWIDTH,ACCESS
;GLCDfntDefault = 0
	clrf	GLCDFNTDEFAULT,ACCESS
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDfntDefaultHeight = 8
	movlw	8
	movwf	GLCDFNTDEFAULTHEIGHT,ACCESS
;GLCDRotate ( Landscape )
	movlw	1
	movwf	GLCDROTATESTATE,ACCESS
	rcall	GLCDROTATE_ST7735
;Clear screen
;GLCDCLS
	bra	GLCDCLS_ST7735

;********************************************************************************

;Source: lcd.h (435)
INITLCD
;asm showdebug  `LCD_IO selected is ` LCD_IO
;`lcd_io selected is ` 2
;asm showdebug  `LCD_Speed is SLOW`
;`lcd_speed is slow`
;asm showdebug  `OPTIMAL is set to ` OPTIMAL
;`optimal is set to ` 0
;asm showdebug  `LCD_Speed is set to ` LCD_Speed
;`lcd_speed is set to ` 100
;All 2-wire modes
;SET LCD_DB OFF
	bcf	LATE,0,ACCESS
;SET LCD_CB OFF
	bcf	LATE,1,ACCESS
;DIR LCD_DB OUT
	bcf	TRISE,0,ACCESS
;DIR LCD_CB OUT
	bcf	TRISE,1,ACCESS
;LCDBacklight Off  'Prevents compiler error if LCDbacklight is not used user code
	clrf	LCDTEMP,ACCESS
	rcall	LCDBACKLIGHT
;WAIT 35 MS
	movlw	35
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SET LCD_RS OFF
	bcf	SYSLCDTEMP,1,ACCESS
;LCD2_NIBBLEOUT 0X03
	movlw	3
	movwf	LCD2BYTE,ACCESS
	rcall	LCD2_NIBBLEOUT
;Wait 5 ms
	movlw	5
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;LCD2_NIBBLEOUT 0X03
	movlw	3
	movwf	LCD2BYTE,ACCESS
	rcall	LCD2_NIBBLEOUT
;WAIT 1 MS
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;LCD2_NIBBLEOUT 0X03
	movlw	3
	movwf	LCD2BYTE,ACCESS
	rcall	LCD2_NIBBLEOUT
;WAIT 1 MS
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;LCD2_NIBBLEOUT 0X02
	movlw	2
	movwf	LCD2BYTE,ACCESS
	rcall	LCD2_NIBBLEOUT
;WAIT 1 MS
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;LCDWriteByte 0x28
	movlw	40
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
;WAIT 1 MS
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;LCDWriteByte 0x08
	movlw	8
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
;WAIT 1 MS
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;LCDWriteByte 0x01
	movlw	1
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
;WAIT 5 MS
	movlw	5
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;LCDWriteByte 0x06
	movlw	6
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
;WAIT 1 MS
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;LCDWriteByte 0x0C
	movlw	12
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
;WAIT 1 MS
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;LCD_State = 12
	movlw	12
	movwf	LCD_STATE,ACCESS
	return

;********************************************************************************

;Source: system.h (111)
INITSYS
;asm showdebug _For_selected_frequency_-_the_external_oscillator_has_been_selected_by_compiler ChipMHz
;_for_selected_frequency_-_the_external_oscillator_has_been_selected_by_compiler 48
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;_complete_the_chip_setup_of_bsr,adcs,ansel_and_other_key_setup_registers_or_register_bits
;Clear BSR on ChipFamily16 MCUs
;BSR = 0
	clrf	BSR,ACCESS
;Clear TBLPTRU on MCUs with this bit as this must be zero
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	bcf	ADCON2,ADFM,ACCESS
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,ACCESS
;SET PCFG3 ON
	bsf	ADCON1,PCFG3,ACCESS
;SET PCFG2 ON
	bsf	ADCON1,PCFG2,ACCESS
;SET PCFG1 ON
	bsf	ADCON1,PCFG1,ACCESS
;SET PCFG0 ON
	bsf	ADCON1,PCFG0,ACCESS
;Commence clearing any ANSELx variants in the part, if the ANSEL regsier/bit exists
;End  clearing ANSEL
;Turn off comparator - this is the default setting
;CMCON = 7
	movlw	7
	movwf	CMCON,ACCESS
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
	return

;********************************************************************************

;Source: lcd.h (1279)
LCD2_NIBBLEOUT
;Sub to send byte in two nibbles to LCD
;2-wire modes with Shiftreg
;Set Data and Clock bits off
;SET LCD_DB OFF
	bcf	LATE,0,ACCESS
;SET LCD_CB OFF
	bcf	LATE,1,ACCESS
;This is mode with 74LS174 or  74HC164 with diode connected to pin 11
;Backilight not supported
;Clear Shift Register With six zero's
;REPEAT 6
	movlw	6
	movwf	SysRepeatTemp4,ACCESS
SysRepeatLoop4
;STROBE
;SET LCD_CB ON
	bsf	LATE,1,ACCESS
;SET LCD_CB OFF
	bcf	LATE,1,ACCESS
;END REPEAT
	decfsz	SysRepeatTemp4,F,ACCESS
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
;First bit out to Shift register, always 1 for E gate LCD
;SET LCD_DB ON
	bsf	LATE,0,ACCESS
;STROBE
;SET LCD_CB ON
	bsf	LATE,1,ACCESS
;SET LCD_CB OFF
	bcf	LATE,1,ACCESS
;SET LCD_DB ON
	bsf	LATE,0,ACCESS
;Shift register (QE), R/S gate LCD
;IF LCD_RS OFF THEN SET LCD_DB OFF
	btfss	SYSLCDTEMP,1,ACCESS
	bcf	LATE,0,ACCESS
;Strobe
;SET LCD_CB ON
	bsf	LATE,1,ACCESS
;SET LCD_CB OFF
	bcf	LATE,1,ACCESS
;4 bits Data (QD - QA) out to Shift register, starting from Nibble most significant bit
;FOR LCDTemp = 1 to 4
;REPEAT 4
	movlw	4
	movwf	SysRepeatTemp4,ACCESS
SysRepeatLoop5
;SET LCD_DB OFF
	bcf	LATE,0,ACCESS
;IF LCD2Byte.3 ON THEN SET LCD_DB ON
	btfsc	LCD2BYTE,3,ACCESS
	bsf	LATE,0,ACCESS
;STROBE
;SET LCD_CB ON
	bsf	LATE,1,ACCESS
;SET LCD_CB OFF
	bcf	LATE,1,ACCESS
;ROTATE LCD2Byte LEFT
	rlcf	LCD2BYTE,F,ACCESS
;END REPEAT
	decfsz	SysRepeatTemp4,F,ACCESS
	bra	SysRepeatLoop5
SysRepeatLoopEnd5
;Last pulse for Nibble output. Not for Shift register
;SET LCD_DB ON
	bsf	LATE,0,ACCESS
;Put E pin on LCD to one through an AND operation
;WAIT 1 MS
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;with the first bit outputted (QH)
;SET LCD_DB OFF
	bcf	LATE,0,ACCESS
	return

;********************************************************************************

;Source: lcd.h (1614)
LCDBACKLIGHT
;Sub set to backlight state
	return

;********************************************************************************

;Source: lcd.h (1027)
LCDNORMALWRITEBYTE
;Sub to write a byte to the LCD
;1 and 2-wire modes
;Swap byte; Most significant NIBBLE sent first
;LCD2_NIBBLEOUT Swap4(LCDByte)
	movff	LCDBYTE,SWAP4IN
	rcall	FN_SWAP4
	movff	SWAP4,LCD2BYTE
	rcall	LCD2_NIBBLEOUT
;Less Significant NIBBLE output
;LCD2_NIBBLEOUT LCDByte
	movff	LCDBYTE,LCD2BYTE
	rcall	LCD2_NIBBLEOUT
;If Register Select is low
;IF LCD_RS = 0 then
	btfsc	SYSLCDTEMP,1,ACCESS
	bra	ENDIF53
;IF LCDByte < 16 then
	movlw	16
	subwf	LCDBYTE,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF54
;if LCDByte > 7 then
	movf	LCDBYTE,W,ACCESS
	sublw	7
	btfss	STATUS, C,ACCESS
;LCD_State = LCDByte
	movff	LCDBYTE,LCD_STATE
;end if
;END IF
ENDIF54
;END IF
ENDIF53
	return

;********************************************************************************

;Source: lcd.h (348)
LOCATE
;Sub to locate the cursor
;Where LCDColumn is 0 to screen width-1, LCDLine is 0 to screen height-1
;Set LCD_RS Off
	bcf	SYSLCDTEMP,1,ACCESS
;If LCDLine > 1 Then
	movf	LCDLINE,W,ACCESS
	sublw	1
	btfsc	STATUS, C,ACCESS
	bra	ENDIF47
;LCDLine = LCDLine - 2
	movlw	2
	subwf	LCDLINE,F,ACCESS
;LCDColumn = LCDColumn + LCD_WIDTH
	movlw	20
	addwf	LCDCOLUMN,F,ACCESS
;End If
ENDIF47
;LCDWriteByte(0x80 or 0x40 * LCDLine + LCDColumn)
	movf	LCDLINE,W,ACCESS
	mullw	64
	movf	LCDCOLUMN,W,ACCESS
	addwf	PRODL,W,ACCESS
	movwf	SysTemp1,ACCESS
	movlw	128
	iorwf	SysTemp1,W,ACCESS
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US,ACCESS
	bra	Delay_10US

;********************************************************************************

;Overloaded signature: STRING:, Source: lcd.h (806)
PRINT545
;Sub to print a string variable on the LCD
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen = 0 Then Exit Sub
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	return
;Set LCD_RS On
	bsf	SYSLCDTEMP,1,ACCESS
;Write Data
;For SysPrintTemp = 1 To PrintLen
	clrf	SYSPRINTTEMP,ACCESS
	movlw	1
	subwf	PRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
SysForLoop4
	incf	SYSPRINTTEMP,F,ACCESS
;LCDWriteByte PrintData(SysPrintTemp)
	movf	SYSPRINTTEMP,W,ACCESS
	addwf	SysPRINTDATAHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	INDF0,LCDBYTE
	rcall	LCDNORMALWRITEBYTE
;Next
	movf	PRINTLEN,W,ACCESS
	subwf	SYSPRINTTEMP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: lcd.h (821)
PRINT546
;Sub to print a byte variable on the LCD
;LCDValueTemp = 0
	clrf	LCDVALUETEMP,ACCESS
;Set LCD_RS On
	bsf	SYSLCDTEMP,1,ACCESS
;IF LCDValue >= 100 Then
	movlw	100
	subwf	LCDVALUE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	ENDIF51
;LCDValueTemp = LCDValue / 100
	movff	LCDVALUE,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempA,LCDVALUETEMP
;LCDValue = SysCalcTempX
	movff	SYSCALCTEMPX,LCDVALUE
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W,ACCESS
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
;End If
ENDIF51
;If LCDValueTemp > 0 Or LCDValue >= 10 Then
	movff	LCDVALUETEMP,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	rcall	SysCompLessThan
	movff	SysByteTempX,SysTemp1
	movff	LCDVALUE,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ENDIF52
;LCDValueTemp = LCDValue / 10
	movff	LCDVALUE,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempA,LCDVALUETEMP
;LCDValue = SysCalcTempX
	movff	SYSCALCTEMPX,LCDVALUE
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W,ACCESS
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
;End If
ENDIF52
;LCDWriteByte (LCDValue + 48)
	movlw	48
	addwf	LCDVALUE,W,ACCESS
	movwf	LCDBYTE,ACCESS
	bra	LCDNORMALWRITEBYTE

;********************************************************************************

;Source: glcd_st7735r.h (583)
PSET_ST7735R
;SetAddress_ST7735 ST7735_COLUMN, GLCDX, GLCDX
	movlw	42
	movwf	ST7735ADDRESSTYPE,ACCESS
	movff	GLCDX,ST7735START
	clrf	ST7735START_H,ACCESS
	movff	GLCDX,ST7735END
	clrf	ST7735END_H,ACCESS
	rcall	SETADDRESS_ST7735
;SetAddress_ST7735 ST7735_ROW, GLCDY, GLCDY
	movlw	43
	movwf	ST7735ADDRESSTYPE,ACCESS
	movff	GLCDY,ST7735START
	clrf	ST7735START_H,ACCESS
	movff	GLCDY,ST7735END
	clrf	ST7735END_H,ACCESS
	rcall	SETADDRESS_ST7735
;SendCommand_ST7735 0x2C
	movlw	44
	movwf	ST7735SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ST7735
;SendWord_ST7735 GLCDColour
	movff	GLCDCOLOUR,ST7735SENDWORD
	movff	GLCDCOLOUR_H,ST7735SENDWORD_H
	bra	SENDWORD_ST7735

;********************************************************************************

;Source: glcd_st7735.h (925)
SENDCOMMAND_ST7735
;set ST7735_CS OFF;
	bcf	LATB,2,ACCESS
;set ST7735_DC OFF;
	bcf	LATE,2,ACCESS
;repeat 8
	movlw	8
	movwf	SysRepeatTemp2,ACCESS
SysRepeatLoop2
;if ST7735SendByte.7 = ON  then
	btfss	ST7735SENDBYTE,7,ACCESS
	bra	ELSE35_1
;set ST7735_DO ON;
	bsf	LATC,7,ACCESS
;else
	bra	ENDIF35
ELSE35_1
;set ST7735_DO OFF;
	bcf	LATC,7,ACCESS
;end if
ENDIF35
;SET GLCD_SCK OFF;
	bcf	LATD,7,ACCESS
;rotate ST7735SendByte left
	rlcf	ST7735SENDBYTE,F,ACCESS
;set GLCD_SCK ON;
	bsf	LATD,7,ACCESS
;end repeat
	decfsz	SysRepeatTemp2,F,ACCESS
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;set ST7735_CS ON;
	bsf	LATB,2,ACCESS
	return

;********************************************************************************

;Source: glcd_st7735.h (959)
SENDDATA_ST7735
;set ST7735_CS OFF;
	bcf	LATB,2,ACCESS
;set ST7735_DC ON;
	bsf	LATE,2,ACCESS
;repeat 8
	movlw	8
	movwf	SysRepeatTemp7,ACCESS
SysRepeatLoop7
;if ST7735SendByte.7 = ON then
	btfss	ST7735SENDBYTE,7,ACCESS
	bra	ELSE75_1
;set ST7735_DO ON;
	bsf	LATC,7,ACCESS
;else
	bra	ENDIF75
ELSE75_1
;set ST7735_DO OFF;
	bcf	LATC,7,ACCESS
;end if
ENDIF75
;SET GLCD_SCK OFF;
	bcf	LATD,7,ACCESS
;rotate ST7735SendByte left
	rlcf	ST7735SENDBYTE,F,ACCESS
;set GLCD_SCK ON;
	bsf	LATD,7,ACCESS
;end Repeat
	decfsz	SysRepeatTemp7,F,ACCESS
	bra	SysRepeatLoop7
SysRepeatLoopEnd7
;set ST7735_CS ON;
	bsf	LATB,2,ACCESS
	return

;********************************************************************************

;Source: glcd_st7735.h (993)
SENDWORD_ST7735
;set ST7735_CS OFF;
	bcf	LATB,2,ACCESS
;set ST7735_DC ON;
	bsf	LATE,2,ACCESS
;repeat 16
	movlw	16
	movwf	SysRepeatTemp3,ACCESS
SysRepeatLoop3
;if ST7735SendWord.15 = ON then
	btfss	ST7735SENDWORD_H,7,ACCESS
	bra	ELSE36_1
;set ST7735_DO ON;
	bsf	LATC,7,ACCESS
;else
	bra	ENDIF36
ELSE36_1
;set ST7735_DO OFF;
	bcf	LATC,7,ACCESS
;end if
ENDIF36
;SET GLCD_SCK OFF;
	bcf	LATD,7,ACCESS
;rotate ST7735SendWord left
	rlcf	ST7735SENDWORD,F,ACCESS
	rlcf	ST7735SENDWORD_H,F,ACCESS
;set GLCD_SCK ON;
	bsf	LATD,7,ACCESS
;end repeat
	decfsz	SysRepeatTemp3,F,ACCESS
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
;set ST7735_CS ON;
	bsf	LATB,2,ACCESS
	return

;********************************************************************************

;Source: glcd_st7735.h (1029)
SETADDRESS_ST7735
;if GLCDRotateState.0 = 0 then
	btfsc	GLCDROTATESTATE,0,ACCESS
	bra	ELSE37_1
;if ST7735AddressType = ST7735_COLUMN then
	movlw	42
	subwf	ST7735ADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF38
;ST7735Start += ST7735_XSTART
	movlw	24
	addwf	ST7735START,F,ACCESS
	movlw	0
	addwfc	ST7735START_H,F,ACCESS
;ST7735End   += ST7735_XSTART
	movlw	24
	addwf	ST7735END,F,ACCESS
	movlw	0
	addwfc	ST7735END_H,F,ACCESS
;end if
ENDIF38
;if ST7735AddressType = ST7735_ROW then
	movlw	43
	subwf	ST7735ADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF39
;ST7735Start += ST7735_YSTART
	movlw	0
	addwf	ST7735START,F,ACCESS
	movlw	0
	addwfc	ST7735START_H,F,ACCESS
;ST7735End   += ST7735_YSTART
	movlw	0
	addwf	ST7735END,F,ACCESS
	movlw	0
	addwfc	ST7735END_H,F,ACCESS
;end if
ENDIF39
;else
	bra	ENDIF37
ELSE37_1
;if ST7735AddressType = ST7735_COLUMN then
	movlw	42
	subwf	ST7735ADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF40
;ST7735Start += ST7735_YSTART
	movlw	0
	addwf	ST7735START,F,ACCESS
	movlw	0
	addwfc	ST7735START_H,F,ACCESS
;ST7735End   += ST7735_YSTART
	movlw	0
	addwf	ST7735END,F,ACCESS
	movlw	0
	addwfc	ST7735END_H,F,ACCESS
;end if
ENDIF40
;if ST7735AddressType = ST7735_ROW then
	movlw	43
	subwf	ST7735ADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF41
;ST7735Start += ST7735_XSTART
	movlw	24
	addwf	ST7735START,F,ACCESS
	movlw	0
	addwfc	ST7735START_H,F,ACCESS
;ST7735End   += ST7735_XSTART
	movlw	24
	addwf	ST7735END,F,ACCESS
	movlw	0
	addwfc	ST7735END_H,F,ACCESS
;end if
ENDIF41
;end if
ENDIF37
;SendCommand_ST7735 ST7735AddressType
	movff	ST7735ADDRESSTYPE,ST7735SENDBYTE
	rcall	SENDCOMMAND_ST7735
;SendData_ST7735 ST7735Start_H
	movff	ST7735START_H,ST7735SENDBYTE
	rcall	SENDDATA_ST7735
;SendData_ST7735 ST7735Start
	movff	ST7735START,ST7735SENDBYTE
	rcall	SENDDATA_ST7735
;SendData_ST7735 ST7735End_H
	movff	ST7735END_H,ST7735SENDBYTE
	rcall	SENDDATA_ST7735
;SendData_ST7735 ST7735End
	movff	ST7735END,ST7735SENDBYTE
	bra	SENDDATA_ST7735

;********************************************************************************

;Source: stdbasic.h (300)
FN_SWAP4
;swapf Swap4In, W
	swapf	SWAP4IN, W,ACCESS
;movwf swap4
	movwf	SWAP4,ACCESS
	return

;********************************************************************************

;Source: system.h (2843)
SYSCOMPLESSTHAN
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;cpfslt SysByteTempA
	cpfslt	SYSBYTETEMPA,ACCESS
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

;Source: system.h (2873)
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

;Source: system.h (1105)
SYSCOPYSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get and copy length
;movff INDF0, SysCalcTempA
	movff	INDF0, SYSCALCTEMPA
;movff SysCalcTempA, INDF1
	movff	SYSCALCTEMPA, INDF1
;goto SysCopyStringCheck
	bra	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART
;movf INDF0, W
	movf	INDF0, W,ACCESS
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA,ACCESS
;addwf SysStringLength, F
	addwf	SYSSTRINGLENGTH, F,ACCESS
SYSCOPYSTRINGCHECK
;Exit if length = 0
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
SYSSTRINGCOPY
;Copy character
;movff PREINC0, PREINC1
	movff	PREINC0, PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringCopy
	bra	SYSSTRINGCOPY
	return

;********************************************************************************

;Source: system.h (2452)
SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F,ACCESS
;btfsc STATUS, Z
	btfsc	STATUS, Z,ACCESS
;return
	return
;Main calc routine
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;SysDivLoop = 8
	movlw	8
	movwf	SYSDIVLOOP,ACCESS
SYSDIV8START
;bcf STATUS, C
	bcf	STATUS, C,ACCESS
;rlf SysByteTempA, F
	rlcf	SYSBYTETEMPA, F,ACCESS
;rlf SysByteTempX, F
	rlcf	SYSBYTETEMPX, F,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;subwf SysByteTempX, F
	subwf	SYSBYTETEMPX, F,ACCESS
;bsf SysByteTempA, 0
	bsf	SYSBYTETEMPA, 0,ACCESS
;btfsc STATUS, C
	btfsc	STATUS, C,ACCESS
;goto Div8NotNeg
	bra	DIV8NOTNEG
;bcf SysByteTempA, 0
	bcf	SYSBYTETEMPA, 0,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F,ACCESS
DIV8NOTNEG
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv8Start
	bra	SYSDIV8START
	return

;********************************************************************************

;Source: system.h (1302)
SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get length
;TBLRD*+
	tblrd*+
;movff TABLAT,SysCalcTempA
	movff	TABLAT,SYSCALCTEMPA
;movff TABLAT,INDF1
	movff	TABLAT,INDF1
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
	movff	TABLAT,PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringRead
	bra	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables

StringTable1
	db	13,77,105,110,105,32,84,70,84,32,119,105,116,104


StringTable2
	db	9,66,117,116,116,111,110,115,95,52


StringTable3
	db	13,68,101,99,46,32,49,48,44,32,50,48,49,57


StringTable4
	db	5,71,114,101,97,116


StringTable5
	db	3,67,111,119


StringTable6
	db	5,66,97,115,105,99


StringTable7
	db	1,32


StringTable8
	db	2,32,32


StringTable9
	db	1,66


StringTable10
	db	8,66,117,116,116,111,110,32,66


StringTable11
	db	1,65


StringTable12
	db	8,66,117,116,116,111,110,32,65


StringTable13
	db	6,83,69,76,69,67,84


StringTable14
	db	2,85,80


StringTable15
	db	4,76,69,70,84


StringTable16
	db	4,68,79,87,78


StringTable17
	db	5,82,73,71,72,84


StringTable66
	db	1,48


StringTable98
	db	0


StringTable99
	db	1,49


;********************************************************************************


 END
