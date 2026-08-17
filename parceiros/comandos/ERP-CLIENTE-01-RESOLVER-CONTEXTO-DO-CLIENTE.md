# ERP Cliente - Passo 01 - Resolver contexto do cliente e elegibilidade de reutilizacao

## Finalidade

Resolver contexto e roteamento da jornada cliente sem executar analise profunda, sem materializar instalacao e sem executar HML/producao.

## Doutrina obrigatoria

Antes de executar, ler integralmente:

- `AGENTS.md` e `parceiros/AGENTS.md`;
- `comece-aqui/00-COMECE-AQUI.md`;
- `comece-aqui/integrar-erp/00-COMECE-AQUI.md`;
- `comece-aqui/integrar-erp/ERPS-INTEGRADOS.md`;
- `comece-aqui/integrar-erp/erp-cliente/00-COMECE-AQUI.md`;
- `documentacao/03-COMO-FUNCIONAM-AS-ETAPAS.md`;
- `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`;
- `documentacao/10-IA-DE-APOIO-DA-FABRICA.md`;
- `documentacao/11-MEMORIA-DE-ERPS-E-COMBINACOES.md`;
- `documentacao/19-PUBLICACAO-DE-INTEGRACOES-HOMOLOGADAS.md`;
- `parceiros/00-GUIA-DE-EXECUCAO.md`;
- `parceiros/01-COMO-USAR-OS-COMANDOS.md`;
- `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`;
- `parceiros/modelos/MANIFESTO-DA-ETAPA.yaml`;
- `parceiros/modelos/CHECKPOINT-DA-EXECUCAO.yaml`;
- modelos em `parceiros/modelos/erp-cliente/`.

## Gate de entrada obrigatorio

Resolver e registrar:

```text
CLIENTE_IDENTIFICADO: SIM | NAO | IDENTIDADE_AMBIGUA
ERP_IDENTIFICADO: SIM | NAO | IDENTIDADE_AMBIGUA
FERRAMENTA_IDENTIFICADA: SIM | NAO | IDENTIDADE_AMBIGUA
FERRAMENTA_HOMOLOGADA: SIM | NAO
COMBINACAO_ERP_FERRAMENTA_EXISTE: SIM | NAO
INTEGRACAO_PUBLICADA: SIM | NAO
DISPONIVEL_PARA_CLIENTE: SIM | NAO
RELEASE_ELEGIVEL: SIM | NAO | INDETERMINADA
```

Sem esse gate, nao avancar para rota de cliente.

## Auto-descoberta obrigatoria

Antes de perguntar ao operador, descobrir automaticamente:

1. identidade canonica do cliente (nome e slug futuro), ERP e ferramenta;
2. memoria existente do cliente e execucoes anteriores para evitar duplicidade;
3. memoria do ERP e da combinacao ERP x ferramenta;
4. status da combinacao (homologada/publicada/disponivel para cliente);
5. release, versao, lifecycle, capacidades e restricoes publicados;
6. contrato de configuracao e referencias tecnicas canonicas;
7. vigencia/integridade verificavel mecanicamente;
8. inventario de materiais recebidos.

Solicitar ao operador somente dados realmente ausentes para resolver contexto.

## Inventario de materiais (sem analise profunda)

Registrar no minimo:

- swagger/openapi: `RECEBIDO | NAO_RECEBIDO | NAO_APLICAVEL`;
- documentacao: `RECEBIDO | NAO_RECEBIDO | NAO_APLICAVEL`;
- regras_negocio: `RECEBIDO | NAO_RECEBIDO | NAO_APLICAVEL`;
- exemplos_payload: `RECEBIDO | NAO_RECEBIDO | NAO_APLICAVEL`;
- customizacoes: `RECEBIDO | NAO_RECEBIDO | NAO_APLICAVEL`;
- credencial_hml: `PRESENTE | AUSENTE | NAO_APLICAVEL`;
- outros_materiais: `RECEBIDO | NAO_RECEBIDO | NAO_APLICAVEL`.

Credencial pode ser marcada como presente, mas nunca persistida em valor real.

## Politica nao inventar

Se houver ambiguidade de cliente, ERP, ferramenta, combinacao, release ou versao:

- nao inferir como fato;
- registrar pendencia objetiva;
- bloquear somente o que depender da ambiguidade.

Ausencia de evidencia nunca vira confirmacao.

## Fronteira obrigatoria

Este Passo 01 nao pode:

- executar Passo 02;
- fazer analise comercial profunda;
- projetar instalacao;
- propor de-para definitivo;
- propor extensao/customizacao;
- executar HML;
- executar producao;
- usar credenciais reais.

## Rotas de saida obrigatorias

- `CLIENTE+ERP+FERRAMENTA+RELEASE_ELEGIVEL` -> `ERP_CLIENTE_02`;
- `ERP_DESCONHECIDO` -> `ERP_PARCEIRO_MENOR_PASSO`;
- `FERRAMENTA_DESCONHECIDA` -> `NOVA_FERRAMENTA`;
- `FERRAMENTA_NAO_HOMOLOGADA` -> `CONCLUIR_JORNADA_FERRAMENTA`;
- `COMBINACAO_HOMOLOGADA_NAO_PUBLICADA` -> `ERP_PARCEIRO_09`;
- `COMBINACAO_NAO_EXISTE` -> `ERP_PARCEIRO_MENOR_PASSO`;
- `RELEASE_PUBLICADA_NAO_VIGENTE` -> `BLOQUEADA_COM_ROTEAMENTO`.

## Checkpoint, resume e idempotencia

- Retomar o mesmo contexto quando cliente+ERP+ferramenta coincidirem;
- incorporar apenas delta de materiais novos;
- preservar evidencias vigentes;
- evitar fluxo duplicado para mesma chave de contexto.

## Artefatos de uma execucao real

Memoria canonica do cliente:

```text
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/CONTEXTO-DO-CLIENTE.yaml
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/INVENTARIO-DE-MATERIAIS.yaml
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/RELATORIO-DE-RESOLUCAO-DE-CONTEXTO.md
```

Controle de execucao:

```text
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-01.yaml
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

## Gate de saida da execucao produtora

```text
CONTEXTO_CLIENTE: RESOLVIDO | NAO_RESOLVIDO
RELEASE_REUTILIZAVEL: SIM | NAO
ELEGIVEL_PARA_JORNADA_CLIENTE: SIM | NAO
PENDENCIAS_PARA_PASSO_02: SIM | NAO
STATUS_DA_ETAPA: CONCLUIDA | PENDENTE | BLOQUEADA
PROXIMO_PASSO: ERP_CLIENTE_02 | ERP_PARCEIRO_<NN> | NOVA_FERRAMENTA_<NN> | BLOQUEADA
HML_EXECUTADA: NAO
PRODUCAO_EXECUTADA: NAO
SEGREDO_PERSISTIDO: NAO
```

## Auditoria

Padrao:

```text
AUDITORIA_INDEPENDENTE_OBRIGATORIA: NAO
```

Excecoes para exigencia de auditoria independente:

- conflito relevante de identidade;
- contradicao estrutural entre fontes;
- risco de roteamento incorreto com impacto de etapa.

## Como chamar

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-CLIENTE-01-RESOLVER-CONTEXTO-DO-CLIENTE.md

Materialize somente o Passo 01 da jornada ERP Cliente:
RESOLVER CONTEXTO DO CLIENTE E ELEGIBILIDADE DE REUTILIZACAO.

Intencao do operador:
[texto livre]

Cliente:
[identificacao conhecida]

ERP:
[erp informado]

Ferramenta E-Catalogos:
[ferramenta informada]

Ambiente pretendido (se houver):
[HML | HOMOLOGACAO | TESTE | PRODUCAO | NAO_INFORMADO]

Materiais enviados:
[listar anexos/caminhos e tipo]

Regras obrigatorias:
- nao executar Passo 02;
- nao fazer analise comercial profunda;
- nao usar credenciais reais;
- nao executar HML;
- nao executar producao;
- nao inventar dados ausentes;
- inventariar materiais sem analisar profundamente.

Procure memoria existente, ferramenta, ERP, combinacao, release, vigencia e rota.
Finalize com status, pendencias e proximo passo permitido.

Nao faca commit.
Nao faca push.
```

### PARE DE COPIAR AQUI