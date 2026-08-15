# 04 - Materializar Base de homologacao no ERP

## Quando usar

Use esta etapa quando o Passo 03 da combinacao ERP x ferramenta ja estiver concluido e apto para materializacao real no ambiente autorizado do ERP.

## Objetivo oficial

Formalizar o fluxo:

PASSO 03 -> PROJETA

PASSO 04 -> MATERIALIZA E CONFIRMA NO ERP

Pergunta central da etapa:

"O que foi planejado realmente conseguiu ser criado e confirmado no ERP de homologacao?"

Fonte de verdade do que precisa ser materializado:

- BASE-COMERCIAL-PLANEJADA.yaml

## Escopo

Esta etapa materializa e confirma no ERP de homologacao/teste o que foi planejado.

Esta etapa nao reprojeta base, nao redefine familias e nao recalcula volume.

Tambem nao reanalisa nem reinterpreta regras de negocio. A unica leitura das fontes do Passo 03 nesta etapa e a verificacao de vigencia do plano antes da escrita.

## O que esta etapa NAO faz

- nao cria Passo 05;
- nao altera contrato homologado da ferramenta;
- nao altera Harness;
- nao altera manifestos existentes;
- nao executa limpeza destrutiva automatica por falha parcial.

## Pre-condicoes obrigatorias da execucao real

So iniciar escrita comercial quando:

- ERP_IDENTIFICADO = SIM
- FERRAMENTA_HOMOLOGADA = SIM
- PASSO_02_APTO = SIM
- PLANO_DE_HOMOLOGACAO = GERADO
- BASE_COMERCIAL_PLANEJADA = GERADA
- PRONTO_PARA_CRIAR_BASE_REAL = SIM
- snapshot das fontes do Passo 03 suficiente para verificar vigencia
- ambiente autorizado valido
- autorizacao explicita do operador para materializar

Se o Passo 03 estiver BLOQUEADO ou sem gate apto, nao iniciar escrita.

## Vigencia do plano antes da escrita

Antes de qualquer operacao comercial, comparar o snapshot registrado no plano com as fontes efetivamente usadas no Passo 03, incluindo quando aplicavel:

- contrato tecnico;
- cenarios funcionais;
- regras de negocio;
- analise e capacidades do ERP;
- matriz ERP x ferramenta;
- padrao global de massa.

Usar hash/versao ja registrado e mecanismos seguros existentes no Harness/repositorio. Nao inventar mecanismo sofisticado de diff nem bloquear por mudanca textual irrelevante quando houver evidencia segura de que a fonte efetiva usada nao mudou.

Se houver divergencia relevante ou faltar evidencia suficiente para comprovar a vigencia:

- classificar `PLANO_POTENCIALMENTE_OBSOLETO`;
- definir `PLANO_VALIDO: NAO`;
- bloquear toda escrita;
- devolver para revalidacao minima do Passo 03.

O Passo 04 nao atualiza snapshot, nao corrige massa e nao refaz o plano automaticamente.

## Politica de ambiente

Por padrao, escrita permitida apenas em:

- HML
- HOMOLOGACAO
- SANDBOX
- TESTE
- DEV autorizado

Produção nao e ambiente padrao desta etapa.

Se contexto resolver ambiente de producao:

- BLOQUEAR a execucao de escrita.

Nao confiar apenas no texto da URL. Validar configuracao oficial de ambiente/conexao quando existir.

## Politica de autorizacao

Credencial presente nao equivale a autorizacao processual.

Antes da primeira escrita de uma execucao real, exigir autorizacao explicita de materializacao para:

- ERP
- combinacao
- ambiente
- plano corrente

Exemplo conceitual de controle:

- AUTORIZADO_MATERIALIZAR_BASE: SIM

Nao reutilizar autorizacao silenciosamente para outro plano/ambiente.

## Politica de credenciais

Em execucao real, o executor pode receber e usar credenciais autorizadas.

Proibido:

- reproduzir segredo;
- persistir segredo em Git;
- registrar segredo em relatorios/artefatos;
- devolver segredo no retorno ao operador.

Preferir:

- env
- secret store
- arquivo local ignorado

Se segredo surgir na sessao, usar de forma transitória e nao persistir.

## Base Mestra do ERP

A massa materializada pertence primariamente ao ERP de homologacao.

Memoria persistente conceitual:

- erps/<erp-slug>/homologacao/BASE-MESTRA-MATERIALIZADA.yaml

Este arquivo registra o estado conhecido da Base Mestra real do ERP.

A combinacao ERP x ferramenta continua com:

- PLANO-DE-HOMOLOGACAO.md
- BASE-COMERCIAL-PLANEJADA.yaml

Passo 04 compara Base planejada x Base Mestra antes de escrever.

## Reutilizacao entre ferramentas

A combinacao deve registrar claramente:

- REUTILIZOU
- ADICIONOU
- NAO_PRECISOU

Se a Base Mestra ja cobrir parte do plano, nao recriar cegamente.

Criar apenas faltantes, extensoes ou capacidades novas justificadas.

## Identidade e correlacao

Aplicar convensao de identificadores.

Separar sempre:

- ID_LOGICO da Fabrica (ex.: HML-PROD-001)
- ERP_ID fisico retornado pelo ERP (ex.: 938472)

Persistir correlacao nao sensivel:

- ID_LOGICO <-> ERP_ID

## Idempotencia

Regra obrigatoria:

Executar Passo 04 duas vezes nao pode duplicar base.

Antes de POST, buscar existencia por correlacao/chave segura.

Se existir correlacao valida, reusar.

Se houver ambiguidade de identidade, bloquear aquele registro e nao sobrescrever dado real.

## DAG e ordem de materializacao

Usar dependencias definidas no Passo 03.

Nao assumir ordem global.

Nao criar filho antes de pai confirmado.

## Persistencia progressiva e retomada

Apos confirmacao de cada escrita relevante, persistir correlacao e checkpoint.

Retomada deve continuar do estado conhecido sem recriar itens ja confirmados.

Nao inventar mecanismo paralelo ao Harness/checkpoint oficial.

## Escritas permitidas em execucao real

- POST: permitido quando necessario para criar planejado.
- PUT/PATCH: permitido somente para ajuste controlado previsto no plano e alvo seguro.
- DELETE: nao faz parte do fluxo normal desta etapa.

## Falha parcial e rollback

Falha parcial nao deve apagar automaticamente sucessos.

Preservar criado/reutilizado/confirmado e registrar pendencias para retomada.

## Verificacao apos escrita

POST 200/201 nao basta para confirmar materializacao.

Sempre que possivel, reconsultar por:

- GET por ID
- GET por chave segura
- listagem filtrada confiavel com paginacao correta

Comparar planejado vs observado.

## Estados de escrita/confirmacao

Cada registro pode assumir, por exemplo:

- ESCRITA_NAO_EXECUTADA
- ESCRITA_CONFIRMADA
- ESCRITA_SEM_RECONSULTA_DISPONIVEL
- DIVERGENTE_APOS_RECONSULTA
- FALHOU_NA_ESCRITA
- FALHOU_NA_RECONSULTA
- REUTILIZADO_EXISTENTE
- ATUALIZADO_CONTROLADAMENTE
- NAO_APLICAVEL

## Retry, auth e rate limit

Retry controlado apenas para falhas transitorias (ex.: timeout, 429, 5xx), com limite.

Nao fazer retry cego para 4xx deterministico de validacao.

Se houver 401 e estrategia de refresh validada no Passo 02, permitir no maximo uma renovacao/retry controlado por operacao.

Respeitar rate limit e Retry-After quando houver.

Nao fixar concorrencia universal.

## Imagens e EAN

Imagens:

- Passo 04 materializa o que o plano exigiu;
- ID logico de imagem nao contem bytes;
- sem fonte de arquivo autorizada, registrar PENDENTE_DE_FONTE_DE_IMAGEM;
- nao inventar binario.

EAN/codigos:

- Passo 04 nao redecide obrigatoriedade de EAN;
- segue o plano (CODIGO_REAL ou CODIGO_SINTETICO_HML);
- nao gerar EAN quando plano nao exigir.

## Cobertura no Passo 04

No Passo 04 pode existir:

- COBERTURA_CRIADA_NO_ERP

Ainda nao pode existir:

- COBERTURA_SINCRONIZADA
- COBERTURA_VALIDADA_NA_FERRAMENTA

## Gate final sugerido da etapa

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

## Como chamar no chat do Codex

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-04-MATERIALIZAR-BASE-HOMOLOGACAO.md

Materialize a Base de homologacao planejada para a combinacao ERP x ferramenta no ambiente autorizado de homologacao/teste.

Use auto-descoberta de contexto no repositorio.

Nao pedir novamente dados ja conhecidos na execucao.

Solicitar somente dado bloqueante ausente.

Passo 04 materializa o que esta em BASE-COMERCIAL-PLANEJADA.yaml.

Nao reprojetar base.
Nao recalcular familias ou quantidades.
Antes da primeira escrita, verificar a vigencia do plano contra o snapshot das fontes do Passo 03. Se houver divergencia relevante ou evidencia insuficiente, classificar PLANO_POTENCIALMENTE_OBSOLETO, bloquear e devolver para revalidacao minima do Passo 03.
Nao criar Passo 05.
Nao alterar contrato homologado da ferramenta.
Nao alterar Harness.
Nao alterar manifestos existentes.

Exigir validacao de ambiente autorizado e autorizacao explicita antes da primeira escrita comercial.

Gerar:
- BASE-MESTRA-MATERIALIZADA.yaml
- RELATORIO-DE-MATERIALIZACAO.md

Retornar gate final da etapa.
```

### PARE DE COPIAR AQUI

## Proximo documento

O proximo documento oficial e:

`comece-aqui/integrar-erp/erp-parceiro/05-PROJETAR-INTEGRACAO-E-MAPEAMENTO.md`

O Passo 05 projeta a integracao e o mapeamento semantico. Quando seus gates permitirem, o Passo 06 desenvolve e testa localmente a implementacao e o Passo 07 executa e valida tecnicamente em HML. O Passo 04 nao pula o Passo 05 nem inicia etapas posteriores automaticamente.

Nao iniciar automaticamente proxima etapa.
