#region Navigation
function ..   { Set-Location .. }
function ...  { Set-Location ../.. }
function .... { Set-Location ../../.. }
Set-Alias -Name mkcd -Value New-DirectoryAndEnter
#endregion

#region ls
function ll { ls -alF @args }
function la { ls -A @args }
function l  { ls -CF @args }
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
#endregion

#region Utilities
Set-Alias -Name sysinfo -Value Get-SystemInfo
Set-Alias -Name extract -Value Extract-Archive
#endregion

#region External Tools
function npp { & "C:\Program Files\Notepad++\notepad++.exe" $args }
#endregion
