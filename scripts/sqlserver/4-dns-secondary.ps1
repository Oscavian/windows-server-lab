Install-WindowsFeature -Name DNS -IncludeManagementTools

Add-DnsServerSecondaryZone -MasterServers 192.168.23.10 -Name "ws2-2324-oskar.hogent" -ZoneFile "ws2-2324-oskar.hogent"

Add-DnsServerForwarder -IPAddress 8.8.8.8 -PassThru

New-NetFirewallRule -DisplayName "DNS Server Incoming UDP" -Direction Inbound -LocalPort 53 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "DNS Server Incoming TCP" -Direction Inbound -LocalPort 53 -Protocol TCP -Action Allow

# force a dns zone transfer
dnscmd /zonerefresh ws2-2324-oskar.hogent