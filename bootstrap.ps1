Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
. "C:\DevOps\secrets.ps1"
(New-Object System.Net.webclient).DownloadFile("https://raw.githubusercontent.com/rsWinAutomationSupport/Git/v1.9.4/Git-Windows-Latest.exe","C:\DevOps\Git-Windows-Latest.exe")
Start -Wait "C:\DevOps\Git-Windows-Latest.exe" -ArgumentList "/verysilent"
cd "C:\Program Files\WindowsPowerShell\Modules"
### the rsCommon production command is commented out for dev use.
#Start -Wait "C:\Program Files (x86)\Git\bin\git.exe" -ArgumentList "clone --branch $($d.provBr) https://github.com/rsWinAutomationSupport/rsCommon.git"
Start -Wait "C:\Program Files (x86)\Git\bin\git.exe" -ArgumentList "clone --branch $($d.provBr) $('https://github.com', $($d.git_username), 'rsCommon.git' -join '/')"
cd "C:\DevOps"
### the rsProvisioning production command is commented out for dev use.
#Start -Wait "C:\Program Files (x86)\Git\bin\git.exe" -ArgumentList "clone --branch $($d.provBr) https://github.com/rsWinAutomationSupport/rsProvisioning.git"
Start -Wait "C:\Program Files (x86)\Git\bin\git.exe" -ArgumentList "clone --branch $($d.provBr) $('https://github.com', $($d.git_username), 'rsProvisioning.git' -join '/')"
PowerShell.exe "C:\DevOps\rsProvisioning\rsBasePrep.ps1" -ArgumentList "-ExecutionPolicy Bypass -Force"
