# 01 — Análise da documentação oficial da ferramenta Força de Vendas

## 1) Fontes analisadas

1. Documentação oficial da API Força de Vendas (PDF, 87 páginas):
   - `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.pdf`
2. Extração textual UTF-8 vinculada ao mesmo PDF:
   - `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.extraido.txt`

Contexto obrigatório da correção controlada, usado para localizar regressões sem substituir a fonte oficial:

- `parceiros/comandos/01-APRESENTAR-E-ANALISAR-FERRAMENTA.md`;
- os três artefatos históricos do Passo 01;
- `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-01.md`;
- `ferramentas/forca-de-vendas/HOMOLOGACAO-PARA-INTEGRACOES.md`;
- `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-03.md`;
- `parceiros/execucoes/ferramentas/forca-de-vendas/DIAGNOSTICO-CORRECAO-POS-PASSO-03.md`.

> Fonte primária adotada: documentação oficial acima.

---

## 2) Identidade, versão e ambiente

- Produto/API: Força de Vendas — API oficial de integração da E-Catálogos
- Versão informada: `1.0.0`
- Especificação informada: `OAS 3.0`
- Base URL/Server: `https://forca-de-vendas.api.e-catalogos.net`
- Site institucional: `https://e-catalogos.net`

### Autenticação

- Endpoint: `POST /auth`
- Credenciais no corpo: `email`, `password`, `key`
- Retorno de sucesso: JWT em `resource.token`
- Aplicação do token nas demais operações: a interface da documentação exibe `Authorize`, mas não define o nome do header, o esquema de segurança nem o prefixo do token.
- Formato `Authorization: Bearer <token>`: **NAO_DOCUMENTADO**; não assumir `Bearer` por convenção.
- Expiração, renovação e escopos do token: **NAO_DOCUMENTADO**.
- Pendência aplicável: `PEND-001`.

---

## 3) Inventário de módulos (tags)

Módulos identificados na documentação:

1. Autenticação
2. Categorias
3. Campanhas
4. Clientes
5. Condições de pagamento
6. Cores
7. Companhias
8. Filiais
9. Gêneros
10. Imagens
11. Linhas
12. Marcas
13. Métodos de pagamento
14. Pedidos
15. Preços
16. Prepostos
17. Produtos
18. Prazos de entregas
19. Regiões
20. Representantes
21. Skus
22. Subcategorias
23. Tabelas de preço
24. Transportadoras
25. Variantes
26. Vendedores

---

## 4) Inventário completo de endpoints e métodos

### Autenticação
- `POST /auth`

### Categorias
- `GET /categories`
- `POST /categories`
- `PUT /categories`

### Campanhas
- `POST /campaigns`
- `DELETE /campaigns`

### Clientes
- `GET /clients`
- `POST /clients`
- `PUT /clients`

### Condições de pagamento
- `GET /payment-conditions`
- `POST /payment-conditions`
- `PUT /payment-conditions`
- `DELETE /payment-conditions/{erpId}`

### Cores
- `GET /colors`
- `POST /colors`
- `PUT /colors`
- `PUT /colors/products/{productErpId}`

### Companhias
- `POST /companies`
- `PUT /companies`

### Filiais
- `GET /branches`
- `POST /branches`
- `PUT /branches`
- `DELETE /branches/{erpId}`

### Gêneros
- `GET /genders`
- `POST /genders`
- `PUT /genders`
- `DELETE /genders/{erpId}`

### Imagens
- `POST /images` (multipart/form-data)

### Linhas
- `POST /lines`
- `DELETE /lines`

### Marcas
- `GET /brands`
- `POST /brands`
- `PUT /brands`

### Métodos de pagamento
- `GET /payment-methods`
- `POST /payment-methods`
- `PUT /payment-methods`
- `DELETE /payment-methods/{erpId}`

### Pedidos
- `GET /orders`
- `PATCH /orders/export/{number}`
- `PATCH /orders/{number}`
- `PUT /orders/status`
- `GET /orders/integrated`

### Preços
- `POST /prices`
- `PUT /prices`
- `DELETE /prices/{erpId}`

### Prepostos
- `GET /agents`
- `POST /agents`
- `PUT /agents`
- `DELETE /agents`

### Produtos
- `GET /products`
- `POST /products`
- `PUT /products`
- `GET /products/{erpId}`
- `PATCH /products/visible`

### Prazos de entrega
- `GET /deadlines`
- `POST /deadlines`
- `PUT /deadlines`
- `DELETE /deadlines/{erpId}`

### Regiões
- `GET /regions`
- `POST /regions`
- `PUT /regions`
- `GET /regions/{erpId}`
- `DELETE /regions/{erpId}`

### Representantes
- `GET /representatives`
- `POST /representatives`
- `PUT /representatives`
- `DELETE /representatives`
- `PATCH /representatives/clients`

### Skus
- `GET /skus`
- `POST /skus`
- `PUT /skus`
- `GET /skus/{erpId}`
- `PATCH /skus/stock`
- `PATCH /skus/grid`

### Subcategorias
- `GET /subcategories`
- `POST /subcategories`
- `PUT /subcategories`

### Tabelas de preço
- `GET /price-tables`
- `POST /price-tables`
- `PUT /price-tables`

### Transportadoras
- `GET /carriers`
- `POST /carriers`
- `PUT /carriers`
- `DELETE /carriers/{erpId}`

### Variantes
- `GET /variants`
- `POST /variants`

### Vendedores
- `GET /sellers`
- `POST /sellers`
- `PUT /sellers/{erpId}`
- `PATCH /sellers/clients`

Inventário técnico por operação (estruturado, com campos por operação e marcação `NAO_DOCUMENTADO` quando ausente na fonte):

- `analises/ferramentas/forca-de-vendas/01-inventario-operacoes.md`
- Fonte direta de validação usada no refino: `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.extraido.txt` (extraído do PDF oficial em UTF-8)

---

## 5) Parâmetros, paginação, payloads e respostas (resumo técnico)

- Operações paginadas documentadas: **21**, com `page` e `limit`: `OP-002`, `OP-007`, `OP-010`, `OP-014`, `OP-020`, `OP-024`, `OP-031`, `OP-034`, `OP-038`, `OP-042`, `OP-046`, `OP-050`, `OP-055`, `OP-059`, `OP-064`, `OP-069`, `OP-075`, `OP-078`, `OP-081`, `OP-085` e `OP-087`.
- Filtros específicos devem ser preservados por operação, sem usar o padrão de outra rota: nome, cnpj/cpf/email, códigos ERP, tipo e demais parâmetros publicados.
- `erpId` e suas variações aparecem como identificadores recorrentes, mas identificador relacional não deve ser promovido automaticamente a chave de correlação. A correlação deve ser demonstrada no bloco da própria operação.
- Upload de arquivo:
  - `POST /images` com `multipart/form-data`, campo obrigatório `images` (array de arquivos).
  - A finalidade declara associação a um produto, mas parâmetros e request não informam o identificador do produto; mecanismo de associação, quantidade máxima, tamanho e tipos aceitos permanecem `NAO_DOCUMENTADO` em `PEND-016`.
- Vendedores:
  - `POST /sellers` recebe `code`;
  - `PUT /sellers/{erpId}` identifica o recurso por `erpId`;
  - a fonte não documenta a ponte entre `code` e `erpId` (`PEND-017`).
- Códigos de erro recorrentes:
  - `400` para corpo inválido/parâmetros inválidos;
  - `404` para recurso não encontrado;
  - `409` para duplicidade em alguns cadastros;
  - `500` para erro interno.
- Esses padrões não substituem os códigos e payloads publicados em cada operação. Em `OP-041`, somente o `500` possui semântica descrita; `200`, `400` e `404` aparecem sem descrição/payload (`PEND-019`).
- Rate limit, quotas e headers de limitação: **não documentados**.

---

## 6) Schemas e entidades

Schemas listados no bloco final (páginas 84–87):

1. `Representatives`
2. `Agents`
3. `Campaign`
4. `Line`
5. `Client`
6. `Companies`
7. `Brands`
8. `Carriers`
9. `Categories`
10. `PaymentConditions`
11. `Colors`
12. `Branches`
13. `Gender`
14. `PaymentMethods`
15. `Orders`
16. `Deadlines`
17. `Sellers`
18. `Prices`
19. `Product`
20. `Sku`
21. `Subcategories`
22. `PriceTables`
23. `Variants`
24. `VinculateSellersClients`
25. `VinculatedResponse`
26. `Regions`
27. `ProductsVisibility`

O bloco de componentes contém **185 marcadores `*` de obrigatoriedade**. Eles devem ser preservados como obrigatoriedade do componente em que aparecem, sem projetá-los automaticamente em uma operação.

Observações:

- no PDF, os schemas aparecem resumidos em alguns pontos, com campos representados por `[...]` e sem detalhamento completo de tipo;
- a fonte não explicita o vínculo normativo entre cada request/response body e um component schema;
- há conflitos entre exemplos de operação e components nas operações `OP-008`, `OP-009`, `OP-012`, `OP-022`, `OP-026`, `OP-032`, `OP-033`, `OP-036`, `OP-047`, `OP-048`, `OP-057`, `OP-066`, `OP-071`, `OP-077`, `OP-080`, `OP-083`, `OP-088` e `OP-089`;
- por isso, não projetar `required` do component no body da operação sem vínculo explícito (`PEND-018`);
- valores categóricos presentes apenas em exemplos não formam enum exaustivo. Somente `OP-087` explicita `SHOWROOM | COORDINATOR` como domínio da operação (`PEND-020`).

---

## 7) Dependências e ordem provável de cadastro (com evidência documental)

As relações abaixo são dependências documentadas por campos e operações. Elas não transformam todo identificador relacional em chave de correlação nem criam garantia transacional adicional.

- `companies` fornece a referência corporativa `companyErpId` usada por diversas entidades.
- `brands` referencia `companyErpId`.
- `categories` referencia `brandErpId`.
- `subcategories` referencia `categoryErpId`; em `PUT /subcategories`, o mecanismo para informar o `erpId` do alvo não está documentado (`PEND-015`).
- `payment-conditions` referencia `paymentMethodErpId` e, quando publicado, `companyErpId`; métodos de pagamento precedem condições de pagamento.
- `clients` pode referenciar `representativesErpIds`. Quando esse campo for usado, os representantes precisam estar previamente identificáveis.
- `PATCH /representatives/clients` exige `representativeErpId` e `clientErpId`; ambos os registros precisam existir.
- `regions` referencia uma tabela de preço. O request usa `priceTablesErpId` e a resposta usa `priceTableErpId`; preservar as duas grafias e `PEND-005` sem escolher uma forma normativa.
- `products` referencia `branchErpId`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `productSubcategoryErpId`, `campaignErpId`, `lineErpId` e `productColors`.
- cores-mestre podem existir antes do produto; porém `PUT /colors/products/{productErpId}` só pode ocorrer depois que produto e cores estejam identificáveis.
- `variants` referencia `productErpId`.
- `skus` referencia `variantErpId`.
- `prices` referencia `skuErpId` e `priceTableErpId`.
- `POST /images` declara associação a produto, mas não documenta como o produto é informado ou inferido; não estabelecer ordem executável para essa associação até resolver `PEND-016`.
- `POST /sellers` usa `code`, `PUT /sellers/{erpId}` usa `erpId` e `PATCH /sellers/clients` usa `sellerErpId`; a ponte entre as chaves permanece `NAO_DOCUMENTADO` em `PEND-017`.
- pedidos:
  - leitura em `GET /orders` (não integrados);
  - confirmação/exportação em `PATCH /orders/export/{number}`;
  - marcação de integrado em `PATCH /orders/{number}`;
  - atualização logística/fiscal em `PUT /orders/status`;
  - consulta posterior em `GET /orders/integrated`.

Ordem parcial mínima sustentada pelas referências documentadas:

1. `companies`;
2. `brands`, `branches`, `genders`, `deadlines`, `payment-methods`, `price-tables`, `carriers`, `campaigns`, `lines`, `colors`, `representatives` e `sellers`;
3. `payment-conditions` depois de `payment-methods`;
4. `regions` depois de `price-tables`;
5. `categories` depois de `brands`, seguidas de `subcategories`;
6. `clients` depois de `representatives` quando `representativesErpIds` for usado;
7. `products` depois das dependências de catálogo;
8. vínculo explícito `colors/products` depois de produto e cores;
9. `products -> variants -> skus -> prices`, com `price-tables` também antes de `prices`;
10. vínculos `representatives/clients` e `sellers/clients` depois das entidades envolvidas;
11. pedidos e seus registros de confirmação/status;
12. associação de imagens: ordem operacional pendente de `PEND-016`.

Essa ordem é parcial e baseada apenas em referências publicadas; não representa garantia de atomicidade, idempotência ou rollback.

---

## 8) Operações disponíveis por módulo (CRUD e vínculos)

- CRUD completo (ou quase) em vários cadastros mestres: categorias, filiais, gêneros, métodos de pagamento, prazos, regiões, transportadoras, skus (com extras), produtos (sem delete explícito), etc.
- Operações de vínculo:
  - cores por produto (`PUT /colors/products/{productErpId}`)
  - clientes por representantes (`PATCH /representatives/clients`)
  - clientes por vendedores (`PATCH /sellers/clients`)
- Operações de integração de pedidos:
  - exportar (`PATCH /orders/export/{number}`)
  - marcar integrado + ERP number (`PATCH /orders/{number}`)
  - atualizar status/NFe (`PUT /orders/status`)
  - consultar já integrados (`GET /orders/integrated`)

---

## 9) Bidirecionalidade — pontos relevantes por módulo

Critério aplicado: capacidade bidirecional derivada exclusivamente das operações efetivamente documentadas por módulo.

Matriz detalhada por módulo (ERP -> ferramenta, ferramenta -> ERP, consulta, criação, atualização, exclusão, correlação, confirmação de integração, limitações e status):

- `analises/ferramentas/forca-de-vendas/01-matriz-bidirecionalidade-modulos.md`

Limitações transversais ainda não documentadas na fonte oficial:

- idempotência formal;
- prevenção de loop;
- política de conflito;
- estratégia de reprocessamento seguro;
- rate limit e retry/backoff.

Cobertura direcional esperada após a correção controlada da matriz: **66** operações em `ERP -> ferramenta`, **24** em `ferramenta -> ERP`, união **90/90**, sem operação extra, ausente ou duplicada entre as direções.

Na matriz, correlação por operação deve ficar separada de identificadores relacionais/dependências. Sem evidência no próprio bloco, usar `NAO_DOCUMENTADO` ou a pendência correspondente; não derivar correlação por padrão nominal de `erpId`.

Os status são definidos individualmente por módulo na matriz: autenticação é específica; módulos com suporte apenas de escrita são unidirecionais; módulos com leitura e escrita permanecem parciais e carregam as lacunas contratuais aplicáveis. Não existe um único status universal para os 26 módulos.

---

## 10) Divergências e inconsistências encontradas na própria fonte

1. **Parâmetros de path declarados em rotas sem placeholder no path**  
   - `PUT /companies`, `PUT /genders`, `DELETE /agents`, `PUT /regions`, `PUT /representatives`, `DELETE /representatives` e `PUT /skus` declaram `erpId` de path, mas publicam rota sem `{erpId}` (`PEND-006`).
2. **Alvo de atualização não informado**
   - `OP-012 PUT /payment-conditions` descreve atualização sem informar o alvo; `OP-033 PUT /brands`, `OP-077 PUT /subcategories` e `OP-083 PUT /carriers` dizem atualizar por `erpId`, mas rota, parâmetros e request não transportam esse identificador (`PEND-015`).
3. **Inconsistência de status code x mensagem**
   - Em alguns módulos aparece `401` com mensagem `"400: Parâmetros inválidos"`.
4. **Inconsistências de nomes de campo**
   - `cellphone` vs `cellPhone`;
   - `productSubcategoryErpId` vs `subcategoryErpId`;
   - `priceTablesErpId` (request em regiões) vs `priceTableErpId` (response);
   - `ordersped_numero_externo`/`ordersPedTelefoneCliente` em respostas de pedidos.
5. **Inconsistência de visibilidade em produto**
   - Em pontos diferentes: `isVisibleB2B`/`isVisibleForca` e `isVisible`.
6. **Descrição textual incorreta em resposta**
   - Em `PUT /brands`, descrição cita “Empresa atualizada com sucesso”.
7. **Lacuna de sucesso explícito em alguns endpoints**
   - `POST /brands` e `POST /subcategories` no trecho apresentado não exibem resposta de sucesso completa (apenas erros).
8. **Campos com provável erro tipográfico**
   - `colection` (provável `collection`);
   - `ANAlist/analist` em cliente (grafia não padronizada).
9. **Associação de imagens sem identificador do produto**
   - `POST /images` declara associação ao produto, mas publica `No parameters` e request somente com `images` (`PEND-016`).
10. **Criação e atualização de vendedor usam chaves sem ponte documentada**
    - criação por `code`, atualização por `erpId` e vínculo por `sellerErpId`, sem relação normativa entre elas (`PEND-017`).
11. **Vínculo entre bodies e component schemas não explicitado**
    - a fonte não associa normativamente os bodies aos 27 components e apresenta conflitos schema x exemplo em 18 operações (`PEND-018`).
12. **Respostas sem semântica em `OP-041 PUT /orders/status`**
    - `200`, `400` e `404` aparecem sem descrição/payload; somente `500` possui semântica descrita (`PEND-019`).
13. **Domínios categóricos não formalizados**
    - somente `OP-087` explicita `SHOWROOM | COORDINATOR`; valores isolados em exemplos não devem ser tratados como enum exaustivo (`PEND-020`).

Rastreabilidade das divergências por operação:

- `PUT /companies`, `PUT /genders`, `DELETE /agents`, `PUT /regions`, `PUT /representatives`, `DELETE /representatives`, `PUT /skus` (path `erpId` citado em rota sem placeholder);
- `PUT /payment-conditions`, `PUT /brands`, `PUT /subcategories`, `PUT /carriers` (alvo de atualização ausente);
- `PUT /brands` (descrição textual de sucesso divergente);
- `POST /brands`, `POST /subcategories` (trecho sem resposta de sucesso explícita);
- `POST /images` (associação ao produto sem identificador);
- `POST /sellers`, `PUT /sellers/{erpId}`, `PATCH /sellers/clients` (ponte entre chaves não documentada);
- `OP-008`, `OP-009`, `OP-012`, `OP-022`, `OP-026`, `OP-032`, `OP-033`, `OP-036`, `OP-047`, `OP-048`, `OP-057`, `OP-066`, `OP-071`, `OP-077`, `OP-080`, `OP-083`, `OP-088`, `OP-089` (body x component schema/required não vinculados ou divergentes);
- `OP-041` (semântica ausente para respostas `200`, `400`, `404`);
- `OP-087` (único enum explícito identificado).

---

## 11) Pendências e perguntas

As pendências abaixo possuem IDs estáveis. Ausência ou conflito deve permanecer explícito; nenhuma delas autoriza completar a fonte por convenção REST, exemplo isolado, component schema não vinculado ou artefato histórico.

| ID | Título e lacuna preservada | Evidência/conduta obrigatória |
|---|---|---|
| `PEND-001` | Aplicação, expiração, renovação e escopos do JWT não documentados | `POST /auth` retorna JWT, mas header, prefixo, validade, refresh e escopos não são definidos. Não assumir `Bearer`. |
| `PEND-002` | Rate limit, quota, timeout e retry/backoff não documentados | A fonte não publica limites ou política de repetição; definir somente após decisão/evidência externa autorizada. |
| `PEND-003` | Idempotência por módulo não documentada | Não inferir idempotência por verbo HTTP, status ou uso de `erpId`. |
| `PEND-004` | Prevenção de loop bidirecional não documentada | Origem da alteração e mecanismo antirrealimentação exigem desenho posterior explícito. |
| `PEND-005` | Nomenclatura divergente de campos | Preservar `cellphone/cellPhone`, `productSubcategoryErpId/subcategoryErpId`, `priceTablesErpId/priceTableErpId` e nomes de pedidos sem normalização silenciosa. |
| `PEND-006` | Rotas com conflito entre path e parâmetro | Sete operações declaram `erpId` path sem placeholder. Não escolher formato da URL sem confirmação oficial. |
| `PEND-007` | OpenAPI/Swagger bruto não disponível | O PDF é a fonte recebida; obter especificação bruta para validação estrutural mais forte. |
| `PEND-008` | Política de conflito não documentada | Não definir sistema prevalente ou ordenação temporal sem decisão explícita. |
| `PEND-009` | Reprocessamento seguro não documentado | Não definir repetição após falha parcial sem estratégia de consistência e deduplicação. |
| `PEND-010` | Inconsistência entre status HTTP e mensagem | Preservar código e mensagem exatamente como publicados; não reclassificar por texto. |
| `PEND-011` | Divergência nos campos de visibilidade de produto | `isVisibleB2B/isVisibleForca` e `isVisible` não são equivalentes sem confirmação. |
| `PEND-012` | Descrição de sucesso divergente em `PUT /brands` | A descrição cita atualização de empresa; não usá-la como regra de marca sem confirmação. |
| `PEND-013` | Resposta de sucesso não explicitada em `POST /brands` e `POST /subcategories` | Não inventar código ou payload de sucesso. |
| `PEND-014` | Erros tipográficos em campos documentados | Preservar `colection` e `ANAlist/analist` ou obter forma oficial; não corrigir silenciosamente. |
| `PEND-015` | Identificador do alvo ausente em quatro atualizações | `OP-012` não informa qual registro atualizar; `OP-033`, `OP-077` e `OP-083` dizem atualizar por `erpId`, mas rota/parâmetros/body não transportam o alvo. |
| `PEND-016` | Associação e limites de upload em `POST /images` não documentados | Request contém apenas `images`; associação ao produto, quantidade, tamanho e tipos aceitos permanecem desconhecidos. |
| `PEND-017` | Ponte `code` -> `erpId` de vendedores não documentada | Criação usa `code`, atualização usa `erpId`, vínculo usa `sellerErpId`; não inventar equivalência. |
| `PEND-018` | Body x component schema/required não vinculado e conflitos schema x exemplo | Afeta 18 operações listadas na seção 10. Preservar os 185 `*` nos components, sem projetar required na operação. |
| `PEND-019` | Semântica de respostas de `OP-041` incompleta | `200`, `400`, `404` sem descrição/payload; somente `500` descrito. |
| `PEND-020` | Domínios categóricos/enums não formalizados | Somente `OP-087` explicita `SHOWROOM \| COORDINATOR`; valores de exemplos não formam enum exaustivo. |

Rastreabilidade das conclusões de dependência/correlação (evidência por operação):

- correlação por `erpId` somente quando documentada na própria operação, como em `DELETE /payment-conditions/{erpId}`, `DELETE /branches/{erpId}`, `GET /products/{erpId}`, `GET /regions/{erpId}`, `GET /skus/{erpId}` e `PUT /sellers/{erpId}`;
- correlação de pedidos por `number` em `PATCH /orders/export/{number}` e `PATCH /orders/{number}`; `PUT /orders/status` publica `orderNumber`/`orderErpId` no body, sem converter `clientErpId` em chave primária;
- vínculos comerciais por `representativeErpId + clientErpId` e `sellerErpId + clientErpId + companyErpId` nas operações correspondentes;
- dependências explícitas de pagamento, região/preço, catálogo, preço e estoque registradas na seção 7;
- identificador relacional e chave de correlação permanecem conceitos separados.

---

## 12) Contagens totais (quando possível)

- Módulos/tags: **26**
- Rotas únicas: **47**
- Operações (método + rota): **90**
- Schemas listados: **27**
- Marcadores `*` de obrigatoriedade nos component schemas: **185**
- Operações paginadas com `page` e `limit`: **21**
- Operações com dados técnicos efetivamente documentados (além de método/rota): **90**
- Pendências documentais com ID estável: **20** (`PEND-001` a `PEND-020`)
- Cobertura direcional esperada da matriz corrigida: **66** `ERP -> ferramenta` e **24** `ferramenta -> ERP`, união **90/90**

---

## 13) Validação direta contra a fonte oficial

Validação corretiva executada diretamente sobre a documentação oficial:

1. PDF oficial (`Documentacao_API_Forca_de_Vendas.pdf`) como fonte primária;
2. extração textual UTF-8 do próprio PDF para conferência rastreável por página/módulo/operação;
3. recálculo de operações e rotas a partir das combinações método + rota extraídas da fonte;
4. separação dos limites de cada bloco de operação para não misturar request, response, erro, texto de interface ou operação vizinha;
5. conferência explícita de parâmetros, bodies, códigos, paginação, upload, enums e correlações por operação;
6. contagem separada dos 27 component schemas e dos 185 marcadores de obrigatoriedade, sem projetar `required` em body não vinculado;
7. marcação `NAO_DOCUMENTADO` quando o dado não está explicitamente presente e registro das ambiguidades em `PEND-001` a `PEND-020`;
8. revisão de bidirecionalidade por módulo baseada na finalidade textual, sem regra simplista por verbo HTTP;
9. preservação das contagens invariantes de 26 módulos, 90 operações e 47 rotas únicas.

Esta correção documental não é auditoria e não altera, por si só, o gate formal da Etapa 01.

---

## 14) Conclusão da etapa 01

A execução da Etapa 01 havia sido reaberta anteriormente para recálculo de contagem, inventário técnico estruturado por operação, matriz de bidirecionalidade e rastreabilidade. Após o Passo 03 identificar divergências semânticas materiais, esta análise foi reaberta novamente em correção controlada, preservando o histórico e os mesmos 26 módulos, 90 operações e 47 rotas únicas.

Foram explicitadas 20 pendências estáveis, inclusive as quatro classes de ambiguidade oficial: rota x path (`PEND-006`), alvo de atualização ausente (`PEND-015`), associação de imagens (`PEND-016`) e ponte de identificação de vendedores (`PEND-017`).

Não foi iniciada implementação de integração, não houve adaptação para ERP, não foram usadas fontes legadas como fonte primária e os Passos 02 e 03 não foram executados nesta correção. A Etapa 01 permanece sujeita a auditoria integral e separada; nenhuma lacuna foi resolvida por suposição silenciosa.
