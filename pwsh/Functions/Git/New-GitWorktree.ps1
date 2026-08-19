# Create a sibling git worktree on a new branch off a base branch (default: main)
# and seed it with build artefacts (node_modules, bin/obj, caches) from the
# current worktree, so the new copy is ready to run without a full rebuild.
function New-GitWorktree {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$BranchName,

        [Parameter(Mandatory, Position = 1)]
        [string]$DirectoryName,

        [Parameter(Position = 2)]
        [string]$BaseBranch = 'main'
    )

    $source = (Get-Location).Path
    $destination = Join-Path (Split-Path $source -Parent) $DirectoryName

    git worktree add -b $BranchName $destination $BaseBranch
    if ($LASTEXITCODE -ne 0) { throw "git worktree add failed with exit code $LASTEXITCODE" }

    $excludeDirs = @(
        '.git',
        'node_modules',                           # yarn / npm
        'bin', 'obj',                             # .NET build outputs
        '.svelte-kit', '.vite', '.astro',         # Svelte / Vite caches
        'dist', 'build', 'out',                   # generic frontend outputs
        'TestResults',                            # dotnet test
        'publish',                                # dotnet publish
        '.turbo', '.parcel-cache',
        '.nyc_output', 'coverage'                 # test/coverage outputs
    )
    $excludeFiles = @('*.log', '.DS_Store', 'Thumbs.db')

    robocopy $source $destination /E /XD @excludeDirs /XF @excludeFiles /NFL /NDL /NJH /NJS /NP
    if ($LASTEXITCODE -ge 8) { throw "robocopy failed with exit code $LASTEXITCODE" }
}

Set-Alias -Name gwt -Value New-GitWorktree
