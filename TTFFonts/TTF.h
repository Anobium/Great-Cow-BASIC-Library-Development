'    TTF routines for the GCBASIC compiler
'    Copyright (C) 2015 Katsaounis Dimitris

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
'
' Characters in use:
' !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
' All files built with TheDotFactory http://www.pavius.net/the-dot-factory-an-lcd-font-and-image-generator/
'
' Fonts:
' Arial Size 8-28
' CourierNew Size 8-28
' TimesNewRoman Size 8-28
' ScriptMT Size 8-26
' 7Segment Size 8-48 and 72

' Ôhe user for system memory economy reasons, may use one font at a time with one group of sizes:
' small 8-16pts , medium 18-22pts and large  24-28pts.
' The philosophy is that every time a user uses a screen with specific resolution, so size
' 28pts is very large  for  a 128x64 display.
' For example Small Arial it consums about 10KB of system memory.
'
' User must Define constant GLCDDefaultFont to be able to use a specific font otherwise the system
' uses as the  default font the Arial font.
' For example:
' #define GLCDDefaultFont  GLCDArial   or
' #define GLCDDefaultFont  GLCDCourierNew
'
' also user must Define constant GLCDfntSize to be able to use a specific gpoup of sizes
' otherwise the system uses as the  default group of sizes the group Smallfont.
' For example:
' #define GLCDfntSize GLCDSmallSize    or
' #define GLCDfntSize GLCDMediumSize
'

#include "Arial.h"
#include "CourierNew.h"
#include "TimesNewRoman.h"
#include "ScriptMT.h"  'Up to 26pts

#startup TTFInit

Sub TTFInit
  Dim GLCDPrintLoc , CharCol,  CharRow,  CharColS,   CharRowS, CharOffSetBegin, CharOffSetEnd, CharDiscr, GLCDFontWidth as Word
  'Define TTF Fonts. Add new fonts here
  #define GLCDArial 1
  #define GLCDCourierNew 2
  #define GLCDTimesNewRoman 3
  #define GLCDScriptMT 4
  #define GLCD7Segment 5
  'Define Font Size
  #define GLCDSmallSize 1   '8-16
  #define GLCDMediumSize 2  '18-22
  #define GLCDBigSize 3     '24-28

  GLCDDefaultSize=10
End Sub

Sub GLCDTTFPrint (In PrintLocX as Word, In PrintLocY as Word, In GLCDPrintData As String, Optional In GLCDFont as Byte = GLCDDefaultFont ,Optional In  GLCDForeground as word = GLCDForeground, Optional In Size=GLCDDefaultSize )
          PrintLen = GLCDPrintData(0)
	If PrintLen = 0 Then Exit Sub
	GLCDPrintLoc = PrintLocX
          GLCDFontWidth=0
	For SysPrintTem = 1 To PrintLen
	    GLCDTTFDraw GLCDPrintLoc, PrintLocY, GLCDPrintData(SysPrintTem), GLCDFont,   GLCDForeground , Size
              GLCDPrintLoc = [Word]GLCDPrintLoc + GLCDFontWidth
	Next
End Sub

Sub GLCDTTFDraw ( In CharLocX as Word, In CharLocY as Word, In CharCode as Byte, Optional In GLCDFont as Byte = GLCDDefaultFont,  Optional In  GLCDForeground as word = GLCDForeground,  Optional In Size = GLCDDefaultSize)
  CharNum=0
  Select Case CharCode
       Case  " " : CharNum=1
       Case  "!" : CharNum=2
       Case  "#" : CharNum=3
       Case  "$" : CharNum=4
       Case  "%" : CharNum=5
       Case  "&" : CharNum=6
       Case  "`" : CharNum=7
       Case  "(" : CharNum=8
       Case  ")" : CharNum=9
       Case  "*" : CharNum=10
       Case  "+" : CharNum=11
       Case  "," : CharNum=12
       Case  "-" : CharNum=13
       Case  "." : CharNum=14
       Case  "/" : CharNum=15
       Case  "0" : CharNum=16
       Case  "1" : CharNum=17
       Case  "2" : CharNum=18
       Case  "3" : CharNum=19
       Case  "4" : CharNum=20
       Case  "5" : CharNum=21
       Case  "6" : CharNum=22
       Case  "7" : CharNum=23
       Case  "8" : CharNum=24
       Case  "9" : CharNum=25
       Case  ":" : CharNum=26
       'Case  ";" : CharNum=27
       Case  "<" : CharNum=28
       Case  "=" : CharNum=29
       Case  ">" : CharNum=30
       Case  "?" : CharNum=31
       Case  "@" : CharNum=32
       Case  "A" : CharNum=33
       Case  "B" : CharNum=34
       Case  "C" : CharNum=35
       Case  "D" : CharNum=36
       Case  "E" : CharNum=37
       Case  "F" : CharNum=38
       Case  "G" : CharNum=39
       Case  "H" : CharNum=40
       Case  "I" : CharNum=41
       Case  "J" : CharNum=42
       Case  "K" : CharNum=43
       Case  "L" : CharNum=44
       Case  "M" : CharNum=45
       Case  "N" : CharNum=46
       Case  "O" : CharNum=47
       Case  "P" : CharNum=48
       Case  "Q" : CharNum=49
       Case  "R" : CharNum=50
       Case  "S" : CharNum=51
       Case  "T" : CharNum=52
       Case  "U" : CharNum=53
       Case  "V" : CharNum=54
       Case  "W" : CharNum=55
       Case  "X" : CharNum=56
       Case  "Y" : CharNum=57
       Case  "Z" : CharNum=58
       Case  "[" : CharNum=59
       Case  "\" : CharNum=60
       Case  "]" : CharNum=61
       Case  "^" : CharNum=62
       Case  "_" : CharNum=63
       Case  "'" : CharNum=64
       Case  "a" : CharNum=65
       Case  "b" : CharNum=66
       Case  "c" : CharNum=67
       Case  "d" : CharNum=68
       Case  "e" : CharNum=69
       Case  "f" : CharNum=70
       Case  "g" : CharNum=71
       Case  "h" : CharNum=72
       Case  "i" : CharNum=73
       Case  "j" : CharNum=74
       Case  "k" : CharNum=75
       Case  "l" : CharNum=76
       Case  "m" : CharNum=77
       Case  "n" : CharNum=78
       Case  "o" : CharNum=79
       Case  "p" : CharNum=80
       Case  "q" : CharNum=81
       Case  "r" : CharNum=82
       Case  "s" : CharNum=83
       Case  "t" : CharNum=84
       Case  "u" : CharNum=85
       Case  "v" : CharNum=86
       Case  "w" : CharNum=87
       Case  "x" : CharNum=88
       Case  "y" : CharNum=89
       Case  "z" : CharNum=90
       Case  "{" : CharNum=91
       Case  "|" : CharNum=92
       Case  "}" : CharNum=93
       Case  "~" : CharNum=94
       Case Else  : Exit Sub
  End Select
  CharDiscr = [Word](Size-8)*94+CharNum*2-1
  #if GLCDDefaultFont=GLCDArial
      ReadTable Arial_Descriptors, CharDiscr ,  CharBits
      ReadTable Arial_Descriptors, CharDiscr+1,  CharOffSetBegin
      ReadTable Arial_Descriptors, CharDiscr+3,  CharOffSetEnd
  #endif
  #ifndef GLCDDefaultFont
      ReadTable Arial_Descriptors, CharDiscr ,  CharBits
      ReadTable Arial_Descriptors, CharDiscr+1,  CharOffSetBegin
      ReadTable Arial_Descriptors, CharDiscr+3,  CharOffSetEnd
  #endif
  #if GLCDDefaultFont=GLCDCourierNew
      ReadTable CourierNew_Descriptors, CharDiscr ,  CharBits
      ReadTable CourierNew_Descriptors, CharDiscr+1,  CharOffSetBegin
      ReadTable CourierNew_Descriptors, CharDiscr+3,  CharOffSetEnd
  #endif
  #if GLCDDefaultFont=GLCDTimesNewRoman
      ReadTable TimesNewRoman_Descriptors, CharDiscr ,  CharBits
      ReadTable TimesNewRoman_Descriptors, CharDiscr+1,  CharOffSetBegin
      ReadTable TimesNewRoman_Descriptors, CharDiscr+3,  CharOffSetEnd
  #endif
  #if GLCDDefaultFont=GLCDScriptMT
      ReadTable ScriptMT_Descriptors, CharDiscr ,  CharBits
      ReadTable ScriptMT_Descriptors, CharDiscr+1,  CharOffSetBegin
      ReadTable ScriptMT_Descriptors, CharDiscr+3,  CharOffSetEnd
  #endif
  'Add new fonts descriptors here
  GLCDFontWidth=CharBits+2
  CharBytes=CharBits/8
  if SysCalcTempX<>0 then CharBytes++
  CharOffSetBegin++
  CharOldBytes=CharBytes
  CharCols=0
  CharRowS=0
  For CharRow=CharOffSetBegin to CharOffSetEnd
      #if GLCDDefaultFont=GLCDArial
         #if GLCDfntSize = GLCDSmallSize
             if Size=8  Then ReadTable Arial8 , CharRow , CurrCharVal
             if Size=10 then ReadTable Arial10 , CharRow , CurrCharVal
             if Size=12 then ReadTable Arial12 , CharRow , CurrCharVal
             if Size=14 then ReadTable Arial14 , CharRow , CurrCharVal
             if Size=16 then ReadTable Arial16 , CharRow , CurrCharVal
         #endif
         #ifndef GLCDfntSize
             if Size=8  Then ReadTable Arial8 , CharRow , CurrCharVal
             if Size=10 then ReadTable Arial10 , CharRow , CurrCharVal
             if Size=12 then ReadTable Arial12 , CharRow , CurrCharVal
             if Size=14 then ReadTable Arial14 , CharRow , CurrCharVal
             if Size=16 then ReadTable Arial16 , CharRow , CurrCharVal
         #endif
         #if GLCDfntSize = GLCDMediumSize
             if Size=18 then ReadTable Arial18 , CharRow , CurrCharVal
             if Size=20 then ReadTable Arial20 , CharRow , CurrCharVal
             if Size=22 then ReadTable Arial22 , CharRow , CurrCharVal
         #endif
         #if GLCDfntSize = GLCDBigSize
             if Size=24 then ReadTable Arial24 , CharRow , CurrCharVal
             if Size=26 then ReadTable Arial26 , CharRow , CurrCharVal
             if Size=28 then ReadTable Arial28 , CharRow , CurrCharVal
         #endif
      #endif
      #ifndef GLCDDefaultFont
         #if GLCDfntSize = GLCDSmallSize
             if Size=8  Then ReadTable Arial8 , CharRow , CurrCharVal
             if Size=10 then ReadTable Arial10 , CharRow , CurrCharVal
             if Size=12 then ReadTable Arial12 , CharRow , CurrCharVal
             if Size=14 then ReadTable Arial14 , CharRow , CurrCharVal
             if Size=16 then ReadTable Arial16 , CharRow , CurrCharVal
         #endif
         #ifndef GLCDfntSize
             if Size=8  Then ReadTable Arial8 , CharRow , CurrCharVal
             if Size=10 then ReadTable Arial10 , CharRow , CurrCharVal
             if Size=12 then ReadTable Arial12 , CharRow , CurrCharVal
             if Size=14 then ReadTable Arial14 , CharRow , CurrCharVal
             if Size=16 then ReadTable Arial16 , CharRow , CurrCharVal
         #endif
         #if GLCDfntSize = GLCDMediumSize
             if Size=18 then ReadTable Arial18 , CharRow , CurrCharVal
             if Size=20 then ReadTable Arial20 , CharRow , CurrCharVal
             if Size=22 then ReadTable Arial22 , CharRow , CurrCharVal
         #endif
         #if GLCDfntSize = GLCDBigSize
             if Size=24 then ReadTable Arial24 , CharRow , CurrCharVal
             if Size=26 then ReadTable Arial26 , CharRow , CurrCharVal
             if Size=28 then ReadTable Arial28 , CharRow , CurrCharVal
         #endif
      #endif
      #if GLCDDefaultFont=GLCDCourierNew
         #if GLCDfntSize = GLCDSmallSize
             if Size=8  then ReadTable CourierNew8 , CharRow , CurrCharVal
             if Size=10 then ReadTable CourierNew10 , CharRow , CurrCharVal
             if Size=12 then ReadTable CourierNew12 , CharRow , CurrCharVal
             if Size=14 then ReadTable CourierNew14 , CharRow , CurrCharVal
             if Size=16 then ReadTable CourierNew16 , CharRow , CurrCharVal
         #endif
         #ifndef GLCDfntSize
             if Size=8  then ReadTable CourierNew8 , CharRow , CurrCharVal
             if Size=10 then ReadTable CourierNew10 , CharRow , CurrCharVal
             if Size=12 then ReadTable CourierNew12 , CharRow , CurrCharVal
             if Size=14 then ReadTable CourierNew14 , CharRow , CurrCharVal
             if Size=16 then ReadTable CourierNew16 , CharRow , CurrCharVal
         #endif
         #if GLCDfntSize = GLCDMediumSize
             if Size=18 then ReadTable CourierNew18 , CharRow , CurrCharVal
             if Size=20 then ReadTable CourierNew20 , CharRow , CurrCharVal
             if Size=22 then ReadTable CourierNew22 , CharRow , CurrCharVal
         #endif
         #if GLCDfntSize = GLCDBigSize
             if Size=24 then ReadTable CourierNew24 , CharRow , CurrCharVal
             if Size=26 then ReadTable CourierNew26 , CharRow , CurrCharVal
             if Size=28 then ReadTable CourierNew28 , CharRow , CurrCharVal
         #endif
      #endif
      #if GLCDDefaultFont=GLCDTimesNewRoman
         #if GLCDfntSize = GLCDSmallSize
             if Size=8  then ReadTable TimesNewRoman8 , CharRow , CurrCharVal
             if Size=10 then ReadTable TimesNewRoman10 , CharRow , CurrCharVal
             if Size=12 then ReadTable TimesNewRoman12 , CharRow , CurrCharVal
             if Size=14 then ReadTable TimesNewRoman14 , CharRow , CurrCharVal
             if Size=16 then ReadTable TimesNewRoman16 , CharRow , CurrCharVal
         #endif
         #ifndef GLCDfntSize
             if Size=8  then ReadTable TimesNewRoman8 , CharRow , CurrCharVal
             if Size=10 then ReadTable TimesNewRoman10 , CharRow , CurrCharVal
             if Size=12 then ReadTable TimesNewRoman12 , CharRow , CurrCharVal
             if Size=14 then ReadTable TimesNewRoman14 , CharRow , CurrCharVal
             if Size=16 then ReadTable TimesNewRoman16 , CharRow , CurrCharVal
         #endif
         #if GLCDfntSize = GLCDMediumSize
             if Size=18 then ReadTable TimesNewRoman18 , CharRow , CurrCharVal
             if Size=20 then ReadTable TimesNewRoman20 , CharRow , CurrCharVal
             if Size=22 then ReadTable TimesNewRoman22 , CharRow , CurrCharVal
         #endif
         #if GLCDfntSize = GLCDBigSize
             if Size=24 then ReadTable TimesNewRoman24 , CharRow , CurrCharVal
             if Size=26 then ReadTable TimesNewRoman26 , CharRow , CurrCharVal
             if Size=28 then ReadTable TimesNewRoman28 , CharRow , CurrCharVal
         #endif
      #endif
      #if GLCDDefaultFont=GLCDScriptMT
         #if GLCDfntSize = GLCDSmallSize
             if Size=8  then ReadTable ScriptMT8 , CharRow , CurrCharVal
             if Size=10 then ReadTable ScriptMT10 , CharRow , CurrCharVal
             if Size=12 then ReadTable ScriptMT12 , CharRow , CurrCharVal
             if Size=14 then ReadTable ScriptMT14 , CharRow , CurrCharVal
             if Size=16 then ReadTable ScriptMT16 , CharRow , CurrCharVal
         #endif
         #ifndef GLCDfntSize
             if Size=8  then ReadTable ScriptMT8 , CharRow , CurrCharVal
             if Size=10 then ReadTable ScriptMT10 , CharRow , CurrCharVal
             if Size=12 then ReadTable ScriptMT12 , CharRow , CurrCharVal
             if Size=14 then ReadTable ScriptMT14 , CharRow , CurrCharVal
             if Size=16 then ReadTable ScriptMT16 , CharRow , CurrCharVal
         #endif
         #if GLCDfntSize = GLCDMediumSize
             if Size=18 then ReadTable ScriptMT18 , CharRow , CurrCharVal
             if Size=20 then ReadTable ScriptMT20 , CharRow , CurrCharVal
             if Size=22 then ReadTable ScriptMT22 , CharRow , CurrCharVal
         #endif
         #if GLCDfntSize = GLCDBigSize
             if Size=24 then ReadTable ScriptMT24 , CharRow , CurrCharVal
             if Size=26 then ReadTable ScriptMT26 , CharRow , CurrCharVal
         #endif
      #endif
      'Add new fonts tables here
      For CharCol=0 to 7
             if CurrCharVal.7=1 then
                     PSet_SSD1289 CharLocX + CharCol + CharColS, CharLocY + CharRowS, GLCDForeground
             Else
                     PSet_SSD1289 CharLocX + CharCol + CharColS, CharLocY + CharRowS, GLCDBackground
             End if
             Rotate CurrCharVal Left
      Next CharCol
      if CharBytes<>0 then CharBytes--
      if CharBytes<>0 Then
         CharColS =CharColS+8
      Else
         CharColS=0
         CharRowS++
         CharBytes=CharOldBytes
      end if
  Next

End Sub

