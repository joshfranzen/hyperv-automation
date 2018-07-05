configuration RenameServer {

param (
    [string[]]$Computername="localhost"
)

Import-DscResource -ModuleName xComputerManagement

node localhost {
    xcomputer {
        name = $Computername
    }

}
}
