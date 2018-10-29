'
' Created by SharpDevelop.
' User: admin
' Date: 01/06/2018
' Time: 20:17
' 
' To change this template use Tools | Options | Coding | Edit Standard Headers.
'
Partial Class MainForm
    Inherits System.Windows.Forms.Form

    ''' <summary>
    ''' Designer variable used to keep track of non-visual components.
    ''' </summary>
    Private components As System.ComponentModel.IContainer

    ''' <summary>
    ''' Disposes resources used by the form.
    ''' </summary>
    ''' <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If components IsNot Nothing Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

    ''' <summary>
    ''' This method is required for Windows Forms designer support.
    ''' Do not change the method contents inside the source code editor. The Forms designer might
    ''' not be able to load this method if it was changed manually.
    ''' </summary>
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(MainForm))
        Me.groupBox1 = New System.Windows.Forms.GroupBox()
        Me.ConnectionStatus = New System.Windows.Forms.Label()
        Me.groupBox2 = New System.Windows.Forms.GroupBox()
        Me.PollADCValues = New System.Windows.Forms.Button()
        Me.ADC3Value = New System.Windows.Forms.TextBox()
        Me.label4 = New System.Windows.Forms.Label()
        Me.ADC2Value = New System.Windows.Forms.TextBox()
        Me.label3 = New System.Windows.Forms.Label()
        Me.ADC1Value = New System.Windows.Forms.TextBox()
        Me.label2 = New System.Windows.Forms.Label()
        Me.ADC0Value = New System.Windows.Forms.TextBox()
        Me.label1 = New System.Windows.Forms.Label()
        Me.groupBox3 = New System.Windows.Forms.GroupBox()
        Me.SetLEDStatus1 = New System.Windows.Forms.CheckBox()
        Me.BlackLED1 = New System.Windows.Forms.PictureBox()
        Me.RedLED1 = New System.Windows.Forms.PictureBox()
        Me.label5 = New System.Windows.Forms.Label()
        Me.textBox1 = New System.Windows.Forms.TextBox()
        Me.VenPidText = New System.Windows.Forms.Label()
        Me.notifyIcon1 = New System.Windows.Forms.NotifyIcon(Me.components)
        Me.SetLEDStatus2 = New System.Windows.Forms.CheckBox()
        Me.BlackLED2 = New System.Windows.Forms.PictureBox()
        Me.GreenLED2 = New System.Windows.Forms.PictureBox()
        Me.groupBox1.SuspendLayout()
        Me.groupBox2.SuspendLayout()
        Me.groupBox3.SuspendLayout()
        CType(Me.BlackLED1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RedLED1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.BlackLED2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.GreenLED2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'groupBox1
        '
        Me.groupBox1.Controls.Add(Me.ConnectionStatus)
        Me.groupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.groupBox1.Location = New System.Drawing.Point(12, 12)
        Me.groupBox1.Name = "groupBox1"
        Me.groupBox1.Size = New System.Drawing.Size(168, 67)
        Me.groupBox1.TabIndex = 6
        Me.groupBox1.TabStop = False
        Me.groupBox1.Text = "Connection Status"
        '
        'ConnectionStatus
        '
        Me.ConnectionStatus.BackColor = System.Drawing.Color.Red
        Me.ConnectionStatus.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.ConnectionStatus.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ConnectionStatus.Location = New System.Drawing.Point(16, 24)
        Me.ConnectionStatus.Name = "ConnectionStatus"
        Me.ConnectionStatus.Size = New System.Drawing.Size(144, 26)
        Me.ConnectionStatus.TabIndex = 0
        Me.ConnectionStatus.Text = "Device not connected"
        Me.ConnectionStatus.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'groupBox2
        '
        Me.groupBox2.Controls.Add(Me.PollADCValues)
        Me.groupBox2.Controls.Add(Me.ADC3Value)
        Me.groupBox2.Controls.Add(Me.label4)
        Me.groupBox2.Controls.Add(Me.ADC2Value)
        Me.groupBox2.Controls.Add(Me.label3)
        Me.groupBox2.Controls.Add(Me.ADC1Value)
        Me.groupBox2.Controls.Add(Me.label2)
        Me.groupBox2.Controls.Add(Me.ADC0Value)
        Me.groupBox2.Controls.Add(Me.label1)
        Me.groupBox2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.groupBox2.Location = New System.Drawing.Point(12, 85)
        Me.groupBox2.Name = "groupBox2"
        Me.groupBox2.Size = New System.Drawing.Size(168, 163)
        Me.groupBox2.TabIndex = 7
        Me.groupBox2.TabStop = False
        Me.groupBox2.Text = "ADC Values"
        '
        'PollADCValues
        '
        Me.PollADCValues.Enabled = False
        Me.PollADCValues.Location = New System.Drawing.Point(22, 129)
        Me.PollADCValues.Name = "PollADCValues"
        Me.PollADCValues.Size = New System.Drawing.Size(128, 24)
        Me.PollADCValues.TabIndex = 9
        Me.PollADCValues.Text = "Read"
        Me.PollADCValues.UseVisualStyleBackColor = True
        '
        'ADC3Value
        '
        Me.ADC3Value.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.ADC3Value.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ADC3Value.Location = New System.Drawing.Point(74, 105)
        Me.ADC3Value.Name = "ADC3Value"
        Me.ADC3Value.ReadOnly = True
        Me.ADC3Value.Size = New System.Drawing.Size(72, 13)
        Me.ADC3Value.TabIndex = 7
        Me.ADC3Value.Text = "0"
        Me.ADC3Value.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        '
        'label4
        '
        Me.label4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.label4.Location = New System.Drawing.Point(19, 105)
        Me.label4.Name = "label4"
        Me.label4.Size = New System.Drawing.Size(100, 15)
        Me.label4.TabIndex = 6
        Me.label4.Text = "ADC 3"
        '
        'ADC2Value
        '
        Me.ADC2Value.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.ADC2Value.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ADC2Value.Location = New System.Drawing.Point(74, 79)
        Me.ADC2Value.Name = "ADC2Value"
        Me.ADC2Value.ReadOnly = True
        Me.ADC2Value.Size = New System.Drawing.Size(72, 13)
        Me.ADC2Value.TabIndex = 5
        Me.ADC2Value.Text = "0"
        Me.ADC2Value.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        '
        'label3
        '
        Me.label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.label3.Location = New System.Drawing.Point(19, 79)
        Me.label3.Name = "label3"
        Me.label3.Size = New System.Drawing.Size(100, 15)
        Me.label3.TabIndex = 4
        Me.label3.Text = "ADC 2"
        '
        'ADC1Value
        '
        Me.ADC1Value.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.ADC1Value.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ADC1Value.Location = New System.Drawing.Point(74, 54)
        Me.ADC1Value.Name = "ADC1Value"
        Me.ADC1Value.ReadOnly = True
        Me.ADC1Value.Size = New System.Drawing.Size(72, 13)
        Me.ADC1Value.TabIndex = 3
        Me.ADC1Value.Text = "0"
        Me.ADC1Value.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        '
        'label2
        '
        Me.label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.label2.Location = New System.Drawing.Point(19, 54)
        Me.label2.Name = "label2"
        Me.label2.Size = New System.Drawing.Size(100, 15)
        Me.label2.TabIndex = 2
        Me.label2.Text = "ADC 1"
        '
        'ADC0Value
        '
        Me.ADC0Value.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.ADC0Value.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ADC0Value.Location = New System.Drawing.Point(74, 28)
        Me.ADC0Value.Name = "ADC0Value"
        Me.ADC0Value.ReadOnly = True
        Me.ADC0Value.Size = New System.Drawing.Size(72, 13)
        Me.ADC0Value.TabIndex = 1
        Me.ADC0Value.Text = "0"
        Me.ADC0Value.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        '
        'label1
        '
        Me.label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.label1.Location = New System.Drawing.Point(19, 28)
        Me.label1.Name = "label1"
        Me.label1.Size = New System.Drawing.Size(100, 15)
        Me.label1.TabIndex = 0
        Me.label1.Text = "ADC 0"
        '
        'groupBox3
        '
        Me.groupBox3.Controls.Add(Me.SetLEDStatus2)
        Me.groupBox3.Controls.Add(Me.BlackLED2)
        Me.groupBox3.Controls.Add(Me.SetLEDStatus1)
        Me.groupBox3.Controls.Add(Me.BlackLED1)
        Me.groupBox3.Controls.Add(Me.RedLED1)
        Me.groupBox3.Controls.Add(Me.GreenLED2)
        Me.groupBox3.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.groupBox3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.groupBox3.Location = New System.Drawing.Point(18, 254)
        Me.groupBox3.Name = "groupBox3"
        Me.groupBox3.Size = New System.Drawing.Size(162, 122)
        Me.groupBox3.TabIndex = 8
        Me.groupBox3.TabStop = False
        Me.groupBox3.Text = "LED Status"
        '
        'SetLEDStatus1
        '
        Me.SetLEDStatus1.Enabled = False
        Me.SetLEDStatus1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.SetLEDStatus1.Location = New System.Drawing.Point(47, 35)
        Me.SetLEDStatus1.Name = "SetLEDStatus1"
        Me.SetLEDStatus1.Size = New System.Drawing.Size(71, 24)
        Me.SetLEDStatus1.TabIndex = 3
        Me.SetLEDStatus1.Text = "Set State"
        Me.SetLEDStatus1.UseVisualStyleBackColor = True
        '
        'BlackLED1
        '
        Me.BlackLED1.Image = CType(resources.GetObject("BlackLED1.Image"), System.Drawing.Image)
        Me.BlackLED1.Location = New System.Drawing.Point(11, 36)
        Me.BlackLED1.Name = "BlackLED1"
        Me.BlackLED1.Size = New System.Drawing.Size(24, 22)
        Me.BlackLED1.TabIndex = 2
        Me.BlackLED1.TabStop = False
        '
        'RedLED1
        '
        Me.RedLED1.Image = CType(resources.GetObject("RedLED1.Image"), System.Drawing.Image)
        Me.RedLED1.Location = New System.Drawing.Point(11, 36)
        Me.RedLED1.Name = "RedLED1"
        Me.RedLED1.Size = New System.Drawing.Size(24, 22)
        Me.RedLED1.TabIndex = 1
        Me.RedLED1.TabStop = False
        Me.RedLED1.Visible = False
        '
        'label5
        '
        Me.label5.Location = New System.Drawing.Point(319, 379)
        Me.label5.Name = "label5"
        Me.label5.Size = New System.Drawing.Size(72, 19)
        Me.label5.TabIndex = 9
        Me.label5.Text = "v1.4.1"
        Me.label5.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'textBox1
        '
        Me.textBox1.Location = New System.Drawing.Point(188, 17)
        Me.textBox1.Multiline = True
        Me.textBox1.Name = "textBox1"
        Me.textBox1.ReadOnly = True
        Me.textBox1.Size = New System.Drawing.Size(203, 359)
        Me.textBox1.TabIndex = 10
        Me.textBox1.Text = resources.GetString("textBox1.Text")
        '
        'VenPidText
        '
        Me.VenPidText.Location = New System.Drawing.Point(15, 379)
        Me.VenPidText.Name = "VenPidText"
        Me.VenPidText.Size = New System.Drawing.Size(274, 19)
        Me.VenPidText.TabIndex = 9
        Me.VenPidText.Text = "Initialising ..."
        Me.VenPidText.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'notifyIcon1
        '
        Me.notifyIcon1.Text = "notifyIcon1"
        Me.notifyIcon1.Visible = True
        '
        'SetLEDStatus2
        '
        Me.SetLEDStatus2.Enabled = False
        Me.SetLEDStatus2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.SetLEDStatus2.Location = New System.Drawing.Point(47, 81)
        Me.SetLEDStatus2.Name = "SetLEDStatus2"
        Me.SetLEDStatus2.Size = New System.Drawing.Size(71, 24)
        Me.SetLEDStatus2.TabIndex = 5
        Me.SetLEDStatus2.Text = "Set State"
        Me.SetLEDStatus2.UseVisualStyleBackColor = True
        '
        'BlackLED2
        '
        Me.BlackLED2.Image = CType(resources.GetObject("BlackLED2.Image"), System.Drawing.Image)
        Me.BlackLED2.Location = New System.Drawing.Point(11, 81)
        Me.BlackLED2.Name = "BlackLED2"
        Me.BlackLED2.Size = New System.Drawing.Size(24, 22)
        Me.BlackLED2.TabIndex = 4
        Me.BlackLED2.TabStop = False
        '
        'GreenLED2
        '
        Me.GreenLED2.Image = CType(resources.GetObject("GreenLED2.Image"), System.Drawing.Image)
        Me.GreenLED2.Location = New System.Drawing.Point(11, 81)
        Me.GreenLED2.Name = "GreenLED2"
        Me.GreenLED2.Size = New System.Drawing.Size(24, 22)
        Me.GreenLED2.TabIndex = 6
        Me.GreenLED2.TabStop = False
        '
        'MainForm
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(407, 407)
        Me.Controls.Add(Me.textBox1)
        Me.Controls.Add(Me.VenPidText)
        Me.Controls.Add(Me.label5)
        Me.Controls.Add(Me.groupBox3)
        Me.Controls.Add(Me.groupBox2)
        Me.Controls.Add(Me.groupBox1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.Name = "MainForm"
        Me.Text = "USB Utility (LibK/WinUSB) -  Great Cow BASIC"
        Me.groupBox1.ResumeLayout(False)
        Me.groupBox2.ResumeLayout(False)
        Me.groupBox2.PerformLayout()
        Me.groupBox3.ResumeLayout(False)
        CType(Me.BlackLED1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RedLED1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.BlackLED2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.GreenLED2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Private BlackLED1 As System.Windows.Forms.PictureBox
    Private RedLED1 As System.Windows.Forms.PictureBox
    Private notifyIcon1 As System.Windows.Forms.NotifyIcon
    Private VenPidText As System.Windows.Forms.Label
    Private textBox1 As System.Windows.Forms.TextBox
    Private ConnectionStatus As System.Windows.Forms.Label
    Private label5 As System.Windows.Forms.Label
    Private groupBox3 As System.Windows.Forms.GroupBox
    Private label2 As System.Windows.Forms.Label
    Private ADC1Value As System.Windows.Forms.TextBox
    Private label3 As System.Windows.Forms.Label
    Private ADC2Value As System.Windows.Forms.TextBox
    Private label4 As System.Windows.Forms.Label
    Private ADC3Value As System.Windows.Forms.TextBox
    Private label1 As System.Windows.Forms.Label
    Private ADC0Value As System.Windows.Forms.TextBox
    Private groupBox2 As System.Windows.Forms.GroupBox
    Private groupBox1 As System.Windows.Forms.GroupBox
    Private WithEvents PollADCValues As Button
    Private WithEvents SetLEDStatus1 As CheckBox
    Private WithEvents GreenLED2 As PictureBox
    Private WithEvents SetLEDStatus2 As CheckBox
    Private WithEvents BlackLED2 As PictureBox
End Class
