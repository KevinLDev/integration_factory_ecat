# Modelo - Relatorio de homologacao funcional

> Modelo global do ERP Parceiro - Passo 08. Em uma execucao real, gerar `erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-HOMOLOGACAO-FUNCIONAL.md`.

## Regras de uso

- representar somente a execucao funcional realizada;
- modelo V1: execucao manual do operador assistida por IA;
- nao declarar automacao UI ou observer realtime nesta versao;
- nao declarar `INTEGRACAO_HOMOLOGADA` na execucao produtora;
- nao persistir segredos, tokens, Authorization ou PII desnecessaria;
- manter rastreabilidade por cenario e por artefato upstream.

# Identificacao

| Campo | Valor |
|---|---|
| ERP | `<nome>` |
| ERP slug | `<slug>` |
| Ferramenta | `<nome>` |
| Ferramenta slug | `<slug>` |
| Combinacao | `<erp-slug> x <ferramenta-slug>` |
| Jornada | `ERP_PARCEIRO` |
| Etapa | `ERP_PARCEIRO_PASSO_08` |
| Execution ID | `<id>` |
| Data | `<AAAA-MM-DD>` |
| Plano funcional | `<caminho/hash>` |
| Matriz de cenarios | `<caminho/hash>` |
| Evidencias funcionais | `<caminho/hash>` |
| Manifesto da etapa | `<caminho/hash>` |

# Gate de entrada

| Controle | Estado | Evidencia |
|---|---|---|
| Passo 07 apto para homologacao funcional | `SIM \| NAO` | `<manifesto/relatorio>` |
| Implementacao vigente | `SIM \| NAO` | `<versao/hash/commit>` |
| Escopo funcional derivado do suporte real | `SIM \| NAO` | `<mapeamento/plano>` |
| Execucao manual HML disponivel | `SIM \| NAO` | `<registro>` |

# Limites confirmados

- automacao UI implementada: `NAO`;
- observer realtime implementado: `NAO`;
- producao executada: `NAO`;
- cliente real utilizado: `NAO`;
- publicacao executada: `NAO`;
- passo 09 criado: `NAO`.

# Matriz funcional executada

| Cenario | Area | Criticidade | Perfil | Executor | Status | Evidencia |
|---|---|---|---|---|---|---|
| `<scenario_id>` | `<area>` | `<criticidade>` | `<perfil>` | `HUMANO` | `<status>` | `<referencia>` |

# Resultados por cenario

| Cenario | Esperado | Observado | IDs | Classificacao | Menor passo responsavel | Reexecucao |
|---|---|---|---|---|---|---|
| `<scenario_id>` | `<resumo>` | `<resumo>` | `<ferramenta/erp>` | `<classificacao>` | `<passo>` | `<SIM/NAO>` |

# Taxonomia de falhas aplicada

| ID | Classificacao | Evidencia | Impacto | Menor passo responsavel | Acao |
|---|---|---|---|---|---|
| `<falha_id>` | `<classificacao>` | `<referencia>` | `<bloqueante/nao_bloqueante>` | `<passo>` | `<acao>` |

# Reexecucao e invalidacao

- cenarios reiniciados por mudanca upstream: `<lista>`;
- criterio de invalidacao aplicado: `<detalhes>`;
- aprovacao restaurada automaticamente: `NAO`.

# Harness e auditoria

- manifesto: `<caminho/resultado>`;
- checkpoint: `<caminho/resultado ou NAO_APLICAVEL>`;
- validacoes mecanicas: `<comandos e exit codes>`;
- auditoria da execucao produtora: `AGUARDANDO_INDEPENDENTE`;
- status da etapa: `PENDENTE`;
- integracao homologada: `NAO`.

# Gate final da execucao produtora

```text
MATRIZ_FUNCIONAL_DERIVADA_DO_ESCOPO: SIM | NAO
CENARIOS_CRITICOS_EXECUTADOS: SIM | NAO
EVIDENCIA_FUNCIONAL_SUFICIENTE: SIM | PARCIAL | NAO
FALHAS_CRITICAS: <quantidade>
FALHAS_ALTAS: <quantidade>
REEXECUCOES_PENDENTES: <quantidade>
ESCRITA_PRODUCAO: NAO
AUTOMACAO_UI_IMPLEMENTADA: NAO
OBSERVER_REALTIME_IMPLEMENTADO: NAO
PASSO_09_EXECUTADO: NAO
PUBLICACAO_EXECUTADA: NAO
CLIENTE_REAL_UTILIZADO: NAO
HOMOLOGACAO_FUNCIONAL: APROVADA | REPROVADA | BLOQUEADA
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS DA ETAPA: PENDENTE
INTEGRACAO_HOMOLOGADA: NAO
```

Somente apos auditoria independente aprovada, os controles de estado e manifesto podem registrar:

```text
HOMOLOGACAO_FUNCIONAL: APROVADA
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
INTEGRACAO_HOMOLOGADA: SIM
```
