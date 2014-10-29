powershell.exe ""Set-ExecutionPolicy Bypass;
$wd1 = 'C:\DevOps';
$wd2 = 'C:\cloud-automation';
if(Test-Path $wd1) { $wd = $wd1 } else { $wd = $wd2 };
Ren ($wd + '\secrets') -NewName 'secrets.ps1';
. ""($wd + '\secrets.ps1')"";
if(!(Test-Path $d.wD)) {NI -Path ($d.wD) -ItemType container};
(New-Object System.Net.webclient).DownloadFile(($d.gS),($d.gPath));
Start -Wait $($d.gPath) -ArgumentList '/verysilent';
cd $($d.mod);
Start -Wait $($d.gX) -ArgumentList \"clone --branch $($d.cBr) $(($d.git), $($d.gCA), 'rsCommon.git' -join '/')\";
cd $($d.wD);
Start -Wait $($d.gX) -ArgumentList \"clone --branch $($d.provBr) $((($d.git), $($d.gCA), $($d.prov) -join '/'), '.git' -join '')\";
Powershell $($d.wD, $d.prov, $d.bS -join '\')""