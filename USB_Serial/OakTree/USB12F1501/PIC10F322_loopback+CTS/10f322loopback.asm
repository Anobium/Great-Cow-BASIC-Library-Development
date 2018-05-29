        radix   DEC
        
#include "p10f322.inc"
        
xtal    EQU     8000000         ; you may also want to change: _HS_OSC _XT_OSC
baud    EQU     9600            ; standard TinyBld baud rates: 115200 or 19200

        #define TX      0
	#define CTS     1
        #define RX      2

        __CONFIG        _FOSC_INTOSC & _BOREN_OFF & _WDTE_SWDTEN & _PWRTE_ON & _MCLRE_OFF & _CP_OFF & _LVP_OFF & _LPBOR_OFF & _BORV_HI & _WRT_OFF

;       errorlevel 1, -305              ; suppress warning msg that takes f as default

        cblock 0x7E
	cn		;0x7E
	rxd		;0x7F
        endc

                org     0x0000
		clrf    ANSELA          ; digital I/O
                bcf     TRISA,TX        ; set TX Port
		bsf	LATA,TX

RcvL:

                btfsc   PORTA,RX
                goto	RcvL

		call    bwait2		; wait 1/2 bit and W=9
                movwf   cn		; cn=9
                rrf     rxd,f		; get bit data
		call    bwait   	; wait 1bit and Carry=1
                btfss   PORTA,RX
                bcf     STATUS,C
		decfsz	cn,f		; cn=0?
                goto    $-5		; loop

SendL:

		btfsc   PORTA,CTS
		goto	SendL

		call	bout+3	; send start bit
		movwf	cn	; cn=9
		rrf     rxd,f	; set Carry		; 1
                call    bout	; wait 1bit and Carry=1	; 2+1+1+1+1+8N+6=8N+12
                decfsz  cn,f	; send 10bits?		; 1
                goto    $-3	; loop			; 2(1) total:1+8N+12+1+2=8N+16

		goto	RcvL

bout:
                btfsc   STATUS,C
                bsf     LATA,TX
                btfss   STATUS,C
                bcf     LATA,TX

bwait:				; wait 1 bit
		call	bwait2				; 2+(4N+2)+(4N+2)=8N+6
bwait2:				; wait 1/2bit and Set Carry=1
		movlw   .256-((xtal/.4)/baud-.15)/.8	; 1
                addlw   0x01           			; 1
                btfss	STATUS,Z        		; 1
                goto    $-2             		; 2(1)
		retlw	0x09				; 2 total:1+(1+1+2)*N-1+2=4N+2

                end
