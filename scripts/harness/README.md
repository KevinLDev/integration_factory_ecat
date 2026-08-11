# Scripts determinísticos do Harness

Esta pasta contém validações mecânicas genéricas. Os scripts não executam jornadas, não interpretam regras de negócio e são somente leitura dos artefatos de negócio por padrão.

## Compatibilidade

Os scripts usam somente Windows PowerShell 5.1 e APIs do .NET já disponíveis. Nenhum módulo ou pacote externo é necessário.

Manifestos e checkpoints usam arquivos `.yaml` no subconjunto YAML 1.2 compatível com JSON. Essa restrição permite leitura determinística com `ConvertFrom-Json`, sem instalar parser YAML. Caminhos armazenados nesses controles devem ser relativos à raiz do repositório e usar `/`.

Hashes declarados em manifestos e checkpoints usam um modo explícito por entrada. `BYTES_V1` continua sendo hash por bytes exatos, enquanto `TEXT_CANONICAL_V1` normaliza texto UTF-8 removendo um BOM inicial e convertendo `CRLF` e `CR` para `LF` antes do SHA-256. Isso torna os artefatos textuais portáveis entre PCs, checkouts e políticas de fim de linha sem relaxar a integridade de binários.

Como a política efetiva da máquina pode ser `Restricted`, a entrada recomendada é `harness.cmd`. Ela aplica `-ExecutionPolicy Bypass` somente ao processo filho; não usa `Set-ExecutionPolicy` nem altera configuração persistente.

## Comandos

```text
scripts\harness\harness.cmd hash <caminho> [-ExpectedSha256 <hash>]
scripts\harness\harness.cmd files -Path <caminhos>
scripts\harness\harness.cmd manifest <manifesto>
scripts\harness\harness.cmd checkpoint <checkpoint>
scripts\harness\harness.cmd selftest -ManifestDirectory <diretorio> -Expect "<arquivo=vigencia;arquivo=vigencia>"
```

- `Get-HarnessHash.ps1`: calcula SHA-256 por bytes exatos ou por texto canônico, e opcionalmente compara com um valor esperado.
- `Test-HarnessFiles.ps1`: valida presença, UTF-8 estrito, Markdown básico, referências locais verificáveis, contagens e IDs por regex fornecida.
- `Test-HarnessManifest.ps1`: confere schema, fontes, entradas, saídas, auditoria vigente, dependências transitivas, hashes, vigência e gate de reutilização. Na jornada de nova ferramenta, o gate do Passo 03 é fixo e não pode ser enfraquecido pelo manifesto: exige aptidão técnica, auditoria aprovada e profunda, etapa concluída e prontidão homologada.
- `Test-HarnessCheckpoint.ps1`: valida estrutura, datas, tipos e compara linha de base, arquivos produzidos e arquivos protegidos antes de uma retomada.
- `Invoke-HarnessTests.ps1`: executa expectativas reais e simulações isoladas de invalidação/restauração em cascata transitiva, upstream sem gate, gate especializado, dependência inválida, checkpoint e entradas vazias em `.tmp/harness-tests/`, removida ao final.

## Exit codes

| Código | Significado |
|---:|---|
| `0` | validação aprovada ou retomada segura |
| `1` | uso, schema ou leitura inválida |
| `2` | divergência, obsolescência ou retomada bloqueada |

Um manifesto declarado como invalidado continua retornando `2`: o histórico pode estar coerente, mas não é reutilizável como gate vigente.

Listas passadas pelo wrapper usam `;` dentro de um único argumento, por exemplo `-Path "arquivo-a.md;arquivo-b.md"`.

Os caminhos são confinados à raiz do repositório e não podem atravessar links simbólicos ou junctions. Listas vazias são rejeitadas; `dependencias` exige etapa, manifesto upstream, `hash_mode` e ao menos um hash esperado.

Manifestos reais devem seguir `parceiros/execucoes/<tipo>/<slug>/manifestos/PASSO-<NN>.yaml`; tipo, slug, execução e etapa precisam coincidir com esse caminho. Assim, o gate fixo do Passo 03 da trilha de ferramentas continua obrigatório mesmo se alguém adulterar os campos de identidade do manifesto.

## Limites

- Hash prova identidade dos bytes, não correção semântica.
- `TEXT_CANONICAL_V1` prova identidade do texto canônico, não da forma exata de fim de linha ou BOM.
- Manifesto não substitui fonte, estado nem auditoria.
- Checkpoint não substitui `ESTADO-DA-EXECUCAO.md`.
- Scripts não substituem análise semântica da IA.
- Verificação sem mudança não regrava manifesto nem timestamp.
