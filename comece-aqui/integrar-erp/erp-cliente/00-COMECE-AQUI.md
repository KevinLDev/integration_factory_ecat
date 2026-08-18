# Integrar um cliente

## Quando usar

Use esta jornada quando existe um cliente real que utiliza um ERP e precisa ser integrado a uma ferramenta E-Catálogos.

Antes de seguir esta jornada, consulte `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md` para confirmar que a combinação ERP x ferramenta já está publicada no Passo 09 e que o cenário é realmente de reutilização para cliente.

## Objetivo desta jornada

Aplicar uma integracao ERP x ferramenta ja publicada para um cliente real, sem reconstruir o core da combinacao homologada.

## Regra principal

Antes de iniciar uma integração de cliente, a fábrica deve verificar se existe integração publicada para a combinação:

```text
ERP
+
Ferramenta E-Catálogos
```

Consulte `comece-aqui/integrar-erp/ERPS-INTEGRADOS.md`.

### Se a integração existir

Reutilize a integração publicada e trate somente as particularidades necessárias do cliente.

Não reconstrua o adaptador, não reanalise profundamente o ERP e não exija uma base comercial completa de desenvolvimento quando a combinação já estiver publicada.

### Se a integração não existir

Não desenvolva silenciosamente uma nova integração dentro da jornada de cliente.

Volte primeiro para:

`comece-aqui/integrar-erp/erp-parceiro/00-COMECE-AQUI.md`

## Passos operacionais disponíveis

Passo 01 — Resolver contexto do cliente e elegibilidade de reutilização:

`comece-aqui/integrar-erp/erp-cliente/01-RESOLVER-CONTEXTO-DO-CLIENTE.md`

Passo 02 — Analisar realidade comercial e tecnica do cliente:

`comece-aqui/integrar-erp/erp-cliente/02-ANALISAR-REALIDADE-COMERCIAL-E-TECNICA-DO-CLIENTE.md`

## Fronteira do Passo 01

O Passo 01 resolve somente:

- quem e o cliente;
- qual ERP utiliza;
- qual ferramenta deseja;
- quais materiais foram recebidos;
- se existe release publicada e elegivel para reutilizacao.

O Passo 01 nao executa analise comercial profunda, nao projeta instalacao, nao materializa configuracao, nao executa HML e nao executa producao.

## Fronteira do Passo 02

O Passo 02 resolve somente:

- a realidade comercial e tecnica comprovada do cliente para a combinacao publicada;
- a matriz comercial do cliente por capacidade;
- o que o cliente possui versus o que usa hoje;
- configuracoes, de-paras, extensoes, gaps, pendencias e bloqueios identificados;
- a base decisoria para projetar a instalacao no Passo 03.

O Passo 02 nao projeta a instalacao final, nao materializa configuracao, nao implementa de-para real, nao implementa extensao real, nao desenvolve codigo, nao executa HML e nao executa producao.

## Visao dos proximos passos

Os passos posteriores da jornada ERP cliente permanecem planejados e ainda nao estao liberados para execucao.

## Disponibilidade

**PASSO 01 LIBERADO PARA EXECUCAO.**

**PASSO 02 LIBERADO PARA EXECUCAO.**

Os passos posteriores da jornada ERP cliente ainda nao estao liberados.
