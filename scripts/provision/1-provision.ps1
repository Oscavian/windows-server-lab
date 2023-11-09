# Set VM base folder
$VM_BASE_FOLDER = '/run/media/oskar/2e1063cc-b9dc-4ac0-ad88-26721ac14aa7/virtualbox'

# Set ISO paths
$WS_ISO_PATH = '/run/media/oskar/2e1063cc-b9dc-4ac0-ad88-26721ac14aa7/isos/en-us_windows_server_2022_x64_dvd_620d7eac.iso'
$W10_ISO_PATH = '/run/media/oskar/2e1063cc-b9dc-4ac0-ad88-26721ac14aa7/isos/SW_DVD9_Win_Pro_10_20H2.10_64BIT_English_Pro_Ent_EDU_N_MLF_X22-76585.ISO'
$CFG_SCRIPT_PATH = (Get-Item '../').FullName

# Provision a VirtualBox VM
function New-VboxVM {
    param(
        [string]$name,
        [int]$memory,
        [int]$cpuCores,
        [int]$diskSize,
        [int]$imageIndex,
        [string]$isoPath,
        [string]$osType
    )

    if (Test-Path "$VM_BASE_FOLDER\$name\$name.vbox") {
        Write-Host "VM $name already exists."
        return
    }

    Write-Host "Creating VM $name"
    VBoxManage createvm `
        --name $name `
        --basefolder $VM_BASE_FOLDER `
        --ostype $osType `
        --register `
        --default

    Write-Host "Configuring VM $name"
    VBoxManage modifyvm $name `
        --cpus $cpuCores `
        --memory $memory `
        --nic1 natnetwork `
        --nat-network1 NatNetwork1 `
        --groups "winserv2"

    Write-Host "Create and attach new disk for VM $name"
    VBoxManage createmedium disk `
        --filename "$VM_BASE_FOLDER\$name\$name.vdi" `
        --size $diskSize

    VBoxManage storageattach $name `
        --storagectl SATA `
        --port 0 `
        --type hdd `
        --medium "$VM_BASE_FOLDER\$name\$name.vdi"

    VBoxManage sharedfolder add $name `
        --name "share-$name" `
        --hostpath $CFG_SCRIPT_PATH `
        --readonly `
        --automount `
        --auto-mount-point "H:\"

    Write-Host "Begin unattended installation of VM $name"
    VBoxManage unattended install $name `
        --iso $isoPath `
        --user "oskar" `
        --password "123456" `
        --locale "de_AT" `
        --country "AT" `
        --hostname "$name.ws2-2324-oskar.hogent" `
        --install-additions `
        --image-index $imageIndex
}

# Provision VirtualBox VMs
if (-not (VBoxManage list vms | Select-String "domcon")) { New-VboxVM "domcon" 2048 1 65536 2 $WS_ISO_PATH "Windows2022_64" }
if (-not (VBoxManage list vms | Select-String "sharepoint")) { New-VboxVM "sharepoint" 1024 1 65536 2 $WS_ISO_PATH "Windows2022_64" }
if (-not (VBoxManage list vms | Select-String "sqlserver")) { New-VboxVM "sqlserver" 1024 1 65536 1 $WS_ISO_PATH "Windows2022_64" }
if (-not (VBoxManage list vms | Select-String "ws2client")) { New-VboxVM "ws2client" 1024 1 65536 1 $W10_ISO_PATH "Windows10_64" }

# Start unattended installation
& VBoxManage startvm "domcon" --type headless
Start-Sleep -Seconds 2
& VBoxManage startvm "sharepoint" --type headless
Start-Sleep -Seconds 2
& VBoxManage startvm "sqlserver" --type headless
Start-Sleep -Seconds 2
& VBoxManage startvm "ws2client" --type headless
