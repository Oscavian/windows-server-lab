# Enable SQL Server Service
Set-Service sqlserveragent -StartupType Auto
Start-Service sqlserveragent

# Enable SQL Browser
Set-Service sqlbrowser -StartupType Auto
Start-Service sqlbrowser

try {
    if (Get-Command Invoke-Sqlcmd) {
        Write-Host "SQLCMD already installed. Skipping installation."
    }
}
catch {
    Write-Progress "SQLCMD utility not found, installing..."
    Invoke-WebRequest https://go.microsoft.com/fwlink/?linkid=2230791 -OutFile $env:HOME\mssqlcmdlnutls.msi
    Start-Process -FilePath "$env:HOME\mssqlcmdlnutls.msi" -ArgumentList '/quiet'
    # & "$env:HOME\mssqlcmdlnutls.msi"
    #Write-Host "Please click through the installation window."
    Write-Host "Please restart your terminal session and run this script again!"
    #exit
}

# Enable TCP/IP on the sqlserver instance
Write-Host "Enable remote connections on the instance of SQL Server"
$query = @"
EXEC sys.sp_configure N'remote access', N'1';
GO
RECONFIGURE WITH OVERRIDE;
GO
"@
Invoke-Sqlcmd $query -Verbose

# sqlcmd -i 'H:\sqlserver\enable-remote-access.sql'


# Configure Firewall rules
Write-Host "Applying Firewall rules for SQL Server... opening tcp/1433 & udp/1433"
New-NetFirewallRule -DisplayName "SQLServer default instance" -Direction Inbound -LocalPort 1433 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "SQLServer Browser service" -Direction Inbound -LocalPort 1434 -Protocol UDP -Action Allow

# Not tested yet
# Write-Host "Enabling TCP/IP on the sqlserver instance"
# SQLPS.exe -Command $(Get-Content 'H:\sqlserver\sqlps.ps1')




