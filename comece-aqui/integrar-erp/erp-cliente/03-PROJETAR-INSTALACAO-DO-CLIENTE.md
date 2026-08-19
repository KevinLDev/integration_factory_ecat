# 03 - Projetar instalacao do cliente

## Quando usar

Use esta etapa quando o Passo 02 da jornada ERP Cliente estiver concluido, com a matriz comercial consolidada e `APTO_PARA_PROJETAR_INSTALACAO: SIM`, e a Fabrica precisar desenhar como as capacidades ja classificadas ficarao instaladas para este cliente especifico, antes de qualquer materializacao real em HML.

Antes de executar, consultar:

`documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`

## Objetivo

Responder com seguranca:

- para as capacidades `ATIVO` e `PRONTO_PARA_ATIVACAO` do Passo 02, como fica a configuracao projetada (sem valor real);
- quais de-paras e extensoes precisam ser projetados;
- qual o plano de ativacao das capacidades que o cliente ainda nao usa mas pode passar a usar;
- quais criterios de aceite vao validar essa instalacao mais adiante;
- o que fica de fora do escopo deste passo (nao suportado, pendente de evidencia, ou com gap aberto) e por que.

Resultado esperado da etapa:

```text
PROJETO_INSTALACAO: CONCLUIDO | PARCIAL | BLOQUEADO
PLANO_DE_INSTALACAO_CONSOLIDADO: SIM | PARCIAL | NAO
PRONTO_PARA_MATERIALIZACAO_EM_HML: SIM | NAO
PROXIMO_PASSO: ERP_CLIENTE_04 | ERP_PARCEIRO_<NN> | NOVA_FERRAMENTA_<NN> | BLOQUEADA
```

## Fronteira do Passo 03

Esta etapa nao pode:

- reclassificar qualquer capacidade que o Passo 02 ja decidiu (isso e' exclusivo do Passo 02 -- se a evidencia mudou, volte para la);
- materializar configuracao, de-para ou extensao real;
- desenvolver integracao;
- usar credenciais reais;
- executar HML;
- executar producao.

Esses itens pertencem aos passos posteriores (o Passo 04 -- "materializar instalacao em HML" -- ja esta liberado; ver nota abaixo).

## Nota sobre o roteiro completo da jornada

```text
01 Resolver contexto do cliente          [liberado, commitado]
02 Analisar realidade comercial/tecnica  [liberado]
03 Projetar instalacao                   [este documento]
04 Materializar instalacao em HML        [liberado]
05 Validar HML + preparar producao       [liberado]
06 Go-live + validar producao + memoria  [futuro]
```

Este roteiro esta formalizado nesta publicacao para delimitar o Passo 03 e impedir que ele invada o escopo do Passo 04. O Passo 06 continua nao liberado.

## Pre-requisitos

- Passo 01 concluido com contexto resolvido e release elegivel;
- Passo 02 concluido, com `MATRIZ_COMERCIAL_CONSOLIDADA` e `APTO_PARA_PROJETAR_INSTALACAO: SIM`;
- ao menos uma capacidade classificada como `ATIVO` ou `PRONTO_PARA_ATIVACAO`.

## O que voce precisa ter

- referencia a saida do Passo 02 para esta combinacao (matriz comercial e relatorio de analise);
- contrato de configuracao e manifesto de publicacao da release, quando ainda nao resolvidos automaticamente.

Nao envie secrets no prompt.

## O que voce nao precisa fazer manualmente

- reclassificar capacidades;
- montar o plano de instalacao na mao;
- decidir sozinho se um item tem gap de release ou de ferramenta;
- criar manifesto/checkpoint manualmente.

## O que a IA fara

1. Carregar a saida valida dos Passos 01 e 02.
2. Aplicar a regra de escopo: somente capacidades `ATIVO`/`PRONTO_PARA_ATIVACAO` entram no plano; o resto vai para itens fora de escopo.
3. Carregar o contrato de configuracao e o manifesto de publicacao da release.
4. Projetar configuracao (sem valor real), de-para e extensao para cada capacidade dentro do escopo.
5. Definir plano de ativacao para as capacidades `PRONTO_PARA_ATIVACAO`.
6. Definir criterios de aceite por capacidade.
7. Registrar itens fora de escopo (nao suportado, pendente de evidencia, gap de release ou de ferramenta) sem bloquear o restante do plano por causa deles.
8. Consolidar pendencias, bloqueios, restricoes e riscos.
9. Preparar o handoff para o Passo 04 sem materializar nada.

## Regra de escopo

Capacidade so entra no plano de instalacao se `origem_status = ATIVO` ou `origem_status = PRONTO_PARA_ATIVACAO` no Passo 02. Capacidades `NAO_SUPORTADO` ou `PENDENTE_DE_EVIDENCIA` vao para "itens fora de escopo".

## Regra de gap aberto

Capacidade com `GAP_DA_RELEASE` ou `GAP_DA_FERRAMENTA` aberto **nao bloqueia o Passo 03 inteiro**. Ela fica registrada em itens fora de escopo, com a rota de origem preservada, e o restante do plano segue em frente.

## Rotas de saida

- plano consolidado, sem pendencia bloqueante -> ERP Cliente Passo 04;
- pendencia bloqueante identificada durante o projeto -> permanece BLOQUEADO, registra pendencia;
- capacidade nova revelada que o Passo 02 nao cobriu -> retorna ao Passo 02;
- gap de release ainda aberto para item critico -> ERP Parceiro no menor passo responsavel;
- gap de ferramenta ainda aberto para item critico -> jornada da ferramenta.

## O que mandar para o chat do Copilot

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-CLIENTE-03-PROJETAR-INSTALACAO-DO-CLIENTE.md

Objetivo:
Projetar somente a instalacao do cliente para as capacidades ja classificadas como
ATIVO ou PRONTO_PARA_ATIVACAO pelo Passo 02, preparando a base para o Passo 04.

Solicitacao do operador:
[descreva a intencao em linguagem natural]

Cliente informado:
[nome ou identificador conhecido]

ERP informado:
[nome do ERP]

Ferramenta E-Catalogos desejada:
[nome da ferramenta]

Regras obrigatorias:
- nao reclassificar nenhuma capacidade do Passo 02;
- nao executar Passo 04;
- nao usar credencial real;
- nao executar HML;
- nao executar producao;
- nao materializar configuracao, de-para ou extensao real;
- nao inventar dados ausentes;
- capacidade com gap aberto vai para itens fora de escopo e nao bloqueia o restante do plano.

Descubra automaticamente a saida valida dos Passos 01 e 02, o contrato de configuracao e o
manifesto de publicacao da release.

Gere somente artefatos de projeto do Passo 03.
Finalize com status, plano, itens fora de escopo, pendencias, rota e proximo passo permitido.

Nao faca commit.
Nao faca push.
```

### PARE DE COPIAR AQUI

## Exemplo preenchido

```text
Execute integralmente:
parceiros/comandos/ERP-CLIENTE-03-PROJETAR-INSTALACAO-DO-CLIENTE.md

Objetivo:
Projetar a instalacao do Cliente Exemplo para a combinacao ERP Exemplo x Ferramenta Exemplo, a partir das saidas validas dos Passos 01 e 02.

Cliente informado:
Cliente Exemplo Ltda. (ficticio)

ERP informado:
ERP Exemplo

Ferramenta E-Catalogos desejada:
Ferramenta Exemplo

Materiais fornecidos:
- contrato de configuracao publicado: SIM
- matriz comercial do Passo 02: SIM
- relatorio de analise do Passo 02: SIM
- configuracoes, de-paras ou extensoes adicionais: NAO

Regras obrigatorias:
- projetar somente as capacidades classificadas como ATIVO ou PRONTO_PARA_ATIVACAO;
- nao reclassificar capacidade;
- nao usar credenciais reais;
- nao executar HML ou producao;
- nao materializar configuracao, de-para ou extensao.

Nao faca commit.
Nao faca push.
```

## Artefatos esperados

Memoria canonica do cliente (sem dados reais sensiveis):

```text
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/PLANO-DE-INSTALACAO-DO-CLIENTE.yaml
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/RELATORIO-DE-PROJETO-DE-INSTALACAO.md
```

Controles de execucao da etapa (quando aplicavel):

```text
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-03.yaml
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

## Como testar

A resposta final deve comprovar:

- consumo valido da saida dos Passos 01 e 02, sem reclassificar nada;
- plano de instalacao preenchido somente para capacidades dentro do escopo permitido;
- configuracao projetada sem valor real, com escopo `CONFIGURACAO_REUTILIZAVEL`/`CONFIGURACAO_DO_CLIENTE` explicito;
- itens fora de escopo registrados com motivo e rota;
- ausencia de segredo persistido e de qualquer execucao real (HML ou producao).

## Como interpretar falhas

| Classificacao | Encaminhamento |
| --- | --- |
| `PASSO_02_INVALIDO` | Bloquear o Passo 03 e retornar ao Passo 02. |
| `SEM_CAPACIDADE_ELEGIVEL` | Bloquear o Passo 03; nao ha `ATIVO`/`PRONTO_PARA_ATIVACAO` suficiente para projetar. |
| `RECLASSIFICACAO_TENTADA` | Bloquear; reclassificacao pertence ao Passo 02. |
| `GAP_DA_RELEASE` | Registrar em itens fora de escopo e encaminhar ao menor passo ERP parceiro necessario; nao bloqueia o restante. |
| `GAP_DA_FERRAMENTA` | Registrar em itens fora de escopo e encaminhar a jornada responsavel pela ferramenta; nao bloqueia o restante. |
| `PENDENTE_DE_EVIDENCIA` | Continuar com plano parcial seguro e registrar a falta. |
| `BLOQUEIO_CRITICO` | Bloquear somente o escopo dependente e registrar a causa. |

## Status, auditoria e quando continuar

A etapa termina com `CONCLUIDA`, `PENDENTE` ou `BLOQUEADA`.

Para projeto simples, sem divergencia estrutural critica, a regra padrao e:

```text
AUDITORIA_INDEPENDENTE_OBRIGATORIA: NAO
```

A auditoria independente deve ser exigida quando o plano envolver `EXTENSAO_CLIENTE` bloqueante, algum `GAP_DA_RELEASE`/`GAP_DA_FERRAMENTA` de item critico, ou classificacao critica que altere o proximo passo permitido.

Com `PROJETO_INSTALACAO: CONCLUIDO`, `PLANO_DE_INSTALACAO_CONSOLIDADO: SIM` e `PRONTO_PARA_MATERIALIZACAO_EM_HML: SIM`, a proxima etapa permitida e o Passo 04 da jornada ERP cliente: `comece-aqui/integrar-erp/erp-cliente/04-MATERIALIZAR-INSTALACAO-EM-HML.md`.

## Proximo documento

A jornada ERP cliente segue em evolucao. Os Passos 01, 02, 03, 04 e 05 estao liberados nesta publicacao. O Passo 06 permanece futuro: go-live e registro de memoria.
