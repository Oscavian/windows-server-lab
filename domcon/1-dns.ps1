# Define the IP address of your preferred DNS forwarder
$DnsForwarder = "8.8.8.8"  # Replace with the IP address of your DNS forwarder

# Install the DNS server role
Install-WindowsFeature -Name DNS -IncludeManagementTools

# Configure the DNS server
Install-DnsServer -DnsServerForwarder $DnsForwarder

# Restart the DNS server to apply the changes
Restart-Service -Name "DNS Server"