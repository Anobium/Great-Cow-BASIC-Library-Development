/*********************************************************************
*
*                  Board Support Packet of Microchip Chips
*
*
*********************************************************************
* FileName:        BSP_DEBUG.C
* Dependencies:    BSP_DEF.H
*                  BSP_FIFO.H
*                  BSP_INT.H
*                  BSP_UART.H
*                  P24FJ128GA006.H
* Processor:       PIC24F
* Complier:        Microchip C30 v2.01 or higher
* Company:         Microchip Technology, Inc.
*
* Software License Agreement
*
* This software is owned by Microchip Technology Inc. ("Microchip")
* and is supplied to you for use exclusively as described in the
* associated software agreement.  This software is protected by
* software and other intellectual property laws.  Any use in
* violation of the software license may subject the user to criminal
* sanctions as well as civil liability.  Copyright 2006 Microchip
* Technology Inc.  All rights reserved.
*
* This software is provided "AS IS."  MICROCHIP DISCLAIMS ALL
* WARRANTIES, EXPRESS, IMPLIED, STATUTORY OR OTHERWISE, NOT LIMITED
* TO MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND
* INFRINGEMENT.  Microchip shall in no event be liable for special,
* incidental, or consequential damages.
*
*
* Author               Date    Comment
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Robin Chen           Dec/06   Original (Rev. 1.0)

********************************************************************/
#include <string.h>
#include <stdlib.h>
#include "GenericTypeDefs.h"
#include "Compiler.h"
#include "HardwareProfile.h"
#include "BSP_UART.H"


#define	 ENABLEINT		(INTCONbits.GIEH = 1)		// disable high level priority interrupt
#define  DISABLEINT		(INTCONbits.GIEH = 0)		// enable high level priority interrupt

/******************************************************************************
* UART BAUD & BAUD RATE TABLE
******************************************************************************/
rom WORD UART_BAUD_TBL[10][2] =
{
    {UART_BAUD_1200  , UART_BAUD_RATE_1200 },
    {UART_BAUD_2400  , UART_BAUD_RATE_2400 },
    {UART_BAUD_4800  , UART_BAUD_RATE_4800 },
    {UART_BAUD_9600  , UART_BAUD_RATE_9600 },
    {UART_BAUD_19200 , UART_BAUD_RATE_19200 },
    {UART_BAUD_38400 , UART_BAUD_RATE_38400 },
    {UART_BAUD_57600 , UART_BAUD_RATE_57600 },
    {UART_BAUD_115200, UART_BAUD_RATE_115200 },
    {UART_BAUD_230400, UART_BAUD_RATE_230400 },
    {UART_BAUD_460800, UART_BAUD_RATE_460800 }
    };

/******************************************************************************
* COM port related FIFO struction define, Tx & Rx Buffer
******************************************************************************/
#pragma	udata SEC_RXBUF		   // locate 0xA00
BYTE        UARTRxBuf[512];    // Receive FIFO buffer

#pragma	udata SEC_TXBUF		   // locate 0xC00
BYTE        UARTTxBuf[512];    // Transfer FIFO buffer

#pragma udata

BYTE*	RxFifo_Start;
BYTE*	RxFifo_End;
BYTE*	RxFifo_Read;
BYTE*	RxFifo_Write;

BYTE*	TxFifo_Start;
BYTE*	TxFifo_End;
BYTE*	TxFifo_Read;
BYTE*	TxFifo_Write;

#pragma code // Return to default code section


/*********************************************************************
 * Function:
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
void UART_Init(BYTE Baud)
{

	RCSTA1bits.SPEN = 0;// disable uart commutation

//calculate baud rate
	SPBRGH1 = (BYTE)((UART_BAUD_TBL[Baud][1] & 0xFF00 )>>8);
	SPBRG1 =  (BYTE)(UART_BAUD_TBL[Baud][1] & 0x00FF );
//enable uart
	RCSTA1bits.SPEN = 1;//Enable uart commutation

    TxFifo_Start = (BYTE*)UARTRxBuf;
    TxFifo_End   = (BYTE*)UARTRxBuf + sizeof(UARTRxBuf);
    TxFifo_Read  = (BYTE*)UARTRxBuf;
	TxFifo_Write = (BYTE*)UARTRxBuf;
	
    RxFifo_Start = (BYTE*)UARTTxBuf;
    RxFifo_End   = (BYTE*)UARTTxBuf + sizeof(UARTTxBuf);
    RxFifo_Read  = (BYTE*)UARTTxBuf;
	RxFifo_Write = (BYTE*)UARTTxBuf;

}
/*********************************************************************
 * Function:
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
void UART_Read(BYTE* pBuffer,WORD wCount )
{

    while( wCount-- > 0 )
    {
        // read from the FIFO, and pointe to the next
        *pBuffer++ = *RxFifo_Read;
	    DISABLEINT;            // disable high level priority interrupt
        RxFifo_Read++;
    	ENABLEINT;            // enable high level priority interrupt
        // check if it is the bottom of FIFO
        if( RxFifo_Read >= RxFifo_End )
        {
		    DISABLEINT;            // disable high level priority interrupt
            RxFifo_Read = RxFifo_Start;
	    	ENABLEINT;            // enable high level priority interrupt
        }
    }
  
}

/*********************************************************************
 * Function:
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
void UART_Write(BYTE* pBuffer,WORD wCount )
{

    while( wCount-- > 0 )
    {
        // write to the FIFO, and pointe to the next
 		*TxFifo_Write = *pBuffer++;
	    DISABLEINT;            // disable high level priority interrupt
	    TxFifo_Write++;
    	ENABLEINT;            // enable high level priority interrupt
        // check if it is the bottom of FIFO
 		if( TxFifo_Write >= TxFifo_End )
 		{
		    DISABLEINT;            // disable high level priority interrupt
 			TxFifo_Write = TxFifo_Start;
	    	ENABLEINT;            // enable high level priority interrupt
 		}
    }
   PIE1bits.TX1IE = 1;             // enable

}

/*********************************************************************
 * Function:
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
WORD UART_BlankNum(void)
{

	WORD wBlankNum;
    DISABLEINT;            // disable high level priority interrupt
	if( TxFifo_Write == TxFifo_Read )
	    wBlankNum = TxFifo_End - TxFifo_Start - 1;
	else if( TxFifo_Write > TxFifo_Read )
	    wBlankNum = TxFifo_End - TxFifo_Start + TxFifo_Read - TxFifo_Write - 1;
	else
	    wBlankNum = TxFifo_Read - TxFifo_Write - 1;
   	ENABLEINT;            // enable high level priority interrupt
	return wBlankNum;

}
/*********************************************************************
 * Function:
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
WORD UART_HoldNum(void)
{
    WORD wHoldNum;
    DISABLEINT;            // disable high level priority interrupt
    if( RxFifo_Write == RxFifo_Read )
        wHoldNum = 0;
    else if( RxFifo_Write > RxFifo_Read )
        wHoldNum = RxFifo_Write - RxFifo_Read;
    else
        wHoldNum = RxFifo_End - RxFifo_Start + RxFifo_Write - RxFifo_Read;
   	ENABLEINT;            // enable high level priority interrupt
	return wHoldNum;
}

/*********************************************************************
 * Function:        void _ISR _U1RXInterrupt(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
#pragma interrupt UART_Handler
void UART_Handler(void)
{
    BYTE    data;

    // TX interrupter handler
    if(PIR1bits.TX1IF)
    {
	    if( TxFifo_Write == TxFifo_Read )
	    {
		    PIE1bits.TX1IE = 0;       // disable
	    }
	    else
	   	{
	        // read from the FIFO, and pointe to the next
    	    TXREG1 = *TxFifo_Read++;
        	// check if it is the bottom of FIFO
	        if( TxFifo_Read >= TxFifo_End )
    	        TxFifo_Read = TxFifo_Start;
	   	}
    }
    
    // RX interrupter handler
    if(PIR1bits.RC1IF)
    {
        data = RCREG1;
 		*RxFifo_Write++ = data;
        // check if it is the bottom of FIFO
 		if( RxFifo_Write >= RxFifo_End )
 			RxFifo_Write = RxFifo_Start;
    }

}

#pragma code LowVector=0x08		// high level interrupt vector
void HighVector (void)
{
    _asm goto UART_Handler _endasm
}

