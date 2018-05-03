$DCName = read-host "Server Name"
$VHDPath = "C:\VM\$DCName\$DCName.vhdx"

new-vm -MemoryStartupBytes 2GB -Generation 2 -NoVHD -Name $DCName 

Set-VM -name $DCName -ProcessorCount 2

Add-VMNetworkAdapter -VMname $DCName 

New-VHD -Path $VHDPath -Parentpath "C:\VM\WinSrv2012R2\WinSrv2012Temp\WinSrv2012R2.vhdx" -Differencing

Get-vm $DCname | Add-VMHardDiskDrive -controllertype SCSI -controllernumber 0 -Path $VHDPath

$vmharddiskdrive = Get-VMHardDiskDrive -VMName "$DCName"

Set-VMFirmware "$DCName" -FirstBootDevice $vmharddiskdrive


