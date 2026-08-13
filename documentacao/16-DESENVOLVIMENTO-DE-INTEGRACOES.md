# 16 - Desenvolvimento de integrações

## 1. Objetivo

Este documento define o padrão estrutural do ERP Parceiro - Passo 06 - Desenvolver Integração.

O Passo 06 transforma o projeto aprovado e vigente do Passo 05 em código executável e testado. Ele não redescobre o mapeamento, não homologa a integração e não executa sincronização real contra ERP ou ferramenta.

Sequência oficial:

```text
PASSO 01 -> identifica o ERP
PASSO 02 -> descobre capacidades
PASSO 03 -> projeta a homologação
PASSO 04 -> materializa a Base Mestra no ERP
PASSO 05 -> decide como ERP e ferramenta conversam
PASSO 06 -> implementa e testa essas decisões
```

O resultado máximo desta etapa é:

```text
PRONTO_PARA_EXECUCAO_HML: SIM
```

O Passo 06 nunca declara `INTEGRACAO_HOMOLOGADA`. Uma etapa posterior, ainda não publicada, poderá executar e validar a implementação em HML.

## 2. Regra central: decisão versus implementação

```text
PASSO 05 = DECISAO
PASSO 06 = IMPLEMENTACAO
```

O Passo 06 implementa exatamente `MAPEAMENTO-SEMANTICO.yaml`, `REGRAS-DE-TRANSFORMACAO.yaml` e `PLANO-DA-INTEGRACAO.md` aprovados. Não pode trocar silenciosamente campo, direção, evento, identidade, fonte da verdade, ownership, enum, transformação ou política de ausência por uma alternativa que pareça mais simples.

Quando o código não corresponde a uma decisão clara do Passo 05, trata-se de `BUG_DE_IMPLEMENTACAO` e a correção pertence ao próprio Passo 06.

Quando evidência nova demonstra que a decisão upstream é impossível, incorreta ou insuficiente, trata-se de `DIVERGENCIA_DE_PROJETO`. A execução deve parar o fluxo afetado, registrar evidência e retornar ao menor passo responsável. Arquitetura upstream não pode ser corrigida escondida no código.

## 3. Pré-condições

Uma execução real só pode desenvolver quando confirmar:

- `ERP_IDENTIFICADO: SIM`;
- `FERRAMENTA_HOMOLOGADA: SIM`;
- Passo 05 concluído, auditado e vigente;
- `PRONTO_PARA_DESENVOLVIMENTO: SIM`;
- `MAPEAMENTO-SEMANTICO.yaml` existente e suficiente;
- `REGRAS-DE-TRANSFORMACAO.yaml` existente e determinístico;
- `PLANO-DA-INTEGRACAO.md` existente e suficiente;
- pendências bloqueantes compatíveis com o gate declarado;
- contrato, regras, capacidades, Base e snapshots relevantes vigentes.

Mudança upstream relevante impede desenvolvimento sobre projeto possivelmente obsoleto. Não trocar hash nem atualizar código automaticamente para fazer o gate passar.

## 4. Inputs obrigatórios

### Memória geral do ERP

```text
erps/<erp-slug>/ANALISE-DO-ERP.md
erps/<erp-slug>/CAPACIDADES-DO-ERP.md
erps/<erp-slug>/FONTES.md
```

### Base Mestra

```text
erps/<erp-slug>/homologacao/BASE-MESTRA-MATERIALIZADA.yaml
```

### Memória da combinação

```text
erps/<erp-slug>/integracoes/<ferramenta-slug>/MATRIZ-ERP-FERRAMENTA.md
erps/<erp-slug>/integracoes/<ferramenta-slug>/PENDENCIAS.md
erps/<erp-slug>/integracoes/<ferramenta-slug>/PLANO-DE-HOMOLOGACAO.md
erps/<erp-slug>/integracoes/<ferramenta-slug>/BASE-COMERCIAL-PLANEJADA.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-MATERIALIZACAO.md
erps/<erp-slug>/integracoes/<ferramenta-slug>/MAPEAMENTO-SEMANTICO.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/REGRAS-DE-TRANSFORMACAO.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/PLANO-DA-INTEGRACAO.md
```

### Memória da ferramenta

```text
ferramentas/<ferramenta-slug>/CONTRATO-DA-FERRAMENTA.yaml
ferramentas/<ferramenta-slug>/CENARIOS-FUNCIONAIS.md
ferramentas/<ferramenta-slug>/REGRAS-DE-NEGOCIO.md
ferramentas/<ferramenta-slug>/HOMOLOGACAO-PARA-INTEGRACOES.md
```

Itens não aplicáveis devem ser justificados; itens obrigatórios ausentes bloqueiam o escopo alcançado.

## 5. Descoberta da arquitetura executável

Antes de criar ou editar código, a execução deve inspecionar a arquitetura real do repositório, incluindo:

- `package.json`, lockfile e workspaces;
- `tsconfig*.json` e configurações de build/lint/test;
- `src/`, `packages/`, `apps/`, `libs/`, `integracoes/`, `erps/` e convenções existentes;
- código reutilizável de ERP e ferramenta;
- testes, fixtures, configuração, observabilidade e tratamento de erros existentes.

Não se impõe nome de pasta, classe, framework, package manager ou comando sem evidência física.

### Baseline desta publicação estrutural

Na criação deste padrão, o estado observado foi:

```text
ARQUITETURA_EXECUTAVEL_EXISTENTE: PARCIAL
```

Existe destino conceitual em `erps/` para artefatos técnicos, mas não existe implementação executável que defina estrutura física canônica: não foram encontrados package manager, lockfile, workspace, TypeScript, `tsconfig`, diretórios de aplicação ou testes. `scripts/harness/` é infraestrutura PowerShell de validação mecânica e não é runtime de integração. Referências históricas também não são arquitetura oficial.

Uma execução real futura deve reavaliar o estado corrente. Se ainda não houver padrão físico, deve registrar uma decisão mínima, explícita e auditável antes de criar código. Se não puder decidir com segurança, usar `ARQUITETURA_EXECUTAVEL: INSUFICIENTE`; não criar estrutura arbitrária.

## 6. Responsabilidades lógicas obrigatórias

Os caminhos físicos podem variar conforme a arquitetura descoberta, mas estas responsabilidades não podem ser misturadas sem justificativa.

### SHARED_CORE

Infraestrutura realmente transversal e comprovadamente reutilizável, como contratos comuns de HTTP, erros, observabilidade e correlação.

Não deve conter semântica de ERP, ferramenta ou combinação. Não criar abstração por previsão.

### ERP_REUSABLE

Conhecimento executável específico do ERP que pode servir a várias ferramentas:

- autenticação e refresh suportados;
- cliente HTTP e headers do ERP;
- serialização e DTOs brutos;
- paginação e rate limit do ERP;
- normalização de erros;
- operações confirmadas.

O cliente do ERP não contém regra comercial de uma ferramenta. Um método conceitual `listProducts` pode pertencer ao ERP; `getProductsForForca` mistura responsabilidades.

### TOOL_REUSABLE

Conhecimento executável da ferramenta E-Catálogos reutilizável entre vários ERPs:

- autenticação e cliente da ferramenta;
- DTOs e validação do contrato homologado;
- operações homologadas;
- tratamento técnico específico da ferramenta.

O cliente da ferramenta não conhece ERP específico e não deve ser duplicado por combinação.

### COMBINATION_SPECIFIC

Código próprio da combinação ERP x ferramenta:

- mappers e transformações;
- de-paras conceituais;
- flows e orquestração específica;
- direções, ownership e eventos;
- composição entre clients;
- políticas da combinação aprovadas no Passo 05.

## 7. Limites de abstração

Não criar mega modelo universal de ERP. Representação intermediária só é válida quando simplifica uma transformação concreta e documentada; nunca substitui o contrato da ferramenta ou o mapeamento semântico.

Criar ou promover abstração apenas quando:

- já existir padrão no repositório;
- houver necessidade concreta atual;
- a responsabilidade for realmente compartilhada;
- ou o componente for fundamentalmente transversal.

A primeira integração não autoriza construir framework especulativo. Dependência nova exige necessidade, compatibilidade e justificativa; operações triviais não justificam pacote pesado.

## 8. Clients e contratos externos

Clients devem expor capacidades técnicas do sistema a que pertencem e preservar DTOs externos na fronteira apropriada. Regras da combinação ficam fora deles.

Somente operações comprovadas podem ser implementadas. `PUT` não implica `UPSERT`, ausência em listagem não implica `DELETE` e endpoint disponível não prova o evento comercial correto.

O contrato homologado da ferramenta permanece somente leitura. Teste que revela incompatibilidade não autoriza alterar o contrato para fazer o código passar.

## 9. Mappers e transformers

Cada transformação deve corresponder a um ID de `REGRAS-DE-TRANSFORMACAO.yaml` e ser pequena, determinística e testável.

Uma regra válida possui entradas, saídas, tipos, pré-condições, algoritmo ou passos ordenados, validações e política de valor desconhecido/erro. Expressões vagas como “ajustar valor” não são implementáveis.

Preservar separadamente:

```text
null
campo ausente
""
0
false
```

Não usar lógica equivalente a `value || default` quando zero ou `false` forem válidos. Valores monetários preservam precisão; datas e timezone seguem o Passo 05 e o contrato.

Todo `ENUM_MAP` deve ser explícito. Valor desconhecido usa apenas `BLOQUEAR_REGISTRO`, `USAR_FALLBACK_AUTORIZADO` ou `PENDENTE_DE_MAPEAMENTO`, conforme o projeto.

## 10. Grade e relações comerciais

Grade derivada usa somente entradas e relações aprovadas. Não inferir tamanho por nome, descrição ou SKU sem regra explícita e evidenciada.

Grade aberta e Grade fechada/Pack são comportamentos distintos. Tamanhos não provam composição fixa.

Relações, cardinalidades e dependências do Passo 05 devem ser respeitadas, incluindo, quando aplicável, produto/variação, preço/tabela/região, estoque/filial, cliente, representante/preposto e pedido/itens.

## 11. Flows, direção e eventos

A implementação deve ser separada por fluxo ou módulo; não concentrar toda a integração em classe ou arquivo monolítico.

Cada flow conhece:

- origem e destino;
- direção;
- evento comercial e mecanismo técnico;
- identidade e correlação;
- transformação;
- política de erro;
- dependências e confirmação.

Direções válidas vêm do Passo 05: `ERP_PARA_FERRAMENTA`, `FERRAMENTA_PARA_ERP`, `BIDIRECIONAL_CONTROLADO` e `SEM_SINCRONIZACAO`. Não promover a integração inteira a bidirecional.

Eventos implementados também vêm do Passo 05. `PEDIDO_CRIADO != PEDIDO_EXPORTADO`; webhook não pode ser criado apenas por conveniência.

## 12. Carga, paginação e batch

`CARGA_INICIAL` e `INCREMENTAL` são fluxos distintos quando planejados. Carga inicial percorre todo o conjunto aplicável; a primeira página nunca representa o universo sem evidência.

Paginação pertence principalmente ao client da API responsável e segue o mecanismo confirmado (`page`, `offset`, cursor, token ou outro). Testar página única, múltiplas páginas, final, vazio, cursor ausente e erro intermediário.

Batch size respeita limite documentado ou configuração validada. Não escolher valor arbitrário quando existir limite da API.

## 13. Auth, token, retry e rate limit

Implementar somente a autenticação confirmada para o sistema: API Key, Bearer, OAuth, JWT, login/senha, refresh token ou outra evidenciada. Não criar abstração OAuth onde OAuth não existe.

Quando houver token renovável:

1. token válido é reutilizado;
2. token expirando/expirado é renovado pelo mecanismo suportado;
3. um `401` permite no máximo uma renovação e um retry controlados por operação;
4. nova falha encerra e reporta.

Esse comportamento não obriga uma classe chamada `TokenManager`; nomes e composição devem seguir a arquitetura existente.

Retry é limitado a falhas transitórias quando a operação for segura. `429` respeita `Retry-After` quando disponível. `5xx` pode ter retry limitado. `4xx` funcional, `MAPPING_ERROR` e `VALIDATION_ERROR` não recebem retry cego.

## 14. Correlação, idempotência e loop

A implementação deve estar preparada para:

```text
ERP_ID <-> ID_LOGICO <-> TOOL_ID
```

Nome ou descrição nunca é chave de correlação. IDs físicos da Base Mestra não são hardcoded.

Writes futuros devem usar identidade, lookup e política de create/update comprovados. A regra “não achei localmente, então POST” é inválida.

Para `BIDIRECIONAL_CONTROLADO`, implementar a estratégia de origem da mudança e prevenção de loop definida no Passo 05. Não criar banco nesta tarefa estrutural; numa execução real, usar a porta ou persistência coerente com a arquitetura aprovada.

## 15. Configuração e segredos

Valores específicos de cliente são parâmetros, nunca hardcode reutilizável. Isso inclui filial, depósito, tabela de preço, representante, cliente, marca, tenant, ID comercial e credencial.

O Passo 06 pode implementar schema/configuração tipada necessária, sem valores reais. Valores concretos pertencem à jornada ERP Cliente ou ao ambiente autorizado.

Credenciais podem ser recebidas e usadas somente quando autorizadas, mas nunca persistidas, reproduzidas, incluídas em fixture ou retornadas. Preferir mecanismo de secrets existente e validar ignore antes de usar arquivo local.

## 16. Logs, observabilidade e erros

Logs estruturados devem permitir diagnóstico por flow, execução, entidade, correlation id, operação, status e erro, sem senha, token, API key, refresh token ou payload pessoal desnecessário.

Respeitar taxonomia existente. Na ausência de taxonomia, categorias conceituais podem incluir `AUTH_ERROR`, `NETWORK_ERROR`, `RATE_LIMIT_ERROR`, `VALIDATION_ERROR`, `MAPPING_ERROR`, `CONTRACT_ERROR`, `NOT_FOUND`, `CONFLICT`, `DEPENDENCY_ERROR` e `UNEXPECTED_ERROR`.

## 17. Testes obrigatórios

Uma execução real deve criar, conforme aplicável:

- testes unitários;
- testes de transformação e mapper;
- testes de contrato/DTO;
- testes de flow com clients mockados;
- testes de auth, paginação, retry e erros;
- testes de validação de configuração.

Testes normais não dependem de rede externa. Usar mocks, fakes, payloads documentados e fixtures sintéticas, determinísticas, sem secrets e sem PII real desnecessária.

A Base Mestra pode inspirar diversidade representativa, mas não deve ser copiada em volume artificial. Testar regras e variedade, não 200 registros reais.

O Passo 06 não executa HML nem sincroniza dados reais.

## 18. TypeScript, dependências e comandos

Respeitar integralmente package manager, TypeScript, lint, formatter, build e testes já existentes. Não trocar framework, não fazer upgrade amplo e não alterar `tsconfig` global sem necessidade concreta.

Preferir tipagem explícita e evitar `any`; qualquer exceção deve ser justificada no relatório.

Descobrir os comandos reais do projeto para build, typecheck, lint e test. Não hardcodar comandos genéricos quando o repositório usar outros.

## 19. Outputs de uma execução real

Além do código na arquitetura física aprovada, gerar na memória da combinação:

```text
erps/<erp-slug>/integracoes/<ferramenta-slug>/MANIFESTO-DA-IMPLEMENTACAO.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-DESENVOLVIMENTO.md
```

Usar os modelos em `parceiros/modelos/desenvolvimento/`. Esta tarefa estrutural cria somente modelos globais; não cria outputs de combinação nem código concreto.

## 20. Vigência e idempotência documental

Antes de desenvolver, congelar/referenciar inputs relevantes. Mudança posterior em mapeamento, transformações, plano, contrato, regra, capacidade ERP ou Base alcançada pode classificar a implementação como `IMPLEMENTACAO_POTENCIALMENTE_OBSOLETA`.

Se implementação já existir, comparar versão, fontes, Passo 05, código, testes, decisões humanas e alterações manuais válidas. Não sobrescrever cegamente nem regravar apenas para alterar timestamp.

## 21. Auditoria e fronteira externa

O Passo 06 desenvolve e testa localmente. Não executa `POST`, `PUT`, `PATCH` ou `DELETE` em ERP ou ferramenta, não popula Base Mestra e não sincroniza.

Consulta somente leitura excepcional para esclarecer divergência técnica segue documentação, autorização, ambiente e segurança existentes. Ela não transforma o Passo 06 em etapa de HML.

Execução produtora e auditoria são separadas. Durante auditoria, código e artefatos auditados ficam imutáveis. Problema encontrado reprova; correção ocorre em nova execução produtora e exige nova auditoria.

Commit e push são decisões separadas do operador.

## 22. Gate final

Registrar exatamente:

```text
ERP_IDENTIFICADO: SIM | NAO
FERRAMENTA_HOMOLOGADA: SIM | NAO
PASSO_05_APTO: SIM | NAO
PROJETO_VIGENTE: SIM | NAO
ARQUITETURA_EXECUTAVEL: DEFINIDA | INSUFICIENTE
ESCOPO_DE_DESENVOLVIMENTO: DEFINIDO | PARCIAL | INSUFICIENTE
CODIGO: GERADO | PARCIAL | NAO_GERADO
FLUXOS_IMPLEMENTADOS: COMPLETOS | PARCIAIS | INSUFICIENTES
BUILD: APROVADO | REPROVADO | NAO_APLICAVEL
TYPECHECK: APROVADO | REPROVADO | NAO_APLICAVEL
LINT: APROVADO | REPROVADO | NAO_APLICAVEL
TESTES_UNITARIOS: APROVADOS | REPROVADOS | INSUFICIENTES
TESTES_TRANSFORMACAO: APROVADOS | REPROVADOS | INSUFICIENTES
TESTES_FLUXO: APROVADOS | REPROVADOS | INSUFICIENTES
AUTH: IMPLEMENTADA | PARCIAL | NAO_APLICAVEL | INSUFICIENTE
PAGINACAO: IMPLEMENTADA | NAO_APLICAVEL | INSUFICIENTE
RETRY_RATE_LIMIT: IMPLEMENTADO | NAO_APLICAVEL | INSUFICIENTE
CONFIGURACAO: DEFINIDA | PARCIAL | INSUFICIENTE
SEGREDOS_NO_REPOSITORIO: NAO | SIM
DIVERGENCIAS_DE_PROJETO: <quantidade>
PENDENCIAS_BLOQUEANTES: <quantidade>
ESCRITA_HML_EXECUTADA: NAO
PRONTO_PARA_EXECUCAO_HML: SIM | NAO
```

`PRONTO_PARA_EXECUCAO_HML: SIM` exige projeto vigente, aderência ao Passo 05, arquitetura e configuração definidas, código e flows suficientes, validações aplicáveis aprovadas, testes necessários aprovados, nenhum secret, nenhuma divergência bloqueante, nenhuma decisão arquitetural fundamental pendente e nenhuma escrita HML executada.

Cobertura `PARCIAL_JUSTIFICADA` do Passo 05 permite implementar somente o núcleo homologável aprovado, desde que o escopo não suportado e seu impacto permaneçam explícitos.

## 23. Próxima etapa

O Passo 06 é a última etapa oficial disponível da jornada ERP parceiro. Não existe Passo 07 oficial ou executável.

Uma etapa posterior poderá executar e validar a implementação em HML, mas esta referência não cria nome, comando, runtime ou autorização de execução externa.
