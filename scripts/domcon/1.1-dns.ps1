
# add reverse lookup zone
Add-DnsServerPrimaryZone -NetworkID "192.168.23.0/24" -ReplicationScope "Forest"

Add-DnsServerResourceRecordPtr -Name "10" -ZoneName "23.168.192.in-addr.arpa" -AllowUpdateAny -TimeToLive 01:00:00 -AgeRecord -PtrDomainName "srv001.ws2-2324-oskar.hogent"
Add-DnsServerResourceRecordPtr -Name "20" -ZoneName "23.168.192.in-addr.arpa" -AllowUpdateAny -TimeToLive 01:00:00 -AgeRecord -PtrDomainName "srv002.ws2-2324-oskar.hogent"
Add-DnsServerResourceRecordPtr -Name "30" -ZoneName "23.168.192.in-addr.arpa" -AllowUpdateAny -TimeToLive 01:00:00 -AgeRecord -PtrDomainName "srv003.ws2-2324-oskar.hogent"

Add-DnsServerZoneTransferPolicy -ServerInterfaceIP "EQ,192.168.23.30" -ZoneName 'ws2-2324-oskar.hogent' -Name 'Allow Transfer to Secondary Dns'##

# Start-Service FDResPub
# Start-Service SSDPSRV
# Start-Service upnphost