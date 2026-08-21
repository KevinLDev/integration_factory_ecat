# Relatório de materialização da Base de homologação — Bling x Força de Vendas

## Identificação

- ERP: Bling
- ERP_SLUG: bling
- FERRAMENTA: Força de Vendas
- FERRAMENTA_SLUG: forca-de-vendas
- COMBINACAO: bling x forca-de-vendas
- ETAPA_ORIGEM: ERP_PARCEIRO_PASSO_04
- DATA_INICIO: 2026-08-21 (revalidação de vigência do plano)
- DATA_FIM: 2026-08-21 (fim desta rodada parcial; execução continua em rodada futura)

## Ambiente

- AMBIENTE_TIPO: DEV_AUTORIZADO
- AMBIENTE_AUTORIZADO: SIM
- VALIDACAO_DE_AMBIENTE: Bling não publica base URL de sandbox separada nesta especificação (só
  produção e "ambiente de teste da documentação"). A conta usada (eCatalogos, app_id 386879, aprovado
  no painel do Bling) foi explicitamente designada pelo operador como ambiente de DEV autorizado para
  esta fábrica, mesmo batendo na API de produção do Bling.
- AUTORIZADO_MATERIALIZAR_BASE: SIM (autorização explícita do operador no chat)

## Plano de origem

- PLANO_DE_HOMOLOGACAO: `erps/bling/integracoes/forca-de-vendas/PLANO-DE-HOMOLOGACAO.md`
- BASE_COMERCIAL_PLANEJADA: `erps/bling/integracoes/forca-de-vendas/BASE-COMERCIAL-PLANEJADA.yaml`
- HASH_DO_PLANO: `19BFCBB09335B6CE1B8378A076D64D2AFEED4F6DB5B11F18A2A2E81C4A5C8EB3` (revalidado antes da
  primeira escrita — a tabela de snapshot do plano estava desatualizada; corrigida sem reprojetar nada)
- VERSAO_DO_PLANO: revalidação mínima de 2026-08-21

## Resumo executivo

```text
STATUS_DA_ETAPA: PENDENTE
MATERIALIZACAO: PARCIAL_JUSTIFICADA
RECONSULTA: APROVADA
CORRELACOES: VALIDAS
COBERTURA_CRIADA_NO_ERP: PARCIAL_JUSTIFICADA
FALHAS_BLOQUEANTES: 0
```

`STATUS_DA_ETAPA: PENDENTE` (não `CONCLUIDA`) porque `MATERIALIZACAO: PARCIAL_JUSTIFICADA` — a etapa
ainda não cobriu produtos, clientes, vendedores reais e pedidos (ver `P04-002`), e `P04-001` (vendedor
real) depende de ação manual do operador. Isto não decorre de exigência de auditoria independente: a
regra de "nenhuma das três se autoaprova" (`AGENTS.md` Seção 3) é escopada aos Passos 04-06 da jornada
ERP CLIENTE e aos Passos 08-09 da jornada ERP PARCEIRO — o Passo 04 do ERP PARCEIRO (esta etapa) admite
autoauditoria `NORMAL` divulgada, no mesmo padrão já usado nos Passos 01-03 desta execução.

## Base Mestra anterior

- BASE_MESTRA_EXISTENTE: NÃO (esta é a primeira materialização real do Bling na fábrica)
- CAMINHO_BASE_MESTRA: `erps/bling/homologacao/BASE-MESTRA-MATERIALIZADA.yaml`
- RESUMO_ESTADO_ANTERIOR: N/A

## Reutilizações

Nenhuma — base mestra criada do zero nesta execução.

## Materializações (tudo `CRIADO`, com reconsulta `ESCRITA_CONFIRMADA`)

| ENTIDADE | ID_LOGICO | ERP_ID | RESULTADO |
|---|---|---:|---|
| Campo customizado | HML-CC-MARCA | 11015553 | `POST` 201 → `GET /campos-customizados/11015553` 200, 10 opções confirmadas |
| Campo customizado | HML-CC-COR | 11015554 | Confirmado via `GET /campos-customizados/modulos/98309` |
| Campo customizado | HML-CC-GENERO | 11015555 | Confirmado via `GET /campos-customizados/modulos/98309` |
| Campo customizado | HML-CC-CAMPANHA | 11015556 | Confirmado via `GET /campos-customizados/modulos/98309` |
| Campo customizado | HML-CC-LINHA | 11015557 | Confirmado via `GET /campos-customizados/modulos/98309` |
| Campo customizado | HML-CC-TIPO | 11015558 | Confirmado via `GET /campos-customizados/modulos/98309` |
| Campo customizado | HML-CC-DISPONIBILIDADE | 11015559 | Confirmado via `GET /campos-customizados/modulos/98309` |
| Campo customizado | HML-CC-PRAZO-DIAS | 11015560 | Confirmado via `GET /campos-customizados/modulos/98309` |
| Campo customizado | HML-CC-ORIGEM | 11015561 | Confirmado via `GET /campos-customizados/modulos/98309` |
| Campo customizado | HML-CC-TABELA-A | 11015562 | Confirmado via `GET /campos-customizados/modulos/98309` |
| Campo customizado | HML-CC-TABELA-B | 11015563 | Confirmado via `GET /campos-customizados/modulos/98309` |
| Campo customizado | HML-CC-TABELA-C | 11015564 | Confirmado via `GET /campos-customizados/modulos/98309` |
| Campo customizado | HML-CC-PAPEL-VENDEDOR | 11015565 | Confirmado via `GET /campos-customizados/modulos/98308` |
| Campo customizado | HML-CC-REGIAO-CLIENTE | 11015566 | Confirmado via `GET /campos-customizados/modulos/98308` |
| Categoria (10) | HML-CAT-001 a 010 | 14311473, 14311477, 14311481, 14311485, 14311489, 14311493, 14311496, 14311499, 14311502, 14311505 | Todas `POST /categorias/produtos` 201 |
| Subcategoria (25) | HML-SUBCAT-001 a 025 | ver `BASE-MESTRA-MATERIALIZADA.yaml` | Todas `POST /categorias/produtos` com `categoriaPai` 201 |

**Total materializado nesta rodada: 14 campos customizados + 10 categorias + 25 subcategorias = 49
registros reais, 100% confirmados por reconsulta.**

## Correlações

Ver `erps/bling/homologacao/BASE-MESTRA-MATERIALIZADA.yaml`, seção `correlacoes` — todas `VALIDAS`.
Evidência bruta persistida em:

- `parceiros/execucoes/erps/bling/forca-de-vendas/evidencias/passo04-log-campos-customizados-20260821.json`
- `parceiros/execucoes/erps/bling/forca-de-vendas/evidencias/passo04-log-categorias-20260821.json`

## Verificações

| ENTIDADE | ID_LOGICO | CAMPOS_COMPARADOS | RESULTADO |
|---|---|---|---|
| Campo customizado | HML-CC-MARCA | `nome`, `opcoes[]` (10), `modulo.id`, `tipoCampo.id` | OK — reconsulta via `GET /campos-customizados/11015553` bateu exatamente com o planejado |
| Categorias/Subcategorias | HML-CAT-*/HML-SUBCAT-* | contagem (10 + 25) | OK — contagem final do log bate com o baseline do plano |

## Achado experimental importante: Vendedores não são criáveis via API

Testei a hipótese de que criar um `Contato` com `tiposContato: [Vendedor]` faria esse contato aparecer
em `GET /vendedores`. Criei `HML Vendedor 001` (`POST /contatos` → 201, `erp_id` 18342118651) e
reconsultei `GET /vendedores` — **lista vazia**. Conclusão: `Vendedores` no Bling não é derivado
automaticamente de `Contatos`; exige um mecanismo de cadastro que não está exposto nesta API (muito
provavelmente vínculo com usuário/login do painel). Isso **confirma com evidência real**
`PEND-BLING-FDV-008`, que antes era uma inferência a partir da ausência de `POST`/`PUT` no recurso
`Vendedores`. Evidência:
`parceiros/execucoes/erps/bling/forca-de-vendas/evidencias/passo04-evidencia-teste-vendedor-20260821.json`.

## Falhas

Nenhuma. 0 falhas bloqueantes nesta rodada.

## Divergências

Nenhuma divergência entre planejado e observado nas 49 entidades materializadas.

## Pendências

| ID | DESCRICAO | IMPACTO | STATUS |
|---|---|---|---|
| P04-001 | Vendedores/Representantes/Prepostos reais não podem ser criados via API (confirmado empiricamente) | Bloqueia `REL-006` (vínculo cliente-vendedor) até cadastro manual no painel do Bling pelo operador — este agente não tem ferramenta de automação de navegador | ABERTO |
| P04-002 | Produtos (200), variações/SKUs, clientes (20), preços, estoques e pedidos (100) ainda não materializados | `MATERIALIZACAO: PARCIAL_JUSTIFICADA`; continuação prevista em execução futura do Passo 04 | ABERTO |

## Cobertura criada no ERP

| CENARIO | STATUS | EVIDENCIA |
|---|---|---|
| Camada de complemento (campos customizados) disponível para todos os gaps identificados no Passo 02/03 | COBERTURA_CRIADA_NO_ERP | 14 campos customizados confirmados |
| Estrutura de categorização (Categoria → Subcategoria) | COBERTURA_CRIADA_NO_ERP | 10 categorias + 25 subcategorias confirmadas |
| CEN-001 a CEN-012 (cenários de produto/pedido) | PENDENTE — depende de produtos/clientes ainda não materializados | — |

## Itens ainda não materializados

| ENTIDADE | ID_LOGICO | MOTIVO | BLOQUEIA_PROXIMA_ETAPA |
|---|---|---|---|
| Produtos (200) | HML-PROD-001..200 | Não iniciado nesta rodada — escopo grande, requer execução dedicada | NÃO (Passo 05 pode ser projetado com o que já existe; materialização completa é recomendada antes do Passo 06) |
| Variações/SKUs | HML-SKU-* | Depende de produtos | NÃO |
| Clientes (20) | HML-CLI-001..020 | Não iniciado nesta rodada | NÃO |
| Vendedores reais (10) | HML-VEND-001..010 | Bloqueado — exige painel do Bling (ação humana) | SIM, para cenários que dependem de representante/preposto |
| Preços/Estoques/Pedidos | — | Dependem de produtos e clientes | NÃO |

## Gate final da etapa

```text
AMBIENTE_AUTORIZADO: SIM
PLANO_VALIDO: SIM
BASE_MESTRA: CRIADA
MATERIALIZACAO: PARCIAL_JUSTIFICADA
RECONSULTA: APROVADA
CORRELACOES: VALIDAS
DEPENDENCIAS: VALIDAS
COBERTURA_CRIADA_NO_ERP: PARCIAL_JUSTIFICADA
FALHAS_BLOQUEANTES: 0
PRONTO_PARA_VALIDACAO_NA_FERRAMENTA: NAO
```

`PRONTO_PARA_VALIDACAO_NA_FERRAMENTA: NAO` porque não há produtos/clientes/pedidos reais ainda para
validar na Força de Vendas — só a camada de complemento e a categorização.

## Critérios para próxima etapa

1. Continuar a materialização (produtos, variações, clientes, preços, estoques, pedidos) em execução
   futura do Passo 04, reaproveitando os 14 campos customizados e as 35 categorias/subcategorias já
   confirmados (idempotência: não recriar).
2. Resolver `P04-001` (cadastro manual de vendedores no painel do Bling pelo operador) antes de
   materializar clientes com vínculo de representante/preposto.
3. Este relatório recebeu autoauditoria `NORMAL` (divulgada como não independente, mesmo padrão dos
   Passos 01-03) aprovando o que foi de fato executado; `STATUS_DA_ETAPA` só poderá virar `CONCLUIDA`
   quando `MATERIALIZACAO` chegar a `COMPLETA` (ou a uma cobertura mínima suficiente, a critério do
   operador) — não é bloqueio de auditoria independente. Não iniciar Passo 05 automaticamente.

## Segurança

- Segredos não reproduzidos neste relatório nem em `BASE-MESTRA-MATERIALIZADA.yaml`.
- Segredos não persistidos em artefatos versionados (tokens ficam apenas em
  `.tmp/bling-auth-test/tokens.local.json`, fora do controle de versão).
- Nenhum token/key/senha aparece nos logs de evidência persistidos.
