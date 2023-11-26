Install-WindowsFeature AD-Certificate -IncludeManagementTools

$params = @{
    CAType                  = "EnterpriseRootCa"
    CryptoProviderName      = "RSA#Microsoft Software Key Storage Provider"
    KeyLength               = 2048
    HashAlgorithmName       = "SHA1"
    ValidityPeriod          = "Years"
    ValidityPeriodUnits     = 3
    Credential              = $(Get-Credential -Credential 'ws2-2324-oskar.hogent\oskar')
    OverwriteExistingCAinDS = $true
    Verbose                 = $true
}
Install-AdcsCertificationAuthority @params

# Verify the correct installation:
# certutil -viewstore "ldap:///CN=ws2-2324-oskar-SRV001-CA,CN=Certification Authorities,CN=Public Key Services,CN=Services,CN=Configuration,DC=ws2-2324-oskar,DC=hogent?cACertificate?base?objectClass=certificationAuthority"