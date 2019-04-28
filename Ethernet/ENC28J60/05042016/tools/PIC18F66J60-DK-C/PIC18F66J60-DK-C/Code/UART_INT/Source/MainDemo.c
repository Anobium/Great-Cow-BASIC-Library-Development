/*********************************************************************
 *
 *  Main Application Entry Point and TCP/IP Stack Demo
 *  Module for Microchip TCP/IP Stack
 *   -Demonstrates how to call and use the Microchip TCP/IP stack
 *	 -Reference: AN833
 *
 *********************************************************************
 * FileName:        MainDemo.c
 * Dependencies:    string.H
 *                  StackTsk.h
 *                  Tick.h
 *                  http.h
 *                  MPFS.h
 *				   	mac.h
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F
 * Complier:        Microchip C18 v3.02 or higher
 *					Microchip C30 v2.05 or higher
 *					HI-TECH PICC-18
 * Company:         Microchip Technology, Inc.
 *
 * Software License Agreement
 *
 * Copyright ?2002-2007 Microchip Technology Inc.  All rights 
 * reserved.
 *
 * Microchip licenses to you the right to use, modify, copy, and 
 * distribute: 
 * (i)  the Software when embedded on a Microchip microcontroller or 
 *      digital signal controller product (“Device? which is 
 *      integrated into Licensee’s product; or
 * (ii) ONLY the Software driver source files ENC28J60.c and 
 *      ENC28J60.h ported to a non-Microchip device used in 
 *      conjunction with a Microchip ethernet controller for the 
 *      sole purpose of interfacing with the ethernet controller. 
 *
 * You should refer to the license agreement accompanying this 
 * Software for additional information regarding your rights and 
 * obligations.
 *
 * THE SOFTWARE AND DOCUMENTATION ARE PROVIDED “AS IS?WITHOUT 
 * WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT 
 * LIMITATION, ANY WARRANTY OF MERCHANTABILITY, FITNESS FOR A 
 * PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT SHALL 
 * MICROCHIP BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR 
 * CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF 
 * PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS 
 * BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE 
 * THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER 
 * SIMILAR COSTS, WHETHER ASSERTED ON THE BASIS OF CONTRACT, TORT 
 * (INCLUDING NEGLIGENCE), BREACH OF WARRANTY, OR OTHERWISE.
 *
 *
 * Author              Date         Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 ********************************************************************/
/*
 * Following define uniquely deines this file as main
 * entry/application In whole project, there should only be one such
 * definition and application file must define AppConfig variable as
 * described below.
 */
#include <string.h>
#include <stdlib.h>
#include "GenericTypeDefs.h"
#include "Compiler.h"
#include "HardwareProfile.h"
#include "BSP_UART.H"


/////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define     LED_LINK    LED1_IO
#define     LED_TRANS   LED0_IO
#define     LED_RUN     LED0_IO

#define 	RE_DE_TRIS	(TRISCbits.TRISC0)
#define 	RE_DE_IO	(LATCbits.LATC0)


// Set configuration fuses
#if defined(__18CXX)
	#if defined(__18F66J60)
/*	
		DEBUG = OFF 	Background debugger disabled; RB6 and RB7 configured as general purpose I/O pins  
		XINST = OFF  	Instruction set extension and Indexed Addressing mode disabled (Legacy mode)  
		STVR = ON		Reset on stack overflow/underflow enabled  
		WDT = ON		WDT enabled  
		CP0 = OFF		Program memory is not code-protected  
		FCMEN = ON		Fail-Safe Clock Monitor enabled  
		IESO = ON		Two-Speed Start-up enabled  
		FOSC2 = ON		Clock selected by FOSC1:FOSC0 as system clock is enabled when OSCCON<1:0> = 00  
		FOSC = HSPLL	HS oscillator, PLL enabled and under software control  
		WDTPS = 16		1:16  about 64ms
		ETHLED = ON		RA0/RA1 are multiplexed with LEDA/LEDB when Ethernet module is enabled and function as I/O when Ethernet is disabled  
*/		
		#pragma config DEBUG = ON, XINST=OFF, STVR = ON, WDT=ON, CP0 = OFF, FCMEN = ON, IESO = ON, FOSC2=ON, FOSC=HSPLL, WDTPS = 16, ETHLED=ON
	#else
    	#error " MCU define error";
	#endif
#endif


// Private helper functions.
// These may or may not be present in all applications.
static void InitializeBoard(void);


// Main application entry point.
void main(void)
{
	
	unsigned char uart_buf[]="Hello!";

    // Initialize any application specific hardware.
    InitializeBoard();
	UART_Init( UART_BAUD_9600 );

	UART_Write(uart_buf,6);

    while(1)
    {
		RE_DE_IO = 1;		// send
		UART_Write(uart_buf,6);
 		//RE_DE_IO = 0;		// receive
		_asm CLRWDT _endasm
    }
}



/*********************************************************************
 * Function:        void InitializeBoard(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Initialize board specific hardware.
 *
 * Note:            None
 ********************************************************************/
static void InitializeBoard(void)
{
    // PLL enable; Postcaler disabled; PLL prescaler is divided by 3; PLL post
    OSCTUNEbits.PPRE =0;                // PLL Prescaler Configuration bit 0:divide by 2; 1:divide by 3
    OSCTUNEbits.PPST0 = 0;
    OSCTUNEbits.PPST1 = 0;
    OSCTUNEbits.PLLEN = 1;              //enable PLL

	RE_DE_TRIS = 0;		// output
	RE_DE_IO = 0;		// receive

	// LEDs IO
	LED0_IO = 1;    //led off
	LED1_IO = 1;    //led off

	LED0_TRIS = 0;		// output
	LED1_TRIS = 0;		// output		

	BUTTON_TRIS = 1;	// input
	
    // UART IO
    UART1TX_TRIS = 0;	// output
    UART1RX_TRIS = 1;	// input

	RCSTA1bits.SPEN = 0;// disable uart commutation
    TXSTA1bits.SYNC = 0;    // asynchronous mode
    TXSTA1bits.BRGH = 1;    // high speed
	BAUDCON1bits.BRG16 = 1; // 16bits

    RCSTA1bits.CREN = 1;    // enable receive
    TXSTA1bits.TXEN = 1;    // tx enable

    // EUSART1 rx int enable
    IPR1bits.RC1IP = 1;             // high priority
    PIE1bits.RC1IE = 1;             // enable

    // EUSART1 tx int enable
    IPR1bits.TX1IP = 1;             // high priority
    PIE1bits.TX1IE = 0;             // disable

	// Enable Interrupts
	RCONbits.IPEN = 1;		// Enable interrupt priorities
    INTCONbits.GIEH = 1;
    INTCONbits.GIEL = 1;

}

/*
wRdy = TCPIsGetReady(TCPSocket);
			if( wRdy > 0 )
			{
	            LED_Blink = TRUE;            // LED TRANS Light On
                if( wRdy > MAXRDY_ETH ) wRdy = MAXRDY_ETH;

                TCPGetArray(TCPSocket,Buffer,wRdy);
                UART_Write(Buffer,wRdy);
                TCPDiscard(TCPSocket);
                TCPLinkTimer = TickGet();
		    }

            wRdy = UART_HoldNum();
            if( (wRdy > 0 && ( TickGetDiff(TickGet(), Timer) >= ExchTimer )) || wRdy > CNT_COM )
            {
                Timer = TickGet();
    			// Make certain the socket can be written to
	    		if(TCPIsPutReady(TCPSocket))
		    	{
		            LED_Blink = TRUE;            // LED TRANS Light On

                    if( wRdy > MAXRDY_COM ) wRdy = MAXRDY_COM;

                    UART_Read(Buffer,wRdy);
                    TCPPutArray( TCPSocket, Buffer, wRdy );
           			TCPFlush(TCPSocket);	               	    // Send the packet
           			TCPLinkTimer = TickGet();
                }
            }
*/
