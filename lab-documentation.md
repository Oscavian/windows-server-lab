> Author: Oskar Münstermann
> Date: 11.10.2023
> 

# Setup

| Hostname   | Services                                         | CPU | OS              | RAM   | Disk |
|------------|--------------------------------------------------|-----|-----------------|-------|------|
| domcon     | AD Domain Controller, Primary DNS, Root CA, DHCP | 1   | WS 2022 Desktop | 2048M | 64G  |
| sharepoint | SharePoint                                       | 1   | WS 2022 Core    | 1024M | 64G  |
| sqlserver  | SQL Server, Secondary DNS                        | 1   | WS 2022 Core    | 1024M | 64G  |
| ws2client  | Windows 10 client                                | 1   | Windows 10      | 2048M | 64G  |

| Hostname   | IP            | DNS           | Gateway      |
|------------|---------------|---------------|--------------|
| domcon     | 192.168.23.10 | 192.168.23.3  | 192.168.23.2 |
| sharepoint | 192.168.23.20 | 192.168.23.10 | 192.168.23.2 |
| sqlserver  | 192.168.23.30 | 192.168.23.10 | 192.168.23.2 |
| ws2client  | DHCP          | 192.168.23.10 | 192.168.23.2 |

![Network](./network.png)

# Motivations behind decisions

I to sticked to the minmum of 3 Windows Server VMs plus one Client VM. So I had to make a few tradeoffs regarding the seperation of services on different machines. My thought-process was the following:

- The Domain Controller has to be a seperate machine, first machine
- SharePoint and MSSQL would probably lead a bottleneck if run on one machine, so seperate them, makes machine two and three.
- The other network services (DNS1, DHCP) and the Root CA also run on the Domain Controller except for the secondary DNS, which obviously has to run on another machine, I chose the Database Machine.
- For the resources, I doubles the minimum of 32G disk size for the server machines to 64G to be sure to have enough space. The machines with a GUI get 128G. Same for the RAM, 1G for WS Core machines, 2G for client and dc.

# Problems

- As my host system is an Arch Linux derivate, I had to install the package `virtualbox-unattended-templates-7.0.10-1` from the AUR.
- I had to install PowerShell on my Linux host in order to write and test the provisioning scripts. Initially, I wrote them in Bash. Retrospectively, I should've started with PowerShell right away, it's not too big of a difference in that case.
- The shared folder wouldn't show up for any reason after the initial boot, only after rebooting once. Don't know why that does not work right away.

# Status

**Before 1st Deadline**

- I created the VM setup as a table and a network diagram depicting my planned setup.
- Apart from that I started creating the automation scripts, because I try to skip the manual install process. 
- I created the first version of the lab documentation

**Before 2nd Deadline**

- I created scripts for creating the NatNetwork and provisioning all 4 machines using VBoxManage.
- Additionally, I started on configuring networking on the machines.
- On the Domain Controller, I installed an Active Directory Forest.
- updated the lab documentation
- wrote the first deployment manual


# Conclusion

<aside>
🖊️ TBD
</aside>