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

Passo 03 — Projetar instalacao do cliente:

`comece-aqui/integrar-erp/erp-cliente/03-PROJETAR-INSTALACAO-DO-CLIENTE.md`

Passo 04 — Materializar instalacao do cliente em HML:

`comece-aqui/integrar-erp/erp-cliente/04-MATERIALIZAR-INSTALACAO-EM-HML.md`

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

## Fronteira do Passo 03

O Passo 03 resolve somente o projeto da instalacao do cliente a partir da saida valida do Passo 02:

- configuracoes, de-paras e extensoes projetados, sem materializacao;
- plano de ativacao, dependencias e criterios de aceite;
- itens fora de escopo, pendencias, bloqueios, restricoes e riscos;
- prontidao para a futura materializacao em HML.

O Passo 03 nao reclassifica capacidades, nao altera os artefatos do Passo 02, nao materializa configuracao, nao desenvolve codigo, nao usa credenciais reais, nao executa HML e nao executa producao.

## Fronteira do Passo 04

O Passo 04 resolve somente a materializacao real, em HML, do que o Passo 03 projetou:

- configuracao, de-para e extensao efetivamente criados e confirmados no ambiente de HML autorizado do cliente;
- confirmacao de cada escrita por reconsulta ao destino;
- idempotencia (reexecucao nao duplica).

O Passo 04 nao reprojeta nem reclassifica nada do Passo 02/03, nao altera o contrato homologado da ferramenta, nao valida funcionalmente o resultado, nao usa nem escreve em producao, e nunca se autoaprova: a primeira materializacao real de cada combinacao exige auditoria independente `PROFUNDA`, separada da execucao produtora.

## Visao dos proximos passos

Os Passos 05 e 06 da jornada ERP cliente permanecem planejados e ainda nao estao liberados para execucao: validacao em HML/preparacao para producao e go-live/registro de memoria.

## Disponibilidade

**PASSO 01 LIBERADO PARA EXECUCAO.**

**PASSO 02 LIBERADO PARA EXECUCAO.**

**PASSO 03 LIBERADO PARA EXECUCAO SOMENTE COMO PROJETO.**

**PASSO 04 LIBERADO PARA EXECUCAO REAL EM HML, COM AUDITORIA INDEPENDENTE PROFUNDA OBRIGATORIA NA PRIMEIRA MATERIALIZACAO DE CADA COMBINACAO.**

Os Passos 05 e 06 da jornada ERP cliente ainda nao estao liberados.
