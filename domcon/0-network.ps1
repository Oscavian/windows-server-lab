# Set Hostname
Rename-Computer -NewName "srv001" -Force

# Set IP Address, DNS, and Gateway
Remove-NetIPAddress -InterfaceAlias "Ethernet"
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress "192.168.23.10" -PrefixLength 24 -DefaultGateway "192.168.23.2"
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "192.168.23.10", "8.8.8.8"
