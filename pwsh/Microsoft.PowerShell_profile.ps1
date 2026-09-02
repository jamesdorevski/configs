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

#region Aliases (bash-style shims in .\Aliases.ps1)
$aliasesPath = Join-Path $PSScriptRoot 'Aliases.ps1'
if (Test-Path $aliasesPath) {
    . $aliasesPath
}
#endregion

#region Navigation
function New-DirectoryAndEnter {
    param([string]$Path)
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
    Set-Location $Path
}
#endregion

#region Git
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
#endregion

#region External Tools
# Zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# vfox
Invoke-Expression "$(vfox activate pwsh)"
#endregion

# coreutils

## Remove pwsh aliases
$coreutils = @(
    'arch','b2sum','base32','base64','basename','basenc','cat','cksum','comm','cp',
    'csplit','cut','date','df','dirname','du','echo','env','expr','factor',
    'false','find','fmt','fold','grep','head','hostname','join','link','ln',
    'ls','md5sum','mkdir','mktemp','mv','nl','nproc','numfmt','od','paste',
    'pathchk','pr','printenv','printf','ptx','pwd','readlink','realpath','rm','rmdir',
    'seq','sha1sum','sha224sum','sha256sum','sha384sum','sha512sum','shuf','sleep','sort','split',
    'stat','sum','tac','tail','tee','test','touch','tr','true','truncate',
    'tsort','unexpand','uniq','unlink','uptime','wc','xargs','yes'
)

foreach ($name in $coreutils) {
    if (Test-Path "Alias:$name")    { Remove-Item "Alias:$name" -Force }
    if (Test-Path "Function:$name") { Remove-Item "Function:$name" -Force }
}
#endregion
