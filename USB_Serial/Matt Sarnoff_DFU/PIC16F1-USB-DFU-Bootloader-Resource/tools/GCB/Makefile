CFLAGS = -fstack-protector -fstack-protector-all
# CFLAGS = -O3

hex2dfu_C = hex2dfu.c
hex2dfu_H = 

all: hex2dfu

hex2dfu: Makefile $(hex2dfu_C) $(hex2dfu_H)
	gcc $(hex2dfu_C) -o $@ $(CFLAGS)

clean:
	rm -f hex2dfu hex2dfu.exe
