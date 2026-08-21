# CAPACIDADES-DO-ERP — Bling

## Como ler este catálogo

- `VERBOS` = métodos HTTP realmente presentes no OpenAPI para o recurso (`x-api-resource`), não
  suposição por convenção REST.
- `RELEVANCIA` frente ao contrato homologado da Força de Vendas:
  - `RELEVANTE`: módulo com contrapartida direta ou próxima no contrato da ferramenta;
  - `RELEVANTE_INDIRETO`: não é módulo da ferramenta, mas sustenta dados usados por um módulo relevante
    (ex.: Situações sustenta o ciclo de vida de Pedidos);
  - `NAO_RELEVANTE`: módulo de ERP geral (fiscal/financeiro/produção) sem contrapartida no contrato
    atual da Força de Vendas.
- `DOCUMENTADO`/`TESTADO` seguem a convenção do Passo 02: todas as linhas são `DOCUMENTADO: SIM`
  (vindas do OpenAPI oficial); `TESTADO: SIM` aparece somente nas duas rotas efetivamente chamadas em
  runtime (ver `FONTES.md`). As demais são `CONFIRMADO_POR_DOCUMENTACAO`.

## Catálogo completo (43 recursos, 257 operações, contagem mecânica)

| Recurso (`x-api-resource`) | Verbos | Total ops | Relevância p/ Força de Vendas |
|---|---|---:|---|
| Produtos | GET, POST, PUT, PATCH, DELETE | 9 | RELEVANTE |
| ProdutosVariacoes | GET, POST, PATCH | 3 | RELEVANTE |
| ProdutosEstruturas | GET, POST, PUT, PATCH, DELETE | 6 | RELEVANTE |
| ProdutosFornecedores | GET, POST, PUT, DELETE | 5 | NAO_RELEVANTE |
| ProdutosLojas | GET, POST, PUT, DELETE | 5 | RELEVANTE |
| CategoriasProdutos | GET, POST, PUT, DELETE | 5 | RELEVANTE |
| CategoriasLojas | GET, POST, PUT, DELETE | 5 | RELEVANTE_INDIRETO |
| GruposProdutos | GET, POST, PUT, DELETE | 6 | RELEVANTE_INDIRETO |
| Contatos | GET, POST, PUT, PATCH, DELETE | 10 | RELEVANTE |
| ContatosTipos | GET | 1 | RELEVANTE_INDIRETO |
| Vendedores | GET | 2 | RELEVANTE (somente leitura) |
| Depositos | GET, POST, PUT | 4 | RELEVANTE |
| Estoques | GET, POST, PUT | 4 | RELEVANTE |
| Lotes | GET, POST, PUT, PATCH, DELETE | 8 | RELEVANTE_INDIRETO |
| LotesLancamentos | GET, POST, PATCH | 8 | RELEVANTE_INDIRETO |
| PedidosVenda | GET, POST, PUT, PATCH, DELETE | 14 | RELEVANTE (núcleo) |
| FormasPagamentos | GET, POST, PUT, PATCH, DELETE | 7 | RELEVANTE |
| Logisticas | GET, POST, PUT, PATCH, DELETE | 20 | RELEVANTE_PARCIAL |
| CanaisVendas | GET | 3 | RELEVANTE_INDIRETO |
| Situacoes | GET, POST, PUT, DELETE | 4 | RELEVANTE_INDIRETO |
| SituacoesModulos | GET | 4 | RELEVANTE_INDIRETO |
| SituacoesTransicoes | GET, POST, PUT, DELETE | 4 | RELEVANTE_INDIRETO |
| Empresas | GET | 1 | RELEVANTE_INDIRETO (identidade do tenant) |
| CamposCustomizados | GET, POST, PUT, PATCH, DELETE | 8 | RELEVANTE_INDIRETO (via de adaptação) |
| PropostasComerciais | GET, POST, PUT, PATCH, DELETE | 7 | RELEVANTE (candidato a Orçamentos) |
| Anuncios | GET, POST, PUT, DELETE | 7 | NAO_RELEVANTE |
| AnunciosCategorias | GET | 2 | NAO_RELEVANTE |
| NaturezasOperacoes | GET, POST | 2 | RELEVANTE_INDIRETO (necessário para emitir NF a partir do pedido) |
| NotasFiscais | GET, POST, PUT, DELETE | 22 | RELEVANTE_INDIRETO (pós-pedido) |
| NFSe | GET, POST, PUT, DELETE | 8 | NAO_RELEVANTE |
| ContasReceber | GET, POST, PUT, DELETE | 8 | RELEVANTE_INDIRETO |
| ContasPagar | GET, POST, PUT, DELETE | 6 | NAO_RELEVANTE |
| ContasContabeis | GET | 2 | RELEVANTE_INDIRETO |
| Caixas | GET, POST, PUT, DELETE | 5 | NAO_RELEVANTE |
| Borderos | GET, DELETE | 2 | NAO_RELEVANTE |
| CategoriasReceitasDespesas | GET, POST, PUT, DELETE | 6 | NAO_RELEVANTE |
| PedidosCompra | GET, POST, PUT, PATCH, DELETE | 10 | NAO_RELEVANTE |
| OrdensProducao | GET, POST, PUT, DELETE | 7 | NAO_RELEVANTE |
| Contratos | GET, POST, PUT, DELETE | 5 | NAO_RELEVANTE |
| Homologacao | GET, POST, PUT, PATCH, DELETE | 5 | NAO_RELEVANTE (ferramenta de homologação de app Bling) |
| Notificacoes | GET, POST | 3 | NAO_RELEVANTE |
| Usuarios | GET | 1 | NAO_RELEVANTE |
| DocumentosCompartilhados | GET | 1 | NAO_RELEVANTE |
| (sem `x-api-resource`) | PATCH, POST | 2 | NAO_RELEVANTE (recuperação/redefinição de senha de usuário) |

Total: 43 recursos nomeados + 1 par de operações sem `x-api-resource` = 257 operações.

## Detalhamento dos recursos `RELEVANTE`/`RELEVANTE_PARCIAL`

### Produtos (`/produtos`)

- LER: `GET /produtos` (paginado, filtros por `codigos[]`, `gtins[]`, `idCategoria`, `idLoja`,
  `criterio`, `tipo`, saldo em estoque, `dataInclusao*`/`dataAlteracao*`), `GET /produtos/{id}`.
- CRIAR: `POST /produtos`.
- ATUALIZAR: `PUT /produtos/{id}` (completo), `PATCH /produtos/{id}` (parcial), `PATCH
  /produtos/{id}/situacoes` (ativo/inativo/excluído), `POST /produtos/situacoes` (múltiplos).
- EXCLUIR: `DELETE /produtos`, `DELETE /produtos/{id}` (múltiplos e único).
- EVENTO/WEBHOOK: nenhum.
- DOCUMENTADO: SIM. TESTADO: NÃO. RESULTADO: CONFIRMADO_POR_DOCUMENTACAO.
- Estrutura relevante: `formato` (`S` Simples, `V` Com variações, `E` Com composição), `tipo` (`P`/`S`/
  `N`), `estoque.saldoVirtualTotal`, `midia.imagens` (via URL, não upload multipart), `tributacao`,
  `dimensoes`, `camposCustomizados[]`, `duns[]`.
- Direção possível: BIDIRECIONAL (Bling expõe catálogo `ERP -> ferramenta`; Força de Vendas poderia, em
  tese, também criar/alterar produto `ferramenta -> ERP`, mas o contrato atual da ferramenta modela
  Produto como `ERP -> ferramenta` predominante — ver `BIDIRECIONALIDADE.md` da ferramenta).

### ProdutosVariacoes (`/produtos/variacoes`)

- LER: `GET /produtos/variacoes/{idProdutoPai}` (produto pai + variações).
- CRIAR: `POST /produtos/variacoes/atributos/gerar-combinacoes` (gera combinações sem persistir).
- ATUALIZAR: `PATCH /produtos/variacoes/{idProdutoPai}/atributos` (renomeia atributo de variação).
- Estrutura: cada variação é um Produto completo com `variacao.nome` (ex.: `"Tamanho:G;Cor:Verde"`,
  string livre, não estrutura de atributo tipada) e `produtoPai.id`.
- Nota estrutural crítica: Bling modela **Produto -> Variação** (2 níveis, cada variação já é a unidade
  vendável/com estoque/preço próprios), enquanto o contrato da Força de Vendas modela
  **Produto -> Variante -> SKU -> Preço** (3-4 níveis, ver `DEPENDENCIAS.md` da ferramenta). Ver matriz
  da combinação para o mapeamento proposto.

### ProdutosEstruturas (`/produtos/estruturas`) — reexaminado nesta revisão

- LER: `GET /produtos/estruturas/{id}`. CRIAR/ATUALIZAR: `PUT /produtos/estruturas/{id}`,
  `POST .../componentes` (adiciona), `PATCH .../componentes/{idComponente}` (altera um componente).
  EXCLUIR: `DELETE .../componentes` (remove específicos), `DELETE /produtos/estruturas` (remove
  estrutura de múltiplos produtos).
- Estrutura (`ProdutosEstruturaDTO`): `tipoEstoque` (`F` Físico / `V` Virtual), `lancamentoEstoque`
  (`A` Produto e Componente / `M` Componente / `P` Produto), `componentes[]` — cada componente é
  `{produto: {id}, quantidade}` (`ProdutosComponenteDTO`), sem restrição de tipo no schema sobre qual
  produto pode ser componente.
- **Achado relevante para `RN-FDV-GRA-002` (grade fechada com pack/composição fixa)**: a combinação
  `formato: "E"` (produto com composição) + `lancamentoEstoque: "M"` modela exatamente uma "grade
  fechada": um produto pai vendável como uma unidade (o pack), cujos componentes (cada tamanho,
  representado como uma variação/Produto próprio) têm quantidade fixa e cujo estoque é decrementado
  apenas nos componentes, não no pai. O produto pai continua sendo um Produto normal (preço, `gtin`,
  aparece como item de `PedidosVenda` normalmente).
- Ressalvas que permanecem reais mesmo após este reexame (não eliminadas, apenas mais precisas):
  1. A documentação não afirma explicitamente que uma **variação** (que já é, ela mesma, um Produto
     filho de outro produto pai por `formato: V`) pode ser referenciada como componente de uma
     estrutura de composição de um produto diferente — isso é inferido da generalidade do schema
     (`componente.produto` é só `{id}`, sem restrição), não de uma afirmação textual direta.
  2. Comportamento em runtime (decremento de estoque realmente atômico ao vender o produto composto,
     aceitação de `formato: E` como item de pedido) não foi testado nesta análise documental — fica
     para o Passo 07 (Executar e Validar Tecnicamente em HML).
- Classificação atualizada: `COMPATIVEL_COM_ADAPTACAO` (antes: `PENDENTE_DE_EVIDENCIA` na primeira
  passada da Etapa 02/03). Ver `DIAGNOSTICO-CORRECAO-20260821.md` para o histórico desta correção.

### ProdutosLojas / CategoriasProdutos / CategoriasLojas / GruposProdutos

- `ProdutosLojas`: vincula produto a uma "loja" (canal de venda) com `preco`, `precoPromocional`,
  `codigo` próprio do canal — possível via de adaptação para o conceito de "visibilidade por canal" que
  falta em Produto (ver Pendência de visibilidade).
- `CategoriasProdutos`: suporta hierarquia via `categoriaPai` (mesma entidade, recursiva) — candidato a
  cobrir Categoria+Subcategoria da ferramenta com uma única entidade Bling.
- `GruposProdutos`: entidade hierárquica adicional (`grupoProdutoPai`), sem contrapartida direta
  nomeada no contrato da ferramenta; potencial via de adaptação para Linha/Gênero se necessário.
- `ProdutosFornecedores`: sem contrapartida direta no contrato atual da ferramenta; não aprofundado
  nesta análise (`NAO_RELEVANTE`). `ProdutosEstruturas` foi reexaminado em detalhe acima.

### Contatos (`/contatos`) + ContatosTipos + Vendedores

- LER: `GET /contatos` (paginado, filtros por `pesquisa`, `idTipoContato`, `idVendedor`, `uf`,
  `telefone`, `numeroDocumento`, `tipoPessoa`), `GET /contatos/{id}`, `GET /contatos/{id}/tipos`.
- CRIAR: `POST /contatos`.
- ATUALIZAR: `PUT /contatos/{id}`, `PATCH /contatos/{id}/situacoes`, `POST /contatos/situacoes`
  (múltiplos).
- EXCLUIR: `DELETE /contatos`, `DELETE /contatos/{id}`.
- Estrutura relevante: `tipo` (`F`/`J`/`E`), `tiposContato[]` (vínculo com `ContatosTipos`, usado para
  distinguir Cliente/Fornecedor/Transportador etc.), `vendedor.id` (**singular**, um vendedor por
  contato), `endereco.geral`/`endereco.cobranca`, `financeiro.limiteCredito`/`condicaoPagamento`,
  `camposCustomizados[]`.
- `Vendedores` (`/vendedores`): **somente leitura** (`GET` apenas — confirmado mecanicamente, sem
  `POST`/`PUT`/`DELETE` no OpenAPI). Vendedor é ele mesmo um `Contato` (campo `contato.id`), com
  `descontoLimite` e `comissoes[]`.
- Direção possível: BIDIRECIONAL para Contatos (LER/CRIAR/ATUALIZAR/EXCLUIR completos); **SOMENTE
  LEITURA** para Vendedores.

### Depositos + Estoques (+ Lotes/LotesLancamentos)

- `Depositos` (`/depositos`): LER/CRIAR/ATUALIZAR completos (sem DELETE).
- `Estoques` (`/estoques`, `/estoques/saldos`, `/estoques/saldos/{idDeposito}`): LER saldo por produto/
  depósito (`saldoFisicoTotal`, `saldoVirtualTotal`), CRIAR lançamento de estoque (`operacao`: `B`
  Balanço/`E` Entrada/`S` Saída), ATUALIZAR (`PUT /estoques/{id}`, preço/custo/observação).
- `Lotes`/`LotesLancamentos`: controle de lote/validade por produto+depósito — funcionalidade adicional
  do Bling sem módulo equivalente explícito no contrato atual da ferramenta (RELEVANTE_INDIRETO).
- Direção possível: BIDIRECIONAL (estoque pode ser lido pela ferramenta e a ferramenta, em tese, poderia
  registrar saída de estoque por venda — mas isso normalmente decorre do próprio pedido de venda, não
  de uma chamada direta a `/estoques`).

### PedidosVenda (`/pedidos/vendas`) — núcleo da integração

- LER: `GET /pedidos/vendas` (paginado, filtros ricos: `idContato`, `idsSituacoes[]`, datas de emissão/
  alteração/prevista, `numero`, `idLoja`, `idVendedor`, `numerosLojas[]`, `idUnidadeNegocio`),
  `GET /pedidos/vendas/{id}`.
- CRIAR: `POST /pedidos/vendas`.
- ATUALIZAR: `PUT /pedidos/vendas/{id}`, `PATCH /pedidos/vendas/{id}/situacoes/{idSituacao}` (transição
  de situação via o sistema genérico de Situações do Bling).
- EXCLUIR: `DELETE /pedidos/vendas`, `DELETE /pedidos/vendas/{id}`.
- Ações adicionais: `POST .../lancar-estoque[/{idDeposito}]`, `POST .../estornar-estoque`,
  `POST .../lancar-contas`, `POST .../estornar-contas`, `POST .../gerar-nfe`, `POST .../gerar-nfce`.
- Estrutura relevante: `itens[]` (produto, quantidade, valor, desconto), `parcelas[]` (forma de
  pagamento + vencimento), `situacao.id`/`valor`, `vendedor.id`, `loja.id`, `numeroLoja` (número do
  pedido na origem externa — **campo importante para correlação com o pedido da Força de Vendas**),
  `transporte`, `intermediador`.
- **Achado estrutural chave**: o Bling tem um sistema genérico e configurável de **Situações e
  Transições** (`Situacoes`, `SituacoesModulos`, `SituacoesTransicoes`) aplicável a Pedidos de Venda.
  Isso é um candidato natural para modelar o ciclo `pedido pendente -> exportado -> integrado` que a
  Força de Vendas documenta em `REGRAS-DE-NEGOCIO.md` (`RN-FDV-PED-001` a `007`, `RN-FDV-EXP-001/002`),
  desde que as situações/transições corretas sejam configuradas na conta Bling onde a combinação for
  aplicada (nesta fase, a conta de homologação do ERP parceiro; futuramente, a conta de cada cliente) —
  isso é decisão de mapeamento (Passo 05), não fato genérico da API.
- Direção possível: **BIDIRECIONAL** — `ferramenta -> ERP` via `POST /pedidos/vendas` (pedido criado
  pelo representante na Força de Vendas é criado no Bling); `ERP -> ferramenta` via `PATCH .../situacoes`
  e os campos de nota fiscal gerada, para devolver status/confirmação fiscal e logística.

### FormasPagamentos (`/formas-pagamentos`)

- LER/CRIAR/ATUALIZAR/EXCLUIR completos, mais `PATCH .../padrao` e `PATCH .../situacao`.
- Estrutura: uma única entidade combina o que a ferramenta separa em "Método de pagamento" (Métodos de
  Pagamento) e "Condição de pagamento" (Condições de Pagamento): `tipoPagamento` (enum numérico: 1
  Dinheiro, 3 Cartão de Crédito, 15 Boleto, 17 PIX etc.), `condicao` (string livre, ex.: `"1x"`, sem
  estrutura de parcelamento tipada), `destino` (conta a receber/pagar, ficha financeira, caixa/banco),
  `taxas` (aliquota/valor/prazo), `dadosCartao` (bandeira/tipo quando aplicável).
- Direção possível: BIDIRECIONAL, com **adaptação obrigatória** (colapsar método+condição da ferramenta
  em uma única `FormaPagamento` do Bling, ou usar `condicao` como campo textual para representar o
  parcelamento) — ver matriz da combinação.

### Logisticas (`/logisticas`, `/logisticas/servicos`, `/logisticas/objetos`, `/logisticas/etiquetas`,
`/logisticas/remessas`)

- Conjunto mais complexo do Bling relacionado a frete: logísticas configuradas (Correios, Jadlog,
  MelhorEnvio etc., ou `CustomLogistic` personalizada), serviços por logística (frete por item, prazo
  de entrega em dias úteis — `estimativaEntrega`), objetos de postagem (rastreamento, dimensões,
  embalagem), etiquetas (PDF/ZPL) e remessas (agrupamento de objetos para postagem, PLP).
- LER/CRIAR/ATUALIZAR/EXCLUIR (parcial, varia por sub-recurso — ver contagem de verbos na tabela).
- Relevância: **RELEVANTE_PARCIAL**. O conceito mais próximo de "Transportadora" da ferramenta não é
  `Logisticas` diretamente (que é pesado, amarrado a integrações reais de transporte), e sim o contato
  do tipo transportador dentro de `Contatos`/`NotasFiscaisTransporteTransportadorDTO` (nome, CNPJ/CPF,
  IE, endereço) usado como remetente/transportador em notas fiscais e vendas. Ver matriz para a decisão
  de qual candidato usar.
- `estimativaEntrega` (prazo em dias úteis por serviço de logística) é um conceito diferente do "Prazo
  de entrega" comercial da ferramenta (vinculado a marca/disponibilidade) — não devem ser tratados como
  equivalentes sem decisão explícita.

### PropostasComerciais (`/propostas-comerciais`)

- LER/CRIAR/ATUALIZAR/EXCLUIR completos, mais `PATCH .../situacoes`.
- Estrutura: `contato`, `itens[]` (produto, quantidade, desconto, valor), `parcelas[]`, `vendedor`,
  `transporte`, `situacao` (enum textual: Pendente/Aguardando/Não aprovado/Aprovado/Concluído/
  Rascunho).
- Candidato a mapear o conceito de "Orçamento" da ferramenta (`RN-FDV-ORC-001` a `006`: orçamento é
  documento comercial preliminar, editável, conversível em pedido). O Bling não expõe uma ação
  explícita de "converter proposta em pedido de venda" nesta especificação — a conversão, se existir,
  não está documentada como endpoint (`PENDENTE_DE_EVIDENCIA`).

### CamposCustomizados (`/campos-customizados`)

- Mecanismo genérico de campos customizados por módulo do Bling (`GET /campos-customizados/modulos`
  lista módulos elegíveis).
- Relevância: via de adaptação genérica para armazenar dados que a ferramenta precisa e o Bling não tem
  como entidade nativa (ex.: um código de "Gênero" ou atributo de "Cor" como campo customizado do
  produto), quando a implementação futura decidir usar essa estratégia. Registrado aqui como
  possibilidade técnica, não como decisão de mapeamento (isso pertence ao Passo 05).

### NaturezasOperacoes + NotasFiscais + ContasReceber/ContasContabeis

- `RELEVANTE_INDIRETO`: necessários apenas se a integração também cobrir o marco fiscal/financeiro pós-
  venda (gerar NF-e a partir do pedido, lançar/estornar contas a receber) — funcionalidade que o Bling
  já expõe diretamente a partir de Pedidos de Venda (`POST /pedidos/vendas/{id}/gerar-nfe`,
  `.../lancar-contas`). Não aprofundado além do necessário para registrar a possibilidade nesta etapa;
  aprofundar apenas se o mapeamento (Passo 05) confirmar que esse marco faz parte do escopo.

## Módulos sem contrapartida no Bling (verificação mecânica, ver `ANALISE-DO-ERP.md` seção 8)

Marca, Cor, Região, Tabela de preço, Gênero, Campanha, Preposto: **sem recurso dedicado no Bling**
(busca por termo nos 162 paths e 407 schemas — zero ou apenas referência de ID sem CRUD). Tratado com
profundidade na matriz da combinação, não neste catálogo geral do ERP.
