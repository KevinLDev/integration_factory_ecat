# 01A - Inventário técnico por operação (Força de Vendas)

Fonte primária obrigatória: `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.pdf`
Extração usada como índice mecânico e rastreabilidade: `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.extraido.txt` (UTF-8).

Este inventário foi reaberto e corrigido após o Passo 03 detectar falhas semânticas na execução histórica do Passo 01. A auditoria anterior permanece preservada como evidência histórica, mas não valida este conteúdo corrigido. Cada operação abaixo foi novamente confrontada com o próprio bloco da fonte; não foram usadas regras genéricas por verbo HTTP.

## Convenções de leitura

- `*` significa somente obrigatoriedade explicitamente marcada na fonte.
- Required de componente e required de operação são camadas separadas. O PDF não expõe de forma inequívoca o `$ref` de cada body; campos do componente não foram promovidos automaticamente a obrigatórios no request (`PEND-018`).
- Valores vistos apenas em exemplos não foram promovidos a enums. O único enum textual explícito por operação é `SHOWROOM | COORDINATOR` em `GET /sellers` (`PEND-020`).
- Para `OP-002` a `OP-090`, a documentação geral confirma obtenção de JWT por `POST /auth`, mas `Bearer`, nome/formato do header, expiração, renovação e escopos permanecem `NAO_DOCUMENTADO` (`PEND-001`).
- `Media type`, `Controls Accept header`, `Try it out`, cabeçalhos de página e outros elementos da interface não são tratados como contrato.
- A seção de identificação/correlação separa os locais onde cada nome aparece. Presença de `erpId`, `code`, `id`, `number` ou outro identificador não prova equivalência entre eles.
- `PEND-002`, `PEND-003`, `PEND-004`, `PEND-008` e `PEND-009` são lacunas transversais de resiliência e sincronização; aplicam-se quando a futura operação exigir rate limit/retry, idempotência, prevenção de loop, conflito ou reprocessamento.

## Catálogo de componentes/schemas da fonte

A fonte lista 27 componentes no bloco final. Foram preservados **185 marcadores `*`**. Os campos sem `*` são apresentados como opcionais no componente, sem projetar essa classificação automaticamente sobre um request de operação.

| Schema | Required no componente (`*`) | Sem `*` no componente |
|---|---|---|
| `Representatives` | name, cpf, email, cellPhone, erpId, companyErpId, address | rg, type, birthDate, phone |
| `Agents` | name, erpId, cpf, email, cellPhone, street, number, complement, neighborhood, city, uf, zipCode, companyErpId, representativesErpId, password | rg, birthDate, phone |
| `Campaign` | erpId, description | nenhum |
| `Line` | erpId, description | nenhum |
| `Client` | name, cpf, email, cellphone, erpId, isShopkeeper, companyErpId, haveCredit, addresses | phone, rg, concept, blocktype, expeditionBlock, invoiceBlock, orderBlock, creditLimit, groupCod, businessErpId, clientGroup, analist |
| `Companies` | key, deadlineType, tools, business | erpId, apiKey, logoImg, defaultCarriers |
| `Brands` | erpId, name, minValue, minInstallmentsValue, addressErpId, businessErpId, addresses | logoImg, visible, skuOrder |
| `Carriers` | name, cnpj, phone, companyErpId, email | erpId |
| `Categories` | erpId, name, brandErpId | nenhum |
| `PaymentConditions` | erpId, term, installments, priceAdjustment, minimumValue, paymentMethodErpId, companyErpId | nenhum |
| `Colors` | erpId, name, rgb, hexCode | companyErpId |
| `Branches` | name, companyErpId, business | erpId |
| `Gender` | erpId, name, companyErpId | nenhum |
| `PaymentMethods` | description, minValue, priceAdjustment, companyErpId | erpId |
| `Orders` | ped_data_pagamento, ped_data_entrega, ped_descricao_entrega, ped_modo_entrega, ped_forma_pagamento, ped_data_pedido, ped_numero_pedido, ped_ordem_compra, ped_observacao, ped_nome_comprador, ped_email_enviado, ped_visualizar, orcamento, ped_ipi, ped_st, ped_tabela_precos, ped_email_xml, ped_transp_nome, ped_transp_tel, ped_transp_email, ped_enviar_emails, ped_fotos_produtos, ped_aprovado, ped_data_aprovado, ped_motivo_reprovar, ped_transp_id, ped_telefone_cliente, ped_tipo_frete, ped_tipo_venda, ped_numero_externo, ped_representante_ausente, ped_status, uuid, user_jwt, platform, fk_vendedores, fk_vendedores_aux, created_at, pedido_cliente, verificacao, fk_prepostos, ped_b2c_exportado, crp_desconto_especial, integrated, ped_conceito, tabela_precos, marca, cliente, representante, prazo, transportadora, carrinho_pedido | nenhum |
| `Deadlines` | erpId, name, initial, final, type, companyErpId | nenhum |
| `Sellers` | name, cpf, type, companyErpId, password | erpId, cellphone, email, code |
| `Prices` | erpId, price, skuErpId, priceTableErpId, skuCode, companyErpId | nenhum |
| `Product` | erpId, name, reference, branchErpId, promptDelivery, brandErpId, openGrid, ipi, isDiscontinued, isLaunch, genderErpId, categoryErpId, productColors | description, deadlineErpId, compositionData, technicalInformation, isVisibleB2B, isVisibleForca, colection, st, subcategoryErpId |
| `Sku` | size, stockB2B, stockForca, price, code, multipleQuantity, erpId, variantErpId, companyErpId | minQuantity, cest, height, length, ncm, weight, width |
| `Subcategories` | erpId, name, categoryErpId | companyErpId |
| `PriceTables` | erpId, description, visible, companyErpId | priceAdjustment, minimumValue |
| `Variants` | erpId, name, productErpId, companyErpId | hexCode |
| `VinculateSellersClients` | sellerErpId, clientErpId, companyErpId | nenhum |
| `VinculatedResponse` | sellerErpId, clientErpId | nenhum |
| `Regions` | nenhum | erpId, name, color, statesCodes, cityNames, companyErpId, priceTablesErpId |
| `ProductsVisibility` | productErpId, isVisibleB2B, isVisibleForca | nenhum |

Rastreabilidade do catálogo: PDF oficial, páginas 84-87; extração vinculada, linhas 5044-5818. A fonte resume tipos como `[...]` e não fornece o OpenAPI bruto (`PEND-007`).

## Contagem validada contra a fonte oficial

- Módulos: **26**
- Operações únicas (método + rota): **90**
- Rotas únicas: **47**
- Operações paginadas com `page` e `limit`: **21**
- Schemas/componentes: **27**
- Marcadores required no catálogo de componentes: **185**

## Autenticação

### OP-001 - `POST /auth`
- módulo: Autenticação
- método HTTP: POST
- rota: `/auth`
- finalidade/descrição oficial: Efetuar login Realiza autenticação do usuário e retorna o token JWT.
- autenticação: endpoint de obtenção de JWT; sem token prévio
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `email`, `password`, `key`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: sem componente final inequivocamente relacionado. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: sem componente final inequivocamente relacionado.
- response body de sucesso: `200` Login realizado com sucesso.; campos do exemplo: `status`, `message`, `resource`, `token`
- códigos HTTP documentados: `200` Login realizado com sucesso. | `400` Erro ao tentar realizar login. | `500` Erro no servidor
- principais respostas de erro: `400` Erro ao tentar realizar login.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline de request e response; componente final específico de autenticação: NAO_DOCUMENTADO
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `email`, `password`, `key`; respostas: `200` presente (objeto), campos: `status`, `message`, `resource`, `token`; `400` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência. O valor do JWT não é reproduzido.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: NAO_DOCUMENTADO
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, página 3; extração vinculada, linhas 23-81; módulo Autenticação; operação `POST /auth`.


## Categorias

### OP-002 - `GET /categories`
- módulo: Categorias
- método HTTP: GET
- rota: `/categories`
- finalidade/descrição oficial: Listar categorias com filtro por nome e paginação
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, sem `*`); `limit` (integer, sem `*`); `name` (string, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Categories`: erpId, name, brandErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query), `name` (query); no catálogo de componentes: `Categories`: nenhum campo sem `*`.
- response body de sucesso: `200` Lista paginada de categorias; campos do exemplo: `data`, `erpId`, `name`, `brandErpId`, `total`, `page`, `limit`
- códigos HTTP documentados: `200` Lista paginada de categorias | `404` Categorias não encontradas. | `500` Erro no servidor
- principais respostas de erro: `404` Categorias não encontradas.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Categories`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (objeto), campos: `data`, `erpId`, `name`, `brandErpId`, `total`, `page`, `limit`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, sem `*`) e limit (integer, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: response 2xx: `erpId`, `brandErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, página 4; extração vinculada, linhas 89-144; módulo Categorias; operação `GET /categories`.

### OP-003 - `POST /categories`
- módulo: Categorias
- método HTTP: POST
- rota: `/categories`
- finalidade/descrição oficial: Criar uma categoria
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `brandErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Categories`: erpId, name, brandErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Categories`: nenhum campo sem `*`.
- response body de sucesso: `201` Categoria criada com sucesso.; campos do exemplo: `erpId`, `name`, `brandErpId`
- códigos HTTP documentados: `201` Categoria criada com sucesso. | `400` Corpo da requisição vazio ou inválido. | `409` Categoria já existente. | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição vazio ou inválido.; campos do exemplo: `message` | `409` Categoria já existente.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Categories`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `brandErpId`; respostas: `201` presente (objeto), campos: `erpId`, `name`, `brandErpId`; `400` presente (objeto), campos: `message`; `409` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `brandErpId`; response 2xx: `erpId`, `brandErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 4-5; extração vinculada, linhas 146-218; módulo Categorias; operação `POST /categories`.

### OP-004 - `PUT /categories`
- módulo: Categorias
- método HTTP: PUT
- rota: `/categories`
- finalidade/descrição oficial: Atualizar categoria
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `brandErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Categories`: erpId, name, brandErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Categories`: nenhum campo sem `*`.
- response body de sucesso: `200` Categoria atualizada com sucesso!; campos do exemplo: `erpId`, `name`, `brandErpId`
- códigos HTTP documentados: `200` Categoria atualizada com sucesso! | `404` Categoria não encontrada. | `500` Erro no servidor
- principais respostas de erro: `404` Categoria não encontrada.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Categories`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `brandErpId`; respostas: `200` presente (objeto), campos: `erpId`, `name`, `brandErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `brandErpId`; response 2xx: `erpId`, `brandErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 5-6; extração vinculada, linhas 220-271; módulo Categorias; operação `PUT /categories`.


## Campanhas

### OP-005 - `POST /campaigns`
- módulo: Campanhas
- método HTTP: POST
- rota: `/campaigns`
- finalidade/descrição oficial: Criar ou atualizar uma campanha
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `description`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Campaign`: erpId, description. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Campaign`: nenhum campo sem `*`.
- response body de sucesso: `201` Campanha criada ou atualizada com sucesso; campos do exemplo: `id`, `erpId`, `description`
- códigos HTTP documentados: `201` Campanha criada ou atualizada com sucesso | `400` Corpo da requisição inválido | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição inválido; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Campaign`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `description`; respostas: `201` presente (objeto), campos: `id`, `erpId`, `description`; `400` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`; response 2xx: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 6-7; extração vinculada, linhas 275-335; módulo Campanhas; operação `POST /campaigns`.

### OP-006 - `DELETE /campaigns`
- módulo: Campanhas
- método HTTP: DELETE
- rota: `/campaigns`
- finalidade/descrição oficial: Remover campanha por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Campaign`: erpId, description. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Campaign`: nenhum campo sem `*`.
- response body de sucesso: `200` Campanha removida com sucesso; campos do exemplo: `id`, `erpId`, `description`
- códigos HTTP documentados: `200` Campanha removida com sucesso | `404` Campanha não encontrada | `500` Erro no servidor
- principais respostas de erro: `404` Campanha não encontrada; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Campaign`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`; respostas: `200` presente (objeto), campos: `id`, `erpId`, `description`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`; response 2xx: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, página 7; extração vinculada, linhas 337-399; módulo Campanhas; operação `DELETE /campaigns`.


## Clientes

### OP-007 - `GET /clients`
- módulo: Clientes
- método HTTP: GET
- rota: `/clients`
- finalidade/descrição oficial: Buscar clientes com filtros e paginação
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, sem `*`); `limit` (integer, sem `*`); `name` (string, sem `*`); `cnpj` (string, sem `*`); `email` (string, sem `*`); `cellphone` (string, sem `*`); `haveCredit` (boolean, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Client`: name, cpf, email, cellphone, erpId, isShopkeeper, companyErpId, haveCredit, addresses. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query), `name` (query), `cnpj` (query), `email` (query), `cellphone` (query), `haveCredit` (query); no catálogo de componentes: `Client`: phone, rg, concept, blocktype, expeditionBlock, invoiceBlock, orderBlock, creditLimit, groupCod, businessErpId, clientGroup, analist.
- response body de sucesso: `200` Lista paginada de clientes; campos do exemplo: `data`, `erpId`, `name`, `cnpj`, `email`, `cellphone`, `haveCredit`, `companyErpId`, `total`, `page`, `limit`
- códigos HTTP documentados: `200` Lista paginada de clientes | `404` Cliente não encontrado. | `500` Erro no servidor
- principais respostas de erro: `404` Cliente não encontrado.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Client`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (objeto), campos: `data`, `erpId`, `name`, `cnpj`, `email`, `cellphone`, `haveCredit`, `companyErpId`, `total`, `page`, `limit`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, sem `*`) e limit (integer, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-005, PEND-014
- rastreabilidade da fonte: PDF oficial, páginas 7-8; extração vinculada, linhas 403-455; módulo Clientes; operação `GET /clients`.

### OP-008 - `POST /clients`
- módulo: Clientes
- método HTTP: POST
- rota: `/clients`
- finalidade/descrição oficial: Cria um novo cliente
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `cnpj`, `rg`, `email`, `phone`, `cellphone`, `isShopkeeper`, `concept`, `blocktype`, `expeditionBlock`, `invoiceBlock`, `orderBlock`, `creditLimit`, `groupCod`, `companyErpId`, `businessErpId`, `haveCredit`, `clientGroup`, `analist`, `addresses`, `addressesErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`, `representativesErpIds`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Client`: name, cpf, email, cellphone, erpId, isShopkeeper, companyErpId, haveCredit, addresses. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Client`: phone, rg, concept, blocktype, expeditionBlock, invoiceBlock, orderBlock, creditLimit, groupCod, businessErpId, clientGroup, analist.
- response body de sucesso: `201` Sucesso ao criar novo cliente; campos do exemplo: `client`, `erpId`, `name`, `cnpj`, `rg`, `email`, `phone`, `cellPhone`, `addresses`, `street`, `number`, `neighborhood`, `zipCode`, `city`, `uf`, `representativesErpIds`
- códigos HTTP documentados: `201` Sucesso ao criar novo cliente | `400` Erro ao criar novo cliente
- principais respostas de erro: `400` Erro ao criar novo cliente; body/exemplo: NAO_DOCUMENTADO
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Client`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `cnpj`, `rg`, `email`, `phone`, `cellphone`, `isShopkeeper`, `concept`, `blocktype`, `expeditionBlock`, `invoiceBlock`, `orderBlock`, `creditLimit`, `groupCod`, `companyErpId`, `businessErpId`, `haveCredit`, `clientGroup`, `analist`, `addresses`, `addressesErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`, `representativesErpIds`; respostas: `201` presente (objeto), campos: `client`, `erpId`, `name`, `cnpj`, `rg`, `email`, `phone`, `cellPhone`, `addresses`, `street`, `number`, `neighborhood`, `zipCode`, `city`, `uf`, `representativesErpIds`; `400` ausente. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `companyErpId`, `businessErpId`, `addressesErpId`; response 2xx: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-005, PEND-014, PEND-018
- rastreabilidade da fonte: PDF oficial, página 9; extração vinculada, linhas 461-500; módulo Clientes; operação `POST /clients`.

### OP-009 - `PUT /clients`
- módulo: Clientes
- método HTTP: PUT
- rota: `/clients`
- finalidade/descrição oficial: Atualiza o Cliente pelo erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `cnpj`, `rg`, `email`, `phone`, `cellphone`, `isShopkeeper`, `concept`, `blocktype`, `expeditionBlock`, `invoiceBlock`, `orderBlock`, `creditLimit`, `groupCod`, `companyErpId`, `businessErpId`, `haveCredit`, `clientGroup`, `analist`, `addresses`, `addressesErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Client`: name, cpf, email, cellphone, erpId, isShopkeeper, companyErpId, haveCredit, addresses. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Client`: phone, rg, concept, blocktype, expeditionBlock, invoiceBlock, orderBlock, creditLimit, groupCod, businessErpId, clientGroup, analist.
- response body de sucesso: `200` Sucesso ao Atualizar cliente; body/exemplo: NAO_DOCUMENTADO
- códigos HTTP documentados: `200` Sucesso ao Atualizar cliente | `500` Erro no servidor
- principais respostas de erro: `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Client`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `cnpj`, `rg`, `email`, `phone`, `cellphone`, `isShopkeeper`, `concept`, `blocktype`, `expeditionBlock`, `invoiceBlock`, `orderBlock`, `creditLimit`, `groupCod`, `companyErpId`, `businessErpId`, `haveCredit`, `clientGroup`, `analist`, `addresses`, `addressesErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`; respostas: `200` ausente; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `companyErpId`, `businessErpId`, `addressesErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-005, PEND-014, PEND-018
- rastreabilidade da fonte: PDF oficial, página 10; extração vinculada, linhas 508-540; módulo Clientes; operação `PUT /clients`.


## Condições de pagamento

### OP-010 - `GET /payment-conditions`
- módulo: Condições de pagamento
- método HTTP: GET
- rota: `/payment-conditions`
- finalidade/descrição oficial: Listar todas as condições de pagamento
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (number, obrigatório `*`); `limit` (number, obrigatório `*`); `term` (string, sem `*`); `installments` (string, sem `*`); `priceAdjustment` (string, sem `*`); `erpId` (string, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `page` (query), `limit` (query); no catálogo de componentes: `PaymentConditions`: erpId, term, installments, priceAdjustment, minimumValue, paymentMethodErpId, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `term` (query), `installments` (query), `priceAdjustment` (query), `erpId` (query); no catálogo de componentes: `PaymentConditions`: nenhum campo sem `*`.
- response body de sucesso: `200` Lista de condições de pagamento; campos do exemplo: `erpId`, `term`, `installments`, `priceAdjustment`, `minimumValue`, `paymentMethodErpId`, `companyErpId`
- códigos HTTP documentados: `200` Lista de condições de pagamento | `404` Condições de pagamento não encontradas | `500` Erro no servidor
- principais respostas de erro: `404` Condições de pagamento não encontradas; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `PaymentConditions`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `term`, `installments`, `priceAdjustment`, `minimumValue`, `paymentMethodErpId`, `companyErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (number, obrigatório `*`) e limit (number, obrigatório `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: query: `erpId`; response 2xx: `erpId`, `paymentMethodErpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 10-11; extração vinculada, linhas 546-600; módulo Condições de pagamento; operação `GET /payment-conditions`.

### OP-011 - `POST /payment-conditions`
- módulo: Condições de pagamento
- método HTTP: POST
- rota: `/payment-conditions`
- finalidade/descrição oficial: Criar uma nova condição de pagamento
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `term`, `installments`, `priceAdjustment`, `minimumValue`, `paymentMethodErpId`, `companyErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `PaymentConditions`: erpId, term, installments, priceAdjustment, minimumValue, paymentMethodErpId, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `PaymentConditions`: nenhum campo sem `*`.
- response body de sucesso: `201` Condição de pagamento criada com sucesso; campos do exemplo: `erpId`, `term`, `installments`, `priceAdjustment`, `minimumValue`, `paymentMethodErpId`, `companyErpId`
- códigos HTTP documentados: `201` Condição de pagamento criada com sucesso | `400` Corpo da requisição vazio ou inválido | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição vazio ou inválido; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `PaymentConditions`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `term`, `installments`, `priceAdjustment`, `minimumValue`, `paymentMethodErpId`, `companyErpId`; respostas: `201` presente (objeto), campos: `erpId`, `term`, `installments`, `priceAdjustment`, `minimumValue`, `paymentMethodErpId`, `companyErpId`; `400` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `paymentMethodErpId`, `companyErpId`; response 2xx: `erpId`, `paymentMethodErpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 11-12; extração vinculada, linhas 602-645; módulo Condições de pagamento; operação `POST /payment-conditions`.

### OP-012 - `PUT /payment-conditions`
- módulo: Condições de pagamento
- método HTTP: PUT
- rota: `/payment-conditions`
- finalidade/descrição oficial: Atualizar condição de pagamento
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `term`, `installments`, `priceAdjustment`, `minimumValue`, `paymentMethodErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `PaymentConditions`: erpId, term, installments, priceAdjustment, minimumValue, paymentMethodErpId, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `PaymentConditions`: nenhum campo sem `*`.
- response body de sucesso: `200` Condição de pagamento atualizada com sucesso; campos do exemplo: `erpId`, `term`, `installments`, `priceAdjustment`, `minimumValue`, `paymentMethodErpId`
- códigos HTTP documentados: `200` Condição de pagamento atualizada com sucesso | `404` Condição de pagamento não encontrada | `500` Erro no servidor
- principais respostas de erro: `404` Condição de pagamento não encontrada; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `PaymentConditions`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `term`, `installments`, `priceAdjustment`, `minimumValue`, `paymentMethodErpId`; respostas: `200` presente (objeto), campos: `erpId`, `term`, `installments`, `priceAdjustment`, `minimumValue`, `paymentMethodErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `paymentMethodErpId`; response 2xx: `erpId`, `paymentMethodErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-015, PEND-018
- rastreabilidade da fonte: PDF oficial, páginas 12-13; extração vinculada, linhas 647-692; módulo Condições de pagamento; operação `PUT /payment-conditions`.

### OP-013 - `DELETE /payment-conditions/{erpId}`
- módulo: Condições de pagamento
- método HTTP: DELETE
- rota: `/payment-conditions/{erpId}`
- finalidade/descrição oficial: Remover condição de pagamento por erp_id
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `PaymentConditions`: erpId, term, installments, priceAdjustment, minimumValue, paymentMethodErpId, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `PaymentConditions`: nenhum campo sem `*`.
- response body de sucesso: `200` Condição de pagamento deletada; campos do exemplo: `erpId`, `term`, `installments`, `priceAdjustment`, `minimumValue`, `paymentMethodErpId`
- códigos HTTP documentados: `200` Condição de pagamento deletada | `404` Condição de pagamento não encontrada | `500` Erro no servidor
- principais respostas de erro: `404` Condição de pagamento não encontrada; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `PaymentConditions`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (objeto), campos: `erpId`, `term`, `installments`, `priceAdjustment`, `minimumValue`, `paymentMethodErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`; response 2xx: `erpId`, `paymentMethodErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 13-14; extração vinculada, linhas 694-752; módulo Condições de pagamento; operação `DELETE /payment-conditions/{erpId}`.


## Cores

### OP-014 - `GET /colors`
- módulo: Cores
- método HTTP: GET
- rota: `/colors`
- finalidade/descrição oficial: Listar todas as cores
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, sem `*`); `limit` (integer, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Colors`: erpId, name, rgb, hexCode. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query); no catálogo de componentes: `Colors`: companyErpId.
- response body de sucesso: `200` Lista de cores; campos do exemplo: `erpId`, `name`, `rgb`, `hexCode`
- códigos HTTP documentados: `200` Lista de cores | `404` Cores não encontradas. | `500` Erro no servidor
- principais respostas de erro: `404` Cores não encontradas.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Colors`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `name`, `rgb`, `hexCode`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, sem `*`) e limit (integer, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: response 2xx: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, página 14; extração vinculada, linhas 756-809; módulo Cores; operação `GET /colors`.

### OP-015 - `POST /colors`
- módulo: Cores
- método HTTP: POST
- rota: `/colors`
- finalidade/descrição oficial: Criar uma cor
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `rgb`, `hexCode`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Colors`: erpId, name, rgb, hexCode. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Colors`: companyErpId.
- response body de sucesso: `201` Cor criada com sucesso.; campos do exemplo: `erpId`, `name`, `rgb`, `hexCode`
- códigos HTTP documentados: `201` Cor criada com sucesso. | `400` Corpo da requisição vazio ou inválido. | `409` Cor já existente. | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição vazio ou inválido.; campos do exemplo: `message` | `409` Cor já existente.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Colors`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `rgb`, `hexCode`; respostas: `201` presente (objeto), campos: `erpId`, `name`, `rgb`, `hexCode`; `400` presente (objeto), campos: `message`; `409` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`; response 2xx: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 14-15; extração vinculada, linhas 811-871; módulo Cores; operação `POST /colors`.

### OP-016 - `PUT /colors`
- módulo: Cores
- método HTTP: PUT
- rota: `/colors`
- finalidade/descrição oficial: Atualizar cor por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `rgb`, `hexCode`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Colors`: erpId, name, rgb, hexCode. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Colors`: companyErpId.
- response body de sucesso: `200` Cor atualizada com sucesso!; campos do exemplo: `erpId`, `name`, `rgb`, `colorsCompanyErpId`, `hexCode`
- códigos HTTP documentados: `200` Cor atualizada com sucesso! | `404` Cor não encontrada. | `500` Erro no servidor
- principais respostas de erro: `404` Cor não encontrada.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Colors`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `rgb`, `hexCode`; respostas: `200` presente (objeto), campos: `erpId`, `name`, `rgb`, `colorsCompanyErpId`, `hexCode`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: Identificador primário no request: `erpId`; `colorsCompanyErpId` aparece apenas na resposta e não foi promovido a correlação primária.
- pendências específicas: PEND-005
- rastreabilidade da fonte: PDF oficial, páginas 15-16; extração vinculada, linhas 873-913; módulo Cores; operação `PUT /colors`.

### OP-017 - `PUT /colors/products/{productErpId}`
- módulo: Cores
- método HTTP: PUT
- rota: `/colors/products/{productErpId}`
- finalidade/descrição oficial: Atualizar cores vinculadas com produto do productErpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `productErpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `colorErpId`
- campos obrigatórios: na operação: `productErpId` (path); no catálogo de componentes: `Colors`: erpId, name, rgb, hexCode. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Colors`: companyErpId.
- response body de sucesso: `200` Cores de produto atualizadas com sucesso.; campos do exemplo: `productColorsDeleted`, `count`, `productsColorsCreated`, `id`, `product_id`, `color_id`
- códigos HTTP documentados: `200` Cores de produto atualizadas com sucesso. | `404` Recurso não encontrado. | `500` Erro no servidor
- principais respostas de erro: `404` Recurso não encontrado.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Colors`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (array), campos: `colorErpId`; respostas: `200` presente (objeto), campos: `productColorsDeleted`, `count`, `productsColorsCreated`, `id`, `product_id`, `color_id`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: Alvo no path: `productErpId`; itens do vínculo no request: `colorErpId`. Não existe `erpId` genérico nesta operação.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 16-17; extração vinculada, linhas 915-964; módulo Cores; operação `PUT /colors/products/{productErpId}`.


## Companhias

### OP-018 - `POST /companies`
- módulo: Companhias
- método HTTP: POST
- rota: `/companies`
- finalidade/descrição oficial: Criar uma empresa
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `key`, `apiKey`, `logoImg`, `deadlineType`, `tools`, `defaultCarriers`, `business`, `businessErpId`, `name`, `cnpj`, `municipalRegistration`, `stateRegistration`, `fantasyName`, `email`, `phone`, `cellPhone`, `addressErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Companies`: key, deadlineType, tools, business. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Companies`: erpId, apiKey, logoImg, defaultCarriers.
- response body de sucesso: `201` Empresa criada com sucesso; campos do exemplo: `erpId`, `key`, `logoImg`, `deadlineType`, `tools`, `defaultCarriers`, `business`, `businessErpId`, `name`, `cnpj`, `municipalRegistration`, `stateRegistration`, `fantasyName`, `email`, `phone`, `cellPhone`, `addressErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`
- códigos HTTP documentados: `201` Empresa criada com sucesso | `400` Corpo inválido ou ERP já existente | `500` Erro no servidor
- principais respostas de erro: `400` Corpo inválido ou ERP já existente; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Companies`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `key`, `apiKey`, `logoImg`, `deadlineType`, `tools`, `defaultCarriers`, `business`, `businessErpId`, `name`, `cnpj`, `municipalRegistration`, `stateRegistration`, `fantasyName`, `email`, `phone`, `cellPhone`, `addressErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`; respostas: `201` presente (objeto), campos: `erpId`, `key`, `logoImg`, `deadlineType`, `tools`, `defaultCarriers`, `business`, `businessErpId`, `name`, `cnpj`, `municipalRegistration`, `stateRegistration`, `fantasyName`, `email`, `phone`, `cellPhone`, `addressErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`; `400` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `businessErpId`, `addressErpId`; response 2xx: `erpId`, `businessErpId`, `addressErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 17-18; extração vinculada, linhas 968-1009; módulo Companhias; operação `POST /companies`.

### OP-019 - `PUT /companies`
- módulo: Companhias
- método HTTP: PUT
- rota: `/companies`
- finalidade/descrição oficial: Atualizar empresa por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `key`, `apiKey`, `logoImg`, `deadlineType`, `tools`, `defaultCarriers`, `business`, `name`, `cnpj`, `municipalRegistration`, `stateRegistration`, `fantasyName`, `email`, `phone`, `cellPhone`
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Companies`: key, deadlineType, tools, business. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Companies`: erpId, apiKey, logoImg, defaultCarriers.
- response body de sucesso: `200` Empresa atualizada com sucesso; campos do exemplo: `erpId`, `key`, `apiKey`, `logoImg`, `deadlineType`, `tools`, `defaultCarriers`, `business`, `businessErpId`, `businessCompanyErpId`, `name`, `cnpj`, `municipalRegistration`, `stateRegistration`, `fantasyName`, `email`, `phone`, `cellPhone`, `addressErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`
- códigos HTTP documentados: `200` Empresa atualizada com sucesso | `404` Empresa não encontrada | `500` Erro no servidor
- principais respostas de erro: `404` Empresa não encontrada; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Companies`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `key`, `apiKey`, `logoImg`, `deadlineType`, `tools`, `defaultCarriers`, `business`, `name`, `cnpj`, `municipalRegistration`, `stateRegistration`, `fantasyName`, `email`, `phone`, `cellPhone`; respostas: `200` presente (objeto), campos: `erpId`, `key`, `apiKey`, `logoImg`, `deadlineType`, `tools`, `defaultCarriers`, `business`, `businessErpId`, `businessCompanyErpId`, `name`, `cnpj`, `municipalRegistration`, `stateRegistration`, `fantasyName`, `email`, `phone`, `cellPhone`, `addressErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: A fonte declara `erpId` como path, mas a rota não possui placeholder; transporte da chave AMBIGUO (`PEND-006`).
- pendências específicas: PEND-006
- rastreabilidade da fonte: PDF oficial, páginas 18-19; extração vinculada, linhas 1015-1059; módulo Companhias; operação `PUT /companies`.


## Filiais

### OP-020 - `GET /branches`
- módulo: Filiais
- método HTTP: GET
- rota: `/branches`
- finalidade/descrição oficial: Listar todas as filiais
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, obrigatório `*`); `limit` (integer, obrigatório `*`); `name` (string, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `page` (query), `limit` (query); no catálogo de componentes: `Branches`: name, companyErpId, business. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `name` (query); no catálogo de componentes: `Branches`: erpId.
- response body de sucesso: `200` Lista de filiais; campos do exemplo: `erpId`, `name`, `companyErpId`, `business`, `businessErpId`, `cnpj`, `municipalRegistration`, `stateRegistration`, `businessName`, `fantasyName`, `email`, `phone`, `cellphone`, `addressErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`
- códigos HTTP documentados: `200` Lista de filiais | `404` Nenhuma filial encontrada | `500` Erro no servidor
- principais respostas de erro: `404` Nenhuma filial encontrada; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Branches`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `name`, `companyErpId`, `business`, `businessErpId`, `cnpj`, `municipalRegistration`, `stateRegistration`, `businessName`, `fantasyName`, `email`, `phone`, `cellphone`, `addressErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, obrigatório `*`) e limit (integer, obrigatório `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: response 2xx: `erpId`, `companyErpId`, `businessErpId`, `addressErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 19-20; extração vinculada, linhas 1063-1110; módulo Filiais; operação `GET /branches`.

### OP-021 - `POST /branches`
- módulo: Filiais
- método HTTP: POST
- rota: `/branches`
- finalidade/descrição oficial: Criar uma filial
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `companyErpId`, `business`, `businessErpId`, `cnpj`, `municipalRegistration`, `stateRegistration`, `businessName`, `fantasyName`, `email`, `phone`, `cellphone`, `addressErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Branches`: name, companyErpId, business. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Branches`: erpId.
- response body de sucesso: `201` Filial criada com sucesso.; campos do exemplo: `erpId`, `name`, `companyErpId`, `business`, `businessErpId`, `cnpj`, `municipalRegistration`, `stateRegistration`, `businessName`, `fantasyName`, `email`, `phone`, `cellphone`, `addressErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`
- códigos HTTP documentados: `201` Filial criada com sucesso. | `400` Corpo da requisição vazio ou inválido. | `409` Filial já existente. | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição vazio ou inválido.; campos do exemplo: `message` | `409` Filial já existente.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Branches`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `companyErpId`, `business`, `businessErpId`, `cnpj`, `municipalRegistration`, `stateRegistration`, `businessName`, `fantasyName`, `email`, `phone`, `cellphone`, `addressErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`; respostas: `201` presente (objeto), campos: `erpId`, `name`, `companyErpId`, `business`, `businessErpId`, `cnpj`, `municipalRegistration`, `stateRegistration`, `businessName`, `fantasyName`, `email`, `phone`, `cellphone`, `addressErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`; `400` presente (objeto), campos: `message`; `409` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `companyErpId`, `businessErpId`, `addressErpId`; response 2xx: `erpId`, `companyErpId`, `businessErpId`, `addressErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 20-22; extração vinculada, linhas 1112-1174; módulo Filiais; operação `POST /branches`.

### OP-022 - `PUT /branches`
- módulo: Filiais
- método HTTP: PUT
- rota: `/branches`
- finalidade/descrição oficial: Atualizar filial por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `business`, `cnpj`, `municipalRegistration`, `stateRegistration`, `businessName`, `fantasyName`, `email`, `phone`, `cellphone`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Branches`: name, companyErpId, business. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Branches`: erpId.
- response body de sucesso: `200` Filial atualizada com sucesso!; campos do exemplo: `name`, `business`, `cnpj`, `municipalRegistration`, `stateRegistration`, `businessName`, `fantasyName`, `email`, `phone`, `cellphone`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`
- códigos HTTP documentados: `200` Filial atualizada com sucesso! | `404` Filial não encontrada. | `500` Erro no servidor
- principais respostas de erro: `404` Filial não encontrada.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Branches`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `business`, `cnpj`, `municipalRegistration`, `stateRegistration`, `businessName`, `fantasyName`, `email`, `phone`, `cellphone`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`; respostas: `200` presente (objeto), campos: `name`, `business`, `cnpj`, `municipalRegistration`, `stateRegistration`, `businessName`, `fantasyName`, `email`, `phone`, `cellphone`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-018
- rastreabilidade da fonte: PDF oficial, páginas 22-23; extração vinculada, linhas 1176-1231; módulo Filiais; operação `PUT /branches`.

### OP-023 - `DELETE /branches/{erpId}`
- módulo: Filiais
- método HTTP: DELETE
- rota: `/branches/{erpId}`
- finalidade/descrição oficial: Remover filial por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Branches`: name, companyErpId, business. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Branches`: erpId.
- response body de sucesso: `200` Filial deletada.; campos do exemplo: `erpId`, `name`, `companyErpId`, `business`, `businessErpId`, `cnpj`, `municipalRegistration`, `stateRegistration`, `businessName`, `fantasyName`, `email`, `phone`, `cellphone`, `addressErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`
- códigos HTTP documentados: `200` Filial deletada. | `404` Filial não encontrada. | `500` Erro no servidor
- principais respostas de erro: `404` Filial não encontrada.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Branches`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (objeto), campos: `erpId`, `name`, `companyErpId`, `business`, `businessErpId`, `cnpj`, `municipalRegistration`, `stateRegistration`, `businessName`, `fantasyName`, `email`, `phone`, `cellphone`, `addressErpId`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`; response 2xx: `erpId`, `companyErpId`, `businessErpId`, `addressErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, página 23; extração vinculada, linhas 1233-1278; módulo Filiais; operação `DELETE /branches/{erpId}`.


## Gêneros

### OP-024 - `GET /genders`
- módulo: Gêneros
- método HTTP: GET
- rota: `/genders`
- finalidade/descrição oficial: Listar todos os gêneros
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, sem `*`); `limit` (integer, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Gender`: erpId, name, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query); no catálogo de componentes: `Gender`: nenhum campo sem `*`.
- response body de sucesso: `200` Lista de gêneros; campos do exemplo: `erpId`, `name`, `companyErpId`
- códigos HTTP documentados: `200` Lista de gêneros | `404` Gêneros não encontrados | `500` Erro no servidor
- principais respostas de erro: `404` Gêneros não encontrados; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Gender`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `name`, `companyErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, sem `*`) e limit (integer, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, página 24; extração vinculada, linhas 1286-1339; módulo Gêneros; operação `GET /genders`.

### OP-025 - `POST /genders`
- módulo: Gêneros
- método HTTP: POST
- rota: `/genders`
- finalidade/descrição oficial: Criar um gênero
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `companyErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Gender`: erpId, name, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Gender`: nenhum campo sem `*`.
- response body de sucesso: `201` Gênero criado com sucesso; campos do exemplo: `erpId`, `name`, `companyErpId`
- códigos HTTP documentados: `201` Gênero criado com sucesso | `400` Corpo da requisição vazio ou inválido | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição vazio ou inválido; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Gender`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `companyErpId`; respostas: `201` presente (objeto), campos: `erpId`, `name`, `companyErpId`; `400` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `companyErpId`; response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 24-25; extração vinculada, linhas 1341-1390; módulo Gêneros; operação `POST /genders`.

### OP-026 - `PUT /genders`
- módulo: Gêneros
- método HTTP: PUT
- rota: `/genders`
- finalidade/descrição oficial: Atualizar gênero por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Gender`: erpId, name, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Gender`: nenhum campo sem `*`.
- response body de sucesso: `200` Gênero atualizado com sucesso; campos do exemplo: `erpId`, `name`, `companyErpId`
- códigos HTTP documentados: `200` Gênero atualizado com sucesso | `404` Gênero não encontrado | `500` Erro no servidor
- principais respostas de erro: `404` Gênero não encontrado; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Gender`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`; respostas: `200` presente (objeto), campos: `erpId`, `name`, `companyErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`; request: `erpId`; response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-006, PEND-018
- rastreabilidade da fonte: PDF oficial, páginas 25-26; extração vinculada, linhas 1392-1442; módulo Gêneros; operação `PUT /genders`.

### OP-027 - `DELETE /genders/{erpId}`
- módulo: Gêneros
- método HTTP: DELETE
- rota: `/genders/{erpId}`
- finalidade/descrição oficial: Remover gênero por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Gender`: erpId, name, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Gender`: nenhum campo sem `*`.
- response body de sucesso: `200` Gênero deletado com sucesso; campos do exemplo: `erpId`, `name`
- códigos HTTP documentados: `200` Gênero deletado com sucesso | `404` Gênero não encontrado | `500` Erro no servidor
- principais respostas de erro: `404` Gênero não encontrado; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Gender`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (objeto), campos: `erpId`, `name`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`; response 2xx: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, página 26; extração vinculada, linhas 1444-1497; módulo Gêneros; operação `DELETE /genders/{erpId}`.


## Imagens

### OP-028 - `POST /images`
- módulo: Imagens
- método HTTP: POST
- rota: `/images`
- finalidade/descrição oficial: Fazer upload de imagens para um produto Envia uma ou mais imagens para associar a um produto. As imagens devem ser enviadas como multipart/form-data.
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: multipart/form-data; campos do exemplo oficial, em ordem de primeira ocorrência: `images`
- campos obrigatórios: na operação: `images` (request multipart, `array<string>`); no catálogo de componentes: sem componente final inequivocamente relacionado. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: sem componente final inequivocamente relacionado.
- response body de sucesso: `200` Imagens inseridas com sucesso; campos do exemplo: `path`, `order`, `productErpId`
- códigos HTTP documentados: `200` Imagens inseridas com sucesso | `400` Nenhuma imagem enviada ou dados inválidos | `404` Produto ou variante não encontrada | `500` Erro no servidor
- principais respostas de erro: `400` Nenhuma imagem enviada ou dados inválidos; campos do exemplo: `message` | `404` Produto ou variante não encontrada; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente final: NAO_DOCUMENTADO
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (multipart), campos: `images`; respostas: `200` presente (array), campos: `path`, `order`, `productErpId`; `400` presente (objeto), campos: `message`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: `UPLOAD multipart/form-data`; campo obrigatório `images` (`array<string>`); associação ao produto/variante: AMBIGUA (`PEND-016`)
- evidência de identificação/correlação: O request contém somente `images`; o identificador do produto/variante não é documentado. `productErpId` aparece apenas na resposta (`PEND-016`).
- pendências específicas: PEND-016
- rastreabilidade da fonte: PDF oficial, páginas 26-27; extração vinculada, linhas 1501-1568; módulo Imagens; operação `POST /images`.


## Linhas

### OP-029 - `POST /lines`
- módulo: Linhas
- método HTTP: POST
- rota: `/lines`
- finalidade/descrição oficial: Criar ou atualizar uma linha
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `description`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Line`: erpId, description. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Line`: nenhum campo sem `*`.
- response body de sucesso: `201` Linha criada ou atualizada com sucesso; campos do exemplo: `id`, `erpId`, `description`
- códigos HTTP documentados: `201` Linha criada ou atualizada com sucesso | `400` Corpo da requisição inválido | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição inválido; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Line`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `description`; respostas: `201` presente (objeto), campos: `id`, `erpId`, `description`; `400` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`; response 2xx: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 27-28; extração vinculada, linhas 1572-1623; módulo Linhas; operação `POST /lines`.

### OP-030 - `DELETE /lines`
- módulo: Linhas
- método HTTP: DELETE
- rota: `/lines`
- finalidade/descrição oficial: Remover linha por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Line`: erpId, description. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Line`: nenhum campo sem `*`.
- response body de sucesso: `200` Linha removida com sucesso; campos do exemplo: `id`, `erpId`, `description`
- códigos HTTP documentados: `200` Linha removida com sucesso | `404` Linha não encontrada | `500` Erro no servidor
- principais respostas de erro: `404` Linha não encontrada; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Line`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`; respostas: `200` presente (objeto), campos: `id`, `erpId`, `description`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`; response 2xx: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 28-29; extração vinculada, linhas 1625-1681; módulo Linhas; operação `DELETE /lines`.


## Marcas

### OP-031 - `GET /brands`
- módulo: Marcas
- método HTTP: GET
- rota: `/brands`
- finalidade/descrição oficial: Listar todas as Marcas
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, sem `*`); `limit` (integer, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Brands`: erpId, name, minValue, minInstallmentsValue, addressErpId, businessErpId, addresses. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query); no catálogo de componentes: `Brands`: logoImg, visible, skuOrder.
- response body de sucesso: `200` Lista de Marcas; campos do exemplo: `erpId`, `name`, `logoImg`, `minValue`, `minInstallmentsValue`, `companyErpId`, `visible`, `skuOrder`, `addresses`, `addressesErpId`, `city`, `street`, `number`, `neighborhood`, `uf`, `zipCode`, `complement`
- códigos HTTP documentados: `200` Lista de Marcas | `404` Nenhuma marca encontrada | `500` Erro no servidor
- principais respostas de erro: `404` Nenhuma marca encontrada; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Brands`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `name`, `logoImg`, `minValue`, `minInstallmentsValue`, `companyErpId`, `visible`, `skuOrder`, `addresses`, `addressesErpId`, `city`, `street`, `number`, `neighborhood`, `uf`, `zipCode`, `complement`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, sem `*`) e limit (integer, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: response 2xx: `erpId`, `companyErpId`, `addressesErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 29-30; extração vinculada, linhas 1685-1744; módulo Marcas; operação `GET /brands`.

### OP-032 - `POST /brands`
- módulo: Marcas
- método HTTP: POST
- rota: `/brands`
- finalidade/descrição oficial: Criar uma marca
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `logoImg`, `minValue`, `minInstallmentsValue`, `companyErpId`, `visible`, `skuOrder`, `addresses`, `addressesErpId`, `city`, `street`, `number`, `neighborhood`, `uf`, `zipCode`, `complement`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Brands`: erpId, name, minValue, minInstallmentsValue, addressErpId, businessErpId, addresses. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Brands`: logoImg, visible, skuOrder.
- response body de sucesso: NAO_DOCUMENTADO
- códigos HTTP documentados: `400` Requisição inválida | `500` Erro no servidor
- principais respostas de erro: `400` Requisição inválida; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Brands`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `logoImg`, `minValue`, `minInstallmentsValue`, `companyErpId`, `visible`, `skuOrder`, `addresses`, `addressesErpId`, `city`, `street`, `number`, `neighborhood`, `uf`, `zipCode`, `complement`; respostas: 2xx ausente na fonte; `400` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `companyErpId`, `addressesErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-013, PEND-018
- rastreabilidade da fonte: PDF oficial, página 30; extração vinculada, linhas 1746-1789; módulo Marcas; operação `POST /brands`.

### OP-033 - `PUT /brands`
- módulo: Marcas
- método HTTP: PUT
- rota: `/brands`
- finalidade/descrição oficial: Atualizar marca por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `name`, `logoImg`, `minValue`, `minInstallmentsValue`, `visible`, `skuOrder`, `addresses`, `addressesErpId`, `city`, `street`, `number`, `neighborhood`, `uf`, `zipCode`, `complement`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Brands`: erpId, name, minValue, minInstallmentsValue, addressErpId, businessErpId, addresses. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Brands`: logoImg, visible, skuOrder.
- response body de sucesso: `200` Empresa atualizada com sucesso!; campos do exemplo: `erpId`, `name`, `logoImg`, `minValue`, `minInstallmentsValue`, `visible`, `skuOrder`, `addresses`, `addressesErpId`, `city`, `street`, `number`, `neighborhood`, `uf`, `zipCode`, `complement`
- códigos HTTP documentados: `200` Empresa atualizada com sucesso! | `401` Requisição inválida | `404` Recurso não encontrado | `500` Erro no servidor
- principais respostas de erro: `401` Requisição inválida; campos do exemplo: `message` | `404` Recurso não encontrado; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message` | conflito literal preservado: status `401`, exemplo `message` com texto `400: Parâmetros inválidos` (`PEND-010`)
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Brands`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `name`, `logoImg`, `minValue`, `minInstallmentsValue`, `visible`, `skuOrder`, `addresses`, `addressesErpId`, `city`, `street`, `number`, `neighborhood`, `uf`, `zipCode`, `complement`; respostas: `200` presente (objeto), campos: `erpId`, `name`, `logoImg`, `minValue`, `minInstallmentsValue`, `visible`, `skuOrder`, `addresses`, `addressesErpId`, `city`, `street`, `number`, `neighborhood`, `uf`, `zipCode`, `complement`; `401` presente (objeto), campos: `message`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `addressesErpId`; response 2xx: `erpId`, `addressesErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-010, PEND-012, PEND-015, PEND-018
- rastreabilidade da fonte: PDF oficial, páginas 30-31; extração vinculada, linhas 1791-1852; módulo Marcas; operação `PUT /brands`.


## Métodos de pagamento

### OP-034 - `GET /payment-methods`
- módulo: Métodos de pagamento
- método HTTP: GET
- rota: `/payment-methods`
- finalidade/descrição oficial: Listar todos os métodos de pagamento
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, obrigatório `*`); `limit` (integer, obrigatório `*`); `description` (string, sem `*`); `minValue` (string, sem `*`); `priceAdjustment` (string, sem `*`); `erpId` (string, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `page` (query), `limit` (query); no catálogo de componentes: `PaymentMethods`: description, minValue, priceAdjustment, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `description` (query), `minValue` (query), `priceAdjustment` (query), `erpId` (query); no catálogo de componentes: `PaymentMethods`: erpId.
- response body de sucesso: `200` Lista de métodos de pagamento; campos do exemplo: `erpId`, `description`, `minValue`, `companyErpId`, `priceAdjustment`
- códigos HTTP documentados: `200` Lista de métodos de pagamento | `404` Métodos de pagamento não encontrados | `500` Erro no servidor
- principais respostas de erro: `404` Métodos de pagamento não encontrados; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `PaymentMethods`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `description`, `minValue`, `companyErpId`, `priceAdjustment`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, obrigatório `*`) e limit (integer, obrigatório `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: query: `erpId`; response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 32-33; extração vinculada, linhas 1860-1914; módulo Métodos de pagamento; operação `GET /payment-methods`.

### OP-035 - `POST /payment-methods`
- módulo: Métodos de pagamento
- método HTTP: POST
- rota: `/payment-methods`
- finalidade/descrição oficial: Criar um novo método de pagamento
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `description`, `minValue`, `companyErpId`, `priceAdjustment`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `PaymentMethods`: description, minValue, priceAdjustment, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `PaymentMethods`: erpId.
- response body de sucesso: `201` Método de pagamento criado com sucesso; campos do exemplo: `erpId`, `description`, `minValue`, `companyErpId`, `priceAdjustment`
- códigos HTTP documentados: `201` Método de pagamento criado com sucesso | `400` Corpo da requisição vazio ou inválido | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição vazio ou inválido; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `PaymentMethods`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `description`, `minValue`, `companyErpId`, `priceAdjustment`; respostas: `201` presente (objeto), campos: `erpId`, `description`, `minValue`, `companyErpId`, `priceAdjustment`; `400` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `companyErpId`; response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, página 33; extração vinculada, linhas 1916-1974; módulo Métodos de pagamento; operação `POST /payment-methods`.

### OP-036 - `PUT /payment-methods`
- módulo: Métodos de pagamento
- método HTTP: PUT
- rota: `/payment-methods`
- finalidade/descrição oficial: Atualizar método de pagamento por erp_id
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `description`, `minValue`, `priceAdjustment`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `PaymentMethods`: description, minValue, priceAdjustment, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `PaymentMethods`: erpId.
- response body de sucesso: `200` Método de pagamento atualizado com sucesso; campos do exemplo: `erpId`, `description`, `minValue`, `companyErpId`, `priceAdjustment`
- códigos HTTP documentados: `200` Método de pagamento atualizado com sucesso | `404` Método de pagamento não encontrado | `500` Erro no servidor
- principais respostas de erro: `404` Método de pagamento não encontrado; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `PaymentMethods`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `description`, `minValue`, `priceAdjustment`; respostas: `200` presente (objeto), campos: `erpId`, `description`, `minValue`, `companyErpId`, `priceAdjustment`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`; response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-018
- rastreabilidade da fonte: PDF oficial, páginas 33-34; extração vinculada, linhas 1976-2019; módulo Métodos de pagamento; operação `PUT /payment-methods`.

### OP-037 - `DELETE /payment-methods/{erpId}`
- módulo: Métodos de pagamento
- método HTTP: DELETE
- rota: `/payment-methods/{erpId}`
- finalidade/descrição oficial: Remover método de pagamento por erp_id
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `PaymentMethods`: description, minValue, priceAdjustment, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `PaymentMethods`: erpId.
- response body de sucesso: `200` Método de pagamento deletado; campos do exemplo: `erpId`, `description`, `minValue`, `companyErpId`, `priceAdjustment`
- códigos HTTP documentados: `200` Método de pagamento deletado | `404` Método de pagamento não encontrado | `500` Erro no servidor
- principais respostas de erro: `404` Método de pagamento não encontrado; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `PaymentMethods`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (objeto), campos: `erpId`, `description`, `minValue`, `companyErpId`, `priceAdjustment`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`; response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 34-35; extração vinculada, linhas 2021-2068; módulo Métodos de pagamento; operação `DELETE /payment-methods/{erpId}`.


## Pedidos

### OP-038 - `GET /orders`
- módulo: Pedidos
- método HTTP: GET
- rota: `/orders`
- finalidade/descrição oficial: Listar pedidos não integrados.
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, sem `*`); `limit` (integer, sem `*`); `name` (string, sem `*`); `number` (string, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Orders`: ped_data_pagamento, ped_data_entrega, ped_descricao_entrega, ped_modo_entrega, ped_forma_pagamento, ped_data_pedido, ped_numero_pedido, ped_ordem_compra, ped_observacao, ped_nome_comprador, ped_email_enviado, ped_visualizar, orcamento, ped_ipi, ped_st, ped_tabela_precos, ped_email_xml, ped_transp_nome, ped_transp_tel, ped_transp_email, ped_enviar_emails, ped_fotos_produtos, ped_aprovado, ped_data_aprovado, ped_motivo_reprovar, ped_transp_id, ped_telefone_cliente, ped_tipo_frete, ped_tipo_venda, ped_numero_externo, ped_representante_ausente, ped_status, uuid, user_jwt, platform, fk_vendedores, fk_vendedores_aux, created_at, pedido_cliente, verificacao, fk_prepostos, ped_b2c_exportado, crp_desconto_especial, integrated, ped_conceito, tabela_precos, marca, cliente, representante, prazo, transportadora, carrinho_pedido. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query), `name` (query), `number` (query); no catálogo de componentes: `Orders`: nenhum campo sem `*`.
- response body de sucesso: `200` Lista de pedidos não integrados; campos do exemplo: `ped_data_pagamento`, `ped_data_entrega`, `ped_descricao_entrega`, `ped_modo_entrega`, `ped_forma_pagamento`, `ped_data_pedido`, `ped_numero_pedido`, `ped_ordem_compra`, `ped_observacao`, `ped_nome_comprador`, `ped_email_enviado`, `ped_visualizar`, `orcamento`, `ped_ipi`, `ped_st`, `ped_tabela_precos`, `ped_email_xml`, `ped_transp_nome`, `ped_transp_tel`, `ped_transp_email`, `ped_enviar_emails`, `ped_fotos_produtos`, `ped_aprovado`, `ped_data_aprovado`, `ped_motivo_reprovar`, `ped_transp_id`, `ped_telefone_cliente`, `ped_tipo_frete`, `ped_tipo_venda`, `ped_numero_externo`, `ped_representante_ausente`, `ped_status`, `uuid`, `user_jwt`, `platform`, `fk_vendedores`, `fk_vendedores_aux`, `created_at`, `pedido_cliente`, `verificacao`, `fk_prepostos`, `ped_b2c_exportado`, `crp_desconto_especial`, `integrated`, `marca`, `id`, `mc_nome`, `mc_cnpj`, `mc_endereco`, `mc_numero`, `mc_complemento`, `mc_bairro`, `mc_cidade`, `mc_uf`, `mc_cep`, `mc_id_erp`, `mc_codigo_tabela`, `mc_visualizar`, `cliente`, `cl_nome_comprador`, `cl_cargo`, `cl_razao`, `cl_fantasia`, `cl_unidade`, `cl_cnpj`, `cl_inscricao_estadual`, `cl_inscricao_suframa`, `cl_telefone`, `cl_email_cadastro`, `cl_email_1`, `cl_email_2`, `cl_id_erp`, `cl_conceito`, `representante`, `rp_nome`, `rp_rg`, `rp_cpf`, `rp_data_nascimento`, `rp_sexo`, `rp_data_emissao`, `rp_orgao_emissor`, `rp_orgao_uf_emissor`, `rp_registro_core`, `rp_email_1`, `rp_email_2`, `rp_email_3`, `rp_razao_social`, `rp_nome_fantasia`, `rp_cnpj`, `rp_inscricao_estadual`, `rp_inscricao_municipal`, `rp_id_erp`, `rp_cep`, `rp_endereco`, `rp_numero`, `rp_complemento`, `rp_bairro`, `rp_cidade`, `rp_uf`, `rp_lmt_desconto_especial`, `rp_comissao_1`, `lrp_comissao_2`, `prazo`, `prz_nome`, `prz_desconto`, `prz_id_erp`, `ped_conceito`, `tabela_precos`, `transportadora`, `etr_nome`, `etr_email`, `etr_telefone`, `etr_cnpj`, `etr_tipo_frete`, `etr_id_erp`, `carrinho_pedido`, `crp_quantidade`, `crp_quantidade_cancelada`, `crp_quantidade_entregue`, `crp_quantidade_entregar`, `crp_quantidade_embalada`, `crp_preco_unitario`, `crp_valor_original`, `crp_valor_entregar`, `crp_valor_entregue`, `crp_valor_cancelado`, `crp_prazo_entrega`, `crp_desconto_volume`, `crp_desconto_valor`, `crp_desconto_parcela`, `crp_desconto_individual`, `crp_desconto_progressivo`, `crp_desconto_unitario`, `crp_cubagem_total`, `crp_peso_total`, `crp_ipi_valor`, `crp_st_valor`, `produto`, `prd_nome`, `prd_referencia`, `tamanho`, `tmh_nome`, `tmh_id_erp`, `cor`, `cor_nome`, `cor_id_erp`, `crp_sku_erp`, `crp_comissao_1`, `crp_comissao_2`
- códigos HTTP documentados: `200` Lista de pedidos não integrados | `404` Pedidos não encontrados. | `500` Erro no servidor
- principais respostas de erro: `404` Pedidos não encontrados.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Orders`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `ped_data_pagamento`, `ped_data_entrega`, `ped_descricao_entrega`, `ped_modo_entrega`, `ped_forma_pagamento`, `ped_data_pedido`, `ped_numero_pedido`, `ped_ordem_compra`, `ped_observacao`, `ped_nome_comprador`, `ped_email_enviado`, `ped_visualizar`, `orcamento`, `ped_ipi`, `ped_st`, `ped_tabela_precos`, `ped_email_xml`, `ped_transp_nome`, `ped_transp_tel`, `ped_transp_email`, `ped_enviar_emails`, `ped_fotos_produtos`, `ped_aprovado`, `ped_data_aprovado`, `ped_motivo_reprovar`, `ped_transp_id`, `ped_telefone_cliente`, `ped_tipo_frete`, `ped_tipo_venda`, `ped_numero_externo`, `ped_representante_ausente`, `ped_status`, `uuid`, `user_jwt`, `platform`, `fk_vendedores`, `fk_vendedores_aux`, `created_at`, `pedido_cliente`, `verificacao`, `fk_prepostos`, `ped_b2c_exportado`, `crp_desconto_especial`, `integrated`, `marca`, `id`, `mc_nome`, `mc_cnpj`, `mc_endereco`, `mc_numero`, `mc_complemento`, `mc_bairro`, `mc_cidade`, `mc_uf`, `mc_cep`, `mc_id_erp`, `mc_codigo_tabela`, `mc_visualizar`, `cliente`, `cl_nome_comprador`, `cl_cargo`, `cl_razao`, `cl_fantasia`, `cl_unidade`, `cl_cnpj`, `cl_inscricao_estadual`, `cl_inscricao_suframa`, `cl_telefone`, `cl_email_cadastro`, `cl_email_1`, `cl_email_2`, `cl_id_erp`, `cl_conceito`, `representante`, `rp_nome`, `rp_rg`, `rp_cpf`, `rp_data_nascimento`, `rp_sexo`, `rp_data_emissao`, `rp_orgao_emissor`, `rp_orgao_uf_emissor`, `rp_registro_core`, `rp_email_1`, `rp_email_2`, `rp_email_3`, `rp_razao_social`, `rp_nome_fantasia`, `rp_cnpj`, `rp_inscricao_estadual`, `rp_inscricao_municipal`, `rp_id_erp`, `rp_cep`, `rp_endereco`, `rp_numero`, `rp_complemento`, `rp_bairro`, `rp_cidade`, `rp_uf`, `rp_lmt_desconto_especial`, `rp_comissao_1`, `lrp_comissao_2`, `prazo`, `prz_nome`, `prz_desconto`, `prz_id_erp`, `ped_conceito`, `tabela_precos`, `transportadora`, `etr_nome`, `etr_email`, `etr_telefone`, `etr_cnpj`, `etr_tipo_frete`, `etr_id_erp`, `carrinho_pedido`, `crp_quantidade`, `crp_quantidade_cancelada`, `crp_quantidade_entregue`, `crp_quantidade_entregar`, `crp_quantidade_embalada`, `crp_preco_unitario`, `crp_valor_original`, `crp_valor_entregar`, `crp_valor_entregue`, `crp_valor_cancelado`, `crp_prazo_entrega`, `crp_desconto_volume`, `crp_desconto_valor`, `crp_desconto_parcela`, `crp_desconto_individual`, `crp_desconto_progressivo`, `crp_desconto_unitario`, `crp_cubagem_total`, `crp_peso_total`, `crp_ipi_valor`, `crp_st_valor`, `produto`, `prd_nome`, `prd_referencia`, `tamanho`, `tmh_nome`, `tmh_id_erp`, `cor`, `cor_nome`, `cor_id_erp`, `crp_sku_erp`, `crp_comissao_1`, `crp_comissao_2`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, sem `*`) e limit (integer, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: Filtros `name` e `number`; a resposta expõe `ped_numero_pedido` e `ped_numero_externo`. As grafias não foram declaradas equivalentes.
- pendências específicas: PEND-005, PEND-014
- rastreabilidade da fonte: PDF oficial, páginas 35-37; extração vinculada, linhas 2072-2133; módulo Pedidos; operação `GET /orders`.

### OP-039 - `PATCH /orders/export/{number}`
- módulo: Pedidos
- método HTTP: PATCH
- rota: `/orders/export/{number}`
- finalidade/descrição oficial: Exportar pedido
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `number` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `number` (path); no catálogo de componentes: `Orders`: ped_data_pagamento, ped_data_entrega, ped_descricao_entrega, ped_modo_entrega, ped_forma_pagamento, ped_data_pedido, ped_numero_pedido, ped_ordem_compra, ped_observacao, ped_nome_comprador, ped_email_enviado, ped_visualizar, orcamento, ped_ipi, ped_st, ped_tabela_precos, ped_email_xml, ped_transp_nome, ped_transp_tel, ped_transp_email, ped_enviar_emails, ped_fotos_produtos, ped_aprovado, ped_data_aprovado, ped_motivo_reprovar, ped_transp_id, ped_telefone_cliente, ped_tipo_frete, ped_tipo_venda, ped_numero_externo, ped_representante_ausente, ped_status, uuid, user_jwt, platform, fk_vendedores, fk_vendedores_aux, created_at, pedido_cliente, verificacao, fk_prepostos, ped_b2c_exportado, crp_desconto_especial, integrated, ped_conceito, tabela_precos, marca, cliente, representante, prazo, transportadora, carrinho_pedido. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Orders`: nenhum campo sem `*`.
- response body de sucesso: `200` Pedido exportado com sucesso!; campos do exemplo: `ped_data_pagamento`, `ped_data_entrega`, `ped_descricao_entrega`, `ped_modo_entrega`, `ped_forma_pagamento`, `ped_data_pedido`, `ped_numero_pedido`, `ped_ordem_compra`, `ped_observacao`, `ped_nome_comprador`, `ped_email_enviado`, `ped_visualizar`, `orcamento`, `ped_ipi`, `ped_st`, `ped_tabela_precos`, `ped_email_xml`, `ped_transp_nome`, `ped_transp_tel`, `ped_transp_email`, `ped_enviar_emails`, `ped_fotos_produtos`, `ped_aprovado`, `ped_data_aprovado`, `ped_motivo_reprovar`, `ped_transp_id`, `ordersPedTelefoneCliente`, `ped_tipo_frete`, `ped_tipo_venda`, `ordersped_numero_externo`, `ped_representante_ausente`, `ped_status`, `uuid`, `user_jwt`, `platform`, `fk_vendedores`, `fk_vendedores_aux`, `created_at`, `pedido_cliente`, `verificacao`, `fk_prepostos`, `ped_b2c_exportado`, `crp_desconto_especial`, `integrated`, `marca`, `id`, `mc_nome`, `mc_cnpj`, `mc_endereco`, `mc_numero`, `mc_complemento`, `mc_bairro`, `mc_cidade`, `mc_uf`, `mc_cep`, `mc_id_erp`, `mc_codigo_tabela`, `mc_visualizar`, `cliente`, `cl_nome_comprador`, `cl_cargo`, `cl_razao`, `cl_fantasia`, `cl_unidade`, `cl_cnpj`, `cl_inscricao_estadual`, `cl_inscricao_suframa`, `cl_telefone`, `cl_email_cadastro`, `cl_email_1`, `cl_email_2`, `cl_id_erp`, `cl_conceito`, `representante`, `rp_nome`, `rp_rg`, `rp_cpf`, `rp_data_nascimento`, `rp_sexo`, `rp_data_emissao`, `rp_orgao_emissor`, `rp_orgao_uf_emissor`, `rp_registro_core`, `rp_email_1`, `rp_email_2`, `rp_email_3`, `rp_razao_social`, `rp_nome_fantasia`, `rp_cnpj`, `rp_inscricao_estadual`, `rp_inscricao_municipal`, `rp_id_erp`, `rpCep`, `rpEndereco`, `rpNumero`, `rpComplemento`, `rpBairro`, `rpCidade`, `rpUf`, `rp_lmt_desconto_especial`, `rp_comissao_1`, `rpComissao2`, `prazo`, `prz_nome`, `prz_desconto`, `prz_id_erp`, `ordersVendedorAuxiliar`, `nome`, `cpf`, `codigo`, `ped_conceito`, `tabela_precos`, `transportadora`, `etr_nome`, `etr_email`, `etr_telefone`, `etr_cnpj`, `etr_tipo_frete`, `etr_id_erp`, `carrinho_pedido`, `crp_quantidade`, `crp_quantidade_cancelada`, `crp_quantidade_entregue`, `crp_quantidade_entregar`, `crp_quantidade_embalada`, `crp_preco_unitario`, `crp_valor_original`, `crp_valor_entregar`, `crp_valor_entregue`, `crp_valor_cancelado`, `crp_prazo_entrega`, `crp_desconto_volume`, `crp_desconto_valor`, `crp_desconto_parcela`, `crp_desconto_individual`, `crp_desconto_progressivo`, `crp_desconto_unitario`, `crp_cubagem_total`, `crp_peso_total`, `crp_ipi_valor`, `crp_st_valor`, `produto`, `prd_nome`, `prd_referencia`, `tamanho`, `tmh_nome`, `tmh_id_erp`, `cor`, `cor_nome`, `cor_id_erp`, `crp_sku_erp`, `crp_comissao_1`, `crp_comissao_2`
- códigos HTTP documentados: `200` Pedido exportado com sucesso! | `404` Pedido não encontrado. | `500` Erro no servidor
- principais respostas de erro: `404` Pedido não encontrado.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Orders`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (objeto), campos: `ped_data_pagamento`, `ped_data_entrega`, `ped_descricao_entrega`, `ped_modo_entrega`, `ped_forma_pagamento`, `ped_data_pedido`, `ped_numero_pedido`, `ped_ordem_compra`, `ped_observacao`, `ped_nome_comprador`, `ped_email_enviado`, `ped_visualizar`, `orcamento`, `ped_ipi`, `ped_st`, `ped_tabela_precos`, `ped_email_xml`, `ped_transp_nome`, `ped_transp_tel`, `ped_transp_email`, `ped_enviar_emails`, `ped_fotos_produtos`, `ped_aprovado`, `ped_data_aprovado`, `ped_motivo_reprovar`, `ped_transp_id`, `ordersPedTelefoneCliente`, `ped_tipo_frete`, `ped_tipo_venda`, `ordersped_numero_externo`, `ped_representante_ausente`, `ped_status`, `uuid`, `user_jwt`, `platform`, `fk_vendedores`, `fk_vendedores_aux`, `created_at`, `pedido_cliente`, `verificacao`, `fk_prepostos`, `ped_b2c_exportado`, `crp_desconto_especial`, `integrated`, `marca`, `id`, `mc_nome`, `mc_cnpj`, `mc_endereco`, `mc_numero`, `mc_complemento`, `mc_bairro`, `mc_cidade`, `mc_uf`, `mc_cep`, `mc_id_erp`, `mc_codigo_tabela`, `mc_visualizar`, `cliente`, `cl_nome_comprador`, `cl_cargo`, `cl_razao`, `cl_fantasia`, `cl_unidade`, `cl_cnpj`, `cl_inscricao_estadual`, `cl_inscricao_suframa`, `cl_telefone`, `cl_email_cadastro`, `cl_email_1`, `cl_email_2`, `cl_id_erp`, `cl_conceito`, `representante`, `rp_nome`, `rp_rg`, `rp_cpf`, `rp_data_nascimento`, `rp_sexo`, `rp_data_emissao`, `rp_orgao_emissor`, `rp_orgao_uf_emissor`, `rp_registro_core`, `rp_email_1`, `rp_email_2`, `rp_email_3`, `rp_razao_social`, `rp_nome_fantasia`, `rp_cnpj`, `rp_inscricao_estadual`, `rp_inscricao_municipal`, `rp_id_erp`, `rpCep`, `rpEndereco`, `rpNumero`, `rpComplemento`, `rpBairro`, `rpCidade`, `rpUf`, `rp_lmt_desconto_especial`, `rp_comissao_1`, `rpComissao2`, `prazo`, `prz_nome`, `prz_desconto`, `prz_id_erp`, `ordersVendedorAuxiliar`, `nome`, `cpf`, `codigo`, `ped_conceito`, `tabela_precos`, `transportadora`, `etr_nome`, `etr_email`, `etr_telefone`, `etr_cnpj`, `etr_tipo_frete`, `etr_id_erp`, `carrinho_pedido`, `crp_quantidade`, `crp_quantidade_cancelada`, `crp_quantidade_entregue`, `crp_quantidade_entregar`, `crp_quantidade_embalada`, `crp_preco_unitario`, `crp_valor_original`, `crp_valor_entregar`, `crp_valor_entregue`, `crp_valor_cancelado`, `crp_prazo_entrega`, `crp_desconto_volume`, `crp_desconto_valor`, `crp_desconto_parcela`, `crp_desconto_individual`, `crp_desconto_progressivo`, `crp_desconto_unitario`, `crp_cubagem_total`, `crp_peso_total`, `crp_ipi_valor`, `crp_st_valor`, `produto`, `prd_nome`, `prd_referencia`, `tamanho`, `tmh_nome`, `tmh_id_erp`, `cor`, `cor_nome`, `cor_id_erp`, `crp_sku_erp`, `crp_comissao_1`, `crp_comissao_2`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `number`; response 2xx: `uuid`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-005, PEND-014
- rastreabilidade da fonte: PDF oficial, páginas 37-40; extração vinculada, linhas 2135-2187; módulo Pedidos; operação `PATCH /orders/export/{number}`.

### OP-040 - `PATCH /orders/{number}`
- módulo: Pedidos
- método HTTP: PATCH
- rota: `/orders/{number}`
- finalidade/descrição oficial: Marcar pedido como integrado e passar numero ERP
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `number` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `ped_numero_externo`, `crp_desconto_especial`, `integrated`
- campos obrigatórios: na operação: `number` (path); no catálogo de componentes: `Orders`: ped_data_pagamento, ped_data_entrega, ped_descricao_entrega, ped_modo_entrega, ped_forma_pagamento, ped_data_pedido, ped_numero_pedido, ped_ordem_compra, ped_observacao, ped_nome_comprador, ped_email_enviado, ped_visualizar, orcamento, ped_ipi, ped_st, ped_tabela_precos, ped_email_xml, ped_transp_nome, ped_transp_tel, ped_transp_email, ped_enviar_emails, ped_fotos_produtos, ped_aprovado, ped_data_aprovado, ped_motivo_reprovar, ped_transp_id, ped_telefone_cliente, ped_tipo_frete, ped_tipo_venda, ped_numero_externo, ped_representante_ausente, ped_status, uuid, user_jwt, platform, fk_vendedores, fk_vendedores_aux, created_at, pedido_cliente, verificacao, fk_prepostos, ped_b2c_exportado, crp_desconto_especial, integrated, ped_conceito, tabela_precos, marca, cliente, representante, prazo, transportadora, carrinho_pedido. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Orders`: nenhum campo sem `*`.
- response body de sucesso: `200` Pedido integrado com sucesso!; campos do exemplo: `crp_desconto_especial`, `integrated`, `ordersped_numero_externo`
- códigos HTTP documentados: `200` Pedido integrado com sucesso! | `404` Pedido não encontrado. | `500` Erro no servidor
- principais respostas de erro: `404` Pedido não encontrado.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Orders`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `ped_numero_externo`, `crp_desconto_especial`, `integrated`; respostas: `200` presente (objeto), campos: `crp_desconto_especial`, `integrated`, `ordersped_numero_externo`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: Alvo no path: `number`; request contém `ped_numero_externo`. A relação entre os campos foi preservada por contexto, sem equivalência implícita.
- pendências específicas: PEND-005, PEND-014
- rastreabilidade da fonte: PDF oficial, páginas 40-41; extração vinculada, linhas 2189-2257; módulo Pedidos; operação `PATCH /orders/{number}`.

### OP-041 - `PUT /orders/status`
- módulo: Pedidos
- método HTTP: PUT
- rota: `/orders/status`
- finalidade/descrição oficial: Rota para atualizar status e informações de NFE dos pedidos.
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `orderNumber`, `orderErpId`, `carrierErpId`, `clientErpId`, `clientName`, `clientCnpj`, `carrierName`, `carrierCnpj`, `status`, `branchCode`, `boxCode`, `boxQuantity`, `packagedQuantity`, `packagedValue`, `packagedDate`, `nfeNumber`, `nfeKey`, `nfeSerie`, `nfeEmissionDate`, `nfeAuthorizationDate`, `nfeAuthorizationProtocol`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Orders`: ped_data_pagamento, ped_data_entrega, ped_descricao_entrega, ped_modo_entrega, ped_forma_pagamento, ped_data_pedido, ped_numero_pedido, ped_ordem_compra, ped_observacao, ped_nome_comprador, ped_email_enviado, ped_visualizar, orcamento, ped_ipi, ped_st, ped_tabela_precos, ped_email_xml, ped_transp_nome, ped_transp_tel, ped_transp_email, ped_enviar_emails, ped_fotos_produtos, ped_aprovado, ped_data_aprovado, ped_motivo_reprovar, ped_transp_id, ped_telefone_cliente, ped_tipo_frete, ped_tipo_venda, ped_numero_externo, ped_representante_ausente, ped_status, uuid, user_jwt, platform, fk_vendedores, fk_vendedores_aux, created_at, pedido_cliente, verificacao, fk_prepostos, ped_b2c_exportado, crp_desconto_especial, integrated, ped_conceito, tabela_precos, marca, cliente, representante, prazo, transportadora, carrinho_pedido. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Orders`: nenhum campo sem `*`.
- response body de sucesso: `200` DESCRICAO_NAO_DOCUMENTADA; body/exemplo: NAO_DOCUMENTADO
- códigos HTTP documentados: `200` DESCRICAO_NAO_DOCUMENTADA | `400` DESCRICAO_NAO_DOCUMENTADA | `404` DESCRICAO_NAO_DOCUMENTADA | `500` Erro no servidor
- principais respostas de erro: `400` DESCRICAO_NAO_DOCUMENTADA; body/exemplo: NAO_DOCUMENTADO | `404` DESCRICAO_NAO_DOCUMENTADA; body/exemplo: NAO_DOCUMENTADO | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Orders`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `orderNumber`, `orderErpId`, `carrierErpId`, `clientErpId`, `clientName`, `clientCnpj`, `carrierName`, `carrierCnpj`, `status`, `branchCode`, `boxCode`, `boxQuantity`, `packagedQuantity`, `packagedValue`, `packagedDate`, `nfeNumber`, `nfeKey`, `nfeSerie`, `nfeEmissionDate`, `nfeAuthorizationDate`, `nfeAuthorizationProtocol`; respostas: `200` ausente; `400` ausente; `404` ausente; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: Alvos explícitos no request: `orderNumber` e `orderErpId`; `carrierErpId` e `clientErpId` são identificadores relacionais.
- pendências específicas: PEND-019
- rastreabilidade da fonte: PDF oficial, página 41; extração vinculada, linhas 2259-2296; módulo Pedidos; operação `PUT /orders/status`.

### OP-042 - `GET /orders/integrated`
- módulo: Pedidos
- método HTTP: GET
- rota: `/orders/integrated`
- finalidade/descrição oficial: Listar pedidos integrados.
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, sem `*`); `limit` (integer, sem `*`); `erpId` (string, sem `*`); `number` (string, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Orders`: ped_data_pagamento, ped_data_entrega, ped_descricao_entrega, ped_modo_entrega, ped_forma_pagamento, ped_data_pedido, ped_numero_pedido, ped_ordem_compra, ped_observacao, ped_nome_comprador, ped_email_enviado, ped_visualizar, orcamento, ped_ipi, ped_st, ped_tabela_precos, ped_email_xml, ped_transp_nome, ped_transp_tel, ped_transp_email, ped_enviar_emails, ped_fotos_produtos, ped_aprovado, ped_data_aprovado, ped_motivo_reprovar, ped_transp_id, ped_telefone_cliente, ped_tipo_frete, ped_tipo_venda, ped_numero_externo, ped_representante_ausente, ped_status, uuid, user_jwt, platform, fk_vendedores, fk_vendedores_aux, created_at, pedido_cliente, verificacao, fk_prepostos, ped_b2c_exportado, crp_desconto_especial, integrated, ped_conceito, tabela_precos, marca, cliente, representante, prazo, transportadora, carrinho_pedido. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query), `erpId` (query), `number` (query); no catálogo de componentes: `Orders`: nenhum campo sem `*`.
- response body de sucesso: `200` Lista de pedidos integrados.; campos do exemplo: `erpId`, `number`, `buyerName`, `deadline`, `observation`, `status`, `type`, `grossValue`, `finalValue`, `paymentCondition`, `term`, `installments`, `priceAdjustment`, `paymentMethod`, `description`, `minimumValue`, `seller`, `name`, `representative`, `agent`, `carrier`, `details`, `orderErpId`, `clientName`, `clientCnpj`, `carrierName`, `carrierCnpj`, `branchCode`, `boxCode`, `boxQuantity`, `packagedQuantity`, `packagedValue`, `packagedDate`, `nfe`, `serie`, `key`, `emissionDate`, `authorizationProtocol`, `authorizationDate`, `items`, `product`, `reference`, `collection`, `color`, `quantity`, `skuCount`, `value`, `skus`, `code`, `size`, `unitPrice`, `total`
- códigos HTTP documentados: `200` Lista de pedidos integrados. | `404` Pedidos não encontrados. | `500` Erro no servidor
- principais respostas de erro: `404` Pedidos não encontrados.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Orders`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `number`, `buyerName`, `deadline`, `observation`, `status`, `type`, `grossValue`, `finalValue`, `paymentCondition`, `term`, `installments`, `priceAdjustment`, `paymentMethod`, `description`, `minimumValue`, `seller`, `name`, `representative`, `agent`, `carrier`, `details`, `orderErpId`, `clientName`, `clientCnpj`, `carrierName`, `carrierCnpj`, `branchCode`, `boxCode`, `boxQuantity`, `packagedQuantity`, `packagedValue`, `packagedDate`, `nfe`, `serie`, `key`, `emissionDate`, `authorizationProtocol`, `authorizationDate`, `items`, `product`, `reference`, `collection`, `color`, `quantity`, `skuCount`, `value`, `skus`, `code`, `size`, `unitPrice`, `total`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, sem `*`) e limit (integer, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: Filtros explícitos: `number` e `erpId`; a fonte não declara equivalência entre eles.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 41-43; extração vinculada, linhas 2298-2343; módulo Pedidos; operação `GET /orders/integrated`.


## Preços

### OP-043 - `POST /prices`
- módulo: Preços
- método HTTP: POST
- rota: `/prices`
- finalidade/descrição oficial: Criar um novo preço vinculado a uma tabela de preço de um SKU
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `price`, `skuCode`, `priceTableErpId`, `skuErpId`, `companyErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Prices`: erpId, price, skuErpId, priceTableErpId, skuCode, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Prices`: nenhum campo sem `*`.
- response body de sucesso: `201` Preço de SKU criado com sucesso; campos do exemplo: `erpId`, `price`, `skuErpId`, `priceTableErpId`, `skuCode`, `companyErpId`
- códigos HTTP documentados: `201` Preço de SKU criado com sucesso | `400` Corpo da requisição inválido | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição inválido; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Prices`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `price`, `skuCode`, `priceTableErpId`, `skuErpId`, `companyErpId`; respostas: `201` presente (objeto), campos: `erpId`, `price`, `skuErpId`, `priceTableErpId`, `skuCode`, `companyErpId`; `400` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `priceTableErpId`, `skuErpId`, `companyErpId`; response 2xx: `erpId`, `skuErpId`, `priceTableErpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 43-44; extração vinculada, linhas 2347-2392; módulo Preços; operação `POST /prices`.

### OP-044 - `PUT /prices`
- módulo: Preços
- método HTTP: PUT
- rota: `/prices`
- finalidade/descrição oficial: Atualizar preço de SKU por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `price`, `skuCode`, `priceTableErpId`, `skuErpId`, `companyErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Prices`: erpId, price, skuErpId, priceTableErpId, skuCode, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Prices`: nenhum campo sem `*`.
- response body de sucesso: `200` Preço de SKU atualizado com sucesso; campos do exemplo: `erpId`, `price`, `skuErpId`, `priceTableErpId`, `skuCode`, `companyErpId`
- códigos HTTP documentados: `200` Preço de SKU atualizado com sucesso | `404` Preço de SKU não encontrado | `500` Erro no servidor
- principais respostas de erro: `404` Preço de SKU não encontrado; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Prices`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `price`, `skuCode`, `priceTableErpId`, `skuErpId`, `companyErpId`; respostas: `200` presente (objeto), campos: `erpId`, `price`, `skuErpId`, `priceTableErpId`, `skuCode`, `companyErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `priceTableErpId`, `skuErpId`, `companyErpId`; response 2xx: `erpId`, `skuErpId`, `priceTableErpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 44-45; extração vinculada, linhas 2394-2453; módulo Preços; operação `PUT /prices`.

### OP-045 - `DELETE /prices/{erpId}`
- módulo: Preços
- método HTTP: DELETE
- rota: `/prices/{erpId}`
- finalidade/descrição oficial: Remover preço de SKU por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Prices`: erpId, price, skuErpId, priceTableErpId, skuCode, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Prices`: nenhum campo sem `*`.
- response body de sucesso: `200` Preço de SKU deletado com sucesso; campos do exemplo: `erpId`, `price`, `skuErpId`, `priceTableErpId`, `skuCode`, `companyErpId`
- códigos HTTP documentados: `200` Preço de SKU deletado com sucesso | `404` Preço de SKU não encontrado | `500` Erro no servidor
- principais respostas de erro: `404` Preço de SKU não encontrado; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Prices`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (objeto), campos: `erpId`, `price`, `skuErpId`, `priceTableErpId`, `skuCode`, `companyErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`; response 2xx: `erpId`, `skuErpId`, `priceTableErpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, página 45; extração vinculada, linhas 2455-2508; módulo Preços; operação `DELETE /prices/{erpId}`.


## Prepostos

### OP-046 - `GET /agents`
- módulo: Prepostos
- método HTTP: GET
- rota: `/agents`
- finalidade/descrição oficial: Lista os vendedores
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, obrigatório `*`); `limit` (integer, obrigatório `*`); `name` (string, sem `*`); `cpf` (string, sem `*`); `email` (string, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `page` (query), `limit` (query); no catálogo de componentes: `Agents`: name, erpId, cpf, email, cellPhone, street, number, complement, neighborhood, city, uf, zipCode, companyErpId, representativesErpId, password. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `name` (query), `cpf` (query), `email` (query); no catálogo de componentes: `Agents`: rg, birthDate, phone.
- response body de sucesso: `200` Lista de vendedores retornada com sucesso; campos do exemplo: `erpId`, `name`, `email`, `cellPhone`, `phone`, `codigo`, `cpf`, `rg`, `representatives`
- códigos HTTP documentados: `200` Lista de vendedores retornada com sucesso | `401` Requisição inválida | `404` Recurso não encontrado
- principais respostas de erro: `401` Requisição inválida; campos do exemplo: `message` | `404` Recurso não encontrado; campos do exemplo: `message` | conflito literal preservado: status `401`, exemplo `message` com texto `400: Parâmetros inválidos` (`PEND-010`)
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Agents`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `name`, `email`, `cellPhone`, `phone`, `codigo`, `cpf`, `rg`, `representatives`; `401` presente (objeto), campos: `message`; `404` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, obrigatório `*`) e limit (integer, obrigatório `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: response 2xx: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-010
- rastreabilidade da fonte: PDF oficial, páginas 45-46; extração vinculada, linhas 2512-2569; módulo Prepostos; operação `GET /agents`.

### OP-047 - `POST /agents`
- módulo: Prepostos
- método HTTP: POST
- rota: `/agents`
- finalidade/descrição oficial: Cria um novo vendedor
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `cpf`, `rg`, `email`, `cellPhone`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`, `companyErpId`, `representativesErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Agents`: name, erpId, cpf, email, cellPhone, street, number, complement, neighborhood, city, uf, zipCode, companyErpId, representativesErpId, password. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Agents`: rg, birthDate, phone.
- response body de sucesso: `200` Operação realizada com sucesso; campos do exemplo: `message`
- códigos HTTP documentados: `200` Operação realizada com sucesso | `401` Requisição inválida | `404` Recurso não encontrado
- principais respostas de erro: `401` Requisição inválida; campos do exemplo: `message` | `404` Recurso não encontrado; campos do exemplo: `message` | conflito literal preservado: status `401`, exemplo `message` com texto `400: Parâmetros inválidos` (`PEND-010`)
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Agents`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `cpf`, `rg`, `email`, `cellPhone`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`, `companyErpId`, `representativesErpId`; respostas: `200` presente (objeto), campos: `message`; `401` presente (objeto), campos: `message`; `404` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `companyErpId`, `representativesErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-010, PEND-018
- rastreabilidade da fonte: PDF oficial, páginas 46-47; extração vinculada, linhas 2571-2616; módulo Prepostos; operação `POST /agents`.

### OP-048 - `PUT /agents`
- módulo: Prepostos
- método HTTP: PUT
- rota: `/agents`
- finalidade/descrição oficial: Atualiza um vendedor existente
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `cpf`, `rg`, `email`, `cellPhone`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`, `companyErpId`, `representativesErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Agents`: name, erpId, cpf, email, cellPhone, street, number, complement, neighborhood, city, uf, zipCode, companyErpId, representativesErpId, password. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Agents`: rg, birthDate, phone.
- response body de sucesso: `200` Operação realizada com sucesso; campos do exemplo: `message`
- códigos HTTP documentados: `200` Operação realizada com sucesso | `401` Requisição inválida | `404` Recurso não encontrado
- principais respostas de erro: `401` Requisição inválida; campos do exemplo: `message` | `404` Recurso não encontrado; campos do exemplo: `message` | conflito literal preservado: status `401`, exemplo `message` com texto `400: Parâmetros inválidos` (`PEND-010`)
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Agents`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `cpf`, `rg`, `email`, `cellPhone`, `street`, `number`, `complement`, `neighborhood`, `city`, `uf`, `zipCode`, `companyErpId`, `representativesErpId`; respostas: `200` presente (objeto), campos: `message`; `401` presente (objeto), campos: `message`; `404` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `companyErpId`, `representativesErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-010, PEND-018
- rastreabilidade da fonte: PDF oficial, páginas 47-48; extração vinculada, linhas 2618-2684; módulo Prepostos; operação `PUT /agents`.

### OP-049 - `DELETE /agents`
- módulo: Prepostos
- método HTTP: DELETE
- rota: `/agents`
- finalidade/descrição oficial: Exclui um vendedor existente
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (integer, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Agents`: name, erpId, cpf, email, cellPhone, street, number, complement, neighborhood, city, uf, zipCode, companyErpId, representativesErpId, password. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Agents`: rg, birthDate, phone.
- response body de sucesso: `200` Operação realizada com sucesso; campos do exemplo: `message`
- códigos HTTP documentados: `200` Operação realizada com sucesso | `401` Requisição inválida | `404` Recurso não encontrado
- principais respostas de erro: `401` Requisição inválida; campos do exemplo: `message` | `404` Recurso não encontrado; campos do exemplo: `message` | conflito literal preservado: status `401`, exemplo `message` com texto `400: Parâmetros inválidos` (`PEND-010`)
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Agents`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (objeto), campos: `message`; `401` presente (objeto), campos: `message`; `404` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-006, PEND-010
- rastreabilidade da fonte: PDF oficial, páginas 48-49; extração vinculada, linhas 2686-2751; módulo Prepostos; operação `DELETE /agents`.


## Produtos

### OP-050 - `GET /products`
- módulo: Produtos
- método HTTP: GET
- rota: `/products`
- finalidade/descrição oficial: Listar todos os produtos
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (number, sem `*`); `limit` (number, sem `*`); `name` (NAO_DOCUMENTADO, sem `*`); `reference` (NAO_DOCUMENTADO, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Product`: erpId, name, reference, branchErpId, promptDelivery, brandErpId, openGrid, ipi, isDiscontinued, isLaunch, genderErpId, categoryErpId, productColors. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query), `name` (query), `reference` (query); no catálogo de componentes: `Product`: description, deadlineErpId, compositionData, technicalInformation, isVisibleB2B, isVisibleForca, colection, st, subcategoryErpId.
- response body de sucesso: `200` Lista de produtos; campos do exemplo: `erpId`, `companyErpId`, `name`, `reference`, `branchErpId`, `promptDelivery`, `description`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `createdAt`, `updatedAt`, `deletedAt`, `compositionData`, `technicalInformation`, `openGrid`, `ipi`, `isDiscontinued`, `isLaunch`, `isVisibleB2B`, `isVisibleForca`, `colection`, `st`, `productColors`, `colorErpId`
- códigos HTTP documentados: `200` Lista de produtos | `404` Produtos não encontrados | `500` Erro no servidor
- principais respostas de erro: `404` Produtos não encontrados; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Product`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `companyErpId`, `name`, `reference`, `branchErpId`, `promptDelivery`, `description`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `createdAt`, `updatedAt`, `deletedAt`, `compositionData`, `technicalInformation`, `openGrid`, `ipi`, `isDiscontinued`, `isLaunch`, `isVisibleB2B`, `isVisibleForca`, `colection`, `st`, `productColors`, `colorErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (number, sem `*`) e limit (number, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: query: `reference`; response 2xx: `erpId`, `companyErpId`, `reference`, `branchErpId`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `colorErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 49-50; extração vinculada, linhas 2755-2798; módulo Produtos; operação `GET /products`.

### OP-051 - `POST /products`
- módulo: Produtos
- método HTTP: POST
- rota: `/products`
- finalidade/descrição oficial: Criar um produto
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `companyErpId`, `name`, `reference`, `branchErpId`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `productSubcategoryErpId`, `promptDelivery`, `description`, `compositionData`, `technicalInformation`, `openGrid`, `ipi`, `isDiscontinued`, `isLaunch`, `isVisibleB2B`, `isVisibleForca`, `colection`, `st`, `campaignErpId`, `lineErpId`, `productColors`, `colorErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Product`: erpId, name, reference, branchErpId, promptDelivery, brandErpId, openGrid, ipi, isDiscontinued, isLaunch, genderErpId, categoryErpId, productColors. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Product`: description, deadlineErpId, compositionData, technicalInformation, isVisibleB2B, isVisibleForca, colection, st, subcategoryErpId.
- response body de sucesso: `201` Produto criado com sucesso; campos do exemplo: `erpId`, `companyErpId`, `name`, `reference`, `branchErpId`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `productSubcategoryErpId`, `promptDelivery`, `description`, `compositionData`, `technicalInformation`, `openGrid`, `ipi`, `isDiscontinued`, `isLaunch`, `isVisibleB2B`, `isVisibleForca`, `colection`, `st`, `campaignErpId`, `lineErpId`, `productColors`, `colorErpId`
- códigos HTTP documentados: `201` Produto criado com sucesso | `400` Corpo da requisição vazio ou inválido | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição vazio ou inválido; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Product`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `companyErpId`, `name`, `reference`, `branchErpId`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `productSubcategoryErpId`, `promptDelivery`, `description`, `compositionData`, `technicalInformation`, `openGrid`, `ipi`, `isDiscontinued`, `isLaunch`, `isVisibleB2B`, `isVisibleForca`, `colection`, `st`, `campaignErpId`, `lineErpId`, `productColors`, `colorErpId`; respostas: `201` presente (objeto), campos: `erpId`, `companyErpId`, `name`, `reference`, `branchErpId`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `productSubcategoryErpId`, `promptDelivery`, `description`, `compositionData`, `technicalInformation`, `openGrid`, `ipi`, `isDiscontinued`, `isLaunch`, `isVisibleB2B`, `isVisibleForca`, `colection`, `st`, `campaignErpId`, `lineErpId`, `productColors`, `colorErpId`; `400` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `companyErpId`, `reference`, `branchErpId`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `productSubcategoryErpId`, `campaignErpId`, `lineErpId`, `colorErpId`; response 2xx: `erpId`, `companyErpId`, `reference`, `branchErpId`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `productSubcategoryErpId`, `campaignErpId`, `lineErpId`, `colorErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-005, PEND-014
- rastreabilidade da fonte: PDF oficial, páginas 50-51; extração vinculada, linhas 2800-2858; módulo Produtos; operação `POST /products`.

### OP-052 - `PUT /products`
- módulo: Produtos
- método HTTP: PUT
- rota: `/products`
- finalidade/descrição oficial: Atualizar produto por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `reference`, `branchErpId`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `productSubcategoryErpId`, `promptDelivery`, `description`, `compositionData`, `technicalInformation`, `openGrid`, `ipi`, `isDiscontinued`, `isLaunch`, `isVisible`, `colection`, `campaignErpId`, `lineErpId`, `st`, `productColors`, `colorErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Product`: erpId, name, reference, branchErpId, promptDelivery, brandErpId, openGrid, ipi, isDiscontinued, isLaunch, genderErpId, categoryErpId, productColors. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Product`: description, deadlineErpId, compositionData, technicalInformation, isVisibleB2B, isVisibleForca, colection, st, subcategoryErpId.
- response body de sucesso: `200` Produto atualizado com sucesso; campos do exemplo: `erpId`, `companyErpId`, `name`, `reference`, `branchErpId`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `productSubcategoryErpId`, `promptDelivery`, `description`, `compositionData`, `technicalInformation`, `openGrid`, `ipi`, `isDiscontinued`, `isLaunch`, `isVisible`, `colection`, `st`, `productColors`, `colorErpId`
- códigos HTTP documentados: `200` Produto atualizado com sucesso | `404` Produto não encontrado | `500` Erro no servidor
- principais respostas de erro: `404` Produto não encontrado; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Product`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `reference`, `branchErpId`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `productSubcategoryErpId`, `promptDelivery`, `description`, `compositionData`, `technicalInformation`, `openGrid`, `ipi`, `isDiscontinued`, `isLaunch`, `isVisible`, `colection`, `campaignErpId`, `lineErpId`, `st`, `productColors`, `colorErpId`; respostas: `200` presente (objeto), campos: `erpId`, `companyErpId`, `name`, `reference`, `branchErpId`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `productSubcategoryErpId`, `promptDelivery`, `description`, `compositionData`, `technicalInformation`, `openGrid`, `ipi`, `isDiscontinued`, `isLaunch`, `isVisible`, `colection`, `st`, `productColors`, `colorErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `reference`, `branchErpId`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `productSubcategoryErpId`, `campaignErpId`, `lineErpId`, `colorErpId`; response 2xx: `erpId`, `companyErpId`, `reference`, `branchErpId`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `productSubcategoryErpId`, `colorErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-005, PEND-011, PEND-014
- rastreabilidade da fonte: PDF oficial, páginas 51-52; extração vinculada, linhas 2860-2901; módulo Produtos; operação `PUT /products`.

### OP-053 - `GET /products/{erpId}`
- módulo: Produtos
- método HTTP: GET
- rota: `/products/{erpId}`
- finalidade/descrição oficial: Buscar produto por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Product`: erpId, name, reference, branchErpId, promptDelivery, brandErpId, openGrid, ipi, isDiscontinued, isLaunch, genderErpId, categoryErpId, productColors. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Product`: description, deadlineErpId, compositionData, technicalInformation, isVisibleB2B, isVisibleForca, colection, st, subcategoryErpId.
- response body de sucesso: `200` Produto encontrado; campos do exemplo: `erpId`, `name`, `reference`, `branchErpId`, `productPromptDelivery`, `description`, `compositionData`, `technicalInformation`, `productOpenGrid`, `ipi`, `productIsDiscontinued`, `productIsLaunch`, `productIsVisibleB2B`, `productIsVisibleForca`, `colection`, `st`, `genderErpId`, `categoryErpId`, `subcategoryErpId`, `campaignErpId`, `lineErpId`, `companyErpId`, `productColors`, `colorErpId`
- códigos HTTP documentados: `200` Produto encontrado | `404` Produto não encontrado | `500` Erro no servidor
- principais respostas de erro: `404` Produto não encontrado; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Product`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (objeto), campos: `erpId`, `name`, `reference`, `branchErpId`, `productPromptDelivery`, `description`, `compositionData`, `technicalInformation`, `productOpenGrid`, `ipi`, `productIsDiscontinued`, `productIsLaunch`, `productIsVisibleB2B`, `productIsVisibleForca`, `colection`, `st`, `genderErpId`, `categoryErpId`, `subcategoryErpId`, `campaignErpId`, `lineErpId`, `companyErpId`, `productColors`, `colorErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`; response 2xx: `erpId`, `reference`, `branchErpId`, `genderErpId`, `categoryErpId`, `subcategoryErpId`, `campaignErpId`, `lineErpId`, `companyErpId`, `colorErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-005, PEND-014
- rastreabilidade da fonte: PDF oficial, páginas 52-53; extração vinculada, linhas 2907-2928; módulo Produtos; operação `GET /products/{erpId}`.

### OP-054 - `PATCH /products/visible`
- módulo: Produtos
- método HTTP: PATCH
- rota: `/products/visible`
- finalidade/descrição oficial: Atualizar visibilidade de produtos no B2B e no Força de vendas
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `productErpId`, `isVisibleB2B`, `isVisibleForca`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `ProductsVisibility`: productErpId, isVisibleB2B, isVisibleForca. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `ProductsVisibility`: nenhum campo sem `*`.
- response body de sucesso: `200` Produto atualizado com sucesso; body/exemplo: NAO_DOCUMENTADO
- códigos HTTP documentados: `200` Produto atualizado com sucesso | `404` Produto não encontrado | `500` Erro no servidor
- principais respostas de erro: `404` Produto não encontrado; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `ProductsVisibility`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (array), campos: `productErpId`, `isVisibleB2B`, `isVisibleForca`; respostas: `200` ausente; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: Identificador no request: `productErpId`; não existe `erpId` genérico nesta operação.
- pendências específicas: PEND-011
- rastreabilidade da fonte: PDF oficial, páginas 53-54; extração vinculada, linhas 2930-2969; módulo Produtos; operação `PATCH /products/visible`.


## Prazos de entregas

### OP-055 - `GET /deadlines`
- módulo: Prazos de entregas
- método HTTP: GET
- rota: `/deadlines`
- finalidade/descrição oficial: Listar todos os prazos de entrega
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, sem `*`); `limit` (integer, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Deadlines`: erpId, name, initial, final, type, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query); no catálogo de componentes: `Deadlines`: nenhum campo sem `*`.
- response body de sucesso: `200` Lista de prazos de entrega; campos do exemplo: `erpId`, `name`, `initial`, `final`, `companyErpId`, `type`
- códigos HTTP documentados: `200` Lista de prazos de entrega | `404` Prazos de entrega não encontrados | `500` Erro no servidor
- principais respostas de erro: `404` Prazos de entrega não encontrados; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Deadlines`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `name`, `initial`, `final`, `companyErpId`, `type`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, sem `*`) e limit (integer, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 54-55; extração vinculada, linhas 2973-3027; módulo Prazos de entregas; operação `GET /deadlines`.

### OP-056 - `POST /deadlines`
- módulo: Prazos de entregas
- método HTTP: POST
- rota: `/deadlines`
- finalidade/descrição oficial: Criar um prazo de entrega
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `initial`, `final`, `companyErpId`, `type`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Deadlines`: erpId, name, initial, final, type, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Deadlines`: nenhum campo sem `*`.
- response body de sucesso: `201` Prazo de entrega criado com sucesso; campos do exemplo: `erpId`, `name`, `initial`, `final`, `companyErpId`, `type`
- códigos HTTP documentados: `201` Prazo de entrega criado com sucesso | `400` Corpo da requisição vazio ou inválido | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição vazio ou inválido; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Deadlines`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `initial`, `final`, `companyErpId`, `type`; respostas: `201` presente (objeto), campos: `erpId`, `name`, `initial`, `final`, `companyErpId`, `type`; `400` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `companyErpId`; response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, página 55; extração vinculada, linhas 3029-3087; módulo Prazos de entregas; operação `POST /deadlines`.

### OP-057 - `PUT /deadlines`
- módulo: Prazos de entregas
- método HTTP: PUT
- rota: `/deadlines`
- finalidade/descrição oficial: Atualizar prazo de entrega por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `initial`, `final`, `type`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Deadlines`: erpId, name, initial, final, type, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Deadlines`: nenhum campo sem `*`.
- response body de sucesso: `200` Prazo de entrega atualizado com sucesso; campos do exemplo: `erpId`, `name`, `initial`, `final`, `companyErpId`, `type`
- códigos HTTP documentados: `200` Prazo de entrega atualizado com sucesso | `404` Prazo de entrega não encontrado | `500` Erro no servidor
- principais respostas de erro: `404` Prazo de entrega não encontrado; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Deadlines`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `initial`, `final`, `type`; respostas: `200` presente (objeto), campos: `erpId`, `name`, `initial`, `final`, `companyErpId`, `type`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`; response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-018
- rastreabilidade da fonte: PDF oficial, páginas 55-56; extração vinculada, linhas 3089-3136; módulo Prazos de entregas; operação `PUT /deadlines`.

### OP-058 - `DELETE /deadlines/{erpId}`
- módulo: Prazos de entregas
- método HTTP: DELETE
- rota: `/deadlines/{erpId}`
- finalidade/descrição oficial: Remover prazo de entrega por erp_id
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Deadlines`: erpId, name, initial, final, type, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Deadlines`: nenhum campo sem `*`.
- response body de sucesso: `200` Prazo de entrega deletado com sucesso; campos do exemplo: `erpId`, `name`, `initial`, `final`, `companyErpId`, `type`
- códigos HTTP documentados: `200` Prazo de entrega deletado com sucesso | `404` Prazo de entrega não encontrado | `500` Erro no servidor
- principais respostas de erro: `404` Prazo de entrega não encontrado; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Deadlines`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (objeto), campos: `erpId`, `name`, `initial`, `final`, `companyErpId`, `type`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`; response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 56-57; extração vinculada, linhas 3138-3178; módulo Prazos de entregas; operação `DELETE /deadlines/{erpId}`.


## Regiões

### OP-059 - `GET /regions`
- módulo: Regiões
- método HTTP: GET
- rota: `/regions`
- finalidade/descrição oficial: Listar todas as regiões
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (number, sem `*`); `limit` (number, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Regions`: nenhum campo com `*`. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query); no catálogo de componentes: `Regions`: erpId, name, color, statesCodes, cityNames, companyErpId, priceTablesErpId.
- response body de sucesso: `200` Lista de regiões; campos do exemplo: `erpId`, `name`, `color`, `statesCodes`, `cityNames`, `companyErpId`, `priceTableErpId`
- códigos HTTP documentados: `200` Lista de regiões | `404` Regiões não encontradas | `500` Erro no servidor
- principais respostas de erro: `404` Regiões não encontradas; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Regions`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `name`, `color`, `statesCodes`, `cityNames`, `companyErpId`, `priceTableErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (number, sem `*`) e limit (number, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: response 2xx: `erpId`, `companyErpId`, `priceTableErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-005
- rastreabilidade da fonte: PDF oficial, páginas 57-58; extração vinculada, linhas 3182-3238; módulo Regiões; operação `GET /regions`.

### OP-060 - `POST /regions`
- módulo: Regiões
- método HTTP: POST
- rota: `/regions`
- finalidade/descrição oficial: Criar uma região
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `color`, `statesCodes`, `cityNames`, `companyErpId`, `priceTablesErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Regions`: nenhum campo com `*`. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Regions`: erpId, name, color, statesCodes, cityNames, companyErpId, priceTablesErpId.
- response body de sucesso: `201` Região criada com sucesso; campos do exemplo: `erpId`, `name`, `color`, `statesCodes`, `cityNames`, `companyErpId`, `priceTableErpId`
- códigos HTTP documentados: `201` Região criada com sucesso | `400` Corpo da requisição inválido | `404` Tabela de preço não encontrada | `409` ERP ID já cadastrado | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição inválido; campos do exemplo: `message` | `404` Tabela de preço não encontrada; campos do exemplo: `message` | `409` ERP ID já cadastrado; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Regions`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `color`, `statesCodes`, `cityNames`, `companyErpId`, `priceTablesErpId`; respostas: `201` presente (objeto), campos: `erpId`, `name`, `color`, `statesCodes`, `cityNames`, `companyErpId`, `priceTableErpId`; `400` presente (objeto), campos: `message`; `404` presente (objeto), campos: `message`; `409` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `companyErpId`, `priceTablesErpId`; response 2xx: `erpId`, `companyErpId`, `priceTableErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-005
- rastreabilidade da fonte: PDF oficial, páginas 58-59; extração vinculada, linhas 3240-3302; módulo Regiões; operação `POST /regions`.

### OP-061 - `PUT /regions`
- módulo: Regiões
- método HTTP: PUT
- rota: `/regions`
- finalidade/descrição oficial: Atualizar uma região
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `name`, `color`, `statesCodes`, `cityNames`
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Regions`: nenhum campo com `*`. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Regions`: erpId, name, color, statesCodes, cityNames, companyErpId, priceTablesErpId.
- response body de sucesso: `200` Região atualizada com sucesso; campos do exemplo: `erpId`, `name`, `color`, `statesCodes`, `cityNames`, `companyErpId`, `priceTableErpId`
- códigos HTTP documentados: `200` Região atualizada com sucesso | `404` Região não encontrada | `500` Erro no servidor
- principais respostas de erro: `404` Região não encontrada; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Regions`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `name`, `color`, `statesCodes`, `cityNames`; respostas: `200` presente (objeto), campos: `erpId`, `name`, `color`, `statesCodes`, `cityNames`, `companyErpId`, `priceTableErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`; response 2xx: `erpId`, `companyErpId`, `priceTableErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-005, PEND-006
- rastreabilidade da fonte: PDF oficial, página 59; extração vinculada, linhas 3304-3366; módulo Regiões; operação `PUT /regions`.

### OP-062 - `GET /regions/{erpId}`
- módulo: Regiões
- método HTTP: GET
- rota: `/regions/{erpId}`
- finalidade/descrição oficial: Buscar região por ERP ID
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Regions`: nenhum campo com `*`. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Regions`: erpId, name, color, statesCodes, cityNames, companyErpId, priceTablesErpId.
- response body de sucesso: `200` Região encontrada; campos do exemplo: `erpId`, `name`, `color`, `statesCodes`, `cityNames`, `companyErpId`, `priceTableErpId`
- códigos HTTP documentados: `200` Região encontrada | `404` Região não encontrada | `500` Erro no servidor
- principais respostas de erro: `404` Região não encontrada; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Regions`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (objeto), campos: `erpId`, `name`, `color`, `statesCodes`, `cityNames`, `companyErpId`, `priceTableErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`; response 2xx: `erpId`, `companyErpId`, `priceTableErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 59-60; extração vinculada, linhas 3368-3407; módulo Regiões; operação `GET /regions/{erpId}`.

### OP-063 - `DELETE /regions/{erpId}`
- módulo: Regiões
- método HTTP: DELETE
- rota: `/regions/{erpId}`
- finalidade/descrição oficial: Excluir uma região permanentemente
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Regions`: nenhum campo com `*`. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Regions`: erpId, name, color, statesCodes, cityNames, companyErpId, priceTablesErpId.
- response body de sucesso: `200` Região excluída com sucesso; campos do exemplo: `erpId`, `name`, `color`, `statesCodes`, `cityNames`
- códigos HTTP documentados: `200` Região excluída com sucesso | `404` Região não encontrada | `500` Erro no servidor
- principais respostas de erro: `404` Região não encontrada; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Regions`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (objeto), campos: `erpId`, `name`, `color`, `statesCodes`, `cityNames`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`; response 2xx: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 60-61; extração vinculada, linhas 3409-3457; módulo Regiões; operação `DELETE /regions/{erpId}`.


## Representantes

### OP-064 - `GET /representatives`
- módulo: Representantes
- método HTTP: GET
- rota: `/representatives`
- finalidade/descrição oficial: Lista todos os representantes com paginação e filtros.
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, sem `*`); `limit` (integer, sem `*`); `cpf` (string, sem `*`); `cnpj` (string, sem `*`); `name` (string, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Representatives`: name, cpf, email, cellPhone, erpId, companyErpId, address. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query), `cpf` (query), `cnpj` (query), `name` (query); no catálogo de componentes: `Representatives`: rg, type, birthDate, phone.
- response body de sucesso: `200` Lista de representantes retornada com sucesso.; campos do exemplo: `erpId`, `name`, `cpf`, `cnpj`, `corporateName`, `stateRegistration`, `active`, `cellPhone`, `phone`, `email`, `rg`, `type`, `representativesClients`
- códigos HTTP documentados: `200` Lista de representantes retornada com sucesso. | `400` Requisição inválida | `500` Erro no servidor
- principais respostas de erro: `400` Requisição inválida; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Representatives`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `name`, `cpf`, `cnpj`, `corporateName`, `stateRegistration`, `active`, `cellPhone`, `phone`, `email`, `rg`, `type`, `representativesClients`; `400` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, sem `*`) e limit (integer, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: response 2xx: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 61-62; extração vinculada, linhas 3461-3510; módulo Representantes; operação `GET /representatives`.

### OP-065 - `POST /representatives`
- módulo: Representantes
- método HTTP: POST
- rota: `/representatives`
- finalidade/descrição oficial: Cria um representante.
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `name`, `cpf`, `rg`, `email`, `phone`, `cellPhone`, `erpId`, `companyErpId`, `type`, `cnpj`, `stateRegistration`, `corporateName`, `internal`, `address`, `street`, `number`, `complement`, `neighborhood`, `city`, `zipCode`, `uf`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Representatives`: name, cpf, email, cellPhone, erpId, companyErpId, address. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Representatives`: rg, type, birthDate, phone.
- response body de sucesso: `201` Operação realizada com sucesso; campos do exemplo: `message`
- códigos HTTP documentados: `201` Operação realizada com sucesso | `400` Requisição inválida | `409` Representante ou usuário já cadastrado. | `500` Erro no servidor
- principais respostas de erro: `400` Requisição inválida; campos do exemplo: `message` | `409` Representante ou usuário já cadastrado.; body/exemplo: NAO_DOCUMENTADO | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Representatives`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `name`, `cpf`, `rg`, `email`, `phone`, `cellPhone`, `erpId`, `companyErpId`, `type`, `cnpj`, `stateRegistration`, `corporateName`, `internal`, `address`, `street`, `number`, `complement`, `neighborhood`, `city`, `zipCode`, `uf`; respostas: `201` presente (objeto), campos: `message`; `400` presente (objeto), campos: `message`; `409` ausente; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 62-63; extração vinculada, linhas 3516-3572; módulo Representantes; operação `POST /representatives`.

### OP-066 - `PUT /representatives`
- módulo: Representantes
- método HTTP: PUT
- rota: `/representatives`
- finalidade/descrição oficial: Atualiza um representante pelo ERP ID.
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `rg`, `email`, `phone`, `cellPhone`, `cnpj`, `stateRegistration`, `corporateName`, `type`, `internal`, `address`, `street`, `number`, `complement`, `neighborhood`, `city`, `zipCode`, `uf`
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Representatives`: name, cpf, email, cellPhone, erpId, companyErpId, address. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Representatives`: rg, type, birthDate, phone.
- response body de sucesso: `200` Representante atualizado com sucesso.; campos do exemplo: `id`, `erpId`, `name`, `rg`, `email`, `phone`, `cellPhone`, `type`, `stateRegistration`, `internal`
- códigos HTTP documentados: `200` Representante atualizado com sucesso. | `400` Requisição inválida | `404` Representante não encontrado | `409` Já existe um representante com o CNPJ informado. | `500` Erro no servidor
- principais respostas de erro: `400` Requisição inválida; campos do exemplo: `message` | `404` Representante não encontrado; campos do exemplo: `message`, `statusCode` | `409` Já existe um representante com o CNPJ informado.; campos do exemplo: `message`, `statusCode` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Representatives`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `rg`, `email`, `phone`, `cellPhone`, `cnpj`, `stateRegistration`, `corporateName`, `type`, `internal`, `address`, `street`, `number`, `complement`, `neighborhood`, `city`, `zipCode`, `uf`; respostas: `200` presente (objeto), campos: `id`, `erpId`, `name`, `rg`, `email`, `phone`, `cellPhone`, `type`, `stateRegistration`, `internal`; `400` presente (objeto), campos: `message`; `404` presente (objeto), campos: `message`, `statusCode`; `409` presente (objeto), campos: `message`, `statusCode`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`; request: `erpId`; response 2xx: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-006, PEND-018
- rastreabilidade da fonte: PDF oficial, páginas 63-64; extração vinculada, linhas 3574-3636; módulo Representantes; operação `PUT /representatives`.

### OP-067 - `DELETE /representatives`
- módulo: Representantes
- método HTTP: DELETE
- rota: `/representatives`
- finalidade/descrição oficial: Exclui um representante pelo ERP ID.
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Representatives`: name, cpf, email, cellPhone, erpId, companyErpId, address. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Representatives`: rg, type, birthDate, phone.
- response body de sucesso: `200` Operação realizada com sucesso; campos do exemplo: `message`
- códigos HTTP documentados: `200` Operação realizada com sucesso | `401` Requisição inválida | `404` Recurso não encontrado
- principais respostas de erro: `401` Requisição inválida; campos do exemplo: `message` | `404` Recurso não encontrado; campos do exemplo: `message` | conflito literal preservado: status `401`, exemplo `message` com texto `400: Parâmetros inválidos` (`PEND-010`)
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Representatives`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (objeto), campos: `message`; `401` presente (objeto), campos: `message`; `404` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-006, PEND-010
- rastreabilidade da fonte: PDF oficial, página 64; extração vinculada, linhas 3638-3697; módulo Representantes; operação `DELETE /representatives`.

### OP-068 - `PATCH /representatives/clients`
- módulo: Representantes
- método HTTP: PATCH
- rota: `/representatives/clients`
- finalidade/descrição oficial: Vincula clientes a representantes.
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `clientErpId`, `representativeErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Representatives`: name, cpf, email, cellPhone, erpId, companyErpId, address. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Representatives`: rg, type, birthDate, phone.
- response body de sucesso: `201` Clientes vinculados com sucesso.; campos do exemplo: `created`, `ignored`
- códigos HTTP documentados: `201` Clientes vinculados com sucesso. | `400` Requisição inválida | `404` Cliente ou representante não encontrado. | `500` Erro no servidor
- principais respostas de erro: `400` Requisição inválida; campos do exemplo: `message` | `404` Cliente ou representante não encontrado.; campos do exemplo: `message`, `statusCode` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Representatives`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (array), campos: `clientErpId`, `representativeErpId`; respostas: `201` presente (objeto), campos: `created`, `ignored`; `400` presente (objeto), campos: `message`; `404` presente (objeto), campos: `message`, `statusCode`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: Identificadores do vínculo: `clientErpId` e `representativeErpId`; não existe `erpId` genérico.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, página 65; extração vinculada, linhas 3703-3778; módulo Representantes; operação `PATCH /representatives/clients`.


## Skus

### OP-069 - `GET /skus`
- módulo: Skus
- método HTTP: GET
- rota: `/skus`
- finalidade/descrição oficial: Listar todos os SKUs
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, sem `*`); `limit` (integer, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Sku`: size, stockB2B, stockForca, price, code, multipleQuantity, erpId, variantErpId, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query); no catálogo de componentes: `Sku`: minQuantity, cest, height, length, ncm, weight, width.
- response body de sucesso: `200` Lista de SKUs; campos do exemplo: `erpId`, `size`, `stockB2B`, `stockForca`, `price`, `code`, `minQuantity`, `multipleQuantity`, `variantErpId`, `cest`, `height`, `length`, `ncm`, `weight`, `width`, `companyErpId`
- códigos HTTP documentados: `200` Lista de SKUs | `404` SKUs não encontrados | `500` Erro no servidor
- principais respostas de erro: `404` SKUs não encontrados; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Sku`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `size`, `stockB2B`, `stockForca`, `price`, `code`, `minQuantity`, `multipleQuantity`, `variantErpId`, `cest`, `height`, `length`, `ncm`, `weight`, `width`, `companyErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, sem `*`) e limit (integer, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: response 2xx: `erpId`, `code`, `variantErpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 65-66; extração vinculada, linhas 3782-3838; módulo Skus; operação `GET /skus`.

### OP-070 - `POST /skus`
- módulo: Skus
- método HTTP: POST
- rota: `/skus`
- finalidade/descrição oficial: Criar um Sku
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `size`, `stockB2B`, `stockForca`, `price`, `code`, `minQuantity`, `multipleQuantity`, `variantErpId`, `cest`, `height`, `length`, `ncm`, `weight`, `companyErpId`, `width`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Sku`: size, stockB2B, stockForca, price, code, multipleQuantity, erpId, variantErpId, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Sku`: minQuantity, cest, height, length, ncm, weight, width.
- response body de sucesso: `200` Sku criado com sucesso.; campos do exemplo: `message`, `created`, `erpId`, `size`, `stockB2B`, `stockForca`, `price`, `code`, `minQuantity`, `multipleQuantity`, `variantErpId`, `cest`, `height`, `length`, `ncm`, `weight`, `companyErpId`, `width`
- códigos HTTP documentados: `200` Sku criado com sucesso. | `400` Corpo da requisição vazio ou inválido. | `409` Sku já existente. | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição vazio ou inválido.; campos do exemplo: `message` | `409` Sku já existente.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Sku`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `size`, `stockB2B`, `stockForca`, `price`, `code`, `minQuantity`, `multipleQuantity`, `variantErpId`, `cest`, `height`, `length`, `ncm`, `weight`, `companyErpId`, `width`; respostas: `200` presente (objeto), campos: `message`, `created`, `erpId`, `size`, `stockB2B`, `stockForca`, `price`, `code`, `minQuantity`, `multipleQuantity`, `variantErpId`, `cest`, `height`, `length`, `ncm`, `weight`, `companyErpId`, `width`; `400` presente (objeto), campos: `message`; `409` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `code`, `variantErpId`, `companyErpId`; response 2xx: `erpId`, `code`, `variantErpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 66-67; extração vinculada, linhas 3840-3888; módulo Skus; operação `POST /skus`.

### OP-071 - `PUT /skus`
- módulo: Skus
- método HTTP: PUT
- rota: `/skus`
- finalidade/descrição oficial: Atualizar Sku por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `size`, `stockB2B`, `stockForca`, `price`, `code`, `minQuantity`, `multipleQuantity`, `variantErpId`, `cest`, `height`, `length`, `ncm`, `weight`, `width`
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Sku`: size, stockB2B, stockForca, price, code, multipleQuantity, erpId, variantErpId, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Sku`: minQuantity, cest, height, length, ncm, weight, width.
- response body de sucesso: `200` Sku atualizado com sucesso!; campos do exemplo: `message`, `updated`, `erpId`, `size`, `stock`, `price`, `code`, `minQuantity`, `multipleQuantity`, `variantErpId`, `cest`, `height`, `length`, `ncm`, `weight`, `companyErpId`, `width`
- códigos HTTP documentados: `200` Sku atualizado com sucesso! | `404` Sku não encontrado. | `500` Erro no servidor
- principais respostas de erro: `404` Sku não encontrado.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Sku`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `size`, `stockB2B`, `stockForca`, `price`, `code`, `minQuantity`, `multipleQuantity`, `variantErpId`, `cest`, `height`, `length`, `ncm`, `weight`, `width`; respostas: `200` presente (objeto), campos: `message`, `updated`, `erpId`, `size`, `stock`, `price`, `code`, `minQuantity`, `multipleQuantity`, `variantErpId`, `cest`, `height`, `length`, `ncm`, `weight`, `companyErpId`, `width`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`; request: `erpId`, `code`, `variantErpId`; response 2xx: `erpId`, `code`, `variantErpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-006, PEND-018
- rastreabilidade da fonte: PDF oficial, páginas 67-68; extração vinculada, linhas 3890-3939; módulo Skus; operação `PUT /skus`.

### OP-072 - `GET /skus/{erpId}`
- módulo: Skus
- método HTTP: GET
- rota: `/skus/{erpId}`
- finalidade/descrição oficial: Buscar sku por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Sku`: size, stockB2B, stockForca, price, code, multipleQuantity, erpId, variantErpId, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Sku`: minQuantity, cest, height, length, ncm, weight, width.
- response body de sucesso: `200` Sku retornado com sucesso; campos do exemplo: `erpId`, `size`, `stockB2B`, `stockForca`, `price`, `code`, `minQuantity`, `multipleQuantity`, `variantErpId`, `cest`, `height`, `length`, `ncm`, `weight`, `width`, `companyErpId`
- códigos HTTP documentados: `200` Sku retornado com sucesso | `404` Sku não encontrado. | `500` Erro no servidor
- principais respostas de erro: `404` Sku não encontrado.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Sku`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (objeto), campos: `erpId`, `size`, `stockB2B`, `stockForca`, `price`, `code`, `minQuantity`, `multipleQuantity`, `variantErpId`, `cest`, `height`, `length`, `ncm`, `weight`, `width`, `companyErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`; response 2xx: `erpId`, `code`, `variantErpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 68-69; extração vinculada, linhas 3941-3983; módulo Skus; operação `GET /skus/{erpId}`.

### OP-073 - `PATCH /skus/stock`
- módulo: Skus
- método HTTP: PATCH
- rota: `/skus/stock`
- finalidade/descrição oficial: Atualizar estoque de sku (peça)
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `stockB2B`, `stockForca`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Sku`: size, stockB2B, stockForca, price, code, multipleQuantity, erpId, variantErpId, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Sku`: minQuantity, cest, height, length, ncm, weight, width.
- response body de sucesso: `200` Estoque atualizado com sucesso!; campos do exemplo: `message`
- códigos HTTP documentados: `200` Estoque atualizado com sucesso! | `404` ERP_ID não encontrado. | `500` Erro no servidor
- principais respostas de erro: `404` ERP_ID não encontrado.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Sku`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (array), campos: `erpId`, `stockB2B`, `stockForca`; respostas: `200` presente (objeto), campos: `message`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 69-70; extração vinculada, linhas 3987-4023; módulo Skus; operação `PATCH /skus/stock`.

### OP-074 - `PATCH /skus/grid`
- módulo: Skus
- método HTTP: PATCH
- rota: `/skus/grid`
- finalidade/descrição oficial: Atualizar grade de múltiplas quantidades por SKU Atualiza a quantidade múltipla de SKUs com base em referência do produto e tamanho.
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `reference`, `grid`, `value`, `quantity`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Sku`: size, stockB2B, stockForca, price, code, multipleQuantity, erpId, variantErpId, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Sku`: minQuantity, cest, height, length, ncm, weight, width.
- response body de sucesso: `200` Grades atualizadas com sucesso.; campos do exemplo: `skuErpId`, `newValue`, `newQuantity`, `reference`, `size`, `message`
- códigos HTTP documentados: `200` Grades atualizadas com sucesso. | `500` Erro no servidor
- principais respostas de erro: `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Sku`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (array), campos: `reference`, `grid`, `value`, `quantity`; respostas: `200` presente (array), campos: `skuErpId`, `newValue`, `newQuantity`, `reference`, `size`, `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: Identificador do request: `reference`; `skuErpId` aparece apenas na resposta. Grade, valor e quantidade são dados, não chaves.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 70-71; extração vinculada, linhas 4025-4065; módulo Skus; operação `PATCH /skus/grid`.


## Subcategorias

### OP-075 - `GET /subcategories`
- módulo: Subcategorias
- método HTTP: GET
- rota: `/subcategories`
- finalidade/descrição oficial: Listar todas as subcategorias
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, sem `*`); `limit` (integer, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Subcategories`: erpId, name, categoryErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query); no catálogo de componentes: `Subcategories`: companyErpId.
- response body de sucesso: `200` Lista de subcategorias; campos do exemplo: `erpId`, `name`, `categoryErpId`
- códigos HTTP documentados: `200` Lista de subcategorias | `404` Subcategorias não encontradas | `500` Erro no servidor
- principais respostas de erro: `404` Subcategorias não encontradas; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Subcategories`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `name`, `categoryErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, sem `*`) e limit (integer, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: response 2xx: `erpId`, `categoryErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 71-72; extração vinculada, linhas 4073-4122; módulo Subcategorias; operação `GET /subcategories`.

### OP-076 - `POST /subcategories`
- módulo: Subcategorias
- método HTTP: POST
- rota: `/subcategories`
- finalidade/descrição oficial: Criar uma subcategoria
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `categoryErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Subcategories`: erpId, name, categoryErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Subcategories`: companyErpId.
- response body de sucesso: NAO_DOCUMENTADO
- códigos HTTP documentados: `400` Corpo da requisição vazio ou inválido. | `409` Subcategoria já existente. | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição vazio ou inválido.; campos do exemplo: `message` | `409` Subcategoria já existente.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Subcategories`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `categoryErpId`; respostas: 2xx ausente na fonte; `400` presente (objeto), campos: `message`; `409` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `categoryErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-013
- rastreabilidade da fonte: PDF oficial, página 72; extração vinculada, linhas 4128-4184; módulo Subcategorias; operação `POST /subcategories`.

### OP-077 - `PUT /subcategories`
- módulo: Subcategorias
- método HTTP: PUT
- rota: `/subcategories`
- finalidade/descrição oficial: Atualizar subcategoria por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `name`, `categoryErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Subcategories`: erpId, name, categoryErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Subcategories`: companyErpId.
- response body de sucesso: `200` Subcategoria atualizada com sucesso!; campos do exemplo: `message`, `updated`, `erpId`, `name`, `categoryErpId`
- códigos HTTP documentados: `200` Subcategoria atualizada com sucesso! | `404` Subcategoria não encontrada. | `500` Erro no servidor
- principais respostas de erro: `404` Subcategoria não encontrada.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Subcategories`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `name`, `categoryErpId`; respostas: `200` presente (objeto), campos: `message`, `updated`, `erpId`, `name`, `categoryErpId`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: A descrição pretende atualização por `erpId`, mas rota, parâmetros e request não o transportam; identificação AMBIGUA (`PEND-015`).
- pendências específicas: PEND-015, PEND-018
- rastreabilidade da fonte: PDF oficial, páginas 72-73; extração vinculada, linhas 4186-4231; módulo Subcategorias; operação `PUT /subcategories`.


## Tabelas de preço

### OP-078 - `GET /price-tables`
- módulo: Tabelas de preço
- método HTTP: GET
- rota: `/price-tables`
- finalidade/descrição oficial: Listar todas as tabelas de preço
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, sem `*`); `limit` (integer, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `PriceTables`: erpId, description, visible, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query); no catálogo de componentes: `PriceTables`: priceAdjustment, minimumValue.
- response body de sucesso: `200` Lista de tabelas de preço; campos do exemplo: `erpId`, `description`, `priceAdjustment`, `minimumValue`, `companyErpId`, `visible`
- códigos HTTP documentados: `200` Lista de tabelas de preço | `404` Tabelas de preço não encontradas | `500` Erro no servidor
- principais respostas de erro: `404` Tabelas de preço não encontradas; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `PriceTables`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `description`, `priceAdjustment`, `minimumValue`, `companyErpId`, `visible`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, sem `*`) e limit (integer, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 73-74; extração vinculada, linhas 4235-4291; módulo Tabelas de preço; operação `GET /price-tables`.

### OP-079 - `POST /price-tables`
- módulo: Tabelas de preço
- método HTTP: POST
- rota: `/price-tables`
- finalidade/descrição oficial: Criar uma nova tabela de preços
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `description`, `priceAdjustment`, `minimumValue`, `companyErpId`, `visible`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `PriceTables`: erpId, description, visible, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `PriceTables`: priceAdjustment, minimumValue.
- response body de sucesso: `201` Tabela de preços criada com sucesso.; campos do exemplo: `erpId`, `description`, `priceAdjustment`, `minimumValue`, `companyErpId`, `visible`
- códigos HTTP documentados: `201` Tabela de preços criada com sucesso. | `400` Corpo da requisição vazio ou inválido. | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição vazio ou inválido.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `PriceTables`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `description`, `priceAdjustment`, `minimumValue`, `companyErpId`, `visible`; respostas: `201` presente (objeto), campos: `erpId`, `description`, `priceAdjustment`, `minimumValue`, `companyErpId`, `visible`; `400` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `companyErpId`; response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 74-75; extração vinculada, linhas 4293-4351; módulo Tabelas de preço; operação `POST /price-tables`.

### OP-080 - `PUT /price-tables`
- módulo: Tabelas de preço
- método HTTP: PUT
- rota: `/price-tables`
- finalidade/descrição oficial: Atualizar tabela de preços por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `description`, `priceAdjustment`, `minimumValue`, `visible`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `PriceTables`: erpId, description, visible, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `PriceTables`: priceAdjustment, minimumValue.
- response body de sucesso: `200` Tabela de preços atualizada com sucesso!; campos do exemplo: `erpId`, `description`, `priceAdjustment`, `minimumValue`, `companyErpId`, `visible`
- códigos HTTP documentados: `200` Tabela de preços atualizada com sucesso! | `404` Tabela de preços não encontrada. | `500` Erro no servidor
- principais respostas de erro: `404` Tabela de preços não encontrada.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `PriceTables`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `description`, `priceAdjustment`, `minimumValue`, `visible`; respostas: `200` presente (objeto), campos: `erpId`, `description`, `priceAdjustment`, `minimumValue`, `companyErpId`, `visible`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`; response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-018
- rastreabilidade da fonte: PDF oficial, página 75; extração vinculada, linhas 4353-4411; módulo Tabelas de preço; operação `PUT /price-tables`.


## Transportadoras

### OP-081 - `GET /carriers`
- módulo: Transportadoras
- método HTTP: GET
- rota: `/carriers`
- finalidade/descrição oficial: Listar todas as transportadoras
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, sem `*`); `limit` (integer, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Carriers`: name, cnpj, phone, companyErpId, email. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query); no catálogo de componentes: `Carriers`: erpId.
- response body de sucesso: `200` Lista de transportadoras; campos do exemplo: `erpId`, `name`, `cnpj`, `phone`, `companyErpId`, `email`
- códigos HTTP documentados: `200` Lista de transportadoras | `404` Transportadoras não encontradas | `500` Erro no servidor
- principais respostas de erro: `404` Transportadoras não encontradas; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Carriers`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `name`, `cnpj`, `phone`, `companyErpId`, `email`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, sem `*`) e limit (integer, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 75-76; extração vinculada, linhas 4415-4461; módulo Transportadoras; operação `GET /carriers`.

### OP-082 - `POST /carriers`
- módulo: Transportadoras
- método HTTP: POST
- rota: `/carriers`
- finalidade/descrição oficial: Criar uma transportadora
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `cnpj`, `phone`, `companyErpId`, `email`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Carriers`: name, cnpj, phone, companyErpId, email. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Carriers`: erpId.
- response body de sucesso: `201` Transportadora criada com sucesso.; campos do exemplo: `erpId`, `name`, `cnpj`, `phone`, `companyErpId`, `email`
- códigos HTTP documentados: `201` Transportadora criada com sucesso. | `400` Corpo da requisição vazio ou inválido. | `409` Transportadora já existente. | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição vazio ou inválido.; campos do exemplo: `message` | `409` Transportadora já existente.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Carriers`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `cnpj`, `phone`, `companyErpId`, `email`; respostas: `201` presente (objeto), campos: `erpId`, `name`, `cnpj`, `phone`, `companyErpId`, `email`; `400` presente (objeto), campos: `message`; `409` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `companyErpId`; response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 76-77; extração vinculada, linhas 4463-4523; módulo Transportadoras; operação `POST /carriers`.

### OP-083 - `PUT /carriers`
- módulo: Transportadoras
- método HTTP: PUT
- rota: `/carriers`
- finalidade/descrição oficial: Atualizar transportadora por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `name`, `cnpj`, `phone`, `email`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Carriers`: name, cnpj, phone, companyErpId, email. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Carriers`: erpId.
- response body de sucesso: `200` Transportadora atualizada com sucesso!; campos do exemplo: `erpId`, `name`, `cnpj`, `phone`, `companyErpId`, `email`
- códigos HTTP documentados: `200` Transportadora atualizada com sucesso! | `404` Transportadora não encontrada. | `500` Erro no servidor
- principais respostas de erro: `404` Transportadora não encontrada.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Carriers`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `name`, `cnpj`, `phone`, `email`; respostas: `200` presente (objeto), campos: `erpId`, `name`, `cnpj`, `phone`, `companyErpId`, `email`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-015, PEND-018
- rastreabilidade da fonte: PDF oficial, páginas 77-78; extração vinculada, linhas 4525-4569; módulo Transportadoras; operação `PUT /carriers`.

### OP-084 - `DELETE /carriers/{erpId}`
- módulo: Transportadoras
- método HTTP: DELETE
- rota: `/carriers/{erpId}`
- finalidade/descrição oficial: Remover transportadora por erpId
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Carriers`: name, cnpj, phone, companyErpId, email. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Carriers`: erpId.
- response body de sucesso: `200` Transportadora deletada.; campos do exemplo: `erpId`, `name`, `cnpj`, `companyErpId`, `email`
- códigos HTTP documentados: `200` Transportadora deletada. | `404` Transportadora não encontrada. | `500` Erro no servidor
- principais respostas de erro: `404` Transportadora não encontrada.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Carriers`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (objeto), campos: `erpId`, `name`, `cnpj`, `companyErpId`, `email`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: path: `erpId`; response 2xx: `erpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 78-79; extração vinculada, linhas 4571-4630; módulo Transportadoras; operação `DELETE /carriers/{erpId}`.


## Variantes

### OP-085 - `GET /variants`
- módulo: Variantes
- método HTTP: GET
- rota: `/variants`
- finalidade/descrição oficial: Listar todas as variantes
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, sem `*`); `limit` (integer, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Variants`: erpId, name, productErpId, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query); no catálogo de componentes: `Variants`: hexCode.
- response body de sucesso: `200` Lista de variantes; campos do exemplo: `erpId`, `name`, `hexCode`, `product`, `isVisibleForca`, `isVisibleB2B`
- códigos HTTP documentados: `200` Lista de variantes | `404` Variantes não encontradas | `500` Erro no servidor
- principais respostas de erro: `404` Variantes não encontradas; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Variants`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `name`, `hexCode`, `product`, `isVisibleForca`, `isVisibleB2B`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, sem `*`) e limit (integer, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: response 2xx: `erpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, página 79; extração vinculada, linhas 4634-4687; módulo Variantes; operação `GET /variants`.

### OP-086 - `POST /variants`
- módulo: Variantes
- método HTTP: POST
- rota: `/variants`
- finalidade/descrição oficial: Criar uma variante
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `erpId`, `name`, `hexCode`, `productErpId`, `companyErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Variants`: erpId, name, productErpId, companyErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Variants`: hexCode.
- response body de sucesso: `201` Variante criada com sucesso.; campos do exemplo: `erpId`, `name`, `hexCode`, `productErpId`, `companyErpId`
- códigos HTTP documentados: `201` Variante criada com sucesso. | `400` Corpo da requisição vazio ou inválido. | `409` Variante já existente. | `500` Erro no servidor
- principais respostas de erro: `400` Corpo da requisição vazio ou inválido.; campos do exemplo: `message` | `409` Variante já existente.; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Variants`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `erpId`, `name`, `hexCode`, `productErpId`, `companyErpId`; respostas: `201` presente (objeto), campos: `erpId`, `name`, `hexCode`, `productErpId`, `companyErpId`; `400` presente (objeto), campos: `message`; `409` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: request: `erpId`, `productErpId`, `companyErpId`; response 2xx: `erpId`, `productErpId`, `companyErpId`. Os contextos não foram declarados equivalentes.
- pendências específicas: nenhuma específica além das pendências transversais aplicáveis
- rastreabilidade da fonte: PDF oficial, páginas 79-80; extração vinculada, linhas 4689-4753; módulo Variantes; operação `POST /variants`.


## Vendedores

### OP-087 - `GET /sellers`
- módulo: Vendedores
- método HTTP: GET
- rota: `/sellers`
- finalidade/descrição oficial: Lista todos os vendedores/showrooms com paginação e filtros.
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: `page` (integer, sem `*`); `limit` (integer, sem `*`); `name` (string, sem `*`); `cpf` (string, sem `*`); `type` (string, sem `*`); `erpId` (string, sem `*`); `code` (string, sem `*`)
- header parameters específicos: NAO_DOCUMENTADO
- request body: NAO_DOCUMENTADO
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Sellers`: name, cpf, type, companyErpId, password. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: `page` (query), `limit` (query), `name` (query), `cpf` (query), `type` (query), `erpId` (query), `code` (query); no catálogo de componentes: `Sellers`: erpId, cellphone, email, code.
- response body de sucesso: `200` Lista de vendedores retornada com sucesso.; campos do exemplo: `erpId`, `name`, `cpf`, `email`, `cellphone`, `type`, `code`
- códigos HTTP documentados: `200` Lista de vendedores retornada com sucesso. | `400` Requisição inválida | `500` Erro no servidor
- principais respostas de erro: `400` Requisição inválida; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Sellers`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: `type`: `SHOWROOM | COORDINATOR` (enum explicitamente descrito na query da operação)
- exemplos relevantes: request ausente; respostas: `200` presente (array), campos: `erpId`, `name`, `cpf`, `email`, `cellphone`, `type`, `code`; `400` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: page (integer, sem `*`) e limit (integer, sem `*`)
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: query: `erpId`, `code`; response 2xx: `erpId`, `code`. Os contextos não foram declarados equivalentes.
- pendências específicas: PEND-017
- rastreabilidade da fonte: PDF oficial, páginas 80-81; extração vinculada, linhas 4757-4817; módulo Vendedores; operação `GET /sellers`.

### OP-088 - `POST /sellers`
- módulo: Vendedores
- método HTTP: POST
- rota: `/sellers`
- finalidade/descrição oficial: Cria um vendedor/showroom.
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `name`, `cpf`, `email`, `cellphone`, `type`, `companyErpId`, `code`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Sellers`: name, cpf, type, companyErpId, password. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Sellers`: erpId, cellphone, email, code.
- response body de sucesso: `201` Operação realizada com sucesso; campos do exemplo: `message`
- códigos HTTP documentados: `201` Operação realizada com sucesso | `400` Requisição inválida | `409` Vendedor já cadastrado. | `500` Erro no servidor
- principais respostas de erro: `400` Requisição inválida; campos do exemplo: `message` | `409` Vendedor já cadastrado.; body/exemplo: NAO_DOCUMENTADO | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Sellers`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `name`, `cpf`, `email`, `cellphone`, `type`, `companyErpId`, `code`; respostas: `201` presente (objeto), campos: `message`; `400` presente (objeto), campos: `message`; `409` ausente; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: Request usa `code` e `companyErpId`; a ponte para `erpId` não é documentada (`PEND-017`).
- pendências específicas: PEND-017, PEND-018
- rastreabilidade da fonte: PDF oficial, páginas 81-82; extração vinculada, linhas 4819-4880; módulo Vendedores; operação `POST /sellers`.

### OP-089 - `PUT /sellers/{erpId}`
- módulo: Vendedores
- método HTTP: PUT
- rota: `/sellers/{erpId}`
- finalidade/descrição oficial: Atualiza um vendedor/showroom por erpId.
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: `erpId` (string, obrigatório `*`)
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `name`, `cpf`, `email`, `cellphone`, `type`, `code`
- campos obrigatórios: na operação: `erpId` (path); no catálogo de componentes: `Sellers`: name, cpf, type, companyErpId, password. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `Sellers`: erpId, cellphone, email, code.
- response body de sucesso: `200` Operação realizada com sucesso; campos do exemplo: `message`
- códigos HTTP documentados: `200` Operação realizada com sucesso | `400` Requisição inválida | `404` Vendedor não encontrado. | `500` Erro no servidor
- principais respostas de erro: `400` Requisição inválida; campos do exemplo: `message` | `404` Vendedor não encontrado.; body/exemplo: NAO_DOCUMENTADO | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `Sellers`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (objeto), campos: `name`, `cpf`, `email`, `cellphone`, `type`, `code`; respostas: `200` presente (objeto), campos: `message`; `400` presente (objeto), campos: `message`; `404` ausente; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: Alvo no path: `erpId`; request contém `code`; a ponte entre eles não é documentada (`PEND-017`).
- pendências específicas: PEND-017, PEND-018
- rastreabilidade da fonte: PDF oficial, páginas 82-83; extração vinculada, linhas 4882-4956; módulo Vendedores; operação `PUT /sellers/{erpId}`.

### OP-090 - `PATCH /sellers/clients`
- módulo: Vendedores
- método HTTP: PATCH
- rota: `/sellers/clients`
- finalidade/descrição oficial: Vincula múltiplos vendedores a clientes
- autenticação: JWT obtido em `POST /auth`; nome/formato do header, prefixo `Bearer`, expiração, renovação e escopos: NAO_DOCUMENTADO (`PEND-001`)
- path parameters: NAO_DOCUMENTADO
- query parameters: NAO_DOCUMENTADO
- header parameters específicos: NAO_DOCUMENTADO
- request body: application/json; campos do exemplo oficial, em ordem de primeira ocorrência: `sellerErpId`, `clientErpId`, `companyErpId`
- campos obrigatórios: na operação: NAO_DOCUMENTADO; no catálogo de componentes: `VinculateSellersClients`: sellerErpId, clientErpId, companyErpId; `VinculatedResponse`: sellerErpId, clientErpId. Não projetar required do componente no request sem vínculo explícito.
- campos opcionais: na operação: NAO_DOCUMENTADO; no catálogo de componentes: nenhum nos dois componentes.
- response body de sucesso: `200` Vinculações realizadas com sucesso; campos do exemplo: `sellerErpId`, `clientErpId`
- códigos HTTP documentados: `200` Vinculações realizadas com sucesso | `400` Requisição inválida | `404` Recurso não encontrado | `500` Erro no servidor
- principais respostas de erro: `400` Requisição inválida; campos do exemplo: `message` | `404` Recurso não encontrado; campos do exemplo: `message` | `500` Erro no servidor; campos do exemplo: `message`
- schema/modelo relacionado: schemas inline do bloco da operação; componente(s) final(is) relacionado(s) por domínio: `VinculateSellersClients + VinculatedResponse`. O PDF não expõe $ref inequívoco; ver PEND-018.
- enums documentados: NAO_DOCUMENTADO (valores vistos apenas em exemplos não foram promovidos a enum; `PEND-020`)
- exemplos relevantes: request presente (array), campos: `sellerErpId`, `clientErpId`, `companyErpId`; respostas: `200` presente (array), campos: `sellerErpId`, `clientErpId`; `400` presente (objeto), campos: `message`; `404` presente (objeto), campos: `message`; `500` presente (objeto), campos: `message`. Valores literais completos permanecem na faixa de linhas da rastreabilidade e não foram convertidos em enum, regra ou equivalência.
- paginação: NAO_DOCUMENTADO
- upload/download: NAO_DOCUMENTADO
- evidência de identificação/correlação: Identificadores do vínculo: `sellerErpId`, `clientErpId` e `companyErpId`; nenhum outro ID foi atribuído à operação.
- pendências específicas: PEND-017
- rastreabilidade da fonte: PDF oficial, páginas 83-84; extração vinculada, linhas 4958-5042; módulo Vendedores; operação `PATCH /sellers/clients`.

## Fechamento da revisão operação por operação

- 90/90 operações foram reconstruídas a partir do próprio bloco oficial.
- 26 módulos, 90 identidades método + rota e 47 rotas únicas foram preservados.
- 21 operações paginadas foram registradas.
- 27 componentes e 185 marcadores required foram preservados sem projetar `$ref` inexistente.
- `Bearer` não foi afirmado; o transporte do JWT permanece `NAO_DOCUMENTADO`.
- As ambiguidades de rota/path, atualização sem identificador, imagem/produto e `code`/`erpId` de vendedores permanecem explícitas.
- Nenhum endpoint, campo, código, enum ou relacionamento foi preenchido por convenção de verbo HTTP.
