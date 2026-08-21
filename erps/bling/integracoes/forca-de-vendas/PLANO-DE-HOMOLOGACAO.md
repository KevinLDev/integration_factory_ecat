# Plano de homologação da combinação Bling x Força de Vendas

## Identificação

- ERP: Bling
- ERP_SLUG: bling
- FERRAMENTA: Força de Vendas
- FERRAMENTA_SLUG: forca-de-vendas
- COMBINACAO: bling x forca-de-vendas
- PERFIL: HOMOLOGACAO
- ETAPA_ORIGEM: ERP_PARCEIRO_PASSO_03
- DATA_PLANEJAMENTO: 2026-08-21

## Base Mestra e baseline de homologação

- BASE_MESTRA_ERP: inexistente até esta execução — esta é a primeira combinação do Bling na fábrica;
  este plano **é** a origem da futura Base Mestra do Bling, não um recorte de uma base preexistente.
- BASE_MESTRA_REUTILIZADA: NAO (nada a reutilizar ainda)
- PERFIL_BASELINE: HOMOLOGACAO

Baseline recomendado para ERP Parceiro em HOMOLOGACAO (ver seção "Desvios do baseline" para os ajustes
desta combinação):

- produtos: 200 · clientes: 20 · marcas: 10 · categorias: 10 · subcategorias: 25 · linhas: 8 ·
  tipos: 5 · gêneros: 5 · campanhas: 4 · filiais: 3 · tabelas de preço: 3 · condições de pagamento: 5 ·
  vendedores: 10 · representantes: 5 · prepostos: 5 · transportadoras: 5 · pedidos: 100

## Fontes utilizadas

- Contrato técnico da ferramenta: `ferramentas/forca-de-vendas/CONTRATO-DA-FERRAMENTA.yaml`
- Cenários funcionais da ferramenta: `ferramentas/forca-de-vendas/CENARIOS-FUNCIONAIS.md`
- Regras de negócio da ferramenta: `ferramentas/forca-de-vendas/REGRAS-DE-NEGOCIO.md`
- Homologação da ferramenta para integrações: `ferramentas/forca-de-vendas/HOMOLOGACAO-PARA-INTEGRACOES.md`
- Análise do ERP: `erps/bling/ANALISE-DO-ERP.md`
- Capacidades do ERP: `erps/bling/CAPACIDADES-DO-ERP.md`
- Matriz ERP x ferramenta: `erps/bling/integracoes/forca-de-vendas/MATRIZ-ERP-FERRAMENTA.md`
- Pendências da combinação: `erps/bling/integracoes/forca-de-vendas/PENDENCIAS.md`
- Padrão global de massa comercial: `documentacao/13-PADRAO-GLOBAL-DE-MASSA-COMERCIAL.md`
- Padrão de base comercial: `parceiros/modelos/base-comercial/PADRAO-BASE-COMERCIAL.md`
- Convenção de identificadores: `parceiros/modelos/base-comercial/CONVENCAO-DE-IDENTIFICADORES.md`
- Padrão de imagens: `parceiros/modelos/base-comercial/PADRAO-DE-IMAGENS.md`

## Snapshot das fontes usadas

| TIPO_FONTE | CAMINHO | VERSAO | SHA256 | HASH_MODE |
|---|---|---|---|---|
| CONTRATO_TECNICO | `ferramentas/forca-de-vendas/CONTRATO-DA-FERRAMENTA.yaml` | NAO_DISPONIVEL (não recalculado nesta etapa; ver `PASSO-03.yaml` da ferramenta para o hash vigente aprovado) | NAO_DISPONIVEL | NAO_DISPONIVEL |
| CENARIOS_FUNCIONAIS | `ferramentas/forca-de-vendas/CENARIOS-FUNCIONAIS.md` | NAO_DISPONIVEL | NAO_DISPONIVEL | NAO_DISPONIVEL |
| REGRAS_DE_NEGOCIO | `ferramentas/forca-de-vendas/REGRAS-DE-NEGOCIO.md` | NAO_DISPONIVEL | `99990B2C6A9C389F6C4BCA1295AE01A2C7898ADAA92D4968F21273E83CE61BEE` (BYTES_V1, registrado em `HOMOLOGACAO-PARA-INTEGRACOES.md` da ferramenta) | BYTES_V1 |
| ANALISE_ERP | `erps/bling/ANALISE-DO-ERP.md` | NAO_DISPONIVEL | `8751FB0048E46D81075D85597C0C0F949348ABF08C5A7D7F8D2121D446317B7B` | TEXT_CANONICAL_V1 |
| CAPACIDADES_ERP | `erps/bling/CAPACIDADES-DO-ERP.md` | NAO_DISPONIVEL | `F093835E275E8D7C6667CB683EADD7BECF34A8309B1C9EDE91438DB57EAD93C9` | TEXT_CANONICAL_V1 |
| MATRIZ | `erps/bling/integracoes/forca-de-vendas/MATRIZ-ERP-FERRAMENTA.md` | NAO_DISPONIVEL | `3D3AD4090FEFE114D741964393AF6441A08A4D3E56AF9C93B825341D96C1F403` | TEXT_CANONICAL_V1 |
| PADRAO_DE_MASSA | `documentacao/13-PADRAO-GLOBAL-DE-MASSA-COMERCIAL.md` | NAO_DISPONIVEL | NAO_DISPONIVEL (não recalculado nesta etapa) | NAO_DISPONIVEL |

**Snapshot revalidado em 2026-08-21** (revalidação mínima disparada pelo gate de vigência do Passo 04,
antes da primeira escrita): os três hashes acima foram atualizados para refletir as correções
documental e de runtime já aplicadas (ver `DIAGNOSTICO-CORRECAO-20260821.md` e
`DIAGNOSTICO-CORRECAO-RUNTIME-20260821.md`). A divergência encontrada era só esta tabela de snapshot
estar desatualizada — o conteúdo do plano (gaps, gate final, famílias) já incorporava as correções
desde que foram feitas; nada foi reprojetado. Hashes recalculados nesta revalidação via
`scripts/harness/harness.cmd hash`, conferindo com os registrados em
`parceiros/execucoes/erps/bling/manifestos/PASSO-02.yaml`. Os demais campos `NAO_DISPONIVEL` não foram
inventados.

## Objetivo da homologação

Provar que a combinação Bling x Força de Vendas sustenta, com cobertura rastreável, o núcleo do
contrato da ferramenta (produto, variação/SKU, cliente, vendedor, pedido, forma de pagamento) e, para
os requisitos que o Bling não modela nativamente (marca, cor, gênero, campanha, linha, região, tabela
de preço, prazo por marca, papel comercial representante/preposto), demonstrar que uma **camada de
complemento materializada dentro do próprio Bling** (campos customizados + cadastro manual assistido no
painel, quando a API não permitir escrita) entrega ao Força de Vendas os mesmos dados completos que ele
exigiria de um ERP nativamente compatível — sem alterar o contrato homologado da ferramenta e sem
fingir cobertura onde ela realmente não existe.

## Escopo técnico

Capacidades confirmadas do Bling usadas neste plano (evidência em `CAPACIDADES-DO-ERP.md`):
`Produtos` (CRUD completo, `gtin` nativo), `ProdutosVariacoes` (variação = SKU), `CategoriasProdutos`
(hierárquico via `categoriaPai`), `Contatos` (CRUD completo, `tiposContato`, `vendedor.id`),
`Vendedores` (somente leitura), `Depositos`/`Estoques` (CRUD + saldo), `PedidosVenda` (CRUD completo +
`Situacoes`/`SituacoesTransicoes`), `FormasPagamentos` (CRUD completo), `CamposCustomizados` (CRUD
completo, com opções tipadas por lista).

## Escopo funcional

Modos da ferramenta considerados (fonte: `CENARIOS-FUNCIONAIS.md`), com dados necessários já
levantados na matriz da combinação:

- Direto, Código de Barras, Galeria, Link E-commerce, Passo a Passo, Referência, Replicar — os 7 modos.
- Código de Barras e Referência: cobertura favorável (Bling tem `gtin`/`codigo` nativos).
- Direto, Link E-commerce e Replicar: `DEGRADA_MODO` pela ausência nativa de tabela de preço por
  região — mitigado neste plano pela camada de complemento (campos customizados de preço por tabela).
- Galeria e Passo a Passo: `DEGRADA_MODO` pela ausência de Cor/Marca/Gênero/Campanha como entidades
  nativas — mitigado pela camada de complemento (campos customizados tipo lista de opções).

## Regras de negócio consideradas

`REGRAS_DE_NEGOCIO_CONSIDERADAS`:

- `RN-FDV-MAR-001..004` (marca obrigatória no produto, impacta visibilidade/prazo) — coberta via
  camada de complemento (campo customizado Marca).
- `RN-FDV-PRE-001..004` e `RN-FDV-REG-001..004` (tabela de preço varia por região) — coberta via
  camada de complemento (campos customizados de preço por tabela + campo de região no cliente).
- `RN-FDV-GRA-001..003` (grade aberta/fechada) — grade aberta coberta nativamente via variação; grade
  fechada com pack coberta via `ProdutosEstruturas` (`formato: E` + `lancamentoEstoque: M`), confirmado
  estruturalmente nesta revisão (ver `DIAGNOSTICO-CORRECAO-20260821.md`).
- `RN-FDV-DISP-001/002` (pronta entrega/não pronta entrega) — coberta via camada de complemento.
- `RN-FDV-PRA-001..007` (prazo vinculado a marca) — coberta via camada de complemento.
- `RN-FDV-ORI-001..003` (nacional/importado) — coberta via campo customizado comercial dedicado
  (decisão explícita de não reutilizar o campo fiscal `tributacao.origem`, que tem propósito legal
  distinto — ver "Gaps e restrições").
- `RN-FDV-RP-001/002` (representante/preposto) — coberta via campo customizado de papel comercial no
  `Contato` (vendedor), combinado com cadastro manual do vendedor no painel do Bling.
- `RN-FDV-PED-001..007` e `RN-FDV-EXP-001/002` (ciclo pendente->exportado->integrado) — coberta via
  `PedidosVenda` + sistema de `Situacoes`/`SituacoesTransicoes` do Bling, com mapeamento de estados a
  definir no Passo 05.
- `RN-FDV-ORC-001..006` (orçamento convertido em pedido) — sem endpoint de conversão automática no
  Bling; tratada como gap com adaptação manual/futura (ver "Gaps e restrições").
- `RN-FDV-MOD-001..009` (modos funcionais não exigem endpoint de mesmo nome) — respeitada em todo este
  plano; nenhum "endpoint de modo" foi inventado.
- `RN-FDV-ABC-001..004` (Curva ABC) — não exige endpoint próprio; diversidade de pedidos planejada na
  seção "Diversidade para relatórios".

## Relações entre entidades

| RELACAO_ID | ENTIDADES | REGRA_TAGS | DADOS_NECESSARIOS | CAPACIDADE_ERP | EVIDENCIA | STATUS |
|---|---|---|---|---|---|---|
| REL-001 | Produto -> Marca | RN-FDV-MAR-001 | marca_id | Campo customizado (lista de opções) em Produtos | `CAPACIDADES-DO-ERP.md` (CamposCustomizados) | COMPATIVEL_COM_ADAPTACAO |
| REL-002 | Produto -> Categoria -> Subcategoria | — | categoria_id, categoria_pai_id | `CategoriasProdutos.categoriaPai` | `CAPACIDADES-DO-ERP.md` | COMPATIVEL |
| REL-003 | Cliente -> Região -> Tabela de Preço | RN-FDV-REG-002, RN-FDV-PRE-001 | regiao (campo customizado no Contato), tabela_preco_id | Campo customizado em Contatos + Produtos | `MATRIZ-ERP-FERRAMENTA.md` linhas 15/19/23 | COMPATIVEL_COM_ADAPTACAO |
| REL-004 | Produto -> Variação (SKU) -> Estoque | — | sku_logico, quantidade, filial | `ProdutosVariacoes` + `Estoques` | `CAPACIDADES-DO-ERP.md` | COMPATIVEL |
| REL-005 | Marca -> Prazo de entrega | RN-FDV-PRA-003 | prazo_dias | Campo customizado em Produtos (associado à marca do mesmo produto) | `MATRIZ-ERP-FERRAMENTA.md` linha 18 | COMPATIVEL_COM_ADAPTACAO |
| REL-006 | Representante -> Preposto -> Cliente | RN-FDV-RP-001/002 | papel_comercial, representante_pai_id | Campo customizado em Contatos (vendedor) + `Contatos.vendedor.id` | `MATRIZ-ERP-FERRAMENTA.md` linhas 20/26 | PARCIAL (criação manual no painel) |
| REL-007 | Pedido -> Situação -> Exportação | RN-FDV-PED-001..003 | situacao_id, transicao | `PedidosVenda` + `Situacoes`/`SituacoesTransicoes` | `CAPACIDADES-DO-ERP.md` (PedidosVenda) | COMPATIVEL_COM_ADAPTACAO |
| REL-008 | Orçamento -> Pedido | RN-FDV-ORC-004/005 | convertido_em_pedido_id | Sem endpoint de conversão automática | `MATRIZ-ERP-FERRAMENTA.md` (PropostasComerciais) | PENDENTE_DE_EVIDENCIA |

## Cenários de homologação

| CENARIO_ID | CENARIO_TAGS | REGRA_TAGS | DESCRICAO | STATUS_DO_PLANEJAMENTO |
|---|---|---|---|---|
| CEN-001 | PRECO_POR_TABELA_REGIAO | RN-FDV-PRE-001/002, RN-FDV-REG-002 | Cliente SP (Região Sudeste, Tabela A) e cliente CE (Região Nordeste, Tabela B) veem preços diferentes do mesmo Produto X | PLANEJADO_COM_ADAPTACAO |
| CEN-002 | PRODUTO_AUSENTE_EM_TABELA | RN-FDV-PRE-003 | Produto Y tem preço preenchido na Tabela A e campo customizado vazio na Tabela B (ausência representável) | PLANEJADO_COM_ADAPTACAO |
| CEN-003 | GRADE_ABERTA_P_M_G_GG | RN-FDV-GRA-001 | Família de produtos com variações de tamanho P/M/G/GG, quantidade por tamanho | PLANEJADO |
| CEN-004 | GRADE_FECHADA_PACK | RN-FDV-GRA-002 | Produto com composição fixa via `ProdutosEstruturas` (`formato: E`, `lancamentoEstoque: M`) | PLANEJADO_COM_ADAPTACAO |
| CEN-005 | PRONTA_ENTREGA_X_NAO_PRONTA | RN-FDV-DISP-001/002, RN-FDV-PRA-005/006 | Metade da família com disponibilidade imediata, metade com disponibilidade futura restringindo prazo | PLANEJADO_COM_ADAPTACAO |
| CEN-006 | PRAZO_POR_MARCA | RN-FDV-PRA-003 | Marca A com prazo de 5 dias, Marca B com prazo de 15 dias | PLANEJADO_COM_ADAPTACAO |
| CEN-007 | NACIONAL_IMPORTADO | RN-FDV-ORI-001/002 | 100 produtos nacionais e 100 importados (campo customizado comercial dedicado) | PLANEJADO_COM_ADAPTACAO |
| CEN-008 | PEDIDO_REPRESENTANTE_X_PREPOSTO | RN-FDV-RP-001/002, RN-FDV-PED-004/005 | Pedidos originados por vendedor marcado "Representante" e por vendedor marcado "Preposto" | PLANEJADO_COM_ADAPTACAO |
| CEN-009 | CICLO_PENDENTE_EXPORTADO_INTEGRADO | RN-FDV-PED-001..003, RN-FDV-EXP-001/002 | Pedidos em três situações Bling distintas mapeadas ao ciclo da ferramenta | PLANEJADO_COM_ADAPTACAO (mapeamento de situações fica para o Passo 05) |
| CEN-010 | ORCAMENTO_CONVERTIDO_EM_PEDIDO | RN-FDV-ORC-004/005 | Proposta comercial convertida manualmente em pedido de venda | GAP (sem endpoint de conversão automática) |
| CEN-011 | CODIGO_DE_BARRAS_POR_SKU | — (Modo Código de Barras) | Variações com `gtin` nativo, únicos, consultáveis via `gtins[]` | PLANEJADO |
| CEN-012 | GALERIA_MULTIPLAS_IMAGENS | — (Modo Galeria) | Distribuição 45/45/45/45/10/10 de imagens por produto | PLANEJADO |

## Capacidades confirmadas

- `Produtos`, `ProdutosVariacoes`, `CategoriasProdutos`, `Contatos`, `Vendedores` (leitura),
  `Depositos`, `Estoques`, `PedidosVenda`, `FormasPagamentos`, `CamposCustomizados`,
  `Situacoes`/`SituacoesTransicoes` — todas com evidência documental em `CAPACIDADES-DO-ERP.md`;
  autenticação confirmada em runtime (ver `ANALISE-DO-ERP.md`).

## Gaps e restrições

| GAP_ID | REQUISITO_AFETADO | IMPACTO | MODO_AFETADO | POSSIVEL_ADAPTACAO | STATUS |
|---|---|---|---|---|---|
| GAP-001 | Grade fechada com pack/composição (`RN-FDV-GRA-002`) | Reexaminado nesta revisão: `ProdutosEstruturas` (`formato: E` + `lancamentoEstoque: M`) modela estruturalmente um pack fechado (produto pai + componentes de quantidade fixa, estoque decrementado só nos componentes). Resta confirmar (a) se variação pode ser componente de produto diferente e (b) comportamento em runtime | Galeria, Direto | Usar `ProdutosEstruturas` com `lancamentoEstoque: M`; confirmar (a)/(b) no Passo 04 (leitura) e Passo 07 (runtime) | COMPATIVEL_COM_ADAPTACAO (RESOLVIDO nesta revisão — ver `DIAGNOSTICO-CORRECAO-20260821.md`) |
| GAP-002 | Conversão automática de Orçamento em Pedido (`RN-FDV-ORC-004/005`) | Sem endpoint no Bling | Nenhum modo bloqueado (fluxo é interno à ferramenta, não ao ERP) | Registrar como processo manual/fora do escopo de API do Bling | GAP |
| GAP-003 | Filiais/unidades de negócio via API (`PEND-BLING-FDV-006`) | **RESOLVIDO (2026-08-21)**: verificado em runtime na conta Bling do ERP parceiro — `GET /depositos` retorna 1 depósito, `GET /canais-venda` retorna 0 canais. Não há hoje cenário multi-filial nesta conta | Direto, Replicar (estoque multi-filial) | `Filiais` marcado `NAO_APLICAVEL` para esta homologação; reabrir e reverificar por conta em qualquer futura jornada de ERP Cliente com Bling real multi-filial | RESOLVIDO_NAO_APLICAVEL |
| GAP-004 | Vendedores só leitura via API (`PEND-BLING-FDV-008`) | Não é possível criar vendedor via API | Passo a Passo/Replicar (cadastro de representante/preposto) | Cadastro manual no painel do Bling durante a materialização (Passo 04); depois só leitura via API | COMPATIVEL_COM_ADAPTACAO_MANUAL |
| GAP-005 | Uso de campo fiscal `tributacao.origem` para separação comercial nacional/importado | Misturaria semântica fiscal (NCM/ICMS) com semântica comercial da ferramenta | Passo a Passo | Campo customizado comercial dedicado, sem reaproveitar o campo fiscal | COMPATIVEL_COM_ADAPTACAO (decisão explícita, não é bug) |
| GAP-006 | Rate limit real do Bling não documentado nesta especificação (`PEND-BLING-FDV-011`) | Sem impacto no planejamento; impacta o Passo 06+ (volume de chamadas) | Nenhum | Confirmar limite real antes de desenvolver sincronização em volume | PENDENTE_DE_EVIDENCIA (não bloqueia este Passo 03) |

Nenhum gap acima foi coberto com "cobertura fingida"; onde a adaptação é viável, ela está marcada como
tal, não como `COMPATIVEL` puro.

## Impactos funcionais

- Código de Barras, Referência: `NAO_IMPACTA_MODO`.
- Galeria, Passo a Passo: `DEGRADA_MODO` sem a camada de complemento; `NAO_IMPACTA_MODO` esperado com
  ela implementada (a confirmar em homologação funcional, Passo 08).
- Direto, Link E-commerce, Replicar: `DEGRADA_MODO` quanto à granularidade comercial (região/tabela)
  sem a camada de complemento; mitigado com ela.
- Nenhum modo classificado como `BLOQUEIA_MODO`.

## Famílias planejadas

| FAMILIA_ID | OBJETIVO | CENARIO_TAGS | QTD_PRODUTOS |
|---|---|---:|---:|
| FAM-GRADE-ABERTA-VESTUARIO | Cobrir grade P/M/G/GG com múltiplas marcas/categorias/cores (via campo customizado) | CEN-003, CEN-011, CEN-012 | 60 |
| FAM-GRADE-FECHADA-PACK | Cobrir composição fixa via `ProdutosEstruturas` (`formato: E`, `lancamentoEstoque: M`) | CEN-004 | 20 |
| FAM-SEM-GRADE-REFERENCIA | Produtos simples (sem variação), foco em Referência/Código de Barras | CEN-011 | 40 |
| FAM-PRECO-MULTITABELA | Produtos com preço preenchido de forma distinta nas 3 tabelas planejadas, incluindo ausência proposital em uma tabela | CEN-001, CEN-002 | 40 |
| FAM-PRONTA-ENTREGA | Disponibilidade imediata, prazo curto | CEN-005, CEN-006 | 20 |
| FAM-NAO-PRONTA-ENTREGA | Disponibilidade futura, prazo restringido | CEN-005, CEN-006 | 20 |
| **Total produtos** | | | **200** |

Cada família combina múltiplas dimensões no mesmo produto (nacional/importado, marca, categoria,
subcategoria, imagem) para evitar explosão cartesiana, conforme
`documentacao/13-PADRAO-GLOBAL-DE-MASSA-COMERCIAL.md` seção 8. Distribuição nacional/importado
(100/100) e de imagens (45/45/45/45/10/10) é aplicada transversalmente às 6 famílias, não como família
própria.

## Quantidades derivadas

- 200 produtos mantidos no baseline: nenhuma limitação real do Bling foi identificada que justifique
  reduzir (Produtos suporta paginação e filtros ricos, sem limite de cadastro documentado).
- 3 tabelas de preço via campo customizado: número escolhido para bater com o baseline recomendado;
  cada tabela vira um campo customizado próprio no módulo Produtos (`Preço Tabela A/B/C`), então o
  custo de manutenção cresce linearmente com o número de tabelas — **decisão explícita de manter em 3
  para homologação**; um cenário real de cliente com muito mais tabelas exigiria reavaliar essa
  estratégia (registrado como risco, não como bloqueio).
- 10 vendedores (5 representantes + 5 prepostos): cadastro manual no painel do Bling, dentro do
  baseline recomendado.

## Desvios do baseline

| ENTIDADE | BASELINE | PLANEJADO | MOTIVO |
|---|---:|---:|---|
| Filiais | 3 | 0 (`NAO_APLICAVEL`) | `PEND-BLING-FDV-006` resolvida em 2026-08-21: verificado em runtime que a conta Bling do ERP parceiro tem 1 depósito e 0 canais de venda — sem cenário multi-filial real para materializar nesta homologação |
| Regiões | (sem número fixo no baseline) | 3 | Alinhado 1:1 com as 3 tabelas de preço planejadas, por dependência direta (`RN-FDV-REG-002`) |
| Tipos | 5 | 5 (via campo customizado dedicado) | Baseline mantido, mas implementado como campo customizado próprio para não confundir com o campo técnico `tipo` (P/S/N) já nativo do Bling, que tem semântica diferente |

## Entidades comerciais

Necessárias para esta combinação: marcas, categorias, subcategorias, produtos, variações (SKUs),
cores (via campo customizado), grades, imagens, preços, tabelas de preço (via campo customizado),
regiões (via campo customizado no cliente), estoques, clientes, vendedores, representantes, prepostos,
condições de pagamento, transportadoras, campanhas (via campo customizado), pedidos.

Não necessárias/não aplicáveis nesta combinação: filiais (pendente de confirmação, não incluídas nesta
rodada), orçamentos automatizados (gap, tratamento manual).

## Dependências (DAG da combinação)

| ENTIDADE | DEPENDE_DE | EVIDENCIA |
|---|---|---|
| Campo customizado "Marca" (opções) | — (pré-requisito de infraestrutura) | `CamposCustomizados` deve ser criado antes de qualquer produto |
| Categoria | — | `CategoriasProdutos` |
| Subcategoria | Categoria (via `categoriaPai`) | `CategoriasProdutos` |
| Produto | Categoria/Subcategoria, campo customizado Marca | `Produtos`, `CategoriasProdutos`, `CamposCustomizados` |
| Variação (SKU) | Produto | `ProdutosVariacoes` |
| Estoque | Variação (SKU), Depósito | `Estoques`, `Depositos` |
| Preço por tabela (campo customizado) | Produto, campo customizado "Tabela de Preço" | `Produtos`, `CamposCustomizados` |
| Vendedor (representante/preposto) | Contato + cadastro manual no painel | `Contatos`, `Vendedores` |
| Cliente | Vendedor (quando vinculado), campo customizado "Região" | `Contatos` |
| Pedido de venda | Cliente, Produto/Variação, Forma de Pagamento, Vendedor | `PedidosVenda`, `FormasPagamentos` |

## Estratégia de identificadores

- Prefixo `HML` conforme `CONVENCAO-DE-IDENTIFICADORES.md`.
- `id_logico` estável independente do `id` numérico atribuído pelo Bling na criação real (Passo 04);
  `codigo_fisico` = `codigo` do produto/variação no Bling (campo `codigo`, sem limite de tamanho
  documentado nesta especificação — a confirmar no Passo 04).
- Exemplos: `HML-PROD-001`, `HML-SKU-001-P` (Produto 001, tamanho P), `HML-CLI-001`, `HML-MARCA-001`,
  `HML-CAT-001`, `HML-VEND-001`.

## Estratégia de códigos/EAN

- Modo Código de Barras exige EAN por SKU (ver `CENARIOS-FUNCIONAIS.md` Modo 2) → EAN entra no plano.
- Bling suporta `gtin` nativo por Produto/Variação → sem gap.
- Estratégia: `CODIGO_SINTETICO_HML`, formato EAN-13, dígito verificador válido, determinístico a
  partir do `id_logico` da variação, único no escopo da massa de homologação. Nenhum código real será
  usado nesta fase de homologação.

## Estratégia de imagens

- Aplicável (Modo Galeria exige imagem).
- Referências via URL (`midia.imagens.imagensURL`), biblioteca lógica `IMG-STD-001..004`,
  `IMG-PLACEHOLDER-001`, `SEM_IMAGEM`, conforme `PADRAO-DE-IMAGENS.md`.
- Cardinalidade baseline aplicada sem desvio: 45/45/45/45/10/10 sobre os 200 produtos.
- Nenhum binário será adicionado ao repositório.

## Cobertura esperada

Ver `BASE-COMERCIAL-PLANEJADA.yaml` para o mapeamento família -> cenários -> regras, e cenário ->
famílias que o cobrem.

## Coberturas impossíveis

- `CEN-010` (conversão automática de orçamento em pedido): cobertura impossível via API nesta
  especificação — tratado como processo manual/fora do escopo técnico do Bling, não como falha de
  planejamento.

`CEN-004` (grade fechada com pack) **deixou de ser cobertura impossível/incerta nesta revisão**: o
reexame de `ProdutosEstruturas` (ver `DIAGNOSTICO-CORRECAO-20260821.md`) confirmou estruturalmente o
mecanismo (`formato: E` + `lancamentoEstoque: M`); resta apenas confirmação fina de detalhe (variação
como componente de outro produto) e validação em runtime no Passo 07 — não bloqueia mais a
materialização de `FAM-GRADE-FECHADA-PACK`.

## Pendências bloqueantes

Nenhuma. `GAP-001` (grade fechada com pack) foi resolvido em 2026-08-21 (reexame de schema) e
`GAP-003` (Filiais) foi resolvido em 2026-08-21 (verificação em runtime: 1 depósito, 0 canais de venda
na conta do ERP parceiro — `NAO_APLICAVEL` para esta homologação). As 200 famílias de produtos
planejadas estão liberadas para materialização.

`GAP-002` (conversão automática de orçamento em pedido) permanece um gap definitivo, mas não é
bloqueante — é tratado como processo manual, fora do escopo de API do Bling, sem impedir a
materialização do restante da base.

## Gate final da etapa

```text
ERP_IDENTIFICADO: SIM
FERRAMENTA_HOMOLOGADA: SIM
PASSO_02_APTO: SIM
PLANO_DE_HOMOLOGACAO: GERADO
BASE_COMERCIAL_PLANEJADA: GERADA
COBERTURA_PLANEJADA: PARCIAL_JUSTIFICADA
PENDENCIAS_BLOQUEANTES: 0
SNAPSHOT_DAS_FONTES: REGISTRADO
PRONTO_PARA_CRIAR_BASE_REAL: SIM
```

`PRONTO_PARA_CRIAR_BASE_REAL: SIM` a partir de 2026-08-21: as duas pendências bloqueantes (`GAP-001`
grade fechada, `GAP-003` filiais) foram resolvidas com evidência real — a primeira por reexame de
schema, a segunda por chamada de leitura em runtime na própria conta Bling do ERP parceiro (1 depósito,
0 canais de venda). `COBERTURA_PLANEJADA` permanece `PARCIAL_JUSTIFICADA` (não `COMPLETA`) porque
`GAP-002` (conversão automática de orçamento em pedido) continua sendo um gap definitivo e permanente,
não uma pendência a resolver — ver `DIAGNOSTICO-CORRECAO-RUNTIME-20260821.md`.

## Critérios para próxima etapa

Os critérios para `PRONTO_PARA_CRIAR_BASE_REAL: SIM` foram atendidos em 2026-08-21. O Passo 04
(Materializar Base de Homologação) pode prosseguir com os 200 produtos planejados, tratando `Filiais`
como `NAO_APLICAVEL` e `FAM-GRADE-FECHADA-PACK` como liberada. Recomenda-se ainda, antes de escrita real
em massa: recalcular os hashes das fontes marcadas `NAO_DISPONIVEL` na tabela de snapshot deste plano,
se ainda não tiverem sido calculados por outra execução.

Se qualquer fonte efetivamente usada mudar antes do Passo 04, este plano deve ser classificado
`PLANO_POTENCIALMENTE_OBSOLETO` e revalidado neste mesmo Passo 03 antes de prosseguir — não
reprojetado dentro do Passo 04. Esta seção não inicia o Passo 04 automaticamente.
