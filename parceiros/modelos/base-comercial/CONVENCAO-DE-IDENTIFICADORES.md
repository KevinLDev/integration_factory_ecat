# Convencao de identificadores da base comercial de homologacao

## 1. Objetivo

Definir padrao de identificadores logicos estaveis para massa comercial de homologacao.

Os ids logicos existem para rastreabilidade e auditoria, independentemente de limites fisicos de cada ERP.

## 2. Principios

- determinismo: mesmo plano gera a mesma identidade logica;
- estabilidade: id logico nao muda por restricao fisica temporaria;
- rastreabilidade: cada registro aponta cenario_tags e origem de cobertura;
- separacao: id logico != codigo fisico do ERP quando houver limitacao de formato.

## 3. Prefixo padrao

Prefixo recomendado para homologacao:

- HML

Formato base:

- HML-<TIPO>-<SEQUENCIAL>

Exemplos conceituais:

- HML-PROD-001
- HML-SKU-001-AZ-P
- HML-CLI-001
- HML-MARCA-001
- HML-CAT-001
- HML-FILIAL-001

## 4. Nomes humanos

Nome humano pode seguir padrao equivalente:

- HML Camiseta Basica 001
- HML Cliente 001
- HML Marca Alpha

Nome humano nao substitui id logico.

## 5. Mapeamento logico x fisico

Quando ERP impuser limite de tamanho/formato:

- manter id_logico estavel no plano de homologacao;
- derivar codigo_fisico conforme restricao real detectada;
- registrar regra de conversao e evidencia da restricao.

Exemplo:

- id_logico_sku: HML-SKU-001-AZ-P
- limite_erp: max 15 caracteres
- codigo_fisico_sku: HMLS001AZP0001

## 6. Unicidade

A unicidade minima deve ser garantida por tipo de entidade no escopo da combinacao.

Nao reutilizar o mesmo id_logico para entidades diferentes.

## 7. Relacao com cobertura

Cada id_logico deve declarar:

- cenario_tags cobertas;
- familia de cobertura;
- estado de cobertura.

Isso permite rastrear:

- CENARIO -> IDS;
- ID -> CENARIOS.
