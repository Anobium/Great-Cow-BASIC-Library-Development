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
BLOCKSTARTADDR	EQU	1
BLOCKSTARTADDR_E	EQU	4
BLOCKSTARTADDR_H	EQU	2
BLOCKSTARTADDR_U	EQU	3
EEDATABYTE	EQU	13
EEDATAOFFSET	EQU	14
FLASHADDR	EQU	15
FLASHADDR_E	EQU	18
FLASHADDR_H	EQU	16
FLASHADDR_U	EQU	17
FLASH_READBYTE_K42	EQU	19
FLASH_READWORD_K42	EQU	20
FLASH_READWORD_K42_H	EQU	21
FLASH_WRITEBLOCK_K42	EQU	22
MYBUFFER	EQU	893
MYBYTE	EQU	23
MYFLASHADDRESS	EQU	24
MYFLASHADDRESS_E	EQU	27
MYFLASHADDRESS_H	EQU	25
MYFLASHADDRESS_U	EQU	26
MYWORD	EQU	28
MYWORD_H	EQU	29
SYSBITVAR0	EQU	30
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSFLASHRDBUFPTRHANDLER	EQU	31
SYSFLASHRDBUFPTRHANDLER_H	EQU	32
SYSFLASHWRBUFPTRHANDLER	EQU	33
SYSFLASHWRBUFPTRHANDLER_H	EQU	34
SYSLONGTEMPA	EQU	5
SYSLONGTEMPA_E	EQU	8
SYSLONGTEMPA_H	EQU	6
SYSLONGTEMPA_U	EQU	7
SYSLONGTEMPB	EQU	9
SYSLONGTEMPB_E	EQU	12
SYSLONGTEMPB_H	EQU	10
SYSLONGTEMPB_U	EQU	11
SYSTEMP1	EQU	35
SYSTEMP1_E	EQU	38
SYSTEMP1_H	EQU	36
SYSTEMP1_U	EQU	37
WRITEADDR	EQU	39
WRITEADDR_E	EQU	42
WRITEADDR_H	EQU	40
WRITEADDR_U	EQU	41
WRITELOOP	EQU	43

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

;Start of the main program
;Public are following methods v1.01
;FLASH_ReadByte_K42
;FLASH_ReadWord_K42
;FLASH_WriteByte_K42
;#define WRITE_FLASH_BLOCKSIZE_K42    128
;#define ERASE_FLASH_BLOCKSIZE_K42    128
;#define END_FLASH_K42                0x020000
;dim myFlashAddress as long
;myFlashAddress = 0x3FF0
	movlw	240
	movwf	MYFLASHADDRESS,BANKED
	movlw	63
	movwf	MYFLASHADDRESS_H,BANKED
	clrf	MYFLASHADDRESS_U,BANKED
	clrf	MYFLASHADDRESS_E,BANKED
;myByte = 0x55  ' the byte to write
	movlw	85
	movwf	MYBYTE,BANKED
;dim myBuffer( WRITE_FLASH_BLOCKSIZE_K42 )
;FLASH_WriteByte_K42( myFlashAddress, myBuffer, myByte )
	movff	MYFLASHADDRESS,FLASHADDR
	movff	MYFLASHADDRESS_H,FLASHADDR_H
	movff	MYFLASHADDRESS_U,FLASHADDR_U
	movff	MYFLASHADDRESS_E,FLASHADDR_E
	movlw	low MYBUFFER
	movwf	SysFLASHRDBUFPTRHandler,BANKED
	movlw	high MYBUFFER
	movwf	SysFLASHRDBUFPTRHandler_H,BANKED
	movff	MYBYTE,EEDATABYTE
	rcall	FLASH_WRITEBYTE_K42
	movff	FLASHADDR,MYFLASHADDRESS
	movff	FLASHADDR_H,MYFLASHADDRESS_H
	movff	FLASHADDR_U,MYFLASHADDRESS_U
	movff	FLASHADDR_E,MYFLASHADDRESS_E
	movff	EEDATABYTE,MYBYTE
;dim mybyte as Byte
;mybyte = FLASH_ReadByte_K42  ( myFlashAddress )
	movff	MYFLASHADDRESS,FLASHADDR
	movff	MYFLASHADDRESS_H,FLASHADDR_H
	movff	MYFLASHADDRESS_U,FLASHADDR_U
	movff	MYFLASHADDRESS_E,FLASHADDR_E
	rcall	FN_FLASH_READBYTE_K42
	movff	FLASH_READBYTE_K42,MYBYTE
;dim myword as Word
;myword = FLASH_ReadWord_K42 ( myFlashAddress )
	movff	MYFLASHADDRESS,FLASHADDR
	movff	MYFLASHADDRESS_H,FLASHADDR_H
	movff	MYFLASHADDRESS_U,FLASHADDR_U
	movff	MYFLASHADDRESS_E,FLASHADDR_E
	rcall	FN_FLASH_READWORD_K42
	movff	FLASH_READWORD_K42,MYWORD
	movff	FLASH_READWORD_K42_H,MYWORD_H
;end
	bra	BASPROGRAMEND
;Summary
;Reads a data byte from Flash
;
;Description
;This routine reads a data byte from given Flash address
;
;Preconditions
;None
;
;Param
;flashAddr - Flash program memory location from which data has to be read
;
;Returns
;Data byte read from given Flash address
;
;Example
;readByte as byte
;flashAddr = 0x7D00
;
;readByte = FLASH_ReadByte_K42(flashAddr)
;Summary
;Reads a data word from Flash
;
;Description
;This routine reads a data word from given Flash address
;
;Preconditions
;None
;
;Param
;flashAddr - Flash program memory location from which data has to be read
;
;Returns
;Data word read from given Flash address
;
;Example
;readWord as word
;flashAddr = 0x7D00
;
;readWord = FLASH_ReadWord_K42(flashAddr)
;
;Summary
;Writes a data byte into Flash
;
;Description
;This routine writes the given data byte into mentioned Flash address.
;
;This routine intially reads block of data (from Flash) into RAM, updates
;data values in RAM, and writes back updated values to Flash.
;
;Preconditions
;None
;
;Param
;flashAddr      - Flash program memory location to which data has to be written
;flashRdBufPtr -  RAM buffer of size 'ERASE_FLASH_BLOCKSIZE' at least
;byte           - Data byte to be written in Flash
;
;Returns
;None
;
;Example
;
;writeData = 0xAA
;flashAddr = 0x7D00
;MyBuffer(ERASE_FLASH_BLOCKSIZE)
;
;FLASH_WriteByte_K42(flashAddr, MyBuffer, writeData)
;Summary
;Writes data to complete block of Flash
;
;Description
;This routine writes data bytes to complete block in Flash program memory
;
;Preconditions
;None
;
;Param
;writeAddr      - A valid block starting address in Flash
;myBuffer        - An array of size 'WRITE_FLASH_BLOCKSIZE' at least
;Returns
;-1, if the given address is not a valid block starting address of Flash
;0, in case of valid block starting address
;Example
;#define FLASH_ROW_ADDRESS     0x7D00
;Dim myBuffer (
;0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
;0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
;0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
;0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F
;)
;write to Flash memory block
;FLASH_WriteBlock_K42( FLASH_ROW_ADDRESS, myBuffer )
;Summary
;Erases complete Flash program memory block
;
;Description
;This routine erases complete Flash program memory block
;
;Preconditions
;None
;
;Param
;baseAddr - A valid block starting address in Flash program memory
;
;Returns
;None
;
;Example
;flashBlockStartAddr = 0x7D00
;
;FLASH_EraseBlock_K42(flashBlockStartAddr)
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

FLASH_ERASEBLOCK_K42
;GIEBitValue = GIE   'Save interrupt enable
	bcf	SYSBITVAR0,0,BANKED
	btfsc	INTCON0,GIE,ACCESS
	bsf	SYSBITVAR0,0,BANKED
ENDIF8
;TBLPTRU = flashAddr_U
	movffl	FLASHADDR_U,TBLPTRU
;TBLPTRH = flashAddr_H
	movffl	FLASHADDR_H,TBLPTRH
;TBLPTRL = flashAddr
	movffl	FLASHADDR,TBLPTRL
;NVMREG1 = 1
	banksel	NVMCON1
	bsf	NVMCON1,NVMREG1,BANKED
;NVMREG0 = 0
	bcf	NVMCON1,NVMREG0,BANKED
;WREN = 1
	bsf	NVMCON1,WREN,BANKED
;FREE = 1
	bsf	NVMCON1,FREE,BANKED
	BCF	INTCON0,7
	BANKSEL	NVMCON1
	BSF	NVMCON1,2
	MOVLW	0x55
	MOVWF	NVMCON2
	MOVLW	0xAA
	MOVWF	NVMCON2
	BSF	NVMCON1,1
	BSF	INTCON0,7
	banksel	0
	return

;********************************************************************************

FN_FLASH_READBYTE_K42
;NVMREG1 = 1
	banksel	NVMCON1
	bsf	NVMCON1,NVMREG1,BANKED
;NVMREG0 = 0
	bcf	NVMCON1,NVMREG0,BANKED
;TBLPTRU = flashAddr_u
	movffl	FLASHADDR_U,TBLPTRU
;TBLPTRH = flashAddr_h
	movffl	FLASHADDR_H,TBLPTRH
;TBLPTRL = flashAddr
	movffl	FLASHADDR,TBLPTRL
	TBLRD
;FLASH_ReadByte_K42 = TABLAT
	movffl	TABLAT,FLASH_READBYTE_K42
	banksel	0
	return

;********************************************************************************

FN_FLASH_READWORD_K42
;FLASH_ReadWord_K42 = FLASH_ReadByte_K42( flashAddr )
	rcall	FN_FLASH_READBYTE_K42
	movff	FLASH_READBYTE_K42,FLASH_READWORD_K42
	clrf	FLASH_READWORD_K42_H,BANKED
;FLASH_ReadWord_K42_h = FLASH_ReadByte_K42( flashAddr + 1 )
	incf	FLASHADDR,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	FLASHADDR_H,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	FLASHADDR_U,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	FLASHADDR_E,F,BANKED
	rcall	FN_FLASH_READBYTE_K42
	movff	FLASH_READBYTE_K42,FLASH_READWORD_K42_H
	return

;********************************************************************************

FN_FLASH_WRITEBLOCK_K42
;dim blockStartAddr  as Long
;blockStartAddr= writeAddr & ((END_FLASH_K42-1) OR (ERASE_FLASH_BLOCKSIZE_K42-1))
	movff	WRITEADDR,BLOCKSTARTADDR
	movff	WRITEADDR_H,BLOCKSTARTADDR_H
	movlw	1
	andwf	WRITEADDR_U,W,BANKED
	movwf	BLOCKSTARTADDR_U,BANKED
	clrf	BLOCKSTARTADDR_E,BANKED
;Dim GIEBitValue as bit
;GIEBitValue = GIE     'Save interrupt enable
	bcf	SYSBITVAR0,0,BANKED
	btfsc	INTCON0,GIE,ACCESS
	bsf	SYSBITVAR0,0,BANKED
ENDIF7
;Flash write must start at the beginning of a row
;if writeAddr <> blockStartAddr then
	movff	WRITEADDR,SysLONGTempA
	movff	WRITEADDR_H,SysLONGTempA_H
	movff	WRITEADDR_U,SysLONGTempA_U
	movff	WRITEADDR_E,SysLONGTempA_E
	movff	BLOCKSTARTADDR,SysLONGTempB
	movff	BLOCKSTARTADDR_H,SysLONGTempB_H
	movff	BLOCKSTARTADDR_U,SysLONGTempB_U
	movff	BLOCKSTARTADDR_E,SysLONGTempB_E
	rcall	SysCompEqual32
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF3
;FLASH_WriteBlock_K42 = false
	clrf	FLASH_WRITEBLOCK_K42,BANKED
;exit function
	return
;end if
ENDIF3
;Block erase sequence
;FLASH_EraseBlock_K42(writeAddr)
	movff	WRITEADDR,FLASHADDR
	movff	WRITEADDR_H,FLASHADDR_H
	movff	WRITEADDR_U,FLASHADDR_U
	movff	WRITEADDR_E,FLASHADDR_E
	rcall	FLASH_ERASEBLOCK_K42
	movff	FLASHADDR,WRITEADDR
	movff	FLASHADDR_H,WRITEADDR_H
	movff	FLASHADDR_U,WRITEADDR_U
	movff	FLASHADDR_E,WRITEADDR_E
;Block write sequence
;TBLPTRU = writeAddr_U                               'Load Table point register
	movffl	WRITEADDR_U,TBLPTRU
;TBLPTRH = writeAddr_H
	movffl	WRITEADDR_H,TBLPTRH
;TBLPTRL = writeAddr
	movffl	WRITEADDR,TBLPTRL
;Write block of data
;dim writeloop as byte
;for writeloop = 0 to WRITE_FLASH_BLOCKSIZE_K42-1
	setf	WRITELOOP,BANKED
SysForLoop2
	incf	WRITELOOP,F,BANKED
;TABLAT = flashWrBufPtr(writeloop) ' Load data byte
	movf	WRITELOOP,W,BANKED
	addwf	SysFLASHWRBUFPTRHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysFLASHWRBUFPTRHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,TABLAT
;if writeloop = (WRITE_FLASH_BLOCKSIZE_K42-1) then
	movff	WRITELOOP,SysBYTETempA
	movlw	127
	movwf	SysBYTETempB,ACCESS
	rcall	SysCompEqual
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE5_1
	TBLWT
;else
ELSE5_1
	TBLWTPOSTINC
;end if
ENDIF5
;next
	movff	WRITELOOP,SysBYTETempA
	movlw	127
	movwf	SysBYTETempB,ACCESS
	rcall	SysCompLessThan
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop2
ENDIF6
SysForLoopEnd2
;NVMREG1 = 1
	banksel	NVMCON1
	bsf	NVMCON1,NVMREG1,BANKED
;NVMREG0 = 0
	bcf	NVMCON1,NVMREG0,BANKED
;WREN = 1
	bsf	NVMCON1,WREN,BANKED
	BCF	INTCON0,7
	BANKSEL	NVMCON1
	BSF	NVMCON1,2
	MOVLW	0x55
	MOVWF	NVMCON2
	MOVLW	0xAA
	MOVWF	NVMCON2
	BSF	NVMCON1,1
	BSF	INTCON0,7
	BCF	NVMCON1,2
;FLASH_WriteBlock_K42 = true
	banksel	FLASH_WRITEBLOCK_K42
	setf	FLASH_WRITEBLOCK_K42,BANKED
	return

;********************************************************************************

FLASH_WRITEBYTE_K42
;dim blockStartAddr  as Long
;blockStartAddr= flashAddr  & ((END_FLASH_K42-1) OR (ERASE_FLASH_BLOCKSIZE_K42-1))
	movff	FLASHADDR,BLOCKSTARTADDR
	movff	FLASHADDR_H,BLOCKSTARTADDR_H
	movlw	1
	andwf	FLASHADDR_U,W,BANKED
	movwf	BLOCKSTARTADDR_U,BANKED
	clrf	BLOCKSTARTADDR_E,BANKED
;Dim EEDataoffset as byte
;EEDataoffset = (flashAddr & (ERASE_FLASH_BLOCKSIZE_K42-1))
	movlw	127
	andwf	FLASHADDR,W,BANKED
	movwf	EEDATAOFFSET,BANKED
;Entire row will be erased, read and save the existing data
;dim writeloop as byte
;for writeloop = 0 to ERASE_FLASH_BLOCKSIZE_K42-1
	setf	WRITELOOP,BANKED
SysForLoop1
	incf	WRITELOOP,F,BANKED
;flashRdBufPtr(writeloop) = FLASH_ReadByte_K42(blockStartAddr+ writeloop )
	movf	WRITELOOP,W,BANKED
	addwf	BLOCKSTARTADDR,W,BANKED
	movwf	FLASHADDR,BANKED
	movlw	0
	addwfc	BLOCKSTARTADDR_H,W,BANKED
	movwf	FLASHADDR_H,BANKED
	movlw	0
	addwfc	BLOCKSTARTADDR_U,W,BANKED
	movwf	FLASHADDR_U,BANKED
	movlw	0
	addwfc	BLOCKSTARTADDR_E,W,BANKED
	movwf	FLASHADDR_E,BANKED
	rcall	FN_FLASH_READBYTE_K42
	movf	WRITELOOP,W,BANKED
	addwf	SysFLASHRDBUFPTRHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysFLASHRDBUFPTRHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	FLASH_READBYTE_K42,INDF0
;next
	movff	WRITELOOP,SysBYTETempA
	movlw	127
	movwf	SysBYTETempB,ACCESS
	rcall	SysCompLessThan
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop1
ENDIF2
SysForLoopEnd1
;Load byte at offset
;flashRdBufPtr( EEDataoffset ) = EEDatabyte
	movf	EEDATAOFFSET,W,BANKED
	addwf	SysFLASHRDBUFPTRHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysFLASHRDBUFPTRHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	EEDATABYTE,INDF0
;Writes buffer contents to current block
;FLASH_WriteBlock_K42(blockStartAddr, flashRdBufPtr)
	movff	BLOCKSTARTADDR,WRITEADDR
	movff	BLOCKSTARTADDR_H,WRITEADDR_H
	movff	BLOCKSTARTADDR_U,WRITEADDR_U
	movff	BLOCKSTARTADDR_E,WRITEADDR_E
	movff	SysFLASHRDBUFPTRHandler,SysFLASHWRBUFPTRHandler
	movff	SysFLASHRDBUFPTRHandler_H,SysFLASHWRBUFPTRHandler_H
	bra	FN_FLASH_WRITEBLOCK_K42

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


 END
