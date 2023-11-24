
# Enable console prompting
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds" `
    -Name 'ConsolePrompting' `
    -Value $true

# Add SQL Server to AD
Add-Computer -ComputerName 'srv003' `
    -DomainName 'ws2-2324-oskar.hogent' `
    -Credential 'WS2-2324-OSKAR\oskar' `
    -Restart -Force