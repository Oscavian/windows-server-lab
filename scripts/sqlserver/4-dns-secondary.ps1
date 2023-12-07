Install-WindowsFeature -Name DNS -IncludeManagementTools

Add-DnsServerSecondaryZone -MasterServers 192.168.23.10 -Name "ws2-2324-oskar.hogent" -ZoneFile "ws2-2324-oskar.hogent"