/*********************************************************************
*
*                  Helper Functions for Microchip TCP/IP Stack
*
*********************************************************************
* FileName:			Helpers.C
* Dependencies:		Compiler.h
*					Helpers.h
* Processor:		PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F
* Complier:			Microchip C18 v3.02 or higher
*					Microchip C30 v2.01 or higher
* Company:			Microchip Technology, Inc.
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
* Author               Date    Comment
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* Nilesh Rajbharti     5/17/01 Original        (Rev 1.0)
* Nilesh Rajbharti     2/9/02  Cleanup
* Nilesh Rajbharti     6/25/02 Rewritten CalcIPChecksum() to avoid
*                              multi-byte shift operation.
* Howard Schlunder		2/9/05 Added hexatob(), btohexa_high(), and
*							   btohexa_low()
* Howard Schlunder    10/10/06 Optimized swapl()
********************************************************************/
#define __HELPERS_C

#include "TCPIP Stack/TCPIP.h"


#if defined(STACK_USE_HTTP_SERVER)
/*********************************************************************
* Function:		void UnencodeURL(BYTE *URL)
*
* PreCondition:	None
*
* Input:		*URL: Pointer to a null terminated URL string
*
* Output:		All escape sequences (ex: %20) are converted to 
*				liternal representations in the URL string.
*
* Side Effects:	None
*
* Overview:		None
*
* Note:			None
********************************************************************/
void UnencodeURL(BYTE *URL)
{
	BYTE *Right, *Copy;
	WORD_VAL Number;

	while(Right = (BYTE*)strchr((char*)URL, '%'))
	{
		// Make sure the string is long enough
		if(Right[1] == '\0')
			break;
		if(Right[2] == '\0')
			break;

		// Update the string in place
		Number.v[0] = Right[2];
		Number.v[1] = Right[1];
		*Right++ = hexatob(Number);
		URL = Right;

		// Remove two blank spots by shifting all remaining characters right two
		Copy = Right + 2;
		while(*Right++ = *Copy++);
	}
}		    
#endif


/*********************************************************************
* Function:		BOOL StringToIPAddress(BYTE *str, IP_ADDR *IPAddress)
*
* PreCondition:	None
*
* Input:		str: Pointer to a null terminated URL, hostname, or dotted decimal IP address string
*				IPAddress: Pointer to a location to write the decoded IP address.  Result is big endian.
*
* Output:		TRUE if a IP address was successfully decoded
*				FALSE if no IP address could be found or wrong format
*
* Side Effects:	None
*
* Overview:		None
*
* Note:			None
********************************************************************/
BOOL StringToIPAddress(BYTE *str, IP_ADDR *IPAddress)
{
    BYTE i, j, k;
	BYTE buffer[4];

	j = 0;
	k = 0;

    while(i = *str++)
    {
        if(i == '.')
        {
            buffer[j] = '\0';
			j = 0;
            IPAddress->v[k++] = atoi((char*)buffer);
        }
        else if(i < '0' || i > '9')
		{
            return FALSE;
		}
		else
		{
			buffer[j++] = i;
			if(k >= sizeof(IP_ADDR))
				return FALSE;
		}

		if(j >= sizeof(buffer))
			return FALSE;
    }

	buffer[j] = '\0';
    IPAddress->v[k] = atoi((char*)buffer);
    return (k == 3u);
}


//#if defined(__C30__) || defined(HI_TECH_C)
/*********************************************************************
* Function:		void uitoa(WORD Value, BYTE *Buffer)
*
* PreCondition:	None
*
* Input:		Value: Unsigned integer to be converted
*				Buffer: Pointer to a location to write the string
*
* Output:		*Buffer: Receives the resulting string
*
* Side Effects:	None
*
* Overview:		The function converts an unsigned integer (16 bits) 
*				into a null terminated decimal string.
*
* Note:			None
********************************************************************/
void uitoa(WORD Value, BYTE *Buffer)
{
	BYTE i;
	WORD Digit;
	WORD Divisor;
	BOOL Printed = FALSE;

	if(Value)
	{
		for(i = 0, Divisor = 10000; i < 5; i++)
		{
			Digit = Value/Divisor;
			if(Digit || Printed)
			{
				*Buffer++ = '0' + Digit;
				Value -= Digit*Divisor;
				Printed = TRUE;
			}
			Divisor /= 10;
		}
	}
	else
	{
		*Buffer++ = '0';
	}

	*Buffer = '\0';
}			    
//#endif


/*********************************************************************
* Function:        BYTE hexatob(WORD_VAL AsciiChars)
*
* PreCondition:    None
*
* Input:           Two ascii bytes; each ranged '0'-'9', 'A'-'F', or
*						'a'-'f'
*
* Output:          The resulting packed byte: 0x00-0xFF
*
* Side Effects:    None
*
* Overview:        None
*
* Note:			None
********************************************************************/
BYTE hexatob(WORD_VAL AsciiChars)
{
	// Convert lowercase to uppercase
	if(AsciiChars.v[1] > 'F')
		AsciiChars.v[1] -= 'a'-'A';
	if(AsciiChars.v[0] > 'F')
		AsciiChars.v[0] -= 'a'-'A';

	// Convert 0-9, A-F to 0x0-0xF
	if(AsciiChars.v[1] > '9')
		AsciiChars.v[1] -= 'A' - 10;
	else
		AsciiChars.v[1] -= '0';

	if(AsciiChars.v[0] > '9')
		AsciiChars.v[0] -= 'A' - 10;
	else
		AsciiChars.v[0] -= '0';

	// Concatenate
	return (AsciiChars.v[1]<<4) |  AsciiChars.v[0];
}

/*********************************************************************
* Function:        BYTE btohexa_high(BYTE b)
*
* PreCondition:    None
*
* Input:           One byte ranged 0x00-0xFF
*
* Output:          An ascii byte (always uppercase) between '0'-'9' 
*					or 'A'-'F' that corresponds to the upper 4 bits of
*					the input byte.
*					ex: b = 0xAE, btohexa_high() returns 'A'
*
* Side Effects:    None
*
* Overview:        None
*
* Note:			None
********************************************************************/
BYTE btohexa_high(BYTE b)
{
	b >>= 4;
	return (b>0x9u) ? b+'A'-10:b+'0';
}

/*********************************************************************
* Function:        BYTE btohexa_low(BYTE b)
*
* PreCondition:    None
*
* Input:           One byte ranged 0x00-0xFF
*
* Output:          An ascii byte (always uppercase) between '0'-'9' 
*					or 'A'-'F' that corresponds to the lower 4 bits of
*					the input byte.
*					ex: b = 0xAE, btohexa_low() returns 'E'
*
* Side Effects:    None
*
* Overview:        None
*
* Note:			None
********************************************************************/
BYTE btohexa_low(BYTE b)
{
	b &= 0x0F;
	return (b>9u) ? b+'A'-10:b+'0';
}


WORD swaps(WORD v)
{
	WORD_VAL t;
	BYTE b;

	t.Val   = v;
	b       = t.v[1];
	t.v[1]  = t.v[0];
	t.v[0]  = b;

	return t.Val;
}


DWORD swapl(DWORD v)
{
	// Swap bytes 0 and 3
	((DWORD_VAL*)&v)->v[0] ^= ((DWORD_VAL*)&v)->v[3];
	((DWORD_VAL*)&v)->v[3] ^= ((DWORD_VAL*)&v)->v[0];
	((DWORD_VAL*)&v)->v[0] ^= ((DWORD_VAL*)&v)->v[3];

	// Swap bytes 1 and 2
	((DWORD_VAL*)&v)->v[1] ^= ((DWORD_VAL*)&v)->v[2];
	((DWORD_VAL*)&v)->v[2] ^= ((DWORD_VAL*)&v)->v[1];
	((DWORD_VAL*)&v)->v[1] ^= ((DWORD_VAL*)&v)->v[2];

	return v;
}


WORD CalcIPChecksum(BYTE* buffer, WORD count)
{
	WORD i;
	WORD *val;
	DWORD_VAL sum = {0x00000000ul};

	i = count >> 1;
	val = (WORD*)buffer;

	// Calculate the sum of all words
	while(i--)
		sum.Val += (DWORD)*val++;

	// Add in the sum of the remaining byte, if present
	if(((WORD_VAL*)&count)->bits.b0)
		sum.Val += (DWORD)*(BYTE*)val;

	// Do an end-around carry (one's complement arrithmatic)
	sum.Val = (DWORD)sum.w[0] + (DWORD)sum.w[1];

	// Do another end-around carry in case if the prior add 
	// caused a carry out
	sum.w[0] += sum.w[1];

	// Return the resulting checksum
	return ~sum.w[0];
}


/*********************************************************************
* Function:        WORD CalcIPBufferChecksum(WORD len)
*
* PreCondition:    TCPInit() is already called     AND
*                  MAC buffer pointer set to starting of buffer
*
* Input:           len     - Total number of bytes to calculate
*                          checksum for.
*
* Output:          16-bit checksum as defined by rfc 793.
*
* Side Effects:    None
*
* Overview:        This function performs checksum calculation in
*                  MAC buffer itself.
*
* Note:            None
********************************************************************/
#if defined(NON_MCHP_MAC)
WORD CalcIPBufferChecksum(WORD len)
{
	DWORD_VAL Checksum = {0x00000000ul};
	WORD ChunkLen;
	BYTE DataBuffer[20];	// Must be an even size
	WORD *DataPtr;

	while(len)
	{
		// Obtain a chunk of data (less SPI overhead compared 
		// to requesting one byte at a time)
		ChunkLen = len > sizeof(DataBuffer) ? sizeof(DataBuffer) : len;
		MACGetArray(DataBuffer, ChunkLen);
		len -= ChunkLen;

		// Take care of a last odd numbered data byte
		if(((WORD_VAL*)&ChunkLen)->bits.b0)
		{
			DataBuffer[ChunkLen] = 0x00;
			ChunkLen++;
		}

		// Calculate the checksum over this chunk
		DataPtr = (WORD*)&DataBuffer[0];
		while(ChunkLen)
		{
			Checksum.Val += *DataPtr++;
			ChunkLen -= 2;
		}
	}
	
	// Do an end-around carry (one's complement arrithmatic)
	Checksum.Val = (DWORD)Checksum.w[0] + (DWORD)Checksum.w[1];

	// Do another end-around carry in case if the prior add 
	// caused a carry out
	Checksum.w[0] += Checksum.w[1];

	// Return the resulting checksum
	return ~Checksum.w[0];
}
#endif

/*********************************************************************
* Function:		char *strupr(char *s)
*
* PreCondition:	None
*
* Input:		s: Pointer to a null terminated string to convert.
*
* Output:		char* return: Pointer to the initial string
*				*s: String is updated in to have all upper case 
*					characters
*
* Side Effects:	None
*
* Overview:		The function sequentially converts all lower case 
*				characters in the input s string to upper case 
*				characters.  Non a-z characters are skipped.
*
* Note:			None
********************************************************************/
#if defined(__C30__) || defined(HI_TECH_C)
char *strupr(char *s)
{
	char c;
	char *t;

	t = s;
	while( (c = *t) )
	{
		if(c >= 'a' && c <= 'z')
		{
			*t -= ('a' - 'A');
		}
		t++;
	}
	return s;
}
#endif
