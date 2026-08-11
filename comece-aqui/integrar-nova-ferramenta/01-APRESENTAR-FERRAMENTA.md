# 01 — Apresentar uma ferramenta E-Catálogos

## Quando usar

Use esta etapa quando a ferramenta da E-Catálogos ainda não foi analisada/cadastrada na fábrica.

## O que você precisa ter antes

- Nome da ferramenta.
- Objetivo resumido.
- Documentação oficial (PDF, Swagger/OpenAPI, manuais, exemplos).

## Quais arquivos disponibilizar

- Pelo menos a documentação oficial.
- Se existir: OpenAPI/Swagger bruto e exemplos.

## Onde colocar os arquivos

Você pode:

- anexar no chat;
- apontar caminho de arquivo já existente no repositório;
- indicar pasta com os arquivos.

Você não precisa organizar estrutura técnica manualmente.

## O que você precisa informar

- nome da ferramenta;
- objetivo;
- caminho/nome da documentação;
- informações adicionais (se houver).

## O que você NÃO precisa fazer manualmente

- criar pasta de execução;
- copiar modelos;
- renomear pastas;
- criar `DADOS-DA-EXECUCAO.md` ou `ESTADO-DA-EXECUCAO.md`;
- mover arquivos apenas para o comando funcionar.

## O que mandar para o chat do Codex

### COPIE A PARTIR DAQUI

```text
Execute integralmente:

parceiros/comandos/01-APRESENTAR-E-ANALISAR-FERRAMENTA.md

Nova ferramenta:
[NOME DA FERRAMENTA]

Objetivo:
[OBJETIVO]

Documentação:
[NOME OU CAMINHO DOS ARQUIVOS]

Informações adicionais:
[SE HOUVER]

Execute somente esta etapa.
```

### PARE DE COPIAR AQUI

Substitua os campos entre colchetes antes de enviar.
Os colchetes são marcadores e não devem permanecer no prompt final.

- `[NOME DA FERRAMENTA]` -> ex.: `Força de Vendas`
- `[OBJETIVO]` -> objetivo resumido da ferramenta
- `[NOME OU CAMINHO DOS ARQUIVOS]` -> nome/caminho da documentação oficial
- `[SE HOUVER]` -> informações extras opcionais

## Exemplo preenchido

```text
Execute integralmente:

parceiros/comandos/01-APRESENTAR-E-ANALISAR-FERRAMENTA.md

Nova ferramenta:
Força de Vendas

Objetivo:
Ferramenta de força de vendas da E-Catálogos.

Documentação:
Documentacao_API_Forca_de_Vendas.pdf

Informações adicionais:
Primeira execução real da V1.

Execute somente esta etapa.
```

## O que a IA fará

- criar/localizar execução;
- organizar referências da documentação;
- produzir análise técnica da ferramenta;
- atualizar estado persistente;
- aplicar as regras do comando técnico.

## O que você deve receber ao final

Um retorno com:

- `STATUS DA ETAPA` (`CONCLUIDA`, `PENDENTE` ou `BLOQUEADA`);
- resumo;
- arquivos criados/alterados;
- validações;
- pendências;
- próxima ação.

## Como interpretar CONCLUIDA, PENDENTE e BLOQUEADA

- `CONCLUIDA`: etapa finalizada.
- `PENDENTE`: falta informação/ajuste; continue nesta etapa.
- `BLOQUEADA`: impedimento técnico/externo; resolva antes de seguir.

## Quando posso continuar

Somente quando:

- `STATUS DA ETAPA: CONCLUIDA`
- e auditoria da etapa estiver `APROVADA`.

## Próximo documento

- `comece-aqui/integrar-nova-ferramenta/02-CADASTRAR-FERRAMENTA.md`
