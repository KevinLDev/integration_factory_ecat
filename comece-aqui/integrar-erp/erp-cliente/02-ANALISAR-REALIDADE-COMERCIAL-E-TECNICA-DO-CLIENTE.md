# 02 - Analisar realidade comercial e tecnica do cliente

## Quando usar

Use esta etapa quando o Passo 01 da jornada ERP Cliente estiver concluido e a Fabrica precisar analisar, com evidencia, a realidade comercial e tecnica do cliente para a combinacao ERP x ferramenta ja publicada.

Antes de executar, consultar:

`documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`

## Objetivo

Responder com seguranca:

- o que o cliente possui no ERP real para a combinacao publicada;
- o que o cliente utiliza hoje;
- o que ja esta suportado e pode ficar pronto para ativacao futura;
- quais configuracoes, de-paras, extensoes, gaps, pendencias e bloqueios existem;
- se ja existe base suficiente para projetar a instalacao no Passo 03.

Resultado esperado da etapa:

```text
ANALISE_CLIENTE: CONCLUIDA | PARCIAL | BLOQUEADA
MATRIZ_COMERCIAL_CONSOLIDADA: SIM | PARCIAL | NAO
PENDENCIAS_BLOQUEANTES: SIM | NAO
APTO_PARA_PROJETAR_INSTALACAO: SIM | NAO
PROXIMO_PASSO: ERP_CLIENTE_03 | ERP_PARCEIRO_<NN> | NOVA_FERRAMENTA_<NN> | BLOQUEADA
```

## Fronteira da etapa

Esta etapa nao pode:

- projetar a instalacao final do cliente;
- materializar configuracao real;
- implementar de-para real;
- implementar extensao real;
- desenvolver integracao;
- usar credenciais reais;
- executar HML;
- executar producao.

Esses itens pertencem aos passos posteriores ou a outras jornadas.

## Pre-requisitos

- Passo 01 concluido com contexto resolvido e release elegivel;
- identificacao resolvida de cliente, ERP, ferramenta e combinacao;
- release publicada localizada com versao, contrato de configuracao e referencias tecnicas;
- materiais do cliente disponiveis quando existirem.

## O que voce precisa ter

- identificacao do cliente resolvida pelo Passo 01;
- ERP e ferramenta resolvidos;
- materiais disponiveis para analise (Swagger, docs, exemplos, layouts, regras, customizacoes, middleware, etc.), quando houver.

Nao envie secrets no prompt.

## O que voce nao precisa fazer manualmente

- localizar a memoria do ERP, da combinacao ou da release publicada;
- decidir sozinho se algo e configuracao, de-para, extensao ou gap;
- criar manifesto/checkpoint manualmente;
- montar a matriz comercial na mao;
- decidir o menor passo responsavel sem evidencia.

## O que a IA fara

1. Carregar a saida valida do Passo 01.
2. Carregar memoria do ERP, da combinacao e da release publicada.
3. Analisar materiais do cliente sem sobrescrever memoria generica silenciosamente.
4. Construir a matriz comercial do cliente por capacidade.
5. Distinguir cliente possui versus cliente usa atualmente.
6. Identificar capacidades ativas e prontas para ativacao futura.
7. Identificar configuracoes, de-paras, extensoes, gaps, pendencias e bloqueios.
8. Registrar divergencias de evidencia e middleware/API customizada quando existirem.
9. Preparar o handoff para o Passo 03 sem implementar a instalacao.

## Status obrigatorios e invariantes de classificacao

Os status de cada capacidade devem seguir obrigatoriamente as seguintes invariantes. Violá-las torna a analise invalida.

### ATIVO

Somente pode ser atribuido quando **toda** a cadeia estiver **comprovada**:

- `ferramenta_ecat_suporta = SIM`
- `erp_suporta = SIM`
- `release_publicada_suporta = SIM`
- `cliente_possui = SIM`
- `cliente_usa_atualmente = SIM`
- realidade do cliente e compativel com a semantica exigida
- sem GAP_DA_RELEASE impeditivo
- sem GAP_DA_FERRAMENTA impeditivo
- sem pendencia bloqueante da capacidade
- evidencias suficientes para sustentar a classificacao

`INDETERMINADO` em qualquer componente obrigatorio **proibe** `ATIVO`. Usar `PENDENTE_DE_EVIDENCIA`.

### PRONTO_PARA_ATIVACAO

Somente pode ser atribuido quando:

- `ferramenta_ecat_suporta = SIM`
- `erp_suporta = SIM`
- `release_publicada_suporta = SIM`
- a realidade do cliente possui ou pode receber a capacidade sem desenvolvimento generico novo
- `cliente_usa_atualmente = NAO`
- sem GAP_DA_RELEASE impeditivo
- sem GAP_DA_FERRAMENTA impeditivo
- sem dependencia sem evidencia que impeca a ativacao futura
- evidencias suficientes de toda a cadeia relevante

`PRONTO_PARA_ATIVACAO` **nao significa** simplesmente "cliente nao usa hoje". `INDETERMINADO` em qualquer suporte obrigatorio **proibe** este status. Usar `PENDENTE_DE_EVIDENCIA`.

### NAO_SUPORTADO

Somente pode ser atribuido quando existir **evidencia negativa suficiente**:

- contrato da ferramenta prova ausencia da capacidade; ou
- documentacao ou API do ERP prova ausencia; ou
- release publicada declara explicitamente capacidade nao suportada; ou
- restricao comprovada impede a capacidade no contexto especifico.

**Proibido**:

- "nao encontrei documentacao" → `NAO_SUPORTADO` (PROIBIDO)
- "campo nao apareceu no exemplo" → `NAO_SUPORTADO` (PROIBIDO)
- "nome equivalente nao foi localizado" → `NAO_SUPORTADO` (PROIBIDO)
- "ausencia de prova de suporte" → `NAO_SUPORTADO` (PROIBIDO)

Sem evidencia negativa suficiente: `PENDENTE_DE_EVIDENCIA`.

### PENDENTE_DE_EVIDENCIA

**Obrigatorio** quando uma decisao depende de informacao ainda nao comprovada:

- `ferramenta_ecat_suporta = INDETERMINADO`
- `erp_suporta = INDETERMINADO`
- `release_publicada_suporta = INDETERMINADO`
- `cliente_possui = INDETERMINADO`
- semantica relevante ainda nao comprovada
- middleware pode alterar comportamento e impacto ainda nao determinado
- fontes contraditorias ainda nao reconciliadas
- evidencia necessaria ausente

Desconhecido **nao vira falso automaticamente**. Ausencia de documentacao **nao prova ausencia da capacidade**. Nome parecido **nao prova semantica**.

## Regra de cobertura e classificacao

A cobertura comercial completa nao autoriza inventar capacidade. Quando a evidencia for insuficiente, usar `PENDENTE_DE_EVIDENCIA`. Para o conjunto completo de invariantes, ver a secao "Status obrigatorios e invariantes de classificacao" acima e o modelo `parceiros/modelos/erp-cliente/MODELO-MATRIZ-COMERCIAL-DO-CLIENTE.yaml`.

## Rotas de saida
- analise consolidada sem bloqueio critico -> ERP Cliente Passo 03;
- configuracao/de-para/extensao apenas identificados -> ERP Cliente Passo 03;
- gap generico de mapeamento -> ERP Parceiro Passo 05;
- gap generico de implementacao -> ERP Parceiro Passo 06;
- necessidade de prova tecnica generica -> ERP Parceiro Passo 07;
- necessidade de prova funcional generica -> ERP Parceiro Passo 08;
- nova release necessaria -> ERP Parceiro Passo 09;
- gap da ferramenta -> jornada da ferramenta;
- contexto/release invalido -> bloquear e retornar ao menor responsavel.

## O que mandar para o chat do Copilot

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-CLIENTE-02-ANALISAR-REALIDADE-COMERCIAL-E-TECNICA-DO-CLIENTE.md

Objetivo:
Analisar somente a realidade comercial e tecnica do cliente para a combinacao publicada e preparar a base decisoria do Passo 03.

Solicitacao do operador:
[descreva a intencao em linguagem natural]

Cliente informado:
[nome ou identificador conhecido]

ERP informado:
[nome do ERP]

Ferramenta E-Catalogos desejada:
[nome da ferramenta]

Ambiente pretendido (se informado):
[HML | HOMOLOGACAO | TESTE | PRODUCAO | NAO_INFORMADO]

Materiais fornecidos:
- swagger/openapi: [SIM | NAO]
- documentacao: [SIM | NAO]
- regras de negocio: [SIM | NAO]
- exemplos/payloads: [SIM | NAO]
- layouts/manuais: [SIM | NAO]
- customizacoes/middleware/api propria: [SIM | NAO]
- credencial hml: [PRESENTE | AUSENTE | NAO_APLICAVEL]
- outros: [listar ou NA]

Regras obrigatorias:
- nao executar Passo 03;
- nao usar credencial real;
- nao executar HML;
- nao executar producao;
- nao desenvolver integracao;
- nao materializar configuracao, de-para ou extensao real;
- nao inventar capacidade, semantica, release ou comportamento.

Descubra automaticamente a saida valida do Passo 01, a memoria do ERP, a release publicada, o contrato de configuracao e as capacidades comprovadas.

Analise a realidade do cliente com cobertura comercial completa, mesmo para capacidades que ele nao usa hoje, desde que ERP + ferramenta + release suportem.

Gere somente artefatos de analise do Passo 02.
Finalize com status, matriz, pendencias, bloqueios, rota e proximo passo permitido.

Nao faca commit.
Nao faca push.
```

### PARE DE COPIAR AQUI

## Artefatos esperados

Memoria canonica do cliente (sem dados reais sensiveis):

```text
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/MATRIZ-COMERCIAL-DO-CLIENTE.yaml
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/RELATORIO-DE-ANALISE-DO-CLIENTE.md
```

Controles de execucao da etapa (quando aplicavel):

```text
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-02.yaml
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

## Como testar

A resposta final deve comprovar:

- consumo valido da saida do Passo 01;
- reuso da memoria do ERP, da combinacao e da release publicada;
- matriz comercial preenchida por capacidade, sem virar decoracao;
- distincao entre cliente possui e cliente usa atualmente;
- classificacao de capacidades ativas, prontas para ativacao, nao suportadas ou pendentes de evidencia;
- identificacao de configuracoes, de-paras, extensoes, gaps, pendencias e bloqueios;
- ausencia de segredo persistido e de qualquer execucao real.

## Como interpretar falhas

| Classificacao | Encaminhamento |
| --- | --- |
| `PASSO_01_INVALIDO` | Bloquear o Passo 02 e retornar ao Passo 01. |
| `RELEASE_NAO_ELEGIVEL` | Bloquear o Passo 02 e encaminhar ao menor responsavel. |
| `GAP_DA_RELEASE` | Encaminhar ao menor passo ERP parceiro necessario. |
| `GAP_DA_FERRAMENTA` | Encaminhar a jornada responsavel pela ferramenta. |
| `DIVERGENCIA_DE_EVIDENCIA` | Registrar divergencia e encaminhar ao menor passo responsavel. |
| `PENDENTE_DE_EVIDENCIA` | Continuar com analise parcial segura e registrar a falta. |
| `BLOQUEIO_CRITICO` | Bloquear somente o escopo dependente e registrar a causa. |

## Status, auditoria e quando continuar

A etapa termina com `CONCLUIDA`, `PENDENTE` ou `BLOQUEADA`.

Para analise simples sem divergencia estrutural critica, a regra padrao e:

```text
AUDITORIA_INDEPENDENTE_OBRIGATORIA: NAO
```

A auditoria independente deve ser exigida quando a saida identificar qualquer combinacao de:

- `EXTENSAO_CLIENTE` bloqueante;
- `GAP_DA_RELEASE`;
- `GAP_DA_FERRAMENTA`;
- `DIVERGENCIA_DE_EVIDENCIA` com impacto de rota;
- classificacao critica que altere o proximo passo permitido.

Com `ANALISE_CLIENTE: CONCLUIDA`, `MATRIZ_COMERCIAL_CONSOLIDADA: SIM` e `APTO_PARA_PROJETAR_INSTALACAO: SIM`, a proxima etapa permitida e o Passo 03 da jornada ERP cliente: `comece-aqui/integrar-erp/erp-cliente/03-PROJETAR-INSTALACAO-DO-CLIENTE.md`.

## Proximo documento

A jornada ERP cliente segue em evolucao. Os Passos 01, 02 e 03 estao liberados nesta publicacao. Os Passos 04 a 06 permanecem futuros.
