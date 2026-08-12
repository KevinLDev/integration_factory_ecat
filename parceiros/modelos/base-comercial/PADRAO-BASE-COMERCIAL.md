# Padrao de base comercial da Fabrica

## 1. Objetivo

Orientar como transformar necessidades de homologacao em familias e registros de massa comercial.

Entrada conceitual:

- cenarios necessarios;
- capacidades do ERP;
- restricoes tecnicas e operacionais;
- perfil da ferramenta.

Saida conceitual:

- plano de homologacao da combinacao, com cobertura declarada e rastreavel.

## 2. Formula de construcao

PADRAO GLOBAL DE MASSA
+
NECESSIDADES DA FERRAMENTA
+
CAPACIDADES CONFIRMADAS DO ERP
+
RESTRICOES DA COMBINACAO
->
PLANO DE HOMOLOGACAO DA COMBINACAO

## 3. Perfil de massa

Perfis conceituais permitidos:

- MINIMA
- HOMOLOGACAO
- ESTRESSE

Regra da jornada ERP parceiro:

- perfil padrao obrigatorio: HOMOLOGACAO.

MINIMA nao substitui homologacao completa.
ESTRESSE e opcional para volume/carga adicional.

## 4. Estrategia de cobertura

- cobertura e prioridade maior que contagem fixa de registros;
- usar repeticao adequada de cenarios criticos;
- evitar cenarios chave representados por registro unico;
- combinar cenarios no mesmo registro quando isso aumentar eficiencia sem perder repeticao minima.

## 5. Estruturacao por familias

Montar familias com objetivo funcional explicito, por exemplo:

- familias de grade;
- familias de cor;
- familias de multi-filial;
- familias de imagem;
- familias de clientes e condicoes comerciais.

Nomes e quantidades de familias sao derivados da combinacao, nao fixos globalmente.

## 6. Cobertura declarada

Toda familia e todo registro devem declarar:

- por que existem;
- quais cenarios cobrem;
- quais gaps permanecem;
- estado da cobertura.

Estados sugeridos:

- COBERTURA_PLANEJADA
- COBERTURA_CRIADA_NO_ERP
- COBERTURA_SINCRONIZADA
- COBERTURA_VALIDADA_NA_FERRAMENTA

## 7. Gaps e cobertura impossivel

Quando ferramenta exige algo que o ERP nao suporta:

- nao fingir cobertura;
- registrar gap/adaptacao/cobertura impossivel;
- manter evidencia da limitacao.

## 8. Dependencias

Nao existe ordem fixa universal de criacao.

A ordem real deve ser derivada de:

- CAPACIDADES-DO-ERP;
- documentacao/evidencia autorizada;
- contrato da ferramenta.

Este padrao so define como representar dependencias no plano.

## 9. Guardrails

- nao inventar endpoint/campo/regra comercial;
- nao remover necessidade de ferramenta sem registrar gap;
- nao converter catalogo global em obrigacao universal;
- nao executar runtime nesta etapa.

## 10. Politica operacional de EAN/codigo de barras

Aplicacao condicional:

- EAN/codigo de barras so entra no plano quando ferramenta/cenario funcional exigir;
- se nao houver exigencia funcional, ausencia de EAN nao gera gap e nao exige teste de EAN.

Determinismo e reproducibilidade:

- para o mesmo plano/identidade logica, o codigo sintetico deve ser reproduzivel;
- mudanca arbitraria de codigo entre execucoes equivalentes deve ser evitada.

Formato, checksum e unicidade:

- respeitar formato exigido pela combinacao (nao assumir EAN-13 universalmente);
- quando o padrao exigir digito verificador/checksum, usar valor valido;
- quando a combinacao exigir EAN-13, usar 13 digitos com digito verificador valido;
- garantir unicidade no escopo aplicavel da massa quando houver exigencia de unicidade.

Relacao por entidade:

- nao presumir estrutura universal;
- codigo pode pertencer a produto, SKU, variacao ou outra entidade suportada;
- a decisao vem do contrato/cenario funcional da ferramenta e da capacidade/evidencia do ERP;
- se ferramenta exigir por SKU e ERP so oferecer por produto, registrar gap/adaptacao sem fingir cobertura completa.

Codigo real x codigo sintetico:

- registrar no plano se o cenario usa `CODIGO_REAL` ou `CODIGO_SINTETICO_HML`;
- nao substituir codigo real autorizado de forma silenciosa;
- evitar colisao conhecida entre codigos reais e sinteticos;
- codigo sintetico de homologacao nao representa registro/licenciamento comercial real.
