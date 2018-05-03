$DCCount = Get-ChildItem -Path F:\ -Name DC* | Measure-Object | %{$_.Count}
$DCnumber = $DCCount + 1
$DCName = "DC$DCnumber"
$VHDPath = "F:\$DCName\$DCName.vhdx"

new-vm -MemoryStartupBytes 2GB -Generation 2 -NoVHD -Name $DCName 

Set-VM -name $DCName -ProcessorCount 4

Add-VMNetworkAdapter -VMname $DCName -SwitchName Switch1
Add-VMNetworkAdapter -VMname $DCName -SwitchName Switch2

Set-VMNetworkAdapter -VMName $DCName -AllowTeaming on

New-VHD -Path $VHDPath -Parentpath "F:\WinServer2012R2Template\WinServer2012Template.vhdx" -Differencing

Get-vm $DCname | Add-VMHardDiskDrive -controllertype SCSI -controllernumber 0 -Path $VHDPath

$vmharddiskdrive = Get-VMHardDiskDrive -VMName "$DCName"

Set-VMFirmware "$DCName" -FirstBootDevice $vmharddiskdrive

Start-VM $DCname
