Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
if(!(Test-Path -Path "C:\DevOps")) { 
   New-Item -Path "C:\DevOps" -ItemType directory -Force
}
. "C:\DevOps\secrets.ps1"
(New-Object System.Net.webclient).DownloadFile("https://raw.githubusercontent.com/rsWinAutomationSupport/Git/v1.9.4/Git-Windows-Latest.exe","C:\DevOps\Git-Windows-Latest.exe")
Start -Wait "C:\DevOps\Git-Windows-Latest.exe" -ArgumentList "/verysilent"
cd "C:\Program Files\WindowsPowerShell\Modules"
Start -Wait "C:\Program Files (x86)\Git\bin\git.exe" -ArgumentList "clone --branch $($d.cBr) $('https://github.com', $($d.gCA), 'rsCommon.git' -join '/')"
cd "C:\DevOps"
Start -Wait "C:\Program Files (x86)\Git\bin\git.exe" -ArgumentList "clone --branch $($d.provBr) $('https://github.com', $($d.gCA), 'rsProvisioning.git' -join '/')"
& "C:\DevOps\rsProvisioning\rsBasePrep.ps1"
