$ClientName = read-host "Client Name"
$VHDPath = "C:\VM\$ClientName\$ClientName.vhdx"

new-vm -MemoryStartupBytes 2GB -Generation 1 -NoVHD -Name $ClientName 

Set-VM -name $ClientName -ProcessorCount 4

Add-VMNetworkAdapter -VMname $ClientName

New-VHD -Path $VHDPath -Parentpath "C:\Users\Public\Documents\Hyper-V\Virtual hard disks\Win7Desktop.vhdx" -Differencing

Get-vm $ClientName | Add-VMHardDiskDrive -controllertype IDE -controllernumber 1 -Path $VHDPath

$vmharddiskdrive = Get-VMHardDiskDrive -VMName "$ClientName"




