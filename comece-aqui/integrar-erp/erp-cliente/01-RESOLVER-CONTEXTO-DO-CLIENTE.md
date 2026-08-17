# 01 - Resolver contexto do cliente e elegibilidade de reutilizacao

## Quando usar

Use esta etapa quando um cliente real precisa integrar um ERP a uma ferramenta E-Catalogos e a Fabrica precisa decidir, com evidencia, se existe release publicada elegivel para reutilizacao.

Antes de executar, consultar:

`documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`

## Objetivo

Responder com seguranca:

- quem e o cliente;
- qual ERP utiliza;
- qual ferramenta E-Catalogos deseja;
- quais materiais foram recebidos;
- se a combinacao ERP x ferramenta possui release publicada, vigente e elegivel para reutilizacao.

Resultado esperado da etapa:

```text
CONTEXTO_CLIENTE: RESOLVIDO | NAO_RESOLVIDO
RELEASE_REUTILIZAVEL: SIM | NAO
ELEGIVEL_PARA_JORNADA_CLIENTE: SIM | NAO
PROXIMO_PASSO: ERP_CLIENTE_02 | ERP_PARCEIRO_<NN> | NOVA_FERRAMENTA_<NN> | BLOQUEADA
```

## Fronteira da etapa

Esta etapa nao pode:

- executar analise comercial profunda do cliente;
- mapear campo a campo da instalacao do cliente;
- projetar instalacao, de-para ou extensao;
- desenvolver integracao;
- usar credenciais reais;
- executar HML;
- executar producao.

Esses itens pertencem aos passos posteriores.

## Pre-requisitos

- intencao do operador de integrar um cliente;
- identificacao inicial de cliente, ERP e ferramenta (mesmo que parcial);
- materiais tecnicos recebidos quando existirem.

## O que voce precisa ter

- identificacao minima do cliente;
- ERP informado pelo operador;
- ferramenta desejada;
- materiais disponiveis (Swagger, docs, exemplos, regras, customizacoes, etc.), quando houver.

Nao envie secrets no prompt.

## O que voce nao precisa fazer manualmente

- decidir jornada/etapa interna da Fabrica;
- localizar release publicada na estrutura tecnica;
- montar manifesto/checkpoint manualmente;
- criar rotas de fallback manualmente;
- indicar qual passo interno deve rodar.

## O que a IA fara

1. Resolver identidade de cliente, ERP e ferramenta sem inventar dados.
2. Verificar ferramenta conhecida e homologada.
3. Verificar ERP conhecido e memoria reutilizavel existente.
4. Verificar combinacao ERP x ferramenta e status de publicacao.
5. Verificar elegibilidade da release (status, auditoria, lifecycle e vigencia quando verificavel).
6. Inventariar materiais recebidos sem fazer analise profunda do conteudo.
7. Registrar pendencias bloqueantes e nao bloqueantes.
8. Decidir rota de saida para Passo 02 cliente ou retorno ao menor responsavel.
9. Persistir contexto e relatorio sem segredos.

## Rotas de saida

- cliente + ERP + ferramenta + release publicada elegivel -> ERP Cliente Passo 02;
- ERP desconhecido -> jornada ERP parceiro no menor passo apropriado;
- ferramenta desconhecida -> jornada nova ferramenta;
- ferramenta conhecida mas nao homologada -> concluir jornada da ferramenta;
- combinacao homologada e nao publicada -> ERP parceiro Passo 09;
- combinacao inexistente -> ERP parceiro no menor passo apropriado;
- release publicada sem vigencia/elegibilidade -> bloquear e encaminhar conforme causa.

## O que mandar para o chat do Copilot

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-CLIENTE-01-RESOLVER-CONTEXTO-DO-CLIENTE.md

Objetivo:
Resolver somente o contexto do cliente e a elegibilidade de reutilizacao da release.

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
- customizacoes: [SIM | NAO]
- credencial hml: [PRESENTE | AUSENTE | NAO_APLICAVEL]
- outros: [listar ou NA]

Regras obrigatorias:
- nao executar Passo 02;
- nao fazer analise comercial profunda;
- nao usar credencial real;
- nao executar HML;
- nao executar producao;
- nao inventar campos, equivalencias, versao ou release.

Descubra automaticamente memoria existente, ferramenta, ERP, combinacao, release e vigencia.

Gere somente artefatos de contexto do Passo 01.
Finalize com status, rota e proximo passo permitido.

Nao faca commit.
Nao faca push.
```

### PARE DE COPIAR AQUI

## Artefatos esperados

Contexto canonico do cliente (sem dados reais sensiveis):

```text
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/CONTEXTO-DO-CLIENTE.yaml
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/INVENTARIO-DE-MATERIAIS.yaml
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/RELATORIO-DE-RESOLUCAO-DE-CONTEXTO.md
```

Controles de execucao da etapa (quando aplicavel):

```text
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-01.yaml
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

## Como testar

A resposta final deve comprovar:

- identidade resolvida sem ambiguidade ou pendencia explicita;
- ferramenta resolvida e homologacao verificada;
- ERP resolvido e memoria localizada quando existente;
- combinacao e release resolvidas com estado e vigencia;
- inventario de materiais preenchido sem analise profunda;
- rota de saida explicita;
- ausencia de segredo persistido.

## Como interpretar falhas

| Classificacao | Encaminhamento |
| --- | --- |
| `CLIENTE_NAO_IDENTIFICAVEL` | Bloquear Passo 01 e solicitar dado minimo de identidade. |
| `ERP_DESCONHECIDO` | Encaminhar para ERP parceiro (menor passo aplicavel). |
| `FERRAMENTA_DESCONHECIDA` | Encaminhar para jornada de nova ferramenta. |
| `FERRAMENTA_NAO_HOMOLOGADA` | Encaminhar para conclusao da jornada da ferramenta. |
| `COMBINACAO_NAO_EXISTE` | Encaminhar para ERP parceiro (menor passo aplicavel). |
| `COMBINACAO_NAO_PUBLICADA` | Encaminhar para ERP parceiro Passo 09. |
| `RELEASE_NAO_VIGENTE` | Bloquear e encaminhar conforme causa da vigencia. |

## Status, auditoria e quando continuar

A etapa termina com `CONCLUIDA`, `PENDENTE` ou `BLOQUEADA`.

Para resolucao simples de contexto, a regra padrao e:

```text
AUDITORIA_INDEPENDENTE_OBRIGATORIA: NAO
```

A auditoria independente pode ser exigida quando houver ambiguidade estrutural, evidencia contraditoria relevante ou risco de roteamento incorreto.

Com `CONTEXTO_CLIENTE: RESOLVIDO` e `ELEGIVEL_PARA_JORNADA_CLIENTE: SIM`, a proxima etapa permitida e o Passo 02 da jornada ERP cliente quando esse passo for oficialmente liberado.

## Proximo documento

A jornada ERP cliente segue em evolucao. Somente o Passo 01 esta liberado nesta publicacao.