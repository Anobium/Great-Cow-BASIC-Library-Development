;Program compiled by Great Cow BASIC (0.98.<<>> 2018-07-19)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F24K42, r=DEC
#include <P18F24K42.inc>
 CONFIG LVP = OFF, WDTE = OFF, MVECEN = OFF, MCLRE = EXTMCLR, RSTOSC = HFINTOSC_1MHZ

;********************************************************************************

;Set aside memory locations for variables
BLOCKSTARTADDR	EQU	13
BLOCKSTARTADDR_E	EQU	16
BLOCKSTARTADDR_H	EQU	14
BLOCKSTARTADDR_U	EQU	15
COMPORT	EQU	4
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
EEDATA	EQU	17
EEDATABUFFER	EQU	893
EEDATABYTE	EQU	18
EEDATAOFFSET	EQU	19
FLASHADDR	EQU	20
FLASHADDR_E	EQU	23
FLASHADDR_H	EQU	21
FLASHADDR_U	EQU	22
FLASH_READBYTE_K42	EQU	24
FLASH_READWORD_K42	EQU	25
FLASH_READWORD_K42_H	EQU	26
FLASH_WRITEBLOCK_K42	EQU	27
MYBYTE	EQU	28
MYFLASHADDRESS	EQU	29
MYFLASHADDRESS_E	EQU	32
MYFLASHADDRESS_H	EQU	30
MYFLASHADDRESS_U	EQU	31
MYWORD	EQU	33
MYWORD_H	EQU	34
NVMADRH	EQU	35
PRINTLEN	EQU	36
SERDATA	EQU	37
STRINGPOINTER	EQU	38
SYSBITVAR0	EQU	39
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSEEADDRESS	EQU	40
SYSEEADDRESS_H	EQU	41
SYSEEPROMADDRESS	EQU	42
SYSEEPROMADDRESS_H	EQU	43
SYSFLASHRDBUFPTRHANDLER	EQU	44
SYSFLASHRDBUFPTRHANDLER_H	EQU	45
SYSFLASHWRBUFPTRHANDLER	EQU	46
SYSFLASHWRBUFPTRHANDLER_H	EQU	47
SYSLONGTEMPA	EQU	5
SYSLONGTEMPA_E	EQU	8
SYSLONGTEMPA_H	EQU	6
SYSLONGTEMPA_U	EQU	7
SYSLONGTEMPB	EQU	9
SYSLONGTEMPB_E	EQU	12
SYSLONGTEMPB_H	EQU	10
SYSLONGTEMPB_U	EQU	11
SYSPRINTDATAHANDLER	EQU	48
SYSPRINTDATAHANDLER_H	EQU	49
SYSPRINTTEMP	EQU	50
SYSREPEATTEMP1	EQU	51
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	884
SYSTEMP1	EQU	52
SYSTEMP1_H	EQU	53
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
WRITEADDR	EQU	54
WRITEADDR_E	EQU	57
WRITEADDR_H	EQU	55
WRITEADDR_U	EQU	56
WRITELOOP	EQU	58

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
	rcall	INITUSART
;Automatic pin direction setting
	bcf	TRISA,0,ACCESS

;Start of the main program
;Public are following methods v1.04
;FLASH_ReadByte_K42
;FLASH_ReadWord_K42
;FLASH_WriteByte_K42
;#define WRITE_FLASH_BLOCKSIZE_K42    128
;#define ERASE_FLASH_BLOCKSIZE_K42    128
;#define END_FLASH_K42                0x004000   'Some devices have more memory. Please check the datasheet
;dim EEDataBuffer( WRITE_FLASH_BLOCKSIZE_K42 )
;#define USART_BAUD_RATE 9600
;#define USART_TX_BLOCKING
;HSerPrintStringCRLF "K42 Test"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTSTRINGCRLF
;User code starts here.
;dim myFlashAddress as long
;myFlashAddress = 0x003FFF
	setf	MYFLASHADDRESS,BANKED
	movlw	63
	movwf	MYFLASHADDRESS_H,BANKED
	clrf	MYFLASHADDRESS_U,BANKED
	clrf	MYFLASHADDRESS_E,BANKED
;myByte = 0xAA  ' the test byte to write
	movlw	170
	movwf	MYBYTE,BANKED
;FLASH_WriteByte_K42( myFlashAddress, EEDataBuffer, myByte )
	movff	MYFLASHADDRESS,FLASHADDR
	movff	MYFLASHADDRESS_H,FLASHADDR_H
	movff	MYFLASHADDRESS_U,FLASHADDR_U
	movff	MYFLASHADDRESS_E,FLASHADDR_E
	movlw	low EEDATABUFFER
	movwf	SysFLASHRDBUFPTRHandler,BANKED
	movlw	high EEDATABUFFER
	movwf	SysFLASHRDBUFPTRHandler_H,BANKED
	movff	MYBYTE,EEDATABYTE
	rcall	FLASH_WRITEBYTE_K42
	movff	FLASHADDR,MYFLASHADDRESS
	movff	FLASHADDR_H,MYFLASHADDRESS_H
	movff	FLASHADDR_U,MYFLASHADDRESS_U
	movff	FLASHADDR_E,MYFLASHADDRESS_E
	movff	EEDATABYTE,MYBYTE
;dim mybyte as Byte
;myFlashAddress = 0x003FFF
	setf	MYFLASHADDRESS,BANKED
	movlw	63
	movwf	MYFLASHADDRESS_H,BANKED
	clrf	MYFLASHADDRESS_U,BANKED
	clrf	MYFLASHADDRESS_E,BANKED
;mybyte = FLASH_ReadByte_K42  ( myFlashAddress )
	movff	MYFLASHADDRESS,FLASHADDR
	movff	MYFLASHADDRESS_H,FLASHADDR_H
	movff	MYFLASHADDRESS_U,FLASHADDR_U
	movff	MYFLASHADDRESS_E,FLASHADDR_E
	rcall	FN_FLASH_READBYTE_K42
	movff	FLASH_READBYTE_K42,MYBYTE
;myFlashAddress = 0x003FFE
	movlw	254
	movwf	MYFLASHADDRESS,BANKED
	movlw	63
	movwf	MYFLASHADDRESS_H,BANKED
	clrf	MYFLASHADDRESS_U,BANKED
	clrf	MYFLASHADDRESS_E,BANKED
;FLASH_WriteByte_K42( myFlashAddress, EEDataBuffer, myByte - 1 )
	movff	MYFLASHADDRESS,FLASHADDR
	movff	MYFLASHADDRESS_H,FLASHADDR_H
	movff	MYFLASHADDRESS_U,FLASHADDR_U
	movff	MYFLASHADDRESS_E,FLASHADDR_E
	movlw	low EEDATABUFFER
	movwf	SysFLASHRDBUFPTRHandler,BANKED
	movlw	high EEDATABUFFER
	movwf	SysFLASHRDBUFPTRHandler_H,BANKED
	decf	MYBYTE,W,BANKED
	movwf	EEDATABYTE,BANKED
	rcall	FLASH_WRITEBYTE_K42
	movff	FLASHADDR,MYFLASHADDRESS
	movff	FLASHADDR_H,MYFLASHADDRESS_H
	movff	FLASHADDR_U,MYFLASHADDRESS_U
	movff	FLASHADDR_E,MYFLASHADDRESS_E
;EPWrite 0x00, myByte
	clrf	SYSEEADDRESS,BANKED
	clrf	SYSEEADDRESS_H,BANKED
	movff	MYBYTE,EEDATA
	rcall	NVMADR_EPWRITE
;myFlashAddress = 0x003FFE
	movlw	254
	movwf	MYFLASHADDRESS,BANKED
	movlw	63
	movwf	MYFLASHADDRESS_H,BANKED
	clrf	MYFLASHADDRESS_U,BANKED
	clrf	MYFLASHADDRESS_E,BANKED
;dim myword as Word
;myword = FLASH_ReadWord_K42 ( myFlashAddress )
	movff	MYFLASHADDRESS,FLASHADDR
	movff	MYFLASHADDRESS_H,FLASHADDR_H
	movff	MYFLASHADDRESS_U,FLASHADDR_U
	movff	MYFLASHADDRESS_E,FLASHADDR_E
	rcall	FN_FLASH_READWORD_K42
	movff	FLASH_READWORD_K42,MYWORD
	movff	FLASH_READWORD_K42_H,MYWORD_H
;EPWrite 0x10, myword_h
	movlw	16
	movwf	SYSEEADDRESS,BANKED
	clrf	SYSEEADDRESS_H,BANKED
	movff	MYWORD_H,EEDATA
	rcall	NVMADR_EPWRITE
;EPWrite 0x11, myword
	movlw	17
	movwf	SYSEEADDRESS,BANKED
	clrf	SYSEEADDRESS_H,BANKED
	movff	MYWORD,EEDATA
	rcall	NVMADR_EPWRITE
;Repeat 10
	movlw	10
	movwf	SysRepeatTemp1,BANKED
SysRepeatLoop1
;pulseout porta.0, 900 ms
;Set Pin On
	bsf	LATA,0,ACCESS
;Wait Time
	movlw	132
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set Pin Off
	bcf	LATA,0,ACCESS
;wait 100 ms
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;end Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;end
	bra	BASPROGRAMEND
;User code ends here.
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
;#define FLASH_ROW_ADDRESS     0x3D00
;
;You will have to sort this data array in your code if your were to preload the FlashMemory
;Dim EEDataBuffer (
;0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
;0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
;0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
;0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F
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

FLASH_ERASEBLOCK_K42
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
;IntOff
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
;IntOn
	banksel	0
	return

;********************************************************************************

FN_FLASH_READBYTE_K42
;NVMREG1 = 1
	banksel	NVMCON1
	bsf	NVMCON1,NVMREG1,BANKED
;NVMREG0 = 0
	bcf	NVMCON1,NVMREG0,BANKED
;RD = 1
	bsf	NVMCON1,RD,BANKED
;TBLPTRU = flashAddr_u
	movffl	FLASHADDR_U,TBLPTRU
;TBLPTRH = flashAddr_h
	movffl	FLASHADDR_H,TBLPTRH
;TBLPTRL = flashAddr
	movffl	FLASHADDR,TBLPTRL
;TBLRD*
	tblrd*
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
;FLASH_ReadWord_K42_h = FLASH_ReadByte_K42( [long]flashAddr + 1 )
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
;blockStartAddr= writeAddr & ((END_FLASH_K42-1) XOR (ERASE_FLASH_BLOCKSIZE_K42-1))
	movlw	128
	andwf	WRITEADDR,W,BANKED
	movwf	BLOCKSTARTADDR,BANKED
	movlw	63
	andwf	WRITEADDR_H,W,BANKED
	movwf	BLOCKSTARTADDR_H,BANKED
	clrf	BLOCKSTARTADDR_U,BANKED
	clrf	BLOCKSTARTADDR_E,BANKED
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
;TBLWT*
	tblwt*
;else
	bra	ENDIF5
ELSE5_1
;TBLWT*+
	tblwt*+
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
;INTOFF
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
SysWaitLoop1
	btfsc	NVMCON1,WR,BANKED
	bra	SysWaitLoop1
;WREN = 0
	bcf	NVMCON1,WREN,BANKED
;INTON
;FLASH_WriteBlock_K42 = true
	banksel	FLASH_WRITEBLOCK_K42
	setf	FLASH_WRITEBLOCK_K42,BANKED
	return

;********************************************************************************

FLASH_WRITEBYTE_K42
;dim blockStartAddr  as Long
;blockStartAddr= flashAddr  & ((END_FLASH_K42-1) XOR (ERASE_FLASH_BLOCKSIZE_K42-1))
	movlw	128
	andwf	FLASHADDR,W,BANKED
	movwf	BLOCKSTARTADDR,BANKED
	movlw	63
	andwf	FLASHADDR_H,W,BANKED
	movwf	BLOCKSTARTADDR_H,BANKED
	clrf	BLOCKSTARTADDR_U,BANKED
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

HSERPRINTSTRINGCRLF
;PrintLen = LEN(PrintData$)
;PrintLen = PrintData(0)
	movffl	SysPRINTDATAHandler,AFSR0
	movffl	SysPRINTDATAHandler_H,AFSR0_H
	movffl	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF10
;Write Data
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd3
ENDIF11
SysForLoop3
	incf	SYSPRINTTEMP,F,BANKED
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,BANKED
	addwf	SysPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,SERDATA
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;next
	movf	PRINTLEN,W,BANKED
	subwf	SYSPRINTTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
ENDIF12
SysForLoopEnd3
;End If
ENDIF10
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	bra	Delay_MS

;********************************************************************************

HSERSEND
;Block before sending (if needed)
;Send byte
;if comport = 1 Then
	decf	COMPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF13
;HSerSendBlocker
;Wait While U1TXIF = Off
SysWaitLoop4
	banksel	PIR3
	btfss	PIR3,U1TXIF,BANKED
	bra	SysWaitLoop4
;U1TXB = SerData
	movffl	SERDATA,U1TXB
;end if
ENDIF13
	banksel	0
	return

;********************************************************************************

INITPPS
;Module: UART1
;RC6PPS = 0x0013     'TX1 > RC6
	movlw	19
	banksel	RC6PPS
	movwf	RC6PPS,BANKED
;U1RXPPS = 0x0017    'RC7 > RX1
	movlw	23
	movwf	U1RXPPS,BANKED
;Setup Serial port
	banksel	0
	return

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

INITUSART
;Set the default value for comport
;comport = 1
	movlw	1
	movwf	COMPORT,BANKED
;Set baud rate for legacy chips
;for 18fxxK42 series UART
;U1BRGH=SPBRGH_TEMP
	movlw	3
	banksel	U1BRGH
	movwf	U1BRGH,BANKED
;U1BRGL=SPBRGL_TEMP
	movlw	64
	movwf	U1BRGL,BANKED
;U1BRGS = BRGS1_SCRIPT
	bsf	U1CON0,U1BRGS,BANKED
;U1TXEN=1
	bsf	U1CON0,U1TXEN,BANKED
;U1RXEN=1
	bsf	U1CON0,U1RXEN,BANKED
;ON_U1CON1=1
	bsf	U1CON1,ON_U1CON1,BANKED
;Enable async mode
;Set SYNC Off
	banksel	CM1CON0
	bcf	CM1CON0,SYNC,BANKED
;Enable TX and RX
;Set TXEN On
	banksel	U1CON0
	bsf	U1CON0,TXEN,BANKED
;PIC USART 2 Init
	banksel	0
	return

;********************************************************************************

NVMADR_EPWRITE
;dim IntState as bit
;IntState = GIE
	bcf	SYSBITVAR0,1,BANKED
	btfsc	INTCON0,GIE,ACCESS
	bsf	SYSBITVAR0,1,BANKED
ENDIF7
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
SysWaitLoop3
	btfsc	NVMCON1,WR,BANKED
	bra	SysWaitLoop3
;WREN = 0
	bcf	NVMCON1,WREN,BANKED
;Restore interrupt to initial  State
;GIE = IntState
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,1,BANKED
	bcf	INTCON0,GIE,ACCESS
ENDIF8
	btfsc	SYSBITVAR0,1,BANKED
	bsf	INTCON0,GIE,ACCESS
ENDIF9
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
	db	8,75,52,50,32,84,101,115,116


;********************************************************************************


 END
