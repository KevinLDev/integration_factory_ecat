# ERP Parceiro - Passo 05 - Projetar integração e mapeamento semântico

## Finalidade

Executar somente o Passo 05 da jornada de ERP parceiro e transformar os resultados válidos dos Passos 01 a 04 em um projeto técnico completo, rastreável e reutilizável da integração ERP x ferramenta E-Catálogos.

Este passo responde:

> De onde vem cada conceito necessário para a ferramenta, como ele é representado pelo ERP, que transformação será necessária, em qual direção ele trafega, em qual momento deve trafegar e quais gaps ainda impedem o desenvolvimento?

O resultado é projeto, não implementação.

## Resultado oficial da sequência

```text
PASSO 01 -> identifica
PASSO 02 -> descobre capacidades
PASSO 03 -> planeja homologação
PASSO 04 -> materializa Base no ERP
PASSO 05 -> projeta como ERP e ferramenta conversarão
```

## Fronteira obrigatória

O Passo 05 pode:

- ler a memória já persistida do ERP, da ferramenta e da combinação;
- comparar contrato, regras, capacidades e evidências;
- usar a Base Mestra materializada como caso de prova;
- em execução real futura, reconsultar dados por `GET`, `HEAD` ou `OPTIONS` documentado e autorizado quando a evidência existente for insuficiente;
- registrar mapeamentos, transformações, fluxos, decisões, gaps e pendências;
- executar validações locais, Harness e auditoria aplicável.

O Passo 05 não pode:

- criar TypeScript, classes, adaptadores, serviços, controllers, jobs, webhooks ou runtime;
- executar sincronização;
- executar `POST`, `PUT`, `PATCH` ou `DELETE`;
- alterar schema ou criar campo customizado no ERP;
- alterar o contrato homologado da ferramenta;
- inventar equivalências, campos, enums, relações, cardinalidades, eventos, rotas ou operações;
- hardcodar valores de cliente;
- criar, liberar ou executar o Passo 06;
- alterar Harness ou manifestos já homologados fora do controle próprio de uma execução futura desta etapa;
- iniciar automaticamente etapa posterior.

Uma etapa posterior poderá desenvolver a integração a partir dos artefatos aprovados. Esta frase é apenas o limite conceitual do handoff e não cria um comando novo.

## Instruções e doutrina obrigatórias

Antes de agir, ler integralmente:

- `AGENTS.md` da raiz e `AGENTS.md` aplicáveis;
- `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`;
- `documentacao/11-MEMORIA-DE-ERPS-E-COMBINACOES.md`;
- `documentacao/12-MEMORIA-FUNCIONAL-DAS-FERRAMENTAS.md`;
- `documentacao/13-PADRAO-GLOBAL-DE-MASSA-COMERCIAL.md`;
- `documentacao/14-MEMORIA-DE-REGRAS-DE-NEGOCIO-DAS-FERRAMENTAS.md`;
- `documentacao/15-MAPEAMENTO-SEMANTICO-DE-INTEGRACOES.md`;
- documentação de segurança e credenciais aplicável;
- documentos técnicos e operacionais dos Passos 01 a 04.

Usar os modelos:

- `parceiros/modelos/mapeamento/MODELO-MAPEAMENTO-SEMANTICO.yaml`;
- `parceiros/modelos/mapeamento/MODELO-REGRAS-DE-TRANSFORMACAO.yaml`;
- `parceiros/modelos/mapeamento/MODELO-PLANO-DA-INTEGRACAO.md`.

## Gate de entrada obrigatório

Resolver e retornar:

```text
ERP_IDENTIFICADO: SIM | NAO
FERRAMENTA_HOMOLOGADA: SIM | NAO
PASSO_04_APTO: SIM | NAO
```

### ERP identificado

`ERP_IDENTIFICADO: SIM` exige resolução inequívoca do ERP, do slug e da memória geral correspondente. Nome informado no chat não substitui a identidade persistida.

### Ferramenta homologada

`FERRAMENTA_HOMOLOGADA: SIM` exige conjuntamente:

```text
RESULTADO TECNICO: APTO_PARA_INTEGRACOES
PASSO 03 DA FERRAMENTA: CONCLUIDA
AUDITORIA 03: APROVADA E VIGENTE
PRONTIDAO: HOMOLOGADA_PARA_INTEGRACOES
MANIFESTO 03: VALIDO E COM GATE ATENDIDO
```

O contrato e seus artefatos canônicos são somente leitura nesta jornada.

### Passo 04 apto

`PASSO_04_APTO: SIM` não significa apenas que arquivos existem. Exige, quando os controles forem aplicáveis à execução:

- Passos 01 a 04 da combinação identificados e coerentes;
- status do Passo 04 `CONCLUIDA`;
- auditoria aprovada e vigente;
- manifesto da etapa válido, reutilizável e com gate atendido;
- plano e snapshot upstream vigentes;
- Base Mestra e relatório de materialização localizáveis;
- materialização `COMPLETA` ou `PARCIAL_JUSTIFICADA`;
- reconsulta suficiente;
- correlações válidas ou parciais com justificativa não bloqueante;
- zero falhas bloqueantes;
- gate final do Passo 04 apto ao uso subsequente.

Se controles de vigência obrigatórios ainda não existirem, não presumir aptidão: registrar a lacuna e bloquear ou deixar pendente conforme recuperabilidade.

## Resolução automática de contexto

O operador pode dizer apenas, por exemplo, “Projete a integração do ERP Bling com o Força de Vendas”. O executor deve localizar automaticamente o contexto já persistido e não perguntar novamente por fatos existentes.

A busca deve resolver, no mínimo:

### Memória geral do ERP

Em `erps/<erp-slug>/`, quando existirem:

- `ANALISE-DO-ERP.md`;
- `CAPACIDADES-DO-ERP.md`;
- `FONTES.md`;
- demais evidências explicitamente referenciadas.

### Memória da combinação

Em `erps/<erp-slug>/integracoes/<ferramenta-slug>/`, quando existirem:

- `MATRIZ-ERP-FERRAMENTA.md`;
- `PENDENCIAS.md`;
- `PLANO-DE-HOMOLOGACAO.md`;
- `BASE-COMERCIAL-PLANEJADA.yaml`;
- `RELATORIO-DE-MATERIALIZACAO.md`;
- outputs anteriores do Passo 05.

### Memória de homologação do ERP

Em `erps/<erp-slug>/homologacao/`, quando existir:

- `BASE-MESTRA-MATERIALIZADA.yaml`.

### Memória da ferramenta

Na execução homologada da ferramenta, quando existirem ou se aplicarem:

- `CONTRATO-DA-FERRAMENTA.yaml`;
- `CENARIOS-FUNCIONAIS.md`;
- `REGRAS-DE-NEGOCIO.md`;
- `HOMOLOGACAO-PARA-INTEGRACOES.md`;
- fontes e auditorias vigentes referenciadas pelo manifesto.

Perguntar ao operador somente por decisão realmente ambígua e bloqueante que não possa ser resolvida por fonte ou evidência. O restante deve ser classificado sem invenção.

## Hierarquia de autoridade

Para fatos técnicos, respeitar:

1. documentação oficial e OpenAPI/Swagger vigente;
2. evidência do ambiente autorizado;
3. testes reproduzíveis;
4. decisão de negócio explicitamente aprovada;
5. documentação gerada pela Fábrica;
6. implementação histórica apenas como referência.

O contrato homologado da ferramenta é soberano para a forma da integração, mas a fonte da verdade de cada dado pode ser `ERP`, `FERRAMENTA`, `INTEGRACAO_CONFIG` ou `DERIVADO`.

## Snapshot e idempotência documental

Antes de editar qualquer output:

1. registrar os caminhos, versões, hashes e vigências efetivamente disponíveis;
2. verificar se os outputs do Passo 05 já existem;
3. comparar fontes, versão do ERP, versão da ferramenta, contrato, regras, Base, decisões anteriores e intervenção humana;
4. preservar decisões humanas e conteúdo válido não alcançado pelo delta;
5. classificar mudança upstream e a extensão da reanálise;
6. não sobrescrever cegamente nem recalcular hashes para “deixar verde”.

Quando a mudança atingir uma premissa semântica, reanalisar os fluxos dependentes. Quando nenhum upstream mudou, priorizar leitura por delta sem reduzir a auditoria obrigatória.

## Processo obrigatório

Executar na ordem:

1. validar o contexto e as instruções aplicáveis;
2. resolver ERP e ferramenta sem duplicar memória;
3. validar vigência, auditoria e gates dos Passos 01 a 04;
4. carregar o contrato homologado da ferramenta;
5. carregar os cenários funcionais;
6. carregar as regras de negócio;
7. carregar capacidades e fontes do ERP;
8. carregar Base Mestra, plano e relatório de materialização;
9. carregar a matriz ERP x ferramenta;
10. carregar `PENDENCIAS.md`, preservando itens existentes;
11. identificar objetos, conceitos, relações e operações no escopo;
12. definir fonte da verdade e proprietário por conceito;
13. definir direção por fluxo, não globalmente;
14. definir evento comercial, momento e mecanismo técnico comprovado;
15. mapear identidades e correlações necessárias;
16. mapear relações e cardinalidades com evidência;
17. mapear campos pelo significado, tipos e semântica de valores;
18. classificar cada mapeamento;
19. criar regras de transformação determinísticas;
20. identificar enums, lookups e de-paras explícitos;
21. identificar configurações requeridas do cliente sem preencher valores;
22. identificar customizações planejadas, enriquecimentos, gaps e decisões pendentes;
23. validar cobertura por módulo, cenário e fluxo;
24. gerar os três outputs obrigatórios na memória da combinação;
25. atualizar o `PENDENCIAS.md` existente somente quando necessário, sem duplicar itens;
26. congelar outputs, executar Harness e auditoria aplicáveis e retornar o gate.

Durante uma auditoria independente, os artefatos produtores ficam congelados. Correção decorrente de reprovação pertence a nova execução produtora, seguida de nova auditoria. Manifesto, estado, checkpoint e relatório de auditoria próprios de uma execução real ficam em `parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/`, conforme as regras gerais; este comando não altera manifestos existentes de ferramentas.

## Regra central de equivalência

```text
MAPEAMENTO SEMANTICO != CORRESPONDENCIA DE NOMES
```

Todo mapeamento deve provar:

```text
conceito da ferramenta
-> significado e regra de negócio
-> dados necessários
-> representação real no ERP
-> transformação
-> representação válida no contrato
```

Campos homônimos sem prova permanecem pendentes. Conceitos com nomes diferentes podem ser equivalentes somente quando a evidência demonstra o mesmo significado e comportamento.

## Classificações obrigatórias

Cada conceito ou campo relevante deve usar uma classificação, separada do estado da evidência:

- `DIRETO`: informação semanticamente equivalente já existe;
- `DERIVADO`: informação é calculável com segurança a partir de dados nativos;
- `DE_PARA`: tradução explícita e configurável;
- `CUSTOM_ERP`: dependência de extensão customizada, apenas planejada nesta etapa;
- `ENRIQUECIMENTO`: configuração externa estável e controlada, sem fabricar dado transacional;
- `SEM_CAPACIDADE`: impossibilidade segura comprovada;
- `PENDENTE_DE_DECISAO`: alternativas existem, mas falta evidência ou decisão.

Ordem obrigatória de preferência:

1. capacidade nativa;
2. derivação segura;
3. de-para explícito;
4. custom existente;
5. novo custom suportado e futuramente autorizado;
6. enriquecimento controlado;
7. gap ou `SEM_CAPACIDADE`.

Não criar campo customizado nem alterar schema. Não usar enriquecimento para inventar dados.

## Estados de evidência

Usar:

- `CONFIRMADO_POR_CONTRATO`;
- `CONFIRMADO_POR_DOCUMENTACAO`;
- `CONFIRMADO_EM_RUNTIME`;
- `DERIVADO_COM_EVIDENCIA`;
- `PENDENTE_DE_EVIDENCIA`;
- `DIVERGENTE`;
- `SEM_CAPACIDADE_CONFIRMADA`.

`SEM_CAPACIDADE` só é conclusivo com prova suficiente. Ausência de nome equivalente não é prova.

## Direções e bidirecionalidade

Por fluxo, usar:

- `ERP_PARA_FERRAMENTA`;
- `FERRAMENTA_PARA_ERP`;
- `BIDIRECIONAL_CONTROLADO`;
- `SEM_SINCRONIZACAO`.

Em `BIDIRECIONAL_CONTROLADO`, definir fonte da verdade, ownership, identidade, correlação, prioridade, conflito, origem do evento e estratégia conceitual de loop. Se qualquer item fundamental estiver indefinido, o fluxo não está pronto.

## Eventos e momento comercial

Usar somente mecanismo confirmado:

- `POLLING`;
- `WEBHOOK`;
- `EVENTO_FUNCIONAL`;
- `EXPORTACAO_MANUAL`;
- `BATCH`;
- `SCHEDULE`;
- `PENDENTE_DE_EVIDENCIA`.

Registrar evento comercial e mecanismo técnico separadamente. `PEDIDO_CRIADO` não equivale a `PEDIDO_EXPORTADO`. Não projetar envio na criação quando a regra exige exportação ou aprovação. Endpoint CRUD não prova evento.

## Identidade e correlações

Para cada entidade, documentar o papel aplicável de:

- ID lógico da Fábrica;
- ERP ID;
- Tool ID;
- `externalId`, `erpId` ou referência;
- SKU;
- chave de negócio e escopo.

Nome não pode identificar uma entidade. Projetar a correlação `ERP_ID <-> ID_LOGICO <-> TOOL_ID`, inclusive lookup e estratégia de create/update, sem implementar banco e sem incluir IDs físicos da Base no mapeamento reutilizável.

## Campos, valores e transformações

Cada campo aplicável deve registrar origem, destino, tipos, nulabilidade, obrigatoriedade, classificação, transformação, default justificado, de-para, validação, evidência e status. Campos não aplicáveis não precisam ser artificialmente preenchidos.

As regras devem usar um dos tipos suportados pelos modelos e conter entradas, saídas, pré-condições, algoritmo ou passos ordenados, parâmetros, validação e política de valor desconhecido.

Não tratar como equivalentes:

```text
null
""
0
false
campo ausente
```

Para enum desconhecido, usar uma política explícita:

- `BLOQUEAR_REGISTRO`;
- `USAR_FALLBACK_AUTORIZADO`, com autorização registrada;
- `PENDENTE_DE_MAPEAMENTO`.

É inválida uma regra vaga como “ajustar o valor”. O projeto deve ser implementável sem nova decisão semântica.

## Relações, operações e ciclo de vida

Mapear relações e cardinalidades com evidência, incluindo dependências entre fluxos. Não reduzir Produto, Variação, Tabela, Região, Estoque, Pedido e seus vínculos a campos isolados.

Mapear `READ`, `CREATE`, `UPDATE`, `UPSERT`, `DELETE` e `DEACTIVATE` somente quando suportados. Não inferir `UPSERT` de `PUT`, nem `DELETE` da ausência. A política de remoção deve ser uma escolha comprovada entre `DELETE`, `DEACTIVATE`, `HIDE`, `IGNORE` ou `PENDENTE`.

O projeto dessas operações não autoriza executá-las no Passo 05.

## Carga, paginação e volume

Cada fluxo deve declarar `CARGA_INICIAL`, `INCREMENTAL` ou ambos, além de paginação, filtros, cursor, batch, limites, ordenação e dependências quando conhecidos. Nunca assumir que a primeira página representa o conjunto completo.

Não implementar scheduler, fila ou mecanismo de retry nesta etapa.

## Configurações, customizações e enriquecimento

Listar `CONFIGURACOES_REQUERIDAS_DO_CLIENTE`, como filial, tabela, representantes, depósitos e de-paras específicos, apenas como requisitos tipados e validados. Não preencher valores reais.

Para `CUSTOM_ERP`, registrar necessidade, tipo, finalidade, suporte, custom existente e autorização futura necessária. Para `ENRIQUECIMENTO`, registrar fonte controlada, estabilidade, chave, dado fornecido e prova de que não fabrica informação transacional.

## Casos semânticos que exigem verificação

### Grade

Grade pode ser derivada de variações ou SKUs ligados a um produto pai, sem campo homônimo, desde que relação, agrupamento, unicidade e ordenação estejam comprovados. Grade aberta não prova Grade fechada ou composição de Pack.

### Linha, Gênero, Campanha e Preposto

Coleção não equivale automaticamente a Linha; vendedor não equivale automaticamente a Preposto. A mesma cautela vale para gênero e campanha. Exigir significado e evidência comercial.

### Preço, Tabela, Região e Visibilidade

Preço único não cobre automaticamente a cadeia Cliente -> Região -> Tabela -> Produto -> Preço/Visibilidade. Produto inexistente é diferente de produto existente, mas invisível no contexto comercial.

### Nacional e importado

Não inferir origem por nome ou SKU. Um único endpoint do ERP pode alimentar fluxos separados por `SPLIT`; não inventar dois endpoints.

## Outputs obrigatórios de uma execução real

Gerar somente na memória da combinação:

```text
erps/<erp-slug>/integracoes/<ferramenta-slug>/MAPEAMENTO-SEMANTICO.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/REGRAS-DE-TRANSFORMACAO.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/PLANO-DA-INTEGRACAO.md
```

Atualizar `PENDENCIAS.md` quando necessário. Não criar segundo arquivo de pendências e não apagar histórico válido.

## Cobertura

Classificar:

- `COMPLETA`: todos os fluxos e cenários obrigatórios do escopo têm decisões suficientes;
- `PARCIAL_JUSTIFICADA`: limitação opcional está explícita, impacto delimitado e núcleo obrigatório permanece implementável;
- `INSUFICIENTE`: há conceito, fluxo ou decisão fundamental obrigatório sem solução segura.

Um campo obrigatório da ferramenta sem fonte, derivação ou configuração segura torna `PRONTO_PARA_DESENVOLVIMENTO: NAO`. Quantidade de campos mapeados não compensa um evento, identidade ou regra fundamental ausente.

## Gate final obrigatório

Retornar exatamente:

```text
ERP_IDENTIFICADO: SIM | NAO
FERRAMENTA_HOMOLOGADA: SIM | NAO
PASSO_04_APTO: SIM | NAO
MAPEAMENTO_SEMANTICO: GERADO | PARCIAL | BLOQUEADO
FLUXOS: DEFINIDOS | PARCIAIS | INSUFICIENTES
TRANSFORMACOES: DEFINIDAS | PARCIAIS | INSUFICIENTES
IDENTIDADES: DEFINIDAS | PARCIAIS | INVALIDAS
DIRECOES: DEFINIDAS | PARCIAIS
EVENTOS: DEFINIDOS | PARCIAIS | PENDENTES
CONFIGURACOES_REQUERIDAS: DEFINIDAS | PARCIAIS
PENDENCIAS_BLOQUEANTES: <quantidade>
COBERTURA_DE_MAPEAMENTO: COMPLETA | PARCIAL_JUSTIFICADA | INSUFICIENTE
PRONTO_PARA_DESENVOLVIMENTO: SIM | NAO
```

`PRONTO_PARA_DESENVOLVIMENTO: SIM` exige zero pendências arquiteturais bloqueantes e outputs aprovados, coerentes e suficientes para implementação sem redescobrir origem de conceito, direção, evento, identidade, ownership, enum ou política de ausência.

## Status da etapa

Usar somente:

- `CONCLUIDA`: gate suficiente, outputs congelados, Harness aplicável aprovado, auditoria aprovada e controles de vigência válidos;
- `PENDENTE`: falta recuperável de decisão, fonte, autorização ou evidência;
- `BLOQUEADA`: gate de entrada inválido, contradição impeditiva ou impossibilidade segura do escopo obrigatório.

Não marcar `CONCLUIDA` apenas porque os arquivos foram gerados.

## Cenários mínimos de validação A-Z

- **A.** Campo `grade` com nome igual e sem prova semântica: não mapear automaticamente.
- **B.** SKUs P/M/G/GG com relação pai/variação comprovada: Grade pode ser `DERIVADO` com regra determinística.
- **C.** Tamanho sem composição de Pack: Grade aberta pode ser possível; Grade fechada não está automaticamente coberta.
- **D.** ERP suporta custom para Linha: `CUSTOM_ERP` pode ser planejado; não criar o campo.
- **E.** ERP sem custom e relação Categoria -> Linha estável e comprovada: `DE_PARA` pode ser alternativa.
- **F.** Nenhum dado pode produzir tamanho, com ausência comprovada: não inventar Grade; classificar o cenário como `SEM_CAPACIDADE`.
- **G.** ERP tem Coleção e ferramenta tem Linha: exigir equivalência de significado.
- **H.** ERP tem Vendedor e ferramenta tem Preposto: exigir equivalência comercial.
- **I.** ERP tem preço único e cenário exige Tabela/Região: registrar gap ou cobertura parcial, não cobertura total.
- **J.** Pedido criado e exportado são momentos distintos: usar o evento comercial correto; mecanismo incerto fica pendente.
- **K.** Nacional e importado vêm do mesmo endpoint: permitir `SPLIT` sem inventar dois endpoints.
- **L.** Enum ERP `N/I` e ferramenta `NACIONAL/IMPORTADO`: exigir `DE_PARA` ou `ENUM_MAP` explícito.
- **M.** Estoque `null` e estoque zero: preservar a diferença.
- **N.** Dois produtos têm o mesmo nome: nome não é identidade.
- **O.** Produto possui ERP ID e `erpId` na ferramenta: projetar correlação com ID lógico.
- **P.** Mesmo conceito trafega nas duas direções: exigir ownership, conflito, origem de evento e prevenção conceitual de loop.
- **Q.** Fluxo exige filial do Cliente X: declarar configuração de cliente sem hardcode.
- **R.** Já existe ERP x ferramenta A e chega ferramenta B: reutilizar `ERP_GERAL`, não copiar semântica específica.
- **S.** Campo obrigatório sem fonte, derivação ou configuração segura: `PRONTO_PARA_DESENVOLVIMENTO: NAO`.
- **T.** Modo opcional sem suporte, com núcleo completo: `PARCIAL_JUSTIFICADA` pode ser válida se impacto estiver explícito.
- **U.** Passo 05 cria TypeScript: inválido.
- **V.** Passo 05 executa escrita no ERP ou ferramenta: inválido.
- **W.** Regra diz apenas “ajustar valor”: insuficiente.
- **X.** Regra possui entradas, saída, algoritmo, validações e política desconhecida: estruturalmente adequada.
- **Y.** Desenvolvimento ainda precisaria decidir de onde vem Grade: Passo 05 insuficiente e gate `NAO`.
- **Z.** Projeto fecha decisões fundamentais e deixa somente implementação: objetivo do Passo 05 atingido.

## Validações antes do retorno

1. conferir que os três outputs concretos estão apenas na pasta da combinação;
2. validar sintaxe e UTF-8 dos YAMLs e Markdown;
3. verificar referências, versões e hashes registrados;
4. conferir que classificação e estado de evidência não foram misturados;
5. conferir que nenhum segredo, credencial ou token foi persistido ou impresso e que nenhum valor concreto de cliente foi hardcodado;
6. conferir que `PENDENCIAS.md` não foi duplicado;
7. confirmar ausência de código, runtime e chamadas de escrita;
8. executar `scripts/harness/harness.cmd files` em todos os arquivos criados ou alterados;
9. executar `git diff --check`;
10. executar auditoria semântica independente contra este comando, a doutrina e as fontes;
11. atualizar apenas controles próprios da execução depois da auditoria, conforme a Constituição;
12. retornar status, gates, evidências, outputs, pendências e próxima ação permitida.

## Como executar (operador)

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-05-PROJETAR-INTEGRACAO-E-MAPEAMENTO.md

Continue a jornada de ERP parceiro da execução atual e execute somente o Passo 05.

Projete a integração e o mapeamento semântico da combinação ERP x ferramenta já identificada.

Descubra automaticamente no repositório o ERP, a ferramenta, as análises, capacidades, fontes, matriz, pendências, plano de homologação, Base planejada, Base Mestra materializada, relatório de materialização, contrato, cenários, regras e homologação vigentes.

Não peça novamente contexto já persistido. Pergunte somente por decisão realmente ambígua e bloqueante.

Valide primeiro a vigência e os gates dos Passos 01 a 04.

Não desenvolva código ou runtime.
Não execute sincronização.
Não execute POST, PUT, PATCH ou DELETE.
Não altere schema do ERP nem contrato da ferramenta.
Não invente equivalências, operações, eventos ou cardinalidades.
Não hardcode valores de cliente.
Não crie nem execute Passo 06.

Se precisar confirmar evidência no ambiente autorizado, use apenas GET, HEAD ou OPTIONS documentado, com segredos transitórios e redigidos.

Gere na memória da combinação:
- MAPEAMENTO-SEMANTICO.yaml
- REGRAS-DE-TRANSFORMACAO.yaml
- PLANO-DA-INTEGRACAO.md

Atualize o PENDENCIAS.md existente somente quando necessário, sem criar arquivo paralelo.

Execute as validações, o Harness e a auditoria aplicáveis.
Retorne STATUS DA ETAPA, gate de entrada, gate final, fontes, evidências, cobertura, outputs, pendências e próxima ação permitida.

Não faça commit.
Não faça push.
Pare após o retorno do Passo 05.
```

### PARE DE COPIAR AQUI

## Retorno obrigatório

```text
STATUS DA ETAPA: CONCLUIDA | PENDENTE | BLOQUEADA

GATE DE ENTRADA:
- ERP_IDENTIFICADO
- FERRAMENTA_HOMOLOGADA
- PASSO_04_APTO

FONTES E VERSOES:
<snapshot efetivamente usado>

OUTPUTS:
- MAPEAMENTO-SEMANTICO.yaml
- REGRAS-DE-TRANSFORMACAO.yaml
- PLANO-DA-INTEGRACAO.md
- PENDENCIAS.md: INALTERADO | ATUALIZADO

GATE FINAL:
- ERP_IDENTIFICADO
- FERRAMENTA_HOMOLOGADA
- PASSO_04_APTO
- MAPEAMENTO_SEMANTICO
- FLUXOS
- TRANSFORMACOES
- IDENTIDADES
- DIRECOES
- EVENTOS
- CONFIGURACOES_REQUERIDAS
- PENDENCIAS_BLOQUEANTES
- COBERTURA_DE_MAPEAMENTO
- PRONTO_PARA_DESENVOLVIMENTO

EVIDENCIAS:
<fontes e conclusoes sustentadas>

GAPS E PENDENCIAS:
<itens, impacto e bloqueio>

HARNESS:
<arquivos validados, resultado e exit code>

AUDITORIA: APROVADA | REPROVADA | BLOQUEADA
VIGENCIA DA AUDITORIA:
<resultado e evidencia>

PROXIMA ACAO PERMITIDA:
executar somente o Passo 06 - Desenvolver Integração, conforme `parceiros/comandos/ERP-PARCEIRO-06-DESENVOLVER-INTEGRACAO.md`, quando o gate do Passo 05 estiver atendido e por decisão do operador; não autoexecutar.
```
