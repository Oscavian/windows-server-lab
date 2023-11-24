# Define variables for your domain configuration
$DomainName = "ws2-2324-oskar.hogent"
$DomainNetbiosName = "WS2-2324-OSKAR"
$SafeModeAdministratorPassword = ConvertTo-SecureString -AsPlainText "Password123!" -Force
$ForestMode = "Default"
$DomainMode = "Default"

# Install the Active Directory Domain Services role
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Install AD Forest
Install-ADDSForest `
  -DomainName $DomainName `
  -DomainNetbiosName $DomainNetbiosName `
  -SafeModeAdministratorPassword $SafeModeAdministratorPassword `
  -DomainMode $DomainMode `
  -ForestMode $ForestMode `
  -InstallDns:$true `
  -Force:$true
  -NoRebootOnCompletion:$false

# Server automatically restarts