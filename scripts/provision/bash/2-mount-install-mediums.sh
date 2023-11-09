#!/bin/bash

VM_BASE_FOLDER=`VBoxManage list systemproperties | sed -n -e 's/Default machine folder: *\(\/.*\)$/\1/p'`
SQL_ISO_PATH=/run/media/oskar/2e1063cc-b9dc-4ac0-ad88-26721ac14aa7/isos/en_sql_server_2019_standard_x64_dvd_814b57aa.iso
SP_IMAGE_PATH=/run/media/oskar/2e1063cc-b9dc-4ac0-ad88-26721ac14aa7/isos/officeserver.img

function mount_install_med {    
    VBoxManage storageattach "$1" \
            --storagectl SATA \
            --port 1 \
            --type dvddrive \
            --medium "$2"
}

mount_install_med "sqlserver" $SQL_ISO_PATH
mount_install_med "sharepoint" $SP_IMAGE_PATH