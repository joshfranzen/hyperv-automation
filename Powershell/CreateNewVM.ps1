#Import the contents of the text file and save them as an array. The vmconfig.txt writes out from the result of the VM Automation tool webpage.

$Text = Get-Content -Path \\geth.net\gethshare\Primary\it\VMConfig\ConsensusVMConfig.txt
$Text.GetType() | Format-table -AutoSize


#Set the various values to the correct variable context (used later in the setup of the VM)

$VMName = $Text[0]
$VHDPath = "G:\$VMName\$VMName.vhdx"
$RamValue = $Text[1] -as [int]
$Ramvalue = $RamValue *= 1073741824
$CPUValue = $Text[2]
$SubNetValue = $Text[3]
$OSValue = $Text[4]


#Parse the value of the os input and correctly assign the vhdx path for differencing disk

if ($OSValue -eq "Windows 7 Enteprise") {
        $OSPath = "G:\Templates\Windows7\Win7Temp\Win7Template.vhdx"
}
elseif ($OSValue -eq "Windows 10 Enterprise") {
          $OSPath = "G:\Templates\Windows10\Win10Temp\Win10Template.vhdx"
}
elseif ($OSValue -eq "Windows Server 2012 R2") {
          $OSPath = "C:\VM\WinSrv2012R2\WinSrv2012Temp\WinSrv2012R2.vhdx"
}
else {
          $OSPath = "G:\Templates\WinSrv2016\WinSrv2016Temp\WinSrv2016Template.vhdx"
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



new-vm -MemoryStartupBytes $RamValue -Generation 2 -NoVHD -Name $VMName 

Set-VM -name $VMName -ProcessorCount $CPUValue

Add-VMNetworkAdapter -VMname $VMName -SwitchName $SwitchName

New-VHD -Path $VHDPath -Parentpath $OSPath -Differencing

Get-vm $VMname | Add-VMHardDiskDrive -controllertype SCSI -controllernumber 0 -Path $VHDPath

$vmharddiskdrive = Get-VMHardDiskDrive -VMName "$VMName"

Set-VMFirmware "$VMName" -FirstBootDevice $vmharddiskdrive

Start-VM $VMName

remove-item \\geth.net\gethshare\primary\it\VMConfig\ConsensusVMConfig.txt


