'    Graphical LCD routines for the GCBASIC compiler
'    Copyright (C) 2019 Evan Venn

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
' Supports uc8230 controller only.

'Changes
  '7/6/2018 Initial release including OLED fonts


'Hardware settings
'Type
'''@hardware All; Controller Type; GLCD_TYPE; "GLCD_TYPE_uc8230"
'    #define GLCD_TYPE GLCD_TYPE_uc8230
'
'    'Pin mappings for SPI - this GLCD driver supports Hardware SPI and Software SPI
'    #define GLCD_RD       ANALOG_0          ' read command line
'    #define GLCD_WR       ANALOG_1          ' write command line
'    #define GLCD_RS       ANALOG_2          ' Command/Data line
'    #define GLCD_CS       ANALOG_3          ' Chip select line
'    #define GLCD_RST      ANALOG_4          ' Reset line
'
'
'    Parallel lines (uc8230 only)
'    #define GLCD_DB0       DIGITAL_8
'    #define GLCD_DB1       DIGITAL_9
'    #define GLCD_DB2       DIGITAL_2
'    #define GLCD_DB3       DIGITAL_3
'    #define GLCD_DB4       DIGITAL_4
'    #define GLCD_DB5       DIGITAL_5
'    #define GLCD_DB6       DIGITAL_6

#define uc8230_WHITE   TFT_WHITE
#define uc8230_BLACK   TFT_BLACK
#define uc8230_RED     TFT_RED
#define uc8230_GREEN   TFT_GREEN
#define uc8230_BLUE    TFT_BLUE
#define uc8230_YELLOW  TFT_YELLOW
#define uc8230_CYAN    TFT_CYAN
#define uc8230_MAGENTA TFT_MAGENTA
#define uc8230_NAVY          TFT_NAVY
#define uc8230_DARKGREEN     TFT_DARKGREEN
#define uc8230_DARKCYAN      TFT_DARKCYAN
#define uc8230_MAROON        TFT_MAROON
#define uc8230_PURPLE        TFT_PURPLE
#define uc8230_OLIVE         TFT_OLIVE
#define uc8230_LIGHTGREY     TFT_LIGHTGREY
#define uc8230_DARKGREY      TFT_DARKGREY
#define uc8230_ORANGE        TFT_ORANGE
#define uc8230_GREENYELLOW   TFT_GREENYELLOW
#define uc8230_PINK          TFT_PINK

#script
      uc8230_GLCD_RST = GLCD_RST
      uc8230_GLCD_CS  = GLCD_CS
      uc8230_GLCD_RS  = GLCD_RS
      uc8230_GLCD_WR  = GLCD_WR
      uc8230_GLCD_RD  = GLCD_RD


      uc8230_GLCD_DB0 = GLCD_DB0
      uc8230_GLCD_DB1 = GLCD_DB1
      uc8230_GLCD_DB2 = GLCD_DB2
      uc8230_GLCD_DB3 = GLCD_DB3
      uc8230_GLCD_DB4 = GLCD_DB4
      uc8230_GLCD_DB5 = GLCD_DB5
      uc8230_GLCD_DB6 = GLCD_DB6
      uc8230_GLCD_DB7 = GLCD_DB7
#endscript

#startup InitGLCD_uc8230

dim GLCDDeviceWidth, GLCDDeviceHeight as word

Sub InitGLCD_uc8230

  'Setup code for uc8230 controllers
  #if GLCD_TYPE = GLCD_TYPE_uc8230

      dir  uc8230_GLCD_DB7 OUT
      dir  uc8230_GLCD_DB6 OUT
      dir  uc8230_GLCD_DB5 OUT
      dir  uc8230_GLCD_DB4 OUT
      dir  uc8230_GLCD_DB3 OUT
      dir  uc8230_GLCD_DB2 OUT
      dir  uc8230_GLCD_DB1 OUT
      dir  uc8230_GLCD_DB0 OUT

      'Set pin directions
      Dir uc8230_GLCD_RD  Out
      Dir uc8230_GLCD_WR  Out
      Dir uc8230_GLCD_RS  Out
      Dir uc8230_GLCD_CS  Out
      Dir uc8230_GLCD_RST Out

      Set uc8230_GLCD_RD On
      Set uc8230_GLCD_WR On
      Set uc8230_GLCD_RS On
      set uc8230_GLCD_CS ON
      Set uc8230_GLCD_RST On

      'Reset
      Set uc8230_GLCD_RST Off
      Wait 100 ms
      Set uc8230_GLCD_RST On
      Wait 100 ms

'      SendData_uc8230(0x00)
'      SendData_uc8230(0x00)
'      SendData_uc8230(0x00)
'      SendData_uc8230(0x00)

      set uc8230_GLCD_CS ON
      set uc8230_GLCD_CS OFF
      set uc8230_GLCD_WR ON

'        SendCommandData_uc8230( 0x00E5, 0x8000)  ' Set the Vcore voltage and this setting is must.
        SendCommandData_uc8230( 0x0000, 0x0001)
        wait 200 ms
        SendCommandData_uc8230( 0x0001, 0x0000)

        SendCommandData_uc8230( 0x0010, 0x1590)    'power items
        SendCommandData_uc8230( 0x0011, 0x0227)
        SendCommandData_uc8230( 0x0012, 0x80ff)
        SendCommandData_uc8230( 0x0013, 0x9c31)
        wait 10 ms
        SendCommandData_uc8230( 0x0002, 0x0300)    ' ? set N-line = 1

        SendCommandData_uc8230( 0x0060, 0xa700)    ' ? //GS; gate scan: start position & drive line Q'ty
        SendCommandData_uc8230( 0x0061, 0x0001)    ' ? //REV, NDL, VLE
        '--------------------Gamma control------------------------*
        SendCommandData_uc8230( 0x0030, 0x0303)    ' ERV OK THIS IS GAMMA
        SendCommandData_uc8230( 0x0031, 0x0303)
        SendCommandData_uc8230( 0x0032, 0x0303)
        SendCommandData_uc8230( 0x0033, 0x0300)
        SendCommandData_uc8230( 0x0034, 0x0003)
        SendCommandData_uc8230( 0x0035, 0x0303)
        SendCommandData_uc8230( 0x0036, 0x1400)
        SendCommandData_uc8230( 0x0037, 0x0303)
        SendCommandData_uc8230( 0x0038, 0x0303)
        SendCommandData_uc8230( 0x0039, 0x0303)
        SendCommandData_uc8230( 0x003a, 0x0300)
        SendCommandData_uc8230( 0x003b, 0x0003)
        SendCommandData_uc8230( 0x003c, 0x0303)
        SendCommandData_uc8230( 0x003d, 0x1400)
        '-----------------------------------------------------------
        SendCommandData_uc8230( 0x0020, 0x0000) 'GRAM horizontal address  ERV WHY SET?
        SendCommandData_uc8230( 0x0021, 0x0000) 'GRAM vertical address
        ' ************** Partial Display control*********************
        SendCommandData_uc8230( 0x0080, 0x0000)
        SendCommandData_uc8230( 0x0081, 0x0000)
        SendCommandData_uc8230( 0x0082, 0x0000)
        SendCommandData_uc8230( 0x0083, 0x0000)
        SendCommandData_uc8230( 0x0084, 0x0000)
        SendCommandData_uc8230( 0x0085, 0x0000)

        SendCommandData_uc8230( 0x0092, 0x0200)
        SendCommandData_uc8230( 0x0093, 0x0303)
        SendCommandData_uc8230( 0x0090, 0x0010)   'set clocks/Line
        SendCommandData_uc8230( 0x0000, 0x0001)
        wait 200 ms
        SendCommandData_uc8230( 0x0003, 0x1030)    ' ERV GOOD set GRAM writing direction & BGR=1
        SendCommandData_uc8230( 0x0007, 0x0173 ) ' Display on setting


      set uc8230_GLCD_CS ON

      wait 120 ms
      'Colours
      GLCDBackground = uc8230_BLACK
      GLCDForeground = uc8230_WHITE

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
  GLCDCLS_uc8230

End Sub



'Subs
'''Clears the GLCD screen
Sub GLCDCLS_uc8230 ( Optional In  GLCDBackground as word = GLCDBackground )

  ' initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
  Dim uc8230SendWord, PrintLocX, PrintLocY as word
  GLCD_yordinate = 0
  PrintLocX = 0
  PrintLocY = 0



    #ifndef GLCD_uc8230_16bit
      set uc8230_GLCD_CS OFF

      SetAddressWindow_uc8230 ( 0,0, GLCDDeviceWidth, GLCDDeviceHeight  )
      uc8230SendWord = GLCDBackground

      GLCDSetWriteDir_uc8230
      uc8230_GLCD_CS = 0
      uc8230_GLCD_RS = 1
      uc8230_GLCD_RD = 1

      Repeat 2
        Repeat 38400

          uc8230_GLCD_WR = 1
          PORTD = (PORTD & 0B00000011) | ((uc8230SendWord_h) & 0B11111100)
          PORTB = (PORTB & 0B11111100) | ((uc8230SendWord_h) & 0B00000011)
          uc8230_GLCD_WR = 0

          uc8230_GLCD_WR = 1
          PORTD = (PORTD & 0B00000011) | ((uc8230SendWord) & 0B11111100)
          PORTB = (PORTB & 0B11111100) | ((uc8230SendWord) & 0B00000011)
          uc8230_GLCD_WR = 0

        End Repeat
      End Repeat

      uc8230_GLCD_WR = 1
      uc8230_GLCD_CS = 1


  #endif

End Sub

'''Draws a filled box on the GLCD screen
'''@param LineX1 Top left corner X location
'''@param LineY1 Top left corner Y location
'''@param LineX2 Bottom right corner X location
'''@param LineY2 Bottom right corner Y location
'''@param LineColour Colour of box (0 = erase, 1 = draw, default is 1)
Sub FilledBox_uc8230(In LineX1 as Word, In LineY1 as Word, In LineX2 as Word, In LineY2 as Word, Optional In LineColour As Word = GLCDForeground)
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

  #If GLCD_TYPE = GLCD_TYPE_uc8230
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
Sub PSet_uc8230(In GLCDX as word , In GLCDY as word, In GLCDColour As Word)

  ' if GLCDY => GLCDDeviceHeight or GLCDX => GLCDDeviceWidth then exit sub
  set uc8230_GLCD_CS OFF
  SetAddressWindow_uc8230 ( GLCDX, GLCDY, GLCDX, GLCDY )

  #If GLCD_TYPE = GLCD_TYPE_uc8230

    #ifndef GLCD_uc8230_16bit
      SendData_uc8230 GLCDColour_H
      SendData_uc8230 GLCDColour
    #endif

    #ifdef GLCD_uc8230_16bit
      sendWord_uc8230 GLCDColour
    #endif

  #endif
  set uc8230_GLCD_CS ON


End Sub

sub  SendCommandData_uc8230( IN uc8230CmdByte as byte, IN uc8230DataWord as word )

  SendCommand_uc8230 (uc8230CmdByte   )
  SendData_uc8230 ( uc8230DataWord  )

End sub

'
'          '''Send a command to the uc8230 GLCD
'          '''@param uc8230SendWord Command to send
'          '''@hide
sub  SendCommand_uc8230( IN uc8230SendWord as word )


  #if GLCD_TYPE = GLCD_TYPE_uc8230

      #ifndef GLCD_uc8230_16bit
      GLCDSetWriteDir_uc8230
      uc8230_GLCD_CS = 0
      uc8230_GLCD_RS = 0
      uc8230_GLCD_RD = 1

      #ifndef  8bitMode
        uc8230_GLCD_WR = 1
        PORTD = (PORTD & 0B00000011) | ((uc8230SendWord_h) & 0B11111100)
        PORTB = (PORTB & 0B11111100) | ((uc8230SendWord_h) & 0B00000011)
        uc8230_GLCD_WR = 0
      #endif

      uc8230_GLCD_WR = 1
      PORTD = (PORTD & 0B00000011) | ((uc8230SendWord) & 0B11111100)
      PORTB = (PORTB & 0B11111100) | ((uc8230SendWord) & 0B00000011)
      uc8230_GLCD_WR  = 0
      uc8230_GLCD_WR = 1
      uc8230_GLCD_CS = 1

    #endif

  #endif

end Sub

'''Send a data byte to the uc8230 GLCD
'''@param uc8230SendWord Byte to send
'''@hide
sub  SendData_uc8230( IN uc8230SendWord as word )

  #if GLCD_TYPE = GLCD_TYPE_uc8230

    GLCDSetWriteDir_uc8230
    uc8230_GLCD_CS = 0
    uc8230_GLCD_RS = 1
    uc8230_GLCD_RD = 1

    #ifndef  8bitMode
      uc8230_GLCD_WR = 1
      PORTD = (PORTD & 0B00000011) | ((uc8230SendWord_h) & 0B11111100)
      PORTB = (PORTB & 0B11111100) | ((uc8230SendWord_h) & 0B00000011)
      uc8230_GLCD_WR = 0
    #endif

    uc8230_GLCD_WR = 1
    PORTD = (PORTD & 0B00000011) | ((uc8230SendWord) & 0B11111100)
    PORTB = (PORTB & 0B11111100) | ((uc8230SendWord) & 0B00000011)
    uc8230_GLCD_WR = 0
    uc8230_GLCD_WR = 1
    uc8230_GLCD_CS = 1

  #endif

end Sub





'''Set the row or column address range for the uc8230 GLCD
'''@param uc8230AddressType Address Type (uc8230_ROW or uc8230_COLUMN)
'''@param uc8230Start Starting address
'''@param uc8230End Ending address
'''@hide
Sub SetAddressWindow_uc8230( In _x1 as word, in _y1 as word, in _x2 as word, in _y2 as word )

  SendCommand_uc8230(0x50)
  SendData_uc8230 _x1
  SendCommand_uc8230(0x51)
  SendData_uc8230 _y1
  SendCommand_uc8230(0x52)
  SendData_uc8230 _x2
  SendCommand_uc8230(0x53)
  SendData_uc8230 _y2
  SendCommand_uc8230(0x20)
  SendData_uc8230 _x1
  SendCommand_uc8230(0x21)
  SendData_uc8230 _y1
  SendCommand_uc8230(0x22)  'write to RAM

End Sub


'Not implemented
Function PixelStatus_uc8230(In GLCDX, In GLCDY ) as word

    #if GLCD_TYPE = GLCD_TYPE_uc8230



      #endif

end function






'''Draws a string at the specified location on the ST7920 GLCD
'''@param StringLocX X coordinate for message
'''@param CharLocY Y coordinate for message
'''@param Chars String to display
'''@param LineColour Line Color, either 1 or 0
Sub GLCDDrawString_uc8230( In StringLocX as word, In CharLocY as word, In Chars as string, Optional In LineColour as word = GLCDForeground )

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
Sub GLCDDrawChar_uc8230(In CharLocX as word, In CharLocY as word, In CharCode, Optional In LineColour as word = GLCDForeground )

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


'''Displays a string in a larger fonti.e.  BigPrint_uc8230 ( 30, uc8230_GLCD_HEIGHT - 20 , "BigPrint_uc8230" )
'''@param PrintLocX X coordinate for message
'''@param PrintLocY Y coordinate for message
'''@param PrintData String to display
'''@param Color Optional color
Sub BigPrint_uc8230(In PrintLocX as Word, In PrintLocY as Word,  PrintData As String, Optional In  Color as word = GLCDForeground)
  Dim GLCDPrintLoc as word
  PrintLen = PrintData(0)
  If PrintLen = 0 Then Exit Sub
  GLCDPrintLoc = PrintLocX
  For SysPrintTemp = 1 To PrintLen
    DrawBigChar_uc8230 GLCDPrintLoc, PrintLocY, PrintData(SysPrintTemp), Color
    GLCDPrintLoc += 13
  Next
End Sub

'''Draws a Vertical Line on the GLCD with a
'''@param GLCDY1 Y coordinate of one end of the line
'''@param GLCDY2 Y coordinate of the other end of the line
'''@param GLCDX1 X coordinate of the line
'''@param LineColour color
Sub DrawBigChar_uc8230 (In CharLocX as Word, In CharLocY as Word, In CharCode, Optional In  Color as word = GLCDForeground )

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
             PSet_uc8230 LocX , LocY , Color
          end if
          Rotate CurrCharVal Right
        Next
    Next
End Sub

Sub GLCDRotate_uc8230( in uc8230AddressType as byte )

  set uc8230_GLCD_CS OFF
  select case uc8230AddressType
        case PORTRAIT  '0 degree

              SendCommand_uc8230(0x16)
              SendData_uc8230(0x00)
              GLCDDeviceHeight = GLCD_HEIGHT - 1
              GLCDDeviceWidth  = GLCD_WIDTH - 1

        case LANDSCAPE

              SendCommand_uc8230(0x16)
              SendData_uc8230(0x60)
              GLCDDeviceHeight = GLCD_WIDTH - 1
              GLCDDeviceWidth  = GLCD_HEIGHT - 1


        case PORTRAIT_REV

              SendCommand_uc8230(0x16)
              SendData_uc8230(0xC0)
              GLCDDeviceHeight = GLCD_HEIGHT - 1
              GLCDDeviceWidth  = GLCD_WIDTH - 1


        case LANDSCAPE_REV

              SendCommand_uc8230(0x16)
              SendData_uc8230(0xA0)
              GLCDDeviceHeight = GLCD_WIDTH - 1
              GLCDDeviceWidth  = GLCD_HEIGHT - 1

        case else
              SendCommand_uc8230(0x16)
              SendData_uc8230(0x0E)
              GLCDDeviceHeight = GLCD_HEIGHT - 1
              GLCDDeviceWidth  = GLCD_WIDTH - 1

  end select
  set uc8230_GLCD_CS On

end sub


Sub GLCDSetWriteDir_uc8230

      dir  uc8230_GLCD_DB7 OUT
      dir  uc8230_GLCD_DB6 OUT
      dir  uc8230_GLCD_DB5 OUT
      dir  uc8230_GLCD_DB4 OUT
      dir  uc8230_GLCD_DB3 OUT
      dir  uc8230_GLCD_DB2 OUT
      dir  uc8230_GLCD_DB1 OUT
      dir  uc8230_GLCD_DB0 OUT

End Sub


Sub GLCDSetReadDir_uc8230

      dir  uc8230_GLCD_DB7 IN
      dir  uc8230_GLCD_DB6 IN
      dir  uc8230_GLCD_DB5 IN
      dir  uc8230_GLCD_DB4 IN
      dir  uc8230_GLCD_DB3 IN
      dir  uc8230_GLCD_DB2 IN
      dir  uc8230_GLCD_DB1 IN
      dir  uc8230_GLCD_DB0 IN

End Sub
