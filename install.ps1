@@ -1,10 +1,16 @@
# HI+ Optimizer Installer / Launcher
# https://github.com/softdaisy/Hi-Optimizer
# HI+ Optimizer Installer
# Downloads the latest GitHub repository and launches HIOptimizer.bat

$ErrorActionPreference = "Stop"

$BatUrl = "https://raw.githubusercontent.com/softdaisy/Hi-Optimizer/refs/heads/main/HIOptimizer.bat"
$BatFile = Join-Path $env:TEMP "HIOptimizer.bat"
$RepoZip = "https://github.com/softdaisy/Hi-Optimizer/archive/refs/heads/main.zip"

$TempRoot = Join-Path $env:TEMP "HIOptimizer"
$ZipFile  = Join-Path $TempRoot "Hi-Optimizer.zip"

# Clean old files
Remove-Item $TempRoot -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $TempRoot | Out-Null

Write-Host ""
Write-Host "======================================" -ForegroundColor Green
@@ -13,15 +19,32 @@ Write-Host "======================================" -ForegroundColor Green
Write-Host ""

Write-Host "[*] Downloading latest version..." -ForegroundColor Yellow
Invoke-WebRequest $RepoZip -OutFile $ZipFile

Write-Host "[*] Extracting files..." -ForegroundColor Yellow
Expand-Archive $ZipFile -DestinationPath $TempRoot -Force

Invoke-WebRequest -Uri $BatUrl -OutFile $BatFile
# Find HIOptimizer.bat anywhere inside the extracted repository
$Bat = Get-ChildItem $TempRoot -Filter "HIOptimizer.bat" -Recurse | Select-Object -First 1

Write-Host "[+] Download complete." -ForegroundColor Green
Write-Host "[*] Launching HI+ Optimizer..." -ForegroundColor Yellow
if (-not $Bat) {
    Write-Host ""
    Write-Host "[!] HIOptimizer.bat was not found." -ForegroundColor Red
    Pause
    exit
}

Start-Process cmd.exe -ArgumentList "/c `"$BatFile`"" -Verb RunAs -Wait
Write-Host "[*] Launching HI+ Optimizer..." -ForegroundColor Green

Start-Process cmd.exe `
    -ArgumentList "/c `"$($Bat.FullName)`"" `
    -Verb RunAs `
    -Wait

Write-Host ""
Write-Host "[*] Cleaning up..." -ForegroundColor Yellow

Remove-Item $BatFile -Force -ErrorAction SilentlyContinue
Remove-Item $TempRoot -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "[✓] Finished." -ForegroundColor Green
Write-Host "[✓] Done." -ForegroundColor Green