#!/bin/bash

function remove_vm() {
	VBoxManage unregistervm --delete $1
	if [[ $? -ne 0 ]]; then
		echo "VM $1 does not exist, skipping."
	fi
}

[[ ! -n $1 ]] && remove_vm $1