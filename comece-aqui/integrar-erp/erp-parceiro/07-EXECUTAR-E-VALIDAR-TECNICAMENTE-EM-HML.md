# 07 - Executar e validar tecnicamente em HML

## Quando usar

Use esta etapa quando a combinacao ERP x ferramenta tiver implementacao aprovada no Passo 06 com `PRONTO_PARA_EXECUCAO_HML: SIM` e o operador autorizar explicitamente a execucao controlada em ambientes HML.

O Passo 07 executa os flows aprovados contra ERP e ferramenta em HML, teste, sandbox, homologacao ou DEV autorizado. Ele produz evidencia tecnica para uma futura homologacao funcional.

## Objetivo

Validar tecnicamente, com escrita real controlada e reconsulta, os flows aplicaveis da combinacao:

- ERP para ferramenta;
- ferramenta para ERP quando suportado e projetado;
- correlacao, identidade e idempotencia;
- prevencao de loop, ownership e conflito quando aplicaveis;
- paginacao, retry, rate limit, falha parcial, checkpoint, retomada e reprocessamento;
- reconciliacao semantica entre origem e destino.

O maior resultado possivel, depois de auditoria independente, e:

```text
VALIDACAO_TECNICA_HML_APROVADA
PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM
```

Isto nunca significa `INTEGRACAO_HOMOLOGADA`.

## Pre-requisitos

- combinacao ERP x ferramenta identificada sem ambiguidade;
- gates upstream exigidos pela combinacao concluidos, vigentes e reutilizaveis;
- Passo 06 com `PRONTO_PARA_EXECUCAO_HML: SIM`;
- implementacao identificavel por versao, hash e commit quando disponivel;
- Base Mestra vigente e apta aos cenarios HML selecionados;
- ERP e ferramenta comprovadamente em ambiente HML/teste/sandbox/homologacao ou DEV autorizado;
- autorizacao explicita para combinacao, versao da implementacao, ambientes e classes de escrita;
- credenciais disponiveis apenas por mecanismo seguro e transitorio quando forem necessarias.

Nao basta informar uma URL contendo `hml`. Se houver duvida de producao, a execucao deve ser bloqueada antes de qualquer escrita.

## O que voce precisa ter

- confirmacao de que deseja executar o Passo 07 para a combinacao atual;
- autorizacao explicita para as escritas HML controladas;
- identificacao dos ambientes autorizados e das classes de escrita permitidas;
- acesso seguro as credenciais somente se a IA solicitar em canal/mecanismo apropriado.

Nao envie segredo, token ou senha no prompt. A IA registra somente a presenca e usa valores reais apenas de forma transitoria quando autorizada.

## O que voce nao precisa fazer manualmente

- localizar os Passos 01 a 06, Base Mestra, mapeamento, codigo ou manifestos;
- criar plano, evidencias, relatorio, estado, checkpoint ou manifesto;
- calcular hashes, escolher correlacao ou definir retry;
- criar dados de homologacao, ambiente, runtime, deploy ou configuracao de cliente;
- copiar IDs fisicos da Base Mestra para a configuracao da integracao.

## O que a IA fara

1. Validara os gates upstream exigidos, a versao da implementacao e a Base Mestra.
2. Validara ambiente, fingerprint nao sensivel, autorizacao e limite de escrita antes da primeira chamada mutavel.
3. Gerara o plano HML usando os models em `parceiros/modelos/hml/`.
4. Executara somente os flows e operacoes aprovados, com lookup, correlacao e reconsulta.
5. Registrara evidencia sanitizada por caso, sem payload sensivel ou segredo.
6. Validara idempotencia, loop, paginacao, retry, rate limit, checkpoint, retomada e reprocessamento quando aplicaveis.
7. Classificara falhas e retornara ao menor passo responsavel sem corrigir upstream silenciosamente.
8. Gerara relatorio tecnico, manifesto e checkpoint conforme o Harness.
9. Terminara a execucao produtora aguardando auditoria independente; nao se autoaprovara.

## Limites desta etapa

O Passo 07 nao pode:

- alterar o mapeamento ou as transformacoes do Passo 05;
- corrigir bug de implementacao fora do Passo 06;
- redesenhar ou recriar a Base Mestra;
- alterar contrato homologado da ferramenta;
- executar homologacao funcional pelo aplicativo ou painel;
- publicar a integracao ou registrar ERP em `erps-integrados/`;
- criar runtime 24/7, deploy de producao ou monitoramento definitivo;
- configurar cliente real;
- executar producao.

## O que mandar para o chat do Copilot

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-07-EXECUTAR-E-VALIDAR-TECNICAMENTE-EM-HML.md

Execute somente o Passo 07 da combinacao ERP x ferramenta ja identificada.

Autorizacao explicita para HML:
SIM

Ambiente autorizado do ERP:
[HML | HOMOLOGACAO | SANDBOX | TESTE | DEV_AUTORIZADO]

Ambiente autorizado da ferramenta:
[HML | HOMOLOGACAO | SANDBOX | TESTE | DEV_AUTORIZADO]

Classes de escrita permitidas:
[LISTAR SOMENTE AS CLASSES/OPERACOES AUTORIZADAS]

Regras adicionais de seguranca:
[SE HOUVER]

Descubra automaticamente os gates exigidos, a implementacao aprovada no Passo 06, a Base Mestra, o projeto do Passo 05, os manifestos, estado e checkpoints.

Antes da primeira escrita, prove que os dois ambientes nao sao producao, registre fingerprints nao sensiveis e valide a autorizacao. Se houver duvida de producao, bloqueie.

Use credenciais apenas de forma transitoria e segura. Nao persista, imprima ou repita secrets.

Execute somente flows e operacoes aprovados. Faca lookup quando aplicavel, use correlacao, reconsulte o destino apos escrita e nao avance origem ou watermark antes de confirmacao valida do destino.

Valide idempotencia, loop, ownership/conflito, paginacao, retry/rate limit, falha parcial, checkpoint, retomada e reprocessamento quando aplicaveis.

Nao altere mapeamento, transformacoes, Base Mestra, contrato ou codigo para fazer HML passar. Classifique o problema e retorne ao menor passo responsavel.

Nao execute producao, homologacao funcional, publicacao, runtime 24/7, deploy, monitoramento definitivo ou configuracao de cliente real.

Gere:
- PLANO-DE-EXECUCAO-HML.yaml
- EVIDENCIAS-DE-EXECUCAO-HML.yaml
- RELATORIO-DE-VALIDACAO-TECNICA-HML.md
- manifesto e checkpoint genericos do Harness quando aplicaveis

Nao execute auditoria aprovadora nesta mesma execucao. Nao faca commit. Nao faca push. Pare apos o retorno da execucao produtora do Passo 07.
```

### PARE DE COPIAR AQUI

Substitua apenas os campos entre colchetes. Nao envie credenciais, tokens, senhas ou IDs de cliente no prompt.

## Exemplo preenchido

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-07-EXECUTAR-E-VALIDAR-TECNICAMENTE-EM-HML.md

Execute somente o Passo 07 da combinacao ERP X x Ferramenta Y ja identificada.

Autorizacao explicita para HML:
SIM

Ambiente autorizado do ERP:
HOMOLOGACAO

Ambiente autorizado da ferramenta:
HML

Classes de escrita permitidas:
CREATE e UPDATE dos registros de homologacao previstos no plano HML vigente

Regras adicionais de seguranca:
Nao usar producao e nao executar exclusao automatica.

Descubra o contexto persistido, valide os gates e execute somente os flows aprovados. Gere plano, evidencias e relatorio tecnico HML. Nao execute auditoria aprovadora nesta mesma execucao, commit ou push.
```

## Artefatos esperados

Na memoria da combinacao:

```text
erps/<erp-slug>/integracoes/<ferramenta-slug>/PLANO-DE-EXECUCAO-HML.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/EVIDENCIAS-DE-EXECUCAO-HML.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-VALIDACAO-TECNICA-HML.md
```

Na execucao Harness, quando aplicavel:

```text
parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-07.yaml
parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

## Como testar

O retorno deve demonstrar, quando aplicavel:

- ambiente validado e producao descartada nos dois lados;
- autorizacao e classes de escrita verificadas;
- reconsulta apos escrita e comparacao semantica;
- correlacao `ERP_ID <-> ID_LOGICO <-> TOOL_ID`;
- caso repetido sem duplicacao;
- caso de loop reconhecido e interrompido;
- paginacao completa, retry limitado e `Retry-After` respeitado;
- nenhum retry cego de erro 4xx, semantico ou de mapping;
- checkpoint e retomada somente apos revalidar baseline;
- reprocessamento precedido de consulta do destino;
- ausencia de producao, segredo persistido, homologacao funcional e publicacao.

## Como interpretar falhas

| Classificacao                       | Encaminhamento                                                       |
| ----------------------------------- | -------------------------------------------------------------------- |
| `ERRO_DE_EXECUCAO_HML`              | Reprocessar no Passo 07 somente quando o estado for seguro.          |
| `BUG_DE_IMPLEMENTACAO`              | Retornar ao Passo 06.                                                |
| `DIVERGENCIA_DE_PROJETO`            | Retornar ao Passo 05.                                                |
| `BASE_DE_HOMOLOGACAO_INSUFICIENTE`  | Retornar ao Passo 03 ou 04, conforme planejamento ou materializacao. |
| `EVIDENCIA_DE_ERP_INSUFICIENTE`     | Retornar ao Passo 02.                                                |
| `CONTRATO_DA_FERRAMENTA_DIVERGENTE` | Bloquear e retornar a jornada responsavel pela ferramenta.           |

## Status, auditoria e quando continuar

A execucao produtora usa somente `CONCLUIDA`, `PENDENTE` ou `BLOQUEADA`. Como a auditoria aprovadora deve ser independente, uma execucao tecnicamente bem-sucedida termina com:

```text
VALIDACAO_TECNICA_HML: APROVADA
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS DA ETAPA: PENDENTE
```

Depois, uma execucao separada de `parceiros/auditorias/AUDITAR-ETAPA.md` deve auditar o Passo 07 em modo `PROFUNDA` quando esta for a primeira execucao HML real da combinacao. Somente auditoria aprovada e gate completo permitem:

```text
STATUS DA ETAPA: CONCLUIDA
PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM
```

Homologacao funcional, publicacao, runtime e producao continuam fora desta etapa e dependem dos passos posteriores oficiais da jornada.

## Proximo documento

O proximo passo operacional publicado para a jornada ERP parceiro e:

`comece-aqui/integrar-erp/erp-parceiro/08-HOMOLOGAR-FUNCIONALMENTE-INTEGRACAO.md`

O Passo 08 valida uso funcional da ferramenta em modelo manual assistido por IA. A publicacao da combinacao ocorre no Passo 09; runtime e ERP cliente permanecem capacidades posteriores.
