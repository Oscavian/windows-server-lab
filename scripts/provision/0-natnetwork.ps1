VBoxManage natnetwork add `
    --netname NatNetwork1 `
    --network "192.168.23.0/24" `
    --enable `
    --dhcp off `
    --ipv6 off