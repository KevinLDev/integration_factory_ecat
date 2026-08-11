# 01B — Matriz de bidirecionalidade por módulo (Força de Vendas)

Fonte primária obrigatória: parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.pdf.

Rastreabilidade auxiliar: analises/ferramentas/forca-de-vendas/01-inventario-operacoes.md e parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.extraido.txt.

Regra aplicada: cada operação foi classificada pela finalidade textual publicada no próprio bloco oficial. O verbo HTTP, isoladamente, não prova direção, idempotência, confirmação de integração nem equivalência entre identificadores.

## Convenções de leitura

- ERP -> ferramenta: o ERP envia dados ou uma ação para a API da ferramenta.
- ferramenta -> ERP: a API da ferramenta expõe dados que o ERP pode consultar.
- correlação primária documentada: identificador do recurso ou da operação presente no próprio bloco oficial. A presença de um campo com sufixo Id não prova, sozinha, equivalência entre chaves.
- IDs relacionais/dependências: referências a outra entidade, escopo ou vínculo. Esses IDs não são promovidos a correlação primária.
- NAO_DOCUMENTADO: a fonte não oferece evidência suficiente no bloco da operação.
- CAPACIDADE_NAO_CONFIRMADA: não há operação cuja finalidade sustente a direção; isso não equivale a prova de impossibilidade da API.
- a autenticação protegida é indicada pela interface da documentação, mas formato do header, prefixo, validade, renovação e escopos permanecem NAO_DOCUMENTADO em PEND-001.
- sucesso HTTP não é tratado como confirmação de integração no sistema de destino.

## Consolidação de cobertura

| Módulo | ERP -> ferramenta | ferramenta -> ERP | União |
|---|---:|---:|---:|
| Autenticação | 1 | 0 | 1 |
| Categorias | 2 | 1 | 3 |
| Campanhas | 2 | 0 | 2 |
| Clientes | 2 | 1 | 3 |
| Condições de pagamento | 3 | 1 | 4 |
| Cores | 3 | 1 | 4 |
| Companhias | 2 | 0 | 2 |
| Filiais | 3 | 1 | 4 |
| Gêneros | 3 | 1 | 4 |
| Imagens | 1 | 0 | 1 |
| Linhas | 2 | 0 | 2 |
| Marcas | 2 | 1 | 3 |
| Métodos de pagamento | 3 | 1 | 4 |
| Pedidos | 3 | 2 | 5 |
| Preços | 3 | 0 | 3 |
| Prepostos | 3 | 1 | 4 |
| Produtos | 3 | 2 | 5 |
| Prazos de entregas | 3 | 1 | 4 |
| Regiões | 3 | 2 | 5 |
| Representantes | 4 | 1 | 5 |
| Skus | 4 | 2 | 6 |
| Subcategorias | 2 | 1 | 3 |
| Tabelas de preço | 2 | 1 | 3 |
| Transportadoras | 3 | 1 | 4 |
| Variantes | 1 | 1 | 2 |
| Vendedores | 3 | 1 | 4 |
| Total | 66 | 24 | 90 |

A união contém 90 identidades método + rota, sem operação ausente, extra ou classificada nas duas direções.

## Pendências aplicáveis

As pendências abaixo preservam ausências e conflitos da fonte; nenhuma autoriza completar o contrato por convenção.

| ID | Lacuna e aplicabilidade |
|---|---|
| PEND-001 | Aplicação do JWT nas chamadas protegidas, formato do header, prefixo, expiração, renovação e escopos não documentados. |
| PEND-002 | Rate limit, quota, timeout e retry/backoff não documentados; aplica-se transversalmente. |
| PEND-003 | Idempotência não documentada; aplica-se às operações de criação, atualização, exclusão, vínculo e confirmação. |
| PEND-004 | Origem da alteração e prevenção de loop não documentadas; aplica-se aos módulos com leitura e escrita. |
| PEND-005 | Nomes conflitantes: cellphone/cellPhone, productSubcategoryErpId/subcategoryErpId, priceTablesErpId/priceTableErpId e nomes atípicos em pedidos. Preservar cada grafia sem equivalência inferida. |
| PEND-006 | PUT /companies, PUT /genders, DELETE /agents, PUT /regions, PUT /representatives, DELETE /representatives e PUT /skus declaram erpId de path sem placeholder na rota publicada. |
| PEND-007 | OpenAPI/Swagger bruto não foi fornecido; o PDF é a fonte oficial recebida. |
| PEND-008 | Sistema prevalente, ordenação temporal e política de conflito não documentados; aplica-se aos módulos com leitura e escrita. |
| PEND-009 | Reprocessamento seguro após falha parcial não documentado; aplica-se às operações mutáveis. |
| PEND-010 | Há blocos em que status HTTP e mensagem divergem; preservar ambos literalmente e não reclassificar o erro por inferência. |
| PEND-011 | isVisibleB2B/isVisibleForca e isVisible divergem no módulo Produtos; não são tratados como equivalentes. |
| PEND-012 | A descrição de sucesso de PUT /brands cita atualização de empresa; não normalizar a semântica. |
| PEND-013 | POST /brands e POST /subcategories não apresentam sucesso completo no trecho oficial; não inventar código ou payload. |
| PEND-014 | As grafias colection e ANAlist/analist são preservadas como publicadas, sem correção silenciosa. |
| PEND-015 | OP-012 não informa qual registro atualizar; OP-033, OP-077 e OP-083 dizem atualizar por erpId, mas rota, parâmetros e request não transportam o identificador do alvo. |
| PEND-016 | POST /images recebe images, porém não documenta como associar o upload ao produto nem quantidade máxima, tamanho ou tipos aceitos. |
| PEND-017 | POST /sellers usa code, PUT /sellers/{erpId} usa erpId e PATCH /sellers/clients usa sellerErpId; a ponte entre essas chaves não está documentada. |
| PEND-018 | A fonte não vincula normativamente bodies aos 27 component schemas/required e há conflitos schema x exemplo em OP-008, OP-009, OP-012, OP-022, OP-026, OP-032, OP-033, OP-036, OP-047, OP-048, OP-057, OP-066, OP-071, OP-077, OP-080, OP-083, OP-088 e OP-089. |
| PEND-019 | Em OP-041, 200, 400 e 404 aparecem sem descrição/payload; somente 500 possui semântica descrita. |
| PEND-020 | Valores categóricos vistos apenas em exemplos não formam enum exaustivo; somente OP-087 explicita SHOWROOM e COORDINATOR como domínio da operação. |

PEND-002, PEND-003, PEND-007 e PEND-009 são transversais no escopo indicado. PEND-004 e PEND-008 aplicam-se a todo módulo com operações nas duas direções. As seções de módulo destacam as pendências adicionais mais diretamente ligadas às suas operações.

## 1. Autenticação

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-001 | ERP -> ferramenta | POST /auth — autenticar o usuário e retornar token JWT. |

- Correlação primária documentada: NAO_DOCUMENTADO.
- IDs relacionais/dependências: NAO_DOCUMENTADO.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-001.
- Status: ESPECIFICO_DE_AUTENTICACAO.
- Rastreabilidade: OP-001; PDF, páginas 3–4; módulo Autenticação.

## 2. Categorias

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-002 | ferramenta -> ERP | GET /categories — listar categorias com filtro por nome e paginação. |
| OP-003 | ERP -> ferramenta | POST /categories — criar uma categoria. |
| OP-004 | ERP -> ferramenta | PUT /categories — atualizar uma categoria. |

- Correlação primária documentada: erpId da categoria, quando presente no próprio request/recurso.
- IDs relacionais/dependências: brandErpId referencia a marca.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: nenhuma além das transversais e das regras de conflito/loop.
- Status: BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO.
- Rastreabilidade: OP-002 a OP-004; PDF, páginas 4–6; módulo Categorias.

## 3. Campanhas

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-005 | ERP -> ferramenta | POST /campaigns — criar ou atualizar uma campanha. |
| OP-006 | ERP -> ferramenta | DELETE /campaigns — remover campanha por erpId. |

- Correlação primária documentada: erpId da campanha.
- IDs relacionais/dependências: NAO_DOCUMENTADO no nível necessário para esta matriz.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: CAPACIDADE_NAO_CONFIRMADA para ferramenta -> ERP.
- Status: UNIDIRECIONAL_CONFIRMADA_ERP_PARA_FERRAMENTA.
- Rastreabilidade: OP-005 a OP-006; PDF, páginas 6–7; módulo Campanhas.

## 4. Clientes

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-007 | ferramenta -> ERP | GET /clients — buscar clientes com filtros e paginação. |
| OP-008 | ERP -> ferramenta | POST /clients — criar um cliente. |
| OP-009 | ERP -> ferramenta | PUT /clients — atualizar cliente por erpId. |

- Correlação primária documentada: erpId do cliente.
- IDs relacionais/dependências: companyErpId, businessErpId, addressesErpId e representativesErpIds, conforme os blocos em que aparecem; não são equivalentes ao erpId do cliente.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-005, PEND-014 e PEND-018 em OP-008/OP-009; representativesErpIds preserva a dependência Cliente -> Representante.
- Status: BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO.
- Rastreabilidade: OP-007 a OP-009; PDF, páginas 7–10; módulo Clientes.

## 5. Condições de pagamento

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-010 | ferramenta -> ERP | GET /payment-conditions — listar condições de pagamento. |
| OP-011 | ERP -> ferramenta | POST /payment-conditions — criar uma condição de pagamento. |
| OP-012 | ERP -> ferramenta | PUT /payment-conditions — atualizar condição de pagamento. |
| OP-013 | ERP -> ferramenta | DELETE /payment-conditions/{erpId} — remover condição por erpId. |

- Correlação primária documentada: erpId em OP-010, OP-011 e OP-013; o identificador do alvo de OP-012 é NAO_DOCUMENTADO.
- IDs relacionais/dependências: paymentMethodErpId referencia Método de pagamento; companyErpId somente nos blocos que o publicam.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-015 em OP-012 e PEND-018 em OP-012.
- Status: BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO.
- Rastreabilidade: OP-010 a OP-013; PDF, páginas 10–14; módulo Condições de pagamento.

## 6. Cores

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-014 | ferramenta -> ERP | GET /colors — listar cores. |
| OP-015 | ERP -> ferramenta | POST /colors — criar uma cor. |
| OP-016 | ERP -> ferramenta | PUT /colors — atualizar cor por erpId. |
| OP-017 | ERP -> ferramenta | PUT /colors/products/{productErpId} — atualizar as cores vinculadas ao produto identificado. |

- Correlação primária documentada: erpId da cor em OP-014 a OP-016; productErpId identifica o produto alvo em OP-017.
- IDs relacionais/dependências: colorErpId identifica as cores da lista de vínculo em OP-017; productErpId e colorErpId não são equivalentes.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: o vínculo de OP-017 exige produto e cores previamente identificáveis; não usar companyErpId ou erpId como correlação de OP-016/OP-017 sem ocorrência no próprio bloco.
- Status: BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO.
- Rastreabilidade: OP-014 a OP-017; PDF, páginas 14–17; módulo Cores.

## 7. Companhias

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-018 | ERP -> ferramenta | POST /companies — criar uma empresa. |
| OP-019 | ERP -> ferramenta | PUT /companies — atualizar empresa por erpId. |

- Correlação primária documentada: erpId da companhia; em OP-019 sua declaração como path conflita com a rota sem placeholder.
- IDs relacionais/dependências: NAO_DOCUMENTADO; não promover companyErpId ausente do bloco de OP-019.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-006 em OP-019; CAPACIDADE_NAO_CONFIRMADA para ferramenta -> ERP.
- Status: UNIDIRECIONAL_CONFIRMADA_ERP_PARA_FERRAMENTA_COM_ROTA_PENDENTE.
- Rastreabilidade: OP-018 a OP-019; PDF, páginas 17–19; módulo Companhias.

## 8. Filiais

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-020 | ferramenta -> ERP | GET /branches — listar filiais. |
| OP-021 | ERP -> ferramenta | POST /branches — criar uma filial. |
| OP-022 | ERP -> ferramenta | PUT /branches — atualizar filial por erpId. |
| OP-023 | ERP -> ferramenta | DELETE /branches/{erpId} — remover filial por erpId. |

- Correlação primária documentada: erpId da filial.
- IDs relacionais/dependências: companyErpId referencia a companhia nos blocos em que aparece.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-018 em OP-022.
- Status: BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO.
- Rastreabilidade: OP-020 a OP-023; PDF, páginas 19–22; módulo Filiais.

## 9. Gêneros

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-024 | ferramenta -> ERP | GET /genders — listar gêneros. |
| OP-025 | ERP -> ferramenta | POST /genders — criar um gênero. |
| OP-026 | ERP -> ferramenta | PUT /genders — atualizar gênero por erpId. |
| OP-027 | ERP -> ferramenta | DELETE /genders/{erpId} — remover gênero por erpId. |

- Correlação primária documentada: erpId do gênero; em OP-026 sua declaração como path conflita com a rota sem placeholder.
- IDs relacionais/dependências: companyErpId somente quando publicado no próprio bloco.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-006 e PEND-018 em OP-026.
- Status: BIDIRECIONAL_PARCIAL_COM_ROTA_PENDENTE.
- Rastreabilidade: OP-024 a OP-027; PDF, páginas 22–26; módulo Gêneros.

## 10. Imagens

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-028 | ERP -> ferramenta | POST /images — enviar uma ou mais imagens em multipart/form-data para associação a produto. |

- Correlação primária documentada: NAO_DOCUMENTADO.
- IDs relacionais/dependências: a finalidade declara dependência de Produto, mas o request publica somente images e não informa productErpId.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-016; CAPACIDADE_NAO_CONFIRMADA para ferramenta -> ERP.
- Status: UNIDIRECIONAL_CONFIRMADA_ERP_PARA_FERRAMENTA_COM_ASSOCIACAO_PENDENTE.
- Rastreabilidade: OP-028; PDF, páginas 26–27; módulo Imagens.

## 11. Linhas

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-029 | ERP -> ferramenta | POST /lines — criar ou atualizar uma linha. |
| OP-030 | ERP -> ferramenta | DELETE /lines — remover linha por erpId. |

- Correlação primária documentada: erpId da linha.
- IDs relacionais/dependências: NAO_DOCUMENTADO no nível necessário para esta matriz.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: CAPACIDADE_NAO_CONFIRMADA para ferramenta -> ERP.
- Status: UNIDIRECIONAL_CONFIRMADA_ERP_PARA_FERRAMENTA.
- Rastreabilidade: OP-029 a OP-030; PDF, páginas 27–29; módulo Linhas.

## 12. Marcas

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-031 | ferramenta -> ERP | GET /brands — listar marcas. |
| OP-032 | ERP -> ferramenta | POST /brands — criar uma marca. |
| OP-033 | ERP -> ferramenta | PUT /brands — atualizar marca por erpId. |

- Correlação primária documentada: erpId em OP-031 e OP-032; o identificador do alvo de OP-033 é NAO_DOCUMENTADO.
- IDs relacionais/dependências: companyErpId referencia a companhia quando aparece no próprio bloco.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-012, PEND-013, PEND-015 e PEND-018 em OP-032/OP-033 conforme a abrangência de cada pendência.
- Status: BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO.
- Rastreabilidade: OP-031 a OP-033; PDF, páginas 29–32; módulo Marcas.

## 13. Métodos de pagamento

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-034 | ferramenta -> ERP | GET /payment-methods — listar métodos de pagamento. |
| OP-035 | ERP -> ferramenta | POST /payment-methods — criar um método de pagamento. |
| OP-036 | ERP -> ferramenta | PUT /payment-methods — atualizar método por erpId. |
| OP-037 | ERP -> ferramenta | DELETE /payment-methods/{erpId} — remover método por erpId. |

- Correlação primária documentada: erpId do método de pagamento.
- IDs relacionais/dependências: companyErpId somente quando publicado; paymentMethodErpId, no módulo Condições de pagamento, referencia este recurso.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-018 em OP-036.
- Status: BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO.
- Rastreabilidade: OP-034 a OP-037; PDF, páginas 32–35; módulo Métodos de pagamento.

## 14. Pedidos

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-038 | ferramenta -> ERP | GET /orders — listar pedidos não integrados. |
| OP-039 | ERP -> ferramenta | PATCH /orders/export/{number} — exportar o pedido identificado por number. |
| OP-040 | ERP -> ferramenta | PATCH /orders/{number} — marcar pedido como integrado e informar o número no ERP. |
| OP-041 | ERP -> ferramenta | PUT /orders/status — atualizar status e informações de NFE do pedido. |
| OP-042 | ferramenta -> ERP | GET /orders/integrated — listar pedidos integrados. |

- Correlação primária documentada: number em OP-038 a OP-040 quando publicado; erpId e number são filtros independentes em OP-042; OP-041 publica orderNumber e orderErpId, sem declarar equivalência entre eles.
- IDs relacionais/dependências: carrierErpId e clientErpId em OP-041 referenciam Transportadora e Cliente; não são correlação primária do pedido.
- Confirmação de integração: OP-039 e OP-040 documentam ações de exportação/marcação; confirmação válida no destino, atomicidade e reprocessamento permanecem NAO_DOCUMENTADO.
- Pendências específicas: PEND-005, PEND-010 e PEND-019; não normalizar number, orderNumber, orderErpId e erpId como uma única chave.
- Status: BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONFIRMACAO.
- Rastreabilidade: OP-038 a OP-042; PDF, páginas 35–43; módulo Pedidos.

## 15. Preços

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-043 | ERP -> ferramenta | POST /prices — criar preço vinculado a uma tabela de preço de um SKU. |
| OP-044 | ERP -> ferramenta | PUT /prices — atualizar preço de SKU por erpId. |
| OP-045 | ERP -> ferramenta | DELETE /prices/{erpId} — remover preço de SKU por erpId. |

- Correlação primária documentada: erpId do preço.
- IDs relacionais/dependências: skuErpId, priceTableErpId e companyErpId, quando publicados; identificam SKU, Tabela de preço e Companhia.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: CAPACIDADE_NAO_CONFIRMADA para ferramenta -> ERP.
- Status: UNIDIRECIONAL_CONFIRMADA_ERP_PARA_FERRAMENTA.
- Rastreabilidade: OP-043 a OP-045; PDF, páginas 43–45; módulo Preços.

## 16. Prepostos

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-046 | ferramenta -> ERP | GET /agents — listar os vendedores denominados agents no módulo. |
| OP-047 | ERP -> ferramenta | POST /agents — criar um vendedor/agente. |
| OP-048 | ERP -> ferramenta | PUT /agents — atualizar vendedor/agente existente. |
| OP-049 | ERP -> ferramenta | DELETE /agents — excluir vendedor/agente existente. |

- Correlação primária documentada: erpId do agente quando presente no próprio bloco; em OP-049 sua declaração como path conflita com a rota sem placeholder.
- IDs relacionais/dependências: companyErpId somente nos blocos que o publicam.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-006 em OP-049 e PEND-018 em OP-047/OP-048.
- Status: BIDIRECIONAL_PARCIAL_COM_ROTA_PENDENTE.
- Rastreabilidade: OP-046 a OP-049; PDF, páginas 45–48; módulo Prepostos.

## 17. Produtos

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-050 | ferramenta -> ERP | GET /products — listar produtos. |
| OP-051 | ERP -> ferramenta | POST /products — criar um produto. |
| OP-052 | ERP -> ferramenta | PUT /products — atualizar produto por erpId. |
| OP-053 | ferramenta -> ERP | GET /products/{erpId} — buscar produto por erpId. |
| OP-054 | ERP -> ferramenta | PATCH /products/visible — atualizar visibilidade do produto no B2B e no Força de Vendas. |

- Correlação primária documentada: erpId do produto em OP-050 a OP-053; productErpId identifica o produto em OP-054. Esses nomes não são declarados equivalentes pela fonte.
- IDs relacionais/dependências: branchErpId, brandErpId, deadlineErpId, genderErpId, categoryErpId, productSubcategoryErpId/subcategoryErpId, campaignErpId, lineErpId, companyErpId e colorErpId em productColors, somente conforme cada bloco.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-005, PEND-011 e PEND-014; a grafia conflitante dos campos e a visibilidade não devem ser normalizadas.
- Status: BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO.
- Rastreabilidade: OP-050 a OP-054; PDF, páginas 48–54; módulo Produtos.

## 18. Prazos de entregas

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-055 | ferramenta -> ERP | GET /deadlines — listar prazos de entrega. |
| OP-056 | ERP -> ferramenta | POST /deadlines — criar um prazo de entrega. |
| OP-057 | ERP -> ferramenta | PUT /deadlines — atualizar prazo por erpId. |
| OP-058 | ERP -> ferramenta | DELETE /deadlines/{erpId} — remover prazo por erpId. |

- Correlação primária documentada: erpId do prazo de entrega.
- IDs relacionais/dependências: companyErpId somente nos blocos que o publicam.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-018 em OP-057.
- Status: BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO.
- Rastreabilidade: OP-055 a OP-058; PDF, páginas 54–57; módulo Prazos de entregas.

## 19. Regiões

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-059 | ferramenta -> ERP | GET /regions — listar regiões. |
| OP-060 | ERP -> ferramenta | POST /regions — criar uma região. |
| OP-061 | ERP -> ferramenta | PUT /regions — atualizar uma região. |
| OP-062 | ferramenta -> ERP | GET /regions/{erpId} — buscar região por erpId. |
| OP-063 | ERP -> ferramenta | DELETE /regions/{erpId} — excluir região. |

- Correlação primária documentada: erpId da região; em OP-061 sua declaração como path conflita com a rota sem placeholder.
- IDs relacionais/dependências: priceTablesErpId no request e priceTableErpId na response referenciam Tabela de preço; companyErpId referencia Companhia. As duas grafias de tabela não são declaradas equivalentes.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-005 e PEND-006 em OP-061.
- Status: BIDIRECIONAL_PARCIAL_COM_ROTA_PENDENTE.
- Rastreabilidade: OP-059 a OP-063; PDF, páginas 57–61; módulo Regiões.

## 20. Representantes

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-064 | ferramenta -> ERP | GET /representatives — listar representantes com paginação e filtros. |
| OP-065 | ERP -> ferramenta | POST /representatives — criar um representante. |
| OP-066 | ERP -> ferramenta | PUT /representatives — atualizar representante por erpId. |
| OP-067 | ERP -> ferramenta | DELETE /representatives — excluir representante por erpId. |
| OP-068 | ERP -> ferramenta | PATCH /representatives/clients — vincular clientes a representantes. |

- Correlação primária documentada: erpId do representante nas operações de recurso; em OP-066 e OP-067 o erpId declarado como path conflita com a rota sem placeholder. OP-068 documenta uma associação por representativeErpId e clientErpId, sem chave primária única.
- IDs relacionais/dependências: companyErpId no cadastro quando publicado; representativeErpId e clientErpId identificam as duas pontas do vínculo em OP-068.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-006 em OP-066/OP-067 e PEND-018 em OP-066.
- Status: BIDIRECIONAL_PARCIAL_COM_ROTAS_PENDENTES.
- Rastreabilidade: OP-064 a OP-068; PDF, páginas 61–65; módulo Representantes.

## 21. Skus

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-069 | ferramenta -> ERP | GET /skus — listar SKUs. |
| OP-070 | ERP -> ferramenta | POST /skus — criar um SKU. |
| OP-071 | ERP -> ferramenta | PUT /skus — atualizar SKU por erpId. |
| OP-072 | ferramenta -> ERP | GET /skus/{erpId} — buscar SKU por erpId. |
| OP-073 | ERP -> ferramenta | PATCH /skus/stock — atualizar estoque do SKU. |
| OP-074 | ERP -> ferramenta | PATCH /skus/grid — atualizar múltiplas quantidades por referência do produto e tamanho. |

- Correlação primária documentada: erpId do SKU em OP-069 a OP-073 quando publicado; em OP-071 sua declaração como path conflita com a rota sem placeholder. OP-074 usa reference e os elementos de grid, sem erpId/skuErpId documentado no bloco.
- IDs relacionais/dependências: variantErpId e companyErpId referenciam Variante e Companhia quando publicados; value e quantity são dados da grade, não IDs relacionais.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-006 e PEND-018 em OP-071; não atribuir erpId ou skuErpId a OP-074 por inferência.
- Status: BIDIRECIONAL_PARCIAL_COM_ROTA_PENDENTE.
- Rastreabilidade: OP-069 a OP-074; PDF, páginas 65–71; módulo Skus.

## 22. Subcategorias

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-075 | ferramenta -> ERP | GET /subcategories — listar subcategorias. |
| OP-076 | ERP -> ferramenta | POST /subcategories — criar uma subcategoria. |
| OP-077 | ERP -> ferramenta | PUT /subcategories — atualizar subcategoria por erpId. |

- Correlação primária documentada: erpId em OP-075/OP-076 quando publicado; o identificador do alvo de OP-077 é NAO_DOCUMENTADO.
- IDs relacionais/dependências: categoryErpId referencia Categoria e não substitui o identificador da subcategoria.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-013 em OP-076; PEND-015 e PEND-018 em OP-077.
- Status: BIDIRECIONAL_PARCIAL_COM_ALVO_DE_ATUALIZACAO_PENDENTE.
- Rastreabilidade: OP-075 a OP-077; PDF, páginas 71–73; módulo Subcategorias.

## 23. Tabelas de preço

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-078 | ferramenta -> ERP | GET /price-tables — listar tabelas de preço. |
| OP-079 | ERP -> ferramenta | POST /price-tables — criar uma tabela de preços. |
| OP-080 | ERP -> ferramenta | PUT /price-tables — atualizar tabela de preços por erpId. |

- Correlação primária documentada: erpId da tabela de preço.
- IDs relacionais/dependências: companyErpId referencia Companhia quando publicado; priceTableErpId/priceTablesErpId em Preços e Regiões referenciam este módulo sem equivalência de grafia assumida.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-018 em OP-080; PEND-005 nas referências conflitantes vindas de Regiões.
- Status: BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO.
- Rastreabilidade: OP-078 a OP-080; PDF, páginas 73–75; módulo Tabelas de preço.

## 24. Transportadoras

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-081 | ferramenta -> ERP | GET /carriers — listar transportadoras. |
| OP-082 | ERP -> ferramenta | POST /carriers — criar uma transportadora. |
| OP-083 | ERP -> ferramenta | PUT /carriers — atualizar transportadora por erpId. |
| OP-084 | ERP -> ferramenta | DELETE /carriers/{erpId} — remover transportadora por erpId. |

- Correlação primária documentada: erpId em OP-081, OP-082 e OP-084 quando publicado; o identificador do alvo de OP-083 é NAO_DOCUMENTADO.
- IDs relacionais/dependências: companyErpId referencia Companhia quando publicado.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-015 e PEND-018 em OP-083.
- Status: BIDIRECIONAL_PARCIAL_COM_ALVO_DE_ATUALIZACAO_PENDENTE.
- Rastreabilidade: OP-081 a OP-084; PDF, páginas 75–79; módulo Transportadoras.

## 25. Variantes

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-085 | ferramenta -> ERP | GET /variants — listar variantes. |
| OP-086 | ERP -> ferramenta | POST /variants — criar uma variante. |

- Correlação primária documentada: erpId da variante.
- IDs relacionais/dependências: productErpId e companyErpId referenciam Produto e Companhia quando publicados.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: nenhuma além das transversais e das regras de conflito/loop.
- Status: BIDIRECIONAL_PARCIAL_COM_LACUNAS_DE_CONTRATO.
- Rastreabilidade: OP-085 a OP-086; PDF, páginas 79–80; módulo Variantes.

## 26. Vendedores

| ID | Direção | Operação e finalidade documentada |
|---|---|---|
| OP-087 | ferramenta -> ERP | GET /sellers — listar vendedores/showrooms com paginação e filtros. |
| OP-088 | ERP -> ferramenta | POST /sellers — criar vendedor/showroom. |
| OP-089 | ERP -> ferramenta | PUT /sellers/{erpId} — atualizar vendedor/showroom por erpId. |
| OP-090 | ERP -> ferramenta | PATCH /sellers/clients — vincular múltiplos vendedores a clientes. |

- Correlação primária documentada: OP-087 permite filtros erpId e code; OP-088 publica code; OP-089 usa erpId; OP-090 publica sellerErpId e clientErpId para a associação. A fonte não declara equivalência entre code, erpId e sellerErpId.
- IDs relacionais/dependências: companyErpId referencia Companhia em OP-088 e compõe o contexto do vínculo em OP-090; clientErpId identifica o cliente vinculado.
- Confirmação de integração: NAO_DOCUMENTADO.
- Pendências específicas: PEND-017, PEND-018 em OP-088/OP-089 e PEND-020; somente OP-087 publica explicitamente SHOWROOM e COORDINATOR.
- Status: BIDIRECIONAL_PARCIAL_COM_PONTE_DE_IDENTIFICACAO_PENDENTE.
- Rastreabilidade: OP-087 a OP-090; PDF, páginas 80–87; módulo Vendedores.

## Validação final da matriz

- módulos reconstruídos: 26/26;
- operações explicitadas por ID, método, rota, finalidade e direção: 90/90;
- ERP -> ferramenta: 66;
- ferramenta -> ERP: 24;
- união: 90;
- operações duplicadas entre direções: 0;
- correlação primária separada de IDs relacionais/dependências: 26/26 módulos;
- pendências preservadas: PEND-001 a PEND-020;
- autenticação sem formato de header ou prefixo inferido;
- equivalências entre IDs não inferidas;
- idempotência, prevenção de loop, política de conflito e reprocessamento seguro: NAO_DOCUMENTADO;
- confirmação de integração no destino: NAO_DOCUMENTADO, inclusive quando a fonte publica sucesso HTTP.

Conclusão: a matriz cobre integralmente as 90 operações e as duas perspectivas exigidas, mas registra capacidade documental, não homologação operacional. As pendências precisam permanecer explícitas nas etapas seguintes.
