function Enable-WindowsTerminalShellIntegration {
    if (-not $env:WT_SESSION) {
        return
    }

    if ($GLOBAL:__WTShellIntegrationEnabled) {
        return
    }
    $GLOBAL:__WTShellIntegrationEnabled = $true

    $GLOBAL:__OriginalPrompt = $function:prompt
    $GLOBAL:__LastHistoryId = -1

    function GLOBAL:__Get-LastExitCode {
        if ($? -eq $true) { return 0 }
        $lastEntry = Get-History -Count 1
        if ($Error[0].InvocationInfo.HistoryId -eq $lastEntry.Id) { return -1 }
        return $LASTEXITCODE
    }

    function GLOBAL:prompt {
        $gle = __Get-LastExitCode
        $lastEntry = Get-History -Count 1

        $out = ''
        if ($GLOBAL:__LastHistoryId -ne -1) {
            if ($lastEntry.Id -eq $GLOBAL:__LastHistoryId) {
                $out += "$([char]27)]133;D$([char]7)"
            } else {
                $out += "$([char]27)]133;D;$gle$([char]7)"
            }
        }

        $out += "$([char]27)]133;A$([char]7)"

        $loc = $executionContext.SessionState.Path.CurrentLocation
        if ($loc.Provider.Name -eq 'FileSystem') {
            $out += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]7)"
        }

        $out += & $GLOBAL:__OriginalPrompt

        $out += "$([char]27)]133;B$([char]7)"

        $GLOBAL:__LastHistoryId = $lastEntry.Id
        return $out
    }
}
