# Set Hostname
Rename-Computer -NewName "srv003" -Force

# Set IP Address, DNS, and Gateway
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress "192.168.23.30" -PrefixLength 24 -DefaultGateway "192.168.23.2"
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "192.168.23.10"
