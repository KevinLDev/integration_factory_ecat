# Modelo - Relatorio de resolucao de contexto do cliente

> Modelo global do ERP Cliente - Passo 01.

## Regras de uso

- resolver somente contexto e elegibilidade de reutilizacao;
- nao executar analise profunda de cliente;
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

# Gate de contexto

```text
CLIENTE_IDENTIFICADO: SIM | NAO | IDENTIDADE_AMBIGUA
ERP_IDENTIFICADO: SIM | NAO | IDENTIDADE_AMBIGUA
FERRAMENTA_IDENTIFICADA: SIM | NAO | IDENTIDADE_AMBIGUA
FERRAMENTA_HOMOLOGADA: SIM | NAO
COMBINACAO_ERP_FERRAMENTA_EXISTE: SIM | NAO
INTEGRACAO_PUBLICADA: SIM | NAO
DISPONIVEL_PARA_CLIENTE: SIM | NAO
RELEASE_ELEGIVEL: SIM | NAO | INDETERMINADA
CONTEXTO_CLIENTE: RESOLVIDO | NAO_RESOLVIDO
ELEGIVEL_PARA_JORNADA_CLIENTE: SIM | NAO
```

# Release resolvida

| Item | Valor |
|---|---|
| Versao | `<versao-ou-NA>` |
| Lifecycle | `ATIVA \| DEPRECATED \| RETIRADA \| INDETERMINADA` |
| Contrato de configuracao | `<ref>` |
| Manifesto de publicacao | `<ref>` |
| Vigencia mecanica | `VALIDA \| INVALIDA \| NAO_VERIFICAVEL` |

# Inventario de materiais

| Material | Status | Referencias |
|---|---|---|
| Swagger/OpenAPI | `RECEBIDO \| NAO_RECEBIDO \| NAO_APLICAVEL` | `<lista>` |
| Documentacao | `RECEBIDO \| NAO_RECEBIDO \| NAO_APLICAVEL` | `<lista>` |
| Regras de negocio | `RECEBIDO \| NAO_RECEBIDO \| NAO_APLICAVEL` | `<lista>` |
| Exemplos/payloads | `RECEBIDO \| NAO_RECEBIDO \| NAO_APLICAVEL` | `<lista>` |
| Customizacoes | `RECEBIDO \| NAO_RECEBIDO \| NAO_APLICAVEL` | `<lista>` |
| Credencial HML | `PRESENTE \| AUSENTE \| NAO_APLICAVEL` | `<lista>` |
| Outros | `RECEBIDO \| NAO_RECEBIDO \| NAO_APLICAVEL` | `<lista>` |

# Pendencias

## Bloqueantes

- `<pendencia-bloqueante-ou-NA>`

## Nao bloqueantes para Passo 02

- `<pendencia-nao-bloqueante-ou-NA>`

# Rota de saida

```text
PROXIMO_PASSO: ERP_CLIENTE_02 | ERP_PARCEIRO_<NN> | NOVA_FERRAMENTA_<NN> | BLOQUEADA
MOTIVO: <texto>
```

# Segurança

- segredo persistido: `NAO`;
- HML executada: `NAO`;
- producao executada: `NAO`.

# Status final

```text
STATUS_DA_ETAPA: CONCLUIDA | PENDENTE | BLOQUEADA
```