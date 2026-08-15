# Modelo - Relatorio de validacao tecnica HML

> Modelo global do ERP Parceiro - Passo 07. Em uma execucao real, gerar `erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-VALIDACAO-TECNICA-HML.md`. Nao preencher este modelo com ERP, ferramenta, cliente, IDs fisicos, payloads sensiveis ou segredos reais.

## Regras de uso

- relatar somente a execucao tecnica HML efetivamente realizada;
- manter o projeto do Passo 05 e a implementacao do Passo 06 como entradas somente leitura;
- separar fato observado, comparacao semantica, pendencia e classificacao de falha;
- nao corrigir artefato upstream, Base Mestra, codigo, contrato ou mapeamento durante a auditoria;
- nao declarar `INTEGRACAO_HOMOLOGADA`;
- nao registrar credencial, token, header, payload pessoal desnecessario ou configuracao concreta de cliente.
- registrar somente o resultado da execucao produtora; a promocao posterior segue os controles de estado e manifesto autorizados pela auditoria independente.

# Identificacao

| Campo              | Valor                            |
| ------------------ | -------------------------------- |
| ERP                | `<nome>`                         |
| ERP slug           | `<slug>`                         |
| Ferramenta         | `<nome>`                         |
| Ferramenta slug    | `<slug>`                         |
| Combinacao         | `<erp-slug> x <ferramenta-slug>` |
| Jornada            | `ERP_PARCEIRO`                   |
| Etapa              | `ERP_PARCEIRO_PASSO_07`          |
| Execution ID       | `<id>`                           |
| Data               | `<AAAA-MM-DD>`                   |
| Plano HML          | `<caminho/hash>`                 |
| Evidencias HML     | `<caminho/hash>`                 |
| Manifesto da etapa | `<caminho/hash>`                 |

# Gate de entrada e baseline

| Controle                              | Estado                       | Evidencia                  |
| ------------------------------------- | ---------------------------- | -------------------------- |
| Gates upstream exigidos               | `ATENDIDOS \| NAO_ATENDIDOS` | `<manifestos/auditorias>`  |
| Passo 06 pronto para HML              | `SIM \| NAO`                 | `<referencia>`             |
| Implementacao identificavel e vigente | `SIM \| NAO`                 | `<versao/hash/commit>`     |
| Base Mestra HML apta                  | `SIM \| NAO`                 | `<referencia>`             |
| ERP em HML autorizado                 | `SIM \| NAO`                 | `<fingerprint redigido>`   |
| Ferramenta em HML autorizada          | `SIM \| NAO`                 | `<fingerprint redigido>`   |
| Autorizacao explicita                 | `SIM \| NAO`                 | `<referencia sem segredo>` |

# Limites confirmados

- escrita em producao: `NAO`;
- homologacao funcional executada: `NAO`;
- publicacao executada: `NAO`;
- runtime 24/7 criado: `NAO`;
- configuracao de cliente real: `NAO`;
- segredo persistido ou impresso: `NAO`.

# Flows e casos executados

| Caso        | Flow        | Direcao     | Entidade     | ID logico     | Operacao     | Correlacao        | Reconsulta    | Comparacao semantica | Status     |
| ----------- | ----------- | ----------- | ------------ | ------------- | ------------ | ----------------- | ------------- | -------------------- | ---------- |
| `<CASO-ID>` | `<FLOW-ID>` | `<direcao>` | `<entidade>` | `<id-logico>` | `<operacao>` | `<id sanitizado>` | `<resultado>` | `<resultado>`        | `<status>` |

Para cada caso, referenciar as evidencias estruturadas com tentativa, resultado esperado, resultado observado sanitizado, origem da alteracao, ERP ID, Tool ID, timestamp e versao do codigo.

# Confiabilidade da execucao

| Aspecto                           | Resultado                                | Evidencia               |
| --------------------------------- | ---------------------------------------- | ----------------------- |
| Lookup antes de escrita           | `<resultado>`                            | `<casos>`               |
| Idempotencia                      | `APROVADA \| REPROVADA \| NAO_APLICAVEL` | `<casos repetidos>`     |
| Prevencao de loop                 | `APROVADA \| REPROVADA \| NAO_APLICAVEL` | `<casos bidirecionais>` |
| Ownership e conflito              | `<resultado>`                            | `<casos aplicaveis>`    |
| Paginacao completa                | `<resultado>`                            | `<casos aplicaveis>`    |
| Retry, 429 e rate limit           | `<resultado>`                            | `<casos aplicaveis>`    |
| 401 com refresh/retry controlados | `<resultado>`                            | `<casos aplicaveis>`    |
| Estado incerto apos timeout       | `<resultado>`                            | `<casos aplicaveis>`    |
| Falha parcial                     | `<resultado>`                            | `<casos aplicaveis>`    |
| Checkpoint e retomada             | `<resultado>`                            | `<checkpoint>`          |
| Reprocessamento consciente        | `<resultado>`                            | `<casos aplicaveis>`    |
| Reconciliacao origem-destino      | `<resultado>`                            | `<comparacoes>`         |

# Falhas e menor passo responsavel

| ID           | Classificacao                                                                                                                                                                      | Evidencia sanitizada | Impacto               | Menor passo responsavel                                    | Acao     |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------- | --------------------- | ---------------------------------------------------------- | -------- |
| `<FALHA-ID>` | `ERRO_DE_EXECUCAO_HML \| BUG_DE_IMPLEMENTACAO \| DIVERGENCIA_DE_PROJETO \| BASE_DE_HOMOLOGACAO_INSUFICIENTE \| EVIDENCIA_DE_ERP_INSUFICIENTE \| CONTRATO_DA_FERRAMENTA_DIVERGENTE` | `<referencia>`       | `<bloqueante ou nao>` | `<07 \| 06 \| 05 \| 03 \| 04 \| 02 \| jornada ferramenta>` | `<acao>` |

`ERRO_DE_EXECUCAO_HML` pode ser reprocessado no Passo 07 somente quando seguro. Nenhuma classificacao upstream pode ser corrigida silenciosamente nesta etapa.

# Harness e auditoria

- manifesto: `<caminho/resultado>`;
- checkpoint: `<caminho/resultado ou NAO_APLICAVEL>`;
- validacoes mecanicas: `<comandos, exit codes e resultados>`;
- arquivos protegidos: `<lista/hash>`;
- vigencia calculada: `<resultado>`;
- auditoria: `AGUARDANDO_INDEPENDENTE`;
- status da etapa: `PENDENTE`;
- prontidao para homologacao funcional: `NAO`;
- auditoria independente posterior: `PROFUNDA` quando esta for a primeira execucao HML real da combinacao; somente ela pode promover os controles pelo mecanismo de estado e manifesto vigente.

# Gate final

```text
AMBIENTE_HML_VALIDADO: SIM | NAO
AUTORIZACAO_HML: SIM | NAO
IMPLEMENTACAO_VIGENTE: SIM | NAO
BASE_MESTRA_HML_APTA: SIM | NAO
FLUXOS_APLICAVEIS_EXECUTADOS: SIM | PARCIAL_JUSTIFICADO | NAO
CORRELACOES_VALIDAS: SIM | PARCIAIS | NAO
IDEMPOTENCIA_APROVADA: SIM | NAO | NAO_APLICAVEL
PREVENCAO_DE_LOOP_APROVADA_QUANDO_APLICAVEL: SIM | NAO | NAO_APLICAVEL
RECONCILIACAO_APROVADA: SIM | PARCIAL_JUSTIFICADA | NAO
REPROCESSAMENTO_SEGURO: SIM | NAO | NAO_APLICAVEL
FALHAS_BLOQUEANTES: <quantidade>
DIVERGENCIAS_DE_PROJETO: <quantidade>
ESCRITA_PRODUCAO: NAO
HOMOLOGACAO_FUNCIONAL_EXECUTADA: NAO
PUBLICACAO_EXECUTADA: NAO
VALIDACAO_TECNICA_HML: APROVADA | PARCIAL_JUSTIFICADA | REPROVADA | BLOQUEADA
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS DA ETAPA: PENDENTE
PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: NAO
```

O maior resultado possivel deste relatorio produtor e `VALIDACAO_TECNICA_HML: APROVADA`, com auditoria independente ainda pendente. Somente depois de auditoria independente `APROVADA` os controles de estado e manifesto vigentes, fora deste relatorio produtor, podem registrar:

```text
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM
```

Isto nao equivale a `INTEGRACAO_HOMOLOGADA`.
