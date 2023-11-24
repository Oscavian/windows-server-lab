# Deployment Guide

> Author: Oskar Münstermann
> 
> Date: 09.11.2023

## Directory Structure

The directory structure follows a pattern, which depicts in which order the scripts have to be executed. Refer to the following instructions for more details. 

The provisioning scripts were initally developed on Linux, thats why there is also a bash version of the provisioning scripts available.
The provisioning scripts were only tested on a Linux notebook, but should also work under Windows.

```
├── provision
│   ├── 0-natnetwork.ps1
│   ├── 1-provision.ps1
│   ├── 2-mount-install-mediums.ps1
│   ├── 3-restart-vms.ps1
│   └── bash
│       ├── 0-natnetwork.sh
│       ├── 1-provision.sh
│       ├── 2-mount-install-mediums.sh
│       └── cleanup.sh
├── domcon
│   ├── 0-network.ps1
│   ├── 1-active-directory.ps1
│   ├── 2-dns.ps1
│   └── 2-ssh.ps1
├── sharepoint
│   └── 0-network.ps1
└── sqlserver
    └── 0-network.ps1
```


## Set ISO Paths

- go to `scripts/provision/1-provision.ps1` and fill in the following variables at the top according to your system
  - VM_BASE_FOLDER - Virtualbox Base folder (where your vms are stored)
  - WS_ISO_PATH # Windows Server ISO
  - W10_ISO_PATH # Windows 10 ISO

- go to `scripts/provision/2-mount-install-mediums.ps1` and fill in the following variables according to your system
  - SQL_ISO_Path # SQL Server ISO
  - SP_Image_Path # Sharepoint ISO

## Execute Provisioning Scripts

To be executed on your host system:

1. cd into `scripts/provision`
2. execute `0-natnetwork.ps1` ro create the NAT Network.
3. execute `1-provision.ps1` to provision and start the unattended installation of all machines.
4. when all the installations have finished, execute `2-mount-install-mediums.ps1`
5. reboot all the machines
6. verify that the shared folder share-*vmname* is available at `H:\` on all machines
7. Verify that the install mediums for sharepoint and sqlserver show up in the respective machines

## Configure the Domain Controller

> When asked for a "yes" or "run", just accept everything

1. Execute `Set-ExecutionPolicy Unrestricted` to allow execution of PS scripts.
2. goto `H:\domcon`
3. run `0-network.ps1` to configure networking
4. run `1-active-directory` to install the AD Services
5. the machine will reboot, let it finish its thing

> No further configuration yet

## Configure the SQL Server

1. Execute `Set-ExecutionPolicy Unrestricted` to allow execution of PS scripts.
2. goto `H:\sqlserver`
3. run `0-network.ps1` to configure networking


## Configure the Sharepoint Server

1. Execute `Set-ExecutionPolicy Unrestricted` to allow execution of PS scripts.
2. goto `H:\sharepoint`
3. run `0-network.ps1` to configure networking