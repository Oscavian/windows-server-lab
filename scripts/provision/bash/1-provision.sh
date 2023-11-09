#!/bin/bash

VM_BASE_FOLDER=`VBoxManage list systemproperties | sed -n -e 's/Default machine folder: *\(\/.*\)$/\1/p'`
WS_ISO_PATH=/run/media/oskar/2e1063cc-b9dc-4ac0-ad88-26721ac14aa7/isos/en-us_windows_server_2022_x64_dvd_620d7eac.iso
# SQL_ISO_PATH=/run/media/oskar/2e1063cc-b9dc-4ac0-ad88-26721ac14aa7/isos/en_sql_server_2019_standard_x64_dvd_814b57aa.iso
W10_ISO_PATH=/run/media/oskar/2e1063cc-b9dc-4ac0-ad88-26721ac14aa7/isos/SW_DVD9_Win_Pro_10_20H2.10_64BIT_English_Pro_Ent_EDU_N_MLF_X22-76585.ISO
CFG_SCRIPT_PATH=$(realpath ../)


function ask_yn() {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;  
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}


# provision a virtualbox vm
# args:
# $1 - VM-name
# $2 - MEMORY
# $3 - CPU CORES
# $4 - DISK SIZE
# $5 - IMAGE INDEX
# $6 - ISO PATH
# $7 - OS TYPE
function provision_vm() {

	if [[ -f "$VM_BASE_FOLDER/$1/$1.vbox" ]]; then
		echo "VM $1 already exists."
		return 1
	fi	

	echo "Creating vm $1"
	VBoxManage createvm \
	--name=$1 \
	--basefolder=$VM_BASE_FOLDER \
	--ostype=$7 \
	--register \
	--default

	echo "Configuring vm $1"

	VBoxManage modifyvm $1 \
		--cpus $3 \
		--memory $2 \
		--nic1 natnetwork \
		--nat-network1 NatNetwork1 \
		--groups "/winserv2"

	echo "Create and attach new disk for vm $1"

	VBoxManage createmedium disk \
		--filename "$VM_BASE_FOLDER/$1/$1.vdi" \
		--size $4

	VBoxManage storageattach "$1" \
		--storagectl SATA \
		--port 0 \
		--type hdd \
		--medium "$VM_BASE_FOLDER/$1/$1.vdi"

	VBoxManage sharedfolder add $1 \
		--name "share-$1" \
		--hostpath "$CFG_SCRIPT_PATH" \
		--readonly \
		--automount \
		--auto-mount-point "H:\\"


	echo "Begin unattended installation of vm $1"

	# --image-index=1 -> Standard Core edition
	# --image-index=2 -> Standard with Desktop
	# --additions-iso=/usr/lib/virtualbox/additions/VBoxGuestAdditions.iso \
	VBoxManage unattended install $1 \
		--iso=$6 \
		--user="oskar" \
		--password="123456" \
		--locale="en_US" \
		--country="AT" \
		--hostname="$1.ws2-2324-oskar.hogent" \
		--install-additions \
		--image-index=$5
}




# provision a virtualbox vm
# args:
# $1 - VM-name
# $2 - MEMORY 
# $3 - CPU CORES
# $4 - DISK SIZE in MiB 131072 or 65536
# $5 - IMAGE INDEX
# $6 - ISO PATH

VBoxManage list vms | grep "domcon" || provision_vm "domcon" 2048 1 65536 2 $WS_ISO_PATH "Windows2022_64"
VBoxManage list vms | grep "sharepoint" || provision_vm "sharepoint" 1024 1 65536 2 $WS_ISO_PATH "Windows2022_64"
VBoxManage list vms | grep "sqlserver" || provision_vm "sqlserver" 1024 1 65536 1 $WS_ISO_PATH "Windows2022_64"
VBoxManage list vms | grep "ws2client" || provision_vm "ws2client" 1024 1 65536 1 $W10_ISO_PATH "Windows10_64"

sleep 2

# start unattended installation
VBoxManage startvm "domcon" --type headless
sleep 2
VBoxManage startvm "sharepoint" --type headless
sleep 2
VBoxManage startvm "sqlserver" --type headless
sleep 2
VBoxManage startvm "ws2client" --type headless


# https://blogs.oracle.com/scoter/post/unattened-install-microsoft-windows-11-on-virtualbox
# https://docs.oracle.com/en/virtualization/virtualbox/6.0/user/vboxmanage-unattended.html
