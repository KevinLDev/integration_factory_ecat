# Como usar os comandos

> Se você é operador, comece por `comece-aqui/00-COMECE-AQUI.md`.
>
> Este arquivo descreve o uso dos comandos técnicos internos em `parceiros/comandos/`.

## Conceito

Os documentos em `parceiros/comandos/` são prompts e regras fixas da fábrica.

O operador não edita esses arquivos. Ele usa o texto fornecido pelo documento operacional correspondente em `comece-aqui/`.

Uma etapa só está pronta para operação quando o comando técnico e o documento humano correspondente existem e estão homologados.

## Comandos disponíveis

Atualmente estão disponíveis:

```text
parceiros/comandos/01-APRESENTAR-E-ANALISAR-FERRAMENTA.md
parceiros/comandos/02-CADASTRAR-FERRAMENTA.md
parceiros/comandos/03-VALIDAR-FERRAMENTA-CADASTRADA.md
parceiros/comandos/ERP-PARCEIRO-01-APRESENTAR-ERP.md
parceiros/comandos/ERP-PARCEIRO-02-ANALISAR-ERP.md
parceiros/comandos/ERP-PARCEIRO-03-PROJETAR-HOMOLOGACAO.md
parceiros/comandos/ERP-PARCEIRO-04-MATERIALIZAR-BASE-HOMOLOGACAO.md
parceiros/comandos/ERP-PARCEIRO-05-PROJETAR-INTEGRACAO-E-MAPEAMENTO.md
parceiros/comandos/ERP-PARCEIRO-06-DESENVOLVER-INTEGRACAO.md
parceiros/comandos/ERP-PARCEIRO-07-EXECUTAR-E-VALIDAR-TECNICAMENTE-EM-HML.md
parceiros/comandos/ERP-PARCEIRO-08-HOMOLOGAR-FUNCIONALMENTE-INTEGRACAO.md
parceiros/comandos/ERP-PARCEIRO-09-CONSOLIDAR-E-PUBLICAR-INTEGRACAO-HOMOLOGADA.md
parceiros/comandos/ERP-CLIENTE-01-RESOLVER-CONTEXTO-DO-CLIENTE.md
parceiros/comandos/ERP-CLIENTE-02-ANALISAR-REALIDADE-COMERCIAL-E-TECNICA-DO-CLIENTE.md
```

Seus documentos operacionais são:

```text
comece-aqui/integrar-nova-ferramenta/01-APRESENTAR-FERRAMENTA.md
comece-aqui/integrar-nova-ferramenta/02-CADASTRAR-FERRAMENTA.md
comece-aqui/integrar-nova-ferramenta/03-VALIDAR-FERRAMENTA-CADASTRADA.md
comece-aqui/integrar-erp/erp-parceiro/01-APRESENTAR-ERP.md
comece-aqui/integrar-erp/erp-parceiro/02-ANALISAR-ERP.md
comece-aqui/integrar-erp/erp-parceiro/03-PROJETAR-HOMOLOGACAO.md
comece-aqui/integrar-erp/erp-parceiro/04-MATERIALIZAR-BASE-HOMOLOGACAO.md
comece-aqui/integrar-erp/erp-parceiro/05-PROJETAR-INTEGRACAO-E-MAPEAMENTO.md
comece-aqui/integrar-erp/erp-parceiro/06-DESENVOLVER-INTEGRACAO.md
comece-aqui/integrar-erp/erp-parceiro/07-EXECUTAR-E-VALIDAR-TECNICAMENTE-EM-HML.md
comece-aqui/integrar-erp/erp-parceiro/08-HOMOLOGAR-FUNCIONALMENTE-INTEGRACAO.md
comece-aqui/integrar-erp/erp-parceiro/09-CONSOLIDAR-E-PUBLICAR-INTEGRACAO-HOMOLOGADA.md
comece-aqui/integrar-erp/erp-cliente/01-RESOLVER-CONTEXTO-DO-CLIENTE.md
comece-aqui/integrar-erp/erp-cliente/02-ANALISAR-REALIDADE-COMERCIAL-E-TECNICA-DO-CLIENTE.md
```

O Passo 03 valida o contrato em modo somente leitura e só registra a ferramenta como homologada para integrações após resultado técnico apto e auditoria aprovada.

## Como executar uma etapa disponível

1. Abra o documento operacional na jornada correta de `comece-aqui/`.
2. Leia os pré-requisitos e confirme que pode avançar.
3. Substitua os campos entre colchetes.
4. Copie somente o conteúdo entre `COPIE A PARTIR DAQUI` e `PARE DE COPIAR AQUI`.
5. Envie esse conteúdo ao Codex no workspace da fábrica.

O Codex cria ou localiza sozinho a estrutura persistente da execução.

## Quando fornecer arquivos

Você pode:

- anexar o arquivo;
- apontar um arquivo já existente no repositório;
- indicar uma pasta contendo documentação;
- informar uma URL quando o ambiente permitir acesso;
- fornecer Swagger/OpenAPI, PDF, exemplos, manuais e regras complementares.

## Quando faltar informação

Não tente adivinhar. Se o Codex puder descobrir pela documentação ou pelo ambiente autorizado, ele deverá fazê-lo. Se depender de decisão ou informação humana, a etapa terminará como `PENDENTE` e informará exatamente o que falta.

## O que nunca deve ser pedido ao operador

Durante o fluxo normal, o Codex não deve pedir ao operador para:

- criar uma pasta;
- copiar ou renomear um modelo;
- criar arquivos de estado;
- mover documentação apenas para o comando funcionar;
- preencher placeholders dentro do arquivo técnico de comando.

## Comandos de ERP parceiro

Os comandos de ERP parceiro possuem seus documentos humanos correspondentes em:

`comece-aqui/integrar-erp/erp-parceiro/`

Comandos operacionais disponiveis para ERP parceiro:

- `parceiros/comandos/ERP-PARCEIRO-01-APRESENTAR-ERP.md`
- `parceiros/comandos/ERP-PARCEIRO-02-ANALISAR-ERP.md`
- `parceiros/comandos/ERP-PARCEIRO-03-PROJETAR-HOMOLOGACAO.md`
- `parceiros/comandos/ERP-PARCEIRO-04-MATERIALIZAR-BASE-HOMOLOGACAO.md`
- `parceiros/comandos/ERP-PARCEIRO-05-PROJETAR-INTEGRACAO-E-MAPEAMENTO.md`
- `parceiros/comandos/ERP-PARCEIRO-06-DESENVOLVER-INTEGRACAO.md`
- `parceiros/comandos/ERP-PARCEIRO-07-EXECUTAR-E-VALIDAR-TECNICAMENTE-EM-HML.md`
- `parceiros/comandos/ERP-PARCEIRO-08-HOMOLOGAR-FUNCIONALMENTE-INTEGRACAO.md`
- `parceiros/comandos/ERP-PARCEIRO-09-CONSOLIDAR-E-PUBLICAR-INTEGRACAO-HOMOLOGADA.md`

Documentos humanos correspondentes:

- `comece-aqui/integrar-erp/erp-parceiro/01-APRESENTAR-ERP.md`
- `comece-aqui/integrar-erp/erp-parceiro/02-ANALISAR-ERP.md`
- `comece-aqui/integrar-erp/erp-parceiro/03-PROJETAR-HOMOLOGACAO.md`
- `comece-aqui/integrar-erp/erp-parceiro/04-MATERIALIZAR-BASE-HOMOLOGACAO.md`
- `comece-aqui/integrar-erp/erp-parceiro/05-PROJETAR-INTEGRACAO-E-MAPEAMENTO.md`
- `comece-aqui/integrar-erp/erp-parceiro/06-DESENVOLVER-INTEGRACAO.md`
- `comece-aqui/integrar-erp/erp-parceiro/07-EXECUTAR-E-VALIDAR-TECNICAMENTE-EM-HML.md`
- `comece-aqui/integrar-erp/erp-parceiro/08-HOMOLOGAR-FUNCIONALMENTE-INTEGRACAO.md`
- `comece-aqui/integrar-erp/erp-parceiro/09-CONSOLIDAR-E-PUBLICAR-INTEGRACAO-HOMOLOGADA.md`

Execute os Passos 01 a 09 em ordem e respeite os gates e handoffs de cada etapa. O Passo 06 termina em `PRONTO_PARA_EXECUCAO_HML`; o Passo 07 executa e valida tecnicamente em HML e so pode liberar prontidao para homologacao funcional depois de auditoria independente; o Passo 08 homologa funcionalmente em modelo manual assistido por IA e so pode liberar `INTEGRACAO_HOMOLOGADA: SIM` apos auditoria independente aprovada; o Passo 09 consolida/publica a integracao homologada e so pode liberar `INTEGRACAO_PUBLICADA: SIM` e `DISPONIVEL_PARA_CLIENTE: SIM` apos auditoria independente aprovada. Producao permanece fora desse escopo.

Comandos de ERP cliente deverão ter seus documentos humanos em:

`comece-aqui/integrar-erp/erp-cliente/`

Comando operacional vigente de ERP cliente:

- `parceiros/comandos/ERP-CLIENTE-01-RESOLVER-CONTEXTO-DO-CLIENTE.md`
- `parceiros/comandos/ERP-CLIENTE-02-ANALISAR-REALIDADE-COMERCIAL-E-TECNICA-DO-CLIENTE.md`

A jornada ERP cliente possui os Passos 01 e 02 liberados. Os passos seguintes ainda nao estao liberados.

## Modelos existentes no repositório

A pasta `parceiros/modelos/` existe como referência ou esquema para o próprio Codex, não como tarefa manual do operador.
