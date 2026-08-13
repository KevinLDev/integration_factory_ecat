# 05 - Projetar integracao e mapeamento semantico

## Quando usar

Use esta etapa quando os Passos 01 a 04 da jornada ERP parceiro estiverem concluidos e vigentes, a Base de homologacao estiver materializada no ERP autorizado e a combinacao possuir evidencia suficiente para projetar como ERP e ferramenta E-Catalogos conversarao.

O Passo 05 e somente de projeto. Ele nao desenvolve nem executa a integracao.

## Objetivo oficial

Responder com evidencia:

> De onde vem cada conceito necessario para a ferramenta, como ele e representado pelo ERP, que transformacao sera necessaria, em qual direcao ele trafega, em qual momento deve trafegar e quais gaps ainda impedem o desenvolvimento?

Sequencia oficial:

```text
PASSO 01 -> identifica
PASSO 02 -> descobre capacidades
PASSO 03 -> planeja homologacao
PASSO 04 -> materializa Base no ERP
PASSO 05 -> projeta como ERP e ferramenta conversarao
```

O resultado deve ser concreto o suficiente para uma etapa futura de desenvolvimento implementar a integracao sem redescobrir decisoes arquiteturais fundamentais.

## Regra central: significado antes do nome

```text
MAPEAMENTO SEMANTICO != MAPEAMENTO TEXTUAL DE CAMPOS
```

Nomes iguais ou parecidos nao provam equivalencia.

O fluxo de raciocinio obrigatorio e:

```text
CONCEITO DA FERRAMENTA
        -> SIGNIFICADO E REGRA DE NEGOCIO
        -> DADOS NECESSARIOS
        -> REPRESENTACAO COMPROVADA NO ERP
        -> TRANSFORMACAO DETERMINISTICA
        -> CONTRATO HOMOLOGADO DA FERRAMENTA
```

A ferramenta E-Catalogos continua soberana sobre o contrato da integracao. Isso nao significa que ela seja origem de todos os dados: a fonte da verdade deve ser definida por conceito e fluxo.

## Pre-condicoes obrigatorias

Antes de projetar, o executor deve confirmar:

- contexto resolvido como `ERP_PARCEIRO`;
- ERP identificado sem ambiguidade;
- ferramenta identificada sem ambiguidade;
- ferramenta com resultado técnico `APTO_PARA_INTEGRACOES`, status da etapa `CONCLUIDA`, prontidão `HOMOLOGADA_PARA_INTEGRACOES`, auditoria aprovada e manifesto vigente;
- Passos 01, 02, 03 e 04 concluidos, auditados quando aplicavel e vigentes;
- Passo 04 apto para servir de evidencia do projeto;
- `PLANO-DE-HOMOLOGACAO.md` existente;
- `BASE-COMERCIAL-PLANEJADA.yaml` existente;
- `BASE-MESTRA-MATERIALIZADA.yaml` existente;
- `RELATORIO-DE-MATERIALIZACAO.md` existente;
- contrato, cenarios, regras, capacidades, matriz e pendencias localizados;
- fontes suficientes para distinguir fato, derivacao, gap e decisao pendente.

Se faltar informacao recuperavel pelo operador, retornar `PENDENTE`. Se o gate upstream estiver invalido, houver identidade ambigua sem como desambiguar ou a etapa nao puder prosseguir com seguranca, retornar `BLOQUEADA`.

Nao trocar hash, reescrever upstream ou alterar contrato para fazer o gate passar.

## O que o operador precisa ter

Em uma execucao real futura, o operador precisa apenas:

- indicar que deseja projetar a integracao da combinacao atual;
- fornecer uma decisao humana somente quando existir ambiguidade realmente bloqueante;
- autorizar explicitamente uma consulta somente leitura, caso ela seja necessaria e ainda nao esteja autorizada;
- fornecer acesso seguro somente se a consulta opcional exigir e puder ocorrer sem operacao proibida.

O operador nao precisa repetir ERP, ferramenta, caminhos, capacidades, contrato, Base Mestra ou documentos ja registrados.

## Arquivos utilizados e onde ficam

O executor deve localizar automaticamente, quando existirem ou forem aplicaveis:

### Conhecimento geral do ERP

```text
erps/<erp-slug>/ANALISE-DO-ERP.md
erps/<erp-slug>/CAPACIDADES-DO-ERP.md
erps/<erp-slug>/FONTES.md
```

### Conhecimento da combinacao

```text
erps/<erp-slug>/integracoes/<ferramenta-slug>/MATRIZ-ERP-FERRAMENTA.md
erps/<erp-slug>/integracoes/<ferramenta-slug>/PENDENCIAS.md
erps/<erp-slug>/integracoes/<ferramenta-slug>/PLANO-DE-HOMOLOGACAO.md
erps/<erp-slug>/integracoes/<ferramenta-slug>/BASE-COMERCIAL-PLANEJADA.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-MATERIALIZACAO.md
```

### Base Mestra do ERP

```text
erps/<erp-slug>/homologacao/BASE-MESTRA-MATERIALIZADA.yaml
```

### Memoria da ferramenta

```text
ferramentas/<ferramenta-slug>/CONTRATO-DA-FERRAMENTA.yaml
ferramentas/<ferramenta-slug>/CENARIOS-FUNCIONAIS.md
ferramentas/<ferramenta-slug>/REGRAS-DE-NEGOCIO.md
ferramentas/<ferramenta-slug>/HOMOLOGACAO-PARA-INTEGRACOES.md
```

Se o operador fornecer uma nova fonte necessaria, o executor deve organiza-la no contexto correto da execucao. O operador nao precisa escolher o destino. Segredos devem permanecer em mecanismo local ignorado, nunca nesses artefatos.

## Auto-descoberta obrigatoria

Antes de perguntar qualquer coisa, o executor deve descobrir no repositorio:

1. ERP, ferramenta, slugs e combinacao ativa;
2. estado, manifestos, auditorias e eventual checkpoint;
3. resultado vigente dos Passos 01 a 04;
4. memoria geral do ERP;
5. contrato, cenarios funcionais e regras de negocio da ferramenta;
6. matriz, plano, Base planejada, Base Mestra e relatorio de materializacao;
7. pendencias e decisoes humanas ja registradas;
8. fontes e versoes efetivamente vigentes;
9. mapeamentos ou decisoes anteriores que nao podem ser sobrescritos cegamente.

Solicitar somente a decisao ou evidencia bloqueante que nao puder ser descoberta.

## O que esta etapa faz

- identifica objetos, conceitos, campos, relacoes, operacoes e eventos necessarios;
- prova equivalencia semantica antes de mapear;
- define fonte da verdade e proprietario do dado por conceito;
- define direcao por modulo, objeto, fluxo e evento;
- define momento de carga inicial e incremental;
- define identidades e correlacoes necessarias;
- classifica cada mapeamento;
- descreve transformacoes deterministicas;
- registra de-paras, configuracoes, customizacoes e enriquecimentos necessarios;
- distingue configuracao reutilizavel da integracao de valor concreto de cliente;
- registra gaps e pendencias no `PENDENCIAS.md` ja existente;
- usa a Base Mestra como evidencia concreta quando disponivel;
- gera os tres artefatos de projeto da combinacao;
- executa validacoes mecanicas e auditoria aplicaveis;
- retorna gate final forte para desenvolvimento futuro.

## O que esta etapa NAO faz

- nao cria codigo TypeScript;
- nao cria adaptador, runtime, servico, controller, job ou webhook;
- nao cria banco, container, deploy ou servidor;
- nao executa sincronizacao;
- nao executa `POST`, `PUT`, `PATCH` ou `DELETE`;
- nao altera schema nem cria campo customizado no ERP;
- nao altera contrato homologado da ferramenta;
- nao inventa endpoint, campo, enum, evento ou equivalencia;
- nao hardcoda configuracao de cliente na integracao reutilizavel;
- nao cria arquivo paralelo de pendencias quando `PENDENCIAS.md` ja existe;
- nao altera Harness;
- nao altera manifestos existentes fora de futuros deltas de controle expressamente autorizados pelo processo de auditoria;
- nao cria nem executa o Passo 06;
- nao inicia automaticamente etapa futura.

## Consulta somente leitura opcional

Por padrao, o Passo 05 trabalha com a memoria e as evidencias ja persistidas.

Quando houver necessidade real, documentacao e autorizacao, uma execucao futura pode usar somente:

- `GET`;
- `HEAD`;
- `OPTIONS`;
- reconsulta de registros da Base Mestra.

Continuam proibidos:

- `POST`;
- `PUT`;
- `PATCH`;
- `DELETE`;
- qualquer operacao com efeito comercial.

Se a autenticacao para a consulta exigir uma operacao proibida e nao houver sessao/token autorizado ja disponivel de forma segura, nao execute a consulta. Registre `PENDENTE_DE_EVIDENCIA` e siga documentalmente com a parte viavel.

Nunca reproduza ou persista credenciais, tokens ou segredos.

## Classificacao obrigatoria dos mapeamentos

Cada conceito/campo relevante deve usar uma destas classificacoes:

- `DIRETO`: o ERP possui informacao semanticamente equivalente;
- `DERIVADO`: a informacao pode ser calculada com seguranca a partir de dados nativos;
- `DE_PARA`: exige traducao explicita e configuravel;
- `CUSTOM_ERP`: depende de campo/extensao customizada existente ou planejada no ERP;
- `ENRIQUECIMENTO`: depende de configuracao controlada externa arquiteturalmente valida;
- `SEM_CAPACIDADE`: nao existe forma segura de produzir ou receber o dado;
- `PENDENTE_DE_DECISAO`: existem alternativas, mas falta evidencia ou decisao para escolher.

Ordem de preferencia:

1. capacidade nativa do ERP;
2. derivacao segura de dados nativos;
3. de-para explicito;
4. campo customizado ja existente;
5. novo campo customizado apenas como planejamento, se suportado e sujeito a autorizacao futura;
6. enriquecimento controlado externo;
7. gap ou `SEM_CAPACIDADE`.

Campo customizado nao e solucao automatica para toda ausencia. Enriquecimento nao pode fabricar informacao transacional inexistente.

## Fonte da verdade, direcao e momento

Para cada conceito relevante, registrar uma fonte da verdade equivalente a:

- `ERP`;
- `FERRAMENTA`;
- `INTEGRACAO_CONFIG`;
- `DERIVADO`.

Classificar a direcao por fluxo:

- `ERP_PARA_FERRAMENTA`;
- `FERRAMENTA_PARA_ERP`;
- `BIDIRECIONAL_CONTROLADO`;
- `SEM_SINCRONIZACAO`.

Classificar o momento/mecanismo somente quando sustentado pelas fontes:

- `POLLING`;
- `WEBHOOK`;
- `EVENTO_FUNCIONAL`;
- `EXPORTACAO_MANUAL`;
- `BATCH`;
- `SCHEDULE`;
- `PENDENTE_DE_EVIDENCIA`.

Nao marcar a integracao inteira genericamente como bidirecional. Para fluxo bidirecional, projetar ownership, prioridade, conflito, origem do evento e prevencao conceitual de loop.

## Identidades e correlacoes

Para cada entidade sincronizavel, definir conforme evidencia:

- ID logico da Fabrica;
- ERP ID;
- Tool ID;
- external ID/`erpId`;
- referencia;
- SKU;
- chave de negocio valida.

Nome ou descricao nao devem ser usados como identidade.

A arquitetura conceitual e:

```text
ERP ID <-> ID LOGICO <-> TOOL ID
```

O Passo 05 apenas projeta essa correlacao. Ele nao implementa banco ou armazenamento de runtime e nao hardcoda IDs fisicos da Base Mestra no mapeamento reutilizavel.

## Transformacoes deterministicas

O projeto pode usar, quando aplicavel:

- `NORMALIZACAO`;
- `DERIVACAO`;
- `COMPOSICAO`;
- `DECOMPOSICAO`;
- `DE_PARA`;
- `LOOKUP`;
- `CONCATENACAO`;
- `SPLIT`;
- `MERGE`;
- `CONVERSAO_TIPO`;
- `CONVERSAO_UNIDADE`;
- `FORMATO_DATA`;
- `PRECISAO_DECIMAL`;
- `ENUM_MAP`;
- `VALOR_CONSTANTE_JUSTIFICADO`;
- `CONDICIONAL`.

Cada regra deve indicar entradas, saida, algoritmo/regra, validacao e politica para valor desconhecido. Expressoes vagas como "ajustar para o formato da ferramenta" sao insuficientes.

O projeto deve distinguir `null`, string vazia, zero, `false` e campo ausente. Enums exigem de-para explicito; valor desconhecido nao pode ser inventado.

Para enum desconhecido, definir explicitamente uma politica sustentada pelo caso, como `BLOQUEAR_REGISTRO`, `USAR_FALLBACK_AUTORIZADO` ou `PENDENTE_DE_MAPEAMENTO`.

Quando houver `CUSTOM_ERP`, registrar necessidade, tipo, finalidade, suporte do ERP, existencia ou nao da customizacao e eventual autorizacao futura. O Passo 05 nao cria nem configura o campo. Quando houver `ENRIQUECIMENTO`, provar que a configuracao externa e estavel e comercialmente valida; ela nao pode fabricar dado transacional ausente.

## Pontos semanticos que exigem cuidado

- Grade nao exige campo homonimo: pode ser derivada de variacoes comprovadamente ligadas ao mesmo produto pai.
- Grade aberta nao prova capacidade de grade fechada/pack com composicao fixa.
- Linha nao equivale automaticamente a colecao, familia, grupo ou categoria.
- Genero nao equivale automaticamente a departamento, atributo ou classificacao.
- Campanha nao equivale automaticamente a colecao, tag ou tabela auxiliar.
- Preposto nao equivale automaticamente a vendedor auxiliar.
- Nacional/importado nao pode ser inferido por nome ou SKU.
- Preco simples nao cobre automaticamente cliente -> regiao -> tabela -> produto -> preco/visibilidade.
- Produto inexistente e diferente de produto existente mas invisivel em determinado contexto comercial.
- Pedido criado e diferente de pedido exportado/aprovado.
- Um unico endpoint ERP pode alimentar fluxos separados de nacional/importado; nao exigir dois endpoints sem evidencia.

## Relacoes, operacoes e ciclo de carga

Mapear relacoes e cardinalidades somente com evidencia, incluindo quando aplicavel:

- produto, marca, categoria, subcategoria e variacoes;
- variacao, cor, tamanho e grade;
- produto/SKU, tabela, preco e estoque por filial;
- cliente, regiao, tabela e condicao;
- representante e preposto;
- pedido, itens, cliente, condicao e status.

Para cada objeto, distinguir operacoes realmente suportadas:

- `CREATE`;
- `UPDATE`;
- `UPSERT`, somente quando comprovado;
- `READ`;
- `DELETE`, `DEACTIVATE`, `HIDE`, `IGNORE`, `PENDENTE` ou outra politica comprovada.

Nao presumir que `PUT` e upsert ou que ausencia implica exclusao.

Cada fluxo deve indicar `CARGA_INICIAL`, `INCREMENTAL` ou ambos. Paginacao, batch, volume, limites e ordem podem ser projetados, mas nao implementados.

## Configuracao de cliente e reuso

A integracao de ERP parceiro deve permanecer reutilizavel.

Registrar `CONFIGURACOES_REQUERIDAS_DO_CLIENTE`, por exemplo:

- filial/deposito utilizados;
- tabela de preco;
- codigos de representantes;
- de-paras especificos;
- parametros comerciais.

Nao preencher IDs, credenciais ou valores concretos de cliente. Esses valores pertencem a jornada ERP Cliente.

Separar sempre:

- `ERP_GERAL`;
- `COMBINACAO_ERP_FERRAMENTA`;
- `CONFIGURACAO_DO_CLIENTE`.

Conhecimento geral do ERP pode ser reutilizado em outra ferramenta. Mapeamento semantico especifico de uma ferramenta nao pode ser copiado cegamente para outra.

## Evidencia e pendencias

Estados recomendados de evidencia:

- `CONFIRMADO_POR_CONTRATO`;
- `CONFIRMADO_POR_DOCUMENTACAO`;
- `CONFIRMADO_EM_RUNTIME`;
- `DERIVADO_COM_EVIDENCIA`;
- `PENDENTE_DE_EVIDENCIA`;
- `DIVERGENTE`;
- `SEM_CAPACIDADE_CONFIRMADA`.

Ausencia de campo homonimo nao prova `SEM_CAPACIDADE`.

Pendencias de mapeamento devem ser atualizadas no `PENDENCIAS.md` da combinacao, preservando IDs, historico e achados existentes. Nao duplicar o mesmo conhecimento em arquivo paralelo.

## Idempotencia documental

Se os outputs do Passo 05 ja existirem:

- nao sobrescrever cegamente;
- comparar fontes e versoes;
- verificar mudancas no ERP, na ferramenta, nas regras e nos upstreams;
- preservar decisoes humanas anteriores;
- classificar necessidade de reutilizacao, complementacao ou reanalise;
- usar checkpoint e manifesto quando aplicavel.

## Artefatos esperados de uma execucao real

Gerar na pasta da combinacao:

```text
erps/<erp-slug>/integracoes/<ferramenta-slug>/MAPEAMENTO-SEMANTICO.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/REGRAS-DE-TRANSFORMACAO.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/PLANO-DA-INTEGRACAO.md
```

Atualizar somente quando necessario:

```text
erps/<erp-slug>/integracoes/<ferramenta-slug>/PENDENCIAS.md
```

Os tres outputs devem ser concretos o suficiente para orientar desenvolvimento futuro, mas nao podem conter codigo, segredo ou configuracao concreta de cliente.

## Gate final obrigatorio

Retornar explicitamente:

- `ERP_IDENTIFICADO: SIM | NAO`
- `FERRAMENTA_HOMOLOGADA: SIM | NAO`
- `PASSO_04_APTO: SIM | NAO`
- `MAPEAMENTO_SEMANTICO: GERADO | PARCIAL | BLOQUEADO`
- `FLUXOS: DEFINIDOS | PARCIAIS | INSUFICIENTES`
- `TRANSFORMACOES: DEFINIDAS | PARCIAIS | INSUFICIENTES`
- `IDENTIDADES: DEFINIDAS | PARCIAIS | INVALIDAS`
- `DIRECOES: DEFINIDAS | PARCIAIS`
- `EVENTOS: DEFINIDOS | PARCIAIS | PENDENTES`
- `CONFIGURACOES_REQUERIDAS: DEFINIDAS | PARCIAIS`
- `PENDENCIAS_BLOQUEANTES: <quantidade>`
- `COBERTURA_DE_MAPEAMENTO: COMPLETA | PARCIAL_JUSTIFICADA | INSUFICIENTE`
- `PRONTO_PARA_DESENVOLVIMENTO: SIM | NAO`

`PRONTO_PARA_DESENVOLVIMENTO: SIM` somente e permitido quando uma etapa futura nao precisar inventar de onde vem um conceito, qual e sua direcao, identidade, fonte da verdade, evento ou transformacao fundamental.

Cobertura `PARCIAL_JUSTIFICADA` pode ser valida quando apenas modo opcional estiver sem suporte, desde que impacto, modo afetado e limite estejam explicitos e nenhuma obrigacao do escopo principal esteja escondida.

## O que mandar para o chat do Codex

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-05-PROJETAR-INTEGRACAO-E-MAPEAMENTO.md

Projete a integracao e o mapeamento semantico da combinacao ERP x ferramenta da execucao atual.

Use auto-descoberta do contexto existente no repositorio.
Nao pedir novamente ERP, ferramenta, contrato, cenarios, regras, capacidades, matriz, Base Mestra, plano ou pendencias ja registrados.

Valide os Passos 01 a 04 e a vigencia dos upstreams antes de projetar.
Se faltar decisao ou evidencia realmente bloqueante, solicite somente o faltante.

Execute somente o Passo 05.
O Passo 05 projeta; nao desenvolve nem executa integracao.

Nao criar codigo TypeScript.
Nao criar adaptador, runtime, servico, job, webhook, banco ou deploy.
Nao executar sincronizacao.
Nao executar POST, PUT, PATCH ou DELETE.
Nao criar nem executar Passo 06.
Nao alterar contrato homologado da ferramenta.
Nao inventar equivalencias, campos, endpoints ou eventos.
Nao alterar Harness.
Nao alterar manifestos existentes fora de deltas de controle expressamente autorizados pelo processo de auditoria.

Consulta externa e opcional e somente leitura. Quando necessaria, documentada e autorizada, limitar a GET, HEAD e OPTIONS. Se nao puder ocorrer sem escrita, registrar PENDENTE_DE_EVIDENCIA.

Gerar na pasta da combinacao:
- MAPEAMENTO-SEMANTICO.yaml
- REGRAS-DE-TRANSFORMACAO.yaml
- PLANO-DA-INTEGRACAO.md

Atualizar PENDENCIAS.md somente quando necessario, sem criar arquivo paralelo.

Executar validacoes e auditoria aplicaveis.
Retornar STATUS DA ETAPA, gate de entrada, artefatos, cobertura, pendencias, gate final e proxima acao permitida.
Nao iniciar automaticamente etapa futura.
```

### PARE DE COPIAR AQUI

## Exemplo preenchido

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-05-PROJETAR-INTEGRACAO-E-MAPEAMENTO.md

Projete a integracao do ERP Bling com o Forca de Vendas usando a execucao atual.

Use todo o contexto ja persistido. Nao solicitar novamente documentos, Base Mestra ou decisoes ja registradas.

Se for indispensavel confirmar uma estrutura, estou autorizando somente leitura no ambiente de homologacao ja registrado. Nao executar POST, PUT, PATCH ou DELETE.

Execute somente o Passo 05.
Nao desenvolver codigo ou runtime.
Nao criar Passo 06.

Gere MAPEAMENTO-SEMANTICO.yaml, REGRAS-DE-TRANSFORMACAO.yaml e PLANO-DA-INTEGRACAO.md na pasta da combinacao, atualize PENDENCIAS.md apenas se necessario e retorne o gate final completo.
```

O exemplo e ilustrativo. Substitua ERP e ferramenta pelos nomes reais antes de enviar. Nao envie colchetes ou segredos.

## O que a IA fara

1. resolvera ERP, ferramenta, combinacao e estado vigente;
2. validara os Passos 01 a 04 e seus controles aplicaveis;
3. carregara contrato, cenarios, regras, capacidades, matriz, Base Mestra e pendencias;
4. identificara conceitos e sua representacao real no ERP;
5. definira fonte da verdade, direcao, ownership, evento e momento;
6. projetara identidades, correlacoes, relacoes e operacoes;
7. classificara mapeamentos e transformacoes;
8. separara configuracao reutilizavel de configuracao concreta de cliente;
9. registrara gaps e cobertura parcial sem esconder limitacoes;
10. gerara os tres outputs e atualizara pendencias apenas quando necessario;
11. validara os artefatos, executara auditoria aplicavel e retornara o gate.

## Como testar esta etapa

O teste deve validar significado e determinismo, nao apenas presenca dos arquivos.

| Cenario | Resultado esperado |
|---|---|
| A. Campo `grade` com nome igual, sem prova semantica | Nao mapear automaticamente |
| B. SKUs P/M/G/GG ligados ao mesmo produto pai | Grade pode ser `DERIVADO` com evidencia |
| C. ERP possui tamanho, mas nao pack | Grade aberta pode ser viavel; fechada nao e presumida |
| D. ERP suporta custom field para Linha | `CUSTOM_ERP` apenas planejado; nenhum campo criado |
| E. Categoria possui relacao estavel com Linha | `DE_PARA` pode ser planejado com evidencia |
| F. Nenhum dado produz tamanho | `SEM_CAPACIDADE` no cenario aplicavel |
| G. ERP possui colecao e ferramenta possui Linha | Sem equivalencia automatica |
| H. ERP possui vendedor e ferramenta possui preposto | Sem equivalencia automatica |
| I. ERP possui preco unico para regra por tabela/regiao | Cobertura parcial ou gap |
| J. Pedido criado e exportado sao momentos distintos | Evento de integracao nao e inferido |
| K. Nacional/importado usam o mesmo endpoint ERP | `SPLIT` de fluxo pode ser projetado |
| L. Enum ERP `N/I` e ferramenta `NACIONAL/IMPORTADO` | `DE_PARA` explicito |
| M. Estoque `null` e zero | Semanticas preservadas separadamente |
| N. Dois produtos com mesmo nome | Nome nao e identidade |
| O. ERP ID e `erpId` da ferramenta existem | Correlacao planejada |
| P. Mesmo dado trafega em duas direcoes | Ownership, conflito e loop conceitual definidos |
| Q. Filial concreta de um cliente | Configuracao requerida, nunca hardcode reutilizavel |
| R. ERP ja mapeado para outra ferramenta | Reusar ERP geral, nao copiar semantica especifica |
| S. Campo obrigatorio sem fonte segura | `PRONTO_PARA_DESENVOLVIMENTO: NAO` |
| T. Apenas modo opcional sem suporte | `PARCIAL_JUSTIFICADA` pode ser valida |
| U. Passo 05 cria TypeScript | Invalido |
| V. Passo 05 executa escrita de API | Invalido |
| W. Transformacao diz apenas "ajustar valor" | Insuficiente |
| X. Transformacao define entradas, saida, regra e desconhecido | Adequada |
| Y. Desenvolvimento futuro ainda teria de descobrir Grade | Passo 05 insuficiente |
| Z. Projeto resolve decisoes fundamentais e resta implementar | Objetivo atingido |

Tambem verificar:

- os tres outputs usam estrutura valida e UTF-8;
- IDs de regra/cenario existentes foram preservados;
- nenhuma equivalencia foi baseada apenas em nome;
- nenhuma decisao humana anterior foi sobrescrita;
- nenhum segredo foi persistido;
- nenhum arquivo fora da combinacao foi alterado sem necessidade;
- Harness aplicavel, `git diff --check` e auditoria da etapa foram registrados.

## Resultado esperado

O retorno deve conter:

- `STATUS DA ETAPA: CONCLUIDA | PENDENTE | BLOQUEADA`;
- gate de entrada e vigencia dos upstreams;
- caminhos dos tres artefatos;
- resumo de fontes da verdade, direcoes, eventos e identidades;
- transformacoes e configuracoes requeridas;
- gaps, pendencias e modos afetados;
- cobertura de mapeamento;
- gate final completo;
- auditoria e validacoes executadas;
- proxima acao permitida, sem autoexecucao.

## Como interpretar erros

| Situacao | Interpretacao e encaminhamento |
|---|---|
| Passo 04 ou upstream invalido | `BLOQUEADA`; retornar a etapa minima responsavel |
| Fonte mudou e impacto nao foi resolvido | Reanalise upstream; nao atualizar hash cegamente |
| Falta documento ou decisao recuperavel | `PENDENTE`; solicitar somente o item faltante |
| Identidade ERP/ferramenta ambigua | `BLOQUEADA` ate desambiguacao segura |
| Campo parecido sem prova semantica | `PENDENTE_DE_EVIDENCIA` ou gap; nunca equivalencia automatica |
| Regra obrigatoria sem fonte segura | `SEM_CAPACIDADE` ou `PENDENTE_DE_DECISAO`, conforme evidencia |
| Consulta somente leitura indisponivel | Continuar documentalmente quando possivel e registrar pendencia |
| Transformacao nao deterministica | Corrigir o projeto no proprio Passo 05 antes de nova auditoria |
| Modulo opcional nao suportado | Avaliar `PARCIAL_JUSTIFICADA` com impacto explicito |
| Contrato real parece conflitante | Parar e informar; nao alterar contrato automaticamente |

## O que fazer se houver falha

Aplicar responsabilidade minima:

- falha de identidade/contexto -> retornar ao Passo 01;
- capacidade ou evidencia do ERP insuficiente -> retornar ao Passo 02;
- plano de homologacao obsoleto ou insuficiente -> retornar ao Passo 03;
- Base Mestra/materializacao inconsistente -> retornar ao Passo 04;
- mapeamento, transformacao ou decisao arquitetural incompleta -> corrigir em nova execucao do Passo 05;
- problema encontrado durante auditoria -> registrar, reprovar e corrigir somente em execucao posterior da etapa.

Nao apagar sucessos, historico ou decisoes humanas para reiniciar.

## Status, auditoria e gate de conclusao

Usar somente:

- `CONCLUIDA`;
- `PENDENTE`;
- `BLOQUEADA`.

Uma execucao so pode terminar `CONCLUIDA` quando:

- os criterios de aceite do comando tecnico forem atendidos;
- os tres outputs existirem e forem semanticamente suficientes;
- a cobertura for `COMPLETA` ou `PARCIAL_JUSTIFICADA` valida;
- pendencias bloqueantes forem compativeis com o gate declarado;
- o manifesto for recalculado como vigente, quando aplicavel;
- a auditoria oficial separada resultar `APROVADA`;
- o gate final refletir o estado real.

Se houver problema de conteudo ou criterio, usar `AUDITORIA: REPROVADA` e `STATUS DA ETAPA: PENDENTE`. Se impedimento externo impossibilitar a propria auditoria, usar `AUDITORIA: BLOQUEADA` e `STATUS DA ETAPA: BLOQUEADA`.

Criar arquivos nao basta para concluir.

## Quando pode continuar

Somente pode haver desenvolvimento futuro quando todos estes pontos forem verdadeiros:

```text
STATUS DA ETAPA: CONCLUIDA
AUDITORIA: APROVADA
MANIFESTO: VALIDO E REUTILIZAVEL, QUANDO APLICAVEL
COBERTURA_DE_MAPEAMENTO: COMPLETA OU PARCIAL_JUSTIFICADA
PRONTO_PARA_DESENVOLVIMENTO: SIM
```

Com esse gate atendido, o Passo 06 oficialmente publicado pode ser iniciado somente por decisão do operador; nunca por autoexecução do Passo 05.

## Proximo documento

O proximo documento oficial e:

`comece-aqui/integrar-erp/erp-parceiro/06-DESENVOLVER-INTEGRACAO.md`

O Passo 06 implementa e testa localmente as decisoes aprovadas do Passo 05. Nao executar automaticamente.
