Set-StrictMode -Version 2.0

function Get-HarnessRepositoryRoot {
    param([string]$RepoRoot)

    if ([string]::IsNullOrWhiteSpace($RepoRoot)) {
        $RepoRoot = Join-Path $PSScriptRoot '..\..'
    }

    $resolved = [System.IO.Path]::GetFullPath($RepoRoot)
    if (-not [System.IO.Directory]::Exists($resolved)) {
        throw "Raiz do repositorio inexistente: $resolved"
    }

    return $resolved.TrimEnd([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar)
}

function Resolve-HarnessPath {
    param(
        [Parameter(Mandatory = $true)][string]$RepoRoot,
        [Parameter(Mandatory = $true)][string]$Path
    )

    if ([string]::IsNullOrWhiteSpace($Path)) {
        throw 'Caminho vazio.'
    }

    if ([System.IO.Path]::IsPathRooted($Path)) {
        $candidate = [System.IO.Path]::GetFullPath($Path)
    }
    else {
        $candidate = [System.IO.Path]::GetFullPath((Join-Path $RepoRoot ($Path -replace '/', [System.IO.Path]::DirectorySeparatorChar)))
    }

    $root = [System.IO.Path]::GetFullPath($RepoRoot).TrimEnd([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar)
    $prefix = $root + [System.IO.Path]::DirectorySeparatorChar
    if (($candidate -ne $root) -and (-not $candidate.StartsWith($prefix, [System.StringComparison]::OrdinalIgnoreCase))) {
        throw "Caminho fora do repositorio: $Path"
    }

    if ($candidate -ne $root) {
        $relative = $candidate.Substring($prefix.Length)
        $cursor = $root
        foreach ($segment in ($relative -split '[\\/]')) {
            if ([string]::IsNullOrWhiteSpace($segment)) { continue }
            $cursor = Join-Path $cursor $segment
            if ((-not [System.IO.File]::Exists($cursor)) -and (-not [System.IO.Directory]::Exists($cursor))) { continue }
            $item = Get-Item -LiteralPath $cursor -Force
            $linkTypeProperty = $item.PSObject.Properties['LinkType']
            $targetProperty = $item.PSObject.Properties['Target']
            $linkType = if ($null -ne $linkTypeProperty) { [string]$linkTypeProperty.Value } else { '' }
            $target = if ($null -ne $targetProperty) { $targetProperty.Value } else { $null }
            if ((-not [string]::IsNullOrWhiteSpace($linkType)) -or ($null -ne $target -and @($target).Count -gt 0)) {
                throw "Caminho atravessa link ou junction: $Path"
            }
        }
    }

    return $candidate
}

function Test-HarnessRelativePath {
    param([string]$Path)

    return (-not [string]::IsNullOrWhiteSpace($Path)) -and (-not [System.IO.Path]::IsPathRooted($Path)) -and (-not $Path.StartsWith('..'))
}

function Get-HarnessProperty {
    param(
        [object]$Object,
        [Parameter(Mandatory = $true)][string]$Name,
        [object]$Default = $null
    )

    if ($null -eq $Object) {
        return $Default
    }

    $property = $Object.PSObject.Properties[$Name]
    if ($null -eq $property) {
        return $Default
    }

    return $property.Value
}

function Test-HarnessHashModeValue {
    param([string]$Value)

    return $Value -in @('BYTES_V1', 'TEXT_CANONICAL_V1')
}

function Get-HarnessEntryHashMode {
    param(
        [Parameter(Mandatory = $true)][object]$Entry,
        [Parameter(Mandatory = $true)][object]$Errors,
        [Parameter(Mandatory = $true)][string]$Scope
    )

    $mode = [string](Get-HarnessProperty -Object $Entry -Name 'hash_mode')
    if ([string]::IsNullOrWhiteSpace($mode)) {
        $Errors.Add("$Scope hash_mode ausente")
        return $null
    }

    $mode = $mode.ToUpperInvariant()
    if (-not (Test-HarnessHashModeValue -Value $mode)) {
        $Errors.Add("$Scope hash_mode invalido: $mode")
        return $null
    }

    return $mode
}

function Get-HarnessCanonicalText {
    param([Parameter(Mandatory = $true)][string]$LiteralPath)

    if (-not [System.IO.File]::Exists($LiteralPath)) {
        throw "Arquivo inexistente: $LiteralPath"
    }

    $bytes = [System.IO.File]::ReadAllBytes($LiteralPath)
    $offset = 0
    if (($bytes.Length -ge 3) -and ($bytes[0] -eq 0xEF) -and ($bytes[1] -eq 0xBB) -and ($bytes[2] -eq 0xBF)) {
        $offset = 3
    }

    $encoding = New-Object System.Text.UTF8Encoding($false, $true)
    $text = $encoding.GetString($bytes, $offset, $bytes.Length - $offset)
    $text = $text -replace "`r`n", "`n"
    $text = $text -replace "`r", "`n"
    return $text
}

function Get-HarnessCanonicalTextBytes {
    param([Parameter(Mandatory = $true)][string]$LiteralPath)

    $text = Get-HarnessCanonicalText -LiteralPath $LiteralPath
    $encoding = New-Object System.Text.UTF8Encoding($false)
    return $encoding.GetBytes($text)
}

function Get-HarnessNestedProperty {
    param(
        [object]$Object,
        [Parameter(Mandatory = $true)][string]$Path
    )

    $current = $Object
    foreach ($segment in ($Path -split '\.')) {
        if ([string]::IsNullOrWhiteSpace($segment)) { return $null }
        $current = Get-HarnessProperty -Object $current -Name $segment
        if ($null -eq $current) { return $null }
    }
    return $current
}

function ConvertTo-HarnessArray {
    param([object]$Value)

    if ($null -eq $Value) {
        return @()
    }

    return @($Value)
}

function Get-HarnessSha256 {
    param(
        [Parameter(Mandatory = $true)][string]$LiteralPath,
        [string]$HashMode = 'BYTES_V1'
    )

    if (-not [System.IO.File]::Exists($LiteralPath)) {
        throw "Arquivo inexistente: $LiteralPath"
    }

    $resolvedMode = [string]$HashMode
    if ([string]::IsNullOrWhiteSpace($resolvedMode)) {
        throw 'Modo de hash vazio.'
    }
    $resolvedMode = $resolvedMode.ToUpperInvariant()
    if (-not (Test-HarnessHashModeValue -Value $resolvedMode)) {
        throw "Modo de hash desconhecido: $HashMode"
    }

    $sha = $null
    try {
        $sha = [System.Security.Cryptography.SHA256]::Create()
        $bytes = switch ($resolvedMode) {
            'BYTES_V1' { $stream = [System.IO.File]::Open($LiteralPath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::Read)
                try { $sha.ComputeHash($stream) }
                finally { if ($null -ne $stream) { $stream.Dispose() } }
            }
            'TEXT_CANONICAL_V1' { $sha.ComputeHash((Get-HarnessCanonicalTextBytes -LiteralPath $LiteralPath)) }
            default { throw "Modo de hash desconhecido: $HashMode" }
        }
        return ([System.BitConverter]::ToString($bytes) -replace '-', '').ToUpperInvariant()
    }
    finally {
        if ($null -ne $sha) { $sha.Dispose() }
    }
}

function Test-HarnessSha256Value {
    param([string]$Value)

    return (-not [string]::IsNullOrWhiteSpace($Value)) -and ($Value -match '^[0-9A-Fa-f]{64}$')
}

function Read-HarnessUtf8Text {
    param([Parameter(Mandatory = $true)][string]$LiteralPath)

    $encoding = New-Object System.Text.UTF8Encoding($false, $true)
    $bytes = [System.IO.File]::ReadAllBytes($LiteralPath)
    return $encoding.GetString($bytes)
}

function Test-HarnessUtf8File {
    param([Parameter(Mandatory = $true)][string]$LiteralPath)

    try {
        $text = Read-HarnessUtf8Text -LiteralPath $LiteralPath
        $issues = New-Object System.Collections.Generic.List[string]
        if ($text.IndexOf([char]0) -ge 0) { $issues.Add('contem NUL') }
        if ($text.IndexOf([char]0xFFFD) -ge 0) { $issues.Add('contem U+FFFD') }
        return [pscustomobject]@{
            Valido = ($issues.Count -eq 0)
            Problemas = @($issues)
            Texto = $text
        }
    }
    catch {
        return [pscustomobject]@{
            Valido = $false
            Problemas = @("UTF-8 invalido: $($_.Exception.Message)")
            Texto = $null
        }
    }
}

function Read-HarnessDataFile {
    param([Parameter(Mandatory = $true)][string]$LiteralPath)

    $text = Read-HarnessUtf8Text -LiteralPath $LiteralPath
    try {
        return $text | ConvertFrom-Json
    }
    catch {
        throw "O arquivo deve usar o subconjunto YAML 1.2 compativel com JSON: $LiteralPath. $($_.Exception.Message)"
    }
}

function Get-HarnessMarkdownLinkProblems {
    param(
        [Parameter(Mandatory = $true)][string]$LiteralPath,
        [Parameter(Mandatory = $true)][string]$RepoRoot,
        [Parameter(Mandatory = $true)][string]$Text
    )

    $problems = New-Object System.Collections.Generic.List[string]
    $matches = [System.Text.RegularExpressions.Regex]::Matches($Text, '(?m)!?\[[^\]]*\]\((?<target>[^)]+)\)')
    foreach ($match in $matches) {
        $target = $match.Groups['target'].Value.Trim()
        if ($target.StartsWith('<') -and $target.EndsWith('>')) {
            $target = $target.Substring(1, $target.Length - 2)
        }
        $target = $target.Split('#')[0]
        if ([string]::IsNullOrWhiteSpace($target)) { continue }
        if ($target -match '^(?i:https?|mailto|data):') { continue }

        try {
            if ($target.StartsWith('/')) {
                $resolved = Resolve-HarnessPath -RepoRoot $RepoRoot -Path $target.TrimStart('/')
            }
            else {
                $resolved = [System.IO.Path]::GetFullPath((Join-Path ([System.IO.Path]::GetDirectoryName($LiteralPath)) ($target -replace '/', [System.IO.Path]::DirectorySeparatorChar)))
                $null = Resolve-HarnessPath -RepoRoot $RepoRoot -Path $resolved
            }

            if ((-not [System.IO.File]::Exists($resolved)) -and (-not [System.IO.Directory]::Exists($resolved))) {
                $problems.Add("referencia interna inexistente: $target")
            }
        }
        catch {
            $problems.Add("referencia interna invalida: $target")
        }
    }

    return @($problems)
}

function Get-HarnessMarkdownProblems {
    param(
        [Parameter(Mandatory = $true)][string]$LiteralPath,
        [Parameter(Mandatory = $true)][string]$RepoRoot,
        [Parameter(Mandatory = $true)][string]$Text
    )

    $problems = New-Object System.Collections.Generic.List[string]
    if ([string]::IsNullOrWhiteSpace($Text)) {
        $problems.Add('Markdown vazio')
    }

    $backtickFences = [System.Text.RegularExpressions.Regex]::Matches($Text, '(?m)^\s*`{3,}').Count
    $tildeFences = [System.Text.RegularExpressions.Regex]::Matches($Text, '(?m)^\s*~{3,}').Count
    if (($backtickFences % 2) -ne 0) { $problems.Add('cercas Markdown com crases desbalanceadas') }
    if (($tildeFences % 2) -ne 0) { $problems.Add('cercas Markdown com tils desbalanceadas') }

    $lines = $Text -split "`r?`n"
    for ($index = 0; $index -lt $lines.Count; $index++) {
        if ($lines[$index] -match '^\s*\|(?:\s*:?-{3,}:?\s*\|)+\s*$') {
            if (($index -eq 0) -or ($index + 1 -ge $lines.Count)) {
                $problems.Add("tabela Markdown incompleta na linha $($index + 1)")
                continue
            }
            $separatorPipes = [System.Text.RegularExpressions.Regex]::Matches($lines[$index], '(?<!\\)\|').Count
            $headerPipes = [System.Text.RegularExpressions.Regex]::Matches($lines[$index - 1], '(?<!\\)\|').Count
            $firstRowPipes = [System.Text.RegularExpressions.Regex]::Matches($lines[$index + 1], '(?<!\\)\|').Count
            if (($separatorPipes -ne $headerPipes) -or ($separatorPipes -ne $firstRowPipes)) {
                $problems.Add("largura inconsistente de tabela Markdown na linha $($index + 1)")
            }
        }
    }

    foreach ($problem in (Get-HarnessMarkdownLinkProblems -LiteralPath $LiteralPath -RepoRoot $RepoRoot -Text $Text)) {
        $problems.Add($problem)
    }

    return @($problems)
}

function Invoke-HarnessMechanicalValidation {
    param(
        [Parameter(Mandatory = $true)][object]$Manifest,
        [Parameter(Mandatory = $true)][string]$RepoRoot
    )

    $issues = New-Object System.Collections.Generic.List[string]
    $rules = Get-HarnessProperty -Object $Manifest -Name 'validacoes_mecanicas'
    if ($null -eq $rules) {
        return @()
    }

    foreach ($path in (ConvertTo-HarnessArray (Get-HarnessProperty -Object $rules -Name 'arquivos_obrigatorios'))) {
        try {
            if (-not (Test-HarnessRelativePath -Path ([string]$path))) {
                $issues.Add("arquivo obrigatorio deve ser relativo: $path")
                continue
            }
            $full = Resolve-HarnessPath -RepoRoot $RepoRoot -Path ([string]$path)
            if ((-not [System.IO.File]::Exists($full)) -and (-not [System.IO.Directory]::Exists($full))) {
                $issues.Add("arquivo obrigatorio ausente: $path")
            }
        }
        catch { $issues.Add("arquivo obrigatorio invalido: $path") }
    }

    foreach ($path in (ConvertTo-HarnessArray (Get-HarnessProperty -Object $rules -Name 'utf8'))) {
        try {
            $full = Resolve-HarnessPath -RepoRoot $RepoRoot -Path ([string]$path)
            if (-not [System.IO.File]::Exists($full)) {
                $issues.Add("arquivo UTF-8 ausente: $path")
                continue
            }
            $result = Test-HarnessUtf8File -LiteralPath $full
            foreach ($problem in $result.Problemas) { $issues.Add("${path}: $problem") }
        }
        catch { $issues.Add("falha ao validar UTF-8 de ${path}: $($_.Exception.Message)") }
    }

    foreach ($path in (ConvertTo-HarnessArray (Get-HarnessProperty -Object $rules -Name 'markdown'))) {
        try {
            $full = Resolve-HarnessPath -RepoRoot $RepoRoot -Path ([string]$path)
            if (-not [System.IO.File]::Exists($full)) {
                $issues.Add("Markdown ausente: $path")
                continue
            }
            $utf8 = Test-HarnessUtf8File -LiteralPath $full
            foreach ($problem in $utf8.Problemas) { $issues.Add("${path}: $problem") }
            if ($utf8.Valido) {
                foreach ($problem in (Get-HarnessMarkdownProblems -LiteralPath $full -RepoRoot $RepoRoot -Text $utf8.Texto)) {
                    $issues.Add("${path}: $problem")
                }
            }
        }
        catch { $issues.Add("falha ao validar Markdown ${path}: $($_.Exception.Message)") }
    }

    foreach ($rule in (ConvertTo-HarnessArray (Get-HarnessProperty -Object $rules -Name 'contagens'))) {
        $name = [string](Get-HarnessProperty -Object $rule -Name 'nome' -Default 'contagem')
        $path = [string](Get-HarnessProperty -Object $rule -Name 'caminho')
        $pattern = [string](Get-HarnessProperty -Object $rule -Name 'padrao_regex')
        $expected = Get-HarnessProperty -Object $rule -Name 'esperado'
        try {
            $full = Resolve-HarnessPath -RepoRoot $RepoRoot -Path $path
            $text = Read-HarnessUtf8Text -LiteralPath $full
            $count = [System.Text.RegularExpressions.Regex]::Matches($text, $pattern).Count
            if ($count -ne [int]$expected) {
                $issues.Add("$name em ${path}: esperado $expected, obtido $count")
            }
        }
        catch { $issues.Add("falha na contagem ${name}: $($_.Exception.Message)") }
    }

    foreach ($rule in (ConvertTo-HarnessArray (Get-HarnessProperty -Object $rules -Name 'ids'))) {
        $name = [string](Get-HarnessProperty -Object $rule -Name 'nome' -Default 'ids')
        $path = [string](Get-HarnessProperty -Object $rule -Name 'caminho')
        $pattern = [string](Get-HarnessProperty -Object $rule -Name 'padrao_regex')
        $expected = Get-HarnessProperty -Object $rule -Name 'esperado_unicos'
        $groupName = [string](Get-HarnessProperty -Object $rule -Name 'grupo' -Default 'id')
        try {
            $full = Resolve-HarnessPath -RepoRoot $RepoRoot -Path $path
            $text = Read-HarnessUtf8Text -LiteralPath $full
            $matches = [System.Text.RegularExpressions.Regex]::Matches($text, $pattern)
            $ids = @()
            foreach ($match in $matches) {
                if (($groupName -ne '0') -and $match.Groups[$groupName].Success) {
                    $ids += $match.Groups[$groupName].Value
                }
                else {
                    $ids += $match.Value
                }
            }
            $unique = @($ids | Sort-Object -Unique)
            $duplicates = @($ids | Group-Object | Where-Object { $_.Count -gt 1 } | ForEach-Object { $_.Name })
            if ($unique.Count -ne [int]$expected) {
                $issues.Add("$name em ${path}: esperados $expected IDs unicos, obtidos $($unique.Count)")
            }
            if ($duplicates.Count -gt 0) {
                $issues.Add("$name em ${path}: IDs duplicados: $($duplicates -join ', ')")
            }
        }
        catch { $issues.Add("falha ao validar ${name}: $($_.Exception.Message)") }
    }

    return @($issues)
}

function Get-HarnessManifestDeclaredArtifacts {
    param([object]$Manifest)

    $all = @()
    foreach ($sectionName in @('fontes', 'entradas', 'saidas')) {
        foreach ($entry in (ConvertTo-HarnessArray (Get-HarnessProperty -Object $Manifest -Name $sectionName))) {
            $all += $entry
        }
    }
    $result = Get-HarnessProperty -Object $Manifest -Name 'resultado'
    $audit = Get-HarnessProperty -Object $result -Name 'auditoria_vigente'
    if ($null -ne $audit) { $all += $audit }
    return @($all)
}

function Invoke-HarnessManifestEvaluation {
    param(
        [Parameter(Mandatory = $true)][string]$ManifestPath,
        [Parameter(Mandatory = $true)][string]$RepoRoot,
        [hashtable]$Visited = $null
    )

    if ($null -eq $Visited) { $Visited = @{} }
    $errors = New-Object System.Collections.Generic.List[string]
    $reasons = New-Object System.Collections.Generic.List[string]
    $categories = New-Object System.Collections.Generic.List[string]
    $manifest = $null
    $declared = $null
    $gatePassed = $false
    $conventionalToolStage03 = $false

    try { $fullManifest = Resolve-HarnessPath -RepoRoot $RepoRoot -Path $ManifestPath }
    catch {
        return [pscustomobject]@{ Manifesto = $ManifestPath; VigenciaDeclarada = $null; VigenciaCalculada = 'MANIFESTO_INVALIDO'; Erros = @($_.Exception.Message); Motivos = @(); GateAtendido = $false; Reutilizavel = $false; ManifestoObjeto = $null }
    }

    if ($Visited.ContainsKey($fullManifest)) {
        return [pscustomobject]@{ Manifesto = $ManifestPath; VigenciaDeclarada = $null; VigenciaCalculada = 'MANIFESTO_INVALIDO'; Erros = @("ciclo de dependencias em $ManifestPath"); Motivos = @(); GateAtendido = $false; Reutilizavel = $false; ManifestoObjeto = $null }
    }
    $Visited[$fullManifest] = $true

    $normalizedRoot = [System.IO.Path]::GetFullPath($RepoRoot).TrimEnd([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar)
    $rootPrefix = $normalizedRoot + [System.IO.Path]::DirectorySeparatorChar
    $relativeManifestPath = if ($fullManifest.StartsWith($rootPrefix, [System.StringComparison]::OrdinalIgnoreCase)) { $fullManifest.Substring($rootPrefix.Length).Replace('\', '/') } else { '' }
    $manifestConventionMatch = [System.Text.RegularExpressions.Regex]::Match(
        $relativeManifestPath,
        '^parceiros/execucoes/(?<type>[^/]+)/(?<slug>[^/]+)/manifestos/PASSO-(?<stage>\d{2})\.ya?ml$',
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
    )
    if ($manifestConventionMatch.Success) {
        $conventionalToolStage03 = ($manifestConventionMatch.Groups['type'].Value -ieq 'ferramentas') -and ($manifestConventionMatch.Groups['stage'].Value -eq '03')
    }

    try {
        if (-not [System.IO.File]::Exists($fullManifest)) {
            throw "Manifesto inexistente: $ManifestPath"
        }
        $manifestText = Read-HarnessUtf8Text -LiteralPath $fullManifest
        $manifest = Read-HarnessDataFile -LiteralPath $fullManifest
        if ((Get-HarnessProperty -Object $manifest -Name 'schema') -ne 'harness.manifesto-etapa.v1') {
            $errors.Add('schema ausente ou diferente de harness.manifesto-etapa.v1')
        }

        $identity = Get-HarnessProperty -Object $manifest -Name 'identidade'
        foreach ($field in @('tipo_alvo', 'alvo', 'slug', 'jornada', 'etapa', 'execucao')) {
            if ([string]::IsNullOrWhiteSpace([string](Get-HarnessProperty -Object $identity -Name $field))) {
                $errors.Add("identidade.$field ausente")
            }
        }
        $targetType = [string](Get-HarnessProperty -Object $identity -Name 'tipo_alvo')
        $targetSlug = [string](Get-HarnessProperty -Object $identity -Name 'slug')
        $targetExecution = ([string](Get-HarnessProperty -Object $identity -Name 'execucao')).Replace('\', '/').TrimEnd('/')
        $targetJourney = [string](Get-HarnessProperty -Object $identity -Name 'jornada')
        $targetStage = [string](Get-HarnessProperty -Object $identity -Name 'etapa')
        $isExecutionPath = $relativeManifestPath.StartsWith('parceiros/execucoes/', [System.StringComparison]::OrdinalIgnoreCase)
        $typeFolders = @{ FERRAMENTA = 'ferramentas'; ERP = 'erps'; CLIENTE = 'clientes' }
        if ($targetType -eq 'TESTE') {
            if ($isExecutionPath) { $errors.Add('manifesto real em parceiros/execucoes nao pode usar tipo_alvo TESTE') }
        }
        elseif (-not $typeFolders.ContainsKey($targetType)) {
            $errors.Add('identidade.tipo_alvo deve ser FERRAMENTA, ERP, CLIENTE ou TESTE')
        }
        elseif (-not $manifestConventionMatch.Success) {
            $errors.Add('manifesto real deve seguir parceiros/execucoes/<tipo>/<slug>/manifestos/PASSO-<NN>.yaml')
        }

        if ($manifestConventionMatch.Success) {
            $pathType = $manifestConventionMatch.Groups['type'].Value
            $pathSlug = $manifestConventionMatch.Groups['slug'].Value
            $pathStage = $manifestConventionMatch.Groups['stage'].Value
            $expectedExecution = "parceiros/execucoes/$pathType/$pathSlug"
            if (($targetType -eq 'TESTE') -or (-not $typeFolders.ContainsKey($targetType)) -or ($typeFolders[$targetType] -ine $pathType)) {
                $errors.Add("identidade.tipo_alvo nao corresponde ao diretorio $pathType")
            }
            if ($targetSlug -ine $pathSlug) { $errors.Add("identidade.slug nao corresponde ao diretorio $pathSlug") }
            if ($targetExecution -ine $expectedExecution) { $errors.Add("identidade.execucao deve ser $expectedExecution") }
            if ($targetStage -notmatch ('^' + [System.Text.RegularExpressions.Regex]::Escape($pathStage) + '(?:-|$)')) {
                $errors.Add("identidade.etapa nao corresponde ao Passo $pathStage")
            }
            if (($pathType -ieq 'ferramentas') -and ($targetJourney -ne 'INTEGRAR_NOVA_FERRAMENTA')) {
                $errors.Add('manifesto da trilha de ferramentas exige jornada INTEGRAR_NOVA_FERRAMENTA')
            }
        }
        $manifestFileName = [System.IO.Path]::GetFileName($fullManifest)
        $manifestStageMatch = [System.Text.RegularExpressions.Regex]::Match($manifestFileName, '^PASSO-(?<stage>\d+)\.ya?ml$', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        if ($manifestStageMatch.Success) {
            $fileStage = $manifestStageMatch.Groups['stage'].Value
            $declaredStage = [string](Get-HarnessProperty -Object $identity -Name 'etapa')
            if ($declaredStage -notmatch ('^' + [System.Text.RegularExpressions.Regex]::Escape($fileStage) + '(?:-|$)')) {
                $errors.Add("identidade.etapa nao corresponde ao arquivo $manifestFileName")
            }
        }

        $result = Get-HarnessProperty -Object $manifest -Name 'resultado'
        foreach ($field in @('status', 'tipo_auditoria')) {
            if ([string]::IsNullOrWhiteSpace([string](Get-HarnessProperty -Object $result -Name $field))) {
                $errors.Add("resultado.$field ausente")
            }
        }
        $audit = Get-HarnessProperty -Object $result -Name 'auditoria_vigente'
        if ($null -eq $audit) { $errors.Add('resultado.auditoria_vigente ausente') }
        $stageStatus = [string](Get-HarnessProperty -Object $result -Name 'status')
        $auditType = [string](Get-HarnessProperty -Object $result -Name 'tipo_auditoria')
        if ($stageStatus -notin @('CONCLUIDA', 'PENDENTE', 'BLOQUEADA')) { $errors.Add('resultado.status invalido') }
        if ($auditType -notin @('NORMAL', 'PROFUNDA')) { $errors.Add('resultado.tipo_auditoria deve ser NORMAL ou PROFUNDA') }

        foreach ($sectionName in @('fontes', 'entradas', 'saidas', 'dependencias', 'gate_reutilizacao')) {
            if ($null -eq $manifest.PSObject.Properties[$sectionName]) { $errors.Add("secao $sectionName ausente") }
        }
        foreach ($listSection in @('fontes', 'entradas', 'saidas', 'dependencias')) {
            $arrayPattern = '"' + [System.Text.RegularExpressions.Regex]::Escape($listSection) + '"\s*:\s*\['
            if (($null -ne $manifest.PSObject.Properties[$listSection]) -and (-not [System.Text.RegularExpressions.Regex]::IsMatch($manifestText, $arrayPattern))) {
                $errors.Add("secao $listSection deve ser uma lista JSON")
            }
        }
        foreach ($nestedListName in @('requisitos', 'hashes_esperados')) {
            $nestedPattern = '"' + [System.Text.RegularExpressions.Regex]::Escape($nestedListName) + '"\s*:\s*(?<token>\S)'
            foreach ($nestedMatch in [System.Text.RegularExpressions.Regex]::Matches($manifestText, $nestedPattern)) {
                if ($nestedMatch.Groups['token'].Value -ne '[') { $errors.Add("$nestedListName deve ser uma lista JSON") }
            }
        }
        if (@(ConvertTo-HarnessArray (Get-HarnessProperty -Object $manifest -Name 'saidas')).Count -eq 0) {
            $errors.Add('saidas deve conter ao menos um arquivo')
        }

        $vigencia = Get-HarnessProperty -Object $manifest -Name 'vigencia'
        $declared = [string](Get-HarnessProperty -Object $vigencia -Name 'estado')
        if ([string]::IsNullOrWhiteSpace($declared)) { $errors.Add('vigencia.estado ausente') }
        $allowedValidity = @('VALIDO', 'INVALIDADO_POR_MUDANCA_UPSTREAM', 'INVALIDADO_POR_FONTE_ALTERADA', 'INVALIDADO_POR_ENTRADA_ALTERADA', 'INVALIDADO_POR_SAIDA_ALTERADA', 'INVALIDADO_POR_AUDITORIA_ALTERADA')
        if ((-not [string]::IsNullOrWhiteSpace($declared)) -and ($declared -notin $allowedValidity)) { $errors.Add('vigencia.estado invalido') }
        $declaredReason = [string](Get-HarnessProperty -Object $vigencia -Name 'motivo')
        if (($declared -ne 'VALIDO') -and [string]::IsNullOrWhiteSpace($declaredReason)) { $errors.Add('vigencia.motivo obrigatorio para manifesto invalidado') }

        $gate = Get-HarnessProperty -Object $manifest -Name 'gate_reutilizacao'
        $requirements = @(ConvertTo-HarnessArray (Get-HarnessProperty -Object $gate -Name 'requisitos'))
        $requirementMap = @{}
        if ($requirements.Count -eq 0) {
            $errors.Add('gate_reutilizacao.requisitos deve conter ao menos uma condicao')
        }
        else {
            $gatePassed = $true
            foreach ($requirement in $requirements) {
                $fieldPath = [string](Get-HarnessProperty -Object $requirement -Name 'campo')
                $expectedValue = Get-HarnessProperty -Object $requirement -Name 'valor_esperado'
                if ([string]::IsNullOrWhiteSpace($fieldPath) -or ($null -eq $expectedValue)) {
                    $errors.Add('requisito de gate incompleto')
                    $gatePassed = $false
                    continue
                }
                if ($requirementMap.ContainsKey($fieldPath)) {
                    $errors.Add("requisito de gate duplicado: $fieldPath")
                    $gatePassed = $false
                    continue
                }
                $requirementMap[$fieldPath] = [string]$expectedValue
                $currentValue = Get-HarnessNestedProperty -Object $manifest -Path $fieldPath
                if (([string]$currentValue) -cne ([string]$expectedValue)) {
                    $gatePassed = $false
                    $reasons.Add("gate nao atendido: $fieldPath; esperado=$expectedValue; atual=$currentValue")
                }
            }
        }

        $journey = [string](Get-HarnessProperty -Object $identity -Name 'jornada')
        $stage = [string](Get-HarnessProperty -Object $identity -Name 'etapa')
        if ($conventionalToolStage03 -or (($journey -eq 'INTEGRAR_NOVA_FERRAMENTA') -and ($stage -match '^03(?:-|$)'))) {
            $mandatoryStage03Gate = [ordered]@{
                'resultado.resultado_tecnico' = 'APTO_PARA_INTEGRACOES'
                'resultado.auditoria_vigente.resultado' = 'APROVADA'
                'resultado.status' = 'CONCLUIDA'
                'resultado.prontidao' = 'HOMOLOGADA_PARA_INTEGRACOES'
                'resultado.tipo_auditoria' = 'PROFUNDA'
            }
            foreach ($mandatoryField in $mandatoryStage03Gate.Keys) {
                $mandatoryExpected = [string]$mandatoryStage03Gate[$mandatoryField]
                if ((-not $requirementMap.ContainsKey($mandatoryField)) -or ($requirementMap[$mandatoryField] -cne $mandatoryExpected)) {
                    $errors.Add("gate obrigatorio do Passo 03 ausente ou enfraquecido: $mandatoryField=$mandatoryExpected")
                    $gatePassed = $false
                }
                $mandatoryCurrent = Get-HarnessNestedProperty -Object $manifest -Path $mandatoryField
                if (([string]$mandatoryCurrent) -cne $mandatoryExpected) { $gatePassed = $false }
            }
        }

        foreach ($sectionName in @('fontes', 'entradas', 'saidas')) {
            foreach ($entry in (ConvertTo-HarnessArray (Get-HarnessProperty -Object $manifest -Name $sectionName))) {
                $path = [string](Get-HarnessProperty -Object $entry -Name 'caminho')
                $expected = [string](Get-HarnessProperty -Object $entry -Name 'sha256')
                $hashMode = Get-HarnessEntryHashMode -Entry $entry -Errors $errors -Scope $sectionName
                if (-not (Test-HarnessRelativePath -Path $path)) {
                    $errors.Add("$sectionName possui caminho nao relativo: $path")
                    continue
                }
                if (-not (Test-HarnessSha256Value -Value $expected)) {
                    $errors.Add("$sectionName possui SHA-256 invalido: $path")
                    continue
                }
                if ($null -eq $hashMode) { continue }
                try {
                    $full = Resolve-HarnessPath -RepoRoot $RepoRoot -Path $path
                    if (-not [System.IO.File]::Exists($full)) {
                        $reasons.Add("$sectionName ausente: $path")
                        if ($sectionName -eq 'fontes') { $categories.Add('FONTE') }
                        elseif ($sectionName -eq 'entradas') { $categories.Add('ENTRADA') }
                        else { $categories.Add('SAIDA') }
                        continue
                    }
                    $actual = Get-HarnessSha256 -LiteralPath $full -HashMode $hashMode
                    if ($actual -ne $expected.ToUpperInvariant()) {
                        $reasons.Add("$sectionName alterado: $path; esperado=$expected; atual=$actual")
                        if ($sectionName -eq 'fontes') { $categories.Add('FONTE') }
                        elseif ($sectionName -eq 'entradas') { $categories.Add('ENTRADA') }
                        else { $categories.Add('SAIDA') }
                    }
                }
                catch { $errors.Add("falha ao verificar ${path}: $($_.Exception.Message)") }
            }
        }

        if ($null -ne $audit) {
            $auditPath = [string](Get-HarnessProperty -Object $audit -Name 'caminho')
            $auditHash = [string](Get-HarnessProperty -Object $audit -Name 'sha256')
            $auditResult = [string](Get-HarnessProperty -Object $audit -Name 'resultado')
            $auditHashMode = Get-HarnessEntryHashMode -Entry $audit -Errors $errors -Scope 'resultado.auditoria_vigente'
            if ((-not (Test-HarnessRelativePath -Path $auditPath)) -or (-not (Test-HarnessSha256Value -Value $auditHash)) -or [string]::IsNullOrWhiteSpace($auditResult)) {
                $errors.Add('resultado.auditoria_vigente incompleta')
            }
            elseif ($null -ne $auditHashMode) {
                if ($auditResult -notin @('APROVADA', 'REPROVADA', 'BLOQUEADA')) { $errors.Add('resultado.auditoria_vigente.resultado invalido') }
                if (($stageStatus -eq 'CONCLUIDA') -and ($auditResult -ne 'APROVADA')) { $errors.Add('etapa CONCLUIDA exige auditoria APROVADA') }
                try {
                    $auditFull = Resolve-HarnessPath -RepoRoot $RepoRoot -Path $auditPath
                    if ((-not [System.IO.File]::Exists($auditFull)) -or ((Get-HarnessSha256 -LiteralPath $auditFull -HashMode $auditHashMode) -ne $auditHash.ToUpperInvariant())) {
                        $categories.Add('AUDITORIA')
                        $reasons.Add("auditoria vigente ausente ou alterada: $auditPath")
                    }
                }
                catch { $errors.Add("falha ao verificar auditoria vigente: $($_.Exception.Message)") }
            }
        }

        foreach ($dependency in (ConvertTo-HarnessArray (Get-HarnessProperty -Object $manifest -Name 'dependencias'))) {
            $upstreamPath = [string](Get-HarnessProperty -Object $dependency -Name 'manifesto_upstream')
            $upstreamStage = [string](Get-HarnessProperty -Object $dependency -Name 'etapa_upstream')
            $expectedEntries = @(ConvertTo-HarnessArray (Get-HarnessProperty -Object $dependency -Name 'hashes_esperados'))
            if ([string]::IsNullOrWhiteSpace($upstreamStage)) {
                $errors.Add('dependencia sem etapa_upstream')
                continue
            }
            if (-not (Test-HarnessRelativePath -Path $upstreamPath)) {
                $errors.Add("dependencia $upstreamStage sem manifesto_upstream relativo")
                continue
            }
            if ($expectedEntries.Count -eq 0) {
                $errors.Add("dependencia $upstreamStage sem hashes_esperados")
                continue
            }

            $upstream = Invoke-HarnessManifestEvaluation -ManifestPath $upstreamPath -RepoRoot $RepoRoot -Visited $Visited
            if ($null -ne $upstream.ManifestoObjeto) {
                $upstreamIdentity = Get-HarnessProperty -Object $upstream.ManifestoObjeto -Name 'identidade'
                $upstreamDeclaredStage = [string](Get-HarnessProperty -Object $upstreamIdentity -Name 'etapa')
                if ($upstreamDeclaredStage -ne $upstreamStage) {
                    $errors.Add("etapa_upstream $upstreamStage difere da identidade $upstreamDeclaredStage")
                }
            }
            if (($upstream.VigenciaCalculada -ne 'VALIDO') -or ($upstream.VigenciaDeclarada -ne 'VALIDO') -or (-not $upstream.Reutilizavel)) {
                $categories.Add('UPSTREAM')
                $reasons.Add("upstream $upstreamStage nao reutilizavel: declarada=$($upstream.VigenciaDeclarada); calculada=$($upstream.VigenciaCalculada); gate=$($upstream.Reutilizavel)")
            }

            $upstreamArtifacts = @()
            if ($null -ne $upstream.ManifestoObjeto) {
                $upstreamArtifacts = Get-HarnessManifestDeclaredArtifacts -Manifest $upstream.ManifestoObjeto
            }
            foreach ($expectedEntry in $expectedEntries) {
                $expectedPath = [string](Get-HarnessProperty -Object $expectedEntry -Name 'caminho')
                $expectedHash = [string](Get-HarnessProperty -Object $expectedEntry -Name 'sha256')
                $expectedHashMode = Get-HarnessEntryHashMode -Entry $expectedEntry -Errors $errors -Scope "dependencia $upstreamStage"
                if ((-not (Test-HarnessRelativePath -Path $expectedPath)) -or (-not (Test-HarnessSha256Value -Value $expectedHash))) {
                    $errors.Add("hash esperado invalido na dependencia $upstreamStage")
                    continue
                }
                if ($null -eq $expectedHashMode) { continue }

                $declaredMatch = @($upstreamArtifacts | Where-Object {
                    ([string](Get-HarnessProperty -Object $_ -Name 'caminho')) -eq $expectedPath -and
                    ([string](Get-HarnessProperty -Object $_ -Name 'sha256')).ToUpperInvariant() -eq $expectedHash.ToUpperInvariant()
                }).Count -gt 0
                try {
                    $expectedFull = Resolve-HarnessPath -RepoRoot $RepoRoot -Path $expectedPath
                    $currentMatch = [System.IO.File]::Exists($expectedFull) -and ((Get-HarnessSha256 -LiteralPath $expectedFull -HashMode $expectedHashMode) -eq $expectedHash.ToUpperInvariant())
                }
                catch { $currentMatch = $false }

                if ((-not $declaredMatch) -or (-not $currentMatch)) {
                    $categories.Add('UPSTREAM')
                    $reasons.Add("hash upstream divergente em $expectedPath; esperado=$expectedHash")
                }
            }
        }

        foreach ($issue in (Invoke-HarnessMechanicalValidation -Manifest $manifest -RepoRoot $RepoRoot)) {
            $errors.Add("validacao mecanica: $issue")
        }
    }
    catch {
        $errors.Add($_.Exception.Message)
    }
    finally {
        $null = $Visited.Remove($fullManifest)
    }

    if ($errors.Count -gt 0) {
        $calculated = 'MANIFESTO_INVALIDO'
    }
    elseif (@($categories | Where-Object { $_ -eq 'UPSTREAM' }).Count -gt 0) {
        $calculated = 'INVALIDADO_POR_MUDANCA_UPSTREAM'
    }
    elseif (@($categories | Where-Object { $_ -eq 'FONTE' }).Count -gt 0) {
        $calculated = 'INVALIDADO_POR_FONTE_ALTERADA'
    }
    elseif (@($categories | Where-Object { $_ -eq 'ENTRADA' }).Count -gt 0) {
        $calculated = 'INVALIDADO_POR_ENTRADA_ALTERADA'
    }
    elseif (@($categories | Where-Object { $_ -eq 'AUDITORIA' }).Count -gt 0) {
        $calculated = 'INVALIDADO_POR_AUDITORIA_ALTERADA'
    }
    elseif (@($categories | Where-Object { $_ -eq 'SAIDA' }).Count -gt 0) {
        $calculated = 'INVALIDADO_POR_SAIDA_ALTERADA'
    }
    else {
        $calculated = 'VALIDO'
    }

    if ((-not [string]::IsNullOrWhiteSpace($declared)) -and ($declared -ne $calculated)) {
        $reasons.Add("vigencia declarada ($declared) difere da calculada ($calculated)")
    }

    $reusable = $false
    if ($null -ne $manifest) {
        $finalResult = Get-HarnessProperty -Object $manifest -Name 'resultado'
        $finalAudit = Get-HarnessProperty -Object $finalResult -Name 'auditoria_vigente'
        $reusable = ($calculated -eq 'VALIDO') -and ($declared -eq 'VALIDO') -and $gatePassed -and
            ([string](Get-HarnessProperty -Object $finalResult -Name 'status') -eq 'CONCLUIDA') -and
            ([string](Get-HarnessProperty -Object $finalAudit -Name 'resultado') -eq 'APROVADA')
    }

    return [pscustomobject]@{
        Manifesto = $ManifestPath
        VigenciaDeclarada = $declared
        VigenciaCalculada = $calculated
        Erros = @($errors)
        Motivos = @($reasons)
        GateAtendido = $gatePassed
        Reutilizavel = $reusable
        ManifestoObjeto = $manifest
    }
}

function Invoke-HarnessCheckpointEvaluation {
    param(
        [Parameter(Mandatory = $true)][string]$CheckpointPath,
        [Parameter(Mandatory = $true)][string]$RepoRoot
    )

    $issues = New-Object System.Collections.Generic.List[string]
    $differences = New-Object System.Collections.Generic.List[string]
    $checkpoint = $null
    try {
        $full = Resolve-HarnessPath -RepoRoot $RepoRoot -Path $CheckpointPath
        $checkpointText = Read-HarnessUtf8Text -LiteralPath $full
        $checkpoint = Read-HarnessDataFile -LiteralPath $full
        if ((Get-HarnessProperty -Object $checkpoint -Name 'schema') -ne 'harness.checkpoint-execucao.v1') {
            $issues.Add('schema ausente ou diferente de harness.checkpoint-execucao.v1')
        }
        foreach ($field in @('tarefa_atual', 'etapa', 'inicio', 'ultima_atualizacao', 'fase_atual', 'proxima_fase', 'ultimo_ponto_seguro', 'motivo_pausa')) {
            if ([string]::IsNullOrWhiteSpace([string](Get-HarnessProperty -Object $checkpoint -Name $field))) {
                $issues.Add("$field ausente")
            }
        }
        $auditStarted = Get-HarnessProperty -Object $checkpoint -Name 'auditoria_iniciada'
        if ($auditStarted -isnot [bool]) { $issues.Add('auditoria_iniciada deve ser booleano') }

        $startValue = [System.DateTimeOffset]::MinValue
        $updateValue = [System.DateTimeOffset]::MinValue
        $dateStyles = [System.Globalization.DateTimeStyles]::RoundtripKind
        $culture = [System.Globalization.CultureInfo]::InvariantCulture
        $startValid = [System.DateTimeOffset]::TryParse([string](Get-HarnessProperty -Object $checkpoint -Name 'inicio'), $culture, $dateStyles, [ref]$startValue)
        $updateValid = [System.DateTimeOffset]::TryParse([string](Get-HarnessProperty -Object $checkpoint -Name 'ultima_atualizacao'), $culture, $dateStyles, [ref]$updateValue)
        if (-not $startValid) { $issues.Add('inicio deve usar data ISO-8601 valida') }
        if (-not $updateValid) { $issues.Add('ultima_atualizacao deve usar data ISO-8601 valida') }
        if ($startValid -and $updateValid -and ($updateValue -lt $startValue)) { $issues.Add('ultima_atualizacao anterior ao inicio') }

        $identity = Get-HarnessProperty -Object $checkpoint -Name 'identidade'
        foreach ($field in @('tipo_alvo', 'alvo', 'slug', 'execucao')) {
            if ([string]::IsNullOrWhiteSpace([string](Get-HarnessProperty -Object $identity -Name $field))) { $issues.Add("identidade.$field ausente") }
        }
        $budget = Get-HarnessProperty -Object $checkpoint -Name 'orcamento_minutos'
        $parsedBudget = 0
        if (($null -eq $budget) -or (-not [int]::TryParse([string]$budget, [ref]$parsedBudget)) -or ($parsedBudget -le 0)) { $issues.Add('orcamento_minutos deve ser inteiro positivo') }
        foreach ($field in @('fases_concluidas', 'linha_de_base', 'arquivos_produzidos', 'arquivos_protegidos')) {
            if ($null -eq $checkpoint.PSObject.Properties[$field]) { $issues.Add("$field ausente") }
            else {
                $arrayPattern = '"' + [System.Text.RegularExpressions.Regex]::Escape($field) + '"\s*:\s*\['
                if (-not [System.Text.RegularExpressions.Regex]::IsMatch($checkpointText, $arrayPattern)) { $issues.Add("$field deve ser uma lista JSON") }
            }
        }
        if (@(ConvertTo-HarnessArray (Get-HarnessProperty -Object $checkpoint -Name 'linha_de_base')).Count -eq 0) { $issues.Add('linha_de_base vazia') }
        if (@(ConvertTo-HarnessArray (Get-HarnessProperty -Object $checkpoint -Name 'arquivos_protegidos')).Count -eq 0) { $issues.Add('arquivos_protegidos vazio') }

        foreach ($sectionName in @('linha_de_base', 'arquivos_protegidos', 'arquivos_produzidos')) {
            foreach ($entry in (ConvertTo-HarnessArray (Get-HarnessProperty -Object $checkpoint -Name $sectionName))) {
                $path = [string](Get-HarnessProperty -Object $entry -Name 'caminho')
                $expected = [string](Get-HarnessProperty -Object $entry -Name 'sha256')
                $hashMode = Get-HarnessEntryHashMode -Entry $entry -Errors $issues -Scope $sectionName
                if ((-not (Test-HarnessRelativePath -Path $path)) -or (-not (Test-HarnessSha256Value -Value $expected))) {
                    $issues.Add("entrada invalida em $sectionName")
                    continue
                }
                if ($null -eq $hashMode) { continue }
                $entryFull = Resolve-HarnessPath -RepoRoot $RepoRoot -Path $path
                if (-not [System.IO.File]::Exists($entryFull)) {
                    $differences.Add("$sectionName ausente: $path")
                    continue
                }
                $actual = Get-HarnessSha256 -LiteralPath $entryFull -HashMode $hashMode
                if ($actual -ne $expected.ToUpperInvariant()) {
                    $differences.Add("$sectionName alterado: $path; esperado=$expected; atual=$actual")
                }
            }
        }
    }
    catch { $issues.Add($_.Exception.Message) }

    if ($issues.Count -gt 0) { $status = 'CHECKPOINT_INVALIDO' }
    elseif ($differences.Count -gt 0) { $status = 'RETOMADA_BLOQUEADA_POR_DIVERGENCIA' }
    else { $status = 'RETOMADA_SEGURA' }

    return [pscustomobject]@{
        Checkpoint = $CheckpointPath
        Resultado = $status
        Erros = @($issues)
        Divergencias = @($differences)
        CheckpointObjeto = $checkpoint
    }
}
