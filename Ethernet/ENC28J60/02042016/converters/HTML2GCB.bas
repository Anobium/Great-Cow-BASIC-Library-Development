'	HTML2GCB - A program to convert HTML to a table for use a HTML Web Page within Great Cow BASIC
'	Copyright (C) 2016 Evan Venn
'
'	This program is free software; you can redistribute it and/or modify
'	it under the terms of the GNU General Public License as published by
'	the Free Software Foundation; either version 2 of the License, or
'	(at your option) any later version.
'
'	This program is distributed in the hope that it will be useful,
'	but WITHOUT ANY WARRANTY; without even the implied warranty of
'	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'	GNU General Public License for more details.
'
'	You should have received a copy of the GNU General Public License
'	along with this program; if not, write to the Free Software
'	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
'
'         If you have any questions about the source code, please email me: evan@anobium.co.uk
'         Any other questions, please email me or see the Souceforge forums.
'

#include once "windows.bi"            ' Requierd to get/parse commandline, Win API NOT UNICODE, but can't undef it.
#include once "win/shellapi.bi"       '





Dim shared  As Integer fhandle, fileresult
dim shared as byte dotPointer, result, tableCounter, variableCountTotal
dim as integer c,nargs
dim shared as string inputfilename

dim as wstring ptr ptr szArglist
Dim shared fbuffer As String
dim params(10) as string


dim shared HTMLMappingType(255) as string
dim shared HTMLMapping(255) as string
dim shared HTMLGCBVarName(255) as String
dim shared sizeofTable(255) as word
#define ByteVar "ByteVar"
#define StringVar "StringVar"


                                      ' Define externals
#undef GetCommandLine
declare function GetCommandLine alias "GetCommandLineW" () as LPWSTR
#undef CommandLineToArgv
declare function CommandLineToArgv alias "CommandLineToArgvW" (byval as LPCWSTR, byval as integer ptr) as LPWSTR ptr
'declare Function RoundUp(ByVal x As Long, ByVal y As Long) As Long
declare Function isHTMLValid(Fisier As String) As Boolean
'declare Sub ReadBitmap( Fisier As String )

declare Sub ReadHTMLPage( Fisier As String )

main:

      szArglist=CommandLineToArgv(GetCommandLine(),@nArgs)           ' get the arguements from GCBasic
      if nargs-1 = 0 then
         print "> Help for HTML2GCB"
         print ">"
         print ">         A tool to convert HTML files to Great Cow Basic table format"
         print ">"
         print ">         Command line parameters"
         print ">         HTML2GCB filename.HTML"
         print ">         "
         print ">         where, the filename.HTML is the source HTML file"
         print ">         "
         print ">"
         print ">         The output will be a file with the extension GCB"
         print ">"

         end
      end if
      print "> ";:print *GetCommandLine()
      for c=0 to nargs-1
          params(c) = *(szArglist[c])
      next
      localfree(szArglist)
      dim shared ug_invert as boolean

      fbuffer = params(1)
      print "> ";
      print fbuffer
      dotPointer = instrrev(fbuffer,".")
      fbuffer = left(fbuffer , dotPointer )+"GCB"
      result = kill ( fbuffer )



 '     Put #fhandle, , "'      Commencing Examination of BMP file":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
      if isHTMLValid ( params(1) ) then
         fhandle= FreeFile
         Open fbuffer For output As #fhandle
         Put #fhandle, , "'      This file was created by the HTML2GCB converter":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
         Put #fhandle, , "'      This is a BMP to GCBasic Table Converter":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
         Put #fhandle, , "'      Created by Evan R. Venn @ 2016":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
         Put #fhandle, , "'      ":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
         Put #fhandle, , "'      This program is free software; you can redistribute it and/or modify":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
         Put #fhandle, , "'      it under the terms of the GNU General Public License as published by":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
         Put #fhandle, , "'      the Free Software Foundation; either version 2 of the License, or":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
         Put #fhandle, , "'      (at your option) any later version":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
         Put #fhandle, , "'      ":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
         Put #fhandle, , "'      Valid HTML file found":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
      else
         Put #fhandle, , "'      Invalid HTML file found":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
         close
         end
      end if


      If Err>0 Then Print "Error opening the file":End
        Put #fhandle, , "'      HTML Metrics":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
        Put #fhandle, , "'      Completed Examination of HTML file":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
      print ">"
      print "> Processing HTML file ";params(1)
      print "> Creating "+fbuffer
      ' Find the first free file number.




      dotPointer = instrrev(params(1),chr(92) )
      inputfilename = mid(params(1), dotPointer+1,255 )
      dotPointer = instrrev(inputfilename,"." )-1
      inputfilename = mid(inputfilename, 1, dotPointer )
      Put #fhandle, , "'      ------------------------------------------------------------------------------":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
      Put #fhandle, , "'      File generated by HTML2GCB":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
      Put #fhandle, , "'      See http://sourceforge.net/projects/bmptoglcd/":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
      Put #fhandle, , "":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)

      tableCounter = 1
      variableCountTotal = 0

      Put #fhandle, , "Table "+ inputfilename +str(tableCounter)+" as Byte":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
      close #fhandle
      Open fbuffer For append As #fhandle



      ReadHTMLPage ( params(1) )

      Put #fhandle, , "End Table":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
      Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
      Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
      Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
      'Output key GCB commands
      Put #fhandle, , "#define ByteVar 0":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
      Put #fhandle, , "#define StringVar 1":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
      Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
      Put #fhandle, , chr(13) : Put #fhandle, , chr(10)

       for c = 1 to tableCounter
            Put #fhandle, , "#define SizeofTable"
            Put #fhandle, , str(c)
            Put #fhandle, , " "
            Put #fhandle, , str(sizeofTable(c))
            Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
       next
      Put #fhandle, , chr(13) : Put #fhandle, , chr(10)


      'Output key GCB Commands
      Put #fhandle, , "dim HTMLMappingType("
      Put #fhandle, ,  str(variableCountTotal)
      Put #fhandle, , ")"
      Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
      Put #fhandle, , "dim HTMLMapping("
      Put #fhandle, , str(variableCountTotal)
      Put #fhandle, , ")"
      Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
      Put #fhandle, , chr(13) : Put #fhandle, , chr(10)



      for c = 1 to variableCountTotal

          Put #fhandle, , "HTMLMappingType("
          Put #fhandle, , str(c)
          Put #fhandle, , ") = "
          Put #fhandle, , HTMLMappingType(c)
          Put #fhandle, , chr(13) : Put #fhandle, , chr(10)

          Put #fhandle, , "HTMLMapping("
          Put #fhandle, , str(c)
          Put #fhandle, , ") = "
          Put #fhandle, , HTMLMapping(c)

          Put #fhandle, , "    '"
          Put #fhandle, , HTMLGCBVarName(c)
          Put #fhandle, , chr(13) : Put #fhandle, , chr(10)

     next
      Put #fhandle, , chr(13) : Put #fhandle, , chr(10)



      print "> GCB Variables found in source HTML = ";
      print str(variableCountTotal)
      ' Close all open files.

      Close

end


    'reads HTML file type
    Sub ReadHTMLPage ( Fisier As String  )


      Dim as long  byteCounter, variableValue
      Dim as ubyte i, j, m
      Dim as ubyte BytesPerRow, BytesPerCol
      Dim as byte AddOne
      Dim as long byteLineCounter
      Dim as ushort lcdByte
      dim as byte HTMLByte

      Dim HTMLhandle As Integer
      Dim as string ln, oldLn, variableValueStr
      Dim as Byte variablePosition, endOfVariablePosition
      HTMLhandle = FreeFile                                             ' Find the next free file number.
      Open Fisier For input As #HTMLhandle




      do until( eof(HTMLhandle) )

          line input #HTMLhandle, ln

          if byteCounter + len(ln) < 2024 then

            'GCB Variable string
            if instr(ln,"_GCB_STRING") <> 0 and instr(ln,"=") <> 0   Then
              oldLn = Ln

              variablePosition = instr(ln,"_GCB_")



              variablePosition = instr( variablePosition, ln, chr(34) )
              endOfVariablePosition = instr( variablePosition+1, ln, chr(34) )

              variableValueStr=mid( ln, variablePosition, endOfVariablePosition )
              'adapt the ln
              ln = mid( ln, 1, variablePosition) + chr(0)+mid( ln, endOfVariablePosition )

              variableCountTotal = variableCountTotal + 1
              HTMLMappingType(variableCountTotal) = StringVar
              HTMLMapping(variableCountTotal) =  mid( oldln, variablePosition+1, endOfVariablePosition - variablePosition-1 )
              HTMLGCBVarName(variableCountTotal) = oldLn
            end if

            'GCB Variable byte
            if instr(ln,"_GCB_BYTE") <> 0 and instr(ln,"=") <> 0 Then
              oldLn = Ln

              variablePosition = instr(ln,"_GCB_BYTE")
              variablePosition = instr( variablePosition, ln, "=" )
              variableValueStr = trim(mid(ln, variablePosition+1))
              variableValue = valLng(variableValueStr)
              endOfVariablePosition = instr( ln, str( variableValue ) ) + len( str( variableValue ) )

              'adapt the ln
              ln = mid( ln, 1, variablePosition) + chr(0)+mid( ln, endOfVariablePosition )
              variableCountTotal = variableCountTotal + 1
              HTMLMappingType(variableCountTotal) = ByteVar
              HTMLMapping(variableCountTotal) = str(variableValue)
              HTMLGCBVarName(variableCountTotal) = oldLn
            end if


            'Now output the line we read or the adapted line
            for byteLineCounter = 1 to len(ln)

                HTMLByte = asc(mid( ln, byteLineCounter, 1 ))
                byteCounter = byteCounter + 1

                if HTMLByte<> 13 Then
                  if HTMLByte<>10 then
                    Print #fhandle,HTMLByte;
                    Put #fhandle, , chr(9)
                    Put #fhandle, , chr(9)
                    Print #fhandle,"'";
                    if HTMLByte = 0 then
                      Print #fhandle,Oldln;
                    else
                      PUT #fhandle,,chr(HTMLByte)
                    end if
                    Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
'                    print HTMLByte
                  end if
                end if

            next
            'to add CRLF
'            byteCounter = byteCounter + 2
'            Print #fhandle, 13
'            Print #fhandle, 10

          Else

                Put #fhandle, , "End Table":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
                Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
                sizeofTable(tableCounter) = byteCounter
                tableCounter = tableCounter+1
                byteCounter = 0

                Put #fhandle, , "Table "+ inputfilename +str(tableCounter)+" as Byte":Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
                close #fhandle
                Open fbuffer For append As #fhandle



          end if
          sizeofTable(tableCounter) = byteCounter


      loop

      Close #HTMLhandle


      print "> Converted ";
      Print Fisier

    End Sub




    Function isHTMLValid(Fisier As String) As Boolean


      Dim HTMLhandle As Integer

      HTMLhandle = FreeFile                                             ' Find the next free file number.

      fileresult = Open ( Fisier For Binary Access Read As #HTMLhandle )

'      'reads bitmap info
'      Get #HTMLhandle, 1, bmpHeader
'      Get #HTMLhandle, 15, dibHeader
'      Close #HTMLhandle
'
'      If ( left(bmpHeader.MagicNumber,2) = "BM" ) And ( dibHeader.Width < 129 ) And ( dibHeader.Height < 65 ) And  ( dibHeader.CompressionType = 0 ) And ( dibHeader.BitsPerPixel = 1 ) Then
        isHTMLValid = True
        Print "> A valid HTML file found"
'      Else
'        result = kill ( fbuffer )
'        if fileresult <> 0 then
'        Print "> Bad times. Check filename"
'        print ""
'        end
'        end if
'        isHTMLValid = False
'        Print "> Bad times. Check type, size, color and compression of BitMap Image"
'        print ">"
'        if left(bmpHeader.MagicNumber,2) <> "BM" then
'           Print "> Probably not a BitMap Image."
'        end if
'        if dibHeader.Width > 128 then
'           Print "> Maximim pixel width is 128."
'        end if
'        if dibHeader.Height > 64 then
'           Print "> Maximum pixel heigth is 64."
'        end if
'        if dibHeader.CompressionType <> 0 then
'           Print "> Incorrect compression type.  Needs to type 0."
'        end if
'        if dibHeader.BitsPerPixel <> 1 then
'           Print "> Incorrect Bits per Pixel.  Needs to 1 bit per pixel (Monochrome)."
'        end if
'        print

'      End If

    End Function



'    'reads bmp file type and updates ImageHeader, calculates size etc
'    Sub ReadBitmap( Fisier As String  )
'
'
'      Dim as byte  l
'      Dim as ubyte i, j, m
'      Dim as ubyte BytesPerRow, BytesPerCol
'      Dim as byte AddOne
'      Dim as ushort lcdByte
'      dim as ubyte info
'      Dim as Long DataIndex, k
'
'      Dim HTMLhandle As Integer
'      Dim As tBmpHeader bmpHeader
'      Dim As tDibHeader dibHeader
'      Dim Title as string * 16
'
'      HTMLhandle = FreeFile                                             ' Find the next free file number.
''      print "> Freefile = "+str(FreeFile)
'      Open Fisier For Binary Access Read As #HTMLhandle
'
'
'      'reads bitmap info
'      Get #HTMLhandle, 1, bmpHeader
'      Get #HTMLhandle, 15, dibHeader
'
'      BytesPerRow = RoundUp(dibHeader.Width, 32) * 4
'      BytesPerCol = RoundUp(dibHeader.Height, 8)
'
'      ReDim bmpData(BytesPerRow * 8, dibHeader.Height) As Boolean
'      ReDim lcdData(BytesPerCol, dibHeader.Width) As UByte
'
'      'Get #HTMLhandle, 11, k                        :' Hard coded address of start of data
'      'print "k = ";:print k
'      k = bmpHeader.Offset
'      'print "k = ";:print k
'
'      'fetch image data
'      print "> Height      = " + str(dibHeader.Height)
'      print "> Width       = " + str(dibHeader.Width)
'      print "> BytePerRow  = " + str(BytesPerRow)
'      print "> BytesPerCol = "+str(BytesPerCol )
'
'      For i = 0 To dibHeader.Height - 1
'
'        For j = 0 To BytesPerRow - 1
'          k = k + 1
'          Get #HTMLhandle, k, info
'
'          For l = 7 To 0 Step -1
'
'            bmpData(j * 8 + 7 - l, i) = ABS(Bit(info, l)) XOR ug_invert
'
'          Next l
'
'        Next j
'
'      Next i
'      Close #HTMLhandle
'
'      ' show array
'      for i = 0 To dibHeader.Height - 1
'          for j = 0 to dibHeader.Width - 1
'                  if bmpData(j , i) = 1 then
'                     print "X";
'                  else
'                     print " ";
'                  end if
'          next
'          print
'      next
'
'
'
'      'updates data: width and height
'      Put  #fhandle, ,"' start data" :Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
'
'      dim testval as ubyte
'      testval =  dibHeader.Width
'      if testval < 16 then
'         Put #fhandle, ,"0x0"+HEX(testval) :Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
'      else
'         Put #fhandle, ,"0x"+HEX(testval) :Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
'      end if
'      testval = dibHeader.Height
'      if testval < 16 then
'         Put #fhandle, ,"0x0"+HEX(testval) :Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
'      else
'         Put #fhandle, ,"0x"+HEX(testval) :Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
'      end if
'
'
'
'      'assigns value to lcdData
'
'      dim  as ubyte bottom_addressed_row
'      bottom_addressed_row = dibHeader.Height
'
'      dim as ubyte y
'      dim  as ubyte x
'      print ">"
'      print "> Processing bitmap to GLCD ";
'      for y = dibHeader.Height to (( dibHeader.Height  ) Mod 8)+1 step - 8
'      print ".";
'
'          For j = 0 To ( dibHeader.Width - 1)
'            bottom_addressed_row = y
'            k = 0
'            info = 0
'
'
'            x = bottom_addressed_row
'            l = bottom_addressed_row - 7
'
'                For i = x To l Step -1
'                if i=255 then end
'
'                  If bmpData(j, ( i -1 )  ) = 0 Then                          ' build the bits into bytes
'                    info = info Or (2 ^ k)
'                  End If
'
'                  If k = 7 Then                                      ' write the data
'                    lcdData(m, j) = info
'
'                    if info < 16 then
'                       Put #fhandle, ,"0x0"+HEX(info) :Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
'                    else
'                       Put #fhandle, ,"0x"+HEX(info) :Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
'                    end if
'                    close #fhandle
'                    Open fbuffer For append As #fhandle
'                    m = m + 1
'                    m = m Mod BytesPerCol
'                  End If
'
'                  k = k + 1
'                  k = k Mod 8
'
'                Next i
'
'          Next j
'
'      next y
'
'      if (dibHeader.Height Mod 8) <> 0 then
'
'      ' last nibbles
'
'          For j = 0 To dibHeader.Width - 1
'             bottom_addressed_row = y
'
'            k = 0
'            info = 0
'
'            i = ((dibHeader.Height Mod 8) - 1)
'
'
'
'
'                do while i <> 255    'change to a DO WHILE, becuase I could not get the for-next to work!
'
'                  If bmpData(j, i ) = 0 Then                          ' build the bits into bytes
'                    info = info Or (2 ^ k)
'                  End If
'
'                  If k = ( (dibHeader.Height Mod 8))-1 Then                                      ' write the data
'                    lcdData(m, j) = info
'
'                    if info < 16 then
'                       Put #fhandle, ,"0x0"+HEX(info) :Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
'                    else
'                       Put #fhandle, ,"0x"+HEX(info) :Put #fhandle, , chr(13) : Put #fhandle, , chr(10)
'                    end if
'                    close #fhandle
'                    Open fbuffer For append As #fhandle
'                    m = m + 1
'                    m = m Mod BytesPerCol
'                  End If
'
'                  k = k + 1
'                  k = k Mod 8
'
'                i = i -1
'                loop
'
'          Next j
'       end if
'
'      print "> Converted ";
'      Print Fisier
'
'    End Sub
'
'    'returns x/y rounder to next integer
'    Function RoundUp(ByVal x As Long, ByVal y As Long) As Long
'
'
'      Dim as byte i, j
'
'      i = x \ y
'      j = x Mod y
'      If j <> 0 Then i = i + 1
'
'      RoundUp = i
'    End Function
'
