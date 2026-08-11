# 02 — Cadastrar a ferramenta

## Quando usar

Use após o Passo 01 da ferramenta estar concluído e auditado.

## Antes de começar

Confirme na execução da ferramenta:

- `STATUS DA ETAPA 01: CONCLUIDA`
- `AUDITORIA ETAPA 01: APROVADA`

Sem isso, o Passo 02 deve bloquear.

## Preciso enviar algum arquivo novo?

Normalmente, não.

O Passo 02 usa principalmente os artefatos aprovados do Passo 01 já existentes na execução.

## O que preciso informar

- nome da ferramenta;
- instrução para continuar a execução existente.

## O que não preciso fazer manualmente

- criar pasta `ferramentas/<slug>`;
- criar manualmente os arquivos canônicos;
- copiar dados técnicos na mão entre arquivos;
- disparar validações internas manualmente.

## O que mandar para o chat do Codex

### COPIE A PARTIR DAQUI

```text
Execute integralmente:

parceiros/comandos/02-CADASTRAR-FERRAMENTA.md

Ferramenta:
[NOME DA FERRAMENTA]

Continue a execução existente.

Não avance para a próxima etapa.
```

### PARE DE COPIAR AQUI

Substitua os campos entre colchetes antes de enviar.
Os colchetes são marcadores e não devem permanecer no prompt final.

- `[NOME DA FERRAMENTA]` -> ex.: `Força de Vendas`

## Exemplo preenchido

```text
Execute integralmente:

parceiros/comandos/02-CADASTRAR-FERRAMENTA.md

Ferramenta:
Força de Vendas

Continue a execução existente.

Não avance para a próxima etapa.
```

## O que a IA fará

- validar pré-requisitos do Passo 01;
- criar o cadastro canônico da ferramenta em `ferramentas/<slug>/`;
- atualizar estado;
- executar auditoria obrigatória da etapa;
- retornar status final da etapa.

## O que devo receber

No retorno final:

- `AUDITORIA` (APROVADA, REPROVADA ou BLOQUEADA);
- `STATUS DA ETAPA` (CONCLUIDA, PENDENTE ou BLOQUEADA);
- resumo;
- arquivos criados/alterados;
- validações;
- pendências;
- próxima ação.

## Como interpretar o resultado

- `AUDITORIA: APROVADA` + `STATUS DA ETAPA: CONCLUIDA`:
  etapa finalizada.
- `AUDITORIA: REPROVADA` + `STATUS DA ETAPA: PENDENTE`:
  ajuste necessário no próprio Passo 02.
- `AUDITORIA: BLOQUEADA` + `STATUS DA ETAPA: BLOQUEADA`:
  existe impedimento externo/técnico.

## Quando posso continuar

Somente quando o Passo 02 terminar com:

- auditoria aprovada;
- etapa concluída.

## Próximo documento

- `comece-aqui/integrar-nova-ferramenta/03-VALIDAR-FERRAMENTA-CADASTRADA.md`
