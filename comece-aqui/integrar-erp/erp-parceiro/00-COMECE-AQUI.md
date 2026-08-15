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

## Pré-condição da ferramenta E-Catálogos

Antes de qualquer futura etapa de ERP parceiro, a ferramenta E-Catálogos escolhida deverá possuir conjuntamente:

```text
PASSO 03: CONCLUIDA
AUDITORIA 03: APROVADA
PRONTIDAO: HOMOLOGADA_PARA_INTEGRACOES
```

Se alguma condição estiver ausente, a jornada de ERP parceiro deverá ser bloqueada para essa ferramenta. Não valide nem corrija silenciosamente o contrato dentro da jornada de ERP.

Se o operador também fornecer documentação da ferramenta já homologada, trate-a como documento de contexto da execução corrente, não como nova verdade contratual.

## Limite posterior ao Passo 07

Os Passos 01 a 07 acima estão disponíveis. O Passo 07 executa e valida tecnicamente em HML, inclusive ida e volta quando suportado, correlação, idempotência e prevenção de loop. Ele não homologa funcionalmente, não publica nem registra o ERP como integrado.

As capacidades posteriores, ainda não publicadas, poderão incluir:

- homologação funcional da integração;
- documentação final e publicação;
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

Os passos posteriores ao Passo 07 da jornada de ERP parceiro ainda nao estao liberados.

Apos concluir e auditar o Passo 07, nao existe proximo passo oficial executavel. Aguarde a publicacao e a liberacao formal de uma etapa posterior.
