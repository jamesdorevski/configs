# Aliases
Set-Alias -Name vi -Value nvim
Set-Alias -Name files -Value explorer

# Enable Starship
Invoke-Expression (&starship init powershell)

# Modules
Import-Module -Name Terminal-Icons
Import-Module PSReadLine

# PsReadLine settings
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
