[CmdletBinding()]
param(
    [string]$RepoRoot,
    [Parameter(Mandatory = $true)][string]$ManifestDirectory,
    [Parameter(Mandatory = $true)][string]$Expect,
    [string]$TextPath = '',
    [switch]$Json
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'Harness.Common.ps1')

$checks = New-Object System.Collections.Generic.List[object]
$failed = $false
$testDirectory = $null
$testRootExisted = $true
$dotTmpExisted = $true

function Add-Check {
    param([string]$Name, [bool]$Passed, [string]$Detail)
    $script:checks.Add([pscustomobject]@{ teste = $Name; resultado = $(if ($Passed) { 'OK' } else { 'FALHA' }); detalhe = $Detail })
    if (-not $Passed) { $script:failed = $true }
}

function Write-Utf8Fixture {
    param([string]$FullPath, [string]$Content)
    $parent = [System.IO.Path]::GetDirectoryName($FullPath)
    if (-not [System.IO.Directory]::Exists($parent)) { $null = [System.IO.Directory]::CreateDirectory($parent) }
    $encoding = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($FullPath, $Content, $encoding)
}

try {
    $root = Get-HarnessRepositoryRoot -RepoRoot $RepoRoot
    $manifestDirFull = Resolve-HarnessPath -RepoRoot $root -Path $ManifestDirectory
    if (-not [System.IO.Directory]::Exists($manifestDirFull)) { throw "Diretorio de manifestos inexistente: $ManifestDirectory" }

    $expectations = @($Expect -split ';' | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
    if ($expectations.Count -eq 0) { throw 'Informe ao menos uma expectativa de manifesto.' }
    foreach ($expectation in $expectations) {
        $separator = $expectation.LastIndexOf('=')
        if ($separator -le 0) { throw "Expectativa invalida: $expectation" }
        $fileName = $expectation.Substring(0, $separator)
        $expectedState = $expectation.Substring($separator + 1)
        $manifestPath = (($ManifestDirectory.TrimEnd('/', '\')) + '/' + $fileName).Replace('\', '/')
        $evaluation = Invoke-HarnessManifestEvaluation -ManifestPath $manifestPath -RepoRoot $root
        $expectsReuse = ($expectedState -eq 'VALIDO')
        $passed = ($evaluation.VigenciaCalculada -eq $expectedState) -and ($evaluation.VigenciaDeclarada -eq $expectedState) -and ($evaluation.Reutilizavel -eq $expectsReuse)
        Add-Check -Name "manifesto $fileName" -Passed $passed -Detail ("declarada={0}; calculada={1}; gate={2}; reutilizavel={3}; motivos={4}" -f $evaluation.VigenciaDeclarada, $evaluation.VigenciaCalculada, $evaluation.GateAtendido, $evaluation.Reutilizavel, ($evaluation.Motivos -join ' | '))
    }

    $textPaths = @($TextPath -split ';' | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
    foreach ($item in $textPaths) {
        $full = Resolve-HarnessPath -RepoRoot $root -Path $item
        $utf8 = Test-HarnessUtf8File -LiteralPath $full
        $issues = @($utf8.Problemas)
        if ($utf8.Valido -and ([System.IO.Path]::GetExtension($full) -ieq '.md')) {
            $issues += @(Get-HarnessMarkdownProblems -LiteralPath $full -RepoRoot $root -Text $utf8.Texto)
        }
        Add-Check -Name "texto $item" -Passed ($issues.Count -eq 0) -Detail ($issues -join ' | ')
    }

    $dotTmp = Resolve-HarnessPath -RepoRoot $root -Path '.tmp'
    $testRoot = Resolve-HarnessPath -RepoRoot $root -Path '.tmp/harness-tests'
    $dotTmpExisted = [System.IO.Directory]::Exists($dotTmp)
    $testRootExisted = [System.IO.Directory]::Exists($testRoot)
    $testDirectory = Join-Path $testRoot ([System.Guid]::NewGuid().ToString('N'))
    $testDirectory = [System.IO.Path]::GetFullPath($testDirectory)
    $testPrefix = [System.IO.Path]::GetFullPath($testRoot).TrimEnd('\') + '\'
    if (-not $testDirectory.StartsWith($testPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw 'Diretorio temporario calculado fora do escopo permitido.'
    }
    $null = [System.IO.Directory]::CreateDirectory($testDirectory)
    $relativeBase = '.tmp/harness-tests/' + [System.IO.Path]::GetFileName($testDirectory)

    $upstreamData = "$relativeBase/upstream.txt"
    $downstreamData = "$relativeBase/downstream.txt"
    $upstreamAudit = "$relativeBase/auditoria-upstream.md"
    $downstreamAudit = "$relativeBase/auditoria-downstream.md"
    $terminalData = "$relativeBase/terminal.txt"
    $terminalAudit = "$relativeBase/auditoria-terminal.md"
    $upstreamManifest = "$relativeBase/PASSO-01.yaml"
    $downstreamManifest = "$relativeBase/PASSO-02.yaml"
    $terminalManifest = "$relativeBase/PASSO-CADEIA-03.yaml"
    $checkpointPath = "$relativeBase/CHECKPOINT.yaml"

    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $upstreamData) -Content "versao-1`n"
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $downstreamData) -Content "resultado-estavel`n"
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $terminalData) -Content "resultado-terminal`n"
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $upstreamAudit) -Content "# Auditoria upstream`n`nAPROVADA`n"
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $downstreamAudit) -Content "# Auditoria downstream`n`nAPROVADA`n"
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $terminalAudit) -Content "# Auditoria terminal`n`nAPROVADA`n"

    $upHash = Get-HarnessSha256 -LiteralPath (Resolve-HarnessPath -RepoRoot $root -Path $upstreamData)
    $downHash = Get-HarnessSha256 -LiteralPath (Resolve-HarnessPath -RepoRoot $root -Path $downstreamData)
    $terminalHash = Get-HarnessSha256 -LiteralPath (Resolve-HarnessPath -RepoRoot $root -Path $terminalData)
    $upAuditHash = Get-HarnessSha256 -LiteralPath (Resolve-HarnessPath -RepoRoot $root -Path $upstreamAudit)
    $downAuditHash = Get-HarnessSha256 -LiteralPath (Resolve-HarnessPath -RepoRoot $root -Path $downstreamAudit)
    $terminalAuditHash = Get-HarnessSha256 -LiteralPath (Resolve-HarnessPath -RepoRoot $root -Path $terminalAudit)

    $upObject = [ordered]@{
        schema = 'harness.manifesto-etapa.v1'
        identidade = [ordered]@{ tipo_alvo = 'TESTE'; alvo = 'fixture'; slug = 'fixture'; jornada = 'TESTE'; etapa = '01'; execucao = $relativeBase }
        resultado = [ordered]@{ status = 'CONCLUIDA'; tipo_auditoria = 'PROFUNDA'; auditoria_vigente = [ordered]@{ caminho = $upstreamAudit; sha256 = $upAuditHash; resultado = 'APROVADA' } }
        fontes = @()
        entradas = @()
        saidas = @([ordered]@{ caminho = $upstreamData; sha256 = $upHash }, [ordered]@{ caminho = $upstreamAudit; sha256 = $upAuditHash })
        dependencias = @()
        gate_reutilizacao = [ordered]@{ requisitos = @([ordered]@{ campo = 'resultado.status'; valor_esperado = 'CONCLUIDA' }, [ordered]@{ campo = 'resultado.auditoria_vigente.resultado'; valor_esperado = 'APROVADA' }) }
        vigencia = [ordered]@{ estado = 'VALIDO'; motivo = $null }
    }
    $downObject = [ordered]@{
        schema = 'harness.manifesto-etapa.v1'
        identidade = [ordered]@{ tipo_alvo = 'TESTE'; alvo = 'fixture'; slug = 'fixture'; jornada = 'TESTE'; etapa = '02'; execucao = $relativeBase }
        resultado = [ordered]@{ status = 'CONCLUIDA'; tipo_auditoria = 'NORMAL'; auditoria_vigente = [ordered]@{ caminho = $downstreamAudit; sha256 = $downAuditHash; resultado = 'APROVADA' } }
        fontes = @()
        entradas = @()
        saidas = @([ordered]@{ caminho = $downstreamData; sha256 = $downHash }, [ordered]@{ caminho = $downstreamAudit; sha256 = $downAuditHash })
        dependencias = @([ordered]@{ etapa_upstream = '01'; manifesto_upstream = $upstreamManifest; hashes_esperados = @([ordered]@{ caminho = $upstreamData; sha256 = $upHash }, [ordered]@{ caminho = $upstreamAudit; sha256 = $upAuditHash }) })
        gate_reutilizacao = [ordered]@{ requisitos = @([ordered]@{ campo = 'resultado.status'; valor_esperado = 'CONCLUIDA' }, [ordered]@{ campo = 'resultado.auditoria_vigente.resultado'; valor_esperado = 'APROVADA' }) }
        vigencia = [ordered]@{ estado = 'VALIDO'; motivo = $null }
    }
    $terminalObject = [ordered]@{
        schema = 'harness.manifesto-etapa.v1'
        identidade = [ordered]@{ tipo_alvo = 'TESTE'; alvo = 'fixture'; slug = 'fixture'; jornada = 'TESTE'; etapa = '03'; execucao = $relativeBase }
        resultado = [ordered]@{ status = 'CONCLUIDA'; tipo_auditoria = 'NORMAL'; auditoria_vigente = [ordered]@{ caminho = $terminalAudit; sha256 = $terminalAuditHash; resultado = 'APROVADA' } }
        fontes = @()
        entradas = @()
        saidas = @([ordered]@{ caminho = $terminalData; sha256 = $terminalHash }, [ordered]@{ caminho = $terminalAudit; sha256 = $terminalAuditHash })
        dependencias = @([ordered]@{ etapa_upstream = '02'; manifesto_upstream = $downstreamManifest; hashes_esperados = @([ordered]@{ caminho = $downstreamData; sha256 = $downHash }, [ordered]@{ caminho = $downstreamAudit; sha256 = $downAuditHash }) })
        gate_reutilizacao = [ordered]@{ requisitos = @([ordered]@{ campo = 'resultado.status'; valor_esperado = 'CONCLUIDA' }, [ordered]@{ campo = 'resultado.auditoria_vigente.resultado'; valor_esperado = 'APROVADA' }) }
        vigencia = [ordered]@{ estado = 'VALIDO'; motivo = $null }
    }
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $upstreamManifest) -Content (($upObject | ConvertTo-Json -Depth 12) + "`n")
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $downstreamManifest) -Content (($downObject | ConvertTo-Json -Depth 12) + "`n")
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $terminalManifest) -Content (($terminalObject | ConvertTo-Json -Depth 12) + "`n")

    $before = Invoke-HarnessManifestEvaluation -ManifestPath $downstreamManifest -RepoRoot $root
    Add-Check -Name 'simulacao baseline valida' -Passed ($before.VigenciaCalculada -eq 'VALIDO') -Detail $before.VigenciaCalculada
    $terminalBefore = Invoke-HarnessManifestEvaluation -ManifestPath $terminalManifest -RepoRoot $root
    Add-Check -Name 'cadeia transitiva baseline valida' -Passed (($terminalBefore.VigenciaCalculada -eq 'VALIDO') -and $terminalBefore.Reutilizavel) -Detail ("calculada={0}; reutilizavel={1}" -f $terminalBefore.VigenciaCalculada, $terminalBefore.Reutilizavel)

    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $upstreamData) -Content "versao-2`n"
    $changed = Invoke-HarnessManifestEvaluation -ManifestPath $downstreamManifest -RepoRoot $root
    Add-Check -Name 'simulacao invalida downstream' -Passed ($changed.VigenciaCalculada -eq 'INVALIDADO_POR_MUDANCA_UPSTREAM') -Detail $changed.VigenciaCalculada
    $terminalChanged = Invoke-HarnessManifestEvaluation -ManifestPath $terminalManifest -RepoRoot $root
    Add-Check -Name 'invalida cascata transitiva' -Passed (($terminalChanged.VigenciaCalculada -eq 'INVALIDADO_POR_MUDANCA_UPSTREAM') -and (-not $terminalChanged.Reutilizavel)) -Detail ("calculada={0}; reutilizavel={1}" -f $terminalChanged.VigenciaCalculada, $terminalChanged.Reutilizavel)

    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $upstreamData) -Content "versao-1`n"
    $restored = Invoke-HarnessManifestEvaluation -ManifestPath $downstreamManifest -RepoRoot $root
    Add-Check -Name 'simulacao restaurada' -Passed ($restored.VigenciaCalculada -eq 'VALIDO') -Detail $restored.VigenciaCalculada
    $terminalRestored = Invoke-HarnessManifestEvaluation -ManifestPath $terminalManifest -RepoRoot $root
    Add-Check -Name 'cascata transitiva restaurada' -Passed (($terminalRestored.VigenciaCalculada -eq 'VALIDO') -and $terminalRestored.Reutilizavel) -Detail ("calculada={0}; reutilizavel={1}" -f $terminalRestored.VigenciaCalculada, $terminalRestored.Reutilizavel)

    $upObject.resultado.status = 'PENDENTE'
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $upstreamManifest) -Content (($upObject | ConvertTo-Json -Depth 12) + "`n")
    $upstreamWithoutGate = Invoke-HarnessManifestEvaluation -ManifestPath $upstreamManifest -RepoRoot $root
    $downstreamBlockedByGate = Invoke-HarnessManifestEvaluation -ManifestPath $downstreamManifest -RepoRoot $root
    $gatePropagationPassed = ($upstreamWithoutGate.VigenciaCalculada -eq 'VALIDO') -and (-not $upstreamWithoutGate.Reutilizavel) -and
        ($downstreamBlockedByGate.VigenciaCalculada -eq 'INVALIDADO_POR_MUDANCA_UPSTREAM') -and (-not $downstreamBlockedByGate.Reutilizavel)
    Add-Check -Name 'upstream sem gate invalida downstream' -Passed $gatePropagationPassed -Detail ("upstream_calculada={0}; upstream_reutilizavel={1}; downstream={2}" -f $upstreamWithoutGate.VigenciaCalculada, $upstreamWithoutGate.Reutilizavel, $downstreamBlockedByGate.VigenciaCalculada)

    $upObject.resultado.status = 'CONCLUIDA'
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $upstreamManifest) -Content (($upObject | ConvertTo-Json -Depth 12) + "`n")
    $restoredAfterGate = Invoke-HarnessManifestEvaluation -ManifestPath $downstreamManifest -RepoRoot $root
    Add-Check -Name 'upstream restaurado apos gate' -Passed (($restoredAfterGate.VigenciaCalculada -eq 'VALIDO') -and $restoredAfterGate.Reutilizavel) -Detail ("calculada={0}; reutilizavel={1}" -f $restoredAfterGate.VigenciaCalculada, $restoredAfterGate.Reutilizavel)

    $gateManifest = "$relativeBase/PASSO-03.yaml"
    $gateObject = (($upObject | ConvertTo-Json -Depth 12) | ConvertFrom-Json)
    $gateObject.identidade.jornada = 'INTEGRAR_NOVA_FERRAMENTA'
    $gateObject.identidade.etapa = '03-VALIDAR-FERRAMENTA-CADASTRADA'
    $gateObject.resultado.tipo_auditoria = 'NORMAL'
    $gateObject.resultado | Add-Member -NotePropertyName 'resultado_tecnico' -NotePropertyValue 'NAO_APTO_PARA_INTEGRACOES'
    $gateObject.resultado | Add-Member -NotePropertyName 'prontidao' -NotePropertyValue 'NAO_HOMOLOGADA'
    $gateObject.gate_reutilizacao.requisitos = @(
        [pscustomobject]@{ campo = 'resultado.status'; valor_esperado = 'CONCLUIDA' },
        [pscustomobject]@{ campo = 'resultado.auditoria_vigente.resultado'; valor_esperado = 'APROVADA' }
    )
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $gateManifest) -Content (($gateObject | ConvertTo-Json -Depth 12) + "`n")
    $gateDenied = Invoke-HarnessManifestEvaluation -ManifestPath $gateManifest -RepoRoot $root
    Add-Check -Name 'gate especializado impede reutilizacao' -Passed (($gateDenied.VigenciaCalculada -eq 'MANIFESTO_INVALIDO') -and (-not $gateDenied.GateAtendido) -and (-not $gateDenied.Reutilizavel)) -Detail ("calculada={0}; gate={1}; reutilizavel={2}; erros={3}" -f $gateDenied.VigenciaCalculada, $gateDenied.GateAtendido, $gateDenied.Reutilizavel, ($gateDenied.Erros -join ' | '))

    $bypassManifest = 'parceiros/execucoes/ferramentas/fixture/manifestos/PASSO-03.yaml'
    $bypassData = 'parceiros/execucoes/ferramentas/fixture/historico.md'
    $bypassAudit = 'parceiros/execucoes/ferramentas/fixture/auditoria.md'
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $testDirectory -Path $bypassData) -Content "# Historico`n"
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $testDirectory -Path $bypassAudit) -Content "# Auditoria`n`nAPROVADA`n"
    $bypassDataHash = Get-HarnessSha256 -LiteralPath (Resolve-HarnessPath -RepoRoot $testDirectory -Path $bypassData)
    $bypassAuditHash = Get-HarnessSha256 -LiteralPath (Resolve-HarnessPath -RepoRoot $testDirectory -Path $bypassAudit)
    $bypassObject = [ordered]@{
        schema = 'harness.manifesto-etapa.v1'
        identidade = [ordered]@{ tipo_alvo = 'FERRAMENTA'; alvo = 'fixture'; slug = 'fixture'; jornada = 'JORNADA_ADULTERADA'; etapa = '03-VALIDAR-FERRAMENTA-CADASTRADA'; execucao = 'parceiros/execucoes/ferramentas/fixture' }
        resultado = [ordered]@{ status = 'CONCLUIDA'; tipo_auditoria = 'NORMAL'; auditoria_vigente = [ordered]@{ caminho = $bypassAudit; sha256 = $bypassAuditHash; resultado = 'APROVADA' }; resultado_tecnico = 'NAO_APTO_PARA_INTEGRACOES'; prontidao = 'NAO_HOMOLOGADA' }
        fontes = @()
        entradas = @()
        saidas = @([ordered]@{ caminho = $bypassData; sha256 = $bypassDataHash }, [ordered]@{ caminho = $bypassAudit; sha256 = $bypassAuditHash })
        dependencias = @()
        gate_reutilizacao = [ordered]@{ requisitos = @([ordered]@{ campo = 'resultado.status'; valor_esperado = 'CONCLUIDA' }, [ordered]@{ campo = 'resultado.auditoria_vigente.resultado'; valor_esperado = 'APROVADA' }) }
        vigencia = [ordered]@{ estado = 'VALIDO'; motivo = $null }
    }
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $testDirectory -Path $bypassManifest) -Content (($bypassObject | ConvertTo-Json -Depth 12) + "`n")
    $identityBypass = Invoke-HarnessManifestEvaluation -ManifestPath $bypassManifest -RepoRoot $testDirectory
    Add-Check -Name 'identidade adulterada nao contorna gate 03' -Passed (($identityBypass.VigenciaCalculada -eq 'MANIFESTO_INVALIDO') -and (-not $identityBypass.GateAtendido) -and (-not $identityBypass.Reutilizavel)) -Detail ("calculada={0}; gate={1}; reutilizavel={2}; erros={3}" -f $identityBypass.VigenciaCalculada, $identityBypass.GateAtendido, $identityBypass.Reutilizavel, ($identityBypass.Erros -join ' | '))

    $invalidDependencyManifest = "$relativeBase/PASSO-DEPENDENCIA-INVALIDA.yaml"
    $invalidDependencyObject = (($downObject | ConvertTo-Json -Depth 12) | ConvertFrom-Json)
    $invalidDependencyObject.identidade.etapa = 'DEPENDENCIA-INVALIDA'
    $invalidDependencyObject.dependencias[0].hashes_esperados = @()
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $invalidDependencyManifest) -Content (($invalidDependencyObject | ConvertTo-Json -Depth 12) + "`n")
    $invalidDependency = Invoke-HarnessManifestEvaluation -ManifestPath $invalidDependencyManifest -RepoRoot $root
    Add-Check -Name 'dependencia sem hashes e rejeitada' -Passed ($invalidDependency.VigenciaCalculada -eq 'MANIFESTO_INVALIDO') -Detail ("calculada={0}; erros={1}" -f $invalidDependency.VigenciaCalculada, ($invalidDependency.Erros -join ' | '))

    $checkpointObject = [ordered]@{
        schema = 'harness.checkpoint-execucao.v1'
        identidade = [ordered]@{ tipo_alvo = 'TESTE'; alvo = 'fixture'; slug = 'fixture'; execucao = $relativeBase }
        tarefa_atual = 'teste de retomada'
        etapa = '02'
        inicio = '2026-01-01T00:00:00-03:00'
        ultima_atualizacao = '2026-01-01T00:10:00-03:00'
        orcamento_minutos = 25
        fase_atual = 'VALIDACAO'
        fases_concluidas = @('PREPARACAO')
        proxima_fase = 'AUDITORIA'
        linha_de_base = @([ordered]@{ caminho = $upstreamData; sha256 = $upHash })
        arquivos_produzidos = @([ordered]@{ caminho = $downstreamData; sha256 = $downHash })
        arquivos_protegidos = @([ordered]@{ caminho = $downstreamData; sha256 = $downHash })
        auditoria_iniciada = $false
        ultimo_ponto_seguro = 'baseline e saida persistidas'
        motivo_pausa = 'teste controlado'
    }
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $checkpointPath) -Content (($checkpointObject | ConvertTo-Json -Depth 12) + "`n")
    $resumeSafe = Invoke-HarnessCheckpointEvaluation -CheckpointPath $checkpointPath -RepoRoot $root
    Add-Check -Name 'checkpoint retomada segura' -Passed ($resumeSafe.Resultado -eq 'RETOMADA_SEGURA') -Detail ("{0}; erros={1}; divergencias={2}" -f $resumeSafe.Resultado, ($resumeSafe.Erros -join ' | '), ($resumeSafe.Divergencias -join ' | '))

    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $downstreamData) -Content "mudanca-externa`n"
    $resumeBlocked = Invoke-HarnessCheckpointEvaluation -CheckpointPath $checkpointPath -RepoRoot $root
    Add-Check -Name 'checkpoint bloqueia divergencia' -Passed ($resumeBlocked.Resultado -eq 'RETOMADA_BLOQUEADA_POR_DIVERGENCIA') -Detail ("{0}; erros={1}; divergencias={2}" -f $resumeBlocked.Resultado, ($resumeBlocked.Erros -join ' | '), ($resumeBlocked.Divergencias -join ' | '))

    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $downstreamData) -Content "resultado-estavel`n"
    $resumeRestored = Invoke-HarnessCheckpointEvaluation -CheckpointPath $checkpointPath -RepoRoot $root
    Add-Check -Name 'checkpoint restaurado' -Passed ($resumeRestored.Resultado -eq 'RETOMADA_SEGURA') -Detail ("{0}; erros={1}; divergencias={2}" -f $resumeRestored.Resultado, ($resumeRestored.Erros -join ' | '), ($resumeRestored.Divergencias -join ' | '))

    $invalidCheckpointPath = "$relativeBase/CHECKPOINT-INVALIDO.yaml"
    $invalidCheckpointObject = (($checkpointObject | ConvertTo-Json -Depth 12) | ConvertFrom-Json)
    $invalidCheckpointObject.auditoria_iniciada = 'false'
    $invalidCheckpointObject.inicio = 'data-invalida'
    $invalidCheckpointObject.motivo_pausa = $null
    Write-Utf8Fixture -FullPath (Resolve-HarnessPath -RepoRoot $root -Path $invalidCheckpointPath) -Content (($invalidCheckpointObject | ConvertTo-Json -Depth 12) + "`n")
    $invalidCheckpoint = Invoke-HarnessCheckpointEvaluation -CheckpointPath $invalidCheckpointPath -RepoRoot $root
    Add-Check -Name 'checkpoint malformado e rejeitado' -Passed ($invalidCheckpoint.Resultado -eq 'CHECKPOINT_INVALIDO') -Detail ("{0}; erros={1}" -f $invalidCheckpoint.Resultado, ($invalidCheckpoint.Erros -join ' | '))

    $previousErrorActionPreference = $ErrorActionPreference
    try {
        $ErrorActionPreference = 'SilentlyContinue'
        & powershell.exe -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot 'Get-HarnessHash.ps1') -Path ';' 2>$null | Out-Null
        $emptyHashExit = $LASTEXITCODE
        & powershell.exe -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot 'Test-HarnessFiles.ps1') -Path ';' 2>$null | Out-Null
        $emptyFilesExit = $LASTEXITCODE
    }
    finally {
        $ErrorActionPreference = $previousErrorActionPreference
    }
    Add-Check -Name 'hash rejeita lista vazia' -Passed ($emptyHashExit -eq 1) -Detail ("exit={0}" -f $emptyHashExit)
    Add-Check -Name 'files rejeita lista vazia' -Passed ($emptyFilesExit -eq 1) -Detail ("exit={0}" -f $emptyFilesExit)
}
catch {
    Add-Check -Name 'execucao do self-test' -Passed $false -Detail $_.Exception.Message
}
finally {
    if (-not [string]::IsNullOrWhiteSpace($testDirectory)) {
        $testRootForDelete = Resolve-HarnessPath -RepoRoot $root -Path '.tmp/harness-tests'
        $deletePrefix = [System.IO.Path]::GetFullPath($testRootForDelete).TrimEnd('\') + '\'
        $resolvedDelete = [System.IO.Path]::GetFullPath($testDirectory)
        if ($resolvedDelete.StartsWith($deletePrefix, [System.StringComparison]::OrdinalIgnoreCase) -and [System.IO.Directory]::Exists($resolvedDelete)) {
            Remove-Item -LiteralPath $resolvedDelete -Recurse -Force
        }
        if ((-not $testRootExisted) -and [System.IO.Directory]::Exists($testRootForDelete) -and ([System.IO.Directory]::GetFileSystemEntries($testRootForDelete).Count -eq 0)) {
            [System.IO.File]::SetAttributes($testRootForDelete, [System.IO.FileAttributes]::Directory)
            [System.IO.Directory]::Delete($testRootForDelete, $false)
        }
        $dotTmpForDelete = Resolve-HarnessPath -RepoRoot $root -Path '.tmp'
        if ((-not $dotTmpExisted) -and [System.IO.Directory]::Exists($dotTmpForDelete) -and ([System.IO.Directory]::GetFileSystemEntries($dotTmpForDelete).Count -eq 0)) {
            [System.IO.File]::SetAttributes($dotTmpForDelete, [System.IO.FileAttributes]::Directory)
            [System.IO.Directory]::Delete($dotTmpForDelete, $false)
        }
        $clean = (-not [System.IO.Directory]::Exists($resolvedDelete)) -and ($testRootExisted -or (-not [System.IO.Directory]::Exists($testRootForDelete))) -and ($dotTmpExisted -or (-not [System.IO.Directory]::Exists($dotTmpForDelete)))
        Add-Check -Name 'limpeza temporaria' -Passed $clean -Detail $resolvedDelete
    }
}

if ($Json) { @($checks) | ConvertTo-Json -Depth 8 }
else {
    foreach ($check in $checks) { Write-Output ("TESTE {0} {1} -- {2}" -f $check.resultado, $check.teste, $check.detalhe) }
}
if ($failed) { exit 2 }
exit 0
