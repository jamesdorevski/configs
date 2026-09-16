function Remove-TicketWorktree {
    <#
    .SYNOPSIS
    Force-remove every git worktree for a ticket under D:\creditprotect.

    .DESCRIPTION
    Lists the worktrees registered in the CreditProtect, Frontend and maestro repos and runs
    git worktree remove --force on each one whose directory name ends in -<TicketId>
    (case-insensitive). Entries whose directory has already been deleted (prunable) are
    removed too. Branches are left in place.

    .PARAMETER TicketId
    Linear ticket key (e.g. DEV-1084). Matched as a case-insensitive directory-name suffix.

    .EXAMPLE
    Remove-TicketWorktree DEV-1084
    Removes be-DEV-1084, fe-DEV-1084 and maestro-DEV-1084 if they exist.

    .LINK
    New-TicketWorktree
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$TicketId
    )

    $repos = @(
        'D:\creditprotect\CreditProtect',
        'D:\creditprotect\Frontend',
        'D:\creditprotect\maestro'
    )
    $removed = 0

    foreach ($repo in $repos) {
        $paths = git -C $repo worktree list --porcelain |
            Where-Object { $_ -like 'worktree *' } |
            ForEach-Object { $_.Substring(9) }

        foreach ($path in $paths) {
            if ((Split-Path $path -Leaf) -notlike "*-$TicketId") { continue }

            git -C $repo worktree remove --force $path
            if ($LASTEXITCODE -ne 0) { throw "git worktree remove failed for $path with exit code $LASTEXITCODE" }
            $removed++
        }
    }

    if ($removed -eq 0) { Write-Warning "No worktrees found with suffix -$TicketId under D:\creditprotect" }
}
