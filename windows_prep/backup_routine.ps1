<#
.SYNOPSIS
    Backs up specified folders to a ZIP file.
.DESCRIPTION
    Scans common web server directories (or custom ones), compresses them,
    and checks usage of google-genai SDK if installed.
#>

param (
    [string]$SourcePath = "C:\inetpub\wwwroot", # Default IIS path, change as needed
    [string]$BackupDest = "C:\Backup_Migration"
)

# 1. Setup Backup Directory
if (-not (Test-Path $BackupDest)) {
    New-Item -ItemType Directory -Path $BackupDest | Out-Null
    Write-Host "Created backup folder: $BackupDest" -ForeColor Green
}

$Timestamp = Get-Date -Format "yyyyMMdd_HHmm"
$ZipFile = "$BackupDest\WebBackup_$Timestamp.zip"

# 2. Check for Gemini CLI / Python SDK (User Request)
Write-Host "Checking for Google Gemini SDK..." -ForeColor Cyan
if (Get-Command python -ErrorAction SilentlyContinue) {
    try {
        python -c "import google.genai; print('Google GenAI SDK is available.')" 2>$null
        if ($?) {
            Write-Host "Gemini SDK detected! You can use 'python use_gemini.py' to organize files later." -ForeColor Green
        } else {
            Write-Host "Gemini SDK not found. Install with: pip install google-genai" -ForeColor Yellow
        }
    } catch {
        Write-Host "Could not verify Gemini SDK." -ForeColor Yellow
    }
} else {
    Write-Host "Python not found. Skipping Gemini check." -ForeColor Gray
}

# 3. Perform Backup
if (Test-Path $SourcePath) {
    Write-Host "Compressing '$SourcePath' to '$ZipFile'..." -ForeColor Cyan
    Compress-Archive -Path "$SourcePath\*" -DestinationPath $ZipFile -Force
    
    if (Test-Path $ZipFile) {
        $Size = (Get-Item $ZipFile).Length / 1MB
        Write-Host "Backup Complete! Size: $([math]::Round($Size, 2)) MB" -ForeColor Green
        Write-Host "Location: $ZipFile"
        Write-Host "IMPORTANT: Copy this ZIP file to your Mac or USB drive immediately!" -ForeColor Red
    } else {
        Write-Error "Backup failed to create zip file."
    }
} else {
    Write-Warning "Source path '$SourcePath' does not exist. Please edit the script to point to your data."
}
