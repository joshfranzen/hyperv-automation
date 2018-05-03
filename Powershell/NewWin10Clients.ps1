#Update this script to be a multi-creator
#take inputs of how many clients
#give the "site" name (earth, noveria, tachunka)
#write a loop script to run the below items, making each client for the workstation name "$site-WS-$count" run for each site while $site is not $null
#specify the following variables:
#$EarthCount
#$NoveriaCount
#$TachunkaCount
#Workflow should be: How many clients for Earth? How many clients for Noveria? How many clients for Tachunka?
#Set $earthcount to a number, if value > 1, set $earthcount = $Null, then stop the loop, repeate for each site




#Do-while loop for $EarthCount

$ClientName = "E-WS-$EarthCount"
$VHDPath = "C:\VM\$ClientName\$ClientName.vhdx"

new-vm -MemoryStartupBytes 2GB -Generation 2 -NoVHD -Name $ClientName 

Set-VM -name $ClientName -ProcessorCount 4

Add-VMNetworkAdapter -VMname $ClientName

New-VHD -Path $VHDPath -Parentpath "C:\Users\Public\Documents\Hyper-V\Virtual hard disks\Win10Desktop.vhdx" -Differencing

Get-vm $ClientName | Add-VMHardDiskDrive -controllertype SCSI -controllernumber 0 -Path $VHDPath

$vmharddiskdrive = Get-VMHardDiskDrive -VMName "$ClientName"

Set-VMFirmware "$ClientName" -FirstBootDevice $vmharddiskdrive


#Do-while loop for $NoveriaCount

$ClientName = "N-WS-$NoveriaCount"
$VHDPath = "C:\VM\$ClientName\$ClientName.vhdx"

new-vm -MemoryStartupBytes 2GB -Generation 2 -NoVHD -Name $ClientName 

Set-VM -name $ClientName -ProcessorCount 4

Add-VMNetworkAdapter -VMname $ClientName

New-VHD -Path $VHDPath -Parentpath "C:\Users\Public\Documents\Hyper-V\Virtual hard disks\Win10Desktop.vhdx" -Differencing

Get-vm $ClientName | Add-VMHardDiskDrive -controllertype SCSI -controllernumber 0 -Path $VHDPath

$vmharddiskdrive = Get-VMHardDiskDrive -VMName "$ClientName"

Set-VMFirmware "$ClientName" -FirstBootDevice $vmharddiskdrive


#Do-while loop for $TachunkaCount

$ClientName = "T-WS-$TachunkaCount"
$VHDPath = "C:\VM\$ClientName\$ClientName.vhdx"

new-vm -MemoryStartupBytes 2GB -Generation 2 -NoVHD -Name $ClientName 

Set-VM -name $ClientName -ProcessorCount 4

Add-VMNetworkAdapter -VMname $ClientName

New-VHD -Path $VHDPath -Parentpath "C:\Users\Public\Documents\Hyper-V\Virtual hard disks\Win10Desktop.vhdx" -Differencing

Get-vm $ClientName | Add-VMHardDiskDrive -controllertype SCSI -controllernumber 0 -Path $VHDPath

$vmharddiskdrive = Get-VMHardDiskDrive -VMName "$ClientName"

Set-VMFirmware "$ClientName" -FirstBootDevice $vmharddiskdrive
