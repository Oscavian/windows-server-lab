#!/bin/bash

VM_BASE_FOLDER=`VBoxManage list systemproperties | sed -n -e 's/Default machine folder: *\(\/.*\)$/\1/p'`
WS_ISO_PATH=/run/media/oskar/2e1063cc-b9dc-4ac0-ad88-26721ac14aa7/isos/en-us_windows_server_2022_x64_dvd_620d7eac.iso

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
function provision_vm() {

	if [[ -f "$VM_BASE_FOLDER/$1/$1.vbox" ]]; then
		echo "VM $1 already exists."
		return 1
	fi	

	VBoxManage createvm \
	--name=$1 \
	--basefolder=$VM_BASE_FOLDER \
	--ostype="Windows2022_64" \
	--register \
	--default

	echo "Modify vm..."

	VBoxManage modifyvm $1 \
		--cpus $3 \
		--memory $2 \
		--nic1 natnetwork \
		--nat-network1 NatNetwork1 \
		--groups "/winserv2"

	echo "Create new disk..."

	VBoxManage createmedium disk \
		--filename "/$VM_BASE_FOLDER/$1/$1.vdi" \
		--size $4

	VBoxManage storageattach "$1" \
		--storagectl SATA \
		--port 0 \
		--type hdd \
		--medium "/$VM_BASE_FOLDER/$1/$1.vdi"

	echo "Begin install..."

	# --image-index=1 -> Standard Core edition
	# --image-index=2 -> Standard with Desktop
	VBoxManage unattended install $1 \
		--iso=$WS_ISO_PATH \
		--user="oskar" \
		--password="123456" \
		--locale="en_US" \
		--country="AT" \
		--hostname="$1.ws2-2324-oskar.hogent" \
		--image-index=$5
}




# provision a virtualbox vm
# args:
# $1 - VM-name
# $2 - MEMORY 
# $3 - CPU CORES
# $4 - DISK SIZE in MiB 131072 or 65536
# $5 - IMAGE INDEX

VBoxManage list vms | grep "domcon" || provision_vm "domcon" 2048 1 131072 2

VBoxManage list vms | grep "sharepoint" || provision_vm "sharepoint" 1024 1 65536 1

VBoxManage list vms | grep "sqlserver" || provision_vm "sqlserver" 1024 1 65536 1


VBoxManage startvm "domcon" --type headless
VBoxManage startvm "sharepoint" --type headless
VBoxManage startvm "sqlserver" --type headless
# [ "$?" -ne 0 ] && exit "$?"

# https://blogs.oracle.com/scoter/post/unattened-install-microsoft-windows-11-on-virtualbox
# https://docs.oracle.com/en/virtualization/virtualbox/6.0/user/vboxmanage-unattended.html
