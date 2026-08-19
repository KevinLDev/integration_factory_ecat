# Modelo - Relatorio de go-live e validacao de producao do cliente

> Modelo global do ERP Cliente - Passo 06.

## Regras de uso

- esta e a primeira etapa de toda a fabrica que escreve em producao -- tratar com o maior rigor;
- nao iniciar escrita sem autorizacao de producao e plano de contingencia definidos;
- bloquear se o ambiente nao for producao real comprovada (nunca HML/sandbox/teste);
- nao re-homologar nem revalidar o que os Passos 04/05 ja aprovaram;
- falha parcial nunca gera rollback automatico de dado real -- preserva sucessos e aciona o plano de contingencia;
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

# Fase 1 -- Autorizacao de go-live

```text
PASSO_05_CONCLUIDO: SIM | NAO
AUDITORIA_PASSO_05: APROVADA | NAO_APROVADA
PRONTO_PARA_PRODUCAO: SIM | NAO
CENARIOS_CRITICOS_OU_ALTOS_PENDENTES: SIM | NAO
PLANO_DE_CONTINGENCIA_DEFINIDO: SIM | NAO
AUTORIZACAO_PRODUCAO: SIM | NAO
AMBIENTE_PRODUCAO_CONFIRMADO: SIM | NAO
```

Plano de contingencia registrado: `<descricao>`

Autorizado por: `<operador>`

# Fase 2 -- Go-live

| Capacidade | ID logico | ID fisico producao | Acao | Confirmado por reconsulta | Pendencia |
|---|---|---|---|---|---|
| `<capacidade>` | `<id>` | `<id>` | `ESCRITA_CONFIRMADA \| REUTILIZADO_EXISTENTE \| DIVERGENTE_APOS_RECONSULTA \| FALHOU_NA_ESCRITA \| FALHOU_NA_RECONSULTA` | `SIM \| NAO` | `<descricao-ou-NA>` |

| Item | Valor |
|---|---|
| Go-live | `EXECUTADO \| PARCIAL_JUSTIFICADO \| BLOQUEADO` |
| Reconsulta | `APROVADA \| PARCIAL \| INSUFICIENTE` |
| Idempotencia aprovada | `SIM \| NAO \| NAO_APLICAVEL` |
| Falha parcial ocorreu | `SIM \| NAO` |
| Plano de contingencia acionado | `SIM \| NAO \| NAO_APLICAVEL` |

# Fase 3 -- Confirmacao pos-go-live

| Cenario | Resultado observado | Status | Classificacao da falha | Menor passo responsavel |
|---|---|---|---|---|
| `<scenario_id>` | `<texto>` | `APROVADO \| REPROVADO \| BLOQUEADO \| NAO_APLICAVEL \| PENDENTE \| PENDENTE_DE_EVIDENCIA` | `<classificacao-ou-NENHUMA>` | `<passo-ou-NA>` |

| Item | Valor |
|---|---|
| Validacao pos-go-live | `APROVADA \| REPROVADA \| PENDENTE` |
| Memoria registrada | `SIM \| NAO` |

# Pendencias

## Bloqueantes

- `<pendencia-bloqueante-ou-NA>`

## Nao bloqueantes

- `<pendencia-nao-bloqueante-ou-NA>`

# Auditoria independente exigida

```text
TIPO_EXIGIDO: PROFUNDA
MOTIVO: Primeira execucao de producao de toda a fabrica
RESULTADO: AGUARDANDO_INDEPENDENTE
```

# Seguranca

- segredo persistido: `NAO`;
- rollback automatico executado: `NAO`.

# Status final da execucao produtora

```text
GO_LIVE: EXECUTADO | PARCIAL_JUSTIFICADO | BLOQUEADO
VALIDACAO_POS_GO_LIVE: APROVADA | REPROVADA | PENDENTE
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS_DA_ETAPA: PENDENTE
CLIENTE_INTEGRADO: NAO
PROXIMO_PASSO: AUDITORIA_INDEPENDENTE_PASSO_06
```

> Somente a auditoria independente `PROFUNDA` aprovada pode promover `AUDITORIA: APROVADA`, `STATUS_DA_ETAPA: CONCLUIDA` e `CLIENTE_INTEGRADO: SIM`.
