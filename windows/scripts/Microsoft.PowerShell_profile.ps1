# Aliases
Set-Alias -Name vi -Value nvim
Set-Alias -Name files -Value explorer

# Enable Starship
Invoke-Expression (&starship init powershell)

# Modules
Import-Module -Name Terminal-Icons

# PsReadLine settings
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Vi
