'  Required for MAX7219 device
'  Required for MAX7219 device
  '  #define Max7219_DI portb.3
  '  #define Max7219_DO portb.2
  '  #define Max7219_SCK portb.1
  '  #define Max7219_CS portb.0

  ' Include GLCD.H to reuse the font tables
  #include <glcd.h>

  ' Set GLCD_TYPE to ensure glcdinit does initialise for the max7219 solution
  #define GLCD_TYPE NOTSPECIFIED

  #define GLCDCLS Max7219_LEDMatrix_GLCDCLS

  ' Reguired defines
  #define  MAX7219_REG_NOOP        0x00
  #define  MAX7219_REG_DECODEMODE  0x09   ' decode register; specify digits to decode
  #define  MAX7219_REG_INTENSITY   0x0A   ' intensity (brightness) register; 15 = 100%
  #define  MAX7219_REG_SCANLIMIT   0x0B   ' scan-limit register; specify how many digits
  #define  MAX7219_REG_SHUTDOWN    0x0C   ' 1 = display on; 0 = display off
  #define  MAX7219_REG_DISPLAYTEST 0x0F   ' 1 =  on; 0 =  off




  ' Determine the power on wait. Can be changed by the user
  #define Max7219_PowerOnTestWait_ms 10
  #define Max7219_PixelTransmissionDelay 1 ms

  #startup MAX7219_LEDMatrix_Init

'Declare global variables
  dim  GLCDBackground, GLCDForeground as byte


  sub MAX7219_LEDMatrix_Init

    GLCDBackground = 0
    GLCDForeground = 1

    SPIMode master, SPI_CPOL_0 + SPI_CPHA_0

    Dir Max7219_DI  In
    Dir Max7219_DO  Out
    Dir Max7219_SCK Out
    Dir Max7219_CS  out
    wait 10 ms

    Set Max7219_DO  off
    Set Max7219_SCK off
    wait 10 ms

    Max7219_sendByte(MAX7219_REG_INTENSITY, 0x00)'Brightness to minimum
    wait Max7219_PowerOnTestWait_ms ms
    Max7219_sendByte(MAX7219_REG_DECODEMODE, 0x00)'Decoding off
    Max7219_sendByte(MAX7219_REG_DECODEMODE, 0x00)'Decoding off
    Max7219_sendByte(MAX7219_REG_INTENSITY, 0x0F)'Brightness to intermediate
    Max7219_sendByte(MAX7219_REG_SCANLIMIT, 0x07)'Scan limit = 7
    Max7219_sendByte(MAX7219_REG_SHUTDOWN, 0x01)'Normal operation mode
    wait Max7219_PowerOnTestWait_ms ms
    GLCDFontWidth = 6


    GLCDCLS

end sub



Sub Max7219_LEDMatrix_GLCDCLS ( Optional In  GLCDBackground as byte = GLCDBackground )

  ' initialise global variable. Required variable for Circle - DO NOT DELETE
  GLCD_yordinate = 0

  Dim Max7219_PixelCounter , Max7219_DeviceAddress as byte

  Max7219_DeviceAddress = 1

  For Max7219_PixelCounter = 1 to Max7219_PixelBytes

            MAX7219_Image_Buffer( Max7219_PixelCounter ) = 0

            Max7219_RowAddress = ( ( Max7219_PixelCounter mod 8 ) )

            'Send a number of NOPS
            Repeat ( Max7219_Devices - Max7219_DeviceAddress )
                Max7219_sendByte(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
            End Repeat

            'Send data to the specific Device and Row
            Max7219_sendByte( Max7219_RowAddress, GLCDBackground )

            'Send a number of NOPS
            Repeat Max7219_DeviceAddress - 1
                Max7219_sendByte(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
            End Repeat

            'Increment the Device address
            If Max7219_RowAddress = 8 then
                Max7219_DeviceAddress++
            end if

  Next

End Sub


Sub Max7219_LEDMatrix_Update


  Dim Max7219_PixelCounter , Max7219_DeviceAddress as byte

  Max7219_DeviceAddress = 1

  For Max7219_PixelCounter = 1 to Max7219_PixelBytes

          Max7219_RowAddress = ( ( Max7219_PixelCounter mod 8 ) )

          'Send a number of NOPS
          Repeat ( Max7219_Devices - Max7219_DeviceAddress )
              Max7219_sendByte(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
          End Repeat

          'Send data to the specific Device and Row
          Max7219_sendByte( Max7219_RowAddress, Max7219_Image_Buffer ( Max7219_PixelCounter) )

          'Send a number of NOPS
          Repeat Max7219_DeviceAddress - 1
              Max7219_sendByte(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
          End Repeat

          'Increment the Device address
          If Max7219_RowAddress = 8 then
              Max7219_DeviceAddress++
          end if

  Next

End Sub




sub Max7219_LEDMatrix_FlashInvertDisplay()

  Dim Max7219_PixelCounter , Max7219_DeviceAddress as byte

  Max7219_DeviceAddress = 1

  For Max7219_PixelCounter = 1 to Max7219_PixelBytes

          Max7219_RowAddress = ( ( Max7219_PixelCounter mod 8 ) )

          'Send a number of NOPS
          Repeat ( Max7219_Devices - Max7219_DeviceAddress )
              Max7219_sendByte(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
          End Repeat
          Max7219_Image_Buffer ( Max7219_PixelCounter + 1 ) = (!Max7219_Image_Buffer ( Max7219_PixelCounter ))

          'Send data to the specific Device and Row
          Max7219_sendByte( Max7219_RowAddress, Max7219_Image_Buffer ( Max7219_PixelCounter ) )

          'Send a number of NOPS
          Repeat Max7219_DeviceAddress - 1
              Max7219_sendByte(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
          End Repeat

          'Increment the Device address
          If Max7219_RowAddress = 8 then
              Max7219_DeviceAddress++
          end if

  Next
  End Sub

  sub Max7219_LEDMATRIX_Brightness (  optional in Max7219_Brightness_Value = 7  )

    if Max7219_Brightness_Value > 0x0f then Max7219_Brightness_Value = 0x0f
    Max7219_sendByte( MAX7219_REG_INTENSITY , Max7219_Brightness_Value )
    Max7219_sendByte( MAX7219_REG_INTENSITY , Max7219_Brightness_Value )
    Max7219_sendByte( MAX7219_REG_INTENSITY , Max7219_Brightness_Value )
    Max7219_sendByte( MAX7219_REG_INTENSITY , Max7219_Brightness_Value )

  end sub


  macro Max7219_SendByte(in reg, in ddata)
 dim null as byte
      Max7219_CS = 1
      Max7219_CS = 0
      FastHWSPITransfer  reg
      FastHWSPITransfer  ddata

      Max7219_CS = 1

  end macro

  macro Max7219_SendBytex(in reg, in ddata)

      FastHWSPITransfer  reg
      FastHWSPITransfer  ddata

  end macro


  Sub xMax7219_PaintFromBuffer( in PixelBuffer(), Max7219_PixelCount )

    Dim Max7219_ByteValue, Max7219_PixelCounter, outbyte As Byte

    Max7219_PixelCounter = 1

    For Max7219_Loop = 1 to Max7219_PixelCount / 8

      For CurrPixelY = 1 to 8

            outbyte = 0
          dim yy as byte
          for yy = 0 to 7
            Max7219_ByteValue = PixelBuffer ( (Max7219_Loop * 8 + yy))
            HSerPrintCRLF
            hserprint Max7219_ByteValue
            HSerPrint ": R="
            repeat CurrPixelY-1
                rotate Max7219_ByteValue right
                HSerPrint "."
            end repeat

            hserprint Max7219_ByteValue
            HSerPrint " outbyte ="

            if Max7219_ByteValue.0 = 1 then
                outbyte.0 = 1
            Else
                outbyte.0 = 0
            end if
            HSerPrint outbyte
            set c off
            rotate outbyte left

          next
          HSerPrintCRLF

          Max7219_CS = 1
          Max7219_CS = 0

          select case Max7219_PixelCounter

          case 1 to 8

              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex( CurrPixelY ,outbyte )

          case 9 to 16
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex( CurrPixelY ,outbyte )
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)

          case 17 to 24
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex( CurrPixelY ,outbyte )
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)


          case 25 to 32
              Max7219_sendBytex( CurrPixelY ,outbyte )
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)

          end select

          Max7219_PixelCounter++

          Max7219_CS = 1
          wait 50 ms

        Next
        wait 2 s

    Next

  End Sub



  Sub Max7219_PaintFromBuffer( in PixelBuffer(), Max7219_PixelCount )

    Dim Max7219_ByteValue, Max7219_PixelCounter As Byte
    Max7219_PixelCounter = 1

    For Max7219_CurrPixelX = 1 to Max7219_PixelCount / 8

        For CurrPixelY = 1 to 8

          Max7219_CS = 1
          Max7219_CS = 0

          select case Max7219_PixelCounter

          case 1 to 8

              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex( CurrPixelY ,PixelBuffer ( Max7219_PixelCounter) )

          case 9 to 16
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex( CurrPixelY ,PixelBuffer ( Max7219_PixelCounter) )
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)

          case 17 to 24
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex( CurrPixelY ,PixelBuffer ( Max7219_PixelCounter) )
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)


          case 25 to 32
              Max7219_sendBytex( CurrPixelY ,PixelBuffer ( Max7219_PixelCounter) )
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_sendBytex(MAX7219_REG_NOOP, MAX7219_REG_NOOP)

          end select

          Max7219_PixelCounter++
          Max7219_CS = 1

        Next

    Next

  End Sub




  Sub Max7219_ClearBuffer( in PixelBuffer(), Max7219_PixelCount )

    For Max7219_CurrPixelX = 1 to Max7219_PixelCount
        PixelBuffer(Max7219_CurrPixelX) = 0
    Next

  End Sub


  Sub Max7219_ScrollMessage( in OutMessage as string, In max7219_MessageTime As Word )

    dim max7219_ScrollLen, max7219_ScrollPosition as word
    max7219_ScrollLen = OutMessage(0) * GLCDFontWidth

    For max7219_ScrollPosition = 1 to max7219_ScrollLen
      Max7219_ClearBuffer ( Max7219_Image_Buffer() ,32)
      GLCDPrint(0 - max7219_ScrollPosition, 0,  OutMessage)
      Max7219_PaintFromBuffer ( Max7219_Image_Buffer() ,32)
      Wait max7219_MessageTime ms
    Next

  End Sub


  Sub Max7219_FlashMessage(OutMessage(), In max7219_MessageTime As Word)

    Max7219_ClearBuffer
    max7219_MessageLength = OutMessage(0)
    For max7219_MessageChar = 1 to max7219_MessageLength
      GLCDDrawChar(0, 0, OutMessage(max7219_MessageChar))
      Max7219_LEDMATRIX_Update
      Wait max7219_MessageTime ms
    Next

  End Sub

#define Pset max7219_PSet_0
Sub Max7219_PSet_90( max7219_LocX as word, max7219_LocY as word, PixelCol)

      'Protect the buffer - by extreme X Y locations
      if max7219_LocX > ( MAX7219_X_Devices * 8 ) -1  then exit sub
      elementbit =  max7219_LocY / 8
      if elementbit >  MAX7219_Y_Devices - 1 then exit sub


      element = ( max7219_LocX + ( max7219_LocY / 8 ) + 1 )
      elementbit =  max7219_LocY mod 8

      Max7219_Image_Buffer( element ) = Max7219_Image_Buffer( element ) OR FnLSL( PixelCol, elementbit )

  End Sub

Sub Max7219_PSet_0( max7219_LocX as word, max7219_LocY as word, PixelCol)


      'Protect the buffer - by extreme X Y locations
      if max7219_LocX > ( MAX7219_X_Devices * 8 ) -1  then exit sub
      elementbit =  max7219_LocY / 8
      if elementbit >  MAX7219_Y_Devices - 1 then exit sub


      elementbit = max7219_LocX mod 8
      element = ( ( max7219_LocX / 8 ) * 8 ) + (8-max7219_LocY)

'      If PixelCol.0 = 0 Then
'        Max7219_Image_Buffer( element ) = Max7219_Image_Buffer( element ) AND FnLSL( PixelCol, elementbit )
'      Else
        Max7219_Image_Buffer( element ) = Max7219_Image_Buffer( element ) OR FnLSL( PixelCol, elementbit )
'      End If



  End Sub




#define GLCDPrint max7219_GLCDPrint
  '''Displays a message
  '''@param PrintLocX X coordinate for message
  '''@param PrintLocY Y coordinate for message
  '''@param PrintData Message to display
  Sub Max7219_GLCDPrint(In PrintLocX as word, In PrintLocY as word, in LCDPrintData as string )

    Dim GLCDPrintLoc as word

    PrintLen = LCDPrintData(0)
    If PrintLen = 0 Then Exit Sub

    GLCDPrintLoc = PrintLocX
    'Write Data
    For SysPrintTemp = 1 To PrintLen
      GLCDDrawChar GLCDPrintLoc, PrintLocY, LCDPrintData(SysPrintTemp)
      GLCDPrintLoc += GLCDFontWidth
    Next
  End Sub

  '''Displays a number
  '''@param PrintLocX X coordinate for message
  '''@param PrintLocY Y coordinate for message
  '''@param LCDValue Number to display
  Sub Max7219_GLCDPrint(In PrintLocX, In PrintLocY, In LCDValue As Long)
    Dim SysCalcTempA As Long
    Dim SysPrintBuffer(10)
    SysPrintBuffLen = 0

    Do
      'Divide number by 10, remainder into buffer
      SysPrintBuffLen += 1
      SysPrintBuffer(SysPrintBuffLen) = LCDValue % 10
      LCDValue = SysCalcTempA
    Loop While LCDValue <> 0

    'Display
    GLCDPrintLoc = PrintLocX
    For SysPrintTemp = SysPrintBuffLen To 1 Step -1
      GLCDDrawChar GLCDPrintLoc, PrintLocY, SysPrintBuffer(SysPrintTemp) + 48
      GLCDPrintLoc += GLCDFontWidth
    Next

  End Sub

#define GLCDDrawChar max7219_GLCDDrawChar
  '''Draws a character at the specified location on the ST7920 GLCD
  '''@param StringLocX X coordinate for message
  '''@param CharLocY Y coordinate for message
  '''@param Chars String to display
  '''@param LineColour Line Color, either 1 or 0
  Sub max7219_GLCDDrawChar(In CharLocX as word, In CharLocY as word, In CharCode, Optional In LineColour as word = GLCDForeground )

    'CharCode needs to have 16 subtracted, table starts at char 16 not char 0
    CharCode -= 15

    'invert colors if required

      if LineColour <> GLCDForeground  then
        'Inverted Colours
        GLCDBackground = 1
        GLCDForeground = 0
      end if

            'Need to read characters from CharColn (n = 0:7) tables
    '(First 3, ie 0:2 are blank, so can ignore)
    For CurrCharCol = 1 to 5

      Select Case CurrCharCol
        Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
        Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
        Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
        Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
        Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
      End Select
      For CurrCharRow = 0 to 7
        If CurrCharVal.0 = 0 Then
                  PSet CharLocX + CurrCharCol-1, CharLocY + CurrCharRow, GLCDBackground
        Else
                  PSet CharLocX + CurrCharCol-1, CharLocY + CurrCharRow, GLCDForeground
        End If
        Rotate CurrCharVal Right
      Next

    Next

    'Restore
    GLCDBackground = 0
    GLCDForeground = 1

  End Sub
