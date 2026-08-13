# Modelo - Plano de homologacao da combinacao ERP x ferramenta

## Identificacao

- ERP: <NOME_DO_ERP>
- ERP_SLUG: <erp-slug>
- FERRAMENTA: <NOME_DA_FERRAMENTA>
- FERRAMENTA_SLUG: <ferramenta-slug>
- COMBINACAO: <erp-slug> x <ferramenta-slug>
- PERFIL: HOMOLOGACAO
- ETAPA_ORIGEM: ERP_PARCEIRO_PASSO_03
- DATA_PLANEJAMENTO: <AAAA-MM-DD>

## Base Mestra e baseline de homologacao

- BASE_MESTRA_ERP: <referencia conceitual da base mestra do ERP>
- BASE_MESTRA_REUTILIZADA: SIM | NAO | PARCIAL
- PERFIL_BASELINE: HOMOLOGACAO

Baseline recomendado para ERP Parceiro em HOMOLOGACAO:

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
- tabelas_de_preco: 3 (quando suportado/relevante)
- condicoes_de_pagamento: 5 (quando suportado/relevante)
- vendedores: 10 (quando suportado/relevante)
- representantes: 5 (quando suportado/relevante)
- prepostos: 5 (quando suportado/relevante)
- transportadoras: 5 (quando suportado/relevante)
- pedidos: 100 (quando aplicavel)

## Fontes utilizadas

- Contrato tecnico da ferramenta: <caminho>
- Cenarios funcionais da ferramenta: <caminho ou NAO_APLICAVEL>
- Homologacao da ferramenta para integracoes: <caminho>
- Analise do ERP: <caminho>
- Capacidades do ERP: <caminho>
- Matriz ERP x ferramenta: <caminho>
- Pendencias da combinacao: <caminho>
- Padrao global de massa comercial: <caminho>
- Padrao de base comercial: <caminho>
- Convencao de identificadores: <caminho>
- Padrao de imagens: <caminho>

## Objetivo da homologacao

Descrever objetivo concreto da homologacao para a combinacao, com foco em cobertura rastreavel dos cenarios relevantes.

## Escopo tecnico

Listar capacidades tecnicas exigidas e capacidades confirmadas do ERP usadas no planejamento.

## Escopo funcional

Listar modos/cenarios funcionais da ferramenta considerados e sua relacao com dados necessarios.

## Cenarios de homologacao

Para cada cenario selecionado, registrar:

- CENARIO_ID:
- DESCRICAO:
- ORIGEM_DO_REQUISITO:
- CAPACIDADE_FERRAMENTA_RELACIONADA:
- CAPACIDADE_ERP_RELACIONADA:
- EVIDENCIA_DISPONIVEL:
- ENTIDADES_NECESSARIAS:
- FAMILIAS_NECESSARIAS:
- QUANTIDADE_REPETICAO_PLANEJADA:
- DEPENDENCIAS:
- IMPACTO_SE_NAO_COBERTO:
- STATUS_DO_PLANEJAMENTO:

## Capacidades confirmadas

Listar somente capacidades do ERP com evidencia suficiente e papel no plano.

## Gaps e restricoes

Listar gaps/restricoes sem mascarar cobertura.

Para cada gap:

- GAP_ID:
- REQUISITO_AFETADO:
- EVIDENCIA:
- IMPACTO:
- MODO_AFETADO:
- POSSIVEL_ADAPTACAO:
- STATUS:

## Impactos funcionais

Classificar por modo/cenario:

- BLOQUEIA_MODO
- DEGRADA_MODO
- NAO_IMPACTA_MODO
- PENDENTE_DE_EVIDENCIA

## Familias planejadas

Descrever familias com objetivo, cobertura e repeticao.

## Quantidades derivadas

Justificar volume por cobertura, repeticao, diversidade, paginacao, filtros e restricoes reais.

Nao usar quantidade fixa universal.

Para HOMOLOGACAO de ERP Parceiro, partir do baseline forte e registrar ajustes para cima/baixo com justificativa tecnica.

## Desvios do baseline

Preencher quando o planejado diferir do baseline:

- ENTIDADE:
- BASELINE:
- PLANEJADO:
- MOTIVO:

## Entidades comerciais

Listar somente entidades necessarias para a combinacao e cenario:

- marcas
- categorias
- subcategorias
- produtos
- variacoes
- SKUs
- cores
- grades
- imagens
- precos
- tabelas de preco
- estoques
- filiais
- clientes
- vendedores
- representantes
- condicoes
- transportadoras
- campanhas
- pedidos
- outras aplicaveis

## Dependencias

Representar ordem planejada da materializacao futura como DAG da combinacao:

- entidade
- depende_de
- evidencia
- observacoes

## Estrategia de identificadores

Aplicar id_logico deterministico e estavel por entidade.

Registrar separacao entre ID_LOGICO e CODIGO_FISICO quando houver restricao do ERP.

## Estrategia de codigos/EAN (quando aplicavel)

Definir se o cenario usa:

- CODIGO_REAL
- CODIGO_SINTETICO_HML

Somente quando ferramenta/cenario exigir.

Registrar formato, checksum e unicidade aplicaveis.

## Estrategia de imagens (quando aplicavel)

Definir uso de referencias logicas de imagem e casos de SEM_IMAGEM.

Para base de 200 produtos com imagem aplicavel, registrar se foi usada cardinalidade baseline (45/45/45/45/10/10) ou desvio justificado.

Nao incluir binarios.

## Cobertura esperada

Mapear:

- CENARIO -> familias/registros planejados
- REGISTRO/FAMILIA -> cenarios cobertos

## Coberturas impossiveis

Listar cenarios/modos com cobertura impossivel ou parcial, com justificativa tecnica.

## Pendencias bloqueantes

Listar pendencias que impedem materializacao segura da base real.

## Gate final da etapa

- ERP_IDENTIFICADO: SIM | NAO
- FERRAMENTA_HOMOLOGADA: SIM | NAO
- PASSO_02_APTO: SIM | NAO
- PLANO_DE_HOMOLOGACAO: GERADO | BLOQUEADO
- BASE_COMERCIAL_PLANEJADA: GERADA | BLOQUEADA
- COBERTURA_PLANEJADA: COMPLETA | PARCIAL_JUSTIFICADA | INSUFICIENTE
- PENDENCIAS_BLOQUEANTES: <quantidade>
- PRONTO_PARA_CRIAR_BASE_REAL: SIM | NAO

## Criterios para proxima etapa

Declarar condicoes minimas para uma etapa futura de materializacao da base planejada.

Esta secao nao publica nem inicia etapa futura automaticamente.