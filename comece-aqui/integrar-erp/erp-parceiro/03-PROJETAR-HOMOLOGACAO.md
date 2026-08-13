# 03 - Projetar homologacao da combinacao ERP x ferramenta

## Quando usar

Use esta etapa quando o Passo 02 da jornada ERP parceiro ja foi concluido com evidencia suficiente para planejar a homologacao da combinacao.

Esta etapa e somente de planejamento.

## Objetivo oficial

Responder com precisao:

"O que exatamente precisa existir para homologarmos esta combinacao ERP x ferramenta com cobertura suficiente?"

Transformar:

- contrato tecnico da ferramenta;
- cenarios funcionais da ferramenta;
- regras de negocio da ferramenta;
- capacidades confirmadas do ERP;
- matriz ERP x ferramenta;
- pendencias/gaps;
- padrao global de massa comercial;

em:

- PLANO-DE-HOMOLOGACAO.md;
- BASE-COMERCIAL-PLANEJADA.yaml.

O planejamento deve cobrir conjuntamente:

CAMPOS
+
CENARIOS_FUNCIONAIS
+
REGRAS_COMERCIAIS
+
RELACOES_ENTRE_ENTIDADES

Quantidade isolada nao prova cobertura: 200 produtos ou 20 clientes comercialmente identicos continuam insuficientes para regras que dependem de tabela, regiao, visibilidade, origem, papel comercial ou aprovacao/exportacao.

## Baseline forte de homologacao (ERP Parceiro)

Para perfil HOMOLOGACAO na jornada ERP Parceiro, usar baseline operacional recomendado:

- produtos: 200
- clientes: 20
- marcas: 10
- categorias: 10
- subcategorias: 25
- linhas: 8 (quando aplicavel)
- tipos: 5 (quando aplicavel)
- generos: ate 5 valores relevantes suportados
- campanhas: 4 (quando aplicavel)
- filiais: 3 (quando suportado/relevante)
- tabelas de preco: 3 (quando suportado/relevante)
- condicoes de pagamento: 5 (quando suportado/relevante)
- vendedores: 10 (quando suportado/relevante)
- representantes: 5 (quando suportado/relevante)
- prepostos: 5 (quando suportado/relevante)
- transportadoras: 5 (quando suportado/relevante)
- pedidos: 100 (quando pedido fizer parte da combinacao)

Regra central:

- TARGET_PRODUTOS_PADRAO = 200 para HOMOLOGACAO de ERP Parceiro;
- pode aumentar acima de 200 quando cobertura exigir;
- reduzir abaixo de 200 somente com justificativa concreta e registrada.

Esse baseline nao vira contrato universal. Dimensoes nao aplicaveis permanecem NAO_APLICAVEL sem virar gap automatico.

## Base Mestra de homologacao do ERP

Conceito:

ERP PARCEIRO
-> BASE MESTRA DE HOMOLOGACAO DO ERP
-> reutilizada para homologar uma ou mais ferramentas
-> cada combinacao ERP x ferramenta seleciona/filtra o que usa.

O Passo 03 da combinacao nao recria toda massa do zero quando reuso for possivel; ele planeja o recorte, os complementos e os desvios necessarios.

## Pre-condicoes obrigatorias

So executar se todos os itens abaixo puderem ser confirmados:

- ERP identificado sem ambiguidade;
- ferramenta identificada sem ambiguidade;
- ferramenta com prontidao HOMOLOGADA_PARA_INTEGRACOES;
- Passo 02 da jornada ERP parceiro concluido em nivel suficiente;
- memoria tecnica do ERP existente;
- analise da combinacao ERP x ferramenta existente;
- capacidades/gaps suficientes para planejamento.

Se faltar evidência, nao inventar. Registrar PENDENTE_DE_EVIDENCIA e seguir apenas com a parte viavel.

## Auto-descoberta obrigatoria

O operador nao deve repetir contexto ja conhecido.

Antes de planejar, o executor deve descobrir automaticamente no repositorio:

- ERP;
- ferramenta;
- slugs;
- memoria tecnica do ERP;
- memoria da ferramenta;
- memoria de regras de negocio da ferramenta, quando existir;
- combinacao ERP x ferramenta;
- resultado do Passo 02;
- matriz;
- pendencias;
- perfil funcional;
- padrao global de massa.

Solicitar ao operador somente dado realmente bloqueante que nao exista no workspace.

## O que esta etapa faz

- valida contexto e gate de entrada;
- seleciona cenarios de homologacao realmente necessarios para a combinacao;
- seleciona regras comerciais e relacoes entre entidades que exigem cobertura de massa;
- calcula cobertura por cenario, com repeticao adequada;
- define familias de dados com combinacao inteligente (sem explosao cartesiana);
- define entidades comerciais necessarias (somente as aplicaveis);
- define estrategia de identificadores logicos estaveis;
- define estrategia de EAN/codigo quando aplicavel;
- define estrategia de imagens quando aplicavel;
- define dependencias da criacao futura (DAG da combinacao);
- registra gaps, impactos funcionais e coberturas impossiveis/pendentes;
- gera artefatos concretos de planejamento para futura materializacao.

## O que esta etapa NAO faz

- nao cria dados no ERP;
- nao chama API externa;
- nao executa POST/PUT/PATCH/DELETE comercial;
- nao usa credenciais;
- nao desenvolve integracao;
- nao cria Passo 04;
- nao altera contrato homologado da ferramenta;
- nao altera Harness;
- nao altera manifestos existentes.

## Regras-chave de planejamento

### Ferramenta e soberana

A ferramenta E-Catalogos continua autoridade canonica.

O ERP e analisado/adaptado contra contrato e cenarios da ferramenta.

Incompatibilidade vira gap; nao fingir cobertura.

### Tecnico x funcional

Nao confundir endpoint com funcionalidade.

FUNCIONALIDADE_DA_FERRAMENTA != ENDPOINT_DE_MESMO_NOME_NO_ERP

### Selecao de cenarios

Cada cenario selecionado deve registrar, quando aplicavel:

- identificador;
- descricao;
- origem do requisito;
- capacidade da ferramenta relacionada;
- capacidade do ERP relacionada;
- evidencia disponivel;
- entidades necessarias;
- familias necessarias;
- quantidade/repeticao planejada;
- dependencias;
- impacto se nao coberto;
- status do planejamento.

### Impacto funcional

Usar:

- BLOQUEIA_MODO;
- DEGRADA_MODO;
- NAO_IMPACTA_MODO;
- PENDENTE_DE_EVIDENCIA.

Gap em modo especifico nao bloqueia automaticamente toda a integracao.

### Cobertura e repeticao

Nao existe quantidade fixa universal.

Volume deve ser derivado de cobertura, repeticao, diversidade, paginacao, filtros e capacidade real do ERP, partindo do baseline forte de HOMOLOGACAO.

Cenario relevante nao deve depender de registro unico sem justificativa.

Nao reduzir para volume muito abaixo do baseline apenas por otimizacao matematica sem justificativa real.

### Familias e combinacao inteligente

Organizar por familias quando isso melhora cobertura e clareza.

Combinar cenarios no mesmo registro e permitido e desejavel, desde que nao elimine repeticao critica.

Familias de produtos devem considerar, quando aplicavel: nacional/importado, pronta entrega/nao pronta entrega, grade aberta/fechada, marcas, categorias, tabelas, disponibilidades e presenca/ausencia de atributos opcionais.

Familias de clientes devem considerar, quando aplicavel: regioes, tabelas, representantes, prepostos, condicoes comerciais, clientes ativos e cenarios controlados de inatividade para validar listagem/visibilidade.

### Cenarios comerciais explicitos

Quando sustentados pela regra e pela capacidade da combinacao, planejar:

1. cliente SP -> Regiao Sudeste -> Tabela A -> Produto X com preco A e cliente CE -> Regiao Nordeste -> Tabela B -> mesmo Produto X com preco B;
2. Produto Y presente na Tabela A e ausente na Tabela B;
3. grade aberta com P/M/G/GG e quantidades individualmente selecionaveis;
4. grade fechada com pack/composicao fixa;
5. pronta entrega compativel com prazo disponivel;
6. nao pronta entrega com disponibilidade futura que restrinja prazos anteriores;
7. Marca A vinculada ao Prazo A e Marca B ao Prazo B;
8. produtos nacionais e importados para validar separacao comercial;
9. pedidos originados por representante e por preposto para validar aprovacao/exportacao;
10. orcamento convertido em pedido, quando aplicavel.

Se o ERP nao suportar os dados necessarios, registrar gap. Nao declarar o cenario executavel por obrigacao do catalogo.

### Rastreabilidade por regra

O plano deve listar `REGRAS_DE_NEGOCIO_CONSIDERADAS`. Cada cenario/familia relevante deve registrar `cenario_tags` e `regra_tags`, usando os IDs estaveis definidos em `REGRAS-DE-NEGOCIO.md` e sem criar IDs aleatorios.

Mapeamento minimo:

- CENARIO/FAMILIA -> REGRAS_DE_NEGOCIO_COBERTAS;
- REGISTRO -> REGRA_TAGS.

### Identificadores

Aplicar parceiros/modelos/base-comercial/CONVENCAO-DE-IDENTIFICADORES.md.

Manter id_logico estavel e separar de codigo_fisico quando houver restricoes do ERP.

### EAN/codigo

Somente planejar quando ferramenta/cenario exigir.

Sem exigencia funcional, ausencia de EAN nao e gap.

Quando exigido, registrar estrategia de determinismo, formato, checksum e unicidade conforme combinacao.

### Imagens

Aplicar parceiros/modelos/base-comercial/PADRAO-DE-IMAGENS.md.

Referenciar ids logicos de imagem quando necessario, sem adicionar binarios.

Quando imagens forem aplicaveis em base de 200 produtos, baseline recomendado de cardinalidade:

- 45 com 1 imagem
- 45 com 2 imagens
- 45 com 3 imagens
- 45 com 4 imagens
- 10 SEM_IMAGEM
- 10 IMG-PLACEHOLDER-001

Reuso de imagem continua permitido.

### Diversidade para relatorios

Quando os 100 pedidos do baseline forem aplicaveis, distribuir diversidade suficiente entre produtos, marcas, categorias, subcategorias, clientes, representantes, prepostos, referencias, variantes, quantidades e valores. Nao e obrigatorio fabricar uma Curva ABC perfeita; a massa apenas nao pode tornar os relatorios inuteis por uniformidade.

Curva ABC continua sendo resultado funcional e nao exige endpoint de mesmo nome no ERP.

### Snapshot e vigencia das fontes

`PLANO-DE-HOMOLOGACAO.md` deve registrar o snapshot das fontes efetivamente usadas: contrato tecnico, cenarios funcionais, regras de negocio, analise do ERP, capacidades do ERP, matriz e padrao de massa.

Registrar caminho e, quando ja disponivel, versao, SHA-256 e modo de hash. Nao inventar hash nem versao ausente. Esse snapshot permite ao Passo 04 detectar plano potencialmente obsoleto antes de escrever.

## Outputs da execucao real desta etapa

Na combinacao:

- erps/<erp-slug>/integracoes/<ferramenta-slug>/PLANO-DE-HOMOLOGACAO.md
- erps/<erp-slug>/integracoes/<ferramenta-slug>/BASE-COMERCIAL-PLANEJADA.yaml

Fontes de modelo:

- parceiros/modelos/base-comercial/MODELO-PLANO-DE-HOMOLOGACAO.md
- parceiros/modelos/base-comercial/MODELO-BASE-HOMOLOGACAO.yaml

## Gate final da etapa

Registrar explicitamente:

- ERP_IDENTIFICADO: SIM | NAO
- FERRAMENTA_HOMOLOGADA: SIM | NAO
- PASSO_02_APTO: SIM | NAO
- PLANO_DE_HOMOLOGACAO: GERADO | BLOQUEADO
- BASE_COMERCIAL_PLANEJADA: GERADA | BLOQUEADA
- COBERTURA_PLANEJADA: COMPLETA | PARCIAL_JUSTIFICADA | INSUFICIENTE
- PENDENCIAS_BLOQUEANTES: <quantidade>
- SNAPSHOT_DAS_FONTES: REGISTRADO | INSUFICIENTE
- PRONTO_PARA_CRIAR_BASE_REAL: SIM | NAO

Se houver cobertura parcial valida, justificar tecnicamente por modo/cenario.

Se houver desvio de baseline, registrar obrigatoriamente em PLANO-DE-HOMOLOGACAO.md na secao DESVIOS DO BASELINE.

## Falhas nao apagam planejamento

Mesmo com gaps, a etapa pode e deve produzir plano e base planejada para a parte viavel.

O gate final decide se avanca, nao a ausencia total de limitacoes.

## Como chamar no chat do Codex

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-03-PROJETAR-HOMOLOGACAO.md

Continue a integracao do ERP parceiro ja analisado na execucao atual com a ferramenta alvo ja homologada.

Projete a homologacao da combinacao ERP x ferramenta usando apenas o contexto existente no repositorio.

Nao pedir ao operador dados que ja existam no workspace.

Se faltar informacao bloqueante que nao exista no repositorio, solicitar somente o faltante.

Execute somente o Passo 03 da jornada ERP parceiro.

Esta etapa e somente planejamento.

Nao criar dados no ERP.
Nao executar POST/PUT/PATCH/DELETE comercial.
Nao usar credenciais.
Nao chamar APIs externas.
Nao desenvolver integracao.
Nao criar Passo 04.
Nao alterar contrato homologado da ferramenta.
Nao alterar Harness.
Nao alterar manifestos existentes.

Registrar no plano o snapshot das fontes efetivamente usadas, incluindo regras de negocio, com hash/versao somente quando disponivel.
```

### PARE DE COPIAR AQUI

Substitua apenas o que for realmente necessario; o restante deve ser auto-descoberto.

## O que esperar do retorno

- STATUS DA ETAPA: CONCLUIDA | PENDENTE | BLOQUEADA
- gate de entrada e gate final completos
- caminhos dos dois outputs planejados
- resumo de cobertura planejada
- gaps e impactos por modo/cenario
- pendencias bloqueantes
- snapshot das fontes usadas no planejamento
- proxima acao permitida (sem iniciar etapa futura automaticamente)

## Cenarios de validacao semantica desta etapa

A) Ferramenta exige EAN por SKU e ERP suporta -> planejar cobertura.
B) Ferramenta exige EAN por SKU e ERP nao suporta -> gap e sem cobertura fingida.
C) Ferramenta nao usa EAN -> nao planejar EAN.
D) Cenario critico em unico produto sem justificativa -> cobertura insuficiente.
E) Plano com 180 produtos -> valido se justificado por cobertura.
F) Plano com 52 produtos cobrindo tudo com repeticao -> valido.
G) Modo especifico nao atendido -> pode bloquear so o modo, com justificativa.
H) ERP sem imagens e ferramenta nao exige imagem -> sem gap.
I) ERP sem imagens e cenario exige imagem -> gap com impacto.
J) Familia cobre varios cenarios ao mesmo tempo -> valido e desejavel.
K) Ordem fixa global sem evidencia do ERP -> invalido.
L) Etapa tenta chamar POST comercial -> invalido.
M) Etapa marca COBERTURA_CRIADA_NO_ERP -> invalido no Passo 03.
N) Etapa gera somente "100 produtos" sem plano concreto -> invalido.
O) Etapa duplica conhecimento geral do ERP -> invalido.
P) Gap opcional bloqueia tudo sem justificativa -> invalido.
Q) Reducao de 200 para 50 sem limitacao real comprovada -> invalido.
R) Ferramenta nao usa campanha/imagem e planejamento marca 0/NAO_APLICAVEL com justificativa -> valido.

## Proximo documento

Apos concluir, aguarde a proxima etapa oficialmente publicada na jornada ERP parceiro.

Nao iniciar automaticamente nenhuma etapa futura.
