[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)][string]$CheckpointPath,
    [string]$RepoRoot,
    [switch]$Json
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'Harness.Common.ps1')

try {
    $root = Get-HarnessRepositoryRoot -RepoRoot $RepoRoot
    $result = Invoke-HarnessCheckpointEvaluation -CheckpointPath $CheckpointPath -RepoRoot $root
    $public = [pscustomobject]@{
        checkpoint = $result.Checkpoint
        resultado = $result.Resultado
        erros = @($result.Erros)
        divergencias = @($result.Divergencias)
    }
    if ($Json) { $public | ConvertTo-Json -Depth 8 }
    else {
        Write-Output ("CHECKPOINT {0}" -f $result.Checkpoint)
        Write-Output ("RETOMADA: {0}" -f $result.Resultado)
        foreach ($errorItem in $result.Erros) { Write-Output ("ERRO: {0}" -f $errorItem) }
        foreach ($difference in $result.Divergencias) { Write-Output ("DIVERGENCIA: {0}" -f $difference) }
    }
    if ($result.Resultado -eq 'CHECKPOINT_INVALIDO') { exit 1 }
    if ($result.Resultado -ne 'RETOMADA_SEGURA') { exit 2 }
    exit 0
}
catch {
    Write-Error $_.Exception.Message
    exit 1
}
