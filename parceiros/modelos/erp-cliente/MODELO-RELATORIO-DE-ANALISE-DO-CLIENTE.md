# Modelo - Relatorio de analise do cliente

> Modelo global do ERP Cliente - Passo 02.

## Regras de uso

- analisar somente a realidade comercial e tecnica do cliente;
- nao projetar a instalacao final;
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
CONTEXTO_CLIENTE_RESOLVIDO: SIM | NAO
RELEASE_REUTILIZAVEL: SIM | NAO
RELEASE_ELEGIVEL: SIM | NAO | INDETERMINADA
INTEGRACAO_PUBLICADA: SIM | NAO | INDETERMINADA
DISPONIVEL_PARA_CLIENTE: SIM | NAO | INDETERMINADA
VERSAO_RELEASE_RESOLVIDA: SIM | NAO
```

# Resumo da analise

| Item | Valor |
|---|---|
| Analise do cliente | `CONCLUIDA \| PARCIAL \| BLOQUEADA` |
| Matriz comercial consolidada | `SIM \| PARCIAL \| NAO` |
| Apto para projetar instalacao | `SIM \| NAO` |
| Release publicada | `SIM \| NAO \| INDETERMINADA` |
| Contrato de configuracao | `<ref>` |
| Manifesto de publicacao | `<ref>` |

# Matriz comercial

> **Invariantes de classificacao obrigatorias antes de preencher esta tabela:**
>
> - `ATIVO` exige **cadeia completamente comprovada**: `ferramenta_ecat_suporta=SIM`, `erp_suporta=SIM`, `release_publicada_suporta=SIM`, `cliente_possui=SIM`, `cliente_usa_atualmente=SIM` e evidencias suficientes de todos os componentes. Qualquer suporte obrigatorio `INDETERMINADO` **proibe** `ATIVO`; usar `PENDENTE_DE_EVIDENCIA`.
>
> - `PRONTO_PARA_ATIVACAO` exige **cadeia de suporte completamente comprovada**: `ferramenta_ecat_suporta=SIM`, `erp_suporta=SIM`, `release_publicada_suporta=SIM` e evidencias suficientes. Nao significa apenas "cliente nao usa hoje". Qualquer suporte obrigatorio `INDETERMINADO` **proibe** `PRONTO_PARA_ATIVACAO`; usar `PENDENTE_DE_EVIDENCIA`.
>
> - `NAO_SUPORTADO` exige **evidencia negativa suficiente** (contrato, documentacao oficial, API, ou restricao comprovada). "Nao encontrei documentacao", "campo nao apareceu no exemplo" ou "nome nao localizado" **nao constituem evidencia negativa**. Sem prova: `PENDENTE_DE_EVIDENCIA`.
>
> - `PENDENTE_DE_EVIDENCIA` e **obrigatorio** quando qualquer componente relevante estiver `INDETERMINADO` ou quando a evidencia necessaria estiver ausente. Desconhecido **nao vira falso automaticamente**.

| Capacidade | Ferramenta | ERP | Release | Cliente possui | Cliente usa hoje | Status | Decisao | Gap | Rota | Evidencia | Pendencia |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `<capacidade>` | `SIM \| NAO \| INDETERMINADO` | `SIM \| NAO \| INDETERMINADO` | `SIM \| NAO \| INDETERMINADO` | `SIM \| NAO \| INDETERMINADO` | `SIM \| NAO \| INDETERMINADO` | `ATIVO \| PRONTO_PARA_ATIVACAO \| NAO_SUPORTADO \| PENDENTE_DE_EVIDENCIA` | `ATIVAR \| DEIXAR_PRONTO \| CONFIGURACAO_CLIENTE \| DE_PARA_CLIENTE \| EXTENSAO_CLIENTE \| GAP_DA_RELEASE \| GAP_DA_FERRAMENTA \| DIVERGENCIA_DE_EVIDENCIA \| PENDENTE \| NAO_APLICAVEL` | `NENHUM \| GAP_DA_RELEASE \| GAP_DA_FERRAMENTA \| DIVERGENCIA_DE_EVIDENCIA` | `<rota>` | `<refs>` | `<descricao-ou-NA>` |

# Configuracoes do cliente

- `<configuracao-ou-NA>`

# De-paras do cliente

- `<de-para-ou-NA>`

# Extensoes do cliente

- `<extensao-ou-NA>`

# Gaps e divergencias

## Gap da release

- `<gap-ou-NA>`

## Gap da ferramenta

- `<gap-ou-NA>`

## Divergencia de evidencia

- `<divergencia-ou-NA>`

# Pendencias

## Bloqueantes

- `<pendencia-bloqueante-ou-NA>`

## Nao bloqueantes

- `<pendencia-nao-bloqueante-ou-NA>`

# Handoff para o Passo 03

- capacidades ativas: `<lista-ou-NA>`
- capacidades prontas para ativacao: `<lista-ou-NA>`
- configuracoes necessarias: `<lista-ou-NA>`
- de-paras necessarios: `<lista-ou-NA>`
- extensoes necessarias: `<lista-ou-NA>`
- restricoes: `<lista-ou-NA>`
- riscos: `<lista-ou-NA>`

# Rota de saida

```text
PROXIMO_PASSO: ERP_CLIENTE_03 | ERP_PARCEIRO_<NN> | NOVA_FERRAMENTA_<NN> | BLOQUEADA
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
