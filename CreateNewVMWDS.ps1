<#
SYNOPSIS:
Run this script from your WDS server to generate a new vm with the specified paramaters below. This script can then be called from an automation service like chef or puppet.
It will create parameters for a new vm, create a new vhdx, a new network adapter and then create the vm with those two devices. The script will then add a pre-registered device
to the WDS server, boot the VM and PXE boot the VM with the unattend file you've specified.

The template VHDX is simply a vhdx disk I mounted to a vm, and then used the windows installer to format. I then cancelled the install to be left with a blank formatted vhdx. 
I use that blank vhdx and copy it to create a new vhdx on which to install windows in the newly created VM.

All of these assume your hyper-v host has an F drive. 


PREREQUISITES
A functioning WDS infrastructure, you should be able to boot up a vm from PXE and install an image from the WDS. 
A functioning Unattend.xml file, you should be able to have a PXE guest use the unattend file from WDS.

#>



Function Create-NewVM {

  
    

 
    process {
    $name = "DP-APP-" + ((get-adcomputer -filter {name -like "DP-APP*"}).count + 1 ) #modify this to fit your naming convention
    $vmhost = "HyperVServer1"                                                        #Add your preferred VM server here
    $vhdtemplate = "F$\2016Template.vhdx"                                            #update this variable to point to your template vhdx on your hyper-v host.
    $vhddir = "F$\$name\Virtual Hard Disks"                                          #destination directory for the new VM vhdx
    $vhdpath = "$vhddir\$name.vhdx"                                                  #this variable defines the full path of the new VHDX
    $domain = "contoso.com"                                                          #add your domain name here for domain join

    [hashtable]$NewvmParams = @{
    name = $name                        #Name of the VM
    memorystartupbytes = 2GB            #RAM Value of the VM
    Generation = "2"                    #Generation 2 VM
    computername = $vmhost              #Target Hyper-V server name
    Switchname = "Provider 2"           #Name of the VSwitch on the hyperV server
    }

    [hashtable]$SetvmParams = @{
    name = $name                        #Name of the VM
    processorcount = $CPU               #CPU Core Count
    Computername = $vmhost              #Target Hyper-V server name
    }



    #This section creates a folder for your new VM's VHDX do keep things organized. Then copies the template VHDX to that folder.
    New-Item -ItemType Directory -Path "\\$vmhost\$vhddir"
    copy-item "\\$vmhost\$VHDTemplate" "\\$vmhost\$vhdpath" -Force

    #Create the VM
    New-vm @newvmparams 

    #Update the VM with the correct CPU count
    set-vm @setvmparams 

    #Add the newly created VHDX to the VM.
    get-vm -computername $vmhost $name | Add-VMHardDiskDrive -controllertype SCSI -controllernumber 0 -Path $VHDPath
    $vmharddiskdrive = Get-VMHardDiskDrive -ComputerName $vmhost -VMName "$Name"

    #boot the vm to get the vNIC assigned a MAC address.
    start-vm -ComputerName $vmhost -Name $name
    sleep -Seconds 2
    stop-vm -ComputerName $vmhost -Name $name -TurnOff -Force


    #Set the VM's new adapter as first boot, and get it's MAC address
    $netadapter = get-vm $name -computername $vmhost | get-vmnetworkadapter 
    Set-VMFirmware -ComputerName $vmhost "$Name" -FirstBootDevice $netadapter
    $macaddress = $netadapter.MacAddress
  
    #This section creates the new pre-registered device on the WDS server.
    #replace the path for -wdsclientunattend with the path where your unattend file lives on your WDS server.
    New-WdsClient -Domain $domain -DeviceName $name -DeviceID $macaddress -JoinDomain $true -WdsClientUnattend "WdsClientUnattend\DPUnattend.xml" -PxePromptPolicy NoPrompt
    get-vm -name $name -ComputerName $vmhost | Add-ClusterVirtualMachineRole -Cluster DP-CLuster 
    start-vm -ComputerName $vmhost -Name $name
    
    Sleep -Seconds 2

    #Set the disk as first boot option
    Set-VMFirmware -ComputerName $vmhost "$Name" -FirstBootDevice $vmharddiskdrive

   
    }


}

#execute the function and create the new VM
create-newvm 
