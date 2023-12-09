# https://learn.microsoft.com/en-us/windows-server/networking/technologies/dhcp/dhcp-deploy-wps

Install-WindowsFeature DHCP -IncludeManagementTools
netsh dhcp add securitygroups

Restart-Service dhcpserver

Add-DhcpServerInDC `
    -DnsName 'srv001.ws2-2324-oskar.hogent' `
    -IPAddress 192.168.23.10

Add-DhcpServerv4Scope -Name "WS2 Network" `
    -StartRange 192.168.23.51 `
    -EndRange 192.168.23.100 `
    -SubnetMask 255.255.255.0 `

Set-DhcpServerv4OptionValue `
    -DnsDomain 'ws2-2324-oskar.hogent' `
    -DnsServer 192.168.23.10

# Set DHCP default gateway, a magic number 3 !!!!
# https://learn.microsoft.com/en-us/powershell/module/dhcpserver/set-dhcpserverv4optionvalue?view=windowsserver2022-ps
Set-DhcpServerv4OptionValue `
    -OptionID 3 `
    -Value 192.168.23.2 `
    -ScopeID 192.168.23.0 `
    -ComputerName 'srv001.ws2-2324-oskar.hogent'

Get-DhcpServerInDC

# Alert Server Manager about Successful post config
Set-ItemProperty -Path 'registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12' -Name ConfigurationState -Value 2