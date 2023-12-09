
$media_path = "$env:HOMEDRIVE\$env:HOMEPATH\SSMS-Setup-ENU.exe"
if((Test-Path $media_path) -eq $false) {
    Write-Progress "Downloading SSMS Setup file..."
    Invoke-WebRequest -Uri 'https://aka.ms/ssmsfullsetup' -OutFile $env:HOMEDRIVE\$env:HOMEPATH\SSMS-Setup-ENU.exe
}

$install_path = "$env:SystemDrive\SSMSto"
$params = "/Install SSMSInstallRoot=`"$install_path`"", "/Quiet" 

Start-Process -FilePath $media_path -ArgumentList $params -Wait
