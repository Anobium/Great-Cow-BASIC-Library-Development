'
' Created by SharpDevelop.
' User: admin
' Date: 01/06/2018
' Time: 20:16
' 
' To change this template use Tools | Options | Coding | Edit Standard Headers.
'
Imports LibUsbDotNet
Imports LibUsbDotNet.Main
Imports LibUsbDotNet.DeviceNotify
Imports System.Runtime.InteropServices
Imports System.Timers
Imports System.Reflection
Imports System.Media






Public Partial Class MainForm
	
	

	Public Const GCBBitOn			 = 1
	Public Const GCBBitOff			 = 0
	
	'Allocated VID and PID to this type of Great Cow BASIC solution
	public const USB_VID                            = &H1209
	Public Const USB_PID 							= &H2006
	'Solution Specific - Can be edited
	Public Const USB_REV 							= &H0000
	
	public const GCBDeviceReadPortb5LEDStatus  	    = 130
	Public Const GCBDeviceSetPortb5StatusOn 		= 131
	Public Const GCBDeviceSetPortb5StatusOff 		= 132
	Public Const GCBDeviceReadADCValues     		= 133	
	
	
	
	
	'Application Support- DO NOT CHANGE
	
	Public Const GCBDeviceKeepAlive  = 255
	'Set up USB change event to handle disconnections etc
	Public Shared UsbDeviceNotifier As IDeviceNotifier = DeviceNotifier.OpenDeviceNotifier()
	'Set up objects and variables we need - do not change
	Public Dim Device As UsbDevice
	Private _timer As Timer
	Shared KeepAliveCounter As Integer
	Shared KeepAliveError As Boolean
	Shared GetStatusfromDeviceUponInit As Boolean
	Shared tempvalue As Byte
	
	'Set up a variable used to track the user interface
	Shared orginalLabel5Text As String
	
	
    Delegate Sub InvokeDelegate()

    Public Sub New()
		' The Me.InitializeComponent call is required for Windows Forms designer support.
		Me.InitializeComponent()
		ConnectionStatus.Select
		
		'Store the orignal UI value - we update later
		orginalLabel5Text = label5.Text	
		
		'Flag to track status of reading the status of the LED when init/reinit of applicatiom
		GetStatusfromDeviceUponInit = True

		'Find USB device
		FindUSBDevice()
		
		' Hook the device notifier event - do not remove
        AddHandler UsbDeviceNotifier.OnDeviceNotify, AddressOf OnUSBDeviceEventRaised

		
        'init the timer - this one 1s manages the KeepAlive - do not remove
	        _timer = New System.Timers.Timer()
	        _timer.Interval = 1000
	        AddHandler _timer.Elapsed, AddressOf OneSecondTimerHandler
	        ' Have the timer fire repeated events (true is the default)
	        _timer.AutoReset = True
	        _timer.Enabled = True		
			KeepAliveCounter = 0
		'end of the KeepAlive handler
		
	End Sub
	
	
	
	'User Interaceface methods
	
	
    Public Sub UpdateFormWithLatestData_UserSolution()
    	
    	try
		        'Update  application
		        If Not Device Is Nothing Then
		            ConnectionStatus.Text = "Device connected"
		            
		            'Update the UI 
		            ConnectionStatus.BackColor = System.Drawing.SystemColors.Control
		            ConnectionStatus.BorderStyle = System.Windows.Forms.BorderStyle.None
		            
		            'If we are init or reinit USB channel so get the LED state from the USB
		            If GetStatusfromDeviceUponInit = True Then
		            	'We need the remove board to be settled. 1s should be enough.
		            	Delay(1)
				        'Get the LED status port.5
				        SetLEDStatus.Checked = ReadDeviceBitStatus_UserSolution ( GCBDeviceReadPortb5LEDStatus )
				        If SetLEDStatus.Checked = True Then
				        	RedLED.Visible=True
				        	BlackLED.Visible=False
				        Else
				        	RedLED.Visible=false
				        	BlackLED.Visible=true
				        End if
				        GetStatusfromDeviceUponInit = False
		            End If           
		            'Update some text
		            VenPidText.Text= Device.Info.ProductString'
		            'Update the timeout string
		            label5.Text=StrDup( KeepAliveCounter , ".")+orginalLabel5Text
		            'Enable the UI
			        PollADCValues.Enabled=True
			        SetLEDStatus.Enabled=True
			        
		        Else
		        	
		            ConnectionStatus.Text = "Device not connected"
		            'Red
		            ConnectionStatus.BackColor = System.Drawing.Color.Red
		            ConnectionStatus.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		            VenPidText.Text=""
		            'Disable the UI
		            PollADCValues.Enabled=False
		            SetLEDStatus.Enabled=False
		            ConnectionStatus.Select
		        End If
    	Catch
    			'exit gracefully
    	End Try
    	
    	'Anyway we have updated the form!!!

    End Sub 'UpdateFormWithLatestData
    
	
	'Poll ADC button was clicked, read ADC values
	Sub PollADCValuesClick_UserSolution(sender As Object, e As EventArgs)
		Dim Reply As Byte()
		'Send request GCBDeviceReadADCValues, which means read ADC to PIC. Read 8 bytes back.
		Reply = ReadReplyData(GCBDeviceReadADCValues, 8)
		If Not Reply Is Nothing Then
			'If there is a reply, display
			If Reply.Length >= 2 Then
				ADC0Value.Text = (Reply(1) * 256 + Reply(0)).ToString
			End If
			If Reply.Length >= 4 Then
				ADC1Value.Text = (Reply(3) * 256 + Reply(2)).ToString
			End If
			If Reply.Length >= 6 Then
				ADC2Value.Text = (Reply(5) * 256 + Reply(4)).ToString
			End If
			If Reply.Length >= 8 Then
				ADC3Value.Text = (Reply(7) * 256 + Reply(6)).ToString
			End If
		End If
	End Sub
	
	'Status of the check changed, send command to turn bit on or off
	Sub SetDeviceStatusCheckedChangedHighOn_UserSolution(sender As Object, e As EventArgs)
		If SetLEDStatus.Checked Then
			'To turn on, test program on PIC expects request GCBDeviceSetPortb5StatusOn
			SendCommand( GCBDeviceSetPortb5StatusOn , GCBBitOn )
			RedLED.Visible=True
			BlackLED.Visible=False

		Else
			'To turn off, test program on PIC expects request GCBDeviceSetPortb5StatusOff
			SendCommand( GCBDeviceSetPortb5StatusOff , GCBBitOff )
			RedLED.Visible=False
			BlackLED.Visible=true
		End If
	End Sub
	
	'Read the status of the LED and return the value
	Function ReadDeviceBitStatus_UserSolution( USBDeviceRequestID As Byte ) As Boolean
		
		Dim Reply As Byte()
		
		'Send USBDeviceRequestID. Read 1 byte back.
		Reply = ReadReplyData(USBDeviceRequestID, 1)
		If Not Reply Is Nothing Then
			'If there is a reply 
			If Reply(0) = 1 Then 
				
				Return True
				
			End If
		End If
		
		Return False
		
	End Function
	
	'Everything after this should not be changed.
	
    'Utility functions
    'Find the USB device - do not change
    Function FindUSBDevice As Boolean

        'Find device
        Dim Finder As New UsbDeviceFinder( USB_VID, USB_PID, USB_REV  )
        
        try
        	Device = UsbDevice.OpenUsbDevice(Finder)
        Catch
        	Device = Nothing
        End try
        	
		If Not Device Is Nothing Then
			GetStatusfromDeviceUponInit = True
		End If
		
        Return Not Device Is Nothing
    End Function
    
    'Send a command (control transfer) to the device, no reply expected - do not change
    Sub SendCommand(Request As Byte, Param As Short)

        _timer.Interval = 10000

        'Check for device
        If Device Is Nothing Then Exit Sub
        
        Try
		        'Create setup packet
		        'First parameter is RequestType, see LibUsbDotNet documentation for bit usage
		        '66 meansn:
		        '          Data direction is host to device
		        '          Request type is vendor defined (ie, by us)
		        '          Packet is sent to the whole device, not a specific endpoint
		        'This should be suitable for any cases when data is being sent to the PIC.
		        Dim SetupPacket As New UsbSetupPacket(66, Request, Param, 0, 0)
				'Dummy variables for data to send (none in this case)
				Dim InBuffer(1024) As Byte
				Dim inCount As Integer = 0
				'Send command
				Device.ControlTransfer(SetupPacket, InBuffer, 1000, inCount)
        Catch
        		'exit gracefully	
        End Try

		KeepAliveCounter = 0
        _timer.Interval = 1000
        _timer.Enabled = True
		
	End Sub
	
	'Send a control transfer and get data from device - do not change
	Function ReadReplyData(Request As Byte, ReplySize As Short) As Byte()

        _timer.Interval = 10000

        'Check for device
        If Device Is Nothing Then Return Nothing

        'Create setup packet
        'First parameter is RequestType, see LibUsbDotNet documentation for bit usage
        '194 means:
        '          Data direction is device to host
        '          Request type is vendor defined (ie, by us)
        '          Packet is sent to the whole device, not a specific endpoint
        'This should be suitable for any cases when data is being read from the PIC.
        'Last parameter is the number of bytes to request back - device may ignore.
        Dim SetupPacket As New UsbSetupPacket(194, Request, 0, 0, ReplySize)
		'Prepare buffers for incoming data
		Dim InBuffer(1024) As Byte
		Dim copyLoc As Integer
		Dim inCount As Integer
		
		try
			'Start control transfer
			Device.ControlTransfer(SetupPacket, InBuffer, ReplySize, inCount)
		Catch
			
		End try
		'Create an appropriately sized output array, fill with the data
		Dim OutBuffer(inCount) As Byte
		For copyLoc = 0 To inCount - 1
			OutBuffer(copyLoc) = InBuffer(copyLoc)
		Next
		
		KeepAliveCounter = 0
        'Set the 1s timer
        _timer.Interval = 1000
        _timer.Enabled = True

        Return OutBuffer
	End Function
	
	
	'KeepAlive Check Send the constant GCBDeviceKeepAlive and expect GCBDeviceKeepAlive back - do not change
	Sub PollKeepAlive()
		Dim Reply As Byte()
		KeepAliveError = False
		'Send request GCBDeviceKeepAlive, which means KEEPALIVE. Read 1 byte back.
		Reply = ReadReplyData(GCBDeviceKeepAlive, 1)
		tempvalue = Reply(0)
		
		If Not Reply Is Nothing Then
			'If there is a reply 
			If Reply(0) <> GCBDeviceKeepAlive Then
				KeepAliveError = True
				Device.Close
				Device = Nothing
				
			End If
		End If
	End Sub
	
	
	'On close of main form, close USB device - do not change
	Sub MainFormFormClosed(sender As Object, e As FormClosedEventArgs)
		'Close USB device if one was opened
		If Not Device Is Nothing Then
			Device.Close
		End If
		
		Try 
			' Disable the device notifier
			UsbDeviceNotifier.Enabled = False
			' Unhook the device notifier event
			RemoveHandler UsbDeviceNotifier.OnDeviceNotify, AddressOf OnUSBDeviceEventRaised
		Catch
			'exit gracefully
		End try
		
	End Sub
	
	'Event methods
	' USB event - do not change
    Sub OnUSBDeviceEventRaised(sender As Object, e As DeviceNotifyEventArgs)
    	' A Device system-level event has occured
    	
    	Try 
    	  If ( e.Device.IdProduct = USB_PID ) And ( e.Device.IdVendor = USB_VID ) Then
    		
    		If ( e.EventType = &H8004 ) Then 
    			
				If Not Device Is Nothing Then
					Device.Close
					Device = Nothing
				End If
    			ConnectionStatus.BeginInvoke(New InvokeDelegate(AddressOf UpdateFormWithLatestData_UserSolution))
    			
    		End If    
    	  End If
    	Catch
    		'exit gracefully
    	End Try	
    	
    End Sub
    	
	'Timer functions  - do not change
	
	Public Sub OneSecondTimerHandler(ByVal sender As Object, ByVal e As ElapsedEventArgs)
		
		
		try
			_timer.Enabled = False
	
	        If Device Is Nothing Then
	            'Find USB device
	            FindUSBDevice()
	            'time out the keepalive
	      		KeepAliveCounter = 9
	        End If
	
			If Not Device Is Nothing Then
				'every 10 seconds poll the device
				If KeepAliveCounter = 9 then
					PollKeepAlive()
					KeepAliveCounter = 0
				Else
					KeepAliveCounter = KeepAliveCounter + 1
				End If
			Else
				'Will keep re-trying keep alive, only if, the USB is active.
				KeepAliveCounter = 9
			End If
		
			_timer.Interval = 1000
	        _timer.Enabled = True
	        ConnectionStatus.BeginInvoke(New InvokeDelegate(AddressOf UpdateFormWithLatestData_UserSolution))
		Finally
			'exit gracefully
		End Try
	
	End Sub
	
	
    Private Sub Delay(ByVal DelayInSeconds As Integer)
        Dim ts As TimeSpan
        Dim targetTime As DateTime = DateTime.Now.AddSeconds(DelayInSeconds)
        Do
            ts = targetTime.Subtract(DateTime.Now)
            Application.DoEvents() ' keep app responsive
            System.Threading.Thread.Sleep(50) ' reduce CPU usage
        Loop While ts.TotalSeconds > 0
    End Sub
		
End Class

