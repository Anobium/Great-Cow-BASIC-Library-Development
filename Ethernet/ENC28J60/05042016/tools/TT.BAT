FOR /L %%G IN (1,1,65535) DO (
	ECHO %%G
	ECHOTOOL 192.168.0.1 /p UDP /n 1 /d %%G /t 1
)
