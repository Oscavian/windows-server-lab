# Set Hostname
Rename-Computer -NewName "srv001" -Force

$ipaddress='192.168.23.10'
$catchall = '0.0.0.0/0'

$currentGateway = Get-NetRoute -DestinationPrefix $catchall | Select-Object -ExpandProperty 'NextHop' 2>$null

$newGateway = '192.168.23.2'

Remove-NetIPAddress -InterfaceAlias "Ethernet" -confirm:$false

if ($null -ne $currentGateway) {
    Write-Warning -Message "Gateway is set to $currentGateway and will be changed to $newGateway"
    Remove-NetRoute -DestinationPrefix $catchall -confirm:$false
}


# Set IP Address, DNS, and Gateway
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress $ipaddress -PrefixLength 24 -AddressFamily 'IPv4' -confirm:$false
New-NetRoute -InterfaceAlias "Ethernet" -NextHop $newGateway -DestinationPrefix $catchall -confirm:$false
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "192.168.23.10", "8.8.8.8" -confirm:$false