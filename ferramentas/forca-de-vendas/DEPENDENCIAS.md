# Dependências conhecidas entre entidades

As dependências abaixo foram reconstruídas a partir da seção 7 e do inventário operação por operação do Passo 01 corrigido, aprovado por `AUDITORIA-ETAPA-01-POS-CORRECOES-PASSO-03.md`, e reconferidas contra a documentação oficial.

Elas registram somente referências publicadas em parâmetros, requests, responses e finalidades. Um identificador relacional não é promovido automaticamente a chave de correlação, obrigatoriedade operacional, equivalência entre grafias, garantia transacional ou regra comercial.

## Referência corporativa

- `companyErpId` referencia Companhia somente nos blocos que publicam esse campo.
- A referência aparece, conforme cada operação, em entidades como marcas, clientes, condições e métodos de pagamento, tabelas de preço, regiões, produtos, preços, transportadoras, filiais e vendedores.
- A presença de `companyErpId` não torna os demais identificadores do mesmo payload equivalentes ao identificador da Companhia.

Evidência: campos dos requests e responses registrados em `01-inventario-operacoes.md`; operações dos módulos Companhias e entidades relacionadas no PDF oficial.

## Condição de pagamento e método de pagamento — DIAG-011

- `payment-conditions` referencia `payment-methods` por `paymentMethodErpId`.
- `OP-011 POST /payment-conditions` publica `paymentMethodErpId` no request e na response.
- `OP-012 PUT /payment-conditions` publica `paymentMethodErpId` no request e na response; o identificador da condição que será atualizada permanece `NAO_DOCUMENTADO` em `PEND-015`.
- `OP-010 GET /payment-conditions` e `OP-013 DELETE /payment-conditions/{erpId}` também publicam `paymentMethodErpId` nas responses.
- Métodos de pagamento precedem condições de pagamento na ordem parcial sustentada pela referência publicada. Isso não transforma `paymentMethodErpId` em chave de correlação da condição nem projeta os `required` do component schema sobre a operação; ver `PEND-018`.
- `companyErpId` deve ser considerado somente nas operações de condição que efetivamente o publicam.

Evidência: `OP-010` a `OP-013`; PDF oficial, páginas 10–14; extração vinculada, linhas 546–752; seção 7 da análise corrigida; parcela do Passo 02 em `DIAG-011`.

## Região e tabela de preço — DIAG-013

- `regions` referencia `price-tables`.
- Em `OP-060 POST /regions`, o request usa `priceTablesErpId`, a response usa `priceTableErpId` e a resposta `404` documenta “Tabela de preço não encontrada”.
- As responses de `OP-059 GET /regions`, `OP-061 PUT /regions` e `OP-062 GET /regions/{erpId}` publicam `priceTableErpId`.
- As duas grafias oficiais, `priceTablesErpId` e `priceTableErpId`, são preservadas sem equivalência normativa inferida; a divergência permanece em `PEND-005`.
- Tabelas de preço precedem a criação de regiões na ordem parcial baseada na referência publicada. Não se infere que o request de atualização `OP-061`, que não publica campo de tabela, altere essa associação.
- Em `OP-061`, o `erpId` é declarado como path parameter, mas a rota publicada não contém placeholder; a construção da URL permanece bloqueada por `PEND-006`.

Evidência: `OP-059` a `OP-062`; PDF oficial, páginas 57–60; extração vinculada, linhas 3182–3407; seção 7 da análise corrigida; parcela do Passo 02 em `DIAG-013`.

## Hierarquia de catálogo

1. `brands` referencia `companyErpId` nos blocos que o publicam.
2. `categories` referencia `brandErpId`.
3. `subcategories` referencia `categoryErpId`.
4. Em `OP-077 PUT /subcategories`, o mecanismo para informar o `erpId` do alvo permanece `NAO_DOCUMENTADO` em `PEND-015`.

Evidência: `POST` e `PUT` dos módulos Marcas, Categorias e Subcategorias no inventário corrigido e no PDF oficial.

## Clientes, representantes e vínculos comerciais

- `OP-008 POST /clients` pode referenciar `representativesErpIds`; quando o campo for usado, os representantes precisam estar previamente identificáveis.
- `PATCH /representatives/clients` publica `representativeErpId` e `clientErpId`; ambas as entidades precisam estar identificáveis para o vínculo.
- `PATCH /sellers/clients` publica `sellerErpId`, `clientErpId` e `companyErpId`; a ponte entre as chaves de vendedor permanece separadamente pendente em `PEND-017`.
- A criação de cliente com `representativesErpIds` e o vínculo posterior por operação específica são capacidades distintas; uma não substitui a outra.

Evidência: `OP-008`, operações do módulo Representantes e `OP-090`; inventário corrigido e PDF oficial.

## Produto e seus pré-requisitos documentados

`products` referencia, conforme o corpo publicado de cada operação:

- `branchErpId`;
- `brandErpId`;
- `deadlineErpId`;
- `genderErpId`;
- `categoryErpId`;
- `productSubcategoryErpId`;
- `campaignErpId`;
- `lineErpId`;
- `productColors`.

Cores-mestre podem existir antes do produto. O vínculo `PUT /colors/products/{productErpId}` depende de produto e cores identificáveis e não deve ser antecipado para antes dessas entidades.

Evidência: `POST /products`, `PUT /products`, `PUT /colors/products/{productErpId}` e seção 7 da análise corrigida.

## Variantes, SKUs e preços

1. `variants` referencia `productErpId`.
2. `skus` referencia `variantErpId`.
3. `prices` referencia `skuErpId` e `priceTableErpId`.
4. A cadeia parcial documentada é `produto -> variante -> SKU -> preço`, com `tabela de preço -> preço` como dependência adicional.

Evidência: `POST /variants`, `POST` e `PUT /skus`, `POST` e `PUT /prices`.

## Imagens e produto

`OP-028 POST /images` declara associação de imagens a um produto, mas publica `No parameters` e request somente com `images`. O mecanismo para informar ou inferir o produto, os limites e os tipos aceitos permanece `NAO_DOCUMENTADO` em `PEND-016`.

Por isso, não existe ordem operacional executável comprovada para essa associação além da necessidade conceitual indicada pela finalidade; nenhuma dependência adicional é inventada.

## Vendedores

- `OP-088 POST /sellers` usa `code`.
- `OP-089 PUT /sellers/{erpId}` usa `erpId` no alvo e `code` no request.
- `OP-090 PATCH /sellers/clients` usa `sellerErpId`.
- A relação normativa entre `code`, `erpId` e `sellerErpId` permanece `NAO_DOCUMENTADO` em `PEND-017`.

## Pedidos e confirmação de integração

1. `GET /orders` fornece pedidos não integrados.
2. `PATCH /orders/export/{number}` registra exportação.
3. `PATCH /orders/{number}` marca integração e recebe a identificação documentada.
4. `PUT /orders/status` atualiza as informações logísticas e fiscais publicadas.
5. `GET /orders/integrated` consulta pedidos já integrados.

Essa sequência registra finalidades publicadas. Confirmação válida no destino, atomicidade, idempotência, prevenção de loop, política de conflito e reprocessamento seguro permanecem `NAO_DOCUMENTADO` nas pendências transversais.

## Ordem parcial mínima sustentada pela fonte

1. companhias;
2. marcas, filiais, gêneros, transportadoras, prazos, métodos de pagamento, tabelas de preço, campanhas, linhas, cores, representantes e vendedores;
3. condições de pagamento depois de métodos de pagamento;
4. regiões depois de tabelas de preço;
5. categorias depois de marcas, seguidas de subcategorias;
6. clientes depois de representantes quando `representativesErpIds` for usado;
7. produtos depois das dependências de catálogo;
8. vínculo explícito de cores com produto depois de produto e cores;
9. `produtos -> variantes -> SKUs -> preços`, com tabelas de preço também antes de preços;
10. vínculos de representantes/clientes e vendedores/clientes depois das entidades envolvidas;
11. pedidos e seus registros de exportação, confirmação e status;
12. associação de imagens: ordem executável pendente de `PEND-016`.

Essa ordem é parcial, não afirma obrigatoriedade ausente e não representa garantia de atomicidade, idempotência ou rollback.

## Rastreabilidade

- fonte original: `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.pdf`;
- índice mecânico vinculado: `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.extraido.txt`;
- síntese corrigida e aprovada: `analises/ferramentas/forca-de-vendas/01-analise-documentacao.md`, seção 7;
- detalhes por operação: `analises/ferramentas/forca-de-vendas/01-inventario-operacoes.md`;
- matriz corrigida: `analises/ferramentas/forca-de-vendas/01-matriz-bidirecionalidade-modulos.md`;
- gate vigente do Passo 01: `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-01-POS-CORRECOES-PASSO-03.md`;
- origem da reconstrução: `parceiros/execucoes/ferramentas/forca-de-vendas/DIAGNOSTICO-CORRECAO-POS-PASSO-03.md`, `DIAG-011` e `DIAG-013`.
