# Visão geral da Fábrica de Integrações (V1)

## O que é

A Fábrica de Integrações é o modelo operacional da E-Catálogos para preparar contratos de suas ferramentas e criar, validar, auditar e evoluir integrações com ERPs.

## Princípio central

A E-Catálogos define o contrato canônico.

```text
ERP <-> adaptador do ERP <-> contrato da ferramenta E-Catálogos
```

## Três jornadas

1. **Nova ferramenta E-Catálogos**: compreender, cadastrar e homologar tecnicamente o contrato de um produto da E-Catálogos.
2. **ERP parceiro**: criar e homologar uma integração reutilizável entre um ERP e uma ferramenta E-Catálogos.
3. **ERP cliente**: aplicar uma integração já suportada a um cliente real e tratar suas particularidades.

Integrar um ERP ao portfólio não é o mesmo que configurar o ERP de um cliente.

## Disponibilidade atual

Os Passos 01, 02 e 03 da jornada de nova ferramenta estão disponíveis. O Passo 03 homologa tecnicamente o contrato para integrações.

A jornada de ERP parceiro possui os Passos 01 a 07 disponíveis, em ordem: apresentar o ERP, analisar suas capacidades, projetar a homologação, materializar a Base de Homologação, projetar a integração e o mapeamento semântico, desenvolver a integração e executar e validar tecnicamente em HML. O Passo 06 termina em `PRONTO_PARA_EXECUCAO_HML`; o Passo 07 pode chegar a `PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM` somente após auditoria independente. Homologação funcional, publicação, runtime e produção não pertencem a esses passos.

A jornada de ERP cliente ainda não está liberada para execução.

## Memória oficial

A memória da fábrica é o repositório — arquivos, estado e evidências —, não o histórico do chat.

## Onde começar

- Novo operador: `comece-aqui/00-COMECE-AQUI.md`
- Entender detalhes da fábrica: `documentacao/01-COMO-FUNCIONA-A-FABRICA.md`
- Comandos técnicos internos executados pela IA: `parceiros/comandos/`
