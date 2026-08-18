# Modelo - Relatorio de projeto de instalacao do cliente

> Modelo global do ERP Cliente - Passo 03.

## Regras de uso

- projetar somente a instalacao do cliente para capacidades ja classificadas como `ATIVO` ou `PRONTO_PARA_ATIVACAO` pelo Passo 02;
- nao reclassificar capacidade (isso pertence exclusivamente ao Passo 02; se a evidencia mudou, retornar ao Passo 02);
- nao materializar configuracao, de-para ou extensao real;
- nao executar HML;
- nao executar producao;
- nao persistir segredo.

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

# Gate de entrada

```text
PASSO_01_CONCLUIDO: SIM | NAO
PASSO_02_CONCLUIDO: SIM | NAO
MATRIZ_COMERCIAL_CONSOLIDADA: SIM | PARCIAL | NAO
APTO_PARA_PROJETAR_INSTALACAO: SIM | NAO
PENDENCIAS_BLOQUEANTES_DO_PASSO_02: SIM | NAO
```

# Resumo do projeto

| Item | Valor |
|---|---|
| Projeto de instalacao | `CONCLUIDO \| PARCIAL \| BLOQUEADO` |
| Plano de instalacao consolidado | `SIM \| PARCIAL \| NAO` |
| Configuracao projetada | `SIM \| NAO` |
| De-para projetado | `SIM \| NAO` |
| Extensao projetada | `SIM \| NAO \| NAO_APLICAVEL` |
| Plano de ativacao definido | `SIM \| NAO \| NAO_APLICAVEL` |
| Criterios de aceite definidos | `SIM \| NAO` |
| Pronto para materializacao em HML | `SIM \| NAO` |

# Regra de escopo

> Somente capacidades com `origem_status = ATIVO` ou `origem_status = PRONTO_PARA_ATIVACAO` no Passo 02 entram no plano de instalacao. Capacidades `NAO_SUPORTADO` ou `PENDENTE_DE_EVIDENCIA` vao para "Itens fora de escopo", nunca para o plano.

# Regra de gap aberto

> Capacidades com `GAP_DA_RELEASE` ou `GAP_DA_FERRAMENTA` aberto no Passo 02 nao bloqueiam o restante do Passo 03. Elas ficam em "Itens fora de escopo" com a rota de origem preservada; o projeto segue com o que ja tem evidencia suficiente.

# Plano de instalacao

| Capacidade | Origem (status Passo 02) | Configuracao projetada | De-para projetado | Extensao projetada | Plano de ativacao | Criterios de aceite | Restricoes | Riscos | Pendencia |
|---|---|---|---|---|---|---|---|---|---|
| `<capacidade>` | `ATIVO \| PRONTO_PARA_ATIVACAO` | `<refs-ou-NA>` | `<refs-ou-NA>` | `SIM \| NAO` | `<refs-ou-NA>` | `<lista>` | `<lista-ou-NA>` | `<lista-ou-NA>` | `<descricao-ou-NA>` |

# Configuracoes projetadas

- `<configuracao-ou-NA>` (indicar `escopo`: `CONFIGURACAO_REUTILIZAVEL` ou `CONFIGURACAO_DO_CLIENTE`)

# De-paras projetados

- `<de-para-ou-NA>`

# Extensoes projetadas

- `<extensao-ou-NA>`

# Plano de ativacao (capacidades PRONTO_PARA_ATIVACAO)

- `<capacidade>`: pre-condicoes `<lista>`, dependencias `<lista>`, ordem sugerida `<texto>`

# Itens fora de escopo

| Capacidade | Origem (status Passo 02) | Gap identificado | Motivo | Rota |
|---|---|---|---|---|
| `<capacidade>` | `NAO_SUPORTADO \| PENDENTE_DE_EVIDENCIA` | `NENHUM \| GAP_DA_RELEASE \| GAP_DA_FERRAMENTA \| DIVERGENCIA_DE_EVIDENCIA` | `<texto>` | `<rota>` |

# Pendencias

## Bloqueantes

- `<pendencia-bloqueante-ou-NA>`

## Nao bloqueantes

- `<pendencia-nao-bloqueante-ou-NA>`

# Rota de saida

```text
PROXIMO_PASSO: ERP_CLIENTE_04 | ERP_PARCEIRO_<NN> | NOVA_FERRAMENTA_<NN> | BLOQUEADA
MOTIVO: <texto>
```

# Seguranca

- segredo persistido: `NAO`;
- HML executada: `NAO`;
- producao executada: `NAO`.

# Status final

```text
STATUS_DA_ETAPA: CONCLUIDA | PENDENTE | BLOQUEADA
```
