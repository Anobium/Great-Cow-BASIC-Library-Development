/*******************************************************************************
Copyright 2016 Microchip Technology Inc. (www.microchip.com)

 bsp/uart.c
   
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

*******************************************************************************/

#include <xc.h>
#include <stdbool.h>
#include <usb_config.h>

#include "uart.h"

/******************************************************************************
 * Function:        void UART_Initialize(void)
 * Overview:        This routine initializes the UART 
 *****************************************************************************/
void UART_Initialize()
{
        unsigned char c;
     
        ANSELCbits.ANSC6 = 0;    // Make RC6 and RC7 pin digital
        ANSELCbits.ANSC7 = 0;
        UART_TRISRx = 1;        // RX
        UART_TRISTx = 1;        // TX
        
        TXSTA = 0x24;       	// TX enable 
        RCSTA = 0x90;       	// RX Enable
        SPBRG = 0x70;
        SPBRGH = 0x02;      	// 48MHz -> 19200 baud

        BAUDCON = 0x08;     	// BRG16 = 1
        c = RCREG;				// read
}//end USART_Initialize

/******************************************************************************
 * Function:        void UART_putch(char c)
 * Input:           char c - character to print to the UART
 * Output:          None
 * Overview:        Print the input character to the UART
 *****************************************************************************/
void UART_putch(char c)
{
      TXREG = c;
}

/******************************************************************************
 * Function:        void UART_baudrateSet(void)
 * Overview:        Changes the serial port baudrate
 *****************************************************************************/
void UART_baudrateSet(uint32_t dwBaud)
{
    uint32_t dwDivider = ((GetSystemClock()/4) / dwBaud) - 1;
    SPBRG = (uint8_t) dwDivider;
    SPBRGH = (uint8_t)((uint16_t) (dwDivider >> 8));
}

/******************************************************************************
 * Function:        void UART_getch(char c)
 * Output:          unsigned char c - character received 
 * Overview:        Read the input character from the UART
 *****************************************************************************/
char UART_getch( void)
{
	char  c;

	if (RCSTAbits.OERR)  // in case of overrun error
	{                    // we should never see an overrun error, but if we do,
		RCSTAbits.CREN = 0;  // reset the port
		c = RCREG;
		RCSTAbits.CREN = 1;  // and keep going.
	}
	else 
    {
		c = RCREG;
    }
	return c;
}