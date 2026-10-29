# Installs Ishoo for this Windows user: downloads the latest ishoo.exe into
# %LOCALAPPDATA%\Programs\Ishoo and adds that folder to your PATH.
#   irm https://raw.githubusercontent.com/junovhs/ishoo-releases/main/install.ps1 | iex
$ErrorActionPreference = 'Stop'
$dir = Join-Path $env:LOCALAPPDATA 'Programs\Ishoo'
New-Item -ItemType Directory -Force $dir | Out-Null
$url = 'https://github.com/junovhs/ishoo-releases/releases/latest/download/ishoo-windows-x64.exe'
Write-Host "Downloading Ishoo..."
Invoke-WebRequest $url -OutFile (Join-Path $dir 'ishoo.exe') -UseBasicParsing
$path = [Environment]::GetEnvironmentVariable('Path', 'User')
if ((($path -split ';') | Where-Object { $_ }) -notcontains $dir) {
    [Environment]::SetEnvironmentVariable('Path', (($path.TrimEnd(';'), $dir) -join ';').TrimStart(';'), 'User')
}
$env:Path = "$env:Path;$dir"
Write-Host "Ishoo is installed. Run: ishoo"
