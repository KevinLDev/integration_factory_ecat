# Forca de Vendas - Cenarios funcionais

## Proposito

Este arquivo registra memoria funcional da ferramenta Forca de Vendas.

Ele e complementar ao contrato tecnico homologado da ferramenta e nao altera autoridade tecnica dos artefatos canonicos.

## Autoridade e classificacao de fonte

- FONTE_TECNICA: prova API/contrato/operacao/schema.
- FONTE_FUNCIONAL: prova uso/fluxo/experiencia/cenario.
- EVIDENCIA_RUNTIME: prova comportamento tecnico observado.
- INFERENCIA: hipotese nao comprovada.

Regra permanente:

- funcionalidade da ferramenta nao equivale automaticamente a endpoint no ERP;
- observacao funcional nao autoriza inventar endpoint tecnico.

Exemplo: modo funcional de codigo de barras nao prova endpoint tecnico `GET /barcode` sem evidencia tecnica.

## Escopo inicial desta versao

Esta primeira versao foi derivada de materiais funcionais fornecidos pelo operador, relacionados aos sete modos abaixo.

Nao trata estes modos como modulo tecnico nem endpoint de ERP.

## Convencao semantica por modo

Para cada modo, as afirmacoes abaixo usam os seguintes tipos:

- OBSERVADO_NA_FONTE_FUNCIONAL;
- DERIVADO_PELA_FABRICA;
- PERGUNTAS_PARA_ANALISE_DE_ERP;
- REQUISITO_DE_HOMOLOGACAO_FUTURA;
- INFERENCIA (quando aplicavel).

Essa separacao nao substitui a classificacao da fonte.

## Modo 1 - Direto

Fonte funcional principal:

- MODO DIRETO FINAL

OBSERVADO_NA_FONTE_FUNCIONAL:

- selecao comercial e montagem direta do pedido.

DERIVADO_PELA_FABRICA:

- cliente;
- origem/filial quando aplicavel;
- tabela/preco;
- filtros de produtos;
- produtos;
- referencia;
- grade/variacao;
- quantidade;
- estoque;
- carrinho;
- condicao de pagamento;
- pedido.

REQUISITO_DE_HOMOLOGACAO_FUTURA:

- validar cobertura do modo com combinacoes de cliente, produto, variacao, quantidade e condicao comercial, preservando montagem direta do pedido.

INFERENCIA:

- o ERP precisa disponibilizar dados/capacidades para alimentar essa experiencia;
- nao exigir endpoint chamado "modo direto".

## Modo 2 - Codigo de Barras

Fonte funcional principal:

- MODO CODIGO DE BARRAS FINAL

OBSERVADO_NA_FONTE_FUNCIONAL:

- identificar/localizar item comercializavel por codigo de barras e utiliza-lo no fluxo de venda.

DERIVADO_PELA_FABRICA:

- produto;
- referencia;
- EAN/codigo de barras;
- SKU/variacao;
- grade quando aplicavel;
- preco;
- estoque.

PERGUNTAS_PARA_ANALISE_DE_ERP:

- disponibiliza EAN/codigo?
- codigo pertence ao produto ou ao SKU?
- variacoes possuem codigos proprios?
- codigo e unico?
- formato possui restricoes?
- codigo e consultavel via API?
- existe relacao confiavel codigo -> item comercializavel?

REQUISITO_DE_HOMOLOGACAO_FUTURA:

- quando a combinacao suportar essa capacidade, validar massa com multiplos itens e codigos validos, incluindo relacao confiavel codigo -> item comercializavel.

INFERENCIA:

- ausencia dessa capacidade pode bloquear este modo sem bloquear automaticamente os demais modos da ferramenta.

## Modo 3 - Galeria

Fonte funcional principal:

- MODO GALERIA FINAL

OBSERVADO_NA_FONTE_FUNCIONAL:

- experiencia visual de catalogo/produtos.

DERIVADO_PELA_FABRICA:

- produto;
- referencia;
- imagens;
- cores;
- variacoes/grade;
- marca;
- categoria/subcategoria quando aplicavel;
- preco;
- estoque;
- atributos usados em filtros.

REQUISITO_DE_HOMOLOGACAO_FUTURA:

- variedade suficiente para cobrir varios produtos, imagens, imagens repetidas, multiplas imagens quando suportadas, produto sem imagem, placeholder, cores, grades e filtros.

## Modo 4 - Link E-commerce

Fonte funcional principal:

- MODO LINK ECOMMERCE FINAL

OBSERVADO_NA_FONTE_FUNCIONAL:

- dados de origem no ERP;
- configuracao funcional no Forca.

DERIVADO_PELA_FABRICA:

O ERP pode fornecer:

- produtos;
- referencias;
- imagens;
- clientes;
- precos;
- estoque;
- grades;
- condicoes comerciais.

O Forca pode usar esses dados para experiencias proprias como:

- composicao de catalogo;
- selecao de referencias;
- associacao a clientes;
- geracao/uso de link comercial;
- fluxo de pedido.

REQUISITO_DE_HOMOLOGACAO_FUTURA:

- validar que dados de origem e configuracao funcional permanecem separados na cobertura da combinacao.

INFERENCIA:

- nao exigir recurso no ERP chamado "Link E-commerce".

## Modo 5 - Passo a Passo

Fonte funcional principal:

- MODO PASSO A PASSO FINAL

OBSERVADO_NA_FONTE_FUNCIONAL:

- selecao progressiva por filtros/classificadores.

DERIVADO_PELA_FABRICA:

- marca;
- entrega/prazo quando aplicavel;
- tipo;
- genero;
- campanha;
- categoria;
- subcategoria;
- linha;
- estoque/faixa;
- demais classificadores sustentados por fonte.

REQUISITO_DE_HOMOLOGACAO_FUTURA:

- validar cobertura progressiva dos classificadores suportados pela combinacao sem assumir obrigatoriedade universal.

INFERENCIA:

- nao transformar automaticamente todo filtro visual em campo obrigatorio do ERP.

## Modo 6 - Referencia

Fonte funcional principal:

- MODO REFERENCIA FINAL

OBSERVADO_NA_FONTE_FUNCIONAL:

- localizacao de produtos/referencias por identificadores comerciais.

DERIVADO_PELA_FABRICA:

- referencia;
- produto;
- SKU/variacao quando aplicavel;
- preco;
- estoque;
- grade.

PERGUNTAS_PARA_ANALISE_DE_ERP:

- referencia existe?
- e unica?
- e produto ou SKU?
- pode ser consultada?
- multiplas referencias sao estaveis?
- existe relacao confiavel referencia -> item?

REQUISITO_DE_HOMOLOGACAO_FUTURA:

- quando suportado, validar identificacao por referencia com consistencia entre referencia, produto/SKU e disponibilidade comercial.

## Modo 7 - Replicar

Fonte funcional principal:

- MODO REPLICAR FINAL

OBSERVADO_NA_FONTE_FUNCIONAL:

- aplicacao/customizacao de uma base comercial para multiplos clientes/CNPJs.

DERIVADO_PELA_FABRICA:

- varios clientes;
- CNPJ/identidade do cliente;
- produtos;
- referencias;
- grades;
- quantidades;
- precos;
- estoque;
- condicoes comerciais;
- pedidos independentes.

REQUISITO_DE_HOMOLOGACAO_FUTURA:

- validar aplicacao para multiplos clientes com manutencao de pedidos independentes apos customizacao.

INFERENCIA:

- nao exigir endpoint "replicar" no ERP;
- foco de integracao e capacidade de representar dados e manter pedidos independentes corretamente.

## Cobertura funcional por modo

A combinacao ERP x Forca deve registrar cobertura funcional por modo com os campos:

- MODO;
- DADOS_NECESSARIOS;
- CAPACIDADES_DISPONIVEIS_NO_ERP;
- CAPACIDADES_FALTANTES;
- IMPACTO;
- EVIDENCIA.

Estados de impacto:

- BLOQUEIA_MODO;
- DEGRADA_MODO;
- NAO_IMPACTA_MODO;
- PENDENTE_DE_EVIDENCIA.

Exemplo conceitual:

- sem EAN confirmado no ERP, Modo Codigo de Barras pode ser BLOQUEIA_MODO;
- no mesmo contexto, Modo Direto pode permanecer NAO_IMPACTA_MODO.

## Rastreabilidade funcional desta versao

Fontes funcionais informadas pelo operador (referencia conceitual):

- MODO CODIGO DE BARRAS FINAL
- MODO DIRETO FINAL
- MODO GALERIA FINAL
- MODO LINK ECOMMERCE FINAL
- MODO PASSO A PASSO FINAL
- MODO REFERENCIA FINAL
- MODO REPLICAR FINAL

Observacoes de rastreabilidade:

- os binarios de video nao precisam ser versionados neste bloco;
- quando hash oficial nao estiver disponivel, nao inventar hash.

## Pendencias desta camada

- nenhuma pendencia tecnica de contrato e resolvida por este documento isoladamente;
- se surgir divergencia tecnica a partir de fonte funcional, registrar pendencia para avaliacao futura sem alteracao silenciosa do contrato homologado.