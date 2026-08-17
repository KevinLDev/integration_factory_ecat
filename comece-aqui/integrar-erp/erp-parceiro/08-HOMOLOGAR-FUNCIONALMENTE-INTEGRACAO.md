# 08 - Homologar funcionalmente a integracao

## Quando usar

Use esta etapa quando a combinacao ERP x ferramenta tiver o Passo 07 concluido e auditado, com:

```text
PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM
```

O Passo 08 valida o uso funcional da ferramenta em HML por execucao manual assistida por IA.

## Objetivo oficial

```text
PASSO 07 -> valida tecnicamente em HML
PASSO 08 -> valida funcionalmente o uso da ferramenta
```

Resultado maximo desta etapa, somente apos auditoria independente:

```text
INTEGRACAO_HOMOLOGADA: SIM
```

## Modelo V1

A V1 deste passo e `HOMOLOGACAO FUNCIONAL MANUAL ASSISTIDA POR IA`.

- o humano executa a interface manualmente;
- a IA orienta, coleta, classifica e relata.

Nao existe automacao de navegador nem observer realtime nesta versao.

## Pre-requisitos

- ERP e ferramenta identificados sem ambiguidade;
- Passos 01 a 07 concluidos, vigentes e auditados quando aplicavel;
- Passo 07 com `PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM`;
- implementacao e baseline identificaveis (versao/hash/commit quando houver);
- artefatos de projeto e evidencias tecnicas acessiveis;
- ambiente HML autorizado para execucao manual do operador.

Se o gate do Passo 07 nao estiver apto, o Passo 08 deve retornar `BLOQUEADA`.

## O que voce precisa ter

- confirmacao de que deseja executar o Passo 08 para a combinacao atual;
- acesso humano a interface da ferramenta em HML;
- disponibilidade para executar os cenarios solicitados;
- capacidade de devolver resultados manuais com evidencias solicitadas.

Nao envie senha, token ou credencial no prompt.

## O que voce nao precisa fazer manualmente

- montar a matriz de cenarios do zero;
- inventar criterios de aprovacao;
- classificar falhas por etapa;
- gerar relatorio tecnico final;
- criar manifesto ou checkpoint.

## O que a IA fara

1. Validara gates upstream e vigencia.
2. Derivara matriz funcional por escopo suportado da combinacao.
3. Gerara roteiro operacional por cenario, com passos concretos.
4. Solicitara ao operador o retorno manual simplificado por cenario.
5. Comparara esperado x observado e classificara status.
6. Classificara falhas pelo menor passo responsavel.
7. Determinara reexecucoes necessarias por impacto.
8. Organizara evidencias e gerara relatorio funcional.
9. Encerrara a execucao produtora aguardando auditoria independente.

## Limites desta etapa

O Passo 08 nao pode:

- substituir validacao tecnica do Passo 07;
- reexecutar HML tecnica inteira sem necessidade;
- alterar contrato, mapeamento, transformacao, Base Mestra ou codigo para "fazer passar";
- controlar navegador automaticamente;
- criar observer realtime;
- publicar integracao;
- registrar ERP em `erps-integrados/`;
- configurar cliente real;
- executar producao.

## O que mandar para o chat do Copilot

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-08-HOMOLOGAR-FUNCIONALMENTE-INTEGRACAO.md

Execute somente o Passo 08 da combinacao ERP x ferramenta ja identificada.

Modelo V1:
HOMOLOGACAO FUNCIONAL MANUAL ASSISTIDA POR IA

Confirme os gates upstream e exija obrigatoriamente PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM no Passo 07.

Derive os cenarios apenas do escopo suportado pela combinacao vigente (nao usar checklist universal).

Nao automatize navegador.
Nao implemente observer realtime.
Nao execute producao.
Nao use cliente real.
Nao publique integracao.
Nao crie Passo 09.

Para cada cenario, forneca:
- pre-condicoes;
- faca (passo a passo objetivo);
- observe;
- confirme;
- evidencia solicitada.

Colete meu retorno manual simplificado por cenario e transforme em:
- status;
- classificacao_da_falha;
- menor_passo_responsavel;
- reexecucao_necessaria.

Gere:
- PLANO-DE-HOMOLOGACAO-FUNCIONAL.yaml
- MATRIZ-DE-CENARIOS-FUNCIONAIS.yaml
- EVIDENCIAS-FUNCIONAIS.yaml
- RELATORIO-DE-HOMOLOGACAO-FUNCIONAL.md
- manifesto/checkpoint do Harness quando aplicavel

Finalize como execucao produtora do Passo 08:
HOMOLOGACAO_FUNCIONAL: APROVADA | REPROVADA | BLOQUEADA
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS DA ETAPA: PENDENTE
INTEGRACAO_HOMOLOGADA: NAO

Nao execute auditoria aprovadora na mesma execucao.
Nao faca commit.
Nao faca push.
```

### PARE DE COPIAR AQUI

## Exemplo preenchido

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-08-HOMOLOGAR-FUNCIONALMENTE-INTEGRACAO.md

Execute somente o Passo 08 da combinacao ERP X x Ferramenta Y ja identificada.

Modelo V1: HOMOLOGACAO FUNCIONAL MANUAL ASSISTIDA POR IA.

Nao automatize navegador e nao use observer realtime.
Derive cenarios do escopo suportado e me entregue roteiro detalhado por cenario.

Vou executar manualmente na ferramenta HML e devolver resultado simplificado com IDs e evidencias.

Classifique cada cenario, determine reexecucao quando necessario e gere os artefatos finais.

Nao execute auditoria aprovadora, commit ou push.
```

## Artefatos esperados

Na memoria da combinacao:

```text
erps/<erp-slug>/integracoes/<ferramenta-slug>/PLANO-DE-HOMOLOGACAO-FUNCIONAL.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/MATRIZ-DE-CENARIOS-FUNCIONAIS.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/EVIDENCIAS-FUNCIONAIS.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-HOMOLOGACAO-FUNCIONAL.md
```

Nos controles Harness, quando aplicavel:

```text
parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-08.yaml
parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

## Como interpretar resultado

- `APROVADO`: comportamento funcional confirmado com evidencia suficiente;
- `REPROVADO`: divergencia funcional comprovada;
- `BLOQUEADO`: impedimento externo que inviabiliza concluir o cenario;
- `PENDENTE`: cenario ainda nao executado;
- `PENDENTE_DE_EVIDENCIA`: retorno insuficiente para concluir;
- `NAO_APLICAVEL`: fora do escopo suportado, com justificativa.

Cenario critico reprovado bloqueia homologacao funcional da combinacao.

## Status, auditoria e continuacao

A execucao produtora do Passo 08 nao se autoaprova. Ela deve terminar com:

```text
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS DA ETAPA: PENDENTE
INTEGRACAO_HOMOLOGADA: NAO
```

Somente auditoria independente aprovada pode promover:

```text
STATUS DA ETAPA: CONCLUIDA
INTEGRACAO_HOMOLOGADA: SIM
```

## Proximo documento

Nao existe passo operacional posterior publicado nesta tarefa. Com `INTEGRACAO_HOMOLOGADA: SIM` apos auditoria, a combinacao fica apenas elegivel para futura capacidade de publicacao.
