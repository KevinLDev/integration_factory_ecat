# Fábrica de Integrações — E-Catálogos

Este repositório contém o Harness operacional usado para preparar ferramentas E-Catálogos e construir, validar, testar, homologar e documentar integrações com ERPs.

## Comece por aqui

Todo novo operador deve abrir primeiro:

```text
comece-aqui/00-COMECE-AQUI.md
```

Essa porta de entrada pergunta o que o operador deseja fazer e o direciona para uma das três jornadas:

1. integrar uma nova ferramenta E-Catálogos;
2. integrar um ERP parceiro ao portfólio;
3. integrar um cliente utilizando um ERP já suportado.

O operador não precisa conhecer a estrutura interna do Harness para começar.

## Disponibilidade atual

Os três primeiros passos da jornada de nova ferramenta estão disponíveis:

```text
comece-aqui/integrar-nova-ferramenta/01-APRESENTAR-FERRAMENTA.md
comece-aqui/integrar-nova-ferramenta/02-CADASTRAR-FERRAMENTA.md
comece-aqui/integrar-nova-ferramenta/03-VALIDAR-FERRAMENTA-CADASTRADA.md
```

A jornada de ERP parceiro possui oficialmente os Passos 01 a 09 disponiveis. O Passo 06 termina em `PRONTO_PARA_EXECUCAO_HML`; o Passo 07 executa e valida tecnicamente em HML, podendo chegar a `PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM` somente depois de auditoria independente; o Passo 08 executa homologacao funcional manual assistida por IA e e o primeiro passo que pode levar a `INTEGRACAO_HOMOLOGADA: SIM` somente apos auditoria independente aprovada; o Passo 09 consolida e publica a integracao homologada, podendo levar a `INTEGRACAO_PUBLICADA: SIM` e `DISPONIVEL_PARA_CLIENTE: SIM` somente apos auditoria independente aprovada. Runtime e producao permanecem futuros. A jornada de ERP cliente possui o Passo 01 liberado para resolucao de contexto e elegibilidade de reutilizacao; os passos seguintes permanecem futuros.

## Outros pontos de entrada

### Entender a fábrica

Abra:

```text
documentacao/00-VISAO-GERAL.md
```

### Consultar ERPs homologados

Abra:

```text
erps-integrados/README.md
```

### Execução técnica interna da IA

Os comandos atualmente existentes ficam em:

```text
parceiros/comandos/
```

## Para uma nova IA ou pessoa mantenedora

Comece por:

```text
documentacao/07-CONTEXTO-INICIAL-DO-PROJETO.md
```

Depois leia:

```text
AGENTS.md
parceiros/AGENTS.md
parceiros/00-GUIA-DE-EXECUCAO.md
parceiros/01-COMO-USAR-OS-COMANDOS.md
```

## Interface do operador

O operador não precisa criar, copiar ou renomear pastas manualmente para executar uma etapa liberada.

```text
PROMPT + DOCUMENTAÇÃO + DADOS CONHECIDOS
                    ↓
                  CODEX
                    ↓
      CRIA/LOCALIZA A EXECUÇÃO
                    ↓
        EXECUTA E VALIDA A ETAPA
```

Uma etapa só deve ser executada quando existir tanto o comando técnico quanto seu documento operacional humano correspondente.
