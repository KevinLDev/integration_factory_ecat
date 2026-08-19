# ERP Cliente - Passo 06 - Go-live, validar producao e registrar memoria

## Finalidade

Executar somente o Passo 06 da jornada ERP Cliente: autorizar e materializar o go-live em producao desta combinacao de cliente, confirmar que producao se comporta como o Passo 05 ja validou em HML, e registrar a memoria final de fechamento.

Este passo responde:

> O que ja foi validado em HML no Passo 05 realmente funciona em producao para este cliente, e o cliente esta de fato integrado?

O resultado e producao real, executada uma unica vez de forma completa (nao faseada), e nunca se autoaprova.

**Esta e a primeira etapa de toda a fabrica que escreve em producao.** Nenhum passo do ERP Parceiro (01 a 09) executa producao. Trate este comando com o nivel de cautela mais alto do repositorio.

## Roteiro da jornada

```text
PASSO 01 -> resolve contexto, release e elegibilidade [liberado, commitado]
PASSO 02 -> analisa realidade comercial e tecnica do cliente [liberado]
PASSO 03 -> projeta a instalacao do cliente [liberado, somente projeto]
PASSO 04 -> materializa a instalacao em HML [liberado, auditoria PROFUNDA obrigatoria]
PASSO 05 -> valida HML e prepara producao [liberado, auditoria PROFUNDA obrigatoria]
PASSO 06 -> go-live, valida producao e registra memoria [este documento]
```

Com este documento, os 6 passos do roteiro ficam formalmente liberados. Nao existe Passo 07 da jornada ERP Cliente; runtime e monitoramento continuos permanecem visao futura, sem etapa oficial.

## Fronteira obrigatoria

O Passo 06 pode:

- ler a validacao aprovada do Passo 05 (`VALIDACAO-HML-DO-CLIENTE.yaml`, `RELATORIO-DE-VALIDACAO-DO-CLIENTE.md`) e a instalacao materializada do Passo 04;
- executar em producao exatamente o que ja foi validado, com reconsulta e confirmacao apos cada escrita;
- reexecutar (via terminal/agente) os mesmos cenarios ja aprovados no Passo 05, agora contra producao, como confirmacao pos-go-live;
- conduzir a confirmacao funcional manual, olhando o resultado na propria ferramenta (mesmo modelo do Passo 05/08 Parceiro, sem automacao de navegador);
- classificar falhas e apontar o menor passo responsavel;
- registrar a memoria final de fechamento da integracao deste cliente;
- executar validacoes locais, Harness e auditoria aplicaveis.

O Passo 06 nao pode:

- iniciar qualquer escrita sem autorizacao explicita de producao (distinta da autorizacao de HML dos Passos 04/05) e sem um plano de contingencia definido;
- iniciar escrita se o ambiente resolvido nao for producao real comprovada (bloquear se resolver HML, homologacao, sandbox, teste ou DEV -- politica invertida em relacao aos Passos 04/05);
- re-homologar a integracao generica, revalidar o que o Passo 05 ja aprovou, ou reprojetar/reclassificar qualquer coisa dos Passos 02, 03 ou 04;
- fazer rollback destrutivo automatico de dado real ja confirmado (pedido, estoque, cliente). Falha parcial preserva o confirmado e aciona o plano de contingencia;
- criar runtime 24/7, monitoramento continuo ou automacao permanente -- fora de escopo;
- reproduzir, persistir ou logar segredo real em qualquer artefato;
- declarar `AUDITORIA: APROVADA`, `STATUS_DA_ETAPA: CONCLUIDA` ou `CLIENTE_INTEGRADO: SIM` a partir da execucao produtora -- exige auditoria independente `PROFUNDA` aprovada.

## Instrucoes e doutrina obrigatorias

Antes de agir, ler integralmente:

- `AGENTS.md` da raiz e `AGENTS.md` aplicaveis;
- `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`;
- `documentacao/10-IA-DE-APOIO-DA-FABRICA.md`;
- `documentacao/17-VALIDACAO-TECNICA-DE-INTEGRACOES-EM-HML.md`;
- `documentacao/18-HOMOLOGACAO-FUNCIONAL-DE-INTEGRACOES.md`;
- `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`;
- `clientes/README.md`;
- os documentos e artefatos dos Passos 01 a 05 aplicaveis a esta combinacao;
- `parceiros/comandos/ERP-CLIENTE-05-VALIDAR-HML-E-PREPARAR-PRODUCAO.md`.

Usar os modelos:

- `parceiros/modelos/erp-cliente/MODELO-GO-LIVE-DO-CLIENTE.yaml`;
- `parceiros/modelos/erp-cliente/MODELO-RELATORIO-DE-GO-LIVE-DO-CLIENTE.md`.

## Fase 1 -- Autorizacao de go-live (obrigatoria antes de qualquer escrita)

Resolver e confirmar, nesta ordem, antes de qualquer chamada de escrita:

```text
PASSO_05_CONCLUIDO: SIM | NAO
AUDITORIA_PASSO_05: APROVADA | NAO_APROVADA
PRONTO_PARA_PRODUCAO: SIM | NAO
CENARIOS_CRITICOS_OU_ALTOS_PENDENTES: SIM | NAO
PLANO_DE_CONTINGENCIA_DEFINIDO: SIM | NAO
AUTORIZACAO_PRODUCAO: SIM | NAO
AMBIENTE_PRODUCAO_CONFIRMADO: SIM | NAO
```

Se `PASSO_05_CONCLUIDO = NAO`, ou `AUDITORIA_PASSO_05 != APROVADA`, ou `PRONTO_PARA_PRODUCAO = NAO`, ou `CENARIOS_CRITICOS_OU_ALTOS_PENDENTES = SIM`, bloquear e retornar ao Passo 05. Se `PLANO_DE_CONTINGENCIA_DEFINIDO = NAO` ou `AUTORIZACAO_PRODUCAO = NAO`, bloquear e nao iniciar nenhuma escrita. Se `AMBIENTE_PRODUCAO_CONFIRMADO = NAO`, bloquear.

### Politica de autorizacao -- OBRIGATORIA

A autorizacao de producao e distinta da autorizacao de HML dos Passos 04/05 e nunca e reaproveitada dela. Nesta V1, o proprio operador e a unica autoridade exigida -- nao ha aprovacao externa do lado do cliente. Ainda assim, a autorizacao deve ser explicita, redigida e dada para este go-live especifico (cliente, combinacao, momento); nunca presumida.

Exemplo conceitual de controle:

```text
AUTORIZADO_GO_LIVE_PRODUCAO: SIM
```

### Politica de ambiente -- INVERTIDA em relacao aos Passos 04/05

Nos Passos 04 e 05, bloqueia-se se o ambiente resolver como producao. Aqui e o oposto: **bloquear se o ambiente resolver como HML, homologacao, sandbox, teste ou DEV**. Nao confiar apenas no texto da URL; registrar fingerprint nao sensivel do ambiente (sistema, conta/tenant sem segredo) antes da primeira escrita, comprovando que e producao.

### Plano de contingencia -- OBRIGATORIO

Deve estar definido e registrado antes da primeira escrita:

- ponto de pausa seguro caso uma escrita falhe no meio do go-live;
- quem decide o proximo passo quando o plano e acionado;
- quais itens sao reversiveis e quais nao sao (pedido real, estoque real e cliente real normalmente nao sao desfazíveis por API);
- que nenhuma tentativa de "corrigir automaticamente" substitui a decisao humana quando o plano e acionado.

## Politica de credenciais

Mesma politica dos Passos 04/05: credenciais reais de producao podem ser usadas de forma transitoria durante a execucao. Proibido reproduzir, persistir ou logar segredo em qualquer artefato, manifesto, checkpoint, relatorio ou resposta ao operador.

## Fase 2 -- Go-live (execucao)

Executar o go-live completo, de uma vez (nao faseado), reaproveitando exatamente o que o Passo 04/05 ja validaram:

1. carregar a instalacao materializada do Passo 04 e a validacao aprovada do Passo 05;
2. confirmar identidade e correlacao (`ID_LOGICO <-> ID_FISICO`) antes de cada escrita, para garantir idempotencia;
3. materializar em producao o que ja foi validado -- sem reprojetar, sem redesenhar;
4. reconsultar cada escrita relevante e comparar planejado x observado;
5. classificar cada item (`ESCRITA_CONFIRMADA`, `REUTILIZADO_EXISTENTE`, `DIVERGENTE_APOS_RECONSULTA`, `FALHOU_NA_ESCRITA`, `FALHOU_NA_RECONSULTA`);
6. em caso de falha parcial: preservar tudo confirmado, nao tentar desfazer nada, acionar o plano de contingencia, registrar pendencia bloqueante e parar.

Regras de escrita: `POST` permitido quando necessario; `PUT`/`PATCH` somente para ajuste controlado previsto; `DELETE` fora do fluxo normal desta etapa.

## Fase 3 -- Confirmacao pos-go-live e memoria

Nao e uma nova homologacao completa. E uma confirmacao curta, usando os mesmos cenarios ja aprovados no Passo 05:

1. reexecutar (via terminal/agente com acesso real) os cenarios ja aprovados no Passo 05, agora contra producao;
2. o operador humano confere manualmente na propria ferramenta (Forca de Vendas ou a que for) que o resultado aparece correto -- mesma politica de roteiro (PRE-CONDICOES, FACA, OBSERVE, CONFIRME, EVIDENCIA SOLICITADA) e o mesmo status permitido (`APROVADO`, `REPROVADO`, `BLOQUEADO`, `NAO_APLICAVEL`, `PENDENTE`, `PENDENTE_DE_EVIDENCIA`; `PARCIALMENTE_APROVADO` proibido) do Passo 05;
3. qualquer cenario `CRITICO` reprovado, pendente ou bloqueado nesta confirmacao impede `CLIENTE_INTEGRADO: SIM`;
4. registrar a memoria final de fechamento: `MEMORIA-DA-INTEGRACAO-DO-CLIENTE.md`, referenciando os artefatos dos 6 passos e o status final da combinacao.

## Taxonomia de falhas e menor passo responsavel -- OBRIGATORIA

```text
FALHA_TECNICA_DE_GO_LIVE           -> preserva sucessos, aciona plano de contingencia, registra pendencia bloqueante
DIVERGENCIA_ENTRE_HML_E_PRODUCAO   -> retorna ao Passo 05 (validacao insuficiente) ou ao Passo 04 (materializacao incorreta)
BUG_NA_INTEGRACAO_GENERICA         -> encaminha ao ERP Parceiro (menor passo responsavel, tipicamente o Passo 06)
CAPACIDADE_ERP_INCORRETA_OU_INSUFICIENTE -> retorna ao Passo 02
BUG_OU_DIVERGENCIA_DA_FERRAMENTA   -> jornada da ferramenta responsavel
```

O Passo 06 nao corrige silenciosamente nenhuma origem upstream e nao tenta "consertar" dado real de producao por conta propria.

## Auto-descoberta obrigatoria

Resolver automaticamente antes de perguntar:

1. cliente, ERP, ferramenta, slugs e combinacao ativa;
2. saida valida dos Passos 01 a 05 para esta combinacao;
3. instalacao materializada do Passo 04 e validacao aprovada do Passo 05;
4. estado de producao ja existente para esta combinacao, se houver (go-live anterior parcial);
5. checkpoints da propria execucao do Passo 06 para esta combinacao.

Perguntar ao operador somente por evidencia realmente ausente e bloqueante -- em especial autorizacao de producao e plano de contingencia, que nunca devem ser assumidos.

## Outputs obrigatorios

Na memoria canonica do cliente:

```text
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/GO-LIVE-DO-CLIENTE.yaml
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/RELATORIO-DE-GO-LIVE-DO-CLIENTE.md
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/MEMORIA-DA-INTEGRACAO-DO-CLIENTE.md
```

Nos controles Harness, quando aplicavel:

```text
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-06.yaml
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

Nota de cobertura do Harness: hoje `scripts/harness/` nao possui validacao especifica para o caminho `parceiros/execucoes/clientes/...`. Registrar como pendencia de Harness, nao inventar validacao mecanica que nao existe.

## Auditoria obrigatoria desta etapa

Esta e a primeira execucao de producao de toda a fabrica -- nao apenas desta combinacao. Conforme `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`, exige auditoria independente `PROFUNDA`, separada da execucao produtora e somente leitura dos artefatos auditados, com o maior rigor entre todas as etapas ja liberadas.

A execucao produtora do Passo 06 nunca declara `AUDITORIA: APROVADA` nem `STATUS_DA_ETAPA: CONCLUIDA`. Ela sempre encerra com `AUDITORIA: AGUARDANDO_INDEPENDENTE` e `STATUS_DA_ETAPA: PENDENTE`.

## Gate final obrigatorio da execucao produtora

Retornar exatamente:

```text
AUTORIZACAO_PRODUCAO: SIM | NAO
PLANO_DE_CONTINGENCIA_DEFINIDO: SIM | NAO
AMBIENTE_PRODUCAO_CONFIRMADO: SIM | NAO
GO_LIVE: EXECUTADO | PARCIAL_JUSTIFICADO | BLOQUEADO
RECONSULTA: APROVADA | PARCIAL | INSUFICIENTE
IDEMPOTENCIA_APROVADA: SIM | NAO | NAO_APLICAVEL
VALIDACAO_POS_GO_LIVE: APROVADA | REPROVADA | PENDENTE
MEMORIA_REGISTRADA: SIM | NAO
FALHAS_BLOQUEANTES: <quantidade>
SEGREDO_PERSISTIDO: NAO
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS_DA_ETAPA: PENDENTE
CLIENTE_INTEGRADO: NAO
PROXIMO_PASSO: AUDITORIA_INDEPENDENTE_PASSO_06
```

Somente a auditoria independente `PROFUNDA` aprovada pode atualizar os controles autorizados para:

```text
AUDITORIA: APROVADA
STATUS_DA_ETAPA: CONCLUIDA
CLIENTE_INTEGRADO: SIM
PROXIMO_PASSO: JORNADA_CONCLUIDA
```

## Como chamar

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-CLIENTE-06-GO-LIVE-E-VALIDAR-PRODUCAO.md

Materialize somente o Passo 06 da jornada ERP Cliente:
GO-LIVE, VALIDAR PRODUCAO E REGISTRAR MEMORIA.

Cliente:
[identificacao conhecida]

ERP:
[erp informado]

Ferramenta E-Catalogos:
[ferramenta informada]

Autorizacao explicita de producao:
[SIM/NAO -- deve ser dada especificamente para este go-live]

Plano de contingencia:
[descreva o que fazer se algo falhar no meio do go-live]

Regras obrigatorias:
- nao iniciar escrita sem autorizacao de producao e plano de contingencia definidos;
- bloquear se o ambiente nao for producao real comprovada;
- nao revalidar nem reprojetar o que ja foi aprovado nos Passos 04/05;
- preservar sucessos parciais, nunca fazer rollback automatico de dado real;
- nao persistir segredo em nenhum artefato;
- confirmar pos-go-live reexecutando os cenarios do Passo 05 e conferindo na ferramenta;
- registrar a memoria final de fechamento;
- nao se autoaprovar -- encerrar com AUDITORIA: AGUARDANDO_INDEPENDENTE e STATUS_DA_ETAPA: PENDENTE.

Reutilize a instalacao materializada do Passo 04 e a validacao aprovada do Passo 05 para esta combinacao.

Gere somente os artefatos do Passo 06.
Finalize com o gate completo da etapa.

Nao faca commit.
Nao faca push.
```

### PARE DE COPIAR AQUI
