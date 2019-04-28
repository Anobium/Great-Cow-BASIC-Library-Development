Status. ENC is operational at the PHY layer and  raw packets are bring received.

Start in the \Standalone Programs directory. Complete the four tests. These do not require the library.  I want to make use the simple stuff works first.



File\Directories.

\.h the library
\16f1939
	\*005 file.  Current status of testing. Shown above.

	\Standalone Programs\

		001  - Test the wiring this is worth doing
		002  - Test the connectivity with analyser, if you have one
		003  - Test end to end using standard SPI - results are LEDS on ENC become operational.
		004  - Test end to end using Fast SPI - again, results are LEDS on ENC become operational.


Marc:
18F4520, 20
001 = Pass
002 = Pass
003 = Pass
004 = Failed. Wont initialise with Fast SPI.
004 = Pass - Missing "SPIRxData = SSPBUF" from Sub FastHWSPITransfer (hwspi.h)


