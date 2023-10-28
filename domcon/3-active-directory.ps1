# Define variables for your domain configuration
$DomainName = "WS2-2324-oskar.hogent"
$SafeModeAdministratorPassword = ConvertTo-SecureString -AsPlainText "Password123!" -Force
$ForestMode = "Default"
$DomainMode = "Default"

# Install the Active Directory Domain Services role
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Promote the server to a domain controller
Install-ADDSForest `
  -DomainName $DomainName `
  -SafeModeAdministratorPassword $SafeModeAdministratorPassword `
  -DomainMode $DomainMode `
  -ForestMode $ForestMode `
  -InstallDns `
  -Force

# Restart the server to complete the promotion
