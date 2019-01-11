 /*
***********************************************************************************************
*             Toshiba T6963C Graphical LCD Display Driver
*
* File name   : t6963.h
* Programmer  : John Leung, TechToys, Hong Kong
* Web presence  : www.TechToys.com.hk
* Note      : References - picant complier web page, epe magazine Feb 2001
*         & Jean J Labrosse's Embedded Systems Building Blocks
*         & treitmey's driver on CCS forum
* Language    : CCS C complier for PIC mid-range MCU, PCM version 3.170, under MPLAB IDE 7.01
* Hardware    : Prototype board PCB ver 2.5(home-grown), EQS Console, MCU 16F877a, 20MHz Xtal
* Date      : Version 0.0 (20 April 2005 - 27 April 2005)
* Date      : 3 May 2005
*       : Routine void GDispPixFontAt(x, y, textptr, size, color) and font5x7.h added
***********************************************************************************************
*                   DESCRIPTION
*
* This module provides an interface to Toshiba T6963C-0101 Graphical LCD of size 128x64 dots
* A 128-word character generator ROM (code 0101) T6963C-0101 is built in as standard.
* Graphics l.c.d. pinout function
* pin 1 FG  frame ground
* pin 2 GND signal ground
* pin 3 +5V Positive supply
* pin 4 CX  Negative supply (-3.5V approx)
* pin 5 WR  Data write (active low)
* pin 6 RD  Data read (active low)
* pin 7 CE  Chip enable (active low)
* pin 8 CD  CD=1, WR=0: command write
*     CD=1, WR=1: command read
*     CD=0, WR=0: data write
*       CD=0, WR=1: data read
* pin 9 RST Module reset (active low)
* pin 10 - 17 Data bus
* pin 18 FS Font select: FS=0(8x8 font), FS=1(or open circuit, 6x8 font)
* In EQS console ver 2.5 PCB, FS is determined by JP23 jumper. FS=0 when shorted
*
*
***********************************************************************************************
*/

/*
***********************************************************************************************
*                   PORT DEFINITION
***********************************************************************************************
*/
#byte PORTA = 0x05
#byte TRISA = 0x85
#bit  PORTA0  = PORTA.0

#bit  PORTA1  = PORTA.1
#bit  PORTA2  = PORTA.2
#bit  PORTA3  = PORTA.3
#bit  PORTA4  = PORTA.4
#bit  PORTA5  = PORTA.5
#bit  TRISA0  = TRISA.0
#bit  TRISA1  = TRISA.1
#bit  TRISA2  = TRISA.2
#bit  TRISA3  = TRISA.3
#bit  TRISA4  = TRISA.4
#bit  TRISA5  = TRISA.5

#byte PORTB = 0x06
#byte TRISB = 0x86
#bit  PORTB0  = PORTB.0
#bit  PORTB1  = PORTB.1
#bit  PORTB2  = PORTB.2
#bit  PORTB3  = PORTB.3
#bit  PORTB4  = PORTB.4
#bit  PORTB5  = PORTB.5
#bit  PORTB6  = PORTB.6
#bit  PORTB7  = PORTB.7
#bit  TRISB0  = TRISB.0
#bit  TRISB1  = TRISB.1
#bit  TRISB2  = TRISB.2
#bit  TRISB3  = TRISB.3
#bit  TRISB4  = TRISB.4
#bit  TRISB5  = TRISB.5
#bit  TRISB6  = TRISB.6
#bit  TRISB7  = TRISB.7

#byte PORTC = 0x07
#byte TRISC = 0x87
#bit  PORTC0  = PORTC.0
#bit  PORTC1  = PORTC.1
#bit  PORTC2  = PORTC.2
#bit  PORTC3  = PORTC.3
#bit  PORTC4  = PORTC.4
#bit  PORTC5  = PORTC.5
#bit  PORTC6  = PORTC.6
#bit  PORTC7  = PORTC.7
#bit  TRISC0  = TRISC.0
#bit  TRISC1  = TRISC.1
#bit  TRISC2  = TRISC.2
#bit  TRISC3  = TRISC.3
#bit  TRISC4  = TRISC.4
#bit  TRISC5  = TRISC.5
#bit  TRISC6  = TRISC.6
#bit  TRISC7  = TRISC.7

#byte PORTD = 0x08
#byte TRISD = 0x88
#bit  PORTD0  = PORTD.0
#bit  PORTD1  = PORTD.1
#bit  PORTD2  = PORTD.2
#bit  PORTD3  = PORTD.3
#bit  PORTD4  = PORTD.4
#bit  PORTD5  = PORTD.5
#bit  PORTD6  = PORTD.6
#bit  PORTD7  = PORTD.7
#bit  TRISD0  = TRISD.0
#bit  TRISD1  = TRISD.1
#bit  TRISD2  = TRISD.2
#bit  TRISD3  = TRISD.3
#bit  TRISD4  = TRISD.4
#bit  TRISD5  = TRISD.5
#bit  TRISD6  = TRISD.6
#bit  TRISD7  = TRISD.7

#byte   PORTE = 0x09
#byte TRISE = 0x89
#bit  PORTE0  = PORTE.0
#bit  PORTE1  = PORTE.1
#bit  PORTE2  = PORTE.2
#bit  TRISE0  = TRISE.0
#bit  TRISE1  = TRISE.1
#bit  TRISE2  = TRISE.2

//I/O port for data definition
#ifndef T6963_H
#define T6963_H

#define LCD_DATA       PORTD    // LCD data port
#define LCD_DATA_TRIS      TRISD    // LCD Data port Tris
#define STA0         PORTD0   // Check command execution capability
#define STA1         PORTD1   // Check data read/write capability
#define STA2         PORTD2   // Check Auto mode data read capability
#define STA3         PORTD3   // Check Auto mode data write capability
#define STA5         PORTD5   // Check controller operation capability
#define STA6         PORTD6   // Error flag. Used for screen peek and screen copy
#define STA7         PORTD7   // Check the blink condition

//Control pin setting
#define LCD_CE        PORTE2    // LCD Enable control line pin number
#define LCD_CE_TRIS       TRISE2    // LCD Enable control line direction pin #
#define LCD_RD        PORTE0    // LCD Read control line  pin number
#define LCD_RD_TRIS       TRISE0    // LCD Read control line direction pin #
#define LCD_WR        PORTE1    // LCD Write control line pin number
#define LCD_WR_TRIS       TRISE1    // LCD Write control line irection pin #
#define LCD_CD        PORTA4    // LCD Control/data Select line
#define LCD_CD_TRIS       TRISA4    // LCD Control/data Select line direction
#define LCD_RST         PORTC0    // LCD RST_ line
#define LCD_RST_TRIS    TRISC0    // LCD RST_line direction
#endif

/*
***********************************************************************************************
*                   GLOBAL CONSTANTS
***********************************************************************************************
*/

/*
***********************************************************************************************
* Note    :   The T6963 controller's RAM address space from $0000 - $FFFF, total 64kbyte RAM.
*       It is just the RAM address set, not the actual RAM amount can be set!
*       However, everything manufacturer may mount different amount of RAM on its
*       module. Example, Powertip's PG12864-F has 4 kbyte RAM only.
*       RAM space to handle 128x64 dots in 8 font = 128x64/8 = 1,024 byte.
*       Thus, the LCD's actual visible screen area is 1 kbyte.
*       For 8-font, 16 COLUMN,
*       TEXT_HOME_ADDR  starts 0x0000 ending 0x01FF -> 512  bytes (for text use)?
*       GRH_HOME_ADDR starts 0x0200 ending 0x05FF -> 1,024 bytes ?
*       CG_HOME_ADDR  starts 0x1400 ending 0x147F -> 128  bytes (custom characters) ?
***********************************************************************************************
*/
#define TEXT_HOME_ADDR      0x0000
#define GRH_HOME_ADDR       0x0200
#define CG_HOME_ADDR    0x1400
#define COLUMN        16    //Set column number to be e.g. 32 for 8x8 fonts, 2 pages
#define MAX_ROW_PIXEL   64    //MAX_ROW_PIXEL the physical matrix length (y direction)
#define MAX_COL_PIXEL   128   //MAX_COL_PIXEL the physical matrix width (x direction)
#define ENABLE        1
#define DISABLE       0
#define BLACK       1
#define WHITE       0

/*
***********************************************************************************************
*                   DISPLAY MODE
***********************************************************************************************
*/
#define DISPLAY_OFF         0x90    //0b10010000, display off
#define CURSOR_ON_BLINK_OFF 0x92    //0b1001xx10, cursor on without blinking
#define CURSOR_BLINK_ON     0x93    //0b1001xx11, cursor on with blinking
#define TEXT_ON             0x94    //0b100101xx, text on, graphics off
#define GRAPHIC_ON          0x98    //0b100110xx, text off, graphics on
#define TEXT_GRH_ON         0x9C    //0b100111xx, text on, graphics on


/*
***********************************************************************************************
*                     MODE
***********************************************************************************************
* Example:  OR_MODE|EXT_CG_MODE   ->  OR mode, external CG ram mode
*       AND_MODE        ->  AND mode, internal CG ROM mode
***********************************************************************************************
*/
/*
***********************************************************************************************
*   In internal CG ROM MODE (INT_CG_MODE), character codes 00h - 7Fh represent the
*   pre-defined "internal" CG ROM characters, and codes 80h - FFh represent the
*   users' own "external" characters. In external CG ROM MODE (EXT_CG_MODE),
*   all 256 codes from 00h - FFh can be used to represent the users' own characters.
***********************************************************************************************
*/

#define INT_CG_MODE         0x80    //0b10000xxx, Internal CG ROM mode
#define EXT_CG_MODE         0x88    //0b10001xxx, External CG RAM mode
#define OR_MODE             0x80    //0b1000x000, OR mode, internal CG ROM mODE
#define XOR_MODE            0x81    //0b1000x001, XOR mode, internal CG ROM mode
#define AND_MODE            0x83    //0b1000x011, AND mode, internal CG ROM mode
#define TEXT_ATTR_MODE      0x84    //0b1000x100, text attribute mode, internal CG ROM mode



/*
***********************************************************************************************
*                   CURSOR MODE
***********************************************************************************************
*/
#define LINE_8_CURSOR       0xA7    //8-line cursor mode
#define LINE_7_CURSOR   0xA6  //7-line cursor mode
#define LINE_6_CURSOR   0xA5  //6-line cursor mode
#define LINE_5_CURSOR   0xA4  //5-line cursor mode
#define LINE_4_CURSOR   0xA3  //4-line cursor mode
#define LINE_3_CURSOR   0xA2  //3-Line cursor mode
#define LINE_2_CURSOR   0xA1  //2-Line cursor mode
#define LINE_1_CURSOR       0xA0    //1-Line cursor mode

/*
***********************************************************************************************
*                 TEXT ATTRIBUTE MODE
***********************************************************************************************
*/
#define ATTR_NORMAL         0x00    //Normal Display
#define ATTR_REVERSE        0x05    //Reverse Display
#define ATTR_INHIBIT        0x03    //Inhibit Display
#define ATTR_BLINK          0x08    //Blinking of Normal Display
#define ATTR_BLINK_REVERSE  0x0D    //Blinking of Reverse Display
#define ATTR_BLINK_INHIBIT  0x0B    //Blinking of Inhibit Display


/*
***********************************************************************************************
*                   GLOBAL VARIABLES
***********************************************************************************************
*/
extern unsigned int8  DisplayMode;  /* Keeps state of the display mode (DISPLAY MODE)   */
extern unsigned int8  Mode;     /* Keeps state of the MODE              */
extern unsigned int8  FontSize;   /* 6 font or 8 font                 */
extern unsigned char  CGBuffer[8];  /* Buffer for custom pattern            */

/*
***********************************************************************************************
*                 FUNCTION PROTOTYPES
***********************************************************************************************
*/
void GDispInit(void);
void GDispSetMode(unsigned int8 mode);
void GDispClrTxt(void);
void GDispClrGrh(void);
void GDispGoto(unsigned int16 row, unsigned int16 col);
void GDispChar(unsigned char c);
void GDispCharAt(unsigned int16 row, unsigned int16 col, unsigned char c);
void GDispSetCursor(unsigned int8 mode, unsigned int16 row, unsigned int16 col, unsigned int8 type);
void GDispSetPixel(unsigned int16 X, unsigned int16 Y, unsigned int8 color);
void GDispSetAttrb(unsigned int16 row, unsigned int16 col, unsigned int8 mode);
void GDispDefCGChar(unsigned int8 id, unsigned char *pat);
void GDispCGChar(unsigned int8 id);
void GDispCGCharAt(unsigned int16 row, unsigned int16 col, unsigned int8 id);
void GDispBlkIcon32X32At(unsigned int16 row, unsigned int16 col);
void GDispPixFontAt(unsigned int16 X, unsigned int16 Y, unsigned char* textptr, unsigned char size, int1 color);
/*
***********************************************************************************************
*                 FUNCTION PROTOTYPES
*                  HARDWARE SPECIFIC
***********************************************************************************************
*/
#define GDispChipEn   LCD_CE = 0          /* Low level Chip Enable macro      */
#define GDispChipDi   LCD_CE = 1          /* Low level Chip Disable macro     */
#define GDispCmdWr    LCD_DATA_TRIS = 0x00; \
            LCD_RD = 1; LCD_CD = 1; \
            LCD_WR = 0          /* Low level command write macro    */
#define GDispCmdRd    LCD_DATA_TRIS = 0xFF;   \
            LCD_RD = 0; LCD_CD = 1; \
            LCD_WR = 1          /* Low level command read macro     */
#define GDispDatWr    LCD_DATA_TRIS = 0x00; \
            LCD_RD = 1; LCD_CD = 0; \
            LCD_WR = 0          /* Low level data write macro     */
#define GDispDatRd    LCD_CD = 0; LCD_WR = 1    /* Low level data read macro      */

void GDispInitPort(void);
void GDispBusyChk(void);
void GDispAutoWrChk(void);
void GDispDataWr(unsigned char data);
void GDispAutoDataWr(unsigned char data);
void GDispCmdSend(unsigned char cmd);
