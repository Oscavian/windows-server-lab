# Install the OpenSSH Server feature
Get-WindowsCapability -Online | Where-Object Name -like `OpenSSH.Server*` | Add-WindowsCapability -Online

Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Ser*'

# Set the SSH server to start automatically
Set-Service -Name sshd -StartupType 'Automatic'

# Start the SSH server
Start-Service sshd

# Create a firewall rule to allow SSH traffic
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

# Optional: Allow SSH traffic through the Windows Firewall (public profile)
Set-NetFirewallProfile -Name Public -Enabled True

# Confirm the SSH server status
Get-Service sshd

# Optionally, check the firewall rule
Get-NetFirewallRule -Name sshd
