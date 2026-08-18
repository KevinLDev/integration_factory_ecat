# ERP Cliente - Passo 02 - Analisar realidade comercial e tecnica do cliente

## Finalidade

Executar somente o Passo 02 da jornada ERP Cliente e transformar a saida valida do Passo 01, a release publicada e os materiais do cliente em uma analise comercial e tecnica rastreavel, segura e reutilizavel para o futuro Passo 03.

Este passo responde:

> Considerando o ERP real deste cliente, a ferramenta E-Catalogos escolhida e a release publicada reutilizavel, qual e a realidade comercial e tecnica desta empresa e como cada capacidade deve ser classificada antes de projetarmos a instalacao?

O resultado e analise, nao implementacao.

## Resultado oficial da sequencia

```text
PASSO 01 -> resolve contexto, release e elegibilidade
PASSO 02 -> analisa realidade comercial e tecnica do cliente
```

## Fronteira obrigatoria

O Passo 02 pode:

- ler a memoria ja persistida do cliente, do ERP, da combinacao e da release publicada;
- analisar materiais recebidos do cliente;
- comparar capacidades da ferramenta, do ERP, da release e do uso real do cliente;
- identificar configuracoes, de-paras, extensoes, gaps, pendencias, bloqueios e riscos;
- classificar middleware e API customizada do cliente quando existirem;
- gerar a matriz comercial do cliente e o relatorio de analise;
- executar validacoes locais, Harness e auditoria aplicavel.

O Passo 02 nao pode:

- criar instalacao final;
- implementar configuracao real;
- implementar de-para real;
- implementar extensao real;
- desenvolver codigo;
- usar credenciais reais;
- executar HML;
- executar producao;
- alterar release publicada.

## Instrucoes e doutrina obrigatorias

Antes de agir, ler integralmente:

- `AGENTS.md` da raiz e `AGENTS.md` aplicaveis;
- `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`;
- `documentacao/10-IA-DE-APOIO-DA-FABRICA.md`;
- `documentacao/11-MEMORIA-DE-ERPS-E-COMBINACOES.md`;
- `documentacao/13-PADRAO-GLOBAL-DE-MASSA-COMERCIAL.md`;
- `documentacao/15-MAPEAMENTO-SEMANTICO-DE-INTEGRACOES.md`;
- `documentacao/19-PUBLICACAO-DE-INTEGRACOES-HOMOLOGADAS.md`;
- `clientes/README.md`;
- documentos tecnicos e operacionais do Passo 01 e do Passo 09 aplicaveis.

Usar os modelos:

- `parceiros/modelos/erp-cliente/MODELO-MATRIZ-COMERCIAL-DO-CLIENTE.yaml`;
- `parceiros/modelos/erp-cliente/MODELO-RELATORIO-DE-ANALISE-DO-CLIENTE.md`.

## Invariantes de classificacao — OBRIGATORIAS

Aplicar antes de atribuir qualquer `status_capacidade`. Violacao torna a analise invalida.

### ATIVO

Somente permitido quando **todos** os componentes obrigatorios estiverem comprovados como SIM:

- `ferramenta_ecat_suporta = SIM`
- `erp_suporta = SIM`
- `release_publicada_suporta = SIM`
- `cliente_possui = SIM`
- `cliente_usa_atualmente = SIM`
- sem GAP_DA_RELEASE impeditivo
- sem GAP_DA_FERRAMENTA impeditivo
- evidencias suficientes

**ATIVO com qualquer suporte obrigatorio INDETERMINADO: PROIBIDO.**
Usar `PENDENTE_DE_EVIDENCIA`.

### PRONTO_PARA_ATIVACAO

Somente permitido quando:

- `ferramenta_ecat_suporta = SIM`
- `erp_suporta = SIM`
- `release_publicada_suporta = SIM`
- `cliente_usa_atualmente = NAO`
- sem GAP_DA_RELEASE impeditivo
- sem GAP_DA_FERRAMENTA impeditivo
- evidencias suficientes de toda a cadeia

**PRONTO_PARA_ATIVACAO com qualquer suporte obrigatorio INDETERMINADO: PROIBIDO.**
Nao significa apenas "cliente nao usa hoje".
Usar `PENDENTE_DE_EVIDENCIA`.

### NAO_SUPORTADO

Somente permitido com **evidencia negativa suficiente**:

- contrato da ferramenta prova ausencia; ou
- documentacao ou API do ERP prova ausencia; ou
- release publicada declara explicitamente capacidade nao suportada; ou
- restricao comprovada impede a capacidade no contexto.

**Estritamente proibido:**

- "nao encontrei documentacao" → `NAO_SUPORTADO` (PROIBIDO)
- "campo nao apareceu no exemplo" → `NAO_SUPORTADO` (PROIBIDO)
- "nome equivalente nao foi localizado" → `NAO_SUPORTADO` (PROIBIDO)
- ausencia de prova de suporte → `NAO_SUPORTADO` (PROIBIDO)

Sem evidencia negativa suficiente: `PENDENTE_DE_EVIDENCIA`.

### PENDENTE_DE_EVIDENCIA

Obrigatorio quando qualquer componente relevante estiver INDETERMINADO ou quando evidencia necessaria estiver ausente. Desconhecido **nao vira falso automaticamente**.

### Traducao obrigatoria: status da capacidade publicada (Passo 09) -> release_publicada_suporta (Passo 02)

O manifesto de publicacao da release (`MODELO-MANIFESTO-DA-INTEGRACAO-PUBLICADA.yaml`, `capacidades_publicadas[].status`) usa um vocabulario de 4 estados que nao e o mesmo vocabulario de `release_publicada_suporta`. Antes de preencher qualquer linha da matriz, traduzir exatamente assim, sem excecao:

```text
SUPORTADO               -> release_publicada_suporta = SIM
SUPORTADO_COM_RESTRICAO -> release_publicada_suporta = SIM
							(a(s) restricao(oes) declarada(s) na release e' obrigatorio
							herdar para o campo `restricoes` da capacidade nesta matriz)
NAO_SUPORTADO           -> release_publicada_suporta = NAO
NAO_APLICAVEL           -> a capacidade esta fora do escopo desta combinacao;
							nao criar linha para ela na matriz do cliente
```

Nao inferir esta traducao de outra forma. Se o manifesto de publicacao nao trouxer `status` para uma capacidade relevante, tratar como INDETERMINADO e aplicar a regra de `PENDENTE_DE_EVIDENCIA`.

## Gate de entrada obrigatorio

Resolver e retornar:

```text
PASSO_01_CONCLUIDO: SIM | NAO
CONTEXTO_CLIENTE_RESOLVIDO: SIM | NAO
RELEASE_REUTILIZAVEL: SIM | NAO
RELEASE_ELEGIVEL: SIM | NAO | INDETERMINADA
INTEGRACAO_PUBLICADA: SIM | NAO | INDETERMINADA
DISPONIVEL_PARA_CLIENTE: SIM | NAO | INDETERMINADA
VERSAO_RELEASE_RESOLVIDA: SIM | NAO
```

Sem esse gate, retornar ao menor responsavel.

## Resolucoes automaticas obrigatorias

Antes de perguntar qualquer coisa, o executor deve descobrir no repositorio:

1. cliente, ERP, ferramenta, slugs e combinacao ativa;
2. contexto, inventario e relatorio do Passo 01;
3. memoria geral do ERP e memoria da combinacao ERP x ferramenta;
4. manifesto da release publicada, contrato de configuracao, capacidades e restricoes comprovadas;
5. materiais do cliente e referencias tecnicas recebidas;
6. pendencias e decisoes humanas ja registradas;
7. eventuais checkpoints da propria analise do cliente.

Perguntar ao operador somente por evidencia realmente ausente e bloqueante.

## Hierarquia de autoridade

Para fatos tecnicos e comerciais, respeitar:

1. contrato homologado e regras da ferramenta E-Catalogos;
2. release publicada e contrato de configuracao da combinacao;
3. memoria geral comprovada do ERP;
4. materiais e evidencias especificos do cliente;
5. decisoes humanas explicitamente aprovadas.

O ERP do cliente e adaptado ao contrato homologado da ferramenta. A ferramenta nao deve ser deformada para caber numa particularidade do cliente sem rota explicita para a jornada responsavel.

## Processo obrigatorio

Executar na ordem:

1. validar contexto e gates do Passo 01;
2. carregar a release publicada e o contrato de configuracao;
3. carregar memoria do ERP e capacidades comprovadas da combinacao;
4. carregar materiais do cliente e classificacoes ja conhecidas;
5. listar as capacidades comerciais relevantes da combinacao;
6. analisar o que o cliente possui e o que usa atualmente;
7. distinguir capacidade ativa de capacidade pronta para ativacao futura;
8. identificar configuracoes do cliente permitidas pelo contrato publicado;
9. identificar de-paras especificos do cliente;
10. identificar extensoes controladas do cliente;
11. identificar gap da release;
12. identificar gap da ferramenta;
13. identificar divergencias de evidencia entre memoria generica e material do cliente;
14. classificar middleware ou API customizada quando existirem;
15. consolidar pendencias, bloqueios, restricoes, riscos e rotas;
16. gerar os outputs obrigatorios da etapa;
17. executar Harness/auditoria aplicaveis e retornar o gate.

## Regra de cobertura obrigatoria

Cobrir todas as capacidades comerciais relevantes que possam ser suportadas pela combinacao, nao apenas o que o cliente usa hoje.

Regra:

```text
ERP suporta
+ release suporta
+ ferramenta suporta
+ cliente ainda nao usa
-> PRONTO_PARA_ATIVACAO
```

Cobertura completa nao autoriza inventar capacidade. Quando a evidencia for insuficiente, usar `PENDENTE_DE_EVIDENCIA`.

## Matriz comercial do cliente

Cada linha da matriz deve permitir responder:

- ferramenta suporta;
- ERP suporta;
- release publicada suporta;
- cliente possui;
- cliente usa atualmente;
- esta configuravel sem mudar o core;
- requer de-para;
- requer extensao;
- existe gap;
- qual a decisao;
- qual a evidencia;
- qual a pendencia;
- qual a rota.

## Status obrigatorios

Usar, no minimo:

- `ATIVO`;
- `PRONTO_PARA_ATIVACAO`;
- `NAO_SUPORTADO`;
- `PENDENTE_DE_EVIDENCIA`.

## Decisoes por capacidade

Usar, quando aplicavel:

- `ATIVAR`;
- `DEIXAR_PRONTO`;
- `CONFIGURACAO_CLIENTE`;
- `DE_PARA_CLIENTE`;
- `EXTENSAO_CLIENTE`;
- `GAP_DA_RELEASE`;
- `GAP_DA_FERRAMENTA`;
- `DIVERGENCIA_DE_EVIDENCIA`;
- `PENDENTE`;
- `NAO_APLICAVEL`.

## Divergencia de evidencia

Se o material do cliente contradizer a memoria generica do ERP ou a release publicada:

- nao sobrescrever memoria silenciosamente;
- nao assumir automaticamente que a release esta errada;
- nao assumir automaticamente que o cliente esta certo;
- registrar `DIVERGENCIA_DE_EVIDENCIA` com evidencia antiga, evidencia nova, impacto e menor passo responsavel.

## Middleware ou API customizada do cliente

Se existir middleware, API propria ou camada adicional:

- classificar se apenas configura, transforma, restringe, substitui endpoint ou altera semantica;
- registrar impacto na matriz e no relatorio;
- nao desenvolver nada nesta etapa.

## Outputs obrigatorios

Na memoria canonica do cliente:

```text
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/MATRIZ-COMERCIAL-DO-CLIENTE.yaml
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/RELATORIO-DE-ANALISE-DO-CLIENTE.md
```

Nos controles Harness, quando aplicavel:

```text
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-02.yaml
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

## Vigencia, checkpoint e idempotencia

Antes de sobrescrever um output, comparar Passo 01, release, versao, materiais do cliente e checkpoint. Preservar conclusoes validas nao afetadas e reanalisar somente o delta.

## Gate final obrigatorio

Retornar exatamente:

```text
ANALISE_CLIENTE: CONCLUIDA | PARCIAL | BLOQUEADA
MATRIZ_COMERCIAL_CONSOLIDADA: SIM | PARCIAL | NAO
CONFIGURACOES_IDENTIFICADAS: SIM | NAO
DE_PARAS_IDENTIFICADOS: SIM | NAO
EXTENSOES_IDENTIFICADAS: SIM | NAO
GAPS_IDENTIFICADOS: SIM | NAO
PENDENCIAS_BLOQUEANTES: SIM | NAO
APTO_PARA_PROJETAR_INSTALACAO: SIM | NAO
PROXIMO_PASSO: ERP_CLIENTE_03 | ERP_PARCEIRO_<NN> | NOVA_FERRAMENTA_<NN> | BLOQUEADA
HML_EXECUTADA: NAO
PRODUCAO_EXECUTADA: NAO
SEGREDO_PERSISTIDO: NAO
```

## Como chamar

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-CLIENTE-02-ANALISAR-REALIDADE-COMERCIAL-E-TECNICA-DO-CLIENTE.md

Materialize somente o Passo 02 da jornada ERP Cliente:
ANALISAR REALIDADE COMERCIAL E TECNICA DO CLIENTE.

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
- nao executar Passo 03;
- nao usar credenciais reais;
- nao executar HML;
- nao executar producao;
- nao desenvolver integracao;
- nao materializar configuracao, de-para ou extensao real;
- nao inventar dados ausentes.

Reutilize a memoria do ERP, a combinacao publicada, a release, o contrato de configuracao e a saida valida do Passo 01.

Analise a realidade do cliente com cobertura comercial completa e classifique por capacidade o que esta ativo, pronto para ativacao, nao suportado ou pendente de evidencia.

Gere somente os artefatos de analise do Passo 02.
Finalize com status, matriz, pendencias, bloqueios, riscos, rotas e proximo passo permitido.

Nao faca commit.
Nao faca push.
```

### PARE DE COPIAR AQUI
