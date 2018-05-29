@echo **************************
@echo *** Use MinGW compiler ***
@echo **************************
@set PATH=c:\mingw\bin;%PATH%
@set CC=gcc
g++ -o test.o  -c test.cpp
g++ -o USBtest.o -c USBTest.cpp
g++ -static -o test.exe test.o USBTest.o -lusb

