# Módulos canônicos da Força de Vendas

## Finalidade e regra de leitura

Este documento oferece a visão humana dos 26 módulos publicados pela API. A identidade e os detalhes técnicos de cada operação ficam em `CONTRATO-DA-FERRAMENTA.yaml`; direção, correlação e limitações ficam em `BIDIRECIONALIDADE.md`.

As capacidades abaixo derivam da finalidade textual de cada operação na fonte oficial e da baseline corrigida e aprovada do Passo 01. Um verbo HTTP isolado não prova direção, idempotência, confirmação no destino nem equivalência entre identificadores.

Convenções:

- `ERP -> ferramenta`: o ERP envia dado ou ação à API da ferramenta;
- `ferramenta -> ERP`: a API expõe dado que um ERP pode consultar;
- `CAPACIDADE_NAO_CONFIRMADA`: nenhuma operação publicada sustenta a direção; não significa prova de impossibilidade da API;
- `NAO_DOCUMENTADO`: a fonte não oferece evidência suficiente;
- cadastro canônico não equivale a homologação para uso em ERP parceiro.

## Cobertura consolidada

| # | Módulo | Operações | Total | ERP -> ferramenta | ferramenta -> ERP | Status documental |
|---:|---|---|---:|---:|---:|---|
| 1 | Autenticação | `OP-001` | 1 | 1 | 0 | `ESPECIFICO_DE_AUTENTICACAO` |
| 2 | Categorias | `OP-002`–`OP-004` | 3 | 2 | 1 | `BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO` |
| 3 | Campanhas | `OP-005`–`OP-006` | 2 | 2 | 0 | `UNIDIRECIONAL_CONFIRMADA_ERP_PARA_FERRAMENTA` |
| 4 | Clientes | `OP-007`–`OP-009` | 3 | 2 | 1 | `BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO` |
| 5 | Condições de pagamento | `OP-010`–`OP-013` | 4 | 3 | 1 | `BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO` |
| 6 | Cores | `OP-014`–`OP-017` | 4 | 3 | 1 | `BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO` |
| 7 | Companhias | `OP-018`–`OP-019` | 2 | 2 | 0 | `UNIDIRECIONAL_CONFIRMADA_ERP_PARA_FERRAMENTA_COM_ROTA_PENDENTE` |
| 8 | Filiais | `OP-020`–`OP-023` | 4 | 3 | 1 | `BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO` |
| 9 | Gêneros | `OP-024`–`OP-027` | 4 | 3 | 1 | `BIDIRECIONAL_PARCIAL_COM_ROTA_PENDENTE` |
| 10 | Imagens | `OP-028` | 1 | 1 | 0 | `UNIDIRECIONAL_CONFIRMADA_ERP_PARA_FERRAMENTA_COM_ASSOCIACAO_PENDENTE` |
| 11 | Linhas | `OP-029`–`OP-030` | 2 | 2 | 0 | `UNIDIRECIONAL_CONFIRMADA_ERP_PARA_FERRAMENTA` |
| 12 | Marcas | `OP-031`–`OP-033` | 3 | 2 | 1 | `BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO` |
| 13 | Métodos de pagamento | `OP-034`–`OP-037` | 4 | 3 | 1 | `BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO` |
| 14 | Pedidos | `OP-038`–`OP-042` | 5 | 3 | 2 | `BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONFIRMACAO` |
| 15 | Preços | `OP-043`–`OP-045` | 3 | 3 | 0 | `UNIDIRECIONAL_CONFIRMADA_ERP_PARA_FERRAMENTA` |
| 16 | Prepostos | `OP-046`–`OP-049` | 4 | 3 | 1 | `BIDIRECIONAL_PARCIAL_COM_ROTA_PENDENTE` |
| 17 | Produtos | `OP-050`–`OP-054` | 5 | 3 | 2 | `BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO` |
| 18 | Prazos de entregas | `OP-055`–`OP-058` | 4 | 3 | 1 | `BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO` |
| 19 | Regiões | `OP-059`–`OP-063` | 5 | 3 | 2 | `BIDIRECIONAL_PARCIAL_COM_ROTA_PENDENTE` |
| 20 | Representantes | `OP-064`–`OP-068` | 5 | 4 | 1 | `BIDIRECIONAL_PARCIAL_COM_ROTAS_PENDENTES` |
| 21 | Skus | `OP-069`–`OP-074` | 6 | 4 | 2 | `BIDIRECIONAL_PARCIAL_COM_ROTA_PENDENTE` |
| 22 | Subcategorias | `OP-075`–`OP-077` | 3 | 2 | 1 | `BIDIRECIONAL_PARCIAL_COM_ALVO_DE_ATUALIZACAO_PENDENTE` |
| 23 | Tabelas de preço | `OP-078`–`OP-080` | 3 | 2 | 1 | `BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO` |
| 24 | Transportadoras | `OP-081`–`OP-084` | 4 | 3 | 1 | `BIDIRECIONAL_PARCIAL_COM_ALVO_DE_ATUALIZACAO_PENDENTE` |
| 25 | Variantes | `OP-085`–`OP-086` | 2 | 1 | 1 | `BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO` |
| 26 | Vendedores | `OP-087`–`OP-090` | 4 | 3 | 1 | `BIDIRECIONAL_PARCIAL_COM_PONTE_DE_IDENTIFICACAO_PENDENTE` |
| **Total** | **26 módulos** | **`OP-001`–`OP-090`** | **90** | **66** | **24** | **Cobertura 90/90** |

As faixas acima são contínuas e mutuamente exclusivas. Sua união preserva as 90 identidades método + rota e as 47 rotas únicas da fonte.

## Capacidades principais e dependências por módulo

1. **Autenticação** — obtém JWT por `POST /auth`. A aplicação do token, o header, o prefixo, a validade, a renovação e os escopos são `NAO_DOCUMENTADO` (`PEND-001`).
2. **Categorias** — consulta, criação e atualização. `brandErpId` referencia Marca; não é promovido a chave primária da categoria.
3. **Campanhas** — criação/atualização conjunta e exclusão por `erpId`; não há leitura publicada que confirme ferramenta -> ERP.
4. **Clientes** — consulta, criação e atualização. `representativesErpIds` preserva a dependência Cliente -> Representante; `companyErpId`, `businessErpId` e `addressesErpId` são IDs relacionais quando publicados (`PEND-005`, `PEND-014`, `PEND-018`).
5. **Condições de pagamento** — consulta, criação, atualização e exclusão. `paymentMethodErpId` comprova a dependência em Método de pagamento. O transporte do identificador do alvo de `OP-012 PUT /payment-conditions` é `NAO_DOCUMENTADO` (`PEND-015`, `PEND-018`).
6. **Cores** — consulta, criação, atualização e vínculo a produto. `OP-017 PUT /colors/products/{productErpId}` exige produto e cores previamente identificáveis; `productErpId` e `colorErpId` não são equivalentes.
7. **Companhias** — criação e atualização; não há leitura publicada. Em `OP-019`, a fonte declara `erpId` de path, mas a rota não contém placeholder (`PEND-006`).
8. **Filiais** — consulta, criação, atualização e exclusão. `companyErpId` referencia Companhia quando publicado (`PEND-018` em `OP-022`).
9. **Gêneros** — consulta, criação, atualização e exclusão. `OP-026` preserva o conflito rota/path sem escolher uma URL (`PEND-006`, `PEND-018`).
10. **Imagens** — upload por `OP-028 POST /images`, `multipart/form-data`, com `images: array<string>` obrigatório. A fonte declara associação a Produto, mas não documenta como o produto é informado (`PEND-016`).
11. **Linhas** — criação/atualização conjunta e exclusão por `erpId`; não há leitura publicada que confirme ferramenta -> ERP.
12. **Marcas** — consulta, criação e atualização. O alvo de `OP-033` não é transportado de forma documentada; a descrição de sucesso também é conflitante (`PEND-012`, `PEND-013`, `PEND-015`, `PEND-018`).
13. **Métodos de pagamento** — consulta, criação, atualização e exclusão. É dependência explícita de Condições de pagamento por `paymentMethodErpId` (`PEND-018` em `OP-036`).
14. **Pedidos** — consultas de não integrados e integrados, ações de exportação/marcação e atualização de status/NFE. `number`, `orderNumber`, `orderErpId` e `erpId` não são normalizados como uma única chave; confirmação válida no ERP, atomicidade e reprocessamento são `NAO_DOCUMENTADO` (`PEND-005`, `PEND-010`, `PEND-019`).
15. **Preços** — criação, atualização e exclusão. Depende de `skuErpId` e `priceTableErpId`, além de `companyErpId` quando publicado; não há leitura publicada.
16. **Prepostos** — consulta, criação, atualização e exclusão. Em `OP-049`, a fonte declara `erpId` de path sem placeholder na rota (`PEND-006`, `PEND-018`).
17. **Produtos** — consulta, criação, atualização, busca por `erpId` e alteração de visibilidade. Referencia entidades de catálogo apenas conforme os campos de cada operação; `productSubcategoryErpId`/`subcategoryErpId` e os campos de visibilidade permanecem conflitantes (`PEND-005`, `PEND-011`, `PEND-014`).
18. **Prazos de entregas** — consulta, criação, atualização e exclusão; `companyErpId` é relacional quando publicado (`PEND-018` em `OP-057`).
19. **Regiões** — consulta, criação, atualização, busca e exclusão. A relação Região -> Tabela de preço é explícita, mas request e response usam `priceTablesErpId` e `priceTableErpId`; ambas as grafias são preservadas. `OP-061` também mantém o conflito rota/path (`PEND-005`, `PEND-006`).
20. **Representantes** — consulta, criação, atualização, exclusão e vínculo com clientes. `representativeErpId` e `clientErpId` são as pontas do vínculo; `OP-066`/`OP-067` mantêm conflitos rota/path (`PEND-006`, `PEND-018`).
21. **Skus** — consulta, criação, atualização, busca, estoque e grade. `variantErpId` referencia Variante. `OP-071` mantém conflito rota/path; `OP-074` usa `reference` e elementos de grade, sem `erpId` ou `skuErpId` documentado no bloco (`PEND-006`, `PEND-018`).
22. **Subcategorias** — consulta, criação e atualização. `categoryErpId` referencia Categoria, mas o identificador do alvo de `OP-077` é `NAO_DOCUMENTADO` (`PEND-013`, `PEND-015`, `PEND-018`).
23. **Tabelas de preço** — consulta, criação e atualização. `companyErpId` é relacional quando publicado; referências de Região preservam a ambiguidade singular/plural (`PEND-005`, `PEND-018`).
24. **Transportadoras** — consulta, criação, atualização e exclusão. O alvo de `OP-083` não é transportado de forma documentada (`PEND-015`, `PEND-018`).
25. **Variantes** — consulta e criação. `productErpId` referencia Produto; `companyErpId` permanece relacional quando publicado.
26. **Vendedores** — consulta, criação, atualização e vínculo com clientes. `OP-087` explicita `SHOWROOM | COORDINATOR`; criação usa `code`, atualização usa `erpId` e vínculo usa `sellerErpId`, sem ponte documentada (`PEND-017`, `PEND-018`, `PEND-020`).

## Aplicação das 20 pendências

| Escopo | Pendências |
|---|---|
| Autenticação | `PEND-001` |
| Resiliência transversal | `PEND-002`, `PEND-009` |
| Operações mutáveis | `PEND-003` |
| Módulos com leitura e escrita | `PEND-004`, `PEND-008` |
| Nomenclaturas e grafias conflitantes | `PEND-005`, `PEND-014` |
| Rotas com path declarado sem placeholder | `PEND-006` — `OP-019`, `OP-026`, `OP-049`, `OP-061`, `OP-066`, `OP-067`, `OP-071` |
| Limitação da fonte fornecida | `PEND-007` |
| Status HTTP e mensagens conflitantes | `PEND-010` |
| Visibilidade de Produto | `PEND-011` |
| Semântica de sucesso de `PUT /brands` | `PEND-012` |
| Sucesso incompleto de `POST /brands` e `POST /subcategories` | `PEND-013` |
| Atualizações sem transporte documentado do alvo | `PEND-015` — `OP-012`, `OP-033`, `OP-077`, `OP-083` |
| Associação de imagem a Produto | `PEND-016` |
| Ponte `code`/`erpId`/`sellerErpId` | `PEND-017` |
| Component required sem vínculo normativo ao body e conflitos schema/exemplo | `PEND-018` — `OP-008`, `OP-009`, `OP-012`, `OP-022`, `OP-026`, `OP-032`, `OP-033`, `OP-036`, `OP-047`, `OP-048`, `OP-057`, `OP-066`, `OP-071`, `OP-077`, `OP-080`, `OP-083`, `OP-088`, `OP-089` |
| Respostas sem semântica em `OP-041` | `PEND-019` |
| Valores categóricos de exemplo não tratados como enum | `PEND-020` |

## Rastreabilidade

- fonte primária: `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.pdf`;
- análise aprovada: `analises/ferramentas/forca-de-vendas/01-analise-documentacao.md`;
- inventário técnico por operação: `analises/ferramentas/forca-de-vendas/01-inventario-operacoes.md`;
- matriz aprovada: `analises/ferramentas/forca-de-vendas/01-matriz-bidirecionalidade-modulos.md`;
- auditoria vigente do Passo 01: `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-01-POS-CORRECOES-PASSO-03.md`.

Nenhum status acima homologa integração. As lacunas de autenticação, idempotência, loop, conflito, reprocessamento e confirmação no destino continuam explícitas até evidência oficial ou decisão futura autorizada.
