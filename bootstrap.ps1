Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
if(!(Test-Path -Path "C:\DevOps")) { 
   New-Item -Path "C:\DevOps" -ItemType directory -Force
}
. "C:\DevOps\secrets.ps1"
(New-Object System.Net.webclient).DownloadFile(($d.gS),($d.gPath))
Start -Wait $($d.gPath) -ArgumentList "/verysilent"
cd $($d.mod)
Start -Wait $($d.gX) -ArgumentList "clone --branch $($d.cBr) $(($d.git), $($d.gCA), 'rsCommon.git' -join '/')"
cd $($d.wD)
Start -Wait $($d.gX) -ArgumentList "clone --branch $($d.provBr) $((($d.git), $($d.gCA), $($d.prov) -join '/'), '.git' -join '')"
Invoke-Expression "$($d.wD, $d.prov, $d.bS -join '\')"
