#!/bin/bash

function remove_vm() {
	VBoxManage unregistervm --delete $1
	if [[ $? -ne 0 ]]; then
		echo "VM $1 does not exist, skipping."
	fi
}

remove_vm $1