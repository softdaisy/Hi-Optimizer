# HI+ Optimizer Installer
# Downloads the latest GitHub repository and launches HIOptimizer.bat

$ErrorActionPreference = "Stop"

$RepoZip = "https://github.com/softdaisy/Hi-Optimizer/archive/refs/heads/main.zip"

$TempRoot = Join-Path $env:TEMP "HIOptimizer"
$ZipFile  = Join-Path $TempRoot "Hi-Optimizer.zip"

# Clean old files
Remove-Item $TempRoot -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $TempRoot | Out-Null

Write-Host ""
Write-Host "======================================" -ForegroundColor Green
Write-Host "      HI+ OPTIMIZER LAUNCHER" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Green
Write-Host ""

Write-Host "[*] Downloading latest version..." -ForegroundColor Yellow
Invoke-WebRequest $RepoZip -OutFile $ZipFile

Write-Host "[*] Extracting files..." -ForegroundColor Yellow
Expand-Archive $ZipFile -DestinationPath $TempRoot -Force

# Find HIOptimizer.bat anywhere inside the extracted repository
$Bat = Get-ChildItem $TempRoot -Filter "HIOptimizer.bat" -Recurse | Select-Object -First 1

if (-not $Bat) {
    Write-Host ""
    Write-Host "[!] HIOptimizer.bat was not found." -ForegroundColor Red
    Pause
    exit
}

Write-Host "[*] Launching HI+ Optimizer..." -ForegroundColor Green

Start-Process cmd.exe `
    -ArgumentList "/c `"$($Bat.FullName)`"" `
    -Verb RunAs `
    -Wait

Write-Host ""
Write-Host "[*] Cleaning up..." -ForegroundColor Yellow

Remove-Item $TempRoot -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "[✓] Done." -ForegroundColor Green
