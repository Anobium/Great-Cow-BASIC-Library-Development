'
'    Created Evan R Venn - Oct 2013
'    Beta v0.81
'    added November 13: PrintString - retrieve a string from an eeprom
'    added November 13: Toggle.  Toggle PORT pin

#define << 0
#define >> 1

' using uf_shift to ensure we do not clash with any potential PUBLIC method.
Function uf_shift ( l_invar as word , l_rotateval, l_direction ) as word

    for ul_loop = 1 to l_rotateval
        set C off
        if l_direction  = 1 then
            rotate l_invar RIGHT
        else
            rotate l_invar LEFT
        end if
    next
    uf_shift = l_invar
end function

' using uf_shift to ensure we do not clash with any potential PUBLIC method.
Function uf_shift_long ( l_invar as Long , l_rotateval, l_direction ) as Long

'    SerPrint 1, "<< = 0x"
'    SerPrint 1, hex( l_invar_E )
'    SerPrint 1, hex( l_invar_U )
'    SerPrint 1, hex( l_invar_H )
'    SerPrint 1, hex( l_invar )

    for ul_loop = 1 to l_rotateval
        set C off
        if l_direction  = 1 then
           rotate l_invar RIGHT
        else
             rotate l_invar LEFT

        end if
'
'        crlf
'        SerPrint 1, ">> = 0x"
'        SerPrint 1, hex( l_invar_E )
'        SerPrint 1, hex( l_invar_U )
'        SerPrint 1, hex( l_invar_H )
'        SerPrint 1, hex( l_invar )

    next
    uf_shift_long = l_invar
end function



sub PrintString ( in ul_addr as Byte, out eepromstring as string )


    dim eepromlocation as word

    if EEPROMReadError = 1 then
       eepromstring = "?$"
       exit sub
    end if

    eepromlocation = 1
    ' get max number of strings
    '     EPRead eepromlocation, maxeepromstrings
     eeprom_rd_byte( EEPROM_DEVICE_1, eepromlocation , maxeepromstrings )
     eepromlocation++

     'get string number
     for sysloop1 =  1 to maxeepromstrings

'         EPRead eepromlocation , stringnumber
          eeprom_rd_byte( EEPROM_DEVICE_1, eepromlocation , stringnumber )
         eepromlocation++
         stringnumber = stringnumber * 1

'         EPRead eepromlocation , stringlength
         eeprom_rd_byte( EEPROM_DEVICE_1, eepromlocation , stringlength )
         eepromlocation++


         ' have we located the correct string?
         if stringnumber = ul_addr then
            eepromstring(0) = stringlength

            for sysloop2 = 1 to stringlength
'                EPRead eepromlocation , instring

                eeprom_rd_byte( EEPROM_DEVICE_1, eepromlocation , instring )
                eepromlocation++
                eepromstring(sysloop2) = instring
            next
            exit Sub
         end if
         eepromlocation = eepromlocation + stringlength


     next
     eepromstring = "?$"
End sub


'      Toggle @PORTE, 2 ' equates to RE1
'      Wait 100  ms
'      Toggle @PORTE, 2
'      Wait 100 ms

Sub Toggle ( In DestPort As word, In DestBit )
      Poke DestPort, Peek(DestPort) xor DestBit
End sub