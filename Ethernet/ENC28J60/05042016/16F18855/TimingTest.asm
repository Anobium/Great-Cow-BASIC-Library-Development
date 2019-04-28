;Program compiled by Great Cow BASIC (0.95 2016-03-13)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F18855, r=DEC
#include <P16F18855.inc>
 __CONFIG _CONFIG1, _FEXTOSC_OFF & _RSTOSC_HFINT32
 __CONFIG _CONFIG2, _CPD_ON & _WRT_OFF & _MCLRE_ON
 __CONFIG _CONFIG3, _WDTE_OFF
 __CONFIG _CONFIG4, _LVP_OFF

;********************************************************************************

;Set aside memory locations for variables
BUFFER1	EQU	9193
BUFFER2	EQU	9188
BITIN	EQU	32
FNNOTBIT	EQU	33
SYSBITVAR0	EQU	34

;********************************************************************************

;Alias variables
SYSBUFFER1_1	EQU	1610
SYSBUFFER1_2	EQU	1611
SYSBUFFER1_3	EQU	1612
SYSBUFFER1_4	EQU	1613
SYSBUFFER2_1	EQU	1605
SYSBUFFER2_2	EQU	1606
SYSBUFFER2_3	EQU	1607
SYSBUFFER2_4	EQU	1608

;********************************************************************************

;Vectors
	ORG	0
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
;UNLOCKPPS
;dim IntState as bit
;IntState = GIE
	bcf	SYSBITVAR0,0
	btfsc	INTCON,GIE
	bsf	SYSBITVAR0,0
;GIE = 0
	bcf	INTCON,GIE
;PPSLOCK = 0x55
	movlw	85
	banksel	PPSLOCK
	movwf	PPSLOCK
;PPSLOCK = 0xAA
	movlw	170
	movwf	PPSLOCK
;PPSLOCKED = 0x00 	'unlock PPS
	bcf	PPSLOCK,PPSLOCKED
;RC0PPS = 0x0010		  'RC0->EUSART:TX;
	movlw	16
	banksel	RC0PPS
	movwf	RC0PPS
;RXPPS  = 0x0011 		'RC1->EUSART:RX;
	movlw	17
	banksel	RXPPS
	movwf	RXPPS
;RB3PPS = 0x0014     'RB3->MSSP1:SCK1;
	movlw	20
	banksel	RB3PPS
	movwf	RB3PPS
;SSP1CLKPPS = 0x000B 'RB3->MSSP1:SCK1;
	movlw	11
	banksel	SSP1CLKPPS
	movwf	SSP1CLKPPS
;SSP1DATPPS = 0x000C 'RB4->MSSP1:SDI1;
	movlw	12
	movwf	SSP1DATPPS
;RB5PPS = 0x0015     'RB5->MSSP1:SDO1;
	movlw	21
	banksel	RB5PPS
	movwf	RB5PPS
;LOCKPPS
;PPSLOCK = 0x55
	movlw	85
	banksel	PPSLOCK
	movwf	PPSLOCK
;PPSLOCK = 0xAA
	movlw	170
	movwf	PPSLOCK
;PPSLOCKED = 0x01  'lock PPS
	bsf	PPSLOCK,PPSLOCKED
;GIE = IntState
	bcf	INTCON,GIE
	banksel	SYSBITVAR0
	btfsc	SYSBITVAR0,0
	bsf	INTCON,GIE
;#define USART_BAUD_RATE 9600
;#define USART_BLOCKING
;#define USART_TX_BLOCKING
;dim buffer1(4)
;dim buffer2(4)
;buffer1=1,2,3,4
	movlw	low BUFFER1
	movwf	FSR0L
	movlw	high BUFFER1
	movwf	FSR0H
	movlw	4
	movwf	INDF0
	incf	FSR0L,F
	movlw	1
	movwf	INDF0
	incf	FSR0L,F
	movlw	2
	movwf	INDF0
	incf	FSR0L,F
	movlw	3
	movwf	INDF0
	incf	FSR0L,F
	movlw	4
	movwf	INDF0
;buffer2=1,2,3,4
	movlw	low BUFFER2
	movwf	FSR0L
	movlw	high BUFFER2
	movwf	FSR0H
	movlw	4
	movwf	INDF0
	incf	FSR0L,F
	movlw	1
	movwf	INDF0
	incf	FSR0L,F
	movlw	2
	movwf	INDF0
	incf	FSR0L,F
	movlw	3
	movwf	INDF0
	incf	FSR0L,F
	movlw	4
	movwf	INDF0
;dir portc.7 out
	bcf	TRISC,7
;do Forever
SysDoLoop_S1
;if buffer1(1)=buffer2(1) then
	banksel	SYSBUFFER2_1
	movf	SYSBUFFER2_1,W
	subwf	SYSBUFFER1_1,W
	btfss	STATUS, Z
	goto	ENDIF1
;if buffer1(2)=buffer2(2) then
	movf	SYSBUFFER2_2,W
	subwf	SYSBUFFER1_2,W
	btfss	STATUS, Z
	goto	ENDIF2
;if buffer1(3)=buffer2(3) then
	movf	SYSBUFFER2_3,W
	subwf	SYSBUFFER1_3,W
	btfss	STATUS, Z
	goto	ENDIF3
;if buffer1(4)=buffer2(4) then
	movf	SYSBUFFER2_4,W
	subwf	SYSBUFFER1_4,W
	btfss	STATUS, Z
	goto	ENDIF4
;setwith ( portc.7, FnNotBit ( portc.7) )
;if Source then
	banksel	BITIN
	clrf	BITIN
	btfsc	PORTC,7
	incf	BITIN,F
	call	FN_FNNOTBIT
	btfss	FNNOTBIT
	goto	ELSE5_1
;TargetBit = 1
	bsf	LATC,7
;else
	goto	ENDIF5
ELSE5_1
;TargetBit = 0
	bcf	LATC,7
;end if
ENDIF5
;end if
ENDIF4
;end if
ENDIF3
;end if
ENDIF2
;end if
ENDIF1
;loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;dim bufferethermac Alias SYSBUFFER1_1, SYSBUFFER1_2, SYSBUFFER1_3, SYSBUFFER1_4 as long
;dim myethermac Alias SYSBUFFER2_1, SYSBUFFER2_3 , SYSBUFFER2_3 , SYSBUFFER2_4 as long
;bufferethermac = 1
;myethermac = 1
;portc.7 = 1
;'4.720us
;do Forever
;if 1 = 1 Then
;setwith ( portc.7, FnNotBit ( portc.7) )
;end if
;loop
;
;portc.7 = 1
;'14.70us
;do Forever
;if bufferethermac = myethermac Then
;setwith ( portc.7, FnNotBit ( portc.7) )
;end if
;loop
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

FN_FNNOTBIT
;If BitIn then
	movf	BITIN,F
	btfsc	STATUS,Z
	goto	ELSE9_1
;FnNOTBit = 0
	bcf	FNNOTBIT
;Else
	goto	ENDIF9
ELSE9_1
;FnNOTBit = 1
	bsf	FNNOTBIT
;End If
ENDIF9
	return

;********************************************************************************

INITSYS
;SET ADCON0.ADON OFF
	banksel	ADCON0
	bcf	ADCON0,ADON
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELC = 0
	clrf	ANSELC
;C2ON = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2ON
;C1ON = 0
	bcf	CM1CON0,C1ON
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

;Start of program memory page 1
	ORG	2048
;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144

 END
