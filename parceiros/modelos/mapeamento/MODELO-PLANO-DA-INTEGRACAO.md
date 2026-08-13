# Modelo - Plano da integração ERP x ferramenta

> Modelo global do ERP Parceiro - Passo 05. Não preencher com dados de um ERP, ferramenta ou cliente reais neste arquivo. Em uma execução real, gerar `erps/<erp-slug>/integracoes/<ferramenta-slug>/PLANO-DA-INTEGRACAO.md` e manter os detalhes estruturados em `MAPEAMENTO-SEMANTICO.yaml` e `REGRAS-DE-TRANSFORMACAO.yaml`.

## Regras de uso do modelo

- o Passo 05 projeta a integração; não desenvolve código, adaptador, runtime ou infraestrutura;
- a ferramenta E-Catálogos permanece soberana sobre o contrato da integração, mas não é necessariamente a fonte da verdade de todos os dados;
- equivalência de nomes não comprova equivalência semântica;
- nenhuma rota, campo, enum, cardinalidade, operação ou capacidade pode ser inventada;
- `classificacao_mapeamento` e `status_evidencia` são dimensões distintas e não devem ser combinadas em um único estado;
- consultas `GET`, `HEAD` ou `OPTIONS` só podem ser usadas em execução futura quando documentadas, necessárias e autorizadas; este passo nunca executa `POST`, `PUT`, `PATCH` ou `DELETE`;
- valores de credenciais, tokens, IDs físicos de cliente e segredos não pertencem a este plano;
- os três artefatos do Passo 05 devem ser consistentes entre si, sem duplicar integralmente o mesmo conteúdo;
- pendências da combinação devem permanecer no `PENDENCIAS.md` existente, e não em arquivo paralelo.

## Identificação

| Campo | Valor |
|---|---|
| ERP | `<nome-do-erp>` |
| ERP slug | `<erp-slug>` |
| Ferramenta E-Catálogos | `<nome-da-ferramenta>` |
| Ferramenta slug | `<ferramenta-slug>` |
| Combinação | `<erp-slug> x <ferramenta-slug>` |
| Jornada | `ERP_PARCEIRO` |
| Etapa | `ERP_PARCEIRO_PASSO_05` |
| Data da análise | `<AAAA-MM-DD>` |
| Responsável | `<responsavel>` |
| Estado da execução | `<caminho-do-estado>` |
| Mapeamento estruturado | `erps/<erp-slug>/integracoes/<ferramenta-slug>/MAPEAMENTO-SEMANTICO.yaml` |
| Regras de transformação | `erps/<erp-slug>/integracoes/<ferramenta-slug>/REGRAS-DE-TRANSFORMACAO.yaml` |
| Pendências vigentes | `erps/<erp-slug>/integracoes/<ferramenta-slug>/PENDENCIAS.md` |

## Pré-condições e gate de entrada

| Condição | Estado | Evidência | Observação |
|---|---|---|---|
| ERP identificado sem ambiguidade | `SIM \| NAO` | `<referencia>` | `<observacao>` |
| Ferramenta identificada sem ambiguidade | `SIM \| NAO` | `<referencia>` | `<observacao>` |
| Ferramenta homologada para integrações | `SIM \| NAO` | `<manifesto/estado/auditoria>` | Exigir conjuntamente resultado técnico apto, auditoria aprovada, etapa concluída e prontidão homologada. |
| Passo 01 do ERP Parceiro concluído e vigente | `SIM \| NAO` | `<referencia>` | `<observacao>` |
| Passo 02 concluído, auditado e vigente | `SIM \| NAO` | `<referencia>` | `<observacao>` |
| Passo 03 concluído, auditado e vigente | `SIM \| NAO` | `<referencia>` | `<observacao>` |
| Passo 04 apto | `SIM \| NAO` | `<estado/gate/relatorio>` | Confirmar materialização, reconsulta, correlações, dependências e ausência de falha bloqueante conforme o gate vigente do Passo 04. |
| Base Mestra materializada disponível | `SIM \| NAO \| NAO_APLICAVEL` | `<referencia>` | Serve como evidência; não como fonte única de verdade sem rastreabilidade. |
| Fontes upstream vigentes | `SIM \| NAO \| EVIDENCIA_INSUFICIENTE` | `<hash/versao/manifesto>` | Mudança upstream exige reanálise consciente; não trocar hashes cegamente. |

Se uma condição obrigatória falhar, registrar o bloqueio e não produzir `PRONTO_PARA_DESENVOLVIMENTO: SIM`.

## Fontes utilizadas

Registrar somente fontes efetivamente consultadas. Usar hash ou versão quando já disponível; não inventar identificadores.

| ID da fonte | Camada | Caminho ou referência | Versão/data | Hash e modo | Vigência | Uso no plano |
|---|---|---|---|---|---|---|
| `<FONTE-001>` | `CONTRATO_TECNICO \| CENARIO_FUNCIONAL \| REGRA_DE_NEGOCIO \| EVIDENCIA_RUNTIME \| ERP_GERAL \| COMBINACAO \| BASE_MESTRA \| DECISAO_APROVADA` | `<referencia>` | `<versao-ou-NA>` | `<sha256/modo-ou-NA>` | `VIGENTE \| INVALIDA \| NAO_COMPROVADA` | `<finalidade>` |

### Snapshot da linha de base

- snapshot calculado em: `<AAAA-MM-DDThh:mm:ssZ>`;
- manifestos e gates verificados: `<referencias>`;
- fontes sem hash/versionamento disponível: `<lista-e-justificativa>`;
- mudança upstream detectada: `SIM | NAO`;
- decisão diante da mudança: `REUTILIZAR | REANALISAR_DELTA | REANALISAR_COMPLETO | BLOQUEAR`;
- justificativa e evidência: `<detalhes>`.

## Objetivo

Descrever como o ERP e a ferramenta conversarão, respondendo com evidência:

1. de onde vem cada conceito necessário;
2. como o ERP e a ferramenta representam esse conceito;
3. qual transformação determinística é necessária;
4. em qual direção e em qual momento o dado trafega;
5. como entidades são identificadas e correlacionadas;
6. quais configurações, customizações, enriquecimentos, gaps e pendências permanecem;
7. se o projeto está suficientemente decidido para desenvolvimento futuro sem reinvenção arquitetural.

## Escopo

### Incluído

- módulos e fluxos selecionados: `<lista>`;
- carga inicial: `<escopo>`;
- incrementais: `<escopo>`;
- regras e cenários obrigatórios: `<IDs>`;
- cobertura opcional aceita: `<lista-ou-NA>`.

### Excluído

- módulos, modos e cenários fora de escopo: `<lista>`;
- motivo e impacto de cada exclusão: `<detalhes>`;
- decisão que autorizou a exclusão: `<referencia-ou-NA>`.

### Fronteiras

Este plano não cria campos no ERP, não modifica schemas, não executa sincronização, não configura cliente real, não altera o contrato homologado e não implementa o passo de desenvolvimento.

## Direções

Não classificar a integração inteira como genericamente bidirecional. Definir por módulo, objeto, fluxo e evento.

| ID do fluxo | Módulo/objeto | Direção | Fonte da verdade | Proprietário do dado | Justificativa/evidência |
|---|---|---|---|---|---|
| `<FLUXO-001>` | `<modulo/objeto>` | `ERP_PARA_FERRAMENTA \| FERRAMENTA_PARA_ERP \| BIDIRECIONAL_CONTROLADO \| SEM_SINCRONIZACAO` | `ERP \| FERRAMENTA \| INTEGRACAO_CONFIG \| DERIVADO` | `<owner>` | `<referencias>` |

Para `BIDIRECIONAL_CONTROLADO`, preencher obrigatoriamente prioridade, regra de conflito, origem do evento e prevenção conceitual de loop.

## Módulos

| Módulo | Papel na integração | Obrigatoriedade | Direções | Operações confirmadas | Cobertura | Impacto da limitação |
|---|---|---|---|---|---|---|
| `<modulo>` | `<papel>` | `OBRIGATORIO \| OPCIONAL \| NAO_APLICAVEL` | `<direcoes>` | `<IDs/rotas ou PENDENTE>` | `COMPLETA \| PARCIAL_JUSTIFICADA \| INSUFICIENTE \| NAO_APLICAVEL` | `<impacto>` |

## Fluxos

| ID | Nome | Origem | Destino | Direção | Modalidade | Objetos | Regra de disparo | Pré-condições | Resultado esperado | Estado |
|---|---|---|---|---|---|---|---|---|---|---|
| `<FLUXO-001>` | `<nome>` | `<sistema/objeto>` | `<sistema/objeto>` | `<direcao>` | `CARGA_INICIAL \| INCREMENTAL \| AMBOS \| SEM_SINCRONIZACAO` | `<objetos>` | `<evento/momento>` | `<dependencias>` | `<efeito>` | `DEFINIDO \| PARCIAL \| INSUFICIENTE` |

Cada fluxo deve indicar ainda:

- operações de leitura e escrita necessárias, apenas quando confirmadas por contrato/capacidade;
- paginação, batch, volume, limites e ordenação conhecidos;
- política de criar versus atualizar;
- comportamento de exclusão: `DELETE | DEACTIVATE | HIDE | IGNORE | PENDENTE`, somente com evidência;
- confirmação válida no destino, reprocessamento e falha parcial em nível conceitual;
- dependências upstream e downstream.

Não presumir `UPSERT` porque existe `PUT`, nem `DELETE` porque um registro deixou de aparecer.

## Eventos

| ID do evento | Fluxo | Evento comercial | Mecanismo técnico | Momento | Origem | Evidência | Estado |
|---|---|---|---|---|---|---|---|
| `<EVT-001>` | `<FLUXO-001>` | `<evento-funcional>` | `POLLING \| WEBHOOK \| EVENTO_FUNCIONAL \| EXPORTACAO_MANUAL \| BATCH \| SCHEDULE \| PENDENTE_DE_EVIDENCIA` | `<quando-agir>` | `<sistema>` | `<referencias>` | `CONFIRMADO_POR_CONTRATO \| CONFIRMADO_POR_DOCUMENTACAO \| CONFIRMADO_EM_RUNTIME \| DERIVADO_COM_EVIDENCIA \| PENDENTE_DE_EVIDENCIA \| DIVERGENTE \| SEM_CAPACIDADE_CONFIRMADA` |

Registrar explicitamente quando eventos parecidos são distintos. Exemplo conceitual: `PEDIDO_CRIADO != PEDIDO_EXPORTADO`. Um endpoint de pedido, sozinho, não prova o momento comercial correto da integração.

## Fonte da verdade

| Conceito/dado | Fonte da verdade | Proprietário | Consumidores | Pode receber retorno? | Política de conflito | Evidência |
|---|---|---|---|---|---|---|
| `<conceito>` | `ERP \| FERRAMENTA \| INTEGRACAO_CONFIG \| DERIVADO` | `<owner>` | `<fluxos>` | `SIM \| NAO \| CONTROLADO` | `<regra-ou-NA>` | `<referencias>` |

Soberania do contrato da ferramenta não significa que a ferramenta origina todos os dados.

## Identidades e correlações

| Entidade | ID lógico da Fábrica | ID ERP | External ID/erpId | ID ferramenta | Chave de negócio | SKU/referência | Estratégia de lookup | Evidência | Estado |
|---|---|---|---|---|---|---|---|---|---|
| `<entidade>` | `<padrao-logico>` | `<campo-ou-NA>` | `<campo-ou-NA>` | `<campo-ou-NA>` | `<chave-composta-ou-NA>` | `<campo-ou-NA>` | `<ordem-de-busca>` | `<referencias>` | `DEFINIDA \| PARCIAL \| INVALIDA` |

Regras obrigatórias:

- nome ou descrição nunca é identidade por si só;
- IDs físicos observados na Base Mestra são evidência, não valores hardcoded no projeto reutilizável;
- registrar a correlação conceitual `ID ERP <-> ID lógico <-> ID ferramenta` quando aplicável;
- não criar banco ou runtime de correlação neste passo.

## Relações e cardinalidades

| ID | Origem | Relação | Destino | Cardinalidade | Obrigatoriedade | Regra de integridade | Evidência | Status de evidência |
|---|---|---|---|---|---|---|---|---|
| `<REL-001>` | `<objeto>` | `<relacao>` | `<objeto>` | `<cardinalidade-ou-PENDENTE>` | `<obrigatoriedade>` | `<regra>` | `<referencias>` | `CONFIRMADO_POR_CONTRATO \| CONFIRMADO_POR_DOCUMENTACAO \| CONFIRMADO_EM_RUNTIME \| DERIVADO_COM_EVIDENCIA \| PENDENTE_DE_EVIDENCIA \| DIVERGENTE \| SEM_CAPACIDADE_CONFIRMADA` |

Não deduzir cardinalidade pela estrutura de um único exemplo. Cobrir, quando aplicável, produto/marca/categoria/subcategoria/variações, variação/cor/tamanho, produto ou SKU/preço/estoque por filial, cliente/região/tabela, representante/preposto e pedido/itens/cliente/condição.

## Mapeamentos

O detalhamento machine-readable pertence a `MAPEAMENTO-SEMANTICO.yaml`. Este plano mantém a visão decisória e os vínculos de auditoria.

| ID | Módulo | Conceito | Origem | Destino | Direção | Fonte da verdade | Classificação | Status de evidência | Obrigatório | Transformação | Regras/cenários | Impacto |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `<MAP-001>` | `<modulo>` | `<significado>` | `<objeto.campo>` | `<objeto.campo>` | `<direcao>` | `<fonte>` | `DIRETO \| DERIVADO \| DE_PARA \| CUSTOM_ERP \| ENRIQUECIMENTO \| SEM_CAPACIDADE \| PENDENTE_DE_DECISAO` | `CONFIRMADO_POR_CONTRATO \| CONFIRMADO_POR_DOCUMENTACAO \| CONFIRMADO_EM_RUNTIME \| DERIVADO_COM_EVIDENCIA \| PENDENTE_DE_EVIDENCIA \| DIVERGENTE \| SEM_CAPACIDADE_CONFIRMADA` | `SIM \| NAO \| CONDICIONAL` | `<TR-ID-ou-NA>` | `<RN-*/CF-*>` | `<impacto>` |

Definições resumidas:

- `DIRETO`: equivalência de significado provada, não apenas nome igual;
- `DERIVADO`: cálculo seguro e reproduzível a partir de dados nativos;
- `DE_PARA`: tradução explícita e configurável;
- `CUSTOM_ERP`: dependência planejada de extensão do ERP, sem criá-la aqui;
- `ENRIQUECIMENTO`: configuração externa válida e governada, nunca fabricação de dado transacional;
- `SEM_CAPACIDADE`: ausência de forma segura confirmada por evidência suficiente;
- `PENDENTE_DE_DECISAO`: opções existem, mas falta evidência ou decisão para escolher.

Ordem de preferência: capacidade nativa, derivação segura, de-para explícito, custom existente, novo custom autorizado futuramente, enriquecimento controlado e, por fim, gap/sem capacidade.

### Conceitos que exigem verificação explícita

- grade sem exigir campo homônimo; grade aberta e grade fechada/pack separadas;
- Linha, Coleção, Família, Grupo e Categoria sem equivalência automática;
- Preposto e Vendedor sem equivalência automática;
- nacional/importado sem inferência por nome ou SKU;
- preço no contexto completo de cliente, região, tabela, produto e visibilidade;
- produto inexistente separado de produto existente, porém invisível comercialmente;
- `null`, campo ausente, string vazia, zero e `false` preservados como valores distintos.

## Transformações

O detalhamento machine-readable pertence a `REGRAS-DE-TRANSFORMACAO.yaml`.

| ID da regra | Tipo | Entradas | Saídas | Regra determinística | Ordenação/precisão | Valor desconhecido/erro | Mapeamentos consumidores | Evidência | Estado |
|---|---|---|---|---|---|---|---|---|---|
| `<TR-001>` | `NORMALIZACAO \| DERIVACAO \| COMPOSICAO \| DECOMPOSICAO \| DE_PARA \| LOOKUP \| CONCATENACAO \| SPLIT \| MERGE \| CONVERSAO_TIPO \| CONVERSAO_UNIDADE \| FORMATO_DATA \| PRECISAO_DECIMAL \| ENUM_MAP \| VALOR_CONSTANTE_JUSTIFICADO \| CONDICIONAL` | `<campos>` | `<campos>` | `<algoritmo-sem-ambiguidade>` | `<regra>` | `BLOQUEAR_REGISTRO \| USAR_FALLBACK_AUTORIZADO \| PENDENTE_DE_MAPEAMENTO` | `<MAP-IDs>` | `<referencias>` | `DEFINIDA \| PARCIAL \| INSUFICIENTE` |

Expressões vagas como “ajustar”, “converter conforme necessário” ou “tratar o valor” são insuficientes. Enumeração exige mapa explícito e política para valor desconhecido. Valor constante exige justificativa e fonte de autoridade.

## Regras de negócio consideradas

| Regra | Descrição resumida | Dados necessários | Mapeamentos/fluxos | Cenários | Cobertura | Evidência | Impacto da lacuna |
|---|---|---|---|---|---|---|---|
| `<RN-*>` | `<resumo-sem-copiar-a-fonte>` | `<dados>` | `<MAP/FLUXO-IDs>` | `<cenario_tags>` | `ATENDIDA \| PARCIAL \| NAO_ATENDIDA \| PENDENTE_DE_EVIDENCIA` | `<referencias>` | `<impacto>` |

Regra documentada não comprova endpoint ou comportamento runtime. Divergências devem permanecer visíveis e nunca sobrescrever silenciosamente o contrato técnico.

## Dependências entre fluxos

| Fluxo | Depende de | Condição de liberação | Identidade/correlação requerida | Tratamento se dependência falhar | Evidência |
|---|---|---|---|---|---|
| `<FLUXO-002>` | `<FLUXO-001>` | `<condicao>` | `<correlacao>` | `<bloquear/adiar/isolar>` | `<referencias>` |

Registrar uma ordem parcial sustentada por evidência, não uma sequência global inventada.

## Carga inicial

| Fluxo/objeto | Aplicável | Escopo | Paginação | Batch/limites | Ordenação | Checkpoint conceitual | Confirmação | Reprocessamento | Estado |
|---|---|---|---|---|---|---|---|---|---|
| `<FLUXO-001>` | `SIM \| NAO` | `<universo/filtro>` | `<estrategia>` | `<limites>` | `<ordem>` | `<marcador>` | `<como-confirmar>` | `<politica>` | `DEFINIDA \| PARCIAL \| INSUFICIENTE` |

Não assumir que a primeira página representa todo o conjunto.

## Incrementais

| Fluxo/objeto | Aplicável | Detecção de mudança | Evento/mecanismo | Cursor/janela | Deduplicação | Idempotência conceitual | Reprocessamento | Estado |
|---|---|---|---|---|---|---|---|---|
| `<FLUXO-001>` | `SIM \| NAO` | `<regra>` | `<EVT-ID>` | `<cursor-ou-NA>` | `<chave>` | `<regra>` | `<politica>` | `DEFINIDO \| PARCIAL \| INSUFICIENTE` |

Não implementar scheduler, webhook, job ou mecanismo de persistência neste passo.

## Configurações requeridas

Separar configuração reutilizável da integração e configuração específica da jornada ERP Cliente. Não preencher valores reais de cliente neste plano.

| ID | Escopo | Nome | Tipo | Obrigatória | Origem/owner | Validação | Segredo | Momento de fornecimento | Impacto se ausente |
|---|---|---|---|---|---|---|---|---|---|
| `<CFG-001>` | `INTEGRACAO_REUTILIZAVEL \| CONFIGURACAO_DO_CLIENTE` | `<nome>` | `<tipo>` | `SIM \| NAO \| CONDICIONAL` | `<owner>` | `<regra>` | `SIM \| NAO` | `<etapa futura>` | `<impacto>` |

Exemplos de categorias, sem valores concretos: filial, tabela de preço, depósito, códigos de representantes, de-paras e parâmetros comerciais. Credenciais de cliente nunca são hardcoded.

## Customizações requeridas

| ID | Conceito | Custom existente | ERP suporta customização | Tipo/finalidade | Evidência | Autorização futura necessária | Alternativas avaliadas | Estado |
|---|---|---|---|---|---|---|---|---|
| `<CUSTOM-001>` | `<conceito>` | `SIM \| NAO \| PENDENTE` | `SIM \| NAO \| PENDENTE_DE_EVIDENCIA` | `<tipo/finalidade>` | `<referencias>` | `SIM \| NAO` | `<nativo/derivacao/de-para/enriquecimento/gap>` | `PLANEJADA \| PENDENTE_DE_DECISAO \| SEM_CAPACIDADE` |

O Passo 05 não cria, configura nem altera campo customizado.

## Enriquecimentos

| ID | Conceito | Dado ausente | Fonte controlada | Regra | Governança/owner | Validade | Evidência | Risco | Estado |
|---|---|---|---|---|---|---|---|---|---|
| `<ENR-001>` | `<conceito>` | `<dado>` | `<configuracao/de-para>` | `<regra>` | `<owner>` | `<criterio>` | `<referencias>` | `<risco>` | `VALIDO \| PENDENTE_DE_DECISAO \| INVALIDO` |

Enriquecimento não pode fabricar dado transacional inexistente, como inventar tamanhos sem qualquer representação no ERP.

## Gaps

| ID | Módulo/fluxo/conceito | Requisito | Capacidade observada | Classificação | Status de evidência | Obrigatoriedade | Impacto | Alternativas | Evidência | Bloqueante |
|---|---|---|---|---|---|---|---|---|---|---|
| `<GAP-001>` | `<escopo>` | `<requisito>` | `<capacidade>` | `SEM_CAPACIDADE \| PENDENTE_DE_DECISAO` | `CONFIRMADO_POR_CONTRATO \| CONFIRMADO_POR_DOCUMENTACAO \| CONFIRMADO_EM_RUNTIME \| DERIVADO_COM_EVIDENCIA \| PENDENTE_DE_EVIDENCIA \| DIVERGENTE \| SEM_CAPACIDADE_CONFIRMADA` | `OBRIGATORIO \| OPCIONAL` | `<impacto>` | `<alternativas>` | `<referencias>` | `SIM \| NAO` |

Um campo homônimo ausente não comprova `SEM_CAPACIDADE`. Avaliar capacidade nativa, derivação, de-para, customização e enriquecimento válido antes da conclusão.

## Pendências

Referenciar e atualizar o `PENDENCIAS.md` da combinação; não duplicar o conteúdo integral aqui.

| ID da pendência | Resumo | Origem | Decisão/evidência faltante | Impacto | Bloqueia desenvolvimento | Responsável/próxima ação |
|---|---|---|---|---|---|---|
| `<PEND-*>` | `<resumo>` | `<fonte/MAP/GAP>` | `<faltante>` | `<impacto>` | `SIM \| NAO` | `<acao>` |

## Riscos

| ID | Risco | Causa | Probabilidade | Impacto | Mitigação planejada | Evidência/monitoramento | Bloqueante |
|---|---|---|---|---|---|---|---|
| `<RISCO-001>` | `<descricao>` | `<causa>` | `BAIXA \| MEDIA \| ALTA` | `BAIXO \| MEDIO \| ALTO \| CRITICO` | `<mitigacao>` | `<referencias>` | `SIM \| NAO` |

Cobrir, quando aplicável: identidade incorreta, duplicação, perda semântica, loop, conflito bidirecional, evento prematuro, paginação incompleta, enum desconhecido, `null` convertido em zero, exclusão indevida, hardcode de cliente e dependência upstream obsoleta.

## Confiabilidade conceitual

| Fluxo | Chave idempotente | Criar x atualizar | Confirmação no destino | Falha parcial | Retry/reprocessamento | Prevenção de loop | Política de conflito |
|---|---|---|---|---|---|---|---|
| `<FLUXO-001>` | `<chave>` | `<regra>` | `<criterio>` | `<isolamento>` | `<politica>` | `<origem/marcador/estrategia>` | `<prioridade/owner>` |

Estas são decisões de projeto. Não criar banco, fila, job, lock, webhook ou runtime neste passo.

## Estratégia de desenvolvimento

Descrever o handoff conceitual para desenvolvimento futuro sem escrever código:

- arquitetura lógica por módulo: `<descricao>`;
- limites entre componentes: `<descricao>`;
- componentes compartilháveis previstos: `<HTTP/auth/paginacao/retry/logs/erros, apenas conceitualmente>`;
- configurações externas previstas: `<lista>`;
- estratégia de correlação prevista: `<descricao>`;
- estratégia de observabilidade prevista: `<descricao>`;
- estratégia de testes derivada dos cenários e regras: `<descricao>`;
- decisões humanas preservadas: `<IDs/referencias>`.

## Ordem sugerida de implementação

| Ordem | Módulo/fluxo | Motivo | Dependências | Critérios de entrada | Critérios de saída | Pode paralelizar |
|---:|---|---|---|---|---|---|
| `1` | `<modulo/fluxo>` | `<justificativa>` | `<dependencias>` | `<gate>` | `<resultado esperado>` | `SIM \| NAO` |

A ordem deve respeitar dependências e risco; não derivar uma ordem global por convenção ou preferência sem evidência.

## Cobertura de mapeamento

| Escopo | Obrigatório | Conceitos esperados | Confirmados | Parciais | Sem capacidade | Pendentes | Cobertura | Justificativa/impacto |
|---|---|---:|---:|---:|---:|---:|---|---|
| `<modulo/cenario/regra>` | `SIM \| NAO` | `<n>` | `<n>` | `<n>` | `<n>` | `<n>` | `COMPLETA \| PARCIAL_JUSTIFICADA \| INSUFICIENTE` | `<detalhes>` |

`PARCIAL_JUSTIFICADA` só é válida quando o impacto e o modo opcional afetado estão explícitos e nenhuma regra obrigatória do escopo principal está escondida. Contagem alta de campos, isoladamente, não prova prontidão.

## Auditoria e rastreabilidade

| Verificação | Resultado | Evidência | Achado/ação |
|---|---|---|---|
| Fontes e versões registradas sem invenção | `APROVADO \| PROBLEMA` | `<referencias>` | `<detalhes>` |
| Contrato homologado permaneceu somente leitura | `APROVADO \| PROBLEMA` | `<diff/hash>` | `<detalhes>` |
| Equivalências sustentadas semanticamente | `APROVADO \| PROBLEMA` | `<MAP-IDs/fontes>` | `<detalhes>` |
| Classificação e status de evidência separados | `APROVADO \| PROBLEMA` | `<MAP-IDs>` | `<detalhes>` |
| Direções, ownership, eventos e loop definidos por fluxo | `APROVADO \| PROBLEMA` | `<FLUXO/EVT-IDs>` | `<detalhes>` |
| Identidades e correlações não usam nome | `APROVADO \| PROBLEMA` | `<entidades>` | `<detalhes>` |
| Transformações determinísticas | `APROVADO \| PROBLEMA` | `<TR-IDs>` | `<detalhes>` |
| `null`, ausente, vazio, zero e `false` preservados | `APROVADO \| PROBLEMA` | `<TR/MAP-IDs>` | `<detalhes>` |
| Relações e cardinalidades possuem evidência | `APROVADO \| PROBLEMA` | `<REL-IDs>` | `<detalhes>` |
| Configuração de cliente não foi hardcoded | `APROVADO \| PROBLEMA` | `<CFG-IDs/varredura>` | `<detalhes>` |
| Carga inicial e incrementais foram definidos | `APROVADO \| PROBLEMA` | `<FLUXO-IDs>` | `<detalhes>` |
| Pendências existentes foram preservadas sem duplicação | `APROVADO \| PROBLEMA` | `<PEND-IDs/diff>` | `<detalhes>` |
| Nenhuma operação de escrita foi executada no Passo 05 | `APROVADO \| PROBLEMA` | `<registro-da-execucao>` | `<detalhes>` |
| Nenhum código/runtime ou artefato de desenvolvimento foi criado | `APROVADO \| PROBLEMA` | `<diff/status>` | `<detalhes>` |
| Três outputs documentais estão íntegros e coerentes | `APROVADO \| PROBLEMA` | `<hashes/Harness>` | `<detalhes>` |

## Idempotência documental e mudança upstream

Antes de criar ou atualizar outputs existentes:

| Verificação | Resultado | Evidência/decisão |
|---|---|---|
| Versões e hashes das fontes comparados | `SIM \| NAO` | `<detalhes>` |
| Versão do ERP comparada | `SIM \| NAO \| NAO_DISPONIVEL` | `<detalhes>` |
| Versão da ferramenta comparada | `SIM \| NAO \| NAO_DISPONIVEL` | `<detalhes>` |
| Regras e cenários comparados | `SIM \| NAO` | `<detalhes>` |
| Decisões anteriores e intervenção humana preservadas | `SIM \| NAO` | `<detalhes>` |
| Delta upstream classificado | `SEM_MUDANCA \| REANALISE_DELTA \| REANALISE_COMPLETA \| BLOQUEADO` | `<detalhes>` |
| Sobrescrita cega evitada | `SIM \| NAO` | `<detalhes>` |

Não regravar artefatos sem mudança material apenas para alterar timestamp. Preservar histórico e decisões aprovadas.

## Gate final do Passo 05

| Campo | Valor | Evidência/justificativa |
|---|---|---|
| `ERP_IDENTIFICADO` | `SIM \| NAO` | `<referencia>` |
| `FERRAMENTA_HOMOLOGADA` | `SIM \| NAO` | `<referencia>` |
| `PASSO_04_APTO` | `SIM \| NAO` | `<referencia>` |
| `MAPEAMENTO_SEMANTICO` | `GERADO \| PARCIAL \| BLOQUEADO` | `<referencia>` |
| `FLUXOS` | `DEFINIDOS \| PARCIAIS \| INSUFICIENTES` | `<referencia>` |
| `TRANSFORMACOES` | `DEFINIDAS \| PARCIAIS \| INSUFICIENTES` | `<referencia>` |
| `IDENTIDADES` | `DEFINIDAS \| PARCIAIS \| INVALIDAS` | `<referencia>` |
| `DIRECOES` | `DEFINIDAS \| PARCIAIS` | `<referencia>` |
| `EVENTOS` | `DEFINIDOS \| PARCIAIS \| PENDENTES` | `<referencia>` |
| `CONFIGURACOES_REQUERIDAS` | `DEFINIDAS \| PARCIAIS` | `<referencia>` |
| `PENDENCIAS_BLOQUEANTES` | `<quantidade>` | `<PEND-IDs>` |
| `COBERTURA_DE_MAPEAMENTO` | `COMPLETA \| PARCIAL_JUSTIFICADA \| INSUFICIENTE` | `<referencia>` |
| `PRONTO_PARA_DESENVOLVIMENTO` | `SIM \| NAO` | `<justificativa>` |

`PRONTO_PARA_DESENVOLVIMENTO: SIM` exige, conjuntamente:

- nenhuma pendência bloqueante;
- todos os conceitos obrigatórios com fonte segura, direção, identidade e transformação decididas;
- eventos comerciais fundamentais definidos com evidência suficiente;
- fluxos bidirecionais com ownership, conflito e prevenção conceitual de loop;
- enums e políticas de valor desconhecido explícitos;
- configurações e customizações distinguidas de valores de cliente;
- nenhuma decisão arquitetural fundamental transferida ao desenvolvimento futuro.

Se o desenvolvimento ainda precisaria descobrir de onde vem Grade, qual evento envia Pedido, como identificar Produto, qual direção Estoque percorre, como mapear um enum, quem é dono do dado ou se uma ausência vira customização/de-para, o valor obrigatório é `NAO`.

## Critérios para Passo 06

Esta seção é somente um handoff conceitual. Não cria, executa nem libera o Passo 06.

- [ ] gate final do Passo 05 aprovado e vigente;
- [ ] `PRONTO_PARA_DESENVOLVIMENTO: SIM` sustentado por evidência, não por quantidade de campos;
- [ ] `MAPEAMENTO-SEMANTICO.yaml` concreto por objeto, campo, relação, evento e identidade;
- [ ] `REGRAS-DE-TRANSFORMACAO.yaml` determinístico, com entradas, saídas, regras e políticas de erro/desconhecido;
- [ ] fluxos, direções, fonte da verdade e ownership definidos;
- [ ] create/update/read e eventual delete/deactivate comprovados sem inferência;
- [ ] carga inicial, incrementais, paginação, volume e dependências definidos;
- [ ] configurações reutilizáveis separadas das configurações de cliente;
- [ ] gaps opcionais aceitos como cobertura parcial justificada e gaps obrigatórios resolvidos;
- [ ] pendências bloqueantes zeradas;
- [ ] decisões humanas e linha de base upstream preservadas;
- [ ] artefatos do Passo 05 auditados e vigentes conforme o Harness aplicável.

## Handoff conceitual

| Item | Referência | Estado | Observação |
|---|---|---|---|
| Mapeamento semântico | `<caminho/hash>` | `PRONTO \| PARCIAL \| BLOQUEADO` | `<detalhes>` |
| Regras de transformação | `<caminho/hash>` | `PRONTAS \| PARCIAIS \| BLOQUEADAS` | `<detalhes>` |
| Plano da integração | `<caminho/hash>` | `PRONTO \| PARCIAL \| BLOQUEADO` | `<detalhes>` |
| Pendências vigentes | `<caminho/hash>` | `<quantidade/bloqueantes>` | `<detalhes>` |
| Baseline upstream | `<manifestos/fontes>` | `VIGENTE \| INVALIDA \| EVIDENCIA_INSUFICIENTE` | `<detalhes>` |
| Próxima ação autorizada | `<aguardar etapa oficialmente publicada ou corrigir achados>` | `<estado>` | Não iniciar desenvolvimento automaticamente. |

## Resultado da etapa

```text
STATUS DA ETAPA: CONCLUIDA | PENDENTE | BLOQUEADA

COBERTURA_DE_MAPEAMENTO: COMPLETA | PARCIAL_JUSTIFICADA | INSUFICIENTE
PRONTO_PARA_DESENVOLVIMENTO: SIM | NAO

RESUMO:
<resultado objetivo, gaps, pendencias bloqueantes e proxima acao permitida>
```
