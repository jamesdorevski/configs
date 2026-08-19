function Enable-ArgumentCompleters {
    $cacheFile = Join-Path (Split-Path $PSScriptRoot -Parent) 'completions.generated.ps1'

    $generators = [ordered]@{
        dotnet  = { dotnet completions script pwsh }
        docker  = { docker completion powershell }
        kubectl = { kubectl completion powershell }
        pnpm    = { pnpm completion pwsh }
    }

    $stale = -not (Test-Path $cacheFile) -or
             (Get-Item $cacheFile).LastWriteTime -lt (Get-Date).AddDays(-7)

    if ($stale) {
        $blocks = foreach ($name in $generators.Keys) {
            if (Get-Command $name -ErrorAction SilentlyContinue) {
                try { & $generators[$name] | Out-String } catch { }
            }
        }
        $blocks -join "`n" | Set-Content -Path $cacheFile -Encoding UTF8
    }

    if (Test-Path $cacheFile) { . $cacheFile }

    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
            param($wordToComplete, $commandAst, $cursorPosition)
            [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
            $word = $wordToComplete.Replace('"', '""')
            $ast  = $commandAst.ToString().Replace('"', '""')
            winget complete --word="$word" --commandline "$ast" --position $cursorPosition |
                ForEach-Object {
                    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
                }
        }
    }
}
