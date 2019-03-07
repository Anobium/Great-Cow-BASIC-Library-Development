'    Graphical LCD routines for the GCBASIC compiler
'    Copyright (C) 2017 Evan Venn and Kent Schafer

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
' Supports HX8347 controller only.

'Changes
  '16/11/2017 Initial release including OLED fonts
  '19/11/2017 Added PrintLocX and PrintLocY initialisation for character mode printing.
  'Correct missing #ENDIF

'Hardware settings
'Type
'''@hardware All; Controller Type; GLCD_TYPE; "GLCD_TYPE_HX8347"
'    #define GLCD_TYPE GLCD_TYPE_HX8347
'
'    'Pin mappings for SPI - this GLCD driver supports Hardware SPI and Software SPI
'    #define GLCD_RD       ANALOG_0          ' read command line
'    #define GLCD_WR       ANALOG_1          ' write command line
'    #define GLCD_RS       ANALOG_2          ' Command/Data line
'    #define GLCD_CS       ANALOG_3          ' Chip select line
'    #define GLCD_RST      ANALOG_4          ' Reset line
'
'
'    Parallel lines (HX8347 only)
'    #define GLCD_DB0       DIGITAL_8
'    #define GLCD_DB1       DIGITAL_9
'    #define GLCD_DB2       DIGITAL_2
'    #define GLCD_DB3       DIGITAL_3
'    #define GLCD_DB4       DIGITAL_4
'    #define GLCD_DB5       DIGITAL_5
'    #define GLCD_DB6       DIGITAL_6

#define HX8347_WHITE   TFT_WHITE
#define HX8347_BLACK   TFT_BLACK
#define HX8347_RED     TFT_RED
#define HX8347_GREEN   TFT_GREEN
#define HX8347_BLUE    TFT_BLUE
#define HX8347_YELLOW  TFT_YELLOW
#define HX8347_CYAN    TFT_CYAN
#define HX8347_MAGENTA TFT_MAGENTA
#define HX8347_NAVY          TFT_NAVY
#define HX8347_DARKGREEN     TFT_DARKGREEN
#define HX8347_DARKCYAN      TFT_DARKCYAN
#define HX8347_MAROON        TFT_MAROON
#define HX8347_PURPLE        TFT_PURPLE
#define HX8347_OLIVE         TFT_OLIVE
#define HX8347_LIGHTGREY     TFT_LIGHTGREY
#define HX8347_DARKGREY      TFT_DARKGREY
#define HX8347_ORANGE        TFT_ORANGE
#define HX8347_GREENYELLOW   TFT_GREENYELLOW
#define HX8347_PINK          TFT_PINK

#script
      HX8347_GLCD_RST = GLCD_RST
      HX8347_GLCD_CS  = GLCD_CS
      HX8347_GLCD_RS  = GLCD_RS
      HX8347_GLCD_WR  = GLCD_WR
      HX8347_GLCD_RD  = GLCD_RD


      HX8347_GLCD_DB0 = GLCD_DB0
      HX8347_GLCD_DB1 = GLCD_DB1
      HX8347_GLCD_DB2 = GLCD_DB2
      HX8347_GLCD_DB3 = GLCD_DB3
      HX8347_GLCD_DB4 = GLCD_DB4
      HX8347_GLCD_DB5 = GLCD_DB5
      HX8347_GLCD_DB6 = GLCD_DB6
      HX8347_GLCD_DB7 = GLCD_DB7
#endscript

#startup InitGLCD_HX8347

dim GLCDDeviceWidth, GLCDDeviceHeight as word

Sub InitGLCD_HX8347

  'Setup code for HX8347 controllers
  #if GLCD_TYPE = GLCD_TYPE_HX8347

      dir  HX8347_GLCD_DB7 OUT
      dir  HX8347_GLCD_DB6 OUT
      dir  HX8347_GLCD_DB5 OUT
      dir  HX8347_GLCD_DB4 OUT
      dir  HX8347_GLCD_DB3 OUT
      dir  HX8347_GLCD_DB2 OUT
      dir  HX8347_GLCD_DB1 OUT
      dir  HX8347_GLCD_DB0 OUT

      'Set pin directions
      Dir HX8347_GLCD_RD  Out
      Dir HX8347_GLCD_WR  Out
      Dir HX8347_GLCD_RS  Out
      Dir HX8347_GLCD_CS  Out
      Dir HX8347_GLCD_RST Out

      Set HX8347_GLCD_RD On
      Set HX8347_GLCD_WR On
      Set HX8347_GLCD_RS On
      set HX8347_GLCD_CS ON
      Set HX8347_GLCD_RST On

      'Reset
      Set HX8347_GLCD_RST Off
      Wait 15 ms
      Set HX8347_GLCD_RST On
      Wait 15 ms

      SendData_HX8347(0x00)
      SendData_HX8347(0x00)
      SendData_HX8347(0x00)
      SendData_HX8347(0x00)

      set HX8347_GLCD_CS ON
      set HX8347_GLCD_WR ON
      set HX8347_GLCD_CS OFF

      SendCommand_HX8347(0x2e)
      SendData_HX8347(0x89)
      SendCommand_HX8347(0x29)
      SendData_HX8347(0x8f)
      SendCommand_HX8347(0x2b)
      SendData_HX8347(0x02)
      SendCommand_HX8347(0xe2)
      SendData_HX8347(0x00)
      SendCommand_HX8347(0xE4)
      SendData_HX8347(0x01)
      SendCommand_HX8347(0xE6)
      SendData_HX8347(0x01)
      SendCommand_HX8347(0xE7)
      SendData_HX8347(0x10)
      SendCommand_HX8347(0xE8)
      SendData_HX8347(0x70)
      SendCommand_HX8347(0xf2)
      SendData_HX8347(0x00)
      SendCommand_HX8347(0xEA)
      SendData_HX8347(0x20)
      SendCommand_HX8347(0xEb)
      SendData_HX8347(0x20)
      SendCommand_HX8347(0xEc)
      SendData_HX8347(0x3c)
      SendCommand_HX8347(0xEd)
      SendData_HX8347(0xc8)
      SendCommand_HX8347(0xE9)
      SendData_HX8347(0x38)
      SendCommand_HX8347(0x1f)
      SendData_HX8347(0x01)

      'Power
      SendCommand_HX8347(0x1b)
      SendData_HX8347(0x1a)
      SendCommand_HX8347(0x1a)
      SendData_HX8347(0x02)
      SendCommand_HX8347(0x24)
      SendData_HX8347(0x61)
      SendCommand_HX8347(0x25)
      SendData_HX8347(0x5c)

     'power on
      SendCommand_HX8347(0x18)
      SendData_HX8347(0x36)
      SendCommand_HX8347(0x19)
      SendData_HX8347(0x01)
      SendCommand_HX8347(0x1f)
      SendData_HX8347(0x88)
      wait 5 ms
      SendCommand_HX8347(0x1f)
      SendData_HX8347(0x80)
      wait 5 ms
      SendCommand_HX8347(0x1f)
      SendData_HX8347(0x90)
      wait 5 ms
      SendCommand_HX8347(0x1f)
      SendData_HX8347(0xD4)
      wait 5 ms

      'color Setting
      SendCommand_HX8347(0x17)
      SendData_HX8347(0x05)

      SendCommand_HX8347(0x36)
      SendData_HX8347(0x09)

      'Display ON Setting
      SendCommand_HX8347(0x28)
      SendData_HX8347(0x38)
      wait 40 ms
      SendCommand_HX8347(0x28)
      SendData_HX8347(0x3c)

      SendCommand_HX8347(0x02)
      SendData_HX8347(0x00)
      SendCommand_HX8347(0x03)
      SendData_HX8347(0x00)
      SendCommand_HX8347(0x04)
      SendData_HX8347(0x00)
      SendCommand_HX8347(0x05)
      SendData_HX8347(0xef)
      SendCommand_HX8347(0x06)
      SendData_HX8347(0x00)
      SendCommand_HX8347(0x07)
      SendData_HX8347(0x00)
      SendCommand_HX8347(0x08)
      SendData_HX8347(0x01)
      SendCommand_HX8347(0x09)
      SendData_HX8347(0x3f)

      set HX8347_GLCD_CS ON

      wait 120 ms
      'Colours
      GLCDBackground = HX8347_BLACK
      GLCDForeground = HX8347_WHITE

      #ifndef GLCD_OLED_FONT
        GLCDFontWidth = 6
      #endif
      #ifdef GLCD_OLED_FONT
        GLCDFontWidth = 5
      #endif

      GLCDfntDefault = 0
      GLCDfntDefaultsize = 1
      GLCDDeviceHeight = GLCD_HEIGHT - 1
      GLCDDeviceWidth  = GLCD_WIDTH - 1

  #endif

  'Clear screen
  GLCDCLS_HX8347

End Sub



'Subs
'''Clears the GLCD screen
Sub GLCDCLS_HX8347 ( Optional In  GLCDBackground as word = GLCDBackground )

  ' initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
  Dim HX8347SendWord, PrintLocX, PrintLocY as word
  GLCD_yordinate = 0
  PrintLocX = 0
  PrintLocY = 0



    #ifndef GLCD_HX8347_16bit
      set HX8347_GLCD_CS OFF

      SetAddressWindow_HX8347 ( 0,0, GLCDDeviceWidth, GLCDDeviceHeight  )
      HX8347SendWord = GLCDBackground

      GLCDSetWriteDir_HX8347
      HX8347_GLCD_CS = 0
      HX8347_GLCD_RS = 1
      HX8347_GLCD_RD = 1

      Repeat 2
        Repeat 38400

          HX8347_GLCD_WR = 1
          PORTD = (PORTD & 0B00000011) | ((HX8347SendWord_h) & 0B11111100)
          PORTB = (PORTB & 0B11111100) | ((HX8347SendWord_h) & 0B00000011)
          HX8347_GLCD_WR = 0

          HX8347_GLCD_WR = 1
          PORTD = (PORTD & 0B00000011) | ((HX8347SendWord) & 0B11111100)
          PORTB = (PORTB & 0B11111100) | ((HX8347SendWord) & 0B00000011)
          HX8347_GLCD_WR = 0

        End Repeat
      End Repeat

      HX8347_GLCD_WR = 1
      HX8347_GLCD_CS = 1


  #endif

End Sub

'''Draws a filled box on the GLCD screen
'''@param LineX1 Top left corner X location
'''@param LineY1 Top left corner Y location
'''@param LineX2 Bottom right corner X location
'''@param LineY2 Bottom right corner Y location
'''@param LineColour Colour of box (0 = erase, 1 = draw, default is 1)
Sub FilledBox_HX8347(In LineX1 as Word, In LineY1 as Word, In LineX2 as Word, In LineY2 as Word, Optional In LineColour As Word = GLCDForeground)
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

  #If GLCD_TYPE = GLCD_TYPE_HX8347
    'Draw lines going across
    For DrawLine = LineX1 To LineX2
      For GLCDTemp = LineY1 To LineY2
        PSet DrawLine, GLCDTemp, LineColour
      Next
    Next
  #endif

End Sub

'''Draws a pixel on the GLCD
'''@param GLCDX X coordinate of pixel
'''@param GLCDY Y coordinate of pixel
'''@param GLCDColour State of pixel (0 = erase, 1 = display)
Sub PSet_HX8347(In GLCDX as word , In GLCDY as word, In GLCDColour As Word)

  ' if GLCDY => GLCDDeviceHeight or GLCDX => GLCDDeviceWidth then exit sub
  set HX8347_GLCD_CS OFF
  SetAddressWindow_HX8347 ( GLCDX, GLCDY, GLCDX, GLCDY )

  #If GLCD_TYPE = GLCD_TYPE_HX8347

    #ifndef GLCD_HX8347_16bit
      SendData_HX8347 GLCDColour_H
      SendData_HX8347 GLCDColour
    #endif

    #ifdef GLCD_HX8347_16bit
      sendWord_HX8347 GLCDColour
    #endif

  #endif
  set HX8347_GLCD_CS ON


End Sub

'
'          '''Send a command to the HX8347 GLCD
'          '''@param HX8347SendByte Command to send
'          '''@hide
sub  SendCommand_HX8347( IN HX8347SendByte as word )


  #if GLCD_TYPE = GLCD_TYPE_HX8347

      #ifndef GLCD_HX8347_16bit
      GLCDSetWriteDir_HX8347
      HX8347_GLCD_CS = 0
      HX8347_GLCD_RS = 0
      HX8347_GLCD_RD = 1

      #ifndef  8bitMode
        HX8347_GLCD_WR = 1
        PORTD = (PORTD & 0B00000011) | ((HX8347SendByte_h) & 0B11111100);
        PORTB = (PORTB & 0B11111100) | ((HX8347SendByte_h) & 0B00000011);
        HX8347_GLCD_WR = 0
      #endif

      HX8347_GLCD_WR = 1
      PORTD = (PORTD & 0B00000011) | ((HX8347SendByte) & 0B11111100);
      PORTB = (PORTB & 0B11111100) | ((HX8347SendByte) & 0B00000011);
      HX8347_GLCD_WR  = 0
      HX8347_GLCD_WR = 1
      HX8347_GLCD_CS = 1

    #endif

  #endif

end Sub

'''Send a data byte to the HX8347 GLCD
'''@param HX8347SendByte Byte to send
'''@hide
sub  SendData_HX8347( IN HX8347SendByte as word )

  #if GLCD_TYPE = GLCD_TYPE_HX8347

    GLCDSetWriteDir_HX8347
    HX8347_GLCD_CS = 0
    HX8347_GLCD_RS = 1
    HX8347_GLCD_RD = 1

    #ifndef  8bitMode
      HX8347_GLCD_WR = 1
      PORTD = (PORTD & 0B00000011) | ((HX8347SendByte_h) & 0B11111100);
      PORTB = (PORTB & 0B11111100) | ((HX8347SendByte_h) & 0B00000011);
      HX8347_GLCD_WR = 0
    #endif

    HX8347_GLCD_WR = 1
    PORTD = (PORTD & 0B00000011) | ((HX8347SendByte) & 0B11111100);
    PORTB = (PORTB & 0B11111100) | ((HX8347SendByte) & 0B00000011);
    HX8347_GLCD_WR = 0
    HX8347_GLCD_WR = 1
    HX8347_GLCD_CS = 1

  #endif

end Sub





'''Set the row or column address range for the HX8347 GLCD
'''@param HX8347AddressType Address Type (HX8347_ROW or HX8347_COLUMN)
'''@param HX8347Start Starting address
'''@param HX8347End Ending address
'''@hide
Sub SetAddressWindow_HX8347( In _x1 as word, in _y1 as word, in _x2 as word, in _y2 as word )

  SendCommand_HX8347(0x02)
  SendData_HX8347 _x1_H
  SendCommand_HX8347(0x03)
  SendData_HX8347 _x1
  SendCommand_HX8347(0x04)
  SendData_HX8347 _x2_H
  SendCommand_HX8347(0x05)
  SendData_HX8347 _x2

  SendCommand_HX8347(0x06)
  SendData_HX8347 _y1_H
  SendCommand_HX8347(0x07)
  SendData_HX8347 _y1
  SendCommand_HX8347(0x08)
  SendData_HX8347 _y2_H
  SendCommand_HX8347(0x09)
  SendData_HX8347 _y2

  SendCommand_HX8347(0x22)  'write to RAM

End Sub

Function PixelStatus_HX8347(In GLCDX, In GLCDY ) as word

    #if GLCD_TYPE = GLCD_TYPE_HX8347

        set HX8347_GLCD_CS OFF
        'Select correct buffer element
        SetAddressWindow_HX8347 ( GLCDX, GLCDY, GLCDX, GLCDY )

        set HX8347_GLCD_CS On
        'Need to read three bytes
        'first byte is a dummy
        'then, two color bytes to make the woord


        set HX8347_GLCD_RS On
        set HX8347_GLCD_RD ON
        set HX8347_GLCD_WR ON
        set HX8347_GLCD_CS OFF

        SendCommand_HX8347 ( 0x2e )

        dir  HX8347_GLCD_DB7 IN
        dir  HX8347_GLCD_DB6 IN
        dir  HX8347_GLCD_DB5 IN
        dir  HX8347_GLCD_DB4 IN
        dir  HX8347_GLCD_DB3 IN
        dir  HX8347_GLCD_DB2 IN
        dir  HX8347_GLCD_DB1 IN
        dir  HX8347_GLCD_DB0 IN

        set HX8347_GLCD_RD OFF
        set HX8347_GLCD_RD OFF
        'dummy read
        PixelStatus_HX8347_h = PINb & 0B00000011
        PixelStatus_HX8347_h = (PINd & 0B11111100) + PixelStatus_HX8347_h
        set HX8347_GLCD_RD ON

        'the real reads
        set HX8347_GLCD_RD OFF
        set HX8347_GLCD_RD OFF
        PixelStatus_HX8347_h = PINb & 0B00000011
        PixelStatus_HX8347_h = (PINd & 0B11111100) + PixelStatus_HX8347_h
        set HX8347_GLCD_RD ON

        set HX8347_GLCD_RD OFF
        set HX8347_GLCD_RD OFF
        [byte]PixelStatus_HX8347 = PINb & 0B00000011
        [byte]PixelStatus_HX8347 = (PINd & 0B11111100) + [byte]PixelStatus_HX8347
        set HX8347_GLCD_RD ON

        set HX8347_GLCD_CS ON

        set HX8347_GLCD_WR ON
        dir  HX8347_GLCD_DB7 OUT
        dir  HX8347_GLCD_DB6 OUT
        dir  HX8347_GLCD_DB5 OUT
        dir  HX8347_GLCD_DB4 OUT
        dir  HX8347_GLCD_DB3 OUT
        dir  HX8347_GLCD_DB2 OUT
        dir  HX8347_GLCD_DB1 OUT
        dir  HX8347_GLCD_DB0 OUT

      #endif

end function






'''Draws a string at the specified location on the ST7920 GLCD
'''@param StringLocX X coordinate for message
'''@param CharLocY Y coordinate for message
'''@param Chars String to display
'''@param LineColour Line Color, either 1 or 0
Sub GLCDDrawString_HX8347( In StringLocX as word, In CharLocY as word, In Chars as string, Optional In LineColour as word = GLCDForeground )

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
'''Draws a character at the specified location on the ST7920 GLCD
'''@param StringLocX X coordinate for message
'''@param CharLocY Y coordinate for message
'''@param Chars String to display
'''@param LineColour Line Color, either 1 or 0
Sub GLCDDrawChar_HX8347(In CharLocX as word, In CharLocY as word, In CharCode, Optional In LineColour as word = GLCDForeground )

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


'''Displays a string in a larger fonti.e.  BigPrint_HX8347 ( 30, HX8347_GLCD_HEIGHT - 20 , "BigPrint_HX8347" )
'''@param PrintLocX X coordinate for message
'''@param PrintLocY Y coordinate for message
'''@param PrintData String to display
'''@param Color Optional color
Sub BigPrint_HX8347(In PrintLocX as Word, In PrintLocY as Word,  PrintData As String, Optional In  Color as word = GLCDForeground)
  Dim GLCDPrintLoc as word
  PrintLen = PrintData(0)
  If PrintLen = 0 Then Exit Sub
  GLCDPrintLoc = PrintLocX
  For SysPrintTemp = 1 To PrintLen
    DrawBigChar_HX8347 GLCDPrintLoc, PrintLocY, PrintData(SysPrintTemp), Color
    GLCDPrintLoc += 13
  Next
End Sub

'''Draws a Vertical Line on the GLCD with a
'''@param GLCDY1 Y coordinate of one end of the line
'''@param GLCDY2 Y coordinate of the other end of the line
'''@param GLCDX1 X coordinate of the line
'''@param LineColour color
Sub DrawBigChar_HX8347 (In CharLocX as Word, In CharLocY as Word, In CharCode, Optional In  Color as word = GLCDForeground )

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
             PSet_HX8347 LocX , LocY , Color
          end if
          Rotate CurrCharVal Right
        Next
    Next
End Sub

Sub GLCDRotate_HX8347( in HX8347AddressType as byte )

  set HX8347_GLCD_CS OFF
  select case HX8347AddressType
        case PORTRAIT  '0 degree

              SendCommand_HX8347(0x16)
              SendData_HX8347(0x00)
              GLCDDeviceHeight = GLCD_HEIGHT - 1
              GLCDDeviceWidth  = GLCD_WIDTH - 1

        case LANDSCAPE

              SendCommand_HX8347(0x16)
              SendData_HX8347(0x60)
              GLCDDeviceHeight = GLCD_WIDTH - 1
              GLCDDeviceWidth  = GLCD_HEIGHT - 1


        case PORTRAIT_REV

              SendCommand_HX8347(0x16)
              SendData_HX8347(0xC0)
              GLCDDeviceHeight = GLCD_HEIGHT - 1
              GLCDDeviceWidth  = GLCD_WIDTH - 1


        case LANDSCAPE_REV

              SendCommand_HX8347(0x16)
              SendData_HX8347(0xA0)
              GLCDDeviceHeight = GLCD_WIDTH - 1
              GLCDDeviceWidth  = GLCD_HEIGHT - 1

        case else
              SendCommand_HX8347(0x16)
              SendData_HX8347(0x0E)
              GLCDDeviceHeight = GLCD_HEIGHT - 1
              GLCDDeviceWidth  = GLCD_WIDTH - 1

  end select
  set HX8347_GLCD_CS On

end sub


Sub GLCDSetWriteDir_HX8347

      dir  HX8347_GLCD_DB7 OUT
      dir  HX8347_GLCD_DB6 OUT
      dir  HX8347_GLCD_DB5 OUT
      dir  HX8347_GLCD_DB4 OUT
      dir  HX8347_GLCD_DB3 OUT
      dir  HX8347_GLCD_DB2 OUT
      dir  HX8347_GLCD_DB1 OUT
      dir  HX8347_GLCD_DB0 OUT

End Sub


Sub GLCDSetReadDir_HX8347

      dir  HX8347_GLCD_DB7 IN
      dir  HX8347_GLCD_DB6 IN
      dir  HX8347_GLCD_DB5 IN
      dir  HX8347_GLCD_DB4 IN
      dir  HX8347_GLCD_DB3 IN
      dir  HX8347_GLCD_DB2 IN
      dir  HX8347_GLCD_DB1 IN
      dir  HX8347_GLCD_DB0 IN

End Sub
