;Program compiled by Great Cow BASIC (0.98.<<>> 2018-07-19)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1938, r=DEC
#include <P16F1938.inc>
 __CONFIG _CONFIG1, _MCLRE_OFF & _WDTE_OFF & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_OFF

;********************************************************************************

;Set aside memory locations for variables
MYFLASHADDRESS	EQU	32
MYFLASHADDRESS_E	EQU	35
MYFLASHADDRESS_H	EQU	33
MYFLASHADDRESS_U	EQU	34
MYWORD	EQU	36
MYWORD_H	EQU	37

;********************************************************************************

;Alias variables
EEADDRESS	EQU	401
EEADDRESS_H	EQU	402
EEDATAVALUE	EQU	403
EEDATAWORD	EQU	403
EEDATAWORD_H	EQU	404

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

;Start of the main program
;Public are following methods v1.04
;FLASH_ReadByte
;FLASH_ReadWord
;FLASH_WriteByte
;#include "D:\Great-Cow-BASIC-Library-Development\trunk\PICDataMethods\PICFlashDataMethods.h"
;User code starts here.
;dim myWord as word
;myWord = 0xAABB  ' the test word to write & 16383, so, therefore 0x2ABB is written. See the Help
	movlw	187
	movwf	MYWORD
	movlw	170
	movwf	MYWORD_H
;dim myFlashAddress as long
;myFlashAddress = 0x3FA0
	movlw	160
	movwf	MYFLASHADDRESS
	movlw	63
	movwf	MYFLASHADDRESS_H
	clrf	MYFLASHADDRESS_U
	clrf	MYFLASHADDRESS_E
;ProgramWrite ( myFlashAddress, myWord )
	movf	MYFLASHADDRESS,W
	banksel	EEADDRESS
	movwf	EEADDRESS
	banksel	MYFLASHADDRESS_H
	movf	MYFLASHADDRESS_H,W
	banksel	EEADDRESS_H
	movwf	EEADDRESS_H
	banksel	MYWORD
	movf	MYWORD,W
	banksel	EEDATAWORD
	movwf	EEDATAWORD
	banksel	MYWORD_H
	movf	MYWORD_H,W
	banksel	EEDATAWORD_H
	movwf	EEDATAWORD_H
	banksel	STATUS
	call	PROGRAMWRITE
;myWord++
	incf	MYWORD,F
	btfsc	STATUS,Z
	incf	MYWORD_H,F
;myFlashAddress = 0x3FA1
	movlw	161
	movwf	MYFLASHADDRESS
	movlw	63
	movwf	MYFLASHADDRESS_H
	clrf	MYFLASHADDRESS_U
	clrf	MYFLASHADDRESS_E
;ProgramWrite ( myFlashAddress, myWord )
	movf	MYFLASHADDRESS,W
	banksel	EEADDRESS
	movwf	EEADDRESS
	banksel	MYFLASHADDRESS_H
	movf	MYFLASHADDRESS_H,W
	banksel	EEADDRESS_H
	movwf	EEADDRESS_H
	banksel	MYWORD
	movf	MYWORD,W
	banksel	EEDATAWORD
	movwf	EEDATAWORD
	banksel	MYWORD_H
	movf	MYWORD_H,W
	banksel	EEDATAWORD_H
	movwf	EEDATAWORD_H
	banksel	STATUS
	call	PROGRAMWRITE
;myFlashAddress = 0x3FA0
	movlw	160
	movwf	MYFLASHADDRESS
	movlw	63
	movwf	MYFLASHADDRESS_H
	clrf	MYFLASHADDRESS_U
	clrf	MYFLASHADDRESS_E
;ProgramRead  ( myFlashAddress, myWord )
	movf	MYFLASHADDRESS,W
	banksel	EEADDRESS
	movwf	EEADDRESS
	banksel	MYFLASHADDRESS_H
	movf	MYFLASHADDRESS_H,W
	banksel	EEADDRESS_H
	movwf	EEADDRESS_H
	banksel	STATUS
	call	PROGRAMREAD
	banksel	EEDATAWORD
	movf	EEDATAWORD,W
	banksel	MYWORD
	movwf	MYWORD
	banksel	EEDATAWORD_H
	movf	EEDATAWORD_H,W
	banksel	MYWORD_H
	movwf	MYWORD_H
;EPWrite 0x00, myWord_h
	banksel	EEADDRESS
	clrf	EEADDRESS
	clrf	EEADDRESS_H
	banksel	MYWORD_H
	movf	MYWORD_H,W
	banksel	EEDATAVALUE
	movwf	EEDATAVALUE
	banksel	STATUS
	call	EPWRITE
;EPWrite 0x01, myWord
	movlw	1
	banksel	EEADDRESS
	movwf	EEADDRESS
	clrf	EEADDRESS_H
	banksel	MYWORD
	movf	MYWORD,W
	banksel	EEDATAVALUE
	movwf	EEDATAVALUE
	banksel	STATUS
	call	EPWRITE
;myFlashAddress = 0x3FA1
	movlw	161
	movwf	MYFLASHADDRESS
	movlw	63
	movwf	MYFLASHADDRESS_H
	clrf	MYFLASHADDRESS_U
	clrf	MYFLASHADDRESS_E
;ProgramRead  ( myFlashAddress, myWord )
	movf	MYFLASHADDRESS,W
	banksel	EEADDRESS
	movwf	EEADDRESS
	banksel	MYFLASHADDRESS_H
	movf	MYFLASHADDRESS_H,W
	banksel	EEADDRESS_H
	movwf	EEADDRESS_H
	banksel	STATUS
	call	PROGRAMREAD
	banksel	EEDATAWORD
	movf	EEDATAWORD,W
	banksel	MYWORD
	movwf	MYWORD
	banksel	EEDATAWORD_H
	movf	EEDATAWORD_H,W
	banksel	MYWORD_H
	movwf	MYWORD_H
;EPWrite 0x02, myWord_h
	movlw	2
	banksel	EEADDRESS
	movwf	EEADDRESS
	clrf	EEADDRESS_H
	banksel	MYWORD_H
	movf	MYWORD_H,W
	banksel	EEDATAVALUE
	movwf	EEDATAVALUE
	banksel	STATUS
	call	EPWRITE
;EPWrite 0x03, myWord
	movlw	3
	banksel	EEADDRESS
	movwf	EEADDRESS
	clrf	EEADDRESS_H
	banksel	MYWORD
	movf	MYWORD,W
	banksel	EEDATAVALUE
	movwf	EEDATAVALUE
	banksel	STATUS
	call	EPWRITE
;end
	goto	BASPROGRAMEND
;User code ends here.
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

EPWRITE
;Variable alias
;Dim EEAddress As Word Alias EEADRH, EEADR
;Dim EEDataValue Alias EEDATL_REF
;Disable interrupt
;IntOff
;Select data memory
;SET EEPGD OFF
	banksel	EECON1
	bcf	EECON1,EEPGD
;Set CFGS OFF
	bcf	EECON1,CFGS
;Start write
;SET WREN ON
	bsf	EECON1,WREN
;EECON2 = 0x55
	movlw	85
	movwf	EECON2
;EECON2 = 0xAA
	movlw	170
	movwf	EECON2
;SET WR ON
	bsf	EECON1,WR
;SET WREN OFF
	bcf	EECON1,WREN
;Wait for write to complete
;WAIT WHILE WR ON
SysWaitLoop1
	btfsc	EECON1,WR
	goto	SysWaitLoop1
;SET WREN OFF
	bcf	EECON1,WREN
;Restore interrupt
;IntOn
	banksel	STATUS
	return

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
;PORTE = 0
	clrf	PORTE
	return

;********************************************************************************

PROGRAMREAD
;Dim EEAddress As Word Alias EEADRH, EEADR
;Dim EEDataWord As Word Alias EEDATH, EEDATL_REF
;Disable Interrupt
;IntOff
;Select program memory
;SET EEPGD ON
	banksel	EECON1
	bsf	EECON1,EEPGD
;Set CFGS OFF
	bcf	EECON1,CFGS
;Start read, wait for it to finish
;SET RD ON
	bsf	EECON1,RD
;NOP
	nop
;NOP
	nop
;Enable interrupt
;IntOn
	banksel	STATUS
	return

;********************************************************************************

PROGRAMWRITE
;Dim EEAddress As Word Alias EEADRH, EEADR
;Dim EEDataWord As Word Alias EEDATH, EEDATL_REF
;Disable Interrupt
;IntOff
;Select program memory
;SET EEPGD ON
	banksel	EECON1
	bsf	EECON1,EEPGD
;Set CFGS OFF
	bcf	EECON1,CFGS
;Enable write
;SET WREN ON
	bsf	EECON1,WREN
;SET FREE OFF
	bcf	EECON1,FREE
;Write enable code
;EECON2 = 0x55
	movlw	85
	movwf	EECON2
;EECON2 = 0xAA
	movlw	170
	movwf	EECON2
;Start write, wait for it to finish
;SET WR ON
	bsf	EECON1,WR
;NOP
	nop
;NOP
	nop
;SET WREN OFF
	bcf	EECON1,WREN
;Enable Interrupt
;IntOn
	banksel	STATUS
	return

;********************************************************************************

;Start of program memory page 1
	ORG	2048
;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144
;Start of program memory page 4
	ORG	8192
;Start of program memory page 5
	ORG	10240
;Start of program memory page 6
	ORG	12288
;Start of program memory page 7
	ORG	14336

 END
