# HI+ Optimizer Installer / Launcher
# https://github.com/softdaisy/Hi-Optimizer

$ErrorActionPreference = "Stop"

$BatUrl = "https://raw.githubusercontent.com/softdaisy/Hi-Optimizer/main/HIOptimizer.bat"
$BatFile = Join-Path $env:TEMP "HIOptimizer.bat"

Write-Host ""
Write-Host "======================================" -ForegroundColor Green
Write-Host "      HI+ OPTIMIZER LAUNCHER" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Green
Write-Host ""

Write-Host "[*] Downloading latest version..." -ForegroundColor Yellow

Invoke-WebRequest -Uri $BatUrl -OutFile $BatFile

Write-Host "[+] Download complete." -ForegroundColor Green
Write-Host "[*] Launching HI+ Optimizer..." -ForegroundColor Yellow

Start-Process cmd.exe -ArgumentList "/c `"$BatFile`"" -Verb RunAs -Wait

Remove-Item $BatFile -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "[✓] Finished." -ForegroundColor Green
