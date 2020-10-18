' A program to Strings to Table
' Copyright (C) 2019 Evan Venn
'
' This program is free software; you can redistribute it and/or modify
' it under the terms of the GNU General Public License as published by
' the Free Software Foundation; either version 2 of the License, or
' (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
' You should have received a copy of the GNU General Public License
' along with this program; if not, write to the Free Software
' Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
'
'         If you have any questions about the source code, please email me: evan@anobium.co.uk
'         Any other questions, please email me or see the Souceforge forums.
'


#include once "windows.bi"            ' Requierd to get/parse commandline, Win API NOT UNICODE, but can't undef it.
#include once "win/shellapi.bi"       '


Dim shared  As Integer ffilehandle, fileresult, VersionData
dim shared as byte dotPointer, result
dim as integer c,nargs

dim as wstring ptr ptr szArglist
Dim shared fbuffer As String
dim params(10) as string
                                      ' Define externals
#undef GetCommandLine
declare function GetCommandLine alias "GetCommandLineW" () as LPWSTR
#undef CommandLineToArgv
declare function CommandLineToArgv alias "CommandLineToArgvW" (byval as LPCWSTR, byval as integer ptr) as LPWSTR ptr
declare Function isBmpValid(Fisier As String) As Boolean
declare Function isValid(Fisier As String) As Boolean

main:

      szArglist=CommandLineToArgv(GetCommandLine(),@nArgs)           ' get the arguements from GCBasic
      if nargs-1 = 0 then
         print "> Help for GCB Strings to Table"
         print ">"
         print ">         A tool to create a GCB table from a list of Strings"
         print ">         for Great Cow BASIC programs only"
         print ">"
         print ">         Command line parameters"
         print ">         GCBDateStamp filename.strings"
         print ">         "
         print ">         The output will be a method with the extension h"
         print ">"

         end
      end if


      for c=0 to nargs-1
          params(c) = *(szArglist[c])
      next
      localfree(szArglist)
      dim shared ug_invert as boolean

      for c=1 to nargs-1
        fbuffer = fbuffer + " " +params(c)
      next


      params(1) = trim(fbuffer)



      if isValid ( params(1) ) then
         ffilehandle= FreeFile
         Open fbuffer For output As #ffilehandle
         Put #ffilehandle, , "'Great Cow BASIC String to Table Converter v1.01":Put #ffilehandle, , chr(13) : Put #ffilehandle, , chr(10)

         Put #ffilehandle, , "        Function GCBBuildStr as string * 5 ":Put #ffilehandle, , chr(13) : Put #ffilehandle, , chr(10)
         Put #ffilehandle, , "            GCBBuildStr=" & Chr(34) & VersionData & Chr(34) :Put #ffilehandle, , chr(13) : Put #ffilehandle, , chr(10)
         Put #ffilehandle, , "        End Function ":Put #ffilehandle, , chr(13) : Put #ffilehandle, , chr(10)

         Put #ffilehandle, , "        Function GCBBuildTimeStr as string * 19 ":Put #ffilehandle, , chr(13) : Put #ffilehandle, , chr(10)
         Put #ffilehandle, , "            GCBBuildTimeStr="&chr(34)&Date()&" "&Time()&chr(34)   :Put #ffilehandle, , chr(13) : Put #ffilehandle, , chr(10)
         Put #ffilehandle, , "        End Function ":Put #ffilehandle, , chr(13) : Put #ffilehandle, , chr(10)





         close #ffilehandle

      else
         Put #ffilehandle, , "'      Invalid methods beware!":Put #ffilehandle, , chr(13) : Put #ffilehandle, , chr(10)
         close #ffilehandle

      end if
      print "Great Cow BASIC build version utility (1.01)...  Build " & str(VersionData)

end

    Function isValid(Fisier As String) As Boolean

      Dim filehandle As Integer
      Dim VersionDataStr as string

      filehandle = FreeFile                                             ' Find the next free file number.


      fileresult = Open ( Fisier for input As #filehandle )

      dim VersionMajor as  Long
      dim VersionMinor as  Long
      dim VersionDot as  Long

      dim VersionNotes as string * 512

      dim NumberFamilies as  Long
      dim NumberParts as  Long
      dim NumberScripts as  Long
      dim Compatibility as Byte
      dim UNUSED1A as  Integer
      dim UNUSED1B as  Integer
      dim UNUSED2 as  Long


      Get #filehandle, ,VersionMajor
      Get #filehandle, ,VersionMinor
      Get #filehandle, ,VersionDot
      Get #filehandle, ,VersionNotes
      Get #filehandle, ,NumberFamilies
      Get #filehandle, ,NumberParts
      Get #filehandle, ,NumberScripts
      Get #filehandle, ,Compatibility
      Get #filehandle, ,UNUSED1A
      Get #filehandle, ,UNUSED1B
      Get #filehandle, ,UNUSED2


print VersionMajor
print VersionMinor
print VersionDot
print VersionNotes
print NumberFamilies
print NumberParts
print NumberScripts
print Compatibility
print UNUSED1A
print UNUSED1B
print UNUSED2



      Close #filehandle

'      fileresult = Open ( Fisier for output As #filehandle )
'      Put #filehandle , , str(VersionData):Put #filehandle , , chr(13) : Put #filehandle , , chr(10)
'      close #filehandle

      isValid = true

    End Function
