# HI+ Optimizer Launcher
$ErrorActionPreference = "Stop"

$ZipUrl = "https://github.com/softdaisy/Hi-Optimizer/archive/refs/heads/main.zip"

$TempDir = Join-Path $env:TEMP "HIOptimizer"
$ZipFile = Join-Path $TempDir "Hi-Optimizer.zip"

# Create temp folder if needed
if (!(Test-Path $TempDir)) {
    New-Item -ItemType Directory -Path $TempDir | Out-Null
}

Write-Host ""
Write-Host "=======================================" -ForegroundColor Green
Write-Host "       HI+ OPTIMIZER LAUNCHER" -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Green
Write-Host ""

Write-Host "[*] Downloading latest version..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $ZipUrl -OutFile $ZipFile

Write-Host "[*] Extracting..." -ForegroundColor Yellow
Expand-Archive -Path $ZipFile -DestinationPath $TempDir -Force

$Bat = Get-ChildItem -Path $TempDir -Filter "HIOptimizer.bat" -Recurse | Select-Object -First 1

if (!$Bat) {
    Write-Host "[!] HIOptimizer.bat not found!" -ForegroundColor Red
    exit
}

Write-Host "[*] Launching..." -ForegroundColor Green

Start-Process `
    -FilePath "cmd.exe" `
    -WorkingDirectory $Bat.Directory.FullName `
    -ArgumentList "/k `"$($Bat.FullName)`"" `
    -Verb RunAs

Write-Host ""
Write-Host "[✓] Started successfully." -ForegroundColor Green
