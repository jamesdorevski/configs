# PowerShell Profile (CurrentUserCurrentHost)

#region Environment
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
[console]::InputEncoding  = [System.Text.UTF8Encoding]::new()
[console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$ErrorView = 'ConciseView'
#endregion

#region Styling
$PSStyle.Progress.View = 'Minimal'
$PSStyle.FileInfo.Directory = $PSStyle.Foreground.Blue + $PSStyle.Bold
#endregion

#region Modules
$modules = @('PSReadLine', 'posh-git', 'Terminal-Icons', 'CompletionPredictor')
foreach ($module in $modules) {
    if (Get-Module -ListAvailable -Name $module -ErrorAction SilentlyContinue) {
        Import-Module $module -ErrorAction SilentlyContinue
    }
}
#endregion

#region Functions (file-per-function under .\Functions\<region>\<Verb-Noun>.ps1)
$functionsPath = Join-Path $PSScriptRoot 'Functions'
if (Test-Path $functionsPath) {
    Get-ChildItem -Path $functionsPath -Filter '*.ps1' -Recurse -File |
        ForEach-Object { . $_.FullName }
}
#endregion

#region Integrations (file-per-integration under .\Integrations\<Name>.ps1)
$integrationsPath = Join-Path $PSScriptRoot 'Integrations'
if (Test-Path $integrationsPath) {
    Get-ChildItem -Path $integrationsPath -Filter '*.ps1' -File |
        ForEach-Object { . $_.FullName }
}
Enable-WindowsTerminalShellIntegration
#endregion

#region Configs (module config, file-per-module under .\Configs\<ModuleName>.ps1)
$configsPath = Join-Path $PSScriptRoot 'Configs'
if (Test-Path $configsPath) {
    Get-ChildItem -Path $configsPath -Filter '*.ps1' -File |
        ForEach-Object { . $_.FullName }
}
Enable-ArgumentCompleters
#endregion

#region Aliases
Set-Alias -Name which -Value Get-Command
Set-Alias -Name grep  -Value Select-String
Set-Alias -Name touch -Value New-Item
#endregion

#region Navigation
function ..   { Set-Location .. }
function ...  { Set-Location ../.. }
function .... { Set-Location ../../.. }

function New-DirectoryAndEnter {
    param([string]$Path)
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
    Set-Location $Path
}
Set-Alias -Name mkcd -Value New-DirectoryAndEnter
#endregion

#region Git
function g    { git @args }
function ga   { git add @args }
function gc   { git commit -m @args }
function gd   { git diff @args }
function gds  { git diff --staged @args }
function gaa  { git add . }
function gph  { git push @args }
function gpl  { git pull @args }
function gs   { git status @args }
function gsw  { git switch @args }
function gst  { git stash @args }
function gstp { git stash pop @args }
function gra  { git restore . }

function glr {
    $tag = git rev-list --tags --max-count=1 --skip=2 --no-walk
    if (-not $tag) {
        Write-Error "Fewer than 3 tags in this repo"
        return
    }
    git log "$tag..HEAD" --format='%Cred%h%Creset - %s %Cgreen(%as) %C(bold blue)<%an>%Creset'
}

# Additional git functions live in .\Functions\Git\
#endregion

#region Utilities
function Get-PublicIP {
    (Invoke-WebRequest -Uri "https://api.ipify.org" -UseBasicParsing).Content
}

function Get-SystemInfo {
    Write-Host "`nSystem Information:" -ForegroundColor Green
    Write-Host "===================" -ForegroundColor Green
    Write-Host "Computer Name: $env:COMPUTERNAME"
    Write-Host "User Name: $env:USERNAME"
    Write-Host "PowerShell Version: $($PSVersionTable.PSVersion)"
    Write-Host "OS: $([System.Environment]::OSVersion.VersionString)"
    Write-Host "Uptime: $((Get-Uptime).ToString())"
    Write-Host ""
}
Set-Alias -Name sysinfo -Value Get-SystemInfo

function Extract-Archive {
    param([string]$Path)
    if (Test-Path $Path) {
        switch -Regex ($Path) {
            '\.zip$'            { Expand-Archive $Path -DestinationPath (Get-Item $Path).BaseName }
            '\.tar\.gz$|\.tgz$' { tar -xzf $Path }
            '\.tar$'            { tar -xf $Path }
            '\.7z$'             { 7z x $Path }
            default             { Write-Host "Unsupported archive format" -ForegroundColor Red }
        }
    } else {
        Write-Host "File not found: $Path" -ForegroundColor Red
    }
}
Set-Alias -Name extract -Value Extract-Archive
#endregion

#region External Tools
function npp { & "C:\Program Files\Notepad++\notepad++.exe" $args }

# Zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# vfox
Invoke-Expression "$(vfox activate pwsh)"
#endregion
