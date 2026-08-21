# DIAGNOSTICO-CORRECAO-RUNTIME — 2026-08-21

## Motivo

Após a correção documental registrada em `DIAGNOSTICO-CORRECAO-20260821.md` (que deixou 1 pendência
bloqueante: `GAP-003`/`PEND-BLING-FDV-006`, Filiais/unidades de negócio), o operador pediu para
verificar essa pendência agora, de fato, em runtime.

## O que foi feito

Chamada técnica controlada (Camada 2 do Passo 02/03: GET/refresh permitidos, nenhuma escrita
comercial), fora da jornada formal (mesmo padrão de transparência já usado no teste de autenticação
original — ver `analises/notas-tecnicas/2026-08-20-bling-conflito-processo-oficial.md`), na conta Bling
do **ERP parceiro** (não de cliente):

1. `POST /oauth/token` com `grant_type=refresh_token` — renovação de token.
2. `GET /empresas/me/dados-basicos` — confirmação de contexto (mesma empresa "eCatalogos").
3. `GET /depositos` — listagem de depósitos.
4. `GET /canais-venda` — listagem de canais de venda.
5. Para cada canal encontrado, `GET /canais-venda/{id}` — inspeção do array `filiais[]` (nenhum canal
   existia, então este passo não retornou dados).

Evidência bruta (sem segredos, tokens mascarados) persistida em:
`parceiros/execucoes/erps/bling/forca-de-vendas/evidencias/evidencia-filiais-depositos-canais-20260821.json`.

## Resultados

1. **Refresh token rotaciona.** `POST /oauth/token` (refresh) retornou HTTP 200, novo `access_token`
   (`expires_in=21600`) e um **novo `refresh_token`, diferente do anterior**. Resolve
   `PEND-BLING-FDV-012`. Implicação de design: a implementação real (Passo 06) deve persistir o
   `refresh_token` mais recente a cada renovação.
2. **A conta tem 1 depósito** ("Geral", `id: 14889154827`, `padrao: true`) e **0 canais de venda**
   configurados. Não há, hoje, nenhuma unidade de negócio/filial adicional para observar via
   `CanalVendaFilialDTO.filiais[]`. Resolve `PEND-BLING-FDV-006` como `NAO_APLICAVEL` **para esta
   homologação** — não como prova de que o Bling nunca suporta múltiplas filiais (a ausência é desta
   conta especificamente, não uma limitação estrutural comprovada da API).

## Artefatos corrigidos

| Artefato | Correção |
|---|---|
| `erps/bling/integracoes/forca-de-vendas/PENDENCIAS.md` | `PEND-BLING-FDV-006` e `PEND-BLING-FDV-012` marcadas RESOLVIDAS com evidência de runtime |
| `erps/bling/ANALISE-DO-ERP.md` | Seção 1 (Autenticação) atualizada com rotação de refresh confirmada; seção 2 (Ambientes) com o estado real da conta (1 depósito, 0 canais) |
| `erps/bling/integracoes/forca-de-vendas/PLANO-DE-HOMOLOGACAO.md` | `GAP-003` resolvido; `PENDENCIAS_BLOQUEANTES` 1→0; `PRONTO_PARA_CRIAR_BASE_REAL` NAO→SIM; desvio de baseline de Filiais atualizado |
| `erps/bling/integracoes/forca-de-vendas/BASE-COMERCIAL-PLANEJADA.yaml` | `GAP-003` marcado resolvido; motivo do desvio de Filiais atualizado |

## Ressalva para o futuro

Esta resolução é válida **apenas para esta conta de homologação do ERP parceiro**. Qualquer jornada
futura de ERP Cliente cujo Bling real tenha múltiplas unidades de negócio/filiais **deve reabrir e
reverificar** essa questão naquela conta específica — o mecanismo real (via `CanalVendaFilialDTO`) só
foi confirmado como *inexistente nesta conta*, não como *incapaz de existir em outras contas*.

## Gate após esta correção

```text
PENDENCIAS_BLOQUEANTES: 0
PRONTO_PARA_CRIAR_BASE_REAL: SIM
```
