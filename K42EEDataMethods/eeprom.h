'    EEPROM routines for Great Cow BASIC
'    Copyright (C) 2006 - 2017 Hugh Considine, William Roth and Evan R. Venn

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

'********************************************************************************
'IMPORTANT:
'THIS FILE IS ESSENTIAL FOR SOME OF THE COMMANDS IN GCBASIC. DO NOT ALTER THIS FILE
'UNLESS YOU KNOW WHAT YOU ARE DOING. CHANGING THIS FILE COULD RENDER SOME GCBASIC
'COMMANDS UNUSABLE!
'********************************************************************************

'Changes:
' 3/5/2006: Program EEPROM read/write added
' 16/5/2006: Write mode disabled at end of EPWrite
' 23/5/2006: EPWrite and EPRead changed to stop use of temporary vars
' 19/8/2006: Program EEPROM altered to take input as word
' 9/2/2007: Bug fix: EEPGD bit not set if not present
' 5/8/2007: Altered to use alias to access address, data vars
' 4/9/2007: Data EEPROM code altered to support AVR
' 15/10/2007: Bug fix: FREE bit not set if not present, altered to use IntOn/IntOff to control interrupt
' 4/12/2007: Added In/Out to parameters
' 17/6/2008: Altered to make EPRead a system sub, to allow use in ReadTable
' 19/4/2009: Bugfixes for AVR, allow EEPE instead of EEWE
' 4/3/2013: Corrections for PIC16F1847 (EEDAT instead of EEDATA)
' 23/2/2016: Use EEDATL instead of EEDATA (16F1825, possibly others)
' 16/3/16: Added supported for NVMADRH:NVMADRL
' 10/9/17: Removed depencies on Register.Bits - just use Bits. This prevents variables being created. And, change Script from NVMADRH to NVMADRL test.

'Set EEDATL_REF to whatever it is actually called (EEDAT, EEDATA or EEDATL)
#script
  If Var(EEDATA) Then
    EEDATL_REF = EEDATA
  End If

  If Var(EEDAT) Then
    EEDATL_REF = EEDAT
  End If

  If Var(EEDATL) Then
    EEDATL_REF = EEDATL
  End If

  'Change from NVMADRH test as NVMADRH does not exist on every chip. The 18F25K42 for instance. 10/9/17
  If var(NVMADRL) Then
    EPWrite = NVMADR_EPWrite
    EPRead  = NVMADR_EPRead
  End If


#endscript

''Public are following methods v1.04
'    'FLASH_ReadByte_K42
'    'FLASH_ReadWord_K42
'    'FLASH_WriteByte_K42
'
'    #define FLASH_DATAMETHODS        0
'    #define WRITE_FLASH_BLOCKSIZE    128
'    #define ERASE_FLASH_BLOCKSIZE    128
'    #define END_FLASH                0x004000   'Some devices have more memory. Please check the datasheet
'
'
'
'    #script
'
'        If PROGRAM_EEDATAMETHODS = 1 Then
'          ProgramWriteByte = FLASH_Write_K42
''          ProgramReadByte  = FLASH_ReadByte_K42
''          ProgramReadWord  = FLASH_ReadWord_K42
'          ProgramWrite = FLASH_Write_K42
'          ProgramRead = FLASH_Read_K42
'          ProgramErase = FLASH_EraseBlock_K42
'        End If
'
'        If PROGRAM_EEDATAMETHODS = 2 Then
'          FLASH_WriteByte = FLASH_WriteByte_Type2
'          FLASH_ReadByte  = FLASH_ReadByte_Type2
'          FLASH_ReadWord  = FLASH_ReadWord_Type2
'        End If
'
'    #endscript
'
'    'We can declare the ARRAY here... if not use then not an issue
'    dim EEDataBuffer  ( WRITE_FLASH_BLOCKSIZE )
'    dim EEDataBuffer_h( WRITE_FLASH_BLOCKSIZE )
'
'    'A byte to hold the upper byte of the address
'    dim l_TBLPTR as byte
'
'
'
'sub EPWrite(In EEAddress, In EEDataValue)
'
'#IFDEF PIC
'
'  'Variable alias
'  #IFNDEF Var(EEADRH)
'    Dim EEAddress Alias EEADR  'erv
'  #ENDIF
'
'  #IFDEF Var(EEADRH)
'    Dim EEAddress As Word Alias EEADRH, EEADR
'  #ENDIF
'
'  #ifdef EEDATL_REF
'    Dim EEDataValue Alias EEDATL_REF
'  #endif
'
'  'Disable interrupt
'  IntOff
'
'  'Select data memory
'  #IFDEF Bit(EEPGD)
'    SET EEPGD OFF
'  #ENDIF
'
' #IFDEF Bit(CFGS)
'    Set CFGS OFF
'  #ENDIF
'
'  'Start write
'  SET WREN ON
'  EECON2 = 0x55
'  EECON2 = 0xAA
'  SET WR ON
'  SET WREN OFF
'
'  'Wait for write to complete
'  WAIT WHILE WR ON
'  SET WREN OFF
'
'  'Restore interrupt
'  IntOn
'
'#ENDIF
'
'#IFDEF AVR
'  'Variable alias
'  #IFDEF Var(EEARH)
'    Dim EEAddress As Word Alias EEARH, EEARL
'  #ENDIF
'  #IFNDEF Var(EEARH)
'    #IFDEF Var(EEAR)
'      Dim EEAddress Alias EEAR
'    #ENDIF
'  #ENDIF
'  Dim EEDataValue Alias EEDR
'
'  'Enable write
'  #IFDEF Bit(EEMWE)
'    Set EEMWE On
'  #ENDIF
'  #IFNDEF Bit(EEMWE)
'    #IFDEF Bit(EEMPE)
'      Set EEMPE On
'    #ENDIF
'  #ENDIF
'  'Start write, wait for it to complete
'  #IFDEF Bit(EEWE)
'    Set EEWE On
'    Wait Until EEWE Off
'  #ENDIF
'  #IFNDEF Bit(EEWE)
'    #IFDEF Bit(EEPE)
'      Set EEPE On
'      Wait Until EEPE Off
'    #ENDIF
'  #ENDIF
'
'#ENDIF
'
'end sub
'
''EPRead made into system subroutine
''Constant added to allow it to still be referred to as EPRead
'#define EPRead SysEPRead
'sub SysEPRead(In EEAddress, Out EEDataValue)
'
'#IFDEF PIC
'
'  'Variable alias
'  #IFNDEF Var(EEADRH)
'    Dim EEAddress Alias EEADR
'  #ENDIF
'  #IFDEF Var(EEADRH)
'    Dim EEAddress As Word Alias EEADRH, EEADR
'  #ENDIF
'  #ifdef EEDATL_REF
'    Dim EEDataValue Alias EEDATL_REF
'  #endif
'
'  'Disable interrupt
'  IntOff
'
'  'Select data memory
'  #IFDEF Bit(EEPGD)
'    SET EEPGD OFF
'  #ENDIF
'  #IFDEF Bit(CFGS)
'    Set CFGS OFF
'  #ENDIF
'
'  'Read
'  SET RD ON
'
'  'Restore interrupt
'  IntOn
'#ENDIF
'
'#IFDEF AVR
'  'Variable alias
'  #IFDEF Var(EEARH)
'    Dim EEAddress As Word Alias EEARH, EEARL
'  #ENDIF
'  #IFNDEF Var(EEARH)
'    #IFDEF Var(EEAR)
'      Dim EEAddress Alias EEAR
'    #ENDIF
'  #ENDIF
'  Dim EEDataValue Alias EEDR
'
'  'Start read
'  Set EERE On
'
'#ENDIF
'
'end sub
'
'function ReadEP(EEAddress)
'
'#IFDEF PIC
'  'Variable alias
'  #IFNDEF Var(EEADRH)
'    Dim EEAddress Alias EEADR
'  #ENDIF
'  #IFDEF Var(EEADRH)
'    Dim EEAddress As Word Alias EEADRH, EEADR
'  #ENDIF
'  #ifdef EEDATL_REF
'    Dim EEDataValue Alias EEDATL_REF
'  #endif
'
'  'Disable interrupt
'  IntOff
'
'  'Select data memory
'  #IFDEF Bit(EEPGD)
'    SET EEPGD OFF
'  #ENDIF
'  #IFDEF Bit(CFGS)
'    Set CFGS OFF
'  #ENDIF
'
'  'Read
'  SET RD ON
'
'  'Restore interrupt
'  IntOn
'#ENDIF
'
'#IFDEF AVR
'  'Variable alias
'  #IFDEF Var(EEARH)
'    Dim EEAddress As Word Alias EEARH, EEARL
'  #ENDIF
'  #IFNDEF Var(EEARH)
'    #IFDEF Var(EEAR)
'      Dim EEAddress Alias EEAR
'    #ENDIF
'  #ENDIF
'  Dim EEDataValue Alias EEDR
'
'  'Start read
'  Set EERE On
'#ENDIF
'
'end function
'
'sub ProgramWrite(In EEAddress, In EEDataWord)
'
'#IFDEF PIC
'
'
'  Dim EEAddress As Word Alias EEADRH, EEADR
'  Dim EEDataWord As Word Alias EEDATH, EEDATL_REF
'
'  'Disable Interrupt
'  IntOff
'
'  'Select program memory
'  SET EEPGD ON
'  #IFDEF Bit(CFGS)
'    Set CFGS OFF
'  #ENDIF
'
'  'Enable write
'  SET WREN ON
'  #ifdef bit(FREE)
'    SET FREE OFF
'  #endif
'
'  'Write enable code
'  EECON2 = 0x55
'  EECON2 = 0xAA
'
'  'Start write, wait for it to finish
'  SET WR ON
'  NOP
'  NOP
'  SET WREN OFF
'
'  'Enable Interrupt
'  IntOn
'#ENDIF
'
'end sub
'
'sub ProgramRead(In EEAddress, Out EEDataWord)
'  Dim EEAddress As Word Alias EEADRH, EEADR
'  Dim EEDataWord As Word Alias EEDATH, EEDATL_REF
'
'  'Disable Interrupt
'  IntOff
'
'  'Select program memory
'  SET EEPGD ON
'  #IFDEF Bit(CFGS)
'    Set CFGS OFF
'  #ENDIF
'
'  'Start read, wait for it to finish
'  SET RD ON
'  NOP
'  NOP
'
'  'Enable interrupt
'  IntOn
'end sub
'
'sub ProgramErase(In EEAddress)
'  Dim EEAddress As Word Alias EEADRH, EEADR
'
'  'Disable Interrupt
'  IntOff
'
'  'Select program memory
'  SET EEPGD ON
'  #IFDEF Bit(CFGS)
'    Set CFGS OFF
'  #ENDIF
'
'  SET WREN ON
'  #ifdef bit(FREE)
'    SET FREE ON
'  #endif
'  EECON2 = 0x55
'  EECON2 = 0xAA
'  SET WR ON
'  NOP
'  NOP
'  #ifdef bit(FREE)
'    SET FREE OFF
'  #endif
'  SET WREN OFF
'
'  'Enable interrupt
'  IntOn
'end sub
'
'
'
''Type #1
''K42 Methods
'      '  Summary
'      '    Reads a data byte from Flash
'      '
'      '  Description
'      '    This routine reads a data byte from given Flash address
'      '
'      '  Preconditions
'      '    None
'      '
'      '  Param
'      '    flashAddr - Flash program memory location from which data has to be read
'      '
'      '  Returns
'      '    Data byte read from given Flash address
'      '
'      '  Example
'      '    readByte as byte
'      '    flashAddr = 0x7D00
'      '
'      '    readByte = FLASH_ReadByte_K42(flashAddr)
'
''          function FLASH_Read_K42( flashAddr as long ) as byte
''
''              NVMREG1 = 1
''              NVMREG0 = 0
''              RD = 1
''              'This will load the flashAddr into the three registers.  The upper byte is a dummy location.
''              Dim flashAddr as Long Alias l_TBLPTR, TBLPTRU, TBLPTRH, TBLPTRL
''
''              TBLRD*
''              NOP     ' NOPs required for latency at high frequencies
''              NOP
''              NOP
''              NOP
''              NOP
''              NOP
''              NOP
''              NOP
''              NOP
''
''              FLASH_ReadByte_K42 = TABLAT
''
''          end function
'
'
'      '  Summary
'      '    Reads a data word from Flash
'      '
'      '  Description
'      '    This routine reads a data word from given Flash address
'      '
'      '  Preconditions
'      '    None
'      '
'      '  Param
'      '    flashAddr - Flash program memory location from which data has to be read
'      '
'      '  Returns
'      '    Data word read from given Flash address
'      '
'      '  Example
'      '    readWord as word
'      '    flashAddr = 0x7D00
'      '
'      '    readWord = FLASH_ReadWord_K42(flashAddr)
'
'          sub FLASH_Read_K42( flashAddr as long, Out EEDataWord as word  )
'
'              NVMREG1 = 1
'              NVMREG0 = 0
'              RD = 1
'              'This will load the flashAddr into the three registers.  The upper byte is a dummy location.
'              Dim flashAddr as Long Alias l_TBLPTR, TBLPTRU, TBLPTRH, TBLPTRL
'
'              TBLRD*+
'              NOP     ' NOPs required for latency at high frequencies
'              NOP
'              NOP
'              NOP
'              NOP
'              NOP
'              NOP
'              NOP
'              NOP
'              EEDataWord_h = TABLAT
'              NOP     ' NOPs required for latency at high frequencies
'              NOP
'              NOP
'              NOP
'              NOP
'              NOP
'              NOP
'              NOP
'              NOP
'              EEDataWord = TABLAT
'
'          end sub
'
'      '
'      '  Summary
'      '    Writes a data byte into Flash
'      '
'      '  Description
'      '    This routine writes the given data byte into mentioned Flash address.
'      '
'      '    This routine intially reads block of data (from Flash) into RAM, updates
'      '    data values in RAM, and writes back updated values to Flash.
'      '
'      '  Preconditions
'      '    None
'      '
'      '  Param
'      '    flashAddr      - Flash program memory location to which data has to be written
'      '    flashRdBufPtr -  RAM buffer of size 'ERASE_FLASH_BLOCKSIZE' at least
'      '    byte           - Data byte to be written in Flash
'      '
'      '  Returns
'      '    None
'      '
'      '  Example
'      '
'      '    writeData = 0xAA
'      '    flashAddr = 0x7D00
'      '    MyBuffer(ERASE_FLASH_BLOCKSIZE)
'      '
'      '    FLASH_WriteByte_K42(flashAddr, MyBuffer, writeData)
'
'          sub FLASH_Write_K42( flashAddr as long,  EEDataByte as byte )
'
'              dim flashAddr as Long Alias l_TBLPTR, TBLPTRU, TBLPTRH, TBLPTRL
'
'              dim blockStartAddr  as Long
'              blockStartAddr= flashAddr  & ((END_FLASH-1) XOR (ERASE_FLASH_BLOCKSIZE-1))
'
'              Dim EEDataoffset as byte
'              EEDataoffset = (flashAddr & (ERASE_FLASH_BLOCKSIZE-1))
'
'              'Entire row will be erased, read and save the existing data
'              dim writeloop as word
'              for writeloop = 0 to ERASE_FLASH_BLOCKSIZE-1
'                   FLASH_Read_K42(blockStartAddr+ writeloop, EEDataBuffer_h(writeloop) )
'              next
'
'              'Load byte at offset
'              EEDataBuffer( EEDataoffset ) = EEDataByte
'
'              'Writes buffer contents to current block
'              FLASH_WriteBlock_K42( blockStartAddr )
'
'          end sub
'
'          sub FLASH_Write_K42( flashAddr as long,  EEDataWord as word )
'
'              FLASH_Write_K42( flashAddr,  EEDataWord_h )
'              FLASH_Write_K42( flashAddr,  EEDataWord )
'
'          end sub
'
'
'      '  Summary
'      '    Writes data to complete block of Flash
'      '
'      '  Description
'      '    This routine writes data bytes to complete block in Flash program memory
'      '
'      '  Preconditions
'      '    None
'      '
'      '  Param
'      '    writeAddr      - A valid block starting address in Flash
'      '    myBuffer        - An array of size 'WRITE_FLASH_BLOCKSIZE' at least
'
'      '  Returns
'      '    -1, if the given address is not a valid block starting address of Flash
'      '    0, in case of valid block starting address
'
'      '  Example
'
'      '    #define FLASH_ROW_ADDRESS     0x3D00
'      '
'      '    You will have to sort this data array in your code if your were to preload the FlashMemory
'      '    Dim EEDataBuffer (
'      '        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
'      '        0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
'      '        0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
'      '        0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F
'      '        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
'      '        0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
'      '        0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
'      '        0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F
'      '        )
'
'      '    write to Flash memory block
'      '    FLASH_WriteBlock_K42( FLASH_ROW_ADDRESS, myBuffer )
'
'          sub FLASH_WriteBlock_K42( writeAddr as long )
'
'              Dim writeAddr as Long Alias l_TBLPTR, TBLPTRU, TBLPTRH, TBLPTRL
'
'              Dim GIEBitValueB as bit
'              GIEBitValueB = GIE        'Save interrupt enable
'
'              dim blockStartAddr  as Long
'              blockStartAddr= writeAddr & ((END_FLASH-1) XOR (ERASE_FLASH_BLOCKSIZE-1))
'
'              ' Flash write must start at the beginning of a row
'              if writeAddr <> blockStartAddr then
'                  exit sub
'              end if
'              'Block erase sequence
'              FLASH_EraseBlock_K42(writeAddr)
'
'              'Write block of data
'              dim writeloop as word
'              for writeloop = 0 to WRITE_FLASH_BLOCKSIZE-1
'
'                  TABLAT = EEDataBuffer(writeloop) ' Load data byte
'
'                  if writeloop = (WRITE_FLASH_BLOCKSIZE-1) then
'                      TBLWT*
'                  else
'                      TBLWT*+
'                  end if
'              next
'
'              NVMREG1 = 1
'              NVMREG0 = 0
'              WREN = 1
'              GIE = 0
'              NVMCON2 = 0x55
'              NVMCON2 = 0xAA
'              WR = 1
'              NOP     ' NOPs required for latency at high frequencies
'              NOP
'              NOP
'              NOP
'              NOP
'              wait while WR = 1
'              WREN = 0
'              GIE = GIEBitValueB
'
'          end sub
'
'
'      '  Summary
'      '    Erases complete Flash program memory block
'      '
'      '  Description
'      '    This routine erases complete Flash program memory block
'      '
'      '  Preconditions
'      '    None
'      '
'      '  Param
'      '    baseAddr - A valid block starting address in Flash program memory
'      '
'      '  Returns
'      '    None
'      '
'      '  Example
'      '    flashBlockStartAddr = 0x7D00
'      '
'      '    FLASH_EraseBlock_K42(flashBlockStartAddr)
'
'          sub FLASH_EraseBlock_K42( flashAddr as long )
'
'              Dim GIEBitValueE as bit
'              GIEBitValueE = GIE        'Save interrupt enable
'
'              Dim flashAddr as Long Alias l_TBLPTR, TBLPTRU, TBLPTRH, TBLPTRL
'
'              NVMREG1 = 1
'              NVMREG0 = 0
'              WREN = 1
'              GIE = 0
'              NVMCON2 = 0x55
'              NVMCON2 = 0xAA
'              WR = 1
'              NOP     ' NOPs required for latency at high frequencies
'              NOP
'              NOP
'              NOP
'              NOP
'              wait while WR = 1
'              WREN = 0
'              GIE = GIEBitValueE
'
'
'          end sub
'
'
'
'  Section: Data EEPROM Module APIs

Sub NVMADR_EPWrite(IN SysEEAddress as WORD , in EEData)

    dim IntState as bit
    IntState = GIE
    Dim SysEEPromAddress As Word

  'ALL 16F NVMREGS Devices Except 18FxxK40/K42
   #IFDEF BIT(NVMREGS)
       SysEEPromAddress = SysEEAddress + 0x7000
       NVMADRH =SysEEPromAddress_h
       NVMADRL =SysEEPromAddress
       NVMDATL = EEData
       NVMREGS = 1
    #ENDIF

   '' 18FXXk40/K42 and others with NVMREG0/NVMREG1
   #IFDEF BIT(NVMREG0)
       SysEEPromAddress = SysEEAddress
       NVMADRH =SysEEPromAddress_h
       NVMADRL =SysEEPromAddress
        'Access EEPROM LOcations
        NVMREG0 = 0
        NVMREG1 = 0
        NVMDAT = EEData
   #ENDIF

    FREE = 0
    WREN = 1
    GIE = 0
    NVMCON2 = 0x55
    NVMCON2 = 0xAA
    WR = 1
    NOP     ' NOPs may be required for latency at high frequencies
    NOP
    NOP
    NOP
    NOP
    wait while WR = 1
    WREN = 0

    'Restore interrupt to initial  State
    GIE = IntState
end sub

Sub NVMADR_EPRead(IN SysEEAddress AS word  , out EEDataValue )



  #IFDEf bit(NVMREGS)
      Dim SysEEPromAddress As Word
      SysEEPromAddress = SysEEAddress + 0x7000
      NVMADRH = SysEEPromAddress_h
      NVMADRL = SysEEPromAddress
      NVMREGS = 1
      RD = 1
      NOP     ' NOPs may be required for latency at high frequencies
      NOP
      NOP
      NOP
      EEDataValue = NVMDATL
  #ENDIF

  #IFDEf bit(NVMREG0)
      Dim SysEEPromAddress As Word
      SysEEPromAddress = SysEEAddress
      NVMADRH =SysEEPromAddress_h
      NVMADRL =SysEEPromAddress
      NVMREG0 = 0
      NVMREG1 = 0
      RD = 1
      NOP     ' NOPs may be required for latency at high frequencies
      NOP
      NOP
      NOP
      EEDataValue = NVMDAT
  #ENDIF


End Sub
