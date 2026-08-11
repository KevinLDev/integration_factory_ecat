[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)][string[]]$Path,
    [string]$RepoRoot,
    [string]$CountPattern,
    [int]$ExpectedCount = -1,
    [string]$IdPattern,
    [string]$IdGroup = 'id',
    [int]$ExpectedUniqueIds = -1,
    [switch]$Json
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'Harness.Common.ps1')

try {
    $root = Get-HarnessRepositoryRoot -RepoRoot $RepoRoot
    $expandedPaths = @()
    foreach ($item in $Path) { $expandedPaths += @($item -split ';' | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }) }
    if ($expandedPaths.Count -eq 0) { throw 'Informe ao menos um caminho nao vazio.' }
    if ((-not [string]::IsNullOrWhiteSpace($CountPattern)) -and ($ExpectedCount -lt 0)) {
        throw '-CountPattern exige -ExpectedCount.'
    }
    if ((-not [string]::IsNullOrWhiteSpace($IdPattern)) -and ($ExpectedUniqueIds -lt 0)) {
        throw '-IdPattern exige -ExpectedUniqueIds.'
    }

    $results = @()
    $failed = $false
    foreach ($item in $expandedPaths) {
        $issues = New-Object System.Collections.Generic.List[string]
        $full = Resolve-HarnessPath -RepoRoot $root -Path $item
        if (-not [System.IO.File]::Exists($full)) {
            $issues.Add('arquivo inexistente')
            $text = $null
        }
        else {
            $utf8 = Test-HarnessUtf8File -LiteralPath $full
            foreach ($problem in $utf8.Problemas) { $issues.Add($problem) }
            $text = $utf8.Texto
            if ($utf8.Valido -and ([System.IO.Path]::GetExtension($full) -ieq '.md')) {
                foreach ($problem in (Get-HarnessMarkdownProblems -LiteralPath $full -RepoRoot $root -Text $text)) {
                    $issues.Add($problem)
                }
            }
            if ($utf8.Valido -and (-not [string]::IsNullOrWhiteSpace($CountPattern))) {
                $count = [System.Text.RegularExpressions.Regex]::Matches($text, $CountPattern).Count
                if ($count -ne $ExpectedCount) { $issues.Add("contagem esperada=$ExpectedCount; atual=$count") }
            }
            if ($utf8.Valido -and (-not [string]::IsNullOrWhiteSpace($IdPattern))) {
                $ids = @()
                foreach ($match in [System.Text.RegularExpressions.Regex]::Matches($text, $IdPattern)) {
                    if (($IdGroup -ne '0') -and $match.Groups[$IdGroup].Success) { $ids += $match.Groups[$IdGroup].Value }
                    else { $ids += $match.Value }
                }
                $unique = @($ids | Sort-Object -Unique)
                $duplicates = @($ids | Group-Object | Where-Object { $_.Count -gt 1 } | ForEach-Object { $_.Name })
                if ($unique.Count -ne $ExpectedUniqueIds) { $issues.Add("IDs unicos esperados=$ExpectedUniqueIds; atuais=$($unique.Count)") }
                if ($duplicates.Count -gt 0) { $issues.Add("IDs duplicados: $($duplicates -join ', ')") }
            }
        }

        if ($issues.Count -gt 0) { $failed = $true }
        $results += [pscustomobject]@{
            caminho = $item
            resultado = $(if ($issues.Count -eq 0) { 'OK' } else { 'FALHA' })
            problemas = @($issues)
        }
    }

    if ($Json) { $results | ConvertTo-Json -Depth 8 }
    else {
        foreach ($result in $results) {
            Write-Output ("ARQUIVO {0} {1}" -f $result.resultado, $result.caminho)
            foreach ($problem in $result.problemas) { Write-Output ("  - {0}" -f $problem) }
        }
    }
    if ($failed) { exit 2 }
    exit 0
}
catch {
    Write-Error $_.Exception.Message
    exit 1
}
