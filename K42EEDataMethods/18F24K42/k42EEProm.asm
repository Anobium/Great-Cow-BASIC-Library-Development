;Program compiled by Great Cow BASIC (0.98.<<>> 2018-07-19)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F24K42, r=DEC
#include <P18F24K42.inc>
 CONFIG LVP = OFF, WDTE = OFF, MVECEN = OFF, MCLRE = INTMCLR, RSTOSC = HFINTOSC_1MHZ

;********************************************************************************

;Set aside memory locations for variables
EEDATA	EQU	1
NVMADRH	EQU	2
SYSBITVAR0	EQU	3
SYSEEADDRESS	EQU	4
SYSEEADDRESS_H	EQU	5
SYSEEPROMADDRESS	EQU	6
SYSEEPROMADDRESS_H	EQU	7

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

;Start of the main program
;EPWrite 0x00,0x55
	clrf	SYSEEADDRESS,BANKED
	clrf	SYSEEADDRESS_H,BANKED
	movlw	85
	movwf	EEDATA,BANKED
	rcall	NVMADR_EPWRITE
;EPWrite 0xFF,0xAA
	setf	SYSEEADDRESS,BANKED
	clrf	SYSEEADDRESS_H,BANKED
	movlw	170
	movwf	EEDATA,BANKED
	rcall	NVMADR_EPWRITE
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

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
;Section added by WMR  for 18FxxK40 chips with PPS and
;Oscillator block similar to 16F188xx Chips
;asm showdebug OSCCON type is 101 '18F and has NDIV3 bit
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
;Clear BSR on 18F chips
;BSR = 0
	clrf	BSR,ACCESS
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
;End clearing any ANSEL variants in the part
;Comparator register bits for 12F510,16F506, PIC16F1535 classes
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
;PORTE = 0
	clrf	PORTE,ACCESS
	banksel	0
	return

;********************************************************************************

NVMADR_EPWRITE
;dim IntState as bit
;IntState = GIE
	bcf	SYSBITVAR0,1,BANKED
	btfsc	INTCON0,GIE,ACCESS
	bsf	SYSBITVAR0,1,BANKED
ENDIF1
;Dim SysEEPromAddress As Word
;ALL 16F NVMREGS Devices Except 18FxxK40/K42
;' 18FXXk40/K42 and others with NVMREG0/NVMREG1
;SysEEPromAddress = SysEEAddress
	movff	SYSEEADDRESS,SYSEEPROMADDRESS
	movff	SYSEEADDRESS_H,SYSEEPROMADDRESS_H
;NVMADRH =SysEEPromAddress_h
	movff	SYSEEPROMADDRESS_H,NVMADRH
;NVMADRL =SysEEPromAddress
	movffl	SYSEEPROMADDRESS,NVMADRL
;Access EEPROM LOcations
;NVMREG0 = 0
	banksel	NVMCON1
	bcf	NVMCON1,NVMREG0,BANKED
;NVMREG1 = 0
	bcf	NVMCON1,NVMREG1,BANKED
;NVMDAT = EEData
	movffl	EEDATA,NVMDAT
;FREE = 0
	bcf	NVMCON1,FREE,BANKED
;WREN = 1
	bsf	NVMCON1,WREN,BANKED
;GIE = 0
	bcf	INTCON0,GIE,ACCESS
;NVMCON2 = 0x55
	movlw	85
	movwf	NVMCON2,BANKED
;NVMCON2 = 0xAA
	movlw	170
	movwf	NVMCON2,BANKED
;WR = 1
	bsf	NVMCON1,WR,BANKED
;NOP     ' NOPs may be required for latency at high frequencies
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;wait while WR = 1
SysWaitLoop1
	btfsc	NVMCON1,WR,BANKED
	bra	SysWaitLoop1
;WREN = 0
	bcf	NVMCON1,WREN,BANKED
;Restore interrupt to initial  State
;GIE = IntState
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,1,BANKED
	bcf	INTCON0,GIE,ACCESS
ENDIF2
	btfsc	SYSBITVAR0,1,BANKED
	bsf	INTCON0,GIE,ACCESS
ENDIF3
	return

;********************************************************************************


 END
