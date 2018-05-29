#Make test program for GCBASIC USB Test
all: test.o USBTest.o
	g++ -static -o test.exe test.o USBTest.o -lusb

test.o: test.cpp USBTest.h
	g++ -o test.o -c test.cpp
	
USBTest.o: USBTest.cpp USBTest.h
	g++ -o USBTest.o -c USBTest.cpp
	
clean:
	rm -rf *.o
	rm -f test.exe
	