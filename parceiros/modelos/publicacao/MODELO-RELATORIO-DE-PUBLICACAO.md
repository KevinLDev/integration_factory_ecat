# Modelo - Relatorio de publicacao

> Modelo global do ERP Parceiro - Passo 09. Em uma execucao real, gerar `erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-PUBLICACAO.md`.

## Regras de uso

- consolidar somente baseline homologada vigente;
- nao redesenvolver ou re-homologar a integracao;
- nao declarar `INTEGRACAO_PUBLICADA: SIM` na execucao produtora;
- nao persistir segredo, dados de cliente ou IDs HML como configuracao reutilizavel;
- manter rastreabilidade para o Passo 08 e auditoria independente.

# Identificacao

| Campo | Valor |
|---|---|
| ERP | `<nome>` |
| ERP slug | `<slug>` |
| Ferramenta | `<nome>` |
| Ferramenta slug | `<slug>` |
| Combinacao | `<erp-slug> x <ferramenta-slug>` |
| Jornada | `ERP_PARCEIRO` |
| Etapa | `ERP_PARCEIRO_PASSO_09` |
| Versao release | `<MAJOR.MINOR.PATCH>` |
| Data | `<AAAA-MM-DD>` |

# Baseline homologado

| Item | Referencia | Hash/modo | Estado |
|---|---|---|---|
| Commit implementacao | `<commit>` | `NA` | `VIGENTE \| DIVERGENTE` |
| Manifesto Passo 08 | `<caminho>` | `<hash/modo>` | `<estado>` |
| Relatorio funcional Passo 08 | `<caminho>` | `<hash/modo>` | `<estado>` |
| Auditoria independente Passo 08 | `<caminho>` | `<hash/modo>` | `<estado>` |
| Mapeamento semantico | `<caminho>` | `<hash/modo>` | `<estado>` |
| Regras de transformacao | `<caminho>` | `<hash/modo>` | `<estado>` |
| Plano da integracao | `<caminho>` | `<hash/modo>` | `<estado>` |
| Contrato da ferramenta | `<caminho>` | `<hash/modo>` | `<estado>` |

# Capacidades publicadas

Status permitidos:

- `SUPORTADO`
- `SUPORTADO_COM_RESTRICAO`
- `NAO_SUPORTADO`
- `NAO_APLICAVEL`

| Capacidade | Direcao | Status | Restricoes | Pre-condicoes | Dependencias | Referencia |
|---|---|---|---|---|---|---|
| `<capacidade>` | `<direcao>` | `<status>` | `<lista>` | `<lista>` | `<lista>` | `<artefatos>` |

# Contrato de configuracao

| Parametro | Escopo | Tipo | Obrigatorio | Sensivel | Regra |
|---|---|---|---|---|---|
| `<nome>` | `CONFIGURACAO_REUTILIZAVEL \| CONFIGURACAO_DO_CLIENTE` | `<tipo>` | `<SIM/NAO>` | `<SIM/NAO>` | `<validacao>` |

- segredo real persistido: `NAO`;
- IDs HML embutidos na configuracao: `NAO`;
- dados de cliente embutidos: `NAO`.

# Catalogo operacional

- atualizado em `erps-integrados/`: `SIM | NAO`;
- sem duplicar fonte tecnica: `SIM`;
- referencia para fonte tecnica canonica: `<caminho>`.

# Gate da execucao produtora

```text
BASELINE_HOMOLOGADA_INTEGRA: SIM | NAO
VERSAO_RELEASE_DEFINIDA: SIM | NAO
CAPACIDADES_CONSOLIDADAS: SIM | NAO
CONTRATO_CONFIGURACAO_DEFINIDO: SIM | NAO
REUTILIZAVEL: SIM | NAO
SEGREDOS_EMBUTIDOS: NAO
IDS_HML_INDEVIDOS: NAO
DADOS_CLIENTE_EMBUTIDOS: NAO
CATALOGO_OPERACIONAL_ATUALIZADO: SIM | NAO
PUBLICACAO_PREPARADA: SIM | NAO
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS DA ETAPA: PENDENTE | BLOQUEADA
INTEGRACAO_HOMOLOGADA: SIM
INTEGRACAO_PUBLICADA: NAO
DISPONIVEL_PARA_CLIENTE: NAO
EM_PRODUCAO: NAO
```

# Promocao pos-auditoria

Somente apos auditoria independente aprovada:

```text
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
INTEGRACAO_HOMOLOGADA: SIM
INTEGRACAO_PUBLICADA: SIM
DISPONIVEL_PARA_CLIENTE: SIM
EM_PRODUCAO: NAO
```

# Idempotencia

- ja publicada para mesma baseline + versao: `SIM | NAO`;
- resultado: `JA_PUBLICADA | NOVA_PUBLICACAO_PREPARADA | BLOQUEADA`.

# Failure routing

| Finding | Classificacao | Menor passo responsavel | Acao |
|---|---|---|---|
| `<id>` | `<classificacao>` | `<passo>` | `<acao>` |

# Harness

- validacoes mecanicas executadas: `<comandos e exit codes>`;
- resultado: `<resumo>`;
- observacao: Harness nao prova comportamento funcional da integracao.
