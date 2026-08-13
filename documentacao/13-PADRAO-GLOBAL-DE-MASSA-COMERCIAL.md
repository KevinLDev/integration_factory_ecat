# Padrao global de massa comercial da Fabrica de Integracoes

## 1. Proposito

Este documento define o padrao global reutilizavel para projetar massa comercial forte, repetivel e auditavel para homologacao.

Este padrao e generico para qualquer ferramenta E-Catalogos (Forca, B2B, Lojas e futuras), sem impor obrigacao universal de todos os cenarios para todas as ferramentas.

## 2. Autoridade e selecao final

Quem manda continua sendo a ferramenta E-Catalogos.

A selecao final de cenarios deve sempre ser derivada da combinacao de:

- CENARIOS FUNCIONAIS DA FERRAMENTA;
- CONTRATO TECNICO DA FERRAMENTA;
- CAPACIDADES CONFIRMADAS DO ERP;
- RESTRICOES DA COMBINACAO.

Ter um cenario no catalogo global significa capacidade de projeto da Fabrica, nao obrigacao universal.

## 3. Formula da base

Formula conceitual obrigatoria:

PADRAO GLOBAL DE MASSA
+
NECESSIDADES DA FERRAMENTA
+
CAPACIDADES DO ERP
->
PLANO DE HOMOLOGACAO DA COMBINACAO

Para ERP Parceiro no perfil HOMOLOGACAO, aplicar leitura operacional complementar:

BASELINE_HOMOLOGACAO_ERP_PARCEIRO
+
CONTRATO_TECNICO_DA_FERRAMENTA
+
CENARIOS_FUNCIONAIS
+
CAPACIDADES_DO_ERP
+
GAPS_E_RESTRICOES
->
BASE_COMERCIAL_FINAL_PLANEJADA

Regras:

- nao gerar dado que o ERP comprovadamente nao consegue representar;
- nao remover necessidade da ferramenta silenciosamente;
- quando houver incompatibilidade, registrar gap, adaptacao ou cobertura impossivel.

## 4. Cobertura em vez de quantidade fixa

A massa comercial nao tem quantidade fixa obrigatoria de registros.

Exemplos validos:

- base com 100, 150, 200 ou mais produtos, quando necessario para cobertura confiavel;
- base com menos registros, quando a mesma cobertura e repeticao forem comprovadas.

A metrica principal e cobertura com repeticao adequada, nao volume fixo predefinido.

### 4.1 Baseline operacional da jornada ERP Parceiro (perfil HOMOLOGACAO)

Para a jornada ERP Parceiro no perfil HOMOLOGACAO, a Fabrica adota baseline operacional recomendado para massa forte de homologacao.

Baseline recomendado:

- PRODUTOS: 200
- CLIENTES: 20
- MARCAS: 10
- CATEGORIAS: 10
- SUBCATEGORIAS: 25
- LINHAS: 8 (quando aplicavel)
- TIPOS: 5 (quando aplicavel)
- GENEROS: ate 5 valores relevantes suportados
- CAMPANHAS: 4 (quando aplicavel)
- FILIAIS: 3 (quando suportado/relevante)
- TABELAS_DE_PRECO: 3 (quando suportado/relevante)
- CONDICOES_DE_PAGAMENTO: 5 (quando suportado/relevante)
- VENDEDORES: 10 (quando suportado/relevante)
- REPRESENTANTES: 5 (quando suportado/relevante)
- PREPOSTOS: 5 (quando suportado/relevante)
- TRANSPORTADORAS: 5 (quando suportado/relevante)
- PEDIDOS: 100 (quando pedido fizer parte da combinacao)

Regras:

- 200 produtos e o ponto de partida operacional para HOMOLOGACAO em ERP Parceiro;
- o plano pode aumentar acima de 200 quando cobertura, paginacao, diversidade ou cenarios exigirem;
- reduzir abaixo de 200 exige justificativa concreta e registrada (limite real de ambiente/API/ERP, dominio extremamente simples, impossibilidade comprovada ou decisao humana registrada);
- MINIMA continua disponivel para smoke/debug e nao substitui HOMOLOGACAO.

## 5. Repeticao obrigatoria de cenarios relevantes

Evitar cenario relevante representado por um unico registro.

Por padrao, caracteristicas importantes devem aparecer em multiplos registros independentes para provar:

- consistencia;
- estabilidade;
- listagem;
- paginacao;
- busca;
- filtros;
- sincronizacao em volume;
- ausencia de comportamento especial preso a um unico registro.

Singleton so e aceitavel quando o cenario e naturalmente unico e a excecao estiver justificada.

## 6. Organizacao por familias e padroes

A massa deve ser organizada por familias/padroes de cobertura.

Exemplos conceituais (nao rigidos):

- FAMILIA-GRADE-ALFA (P/M/G/GG, multiplos produtos e cores);
- FAMILIA-GRADE-NUMERICA (38/40/42/44, combinacoes de cor);
- FAMILIA-SEM-COR;
- FAMILIA-MULTI-COR;
- FAMILIA-MULTI-FILIAL.

Os nomes e quantidades de familias devem ser derivados da cobertura necessaria de cada combinacao.

## 6.1 Base Mestra de homologacao do ERP Parceiro

Conceito complementar:

ERP PARCEIRO
-> BASE MESTRA DE HOMOLOGACAO DO ERP
-> reutilizavel para homologar uma ou mais ferramentas
-> combinacoes ERP x ferramenta selecionam/filtram esse universo.

A Base Mestra representa densidade e diversidade comercial ampla do ERP e nao precisa ser recriada do zero para cada ferramenta quando o mesmo conjunto puder ser reutilizado.

Cada combinacao ERP x ferramenta continua exigindo:

- PLANO-DE-HOMOLOGACAO.md
- BASE-COMERCIAL-PLANEJADA.yaml

Esses artefatos devem declarar quais partes da Base Mestra sao utilizadas e quais extensoes/desvios sao necessarios para aquela combinacao.

## 7. Catalogo global de dimensoes comerciais

O catalogo global pode incluir, quando relevante para a combinacao:

- IDENTIFICACAO: id logico, referencia, sku, codigo externo, ean/codigo de barras;
- PRODUTO: nome, descricao, marca, categoria, subcategoria, linha, campanha, genero, tipo, composicao, ncm, origem, prazo;
- VARIACAO: cor, tamanho, grade, sku, codigo, ean por variacao quando suportado;
- GRADES: sem grade, P/M/G/GG, 38/40/42/44, outras grades;
- CORES: sem cor, uma cor, poucas cores, 3/4/5+ cores;
- PRECO: preco simples, multiplas tabelas, diferencas entre tabelas, preco por sku, preco unitario/pack;
- ESTOQUE: zero/baixo/medio/alto, por filial, diferencas entre filiais, unidade/pack;
- IMAGEM: valida, reutilizada, multiplas imagens, sem imagem, placeholder, imagem por cor/variacao quando suportado;
- CLIENTE: multiplos clientes, PF/PJ quando aplicavel, cpf/cnpj, endereco, contato, regiao, vendedor, tabela de preco, condicao comercial;
- ORGANIZACAO COMERCIAL: vendedor, representante, filial, showroom, transportadora, condicao de pagamento, campanha e outros recursos exigidos;
- PEDIDO: simples, varios itens, varias grades, clientes/condicoes/origens distintas.

### 7.1 Politica explicita de EAN/codigo de barras

EAN/codigo de barras e capacidade do catalogo global, nao requisito universal.

Regra de ativacao:

- aplicar politica de EAN/codigo somente quando ferramenta ou cenario funcional da combinacao exigir esse dado;
- se a ferramenta nao exigir EAN/codigo, EAN nao e obrigatorio;
- se a ferramenta nao exigir EAN/codigo, ausencia de EAN no ERP nao e gap;
- nao gerar EAN sintetico sem necessidade;
- nao degradar cobertura por ausencia de EAN quando o cenario nao exigir.

Fluxo conceitual:

- catalogo global sabe trabalhar com EAN;
- ferramenta/cenario funcional decide se precisa de EAN;
- se NAO precisa, ignorar essa capacidade na combinacao;
- se precisa, verificar capacidade real do ERP;
- se ferramenta precisa e ERP suporta, planejar cobertura;
- se ferramenta precisa e ERP nao suporta, registrar gap/adaptacao/cobertura impossivel.

Quando codigos sinteticos forem necessarios para homologacao:

- gerar de forma deterministica e reproduzivel para o mesmo plano/identidade logica;
- respeitar formato exigido pela combinacao;
- aplicar checksum/digito verificador valido quando o padrao exigir;
- garantir unicidade no escopo aplicavel da massa de homologacao;
- manter relacao rastreavel com produto/SKU/variacao (ou outra entidade suportada);
- respeitar a entidade correta do codigo conforme capacidade real do ERP (produto, SKU, variacao ou outra);
- nao presumir EAN-13 universalmente.

Quando a combinacao exigir especificamente EAN-13:

- gerar exatamente 13 digitos;
- calcular digito verificador valido;
- garantir unicidade no escopo da massa.

Escopo comercial dos codigos sinteticos:

- EAN/GTIN sintetico de homologacao nao representa codigo comercial oficialmente registrado;
- nao declarar licenciamento, propriedade comercial ou identificacao oficial de mercado;
- usar somente para homologacao.

Codigos reais x sinteticos:

- se a execucao possuir codigo real autorizado, nao substituir silenciosamente por sintetico;
- evitar colisao conhecida entre codigos reais e sinteticos na massa/ambiente;
- preservar codigo real quando ele fizer parte do cenario autorizado;
- registrar no plano se o cenario usa `CODIGO_REAL` ou `CODIGO_SINTETICO_HML`;
- evitar reproduzir codigo real em artefatos onde isso nao for necessario.

Esta politica define governanca, nao implementa algoritmo de geracao nesta etapa.

## 8. Combinacao inteligente de cenarios

Um mesmo registro pode cobrir multiplos cenarios.

Objetivo:

- maximizar cobertura com combinacao inteligente;
- evitar explosao desnecessaria de volume;
- manter repeticao suficiente para confiabilidade.

Nao otimizar a ponto de eliminar repeticao de caracteristicas criticas.

Evitar produto cartesiano. Um mesmo registro pode cobrir multiplas dimensoes simultaneamente.

## 9. Cobertura declarada e rastreavel

Cada entidade/familia deve declarar por que existe.

Rastreabilidade obrigatoria:

- CENARIO -> REGISTROS QUE O COBREM;
- REGISTRO -> CENARIOS QUE ELE COBRE.

Cobertura forte de homologacao tambem deve observar experiencia funcional e administrativa quando aplicavel:

- app: filtros, listagem, busca e paginacao;
- painel/backoffice: clientes, vendedores, representantes, prepostos, transportadoras, filiais, tabelas, condicoes, pedidos, estoque e precos.

Exemplo de declaracao conceitual:

- id_logico: HML-PROD-027
- cenario_tags: EAN_POR_SKU, GRADE_P_M_G_GG, CINCO_CORES, ESTOQUE_MULTI_FILIAL, MULTIPLAS_IMAGENS.

## 10. Estados de cobertura

Preparar estados conceituais para governanca de homologacao:

- COBERTURA_PLANEJADA;
- COBERTURA_CRIADA_NO_ERP;
- COBERTURA_SINCRONIZADA;
- COBERTURA_VALIDADA_NA_FERRAMENTA.

Este documento nao implementa runtime; define apenas o modelo de acompanhamento.

## 11. Dependencias

A ordem de criacao nao e fixa globalmente.

A execucao futura deve derivar dependencias de:

- CAPACIDADES-DO-ERP;
- documentacao/evidencia;
- contrato da ferramenta.

Este padrao apenas define como representar dependencias.

## 12. Core global nao e contrato universal

Reforco:

- ter EAN no catalogo global nao obriga todo ERP a ter EAN;
- ter imagens no catalogo global nao obriga todo ERP a ter imagens;
- ter campanha no catalogo global nao obriga todo ERP a ter campanha.

Significado correto:

- a Fabrica sabe projetar e testar esses cenarios quando forem necessarios.

A ferramenta seleciona o que importa.
O ERP determina o que consegue fornecer.
A combinacao registra gaps.

Baseline forte nao converte dimensoes em obrigacao universal. Dimensao nao aplicavel deve ficar como nao aplicavel/zero sem virar gap quando nao for requisito da ferramenta.

## 12.1 Nacional x importado (condicional)

Quando ERP e ferramenta possuirem e utilizarem origem nacional/importado, a distribuicao desejada para baseline de 200 produtos e:

- 100 NACIONAIS
- 100 IMPORTADOS

Essa distribuicao e condicional:

- se a ferramenta nao utiliza origem, nao obrigar;
- se ERP nao possui e ferramenta nao exige, nao e gap;
- se ferramenta exige e ERP nao representa, registrar gap/impacto.

## 13. Exemplo de consumo (Forca) sem obrigacao global

Forca de Vendas pode consumir subconjuntos diferentes do catalogo global conforme modo funcional, por exemplo:

- Codigo de Barras: ean/referencia/sku;
- Galeria: imagem/cor/grade;
- Replicar: varios clientes e pedidos independentes.

Esse exemplo nao cria base concreta e nao transforma Forca em regra universal.

## 14. Escopo deste bloco

Este bloco e somente padrao global reutilizavel.

Nao inclui:

- execucao real;
- base comercial concreta;
- chamadas API;
- scripts geradores;
- banco/servidor/runtime;
- imagem binaria;
- Passo 03.

## 15. Cenarios de validacao conceitual

A) Ferramenta precisa EAN por SKU e ERP suporta:
- gerar varios produtos/SKUs com codigos validos.

B) Ferramenta precisa EAN por SKU e ERP so oferece EAN por produto:
- registrar gap/adaptacao;
- nao declarar cobertura completa.

C) Cenario P/M/G/GG relevante:
- nao usar apenas um produto;
- aplicar repeticao adequada em multiplos produtos/familias.

D) Base calculada com 180 produtos:
- permitido.

E) Base com 50 produtos cobrindo cenarios com repeticao adequada:
- permitido.

F) Imagem repetida em varios produtos:
- permitido.

G) Produto sem imagem:
- diferente de produto com IMG-PLACEHOLDER.

H) Ferramenta nao utiliza campanha:
- nao criar campanha apenas por existir no catalogo global.

I) ERP limita SKU a 15 caracteres:
- manter id logico estavel e adaptar codigo fisico conforme restricao.

J) Mesma familia cobrindo cor + grade + ean + estoque + imagem:
- permitido e desejavel.

K) Caracteristica critica aparecendo em um unico produto sem justificativa:
- cobertura insuficiente.

L) Uso de perfil MINIMA para substituir homologacao de ERP parceiro:
- invalido;
- padrao default da jornada ERP parceiro e HOMOLOGACAO.

M) Reduzir de 200 para 50 apenas por otimizacao matematica:
- invalido para perfil HOMOLOGACAO sem justificativa concreta.

N) Ferramenta nao usa campanha:
- campanhas podem ficar 0/NAO_APLICAVEL, sem gap automatico.

O) Produto com combinacao inteligente de multiplas dimensoes:
- valido e desejavel.
