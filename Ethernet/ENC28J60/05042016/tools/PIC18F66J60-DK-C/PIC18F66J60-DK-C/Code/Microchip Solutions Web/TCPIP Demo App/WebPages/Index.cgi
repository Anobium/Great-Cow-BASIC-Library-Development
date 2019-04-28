<html>
	<body>
		<b>Microchip TCP/IP Stack</b><br>
		Stack version: %16<br>
		Build date: %17<br>
		<br>
		<form method="get" action="0">
			<b>Actions</b><br>
			Toggle LEDs:<br>
			<input type="submit" name="1" value="LED2"></input>
			<input type="submit" name="0" value="LED1"></input>
		</form>
		<form method="get" action="1">
			Write to LCD:
			<input type="text" name="3" size="16"></input>
			<input type="submit" value="Write"></input>
		</form><br>
		<b>Status</b><br>
		Pot0: %02<br>
		Buttons: %0F %0E %0D %04<br>
		LEDs: %15 %14 %13 %12 %11 %10 %01 %00<br>
	</body>
</html>