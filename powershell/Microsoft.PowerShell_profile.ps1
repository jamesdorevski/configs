Import-Module -Name Microsoft.WinGet.CommandNotFound
Invoke-Expression (&jump shell pwsh | Out-String)

Set-PSReadLineOption -EditMode Vi

function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    } else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}

Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

if (Test-Path "C:\Users\micro\.jabba\jabba.ps1") { . "C:\Users\micro\.jabba\jabba.ps1" }


