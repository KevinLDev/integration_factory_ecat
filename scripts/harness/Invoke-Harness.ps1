[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)][ValidateSet('hash', 'files', 'manifest', 'checkpoint', 'selftest')][string]$Action,
    [Parameter(ValueFromRemainingArguments = $true)][string[]]$Arguments
)

$targets = @{
    hash = 'Get-HarnessHash.ps1'
    files = 'Test-HarnessFiles.ps1'
    manifest = 'Test-HarnessManifest.ps1'
    checkpoint = 'Test-HarnessCheckpoint.ps1'
    selftest = 'Invoke-HarnessTests.ps1'
}

& powershell.exe -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot $targets[$Action]) @Arguments
exit $LASTEXITCODE
