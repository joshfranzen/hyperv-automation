<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#region begin GUI{ 

$HyperVToolv1                    = New-Object system.Windows.Forms.Form
$HyperVToolv1.ClientSize         = '555,654'
$HyperVToolv1.text               = "Hyper-V Automation Tool v0.2"
$HyperVToolv1.BackColor          = "#ffffff"
$HyperVToolv1.TopMost            = $false

$VMNAME_PANEL                    = New-Object system.Windows.Forms.Panel
$VMNAME_PANEL.height             = 43
$VMNAME_PANEL.width              = 553
$VMNAME_PANEL.BackColor          = "#59288d"
$VMNAME_PANEL.location           = New-Object System.Drawing.Point(2,1)

$VMNAME_LABEL                    = New-Object system.Windows.Forms.Label
$VMNAME_LABEL.text               = "VM Name"
$VMNAME_LABEL.AutoSize           = $true
$VMNAME_LABEL.width              = 25
$VMNAME_LABEL.height             = 10
$VMNAME_LABEL.location           = New-Object System.Drawing.Point(23,16)
$VMNAME_LABEL.Font               = 'Arial Rounded MT,14'
$VMNAME_LABEL.ForeColor          = "#ffffff"

$CPU_PANEL                       = New-Object system.Windows.Forms.Panel
$CPU_PANEL.height                = 43
$CPU_PANEL.width                 = 275
$CPU_PANEL.BackColor             = "#59288d"
$CPU_PANEL.location              = New-Object System.Drawing.Point(1,105)

$NETWORK_PANEL                   = New-Object system.Windows.Forms.Panel
$NETWORK_PANEL.height            = 43
$NETWORK_PANEL.width             = 553
$NETWORK_PANEL.BackColor         = "#59288d"
$NETWORK_PANEL.location          = New-Object System.Drawing.Point(2,208)

$RAM_PANEL                       = New-Object system.Windows.Forms.Panel
$RAM_PANEL.height                = 43
$RAM_PANEL.width                 = 275
$RAM_PANEL.BackColor             = "#59288d"
$RAM_PANEL.location              = New-Object System.Drawing.Point(280,105)

$OS_PANEL                        = New-Object system.Windows.Forms.Panel
$OS_PANEL.height                 = 43
$OS_PANEL.width                  = 553
$OS_PANEL.BackColor              = "#59288d"
$OS_PANEL.location               = New-Object System.Drawing.Point(3,313)

$STORAGE_PANEL                   = New-Object system.Windows.Forms.Panel
$STORAGE_PANEL.height            = 43
$STORAGE_PANEL.width             = 553
$STORAGE_PANEL.BackColor         = "#59288d"
$STORAGE_PANEL.location          = New-Object System.Drawing.Point(2,422)

$CPU_LABEL                       = New-Object system.Windows.Forms.Label
$CPU_LABEL.text                  = "CPU Cores"
$CPU_LABEL.AutoSize              = $true
$CPU_LABEL.width                 = 25
$CPU_LABEL.height                = 10
$CPU_LABEL.location              = New-Object System.Drawing.Point(24,15)
$CPU_LABEL.Font                  = 'Arial Rounded MT,14'
$CPU_LABEL.ForeColor             = "#ffffff"

$RAM_LABEL                       = New-Object system.Windows.Forms.Label
$RAM_LABEL.text                  = "RAM (in GB)"
$RAM_LABEL.AutoSize              = $true
$RAM_LABEL.width                 = 25
$RAM_LABEL.height                = 10
$RAM_LABEL.location              = New-Object System.Drawing.Point(22,15)
$RAM_LABEL.Font                  = 'Arial Rounded MT,14'
$RAM_LABEL.ForeColor             = "#ffffff"

$NETWORK_LABEL                   = New-Object system.Windows.Forms.Label
$NETWORK_LABEL.text              = "Network Location"
$NETWORK_LABEL.AutoSize          = $true
$NETWORK_LABEL.width             = 25
$NETWORK_LABEL.height            = 10
$NETWORK_LABEL.location          = New-Object System.Drawing.Point(21,15)
$NETWORK_LABEL.Font              = 'Arial Rounded MT,14'
$NETWORK_LABEL.ForeColor         = "#ffffff"

$OS_LABEL                        = New-Object system.Windows.Forms.Label
$OS_LABEL.text                   = "Operating System"
$OS_LABEL.AutoSize               = $true
$OS_LABEL.width                  = 25
$OS_LABEL.height                 = 10
$OS_LABEL.location               = New-Object System.Drawing.Point(20,16)
$OS_LABEL.Font                   = 'Arial Rounded MT,14'
$OS_LABEL.ForeColor              = "#ffffff"

$STORAGE_LABEL                   = New-Object system.Windows.Forms.Label
$STORAGE_LABEL.text              = "Storage"
$STORAGE_LABEL.AutoSize          = $true
$STORAGE_LABEL.width             = 25
$STORAGE_LABEL.height            = 10
$STORAGE_LABEL.location          = New-Object System.Drawing.Point(22,16)
$STORAGE_LABEL.Font              = 'Arial Rounded MT,14'
$STORAGE_LABEL.ForeColor         = "#ffffff"

$VMNAME_VALUE                    = New-Object system.Windows.Forms.TextBox
$VMNAME_VALUE.multiline          = $false
$VMNAME_VALUE.Text               = "VM Name"
$VMNAME_VALUE.width              = 100
$VMNAME_VALUE.height             = 20
$VMNAME_VALUE.location           = New-Object System.Drawing.Point(36,61)
$VMNAME_VALUE.Font               = 'Microsoft Sans Serif,14'

$CPU_VALUE                       = New-Object system.Windows.Forms.TextBox
$CPU_VALUE.multiline             = $false
$CPU_VALUE.width                 = 100
$CPU_VALUE.height                = 20
$CPU_VALUE.location              = New-Object System.Drawing.Point(36,165)
$CPU_VALUE.Font                  = 'Microsoft Sans Serif,14'

$RAM_VALUE                       = New-Object system.Windows.Forms.TextBox
$RAM_VALUE.multiline             = $false
$RAM_VALUE.width                 = 100
$RAM_VALUE.height                = 20
$RAM_VALUE.location              = New-Object System.Drawing.Point(312,165)
$RAM_VALUE.Font                  = 'Microsoft Sans Serif,14'

$SUBNET_VALUE                    = New-Object system.Windows.Forms.ComboBox
$SUBNET_VALUE.text               = "comboBox"
$SUBNET_VALUE.width              = 210
$SUBNET_VALUE.height             = 20
@('Earth','Noveria','Tachunka','Palaven','Geth') | ForEach-Object {[void] $SUBNET_VALUE.Items.Add($_)}
$SUBNET_VALUE.location           = New-Object System.Drawing.Point(36,270)
$SUBNET_VALUE.Font               = 'Microsoft Sans Serif,14'

$OS_VALUE                        = New-Object system.Windows.Forms.ComboBox
$OS_VALUE.text                   = "comboBox"
$OS_VALUE.width                  = 210
$OS_VALUE.height                 = 20
@('Windows 7 Enterprise','Windows 10 Enterprise','Windows Server 2012 R2','Windows Server 2016') | ForEach-Object {[void] $OS_VALUE.Items.Add($_)}
$OS_VALUE.location               = New-Object System.Drawing.Point(36,378)
$OS_VALUE.Font                   = 'Microsoft Sans Serif,14'

$BUILD_BUTTON                    = New-Object system.Windows.Forms.Button
$BUILD_BUTTON.BackColor          = "#59288d"
$BUILD_BUTTON.text               = "Build"
$BUILD_BUTTON.width              = 86
$BUILD_BUTTON.height             = 40
$BUILD_BUTTON.location           = New-Object System.Drawing.Point(421,589)
$BUILD_BUTTON.Font               = 'Arial Rounded MT,14'
$BUILD_BUTTON.ForeColor          = "#ffffff"

$HyperVToolv1.controls.AddRange(@($VMNAME_PANEL,$CPU_PANEL,$NETWORK_PANEL,$RAM_PANEL,$OS_PANEL,$STORAGE_PANEL,$VMNAME_VALUE,$CPU_VALUE,$RAM_VALUE,$SUBNET_VALUE,$OS_VALUE,$BUILD_BUTTON))
$VMNAME_PANEL.controls.AddRange(@($VMNAME_LABEL))
$CPU_PANEL.controls.AddRange(@($CPU_LABEL))
$RAM_PANEL.controls.AddRange(@($RAM_LABEL))
$NETWORK_PANEL.controls.AddRange(@($NETWORK_LABEL))
$OS_PANEL.controls.AddRange(@($OS_LABEL))
$STORAGE_PANEL.controls.AddRange(@($STORAGE_LABEL))

#region gui events {
$BUILD_BUTTON.Add_Click({ BUILD_VM })
#endregion events }

#endregion GUI }


#Write your logic code here

function BUILD_VM {

if ($Subnet_Value.Text -like "*Palaven*") {
    
   $VMNAME_Value.text,$CPU_Value.text,$RAM_Value.text,$Subnet_value.Text,$OS_Value.Text | Out-file -filepath "\\geth.net\gethshare\Primary\it\VMConfig\sovreignvmconfig.txt"

   }
   else {

   $VMNAME_Value.text,$CPU_Value.text,$RAM_Value.text,$Subnet_value.Text,$OS_Value.Text | Out-file -filepath "\\geth.net\gethshare\Primary\it\VMConfig\consensusvmconfig.txt"

   }

}

[void]$HyperVToolv1.ShowDialog()