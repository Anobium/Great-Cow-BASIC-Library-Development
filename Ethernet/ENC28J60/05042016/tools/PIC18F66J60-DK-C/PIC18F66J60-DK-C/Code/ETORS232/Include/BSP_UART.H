/*********************************************************************
*
*                  Board Support Packet of Microchip Chips
*                  General Data Type Define
*
*********************************************************************
* FileName:        BSP_DEF.H
* Dependencies:
* Processor:       PIC18F
* Complier:        Microchip C18 v3.1 or higher
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
#ifndef __BSP_UART_H__
#define __BSP_UART_H__


/*      UART stop bit definition */
#define     UART_STOP_1BIT      1
#define     UART_STOP_2BIT      2

/*      UART data bit definition */
#define    UART_DATA_8BIT       1
#define    UART_DATA_8BIT_EVEN  2
#define    UART_DATA_8BIT_ODD   3


// UART baud define
/*      UART baud definition */
#define     UART_BAUD_1200      0
#define     UART_BAUD_2400      1
#define     UART_BAUD_4800      2
#define     UART_BAUD_9600      3
#define     UART_BAUD_19200     4
#define     UART_BAUD_38400     5
#define     UART_BAUD_57600     6
#define     UART_BAUD_115200    7
#define     UART_BAUD_230400    8
#define     UART_BAUD_460800    9


#define     UART_BAUD_RATE_1200       (WORD)((CLOCK_FREQ+2*1200)/4/1200-1)
#define     UART_BAUD_RATE_2400       (WORD)((CLOCK_FREQ+2*2400)/4/2400-1)
#define     UART_BAUD_RATE_4800       (WORD)((CLOCK_FREQ+2*4800)/4/4800-1)
#define     UART_BAUD_RATE_9600       (WORD)((CLOCK_FREQ+2*9600)/4/9600-1)
#define     UART_BAUD_RATE_19200      (WORD)((CLOCK_FREQ+2*19200)/4/19200-1)
#define     UART_BAUD_RATE_38400      (WORD)((CLOCK_FREQ+2*38400)/4/38400-1)
#define     UART_BAUD_RATE_57600      (WORD)((CLOCK_FREQ+2*57600)/4/57600-1)
#define     UART_BAUD_RATE_115200     (WORD)((CLOCK_FREQ+2*115200)/4/115200-1)
#define     UART_BAUD_RATE_230400     (WORD)((CLOCK_FREQ+2*230400)/4/230400-1)
#define     UART_BAUD_RATE_460800     (WORD)((CLOCK_FREQ+2*460800)/4/460800-1)

void UART_Init(BYTE Baud);
void UART_Read(BYTE* pBuffer,WORD wCount );
void UART_Write(BYTE* pBuffer,WORD wCount );
WORD UART_BlankNum(void);
WORD UART_HoldNum(void);

#endif

