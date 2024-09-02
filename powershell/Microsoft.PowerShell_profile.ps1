Import-Module -Name Microsoft.WinGet.CommandNotFound
Invoke-Expression (&jump shell pwsh | Out-String)

Set-PSReadLineOption -EditMode Vi

if (Test-Path "C:\Users\micro\.jabba\jabba.ps1") { . "C:\Users\micro\.jabba\jabba.ps1" }


