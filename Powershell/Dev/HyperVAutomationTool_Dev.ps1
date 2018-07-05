<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#region begin GUI{ 

$HyperVToolv1                    = New-Object system.Windows.Forms.Form
$HyperVToolv1.ClientSize         = '555,500'
$HyperVToolv1.text               = "Hyper-V Automation Tool v0.2"
$HyperVToolv1.BackColor          = "#ffffff"
$HyperVToolv1.TopMost            = $false

$VMNAME_PANEL                    = New-Object system.Windows.Forms.Panel
$VMNAME_PANEL.height             = 43
$VMNAME_PANEL.width              = 555
$VMNAME_PANEL.BackColor          = "#59288d"
$VMNAME_PANEL.location           = New-Object System.Drawing.Point(0,0)

$VMNAME_LABEL                    = New-Object system.Windows.Forms.Label
$VMNAME_LABEL.text               = "VM Name"
$VMNAME_LABEL.AutoSize           = $true
$VMNAME_LABEL.width              = 25
$VMNAME_LABEL.height             = 10
$VMNAME_LABEL.location           = New-Object System.Drawing.Point(23,16)
$VMNAME_LABEL.Font               = 'Arial Rounded MT,14'
$VMNAME_LABEL.ForeColor          = "#ffffff"

$NETWORK_PANEL                   = New-Object system.Windows.Forms.Panel
$NETWORK_PANEL.height            = 43
$NETWORK_PANEL.width             = 555
$NETWORK_PANEL.BackColor         = "#59288d"
$NETWORK_PANEL.location          = New-Object System.Drawing.Point(0,100)

$OS_PANEL                        = New-Object system.Windows.Forms.Panel
$OS_PANEL.height                 = 43
$OS_PANEL.width                  = 555
$OS_PANEL.BackColor              = "#59288d"
$OS_PANEL.location               = New-Object System.Drawing.Point(0,200)

$STORAGE_PANEL                   = New-Object system.Windows.Forms.Panel
$STORAGE_PANEL.height            = 43
$STORAGE_PANEL.width             = 553
$STORAGE_PANEL.BackColor         = "#59288d"
$STORAGE_PANEL.location          = New-Object System.Drawing.Point(0,300)

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

$SERVICE_LABEL                   = New-Object system.Windows.Forms.Label
$SERVICE_LABEL.text              = "Service"
$SERVICE_LABEL.AutoSize          = $true
$SERVICE_LABEL.width             = 25
$SERVICE_LABEL.height            = 10
$SERVICE_LABEL.location          = New-Object System.Drawing.Point(22,16)
$SERVICE_LABEL.Font              = 'Arial Rounded MT,14'
$SERVICE_LABEL.ForeColor         = "#ffffff"

$VMNAME_VALUE                    = New-Object system.Windows.Forms.TextBox
$VMNAME_VALUE.multiline          = $false
$VMNAME_VALUE.width              = 100
$VMNAME_VALUE.height             = 20
$VMNAME_VALUE.location           = New-Object System.Drawing.Point(36,60)
$VMNAME_VALUE.Font               = 'Microsoft Sans Serif,14'

$SUBNET_VALUE                    = New-Object system.Windows.Forms.ComboBox
$SUBNET_VALUE.width              = 210
$SUBNET_VALUE.height             = 20
@('Earth','Noveria','Tachunka','Palaven','Geth') | ForEach-Object {[void] $SUBNET_VALUE.Items.Add($_)}
$SUBNET_VALUE.location           = New-Object System.Drawing.Point(36,160)
$SUBNET_VALUE.Font               = 'Microsoft Sans Serif,14'

$OS_VALUE                        = New-Object system.Windows.Forms.ComboBox
$OS_VALUE.width                  = 210
$OS_VALUE.height                 = 20
@('Windows 7 Enterprise','Windows 10 Enterprise','Windows Server 2012 R2','Windows Server 2016') | ForEach-Object {[void] $OS_VALUE.Items.Add($_)}
$OS_VALUE.location               = New-Object System.Drawing.Point(36,260)
$OS_VALUE.Font                   = 'Microsoft Sans Serif,14'

$BUILD_BUTTON                    = New-Object system.Windows.Forms.Button
$BUILD_BUTTON.BackColor          = "#59288d"
$BUILD_BUTTON.text               = "Build"
$BUILD_BUTTON.width              = 86
$BUILD_BUTTON.height             = 40
$BUILD_BUTTON.location           = New-Object System.Drawing.Point(400,400)
$BUILD_BUTTON.Font               = 'Arial Rounded MT,14'
$BUILD_BUTTON.ForeColor          = "#ffffff"

$SERVICE_VALUE                   = New-Object system.Windows.Forms.ComboBox
$SERVICE_VALUE.width             = 210
$SERVICE_VALUE.height            = 20
@('Domain Controller','File Server','Web Server','Routing and Remote Access') | ForEach-Object {[void] $SERVICE_VALUE.Items.Add($_)}
$SERVICE_VALUE.location          = New-Object System.Drawing.Point(36,360)
$SERVICE_VALUE.Font              = 'Microsoft Sans Serif,14'

$HyperVToolv1.controls.AddRange(@($VMNAME_PANEL,$NETWORK_PANEL,$OS_PANEL,$STORAGE_PANEL,$VMNAME_VALUE,$SUBNET_VALUE,$OS_VALUE,$BUILD_BUTTON,$SERVICE_VALUE))
$VMNAME_PANEL.controls.AddRange(@($VMNAME_LABEL))
$NETWORK_PANEL.controls.AddRange(@($NETWORK_LABEL))
$OS_PANEL.controls.AddRange(@($OS_LABEL))
$STORAGE_PANEL.controls.AddRange(@($SERVICE_LABEL))

#region gui events {
$BUILD_BUTTON.Add_Click({ BUILD_VM })
#endregion events }


#Write your logic code here

function Build_VM {

#Set the various values to the correct variable context (used later in the setup of the VM)

$VMName = $VMNAME_Value.text     
$VHDPath = "G:\$VMName\$VMName.vhdx"
$SubNetValue = $Subnet_Value.Text
$OSValue = $OS_Value.Text
$Service = $Service_value.Text

configuration SeedMOF {

param (
    [string[]]$computername
    )

    node localhost {

    Import-DscResource -ModuleName xComputerManagement

    xcomputer {
        name = $computername
    }
}
}

SeedMOF -Computername $VMName


#Parse the value of the os input and correctly assign the vhdx path for differencing disk

if ($OSValue -eq "Windows 7 Enteprise") {
        $OSPath = "G:\Templates\Windows7\Win7Temp\Win7Template.vhdx"
        $Host = "SOVREIGN"
}
elseif ($OSValue -eq "Windows 10 Enterprise") {
          $OSPath = "G:\Templates\Windows10\Win10Temp\Win10Template.vhdx"
          $Host = "SOVREIGN"
}
elseif ($OSValue -eq "Windows Server 2012 R2") {
          $OSPath = "C:\VM\WinSrv2012R2\WinSrv2012Temp\WinSrv2012R2.vhdx"
          $Host = "CONSENSUS"
}
else {
          $OSPath = "G:\Templates\WinSrv2016\WinSrv2016Temp\WinSrv2016Template.vhdx"
          $Host = "SOVREIGN"
}            

#Parse the value of the subnet input and correctly assign the switch name for differencing disk

if ($SubNetValue -like '*Palaven*') {
        $SwitchName = "Palaven"
}
elseif ($SubNetValue -like '*Earth*') {
          $SwitchName = "Earth"
}
elseif ($SubNetValue -like '*Noveria*') {
          $SwitchName = "Noveria"
}
elseif ($SubNetValue -like '*Tachunka*') {
          $SwitchName = "Tachunka"
}
else {
          $SwitchName = "Switch 2"
}     



if ($Service 




}



[void]$HyperVToolv1.ShowDialog()