# 09 - Consolidar e publicar integracao homologada

## Quando usar

Use esta etapa quando a combinacao ERP x ferramenta estiver homologada no Passo 08 com auditoria independente aprovada e:

```text
INTEGRACAO_HOMOLOGADA: SIM
```

O Passo 09 consolida a baseline homologada e publica uma release reutilizavel para consumo da jornada ERP Cliente.

## Objetivo oficial

```text
PASSO 08 -> homologa funcionalmente
PASSO 09 -> consolida e publica release homologada
```

Resultado maximo desta etapa, somente apos auditoria independente:

```text
INTEGRACAO_PUBLICADA: SIM
DISPONIVEL_PARA_CLIENTE: SIM
EM_PRODUCAO: NAO
```

## Definicao de publicar

Publicar significa:

- congelar baseline homologada;
- versionar release;
- consolidar capacidades e restricoes comprovadas;
- declarar contrato de configuracao;
- registrar catalogo operacional;
- preparar handoff para ERP Cliente.

Publicar nao significa deploy, producao, cliente configurado ou runtime ativo.

## Pre-requisitos

- ERP e ferramenta identificados sem ambiguidade;
- Passos 01 a 08 concluidos, vigentes e auditados quando aplicavel;
- Passo 08 com `INTEGRACAO_HOMOLOGADA: SIM`;
- baseline homologada identificavel (versao/hash/commit quando houver);
- artefatos tecnicos e de auditoria acessiveis.

Se o gate do Passo 08 nao estiver apto, o Passo 09 deve retornar `BLOQUEADA`.

## O que voce precisa ter

- confirmacao de que deseja executar o Passo 09 para a combinacao atual;
- eventual decisao humana somente quando houver ambiguidade real de versao ou politica.

Nao envie credenciais, tokens ou dados de cliente real no prompt.

## O que voce nao precisa fazer manualmente

- calcular hashes manualmente;
- montar baseline tecnica;
- deduzir capacidades por contagem;
- criar manifesto, relatorio, contrato de configuracao ou catalogo na mao;
- decidir caminho interno de arquivos.

## O que a IA fara

1. Validara gates upstream e vigencia.
2. Congelara baseline homologada exata do Passo 08.
3. Verificara integridade e bloqueios de divergencia.
4. Determinara versao candidata da release.
5. Consolidara capacidades comprovadas e restricoes.
6. Gerara contrato de configuracao sem valores reais.
7. Verificara reutilizacao e ausencia de hardcode indevido.
8. Verificara ausencia de segredos persistidos.
9. Gerara manifesto e relatorio de publicacao.
10. Atualizara catalogo operacional sem duplicar fonte tecnica.
11. Encerrara a execucao produtora aguardando auditoria independente.

## Limites desta etapa

O Passo 09 nao pode:

- executar nova homologacao funcional;
- redesenvolver integracao;
- alterar mapeamento, transformacao, Base Mestra ou codigo para "fazer passar";
- configurar cliente real;
- executar producao;
- executar deploy ou runtime;
- criar Passo 10;
- criar publicacao real de combinacao especifica nesta materializacao.

## O que mandar para o chat do Copilot

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-09-CONSOLIDAR-E-PUBLICAR-INTEGRACAO-HOMOLOGADA.md

Execute somente o Passo 09 da combinacao ERP x ferramenta ja homologada no Passo 08.

Confirme obrigatoriamente:
INTEGRACAO_HOMOLOGADA: SIM
AUDITORIA PASSO 08: APROVADA

Congele baseline homologada exata e bloqueie qualquer divergencia entre homologado e publicado.

Nao reexecute homologacao funcional.
Nao redesenvolva integracao.
Nao altere mapeamento, transformacao ou codigo silenciosamente.

Consolide capacidades com status permitidos:
SUPORTADO
SUPORTADO_COM_RESTRICAO
NAO_SUPORTADO
NAO_APLICAVEL

Nao use PARCIAL_JUSTIFICADO.

Gere:
- MANIFESTO-DA-INTEGRACAO-PUBLICADA.yaml
- CONTRATO-DE-CONFIGURACAO-DA-RELEASE.yaml
- RELATORIO-DE-PUBLICACAO.md
- controle de execucao/manifesto/checkpoint do Harness quando aplicavel

Atualize o catalogo operacional sem transformar `erps-integrados/` em fonte tecnica.

Finalize como execucao produtora do Passo 09:
PUBLICACAO_PREPARADA: SIM | NAO
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS DA ETAPA: PENDENTE | BLOQUEADA
INTEGRACAO_HOMOLOGADA: SIM
INTEGRACAO_PUBLICADA: NAO
DISPONIVEL_PARA_CLIENTE: NAO
EM_PRODUCAO: NAO

Nao execute auditoria aprovadora na mesma execucao.
Nao faca commit.
Nao faca push.
```

### PARE DE COPIAR AQUI

## Exemplo preenchido

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-09-CONSOLIDAR-E-PUBLICAR-INTEGRACAO-HOMOLOGADA.md

Execute somente o Passo 09 da combinacao ERP X x Ferramenta Y ja homologada no Passo 08.

Congele baseline homologada, determine versao de release e consolide capacidades comprovadas.

Nao reexecute P7/P8, nao altere codigo e nao use dados de cliente.

Gere manifesto de release, contrato de configuracao e relatorio de publicacao.

Atualize catalogo operacional por referencia.

Nao execute auditoria aprovadora, commit ou push.
```

## Artefatos esperados

Na fonte tecnica da combinacao:

```text
erps/<erp-slug>/integracoes/<ferramenta-slug>/MANIFESTO-DA-INTEGRACAO-PUBLICADA.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/CONTRATO-DE-CONFIGURACAO-DA-RELEASE.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-PUBLICACAO.md
```

Nos controles Harness, quando aplicavel:

```text
parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-09.yaml
parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

No catalogo operacional:

```text
erps-integrados/
```

apenas por referencia a fonte tecnica canonica.

## Como interpretar resultado

- `PUBLICACAO_PREPARADA: SIM`: baseline congelada e pacote de publicacao pronto para auditoria;
- `INTEGRACAO_PUBLICADA: NAO`: produtor ainda nao promoveu publicacao definitiva;
- `INTEGRACAO_PUBLICADA: SIM`: somente apos auditoria independente aprovada;
- `DISPONIVEL_PARA_CLIENTE: SIM`: somente apos auditoria independente aprovada;
- `EM_PRODUCAO: NAO`: sempre nesta etapa.

## Status, auditoria e continuacao

A execucao produtora do Passo 09 nao se autoaprova. Ela deve terminar com:

```text
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS DA ETAPA: PENDENTE
INTEGRACAO_PUBLICADA: NAO
DISPONIVEL_PARA_CLIENTE: NAO
EM_PRODUCAO: NAO
```

Somente auditoria independente aprovada pode promover:

```text
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
INTEGRACAO_PUBLICADA: SIM
DISPONIVEL_PARA_CLIENTE: SIM
EM_PRODUCAO: NAO
```

## Proximo documento

A jornada ERP parceiro encerra no Passo 09.

Quando houver cliente concreto e combinacao publicada, seguir a jornada:

`comece-aqui/integrar-erp/erp-cliente/00-COMECE-AQUI.md`
