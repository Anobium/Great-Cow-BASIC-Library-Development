XPRESS-Loader
=============

USB-MSD Programmer and CDC Serial Port Emulator
-----------------------------------------------

This application is designed to act as a fast on-board programmer for the MPLAB
Xpress Evaluation Board.

A serial to USB bridge function is simultaneously available.

Additional information about the MPLAB Xpress project can be found at
[https://mplabxpress.microchip.com](<https://mplabxpress.microchip.com>)

License
-------

This application is licensed under the Apache v2 license (see "LICENSE" file in
root directory of the repository). To request to license this code under the MLA
license (www.microchip.com/mla\_license), please contact
mla\_licensing\@microchip.com.

Product Support
---------------

-   This application runs on the PIC18LF25K50 and programs/interfaces to the
    PIC16F18855.

-   The input (file) parsing algorithm is compatible with all PIC16/PIC18 INTEL
    Hex files produced by the MPLAB XC8 compiler.

-   The programming algorithm is currently supporting only the new 8-bit
    LVP-ICSP protocol common to the PIC16F188xx (5 digit) devices. It is also
    assuming a fixed row size of 32 words.

-   The default serial interface does not support hardware handshake although
    this feature can be enabled if required.

Folder Structure
----------------

-   *MPLAB.X* - contains the main application source files

-   *framework* - elements of the MLA - USB and File System open source
    libraries (note: the MSD portion has been customised to reduce considerably
    RAM usage)

-   *utilities* - contains the Windows signed drivers for the Virtual COM port
    (OS X and Linux users do not need it)

-   *bsp* - board support package (currently only the XPRESS evaluation board)

 
