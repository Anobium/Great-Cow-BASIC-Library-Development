'    Graphical LCD routines for the GCBASIC compiler
'    Copyright (C) 2015, 2019 Paolo Iocco, Stan Cartwright and Evan Venn

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

'''Draws a string at the specified location on theE-Paper
'''@param StringLocX X coordinate for message
'''@param CharLocY Y coordinate for message
'''@param Chars String to display
'''@param LineColour Line Color, either 1 or 0


    'EPD Commands
    #define Booster_Soft_start  0x06
    #define Power_Setting       0x01
    #define Power_ON            0x04
    #define Panel_Setting       0x00
    #define PLL_Control         0x30
    #define Resolution_Setting  0x61
    #define VCM_DC_Setting      0x82
    #define Vcom_and_data_interval_setting  0x50
    #define Data_Trasmission_1  0x10
    #define Data_Trasmission_2  0x13
    #define Display_Refresh     0x12
    #define Power_off           0x02
    #define Deep_Sleep          0x07
'______________________________________________________________________
'    Dim EPD_Black, EPD_White, EPD_Background, EPD_Foreground as Byte
'    Dim EPD_Width, EPD_Height, EPD_Width8 as Word
'
'    EPD_Width =104
'    EPD_Height=212
'    EPD_width8=EPD_Width/8
'    EPD_Black =0
'    EPD_White =0xFF            'lungo x ogni bit associato ad un pixel
'    EPD_Background=EPD_Black
'    EPD_Foreground=EPD_White
'
'    #ifndef GLCD_TYPE_EPD2in13D_CHARACTER_MODE_ONLY
'        GLCD_TYPE_EPD2in13D_LOWMEMORY_GLCD_MODE=False
'        BuffWidth=2756
'        n_page=1
'        Dim EPD_Buffer(2756)
'    #endif
'    #ifdef GLCD_TYPE_EPD2in13D_CHARACTER_MODE_ONLY
'      #define GLCD_TYPE_EPD2in13D_LOWMEMORY_GLCD_MODE
'      #ifdef GLCD_TYPE_EPD2in13D_LOWMEMORY1_GLCD_MODE
'        BuffWidth= 104
'        n_Page=26
'        Dim EPD_Buffer(104)
'      #endif
'      #ifdef GLCD_TYPE_EPD2in13D_LOWMEMORY2_GLCD_MODE
'        GLCD_TYPE_EPD2in13D_LOWMEMORY_GLCD_MODE=TRUE
'        BuffWidth=208
'        n_Page=13
'        Dim EPD_Buffer(208)
'      #endif
'      #ifdef GLCD_TYPE_EPD2in13D_LOWMEMORY3_GLCD_MODE
'        GLCD_TYPE_EPD2in13D_LOWMEMORY_GLCD_MODE=TRUE
'        n_Page=8
'        BuffWidth=312
'        Dim EPD_Buffer(312)
'      #endif
'      #ifdef GLCD_TYPE_EPD2in13D_LOWMEMORY4_GLCD_MODE
'        GLCD_TYPE_EPD2in13D_LOWMEMORY_GLCD_MODE=TRUE
'        n_Page=2
'        BuffWidth=1378
'        Dim EPD_Buffer(1378)
'      #endif
'    #endif
'_________________________________________________________________


sub Reset_EPD2in13D

    SET EPD_reset ON
    wait 200 ms
    SET EPD_Reset OFF
    wait 20 ms
    SET EPD_reset ON
    wait 200 ms

end sub

sub Init_EPD2in13D

    SendCommand_EPD2in13D(Booster_Soft_start)
    SendData_EPD2in13D(0x17)
    SendData_EPD2in13D(0x17)
    SendData_EPD2in13D(0x17)

    wait 200 ms
    SendCommand_EPD2in13D(Power_Setting)
    SendData_EPD2in13D(0x03)
    SendData_EPD2in13D(0x00)
    SendData_EPD2in13D(0x2B)
    SendData_EPD2in13D(0x2B)
    SendData_EPD2in13D(0x03)

wait 200 ms
    SendCommand_EPD2in13D(Power_ON)

    Do While EPD_Busy=OFF
    wait 200 ms
    Loop

    SendCommand_EPD2in13D(Panel_Setting)
    SendData_EPD2in13D(0xBF)

    SendCommand_EPD2in13D(PLL_Control)
    SendData_EPD2in13D(0x3C)

    SendCommand_EPD2in13D(Resolution_Setting)
    SendData_EPD2in13D(0x68)
    SendData_EPD2in13D(0x00)
    SendData_EPD2in13D(0xD4)

    SendCommand_EPD2in13D(VCM_DC_Setting)
    SendData_EPD2in13D(0x12)

    LoadLUTS_EPD2in13D

end sub

sub LoadLUTS_EPD2in13D


    SendCommand_EPD2in13D(VCM_DC_Setting)
    SendData_EPD2in13D(0x00)


    SendCommand_EPD2in13D(Vcom_and_data_interval_setting)
    SendData_EPD2in13D(0x97)

    SendCommand_EPD2in13D(0x20) 'VCOM LUT
    for counter=1 to 44
      ReadTable Lut_Vcom, Counter, Data
      SendData_EPD2in13D(Data)
    next

    SendCommand_EPD2in13D(0x21) 'WW LUT
    for counter=1 to 42
      ReadTable Lut_WW, Counter, Data
      SendData_EPD2in13D(Data)
    next

    SendCommand_EPD2in13D(0x22) 'BW LUT
    for counter=1 to 42
      ReadTable Lut_BW, Counter, Data
      SendData_EPD2in13D(Data)
    next

    SendCommand_EPD2in13D(0x23) 'WB LUT
    for counter=1 to 42
      ReadTable Lut_WB, Counter, Data
      SendData_EPD2in13D(Data)
    next

    SendCommand_EPD2in13D(0x24) 'BB LUT
    for counter=1 to 42
      ReadTable Lut_BB, Counter, Data
      SendData_EPD2in13D(Data)
    next

end sub
sub Clear_EPD2in13D


      SendCommand_EPD2in13D(Data_Trasmission_1)
      wait 2 ms
      for ind_raw=1 to EPD_Height
        for ind_col=1 to EPD_width
          SendData_EPD2in13D(EPD_Black)
        next
      next
      wait 10 ms
      SendCommand_EPD2in13D(Data_Trasmission_2)
      wait 2 ms
      for ind_raw=1 to EPD_Height
        for ind_col=1 to EPD_width
          SendData_EPD2in13D(EPD_Black)
        next
      next
      wait 10 ms
end sub

sub Refresh_EPD2in13D

    LoadLUTS_EPD2in13D

    SendCommand_EPD2in13D(Display_Refresh)

    Do While EPD_Busy=OFF
    wait 200 ms
    Loop

end sub

sub Sleep_EPD2in13D

    SendCommand_EPD2in13D(Vcom_and_data_interval_setting)
    SendData_EPD2in13D(0xD7)

    SendCommand_EPD2in13D(Power_Off)

    SendCommand_EPD2in13D(Deep_Sleep)
    SendData_EPD2in13D(0xA5)

end sub

sub SendCommand_EPD2in13D(in Command as Byte)

    SET EPD_CS OFF
    SET EPD_DC OFF
    SPITransfer Command, Dummy
    SET EPD_CS ON

end sub

sub SendData_EPD2in13D(in Data as Byte)

    SET EPD_CS OFF
    SET EPD_DC ON
    SPITransfer Data, Dummy
    SET EPD_CS ON

end sub

Sub DrawString_EPD2in13D( In StringLocX as word, In CharLocY as word, In Chars as string, Optional In LineColour as word = GLCDForeground )

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
Sub DrawChar_EPD2in13D(In CharLocX as word, In CharLocY as word, In CharCode, Optional In LineColour as word = GLCDForeground )

  'This has got a tad complex
  'We have three major pieces
  '1 The preamble - this just adjusted color and the input character
  '2 The code that deals with GCB fontset
  '3 The code that deals with OLED fontset
  '
  'You can make independent change to section 2 and 3 but they are mutual exclusive with many common pieces


    'invert colors if required
    if LineColour <> GLCDForeground  then
      'Inverted Colours
      GLCDBackground = 1
      GLCDForeground = 0
    end if


   dim CharCol, CharRow, GLCDTemp as word
   CharCode -= 15
  'CharCode needs to have 16 subtracted, table starts at char 16 not char 0

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
                           PSet([word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, LineColour)
                        Else
                           PSet([word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, GLCDBACKGROUND)
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
                  CurrCharVal = GLCDBACKGROUND
                #endif
          End Select

            'we handle 8 or 16 pixels of height
            For CurrCharRow = 0 to ROWSperfont
                'Set the pixel
                If CurrCharVal.0 = 0 Then
                          PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, GLCDBACKGROUND
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
                    CurrCharVal = GLCDBACKGROUND
                  #endif
                end if

                'It is the intercharacter space, put out one pixel row
                if CurrCharCol = COLSperfont then
                    'Put out a white intercharacter pixel/space
                     GLCDTemp = CharLocX + CurrCharCol
                     if GLCDfntDefaultSize = 2 then
                        GLCDTemp++
                     end if
                     PSet GLCDTemp , CharLocY + CurrCharRow, GLCDBACKGROUND
                end if

            Next



        Next


    #endif

End Sub

'''Draws a pixel on the GLCD
'''@param GLCDX X coordinate of pixel
'''@param GLCDY Y coordinate of pixel
'''@param GLCDColour State of pixel
Sub PSet_EPD2in13D(In GLCDX as word, In GLCDY as word, In GLCDColour As Word)

  Dim n_col, n_raw, ind_Trans as word
  Dim remainder as byte
  Dim value as bit
  if GLCDColour <> EPD_Background then
    value=1
  else
    value=0
  end if
    n_col=(GLCDX+1)/8       'numero dela colonna su cui è il byte coinvolto
    remainder=(GLCDX+1)%8
    n_raw=GLCDY*EPD_Width8  'numero di riga del byte coinvolto
    if remainder=0 then
      ind=n_raw+n_col
    else
      ind=n_raw+n_col+1     'numero del byte coinvolto (a partire dal primo di ind=1)
    end if
    #ifdef GLCD_TYPE_EPD2in13D_LOWMEMORY_GLCD_MODE
      Ind_Trans=Ind-_GLCDPage*BuffWidth
      if ind_Trans>BuffWidth then
        EXIT SUB
      end if
    #endif
    Data=EPD_Buffer(ind_Trans)
    Select Case remainder
    case 0
      data.0=value
    case 1
      data.7=value
    case 2
      data.6=value
    case 3
      data.5=value
    case 4
      data.4=value
    case 5
      data.3=value
    case 6
      data.2=value
    case 7
      data.1=value
    End Select
    EPD_Buffer(ind_Trans)=Data

End Sub

'''Draws a filled box on the GLCD screen
'''@param LineX1 Top left corner X location
'''@param LineY1 Top left corner Y location
'''@param LineX2 Bottom right corner X location
'''@param LineY2 Bottom right corner Y location
'''@param LineColour Colour of box (0 = erase, 1 = draw, default is 1)
Sub FilledBox_EPD2in13D(In LineX1 as word, In LineY1 as word, In LineX2 as word, In LineY2 as word, Optional In LineColour As Word = GLCDForeground)
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

  for ind_raw=LineY1  to LineY2
    for ind_col=LineX1 to lineX2
      PSet_EPD2in13D(Ind_Col, ind_raw, LineColour)
    next
  next

End Sub





'''Displays a string in a larger fonti.e.  BigPrint_ILI9341 ( 30, ILI9341_GLCD_HEIGHT - 20 , "BigPrint_ILI9341" )
'''@param PrintLocX X coordinate for message
'''@param PrintLocY Y coordinate for message
'''@param PrintData String to display
'''@param Color Optional color
Sub BigPrint_EPD2in13D(In PrintLocX as Word, In PrintLocY as Word,  PrintData As String, Optional In  Color as word = GLCDForeground)
  Dim GLCDPrintLoc as word
  PrintLen = PrintData(0)
  If PrintLen = 0 Then Exit Sub
  GLCDPrintLoc = PrintLocX
  For SysPrintTemp = 1 To PrintLen
    DrawBigChar_EPD2in13D GLCDPrintLoc, PrintLocY, PrintData(SysPrintTemp), Color
    GLCDPrintLoc += 13
  Next
End Sub

'''Draws a Vertical Line on the GLCD with a
'''@param GLCDY1 Y coordinate of one end of the line
'''@param GLCDY2 Y coordinate of the other end of the line
'''@param GLCDX1 X coordinate of the line
'''@param LineColour color
Sub DrawBigChar_EPD2in13D (In CharLocX as Word, In CharLocY as Word, In CharCode, Optional In  Color as word = GLCDForeground )

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
             PSet_EPD2in13D LocX , LocY , Color
          end if
          Rotate CurrCharVal Right
        Next
    Next
End Sub

Macro  GLCD_Open_PageTransaction_EPD2in13D ( Optional In _GLCDPagesL As byte = 0 , Optional In _GLCDPagesH As byte = 7 )

  #ifdef GLCD_TYPE_EPD2in13D_LOWMEMORY_GLCD_MODE

      dim _GLCDPage as byte
      'Clear buffer
      for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
  #endif

end Macro

Macro  GLCD_Close_PageTransaction_EPD2in13D

  #ifdef GLCD_TYPE_EPD2in13D_LOWMEMORY_GLCD_MODE

          if Flag=0 then
            DisplayPixels_EPD2in13D(1)
            Flag=1
          else
            DisplayPixels_EPD2in13D(2)
          end if

      next

  #endif


'______________________________________________________________
'______________________________________________________________

    Table Lut_Vcom as Byte
        0x00, 0x08, 0x00, 0x00, 0x00, 0x02
        0x60, 0x28, 0x28, 0x00, 0x00, 0x01
        0x00, 0x14, 0x00, 0x00, 0x00, 0x01
        0x00, 0x12, 0x12, 0x00, 0x00, 0x01
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00
    End Table
    Table Lut_WW as Byte
        0x40, 0x08, 0x00, 0x00, 0x00, 0x02
        0x90, 0x28, 0x28, 0x00, 0x00, 0x01
        0x40, 0x14, 0x00, 0x00, 0x00, 0x01
        0xA0, 0x12, 0x12, 0x00, 0x00, 0x01
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    End Table
    Table Lut_BW as Byte
        0x40, 0x17, 0x00, 0x00, 0x00, 0x02
        0x90, 0x0F, 0x0F, 0x00, 0x00, 0x03
        0x40, 0x0A, 0x01, 0x00, 0x00, 0x01
        0xA0, 0x0E, 0x0E, 0x00, 0x00, 0x02
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    End Table
    Table Lut_WB as Byte
        0x80, 0x08, 0x00, 0x00, 0x00, 0x02
        0x90, 0x28, 0x28, 0x00, 0x00, 0x01
        0x80, 0x14, 0x00, 0x00, 0x00, 0x01
        0x50, 0x12, 0x12, 0x00, 0x00, 0x01
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    End table
    Table Lut_BB as Byte
        0x80, 0x08, 0x00, 0x00, 0x00, 0x02
        0x90, 0x28, 0x28, 0x00, 0x00, 0x01
        0x80, 0x14, 0x00, 0x00, 0x00, 0x01
        0x50, 0x12, 0x12, 0x00, 0x00, 0x01
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    End Table
'______________________________________________________________
'______________________________________________________________