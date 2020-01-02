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
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
EPD2IN13D_COMMAND	EQU	4
EPD2IN13D_DATA	EQU	7
EPD7IN5ADDRESSTYPE	EQU	8
EPD7IN5_COMMAND	EQU	11
EPD7IN5_DATA	EQU	12
EPD_BUFFER	EQU	511
EPD_IND_COL	EQU	13
EPD_IND_COL_H	EQU	14
EPD_IND_RAW	EQU	15
EPD_IND_RAW_H	EQU	16
GLCDBACKGROUND	EQU	17
GLCDBACKGROUND_H	EQU	18
GLCDDEVICEHEIGHT	EQU	19
GLCDDEVICEHEIGHT_H	EQU	20
GLCDDEVICEWIDTH	EQU	21
GLCDDEVICEWIDTH_H	EQU	22
GLCDFNTDEFAULT	EQU	23
GLCDFNTDEFAULTHEIGHT	EQU	24
GLCDFNTDEFAULTSIZE	EQU	25
GLCDFONTWIDTH	EQU	26
GLCDFOREGROUND	EQU	27
GLCDFOREGROUND_H	EQU	28
GLCD_YORDINATE	EQU	29
GLCD_YORDINATE_H	EQU	30
PRINTLOCX	EQU	31
PRINTLOCX_H	EQU	32
PRINTLOCY	EQU	33
PRINTLOCY_H	EQU	34
SPICLOCKMODE	EQU	35
SPICURRENTMODE	EQU	36
SPIRXDATA	EQU	37
SPITXDATA	EQU	38
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSREPEATTEMP1	EQU	39
SYSTEMP1	EQU	40
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
SYSWORDTEMPA	EQU	5
SYSWORDTEMPA_H	EQU	6
SYSWORDTEMPB	EQU	9
SYSWORDTEMPB_H	EQU	10
_GLCDPAGE	EQU	41
_GLCDPAGESH	EQU	42
_GLCDPAGESL	EQU	43

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
;GLCDCLS
	rcall	CLS_EPD7IN5
;GLCDSleep
	rcall	SLEEP_EPD2IN13D
;do
SysDoLoop_S1
;loop
	bra	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Source: EPD_EPD7in5.h (277)
CLS_EPD7IN5
;added CLS_EPD7in5_init to optimise start up process.
;CLS_EPD7in5_init
	rcall	CLS_EPD7IN5_INIT
;Refresh_EPD7in5
	rcall	REFRESH_EPD7IN5
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
	clrf	PRINTLOCY_H,ACCESS
;For EPD_Ind_raw=1 to BUFFWIDTH
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop1
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
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;SendCommand_EPD7in5(0x04)
	movlw	4
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
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
;SendCommand_EPD7in5(0x12)
	movlw	18
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
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
;Clear data
;SendCommand_EPD7in5(DATA_START_TRANSMISSION_1)
	movlw	16
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATA,0,ACCESS
;for EPD_Ind_raw=1 to GLCD_Height
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop2
	incf	EPD_IND_RAW,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,ACCESS
;for EPD_Ind_col=1 to GLCD_Width
	clrf	EPD_IND_COL,ACCESS
	clrf	EPD_IND_COL_H,ACCESS
SysForLoop3
	incf	EPD_IND_COL,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_COL_H,F,ACCESS
;Was.. speed optimised with macro
;Repeat 4
	movlw	4
	movwf	SysRepeatTemp1,ACCESS
SysRepeatLoop1
;if GLCDBackground = TFT_BLACK then
	movff	GLCDBACKGROUND,SysWORDTempA
	movff	GLCDBACKGROUND_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE2_1
;EPD7in5_Data = TFT_BLACK
	clrf	EPD7IN5_DATA,ACCESS
;else
	bra	ENDIF2
ELSE2_1
;EPD7in5_Data = EPD_WHITE
	movlw	51
	movwf	EPD7IN5_DATA,ACCESS
;end if
ENDIF2
;SendData_EPD7in5_Macro
;Macro Source: EPD_EPD7in5.h (453)
;FastHWSPITransfer EPD7in5_Data
	movff	EPD7IN5_DATA,SPITXDATA
	rcall	FASTHWSPITRANSFER
;End Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;next
	movff	EPD_IND_COL,SysWORDTempA
	movff	EPD_IND_COL_H,SysWORDTempA_H
	movlw	128
	movwf	SysWORDTempB,ACCESS
	movlw	2
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	128
	movwf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
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

;Source: E_paper-7in5_GLCDCLS_to_WHITE.gcb (25)
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
	movwf	SPICURRENTMODE,ACCESS
	clrf	SPICLOCKMODE,ACCESS
	rcall	SPIMODE645
;SendCommand_EPD7in5(0x04)
	movlw	4
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
;do while EPD_Busy=Off
SysDoLoop_S4
	btfsc	PORTC,0,ACCESS
	bra	SysDoLoop_E4
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;loop
	bra	SysDoLoop_S4
SysDoLoop_E4
;SendCommand_EPD7in5(0x01)
	movlw	1
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0x37)
	movlw	55
	movwf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;SendData_EPD7in5(0x00)
	clrf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0x00)
	clrf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0xCF)
	movlw	207
	movwf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;SendData_EPD7in5(0x08)
	movlw	8
	movwf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0x06)
	movlw	6
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0xC7)
	movlw	199
	movwf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;SendData_EPD7in5(0xcc)
	movlw	204
	movwf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;SendData_EPD7in5(0x28)
	movlw	40
	movwf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0x04)
	movlw	4
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
	rcall	Delay_MS
;loop
	bra	SysDoLoop_S5
SysDoLoop_E5
;SendCommand_EPD7in5(0x30)
	movlw	48
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0x3C)
	movlw	60
	movwf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0x41)
	movlw	65
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0x00)
	clrf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0x50)
	movlw	80
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0x77)
	movlw	119
	movwf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0x60)
	movlw	96
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0x22)
	movlw	34
	movwf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0x61)
	movlw	97
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0x02)
	movlw	2
	movwf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;SendData_EPD7in5(0x80)
	movlw	128
	movwf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;SendData_EPD7in5(0x01)
	movlw	1
	movwf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;SendData_EPD7in5(0x80)
	movlw	128
	movwf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0x82)
	movlw	130
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0x1E)
	movlw	30
	movwf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;SendCommand_EPD7in5(0xE5)
	movlw	229
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
;SendData_EPD7in5(0x03)
	movlw	3
	movwf	EPD7IN5_DATA,ACCESS
	rcall	SENDDATA_EPD7IN5
;May not be required, improves start up by having it removed
;SendCommand_EPD7in5(0x12)
	movlw	18
	movwf	EPD7IN5_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD7IN5
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
	rcall	ROTATE_EPD7IN5
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
	movwf	_GLCDPAGESH,ACCESS
;_GLCDPagesL = 0
	clrf	_GLCDPAGESL,ACCESS
;_GLCDPage = 0
	clrf	_GLCDPAGE,ACCESS
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
SysDoLoop_S3
	btfsc	PORTC,0,ACCESS
	bra	SysDoLoop_E3
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;loop
	bra	SysDoLoop_S3
SysDoLoop_E3
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
	rcall	FASTHWSPITRANSFER
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
	rcall	FASTHWSPITRANSFER
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
	rcall	FASTHWSPITRANSFER
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
	rcall	FASTHWSPITRANSFER
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
	btfss	SPICLOCKMODE,0,ACCESS
;SPI1CON1.CKE = 1
	bsf	SPI1CON1,CKE,BANKED
;End If
;If SPIClockMode.1 = On Then
	btfsc	SPICLOCKMODE,1,ACCESS
;SPI1CON1.CKP = 1
	bsf	SPI1CON1,CKP,BANKED
;End If
;SPI1CON1 = 0x40
	movlw	64
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
SysSelect2Case1
	movff	SPICURRENTMODE,SysBYTETempA
	movlw	13
	movwf	SysBYTETempB,ACCESS
	banksel	0
	rcall	SysCompEqual
	movlw	14
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,ACCESS
	btfss	SysTemp1,0,ACCESS
	bra	SysSelect2Case2
;asm showdebug Script value is calculated as SPIBAUDRATE_SCRIPT
;script sysbitvar0.2 is calculated as 3
;SPI1BAUD = SPIBAUDRATE_SCRIPT
	movlw	3
	banksel	SPI1BAUD
	movwf	SPI1BAUD,BANKED
;SPI1CON0.MST = 1
	bsf	SPI1CON0,MST,BANKED
;Case Master
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	12
	subwf	SPICURRENTMODE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case3
;asm showdebug Script value is calculated as SPIBAUDRATE_SCRIPT_MASTER
;script sysbitvar0.2 is calculated as 9
;SPI1BAUD = SPIBAUDRATE_SCRIPT_MASTER
	movlw	9
	banksel	SPI1BAUD
	movwf	SPI1BAUD,BANKED
;SPI1CON0.MST = 1
	bsf	SPI1CON0,MST,BANKED
;Case MasterSlow
	bra	SysSelectEnd2
SysSelect2Case3
	movlw	11
	subwf	SPICURRENTMODE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case4
;asm showdebug Script value is calculated as SPIBAUDRATE_SCRIPT_MASTERSLOW
;script sysbitvar0.2 is calculated as 33
;SPI1BAUD = SPIBAUDRATE_SCRIPT_MASTERSLOW
	movlw	33
	banksel	SPI1BAUD
	movwf	SPI1BAUD,BANKED
;SPI1CON0.MST = 1
	bsf	SPI1CON0,MST,BANKED
;Case Slave
	bra	SysSelectEnd2
SysSelect2Case4
	movf	SPICURRENTMODE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case5
;SPI1CON0.MST = 0
	banksel	SPI1CON0
	bcf	SPI1CON0,MST,BANKED
;Case SlaveSS
	bra	SysSelectEnd2
SysSelect2Case5
	decf	SPICURRENTMODE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd2
;SPI1CON0.MST = 0
	banksel	SPI1CON0
	bcf	SPI1CON0,MST,BANKED
;End Select
SysSelectEnd2
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


 END
