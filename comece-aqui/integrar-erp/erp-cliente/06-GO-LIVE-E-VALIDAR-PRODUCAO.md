# 06 - Go-live, validar producao e registrar memoria

## Quando usar

Use esta etapa quando o Passo 05 desta combinacao de cliente estiver concluido, com `AUDITORIA: APROVADA` e `PRONTO_PARA_PRODUCAO: SIM`, e voce (o operador) decidir autorizar o go-live real deste cliente.

Esta e a primeira etapa de toda a fabrica -- nao so da jornada ERP Cliente -- que escreve em producao. Nenhum passo do ERP Parceiro (01 a 09) executa producao; todos permanecem limitados a HML, homologacao, sandbox ou teste. Trate esta etapa com o nivel de cautela mais alto do repositorio.

Antes de executar, consultar:

- `documentacao/17-VALIDACAO-TECNICA-DE-INTEGRACOES-EM-HML.md`;
- `documentacao/18-HOMOLOGACAO-FUNCIONAL-DE-INTEGRACOES.md`;
- `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`;
- os documentos e artefatos dos Passos 01 a 05 desta combinacao, especialmente o Passo 05 (`VALIDACAO-HML-DO-CLIENTE.yaml`).

## Objetivo

Responder com seguranca:

- o que ja foi validado em HML no Passo 05 realmente funciona quando materializado em producao para este cliente?
- o go-live foi executado de forma completa, confirmada e sem escrita indevida?
- o cliente esta, de fato, integrado e operando?

Resultado esperado da execucao produtora (a etapa nunca se autoaprova):

```text
AUTORIZACAO_PRODUCAO: SIM | NAO
PLANO_DE_CONTINGENCIA_DEFINIDO: SIM | NAO
AMBIENTE_PRODUCAO_CONFIRMADO: SIM | NAO
GO_LIVE: EXECUTADO | PARCIAL_JUSTIFICADO | BLOQUEADO
VALIDACAO_POS_GO_LIVE: APROVADA | REPROVADA | PENDENTE
MEMORIA_REGISTRADA: SIM | NAO
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS_DA_ETAPA: PENDENTE
CLIENTE_INTEGRADO: NAO
```

Somente apos auditoria independente `PROFUNDA` aprovada -- a mais rigorosa de toda a jornada, por ser a primeira producao real da fabrica -- esses controles podem avancar para `AUDITORIA: APROVADA`, `STATUS_DA_ETAPA: CONCLUIDA` e `CLIENTE_INTEGRADO: SIM`.

## Fronteira do Passo 06

Esta etapa nao pode:

- iniciar qualquer escrita sem autorizacao explicita de producao, dada especificamente para este go-live (a autorizacao de HML do Passo 04/05 nao vale aqui);
- iniciar qualquer escrita sem um plano de contingencia definido antes;
- re-homologar a integracao generica, revalidar o que o Passo 05 ja aprovou, ou reprojetar/reclassificar qualquer coisa dos Passos 02, 03 ou 04;
- fazer rollback destrutivo automatico de dados reais ja escritos (pedido, estoque, cliente real). Falha parcial preserva o que foi confirmado e aciona o plano de contingencia, nao apaga nada sozinha;
- persistir credencial ou segredo real em qualquer artefato;
- criar runtime 24/7, monitoramento continuo ou automacao permanente -- isso continua fora de escopo (visao futura da fabrica);
- autoaprovar-se: a conclusao formal da etapa depende de auditoria independente `PROFUNDA`.

## Nota sobre o roteiro completo da jornada

```text
01 Resolver contexto do cliente          [liberado, commitado]
02 Analisar realidade comercial/tecnica  [liberado]
03 Projetar instalacao                   [liberado, somente projeto]
04 Materializar instalacao em HML        [liberado, auditoria PROFUNDA obrigatoria]
05 Validar HML + preparar producao       [liberado, auditoria PROFUNDA obrigatoria]
06 Go-live + validar producao + memoria  [este documento]
```

Com o Passo 06, os 6 passos do roteiro informado pelo operador ficam formalmente liberados. Nao ha Passo 07 da jornada ERP Cliente: runtime e monitoramento continuos permanecem visao futura, sem etapa oficial.

## Pre-requisitos

- Passo 05 concluido, com `AUDITORIA: APROVADA` e `PRONTO_PARA_PRODUCAO: SIM`;
- nenhum cenario `CRITICO` ou `ALTO` reprovado, pendente ou bloqueado no Passo 05;
- plano de contingencia definido: o que fazer se algo falhar no meio do go-live (pausar, quem decide, o que e reversivel e o que nao e);
- autorizacao explicita sua para producao, especifica para este cliente, esta combinacao e este momento.

## O que voce precisa ter

- referencia a validacao aprovada do Passo 05 para esta combinacao;
- acesso ao ambiente de producao real do cliente, com credenciais fornecidas por canal seguro (nunca no prompt);
- disponibilidade para operar manualmente a ferramenta (Forca de Vendas ou a que for) na confirmacao pos-go-live, mesmo modelo do Passo 05.

Nao envie secrets no prompt.

## O que voce nao precisa fazer manualmente

- redesenhar ou revalidar o que ja foi aprovado no Passo 05;
- classificar falhas ou decidir o menor passo responsavel;
- disparar a auditoria independente -- ela e uma execucao separada, somente leitura.

## O que a IA fara

1. Carregar a validacao aprovada do Passo 05 e a instalacao materializada do Passo 04 para esta combinacao.
2. Confirmar autorizacao explicita de producao e plano de contingencia definido -- sem isso, nao inicia escrita.
3. Confirmar que o ambiente resolvido e producao real (nunca HML/sandbox/teste) e registrar fingerprint nao sensivel.
4. Executar o go-live: materializar em producao exatamente o que ja foi validado, com reconsulta e confirmacao apos cada escrita, idempotencia, sem correcao silenciosa.
5. Preservar tudo que for confirmado com sucesso; se houver falha parcial, acionar o plano de contingencia em vez de tentar desfazer dados reais.
6. Rodar a confirmacao pos-go-live: reexecutar (via terminal/agente) os mesmos cenarios ja aprovados no Passo 05, agora contra producao, e conferir manualmente na propria ferramenta (Forca de Vendas ou a que for) que o resultado aparece correto. Esta e uma confirmacao curta, nao uma nova homologacao completa.
7. Classificar qualquer falha encontrada e apontar o menor passo responsavel.
8. Registrar a memoria final de fechamento da integracao deste cliente.
9. Encerrar com `AUDITORIA: AGUARDANDO_INDEPENDENTE` -- a execucao produtora nunca se autoaprova.

## Politica de ambiente -- INVERTIDA em relacao aos Passos 04/05

Nos Passos 04 e 05, a regra e bloquear se o ambiente resolver como producao. Aqui e o oposto: **bloquear se o ambiente resolver como HML, homologacao, sandbox, teste ou DEV**. Go-live so tem sentido contra producao real comprovada. Na duvida, bloquear -- nunca presumir producao pelo texto da URL.

## Politica de autorizacao

Autorizacao de producao e distinta e nao reaproveita a autorizacao de HML dos Passos 04/05. Nesta V1, o proprio operador (voce) e a unica autoridade que precisa autorizar -- nao existe aprovacao externa do lado do cliente neste momento. Ainda assim, a autorizacao deve ser explicita e dada para este go-live especifico; nunca presumida ou reutilizada de uma sessao anterior.

## Politica de credenciais

Mesma politica dos Passos 04/05: credenciais reais de producao podem ser usadas de forma transitoria durante a execucao. Proibido persistir segredo em qualquer artefato, log, relatorio ou resposta ao operador.

## Falha parcial e plano de contingencia

Producao nao permite rollback automatico de dado real. Se uma escrita falhar no meio do go-live:

1. preservar tudo que ja foi confirmado com sucesso;
2. nao tentar desfazer ou compensar automaticamente;
3. registrar exatamente o que falhou e o estado observado;
4. acionar o plano de contingencia definido na Fase 1 (pausar e aguardar decisao humana);
5. nunca prosseguir "tentando de novo" sem entender a causa.

## Taxonomia de falhas e menor passo responsavel

| Classificacao | Encaminhamento |
| --- | --- |
| `FALHA_TECNICA_DE_GO_LIVE` | Preservar sucessos, acionar plano de contingencia, registrar pendencia bloqueante. |
| `DIVERGENCIA_ENTRE_HML_E_PRODUCAO` | Retornar ao Passo 05 se a validacao foi insuficiente, ou ao Passo 04 se a materializacao original estava incorreta. |
| `BUG_NA_INTEGRACAO_GENERICA` | Encaminhar ao ERP Parceiro (menor passo responsavel, tipicamente o Passo 06 dessa jornada). |
| `CAPACIDADE_ERP_INCORRETA_OU_INSUFICIENTE` | Retornar ao Passo 02. |
| `BUG_OU_DIVERGENCIA_DA_FERRAMENTA` | Encaminhar a jornada responsavel pela ferramenta. |

## O que mandar para o chat

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-CLIENTE-06-GO-LIVE-E-VALIDAR-PRODUCAO.md

Objetivo:
Executar o go-live em producao desta combinacao de cliente, com base na validacao ja aprovada no Passo 05.

Cliente informado:
[nome ou identificador conhecido]

ERP informado:
[nome do ERP]

Ferramenta E-Catalogos desejada:
[nome da ferramenta]

Autorizacao explicita de producao:
[SIM/NAO -- deve ser dada por voce, especificamente para este go-live]

Plano de contingencia:
[descreva o que fazer se algo falhar no meio do go-live]

Regras obrigatorias:
- nao iniciar escrita sem autorizacao explicita de producao e plano de contingencia definidos;
- bloquear se o ambiente nao for producao real comprovada;
- nao revalidar nem reprojetar o que ja foi aprovado nos Passos 04/05;
- preservar sucessos parciais, nunca fazer rollback automatico de dado real;
- nao persistir segredo em nenhum artefato;
- confirmar pos-go-live reexecutando os cenarios do Passo 05 e conferindo na ferramenta;
- registrar a memoria final de fechamento;
- nao se autoaprovar -- encerrar com AUDITORIA: AGUARDANDO_INDEPENDENTE.

Descubra automaticamente a validacao aprovada do Passo 05 e a instalacao materializada do Passo 04 para esta combinacao.

Gere somente os artefatos do Passo 06.
Finalize com o gate completo da etapa.

Nao faca commit.
Nao faca push.
```

### PARE DE COPIAR AQUI

## Artefatos esperados

Memoria canonica do cliente (sem dados reais sensiveis):

```text
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/GO-LIVE-DO-CLIENTE.yaml
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/RELATORIO-DE-GO-LIVE-DO-CLIENTE.md
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/MEMORIA-DA-INTEGRACAO-DO-CLIENTE.md
```

Controles de execucao da etapa (quando aplicavel):

```text
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-06.yaml
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

## Como testar

A resposta final deve comprovar:

- autorizacao de producao e plano de contingencia registrados antes da primeira escrita;
- ambiente confirmado como producao real, nunca HML/sandbox/teste;
- cada escrita do go-live confirmada por reconsulta;
- idempotencia comprovada;
- confirmacao pos-go-live feita contra producao, reexecutando os cenarios do Passo 05 e conferindo manualmente na ferramenta;
- memoria de fechamento registrada;
- ausencia de segredo persistido;
- encerramento com `AUDITORIA: AGUARDANDO_INDEPENDENTE` e `STATUS_DA_ETAPA: PENDENTE`.

## Status, auditoria e quando continuar

Esta e a primeira execucao de producao de toda a fabrica. Conforme `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`, a primeira execucao real exige auditoria independente `PROFUNDA`; aqui isso vale com o maior rigor possivel.

A execucao produtora sempre encerra com:

```text
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS_DA_ETAPA: PENDENTE
CLIENTE_INTEGRADO: NAO
```

Somente apos a auditoria independente `PROFUNDA` aprovada, esses controles podem avancar para:

```text
AUDITORIA: APROVADA
STATUS_DA_ETAPA: CONCLUIDA
CLIENTE_INTEGRADO: SIM
```

Com `CLIENTE_INTEGRADO: SIM`, a jornada ERP Cliente desta combinacao esta formalmente concluida.

## Proximo documento

Com o Passo 06, o roteiro de 6 passos da jornada ERP Cliente fica completo. Runtime e monitoramento continuos permanecem visao futura, sem etapa oficial liberada.
