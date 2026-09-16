#region Navigation
function ..   { Set-Location .. }
function ...  { Set-Location ../.. }
function .... { Set-Location ../../.. }
Set-Alias -Name mkcd -Value New-DirectoryAndEnter
#endregion

#region ls
function ll { ls -alF --color=auto @args }
function la { ls -A @args }
function l  { ls -CF @args }
#endregion

#region Git
function g    { git @args }
function ga   { git add @args }
function gcm  { git commit -m @args }
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

function worktree {
    <#
    .SYNOPSIS
    Create or delete per-ticket git worktrees across the CreditProtect repos.

    .DESCRIPTION
    Front-end for New-TicketWorktree and Remove-TicketWorktree. Positional
    arguments after the subcommand are forwarded in order; any argument
    starting with - or -- is forwarded as a switch of the same name.

    Subcommands:
      create <feature> <ticket_id> [branch-description] [--be] [--fe] [--maestro]
      delete <ticket_id>

    .PARAMETER Command
    The subcommand to run: create or delete.

    .PARAMETER Rest
    Arguments forwarded to the subcommand's function.

    .EXAMPLE
    worktree create defaults DEV-1084 director-defaults --be --fe
    Creates D:\creditprotect\be-DEV-1084 (off main) and D:\creditprotect\fe-DEV-1084 (off dev),
    both on branch defaults/DEV-1084/director-defaults.

    .EXAMPLE
    worktree create kyc DEV-1109 --maestro
    Creates D:\creditprotect\maestro-DEV-1109 off dev on branch kyc/DEV-1109.

    .EXAMPLE
    worktree delete DEV-1084
    Force-removes every worktree under D:\creditprotect whose directory name ends in -DEV-1084.

    .LINK
    New-TicketWorktree

    .LINK
    Remove-TicketWorktree
    #>
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateSet('create', 'delete')]
        [string]$Command,

        [Parameter(ValueFromRemainingArguments)]
        [string[]]$Rest = @()
    )
    $positional = @($Rest | Where-Object { $_ -notmatch '^-' })
    $switches = @{}
    foreach ($flag in ($Rest | Where-Object { $_ -match '^-' })) {
        $switches[$flag.TrimStart('-')] = $true
    }
    switch ($Command) {
        'create' { New-TicketWorktree @positional @switches }
        'delete' { Remove-TicketWorktree @positional @switches }
    }
}
#endregion

#region Utilities
Set-Alias -Name sysinfo -Value Get-SystemInfo
Set-Alias -Name extract -Value Extract-Archive
#endregion

#region External Tools
function npp { & "C:\Program Files\Notepad++\notepad++.exe" $args }
#endregion
