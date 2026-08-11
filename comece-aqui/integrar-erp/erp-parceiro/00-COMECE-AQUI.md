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

## Passo operacional disponível

O Passo 01 da jornada de ERP parceiro já está disponível para entrada, triagem e resolução de contexto:

`comece-aqui/integrar-erp/erp-parceiro/01-APRESENTAR-ERP.md`

## Pré-condição da ferramenta E-Catálogos

Antes de qualquer futura etapa de ERP parceiro, a ferramenta E-Catálogos escolhida deverá possuir conjuntamente:

```text
PASSO 03: CONCLUIDA
AUDITORIA 03: APROVADA
PRONTIDAO: HOMOLOGADA_PARA_INTEGRACOES
```

Se alguma condição estiver ausente, a jornada de ERP parceiro deverá ser bloqueada para essa ferramenta. Não valide nem corrija silenciosamente o contrato dentro da jornada de ERP.

Se o operador também fornecer documentação da ferramenta já homologada, trate-a como documento de contexto da execução corrente, não como nova verdade contratual.

## Visão da jornada futura

Quando for preparada e homologada, esta jornada poderá incluir etapas para:

- apresentar a documentação do ERP;
- analisar o ERP;
- escolher ou confirmar a ferramenta E-Catálogos alvo;
- mapear o ERP contra o contrato canônico;
- configurar o ambiente de homologação;
- criar ou preparar base comercial quando necessário;
- desenvolver a integração;
- testar módulo por módulo;
- testar ida e volta quando suportado;
- validar correlação;
- validar idempotência;
- validar prevenção de loops;
- homologar a integração;
- gerar documentação final;
- registrar o ERP como integrado.

Esses itens são somente a visão da jornada. Eles não representam passos disponíveis e não autorizam execução.

Quando esta jornada vier a ser liberada, a camada central de resolução de contexto deverá ter sido consultada antes de qualquer etapa de análise profunda, para evitar duplicação de contrato ou escolha incorreta de jornada.

## Disponibilidade

**PASSO 01 LIBERADO PARA EXECUÇÃO.**

Os passos posteriores da jornada de ERP parceiro ainda não estão liberados.

Aguarde o próximo documento operacional quando o Passo 01 estiver concluído.
