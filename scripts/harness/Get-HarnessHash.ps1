[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)][string[]]$Path,
    [string]$RepoRoot,
    [string]$ExpectedSha256,
    [switch]$Json
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'Harness.Common.ps1')

try {
    $root = Get-HarnessRepositoryRoot -RepoRoot $RepoRoot
    $expandedPaths = @()
    foreach ($item in $Path) { $expandedPaths += @($item -split ';' | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }) }
    if ($expandedPaths.Count -eq 0) { throw 'Informe ao menos um caminho nao vazio.' }
    if ((-not [string]::IsNullOrWhiteSpace($ExpectedSha256)) -and $expandedPaths.Count -ne 1) {
        throw '-ExpectedSha256 aceita exatamente um caminho.'
    }
    if ((-not [string]::IsNullOrWhiteSpace($ExpectedSha256)) -and (-not (Test-HarnessSha256Value -Value $ExpectedSha256))) {
        throw 'SHA-256 esperado invalido.'
    }

    $results = @()
    $mismatch = $false
    foreach ($item in $expandedPaths) {
        $full = Resolve-HarnessPath -RepoRoot $root -Path $item
        if (-not [System.IO.File]::Exists($full)) { throw "Arquivo inexistente: $item" }
        $hash = Get-HarnessSha256 -LiteralPath $full
        $matches = $null
        if (-not [string]::IsNullOrWhiteSpace($ExpectedSha256)) {
            $matches = ($hash -eq $ExpectedSha256.ToUpperInvariant())
            if (-not $matches) { $mismatch = $true }
        }
        $results += [pscustomobject]@{
            caminho = $item
            bytes = ([System.IO.FileInfo]$full).Length
            sha256 = $hash
            corresponde_ao_esperado = $matches
        }
    }

    if ($Json) {
        $results | ConvertTo-Json -Depth 6
    }
    else {
        foreach ($result in $results) {
            $suffix = ''
            if ($null -ne $result.corresponde_ao_esperado) {
                if ($result.corresponde_ao_esperado) { $suffix = ' [IGUAL]' } else { $suffix = ' [DIVERGENTE]' }
            }
            Write-Output ("SHA256 {0} {1} {2}{3}" -f $result.sha256, $result.bytes, $result.caminho, $suffix)
        }
    }
    if ($mismatch) { exit 2 }
    exit 0
}
catch {
    Write-Error $_.Exception.Message
    exit 1
}
