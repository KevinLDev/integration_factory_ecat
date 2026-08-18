# 04 - Materializar instalacao do cliente em HML

## Quando usar

Use esta etapa quando o Passo 03 da combinacao estiver concluido, com `PLANO_DE_INSTALACAO_CONSOLIDADO: SIM` e `PRONTO_PARA_MATERIALIZACAO_EM_HML: SIM`, e houver autorizacao explicita do operador para escrever no ambiente de HML deste cliente.

Antes de executar, consultar:

- `documentacao/17-VALIDACAO-TECNICA-DE-INTEGRACOES-EM-HML.md` (padrao de execucao segura em HML usado como referencia para esta etapa);
- `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`;
- `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`.

## Objetivo

Responder com seguranca:

- o que foi projetado no Passo 03 (configuracao, de-para, extensao, plano de ativacao) realmente foi criado e confirmado no ambiente de HML deste cliente?
- o que ficou pendente, divergente ou bloqueado durante a materializacao?

Resultado esperado da execucao produtora (a etapa nunca se autoaprova):

```text
MATERIALIZACAO: COMPLETA | PARCIAL_JUSTIFICADA | INSUFICIENTE | BLOQUEADA
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS_DA_ETAPA: PENDENTE
PRONTO_PARA_VALIDACAO_HML: NAO
```

Somente apos auditoria independente `PROFUNDA` aprovada esses controles podem avancar para `AUDITORIA: APROVADA`, `STATUS_DA_ETAPA: CONCLUIDA` e `PRONTO_PARA_VALIDACAO_HML: SIM`.

## Fronteira do Passo 04

Esta etapa nao pode:

- reprojetar, redesenhar ou reclassificar qualquer item do Passo 02/03 (se o plano estiver desatualizado, retornar ao Passo 03, nao decidir aqui);
- alterar o contrato homologado da ferramenta nem o core da integracao publicada;
- escrever em ambiente de producao sob qualquer circunstancia;
- persistir credencial ou segredo real em qualquer artefato, log, relatorio ou resposta ao operador;
- validar funcionalmente o resultado (isso pertence ao futuro Passo 05);
- autoaprovar-se: a conclusao formal da etapa depende de auditoria independente `PROFUNDA`, por ser a primeira execucao real desta combinacao de cliente.

## Nota sobre o roteiro completo da jornada

```text
01 Resolver contexto do cliente          [liberado, commitado]
02 Analisar realidade comercial/tecnica  [liberado]
03 Projetar instalacao                   [liberado, somente projeto]
04 Materializar instalacao em HML        [este documento]
05 Validar HML + preparar producao       [futuro]
06 Go-live + validar producao + memoria  [futuro]
```

Os Passos 05 e 06 continuam nao liberados.

## Pre-requisitos

- Passo 03 concluido, com `PLANO_DE_INSTALACAO_CONSOLIDADO: SIM` e `PRONTO_PARA_MATERIALIZACAO_EM_HML: SIM`;
- plano do Passo 03 vigente (sem divergencia relevante nas fontes usadas desde a projecao);
- ambiente de HML do cliente identificado e autorizado;
- autorizacao explicita do operador para materializar aquele plano, naquele ambiente, para aquele cliente.

## O que voce precisa ter

- referencia ao plano de instalacao do Passo 03 para esta combinacao;
- ambiente de HML autorizado e credenciais de HML disponibilizadas por um canal seguro (variavel de ambiente, secret store) -- nunca coladas no prompt.

Nao envie secrets no prompt.

## O que voce nao precisa fazer manualmente

- redesenhar configuracao, de-para ou extensao;
- decidir idempotencia manualmente;
- criar manifesto/checkpoint manualmente;
- disparar a auditoria independente -- ela e uma execucao separada, somente leitura.

## O que a IA fara

1. Carregar a saida valida do Passo 03 (plano de instalacao) e verificar vigencia contra as fontes do Passo 02 e a release publicada.
2. Validar o ambiente (HML, homologacao, sandbox, teste ou DEV autorizado -- nunca producao) e a autorizacao explicita do operador.
3. Registrar um fingerprint nao sensivel do ambiente antes da primeira escrita.
4. Para cada item do plano dentro do escopo: consultar existencia por correlacao antes de escrever, criar ou atualizar somente o que faltar, reconsultar apos a escrita para confirmar.
5. Classificar cada item (`ESCRITA_CONFIRMADA`, `REUTILIZADO_EXISTENTE`, `DIVERGENTE_APOS_RECONSULTA`, `FALHOU_NA_ESCRITA`, `FALHOU_NA_RECONSULTA`, `NAO_APLICAVEL`).
6. Preservar sucessos parciais sem rollback destrutivo automatico em caso de falha.
7. Gerar os artefatos obrigatorios da etapa.
8. Encerrar com `AUDITORIA: AGUARDANDO_INDEPENDENTE` -- a execucao produtora nunca se autoaprova.

## Politica de ambiente

Escrita permitida somente em HML, homologacao, sandbox, teste ou DEV autorizado do cliente. Producao nunca e ambiente padrao nem fallback desta etapa. Nao confiar apenas no texto da URL; se houver duvida sobre o ambiente ser producao, bloquear.

## Politica de autorizacao

Credencial disponivel nao equivale a autorizacao processual. Exigir autorizacao explicita do operador antes da primeira escrita, especifica para cliente, combinacao, ambiente e plano vigente. Nao reutilizar autorizacao silenciosamente para outro plano ou ambiente.

## Politica de credenciais

Credenciais reais de HML podem ser recebidas e usadas de forma transitoria durante a execucao. Proibido: reproduzir segredo, persistir segredo em Git, registrar segredo em relatorio/artefato/checkpoint, devolver segredo ao operador. Preferir variavel de ambiente, secret store ou arquivo local ignorado.

## Idempotencia

Executar o Passo 04 duas vezes nao pode duplicar configuracao do cliente. Buscar existencia por correlacao antes de qualquer escrita.

## Rotas de saida

- materializacao completa ou parcial justificada, sem pendencia bloqueante -> auditoria independente `PROFUNDA` do Passo 04; apos aprovacao, ERP Cliente Passo 05 (quando liberado);
- pendencia bloqueante identificada durante a materializacao -> permanece `BLOQUEADO`, registra pendencia;
- plano do Passo 03 desatualizado ou divergente -> retorna ao Passo 03 para revalidacao minima;
- gap de release ou de ferramenta ainda aberto para item critico -> jornada responsavel.

## O que mandar para o chat

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-CLIENTE-04-MATERIALIZAR-INSTALACAO-EM-HML.md

Objetivo:
Materializar em HML somente o que o Passo 03 projetou para esta combinacao de cliente.

Cliente informado:
[nome ou identificador conhecido]

ERP informado:
[nome do ERP]

Ferramenta E-Catalogos desejada:
[nome da ferramenta]

Ambiente de HML autorizado:
[identificacao do ambiente, sem credencial no prompt]

Regras obrigatorias:
- nao reprojetar nem reclassificar nenhum item do Passo 02/03;
- materializar somente o que o plano do Passo 03 definiu;
- nao usar producao sob nenhuma circunstancia;
- nao persistir segredo em nenhum artefato;
- confirmar cada escrita por reconsulta antes de declarar sucesso;
- nao se autoaprovar -- encerrar com AUDITORIA: AGUARDANDO_INDEPENDENTE.

Descubra automaticamente a saida valida do Passo 03 para esta combinacao.

Gere somente os artefatos de materializacao do Passo 04.
Finalize com o gate completo da etapa.

Nao faca commit.
Nao faca push.
```

### PARE DE COPIAR AQUI

## Exemplo preenchido

```text
Execute integralmente:
parceiros/comandos/ERP-CLIENTE-04-MATERIALIZAR-INSTALACAO-EM-HML.md

Objetivo:
Materializar em HML o plano de instalacao do Cliente Exemplo para a combinacao ERP Exemplo x Ferramenta Exemplo, aprovado no Passo 03.

Cliente informado:
Cliente Exemplo Ltda. (ficticio)

ERP informado:
ERP Exemplo

Ferramenta E-Catalogos desejada:
Ferramenta Exemplo

Ambiente de HML autorizado:
Ambiente HML do Cliente Exemplo (credenciais fornecidas fora do prompt, via variavel de ambiente)

Regras obrigatorias:
- materializar somente o que o Passo 03 projetou;
- nao usar producao;
- nao persistir segredo;
- confirmar cada escrita por reconsulta;
- encerrar com AUDITORIA: AGUARDANDO_INDEPENDENTE.

Nao faca commit.
Nao faca push.
```

Este exemplo e ilustrativo. Ele nao substitui a autorizacao explicita nem a disponibilizacao segura de credenciais reais exigidas antes de qualquer escrita real.

## Artefatos esperados

Memoria canonica do cliente (sem dados reais sensiveis):

```text
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/INSTALACAO-MATERIALIZADA-DO-CLIENTE.yaml
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/RELATORIO-DE-MATERIALIZACAO-DO-CLIENTE.md
```

Controles de execucao da etapa (quando aplicavel):

```text
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-04.yaml
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

## Como testar

A resposta final deve comprovar:

- consumo valido do plano do Passo 03, sem reprojetar nem reclassificar nada;
- ambiente resolvido como HML/homologacao/sandbox/teste, nunca producao;
- autorizacao explicita registrada antes da primeira escrita;
- cada item materializado com classificacao e reconsulta de confirmacao;
- idempotencia comprovada (reexecucao nao duplica);
- ausencia de segredo persistido e de qualquer escrita em producao;
- encerramento com `AUDITORIA: AGUARDANDO_INDEPENDENTE` e `STATUS_DA_ETAPA: PENDENTE`.

## Como interpretar falhas

| Classificacao | Encaminhamento |
| --- | --- |
| `PASSO_03_INVALIDO` ou `PLANO_POTENCIALMENTE_OBSOLETO` | Bloquear o Passo 04 e retornar ao Passo 03 para revalidacao minima. |
| `AMBIENTE_NAO_AUTORIZADO` ou `DUVIDA_DE_PRODUCAO` | Bloquear toda escrita ate confirmar ambiente. |
| `AUTORIZACAO_AUSENTE` | Bloquear; nao iniciar escrita sem autorizacao explicita do operador. |
| `FALHOU_NA_ESCRITA` | Registrar pendencia no item, preservar sucessos ja confirmados, nao aplicar rollback destrutivo automatico. |
| `DIVERGENTE_APOS_RECONSULTA` | Registrar como pendencia bloqueante do item; nao declarar sucesso. |
| `GAP_DA_RELEASE` ou `GAP_DA_FERRAMENTA` ainda aberto | Encaminhar a jornada responsavel; nao bloqueia o restante quando o item ja estava fora de escopo desde o Passo 03. |

## Status, auditoria e quando continuar

Esta e a primeira execucao real de escrita da jornada ERP Cliente para uma combinacao. Conforme `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`, a primeira execucao real de uma combinacao exige auditoria independente `PROFUNDA`, separada da execucao produtora.

A execucao produtora sempre encerra com:

```text
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS_DA_ETAPA: PENDENTE
PRONTO_PARA_VALIDACAO_HML: NAO
```

Somente apos a auditoria independente `PROFUNDA` aprovada, esses controles podem avancar para:

```text
AUDITORIA: APROVADA
STATUS_DA_ETAPA: CONCLUIDA
PRONTO_PARA_VALIDACAO_HML: SIM
```

Com `PRONTO_PARA_VALIDACAO_HML: SIM`, a proxima etapa permitida sera o Passo 05 da jornada ERP cliente quando esse passo for oficialmente liberado.

## Proximo documento

A jornada ERP cliente segue em evolucao. Os Passos 01, 02, 03 e 04 estao liberados nesta publicacao. Os Passos 05 e 06 permanecem futuros: validacao em HML/preparacao para producao e go-live/registro de memoria.
