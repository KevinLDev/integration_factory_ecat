# ERP Parceiro - Passo 08 - Homologar funcionalmente a integracao

## Finalidade

Validar funcionalmente, com execucao manual do operador em HML assistida por IA, se a integracao tecnicamente aprovada no Passo 07 permite os processos de negocio suportados na ferramenta E-Catalogos.

O Passo 08 nao substitui o Passo 07 e nao repete toda a validacao tecnica.

## Modelo V1 oficial

```text
HOMOLOGACAO FUNCIONAL MANUAL ASSISTIDA POR IA
```

Na V1:

- HUMANO executa interface manualmente;
- IA orienta, coleta retorno, classifica e consolida.

Sem browser automation e sem observer realtime.

## Doutrina obrigatoria

Antes de executar, ler integralmente:

- `AGENTS.md` e `parceiros/AGENTS.md`;
- `parceiros/00-GUIA-DE-EXECUCAO.md`;
- `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`;
- `documentacao/15-MAPEAMENTO-SEMANTICO-DE-INTEGRACOES.md`;
- `documentacao/16-DESENVOLVIMENTO-DE-INTEGRACOES.md`;
- `documentacao/17-VALIDACAO-TECNICA-DE-INTEGRACOES-EM-HML.md`;
- `documentacao/18-HOMOLOGACAO-FUNCIONAL-DE-INTEGRACOES.md`;
- `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`;
- documentos dos Passos 01 a 07 aplicaveis;
- modelos em `parceiros/modelos/homologacao-funcional/`;
- manifesto/checkpoint e estado vigentes da combinacao.

## Gate de entrada obrigatorio

Resolver e registrar:

```text
ERP_IDENTIFICADO: SIM | NAO
FERRAMENTA_HOMOLOGADA: SIM | NAO
GATES_UPSTREAM_EXIGIDOS: ATENDIDOS | NAO_ATENDIDOS
PASSO_07_PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM | NAO
IMPLEMENTACAO_VIGENTE: SIM | NAO
BASELINE_FUNCIONAL_DEFINIDA: SIM | NAO
EXECUCAO_MANUAL_HML_DISPONIVEL: SIM | NAO
```

`PASSO_07_PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM` e obrigatorio.

Sem esse gate, encerrar com `STATUS DA ETAPA: BLOQUEADA`.

## Auto-descoberta obrigatoria

Antes de perguntar ao operador, descobrir automaticamente:

1. ERP, ferramenta, slugs e combinacao ativos;
2. status, manifestos, auditorias e checkpoint;
3. resultado vigente dos Passos 01 a 07;
4. escopo suportado da combinacao (mapeamento, transformacoes, plano, limites);
5. cenarios funcionais da ferramenta aplicaveis;
6. evidencias tecnicas do Passo 07 reutilizaveis;
7. pendencias abertas e impacto na homologacao funcional.

Solicitar ao operador somente o que nao puder ser inferido com seguranca.

## Escopo funcional derivado

Derivar a matriz por combinacao ERP x ferramenta e suporte comprovado. Nao usar checklist universal.

Areas possiveis quando suportadas:

- CLIENTES
- PRODUTOS
- VARIANTES
- GRADES
- PRECOS
- ESTOQUE
- VENDEDORES
- PREPOSTOS
- FILIAIS
- TABELAS_DE_PRECO
- CONDICOES_DE_PAGAMENTO
- PEDIDOS
- CANCELAMENTO
- DEVOLUCAO
- CAMPANHAS

## Estrutura obrigatoria de cenario

Cada cenario deve ter no minimo:

- `scenario_id`
- `area_funcional`
- `criticidade` (`CRITICO|ALTO|MEDIO|BAIXO`)
- `perfil_ator`
- `executor` (`HUMANO` na V1)
- `pre_condicoes`
- `dados_de_teste`
- `acoes_do_operador`
- `resultado_esperado`
- `resultado_observado`
- `evidencias`
- `status`
- `dependencias`
- `artefatos_upstream`
- `classificacao_da_falha`
- `menor_passo_responsavel`

## Status de cenario

Permitidos:

- `APROVADO`
- `REPROVADO`
- `BLOQUEADO`
- `NAO_APLICAVEL`
- `PENDENTE`
- `PENDENTE_DE_EVIDENCIA`

`PARCIALMENTE_APROVADO` e proibido.

`NAO_APLICAVEL` exige justificativa e vinculo ao escopo.

## Criterio de conclusao funcional

- qualquer `CRITICO` em `REPROVADO`, `BLOQUEADO`, `PENDENTE` ou `PENDENTE_DE_EVIDENCIA` bloqueia homologacao;
- para `ALTO`, nenhum `REPROVADO` e permitido para concluir sem ressalva;
- homologacao nao e por percentual.

## Registro manual simplificado exigido do operador

Formato esperado por cenario:

```text
CENARIO: <scenario_id>
EXECUTADO: SIM | NAO
RESULTADO_OBSERVADO: <texto curto objetivo>
IDS: ferramenta=<id-ou-NA>; erp=<id-ou-NA>
EVIDENCIAS: <screenshot/caminho/ref>
OBSERVACOES: <opcional>
```

A IA deve transformar o retorno em status, classificacao e menor passo responsavel.

## Taxonomia obrigatoria de falhas

- `BUG_DE_IMPLEMENTACAO` -> Passo 06
- `DIVERGENCIA_DE_PROJETO` -> Passo 05
- `BASE_DE_HOMOLOGACAO_INSUFICIENTE` -> Passo 03 ou 04
- `CAPACIDADE_ERP_INCORRETA_OU_INSUFICIENTE` -> Passo 02
- `FALHA_TECNICA_HML` -> Passo 07
- `BUG_OU_DIVERGENCIA_DA_FERRAMENTA` -> jornada da ferramenta
- `FALHA_FUNCIONAL_DO_CENARIO` -> Passo 08

Nao corrigir upstream silenciosamente durante homologacao funcional.

## Reexecucao e invalidacao

Mudanca upstream em Passos 02 a 07 invalida apenas o alcance funcional dependente.

Regras:

- cenarios afetados voltam para `PENDENTE`;
- aprovacoes antigas nao retornam automaticamente;
- preservar historico e recalcular vigencia por manifestos/hashes;
- reutilizar controle existente do Harness, sem mecanismo paralelo.

## Outputs de uma execucao real

Na memoria da combinacao:

```text
erps/<erp-slug>/integracoes/<ferramenta-slug>/PLANO-DE-HOMOLOGACAO-FUNCIONAL.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/MATRIZ-DE-CENARIOS-FUNCIONAIS.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/EVIDENCIAS-FUNCIONAIS.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-HOMOLOGACAO-FUNCIONAL.md
```

Nos controles Harness, quando aplicavel:

```text
parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-08.yaml
parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

## Gate da execucao produtora

```text
MATRIZ_FUNCIONAL_DERIVADA_DO_ESCOPO: SIM | NAO
CENARIOS_CRITICOS_EXECUTADOS: SIM | NAO
EVIDENCIA_FUNCIONAL_SUFICIENTE: SIM | PARCIAL | NAO
FALHAS_CRITICAS: <quantidade>
FALHAS_ALTAS: <quantidade>
REEXECUCOES_PENDENTES: <quantidade>
ESCRITA_PRODUCAO: NAO
AUTOMACAO_UI_IMPLEMENTADA: NAO
OBSERVER_REALTIME_IMPLEMENTADO: NAO
PASSO_09_EXECUTADO: NAO
PUBLICACAO_EXECUTADA: NAO
CLIENTE_REAL_UTILIZADO: NAO
HOMOLOGACAO_FUNCIONAL: APROVADA | REPROVADA | BLOQUEADA
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS DA ETAPA: PENDENTE
INTEGRACAO_HOMOLOGADA: NAO
```

## Promocao pos-auditoria independente

Somente apos auditoria aprovada:

```text
HOMOLOGACAO_FUNCIONAL: APROVADA
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
INTEGRACAO_HOMOLOGADA: SIM
```

## Fronteiras proibidas

- nao executar Passo 09;
- nao publicar integracao;
- nao registrar ERP em `erps-integrados/`;
- nao configurar cliente real;
- nao executar producao;
- nao automatizar UI;
- nao implementar observer realtime.

## Como chamar

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-08-HOMOLOGAR-FUNCIONALMENTE-INTEGRACAO.md

Continue a jornada ERP parceiro da combinacao ja identificada e execute somente o Passo 08.

Modelo V1:
HOMOLOGACAO FUNCIONAL MANUAL ASSISTIDA POR IA

Descubra automaticamente gates, baseline, mapeamento, transformacoes, plano, evidencias tecnicas do Passo 07 e escopo suportado da combinacao.

Exija PASSO_07_PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM antes de iniciar os cenarios.

Derive a matriz funcional do escopo real da combinacao.
Nao use checklist universal.

Para cada cenario entregue um roteiro concreto com:
- pre-condicoes;
- faca;
- observe;
- confirme;
- evidencia solicitada.

Colete meu retorno manual simplificado por cenario e transforme em:
- status;
- classificacao_da_falha;
- menor_passo_responsavel;
- reexecucao_necessaria.

Nao automatize navegador.
Nao implemente observer realtime.
Nao execute producao.
Nao use cliente real.
Nao publique integracao.
Nao execute Passo 09.

Gere:
- PLANO-DE-HOMOLOGACAO-FUNCIONAL.yaml
- MATRIZ-DE-CENARIOS-FUNCIONAIS.yaml
- EVIDENCIAS-FUNCIONAIS.yaml
- RELATORIO-DE-HOMOLOGACAO-FUNCIONAL.md
- manifesto/checkpoint genericos do Harness quando aplicaveis

Finalize como execucao produtora do Passo 08 com:
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS DA ETAPA: PENDENTE
INTEGRACAO_HOMOLOGADA: NAO

Nao execute auditoria aprovadora nesta mesma execucao.
Nao faca commit.
Nao faca push.
```

### PARE DE COPIAR AQUI
