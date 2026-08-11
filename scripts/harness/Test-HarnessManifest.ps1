[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)][string]$ManifestPath,
    [string]$RepoRoot,
    [switch]$Json
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'Harness.Common.ps1')

try {
    $root = Get-HarnessRepositoryRoot -RepoRoot $RepoRoot
    $result = Invoke-HarnessManifestEvaluation -ManifestPath $ManifestPath -RepoRoot $root
    $public = [pscustomobject]@{
        manifesto = $result.Manifesto
        vigencia_declarada = $result.VigenciaDeclarada
        vigencia_calculada = $result.VigenciaCalculada
        gate_atendido = $result.GateAtendido
        reutilizavel_como_gate = $result.Reutilizavel
        erros = @($result.Erros)
        motivos = @($result.Motivos)
    }

    if ($Json) { $public | ConvertTo-Json -Depth 8 }
    else {
        Write-Output ("MANIFESTO {0}" -f $result.Manifesto)
        Write-Output ("VIGENCIA_DECLARADA: {0}" -f $result.VigenciaDeclarada)
        Write-Output ("VIGENCIA_CALCULADA: {0}" -f $result.VigenciaCalculada)
        Write-Output ("GATE_ATENDIDO: {0}" -f $result.GateAtendido.ToString().ToUpperInvariant())
        Write-Output ("REUTILIZAVEL_COMO_GATE: {0}" -f $result.Reutilizavel.ToString().ToUpperInvariant())
        foreach ($errorItem in $result.Erros) { Write-Output ("ERRO: {0}" -f $errorItem) }
        foreach ($reason in $result.Motivos) { Write-Output ("MOTIVO: {0}" -f $reason) }
    }

    if ($result.VigenciaCalculada -eq 'MANIFESTO_INVALIDO') { exit 1 }
    if (($result.VigenciaCalculada -ne 'VALIDO') -or ($result.VigenciaDeclarada -ne $result.VigenciaCalculada) -or (-not $result.Reutilizavel)) { exit 2 }
    exit 0
}
catch {
    Write-Error $_.Exception.Message
    exit 1
}
