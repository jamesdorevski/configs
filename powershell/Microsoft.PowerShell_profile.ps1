Import-Module -Name Microsoft.WinGet.CommandNotFound
Invoke-Expression (&jump shell pwsh | Out-String)

Set-PSReadLineOption -PredictionViewStyle ListView

if (Test-Path "C:\Users\micro\.jabba\jabba.ps1") { . "C:\Users\micro\.jabba\jabba.ps1" }


