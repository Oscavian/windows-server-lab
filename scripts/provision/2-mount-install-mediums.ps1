
# Set ISO paths
$SQL_ISO_Path = '/run/media/oskar/2e1063cc-b9dc-4ac0-ad88-26721ac14aa7/isos/en_sql_server_2019_standard_x64_dvd_814b57aa.iso'
$SP_Image_Path = '/run/media/oskar/2e1063cc-b9dc-4ac0-ad88-26721ac14aa7/isos/officeserver.img'

# Function to mount installation media
function Mount-InstallMedia {
    param(
        [string]$VMName,
        [string]$ImagePath
    )

    VBoxManage storageattach $VMName `
        --storagectl SATA `
        --port 1 `
        --type dvddrive `
        --medium $ImagePath
}

# Mount installation media for SQL Server
Mount-InstallMedia -VMName 'sqlserver' -ImagePath $SQL_ISO_Path

# Mount installation media for SharePoint
Mount-InstallMedia -VMName 'sharepoint' -ImagePath $SP_Image_Path