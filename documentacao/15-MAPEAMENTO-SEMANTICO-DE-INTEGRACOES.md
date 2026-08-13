# 15 - Mapeamento semântico de integrações

## 1. Objetivo

Este documento define o padrão global para projetar, sem desenvolver, uma integração reutilizável entre um ERP parceiro e uma ferramenta E-Catálogos.

A sequência oficial da jornada é:

```text
PASSO 01 -> identifica o ERP e resolve o contexto
PASSO 02 -> descobre e evidencia capacidades
PASSO 03 -> planeja a homologação da combinação
PASSO 04 -> materializa a Base no ERP autorizado
PASSO 05 -> projeta como ERP e ferramenta conversarão
```

O Passo 05 deve responder:

> De onde vem cada conceito necessário para a ferramenta, como ele é representado pelo ERP, que transformação será necessária, em qual direção ele trafega, em qual momento deve trafegar e quais gaps ainda impedem o desenvolvimento?

Seu resultado é um projeto técnico. Não é código, adaptador, runtime, sincronização nem autorização para iniciar uma etapa posterior.

## 2. Mapeamento semântico, não textual

Mapeamento semântico prova equivalência de significado. Igualdade ou semelhança de nomes não é evidência suficiente.

Não se pode concluir, por exemplo, que `ERP.grade` equivale à Grade da ferramenta, que `ERP.colecao` equivale a Linha ou que `ERP.vendedor` equivale a Preposto apenas porque os rótulos parecem relacionados.

O raciocínio obrigatório é:

```text
CONCEITO DA FERRAMENTA
        -> significado e regra de negócio
        -> dados necessários
        -> representação comprovada no ERP
        -> transformação determinística
        -> contrato homologado da ferramenta
```

Cada conclusão deve registrar significado, evidência, origem, destino e regra aplicável. Quando a equivalência não puder ser provada, o resultado deve permanecer pendente ou ser classificado como ausência de capacidade, conforme a evidência.

## 3. Autoridade do contrato e fonte da verdade

A ferramenta E-Catálogos continua soberana sobre o contrato da integração:

```text
ERP <-> adaptador do ERP <-> contrato homologado da ferramenta
```

No sentido ERP para ferramenta, a representação do ERP é adaptada ao contrato homologado. No sentido ferramenta para ERP, a semântica da ferramenta é transformada para uma representação válida e comprovada do ERP. O Passo 05 não altera o contrato para acomodar peculiaridades do ERP e não inventa campos, enums, rotas, eventos ou operações.

Soberania do contrato não significa que a ferramenta seja a origem de todos os dados. Para cada conceito deve ser registrada uma `FONTE_DA_VERDADE`:

- `ERP`: dado cuja autoridade operacional está no ERP;
- `FERRAMENTA`: dado cuja autoridade operacional está na ferramenta;
- `INTEGRACAO_CONFIG`: decisão estável e controlada mantida na configuração da integração;
- `DERIVADO`: resultado calculado a partir de fontes identificadas, com regra e evidência.

A fonte da verdade é definida por conceito ou fluxo, nunca como propriedade genérica de toda a integração. Também deve ser registrado o proprietário do dado quando houver escrita em mais de uma direção.

## 4. Escopos de conhecimento

Todo conhecimento deve permanecer no escopo correto:

- `ERP_GERAL`: capacidades próprias do ERP, como autenticação, paginação e representação nativa de objetos;
- `COMBINACAO_ERP_FERRAMENTA`: decisões de como um ERP satisfaz o contrato de uma ferramenta específica;
- `CONFIGURACAO_DO_CLIENTE`: valores concretos de uma empresa, como filial, depósito, tabela, representante e parâmetros comerciais.

Uma combinação nova pode reutilizar `ERP_GERAL`, mas não pode copiar cegamente mapeamentos de outra ferramenta. O fato de `produto.codigo` ser útil em duas integrações não prova que Linha no Força e Coleção no B2B tenham a mesma semântica.

O projeto de ERP parceiro é reutilizável e não pode conter IDs, credenciais, marcas, vendedores ou outros valores concretos de um cliente. Necessidades desse tipo devem ser listadas como `CONFIGURACOES_REQUERIDAS_DO_CLIENTE`, para preenchimento na jornada de ERP Cliente.

## 5. Evidência e estados

Cada mapeamento, relação, evento, identidade e operação deve apontar para fonte original ou evidência reproduzível. Os estados de evidência são:

- `CONFIRMADO_POR_CONTRATO`;
- `CONFIRMADO_POR_DOCUMENTACAO`;
- `CONFIRMADO_EM_RUNTIME`;
- `DERIVADO_COM_EVIDENCIA`;
- `PENDENTE_DE_EVIDENCIA`;
- `DIVERGENTE`;
- `SEM_CAPACIDADE_CONFIRMADA`.

Classificação de mapeamento e estado de evidência são dimensões diferentes. Por exemplo, `SEM_CAPACIDADE` é uma classificação; `SEM_CAPACIDADE_CONFIRMADA` registra que a ausência foi comprovada. A falta de um campo homônimo não prova ausência de capacidade.

Se houver divergência entre contrato, documentação e runtime autorizado, ela deve ficar explícita. Não se escolhe silenciosamente a versão mais conveniente.

## 6. Classificação dos mapeamentos

Todo conceito ou campo relevante deve usar exatamente uma das classificações abaixo:

- `DIRETO`: o ERP possui informação semanticamente equivalente, com evidência;
- `DERIVADO`: o resultado pode ser calculado com segurança a partir de dados nativos comprovados;
- `DE_PARA`: há tradução explícita, configurável e auditável entre domínios;
- `CUSTOM_ERP`: depende de campo ou extensão customizada do ERP, existente ou apenas planejada;
- `ENRIQUECIMENTO`: configuração ou control plane autorizado fornece informação estável que o ERP não mantém nativamente;
- `SEM_CAPACIDADE`: não há forma segura comprovada de produzir ou receber o dado exigido;
- `PENDENTE_DE_DECISAO`: existem alternativas, mas falta evidência ou decisão autorizada para escolher.

A preferência de solução é:

1. capacidade nativa do ERP;
2. derivação segura de dados nativos;
3. de-para explícito;
4. campo customizado já existente;
5. novo campo customizado, somente se suportado e futuramente autorizado;
6. enriquecimento externo controlado;
7. gap ou `SEM_CAPACIDADE`.

Campo customizado não é solução automática. No Passo 05, `CUSTOM_ERP` é apenas planejamento: necessidade, tipo, finalidade, suporte do ERP, custom existente, alternativa e eventual autorização futura. Nenhum schema é alterado.

Enriquecimento é admitido somente para dado estável e governável. Uma relação configurada entre Categoria do ERP e Linha da ferramenta pode ser um `DE_PARA`; inventar tamanhos que não existem na origem é proibido. Informação transacional ausente não pode ser fabricada pelo control plane.

## 7. Direção por fluxo

A direção deve ser definida por módulo, objeto, fluxo e evento, usando:

- `ERP_PARA_FERRAMENTA`;
- `FERRAMENTA_PARA_ERP`;
- `BIDIRECIONAL_CONTROLADO`;
- `SEM_SINCRONIZACAO`.

Não existe uma marcação global suficiente de “integração bidirecional”. Produtos podem trafegar do ERP para a ferramenta, enquanto pedidos trafegam no sentido inverso e status retornam ao sistema de origem, desde que cada capacidade esteja comprovada.

Para `BIDIRECIONAL_CONTROLADO`, o projeto deve definir:

- fonte da verdade e proprietário do dado;
- identidade e correlação;
- prioridade de atualização;
- regra de conflito;
- origem reconhecível do evento;
- estratégia conceitual de prevenção de loop;
- condição de confirmação válida no destino.

A prevenção de loop não é implementada no Passo 05, mas o projeto deve impedir que o futuro runtime trate a própria atualização refletida como um novo evento independente.

## 8. Evento e momento do fluxo

Além do objeto, o projeto registra quando a integração deve agir. Os mecanismos conceituais permitidos são:

- `POLLING`;
- `WEBHOOK`;
- `EVENTO_FUNCIONAL`;
- `EXPORTACAO_MANUAL`;
- `BATCH`;
- `SCHEDULE`;
- `PENDENTE_DE_EVIDENCIA`.

Só se escolhe um mecanismo com suporte documentado ou confirmado. A existência de um endpoint de pedido não prova a existência de webhook, polling incremental confiável ou evento comercial adequado.

Em particular:

```text
PEDIDO_CRIADO != PEDIDO_EXPORTADO
```

Se a regra comercial manda enviar o pedido ao ERP somente após exportação ou aprovação, o fluxo não pode nascer automaticamente na criação. Quando o evento comercial é conhecido, mas o mecanismo técnico ainda não foi confirmado, o evento permanece `PENDENTE_DE_EVIDENCIA`.

## 9. Identidade e correlação

Cada entidade sincronizada deve declarar, conforme o contrato real:

- ID lógico da Fábrica;
- ID físico do ERP;
- ID físico da ferramenta;
- `externalId`, `erpId` ou referência equivalente;
- SKU, quando tiver semântica de identidade;
- chave de negócio e seu escopo;
- estratégia de consulta, criação e atualização.

Nome ou descrição nunca pode ser a identidade. Dois produtos chamados “Camiseta Preta” continuam sendo registros diferentes.

A arquitetura de correlação deve ser planejada como:

```text
ERP_ID <-> ID_LOGICO <-> TOOL_ID
```

O projeto registra qual correlação o runtime precisará persistir e consultar, sem implementar banco e sem hardcodar IDs físicos observados na Base Mestra. Identidades da Base são apenas evidências de teste.

## 10. Transformações determinísticas

Regras de transformação devem ser referenciadas por ID e usar um dos tipos:

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

Uma regra determinística declara entradas, saída, tipos, pré-condições, passos ordenados ou algoritmo inequívoco, parâmetros, validações e política de erro ou valor desconhecido. “Ajustar para o formato da ferramenta” é insuficiente.

Para enums, o mapa deve ser explícito. Por exemplo, se comprovado para uma combinação, `N` pode ser traduzido para `NACIONAL` por `ENUM_MAP`; sem prova, não existe tradução. Valores desconhecidos usam uma política declarada:

- `BLOQUEAR_REGISTRO`;
- `USAR_FALLBACK_AUTORIZADO`, com autorização e justificativa;
- `PENDENTE_DE_MAPEAMENTO`.

`null`, `""`, `0`, `false` e campo ausente são estados distintos. A regra deve definir seu comportamento quando relevante, especialmente em estoque, preço, desconto, flags, datas e campos opcionais. Defaults e constantes exigem justificativa e evidência; nunca podem esconder ausência de dado obrigatório.

## 11. Relações e cardinalidade

O mapeamento cobre relações, não apenas campos isolados. Entre outras aplicáveis, devem ser analisadas:

- Produto -> Marca, Categoria, Subcategoria e Variações;
- Variação -> Cor e Tamanho;
- Produto ou SKU -> Preço e Estoque por filial;
- Cliente -> Região -> Tabela;
- Representante -> Preposto;
- Pedido -> Itens, Cliente e Condição.

Cada relação registra significado, direção, chaves, cardinalidade e evidência. Cardinalidade nunca é inferida por conveniência.

Dependências entre fluxos também devem ser explícitas. Por exemplo, um item de pedido não deve ser enviado antes de as identidades de pedido e produto necessárias estarem resolvidas.

## 12. Casos semânticos obrigatórios

### 12.1 Grade aberta e Grade fechada

Grade não exige campo chamado `grade`. Ela pode ser `DERIVADO` quando SKUs ou variações compartilham comprovadamente um produto pai e possuem tamanhos válidos. A regra deve declarar agrupamento, unicidade e ordenação.

Grade aberta e Grade fechada ou Pack não podem ser colapsadas:

```text
tamanhos P/M/G/GG
!=
composição 1P + 2M + 2G + 1GG
```

Existência de tamanho não prova composição fixa. Sem evidência de pack, o cenário fica `PENDENTE_DE_DECISAO` com evidência `PENDENTE_DE_EVIDENCIA`, ou `SEM_CAPACIDADE` quando a ausência tiver sido confirmada.

### 12.2 Linha, Gênero, Campanha e Preposto

Linha pode estar representada por linha, coleção, família, grupo, categoria, custom, de-para ou enriquecimento. Gênero pode vir de atributo, departamento, classificação, custom ou de-para. Campanha pode vir de capacidade nativa, coleção, tag, tabela auxiliar ou configuração. Nenhuma opção é aceita apenas pelo nome.

Preposto não é sinônimo automático de vendedor auxiliar. A equivalência comercial, o papel e a relação com o representante precisam de evidência.

### 12.3 Preço, Tabela, Região e Visibilidade

Um campo de preço único não cobre uma regra que exija:

```text
CLIENTE -> REGIAO -> TABELA -> PRODUTO -> PRECO / VISIBILIDADE
```

O projeto deve verificar tabelas, vínculos, preços, identificadores e possibilidade segura de derivação ou configuração. Se o ERP tiver apenas preço único e o cenário exigir segmentação, deve haver gap ou cobertura parcial justificada.

Produto inexistente é diferente de produto existente, mas invisível em determinado contexto comercial. Visibilidade é um conceito mapeável, com fonte da verdade, regra e evidência próprias.

### 12.4 Nacional e importado

Origem ou procedência não pode ser inferida por nome ou SKU. Deve vir de dado real, de-para comprovado ou configuração autorizada.

Um único catálogo ou endpoint do ERP pode alimentar dois fluxos por uma transformação `SPLIT`. Isso não autoriza inventar dois endpoints no ERP.

## 13. Operações e ciclo de vida

O projeto registra as operações necessárias em origem e destino, sempre ligadas à capacidade ou ao contrato que as comprova:

- `READ`;
- `CREATE`;
- `UPDATE`;
- `UPSERT`, somente quando explicitamente suportado;
- `DELETE` ou `DEACTIVATE`, quando aplicáveis.

`PUT` não significa automaticamente `UPSERT`. Ausência em uma consulta não significa exclusão. Para remoção ou inativação, deve ser escolhida e evidenciada uma política:

- `DELETE`;
- `DEACTIVATE`;
- `HIDE`;
- `IGNORE`;
- `PENDENTE`.

O Passo 05 não executa nenhuma dessas escritas; apenas projeta o comportamento futuro.

## 14. Carga inicial, incremental, paginação e volume

Cada fluxo deve declarar se usa `CARGA_INICIAL`, `INCREMENTAL` ou ambos. Produto pode exigir carga completa e incrementais posteriores; pedido normalmente depende de evento ou processo incremental comprovado.

O projeto registra paginação, cursor, filtros, batch, limites, ordenação e dependências descobertas, sem criar scheduler ou runtime. Uma carga inicial deve percorrer todas as páginas aplicáveis; a primeira página nunca é tratada como conjunto completo sem evidência.

## 15. Base Mestra como evidência

A Base Mestra materializada no Passo 04 pode ser reconsultada como caso de prova para relações, variações, imagens, estoque e outros conceitos. O projeto compara o planejado, o observado no ERP e a representação esperada no contrato da ferramenta.

Os IDs físicos observados ficam na evidência da execução. O mapeamento reutilizável usa papéis de identidade e referências lógicas, não valores físicos de uma organização ou cliente.

## 16. Leitura opcional e segurança

Numa execução real futura, o Passo 05 pode usar somente `GET`, `HEAD` e `OPTIONS` documentados e autorizados para confirmar estrutura ou reconsultar a Base Mestra. O ambiente deve estar resolvido e autorizado antes da chamada.

São proibidos no Passo 05:

- `POST`, `PUT`, `PATCH` e `DELETE`;
- criação ou alteração de campos customizados;
- sincronização e mutação de dados;
- uso de produção sem autorização específica;
- persistência de credenciais, tokens ou respostas sensíveis.

Segredos são usados apenas de modo transitório, em arquivo local ignorado quando necessário, sem aparecer em artefatos, logs, relatórios ou respostas. Evidências persistidas devem ser redigidas.

## 17. Artefatos de uma execução real

Uma combinação deve produzir em `erps/<erp-slug>/integracoes/<ferramenta-slug>/`:

```text
MAPEAMENTO-SEMANTICO.yaml
REGRAS-DE-TRANSFORMACAO.yaml
PLANO-DA-INTEGRACAO.md
```

Se `PENDENCIAS.md` já existir, as pendências do mapeamento são classificadas e atualizadas nele. Não se cria arquivo paralelo nem se apagam pendências anteriores.

Os artefatos são reutilizáveis e devem registrar fontes, versões, evidências e decisões. Se já existirem, a execução compara baseline, mudanças upstream e intervenção humana antes de editar. Decisões humanas são preservadas; mudança de contrato, capacidade, regra, Base ou versão relevante exige reanálise do delta alcançado.

Estado, auditoria, manifesto e checkpoint da execução devem seguir as regras gerais da Fábrica. Os modelos globais não substituem esses controles e não alteram manifestos já homologados.

## 18. Cobertura e gaps

Todo requisito obrigatório sem fonte, derivação, configuração segura ou decisão comprovada é gap bloqueante. Um modo opcional sem suporte pode resultar em `PARCIAL_JUSTIFICADA` quando:

- o modo e o impacto estão explícitos;
- o cenário afetado está identificado;
- o escopo principal continua íntegro;
- nenhuma obrigação é escondida;
- o desenvolvimento não precisará inventar a arquitetura restante.

Quantidade de campos mapeados não prova cobertura. A avaliação considera fluxos, relações, eventos, identidades, transformações e regras de negócio.

## 19. Gate do Passo 05

O gate deve registrar exatamente:

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

`PASSO_04_APTO: SIM` exige artefatos vigentes, estado concluído, auditoria aprovada, manifesto válido quando aplicável, gate final suficiente, correlações utilizáveis e nenhuma falha bloqueante. A mera presença dos arquivos não basta.

`PRONTO_PARA_DESENVOLVIMENTO: SIM` só é permitido quando uma etapa futura não precisar decidir de onde vem um conceito obrigatório, qual evento dispara o fluxo, como a entidade é identificada, qual direção é válida, quem é dono do dado, como enums são traduzidos ou como uma ausência será tratada.

Se houver decisão arquitetural fundamental pendente, o resultado é `NAO`, ainda que muitos campos estejam preenchidos.

## 20. Fronteira com desenvolvimento

O Passo 05 termina no projeto. Ele não cria TypeScript, classes, adaptadores, serviços, controllers, jobs, webhooks, gerenciadores de token, banco, Docker, runtime ou deploy.

Uma etapa posterior poderá desenvolver a integração a partir destes artefatos. Esta referência conceitual não cria, libera nem executa o Passo 06.
