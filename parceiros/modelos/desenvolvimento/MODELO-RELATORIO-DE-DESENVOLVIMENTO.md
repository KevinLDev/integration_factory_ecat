# Modelo - Relatório de desenvolvimento

> Modelo global do ERP Parceiro - Passo 06. Não preencher este arquivo com ERP, ferramenta, cliente, IDs ou segredos reais. Em uma execução real, gerar `erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-DESENVOLVIMENTO.md`.

## Regras de uso

- relatar o que foi efetivamente implementado e testado;
- não declarar integração homologada;
- não esconder divergência upstream em decisão de código;
- não persistir credencial, token, secret, PII real desnecessária ou configuração concreta de cliente;
- referenciar evidências, comandos e exit codes reais;
- separar código reutilizado, criado e alterado controladamente;
- manter coerência com `MANIFESTO-DA-IMPLEMENTACAO.yaml`.

# Identificação

| Campo | Valor |
|---|---|
| ERP | `<nome>` |
| ERP slug | `<slug>` |
| Ferramenta | `<nome>` |
| Ferramenta slug | `<slug>` |
| Combinação | `<erp-slug> x <ferramenta-slug>` |
| Jornada | `ERP_PARCEIRO` |
| Etapa | `ERP_PARCEIRO_PASSO_06` |
| Data | `<AAAA-MM-DD>` |
| Responsável | `<responsavel>` |
| Branch/commit base | `<referencia>` |
| Manifesto da implementação | `<caminho>` |

# Baseline

| Fonte/input | Caminho | Versão | SHA-256/modo | Vigência | Uso |
|---|---|---|---|---|---|
| `<tipo>` | `<caminho>` | `<versao-ou-NA>` | `<hash/modo-ou-NA>` | `VIGENTE \| INVALIDA \| EVIDENCIA_INSUFICIENTE` | `<finalidade>` |

- baseline congelada em: `<timestamp>`;
- mudança upstream detectada: `SIM | NAO`;
- implementação anterior encontrada: `SIM | NAO`;
- decisão: `CRIAR | REUTILIZAR | COMPLEMENTAR | REANALISAR | BLOQUEAR`;
- intervenção humana preservada: `<referencias>`.

# Inputs do Passo 05

| Input | Caminho/hash | Estado | Observação |
|---|---|---|---|
| `MAPEAMENTO-SEMANTICO.yaml` | `<referencia>` | `VIGENTE \| INVALIDO` | `<detalhes>` |
| `REGRAS-DE-TRANSFORMACAO.yaml` | `<referencia>` | `VIGENTE \| INVALIDO` | `<detalhes>` |
| `PLANO-DA-INTEGRACAO.md` | `<referencia>` | `VIGENTE \| INVALIDO` | `<detalhes>` |
| `PENDENCIAS.md` | `<referencia>` | `<bloqueantes>` | `<detalhes>` |
| Gate do Passo 05 | `<manifesto/auditoria>` | `APTO \| NAO_APTO` | `<detalhes>` |

# Arquitetura encontrada

```text
ARQUITETURA_EXECUTAVEL_EXISTENTE: SIM | NAO | PARCIAL
```

- package manager e versão: `<valor-ou-ausente>`;
- workspace: `<valor-ou-ausente>`;
- TypeScript/tsconfig: `<referencias-ou-ausente>`;
- raízes de código: `<caminhos>`;
- testes e comandos existentes: `<referencias>`;
- componentes reutilizáveis encontrados: `<lista>`;
- evidência da classificação: `<detalhes>`.

# Arquitetura utilizada

- raiz física aprovada: `<caminho>`;
- decisão física registrada em: `<referencia>`;
- convenções respeitadas: `<lista>`;
- `SHARED_CORE`: `<limite e caminho>`;
- `ERP_REUSABLE`: `<limite e caminho>`;
- `TOOL_REUSABLE`: `<limite e caminho>`;
- `COMBINATION_SPECIFIC`: `<limite e caminho>`;
- abstrações avaliadas e recusadas: `<lista/justificativa>`;
- justificativa contra overengineering: `<detalhes>`.

# Componentes reutilizados

| ID | Responsabilidade | Caminho | Versão/hash | Motivo do reuso | Alteração |
|---|---|---|---|---|---|
| `<COMP-ID>` | `SHARED_CORE \| ERP_REUSABLE \| TOOL_REUSABLE \| COMBINATION_SPECIFIC` | `<caminho>` | `<referencia>` | `<motivo>` | `NAO \| CONTROLADA` |

# Componentes criados

| ID | Responsabilidade | Caminho | Finalidade | Necessidade concreta | Testes |
|---|---|---|---|---|---|
| `<COMP-ID>` | `SHARED_CORE \| ERP_REUSABLE \| TOOL_REUSABLE \| COMBINATION_SPECIFIC` | `<caminho>` | `<finalidade>` | `<evidencia>` | `<TEST-IDs>` |

# Flows implementados

| Flow | Módulo | Direção | Evento | Carga | Dependências | Estado | Evidência/testes |
|---|---|---|---|---|---|---|---|
| `<FLUXO-ID>` | `<modulo>` | `<direcao-do-Passo-05>` | `<evento-do-Passo-05>` | `CARGA_INICIAL \| INCREMENTAL \| AMBOS` | `<DAG>` | `COMPLETO \| PARCIAL \| INSUFICIENTE` | `<referencias>` |

Para cada flow, registrar origem, destino, identidade, correlação, confirmação, falha parcial e política de reprocessamento.

# Mappers e transformações

| Implementação | MAP/TR IDs | Entradas | Saídas | Regra | Valores especiais | Testes | Estado |
|---|---|---|---|---|---|---|---|
| `<caminho/simbolo>` | `<IDs>` | `<campos>` | `<campos>` | `<algoritmo implementado>` | `<null/vazio/zero/false/ausente>` | `<TEST-IDs>` | `APROVADO \| PROBLEMA` |

Registrar precisão monetária, data/timezone, enums e política de valor desconhecido quando aplicáveis. Grade aberta e Grade fechada/Pack devem permanecer separadas conforme o projeto.

# Auth

- sistema: `<ERP | FERRAMENTA>`;
- estratégia comprovada: `<tipo>`;
- componente responsável: `<referencia>`;
- reutilização/refresh: `<regra>`;
- comportamento de `401`: `<renovacao/retry controlado>`;
- teste: `<referencia>`;
- segredo persistido ou impresso: `NAO`.

# Paginação

| Sistema/operação | Estratégia | Página única | Múltiplas | Final | Vazio | Cursor ausente | Erro intermediário |
|---|---|---|---|---|---|---|---|
| `<referencia>` | `<page/offset/cursor/token>` | `<resultado>` | `<resultado>` | `<resultado>` | `<resultado>` | `<resultado>` | `<resultado>` |

# Retry / rate limit

- falhas transitórias cobertas: `<lista>`;
- limite de tentativas: `<valor/evidencia>`;
- `429`/`Retry-After`: `<regra>`;
- `5xx`: `<regra segura>`;
- `4xx` funcional: `<sem retry cego>`;
- `MAPPING_ERROR`/`VALIDATION_ERROR`: `<sem retry automático>`;
- testes: `<referencias>`.

# Correlação / idempotência

- entidades: `<lista>`;
- correlação `ERP_ID <-> ID_LOGICO <-> TOOL_ID`: `<implementacao/porta>`;
- chave idempotente por flow: `<regras>`;
- lookup antes de create/update: `<regras>`;
- nome usado como identidade: `NAO`;
- IDs físicos hardcoded: `NAO`;
- prevenção de loop: `<estrategia do Passo 05>`;
- testes: `<referencias>`.

# Configurações

| ID | Nome | Tipo | Escopo | Obrigatória | Sensível | Valor real persistido | Validação | Impacto se ausente |
|---|---|---|---|---|---|---|---|---|
| `<CFG-ID>` | `<nome>` | `<tipo>` | `INTEGRACAO_REUTILIZAVEL \| CONFIGURACAO_DO_CLIENTE` | `SIM \| NAO` | `SIM \| NAO` | `NAO` | `<regra>` | `<impacto>` |

# Segurança

- escrita HML executada: `NAO`;
- sincronização real executada: `NAO`;
- `POST/PUT/PATCH/DELETE` externo executado: `NAO`;
- secrets no repositório: `NAO`;
- secrets em fixtures: `NAO`;
- secrets em logs/relatório: `NAO`;
- PII real desnecessária: `NAO`;
- mecanismos de ignore verificados: `<evidencia>`;
- varreduras executadas: `<comandos/resultados>`.

# Testes

| ID | Tipo | Alvo | Fixture/mock | Rede externa | Comando | Exit code | Resultado |
|---|---|---|---|---|---|---:|---|
| `<TEST-ID>` | `UNITARIO \| TRANSFORMACAO \| MAPPER \| CONTRATO_DTO \| FLOW_MOCKADO \| AUTH \| PAGINACAO \| RETRY \| ERRO \| CONFIGURACAO` | `<alvo>` | `<referencia>` | `NAO` | `<comando>` | `<codigo>` | `APROVADO \| REPROVADO` |

Fixtures devem ser sintéticas, determinísticas, representativas, sem secret e sem PII real desnecessária. A Base Mestra pode inspirar diversidade sem copiar volume inteiro.

# Build / typecheck / lint

| Validação | Comando descoberto no projeto | Origem do comando | Exit code | Resultado | Evidência |
|---|---|---|---:|---|---|
| `BUILD` | `<comando-ou-NA>` | `<package/config>` | `<codigo-ou-NA>` | `APROVADO \| REPROVADO \| NAO_APLICAVEL` | `<referencia>` |
| `TYPECHECK` | `<comando-ou-NA>` | `<package/config>` | `<codigo-ou-NA>` | `APROVADO \| REPROVADO \| NAO_APLICAVEL` | `<referencia>` |
| `LINT` | `<comando-ou-NA>` | `<package/config>` | `<codigo-ou-NA>` | `APROVADO \| REPROVADO \| NAO_APLICAVEL` | `<referencia>` |

- package manager preservado: `SIM | NAO`;
- TypeScript/tsconfig preservado: `SIM | NAO | NAO_APLICAVEL`;
- dependências adicionadas: `<lista>`;
- justificativas: `<detalhes>`;
- uso de `any`: `<NAO ou justificativa pontual>`.

# Divergências encontradas

| ID | Tipo | Evidência | Impacto | Menor passo responsável | Ação | Estado |
|---|---|---|---|---|---|---|
| `<DIV-ID>` | `BUG_DE_IMPLEMENTACAO \| DIVERGENCIA_DE_PROJETO \| DIVERGENCIA_DE_CONTRATO \| DIVERGENCIA_DE_ARQUITETURA` | `<referencias>` | `BLOQUEANTE \| NAO_BLOQUEANTE` | `<passo>` | `<corrigir localmente/retornar upstream>` | `<estado>` |

Bug do próprio Passo 06 pode ser corrigido nesta etapa. Decisão fundamental upstream não pode ser trocada silenciosamente.

# Pendências

| ID | Resumo | Origem | Impacto | Bloqueante | Próxima ação | Estado no PENDENCIAS.md |
|---|---|---|---|---|---|---|
| `<PEND-ID>` | `<resumo>` | `<referencia>` | `<impacto>` | `SIM \| NAO` | `<acao>` | `<estado>` |

Atualizar somente o `PENDENCIAS.md` canônico da combinação quando necessário.

# Escopo não implementado

| Item | Motivo | Obrigatoriedade | Impacto | Cobertura parcial autorizada | Referência do Passo 05 |
|---|---|---|---|---|---|
| `<item>` | `<motivo>` | `OBRIGATORIO \| OPCIONAL` | `<impacto>` | `SIM \| NAO` | `<referencia>` |

# Gate

```text
ERP_IDENTIFICADO: SIM | NAO
FERRAMENTA_HOMOLOGADA: SIM | NAO
PASSO_05_APTO: SIM | NAO
PROJETO_VIGENTE: SIM | NAO
ARQUITETURA_EXECUTAVEL: DEFINIDA | INSUFICIENTE
ESCOPO_DE_DESENVOLVIMENTO: DEFINIDO | PARCIAL | INSUFICIENTE
CODIGO: GERADO | PARCIAL | NAO_GERADO
FLUXOS_IMPLEMENTADOS: COMPLETOS | PARCIAIS | INSUFICIENTES
BUILD: APROVADO | REPROVADO | NAO_APLICAVEL
TYPECHECK: APROVADO | REPROVADO | NAO_APLICAVEL
LINT: APROVADO | REPROVADO | NAO_APLICAVEL
TESTES_UNITARIOS: APROVADOS | REPROVADOS | INSUFICIENTES
TESTES_TRANSFORMACAO: APROVADOS | REPROVADOS | INSUFICIENTES
TESTES_FLUXO: APROVADOS | REPROVADOS | INSUFICIENTES
AUTH: IMPLEMENTADA | PARCIAL | NAO_APLICAVEL | INSUFICIENTE
PAGINACAO: IMPLEMENTADA | NAO_APLICAVEL | INSUFICIENTE
RETRY_RATE_LIMIT: IMPLEMENTADO | NAO_APLICAVEL | INSUFICIENTE
CONFIGURACAO: DEFINIDA | PARCIAL | INSUFICIENTE
SEGREDOS_NO_REPOSITORIO: NAO | SIM
DIVERGENCIAS_DE_PROJETO: <quantidade>
PENDENCIAS_BLOQUEANTES: <quantidade>
ESCRITA_HML_EXECUTADA: NAO
PRONTO_PARA_EXECUCAO_HML: SIM | NAO
```

# Prontidão para HML

- resultado: `PRONTO_PARA_EXECUCAO_HML: SIM | NAO`;
- justificativa: `<evidencia consolidada>`;
- itens bloqueantes: `<lista-ou-NENHUM>`;
- auditoria: `APROVADA | REPROVADA | BLOQUEADA`;
- manifesto da implementação: `<caminho/hash>`;
- próxima ação permitida: `<aguardar etapa posterior oficialmente publicada>`.

O relatório não declara `INTEGRACAO_HOMOLOGADA`, não executa etapa posterior e não autoriza commit/push automático.
