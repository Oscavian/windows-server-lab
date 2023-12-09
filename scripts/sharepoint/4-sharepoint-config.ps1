# NOT WORKING!
# https://learn.microsoft.com/en-us/previous-versions/office/sharepoint-server-2010/cc263093(v=office.14)?redirectedfrom=MSDN
# https://blog.stefan-gossner.com/2015/08/20/why-i-prefer-psconfigui-exe-over-psconfig-exe/
# https://learn.microsoft.com/en-us/sharepoint/install/install-sharepoint-server-2016-on-one-server#run-setup
# https://learn.microsoft.com/en-us/sharepoint/install/initial-deployment-administrative-and-service-accounts-in-sharepoint-server

Start-Process -FilePath 'C:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\BIN\psconfig.exe' `
    -ArgumentList `
    '-cmd configdb -create -server "SRV003" -database "Sharepoint_Config" -dbuser "WS2-2324-oskar\oskar" -dbpassword "123456" -user "WS2-2324-oskar\oskar" -password "123456" -passphrase "Password123!" -localserverrole "Single-Server Farm"', `
    '-cmd helpcollections', `
    '-cmd secureresources', `
    '-cmd services', `
    '-cmd installfeatures', `
    '-cmd adminvs -provision', `
    # '-cmd ssl' #add later
    '-cmd applicationcontent -install', `
    '-cmd upgrade' `
    -Wait
    -NoNewWindow
