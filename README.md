# Windows Server Lab Environment

A demo setup for a Windows Server environment. Automated using bash, `VBoxManage` and PowerShell. 

# Todo

## Domain controller

- [x] Network config
- [ ] SSH Server
- [x] Active Directory
- [ ] Primary DNS 
- [ ] DHCP
- [ ] Root CA

## Sharepoint server

- [x] Network config
- [ ] SSH Server
- [ ] Sharepoint

## SQL Server

- [x] Network config
- [ ] SSH Server
- [ ] Secondary DNS

## Deployment steps:

- provision
- install vbox guest additions (shared folder)
- set execution policy to unrestricted
- run network script
- ...

# Resources 

https://learn.microsoft.com/en-us/sql/database-engine/install-windows/install-sql-server-with-powershell-desired-state-configuration?view=sql-server-ver16
https://learn.microsoft.com/en-us/sharepoint/install/installing-sharepoint-server-subscription-edition-on-windows-server-core
