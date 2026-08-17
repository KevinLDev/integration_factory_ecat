# 18 - Homologacao funcional de integracoes

## 1. Objetivo

Este documento define o padrao global do ERP Parceiro - Passo 08 - Homologar funcionalmente a integracao.

Sequencia oficial vigente:

```text
PASSO 01 -> identifica o ERP
PASSO 02 -> comprova capacidades do ERP
PASSO 03 -> projeta homologacao e base
PASSO 04 -> materializa Base de Homologacao
PASSO 05 -> projeta mapeamento semantico
PASSO 06 -> desenvolve e testa localmente
PASSO 07 -> executa e valida tecnicamente em HML
PASSO 08 -> homologa funcionalmente o uso da ferramenta
```

O Passo 08 responde, com evidencia funcional:

> A integracao tecnicamente aprovada no Passo 07 realmente permite executar corretamente os processos de negocio suportados na ferramenta E-Catalogos?

## 2. Fronteira obrigatoria entre Passo 07 e Passo 08

O Passo 07 permanece responsavel por validacao tecnica, incluindo request/response, correlacao, identidade, idempotencia, paginacao, retry, rate limit, prevencao de loop, checkpoint, retomada, reprocessamento e reconciliacao tecnica.

O Passo 08 valida o comportamento funcional percebido no uso da ferramenta, por perfil de ator e por processo de negocio suportado na combinacao.

Regra:

- Passo 08 pode referenciar evidencias tecnicas do Passo 07.
- Passo 08 nao duplica a execucao tecnica completa do Passo 07.

## 3. Modelo V1 oficial

A V1 do Passo 08 e:

```text
HOMOLOGACAO FUNCIONAL MANUAL ASSISTIDA POR IA
```

Responsabilidades na V1:

- HUMANO executa manualmente as acoes de interface na ferramenta em HML.
- IA deriva cenarios, gera roteiro operacional, informa observacoes esperadas, coleta retorno manual, classifica resultado, organiza evidencias e produz relatorio.

Proibicoes da V1:

- sem browser automation;
- sem controle automatico de navegador;
- sem observer realtime;
- sem monitoramento de eventos de interface em tempo real.

Automacao futura pode ser descrita apenas como evolucao, nunca como requisito para usar a V1.

## 4. Derivacao do escopo funcional

A matriz funcional nao e checklist universal.

Ela deve ser derivada da combinacao:

```text
ERP x FERRAMENTA
```

Somente incluir areas com suporte comprovado por artefatos vigentes upstream. Areas possiveis, quando suportadas:

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

## 5. Estrutura minima de cenario funcional

Cada cenario deve conter, no minimo:

- scenario_id
- area_funcional
- criticidade
- perfil_ator
- executor
- pre_condicoes
- dados_de_teste
- acoes_do_operador
- resultado_esperado
- resultado_observado
- evidencias
- status
- dependencias
- artefatos_upstream
- classificacao_da_falha
- menor_passo_responsavel

Na V1, `executor` deve ser `HUMANO` (ou equivalente semantico que mantenha execucao manual).

## 6. Status de cenario

Status permitidos:

- APROVADO
- REPROVADO
- BLOQUEADO
- NAO_APLICAVEL
- PENDENTE
- PENDENTE_DE_EVIDENCIA

Regra obrigatoria:

- `PARCIALMENTE_APROVADO` e proibido para evitar mascaramento de cenario critico.
- `NAO_APLICAVEL` exige justificativa e vinculo ao escopo comprovado.

## 7. Criticidade e criterio de homologacao

Criticidades permitidas:

- CRITICO
- ALTO
- MEDIO
- BAIXO

Politica minima:

- qualquer cenario `CRITICO` com status `REPROVADO` bloqueia homologacao funcional;
- cenario `CRITICO` em `PENDENTE`, `PENDENTE_DE_EVIDENCIA` ou `BLOQUEADO` tambem bloqueia conclusao;
- para cenarios `ALTO`, o limite deve ser zero reprovado para concluir sem ressalva;
- nao homologar por percentual.

Exemplo:

```text
49 APROVADOS + 1 CRITICO REPROVADO -> INTEGRACAO_HOMOLOGADA: NAO
```

## 8. Roteiro operacional orientado ao operador

Cada cenario deve instruir o operador de forma concreta com blocos:

- PRE-CONDICOES
- FACA (passo a passo)
- OBSERVE (campos e comportamentos)
- CONFIRME (resultado no destino quando aplicavel)
- EVIDENCIA SOLICITADA

Formato generico de evidencia solicitada:

- screenshot quando util;
- IDs de referencia (ferramenta e ERP quando aplicavel);
- horario aproximado;
- descricao objetiva do observado.

## 9. Registro manual simplificado (sem observer)

Como a V1 nao possui captura em tempo real, o retorno manual deve ser simples e padronizado. Exemplo:

```text
CENARIO: HF-PED-014
EXECUTADO: SIM
RESULTADO_OBSERVADO: ...
IDS: forca=... ; erp=...
EVIDENCIAS: ...
OBSERVACOES: ...
```

A IA deve converter esse retorno em:

- status do cenario;
- classificacao_da_falha;
- menor_passo_responsavel;
- reexecucao_necessaria.

## 10. Evidencia funcional minima

Cada evidencia funcional deve vincular:

- scenario_id
- perfil_ator
- timestamp
- baseline/versao
- resultado_esperado
- resultado_observado
- dados_sanitizados
- IDs quando uteis
- screenshot/video quando uteis
- referencia tecnica do Passo 07 quando aplicavel
- status
- classificacao

Regras:

- screenshot isolado nao comprova cenario completo;
- texto "funcionou" isolado nao comprova cenario critico;
- nunca persistir senha, token, Authorization, segredo ou dado pessoal desnecessario.

## 11. Taxonomia de falhas e menor passo responsavel

Classificacoes oficiais:

- BUG_DE_IMPLEMENTACAO -> Passo 06
- DIVERGENCIA_DE_PROJETO -> Passo 05
- BASE_DE_HOMOLOGACAO_INSUFICIENTE -> Passo 03 ou Passo 04
- CAPACIDADE_ERP_INCORRETA_OU_INSUFICIENTE -> Passo 02
- FALHA_TECNICA_HML -> Passo 07
- BUG_OU_DIVERGENCIA_DA_FERRAMENTA -> jornada da ferramenta
- FALHA_FUNCIONAL_DO_CENARIO -> Passo 08

O Passo 08 nao corrige silenciosamente upstream.

## 12. Reexecucao e invalidacao

Quando houver correcao upstream, os cenarios funcionais dependentes devem retornar para execucao.

Mudancas em Passos 02, 03, 04, 05, 06 ou 07 invalidam somente o alcance funcional dependente, preservando historico e recalculando vigencia por manifesto/hashes.

Regras:

- nao restaurar aprovacao antiga automaticamente;
- nao criar mecanismo paralelo ao Harness;
- usar manifesto, checkpoint e validadores existentes quando aplicavel.

## 13. Harness e limites de automacao

Harness pode validar mecanicamente:

- existencia de arquivos;
- estrutura de campos;
- IDs;
- statuses permitidos;
- referencias;
- hashes;
- gates de estado.

Harness nao pode afirmar sozinho comportamento funcional percebido em tela.

Validacao mecanica nao substitui homologacao funcional.

## 14. Gate da execucao produtora do Passo 08

A execucao produtora do Passo 08 deve terminar com:

```text
HOMOLOGACAO_FUNCIONAL: APROVADA | REPROVADA | BLOQUEADA
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS DA ETAPA: PENDENTE
INTEGRACAO_HOMOLOGADA: NAO
```

Mesmo quando tecnicamente e funcionalmente consistente, a execucao produtora nao pode se auto-homologar.

## 15. Gate pos-auditoria independente

Somente apos auditoria independente aprovada:

```text
HOMOLOGACAO_FUNCIONAL: APROVADA
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
INTEGRACAO_HOMOLOGADA: SIM
```

Este e o primeiro passo que pode levar a `INTEGRACAO_HOMOLOGADA: SIM` para a combinacao.

Isso nao significa publicacao, onboarding de cliente, runtime definitivo ou producao.

## 16. Fronteira com capacidades futuras

O Passo 08 apenas deixa o handoff conceitual:

```text
INTEGRACAO_HOMOLOGADA: SIM -> elegivel para o Passo 09 de publicacao
```

Este documento nao define as regras do Passo 09. Para publicacao, consulte `documentacao/19-PUBLICACAO-DE-INTEGRACOES-HOMOLOGADAS.md`.

## 17. Referencias historicas

Implementacoes antigas (incluindo Pipedream) continuam apenas como referencia historica para inspirar cenarios, sempre confrontadas com contrato, mapeamento e artefatos vigentes.

Nao sao autoridade atual.
