;Program compiled by Great Cow BASIC (0.94 2015-08-05)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F66J60, r=DEC
#include <P18F66J60.inc>
 CONFIG ETHLED = ON, WDT = OFF

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
;Automatic pin direction setting
	bcf	TRISE,4,ACCESS

;Start of the main program
;Chip Settings
;Dir PORTB.1 In
	bsf	TRISB,1,ACCESS
;If PORTB.1 = 1 Then
	btfsc	PORTB,1,ACCESS
;Set PORTE.4 On
	bsf	LATE,4,ACCESS
;End If
;If PORTB.1 = 0 Then
	btfss	PORTB,1,ACCESS
;Set PORTE.4 Off
	bcf	LATE,4,ACCESS
;End If
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

INITSYS
;BSR = 0
	clrf	BSR,ACCESS
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;SET ADFM OFF
	bcf	ADCON2,ADFM,ACCESS
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
;CMCON = 7
	movlw	7
	movwf	CMCON,ACCESS
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
;PORTF = 0
	clrf	PORTF,ACCESS
;PORTG = 0
	clrf	PORTG,ACCESS
	return

;********************************************************************************


 END
