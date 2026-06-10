param(
    [Parameter(Mandatory = $true)]
    [string[]]$Target
)

$source = Join-Path $PSScriptRoot '.claude'

foreach ($projectRoot in $Target) {
    if (-not (Test-Path $projectRoot)) {
        Write-Error "Target non trovato: $projectRoot"
        continue
    }
    $dest = Join-Path $projectRoot '.claude'
    robocopy $source $dest /MIR /XF settings.local.json /XD claude-archive | Out-Null
    if ($LASTEXITCODE -ge 8) {
        Write-Error "robocopy fallito per $dest (exit $LASTEXITCODE)"
    }
    else {
        Write-Host "Sincronizzato: $dest"
    }
}
exit 0
