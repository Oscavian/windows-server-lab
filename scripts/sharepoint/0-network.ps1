# To be able to execute powershell scripts, change the execution policy

Unblock-File

# Set Hostname
Rename-Computer -NewName "srv002" -Force

# Set IP Address, DNS, and Gateway
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress "192.168.23.20" -PrefixLength 24 -DefaultGateway "192.168.23.2"
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "192.168.23.10"
