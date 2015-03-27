### Sections 1 - 4 will need to be modified for the required branch and github account name.
### branch is currently set to dedicated for feature branch testing.
### for a customer deployment the branch should be set to the appropriate version release of the repo being cloned.

Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
. "C:\DevOps\secrets.ps1"

### if $d.gitBr and $d.commonBr are not defined, make them the same as $d.provBr
if ( -not $d.gitBr)
{
    $d.gitBr = $d.provBr
}
if ( -not $d.commonBr)
{
    $d.commonBr = $d.provBr
}

### Download and install git client
(New-Object System.Net.webclient).DownloadFile("https://raw.githubusercontent.com/rsWinAutomationSupport/Git/v1.9.5/Git-Windows-Latest.exe","C:\DevOps\Git-Windows-Latest.exe")
Start-Process -Wait "C:\DevOps\Git-Windows-Latest.exe" -ArgumentList "/verysilent"

### Set Browser service to manual
Set-Service Browser -StartupType Manual

### disable MSN
(Get-NetAdapter).Name | % {Set-NetAdapterBinding -Name $_ -DisplayName "Client for Microsoft Networks" -Enabled $false}

### start browser service
Start-Service Browser

#################################################
### Clone initial repo's to Modules directory ###
#################################################
Set-Location "C:\Program Files\WindowsPowerShell\Modules"

# 1 #
### [ Edit branch and git user in URI ] ###
Start-Process -Wait "C:\Program Files (x86)\Git\bin\git.exe" -ArgumentList "clone --branch $($d.commonBr) https://github.com/rsWinAutomationSupport/rsCommon.git"
###########################################

# 2 #
### [ Edit branch and git user in URI ] ###
Start-Process -Wait "C:\Program Files (x86)\Git\bin\git.exe" -ArgumentList "clone --branch $($d.gitBr) https://github.com/rsWinAutomationSupport/rsGit.git"
###########################################

##################################################
### Clone initial repos to C:\DevOps directory ###
##################################################
Set-Location "C:\DevOps"

# 3 #
### [ Edit branch and git user in URI ] ###
Start-Process -Wait "C:\Program Files (x86)\Git\bin\git.exe" -ArgumentList "clone --branch $($d.branch_rsConfigs) $((('https://', $d.git_Oauthtoken, '@github.com' -join ''), $($d.git_username), $($d.mR , '.git' -join '')) -join '/')"
###########################################

# 4 #
### [ Edit branch and git user in URI ] ###
Start-Process -Wait "C:\Program Files (x86)\Git\bin\git.exe" -ArgumentList "clone --branch $($d.provBr) https://github.com/rsWinAutomationSupport/rsProvisioning.git"
###########################################

Stop-Service Browser

### Copy rsPlatform to modules directory
if((Test-Path -Path "C:\Program Files\WindowsPowerShell\DscService\Modules" -PathType Container) -eq $false) {
   New-Item -Path "C:\Program Files\WindowsPowerShell\DscService\Modules" -ItemType Container
}
Copy-Item $("C:\DevOps", $d.mR, "rsPlatform" -join '\') "C:\Program Files\WindowsPowerShell\Modules" -Recurse

### Execute rsBasePrep.ps1
PowerShell.exe "C:\DevOps\rsProvisioning\rsBasePrep.ps1" -ArgumentList "-ExecutionPolicy Bypass -Force"