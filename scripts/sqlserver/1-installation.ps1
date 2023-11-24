# SQLServer installation executable paths

Start-Process -FilePath 'D:\setup.exe' -ArgumentList '/Q', '/ConfigurationFile="H:\sqlserver\mssql-conf.ini"', '/SQLSVCPASSWORD="123456"' -Wait -NoNewWindow

