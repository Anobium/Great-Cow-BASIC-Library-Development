This solution is focused on the 16f145x family.  

Background: An ASM development has completed a robust DFU implementation for the 16f145x family.  
This DFU implementation is a bootloader use case and it is relatively simple to use.

Software:

1.	Copy the required DFU utilites to the DFU folder from the ZIP file.  
	Typically needs to be  ..\GCB@SYN\DFU folder.   
	Copies other important files – copy them all.
	
2.	From within Great Cow BASIC IDE/PP Tool add a new programmer to support the DFU.  

	GCBASIC Tools --> Edit Programmer Preferences
	ADD...
	Name: UFD
	Use If: <blank>
	File: %instdir%\..\DFU\HEX2DFU.exe
	Required Config: <blank>
	Command Line Parameters: "%filename%"
	Port: <blank>
	Working Directory: %instdir%\..\DFU
	
	Click OK and Drag DFU to the Top.

Hardware:
3.	Two buttons are Required to operate the DFU bootloader and an LED is a useful indication of the state.

		Connect a Push Button switch to RC5, with a 10K pull up resistor, to act as the PROG button.
		Connect a Push Button switch to RA3, with a 10K pull up resistor, to act as the Mclr button.
		Connect an LED from RA5 to ground via a 1K resistor.
		Ensure you have a .47uF cap from Vusb to Ground.
	Note:
		The 16(l)f145x devices have USB connected to the usual ICSP pins, RA0 is used as D+ and RA1 is D-,
		For Programming you will need to use RC0 as PGC and RC1 as PGD instead.
	
4.	See the ZIP for the hex file 16f145x bootloader_ProgC5_ResetA3.hex.  
	This has a valid VID/ID using the Microchip DFU address as a Microchip External Memory Programmer.  

	USB_VENDOR_ID		equ	0x1209
	USB_PRODUCT_ID		equ	0x2002
	
	Using PK+ Open the HEX file and program the device.
	If the device is not found, refer to the note above.
		
5.	Attach the board/chip and hold down RC5 and press Reset.   
	The board/chip will activate the USB.  
	An LED attached to PortA.5 will glow at mid brightness. 
	The board/chip will attempt to enumerate with the USB Host.
	If the driver is not found:
		Open the device manager and look for the ‘not be recognised’ device and - Update the driver.  
		The driver is in the  ..\GCB@SYN\DFU\Driver folder (as per step one).  
		
USE:
6.	In Great Cow BASIC IDE.  
	Create programs as normal.  
	The header MUST have #option bootloader 0x200 to ensure the DFU bootloader is protected.

; ----- Configuration
  #chip 16f1459,48	     ' The 16(l)f145x in use - 48 MUST BE SPECIFIED
  #option bootloader 0x200   ' must for usb Bootloader
  #option NoConfig           ' Tells compiler not to set config bits
  #option explicit           ' All variables must be declared!

	16F1459Test.GCB is included in the c:\gcb@syn folder.

	Press and Hold PROG/RC5 button then Press and release Mclr whilst PROG is held.
	Release Prog and the bootloader is active.
	
7.	If you have DFU as the default programmer (See 2. above) Click HEX/Flash or Press F5.
	This will program from the IDE using the DFU defined in PP Tool.
	Press and Release Mclr.
	If all worked well LED RA5 will be flashing.

So, in summary  - program as normal. 
	Hold PROG and Reset the part to activate the bootloader, flash your program and then Reset again to run.

Evan/Chris




