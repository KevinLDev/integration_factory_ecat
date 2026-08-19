# 05 - Validar HML e preparar producao

## Quando usar

Use esta etapa quando o Passo 04 desta combinacao de cliente estiver concluido, com `AUDITORIA: APROVADA` e `PRONTO_PARA_VALIDACAO_HML: SIM`, e for necessario comprovar que a instalacao materializada em HML realmente funciona para este cliente antes de autorizar producao.

Antes de executar, consultar:

- `documentacao/17-VALIDACAO-TECNICA-DE-INTEGRACOES-EM-HML.md`;
- `documentacao/18-HOMOLOGACAO-FUNCIONAL-DE-INTEGRACOES.md` (padrao de homologacao funcional manual assistida por IA usado como referencia);
- `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`;
- `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`.

## Objetivo

Responder com seguranca:

- os fluxos materializados no Passo 04 realmente funcionam em HML, com dados reais deste cliente, e atendem os criterios de aceite definidos no Passo 03?
- o comportamento percebido no uso da ferramenta, por processo de negocio deste cliente, esta correto?
- o que falta, se algo faltar, para autorizar o go-live em producao?

Resultado esperado da execucao produtora (a etapa nunca se autoaprova):

```text
VALIDACAO_TECNICA_HML_CLIENTE: APROVADA | PARCIAL_JUSTIFICADA | REPROVADA | BLOQUEADA
CRITERIOS_DE_ACEITE_ATENDIDOS: SIM | PARCIAL | NAO
HOMOLOGACAO_FUNCIONAL_CLIENTE: APROVADA | REPROVADA | BLOQUEADA
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS_DA_ETAPA: PENDENTE
PRONTO_PARA_PRODUCAO: NAO
```

Somente apos auditoria independente `PROFUNDA` aprovada esses controles podem avancar para `AUDITORIA: APROVADA`, `STATUS_DA_ETAPA: CONCLUIDA` e `PRONTO_PARA_PRODUCAO: SIM`.

## Fronteira do Passo 05

Esta etapa nao pode:

- re-homologar a integracao generica ERP x ferramenta (isso ja foi resolvido nos Passos 07, 08 e 09 da jornada ERP Parceiro; o Passo 05 valida somente a instancia deste cliente);
- materializar, corrigir ou ajustar configuracao (se algo estiver incorreto, a rota e voltar ao Passo 04 ou, se for de projeto, ao Passo 03);
- reprojetar nem reclassificar nada dos Passos 02 e 03;
- executar producao sob qualquer circunstancia;
- persistir credencial ou segredo real em qualquer artefato, log, relatorio ou resposta ao operador;
- autoaprovar-se: a conclusao formal da etapa depende de auditoria independente `PROFUNDA`, por ser a primeira validacao real desta combinacao de cliente.

## Nota sobre o roteiro completo da jornada

```text
01 Resolver contexto do cliente          [liberado, commitado]
02 Analisar realidade comercial/tecnica  [liberado]
03 Projetar instalacao                   [liberado, somente projeto]
04 Materializar instalacao em HML        [liberado, com auditoria PROFUNDA obrigatoria]
05 Validar HML + preparar producao       [este documento]
06 Go-live + validar producao + memoria  [liberado, com auditoria PROFUNDA obrigatoria]
```

Com o Passo 06, o roteiro completo esta liberado.

## Pre-requisitos

- Passo 04 concluido, com `AUDITORIA: APROVADA` e `PRONTO_PARA_VALIDACAO_HML: SIM`;
- instalacao materializada e plano do Passo 03 ainda vigentes (sem divergencia relevante desde a materializacao);
- ambiente de HML do cliente acessivel para execucao dos cenarios;
- perfil humano disponivel para operar a ferramenta manualmente durante a validacao funcional.

## O que voce precisa ter

- referencia a instalacao materializada do Passo 04 e ao plano do Passo 03 (criterios de aceite) para esta combinacao;
- disponibilidade de um operador humano para executar as acoes de interface na ferramenta em HML (V1 nao usa automacao de navegador).

Nao envie secrets no prompt.

## O que voce nao precisa fazer manualmente

- derivar sozinho os cenarios de validacao -- a IA deriva a partir dos criterios de aceite e da matriz funcional ja homologada na jornada Parceiro;
- classificar falhas ou decidir o menor passo responsavel;
- disparar a auditoria independente -- ela e uma execucao separada, somente leitura.

## O que a IA fara

1. Carregar a instalacao materializada do Passo 04 e o plano do Passo 03 (criterios de aceite) para esta combinacao.
2. Derivar os cenarios de validacao tecnica e funcional a partir dos criterios de aceite e da matriz funcional ja homologada para a combinacao ERP x ferramenta.
3. Executar a validacao tecnica em HML: confirmar que os fluxos materializados sincronizam, transformam e persistem os dados corretamente, com reconsulta e comparacao planejado x observado.
4. Conduzir a validacao funcional manual assistida: gerar roteiro operacional (PRE-CONDICOES, FACA, OBSERVE, CONFIRME, EVIDENCIA SOLICITADA) por cenario, coletar o retorno manual do operador humano, e classificar cada cenario.
5. Classificar cada falha encontrada e apontar o menor passo responsavel, sem corrigir upstream silenciosamente.
6. Consolidar pendencias, bloqueios e riscos.
7. Gerar os artefatos obrigatorios da etapa.
8. Encerrar com `AUDITORIA: AGUARDANDO_INDEPENDENTE` -- a execucao produtora nunca se autoaprova.

## Politica de criticidade -- OBRIGATORIA

- qualquer cenario `CRITICO` com status `REPROVADO`, `PENDENTE`, `PENDENTE_DE_EVIDENCIA` ou `BLOQUEADO` impede `PRONTO_PARA_PRODUCAO: SIM`;
- para cenarios `ALTO`, o limite e zero reprovado para concluir sem ressalva;
- `PARCIALMENTE_APROVADO` e proibido como status de cenario, para nao mascarar problema critico;
- nao homologar por percentual (ex.: "49 aprovados + 1 critico reprovado" continua `NAO`).

## Politica de credenciais

Mesma politica dos Passos 04: credenciais reais de HML podem ser usadas de forma transitoria durante a execucao dos cenarios. Proibido persistir segredo em qualquer artefato, log, relatorio ou resposta ao operador.

## Rotas de saida (menor passo responsavel)

| Classificacao da falha | Encaminhamento |
| --- | --- |
| `FALHA_FUNCIONAL_DO_CENARIO` | Resolve-se dentro do proprio Passo 05; nao corrige upstream silenciosamente. |
| `FALHA_TECNICA_DE_MATERIALIZACAO` | Retorna ao Passo 04. |
| `DIVERGENCIA_DE_PROJETO` | Retorna ao Passo 03. |
| `CAPACIDADE_ERP_INCORRETA_OU_INSUFICIENTE` | Retorna ao Passo 02. |
| `BUG_NA_INTEGRACAO_GENERICA` | Nao pertence ao Passo 04/05 do cliente -- encaminha ao ERP Parceiro (menor passo responsavel, tipicamente o Passo 06); a combinacao ja homologada pode precisar de nova rodada de auditoria la. |
| `BUG_OU_DIVERGENCIA_DA_FERRAMENTA` ou `CONTRATO_DA_FERRAMENTA_DIVERGENTE` | Encaminha a jornada responsavel pela ferramenta ou ao ERP Parceiro, conforme a origem. |

Aprovado, sem pendencia bloqueante -> auditoria independente `PROFUNDA` do Passo 05; apos aprovacao, ERP Cliente Passo 06.

## O que mandar para o chat

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-CLIENTE-05-VALIDAR-HML-E-PREPARAR-PRODUCAO.md

Objetivo:
Validar tecnica e funcionalmente, em HML, a instalacao materializada no Passo 04 para esta combinacao de cliente.

Cliente informado:
[nome ou identificador conhecido]

ERP informado:
[nome do ERP]

Ferramenta E-Catalogos desejada:
[nome da ferramenta]

Operador humano disponivel para validacao funcional manual:
[SIM/NAO -- V1 exige execucao manual na ferramenta]

Regras obrigatorias:
- nao materializar nem corrigir configuracao (isso pertence ao Passo 04);
- nao reprojetar nem reclassificar nada dos Passos 02/03;
- nao re-homologar a integracao generica ERP x ferramenta;
- nao usar producao sob nenhuma circunstancia;
- nao persistir segredo em nenhum artefato;
- classificar cada cenario sem mascarar problema critico (PARCIALMENTE_APROVADO proibido);
- nao se autoaprovar -- encerrar com AUDITORIA: AGUARDANDO_INDEPENDENTE.

Descubra automaticamente a instalacao materializada do Passo 04 e os criterios de aceite do Passo 03 para esta combinacao.

Gere somente os artefatos de validacao do Passo 05.
Finalize com o gate completo da etapa.

Nao faca commit.
Nao faca push.
```

### PARE DE COPIAR AQUI

## Artefatos esperados

Memoria canonica do cliente (sem dados reais sensiveis):

```text
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/VALIDACAO-HML-DO-CLIENTE.yaml
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/RELATORIO-DE-VALIDACAO-DO-CLIENTE.md
```

Controles de execucao da etapa (quando aplicavel):

```text
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-05.yaml
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

## Como testar

A resposta final deve comprovar:

- consumo valido da instalacao materializada do Passo 04 e dos criterios de aceite do Passo 03;
- cada criterio de aceite coberto por ao menos um cenario, com resultado esperado x observado;
- validacao funcional conduzida por operador humano, sem automacao de navegador;
- nenhum cenario `CRITICO` em `REPROVADO`, `PENDENTE`, `PENDENTE_DE_EVIDENCIA` ou `BLOQUEADO` quando `PRONTO_PARA_PRODUCAO` for `SIM`;
- ausencia de segredo persistido e de qualquer escrita em producao;
- encerramento com `AUDITORIA: AGUARDANDO_INDEPENDENTE` e `STATUS_DA_ETAPA: PENDENTE`.

## Como interpretar falhas

| Classificacao | Encaminhamento |
| --- | --- |
| `PASSO_04_INVALIDO` | Bloquear o Passo 05 e retornar ao Passo 04. |
| `FALHA_FUNCIONAL_DO_CENARIO` | Registrar no proprio Passo 05; nao corrigir upstream silenciosamente. |
| `FALHA_TECNICA_DE_MATERIALIZACAO` | Retornar ao Passo 04. |
| `DIVERGENCIA_DE_PROJETO` | Retornar ao Passo 03. |
| `CAPACIDADE_ERP_INCORRETA_OU_INSUFICIENTE` | Retornar ao Passo 02. |
| `BUG_NA_INTEGRACAO_GENERICA` | Encaminhar ao ERP Parceiro (menor passo responsavel, tipicamente o Passo 06); nao corrigir codigo aqui. |
| `BUG_OU_DIVERGENCIA_DA_FERRAMENTA` / `CONTRATO_DA_FERRAMENTA_DIVERGENTE` | Encaminhar a jornada responsavel. |

## Status, auditoria e quando continuar

Esta e a primeira validacao real da jornada ERP Cliente para uma combinacao. Conforme `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`, a primeira execucao real de uma combinacao exige auditoria independente `PROFUNDA`, separada da execucao produtora.

A execucao produtora sempre encerra com:

```text
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS_DA_ETAPA: PENDENTE
PRONTO_PARA_PRODUCAO: NAO
```

Somente apos a auditoria independente `PROFUNDA` aprovada, esses controles podem avancar para:

```text
AUDITORIA: APROVADA
STATUS_DA_ETAPA: CONCLUIDA
PRONTO_PARA_PRODUCAO: SIM
```

Com `PRONTO_PARA_PRODUCAO: SIM`, a proxima etapa permitida e o Passo 06 da jornada ERP cliente: `comece-aqui/integrar-erp/erp-cliente/06-GO-LIVE-E-VALIDAR-PRODUCAO.md`.

## Proximo documento

A jornada ERP cliente possui o roteiro completo de 6 passos liberado nesta publicacao.
