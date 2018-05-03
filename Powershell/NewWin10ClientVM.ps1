$ClientName = read-host "Client Name"
$VHDPath = "C:\VM\$ClientName\$ClientName.vhdx"

new-vm -MemoryStartupBytes 2GB -Generation 2 -NoVHD -Name $ClientName 

Set-VM -name $ClientName -ProcessorCount 4

Add-VMNetworkAdapter -VMname $ClientName

New-VHD -Path $VHDPath -Parentpath "C:\Users\Public\Documents\Hyper-V\Virtual hard disks\Win10Desktop.vhdx" -Differencing

Get-vm $ClientName | Add-VMHardDiskDrive -controllertype SCSI -controllernumber 0 -Path $VHDPath

$vmharddiskdrive = Get-VMHardDiskDrive -VMName "$ClientName"

Set-VMFirmware "$ClientName" -FirstBootDevice $vmharddiskdrive


