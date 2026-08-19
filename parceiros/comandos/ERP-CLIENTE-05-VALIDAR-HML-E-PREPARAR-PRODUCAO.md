# ERP Cliente - Passo 05 - Validar HML e preparar producao

## Finalidade

Executar somente o Passo 05 da jornada ERP Cliente: comprovar, com evidencia tecnica e funcional, que a instalacao materializada no Passo 04 para este cliente realmente funciona em HML e atende os criterios de aceite definidos no Passo 03, preparando -- sem executar -- a decisao de go-live.

Este passo responde:

> A instalacao materializada no Passo 04 realmente funciona corretamente em HML para este cliente, e o que falta para autorizar producao?

O resultado e evidencia de prontidao, nunca execucao de producao, e nunca se autoaprova.

## Roteiro da jornada

```text
PASSO 01 -> resolve contexto, release e elegibilidade [liberado, commitado]
PASSO 02 -> analisa realidade comercial e tecnica do cliente [liberado]
PASSO 03 -> projeta a instalacao do cliente [liberado, somente projeto]
PASSO 04 -> materializa a instalacao em HML [liberado, auditoria PROFUNDA obrigatoria]
PASSO 05 -> valida HML e prepara producao [este documento]
PASSO 06 -> go-live, valida producao e registra memoria [futuro]
```

Os Passos 01, 02, 03, 04 e 05 estao formalmente liberados nesta publicacao. O Passo 06 permanece futuro e nao pode ser executado ate possuir documento operacional, comando e gate oficialmente liberados.

## Fronteira obrigatoria

O Passo 05 pode:

- ler a instalacao materializada do Passo 04 (`INSTALACAO-MATERIALIZADA-DO-CLIENTE.yaml`, `RELATORIO-DE-MATERIALIZACAO-DO-CLIENTE.md`) e o plano do Passo 03 (`PLANO-DE-INSTALACAO-DO-CLIENTE.yaml`, criterios de aceite);
- ler a matriz funcional ja homologada da combinacao ERP x ferramenta (Passo 08 do ERP Parceiro) para derivar cenarios;
- executar cenarios tecnicos em HML usando a instalacao materializada, com reconsulta e comparacao planejado x observado;
- conduzir homologacao funcional manual assistida por IA (mesmo modelo do Passo 08 do ERP Parceiro): humano executa acoes de interface, IA deriva roteiro, coleta retorno, classifica resultado;
- classificar falhas e apontar o menor passo responsavel;
- executar validacoes locais, Harness e auditoria aplicaveis.

O Passo 05 nao pode:

- re-homologar a integracao generica ERP x ferramenta -- isso pertence exclusivamente aos Passos 07, 08 e 09 do ERP Parceiro;
- materializar, corrigir ou ajustar configuracao, de-para ou extensao. Se algo estiver incorreto, a rota correta e retornar ao Passo 04 (materializacao) ou ao Passo 03 (projeto), nao corrigir aqui;
- reprojetar nem reclassificar nada dos Passos 02 e 03;
- alterar os artefatos dos Passos 02, 03 ou 04;
- usar automacao de navegador, observer realtime ou monitoramento de eventos de interface em tempo real (mesma proibicao V1 do Passo 08 Parceiro);
- executar producao sob qualquer circunstancia;
- reproduzir, persistir ou logar segredo real em qualquer artefato;
- declarar `AUDITORIA: APROVADA`, `STATUS_DA_ETAPA: CONCLUIDA` ou `PRONTO_PARA_PRODUCAO: SIM` a partir da execucao produtora -- esses valores exigem auditoria independente `PROFUNDA` aprovada.

## Instrucoes e doutrina obrigatorias

Antes de agir, ler integralmente:

- `AGENTS.md` da raiz e `AGENTS.md` aplicaveis;
- `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`;
- `documentacao/10-IA-DE-APOIO-DA-FABRICA.md`;
- `documentacao/17-VALIDACAO-TECNICA-DE-INTEGRACOES-EM-HML.md`;
- `documentacao/18-HOMOLOGACAO-FUNCIONAL-DE-INTEGRACOES.md` (padrao de homologacao funcional manual assistida por IA usado como referencia);
- `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`;
- `clientes/README.md`;
- os documentos e artefatos dos Passos 01, 02, 03 e 04 aplicaveis a esta combinacao;
- `parceiros/comandos/ERP-CLIENTE-04-MATERIALIZAR-INSTALACAO-EM-HML.md`.

Usar os modelos:

- `parceiros/modelos/erp-cliente/MODELO-VALIDACAO-HML-DO-CLIENTE.yaml`;
- `parceiros/modelos/erp-cliente/MODELO-RELATORIO-DE-VALIDACAO-DO-CLIENTE.md`.

## Derivacao do escopo de cenarios

Os cenarios nao sao um checklist universal. Derivar exclusivamente de:

1. criterios de aceite definidos no Passo 03 para as capacidades `ATIVO`/`PRONTO_PARA_ATIVACAO` deste cliente;
2. areas funcionais com suporte comprovado pela matriz funcional ja homologada da combinacao (Passo 08 do ERP Parceiro).

Nao incluir area sem suporte comprovado por artefato vigente upstream.

## Estrutura minima de cenario -- OBRIGATORIA

Cada cenario deve conter, no minimo:

```text
scenario_id
capacidade_id (referencia ao Passo 03)
area_funcional
criticidade # CRITICO | ALTO | MEDIO | BAIXO
perfil_ator
executor # HUMANO (V1 nao usa automacao de navegador)
pre_condicoes
dados_de_teste
acoes_do_operador
resultado_esperado
resultado_observado
evidencias
status
dependencias
artefatos_upstream
classificacao_da_falha
menor_passo_responsavel
```

## Status de cenario -- OBRIGATORIO

Status permitidos:

```text
APROVADO
REPROVADO
BLOQUEADO
NAO_APLICAVEL
PENDENTE
PENDENTE_DE_EVIDENCIA
```

`PARCIALMENTE_APROVADO` e proibido, para nao mascarar cenario critico. `NAO_APLICAVEL` exige justificativa e vinculo ao escopo comprovado.

## Politica de criticidade e criterio de prontidao -- OBRIGATORIA

- qualquer cenario `CRITICO` com status `REPROVADO`, `PENDENTE`, `PENDENTE_DE_EVIDENCIA` ou `BLOQUEADO` impede `PRONTO_PARA_PRODUCAO: SIM`;
- para cenarios `ALTO`, o limite e zero reprovado para concluir sem ressalva;
- nao homologar por percentual (exemplo: 49 aprovados + 1 critico reprovado continua `PRONTO_PARA_PRODUCAO: NAO`).

## Roteiro operacional orientado ao operador

Cada cenario deve instruir o operador humano com os blocos:

```text
PRE-CONDICOES
FACA (passo a passo)
OBSERVE (campos e comportamentos)
CONFIRME (resultado no destino quando aplicavel)
EVIDENCIA SOLICITADA
```

Formato de evidencia: screenshot quando util, IDs de referencia (ferramenta e ERP), horario aproximado, descricao objetiva do observado. Nunca persistir senha, token, Authorization, segredo ou dado pessoal desnecessario.

## Registro manual simplificado

Sem observer em tempo real, o retorno manual deve seguir formato padronizado:

```text
CENARIO: <scenario_id>
EXECUTADO: SIM | NAO
RESULTADO_OBSERVADO: ...
IDS: ferramenta=... ; erp=...
EVIDENCIAS: ...
OBSERVACOES: ...
```

A IA converte esse retorno em status do cenario, `classificacao_da_falha`, `menor_passo_responsavel` e necessidade de reexecucao.

## Taxonomia de falhas e menor passo responsavel -- OBRIGATORIA

```text
FALHA_FUNCIONAL_DO_CENARIO            -> resolve no proprio Passo 05, sem corrigir upstream silenciosamente
FALHA_TECNICA_DE_MATERIALIZACAO       -> retorna ao Passo 04
DIVERGENCIA_DE_PROJETO                -> retorna ao Passo 03
CAPACIDADE_ERP_INCORRETA_OU_INSUFICIENTE -> retorna ao Passo 02
BUG_NA_INTEGRACAO_GENERICA            -> encaminha ao ERP Parceiro (menor passo responsavel, tipicamente o Passo 06); a combinacao ja homologada pode precisar de nova rodada de auditoria la
BUG_OU_DIVERGENCIA_DA_FERRAMENTA      -> jornada da ferramenta responsavel
CONTRATO_DA_FERRAMENTA_DIVERGENTE     -> ERP Parceiro, jornada responsavel pela ferramenta
```

`BUG_NA_INTEGRACAO_GENERICA` se aplica quando o fluxo materializado corretamente ainda assim falha por causa do codigo da integracao (nao da configuracao deste cliente, nao da ferramenta isolada) -- ou seja, um caso que a homologacao generica do ERP Parceiro nao cobriu. O Passo 05 nao corrige codigo; apenas classifica e encaminha.

O Passo 05 nao corrige silenciosamente nenhuma origem upstream.

## Gate de entrada obrigatorio

Resolver e retornar:

```text
PASSO_04_CONCLUIDO: SIM | NAO
AUDITORIA_PASSO_04: APROVADA | NAO_APROVADA
PRONTO_PARA_VALIDACAO_HML: SIM | NAO
PLANO_E_MATERIALIZACAO_VIGENTES: SIM | NAO | EVIDENCIA_INSUFICIENTE
OPERADOR_HUMANO_DISPONIVEL: SIM | NAO
```

Se `PASSO_04_CONCLUIDO = NAO`, ou `AUDITORIA_PASSO_04 != APROVADA`, ou `PRONTO_PARA_VALIDACAO_HML = NAO`, retornar ao Passo 04 sem tentar completar a lacuna por conta propria. Se `OPERADOR_HUMANO_DISPONIVEL = NAO`, bloquear a homologacao funcional (a validacao tecnica isolada nao substitui a funcional).

## Auto-descoberta obrigatoria

Resolver automaticamente antes de perguntar:

1. cliente, ERP, ferramenta, slugs e combinacao ativa;
2. saida valida dos Passos 01 a 04 para esta combinacao;
3. criterios de aceite do Passo 03 e itens materializados do Passo 04;
4. matriz funcional ja homologada da combinacao (Passo 08 do ERP Parceiro);
5. checkpoints da propria execucao do Passo 05 para esta combinacao.

Perguntar ao operador somente por evidencia realmente ausente e bloqueante -- em especial a disponibilidade do operador humano para a homologacao funcional.

## Processo obrigatorio

Executar na ordem:

1. validar contexto e gate do Passo 04;
2. verificar vigencia do plano do Passo 03 e da instalacao materializada do Passo 04;
3. derivar cenarios tecnicos e funcionais a partir dos criterios de aceite e da matriz funcional homologada;
4. executar a validacao tecnica: reconsultar e comparar planejado x observado para cada fluxo materializado;
5. conduzir a homologacao funcional manual assistida: gerar roteiro por cenario, coletar retorno do operador humano, classificar resultado;
6. classificar cada falha encontrada e apontar o menor passo responsavel, sem corrigir upstream;
7. aplicar a politica de criticidade para decidir prontidao;
8. consolidar pendencias, bloqueios e riscos;
9. gerar os outputs obrigatorios da etapa;
10. executar Harness aplicavel e encerrar com `AUDITORIA: AGUARDANDO_INDEPENDENTE`.

## Outputs obrigatorios

Na memoria canonica do cliente:

```text
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/VALIDACAO-HML-DO-CLIENTE.yaml
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/RELATORIO-DE-VALIDACAO-DO-CLIENTE.md
```

Nos controles Harness, quando aplicavel:

```text
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-05.yaml
parceiros/execucoes/clientes/<cliente-slug>/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

Nota de cobertura do Harness: hoje `scripts/harness/` nao possui validacao especifica para o caminho `parceiros/execucoes/clientes/...`. Registrar como pendencia de Harness, nao inventar validacao mecanica que nao existe.

## Auditoria obrigatoria desta etapa

Esta e a primeira validacao real da jornada ERP Cliente para uma combinacao. Conforme `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`, a primeira execucao real de uma combinacao exige auditoria independente `PROFUNDA`, separada da execucao produtora e somente leitura dos artefatos auditados.

A execucao produtora do Passo 05 nunca declara `AUDITORIA: APROVADA` nem `STATUS_DA_ETAPA: CONCLUIDA`. Ela sempre encerra com `AUDITORIA: AGUARDANDO_INDEPENDENTE` e `STATUS_DA_ETAPA: PENDENTE`.

## Gate final obrigatorio da execucao produtora

Retornar exatamente:

```text
VALIDACAO_TECNICA_HML_CLIENTE: APROVADA | PARCIAL_JUSTIFICADA | REPROVADA | BLOQUEADA
CRITERIOS_DE_ACEITE_ATENDIDOS: SIM | PARCIAL | NAO
CENARIOS_CRITICOS_REPROVADOS_OU_PENDENTES: <quantidade>
CENARIOS_ALTOS_REPROVADOS: <quantidade>
HOMOLOGACAO_FUNCIONAL_CLIENTE: APROVADA | REPROVADA | BLOQUEADA
FALHAS_BLOQUEANTES: <quantidade>
ESCRITA_PRODUCAO: NAO
SEGREDO_PERSISTIDO: NAO
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS_DA_ETAPA: PENDENTE
PRONTO_PARA_PRODUCAO: NAO
PROXIMO_PASSO: AUDITORIA_INDEPENDENTE_PASSO_05
```

Somente a auditoria independente `PROFUNDA` aprovada pode atualizar os controles autorizados para:

```text
AUDITORIA: APROVADA
STATUS_DA_ETAPA: CONCLUIDA
PRONTO_PARA_PRODUCAO: SIM
PROXIMO_PASSO: ERP_CLIENTE_06
```

## Como chamar

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-CLIENTE-05-VALIDAR-HML-E-PREPARAR-PRODUCAO.md

Materialize somente o Passo 05 da jornada ERP Cliente:
VALIDAR HML E PREPARAR PRODUCAO.

Cliente:
[identificacao conhecida]

ERP:
[erp informado]

Ferramenta E-Catalogos:
[ferramenta informada]

Operador humano disponivel para validacao funcional manual:
[SIM/NAO]

Regras obrigatorias:
- nao materializar nem corrigir configuracao (retornar ao Passo 04 se houver problema);
- nao reprojetar nem reclassificar nada dos Passos 02/03;
- nao re-homologar a integracao generica ERP x ferramenta;
- nao usar automacao de navegador nem observer realtime;
- nao usar producao sob nenhuma circunstancia;
- nao persistir segredo em nenhum artefato;
- nao usar PARCIALMENTE_APROVADO como status de cenario;
- aplicar a politica de criticidade antes de declarar prontidao;
- nao se autoaprovar -- encerrar com AUDITORIA: AGUARDANDO_INDEPENDENTE e STATUS_DA_ETAPA: PENDENTE.

Reutilize a instalacao materializada do Passo 04 e os criterios de aceite do Passo 03 para esta combinacao.

Gere somente os artefatos de validacao do Passo 05.
Finalize com o gate completo da etapa.

Nao faca commit.
Nao faca push.
```

### PARE DE COPIAR AQUI
