# MATRIZ ERP x FERRAMENTA — Bling x Força de Vendas

## Como ler

- Direção segue a convenção de `ferramentas/forca-de-vendas/MODULOS.md`: `ERP -> ferramenta` (Bling
  envia/expõe dado que a Força de Vendas consome) e `ferramenta -> ERP` (a Força de Vendas envia dado
  que o Bling recebe/persiste).
- `COMPATIBILIDADE`: `COMPATIVEL` | `COMPATIVEL_COM_ADAPTACAO` | `PARCIAL` | `NAO_SUPORTADO` |
  `PENDENTE_DE_EVIDENCIA`.
- `GAP` descreve especificamente o que falta, nunca "não compatível" genérico.
- Nenhuma direção foi marcada sem operação real do Bling que a sustente (regra do Passo 02).
- Esta é uma análise de **primeira passada, em nível de módulo**, apoiada em evidência mecânica
  (contagens/greps reais sobre o OpenAPI) e nos artefatos aprovados da ferramenta. Comparação
  campo-a-campo exaustiva (schema x schema, todas as 90 operações da ferramenta x as 257 do Bling) é
  trabalho de granularidade maior, típico do Passo 05 (Projetar Integração e Mapeamento Semântico); ver
  `PENDENCIAS.md` desta pasta.

## Achado estrutural mais importante desta análise

Três pilares do modelo comercial da Força de Vendas — **Marca** (entidade), **Região** e **Tabela de
Preço** — **não têm nenhum recurso de API dedicado no Bling** (verificado mecanicamente: zero rotas,
zero schemas, exceto referências soltas de ID sem CRUD). Como `RN-FDV-PRE-001/002` (preço varia por
tabela/região) e `RN-FDV-MAR-001` (produto deve ter marca) dependem diretamente disso, este é o gap
mais crítico da combinação e deve orientar a decisão de escopo do Passo 03 (Projetar Homologação).

## Matriz por módulo (26 módulos da Força de Vendas)

| MODULO (Força de Vendas) | CAPACIDADE_EXIGIDA_PELA_FERRAMENTA | CAPACIDADE_DISPONIVEL_NO_ERP | DIRECAO_POSSIVEL | COMPATIBILIDADE | GAP | EVIDENCIA_FONTE |
|---|---|---|---|---|---|---|
| 1. Autenticação | Obter JWT via `POST /auth` para autenticar chamadas à API da própria ferramenta | Bling tem seu **próprio** OAuth2 (não é o mesmo sistema) | N/A — infraestrutura, não módulo de dados | N/A | Integração real precisa gerenciar **duas** autenticações independentes (Bling OAuth2 + FDV JWT) | `MODULOS.md` #1; `ANALISE-DO-ERP.md` seção 1 |
| 2. Categorias | Categoria vinculada a `brandErpId`; consulta/criação/atualização | `CategoriasProdutos`: LER/CRIAR/ATUALIZAR/EXCLUIR, hierárquico via `categoriaPai` | BIDIRECIONAL | COMPATIVEL_COM_ADAPTACAO | Sem vínculo nativo com Marca (Marca não existe no Bling) | `CAPACIDADES-DO-ERP.md` (CategoriasProdutos); `MODULOS.md` #2 |
| 3. Campanhas | Criar/atualizar/excluir campanha vinculada a produto (`campaignErpId`) | Nenhum recurso equivalente | — | NAO_SUPORTADO | Sem entidade "Campanha" no Bling (verificação mecânica: 0 ocorrências) | `ANALISE-DO-ERP.md` seção 8; `MODULOS.md` #3 |
| 4. Clientes | Consulta/criação/atualização; `representativesErpIds[]` (múltiplos), `companyErpId`, `businessErpId`, `addressesErpId` | `Contatos`: LER/CRIAR/ATUALIZAR/EXCLUIR; `vendedor.id` **singular**; `endereco.geral`/`endereco.cobranca`; `financeiro` | BIDIRECIONAL | COMPATIVEL_COM_ADAPTACAO | Bling só permite 1 vendedor por contato (FDV permite múltiplos representantes); sem `companyErpId`/`businessErpId` equivalentes | `CAPACIDADES-DO-ERP.md` (Contatos); `MODULOS.md` #4 |
| 5. Condições de pagamento | Consulta/criação/atualização/exclusão; referencia `paymentMethodErpId` | Sem entidade separada; fundida em `FormasPagamentos.condicao` (string livre) | BIDIRECIONAL (com adaptação) | PARCIAL | Bling não separa "método" de "condição" como duas entidades; `condicao` é texto livre, não estrutura de parcelas tipada | `CAPACIDADES-DO-ERP.md` (FormasPagamentos); `MODULOS.md` #5 |
| 6. Cores | Consulta/criação/atualização; vínculo `PUT /colors/products/{productErpId}` | Nenhum recurso equivalente; cor só existe como texto dentro de `variacao.nome` | — | NAO_SUPORTADO | Sem entidade "Cor" com ID próprio no Bling | `ANALISE-DO-ERP.md` seção 8; `MODULOS.md` #6 |
| 7. Companhias | Criar/atualizar múltiplas companhias (`companyErpId` referenciado em quase todos os módulos) | Bling é single-tenant por conta; `Empresas` (`GET /empresas/me/dados-basicos`) é somente a própria empresa da conta, sem CRUD | LEITURA (da própria empresa apenas) | NAO_SUPORTADO | Bling não modela múltiplas companhias dentro de uma conta como a ferramenta espera | `ANALISE-DO-ERP.md` seção 8; `MODULOS.md` #7 |
| 8. Filiais | Consulta/criação/atualização/exclusão; `companyErpId` | `unidadeNegocio.id` aparece como referência em Loja/Vendas/Contratos/Orçamentos; nenhum endpoint de listagem/CRUD de unidades de negócio encontrado nos 43 recursos | PENDENTE_DE_EVIDENCIA | PENDENTE_DE_EVIDENCIA | Não foi possível confirmar se unidades de negócio são geridas por API nesta especificação | `CAPACIDADES-DO-ERP.md`; busca mecânica em `FONTES.md` |
| 9. Gêneros | Consulta/criação/atualização/exclusão | Nenhum recurso equivalente | — | NAO_SUPORTADO | Classificação de gênero (vestuário) não existe no Bling; `CamposCustomizados` é via de adaptação possível, não nativa | `ANALISE-DO-ERP.md` seção 8; `MODULOS.md` #9 |
| 10. Imagens | Upload `multipart/form-data` (`POST /images`), associação a produto não documentada na ferramenta (`PEND-016`) | Imagens via **URL** (`midia.imagens.imagensURL`), enviadas dentro do payload de Produto, não por upload separado | BIDIRECIONAL (com adaptação) | COMPATIVEL_COM_ADAPTACAO | Mecanismo diferente: Bling espera URL pública da imagem, não recebe arquivo binário | `CAPACIDADES-DO-ERP.md` (Produtos); `MODULOS.md` #10 |
| 11. Linhas | Criar/atualizar/excluir (`lineErpId` em produto) | `ProdutosLinhaProdutoDTO` é referência de `id` em `tributacao.linhaProduto`; nenhum endpoint de CRUD/listagem encontrado | PENDENTE_DE_EVIDENCIA | PENDENTE_DE_EVIDENCIA / NAO_SUPORTADO para criação | Sem confirmação de como uma "linha" é criada/listada via API | `CAPACIDADES-DO-ERP.md`; busca mecânica em `ANALISE-DO-ERP.md` |
| 12. Marcas | Consulta/criação/atualização; `RN-FDV-MAR-001`: produto deve ter marca | Nenhuma entidade; `marca` é campo de texto livre em Produto, sem ID | ERP -> ferramenta (só como texto) | NAO_SUPORTADO | Gap crítico: Marca não é entidade no Bling, apenas string no produto — sem ID, sem CRUD próprio, sem vínculo com Categoria/Prazo | `ANALISE-DO-ERP.md` seção 8; `MODULOS.md` #12; `REGRAS-DE-NEGOCIO.md` `RN-FDV-MAR-001..004` |
| 13. Métodos de pagamento | Consulta/criação/atualização/exclusão; dependência de Condições de pagamento | Mesmo caso do item 5 — fundido em `FormasPagamentos` | BIDIRECIONAL (com adaptação) | PARCIAL | Mesma limitação estrutural do item 5 | `CAPACIDADES-DO-ERP.md` (FormasPagamentos); `MODULOS.md` #13 |
| 14. Pedidos | `GET /orders` (não integrados), `PATCH export/{number}`, `PATCH /orders/{number}`, `PUT /orders/status`, `GET /orders/integrated` | `PedidosVenda`: LER/CRIAR/ATUALIZAR/EXCLUIR completos; `PATCH .../situacoes/{idSituacao}` via sistema genérico de Situações/Transições; ações de lançar estoque/contas, gerar NF-e/NFC-e | BIDIRECIONAL | COMPATIVEL_COM_ADAPTACAO | Modelo de ciclo de vida diferente: FDV usa export/mark-integrated explícitos; Bling usa máquina de situações configurável — requer mapear situações Bling <-> `RN-FDV-PED-001..007`/`RN-FDV-EXP-001/002` | `CAPACIDADES-DO-ERP.md` (PedidosVenda); `DEPENDENCIAS.md` seção "Pedidos e confirmação de integração"; `MODULOS.md` #14 |
| 15. Preços | Criar/atualizar/excluir; depende de `skuErpId` + `priceTableErpId` (+`companyErpId`) | Nenhuma tabela de preço; produto tem `preco` único (+ `precoPromocional` por canal em `ProdutosLojas`) | ERP -> ferramenta (preço único apenas) | NAO_SUPORTADO | Gap crítico: sem conceito de tabela de preço múltipla/regional no Bling | `ANALISE-DO-ERP.md` seção 8; `MODULOS.md` #15; `REGRAS-DE-NEGOCIO.md` `RN-FDV-PRE-001..004` |
| 16. Prepostos | Consulta/criação/atualização/exclusão | Nenhum conceito de "preposto" (vendedor auxiliar); `Vendedores` é genérico e somente leitura | — | NAO_SUPORTADO | Hierarquia representante/preposto não existe no Bling | `ANALISE-DO-ERP.md` seção 8; `MODULOS.md` #16; `REGRAS-DE-NEGOCIO.md` `RN-FDV-RP-001/002` |
| 17. Produtos | Consulta/criação/atualização/busca por `erpId`/alteração de visibilidade | `Produtos`: LER/CRIAR/ATUALIZAR(PUT+PATCH)/EXCLUIR completos; `situacao` (A/I) apenas, sem visibilidade multicanal nativa | BIDIRECIONAL | COMPATIVEL_COM_ADAPTACAO | Sem campos equivalentes a `isVisibleB2B`/`isVisibleForca` (`PEND-011` da ferramenta); `ProdutosLojas` é candidato de adaptação por canal | `CAPACIDADES-DO-ERP.md` (Produtos, ProdutosLojas); `MODULOS.md` #17 |
| 18. Prazos de entrega | Consulta/criação/atualização/exclusão; vinculado a marca (`deadlineErpId`) | Nenhum conceito comercial equivalente; `Logisticas.servicos.estimativaEntrega` é SLA de transporte, não prazo comercial por marca/disponibilidade | — | NAO_SUPORTADO | Conceitos diferentes: SLA de transportadora não é o mesmo que prazo comercial vinculado a marca | `ANALISE-DO-ERP.md` seção 8; `MODULOS.md` #18; `REGRAS-DE-NEGOCIO.md` `RN-FDV-PRA-001..007` |
| 19. Regiões | Consulta/criação/atualização/busca/exclusão; vinculada a Tabela de preço | Nenhum recurso equivalente | — | NAO_SUPORTADO | Gap crítico, agrava o item 15 (sem Região nem Tabela de Preço, o modelo territorial de preço da ferramenta não tem onde se apoiar no Bling) | `ANALISE-DO-ERP.md` seção 8; `MODULOS.md` #19; `REGRAS-DE-NEGOCIO.md` `RN-FDV-REG-001..004` |
| 20. Representantes | Consulta/criação/atualização/exclusão/vínculo com clientes | `Vendedores`: **somente leitura**; vínculo cliente-vendedor existe via `Contatos.vendedor.id` | LEITURA + vínculo parcial | PARCIAL | Criar/atualizar/excluir vendedor **não é suportado** via API Bling (confirmado mecanicamente: só `GET`) | `CAPACIDADES-DO-ERP.md` (Vendedores); `MODULOS.md` #20 |
| 21. Skus | Consulta/criação/atualização/busca/estoque/grade; referencia `variantErpId` | Variação do Bling **é** a unidade com estoque/preço próprios (2 níveis: Produto -> Variação, não Produto -> Variante -> SKU) | BIDIRECIONAL | COMPATIVEL_COM_ADAPTACAO | Hierarquia de 2 níveis no Bling vs. 3-4 níveis na ferramenta; requer decisão de mapeamento | `CAPACIDADES-DO-ERP.md` (ProdutosVariacoes); `DEPENDENCIAS.md` seção "Variantes, SKUs e preços"; `MODULOS.md` #21 |
| 22. Subcategorias | Consulta/criação/atualização; `categoryErpId` | Mesma entidade `CategoriasProdutos`, recursiva via `categoriaPai` | BIDIRECIONAL | COMPATIVEL_COM_ADAPTACAO | Uma entidade genérica recursiva no Bling em vez de duas entidades distintas na ferramenta | `CAPACIDADES-DO-ERP.md` (CategoriasProdutos); `MODULOS.md` #22 |
| 23. Tabelas de preço | Consulta/criação/atualização | Nenhum recurso equivalente | — | NAO_SUPORTADO | Mesmo gap crítico do item 15/19 | `ANALISE-DO-ERP.md` seção 8; `MODULOS.md` #23 |
| 24. Transportadoras | Consulta/criação/atualização/exclusão | Dois candidatos parciais: `Contato` tipo transportador (simples: nome/CNPJ/IE/endereço) ou `Logisticas` (robusto, amarrado a integrações reais de frete) | BIDIRECIONAL (via Contatos) | PARCIAL | Nenhum dos dois é um "cadastro simples de transportadora" 1:1 com o que a ferramenta espera; decisão de qual usar pertence ao Passo 05 | `CAPACIDADES-DO-ERP.md` (Logisticas); busca mecânica "transport" em `FONTES.md`; `MODULOS.md` #24 |
| 25. Variantes | Consulta e criação; `productErpId` | Mesmo caso do item 21 — Bling não distingue Variante de SKU | BIDIRECIONAL | COMPATIVEL_COM_ADAPTACAO | Mesmo gap estrutural do item 21 | `CAPACIDADES-DO-ERP.md` (ProdutosVariacoes); `MODULOS.md` #25 |
| 26. Vendedores | Consulta/criação/atualização; vínculo com clientes; `OP-087` distingue `SHOWROOM`/`COORDINATOR` | `Vendedores`: **somente leitura**; é um `Contato` com `comissoes[]`/`descontoLimite` | LEITURA + vínculo | PARCIAL | Sem criação/atualização de vendedor via API; sem distinção `SHOWROOM`/`COORDINATOR` no Bling | `CAPACIDADES-DO-ERP.md` (Vendedores); `MODULOS.md` #26 |

## Contagem de compatibilidade (26 módulos)

| Compatibilidade | Módulos | Quantidade |
|---|---|---:|
| COMPATIVEL_COM_ADAPTACAO | Categorias, Clientes, Imagens, Pedidos, Produtos, Skus, Subcategorias, Variantes | 8 |
| PARCIAL | Condições de pagamento, Métodos de pagamento, Representantes, Transportadoras, Vendedores | 5 |
| NAO_SUPORTADO | Campanhas, Companhias, Cores, Gêneros, Marcas, Prazos de entrega, Preços, Regiões, Tabelas de preço | 9 |
| PENDENTE_DE_EVIDENCIA | Filiais, Linhas | 2 |
| N/A (infraestrutura) | Autenticação | 1 |
| COMPATIVEL (sem ressalva) | — | 0 |

**Nenhum dos 26 módulos foi classificado como totalmente `COMPATIVEL` sem ressalva.** Isso é esperado
nesta granularidade (o Bling é um ERP genérico, a Força de Vendas foi desenhada com vocabulário de
distribuidora multimarca/multi-representante) e não significa que a integração seja inviável — significa
que decisões de adaptação/escopo são necessárias antes do Passo 04.

## Cobertura funcional por modo (7 modos de `CENARIOS-FUNCIONAIS.md`)

| MODO | DADOS_NECESSARIOS | CAPACIDADES_DISPONIVEIS_NO_ERP | CAPACIDADES_FALTANTES | IMPACTO | EVIDENCIA |
|---|---|---|---|---|---|
| 1. Direto | cliente, filial/origem, tabela/preço, produtos, grade, estoque, condição de pagamento, pedido | Contatos, Produtos, Variação(grade), Estoques, FormasPagamentos, PedidosVenda | Tabela de preço por região (item 15/19/23 da matriz) | DEGRADA_MODO — pedido pode ser montado, mas sem diferenciação de preço por região/tabela | `CENARIOS-FUNCIONAIS.md` Modo 1; linhas 15/19/23 desta matriz |
| 2. Código de Barras | produto, referência, EAN, SKU/variação, grade, preço, estoque | Campo `gtin`/`gtinEmbalagem` nativo em Produto + filtro `gtins[]` em `GET /produtos`; preço/estoque disponíveis | Nenhuma faltante identificada nesta análise de módulo | NAO_IMPACTA_MODO (favorável — Bling documenta EAN de forma explícita, melhor que muitos módulos) | `CAPACIDADES-DO-ERP.md` (Produtos: `gtin`) |
| 3. Galeria | produto, referência, imagens, cores, variações/grade, marca, categoria, preço, estoque | Produtos, imagens (via URL), variações, categorias, preço, estoque | Cor como entidade filtrável (item 6); Marca como entidade (item 12) — restam como texto livre | DEGRADA_MODO — galeria funciona, mas sem filtro estruturado por cor/marca via API | `CENARIOS-FUNCIONAIS.md` Modo 3; linhas 6/12 desta matriz |
| 4. Link E-commerce | produtos, referências, imagens, clientes, preços, estoque, grades, condições comerciais | Produtos, Contatos, Estoques, FormasPagamentos disponíveis | Tabela de preço/condições comerciais por região (mesmo gap do Modo 1) | DEGRADA_MODO | `CENARIOS-FUNCIONAIS.md` Modo 4 |
| 5. Passo a Passo | marca, entrega/prazo, tipo, gênero, campanha, categoria, subcategoria, linha, estoque/faixa | Categorias/Subcategorias, `tipo` de produto, estoque | Marca, Gênero, Campanha, Linha (itens 9/11/12) — quatro dos classificadores citados não têm entidade própria no Bling | DEGRADA_MODO — navegação progressiva perde vários filtros estruturados | `CENARIOS-FUNCIONAIS.md` Modo 5; linhas 3/9/11/12 desta matriz |
| 6. Referência | referência, produto, SKU/variação, preço, estoque, grade | `codigo` de Produto/Variação funciona como referência; preço/estoque disponíveis | Nenhuma faltante identificada nesta análise de módulo | NAO_IMPACTA_MODO | `CAPACIDADES-DO-ERP.md` (Produtos, ProdutosVariacoes) |
| 7. Replicar | múltiplos clientes, CNPJ, produtos, referências, grades, quantidades, preços, estoque, condições comerciais, pedidos independentes | Contatos (múltiplos), Produtos, PedidosVenda (independentes por cliente) | Preço/condição comercial diferenciada por cliente/tabela (mesmo gap do Modo 1) | DEGRADA_MODO — réplica funciona estruturalmente, mas sem diferenciação comercial por tabela/região | `CENARIOS-FUNCIONAIS.md` Modo 7; linhas 15/19/23 desta matriz |

Nenhum modo foi classificado como `BLOQUEIA_MODO`: em todos os casos há uma via de montagem do pedido,
ainda que com perda de granularidade comercial (preço único em vez de por tabela/região) ou de
classificadores (marca/gênero/cor como texto livre em vez de entidade filtrável).

## Cobertura por regra de negócio (referência a `RN-FDV-*`, sem duplicar o texto integral)

| REGRA_DE_NEGOCIO | DADOS_NECESSARIOS | CAPACIDADE_ERP | EVIDENCIA | IMPACTO | STATUS |
|---|---|---|---|---|---|
| `RN-FDV-MAR-001` (produto deve ter marca) | Marca como atributo do produto | `marca` é string livre em Produto, sem ID/CRUD | linha 12 da matriz | Impede tratar marca como entidade correlacionável (só texto) | PARCIAL |
| `RN-FDV-PRE-001/002` (tabela de preço varia por região; mesmo produto pode ter preço diferente por tabela) | Tabela de preço, Região, Preço por tabela | Nenhum recurso Bling equivalente | linhas 15/19/23 da matriz | Preço único no Bling não sustenta a regra comercial de precificação regional | NAO_SUPORTADO |
| `RN-FDV-REG-002` (região se relaciona a tabela de preço) | Região, Tabela de preço | Nenhum recurso Bling equivalente | linha 19 da matriz | Mesmo gap acima | NAO_SUPORTADO |
| `RN-FDV-GRA-001` (grade aberta por tamanho) | Grade, quantidade por tamanho | Variação do Bling (grade via nome livre) + estoque por variação | `CAPACIDADES-DO-ERP.md` (ProdutosVariacoes) | Cobertura nativa | COMPATIVEL_COM_ADAPTACAO |
| `RN-FDV-GRA-002` (grade fechada com pack) | Pack/composição fixa vendida como unidade | `ProdutosEstruturas` (`formato: E` + `lancamentoEstoque: M`) modela produto pai composto por componentes de quantidade fixa, com estoque decrementado só nos componentes — reexaminado em profundidade nesta revisão (ver `DIAGNOSTICO-CORRECAO-20260821.md`) | `CAPACIDADES-DO-ERP.md` (ProdutosEstruturas, seção "reexaminado nesta revisão") | Estrutura confirmada por schema; falta apenas confirmar (a) se variação pode ser componente de outro produto e (b) comportamento em runtime (Passo 07) | COMPATIVEL_COM_ADAPTACAO |
| `RN-FDV-PED-001/002/003` (pedido nasce pendente; criação ≠ exportação; exportação é marco oficial) | Estado do pedido, evento de exportação | `PedidosVenda` + sistema de Situações/Transições do Bling pode modelar estados customizados | linha 14 da matriz | Tecnicamente viável, mas exige configuração/mapeamento explícito das situações — não é automático | COMPATIVEL_COM_ADAPTACAO |
| `RN-FDV-PRA-001..007` (prazo de entrega vinculado a marca/disponibilidade) | Prazo comercial por marca | Sem equivalente; `estimativaEntrega` é SLA de transporte, conceito diferente | linha 18 da matriz | Regra de prazo comercial não tem onde se apoiar tecnicamente no Bling | NAO_SUPORTADO |
| `RN-FDV-DISP-001/002` (pronta entrega / não pronta entrega) | Flag de disponibilidade | Sem campo equivalente identificado nesta passada em Produto | `ANALISE-DO-ERP.md`; não aprofundado | Requer verificação campo-a-campo futura | PENDENTE_DE_EVIDENCIA |
| `RN-FDV-ORI-001/002` (fluxo separa nacional/importado) | Origem do produto | Bling tem `tributacao.origem` (0-8, códigos fiscais de origem NCM/ICMS) — cobre a distinção fiscal nacional/estrangeira, mas não confirma se sustenta a separação **comercial** de fluxo que a regra descreve | `CAPACIDADES-DO-ERP.md` (tributação) | Existe campo fiscal correlato; equivalência comercial não confirmada | PENDENTE_DE_EVIDENCIA |
| `RN-FDV-ABC-001..004` (Curva ABC depende de pedidos) | Histórico de pedidos por marca/produto/categoria/cliente/representante | `PedidosVenda` com filtros por vendedor/contato/data; agregação por marca não é possível via API pois Marca não é entidade | linhas 12 e 14 da matriz | Curva ABC por marca especificamente ficaria limitada pela ausência de Marca como entidade | PARCIAL |

Regras não listadas acima (`RN-FDV-CLI-*`, `RN-FDV-FIL-*`, `RN-FDV-RP-*`, `RN-FDV-LINK-*`,
`RN-FDV-MOD-*`, `RN-FDV-ADM-*`) têm impacto já coberto pelas linhas de módulo correspondentes na matriz
principal (Clientes, Filiais, Representantes/Prepostos, modos funcionais) e não foram duplicadas aqui.

## Rastreabilidade

- Fonte ERP: `erps/bling/ANALISE-DO-ERP.md`, `erps/bling/CAPACIDADES-DO-ERP.md`, `erps/bling/FONTES.md`.
- Fonte ferramenta: `ferramentas/forca-de-vendas/MODULOS.md`, `DEPENDENCIAS.md`, `BIDIRECIONALIDADE.md`,
  `PENDENCIAS.md`, `REGRAS-DE-NEGOCIO.md`, `CENARIOS-FUNCIONAIS.md`.
- Pendências desta combinação: `erps/bling/integracoes/forca-de-vendas/PENDENCIAS.md`.
