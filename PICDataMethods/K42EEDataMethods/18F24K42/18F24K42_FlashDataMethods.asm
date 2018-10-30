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
BLOCKSTARTADDR	EQU	13
BLOCKSTARTADDR_E	EQU	16
BLOCKSTARTADDR_H	EQU	14
BLOCKSTARTADDR_U	EQU	15
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
EEDATA	EQU	17
EEDATABUFFER	EQU	893
EEDATABUFFER_H	EQU	764
EEDATABYTE	EQU	18
EEDATAOFFSET	EQU	19
EEDATAWORD	EQU	20
EEDATAWORD_H	EQU	21
L_TBLPTR	EQU	22
MYFLASHADDRESS	EQU	23
MYFLASHADDRESS_E	EQU	26
MYFLASHADDRESS_H	EQU	24
MYFLASHADDRESS_U	EQU	25
MYWORD	EQU	27
MYWORD_H	EQU	28
NVMADRH	EQU	29
SYSBITVAR0	EQU	30
SYSBYTETEMPX	EQU	0
SYSEEADDRESS	EQU	31
SYSEEADDRESS_H	EQU	32
SYSEEPROMADDRESS	EQU	33
SYSEEPROMADDRESS_H	EQU	34
SYSLONGTEMPA	EQU	5
SYSLONGTEMPA_E	EQU	8
SYSLONGTEMPA_H	EQU	6
SYSLONGTEMPA_U	EQU	7
SYSLONGTEMPB	EQU	9
SYSLONGTEMPB_E	EQU	12
SYSLONGTEMPB_H	EQU	10
SYSLONGTEMPB_U	EQU	11
SYSTEMP1	EQU	35
SYSTEMP1_H	EQU	36
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
SYSWAITTEMPS	EQU	4
SYSWORDTEMPA	EQU	5
SYSWORDTEMPA_H	EQU	6
SYSWORDTEMPB	EQU	9
SYSWORDTEMPB_H	EQU	10
WRITELOOP	EQU	37
WRITELOOP_H	EQU	38

;********************************************************************************

;Alias variables
AFSR0	EQU	16361
AFSR0_H	EQU	16362
WRITEADDR	EQU	16374
WRITEADDR_H	EQU	16375
WRITEADDR_U	EQU	16376
WRITEADDR_E	EQU	22
FLASHADDR	EQU	16374
FLASHADDR_H	EQU	16375
FLASHADDR_U	EQU	16376
FLASHADDR_E	EQU	22

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
;Public are following methods v1.04
;FLASH_ReadByte
;FLASH_ReadWord
;FLASH_WriteByte
;#define PROGRAM_EEDATAMETHODS    1
;#define WRITE_FLASH_BLOCKSIZE    128
;#define ERASE_FLASH_BLOCKSIZE    128
;#define END_FLASH                0x004000   'Some devices have more memory. Please check the datasheet
;User code starts here.
;wait 1 s
	movlw	1
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;dim myFlashAddress as long
;myFlashAddress = 0x3FA0
	movlw	160
	movwf	MYFLASHADDRESS,BANKED
	movlw	63
	movwf	MYFLASHADDRESS_H,BANKED
	clrf	MYFLASHADDRESS_U,BANKED
	clrf	MYFLASHADDRESS_E,BANKED
;dim myWord as word
;myWord = 0xAABB  ' the test word to write & 16383, so, therefore 0x2ABB is written. See the Help
	movlw	187
	movwf	MYWORD,BANKED
	movlw	170
	movwf	MYWORD_H,BANKED
;EPWrite 0x00, 0
	clrf	SYSEEADDRESS,BANKED
	clrf	SYSEEADDRESS_H,BANKED
	clrf	EEDATA,BANKED
	rcall	NVMADR_EPWRITE
;EPWrite 0x01, 1
	movlw	1
	movwf	SYSEEADDRESS,BANKED
	clrf	SYSEEADDRESS_H,BANKED
	movlw	1
	movwf	EEDATA,BANKED
	rcall	NVMADR_EPWRITE
;ProgramWrite ( myFlashAddress, myWord )
	movffl	MYFLASHADDRESS,FLASHADDR
	movffl	MYFLASHADDRESS_H,FLASHADDR_H
	movffl	MYFLASHADDRESS_U,FLASHADDR_U
	movff	MYFLASHADDRESS_E,FLASHADDR_E
	movff	MYWORD,EEDATAWORD
	movff	MYWORD_H,EEDATAWORD_H
	rcall	FLASH_WRITE_K4255
	movffl	FLASHADDR,MYFLASHADDRESS
	movffl	FLASHADDR_H,MYFLASHADDRESS_H
	movffl	FLASHADDR_U,MYFLASHADDRESS_U
	movff	FLASHADDR_E,MYFLASHADDRESS_E
	movff	EEDATAWORD,MYWORD
	movff	EEDATAWORD_H,MYWORD_H
;ProgramRead  ( myFlashAddress, myWord )
	movffl	MYFLASHADDRESS,FLASHADDR
	movffl	MYFLASHADDRESS_H,FLASHADDR_H
	movffl	MYFLASHADDRESS_U,FLASHADDR_U
	movff	MYFLASHADDRESS_E,FLASHADDR_E
	rcall	FLASH_READ_K42
	movffl	FLASHADDR,MYFLASHADDRESS
	movffl	FLASHADDR_H,MYFLASHADDRESS_H
	movffl	FLASHADDR_U,MYFLASHADDRESS_U
	movff	FLASHADDR_E,MYFLASHADDRESS_E
	movff	EEDATAWORD,MYWORD
	movff	EEDATAWORD_H,MYWORD_H
;myWord++
	incf	MYWORD,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	MYWORD_H,F,BANKED
;EPWrite 0x00, myWord_h
	clrf	SYSEEADDRESS,BANKED
	clrf	SYSEEADDRESS_H,BANKED
	movff	MYWORD_H,EEDATA
	rcall	NVMADR_EPWRITE
;EPWrite 0x01, myWord
	movlw	1
	movwf	SYSEEADDRESS,BANKED
	clrf	SYSEEADDRESS_H,BANKED
	movff	MYWORD,EEDATA
	rcall	NVMADR_EPWRITE
;end
	bra	BASPROGRAMEND
;User code ends here.
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	14
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	189
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

FLASH_ERASEBLOCK_K42
;Dim GIEBitValueE as bit
;GIEBitValueE = GIE        'Save interrupt enable
	bcf	SYSBITVAR0,2,BANKED
	btfsc	INTCON0,GIE,ACCESS
	bsf	SYSBITVAR0,2,BANKED
ENDIF13
;Dim flashAddr as Long Alias l_TBLPTR, TBLPTRU, TBLPTRH, TBLPTRL
;NVMREG1 = 1
	banksel	NVMCON1
	bsf	NVMCON1,NVMREG1,BANKED
;NVMREG0 = 0
	bcf	NVMCON1,NVMREG0,BANKED
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
;NOP     ' NOPs required for latency at high frequencies
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
SysWaitLoop3
	btfsc	NVMCON1,WR,BANKED
	bra	SysWaitLoop3
;WREN = 0
	bcf	NVMCON1,WREN,BANKED
;GIE = GIEBitValueE
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,2,BANKED
	bcf	INTCON0,GIE,ACCESS
ENDIF14
	btfsc	SYSBITVAR0,2,BANKED
	bsf	INTCON0,GIE,ACCESS
ENDIF15
	return

;********************************************************************************

FLASH_READ_K42
;NVMREG1 = 1
	banksel	NVMCON1
	bsf	NVMCON1,NVMREG1,BANKED
;NVMREG0 = 0
	bcf	NVMCON1,NVMREG0,BANKED
;RD = 1
	bsf	NVMCON1,RD,BANKED
;This will load the flashAddr into the three registers.  The upper byte is a dummy location.
;Dim flashAddr as Long Alias l_TBLPTR, TBLPTRU, TBLPTRH, TBLPTRL
;TBLRD*+
	tblrd*+
;NOP     ' NOPs required for latency at high frequencies
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;EEDataWord_h = TABLAT
	movffl	TABLAT,EEDATAWORD_H
;NOP     ' NOPs required for latency at high frequencies
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;EEDataWord = TABLAT
	movffl	TABLAT,EEDATAWORD
	banksel	EEDATAWORD_H
	clrf	EEDATAWORD_H,BANKED
	return

;********************************************************************************

FLASH_WRITEBLOCK_K42
;Dim writeAddr as Long Alias l_TBLPTR, TBLPTRU, TBLPTRH, TBLPTRL
;Dim GIEBitValueB as bit
;GIEBitValueB = GIE        'Save interrupt enable
	bcf	SYSBITVAR0,1,BANKED
	btfsc	INTCON0,GIE,ACCESS
	bsf	SYSBITVAR0,1,BANKED
ENDIF10
;dim blockStartAddr  as Long
;blockStartAddr= writeAddr & ((END_FLASH-1) XOR (ERASE_FLASH_BLOCKSIZE-1))
	movlw	128
	andwf	WRITEADDR,W,ACCESS
	movwf	BLOCKSTARTADDR,BANKED
	movlw	63
	andwf	WRITEADDR_H,W,ACCESS
	movwf	BLOCKSTARTADDR_H,BANKED
	clrf	BLOCKSTARTADDR_U,BANKED
	clrf	BLOCKSTARTADDR_E,BANKED
;Flash write must start at the beginning of a row
;if writeAddr <> blockStartAddr then
	movffl	WRITEADDR,SysLONGTempA
	movffl	WRITEADDR_H,SysLONGTempA_H
	movffl	WRITEADDR_U,SysLONGTempA_U
	movff	WRITEADDR_E,SysLONGTempA_E
	movff	BLOCKSTARTADDR,SysLONGTempB
	movff	BLOCKSTARTADDR_H,SysLONGTempB_H
	movff	BLOCKSTARTADDR_U,SysLONGTempB_U
	movff	BLOCKSTARTADDR_E,SysLONGTempB_E
	rcall	SysCompEqual32
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
;exit sub
	return
;end if
ENDIF6
;Block erase sequence
;FLASH_EraseBlock_K42(writeAddr)
	movffl	WRITEADDR,FLASHADDR
	movffl	WRITEADDR_H,FLASHADDR_H
	movffl	WRITEADDR_U,FLASHADDR_U
	movff	WRITEADDR_E,FLASHADDR_E
	rcall	FLASH_ERASEBLOCK_K42
	movffl	FLASHADDR,WRITEADDR
	movffl	FLASHADDR_H,WRITEADDR_H
	movffl	FLASHADDR_U,WRITEADDR_U
	movff	FLASHADDR_E,WRITEADDR_E
;Write block of data
;dim writeloop as word
;for writeloop = 0 to WRITE_FLASH_BLOCKSIZE-1
	setf	WRITELOOP,BANKED
	setf	WRITELOOP_H,BANKED
SysForLoop2
	incf	WRITELOOP,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	WRITELOOP_H,F,BANKED
;TABLAT = EEDataBuffer(writeloop) ' Load data byte
	lfsr	0,EEDATABUFFER
	movf	WRITELOOP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	WRITELOOP_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,TABLAT
;if writeloop = (WRITE_FLASH_BLOCKSIZE-1) then
	movff	WRITELOOP,SysWORDTempA
	movff	WRITELOOP_H,SysWORDTempA_H
	movlw	127
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE8_1
;TBLWT*
	tblwt*
;else
	bra	ENDIF8
ELSE8_1
;TBLWT*+
	tblwt*+
;end if
ENDIF8
;next
	movff	WRITELOOP,SysWORDTempA
	movff	WRITELOOP_H,SysWORDTempA_H
	movlw	127
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop2
ENDIF9
SysForLoopEnd2
;NVMREG1 = 1
	banksel	NVMCON1
	bsf	NVMCON1,NVMREG1,BANKED
;NVMREG0 = 0
	bcf	NVMCON1,NVMREG0,BANKED
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
;NOP     ' NOPs required for latency at high frequencies
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
SysWaitLoop2
	btfsc	NVMCON1,WR,BANKED
	bra	SysWaitLoop2
;WREN = 0
	bcf	NVMCON1,WREN,BANKED
;GIE = GIEBitValueB
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,1,BANKED
	bcf	INTCON0,GIE,ACCESS
ENDIF11
	btfsc	SYSBITVAR0,1,BANKED
	bsf	INTCON0,GIE,ACCESS
ENDIF12
	return

;********************************************************************************

;Overloaded signature: LONG:BYTE:
FLASH_WRITE_K4254
;dim flashAddr as Long Alias l_TBLPTR, TBLPTRU, TBLPTRH, TBLPTRL
;dim blockStartAddr  as Long
;blockStartAddr= flashAddr  & ((END_FLASH-1) XOR (ERASE_FLASH_BLOCKSIZE-1))
	movlw	128
	andwf	FLASHADDR,W,ACCESS
	movwf	BLOCKSTARTADDR,BANKED
	movlw	63
	andwf	FLASHADDR_H,W,ACCESS
	movwf	BLOCKSTARTADDR_H,BANKED
	clrf	BLOCKSTARTADDR_U,BANKED
	clrf	BLOCKSTARTADDR_E,BANKED
;Dim EEDataoffset as byte
;EEDataoffset = (flashAddr & (ERASE_FLASH_BLOCKSIZE-1))
	movlw	127
	andwf	FLASHADDR,W,ACCESS
	movwf	EEDATAOFFSET,BANKED
;Entire row will be erased, read and save the existing data
;dim writeloop as word
;for writeloop = 0 to ERASE_FLASH_BLOCKSIZE-1
	setf	WRITELOOP,BANKED
	setf	WRITELOOP_H,BANKED
SysForLoop1
	incf	WRITELOOP,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	WRITELOOP_H,F,BANKED
;FLASH_Read_K42(blockStartAddr+ writeloop, EEDataBuffer_h(writeloop) )
	movf	WRITELOOP,W,BANKED
	addwf	BLOCKSTARTADDR,W,BANKED
	movwf	FLASHADDR,ACCESS
	movf	WRITELOOP_H,W,BANKED
	addwfc	BLOCKSTARTADDR_H,W,BANKED
	movwf	FLASHADDR_H,ACCESS
	movlw	0
	addwfc	BLOCKSTARTADDR_U,W,BANKED
	movwf	FLASHADDR_U,ACCESS
	movlw	0
	addwfc	BLOCKSTARTADDR_E,W,BANKED
	movwf	FLASHADDR_E,ACCESS
	rcall	FLASH_READ_K42
	lfsr	0,EEDATABUFFER_H
	movf	WRITELOOP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movffl	EEDATAWORD,INDF0
;next
	movff	WRITELOOP,SysWORDTempA
	movff	WRITELOOP_H,SysWORDTempA_H
	movlw	127
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop1
ENDIF5
SysForLoopEnd1
;Load byte at offset
;EEDataBuffer( EEDataoffset ) = EEDataByte
	lfsr	0,EEDATABUFFER
	movf	EEDATAOFFSET,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movffl	EEDATABYTE,INDF0
;Writes buffer contents to current block
;FLASH_WriteBlock_K42( blockStartAddr )
	movffl	BLOCKSTARTADDR,WRITEADDR
	movffl	BLOCKSTARTADDR_H,WRITEADDR_H
	movffl	BLOCKSTARTADDR_U,WRITEADDR_U
	movff	BLOCKSTARTADDR_E,WRITEADDR_E
	rcall	FLASH_WRITEBLOCK_K42
	movffl	WRITEADDR,BLOCKSTARTADDR
	movffl	WRITEADDR_H,BLOCKSTARTADDR_H
	movffl	WRITEADDR_U,BLOCKSTARTADDR_U
	movff	WRITEADDR_E,BLOCKSTARTADDR_E
	return

;********************************************************************************

;Overloaded signature: LONG:WORD:
FLASH_WRITE_K4255
;FLASH_Write_K42( flashAddr,  EEDataWord_h )
	movff	EEDATAWORD_H,EEDATABYTE
	rcall	FLASH_WRITE_K4254
	movff	EEDATABYTE,EEDATAWORD_H
;FLASH_Write_K42( flashAddr,  EEDataWord )
	bra	FLASH_WRITE_K4255

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
;OSCFRQ = 0b00000110   '32mhz
	movlw	6
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
	bcf	SYSBITVAR0,3,BANKED
	btfsc	INTCON0,GIE,ACCESS
	bsf	SYSBITVAR0,3,BANKED
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
	btfss	SYSBITVAR0,3,BANKED
	bcf	INTCON0,GIE,ACCESS
ENDIF2
	btfsc	SYSBITVAR0,3,BANKED
	bsf	INTCON0,GIE,ACCESS
ENDIF3
	return

;********************************************************************************

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
