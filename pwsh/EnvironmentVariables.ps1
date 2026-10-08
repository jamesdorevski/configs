$PSDefaultParameterValues['*:Encoding'] = 'utf8'
[console]::InputEncoding  = [System.Text.UTF8Encoding]::new()
[console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

$ErrorView = 'ConciseView'

[Environment]::SetEnvironmentVariable('EDITOR', 'zed --wait', 'User')
