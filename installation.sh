New-Item -Path "C:\Temp" -ItemType Directory

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Test-NetConnection -ComputerName "aws-elastic-disaster-recovery-{region}.s3.{region}.amazonaws.com" -Port 443

# Replace {region} with the region you are using
Invoke-WebRequest -Uri "https://aws-elastic-disaster-recovery-{region}.s3.{region}.amazonaws.com/latest/windows/AwsReplicationWindowsInstaller.exe" -OutFile "C:\Temp\AwsReplicationWindowsInstaller.exe"

# Replace {region} with the region you are using, and replace the  {YOUR-ACKS} and {YOUR-SECRET-ACK} with your own
Start-Process -FilePath "C:\Temp\AwsReplicationWindowsInstaller.exe" -ArgumentList "--region {region} --aws-access-key-id {YOUR-ACKS} --aws-secret-access-key {YOUR-SECRET-ACK} --no-prompt" -Wait -Verb RunAs
