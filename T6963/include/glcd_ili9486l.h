'    Graphical LCD routines for the GCBASIC compiler
'    Copyright (C) 2017 Evan Venn

'    This library is free software; you can redistribute it and/or
'    modify it under the terms of the GNU Lesser General Public
'    License as published by the Free Software Foundation; either
'    version 2.1 of the License, or (at your option) any later version.

'    This library is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY; without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
'    Lesser General Public License for more details.

'    You should have received a copy of the GNU Lesser General Public
'    License along with this library; if not, write to the Free Software
'    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

'Notes:
' Supports ILI9486L controller only.

'Changes
' 21/04/2017:      Initial release
' 29/12/2018       Added 8Wire_Data_Bus support - beta
' 30/12/2018       Added Touch support, OLED, fixed rotate and FilledBox
' 24/1/2019        Revised UNO_8bit_Shield GLCDCLS (typos) and correct command and data send
' 28/1/2019        Revised to support GLCD_RESET and GLCD_RST

'
'Hardware settings
'Type
'''@hardware All; Controller Type; GLCD_TYPE; "GLCD_TYPE_ILI9486L"

'Serial lines (ILI9486L only)
'''@hardware GLCD_TYPE GLCD_TYPE_ILI9486L; Data/Command; GLCD_DC; IO_Pin
'''@hardware GLCD_TYPE GLCD_TYPE_ILI9486L; Chip Select; GLCD_CS; IO_Pin
'''@hardware GLCD_TYPE GLCD_TYPE_ILI9486L; Data In (LCD Out) GLCD_DI; IO_Pin
'''@hardware GLCD_TYPE GLCD_TYPE_ILI9486L; Data Out (LCD In) GLCD_DO; IO_Pin
'''@hardware GLCD_TYPE GLCD_TYPE_ILI9486L; Clock; GLCD_SCK; IO_Pin

'''@hardware GLCD_TYPE GLCD_TYPE_ILI9486L; Reset; GLCD_RST; IO_Pin

'Pin mappings for ILI9486L
#define ILI9486L_DC GLCD_DC
#define ILI9486L_CS GLCD_CS
#define ILI9486L_RST GLCD_RST

#define ILI9486L_DI GLCD_DI
#define ILI9486L_DO GLCD_DO
#define ILI9486L_SCK GLCD_SCK

#define ILI9486L_NOP     0x00
#define ILI9486L_SWRESET 0x01
#define ILI9486L_RDDID   0x04
#define ILI9486L_RDDST   0x09

#define ILI9486L_SLPIN   0x10
#define ILI9486L_SLPOUT  0x11
#define ILI9486L_PTLON   0x12
#define ILI9486L_NORON   0x13

#define ILI9486L_RDMODE  0x0A
#define ILI9486L_RDMADCTL  0x0B
#define ILI9486L_RDPIXFMT  0x0C
#define ILI9486L_RDIMGFMT  0x0D
#define ILI9486L_RDSELFDIAG  0x0F

#define ILI9486L_INVOFF  0x20
#define ILI9486L_INVON   0x21
#define ILI9486L_GAMMASET 0x26
#define ILI9486L_DISPOFF 0x28
#define ILI9486L_DISPON  0x29

#define ILI9486L_CASET   0x2A
#define ILI9486L_PASET   0x2B
#define ILI9486L_RAMWR   0x2C
#define ILI9486L_RAMRD   0x2E

#define ILI9486L_PTLAR   0x30
#define ILI9486L_VSCRDEF 0x33
#define ILI9486L_MADCTL  0x36

#define ILI9486L_MADCTL_MY  0x80
#define ILI9486L_MADCTL_MX  0x40
#define ILI9486L_MADCTL_MV  0x20
#define ILI9486L_MADCTL_ML  0x10
#define ILI9486L_MADCTL_RGB 0x00
#define ILI9486L_MADCTL_BGR 0x08
#define ILI9486L_MADCTL_MH  0x04

#define ILI9486L_PIXFMT  0x3A

#define ILI9486L_FRMCTR1 0xB1
#define ILI9486L_FRMCTR2 0xB2
#define ILI9486L_FRMCTR3 0xB3
#define ILI9486L_INVCTR  0xB4
#define ILI9486L_DFUNCTR 0xB6

#define ILI9486L_PWCTR1  0xC0
#define ILI9486L_PWCTR2  0xC1
#define ILI9486L_PWCTR3  0xC2
#define ILI9486L_PWCTR4  0xC3
#define ILI9486L_PWCTR5  0xC4
#define ILI9486L_VMCTR1  0xC5
#define ILI9486L_VMCTR2  0xC7

#define ILI9486L_RDID1   0xDA
#define ILI9486L_RDID2   0xDB
#define ILI9486L_RDID3   0xDC
#define ILI9486L_RDID4   0xDD

#define ILI9486L_GMCTRP1 0xE0
#define ILI9486L_GMCTRN1 0xE1

#define ILI9486L_PWCTR6  0xFC

#define ILI9486L_WHITE          TFT_WHITE
#define ILI9486L_BLACK          TFT_BLACK
#define ILI9486L_RED            TFT_RED
#define ILI9486L_GREEN          TFT_GREEN
#define ILI9486L_BLUE           TFT_BLUE
#define ILI9486L_YELLOW         TFT_YELLOW
#define ILI9486L_CYAN           TFT_CYAN
#define ILI9486L_MAGENTA        TFT_MAGENTA
#define ILI9486L_NAVY           TFT_NAVY
#define ILI9486L_DARKGREEN      TFT_DARKGREEN
#define ILI9486L_DARKCYAN       TFT_DARKCYAN
#define ILI9486L_MAROON         TFT_MAROON
#define ILI9486L_PURPLE         TFT_PURPLE
#define ILI9486L_OLIVE          TFT_OLIVE
#define ILI9486L_LIGHTGREY      TFT_LIGHTGREY
#define ILI9486L_DARKGREY       TFT_DARKGREY
#define ILI9486L_ORANGE         TFT_ORANGE
#define ILI9486L_GREENYELLOW    TFT_GREENYELLOW
#define ILI9486L_PINK           TFT_PINK


#script
  ' For the UNO_8bit_Shield you can use GLCD_RS or GLCD_DC.  They are mapped automatically
  GLCD_DC_Defined = 0
  if GLCD_TYPE = GLCD_TYPE_ILI9486L then
    if UNO_8bit_Shield then
      'is there a GLCD_DC defined?
      if GLCD_DC then
          GLCD_DC_Defined = 1
      end if

      'if no GLCD_DC then is there is an GLCD_RS
      if GLCD_DC_Defined = 0 Then
          if GLCD_RS then
             'map
             GLCD_DC = GLCD_RS
             GLCD_DC_Defined = 1
          end if
          'so, if there one defined?
          if GLCD_DC_Defined = 0 Then
              warning "No GLCD_DC defined"
          end if
      end if
    end if

      GLCD_RST_Defined = 0
      'is there a GLCD_DC defined?
      if GLCD_RST then
          GLCD_RST_Defined = 1
      end if


      'if no GLCD_RST then is there is an GLCD_RESET
      if GLCD_RST_Defined = 0 Then
          if GLCD_RESET then
             'map
             GLCD_RST = GLCD_RESET
             GLCD_RST_Defined = 1
          end if
          'so, if there one defined?
          if GLCD_RST_Defined = 0 Then
              warning "No GLCD_RST defined"
          end if
      end if
    end if



  end if

  if PIC Then
    if UNO_8bit_Shield then
        error "A PIC with UNO_8bit_Shield not supported"
    end if
  end if

#endscript

#startup InitGLCD_ILI9486L

'''Initialise the GLCD device
Sub InitGLCD_ILI9486L

  '  Mapped to global variables to same RAM
  dim ILI9486L_GLCD_HEIGHT, ILI9486L_GLCD_WIDTH as word


  #if GLCD_TYPE = GLCD_TYPE_ILI9486L

    #ifdef GLCD_DataPort
        InitGLCD_fullport_ILI9486L
    #endif

    #ifndef GLCD_DataPort
        'Setup code for ILI9486L controllers
        #ifndef UNO_8bit_Shield

            'SPI Pin directions
            Dir ILI9486L_CS Out
            Dir ILI9486L_DC Out
            Dir ILI9486L_RST Out

            Dir ILI9486L_DI In
            Dir ILI9486L_DO Out
            Dir ILI9486L_SCK Out

        #endif

        #ifdef UNO_8bit_Shield
          '8 bit data bus directions
          #define ILI9486L_RST GLCD_RST
          #define ILI9486L_CS GLCD_CS
          #define ILI9486L_DC GLCD_DC
          #define ILI9486L_WR GLCD_WR
          #define ILI9486L_RD GLCD_RD


          #define ILI9486L_DB0 GLCD_DB0
          #define ILI9486L_DB1 GLCD_DB1
          #define ILI9486L_DB2 GLCD_DB2
          #define ILI9486L_DB3 GLCD_DB3
          #define ILI9486L_DB4 GLCD_DB4
          #define ILI9486L_DB5 GLCD_DB5
          #define ILI9486L_DB6 GLCD_DB6
          #define ILI9486L_DB7 GLCD_DB7


          dir  ILI9486L_DB7 OUT
          dir  ILI9486L_DB6 OUT
          dir  ILI9486L_DB5 OUT
          dir  ILI9486L_DB4 OUT
          dir  ILI9486L_DB3 OUT
          dir  ILI9486L_DB2 OUT
          dir  ILI9486L_DB1 OUT
          dir  ILI9486L_DB0 OUT

          'Set pin directions
          Dir ILI9486L_RD  Out
          Dir ILI9486L_WR  Out
          Dir ILI9486L_DC  Out
          Dir ILI9486L_CS  Out
          Dir ILI9486L_RST Out

          Set ILI9486L_RD On
          Set ILI9486L_WR On
          Set ILI9486L_DC On
          set ILI9486L_CS ON
          Set ILI9486L_RST On
        #endif

        #ifdef ILI9486L_HardwareSPI
          ' harware SPI mode
          SPIMode MasterFast, 0
        #endif

       Set ILI9486L_CS On
       Set ILI9486L_DC On


        'Reset display
        Wait 50 ms
        Set ILI9486L_RST On
        Wait 5 ms
        'Reset sequence (lower line for at least 10 us)
        Set ILI9486L_RST Off
        Wait 20 us
        Set ILI9486L_RST On
        Wait 150 ms

        SendCommand_ILI9486L(0XF2)
        SendData_ILI9486L(0x18)
        SendData_ILI9486L(0xA3)
        SendData_ILI9486L(0x12)
        SendData_ILI9486L(0x02)
        SendData_ILI9486L(0XB2)
        SendData_ILI9486L(0x12)
        SendData_ILI9486L(0xFF)
        SendData_ILI9486L(0x10)
        SendData_ILI9486L(0x00)
        SendCommand_ILI9486L(0XF8)
        SendData_ILI9486L(0x21)
        SendData_ILI9486L(0x04)
        SendCommand_ILI9486L(0XF9)
        SendData_ILI9486L(0x00)
        SendData_ILI9486L(0x08)
        SendCommand_ILI9486L(0x36)
        SendData_ILI9486L(0x08)
        SendCommand_ILI9486L(0x3A)
        SendData_ILI9486L(0x05)
        SendCommand_ILI9486L(0xB4)
        SendData_ILI9486L(0x01)
        SendCommand_ILI9486L(0xB6)
        SendData_ILI9486L(0x02)
        SendData_ILI9486L(0x22)
        SendCommand_ILI9486L(0xC1)
        SendData_ILI9486L(0x41)
        SendCommand_ILI9486L(0xC5)
        SendData_ILI9486L(0x00)
        SendData_ILI9486L(0x07)
        SendCommand_ILI9486L(0xE0)
        SendData_ILI9486L(0x0F)
        SendData_ILI9486L(0x1F)
        SendData_ILI9486L(0x1C)
        SendData_ILI9486L(0x0C)
        SendData_ILI9486L(0x0F)
        SendData_ILI9486L(0x08)
        SendData_ILI9486L(0x48)
        SendData_ILI9486L(0x98)
        SendData_ILI9486L(0x37)
        SendData_ILI9486L(0x0A)
        SendData_ILI9486L(0x13)
        SendData_ILI9486L(0x04)
        SendData_ILI9486L(0x11)
        SendData_ILI9486L(0x0D)
        SendData_ILI9486L(0x00)
        SendCommand_ILI9486L(0xE1)
        SendData_ILI9486L(0x0F)
        SendData_ILI9486L(0x32)
        SendData_ILI9486L(0x2E)
        SendData_ILI9486L(0x0B)
        SendData_ILI9486L(0x0D)
        SendData_ILI9486L(0x05)
        SendData_ILI9486L(0x47)
        SendData_ILI9486L(0x75)
        SendData_ILI9486L(0x37)
        SendData_ILI9486L(0x06)
        SendData_ILI9486L(0x10)
        SendData_ILI9486L(0x03)
        SendData_ILI9486L(0x24)
        SendData_ILI9486L(0x20)
        SendData_ILI9486L(0x00)
        SendCommand_ILI9486L(0x11)
        wait 120 ms
        SendCommand_ILI9486L(0x29)


        'Default Colours
        GLCDBackground = ILI9486L_BLACK
        GLCDForeground = ILI9486L_WHITE

        'Variables required for device
        ILI9486L_GLCD_WIDTH = GLCD_WIDTH
        ILI9486L_GLCD_HEIGHT = GLCD_HEIGHT
        GLCDFontWidth = 6
        GLCDfntDefault = 0
        GLCDfntDefaultsize = 2

        GLCDRotate Portrait

        GLCDCLS

    #endif

  #endif

End Sub


'''Initialise the GLCD device
Sub InitGLCD_fullport_ILI9486L

  '  Mapped to global variables to same RAM
  dim ILI9486L_GLCD_HEIGHT, ILI9486L_GLCD_WIDTH as word

  'Setup code for ILI9486L controllers
    #if GLCD_TYPE = GLCD_TYPE_ILI9486L

      '8 bit data bus directions
      #define ILI9486L_RST GLCD_RST
      #define ILI9486L_CS GLCD_CS
      #define ILI9486L_DC GLCD_DC
      #define ILI9486L_WR GLCD_WR
      #define ILI9486L_RD GLCD_RD

      'Set pin directions
      Dir ILI9486L_RD  Out
      Dir ILI9486L_WR  Out
      Dir ILI9486L_DC  Out
      Dir ILI9486L_CS  Out
      Dir ILI9486L_RST Out

      Set ILI9486L_RD On
      Set ILI9486L_WR On
      Set ILI9486L_DC On
      set ILI9486L_CS ON
      Set ILI9486L_RST On

      Dir GLCD_DataPort out

      'Reset display
      Wait 50 ms
      Set ILI9486L_RST On
      Wait 5 ms
      'Reset sequence (lower line for at least 10 us)
      Set ILI9486L_RST Off
      Wait 20 us
      Set ILI9486L_RST On
      Wait 150 ms

      SendCommand_ILI9486L(0XF2)
      SendData_ILI9486L(0x18)
      SendData_ILI9486L(0xA3)
      SendData_ILI9486L(0x12)
      SendData_ILI9486L(0x02)
      SendData_ILI9486L(0XB2)
      SendData_ILI9486L(0x12)
      SendData_ILI9486L(0xFF)
      SendData_ILI9486L(0x10)
      SendData_ILI9486L(0x00)
      SendCommand_ILI9486L(0XF8)
      SendData_ILI9486L(0x21)
      SendData_ILI9486L(0x04)
      SendCommand_ILI9486L(0XF9)
      SendData_ILI9486L(0x00)
      SendData_ILI9486L(0x08)
      SendCommand_ILI9486L(0x36)
      SendData_ILI9486L(0x08)
      SendCommand_ILI9486L(0x3A)
      SendData_ILI9486L(0x05)
      SendCommand_ILI9486L(0xB4)
      SendData_ILI9486L(0x01)
      SendCommand_ILI9486L(0xB6)
      SendData_ILI9486L(0x02)
      SendData_ILI9486L(0x22)
      SendCommand_ILI9486L(0xC1)
      SendData_ILI9486L(0x41)
      SendCommand_ILI9486L(0xC5)
      SendData_ILI9486L(0x00)
      SendData_ILI9486L(0x07)
      SendCommand_ILI9486L(0xE0)
      SendData_ILI9486L(0x0F)
      SendData_ILI9486L(0x1F)
      SendData_ILI9486L(0x1C)
      SendData_ILI9486L(0x0C)
      SendData_ILI9486L(0x0F)
      SendData_ILI9486L(0x08)
      SendData_ILI9486L(0x48)
      SendData_ILI9486L(0x98)
      SendData_ILI9486L(0x37)
      SendData_ILI9486L(0x0A)
      SendData_ILI9486L(0x13)
      SendData_ILI9486L(0x04)
      SendData_ILI9486L(0x11)
      SendData_ILI9486L(0x0D)
      SendData_ILI9486L(0x00)
      SendCommand_ILI9486L(0xE1)
      SendData_ILI9486L(0x0F)
      SendData_ILI9486L(0x32)
      SendData_ILI9486L(0x2E)
      SendData_ILI9486L(0x0B)
      SendData_ILI9486L(0x0D)
      SendData_ILI9486L(0x05)
      SendData_ILI9486L(0x47)
      SendData_ILI9486L(0x75)
      SendData_ILI9486L(0x37)
      SendData_ILI9486L(0x06)
      SendData_ILI9486L(0x10)
      SendData_ILI9486L(0x03)
      SendData_ILI9486L(0x24)
      SendData_ILI9486L(0x20)
      SendData_ILI9486L(0x00)
      SendCommand_ILI9486L(0x11)
      wait 120 ms
      SendCommand_ILI9486L(0x29)


      'Default Colours
      GLCDBackground = ILI9486L_BLACK
      GLCDForeground = ILI9486L_WHITE

      'Variables required for device
      ILI9486L_GLCD_WIDTH = GLCD_WIDTH
      ILI9486L_GLCD_HEIGHT = GLCD_HEIGHT
      GLCDFontWidth = 6
      GLCDfntDefault = 0
      GLCDfntDefaultsize = 2

      GLCDRotate Portrait

      GLCDCLS

  #endif

End Sub


Sub DSTB_ILI9486L( Optional In PowerMode = On  )

  if PowerMode = Off Then

       SendCommand_ILI9486L( ILI9486L_DISPOFF )
       SendCommand_ILI9486L( ILI9486L_SLPIN )

    Else

       SendCommand_ILI9486L( ILI9486L_SLPOUT )
       wait 120 ms
       SendCommand_ILI9486L( ILI9486L_DISPON )

    End if


End Sub

'Subs
'''Clears the GLCD screen
Sub GLCDCLS_ILI9486L ( Optional In  GLCDBackground as word = GLCDBackground )

    dim ILI9486LSendWord as word
    ' initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
    GLCD_yordinate = 0

    SetAddressWindow_ILI9486L ( 0, 0, GLCD_WIDTH  , GLCD_HEIGHT )
    ILI9486LSendWord = GLCDBackground

    GLCDCLS_HiBytePortion1 = (PORTD & 0B00000011) | ((ILI9486LSendWord_H) & 0B11111100);
    GLCDCLS_HiBytePortion2 = (PORTB & 0B11111100) | ((ILI9486LSendWord_H) & 0B00000011);
    GLCDCLS_LoBytePortion1 =  (PORTD & 0B00000011) | ((ILI9486LSendWord) & 0B11111100);
    GLCDCLS_LoBytePortion2 =  (PORTB & 0B11111100) | ((ILI9486LSendWord) & 0B00000011);

    set ILI9486L_CS OFF
    set ILI9486L_DC ON
    Repeat 100
      Repeat 48
           Repeat 32
        #ifndef UNO_8bit_Shield
            #ifdef ILI9486L_HardwareSPI
    '         Could use these as an alternative
    '         FastHWSPITransfer  ILI9486LSendWord_h
    '         FastHWSPITransfer  ILI9486LSendWord

              #ifdef PIC
                #ifndef Var(SSPCON1)
                  #ifdef Var(SSPCON)
                    Dim SSPCON1 Alias SSPCON
                  #endif
                #endif
                'Clear WCOL
                Set SSPCON1.WCOL Off
                'Put byte to send into buffer
                'Will start transfer
                SSPBUF = ILI9486LSendWord_h
                Wait While SSPSTAT.BF = Off
                Set SSPSTAT.BF Off
                #if ChipFamily 16
                  ILI9486LTempOut = SSPBUF
                #endif


                'Clear WCOL
                Set SSPCON1.WCOL Off
                'Put byte to send into buffer
                'Will start transfer
                SSPBUF = ILI9486LSendWord
                Wait While SSPSTAT.BF = Off
                Set SSPSTAT.BF Off
                #if ChipFamily 16
                  ILI9486LTempOut = SSPBUF
                #endif

              #endif
              #ifdef AVR
'                 was thjs slower code
'                FastHWSPITransfer  ILI9486LSendWord_h
'                FastHWSPITransfer  ILI9486LSendWord

                  'Master mode only
                  SPDR = ILI9486LSendWord_h
                  Do

                  Loop While SPSR.WCOL
                  'Read buffer
                  'Same for master and slave
                  Wait While SPSR.SPIF = Off

                  'Master mode only
                  SPDR = ILI9486LSendWord
                  Do

                  Loop While SPSR.WCOL
                  'Read buffer
                  'Same for master and slave
                  Wait While SPSR.SPIF = Off

              #endif

            #endif

            #ifndef ILI9486L_HardwareSPI
              SendWord_ILI9486L ( GLCDBackground )
            #endif

        #endif

        #ifdef UNO_8bit_Shield

              #ifdef AVR
                'Write 8 bit bus for AVR
                PORTD = GLCDCLS_HiBytePortion1
                PORTB = GLCDCLS_HiBytePortion2
                set ILI9486L_WR OFF
                set ILI9486L_WR ON
                PORTD = GLCDCLS_LoBytePortion1
                PORTB = GLCDCLS_LoBytePortion2
                set ILI9486L_WR OFF
                set ILI9486L_WR ON
              #endif
        #endif
      end repeat
     end repeat
    end repeat
    set ILI9486L_CS ON;


End Sub


Sub GLCDCLS_fullport_ILI9486L ( Optional In  GLCDBackground as word = GLCDBackground )

    dim ILI9486LSendWord as word
    ' initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
    GLCD_yordinate = 0

    SetAddressWindow_ILI9486L ( 0, 0, GLCD_WIDTH  , GLCD_HEIGHT )
    ILI9486LSendWord = GLCDBackground

    set ILI9486L_CS OFF
    set ILI9486L_DC ON
    Repeat 100
        Repeat 48
          Repeat 32
              'Write 8 bit bus
              GLCD_DataPort = ILI9486LSendWord_h
              set ILI9486L_WR OFF
              set ILI9486L_WR ON
              GLCD_DataPort = ILI9486LSendWord
              set ILI9486L_WR OFF
              set ILI9486L_WR ON
          end repeat
       end repeat
    end repeat
    set ILI9486L_CS ON;

End Sub

'''Draws a string at the specified location on the ST7920 GLCD
'''@param StringLocX X coordinate for message
'''@param CharLocY Y coordinate for message
'''@param Chars String to display
'''@param LineColour Line Color, either 1 or 0
Sub GLCDDrawString_ILI9486L( In StringLocX as word, In CharLocY as word, In Chars as string, Optional In LineColour as word = GLCDForeground )
'    dim TargetCharCol as word
'    for xchar = 1 to Chars(0)
'      ' June 2014
'      ' Corrected error X calcaluation. It was adding an Extra 1!
'      TargetCharCol = StringLocX + ((xchar*( GLCDFontWidth * GLCDfntDefaultsize ))-( GLCDFontWidth * GLCDfntDefaultsize ))
'      GLCDDrawChar TargetCharCol , CharLocY , Chars(xchar), LineColour
'    next
'
  dim GLCDPrintLoc as word

  GLCDPrintLoc = StringLocX

  #ifdef GLCD_OLED_FONT
      dim OldGLCDFontWidth as Byte
      OldGLCDFontWidth = GLCDFontWidth
  #endif

  for xchar = 1 to Chars(0)

      GLCDDrawChar GLCDPrintLoc , CharLocY , Chars(xchar), LineColour
      GLCDPrintIncrementPixelPositionMacro

  next

  #ifdef GLCD_OLED_FONT
      GLCDFontWidth = OldGLCDFontWidth
  #endif

end sub




'''Draws a character at the specified location on the ST7920 GLCD
'''@param StringLocX X coordinate for message
'''@param CharLocY Y coordinate for message
'''@param Chars String to display
'''@param LineColour Line Color, either 1 or 0

Sub GLCDDrawChar_ILI9486L(In CharLocX as word, In CharLocY as word, In CharCode, Optional In LineColour as word = GLCDForeground )

  'This has got a tad complex
  'We have three major pieces
  '1 The preamble - this just adjusted color and the input character
  '2 The code that deals with GCB fontset
  '3 The code that deals with OLED fontset
  '
  'You can make independent change to section 2 and 3 but they are mutual exclusive with many common pieces

   dim CharCol, CharRow, GLCDTemp as word
   CharCode -= 15

   CharCol=0

   #ifndef GLCD_OLED_FONT

        if CharCode>=178 and CharCode<=202 then
           CharLocY=CharLocY-1
        end if

        For CurrCharCol = 1 to 5
          Select Case CurrCharCol
            Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
            Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
            Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
            Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
            Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
          End Select
          CharRow=0
          For CurrCharRow = 1 to 8
              CharColS=0
              For Col=1 to GLCDfntDefaultsize
                    CharColS +=1
                    CharRowS=0
                    For Row=1 to GLCDfntDefaultsize
                        CharRowS +=1
                        if CurrCharVal.0=1 then
                           PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, LineColour
                        Else
                           PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, GLCDBackground
                        End if
                    Next Row
              Next Col
            Rotate CurrCharVal Right
            CharRow +=GLCDfntDefaultsize
          Next
          CharCol +=GLCDfntDefaultsize
        Next

    #endif

    #ifdef GLCD_OLED_FONT

        'Calculate the pointer to the OLED fonts.
        'These fonts are not multiple tables one is a straight list the other is a lookup table with data.
        Dim LocalCharCode as word

        'Get key information and set up the fonts parameters
        Select case GLCDfntDefaultSize
            case 1 'This font is two font tables of an index and data
              CharCode = CharCode - 16
              ReadTable OLEDFont1Index, CharCode, LocalCharCode
              ReadTable OLEDFont1Data, LocalCharCode , COLSperfont
              GLCDFontWidth = COLSperfont + 1
              ROWSperfont = 7  'which is really 8 as we start at 0

            case 2 'This is one font table
              CharCode = CharCode - 17
              'Pointer to table of font elements
              LocalCharCode = (CharCode * 20)
              COLSperfont = 9  'which is really 10 as we start at 0

              ROWSperfont=15  'which is really 16 as we start at 0

        End Select


        'The main loop - loop throught the number of columns
        For CurrCharCol = 0 to COLSperfont  'number of columns in the font , with two row of data

          'Index the pointer to the code that we are looking for as we need to do this lookup many times getting more font data
          LocalCharCode++
          Select case GLCDfntDefaultSize
              case 1
                ReadTable OLEDFont1Data, LocalCharCode, CurrCharVal

              case 2
                #ifndef GLCD_Disable_OLED_FONT2
                  'Read this 20 times... (0..COLSperfont) [ * 2 ]
                  ReadTable OLEDFont2, LocalCharCode, CurrCharVal
                #endif
                #ifdef GLCD_Disable_OLED_FONT2
                  CurrCharVal = GLCDBackground
                #endif
          End Select

            'we handle 8 or 16 pixels of height
            For CurrCharRow = 0 to ROWSperfont
                'Set the pixel
                If CurrCharVal.0 = 0 Then
                          PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, GLCDBackground
                Else
                          PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, LineColour
                End If

                Rotate CurrCharVal Right

                'Set to next row of date, a second row
                if GLCDfntDefaultSize = 2 and CurrCharRow = 7 then
                  LocalCharCode++
                  #ifndef GLCD_Disable_OLED_FONT2
                    ReadTable OLEDFont2, LocalCharCode, CurrCharVal
                  #endif
                  #ifdef GLCD_Disable_OLED_FONT2
                    CurrCharVal = GLCDBackground
                  #endif
                end if

                'It is the intercharacter space, put out one pixel row
                if CurrCharCol = COLSperfont then
                    'Put out a white intercharacter pixel/space
                     GLCDTemp = CharLocX + CurrCharCol
                     if GLCDfntDefaultSize = 2 then
                        GLCDTemp++
                     end if
                     PSet GLCDTemp , CharLocY + CurrCharRow, GLCDBackground
                end if

            Next



        Next


    #endif

End Sub
'''Draws a character at the specified location on the ST7920 GLCD
'''@param StringLocX X coordinate for message
'''@param CharLocY Y coordinate for message
'''@param Chars String to display
'''@param LineColour Line Color, either 1 or 0
Sub OldGLCDDrawChar_ILI9486L(In CharLocX as word, In CharLocY as word, In CharCode, Optional In LineColour as word = GLCDForeground )


  dim CharCol, CharRow as word
  CharCode -= 15

          if CharCode>=178 and CharCode<=202 then
             CharLocY=CharLocY-1
          end if
          CharCol=1

  For CurrCharCol = 1 to 5
    Select Case CurrCharCol
      Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
      Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
      Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
      Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
      Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
    End Select
    CharRow=0
    For CurrCharRow = 1 to 8
        CharColS=0
        For Col=1 to GLCDfntDefaultsize
              CharColS +=1
              CharRowS=0
              For Row=1 to GLCDfntDefaultsize
                  CharRowS +=1
                  if CurrCharVal.0=1 then
                     PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, LineColour
                  Else
                     PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, GLCDBackground
                  End if
              Next Row
        Next Col
      Rotate CurrCharVal Right
      CharRow +=GLCDfntDefaultsize
    Next
    CharCol +=GLCDfntDefaultsize
  Next


End Sub


'''Draws a filled box on the GLCD screen
'''@param LineX1 Top left corner X location
'''@param LineY1 Top left corner Y location
'''@param LineX2 Bottom right corner X location
'''@param LineY2 Bottom right corner Y location
'''@param LineColour Colour of box (0 = erase, 1 = draw, default is 1)
Sub FilledBox_ILI9486L(In LineX1 as word, In LineY1 as word, In LineX2 as word, In LineY2 as word, Optional In LineColour As Word = GLCDForeground)
  dim GLCDTemp, DrawLine as word
  'Make sure that starting point (1) is always less than end point (2)
  If LineX1 > LineX2 Then
    GLCDTemp = LineX1
    LineX1 = LineX2
    LineX2 = GLCDTemp
  End If
  If LineY1 > LineY2 Then
    GLCDTemp = LineY1
    LineY1 = LineY2
    LineY2 = GLCDTemp
  End If


  'Fill with colour
  'Draw lines going across
  For DrawLine = LineX1 To LineX2
    For GLCDTemp = LineY1 To LineY2
      PSet DrawLine, GLCDTemp, LineColour
    Next
  Next

End Sub

'''Draws a pixel on the GLCD
'''@param GLCDX X coordinate of pixel
'''@param GLCDY Y coordinate of pixel
'''@param GLCDColour State of pixel
Sub PSet_ILI9486L(In GLCDX as word, In GLCDY as word, In GLCDColour As Word)

  select case GLCDRotateState
        case PORTRAIT  '0 degree
              SetAddressWindow_ILI9486L ( GLCDX, GLCDY, GLCDX, GLCDY )
              SendWord_ILI9486L GLCDColour

        case LANDSCAPE
             SetAddressWindow_ILI9486L ( GLCDy, ILI9486L_GLCD_WIDTH -GLCDx -0, GLCDy, ILI9486L_GLCD_WIDTH -GLCDx -0 )
             SendWord_ILI9486L GLCDColour

        case PORTRAIT_REV
            SetAddressWindow_ILI9486L ( ILI9486L_GLCD_WIDTH - GLCDX-0, ILI9486L_GLCD_HEIGHT - GLCDY-0, ILI9486L_GLCD_WIDTH - GLCDX-0, ILI9486L_GLCD_HEIGHT - GLCDY-0 )
            SendWord_ILI9486L GLCDColour

        case LANDSCAPE_REV
             SetAddressWindow_ILI9486L ( ILI9486L_GLCD_HEIGHT - GLCDy-0, GLCDx, ILI9486L_GLCD_HEIGHT - GLCDy-0, GLCDx )
             SendWord_ILI9486L GLCDColour

        case else
            SetAddressWindow_ILI9486L ( GLCDX, GLCDY, GLCDX, GLCDY )
            SendWord_ILI9486L GLCDColour

  end select

End Sub




'''Send a command to the ILI9486L GLCD
'''@param ILI9486LSendByte Command to send
'''@hide
sub  SendCommand_ILI9486L( IN ILI9486LSendByte as byte )

    #ifndef UNO_8bit_Shield
      set ILI9486L_CS OFF;
      set ILI9486L_DC OFF;

      #ifdef ILI9486L_HardwareSPI
        'Hardware SPI ****************************************
         SPITransfer  ILI9486LSendByte,  ILI9486LTempOut
         set ILI9486L_CS ON;
         exit sub
      #endif

      #ifndef ILI9486L_HardwareSPI
      'Software SPI ****************************************
      repeat 8

        if ILI9486LSendByte.7 = ON  then
          set ILI9486L_DO ON;
        else
          set ILI9486L_DO OFF;
        end if
        SET GLCD_SCK On;
        rotate ILI9486LSendByte left
        set GLCD_SCK Off;

      end repeat
      set ILI9486L_CS ON;
      #endif
    #endif


    #ifdef UNO_8bit_Shield
      'UNO_8bit_Shield for UNO Shield ****************************************
      set ILI9486L_CS OFF;
      set ILI9486L_DC OFF;

      #ifdef AVR
      PORTD = (PORTD & 0B00000011) | ((ILI9486LSendByte) & 0B11111100);
      PORTB = (PORTB & 0B11111100) | ((ILI9486LSendByte) & 0B00000011);
      #endif


      set ILI9486L_WR OFF
      set ILI9486L_WR ON


      set ILI9486L_CS ON;
    #endif

end Sub

'''Send a data byte to the ILI9486L GLCD
'''@param ILI9486LSendByte Byte to send
'''@hide
sub  SendData_ILI9486L( IN ILI9486LSendByte as byte )

    #ifndef UNO_8bit_Shield
      set ILI9486L_CS OFF;
      set ILI9486L_DC ON;

      #ifdef ILI9486L_HardwareSPI
        'Hardware SPI ****************************************
         SPITransfer  ILI9486LSendByte,  ILI9486LTempOut
         set ILI9486L_CS ON;
         exit sub
      #endif

      #ifndef ILI9486L_HardwareSPI
      'Software SPI ****************************************
      repeat 8

        if ILI9486LSendByte.7 = ON then
          set ILI9486L_DO ON;
        else
          set ILI9486L_DO OFF;
        end if
        SET GLCD_SCK On;
        rotate ILI9486LSendByte left
        set GLCD_SCK Off;

      end Repeat
      set ILI9486L_CS ON;
      #endif
    #endif

    #ifdef UNO_8bit_Shield
      'UNO_8bit_Shield for UNO Shield ****************************************
      set ILI9486L_CS OFF;
      set ILI9486L_DC ON;

      #ifdef AVR
      PORTD = (PORTD & 0B00000011) | ((ILI9486LSendByte) & 0B11111100);
      PORTB = (PORTB & 0B11111100) | ((ILI9486LSendByte) & 0B00000011);
      #endif

      set ILI9486L_WR OFF
      set ILI9486L_WR ON

      set ILI9486L_CS ON;
    #endif

end Sub

'''Send a data word (16 bits) to the ILI9486L GLCD
'''@param ILI9486LSendWord  Word to send
'''@hide
Sub SendWord_ILI9486L(In ILI9486LSendWord As Word)

  #ifndef UNO_8bit_Shield
      set ILI9486L_CS OFF;
      set ILI9486L_DC ON;

      #ifdef ILI9486L_HardwareSPI
        'Hardware SPI ****************************************
         SPITransfer  ILI9486LSendWord_H,  ILI9486LTempOut
         SPITransfer  ILI9486LSendWord,  ILI9486LTempOut
         set ILI9486L_CS ON;
         exit sub
      #endif

      #ifndef ILI9486L_HardwareSPI
      'Software SPI ****************************************
      repeat 16

        if ILI9486LSendWord.15 = ON then
          set ILI9486L_DO ON;
        else
          set ILI9486L_DO OFF;
        end if
        SET GLCD_SCK On;
        rotate ILI9486LSendWord left
        set GLCD_SCK Off;

      end repeat
      set ILI9486L_CS ON;
      #endif
  #endif

  #ifdef UNO_8bit_Shield
    'UNO_8bit_Shield for UNO Shield ****************************************
    set ILI9486L_CS OFF;
    set ILI9486L_DC ON;

    #ifdef AVR
    PORTD = (PORTD & 0B00000011) | ((ILI9486LSendWord_H) & 0B11111100);
    PORTB = (PORTB & 0B11111100) | ((ILI9486LSendWord_H) & 0B00000011);
    #endif

    set ILI9486L_WR OFF
    set ILI9486L_WR ON

    #ifdef AVR
    PORTD = (PORTD & 0B00000011) | ((ILI9486LSendWord) & 0B11111100);
    PORTB = (PORTB & 0B11111100) | ((ILI9486LSendWord) & 0B00000011);
    #endif

    set ILI9486L_WR OFF
    set ILI9486L_WR ON

    set ILI9486L_CS ON;
  #endif
End Sub



'''Send a command to the ILI9486L GLCD
'''@param ILI9486LSendByte Command to send
'''@hide
sub  SendCommand_fullport_ILI9486L( IN ILI9486LSendByte as byte )

      '8Bit_Data_Port ****************************************
      set ILI9486L_CS OFF;
      set ILI9486L_DC OFF;

      GLCD_DataPort = ILI9486LSendByte

      set ILI9486L_WR OFF
      set ILI9486L_WR ON

      set ILI9486L_CS ON;

end Sub

'''Send a data byte to the ILI9486L GLCD
'''@param ILI9486LSendByte Byte to send
'''@hide
sub  SendData_fullport_ILI9486L( IN ILI9486LSendByte as byte )

      '8Bit_Data_Port ****************************************
      set ILI9486L_CS OFF;
      set ILI9486L_DC ON;

      GLCD_DataPort = ILI9486LSendByte

      set ILI9486L_WR OFF
      set ILI9486L_WR ON

      set ILI9486L_CS ON;

end Sub

'''Send a data word (16 bits) to the ILI9486L GLCD
'''@param ILI9486LSendWord  Word to send
'''@hide
Sub SendWord_fullport_ILI9486L(In ILI9486LSendWord As Word)

    '8Bit_Data_Port ****************************************
    set ILI9486L_CS OFF;
    set ILI9486L_DC ON;

    GLCD_DataPort = ILI9486LSendWord_h

    set ILI9486L_WR OFF
    set ILI9486L_WR ON

    GLCD_DataPort = ILI9486LSendWord

    set ILI9486L_WR OFF
    set ILI9486L_WR ON

    set ILI9486L_CS ON;
  #endif
End Sub


'''Set the row or column address range for the ILI9486L GLCD
'''@param ILI9486LAddressType Address Type (ILI9486L_ROW or ILI9486L_COLUMN)
'''@param ILI9486LStart Starting address
'''@param ILI9486LEnd Ending address
'''@hide
Sub SetAddressWindow_ILI9486L( In _x1 as word, in _y1 as word, in _x2 as word, in _y2 as word)

  SendCommand_ILI9486L(ILI9486L_CASET)  'Column addr set
  SendData_ILI9486L _x1_H
  SendData_ILI9486L _x1
  SendData_ILI9486L _x2_H
  SendData_ILI9486L _x2

  SendCommand_ILI9486L(ILI9486L_PASET)  'Row addr set
  SendData_ILI9486L _y1_H
  SendData_ILI9486L _y1
  SendData_ILI9486L _y2_H
  SendData_ILI9486L _y2

  SendCommand_ILI9486L(ILI9486L_RAMWR)  'write to RAM

End Sub



Sub SetCursorPosition_ILI9486L( In _x1 as word, in _y1 as word, in _x2 as word, in _y2 as word)
  SendCommand_ILI9486L(ILI9486L_CASET)  Column addr set
  SendData_ILI9486L _x1_H
  SendData_ILI9486L _x1
  SendData_ILI9486L _x2_H
  SendData_ILI9486L _x2

  SendCommand_ILI9486L(ILI9486L_PASET)  Row addr set
  SendData_ILI9486L _y1_H
  SendData_ILI9486L _y1
  SendData_ILI9486L _y2_H
  SendData_ILI9486L _y2

End Sub


''@hide
sub   GLCDRotate_ILI9486L ( in GLCDRotateState as byte )
'
'#define ILI9486L_MADCTL_MY  0x80
'#define ILI9486L_MADCTL_MX  0x40
'#define ILI9486L_MADCTL_MV  0x20
'#define ILI9486L_MADCTL_ML  0x10
'#define ILI9486L_MADCTL_RGB 0x00
'#define ILI9486L_MADCTL_BGR 0x08
'#define ILI9486L_MADCTL_MH  0x04



  select case GLCDRotateState
        case PORTRAIT  '0 degree
             ILI9486L_GLCD_WIDTH = GLCD_WIDTH
             ILI9486L_GLCD_HEIGHT = GLCD_HEIGHT
        case LANDSCAPE
             ILI9486L_GLCD_WIDTH = GLCD_HEIGHT
             ILI9486L_GLCD_HEIGHT = GLCD_WIDTH
        case PORTRAIT_REV
             ILI9486L_GLCD_WIDTH = GLCD_WIDTH
             ILI9486L_GLCD_HEIGHT = GLCD_HEIGHT
        case LANDSCAPE_REV
             ILI9486L_GLCD_WIDTH = GLCD_HEIGHT
             ILI9486L_GLCD_HEIGHT = GLCD_WIDTH
        case else
             ILI9486L_GLCD_WIDTH = GLCD_WIDTH
             ILI9486L_GLCD_HEIGHT = GLCD_HEIGHT
  end select

end sub

'''Displays a string in a larger fonti.e.  BigPrint_ILI9486L ( 30, ILI9486L_GLCD_HEIGHT - 20 , "BigPrint_ILI9486L" )
'''@param PrintLocX X coordinate for message
'''@param PrintLocY Y coordinate for message
'''@param PrintData String to display
'''@param Color Optional color
Sub BigPrint_ILI9486L(In PrintLocX as Word, In PrintLocY as Word,  PrintData As String, Optional In  Color as word = GLCDForeground)
  Dim GLCDPrintLoc as word
  PrintLen = PrintData(0)
  If PrintLen = 0 Then Exit Sub
  GLCDPrintLoc = PrintLocX
  For SysPrintTemp = 1 To PrintLen
    DrawBigChar_ILI9486L GLCDPrintLoc, PrintLocY, PrintData(SysPrintTemp), Color
    GLCDPrintLoc += 13
  Next
End Sub

'''Draws a Vertical Line on the GLCD with a
'''@param GLCDY1 Y coordinate of one end of the line
'''@param GLCDY2 Y coordinate of the other end of the line
'''@param GLCDX1 X coordinate of the line
'''@param LineColour color
Sub DrawBigChar_ILI9486L (In CharLocX as Word, In CharLocY as Word, In CharCode, Optional In  Color as word = GLCDForeground )

    dim Locx, Locy, CurrCol as Word


    if CharCode <=126 Then
       CharCode -=32
       Goto GCBBigTables
    end if
    if CharCode <=210 Then
       CharCode -=33
       Goto GCBBigTables
    end if
    if CharCode <= 250 Then
       CharCode -=34
       Goto GCBBigTables
    end if
    GCBBigTables:
    For CurrCharCol = 1 to 24
      CurrCol=CurrCharCol+CharCode*24-(CharCode/10)*240
      if CharCode>=0 and CharCode<=9 then ReadTable BigFont32_41 , CurrCol, CurrCharVal
      if CharCode>=10 and CharCode<=19 then ReadTable BigFont42_51 , CurrCol, CurrCharVal
      if CharCode>=20 and CharCode<=29 then ReadTable BigFont52_61 , CurrCol, CurrCharVal
      if CharCode>=30 and CharCode<=39 then ReadTable BigFont62_71 , CurrCol, CurrCharVal
      if CharCode>=40 and CharCode<=49 then ReadTable BigFont72_81 , CurrCol, CurrCharVal
      if CharCode>=50 and CharCode<=59 then ReadTable BigFont82_91 , CurrCol, CurrCharVal
      if CharCode>=60 and CharCode<=69 then ReadTable BigFont92_101 , CurrCol, CurrCharVal
      if CharCode>=70 and CharCode<=79 then ReadTable BigFont102_111 , CurrCol, CurrCharVal
      if CharCode>=80 and CharCode<=89 then ReadTable BigFont112_121 , CurrCol, CurrCharVal
      if CharCode>=90 and CharCode<=99 then ReadTable BigFont122_126 , CurrCol, CurrCharVal
      if CharCode>=160 and CharCode<=169 then ReadTable BigFont193_202 , CurrCol, CurrCharVal
      if CharCode>=170 and CharCode<=179 then ReadTable BigFont203_212 , CurrCol, CurrCharVal
      if CharCode>=180 and CharCode<=183 then ReadTable BigFont213_216 , CurrCol, CurrCharVal

        if CurrCharVal=36 then CurrCharVal=33
        For CurrCharRow = 1 to 8
          LocX=[word]CharLocX+CurrCharCol
          LocY=[Word]CharLocY+CurrCharRow
          if CurrCharCol>12 then
             LocX= LocX - 12
             LocY= LocY + 8
          end if
          if CurrCharVal.0=1 then
             PSet LocX , LocY , Color
          end if
          Rotate CurrCharVal Right
        Next
    Next
End Sub
