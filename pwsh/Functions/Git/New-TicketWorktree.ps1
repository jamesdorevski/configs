function New-TicketWorktree {
    <#
    .SYNOPSIS
    Create per-ticket git worktrees in the CreditProtect, Frontend and/or maestro repos.

    .DESCRIPTION
    For each selected repo, runs New-GitWorktree (gwt) from that repo's main checkout,
    creating a sibling worktree under D:\creditprotect on a new branch named
    <Feature>/<TicketId>[/<Description>] and seeding it with build artefacts.

      -Be       D:\creditprotect\CreditProtect  ->  be-<TicketId>       off main
      -Fe       D:\creditprotect\Frontend       ->  fe-<TicketId>       off dev
      -Maestro  D:\creditprotect\maestro        ->  maestro-<TicketId>  off dev

    At least one of -Be, -Fe, -Maestro is required. Targets are processed in the
    order above; a failure stops processing of the remaining targets.

    .PARAMETER Feature
    First segment of the branch name (e.g. defaults, kyc).

    .PARAMETER TicketId
    Linear ticket key (e.g. DEV-1084). Used verbatim in both the branch name and the directory name.

    .PARAMETER Description
    Optional final branch segment. Omit to create <Feature>/<TicketId>.

    .PARAMETER Be
    Create the backend worktree from D:\creditprotect\CreditProtect off main.

    .PARAMETER Fe
    Create the frontend worktree from D:\creditprotect\Frontend off dev.

    .PARAMETER Maestro
    Create the maestro worktree from D:\creditprotect\maestro off dev.

    .EXAMPLE
    New-TicketWorktree defaults DEV-1084 director-defaults -Be -Fe

    .EXAMPLE
    New-TicketWorktree kyc DEV-1109 -Maestro

    .LINK
    New-GitWorktree

    .LINK
    Remove-TicketWorktree
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Feature,

        [Parameter(Mandatory, Position = 1)]
        [string]$TicketId,

        [Parameter(Position = 2)]
        [string]$Description,

        [switch]$Be,
        [switch]$Fe,
        [switch]$Maestro
    )

    if (-not ($Be -or $Fe -or $Maestro)) {
        throw 'Specify at least one of --be, --fe, --maestro'
    }

    $branch = if ($Description) { "$Feature/$TicketId/$Description" } else { "$Feature/$TicketId" }

    $targets = @(
        if ($Be)      { @{ Repo = 'D:\creditprotect\CreditProtect'; Directory = "be-$TicketId";      Base = 'main' } }
        if ($Fe)      { @{ Repo = 'D:\creditprotect\Frontend';      Directory = "fe-$TicketId";      Base = 'dev' } }
        if ($Maestro) { @{ Repo = 'D:\creditprotect\maestro';       Directory = "maestro-$TicketId"; Base = 'dev' } }
    )

    foreach ($target in $targets) {
        Push-Location $target.Repo
        try     { New-GitWorktree $branch $target.Directory $target.Base }
        finally { Pop-Location }
    }
}
