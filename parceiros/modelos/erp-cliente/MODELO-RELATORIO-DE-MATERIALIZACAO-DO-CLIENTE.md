# Modelo - Relatorio de materializacao da instalacao do cliente em HML

> Modelo global do ERP Cliente - Passo 04.

## Regras de uso

- materializar somente o que o Passo 03 projetou para capacidades `ATIVO`/`PRONTO_PARA_ATIVACAO` (nao reprojetar nem reclassificar);
- escrever apenas em ambiente HML, homologacao, sandbox, teste ou DEV autorizado -- nunca producao;
- exigir autorizacao explicita antes da primeira escrita;
- confirmar cada escrita por reconsulta;
- garantir idempotencia (reexecucao nao duplica);
- nao persistir segredo;
- a execucao produtora nunca se autoaprova -- encerra com `AUDITORIA: AGUARDANDO_INDEPENDENTE`.

# Identificacao

| Campo | Valor |
|---|---|
| Cliente | `<nome>` |
| Cliente slug | `<slug>` |
| ERP | `<nome>` |
| ERP slug | `<slug>` |
| Ferramenta | `<nome>` |
| Ferramenta slug | `<slug>` |
| Combinacao | `<erp-slug>--<ferramenta-slug>` |
| Versao release | `<versao-ou-NA>` |

# Ambiente

| Campo | Valor |
|---|---|
| Classificacao | `HML \| HOMOLOGACAO \| SANDBOX \| TESTE \| DEV_AUTORIZADO` |
| Fingerprint nao sensivel | `<identificador-sem-segredo>` |
| Autorizacao explicita | `SIM \| NAO` |
| Autorizado por | `<operador>` |

# Gate de entrada

```text
PASSO_03_CONCLUIDO: SIM | NAO
PLANO_DE_INSTALACAO_CONSOLIDADO: SIM | PARCIAL | NAO
PRONTO_PARA_MATERIALIZACAO_EM_HML: SIM | NAO
VIGENCIA_DO_PLANO: VIGENTE | PLANO_POTENCIALMENTE_OBSOLETO | EVIDENCIA_INSUFICIENTE
```

# Resumo da materializacao

| Item | Valor |
|---|---|
| Materializacao | `COMPLETA \| PARCIAL_JUSTIFICADA \| INSUFICIENTE \| BLOQUEADA` |
| Reconsulta | `APROVADA \| PARCIAL \| INSUFICIENTE` |
| Idempotencia aprovada | `SIM \| NAO \| NAO_APLICAVEL` |
| Falhas bloqueantes | `<quantidade>` |
| Escrita em producao | `NAO` |
| Segredo persistido | `NAO` |

# Itens materializados

| Capacidade | Acao | Configuracao | De-para | Extensao | Dependencias respeitadas | Pendencia |
|---|---|---|---|---|---|---|
| `<capacidade>` | `ESCRITA_CONFIRMADA \| REUTILIZADO_EXISTENTE \| DIVERGENTE_APOS_RECONSULTA \| FALHOU_NA_ESCRITA \| FALHOU_NA_RECONSULTA \| NAO_APLICAVEL` | `<refs-ou-NA>` | `<refs-ou-NA>` | `SIM \| NAO \| NAO_APLICAVEL` | `SIM \| NAO` | `<descricao-ou-NA>` |

# Itens nao materializados

| Capacidade | Motivo | Rota |
|---|---|---|
| `<capacidade>` | `FORA_DE_ESCOPO_NO_PASSO_03 \| BLOQUEIO_NA_MATERIALIZACAO \| GAP_DA_RELEASE \| GAP_DA_FERRAMENTA` | `<rota>` |

# Pendencias

## Bloqueantes

- `<pendencia-bloqueante-ou-NA>`

## Nao bloqueantes

- `<pendencia-nao-bloqueante-ou-NA>`

# Auditoria independente exigida

```text
TIPO_EXIGIDO: PROFUNDA
MOTIVO: Primeira execucao real de escrita desta combinacao de cliente
RESULTADO: AGUARDANDO_INDEPENDENTE
```

# Seguranca

- segredo persistido: `NAO`;
- escrita em producao: `NAO`.

# Status final da execucao produtora

```text
MATERIALIZACAO: COMPLETA | PARCIAL_JUSTIFICADA | INSUFICIENTE | BLOQUEADA
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS_DA_ETAPA: PENDENTE
PRONTO_PARA_VALIDACAO_HML: NAO
PROXIMO_PASSO: AUDITORIA_INDEPENDENTE_PASSO_04
```

> Somente a auditoria independente `PROFUNDA` aprovada pode promover `AUDITORIA: APROVADA`, `STATUS_DA_ETAPA: CONCLUIDA` e `PRONTO_PARA_VALIDACAO_HML: SIM`.
