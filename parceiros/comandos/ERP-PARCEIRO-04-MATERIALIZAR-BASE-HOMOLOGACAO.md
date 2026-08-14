# ERP Parceiro - Passo 04 - Materializar Base de homologacao

## Finalidade

Transformar, em execucao real autorizada, a BASE-COMERCIAL-PLANEJADA.yaml em registros reais no ERP de homologacao/teste e confirmar o resultado observado.

## Fronteira da etapa

Passo 04 materializa e confirma.

Passo 04 nao reprojeta base.

Passo 04 nao reanalisa nem reinterpreta regras de negocio; apenas verifica a vigencia do plano aprovado antes de materializar.

Passo 04 nao implementa Passo 05.

## Gate de entrada obrigatorio

Antes da primeira escrita comercial:

- ERP_IDENTIFICADO = SIM
- FERRAMENTA_HOMOLOGADA = SIM
- PASSO_02_APTO = SIM
- PLANO_DE_HOMOLOGACAO = GERADO
- BASE_COMERCIAL_PLANEJADA = GERADA
- PRONTO_PARA_CRIAR_BASE_REAL = SIM
- snapshot das fontes do Passo 03 suficiente para verificar vigencia
- ambiente autorizado
- autorizacao explicita do operador para materializar

Sem isso: BLOQUEADA ou PENDENTE com evidencia.

## Verificacao obrigatoria de vigencia do plano

Antes de qualquer escrita comercial:

1. ler o snapshot das fontes registrado no Passo 03;
2. comparar contrato tecnico, cenarios funcionais, regras de negocio, analise/capacidades do ERP, matriz e padrao de massa efetivamente usados;
3. usar hash/versao existente quando disponivel, sem inventar valor;
4. aceitar mudanca textual irrelevante somente quando houver evidencia segura de que a fonte efetiva usada nao mudou.

Se houver divergencia relevante ou evidencia insuficiente:

- `VIGENCIA_DO_PLANO: PLANO_POTENCIALMENTE_OBSOLETO`;
- `PLANO_VALIDO: NAO`;
- bloquear todas as escritas;
- retornar para revalidacao minima do Passo 03.

Nao atualizar o plano, reinterpretar regras, recalcular massa ou corrigir familias dentro do Passo 04.

## Ambiente permitido por padrao

Permitir escrita apenas em ambiente:

- HML
- HOMOLOGACAO
- SANDBOX
- TESTE
- DEV autorizado

Se resolver PRODUCAO, bloquear.

Nao confiar apenas em nome textual de URL.

## Politica de autorizacao

Credencial disponivel nao equivale a autorizacao processual.

Exigir autorizacao explicita para o plano/ERP/ambiente correntes antes da primeira escrita:

- AUTORIZADO_MATERIALIZAR_BASE: SIM

## Politica de credenciais

Permitido em execucao real:

- receber credenciais
- usar credenciais

Proibido:

- reproduzir segredo
- persistir em Git
- logar valor sensivel
- retornar segredo ao operador

## Auto-descoberta obrigatoria

Resolver automaticamente:

1. ERP/ferramenta/slugs
2. estado e gate do Passo 03
3. BASE-COMERCIAL-PLANEJADA.yaml
4. Base Mestra materializada atual (se existir)
5. DAG e dependencias
6. capacidades/rotas do ERP
7. estrategia de auth descoberta no Passo 02
8. ambiente alvo
9. autorizacao para escrita

Solicitar somente informacao bloqueante ausente.

## Reutilizacao e Base Mestra

Base Mestra pertence ao ERP:

- erps/<erp-slug>/homologacao/BASE-MESTRA-MATERIALIZADA.yaml

A combinacao deve declarar o que:

- reutilizou
- criou
- atualizou controladamente
- nao precisou

Nao recriar cegamente entidades ja validas da Base Mestra.

## Identidade e correlacao

Usar id_logico da Fabrica como eixo de idempotencia e rastreabilidade.

Persistir correlacao nao sensivel progressivamente:

- id_logico <-> erp_id

## Acoes por registro

Classificacoes permitidas:

- CRIADO
- REUTILIZADO_EXISTENTE
- ATUALIZADO_CONTROLADAMENTE
- PENDENTE
- FALHOU
- DIVERGENTE
- NAO_APLICAVEL

Nao usar sucesso generico sem acao declarada.

## Fluxo operacional aproximado

1. Resolver contexto
2. Validar Passo 03
3. Verificar vigencia do plano contra o snapshot das fontes
4. Validar ambiente
5. Validar autorizacao
6. Carregar Base planejada
7. Carregar Base Mestra atual
8. Carregar DAG
9. Carregar capacidades/rotas
10. Autenticar
11. Descobrir/reutilizar existentes
12. Materializar faltantes por dependencia
13. Persistir correlacoes/checkpoints progressivamente
14. Reconsultar
15. Comparar planejado x observado
16. Aplicar retries controlados
17. Atualizar Base Mestra
18. Gerar relatorio
19. Retornar gate final

## Regras de escrita

- POST: permitido quando necessario
- PUT/PATCH: somente controle previsto no plano e alvo seguro
- DELETE: fora do fluxo normal

## Regras de confiabilidade

- proibido POST cego sem lookup previo quando aplicavel
- idempotencia obrigatoria
- filho nao criado antes de pai confirmado
- sem rollback destrutivo automatico
- 201 sem reconsulta nao basta para confirmacao
- paginacao deve ser respeitada em confirmacoes por listagem

## Retry, auth e rate limit

- retries limitados para falhas transitorias
- sem retry cego para 4xx deterministico
- 401: no maximo uma renovacao/retry controlado por operacao quando estrategia permitir
- respeitar Retry-After e limites de taxa

## Imagens e EAN

- imagem logica sem arquivo fisico disponivel gera PENDENTE_DE_FONTE_DE_IMAGEM
- nao inventar binarios
- Passo 04 nao redecide necessidade de EAN
- executar conforme plano (CODIGO_REAL ou CODIGO_SINTETICO_HML)

## Cobertura permitida no Passo 04

- COBERTURA_CRIADA_NO_ERP: permitido
- COBERTURA_SINCRONIZADA: nao permitido aqui
- COBERTURA_VALIDADA_NA_FERRAMENTA: nao permitido aqui

## Gate final obrigatorio

Retornar explicitamente:

- AMBIENTE_AUTORIZADO: SIM | NAO
- PLANO_VALIDO: SIM | NAO
- VIGENCIA_DO_PLANO: VIGENTE | PLANO_POTENCIALMENTE_OBSOLETO | EVIDENCIA_INSUFICIENTE
- BASE_MESTRA: CRIADA | ATUALIZADA | REUTILIZADA | BLOQUEADA
- MATERIALIZACAO: COMPLETA | PARCIAL_JUSTIFICADA | INSUFICIENTE | BLOQUEADA
- RECONSULTA: APROVADA | PARCIAL | INSUFICIENTE
- CORRELACOES: VALIDAS | PARCIAIS | INVALIDAS
- DEPENDENCIAS: VALIDAS | PROBLEMA
- COBERTURA_CRIADA_NO_ERP: COMPLETA | PARCIAL_JUSTIFICADA | INSUFICIENTE
- FALHAS_BLOQUEANTES: <quantidade>
- PRONTO_PARA_VALIDACAO_NA_FERRAMENTA: SIM | NAO

## Como executar (operador)

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-04-MATERIALIZAR-BASE-HOMOLOGACAO.md

Materialize a Base planejada da combinacao ERP x ferramenta no ambiente autorizado de homologacao/teste.

Nao reprojete base.

Use BASE-COMERCIAL-PLANEJADA.yaml como fonte de verdade.

Antes da primeira escrita, verifique se o plano continua vigente contra o snapshot das fontes do Passo 03. Se houver divergencia relevante ou evidencia insuficiente, classifique PLANO_POTENCIALMENTE_OBSOLETO, bloqueie e retorne ao Passo 03 para revalidacao minima.

Valide ambiente e autorizacao explicita antes da primeira escrita comercial.

Nao usar producao.

Nao criar Passo 05.

Gerar/atualizar:
- erps/<erp-slug>/homologacao/BASE-MESTRA-MATERIALIZADA.yaml
- erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-MATERIALIZACAO.md

Retornar gate final completo.
```

### PARE DE COPIAR AQUI

## Saida obrigatoria

STATUS DA ETAPA: CONCLUIDA | PENDENTE | BLOQUEADA

GATE DE ENTRADA:
- ERP_IDENTIFICADO
- FERRAMENTA_HOMOLOGADA
- PASSO_02_APTO
- PLANO_DE_HOMOLOGACAO
- BASE_COMERCIAL_PLANEJADA
- PRONTO_PARA_CRIAR_BASE_REAL

GATE FINAL:
- AMBIENTE_AUTORIZADO
- PLANO_VALIDO
- VIGENCIA_DO_PLANO
- BASE_MESTRA
- MATERIALIZACAO
- RECONSULTA
- CORRELACOES
- DEPENDENCIAS
- COBERTURA_CRIADA_NO_ERP
- FALHAS_BLOQUEANTES
- PRONTO_PARA_VALIDACAO_NA_FERRAMENTA

ARTEFATOS:
- BASE-MESTRA-MATERIALIZADA.yaml
- RELATORIO-DE-MATERIALIZACAO.md

PROXIMA ACAO PERMITIDA:
- executar somente o Passo 05 - Projetar Integracao e Mapeamento Semantico, conforme `parceiros/comandos/ERP-PARCEIRO-05-PROJETAR-INTEGRACAO-E-MAPEAMENTO.md` (sem autoexecucao).
- depois do Passo 05 apto, o Passo 06 oficialmente publicado desenvolve e testa localmente a integracao; execucao e validacao em HML permanecem futuras. O Passo 04 nao pula o Passo 05.
