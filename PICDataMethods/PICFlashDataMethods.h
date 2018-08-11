'Public are following methods v1.04
    'FLASH_ReadByte_K42
    'FLASH_ReadWord_K42
    'FLASH_WriteByte_K42

    #define FLASH_DATAMETHODS        0
    #define WRITE_FLASH_BLOCKSIZE    128
    #define ERASE_FLASH_BLOCKSIZE    128
    #define END_FLASH                0x004000   'Some devices have more memory. Please check the datasheet



    #script

        If FLASH_DATAMETHODS = 1 Then
          ProgramWriteByte = FLASH_Write_K42
'          ProgramReadByte  = FLASH_ReadByte_K42
'          ProgramReadWord  = FLASH_ReadWord_K42
          ProgramWrite = FLASH_Write_K42
          ProgramRead = FLASH_Read_K42
          ProgramErase = FLASH_EraseBlock_K42
        End If

        If FLASH_DATAMETHODS = 2 Then
          FLASH_WriteByte = FLASH_WriteByte_Type2
          FLASH_ReadByte  = FLASH_ReadByte_Type2
          FLASH_ReadWord  = FLASH_ReadWord_Type2
        End If

    #endscript

    #startup PicFlashDataMethodsInit, 80
    'We can declare the ARRAY... if not use then not an issue
    dim EEDataBuffer( WRITE_FLASH_BLOCKSIZE )
    dim l_TBLPTR as byte

    Sub PicFlashDataMethodsInit



    End Sub

'Type #1
'K42 Methods
      '  Summary
      '    Reads a data byte from Flash
      '
      '  Description
      '    This routine reads a data byte from given Flash address
      '
      '  Preconditions
      '    None
      '
      '  Param
      '    flashAddr - Flash program memory location from which data has to be read
      '
      '  Returns
      '    Data byte read from given Flash address
      '
      '  Example
      '    readByte as byte
      '    flashAddr = 0x7D00
      '
      '    readByte = FLASH_ReadByte_K42(flashAddr)

          function FLASH_Read_K42( flashAddr as long ) as byte

              NVMREG1 = 1
              NVMREG0 = 0
              RD = 1
              'This will load the flashAddr into the three registers.  The upper byte is a dummy location.
              Dim flashAddr as Long Alias l_TBLPTR, TBLPTRU, TBLPTRH, TBLPTRL

              TBLRD*
              NOP     ' NOPs required for latency at high frequencies
              NOP
              NOP
              NOP
              NOP
              NOP
              NOP
              NOP
              NOP

              FLASH_ReadByte_K42 = TABLAT

          end function


      '  Summary
      '    Reads a data word from Flash
      '
      '  Description
      '    This routine reads a data word from given Flash address
      '
      '  Preconditions
      '    None
      '
      '  Param
      '    flashAddr - Flash program memory location from which data has to be read
      '
      '  Returns
      '    Data word read from given Flash address
      '
      '  Example
      '    readWord as word
      '    flashAddr = 0x7D00
      '
      '    readWord = FLASH_ReadWord_K42(flashAddr)

          function FLASH_Read_K42( flashAddr as long ) as word

              Dim flashAddr as Long Alias l_TBLPTR, TBLPTRU, TBLPTRH, TBLPTRL
              FLASH_ReadWord_K42 = FLASH_ReadByte_K42( flashAddr )
              FLASH_ReadWord_K42_h = FLASH_ReadByte_K42( [long]flashAddr + 1 )

          end function

      '
      '  Summary
      '    Writes a data byte into Flash
      '
      '  Description
      '    This routine writes the given data byte into mentioned Flash address.
      '
      '    This routine intially reads block of data (from Flash) into RAM, updates
      '    data values in RAM, and writes back updated values to Flash.
      '
      '  Preconditions
      '    None
      '
      '  Param
      '    flashAddr      - Flash program memory location to which data has to be written
      '    flashRdBufPtr -  RAM buffer of size 'ERASE_FLASH_BLOCKSIZE' at least
      '    byte           - Data byte to be written in Flash
      '
      '  Returns
      '    None
      '
      '  Example
      '
      '    writeData = 0xAA
      '    flashAddr = 0x7D00
      '    MyBuffer(ERASE_FLASH_BLOCKSIZE)
      '
      '    FLASH_WriteByte_K42(flashAddr, MyBuffer, writeData)

          sub FLASH_Write_K42( flashAddr as long,  EEDataByte as byte )

              dim flashAddr as Long Alias l_TBLPTR, TBLPTRU, TBLPTRH, TBLPTRL

              dim blockStartAddr  as Long
              blockStartAddr= flashAddr  & ((END_FLASH-1) XOR (ERASE_FLASH_BLOCKSIZE-1))

              Dim EEDataoffset as byte
              EEDataoffset = (flashAddr & (ERASE_FLASH_BLOCKSIZE-1))

              'Entire row will be erased, read and save the existing data
              dim writeloop as byte
              for writeloop = 0 to ERASE_FLASH_BLOCKSIZE-1
                  EEDataBuffer(writeloop) = FLASH_ReadByte_K42(blockStartAddr+ writeloop )
              next

              'Load byte at offset
              EEDataBuffer( EEDataoffset ) = EEDataByte

              'Writes buffer contents to current block
              FLASH_WriteBlock_K42( blockStartAddr )

          end sub

          sub FLASH_Write_K42( flashAddr as long,  EEDataWord as word )

              dim flashAddr as Long Alias l_TBLPTR, TBLPTRU, TBLPTRH, TBLPTRL

              FLASH_WriteByte_K42 ( flashAddr, EEDataWord_h )
              FLASH_WriteByte_K42 ( flashAddr, EEDataWord )

          end sub


      '  Summary
      '    Writes data to complete block of Flash
      '
      '  Description
      '    This routine writes data bytes to complete block in Flash program memory
      '
      '  Preconditions
      '    None
      '
      '  Param
      '    writeAddr      - A valid block starting address in Flash
      '    myBuffer        - An array of size 'WRITE_FLASH_BLOCKSIZE' at least

      '  Returns
      '    -1, if the given address is not a valid block starting address of Flash
      '    0, in case of valid block starting address

      '  Example

      '    #define FLASH_ROW_ADDRESS     0x3D00
      '
      '    You will have to sort this data array in your code if your were to preload the FlashMemory
      '    Dim EEDataBuffer (
      '        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
      '        0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
      '        0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
      '        0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F
      '        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
      '        0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
      '        0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
      '        0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F
      '        )

      '    write to Flash memory block
      '    FLASH_WriteBlock_K42( FLASH_ROW_ADDRESS, myBuffer )

          function FLASH_WriteBlock_K42( writeAddr as long )

              Dim writeAddr as Long Alias l_TBLPTR, TBLPTRU, TBLPTRH, TBLPTRL

              Dim GIEBitValueB as bit
              GIEBitValueB = GIE        'Save interrupt enable

              dim blockStartAddr  as Long
              blockStartAddr= writeAddr & ((END_FLASH-1) XOR (ERASE_FLASH_BLOCKSIZE-1))

              ' Flash write must start at the beginning of a row
              if writeAddr <> blockStartAddr then
                  FLASH_WriteBlock_K42 = false
                  exit function
              end if
              'Block erase sequence
              FLASH_EraseBlock_K42(writeAddr)

              'Block write sequence
              TBLPTRU = writeAddr_U                               'Load Table point register
              TBLPTRH = writeAddr_H
              TBLPTRL = writeAddr

              'Write block of data
              dim writeloop as byte
              for writeloop = 0 to WRITE_FLASH_BLOCKSIZE-1

                  TABLAT = EEDataBuffer(writeloop) ' Load data byte

                  if writeloop = (WRITE_FLASH_BLOCKSIZE-1) then
                      TBLWT*
                  else
                      TBLWT*+
                  end if
              next

              NVMREG1 = 1
              NVMREG0 = 0
              WREN = 1
              GIE = 0
              NVMCON2 = 0x55
              NVMCON2 = 0xAA
              WR = 1
              NOP     ' NOPs required for latency at high frequencies
              NOP
              NOP
              NOP
              NOP
              wait while WR = 1
              WREN = 0
              GIE = GIEBitValueB

              FLASH_WriteBlock_K42 = true

          end function


      '  Summary
      '    Erases complete Flash program memory block
      '
      '  Description
      '    This routine erases complete Flash program memory block
      '
      '  Preconditions
      '    None
      '
      '  Param
      '    baseAddr - A valid block starting address in Flash program memory
      '
      '  Returns
      '    None
      '
      '  Example
      '    flashBlockStartAddr = 0x7D00
      '
      '    FLASH_EraseBlock_K42(flashBlockStartAddr)

          sub FLASH_EraseBlock_K42( flashAddr as long )

              Dim GIEBitValueE as bit
              GIEBitValueE = GIE        'Save interrupt enable

              Dim flashAddr as Long Alias l_TBLPTR, TBLPTRU, TBLPTRH, TBLPTRL

              NVMREG1 = 1
              NVMREG0 = 0
              WREN = 1
              GIE = 0
              NVMCON2 = 0x55
              NVMCON2 = 0xAA
              WR = 1
              NOP     ' NOPs required for latency at high frequencies
              NOP
              NOP
              NOP
              NOP
              wait while WR = 1
              WREN = 0
              GIE = GIEBitValueE


          end sub


Type2:
'Type #2  type 16f18326...

'16f18326
'sub flashdata1(xx8)
''adr1=address xx8=data
'nvmadrl=adr1
'nvmadrh=adr1_h
'set nvmCON1.NVMREGS off
'set NVMCON1.wren on  ' Enable writes
'set NVMCON1.lwlo on  ' Write Latches
'NVMdatl=xx8
'NVMdath=xx8_h
'set NVMcon1.lwlo off 'write
'SET INTCON.GIE OFF
'NVMcon2=0x55
'NVMcon2=0xAA
'set NVMcon1.wr on
''SET INTCON.GIE ON
'set PMcon1.wren off
'end sub


          function FLASH_ReadWord_Type2( flashAddr as long ) as word

              Dim GIEBitValueR as bit
              GIEBitValueR = GIE        'Save interrupt enable

              NVMADRL = flashAddr
              NVMADRH = flashAddr_h
              NVMREGS = 0               'Deselect Configuration space
              RD = 1                    'Initiate Read
              NOP     ' NOPs required for latency at high frequencies
              NOP
              NOP
              NOP
              NOP
              GIE = GIEBitValueR
              FLASH_ReadWord_Type2   = FLASH_ReadByte_Type2( flashAddr )
              FLASH_ReadWord_Type2_h = FLASH_ReadByte_Type2( [long]flashAddr + 1 )

          end function


          sub FLASH_WriteWord_Type2 ( flashAddr as long,  EEDataByte as word )

              dim blockStartAddr  as Long
              blockStartAddr= writeAddr & ((END_FLASH-1) XOR (ERASE_FLASH_BLOCKSIZE-1))

              Dim EEDataoffset as byte
              EEDataoffset = (flashAddr & (ERASE_FLASH_BLOCKSIZE-1))


             'Entire row will be erased, read and save the existing data
              dim writeloop as byte
              dim currentReadWord as word
              for writeloop = 0 to ERASE_FLASH_BLOCKSIZE-1
                  currentReadWord = FLASH_ReadWord_Type2(blockStartAddr+ writeloop )
                  EEDataBuffer(writeloop) = currentReadWord_h
                  EEDataBuffer(writeloop + 1) = currentReadWord
              next

              'write at offset
              EEDataBuffer( EEDataoffset ) = EEDataByte_h
              EEDataBuffer( EEDataoffset + 1) = EEDataByte

              'Writes ramBuf to current block
              FLASH_WriteBlock_type2( blockStartAddr  )

          end sub

          function FLASH_WriteBlock_Type2( flashAddr as long )

              Dim GIEBitValueW as bit
              GIEBitValueW = GIE        'Save interrupt enable

              dim blockStartAddr  as Long
              blockStartAddr= writeAddr & ((END_FLASH-1) XOR (ERASE_FLASH_BLOCKSIZE-1))

              ' Flash write must start at the beginning of a row
              if writeAddr <> blockStartAddr then
                  FLASH_WriteBlock_Type2 = false
                  exit function
              end if

              GIE = 0
              'Block erase sequence
              FLASH_EraseBlock_Type2(writeAddr)

              'Block write sequence
              NVMREGS = 0         'Deselect Configuration space
              WREN = 1            'Enable wrties
              LWLO = 1            'Only load write latches

              'Write block of data
              dim writeloop as byte
              for writeloop = 0 to WRITE_FLASH_BLOCKSIZE-1

                  'Load lower 8 bits of write address
                  NVMADRL = flashAddr
                  'Load upper 6 bits of write address
                  NVMADRH = flashAddr_h

                  'Load data in current address
                  NVMDATL = EEDataBuffer(writeloop)
                  NVMDATH = EEDataBuffer(writeloop + 1 )

                  if ( writeloop = ( WRITE_FLASH_BLOCKSIZE-1 ) then )
                      'Start Flash program memory write
                      LWLO = 0
                  end if
                  NVMCON2 = 0x55
                  NVMCON2 = 0xAA
                  WR = 1
                  NOP     ' NOPs required for latency at high frequencies
                  NOP
                  NOP
                  NOP
                  NOP
              next

              WREN = 0
              GIE = GIEBitValueW

              FLASH_WriteBlock_Type2 = true
          end function

          sub FLASH_EraseBlock_Type2( flashAddr as long )

              Dim GIEBitValueE as bit
              GIEBitValueE = GIE        'Save interrupt enable
              GIE = 0
              NVMADRL = flashAddr
              NVMADRH = flashAddr_h

              'Block erase sequence
              NVMREGS = 0           'Deselect Configuration space
              FREE = 1              'Specify an erase operation
              WREN = 1              'Allows erase cycle

              'Start of required sequence to initiate erase
              NVMCON2 = 0x55
              NVMCON2 = 0xAA
              WR = 1
              NOP     ' NOPs required for latency at high frequencies
              NOP
              NOP
              NOP
              NOP
              WREN = 0
              GIE = GIEBitValueE

          end sub


Type3:
'
''Type #3
'12f1840 ?? maybe 12f he stated 16f
'sub flashdata
''ADR1=address XX7=data
'eeadrl=ADR1
'eeadrh=ADR1_h
'set EECON1.eepgd on ' Point to flash memory
'set EECON1.cfgs off  ' Not configuration space
'set EECON1.free off 'write
'set EECON1.wren on  ' Enable writes
'set EECON1.lwlo on  ' Write Latches
'eedatl=XX7
'eedath=XX7_h
'set eecon1.lwlo off 'write
'eecon2=0x55
'eecon2=0xAA
'set eecon1.wr on
'nop
'nop
'set eecon1.wren off
'end sub
'
          sub FLASH_WriteByte_Type3 ( flashAddr as long,  EEDataByte as byte )

    EEADRL = flashAddr       'Data Memory Address to write
    EEADRH = flashAddr_h     'Data Memory Address to write

    EEDATL = EEDataByte      'Data Memory Value to write
    EEPGD = 0                'Point to DATA memory
    CFGS = 0                 'Deselect Configuration space
    WREN = 1                 'Enable writes

    Dim GIEBitValue as bit
    GIEBitValue = GIE        'Save interrupt enable
    EECON2 = 0x55
    EECON2 = 0xAA
    WR = 1                    'Set WR bit to begin write
    'Wait for write to complete
    wait while WR = 1
    WREN = 0                  'Disable writes
    GIE = GIEBitValue

          end sub

          sub FLASH_WriteWord_Type3 ( flashAddr as long,  EEDataByte as word )

    dim blockStartAddr  as Long
    blockStartAddr = flashAddr  & ((END_FLASH-1) XOR (ERASE_FLASH_BLOCKSIZE-1))

    Dim EEDataoffset as byte
    EEDataoffset = (flashAddr & (ERASE_FLASH_BLOCKSIZE-1))

    Dim writeloop as byte

    ' Entire row will be erased, read and save the existing data
    for  i=0; i<ERASE_FLASH_BLOCKSIZE; i++)
    {
        ramBuf[i] = FLASH_ReadWord((blockStartAddr+i));
    }


    for writeloop = 0 to ERASE_FLASH_BLOCKSIZE-1
        EEDataBuffer(writeloop) = FLASH_ReadWord((blockStartAddr + writeloop )
    next



    Write at offset
    EEDataBuffer( EEDataoffset ) = EEDataByte
    EEDataBuffer( EEDataoffset+1 ) = EEDataByte_h


    'Writes ramBuf to current block
    FLASH_WriteBlock_type3( blockStartAddr  )

          end sub


          function FLASH_ReadByte_Type3 ( flashAddr as long )

                EEADRL = flashAddr
                CFGS = 0    'Deselect Configuration space
                EEPGD = 0   'Point to DATA memory
                RD = 1      'EE Read
                NOP     ' NOPs required for latency at high frequencies
                NOP
                NOP
                NOP
                NOP
                FLASH_ReadByte_Type3 = EEDATL

          end function

          function FLASH_ReadWord_Type3( flashAddr as long ) as word

              Dim GIEBitValue as bit
              GIEBitValue = GIE        'Save interrupt enable

                EEADRL = flashAddr
                EEADRH = flashAddr_H
                CFGS = 0    'Deselect Configuration space
                EEPGD = 1   'Select Program Memory
                RD = 1      'Initiate Read
                NOP     ' NOPs required for latency at high frequencies
                NOP
                NOP
                NOP
                NOP
                FLASH_ReadWord_Type3   = EEDATL
                FLASH_ReadWord_Type3_H = EEDATH
                GIE = GIEBitValue

          end function

          function FLASH_WriteBlock_Type3( flashAddr as long )

              dim blockStartAddr  as Long
              blockStartAddr= writeAddr & ((END_FLASH-1) XOR (ERASE_FLASH_BLOCKSIZE-1))

              ' Flash write must start at the beginning of a row
              if writeAddr <> blockStartAddr then
                  FLASH_WriteBlock_Type2 = false
                  exit function
              end if

              IntOff
              'Block erase sequence
              FLASH_EraseBlock_Type3(writeAddr)

              'Block write sequence
                = 0         'Deselect Configuration space
              WREN = 1            'Enable wrties
              LWLO = 1            'Only load write latches

              'Write block of data
              dim writeloop as byte
              for writeloop = 0 to WRITE_FLASH_BLOCKSIZE-1

                  'Load lower 8 bits of write address
                  NVMADRL = flashAddr
                  'Load upper 6 bits of write address
                  NVMADRH = flashAddr_h

                  'Load data in current address
                  NVMDATL = EEDataBuffer(writeloop)
                  NVMDATH = EEDataBuffer(writeloop)_h

                  if ( writeloop = ( WRITE_FLASH_BLOCKSIZE-1 ) then )
                      'Start Flash program memory write
                      LWLO = 0
                  end if
                  NVMCON2 = 0x55
                  NVMCON2 = 0xAA
                  WR = 1
                  NOP     ' NOPs required for latency at high frequencies
                  NOP
                  NOP
                  NOP
                  NOP
              next

              WREN = 0
              INTON

              FLASH_WriteBlock_Type2 = true
          end function


          sub FLASH_EraseBlock_Type3( flashAddr as long )

              Dim GIEBitValue as bit
              GIEBitValue = GIE        'Save interrupt enable
              EEADRL = flashAddr
              EEADRH = flashAddr_h

              CFGS = 0              'Deselect Configuration space
              EEPGD = 1             'Specify an erase operation
              FREE = 1              'Specify erase cycle
              WREN = 1              'Allows erase cycles
              NVMCON2 = 0x55
              NVMCON2 = 0xAA
              WR = 1
              NOP     ' NOPs required for latency at high frequencies
              NOP
              NOP
              NOP
              NOP
              WREN = 0
              GIE = GIEBitValue

          end sub


''Type #4
'16f1825
'a1=a1+1
'x1=x1+1
''a1=address x1=data
'eeadrl=a1
'eeadrh=a1_h
'set EECON1.eepgd on ' Point to flash memory
'set EECON1.cfgs off  ' Not configuration space
'set EECON1.free off 'write
'set EECON1.wren on  ' Enable writes
'set EECON1.lwlo on  ' Write Latches
'eedatl=x1
'eedath=x1_h
'set eecon1.lwlo off 'write
'eecon2=0x55
'eecon2=0xAA
'set eecon1.wr on
'nop
'nop
'set eecon1.wren off
'wait 10 ms
          sub FLASH_WriteByte_Type4 ( flashAddr as long,  EEDataByte as byte )

                NVMADRL = flashAddr
                NVMADRH = flashAddr_h
                NVMREGS = 0
                WREN = 1             ' Enable writes
                LWLO = 1             ' Write Latches
                NVMDATL = EEDataByte
                NVMDATH = EEDataByte_h
                LWLO = 0
                INTOFF
                NVMCON2=0x55
                NVMCON2=0xAA
                WR =1
                NOP     ' NOPs required for latency at high frequencies
                NOP
                NOP
                NOP
                NOP
                wait while WR = 1
                WREN = 0
                INTON

          end sub

          function FLASH_ReadByte_Type4 ( flashAddr as long )

                NVMADRL = flashAddr
                NVMADRH = flashAddr_h
                NVMREGS = 0
                WREN = 1             ' Enable writes
                LWLO = 1             ' Write Latches
                NVMDATL = EEDataByte
                NVMDATH = EEDataByte_h
                LWLO = 0
                INTOFF
                NVMCON2=0x55
                NVMCON2=0xAA
                WR =1
                NOP     ' NOPs required for latency at high frequencies
                NOP
                NOP
                NOP
                NOP
                wait while WR = 1
                WREN = 0
                INTON

          end function

          function FLASH_ReadWord_Type4( flashAddr as long ) as word

              FLASH_ReadWord_Type4   = FLASH_ReadByte_Type4( flashAddr )
              FLASH_ReadWord_Type4_h = FLASH_ReadByte_Type4( [long]flashAddr + 1 )

          end function



''Type #5
'18f14k22
'sub flashdata
'tblptru=0
'tblptrl=a1 'load address 22 bit!
'tblptrh=a1_h
'tablat=x1
'tblwt+*
'tablat=x1_h 'load data as separate bytes
'tblwt+*
'tablat=x9
'tblwt+*
'tablat=x9_h 'load data as separate bytes
'tblwt+*
'set EECON1.eepgd on ' Point to flash memory
'set EECON1.cfgs off  ' Not configuration space
'set EECON1.wren on  ' Enable writes
'eecon2=0x55
'eecon2=0xAA
'set eecon1.wr on
'set eecon1.wren off
'
'end sub
          sub FLASH_WriteByte_Type5 ( flashAddr as long,  EEDataByte as byte )

'              Dim GIEBitValue as bit
'              GIEBitValue = GIE        'Save interrupt enable

              dim blockStartAddr  as Long
              blockStartAddr= flashAddr  & ((END_FLASH-1) XOR (ERASE_FLASH_BLOCKSIZE-1))

              Dim EEDataoffset as byte
              EEDataoffset = (flashAddr & (ERASE_FLASH_BLOCKSIZE-1))

              'Entire row will be erased, read and save the existing data
              dim writeloop as byte
              for writeloop = 0 to ERASE_FLASH_BLOCKSIZE-1
                  EEDataBuffer(writeloop) = FLASH_ReadByte_Type( blockStartAddr + writeloop )
              next

              'Load byte at offset
              EEDataBuffer( EEDataoffset ) = EEDataByte

              'Writes buffer contents to current block
              FLASH_WriteBlock_type5(blockStartAddr )

'              GIE = GIEBitValue

          end sub


          function FLASH_WriteBlock_Type5( writeAddr as long )

              dim blockStartAddr  as Long
              blockStartAddr= writeAddr & ((END_FLASH-1) XOR (ERASE_FLASH_BLOCKSIZE-1))

              Dim GIEBitValue as bit
              GIEBitValue = GIE        'Save interrupt enable

              ' Flash write must start at the beginning of a row
              if writeAddr <> blockStartAddr then
                  FLASH_WriteBlock_Type5 = false
                  exit function
              end if

              'Total number of write blocks present in one erase block
              Dim numberOfWriteBlocks as byte
              numberOfWriteBlocks = ERASE_FLASH_BLOCKSIZE/WRITE_FLASH_BLOCKSIZE

              'Block erase sequence
              FLASH_EraseBlock_Type5(writeAddr)

              Dim blockloop as byte
              for blockloop = 0 to numberOfWriteBlocks - 1
                  'Calculate starting offset of Write Block
                  dim WriteBlkOffset as byte
                  WriteBlkOffset = blockloop * WRITE_FLASH_BLOCKSIZE

                  'Block write sequence
                  TBLPTRU = writeAddr_U                               'Load Table point register
                  TBLPTRH = writeAddr_H
                  TBLPTRL = writeAddr

                  dim writeloop as byte
                  for writeloop = 0 to WRITE_FLASH_BLOCKSIZE-1

                      TABLAT = EEDataBuffer( WriteBlkOffset + writeloop) ' Load data byte

                      if writeloop = (WRITE_FLASH_BLOCKSIZE-1) then
                          TBLWT*
                      else
                          TBLWT*+
                      end if
                  next
              next
              WREN = 1
              GIE = 0
              EECON2 = 0x55
              EECON2 = 0xAA
              WR = 1
              NOP     ' NOPs required for latency at high frequencies
              NOP
              NOP
              NOP
              NOP
              wait while WR = 1
              WREN = 0

              FLASH_WriteBlock_type5 = true
              GIE = GIEBitValue

          end function

          sub FLASH_EraseBlock_Type5( flashAddr as long )

              Dim GIEBitValue as bit
              GIEBitValue = GIE        'Save interrupt enable

              TBLPTRU = flashAddr_U
              TBLPTRH = flashAddr_H
              TBLPTRL = flashAddr

              EEPGD = 1
              CFGS = 0
              WREN = 1
              FREE = 1
              GIE = 0
              EECON2 = 0x55
              EECON2 = 0xAA
              WR = 1
              NOP     ' NOPs required for latency at high frequencies
              NOP
              NOP
              NOP
              NOP
              wait while WR = 1
              WREN = 0
              GIE = GIEBitValue

          end sub


          function FLASH_ReadByte_Type5 ( flashAddr as long )

          end function

          function FLASH_ReadWord_Type5( flashAddr as long ) as word

          end function
