# Guia de execução — Parceiros

## Atalhos de navegação

- Porta de entrada de todo operador: `comece-aqui/00-COMECE-AQUI.md`
- Nova ferramenta E-Catálogos: `comece-aqui/integrar-nova-ferramenta/00-COMECE-AQUI.md`
- Novo ERP parceiro: `comece-aqui/integrar-erp/erp-parceiro/00-COMECE-AQUI.md`
- Integração de cliente: `comece-aqui/integrar-erp/erp-cliente/00-COMECE-AQUI.md`
- Entendimento conceitual: `documentacao/00-VISAO-GERAL.md`
- Comandos técnicos internos da IA: `parceiros/comandos/`

## Para quem é este guia

Este guia explica como a trilha técnica de parceiros se relaciona com as jornadas humanas da fábrica. O operador começa em `comece-aqui/` e não precisa conhecer a arquitetura nem criar arquivos manualmente.

```text
PROMPT + DADOS CONHECIDOS + DOCUMENTAÇÃO/ARQUIVOS
                         ↓
                       CODEX
                         ↓
         CRIA E ORGANIZA A EXECUÇÃO SOZINHO
```

## Regra número 1

Só execute uma etapa quando existirem:

- o comando técnico;
- o documento operacional humano correspondente;
- indicação explícita de que a etapa está disponível.

Cada etapa é um portão de qualidade. Só avance quando o Codex responder `STATUS DA ETAPA: CONCLUIDA` e a auditoria exigida estiver aprovada.

Se responder `PENDENTE`, forneça o que foi solicitado e repita a mesma etapa. Se responder `BLOQUEADA`, resolva o impedimento informado antes de tentar novamente.

## Jornada 1 — Nova ferramenta E-Catálogos

Use para preparar o contrato canônico de Força de Vendas, B2B, Lojas ou outra ferramenta da própria E-Catálogos.

Etapas atualmente disponíveis:

```text
01 APRESENTAR E ANALISAR FERRAMENTA
        ↓
02 CADASTRAR FERRAMENTA
        ↓
03 VALIDAR FERRAMENTA CADASTRADA PARA INTEGRAÇÕES
```

Paridade operacional:

```text
parceiros/comandos/01-APRESENTAR-E-ANALISAR-FERRAMENTA.md
-> comece-aqui/integrar-nova-ferramenta/01-APRESENTAR-FERRAMENTA.md

parceiros/comandos/02-CADASTRAR-FERRAMENTA.md
-> comece-aqui/integrar-nova-ferramenta/02-CADASTRAR-FERRAMENTA.md

parceiros/comandos/03-VALIDAR-FERRAMENTA-CADASTRADA.md
-> comece-aqui/integrar-nova-ferramenta/03-VALIDAR-FERRAMENTA-CADASTRADA.md
```

O Passo 03 só homologa a ferramenta quando o resultado técnico for apto, a auditoria estiver aprovada e a prontidão for `HOMOLOGADA_PARA_INTEGRACOES`. Depois dessa homologação, a ferramenta passa a estar disponível ao resolvedor central de contexto em `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`; uma necessidade de ERP segue então a jornada e o menor passo responsável, sem autoexecução.

## Jornada 2 — ERP parceiro

Use para estudar, mapear, desenvolver, testar e homologar uma integração reutilizável entre um ERP e uma ferramenta E-Catálogos.

Passos operacionais disponíveis:

- `comece-aqui/integrar-erp/erp-parceiro/01-APRESENTAR-ERP.md`
- `comece-aqui/integrar-erp/erp-parceiro/02-ANALISAR-ERP.md`
- `comece-aqui/integrar-erp/erp-parceiro/03-PROJETAR-HOMOLOGACAO.md`
- `comece-aqui/integrar-erp/erp-parceiro/04-MATERIALIZAR-BASE-HOMOLOGACAO.md`
- `comece-aqui/integrar-erp/erp-parceiro/05-PROJETAR-INTEGRACAO-E-MAPEAMENTO.md`
- `comece-aqui/integrar-erp/erp-parceiro/06-DESENVOLVER-INTEGRACAO.md`
- `comece-aqui/integrar-erp/erp-parceiro/07-EXECUTAR-E-VALIDAR-TECNICAMENTE-EM-HML.md`
- `comece-aqui/integrar-erp/erp-parceiro/08-HOMOLOGAR-FUNCIONALMENTE-INTEGRACAO.md`
- `comece-aqui/integrar-erp/erp-parceiro/09-CONSOLIDAR-E-PUBLICAR-INTEGRACAO-HOMOLOGADA.md`

Entrada humana:

`comece-aqui/integrar-erp/erp-parceiro/00-COMECE-AQUI.md`

**PASSO 01 LIBERADO PARA EXECUCAO.**

**PASSO 02 LIBERADO PARA EXECUCAO.**

**PASSO 03 LIBERADO PARA EXECUCAO.**

**PASSO 04 LIBERADO PARA EXECUCAO.**

**PASSO 05 LIBERADO PARA EXECUCAO.**

**PASSO 06 LIBERADO PARA EXECUCAO.**

**PASSO 07 LIBERADO PARA EXECUCAO.**

**PASSO 08 LIBERADO PARA EXECUCAO.**

**PASSO 09 LIBERADO PARA EXECUCAO.**

O Passo 07 executa e valida tecnicamente em HML. O Passo 08 homologa funcionalmente em modelo manual assistido por IA e nao se autoaprova. O Passo 09 consolida e publica a integracao homologada para reutilizacao e tambem nao se autoaprova. Producao permanece fora do escopo. Nao improvise etapas posteriores ao Passo 09.

## Jornada 3 — ERP cliente

Use quando um cliente real precisa utilizar uma integração de ERP compatível com uma ferramenta E-Catálogos.

Entrada humana:

`comece-aqui/integrar-erp/erp-cliente/00-COMECE-AQUI.md`

Essa jornada deve reutilizar uma integração homologada sempre que possível. Os Passos 01 e 02 estao liberados para resolucao de contexto/elegibilidade e analise da realidade comercial e tecnica do cliente; passos posteriores permanecem nao liberados.

## O operador não deve fazer

Não é responsabilidade do operador:

- criar pasta de execução;
- copiar ou renomear modelos;
- criar `ESTADO-DA-EXECUCAO.md`;
- criar estrutura de ferramenta, ERP ou cliente;
- decidir onde um artefato técnico será salvo;
- preencher placeholders dentro dos comandos técnicos.

## O operador deve fazer

O operador precisa somente:

1. escolher a jornada em `comece-aqui/00-COMECE-AQUI.md`;
2. seguir um documento operacional liberado;
3. fornecer os nomes, dados e arquivos pedidos;
4. responder a pendências que dependam de informação humana;
5. avançar apenas quando o status e a auditoria permitirem.

## Memória persistente

Quando uma etapa liberada for executada, a conversa do Codex não será a memória oficial. O Codex deverá manter a execução no repositório com, no mínimo, quando aplicável:

```text
DADOS-DA-EXECUCAO.md
ESTADO-DA-EXECUCAO.md
referencias/
```

## Validade e retomada

Além do estado, o Codex mantém manifestos compactos com hashes e dependências e, durante trabalho interrompível, um checkpoint transitório. O operador não cria esses arquivos.

Um resultado anterior só é reutilizado para a mesma versão exata das entradas. `EXECUCAO: PAUSADA_COM_CHECKPOINT` permite continuar do último ponto seguro e não equivale a `PENDENTE` ou `BLOQUEADA`, nem modifica o status da etapa.

## Credenciais

Quando autenticação real for necessária em uma etapa futura e autorizada, o operador poderá fornecer as credenciais diretamente ou indicar um arquivo local. O Codex deverá protegê-las conforme `AGENTS.md`; o operador não precisará criar um `.env` manualmente.

## Retorno obrigatório

Cada comando termina obrigatoriamente com um destes estados:

```text
STATUS DA ETAPA: CONCLUIDA
STATUS DA ETAPA: PENDENTE
STATUS DA ETAPA: BLOQUEADA
```

Somente `CONCLUIDA`, acompanhada da auditoria exigida, libera a continuação.
