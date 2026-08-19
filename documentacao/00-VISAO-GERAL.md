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

A jornada de ERP parceiro possui os Passos 01 a 09 disponiveis, em ordem: apresentar o ERP, analisar suas capacidades, projetar a homologacao, materializar a Base de Homologacao, projetar a integracao e o mapeamento semantico, desenvolver a integracao, executar e validar tecnicamente em HML, homologar funcionalmente a integracao e consolidar/publicar a integracao homologada. O Passo 06 termina em `PRONTO_PARA_EXECUCAO_HML`; o Passo 07 pode chegar a `PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM` somente apos auditoria independente; o Passo 08 e o primeiro passo que pode levar a `INTEGRACAO_HOMOLOGADA: SIM` somente apos auditoria independente aprovada; o Passo 09 pode levar a `INTEGRACAO_PUBLICADA: SIM` e `DISPONIVEL_PARA_CLIENTE: SIM` somente apos auditoria independente aprovada. Runtime e producao nao pertencem a esses passos.

A jornada de ERP cliente possui o roteiro completo de 6 passos liberado: resolucao de contexto/elegibilidade, analise da realidade comercial e tecnica, projeto da instalacao sem materializacao, materializacao em HML, validacao tecnica/funcional e go-live em producao com registro de memoria de fechamento. O Passo 06 e a primeira etapa de toda a fabrica que escreve em producao. A primeira execucao real de cada combinacao (Passos 04, 05 e 06) exige auditoria independente PROFUNDA, e nenhuma das tres execucoes produtoras se autoaprova.

## Memória oficial

A memória da fábrica é o repositório — arquivos, estado e evidências —, não o histórico do chat.

## Onde começar

- Novo operador: `comece-aqui/00-COMECE-AQUI.md`
- Entender detalhes da fábrica: `documentacao/01-COMO-FUNCIONA-A-FABRICA.md`
- Comandos técnicos internos executados pela IA: `parceiros/comandos/`
