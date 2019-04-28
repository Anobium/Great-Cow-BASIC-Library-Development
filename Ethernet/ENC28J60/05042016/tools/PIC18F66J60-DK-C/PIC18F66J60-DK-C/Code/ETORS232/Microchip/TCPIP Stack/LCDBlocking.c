/*********************************************************************
 *
 *       LCD Access Routines
 *
 *********************************************************************
 * FileName:        LCDBlocking.c
 * Dependencies:    Compiler.h, HardwareProfile.h
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
 * Author               Date         Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Howard Schlunder     4/03/06		Original
 * Howard Schlunder     4/12/06		Changed from using PMP to LCDWrite()
 * Howard Schlunder		8/10/06		Fixed a delay being too short 
 *									when CLOCK_FREQ was a smaller 
 *									value, added FOUR_BIT_MODE
 ********************************************************************/
#define __LCDBLOCKING_C

#include "TCPIP Stack/TCPIP.h"

#if defined(USE_LCD)


#if defined(PICDEMNET)
#define FOUR_BIT_MODE
#endif

// LCDText is a 32 byte shadow of the LCD text.  Write to it and 
// then call LCDUpdate() to copy the string into the LCD module.
BYTE LCDText[16*2+1];

/******************************************************************************
 * Function:        static void LCDWrite(BYTE RS, BYTE Data)
 *
 * PreCondition:    None
 *
 * Input:           RS - Register Select - 1:RAM, 0:Config registers
 *					Data - 8 bits of data to write
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Controls the Port I/O pins to cause an LCD write
 *
 * Note:            None
 *****************************************************************************/
static void LCDWrite(BYTE RS, BYTE Data)
{
	LCD_DATA_TRIS = 0x00;
	LCD_RS_TRIS = 0;
	LCD_RD_WR_TRIS = 0;
	LCD_RD_WR_IO = 0;
	LCD_RS_IO = RS;

#if defined(FOUR_BIT_MODE)
	LCD_DATA_IO = Data>>4;
	Nop();					// Wait Data setup time (min 40ns)
	Nop();
	LCD_E_IO = 1;
	Nop();					// Wait E Pulse width time (min 230ns)
	Nop();
	Nop();
	Nop();
	Nop();
	Nop();
	Nop();
	Nop();
	Nop();
	LCD_E_IO = 0;
#endif

	LCD_DATA_IO = Data;
	Nop();					// Wait Data setup time (min 40ns)
	Nop();
	LCD_E_IO = 1;
	Nop();					// Wait E Pulse width time (min 230ns)
	Nop();
	Nop();
	Nop();
	Nop();
	Nop();
	Nop();
	Nop();
	Nop();
	LCD_E_IO = 0;

	LCD_DATA_TRIS = 0xFF;
	LCD_RS_TRIS = 1;
	LCD_RD_WR_TRIS = 1;
}


/******************************************************************************
 * Function:        void LCDInit(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        LCDText[] is blanked, port I/O pin TRIS registers are 
 *					configured, and the LCD is placed in the default state
 *
 * Note:            None
 *****************************************************************************/
void LCDInit(void)
{
	BYTE i;

	for(i = 0; i < sizeof(LCDText)-1; i++)
	{
		LCDText[i] = ' ';
	}
	LCDText[sizeof(LCDText)-1] = 0;

	// Setup the I/O pins
	LCD_E_IO = 0;
	LCD_RD_WR_IO = 0;

	LCD_DATA_TRIS = 0x00;
	LCD_RD_WR_TRIS = 0;
	LCD_RS_TRIS = 0;
	LCD_E_TRIS = 0;


	// Wait the required time for the LCD to reset
	DelayMs(30);

	// Set the default function
#if defined(FOUR_BIT_MODE)
	LCDWrite(0, 0x28);
#else
	LCDWrite(0, 0x38);
#endif
	Delay10us(5);

	// Set the display control
	LCDWrite(0, 0x0C);
	Delay10us(5);

	// Clear the display
	LCDWrite(0, 0x01);
	Delay10us(153);
	
	// Set the entry mode
	LCDWrite(0, 0x06);
	Delay10us(5);
}


/******************************************************************************
 * Function:        void LCDUpdate(void)
 *
 * PreCondition:    LCDInit() must have been called once
 *
 * Input:           LCDText[]
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Copies the contents of the local LCDText[] array into the 
 *					LCD's internal display buffer.  Null terminators in 
 *					LCDText[] terminate the current line, so strings may be 
 *					printed directly to LCDText[].
 *
 * Note:            None
 *****************************************************************************/
void LCDUpdate(void)
{
	BYTE i, j;

	// Go home
	LCDWrite(0, 0x02);
	DelayMs(1);
	Delay10us(53);

	// Output first line
	for(i = 0; i < 16u; i++)
	{
		// Erase the rest of the line if a null char is 
		// encountered (good for printing strings directly)
		if(LCDText[i] == 0u)
		{
			for(j=i; j < 16u; j++)
			{
				LCDText[j] = ' ';
			}
		}
		LCDWrite(1, LCDText[i]);
		Delay10us(5);
	}
	
	// Set the address to the second line
	LCDWrite(0, 0xC0);
	Delay10us(5);

	// Output second line
	for(i = 16; i < 32u; i++)
	{
		// Erase the rest of the line if a null char is 
		// encountered (good for printing strings directly)
		if(LCDText[i] == 0u)
		{
			for(j=i; j < 32u; j++)
			{
				LCDText[j] = ' ';
			}
		}
		LCDWrite(1, LCDText[i]);
		Delay10us(5);
	}
}

/******************************************************************************
 * Function:        void LCDErase(void)
 *
 * PreCondition:    LCDInit() must have been called once
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Clears LCDText[] and the LCD's internal display buffer
 *
 * Note:            None
 *****************************************************************************/
void LCDErase(void)
{
	// Clear display
	LCDWrite(0, 0x01);
	Delay10us(153);

	// Clear local copy
	memset(LCDText, ' ', 32);
}

#endif	//#if defined(USE_LCD)
