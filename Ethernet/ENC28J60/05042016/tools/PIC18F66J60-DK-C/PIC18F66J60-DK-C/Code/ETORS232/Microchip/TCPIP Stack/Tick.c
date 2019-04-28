/*********************************************************************
 *
 *                  Tick Manager for Loose Timekeeping
 *
 *********************************************************************
 * FileName:        Tick.c
 * Dependencies:    stackTSK.h
 *                  Tick.h
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F
 * Complier:        Microchip C18 v3.02 or higher
 *					Microchip C30 v2.01 or higher
 * Company:         Microchip Technology, Inc.
 *
 * Software License Agreement
 *
 * Copyright © 2002-2007 Microchip Technology Inc.  All rights 
 * reserved.
 *
 * Microchip licenses to you the right to use, modify, copy, and 
 * distribute: 
 * (i)  the Software when embedded on a Microchip microcontroller or 
 *      digital signal controller product (“Device”) which is 
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
 * THE SOFTWARE AND DOCUMENTATION ARE PROVIDED “AS IS” WITHOUT 
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
 * Author               Date        Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Nilesh Rajbharti     6/28/01     Original        (Rev 1.0)
 * Nilesh Rajbharti     2/9/02      Cleanup
 * Nilesh Rajbharti     5/22/02     Rev 2.0 (See version.log for detail)
********************************************************************/
#define __TICK_C

#include "TCPIP Stack/TCPIP.h"

static volatile TICK TickCount = 0;


/*********************************************************************
 * Function:        void TickInit(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          Tick manager is initialized.
 *
 * Side Effects:    None
 *
 * Overview:        Initializes Timer0 as a tick counter.
 *
 * Note:            None
 ********************************************************************/
#define PERIOD 		((WORD)((INSTR_FREQ+32+TICKS_PER_SECOND/2)/64/TICKS_PER_SECOND))
#define TICK_LOAD	((WORD)((-(INSTR_FREQ+2+TICKS_PER_SECOND/2)/4/TICKS_PER_SECOND)+4))
void TickInit(void)
{
#ifdef __C30__
	// Set up timer1 to wake up by timeout
	// 1:64 prescale
	T1CONbits.TCKPS = 2;
	// Base
	PR1 = (WORD)PERIOD;
	// Clear counter
	TMR1 = 0;
	// Enable timer interrupt
	IFS0bits.T1IF = 0;
	IEC0bits.T1IE = 1;
	// Start timer
	T1CONbits.TON = 1;
#else
    // Initialize the time
    TMR0H = (TICK_LOAD & 0xFF00)>>8;
    TMR0L = TICK_LOAD & 0xFF;

	// Set up the timer interrupt
	INTCON2bits.TMR0IP = 0;		// low priority
    INTCONbits.TMR0IF = 0;
    INTCONbits.TMR0IE = 1;		// Enable interrupt

    // Timer0 on, 16-bit, internal timer, 4:1 prescalar
    T0CON = 0x81;
#endif
}


/*********************************************************************
 * Function:        TICK TickGet(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          Current tick value is given
 *					1 tick represents approximately 10ms
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
TICK TickGet(void)
{
    return TickCount;
}


/*********************************************************************
 * Function:        void TickUpdate(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Internal Tick and Seconds count are updated.
 *
 * Note:            None
 ********************************************************************/
#ifdef __18CXX
void TickUpdate(void)
{
	WORD_VAL TMR0Val;

    if(INTCONbits.TMR0IF)
    {
		TMR0Val.v[0] = TMR0L;
		TMR0Val.v[1] = TMR0H;
		TMR0Val.Val += (WORD)TICK_LOAD;
		TMR0H = TMR0Val.v[1];
		TMR0L = TMR0Val.v[0];

        TickCount++;

        INTCONbits.TMR0IF = 0;
    }
}

#else
/*********************************************************************
 * Function:        void _ISR _T1Interrupt(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          TickCount variable is updated
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
#if __C30_VERSION__ >= 300
void _ISR __attribute__((__no_auto_psv__)) _T1Interrupt(void)
#else
void _ISR _T1Interrupt(void)
#endif
{
	TickCount++;
	// Reset interrupt flag
	IFS0bits.T1IF = 0;
	return;
}
#endif
