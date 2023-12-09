# Install prerequesites
# https://learn.microsoft.com/en-us/sharepoint/install/hardware-and-software-requirements-2019

# no quiet install :(
Start-Process -FilePath 'D:\PrerequisiteInstaller.exe' -Wait

Write-Warning "Server needs to be restarted."
Restart-Computer -Confirm
