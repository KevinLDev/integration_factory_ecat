# ERP Cliente - Passo 04 - Materializar instalacao do cliente em HML

## Finalidade

Executar somente o Passo 04 da jornada ERP Cliente: transformar, em execucao real autorizada, o `PLANO-DE-INSTALACAO-DO-CLIENTE.yaml` aprovado no Passo 03 em configuracao, de-para e extensao efetivamente criados e confirmados no ambiente de HML deste cliente.

Este passo responde:

> O que o Passo 03 projetou para este cliente realmente foi materializado e confirmado no ambiente de HML autorizado?

O resultado e materializacao real em HML, nunca em producao, e nunca se autoaprova.

## Roteiro da jornada

```text
PASSO 01 -> resolve contexto, release e elegibilidade [liberado, commitado]
PASSO 02 -> analisa realidade comercial e tecnica do cliente [liberado]
PASSO 03 -> projeta a instalacao do cliente [liberado, somente projeto]
PASSO 04 -> materializa a instalacao em HML [este documento]
PASSO 05 -> valida HML e prepara producao [futuro]
PASSO 06 -> go-live, valida producao e registra memoria [futuro]
```

Os Passos 01, 02, 03 e 04 estao formalmente liberados nesta publicacao. Os Passos 05 e 06 permanecem futuros e nao podem ser executados ate possuirem documentos operacionais, comandos e gates oficialmente liberados.

## Fronteira obrigatoria

O Passo 04 pode:

- ler o plano aprovado do Passo 03 (`PLANO-DE-INSTALACAO-DO-CLIENTE.yaml`, `RELATORIO-DE-PROJETO-DE-INSTALACAO.md`) e a saida do Passo 01/02;
- verificar a vigencia do plano contra as fontes efetivamente usadas no Passo 03 (release, contrato de configuracao, matriz comercial);
- materializar, no ambiente de HML autorizado, exatamente a configuracao, o de-para e a extensao ja projetados;
- executar o plano de ativacao definido para capacidades `PRONTO_PARA_ATIVACAO`;
- reconsultar o destino apos cada escrita relevante para confirmar o resultado;
- executar validacoes locais, Harness e auditoria aplicaveis.

O Passo 04 nao pode:

- reprojetar, redesenhar ou reinterpretar qualquer item do plano do Passo 03. Se o plano estiver desatualizado ou divergente, a rota correta e retornar ao Passo 03, nao decidir aqui;
- alterar os artefatos do Passo 02 ou do Passo 03;
- alterar o contrato homologado da ferramenta nem o core da integracao publicada;
- escrever em ambiente de producao sob qualquer circunstancia;
- reproduzir, persistir ou logar segredo real em qualquer artefato, manifesto, checkpoint, relatorio ou resposta ao operador;
- validar funcionalmente o resultado (pertence ao futuro Passo 05);
- declarar `AUDITORIA: APROVADA`, `STATUS_DA_ETAPA: CONCLUIDA` ou `PRONTO_PARA_VALIDACAO_HML: SIM` a partir da execucao produtora -- esses valores exigem auditoria independente `PROFUNDA` aprovada.

## Instrucoes e doutrina obrigatorias

Antes de agir, ler integralmente:

- `AGENTS.md` da raiz e `AGENTS.md` aplicaveis;
- `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`;
- `documentacao/10-IA-DE-APOIO-DA-FABRICA.md`;
- `documentacao/11-MEMORIA-DE-ERPS-E-COMBINACOES.md`;
- `documentacao/17-VALIDACAO-TECNICA-DE-INTEGRACOES-EM-HML.md` (padrao de execucao segura em HML usado como referencia);
- `documentacao/19-PUBLICACAO-DE-INTEGRACOES-HOMOLOGADAS.md`;
- `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`;
- `clientes/README.md`;
- os documentos e artefatos do Passo 01, 02 e 03 aplicaveis a esta combinacao;
- `parceiros/comandos/ERP-CLIENTE-03-PROJETAR-INSTALACAO-DO-CLIENTE.md`.

Usar os modelos:

- `parceiros/modelos/erp-cliente/MODELO-INSTALACAO-MATERIALIZADA-DO-CLIENTE.yaml`;
- `parceiros/modelos/erp-cliente/MODELO-RELATORIO-DE-MATERIALIZACAO-DO-CLIENTE.md`.

## Verificacao obrigatoria de vigencia do plano

Antes de qualquer escrita:

1. ler o plano do Passo 03 e as fontes que ele usou (matriz comercial, contrato de configuracao, manifesto de publicacao);
2. comparar essas fontes com o estado atual delas no repositorio;
3. usar hash/versao ja registrado quando disponivel, sem inventar valor;
4. aceitar mudanca textual irrelevante somente quando houver evidencia segura de que a fonte efetiva usada nao mudou.

Se houver divergencia relevante ou evidencia insuficiente:

```text
VIGENCIA_DO_PLANO: PLANO_POTENCIALMENTE_OBSOLETO
PLANO_VALIDO: NAO
```

Bloquear toda escrita e retornar ao Passo 03 para revalidacao minima. Nao atualizar o plano, reinterpretar regras ou corrigir o projeto dentro do Passo 04.

## Politica de ambiente -- OBRIGATORIA

Escrita permitida apenas em:

- HML
- HOMOLOGACAO
- SANDBOX
- TESTE
- DEV autorizado

Producao nao e ambiente padrao nem fallback desta etapa. Se o contexto resolver ambiente de producao, ou houver duvida razoavel sobre isso, **bloquear a execucao de escrita**. Nao confiar apenas no texto da URL; validar configuracao oficial de ambiente/conexao quando existir. Antes da primeira escrita, registrar um fingerprint nao sensivel do ambiente (identificador do sistema, classificacao HML/teste/sandbox/homologacao, conta ou tenant sem segredo).

## Politica de autorizacao -- OBRIGATORIA

Credencial disponivel nao equivale a autorizacao processual. Exigir autorizacao explicita do operador antes da primeira escrita, especifica para:

- cliente;
- combinacao (ERP + ferramenta);
- ambiente;
- plano corrente (versao/hash do Passo 03).

Exemplo conceitual de controle:

```text
AUTORIZADO_MATERIALIZAR_INSTALACAO_CLIENTE: SIM
```

Nao reutilizar autorizacao silenciosamente para outro cliente, plano ou ambiente.

## Politica de credenciais -- OBRIGATORIA

Em execucao real, o executor pode receber e usar credenciais autorizadas de HML.

Proibido:

- reproduzir segredo;
- persistir segredo em Git;
- registrar segredo em relatorios, manifestos, checkpoints ou artefatos;
- devolver segredo no retorno ao operador.

Preferir env, secret store ou arquivo local ignorado. Se segredo surgir na sessao, usar de forma transitoria e nao persistir.

## Auto-descoberta obrigatoria

Resolver automaticamente antes de perguntar:

1. cliente, ERP, ferramenta, slugs e combinacao ativa;
2. saida valida do Passo 01, 02 e 03 para esta combinacao;
3. plano de instalacao aprovado (`PLANO-DE-INSTALACAO-DO-CLIENTE.yaml`);
4. contrato de configuracao e manifesto de publicacao da release;
5. estado ja materializado anterior para esta combinacao, se existir;
6. ambiente de HML alvo e estrategia de autenticacao;
7. checkpoints da propria execucao do Passo 04 para esta combinacao.

Perguntar ao operador somente por evidencia realmente ausente e bloqueante -- em especial autorizacao explicita e credenciais, que nunca devem ser assumidas.

## Identidade, correlacao e idempotencia

Separar sempre:

- `ID_LOGICO` da Fabrica para o item do cliente;
- `ID_FISICO` retornado pelo sistema de HML.

Persistir correlacao nao sensivel (`ID_LOGICO <-> ID_FISICO`) progressivamente, apos cada confirmacao.

Regra obrigatoria: executar o Passo 04 duas vezes para a mesma combinacao nao pode duplicar configuracao. Antes de qualquer escrita, buscar existencia por correlacao ou chave segura. Se existir correlacao valida, reutilizar. Se houver ambiguidade de identidade, bloquear aquele item e nao sobrescrever dado real.

## Processo obrigatorio

Executar na ordem:

1. validar contexto e gate do Passo 03;
2. verificar vigencia do plano contra as fontes usadas;
3. validar ambiente (nunca producao) e registrar fingerprint;
4. validar autorizacao explicita do operador;
5. carregar o plano de instalacao e o estado ja materializado anterior, se existir;
6. para cada item do plano: buscar existencia por correlacao, materializar somente o que faltar, respeitando dependencias e ordem de ativacao definidas no Passo 03;
7. reconsultar cada escrita relevante e comparar planejado x observado;
8. classificar cada item (`ESCRITA_CONFIRMADA`, `REUTILIZADO_EXISTENTE`, `DIVERGENTE_APOS_RECONSULTA`, `FALHOU_NA_ESCRITA`, `FALHOU_NA_RECONSULTA`, `NAO_APLICAVEL`);
9. preservar sucessos parciais sem rollback destrutivo automatico em caso de falha;
10. consolidar pendencias, bloqueios e riscos;
11. gerar os outputs obrigatorios da etapa;
12. executar Harness aplicavel e encerrar com `AUDITORIA: AGUARDANDO_INDEPENDENTE`.

## Escritas permitidas em execucao real

- `POST`: permitido quando necessario para criar o que o plano exige.
- `PUT`/`PATCH`: permitido somente para ajuste controlado previsto no plano e alvo seguro.
- `DELETE`: nao faz parte do fluxo normal desta etapa.

## Retry, auth e rate limit

Retry controlado apenas para falhas transitorias (timeout, 429, 5xx), com limite. Nao fazer retry cego para 4xx deterministico de validacao. Em caso de 401, permitir no maximo uma renovacao/retry controlado por operacao, quando a estrategia de autenticacao do Passo 02 permitir. Respeitar rate limit e `Retry-After` quando houver.

## Outputs obrigatorios

Na memoria canonica do cliente:

```text
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/INSTALACAO-MATERIALIZADA-DO-CLIENTE.yaml
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/RELATORIO-DE-MATERIALIZACAO-DO-CLIENTE.md
```

Nos controles Harness, quando aplicavel:

```text
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-04.yaml
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

Nota de cobertura do Harness: hoje `scripts/harness/` nao possui validacao especifica para o caminho `parceiros/execucoes/clientes/...`. Isso e uma lacuna de cobertura, nao um bloqueio -- registrar como pendencia de Harness, nao inventar uma validacao mecanica que nao existe.

## Auditoria obrigatoria desta etapa

Esta e a primeira execucao real de escrita da jornada ERP Cliente para uma combinacao. Conforme `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`, a primeira execucao real de uma combinacao exige auditoria independente `PROFUNDA`, separada da execucao produtora e somente leitura dos artefatos auditados.

A execucao produtora do Passo 04 nunca declara `AUDITORIA: APROVADA` nem `STATUS_DA_ETAPA: CONCLUIDA`. Ela sempre encerra com `AUDITORIA: AGUARDANDO_INDEPENDENTE` e `STATUS_DA_ETAPA: PENDENTE`.

## Gate final obrigatorio da execucao produtora

Retornar exatamente:

```text
AMBIENTE_AUTORIZADO: SIM | NAO
FINGERPRINT_AMBIENTE_REGISTRADO: SIM | NAO
PLANO_VALIDO: SIM | NAO
VIGENCIA_DO_PLANO: VIGENTE | PLANO_POTENCIALMENTE_OBSOLETO | EVIDENCIA_INSUFICIENTE
AUTORIZACAO_MATERIALIZACAO: SIM | NAO
MATERIALIZACAO: COMPLETA | PARCIAL_JUSTIFICADA | INSUFICIENTE | BLOQUEADA
RECONSULTA: APROVADA | PARCIAL | INSUFICIENTE
CORRELACOES: VALIDAS | PARCIAIS | INVALIDAS
IDEMPOTENCIA_APROVADA: SIM | NAO | NAO_APLICAVEL
FALHAS_BLOQUEANTES: <quantidade>
ESCRITA_PRODUCAO: NAO
SEGREDO_PERSISTIDO: NAO
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS_DA_ETAPA: PENDENTE
PRONTO_PARA_VALIDACAO_HML: NAO
PROXIMO_PASSO: AUDITORIA_INDEPENDENTE_PASSO_04
```

Somente a auditoria independente `PROFUNDA` aprovada pode atualizar os controles autorizados para:

```text
AUDITORIA: APROVADA
STATUS_DA_ETAPA: CONCLUIDA
PRONTO_PARA_VALIDACAO_HML: SIM
PROXIMO_PASSO: ERP_CLIENTE_05
```

## Como chamar

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-CLIENTE-04-MATERIALIZAR-INSTALACAO-EM-HML.md

Materialize somente o Passo 04 da jornada ERP Cliente:
MATERIALIZAR INSTALACAO DO CLIENTE EM HML.

Cliente:
[identificacao conhecida]

ERP:
[erp informado]

Ferramenta E-Catalogos:
[ferramenta informada]

Ambiente de HML autorizado:
[identificacao do ambiente -- sem credencial no prompt]

Regras obrigatorias:
- nao reprojetar nem reclassificar nenhum item do Passo 02/03;
- verificar vigencia do plano antes de qualquer escrita; se obsoleto, bloquear e retornar ao Passo 03;
- materializar somente em HML/homologacao/sandbox/teste -- nunca producao;
- exigir autorizacao explicita antes da primeira escrita;
- nao persistir segredo em nenhum artefato;
- confirmar cada escrita por reconsulta antes de declarar sucesso;
- garantir idempotencia -- reexecucao nao duplica;
- nao se autoaprovar -- encerrar com AUDITORIA: AGUARDANDO_INDEPENDENTE e STATUS_DA_ETAPA: PENDENTE.

Reutilize a saida valida dos Passos 01, 02 e 03 para esta combinacao.

Gere somente os artefatos de materializacao do Passo 04.
Finalize com o gate completo da etapa.

Nao faca commit.
Nao faca push.
```

### PARE DE COPIAR AQUI
