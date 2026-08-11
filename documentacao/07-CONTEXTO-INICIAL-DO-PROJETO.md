# Contexto inicial — Fábrica de Integrações E-Catálogos

Este documento serve para contextualizar um novo ChatGPT, Codex ou pessoa que esteja entrando no projeto.

## Objetivo

Construir uma Fábrica de Integrações assistida por IA para padronizar e acelerar integrações entre ERPs parceiros e ferramentas da E-Catálogos.

As primeiras ferramentas consideradas são Força de Vendas, B2B e Lojas/Vestuário.

O primeiro caso real é o **Força de Vendas**.

## Princípio central

Quem define o contrato é a E-Catálogos.

```text
ERP <-> adaptador do ERP <-> contrato da ferramenta E-Catálogos
```

A fábrica deve descobrir como o ERP atende ao que a ferramenta E-Catálogos precisa, e não tentar integrar tudo que o ERP oferece.

## Operação

A fábrica será operada principalmente por VS Code/Cursor, Codex, terminal, arquivos Markdown, documentação de APIs e testes.

O operador fornece intenção, nomes, documentação, arquivos, credenciais e decisões humanas quando necessárias.

O Codex é responsável por criar e organizar a estrutura técnica da execução.

## Harness Engineering

O projeto usa princípios de Harness Engineering: contexto, regras, comandos, documentação, estado persistente, testes e feedback ficam no próprio repositório para que a execução não dependa da memória de um chat.

`AGENTS.md` é a porta de entrada do Harness, mas o Harness completo inclui os guias, comandos, fontes, testes, estado e validações.

## Escopo atual

A experiência operacional está separada em três jornadas:

1. integrar uma nova ferramenta E-Catálogos;
2. integrar um ERP parceiro ao portfólio;
3. integrar um cliente utilizando um ERP já suportado.

Os Passos 01, 02 e 03 da jornada de nova ferramenta estão disponíveis. As portas de ERP parceiro e ERP cliente são conceituais e ainda não liberam execução.

## Regras essenciais

- E-Catálogos é a referência canônica.
- Bidirecionalidade é analisada por padrão para módulos aplicáveis.
- Não inventar endpoint, campo ou regra.
- Toda conclusão técnica deve possuir evidência.
- Não pular etapas.
- Não considerar etapa concluída apenas porque arquivos foram criados.
- A memória oficial é o repositório, não o chat.
- Implementações antigas do Pipedream são referência histórica, não arquitetura oficial.

## Estado operacional da V1

O Força de Vendas é o primeiro caso real da jornada de ferramenta. Seus artefatos homologados e suas execuções existentes são evidência da V1 e não devem ser alterados durante reorganizações documentais.

O Passo 03 homologa tecnicamente o contrato para integrações sem corrigi-lo. Nenhuma etapa posterior ao Passo 03 está liberada enquanto não existir comando técnico e documento operacional humano homologado.

## Ao iniciar um novo chat

Leia, nesta ordem:

1. `AGENTS.md`;
2. `documentacao/07-CONTEXTO-INICIAL-DO-PROJETO.md`;
3. `README.md`;
4. o `AGENTS.md` específico da pasta de trabalho;
5. o guia operacional correspondente;
6. o documento de comando, o estado e as fontes exigidas pela etapa, se houver uma etapa autorizada.

Antes de propor alterações, resuma o que entendeu, aponte contradições e não modifique nada até receber autorização.
