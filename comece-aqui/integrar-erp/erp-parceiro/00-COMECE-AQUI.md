# Integrar um ERP parceiro

## Quando usar

Use esta jornada quando um ERP precisa ser estudado, mapeado, integrado, testado e homologado para entrar no portfólio da E-Catálogos.

Antes de seguir esta jornada, consulte `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md` para confirmar que o cenário realmente é de ERP parceiro e não de cliente reutilizando uma integração já homologada.

## Objetivo final

Produzir uma integração reutilizável entre:

```text
ERP parceiro
      ↕
Ferramenta E-Catálogos
```

Essa integração poderá depois ser aproveitada por clientes.

## Passos operacionais disponiveis

Passo 01 — Apresentar ERP:

`comece-aqui/integrar-erp/erp-parceiro/01-APRESENTAR-ERP.md`

Passo 02 — Analisar ERP:

`comece-aqui/integrar-erp/erp-parceiro/02-ANALISAR-ERP.md`

Passo 03 — Projetar Homologação:

`comece-aqui/integrar-erp/erp-parceiro/03-PROJETAR-HOMOLOGACAO.md`

Passo 04 — Materializar Base de Homologação:

`comece-aqui/integrar-erp/erp-parceiro/04-MATERIALIZAR-BASE-HOMOLOGACAO.md`

Passo 05 — Projetar Integração e Mapeamento Semântico:

`comece-aqui/integrar-erp/erp-parceiro/05-PROJETAR-INTEGRACAO-E-MAPEAMENTO.md`

Passo 06 — Desenvolver Integração:

`comece-aqui/integrar-erp/erp-parceiro/06-DESENVOLVER-INTEGRACAO.md`

Passo 07 — Executar e Validar Tecnicamente em HML:

`comece-aqui/integrar-erp/erp-parceiro/07-EXECUTAR-E-VALIDAR-TECNICAMENTE-EM-HML.md`

Passo 08 — Homologar Funcionalmente a Integracao:

`comece-aqui/integrar-erp/erp-parceiro/08-HOMOLOGAR-FUNCIONALMENTE-INTEGRACAO.md`

Passo 09 — Consolidar e Publicar Integracao Homologada:

`comece-aqui/integrar-erp/erp-parceiro/09-CONSOLIDAR-E-PUBLICAR-INTEGRACAO-HOMOLOGADA.md`

## Pré-condição da ferramenta E-Catálogos

Antes de qualquer futura etapa de ERP parceiro, a ferramenta E-Catálogos escolhida deverá possuir conjuntamente:

```text
PASSO 03: CONCLUIDA
AUDITORIA 03: APROVADA
PRONTIDAO: HOMOLOGADA_PARA_INTEGRACOES
```

Se alguma condição estiver ausente, a jornada de ERP parceiro deverá ser bloqueada para essa ferramenta. Não valide nem corrija silenciosamente o contrato dentro da jornada de ERP.

Se o operador também fornecer documentação da ferramenta já homologada, trate-a como documento de contexto da execução corrente, não como nova verdade contratual.

## Fronteira apos o Passo 09

Os Passos 01 a 09 acima estao disponiveis. O Passo 07 executa e valida tecnicamente em HML, inclusive ida e volta quando suportado, correlacao, idempotencia e prevencao de loop. O Passo 08 homologa funcionalmente em modelo manual assistido por IA e pode levar a `INTEGRACAO_HOMOLOGADA: SIM` somente apos auditoria independente aprovada. O Passo 09 consolida e publica a integracao homologada e pode levar a `INTEGRACAO_PUBLICADA: SIM` e `DISPONIVEL_PARA_CLIENTE: SIM` somente apos auditoria independente aprovada.

As capacidades posteriores, ainda não publicadas, poderão incluir:

- registro do ERP em `erps-integrados/`;
- runtime, monitoramento e operação contínua;
- configuração e onboarding de cliente;
- produção.

Em toda a jornada, a camada central de resolução de contexto deve ser consultada antes de qualquer etapa de análise profunda, para evitar duplicação de contrato ou escolha incorreta de jornada.

## Disponibilidade

**PASSO 01 LIBERADO PARA EXECUCAO.**

**PASSO 02 LIBERADO PARA EXECUCAO.**

**PASSO 03 LIBERADO PARA EXECUCAO.**

**PASSO 04 LIBERADO PARA EXECUCAO.**

**PASSO 05 LIBERADO PARA EXECUCAO.**

**PASSO 06 LIBERADO PARA EXECUCAO.**

**PASSO 07 LIBERADO PARA EXECUCAO.**

**PASSO 08 LIBERADO PARA EXECUCAO.**

**PASSO 09 LIBERADO PARA EXECUCAO.**

Os passos posteriores ao Passo 09 da jornada de ERP parceiro ainda nao estao liberados.

Apos concluir e auditar o Passo 09, a combinacao publicada fica apta para reutilizacao na jornada ERP cliente; os Passos 01 a 06 dessa jornada estao liberados, roteiro completo.
