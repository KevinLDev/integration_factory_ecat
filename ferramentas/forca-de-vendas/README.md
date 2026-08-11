# Força de Vendas — Contrato canônico da Fábrica

## Identificação

- Nome: Força de Vendas
- Empresa responsável: E-Catálogos
- Slug: `forca-de-vendas`
- Versão publicada da API: `1.0.0`
- Especificação publicada: `OAS 3.0`
- Base URL publicada: `https://forca-de-vendas.api.e-catalogos.net`
- Ambiente: `NAO_DOCUMENTADO` — a fonte apresenta uma única base URL, sem classificá-la como produção ou homologação.

## Autenticação

- Obtenção do token: `POST /auth`, com `email`, `password` e `key` no request body.
- Retorno documentado: JWT em `resource.token`.
- Aplicação do JWT às demais operações: a interface mostra `Authorize`, mas nome/formato do header, prefixo, validade, renovação e escopos são `NAO_DOCUMENTADO` (`PEND-001`).
- Não assumir `Authorization: Bearer <token>` sem evidência oficial adicional.

## Cobertura do contrato

| Dimensão | Quantidade |
|---|---:|
| Módulos | 26 |
| Operações identificadas por ID estável (`OP-001` a `OP-090`) | 90 |
| Rotas únicas | 47 |
| Operações `ERP -> ferramenta` | 66 |
| Operações `ferramenta -> ERP` | 24 |
| Operações com request body documentado | 55 |
| Operações paginadas com `page` e `limit` | 21 |
| Component schemas | 27 |
| Campos marcados como obrigatórios nos components | 185 |
| Campos sem marcador de obrigatoriedade nos components | 61 |
| Pendências vigentes | 20 (`PEND-001` a `PEND-020`) |

Distribuição das 90 operações por método: 12 `DELETE`, 24 `GET`, 7 `PATCH`, 25 `POST` e 22 `PUT`.

O único domínio enumerado explicitamente por operação é `SHOWROOM | COORDINATOR` em `OP-087 GET /sellers`. O único upload explícito é `OP-028 POST /images`, `multipart/form-data`, com `images: array<string>` obrigatório; o mecanismo de associação ao produto permanece `NAO_DOCUMENTADO` em `PEND-016`.

## Situação do cadastro e limite de uso

Este diretório contém o contrato canônico reconstruído no Passo 02 a partir dos artefatos corrigidos e aprovados do Passo 01. O resultado da etapa e da auditoria vigente deve ser consultado em `parceiros/execucoes/ferramentas/forca-de-vendas/ESTADO-DA-EXECUCAO.md`; este README não antecipa o quality gate.

- Status do cadastro: controlado pelo quality gate do Passo 02. Durante a transição, `AGUARDANDO_AUDITORIA`; depois da auditoria, o valor vigente é exclusivamente `CONCLUIDA`, `PENDENTE` ou `BLOQUEADA` no estado da execução.

Cadastro no Passo 02 não equivale a homologação para integrações. Enquanto não houver uma futura execução aprovada do Passo 03 com todas as condições do gate, permanecem:

```text
PRONTIDAO GLOBAL: NAO_HOMOLOGADA
USO EM ERP PARCEIRO: BLOQUEADO
```

## Artefatos canônicos

- [Contrato estruturado](./CONTRATO-DA-FERRAMENTA.yaml) — identidade, API, 90 operações e dimensões técnicas por operação.
- [Módulos](./MODULOS.md) — visão humana consolidada dos 26 módulos.
- [Dependências](./DEPENDENCIAS.md) — relações documentadas e ordem parcial sustentada por evidência.
- [Bidirecionalidade](./BIDIRECIONALIDADE.md) — cobertura 66/24, correlação, limitações e rastreabilidade por módulo.
- [Pendências](./PENDENCIAS.md) — `PEND-001` a `PEND-020`, sem resolução inventada.
- [Fontes](./FONTES.md) — cadeia entre contrato, Passo 01 aprovado, execução, auditorias e fonte oficial.

## Baseline aprovada usada na reconstrução

- `analises/ferramentas/forca-de-vendas/01-analise-documentacao.md`
- `analises/ferramentas/forca-de-vendas/01-inventario-operacoes.md`
- `analises/ferramentas/forca-de-vendas/01-matriz-bidirecionalidade-modulos.md`
- `parceiros/execucoes/ferramentas/forca-de-vendas/DADOS-DA-EXECUCAO.md`
- `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-01-POS-CORRECOES-PASSO-03.md`
- fonte primária: `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.pdf`

Ausência documental é preservada como `NAO_DOCUMENTADO`; conflito na própria fonte permanece associado à pendência aplicável. Nenhuma equivalência entre identificadores, capacidade de direção, dependência ou regra operacional é inferida apenas por convenção.
