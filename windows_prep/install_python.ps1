<#
.SYNOPSIS
    Installs Python 3.11 on Windows Server 2016.
.DESCRIPTION
    Downloads and installs Python 3.11, adds it to PATH, and upgrades pip.
    Run this as Administrator.
#>

$PythonVersion = "3.11.6"
$InstallerUrl = "https://www.python.org/ftp/python/$PythonVersion/python-$PythonVersion-amd64.exe"
$InstallerPath = "$env:TEMP\python-$PythonVersion-amd64.exe"

Write-Host "Downloading Python $PythonVersion..." -ForeColor Cyan
try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $InstallerUrl -OutFile $InstallerPath
}
catch {
    Write-Error "Failed to download Python. Check internet connection and TLS settings."
    exit 1
}

Write-Host "Installing Python (this may take a minute)..." -ForeColor Cyan
# Arguments: /quiet = silent, PrependPath=1 = add to PATH, Include_pip=1 = install pip
$InstallArgs = "/quiet InstallAllUsers=1 PrependPath=1 Include_pip=1"
Start-Process -FilePath $InstallerPath -ArgumentList $InstallArgs -Wait

Write-Host "Verifying installation..." -ForeColor Cyan
# Refresh env vars for the current session
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

if (Get-Command python -ErrorAction SilentlyContinue) {
    $ver = python --version
    Write-Host "Success: $ver installed!" -ForeColor Green
    
    Write-Host "Upgrading pip..."
    python -m pip install --upgrade pip
}
else {
    Write-Error "Python installation apparently finished, but 'python' command is not found yet. You may need to restart the shell or the server."
}
