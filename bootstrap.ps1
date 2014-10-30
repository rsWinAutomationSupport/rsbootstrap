Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
. "C:\DevOps\secrets.ps1"
(New-Object System.Net.webclient).DownloadFile("https://raw.githubusercontent.com/rsWinAutomationSupport/Git/v1.9.4/Git-Windows-Latest.exe","C:\DevOps\Git-Windows-Latest.exe")
Start -Wait "C:\DevOps\Git-Windows-Latest.exe" -ArgumentList "/verysilent"
cd "C:\Program Files\WindowsPowerShell\Modules"
Start -Wait "C:\Program Files (x86)\Git\bin\git.exe" -ArgumentList "clone --branch $($d.provBr) $('https://github.com', $($d.gCA), 'rsCommon.git' -join '/')"
cd "C:\DevOps"
Start -Wait "C:\Program Files (x86)\Git\bin\git.exe" -ArgumentList "clone --branch $($d.provBr) $('https://github.com', $($d.gCA), 'rsProvisioning.git' -join '/')"
start PowerShell.exe -ArgumentList "-ExecutionPolicy Bypass -file 'C:\DevOps\rsProvisioning\rsBasePrep.ps1'"
