# ERP Cliente - Passo 03 - Projetar instalacao do cliente

## Finalidade

Executar somente o Passo 03 da jornada ERP Cliente e transformar o handoff valido do Passo 02 em um plano tecnico de instalacao do cliente, rastreavel, seguro e pronto para a materializacao em HML do Passo 04.

Este passo responde:

> Para as capacidades que o Passo 02 classificou como ATIVO ou PRONTO_PARA_ATIVACAO nesta combinacao publicada, como deve ficar desenhada a instalacao deste cliente especifico -- configuracao projetada, de-para projetado, extensao projetada, plano de ativacao e criterios de aceite -- antes de qualquer materializacao real?

O resultado e projeto, nao implementacao nem execucao.

## Roteiro da jornada

```text
PASSO 01 -> resolve contexto, release e elegibilidade [liberado, commitado]
PASSO 02 -> analisa realidade comercial e tecnica do cliente [liberado]
PASSO 03 -> projeta a instalacao do cliente [este documento]
PASSO 04 -> materializa a instalacao em HML [liberado]
PASSO 05 -> valida HML e prepara producao [liberado]
PASSO 06 -> go-live, valida producao e registra memoria [futuro]
```

Os Passos 01, 02, 03, 04 e 05 estao formalmente liberados nesta publicacao. O Passo 06 permanece futuro e nao pode ser executado ate possuir documento operacional, comando e gate oficialmente liberados.

## Fronteira obrigatoria

O Passo 03 pode:

- ler a saida valida do Passo 02 (`MATRIZ-COMERCIAL-DO-CLIENTE.yaml`, `RELATORIO-DE-ANALISE-DO-CLIENTE.md`) e do Passo 01;
- ler o contrato de configuracao e o manifesto de publicacao da release (Passo 09 do ERP Parceiro);
- projetar valores de configuracao do cliente sem inserir valor real nem segredo (mesma regra do `MODELO-CONTRATO-DE-CONFIGURACAO.yaml`: usar `SECRET_REQUIRED`, nunca o valor);
- projetar de-para campo a campo para capacidades `ATIVO`/`PRONTO_PARA_ATIVACAO`;
- desenhar extensoes necessarias, sem implementar;
- definir plano de ativacao para capacidades `PRONTO_PARA_ATIVACAO` (pre-condicoes, dependencias, ordem sugerida);
- definir criterios de aceite mensuraveis para a futura homologacao do cliente;
- executar validacoes locais, Harness e auditoria aplicaveis.

O Passo 03 nao pode:

- reclassificar qualquer capacidade que o Passo 02 ja decidiu (`ATIVO`, `PRONTO_PARA_ATIVACAO`, `NAO_SUPORTADO`, `PENDENTE_DE_EVIDENCIA`). Se a evidencia mudou, a rota correta e retornar ao Passo 02 e passar por nova analise dessa etapa, nao decidir aqui;
- alterar os artefatos do Passo 02 (`MATRIZ-COMERCIAL-DO-CLIENTE.yaml`, `RELATORIO-DE-ANALISE-DO-CLIENTE.md`) nem corrigir silenciosamente achados dele;
- materializar configuracao real;
- implementar de-para ou extensao de fato;
- desenvolver codigo;
- usar credenciais reais;
- executar HML;
- executar producao;
- alterar a release publicada.

## Instrucoes e doutrina obrigatorias

Antes de agir, ler integralmente:

- `AGENTS.md` da raiz e `AGENTS.md` aplicaveis;
- `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`;
- `documentacao/10-IA-DE-APOIO-DA-FABRICA.md`;
- `documentacao/11-MEMORIA-DE-ERPS-E-COMBINACOES.md`;
- `documentacao/19-PUBLICACAO-DE-INTEGRACOES-HOMOLOGADAS.md`;
- `clientes/README.md`;
- os documentos e artefatos do Passo 01 e do Passo 02 aplicaveis a esta combinacao;
- `parceiros/comandos/ERP-CLIENTE-02-ANALISAR-REALIDADE-COMERCIAL-E-TECNICA-DO-CLIENTE.md`, especialmente a secao de traducao de status entre Passo 09 e Passo 02.

Usar os modelos:

- `parceiros/modelos/erp-cliente/MODELO-PLANO-DE-INSTALACAO-DO-CLIENTE.yaml`;
- `parceiros/modelos/erp-cliente/MODELO-RELATORIO-DE-PROJETO-DE-INSTALACAO.md`.

## Regra de escopo -- OBRIGATORIA

Aplicar antes de incluir qualquer capacidade no plano de instalacao. Violacao torna o plano invalido.

```text
origem_status = ATIVO ou PRONTO_PARA_ATIVACAO  -> pode entrar em itens_de_instalacao
origem_status = NAO_SUPORTADO ou PENDENTE_DE_EVIDENCIA -> vai para itens_fora_de_escopo, nunca para o plano
```

Nao existe excecao a esta regra dentro do Passo 03. Uma capacidade so muda de coluna se o Passo 02 for reexecutado e reclassifica-la.

## Regra de gap aberto -- decisao confirmada pelo operador

Quando uma capacidade estiver marcada com `GAP_DA_RELEASE` ou `GAP_DA_FERRAMENTA` no Passo 02:

```text
comportamento: SEGUIR_EM_FRENTE
```

O Passo 03 nao trava por inteiro esperando o gap fechar. A capacidade afetada e registrada em `itens_fora_de_escopo` com a rota de origem preservada (`ERP_PARCEIRO_<NN>` ou jornada da ferramenta), e o restante do plano segue normalmente com o que ja tem evidencia suficiente (`ATIVO` e `PRONTO_PARA_ATIVACAO`). Uma nova rodada do Passo 02, depois que a release ou a ferramenta forem atualizadas, e quem pode promover esses itens para um novo plano de instalacao.

## Gate de entrada obrigatorio

Resolver e retornar:

```text
PASSO_01_CONCLUIDO: SIM | NAO
PASSO_02_CONCLUIDO: SIM | NAO
MATRIZ_COMERCIAL_CONSOLIDADA: SIM | PARCIAL | NAO
APTO_PARA_PROJETAR_INSTALACAO: SIM | NAO
PENDENCIAS_BLOQUEANTES_DO_PASSO_02: SIM | NAO
EXISTE_CAPACIDADE_ATIVO_OU_PRONTA: SIM | NAO
```

Se `APTO_PARA_PROJETAR_INSTALACAO = NAO`, ou `PASSO_02_CONCLUIDO = NAO`, ou nao existir nenhuma capacidade `ATIVO`/`PRONTO_PARA_ATIVACAO`, retornar ao Passo 02 sem tentar completar a lacuna por conta propria.

## Resolucoes automaticas obrigatorias

Antes de perguntar qualquer coisa, o executor deve descobrir no repositorio:

1. cliente, ERP, ferramenta, slugs e combinacao ativa;
2. saida valida do Passo 01 e do Passo 02 para esta combinacao;
3. contrato de configuracao e manifesto de publicacao da release (Passo 09);
4. capacidades `ATIVO`, `PRONTO_PARA_ATIVACAO`, `NAO_SUPORTADO` e `PENDENTE_DE_EVIDENCIA` da matriz do Passo 02;
5. configuracoes, de-paras e extensoes ja identificados (nao materializados) pelo Passo 02;
6. pendencias e decisoes humanas ja registradas;
7. eventuais checkpoints da propria execucao do Passo 03 para esta combinacao.

Perguntar ao operador somente por evidencia realmente ausente e bloqueante.

## Hierarquia de autoridade

Para fatos tecnicos e comerciais, respeitar:

1. contrato homologado e regras da ferramenta E-Catalogos;
2. release publicada e contrato de configuracao da combinacao;
3. classificacao ja decidida pelo Passo 02 (nao reabrir sem retornar a etapa de origem);
4. materiais e evidencias especificos do cliente ja registrados;
5. decisoes humanas explicitamente aprovadas.

## Processo obrigatorio

Executar na ordem:

1. validar contexto e gates dos Passos 01 e 02;
2. carregar a matriz comercial do cliente e aplicar a regra de escopo (secao acima);
3. carregar o contrato de configuracao e o manifesto de publicacao da release;
4. para cada capacidade `ATIVO` ou `PRONTO_PARA_ATIVACAO`: projetar configuracao (`CONFIGURACAO_REUTILIZAVEL` ou `CONFIGURACAO_DO_CLIENTE`, sem valor real), de-para e extensao quando aplicavel;
5. para capacidades `PRONTO_PARA_ATIVACAO`: definir plano de ativacao (pre-condicoes, dependencias, ordem sugerida);
6. definir criterios de aceite mensuraveis por capacidade;
7. registrar capacidades `NAO_SUPORTADO`, `PENDENTE_DE_EVIDENCIA` e com gap aberto em `itens_fora_de_escopo`, aplicando a regra de gap aberto (seguir em frente);
8. consolidar pendencias, bloqueios, restricoes e riscos;
9. gerar os outputs obrigatorios da etapa;
10. executar Harness/auditoria aplicaveis e retornar o gate.

## Outputs obrigatorios

Na memoria canonica do cliente:

```text
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/PLANO-DE-INSTALACAO-DO-CLIENTE.yaml
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/RELATORIO-DE-PROJETO-DE-INSTALACAO.md
```

Nos controles Harness, quando aplicavel:

```text
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-03.yaml
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

Nota de cobertura do Harness: hoje `scripts/harness/` nao possui nenhuma validacao especifica para o caminho `parceiros/execucoes/clientes/...` (so ha fixtures para a jornada `ferramentas`). Isso e uma lacuna de cobertura, nao um bloqueio -- registrar como pendencia de Harness, nao inventar uma validacao mecanica que nao existe.

## Vigencia, checkpoint e idempotencia

Antes de sobrescrever um output, comparar Passo 02, versao da release, contrato de configuracao e checkpoint existente. Preservar conclusoes validas nao afetadas e reprojetar somente o delta.

## Gate final obrigatorio

Retornar exatamente:

```text
PROJETO_INSTALACAO: CONCLUIDO | PARCIAL | BLOQUEADO
PLANO_DE_INSTALACAO_CONSOLIDADO: SIM | PARCIAL | NAO
CONFIGURACAO_PROJETADA: SIM | NAO
DE_PARA_PROJETADO: SIM | NAO
EXTENSAO_PROJETADA: SIM | NAO | NAO_APLICAVEL
PLANO_DE_ATIVACAO_DEFINIDO: SIM | NAO | NAO_APLICAVEL
CRITERIOS_DE_ACEITE_DEFINIDOS: SIM | NAO
PRONTO_PARA_MATERIALIZACAO_EM_HML: SIM | NAO
PROXIMO_PASSO: ERP_CLIENTE_04 | ERP_PARCEIRO_<NN> | NOVA_FERRAMENTA_<NN> | BLOQUEADA
HML_EXECUTADA: NAO
PRODUCAO_EXECUTADA: NAO
SEGREDO_PERSISTIDO: NAO
```

## Como chamar

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-CLIENTE-03-PROJETAR-INSTALACAO-DO-CLIENTE.md

Materialize somente o Passo 03 da jornada ERP Cliente:
PROJETAR INSTALACAO DO CLIENTE.

Intencao do operador:
[texto livre]

Cliente:
[identificacao conhecida]

ERP:
[erp informado]

Ferramenta E-Catalogos:
[ferramenta informada]

Regras obrigatorias:
- nao reclassificar nenhuma capacidade do Passo 02;
- nao executar Passo 04;
- nao usar credenciais reais;
- nao executar HML;
- nao executar producao;
- nao desenvolver integracao;
- nao materializar configuracao, de-para ou extensao real;
- nao inventar dados ausentes;
- capacidade com gap aberto (GAP_DA_RELEASE ou GAP_DA_FERRAMENTA) vai para itens_fora_de_escopo e NAO bloqueia o restante do plano.

Reutilize a saida valida dos Passos 01 e 02, o contrato de configuracao e o manifesto de publicacao da release.

Projete a instalacao somente para capacidades ATIVO ou PRONTO_PARA_ATIVACAO: configuracao, de-para, extensao, plano de ativacao e criterios de aceite.

Gere somente os artefatos de projeto do Passo 03.
Finalize com status, plano, itens fora de escopo, pendencias, rota e proximo passo permitido.

Nao faca commit.
Nao faca push.
```

### PARE DE COPIAR AQUI
