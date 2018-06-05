echo off
Echo Programmer Interface for 16F DFU interface

"32 bit\change.exe" %1 "%temp%\wrtemp.dfu"
"32 bit\dfu-util.exe" -D "%temp%\wrtemp.dfu" -v -R

