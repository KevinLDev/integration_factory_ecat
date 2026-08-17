# 17 - Validacao tecnica de integracoes em HML

## 1. Objetivo

Este documento define o padrao global do ERP Parceiro - Passo 07 - Executar e Validar Tecnicamente em HML.

O Passo 07 executa em ambiente HML autorizado a implementacao aprovada no Passo 06 e produz evidencia tecnica reproduzivel sobre os flows aprovados no Passo 05.

```text
PASSO 05 -> decide
PASSO 06 -> implementa e testa localmente
PASSO 07 -> executa e valida tecnicamente em HML
```

O resultado tecnico maximo da execucao produtora e `VALIDACAO_TECNICA_HML_APROVADA`, registrado no gate como:

```text
VALIDACAO_TECNICA_HML: APROVADA
```

A execucao produtora encerra obrigatoriamente com:

```text
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS DA ETAPA: PENDENTE
PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: NAO
```

Somente depois de auditoria independente `APROVADA`, pelos deltas de estado e manifesto ja autorizados pelas regras de auditoria, podem coexistir:

```text
VALIDACAO_TECNICA_HML: APROVADA
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM
```

O Passo 07 nunca declara `INTEGRACAO_HOMOLOGADA`. A homologacao funcional pertence ao Passo 08 e e executada em modelo manual assistido por IA. Publicacao, runtime operacional, onboarding de cliente e producao pertencem a capacidades posteriores.

## 2. Escopo e autoridade

A ferramenta E-Catalogos continua soberana sobre o contrato. O Passo 07 executa somente flows, direcoes, eventos, ownership, identidades, correlacoes e transformacoes ja definidos no projeto vigente. Evidencia HML nova pode confirmar ou contestar uma decisao, mas nao autoriza altera-la silenciosamente.

A Base Mestra materializada no Passo 04 e a evidencia comercial de partida para os cenarios selecionados. Ela deve ser reutilizada por ID logico e correlacoes vigentes, sem recriacao, redesenho ou uso de IDs fisicos como configuracao reutilizavel.

## 3. Pre-condicoes

Antes de qualquer chamada externa, resolver automaticamente ERP, ferramenta, combinacao, estado, manifestos, auditorias, checkpoints e artefatos aplicaveis.

Todos os gates upstream exigidos pela jornada devem estar concluidos quando aplicavel, vigentes, reutilizaveis e sem divergencia bloqueante. O Passo 07 nao presume que todos os Passos 01 a 06 possuam o mesmo tipo de auditoria ou manifesto; ele valida os controles requeridos por cada artefato que consumir.

Exigir obrigatoriamente:

- Passo 06 com `PRONTO_PARA_EXECUCAO_HML: SIM`;
- implementacao identificavel por versao, hash e commit quando houver Git;
- projeto do Passo 05 vigente e aderente a implementacao;
- Base Mestra vigente e apta aos cenarios HML selecionados;
- ambiente HML, teste, sandbox ou homologacao autorizado para ERP e ferramenta;
- autorizacao explicita do operador para a combinacao, versao, ambientes e classes de escrita permitidas;
- plano de execucao HML com flows e cenarios selecionados.

Se a vigencia, a autorizacao, a identidade, a Base Mestra ou o ambiente nao puderem ser comprovados, bloquear antes da primeira escrita. Nao atualizar hash, estado ou baseline para fazer o gate passar.

## 4. Ambiente, credenciais e seguranca

Antes da primeira escrita, registrar um fingerprint nao sensivel para cada ambiente: identificador do sistema, base URL redigida quando necessario, classificacao HML/teste/sandbox/homologacao, conta ou tenant sem segredo e evidencia de configuracao. O texto da URL, isoladamente, nao prova que o ambiente nao e producao.

Se houver duvida de producao em qualquer lado do flow, bloquear. Producao nunca e fallback.

Credenciais reais podem ser recebidas e usadas transitoriamente quando houver autorizacao, mas sao proibidas em Git, manifesto, checkpoint, log, fixture, relatorio, evidencia e resposta ao operador. Preferir mecanismo de secrets existente, variavel de ambiente, secret store ou arquivo local ignorado. Registrar apenas presenca, tipo e resultado sanitizado da autenticacao.

## 5. Execucao segura

Cada caso HML deve indicar flow, direcao, entidade, ID logico, operacao, correlacao, origem da alteracao, resultado esperado e confirmacao exigida no destino.

### 5.1 Escrita, lookup e confirmacao

- Consultar a correlacao, chave segura ou estado conhecido antes de escrever quando aplicavel.
- Nao usar a regra "nao encontrei localmente, entao POST".
- Separar create, update e upsert conforme a capacidade comprovada; `PUT` nao prova upsert.
- Apos escrita relevante, reconsultar o destino por ID, correlacao ou listagem filtrada confiavel e paginada.
- Nao confirmar origem, avancar watermark ou marcar caso como confirmado antes da confirmacao valida do destino.
- Falha parcial nao dispara rollback destrutivo automatico. Preservar o estado conhecido e registrar o proximo passo seguro.

### 5.2 Correlacao, idempotencia e loop

Usar a correlacao planejada:

```text
ERP_ID <-> ID_LOGICO <-> TOOL_ID
```

Nome e descricao nunca sao identidade. O Passo 07 deve executar deliberadamente caso repetido para provar idempotencia quando o flow tiver escrita. A reexecucao nao pode criar registro adicional nem alterar dado fora da politica aprovada.

Para `BIDIRECIONAL_CONTROLADO`, validar a origem reconhecivel da alteracao, ownership, prioridade, conflito e prevencao de loop definidos no Passo 05. A atualizacao refletida pela propria integracao nao pode ser tratada como novo evento independente.

### 5.3 Retry, auth, rate limit e estado incerto

- Retry e limitado a falha transitoria e operacao segura conforme o projeto.
- `429` respeita `Retry-After` quando disponivel e a politica de rate limit comprovada.
- `5xx` e timeout podem receber retry limitado apenas quando a idempotencia e o estado do destino puderem ser comprovados.
- `4xx` funcional, `VALIDATION_ERROR`, `MAPPING_ERROR`, erro semantico e divergencia de contrato nao recebem retry cego.
- Apos `401`, permitir no maximo um refresh ou reautenticacao controlada e um retry por operacao. Nova falha encerra o caso.
- Apos timeout ou erro de rede com resultado incerto, nao repetir a escrita antes de consultar o destino pela correlacao e classificar o estado. Se a consulta nao resolver, registrar estado incerto e interromper o caso.

### 5.4 Paginacao, checkpoint, retomada e reprocessamento

Paginacao deve percorrer todas as paginas, cursores ou tokens aplicaveis. A primeira pagina nunca representa o conjunto completo sem evidencia. Batch, ordenacao e concorrencia seguem somente limites documentados ou configuracao validada.

Persistir checkpoint em pontos seguros: depois de confirmar lote ou entidade, antes de uma troca de fase e antes de pausar. O checkpoint registra baseline, hashes, arquivos produzidos e protegidos, ponto seguro e proxima fase, sem segredo nem payload sensivel.

Na retomada, validar novamente hashes, manifestos, autorizacao, fingerprint de ambiente e estado das correlacoes. Se houver divergencia externa, nao continuar automaticamente. Reprocessamento deve usar caso identificado, correlacao e estrategia de consulta antes de qualquer nova escrita.

## 6. Evidencias de execucao HML

Toda execucao deve produzir evidencias estruturadas por caso, sem persistir payload sensivel desnecessario. Cada caso registra no minimo:

- `execution_id`;
- referencia da versao, hash ou commit do codigo;
- flow e direcao;
- entidade e ID logico;
- ERP ID e Tool ID quando conhecidos;
- operacao, `correlation_id`, tentativa e origem da alteracao;
- resultado esperado e observado sanitizados;
- reconsulta e comparacao semantica origem-destino;
- timestamp, status e erro sanitizado quando houver.

Status permitidos por caso:

```text
CONFIRMADO
DIVERGENTE
NAO_OBSERVAVEL
PENDENTE_DE_EVIDENCIA
NAO_APLICAVEL
FALHOU_NA_EXECUCAO
```

Comparacao semantica usa os mappers e transformacoes aprovados. Diferenca de formato irrelevante nao deve ocultar diferenca de significado, e igualdade de HTTP nao prova igualdade de dados ou relacoes.

## 7. Menor passo responsavel

O Passo 07 classifica cada falha e retorna ao menor passo responsavel:

| Classificacao                       | Significado                                                                                                               | Tratamento                                                                                                                    |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `ERRO_DE_EXECUCAO_HML`              | Problema operacional desta execucao, como indisponibilidade transitoria, autorizacao expirada ou checkpoint interrompido. | Pode ser tratado ou reprocessado no Passo 07 somente quando seguro.                                                           |
| `BUG_DE_IMPLEMENTACAO`              | Codigo nao cumpre corretamente o projeto vigente.                                                                         | Retornar ao Passo 06.                                                                                                         |
| `DIVERGENCIA_DE_PROJETO`            | Mapeamento, transformacao, flow, direcao, ownership, evento ou decisao semantica e inadequado.                            | Retornar ao Passo 05.                                                                                                         |
| `BASE_DE_HOMOLOGACAO_INSUFICIENTE`  | Base Mestra nao sustenta o cenario requerido.                                                                             | Retornar ao Passo 03 se o planejamento for insuficiente, ou ao Passo 04 se a materializacao estiver incompleta ou divergente. |
| `EVIDENCIA_DE_ERP_INSUFICIENTE`     | Capacidade assumida do ERP nao esta sustentada em documentacao ou runtime.                                                | Retornar ao Passo 02.                                                                                                         |
| `CONTRATO_DA_FERRAMENTA_DIVERGENTE` | Contrato homologado da ferramenta diverge do comportamento que a integracao necessita provar.                             | Bloquear o flow e retornar a jornada responsavel pela ferramenta.                                                             |

Nenhuma capacidade posterior corrige silenciosamente a origem do problema. Um achado de projeto, Base, ERP ou contrato deve permanecer rastreavel na evidencia e no `PENDENCIAS.md` canonico da combinacao quando aplicavel.

## 8. Harness, vigencia e auditoria

Cada execucao usa o manifesto generico `parceiros/modelos/MANIFESTO-DA-ETAPA.yaml` em `parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-07.yaml` e o checkpoint generico `CHECKPOINT-DA-EXECUCAO.yaml` na propria execucao.

O manifesto declara fontes, entradas, saidas, dependencias upstream, hashes, gate de reutilizacao e vigencia. As entradas incluem somente os controles realmente exigidos: artefatos do Passo 05, manifesto e relatorio do Passo 06, Base Mestra, plano HML, versao da implementacao e autorizacao redigida. As saidas incluem evidencias HML, relatorio tecnico e eventual delta autorizado de estado ou pendencias. Segredos, tokens, payloads sensiveis e valores concretos de cliente nao sao entradas ou saidas versionadas.

Antes de retomar, `scripts/harness/` deve validar manifesto e checkpoint. Validadores mecanicos podem conferir estrutura, UTF-8, referencias, hashes, statuses permitidos e coerencia de gates; eles nao substituem comparacao semantica nem prova de ambiente.

Execucao produtora e auditoria independente sao separadas. A auditoria inicia somente depois de congelar plano, evidencias e relatorio produtores. A primeira execucao HML real de uma combinacao exige auditoria `PROFUNDA`, comparando fontes, projeto, implementacao, ambientes redigidos, casos, evidencias e gate sem reexecutar, corrigir ou regenerar a execucao auditada.

## 9. Gate da execucao produtora e promocao posterior

O gate da execucao produtora deve declarar, no minimo:

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
STATUS DA ETAPA: PENDENTE
PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: NAO
```

`VALIDACAO_TECNICA_HML: APROVADA` exige ambiente e autorizacao validos, implementacao e Base vigentes, todos os flows aplicaveis executados ou justificadamente nao aplicaveis, correlacoes validas, idempotencia e loop aprovados quando aplicaveis, reconciliacao suficiente, reprocessamento seguro e zero falhas bloqueantes ou divergencias de projeto.

A execucao produtora nao pode promover esses tres ultimos estados. Somente a auditoria independente `APROVADA` pode atualizar os controles autorizados para:

```text
VALIDACAO_TECNICA_HML: APROVADA
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM
```

`PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM` nao equivale a `INTEGRACAO_HOMOLOGADA`; apenas libera o Passo 08 para validar o comportamento funcional.

## 10. Limites explicitos

O Passo 07 nao pode:

- alterar decisao de mapeamento do Passo 05;
- corrigir divergencia de projeto, Base, ERP ou contrato no fluxo HML;
- redesenhar a Base Mestra;
- alterar contrato homologado da ferramenta;
- homologar funcionalmente pelo aplicativo ou painel;
- publicar integracao ou registrar ERP em `erps-integrados/`;
- criar runtime 24/7, deploy de producao ou monitoramento operacional definitivo;
- configurar cliente real;
- executar producao.

Capacidades posteriores ao Passo 07 tratam homologacao funcional (Passo 08), publicacao (Passo 09), runtime, monitoramento e ERP Cliente. Nenhuma delas e iniciada automaticamente pelo Passo 07.
