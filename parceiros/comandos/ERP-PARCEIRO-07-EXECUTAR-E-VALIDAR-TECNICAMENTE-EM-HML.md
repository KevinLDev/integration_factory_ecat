# ERP Parceiro - Passo 07 - Executar e validar tecnicamente em HML

## Finalidade

Executar em ambientes HML autorizados a implementacao aprovada no Passo 06 e produzir evidencia tecnica reproduzivel dos flows aprovados no Passo 05.

O Passo 07 e uma execucao produtora. Ele nao executa a auditoria independente que aprova sua propria evidencia.

## Resultado tecnico pretendido

```text
VALIDACAO_TECNICA_HML: APROVADA
```

Somente apos auditoria independente e gate completo a combinacao pode receber:

```text
PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM
```

Em nenhuma situacao o Passo 07 declara `INTEGRACAO_HOMOLOGADA`.

## Doutrina obrigatoria

Antes de executar, ler integralmente:

- `AGENTS.md` e `parceiros/AGENTS.md`;
- `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`;
- `documentacao/15-MAPEAMENTO-SEMANTICO-DE-INTEGRACOES.md`;
- `documentacao/16-DESENVOLVIMENTO-DE-INTEGRACOES.md`;
- `documentacao/17-VALIDACAO-TECNICA-DE-INTEGRACOES-EM-HML.md`;
- `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`;
- documentos tecnicos e operacionais dos Passos 01 a 06 aplicaveis;
- modelos de desenvolvimento e `parceiros/modelos/hml/`;
- manifestos, estados, auditorias, checkpoints, Base Mestra e artefatos vigentes da combinacao.

## Gate de entrada obrigatorio

Resolver e registrar:

```text
ERP_IDENTIFICADO: SIM | NAO
FERRAMENTA_HOMOLOGADA: SIM | NAO
GATES_UPSTREAM_EXIGIDOS: ATENDIDOS | NAO_ATENDIDOS
PASSO_06_PRONTO_PARA_EXECUCAO_HML: SIM | NAO
IMPLEMENTACAO_VIGENTE: SIM | NAO
BASE_MESTRA_HML_APTA: SIM | NAO
AMBIENTE_HML_VALIDADO: SIM | NAO
AUTORIZACAO_HML: SIM | NAO
```

Nao generalizar que todos os Passos 01 a 06 possuem a mesma auditoria ou manifesto. Validar somente os controles exigidos pela jornada e pelos artefatos que a combinacao realmente consome.

`PASSO_06_PRONTO_PARA_EXECUCAO_HML: SIM` e obrigatorio. A implementacao deve ter versao, hash e commit quando disponivel. A Base Mestra precisa ser vigente e sustentar os cenarios selecionados.

Se qualquer requisito falhar, retornar `PENDENTE` ou `BLOQUEADA` antes de chamada externa mutavel.

## Ambiente, autorizacao e segredos

Antes da primeira escrita:

1. provar que ERP e ferramenta apontam para HML, teste, sandbox, homologacao ou DEV autorizado;
2. registrar fingerprint nao sensivel de cada ambiente e a evidencia da classificacao;
3. bloquear se houver duvida de producao;
4. validar autorizacao explicita para combinacao, versao, ambiente e classes de escrita;
5. limitar as operacoes as classes autorizadas.

Credenciais podem ser recebidas e usadas de modo transitorio quando autorizadas. Sao proibidas em Git, manifesto, checkpoint, log, fixture, relatorio, evidencia e retorno. Registrar somente presenca, mecanismo seguro e resultado sanitizado.

## Inputs obrigatorios

Localizar, quando aplicaveis:

```text
erps/<erp-slug>/homologacao/BASE-MESTRA-MATERIALIZADA.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/MAPEAMENTO-SEMANTICO.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/REGRAS-DE-TRANSFORMACAO.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/PLANO-DA-INTEGRACAO.md
erps/<erp-slug>/integracoes/<ferramenta-slug>/MANIFESTO-DA-IMPLEMENTACAO.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-DESENVOLVIMENTO.md
erps/<erp-slug>/integracoes/<ferramenta-slug>/PENDENCIAS.md
ferramentas/<ferramenta-slug>/CONTRATO-DA-FERRAMENTA.yaml
ferramentas/<ferramenta-slug>/HOMOLOGACAO-PARA-INTEGRACOES.md
```

Usar ainda o codigo da combinacao, seus testes, configuracao tipada, estados, manifestos, auditorias e checkpoints aplicaveis.

## Processo obrigatorio

1. Resolver identidade e contexto sem pedir dados ja persistidos.
2. Validar gates exigidos, vigencia, codigo, Base Mestra e pendencias.
3. Congelar baseline com hashes, versao da implementacao, ambientes redigidos e autorizacao.
4. Criar `PLANO-DE-EXECUCAO-HML.yaml` a partir do modelo global.
5. Validar ambiente e autorizacao novamente antes da primeira escrita.
6. Executar casos por flow, respeitando dependencias, direcao, evento, ownership e escopo aprovados.
7. Persistir evidencia sanitizada por caso em `EVIDENCIAS-DE-EXECUCAO-HML.yaml`.
8. Reconsultar destino, comparar semanticamente e registrar correlacoes.
9. Criar checkpoint em ponto seguro, revalidar baseline antes de retomar e tratar reprocessamento conscientemente.
10. Classificar falhas pelo menor passo responsavel, sem corrigir upstream silenciosamente.
11. Gerar relatorio tecnico, estado, manifesto e controles permitidos da execucao produtora.
12. Executar Harness aplicavel e retornar o resultado sem iniciar auditoria aprovadora, homologacao funcional, publicacao ou etapa posterior.

## Regras de execucao segura

### Escrita e confirmacao

- Executar somente operacoes e classes de escrita autorizadas.
- Fazer lookup por correlacao ou chave segura antes de escrever quando aplicavel.
- Nao assumir upsert por `PUT` ou ausencia por listagem incompleta.
- Reconsultar destino apos escrita relevante.
- Nao confirmar origem ou avancar watermark antes de confirmacao valida no destino.
- Nao executar rollback destrutivo automatico em falha parcial.

### Correlacao, idempotencia e loop

- Usar `ERP_ID <-> ID_LOGICO <-> TOOL_ID`; nome nao e identidade.
- Executar caso repetido para validar idempotencia quando o flow tiver escrita.
- Em fluxo bidirecional, validar originador da alteracao, ownership, conflito e prevencao de loop definidos no Passo 05.
- Atualizacao refletida pela propria integracao nao pode gerar evento independente.

### Retry, auth, rate limit e timeout

- Retry limitado somente para falha transitoria e operacao segura.
- `429` respeita `Retry-After` quando disponivel.
- `5xx` e timeout podem receber retry limitado somente apos avaliar idempotencia e estado do destino.
- Nao executar retry cego de `4xx`, validacao, mapping, semantica ou contrato.
- Apos `401`, permitir no maximo um refresh/reautenticacao e um retry controlado; nova falha encerra o caso.
- Em estado incerto apos timeout, reconsultar o destino antes de repetir escrita. Se nao for observavel, interromper e registrar.

### Paginacao, checkpoint e retomada

- Percorrer integralmente paginas, cursores ou tokens aplicaveis.
- Nao tratar a primeira pagina como conjunto completo sem evidencia.
- Respeitar limites documentados de batch, ordenacao e concorrencia.
- Checkpoint protege baseline, arquivos produzidos, arquivos protegidos, ultimo ponto seguro e proxima fase, sem segredo.
- Retomada exige revalidar hashes, ambientes, autorizacao, correlacoes e baseline. Divergencia externa interrompe a retomada automatica.

## Evidencias obrigatorias

Usar `MODELO-EVIDENCIAS-DE-EXECUCAO-HML.yaml`. Para cada caso, registrar:

- `execution_id`, flow, direcao, entidade e ID logico;
- ERP ID, Tool ID, operacao, `correlation_id`, tentativa e origem da alteracao;
- resultado esperado e observado sanitizados;
- lookup, escrita, reconsulta e comparacao semantica;
- retry, paginacao, checkpoint, retomada e reprocessamento quando aplicaveis;
- timestamp, versao/hash/commit do codigo, status e erro sanitizado.

Status validos:

```text
CONFIRMADO
DIVERGENTE
NAO_OBSERVAVEL
PENDENTE_DE_EVIDENCIA
NAO_APLICAVEL
FALHOU_NA_EXECUCAO
```

## Classificacao de falhas

| Classificacao                       | Regra                                                                                  | Acao                                                                |
| ----------------------------------- | -------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| `ERRO_DE_EXECUCAO_HML`              | Problema operacional da propria execucao.                                              | Tratar ou reprocessar no Passo 07 somente quando seguro.            |
| `BUG_DE_IMPLEMENTACAO`              | Codigo nao cumpre projeto vigente.                                                     | Retornar ao Passo 06.                                               |
| `DIVERGENCIA_DE_PROJETO`            | Mapeamento, transformacao, flow, direcao, ownership ou decisao semantica e inadequado. | Retornar ao Passo 05.                                               |
| `BASE_DE_HOMOLOGACAO_INSUFICIENTE`  | Base Mestra nao sustenta o cenario.                                                    | Retornar ao Passo 03 ou 04 conforme planejamento ou materializacao. |
| `EVIDENCIA_DE_ERP_INSUFICIENTE`     | Capacidade do ERP nao esta sustentada.                                                 | Retornar ao Passo 02.                                               |
| `CONTRATO_DA_FERRAMENTA_DIVERGENTE` | Contrato da ferramenta diverge do comportamento necessario.                            | Bloquear e retornar a jornada responsavel pela ferramenta.          |

Nenhuma classificacao upstream pode ser corrigida escondida no Passo 07.

## Outputs de uma execucao real

Na memoria da combinacao:

```text
erps/<erp-slug>/integracoes/<ferramenta-slug>/PLANO-DE-EXECUCAO-HML.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/EVIDENCIAS-DE-EXECUCAO-HML.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-VALIDACAO-TECNICA-HML.md
```

Nos controles Harness:

```text
parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-07.yaml
parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

Reutilizar os modelos genericos de manifesto e checkpoint. Nao criar duplicacao especifica desses controles.

## Gate tecnico da execucao produtora

```text
AMBIENTE_HML_VALIDADO: SIM | NAO
AUTORIZACAO_HML: SIM | NAO
IMPLEMENTACAO_VIGENTE: SIM | NAO
BASE_MESTRA_HML_APTA: SIM | NAO
FLUXOS_APLICAVEIS_EXECUTADOS: SIM | PARCIAL_JUSTIFICADO | NAO
CORRELACOES_VALIDAS: SIM | PARCIAIS | NAO
IDEMPOTENCIA_APROVADA: SIM | NAO | NAO_APLICAVEL
PREVENCAO_DE_LOOP_APROVADA_QUANDO_APLICAVEL: SIM | NAO | NAO_APLICAVEL
RECONCILIACAO_APROVADA: SIM | PARCIAL_JUSTIFICADA | NAO
REPROCESSAMENTO_SEGURO: SIM | NAO | NAO_APLICAVEL
FALHAS_BLOQUEANTES: <quantidade>
DIVERGENCIAS_DE_PROJETO: <quantidade>
ESCRITA_PRODUCAO: NAO
HOMOLOGACAO_FUNCIONAL_EXECUTADA: NAO
PUBLICACAO_EXECUTADA: NAO
VALIDACAO_TECNICA_HML: APROVADA | PARCIAL_JUSTIFICADA | REPROVADA | BLOQUEADA
AUDITORIA: AGUARDANDO_INDEPENDENTE
PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: NAO_ATE_AUDITORIA
```

Execucao tecnicamente aprovada termina com `STATUS DA ETAPA: PENDENTE` enquanto aguarda auditoria. Auditoria reprovada tambem retorna `PENDENTE`; bloqueio externo retorna `BLOQUEADA`.

## Auditoria independente posterior

Nao executar auditoria aprovadora na mesma execucao produtora. A auditoria posterior usa `parceiros/auditorias/AUDITAR-ETAPA.md`, declara os artefatos imutaveis, executa validadores, recalcula hashes e compara projeto, implementacao, ambiente redigido, plano, evidencias e relatorio sem corrigir nenhum deles.

Quando esta for a primeira execucao HML real da combinacao, o modo obrigatorio e `PROFUNDA`.

Somente a auditoria independente aprovada pode promover o gate para:

```text
STATUS DA ETAPA: CONCLUIDA
VALIDACAO_TECNICA_HML: APROVADA
PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM
```

## Fronteiras proibidas

Nao executar:

- producao;
- homologacao funcional por aplicativo ou painel;
- publicacao ou registro em `erps-integrados/`;
- runtime 24/7, deploy ou monitoramento operacional definitivo;
- configuracao de cliente real;
- alteracao de contrato, Base Mestra, mapeamento ou codigo para fazer HML passar;
- commit ou push automatico.

## Como chamar

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-07-EXECUTAR-E-VALIDAR-TECNICAMENTE-EM-HML.md

Continue a jornada ERP parceiro da combinacao ja identificada e execute somente o Passo 07.

Autorizacao explicita para HML: [SIM]
Ambiente autorizado ERP: [HML | HOMOLOGACAO | SANDBOX | TESTE | DEV_AUTORIZADO]
Ambiente autorizado ferramenta: [HML | HOMOLOGACAO | SANDBOX | TESTE | DEV_AUTORIZADO]
Classes de escrita permitidas: [LISTA]
Regras adicionais: [SE HOUVER]

Descubra gates, Base Mestra, codigo, projeto, manifestos, auditorias e checkpoint automaticamente. Antes da primeira escrita, prove ambiente nao produtivo, valide autorizacao e registre fingerprint nao sensivel.

Execute somente flows aprovados, com lookup, correlacao, reconsulta e comparacao semantica. Valide idempotencia, loop, paginacao, retry/rate limit, falha parcial, checkpoint, retomada e reprocessamento quando aplicaveis.

Nao altere projeto, Base Mestra, contrato ou codigo para fazer HML passar. Classifique falhas e retorne ao menor passo responsavel.

Nao use producao, nao homologue funcionalmente, nao publique, nao crie runtime/deploy/monitoramento, nao configure cliente real, nao persista segredos, nao faca commit ou push.

Gere plano, evidencias, relatorio, manifesto e checkpoint aplicaveis. Nao execute auditoria aprovadora nesta mesma execucao. Pare apos o retorno produtor do Passo 07.
```

### PARE DE COPIAR AQUI
