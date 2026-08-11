# Diagnóstico de origem dos achados pós-Passo 03 - Força de Vendas

## Natureza e limite deste documento

- Ferramenta: Força de Vendas
- Slug: `forca-de-vendas`
- Data do diagnóstico: 2026-08-10
- Natureza: diagnóstico causal documental; **não é auditoria**
- Resultado técnico vigente consultado: `NAO_APTO_PARA_INTEGRACOES`
- Auditoria vigente consultada: `REPROVADA`
- Status vigente consultado: `PENDENTE`
- Prontidão vigente consultada: `NAO_HOMOLOGADA`

Este documento não executa nem reexecuta os Passos 01, 02 ou 03, não executa auditoria, não corrige conteúdo técnico e não muda o estado da execução. Todos os artefatos consultados foram tratados como somente leitura. A única saída desta tarefa é este relatório.

## Objetivo

Determinar em qual camada nasceu cada divergência material identificada pelo Passo 03, distinguindo:

- erro já existente nos artefatos do Passo 01;
- perda ou representação inadequada criada no Passo 02;
- problemas independentes nas duas etapas;
- conflito ou insuficiência da própria fonte oficial.

## Critério de classificação

| Classificação | Regra aplicada |
|---|---|
| `ORIGEM_PASSO_01` | A informação já estava ausente, incorreta, incompleta ou divergente nos artefatos do Passo 01. A simples cópia posterior pelo Passo 02 não cria uma segunda origem. |
| `ORIGEM_PASSO_02` | O Passo 01 possuía informação utilizável, mas o cadastro canônico a perdeu, resumiu ou não a representou. |
| `ORIGEM_AMBOS` | Há defeitos independentes nas representações do Passo 01 e do Passo 02 para a mesma unidade causal. |
| `FONTE_OFICIAL_AMBIGUA` | A documentação oficial conflita consigo mesma ou não informa como executar/correlacionar a capacidade. Nenhuma resolução foi inferida. |

### Unidade adotada para a contagem

Os oito títulos `ACHADO-03-001` a `ACHADO-03-008` não podem ser contados diretamente sem distorção:

- `ACHADO-03-001` é um guarda-chuva de suficiência operacional;
- `ACHADO-03-002` mistura omissões do inventário com conflito interno da fonte;
- `ACHADO-03-008` mistura omissão de pendência com duas insuficiências oficiais;
- dependências reprovadas aparecem nas seções de validação do Passo 03 e compartilham operações com outros achados.

Por isso, os achados foram decompostos em **17 unidades causais não sobrepostas**. Uma lista de várias operações com o mesmo defeito conta como uma unidade causal; a mesma operação só reaparece quando outro aspecto independente falhou, como body, código HTTP e correlação.

## Fontes analisadas

### Autoridade original

1. `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.pdf`
   - 1.526.436 bytes;
   - SHA-256 `2C8AAB2659BCF8974905912024E86A0B7D1053FB55E2A5FE727785FC1AD01BFB`;
   - 87 páginas, versão 1.0.0 e OAS 3.0, conforme evidência direta preservada nas auditorias anteriores.
2. `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.extraido.txt`
   - 113.964 bytes;
   - SHA-256 `A4B16B88AE820A2B543F72C18FD0908E843C01D948B22BECEB63F8EA9A2B1D5F`;
   - extração UTF-8 vinculada ao mesmo PDF, usada para rastreabilidade mecânica por linha.

Não houve nova instalação ou renderização nesta tarefa. As ferramentas locais de Poppler e Python não estão disponíveis, e o escopo proíbe alterações de máquina. A leitura textual foi confrontada com o PDF de hash estável e com a reextração e inspeção visual direta já registradas em `AUDITORIA-ETAPA-02-REVALIDACAO.md` e `AUDITORIA-ETAPA-02-POS-CORRECOES.md`. Quebras de página e ruído de extração não foram classificados como ambiguidades da API.

### Passo 01

- `analises/ferramentas/forca-de-vendas/01-analise-documentacao.md`;
- `analises/ferramentas/forca-de-vendas/01-inventario-operacoes.md`;
- `analises/ferramentas/forca-de-vendas/01-matriz-bidirecionalidade-modulos.md`;
- `parceiros/comandos/01-APRESENTAR-E-ANALISAR-FERRAMENTA.md`;
- `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-01.md`.

### Passo 02

- `parceiros/comandos/02-CADASTRAR-FERRAMENTA.md`;
- `ferramentas/forca-de-vendas/README.md`;
- `ferramentas/forca-de-vendas/CONTRATO-DA-FERRAMENTA.yaml`;
- `ferramentas/forca-de-vendas/MODULOS.md`;
- `ferramentas/forca-de-vendas/DEPENDENCIAS.md`;
- `ferramentas/forca-de-vendas/BIDIRECIONALIDADE.md`;
- `ferramentas/forca-de-vendas/PENDENCIAS.md`;
- `ferramentas/forca-de-vendas/FONTES.md`;
- `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-02.md`;
- `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-02-REVALIDACAO.md`;
- `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-02-POS-CORRECOES.md`.

### Passo 03 e controles

- `parceiros/comandos/03-VALIDAR-FERRAMENTA-CADASTRADA.md`;
- `ferramentas/forca-de-vendas/HOMOLOGACAO-PARA-INTEGRACOES.md`;
- `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-03.md`;
- `parceiros/execucoes/ferramentas/forca-de-vendas/ESTADO-DA-EXECUCAO.md`;
- `AGENTS.md`, `parceiros/AGENTS.md` e `parceiros/00-GUIA-DE-EXECUCAO.md`, somente como controles de escopo.

## Resumo causal

| ID | Achado relacionado | Unidade causal | Origem | Reexecutar Passo 01 | Reexecutar Passo 02 |
|---|---|---|---|---|---|
| `DIAG-001` | 001 | redução estrutural das 90 operações no YAML | `ORIGEM_PASSO_02` | NÃO, isoladamente | SIM |
| `DIAG-002` | 002 | query parameters e paginação omitidos | `ORIGEM_PASSO_01` | SIM | SIM |
| `DIAG-003` | 002 | sete conflitos rota sem placeholder x `erpId` path | `FONTE_OFICIAL_AMBIGUA` | SIM, para registrar | SIM |
| `DIAG-004` | 003 | 12 request bodies incorretos ou truncados | `ORIGEM_PASSO_01` | SIM | SIM |
| `DIAG-005` | 003 | identificação ausente em `PUT /subcategories` | `FONTE_OFICIAL_AMBIGUA` | SIM, para registrar | SIM |
| `DIAG-006` | 004 | códigos e respostas incompletos em 25 operações | `ORIGEM_PASSO_01` | SIM | SIM |
| `DIAG-007` | 005 | correlações sem evidência em 10 operações | `ORIGEM_PASSO_01` | SIM | SIM |
| `DIAG-008` | 006 | schemas e obrigatoriedade não preservados | `ORIGEM_PASSO_01` | SIM | SIM |
| `DIAG-009` | 006 | enum e upload obrigatório não preservados no inventário | `ORIGEM_PASSO_01` | SIM | SIM |
| `DIAG-010` | 007 | Bearer inferido em 89 operações | `ORIGEM_PASSO_01` | SIM | NÃO, isoladamente |
| `DIAG-011` | 001/dependências | condição de pagamento x método de pagamento | `ORIGEM_AMBOS` | SIM | SIM |
| `DIAG-012` | 001/dependências | clientes x representantes | `ORIGEM_PASSO_01` | SIM | SIM |
| `DIAG-013` | 001/dependências | região x tabela de preço | `ORIGEM_AMBOS` | SIM | SIM |
| `DIAG-014` | 001/dependências | ordem do vínculo cor x produto | `ORIGEM_PASSO_01` | SIM | SIM |
| `DIAG-015` | 005/008 | associação de imagem sem identificador de produto | `FONTE_OFICIAL_AMBIGUA` | SIM, para registrar | SIM |
| `DIAG-016` | 005/008 | criação de vendedor por `code` x atualização por `erpId` | `FONTE_OFICIAL_AMBIGUA` | SIM, para registrar | SIM |
| `DIAG-017` | 008 | `PUT /representatives` ausente de `PEND-006` | `ORIGEM_PASSO_01` | SIM | SIM |

## Diagnóstico detalhado

### DIAG-001 - Redução estrutural do contrato canônico

- Identificador do Passo 03: `ACHADO-03-001`.
- Categoria: suficiência operacional do contrato.
- Operações/módulos afetados: 90 operações, 26 módulos.
- Informação na fonte oficial: cada bloco de operação pode publicar parâmetros, request/response, códigos, schemas, obrigatoriedade, enums, exemplos, paginação e upload/download.
- Informação no Passo 01: o inventário define 20 campos por operação, incluindo essas dimensões, embora parte do conteúdo esteja incorreta nos achados seguintes. Exemplo: `01-inventario-operacoes.md:16-36`.
- Informação no Passo 02: cada item de `CONTRATO-DA-FERRAMENTA.yaml:74-883` contém apenas `id` e oito campos: módulo, método, rota, finalidade, correlação, sucesso, erros e rastreabilidade. Não há campos estruturados para path/query/header, body, required, schema, enum, paginação ou upload.
- Divergência exata: o Passo 02 criou uma perda estrutural adicional ao resumir informações operacionais que existiam no modelo do Passo 01. A referência de origem não substitui uma representação canônica suficiente.
- Etapa responsável: `ORIGEM_PASSO_02`.
- Evidência/rastreabilidade: `CONTRATO-DA-FERRAMENTA.yaml:73-91`; `AUDITORIA-ETAPA-02-POS-CORRECOES.md:80-91`; `HOMOLOGACAO-PARA-INTEGRACOES.md:218-231`; `AUDITORIA-ETAPA-03.md:134`.
- Ação necessária: ampliar o contrato canônico para preservar, de forma estruturada ou por referência operacional inequívoca, todas as dimensões necessárias ao mapeamento.
- Exige reexecutar Passo 01: **NÃO para esta unidade isolada**.
- Exige reexecutar Passo 02: **SIM**.

### DIAG-002 - Query parameters e paginação omitidos

- Identificador do Passo 03: `ACHADO-03-002`.
- Categoria: parâmetros de consulta e paginação.
- Operações/módulos afetados: `OP-002` Categorias, `OP-007` Clientes, `OP-010` Condições de pagamento, `OP-020` Filiais, `OP-034` Métodos de pagamento, `OP-038` Pedidos, `OP-046` Prepostos, `OP-064` Representantes e `OP-087` Vendedores.
- Informação na fonte oficial:
  - `GET /categories`: `page`, `limit`, `name` (`extraido.txt:89-102`);
  - `GET /clients`: `page`, `limit`, `name`, `cnpj`, `email`, `cellphone`, `haveCredit` (`:403-414`);
  - `GET /payment-conditions`: `page`, `limit`, `term`, `installments`, `priceAdjustment`, `erpId` (`:546-559`);
  - os outros seis blocos também publicam filtros omitidos, conforme rastreabilidade das respectivas operações.
- Informação no Passo 01: o inventário omite 16 query parameters no conjunto; `OP-046` ainda introduz o valor espúrio `Vendas`. Exemplos: `01-inventario-operacoes.md:40-60`, `:154-174`, `:222-242`, `:1051-1071`.
- Informação no Passo 02: o YAML não possui campos de parâmetros; essa perda estrutural já está contabilizada em `DIAG-001` e não é contada novamente como nova origem nesta unidade.
- Divergência exata: a captura já estava incompleta ou contaminada no inventário aprovado do Passo 01.
- Etapa responsável: `ORIGEM_PASSO_01`.
- Evidência/rastreabilidade completa: `HOMOLOGACAO-PARA-INTEGRACOES.md:97-110`; inventário nas linhas `40-60`, `154-174`, `222-242`, `451-471`, `778-798`, `868-888`, `1051-1071`, `1463-1483`, `2000-2020`.
- Ação necessária: recapturar os parâmetros diretamente no bloco oficial de cada operação e recalcular a paginação sem usar texto vizinho.
- Exige reexecutar Passo 01: **SIM**.
- Exige reexecutar Passo 02: **SIM**, para propagar o inventário corrigido.

### DIAG-003 - Conflitos entre rota e path parameter

- Identificador do Passo 03: parte de `ACHADO-03-002` e de `PEND-006`.
- Categoria: definição física da URL.
- Operações/módulos afetados: `OP-019 PUT /companies`, `OP-026 PUT /genders`, `OP-049 DELETE /agents`, `OP-061 PUT /regions`, `OP-066 PUT /representatives`, `OP-067 DELETE /representatives` e `OP-071 PUT /skus`.
- Informação na fonte oficial: as sete operações publicam rota sem `{erpId}` e, simultaneamente, declaram `erpId` obrigatório como `path`. Exemplo inequívoco: `PUT /representatives` em `extraido.txt:3574-3586`.
- Informação no Passo 01: o inventário usa `path parameters: NAO_DOCUMENTADO`; a análise registra apenas seis dos sete conflitos e omite `PUT /representatives` (`01-analise-documentacao.md:335-360`).
- Informação no Passo 02: `PEND-006` preserva os mesmos seis casos, sem resolver a URL e sem incluir `PUT /representatives` (`PENDENCIAS.md:50-57`).
- Divergência exata: a URL executável não pode ser derivada com segurança da própria fonte.
- Etapa responsável: `FONTE_OFICIAL_AMBIGUA`. A omissão específica de `PUT /representatives` no registro é tratada separadamente em `DIAG-017`.
- Evidência/rastreabilidade: fonte nas operações iniciadas em `extraido.txt:1015`, `:1392`, `:2686`, `:3304`, `:3574`, `:3638`, `:3890`; inventário nos blocos `OP-019`, `026`, `049`, `061`, `066`, `067`, `071`.
- Ação necessária: preservar literalmente o conflito, registrar pendência para todas as sete operações e obter OpenAPI corrigido ou decisão oficial. Não escolher rota por inferência.
- Exige reexecutar Passo 01: **SIM**, para registrar corretamente a ambiguidade.
- Exige reexecutar Passo 02: **SIM**, para preservar o registro atualizado.

### DIAG-004 - Request bodies incorretos ou truncados

- Identificador do Passo 03: `ACHADO-03-003`.
- Categoria: payload de requisição.
- Operações/módulos afetados: `OP-008 POST /clients`, `OP-017 PUT /colors/products/{productErpId}`, `OP-025 POST /genders`, `OP-028 POST /images`, `OP-036 PUT /payment-methods`, `OP-054 PATCH /products/visible`, `OP-068 PATCH /representatives/clients`, `OP-070 POST /skus`, `OP-073 PATCH /skus/stock`, `OP-074 PATCH /skus/grid`, `OP-077 PUT /subcategories` e `OP-090 PATCH /sellers/clients`.
- Informação na fonte oficial: os blocos publicam requests próprios. Exemplos:
  - cores/produto: lista de `colorErpId` (`extraido.txt:915-935`);
  - visibilidade: `productErpId`, `isVisibleB2B`, `isVisibleForca` (`:2930-2948`);
  - representantes/clientes: `clientErpId`, `representativeErpId` (`:3703-3721`);
  - estoque: `erpId`, `stockB2B`, `stockForca` (`:3987-4005`);
  - grade: `reference`, `grid`, `value`, `quantity` (`:4025-4043`);
  - vendedores/clientes: `sellerErpId`, `clientErpId`, `companyErpId` (`:4958-4976`).
- Informação no Passo 01: 12 bodies já estão truncados ou substituídos por resposta/erro; exemplos em `01-inventario-operacoes.md:381-400`, `:640-659`, `:1233-1252`, `:1551-1570`, `:1672-1713`, `:2066-2085`.
- Informação no Passo 02: o YAML não representa request body. Essa perda genérica já foi contada em `DIAG-001`.
- Divergência exata: ao menos 32 chaves oficiais foram omitidas e 13 chaves estranhas foram acrescentadas; em vários casos um body de resposta ou erro foi rotulado como request.
- Etapa responsável: `ORIGEM_PASSO_01`.
- Evidência/rastreabilidade: `HOMOLOGACAO-PARA-INTEGRACOES.md:112-130`; `AUDITORIA-ETAPA-03.md:136,145-153`.
- Ação necessária: refazer a captura dos 12 request bodies por bloco oficial e separar request, response, exemplo e erro.
- Exige reexecutar Passo 01: **SIM**.
- Exige reexecutar Passo 02: **SIM**.

### DIAG-005 - Identificador ausente em `PUT /subcategories`

- Identificador do Passo 03: subcausa de `ACHADO-03-003`, operação `OP-077`.
- Categoria: identificação do recurso na atualização.
- Operação/módulo afetado: `PUT /subcategories`, Subcategorias.
- Informação na fonte oficial: a descrição diz “Atualizar subcategoria por erpId”, a rota é `/subcategories`, a seção informa `No parameters` e o request mostra somente `name` e `categoryErpId`; o `erpId` aparece na resposta (`extraido.txt:4186-4215`).
- Informação no Passo 01: além de usar a resposta como request, o inventário registra correlação `erpId, categoryErpId` sem documentar onde enviar o `erpId` (`01-inventario-operacoes.md:1766-1788`).
- Informação no Passo 02: o YAML copia a correlação `erpId, categoryErpId`, mas não materializa parâmetro ou body (`CONTRATO-DA-FERRAMENTA.yaml:758-766`); não existe pendência específica.
- Divergência exata: a fonte não oferece mecanismo contratual para identificar a subcategoria a atualizar.
- Etapa responsável: `FONTE_OFICIAL_AMBIGUA`. O body incorreto do inventário permanece `ORIGEM_PASSO_01` em `DIAG-004`.
- Evidência/rastreabilidade: páginas 72-73; linhas citadas acima.
- Ação necessária: registrar uma pendência própria e obter confirmação oficial. Não inserir `erpId` em rota, query ou body por convenção.
- Exige reexecutar Passo 01: **SIM**, para registrar a lacuna.
- Exige reexecutar Passo 02: **SIM**.

### DIAG-006 - Códigos HTTP e respostas incompletos

- Identificador do Passo 03: `ACHADO-03-004`.
- Categoria: contrato de sucesso e erro.
- Operações/módulos afetados: `OP-005`, `012`, `016`, `017`, `018`, `021`, `026`, `030`, `031`, `037`, `039`, `041`, `042`, `043`, `050`, `053`, `054`, `058`, `064`, `066`, `073`, `074`, `075`, `079`, `083`.
- Informação na fonte oficial: os 25 blocos publicam códigos que não foram integralmente preservados. Exemplos: `OP-017` publica `200/404/500`; `OP-073`, `200/404/500`; `OP-074`, `200/500`; `OP-066`, `200/400/404/409/500`.
- Informação no Passo 01: o inventário omite ao menos 38 ocorrências de códigos, usa `NAO_DOCUMENTADO` onde há respostas e inclui ruído de interface em descrições.
- Informação no Passo 02: `sucesso_documentado` e `erros_documentados` são cópias exatas dos resumos do inventário; a auditoria 02 confirmou igualdade 90/90 desses campos.
- Divergência exata: a incompletude nasceu antes da canonicalização; o Passo 02 a propagou sem criar uma segunda origem.
- Etapa responsável: `ORIGEM_PASSO_01`.
- Evidência/rastreabilidade: inventário nos campos de códigos das linhas `120`, `278`, `371`, `393`, `417`, `485`, `606`, `698`, `722`, `856`, `902`, `946`, `968`, `992`, `1153`, `1223`, `1245`, `1335`, `1475`, `1519`, `1684`, `1706`, `1730`, `1824`, `1920`; `HOMOLOGACAO-PARA-INTEGRACOES.md:132-143`.
- Ação necessária: reconstruir os conjuntos de códigos/respostas por operação, sem converter ausência ou texto de interface em regra.
- Exige reexecutar Passo 01: **SIM**.
- Exige reexecutar Passo 02: **SIM**.

### DIAG-007 - Correlações sem evidência

- Identificador do Passo 03: `ACHADO-03-005`.
- Categoria: chaves de correlação.
- Operações/módulos afetados: `OP-016` e `017` Cores; `OP-019` Companhias; `OP-028` Imagens; `OP-041` Pedidos; `OP-054` Produtos; `OP-068` Representantes; `OP-074` Skus; `OP-088` e `090` Vendedores.
- Informação na fonte oficial: os blocos não sustentam 17 tokens afirmados. Caso crítico: `PATCH /sellers/clients` possui apenas `sellerErpId`, `clientErpId`, `companyErpId` no request (`extraido.txt:4958-4976`).
- Informação no Passo 01: as correlações incorretas já aparecem no inventário, por exemplo `OP-074` usa `erpId, skuErpId` em vez de `reference`, e `OP-090` omite `sellerErpId` e acrescenta oito IDs alheios (`01-inventario-operacoes.md:1713,2085`).
- Informação no Passo 02: o YAML copia literalmente essas correlações (`CONTRATO-DA-FERRAMENTA.yaml:736,880`); `BIDIRECIONALIDADE.md` também propaga agregações da matriz do Passo 01.
- Divergência exata: o erro nasceu no Passo 01 e foi copiado sem alteração relevante.
- Etapa responsável: `ORIGEM_PASSO_01`.
- Evidência/rastreabilidade completa: inventário nas linhas `378`, `400`, `446`, `659`, `953`, `1252`, `1570`, `1713`, `2041`, `2085`; `HOMOLOGACAO-PARA-INTEGRACOES.md:154-167`.
- Ação necessária: remover tokens não comprovados e derivar correlação apenas dos parâmetros, bodies e respostas da própria operação.
- Exige reexecutar Passo 01: **SIM**.
- Exige reexecutar Passo 02: **SIM**.

### DIAG-008 - Schemas e obrigatoriedade não preservados

- Identificador do Passo 03: parte de `ACHADO-03-006`.
- Categoria: schemas e required.
- Operações/módulos afetados: 27 schemas e todas as 90 operações.
- Informação na fonte oficial: o bloco de schemas em `extraido.txt:5044-5818` contém 27 schemas e 185 linhas com marcador `*` de obrigatoriedade. Os tipos completos permanecem resumidos em alguns pontos, mas nomes e marcadores são explícitos.
- Informação no Passo 01: a análise lista apenas os 27 nomes (`01-analise-documentacao.md:230-262`), enquanto o inventário registra `campos obrigatórios: NAO_DOCUMENTADO` em 90/90 operações.
- Informação no Passo 02: não há registro estruturado de schemas ou obrigatoriedade no YAML; a perda estrutural dessa dimensão já está contabilizada em `DIAG-001`.
- Divergência exata: a perda material de required já ocorreu no Passo 01. A insuficiência de tipos da fonte não justifica apagar os 185 marcadores existentes.
- Etapa responsável: `ORIGEM_PASSO_01`.
- Evidência/rastreabilidade: contagens mecânicas reproduzidas em `HOMOLOGACAO-PARA-INTEGRACOES.md:145-152` e `AUDITORIA-ETAPA-03.md:138-139`.
- Ação necessária: registrar campos e obrigatoriedade explicitamente publicados; manter como lacuna somente tipos ou detalhes realmente ausentes.
- Exige reexecutar Passo 01: **SIM**.
- Exige reexecutar Passo 02: **SIM**.

### DIAG-009 - Enum de vendedor e upload obrigatório

- Identificador do Passo 03: parte de `ACHADO-03-006`.
- Categoria: enum e upload.
- Operações/módulos afetados: `OP-087 GET /sellers` e `OP-028 POST /images`.
- Informação na fonte oficial:
  - vendedor: `type` aceita `SHOWROOM` ou `COORDINATOR` (`extraido.txt:4757-4770`);
  - imagens: `multipart/form-data` com `images * array<string>` (`:1501-1516`).
- Informação no Passo 01: `OP-087` registra apenas “Enum citado na operação”, sem os valores; `OP-028` usa uma mensagem de erro como request e marca required como `NAO_DOCUMENTADO`. A análise geral, contraditoriamente, registrava corretamente o upload e o campo `images` (`01-analise-documentacao.md:219-220`).
- Informação no Passo 02: o YAML não possui enum/upload estruturado e mantém somente finalidade resumida; a ausência estrutural já está contada em `DIAG-001`.
- Divergência exata: os artefatos aprovados do próprio Passo 01 já eram internamente inconsistentes e o inventário por operação, que alimentou o YAML, estava incompleto.
- Etapa responsável: `ORIGEM_PASSO_01`.
- Evidência/rastreabilidade: `01-inventario-operacoes.md:640-659,2000-2020`; `HOMOLOGACAO-PARA-INTEGRACOES.md:145-152`.
- Ação necessária: registrar os valores do enum e o campo obrigatório de upload no inventário por operação.
- Exige reexecutar Passo 01: **SIM**.
- Exige reexecutar Passo 02: **SIM**.

### DIAG-010 - Inferência de Bearer

- Identificador do Passo 03: `ACHADO-03-007`.
- Categoria: autenticação.
- Operações/módulos afetados: 89 operações protegidas; `POST /auth` é a operação de obtenção do token.
- Informação na fonte oficial: aparece “Authorize” e o login retorna JWT em `resource.token`, mas não há texto `Bearer`, formato do header `Authorization`, expiração, refresh ou escopos (`extraido.txt:18-58`).
- Informação no Passo 01: a análise geral registra apenas JWT e não afirma Bearer (`01-analise-documentacao.md:21-26`), mas o inventário afirma `Token JWT (Bearer), conforme seção Authorize` 89 vezes.
- Informação no Passo 02: os sete canônicos não contêm `Bearer`; README e YAML registram somente JWT via `POST /auth` (`CONTRATO-DA-FERRAMENTA.yaml:10-14`).
- Divergência exata: a afirmação positiva e sem fonte nasceu no inventário do Passo 01. A ausência oficial deve ser `NAO_DOCUMENTADO`, não uma inferência.
- Etapa responsável: `ORIGEM_PASSO_01`.
- Evidência/rastreabilidade: primeira ocorrência em `01-inventario-operacoes.md:45`; contagem 89; `HOMOLOGACAO-PARA-INTEGRACOES.md:62-71`.
- Ação necessária: remover a afirmação Bearer do inventário e criar/ajustar pendência para o formato do header.
- Exige reexecutar Passo 01: **SIM**.
- Exige reexecutar Passo 02: **NÃO para remover Bearer, isoladamente**, pois ele não está nos canônicos. O fluxo global ainda reexecuta o Passo 02 por outros achados e pela nova baseline do Passo 01.

### DIAG-011 - Dependência condição de pagamento x método de pagamento

- Identificador do Passo 03: validação de dependências, relacionada ao guarda-chuva `ACHADO-03-001`.
- Categoria: dependência de entidade.
- Operações/módulos afetados: `OP-011 POST /payment-conditions`, `OP-012 PUT /payment-conditions` e Condições/Métodos de pagamento.
- Informação na fonte oficial: requests de condições de pagamento publicam `paymentMethodErpId` (`extraido.txt:602-665`).
- Informação no Passo 01: o inventário preserva o campo nos bodies (`01-inventario-operacoes.md:253,275`), mas a matriz reduz a correlação a `erpId, companyErpId` (`01-matriz-bidirecionalidade-modulos.md:58-65`) e a análise de dependências permanece genérica.
- Informação no Passo 02: `DEPENDENCIAS.md` e `dependencias_conhecidas` reduzem o módulo a identificadores corporativos/relacionais e não materializam `paymentMethodErpId` (`CONTRATO-DA-FERRAMENTA.yaml:1041-1052`).
- Divergência exata: havia dado bruto correto no Passo 01, mas sua semântica já estava incompleta; o Passo 02 criou uma segunda perda ao não materializar a relação explícita.
- Etapa responsável: `ORIGEM_AMBOS`.
- Evidência/rastreabilidade: `HOMOLOGACAO-PARA-INTEGRACOES.md:169-180`; `AUDITORIA-ETAPA-03.md:141`.
- Ação necessária: registrar a dependência na análise/matriz e materializá-la no contrato canônico.
- Exige reexecutar Passo 01: **SIM**.
- Exige reexecutar Passo 02: **SIM**.

### DIAG-012 - Dependência clientes x representantes

- Identificador do Passo 03: validação de dependências, relacionada ao guarda-chuva `ACHADO-03-001`.
- Categoria: dependência comercial.
- Operação/módulo afetado: `OP-008 POST /clients`, Clientes/Representantes.
- Informação na fonte oficial: o request de criação de cliente contém `representativesErpIds` (`extraido.txt:461-477`).
- Informação no Passo 01: o body do inventário termina no bloco de endereços e omite `representativesErpIds` (`01-inventario-operacoes.md:176-195`); a dependência não é materializada de forma operacional.
- Informação no Passo 02: há referência ao vínculo por `PATCH /representatives/clients`, mas não à dependência existente no próprio cadastro de cliente.
- Divergência exata: a informação já desapareceu no inventário do Passo 01; a propagação não constitui nova origem independente.
- Etapa responsável: `ORIGEM_PASSO_01`.
- Evidência/rastreabilidade: `HOMOLOGACAO-PARA-INTEGRACOES.md:169-180`; `AUDITORIA-ETAPA-03.md:141`.
- Ação necessária: corrigir `OP-008` e representar separadamente criação de cliente com representantes e vínculo posterior por operação específica.
- Exige reexecutar Passo 01: **SIM**.
- Exige reexecutar Passo 02: **SIM**.

### DIAG-013 - Dependência região x tabela de preço

- Identificador do Passo 03: validação de dependências, relacionada ao guarda-chuva `ACHADO-03-001`.
- Categoria: dependência comercial e nomenclatura.
- Operação/módulo afetado: `OP-060 POST /regions`, Regiões/Tabelas de preço.
- Informação na fonte oficial: request usa `priceTablesErpId` e response usa `priceTableErpId`; a relação com tabela de preço existe, mas a grafia normativa conflita.
- Informação no Passo 01: o inventário preserva o request e sua divergência (`01-inventario-operacoes.md:1382-1392`), enquanto a matriz usa apenas `priceTableErpId` e não materializa plenamente a ambiguidade da dependência (`01-matriz-bidirecionalidade-modulos.md:240-247`).
- Informação no Passo 02: `PEND-005` preserva a divergência de nome, porém `DEPENDENCIAS.md` e o YAML não materializam a relação região x tabela de preço.
- Divergência exata: o Passo 01 possui representação semântica incompleta e o Passo 02, independentemente, perde a relação. O conflito de grafia já está corretamente pendente e não é contado como novo achado da fonte.
- Etapa responsável: `ORIGEM_AMBOS`.
- Evidência/rastreabilidade: `01-analise-documentacao.md:335-360`; `PENDENCIAS.md:41-48`; `HOMOLOGACAO-PARA-INTEGRACOES.md:169-180`.
- Ação necessária: materializar a relação sem escolher entre singular/plural; manter ambas as grafias oficiais e a pendência até confirmação.
- Exige reexecutar Passo 01: **SIM**.
- Exige reexecutar Passo 02: **SIM**.

### DIAG-014 - Ordem do vínculo cor x produto

- Identificador do Passo 03: validação de dependências, relacionada ao guarda-chuva `ACHADO-03-001`.
- Categoria: ordem de dependência.
- Operação/módulo afetado: `OP-017 PUT /colors/products/{productErpId}`, Cores/Produtos.
- Informação na fonte oficial: a rota exige `productErpId` e vincula uma lista de `colorErpId`; o produto precisa ser identificável antes do vínculo (`extraido.txt:915-935`).
- Informação no Passo 01: a ordem mínima coloca campanhas/linhas/cores antes de produtos sem distinguir cor-mestre do vínculo pós-produto (`01-analise-documentacao.md:287-296`); a matriz registra a operação, mas o body está incorreto.
- Informação no Passo 02: a mesma ordem é preservada e `productColors` aparece apenas como referência genérica de produto, sem explicitar a operação de vínculo após a existência do produto.
- Divergência exata: a distinção operacional já faltava no Passo 01; o Passo 02 a propagou.
- Etapa responsável: `ORIGEM_PASSO_01`.
- Evidência/rastreabilidade: `DEPENDENCIAS.md:19-34,58-66`; `HOMOLOGACAO-PARA-INTEGRACOES.md:169-180`.
- Ação necessária: separar cadastro de cores da operação de vínculo e registrar a precedência sustentada pelo path `productErpId`.
- Exige reexecutar Passo 01: **SIM**.
- Exige reexecutar Passo 02: **SIM**.

### DIAG-015 - Associação de imagem sem identificador do produto

- Identificador do Passo 03: `ACHADO-03-005` e `ACHADO-03-008`.
- Categoria: associação/correlação de upload.
- Operação/módulo afetado: `OP-028 POST /images`, Imagens/Produtos.
- Informação na fonte oficial: a finalidade diz associar imagens a um produto, `Parameters` informa `No parameters` e o request contém somente o campo obrigatório `images`; `productErpId` aparece na resposta, não no request (`extraido.txt:1501-1534`).
- Informação no Passo 01: o inventário afirma correlação `erpId, productErpId`, usa mensagem de erro como request e não cria pendência para o mecanismo de associação (`01-inventario-operacoes.md:640-659`).
- Informação no Passo 02: o YAML copia a correlação e `PENDENCIAS.md` não registra a lacuna.
- Divergência exata: a fonte não documenta como o produto é informado ou inferido. A correlação positiva dos artefatos não resolve essa insuficiência.
- Etapa responsável: `FONTE_OFICIAL_AMBIGUA`. As inferências nos artefatos devem ser removidas, mas a resolução técnica depende de fonte oficial adicional.
- Evidência/rastreabilidade: `HOMOLOGACAO-PARA-INTEGRACOES.md:154-165,193-214`; `AUDITORIA-ETAPA-03.md:140-143`.
- Ação necessária: registrar pendência própria e solicitar OpenAPI/exemplo oficial ou confirmação do fornecedor; manter `NAO_DOCUMENTADO` até lá.
- Exige reexecutar Passo 01: **SIM**, para remover inferência e registrar a lacuna.
- Exige reexecutar Passo 02: **SIM**.

### DIAG-016 - Criação de vendedor por `code` x atualização por `erpId`

- Identificador do Passo 03: `ACHADO-03-005` e `ACHADO-03-008`.
- Categoria: estratégia de criação/atualização e correlação.
- Operações/módulos afetados: `OP-088 POST /sellers` e `OP-089 PUT /sellers/{erpId}`, Vendedores.
- Informação na fonte oficial: criação recebe `code` e `companyErpId` e retorna somente mensagem; atualização exige `{erpId}`. Não há relação documentada entre `code` e `erpId` (`extraido.txt:4819-4847,4882-4902`).
- Informação no Passo 01: os bodies preservam `code`, mas a correlação de `OP-088` afirma `erpId, companyErpId` e não registra a ausência da ponte (`01-inventario-operacoes.md:2022-2064`).
- Informação no Passo 02: o YAML perde os bodies, copia a correlação e não cria pendência específica.
- Divergência exata: a fonte não explica como obter o `erpId` necessário para atualizar um vendedor criado por `code`.
- Etapa responsável: `FONTE_OFICIAL_AMBIGUA`. Não se pode declarar `code`, `erpId` ou outro campo como ponte sem evidência.
- Evidência/rastreabilidade: `HOMOLOGACAO-PARA-INTEGRACOES.md:154-165,298-303`; `AUDITORIA-ETAPA-03.md:140-143`.
- Ação necessária: criar pendência específica e obter resposta/exemplo oficial que estabeleça a correlação.
- Exige reexecutar Passo 01: **SIM**, para registrar a lacuna e retirar a inferência.
- Exige reexecutar Passo 02: **SIM**.

### DIAG-017 - `PUT /representatives` ausente de `PEND-006`

- Identificador do Passo 03: `ACHADO-03-008`.
- Categoria: cobertura de pendência conhecida.
- Operação/módulo afetado: `OP-066 PUT /representatives`, Representantes.
- Informação na fonte oficial: rota `/representatives` sem placeholder e `erpId * string (path)` (`extraido.txt:3574-3586`).
- Informação no Passo 01: a seção de divergências lista seis operações com esse conflito, mas omite `PUT /representatives`, embora o inventário marque o path como `NAO_DOCUMENTADO` (`01-analise-documentacao.md:335-360`; inventário `:1507-1528`).
- Informação no Passo 02: `PEND-006` copia a lista incompleta e também omite a operação (`PENDENCIAS.md:50-57`; YAML `:1089-1095`).
- Divergência exata: a omissão nasceu na síntese aprovada do Passo 01; o Passo 02 a propagou.
- Etapa responsável: `ORIGEM_PASSO_01`. O conflito técnico da própria fonte continua classificado em `DIAG-003`.
- Evidência/rastreabilidade: `HOMOLOGACAO-PARA-INTEGRACOES.md:97-110,193-214,298-303`.
- Ação necessária: incluir `PUT /representatives` na pendência sem decidir a forma correta da URL.
- Exige reexecutar Passo 01: **SIM**.
- Exige reexecutar Passo 02: **SIM**.

## Correspondência com os oito achados do Passo 03

| Achado macro | Diagnósticos que o explicam | Leitura correta da origem |
|---|---|---|
| `ACHADO-03-001` | `DIAG-001`, `011`, `012`, `013`, `014` e, como guarda-chuva, os defeitos operacionais de `002` a `009` | composto; não cabe uma única origem sem ocultar causas |
| `ACHADO-03-002` | `DIAG-002`, `003` | Passo 01 para query/paginação; fonte ambígua para rota/path |
| `ACHADO-03-003` | `DIAG-004`, `005` | Passo 01 para bodies; fonte ambígua para identificar subcategoria |
| `ACHADO-03-004` | `DIAG-006` | Passo 01 |
| `ACHADO-03-005` | `DIAG-007`, `015`, `016` | Passo 01 para correlações inventadas; fonte ambígua para imagem e vendedor |
| `ACHADO-03-006` | `DIAG-008`, `009` | Passo 01; a perda estrutural adicional do Passo 02 já está em `DIAG-001` |
| `ACHADO-03-007` | `DIAG-010` | Passo 01 |
| `ACHADO-03-008` | `DIAG-015`, `016`, `017` | fonte ambígua para duas lacunas; Passo 01 para a pendência incompleta |

## Papel das auditorias anteriores

As auditorias anteriores **não criaram** os defeitos; elas falharam em detectá-los:

1. `AUDITORIA-ETAPA-01.md:44-54` conferiu principalmente 90 identidades, 47 rotas e rastreabilidade; `:87-89` declarou que não havia divergência impeditiva, embora o inventário já contivesse os erros.
2. `AUDITORIA-ETAPA-02.md` confiou em contagens e na derivação dos artefatos aprovados; seu resultado também se tornou inválido por quebra de separação entre execução e auditoria.
3. `AUDITORIA-ETAPA-02-REVALIDACAO.md:79-83` comprovou que os oito campos do YAML coincidiam com o inventário, mas essa igualdade não demonstrou fidelidade semântica.
4. `AUDITORIA-ETAPA-02-POS-CORRECOES.md:75-91,151-160` repetiu a comparação limitada e declarou zero novos achados.
5. `AUDITORIA-ETAPA-03.md:130-143,202-214` foi a primeira a repetir a comparação semântica ampla e confirmou que os defeitos pertencem primariamente ao inventário, com perdas adicionais na canonicalização.

As ambiguidades oficiais que já estavam registradas antes do Passo 03 - nomes de campos, status x mensagem, visibilidade, texto de `PUT /brands`, sucessos ausentes e erros tipográficos - não foram contadas novamente. Elas continuam pendências, não resoluções.

## Resumo quantitativo por origem

Contagem principal por unidades causais descritas neste documento:

| Origem | Quantidade | IDs |
|---|---:|---|
| `ORIGEM_PASSO_01` | **10** | `002`, `004`, `006`, `007`, `008`, `009`, `010`, `012`, `014`, `017` |
| `ORIGEM_PASSO_02` | **1** | `001` |
| `ORIGEM_AMBOS` | **2** | `011`, `013` |
| `FONTE_OFICIAL_AMBIGUA` | **4** | `003`, `005`, `015`, `016` |
| **Total** | **17** | - |

Esta contagem não multiplica um mesmo tipo de erro pelo número de operações. Para cobertura operacional, os principais conjuntos afetados continuam sendo: 9 operações com query divergente; 7 conflitos rota/path; 12 bodies; 25 conjuntos de códigos/respostas; 10 correlações; 27 schemas/185 marcadores required; 89 afirmações Bearer.

## Menor caminho de correção necessário

Há erros materiais reais no Passo 01 (`DIAG-002`, `004`, `006` a `010`, `012`, `014`, `017`). Portanto, corrigir apenas o Passo 02 não elimina as fontes do problema.

O menor caminho é:

```text
Passo 01
-> auditoria integral do Passo 01
-> Passo 02
-> auditoria integral do Passo 02
-> Passo 03 desde o início
```

Depois do novo Passo 03, o gate ainda exigirá sua auditoria separada, conforme o Harness. Isso não foi executado nesta tarefa.

### Ordem lógica das correções futuras, sem executá-las agora

1. Corrigir o inventário do Passo 01 por operação contra a fonte oficial.
2. Registrar como pendência, sem resolver por inferência, as quatro classes de ambiguidade oficial deste diagnóstico.
3. Submeter o Passo 01 corrigido a auditoria integral e semântica.
4. Regenerar o cadastro canônico com estrutura operacional suficiente e dependências explícitas.
5. Submeter o Passo 02 a auditoria integral que compare também parâmetros, bodies, schemas, required, enums e upload.
6. Reexecutar o Passo 03 desde o início.

## Resultado deste diagnóstico

- Status da execução: **não alterado**.
- Resultado técnico, auditoria e prontidão: **não alterados**.
- Passo 01 executado: **NÃO**.
- Passo 02 executado: **NÃO**.
- Passo 03 executado: **NÃO**.
- Auditoria executada: **NÃO**.
- Artefatos técnicos corrigidos: **NENHUM**.
- Único arquivo criado por esta tarefa: `parceiros/execucoes/ferramentas/forca-de-vendas/DIAGNOSTICO-CORRECAO-POS-PASSO-03.md`.
