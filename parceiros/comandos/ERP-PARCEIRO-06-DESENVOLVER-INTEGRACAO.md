# ERP Parceiro - Passo 06 - Desenvolver integração

## Finalidade

Transformar o projeto aprovado e vigente do Passo 05 em código executável e testado, preservando todas as decisões semânticas e arquiteturais já homologadas para desenvolvimento.

O Passo 06 termina, no máximo, com:

```text
PRONTO_PARA_EXECUCAO_HML: SIM
```

Ele não declara `INTEGRACAO_HOMOLOGADA` e não executa ERP ou ferramenta em HML. A execução e validação externas pertencem a uma etapa posterior ainda não publicada.

## Regra central

```text
PASSO 05 = DECISAO
PASSO 06 = IMPLEMENTACAO
```

Implementar exatamente o mapeamento, as transformações, os flows, as identidades, as direções, os eventos, o ownership e as políticas definidos no Passo 05.

É proibido substituir silenciosamente uma decisão upstream por alternativa “mais fácil”. Evidência de que o projeto está errado gera `DIVERGENCIA_DE_PROJETO` e retorno ao menor passo responsável. Erro de código que contradiz decisão clara é `BUG_DE_IMPLEMENTACAO` e pode ser corrigido no próprio Passo 06.

## Doutrina obrigatória

Antes de agir, ler integralmente:

- `AGENTS.md` e `parceiros/AGENTS.md`;
- `parceiros/00-GUIA-DE-EXECUCAO.md`;
- `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`;
- `documentacao/11-MEMORIA-DE-ERPS-E-COMBINACOES.md`;
- `documentacao/12-MEMORIA-FUNCIONAL-DAS-FERRAMENTAS.md`;
- `documentacao/13-PADRAO-GLOBAL-DE-MASSA-COMERCIAL.md`;
- `documentacao/14-MEMORIA-DE-REGRAS-DE-NEGOCIO-DAS-FERRAMENTAS.md`;
- `documentacao/15-MAPEAMENTO-SEMANTICO-DE-INTEGRACOES.md`;
- `documentacao/16-DESENVOLVIMENTO-DE-INTEGRACOES.md`;
- documentos técnicos e operacionais dos Passos 01 a 05;
- modelos do Passo 05 e de desenvolvimento;
- documentação existente sobre Harness, credenciais, segurança e estrutura executável.

## Gate de entrada obrigatório

Resolver e registrar:

```text
ERP_IDENTIFICADO: SIM | NAO
FERRAMENTA_HOMOLOGADA: SIM | NAO
PASSO_05_APTO: SIM | NAO
PROJETO_VIGENTE: SIM | NAO
```

`FERRAMENTA_HOMOLOGADA: SIM` exige resultado técnico `APTO_PARA_INTEGRACOES`, auditoria aprovada e vigente, etapa concluída, prontidão `HOMOLOGADA_PARA_INTEGRACOES` e manifesto válido com gate atendido.

`PASSO_05_APTO: SIM` exige:

- status `CONCLUIDA`;
- auditoria aprovada e vigente;
- manifesto válido e reutilizável quando aplicável;
- `PRONTO_PARA_DESENVOLVIMENTO: SIM`;
- cobertura `COMPLETA` ou `PARCIAL_JUSTIFICADA` válida;
- `MAPEAMENTO-SEMANTICO.yaml`, `REGRAS-DE-TRANSFORMACAO.yaml` e `PLANO-DA-INTEGRACAO.md` íntegros;
- decisões fundamentais suficientes;
- pendências bloqueantes compatíveis com o gate.

`PROJETO_VIGENTE: SIM` exige comparar os snapshots relevantes do Passo 05 com contrato, regras, capacidades, Base e outros upstreams alcançados. Divergência relevante bloqueia desenvolvimento e retorna ao menor passo responsável. Não recalcular hash cegamente.

## Auto-descoberta obrigatória

O operador não deve repetir fatos já persistidos. Resolver automaticamente:

1. ERP, ferramenta, slugs e combinação;
2. estado, auditorias, manifestos e checkpoint aplicáveis;
3. gates dos Passos 01 a 05;
4. memória geral do ERP e memória da ferramenta;
5. Base Mestra e artefatos da combinação;
6. outputs e decisões do Passo 05;
7. código, configuração e testes existentes;
8. arquitetura física, package manager, TypeScript e comandos do projeto;
9. componentes reutilizáveis de ERP e ferramenta;
10. decisões humanas e alterações manuais que devem ser preservadas.

Perguntar somente por decisão realmente ambígua e bloqueante.

## Inputs obrigatórios

Localizar, quando aplicáveis:

```text
erps/<erp-slug>/ANALISE-DO-ERP.md
erps/<erp-slug>/CAPACIDADES-DO-ERP.md
erps/<erp-slug>/FONTES.md
erps/<erp-slug>/homologacao/BASE-MESTRA-MATERIALIZADA.yaml

erps/<erp-slug>/integracoes/<ferramenta-slug>/MATRIZ-ERP-FERRAMENTA.md
erps/<erp-slug>/integracoes/<ferramenta-slug>/PENDENCIAS.md
erps/<erp-slug>/integracoes/<ferramenta-slug>/PLANO-DE-HOMOLOGACAO.md
erps/<erp-slug>/integracoes/<ferramenta-slug>/BASE-COMERCIAL-PLANEJADA.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-MATERIALIZACAO.md
erps/<erp-slug>/integracoes/<ferramenta-slug>/MAPEAMENTO-SEMANTICO.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/REGRAS-DE-TRANSFORMACAO.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/PLANO-DA-INTEGRACAO.md

ferramentas/<ferramenta-slug>/CONTRATO-DA-FERRAMENTA.yaml
ferramentas/<ferramenta-slug>/CENARIOS-FUNCIONAIS.md
ferramentas/<ferramenta-slug>/REGRAS-DE-NEGOCIO.md
ferramentas/<ferramenta-slug>/HOMOLOGACAO-PARA-INTEGRACOES.md
```

## Inspeção obrigatória da arquitetura

Antes de definir caminhos de código, inspecionar:

- `package.json`, lockfiles e workspaces;
- `tsconfig*.json`;
- `src/`, `packages/`, `apps/`, `libs/`, `integracoes/`, `erps/` e diretórios equivalentes;
- código, testes, fixtures e configurações existentes;
- build, typecheck, lint e test reais;
- padrões de HTTP, auth, erros, logs, paginação, retry e correlação já usados.

Classificar:

```text
ARQUITETURA_EXECUTAVEL_EXISTENTE: SIM | NAO | PARCIAL
```

Reutilizar arquitetura existente. Se ainda não houver padrão físico, registrar decisão mínima e auditável antes do código, sem criar framework especulativo. Se a decisão segura não puder ser tomada, retornar `ARQUITETURA_EXECUTAVEL: INSUFICIENTE`.

## Arquitetura lógica obrigatória

Separar responsabilidades:

- `SHARED_CORE`: apenas infraestrutura realmente transversal;
- `ERP_REUSABLE`: auth, HTTP, DTOs, paginação, rate limit e erros próprios do ERP;
- `TOOL_REUSABLE`: client, DTOs e operações homologadas da ferramenta, sem conhecer ERP específico;
- `COMBINATION_SPECIFIC`: mappers, transformações, flows, direções, eventos e composição ERP x ferramenta.

Não criar mega modelo universal, client que misture os dois sistemas ou abstração por previsão. Representação intermediária não substitui contrato e mapeamento.

## Processo obrigatório

Executar na ordem:

1. validar contexto e instruções aplicáveis;
2. validar o Passo 05 e seus controles;
3. validar vigência do projeto e upstreams;
4. carregar `MAPEAMENTO-SEMANTICO.yaml`;
5. carregar `REGRAS-DE-TRANSFORMACAO.yaml`;
6. carregar `PLANO-DA-INTEGRACAO.md`;
7. inspecionar arquitetura executável real;
8. descobrir código reutilizável;
9. definir e registrar o escopo exato de arquivos;
10. separar `SHARED_CORE`, `ERP_REUSABLE`, `TOOL_REUSABLE` e `COMBINATION_SPECIFIC`;
11. implementar somente infraestrutura estritamente necessária;
12. implementar ou reutilizar client do ERP quando necessário;
13. implementar ou reutilizar client da ferramenta quando necessário;
14. implementar mappers;
15. implementar transformers;
16. implementar flows;
17. implementar auth conforme capacidade real;
18. implementar paginação completa quando aplicável;
19. implementar políticas de erro, retry e rate limit;
20. implementar configuração tipada sem valores de cliente;
21. implementar correlação, idempotência e loop conforme arquitetura;
22. adicionar observabilidade sem secrets;
23. criar fixtures sintéticas e sanitizadas;
24. criar testes aplicáveis;
25. executar build, typecheck, lint e test descobertos no projeto;
26. classificar bugs versus divergências upstream;
27. gerar `MANIFESTO-DA-IMPLEMENTACAO.yaml`;
28. gerar `RELATORIO-DE-DESENVOLVIMENTO.md`;
29. atualizar `PENDENCIAS.md` somente quando necessário;
30. congelar outputs, executar validações/auditoria e retornar o gate.

## Regras de implementação

### Clients

O client do ERP concentra capacidades do ERP e não contém regra comercial da ferramenta. O client da ferramenta segue o contrato homologado e não conhece ERP específico. Não duplicar client reutilizável por combinação.

### Mappers e transformações

Implementar os IDs do Passo 05 com funções determinísticas, pequenas e testáveis. Preservar `null`, ausente, vazio, zero e `false`. Não perder precisão decimal ou timezone. Enums usam mapa e política de desconhecido explícitos.

Grade derivada usa somente as entradas aprovadas. Grade aberta e Grade fechada/Pack não são colapsadas.

### Flows

Separar por módulo/fluxo. Cada flow deve conhecer origem, destino, direção, evento, identidade, transformação, política de erro, dependências e confirmação. Evitar arquivo ou classe monolítica.

Direção e evento vêm do Passo 05. Não tornar tudo bidirecional e não confundir `PEDIDO_CRIADO` com `PEDIDO_EXPORTADO`.

### Carga, paginação e batch

Implementar `CARGA_INICIAL` e `INCREMENTAL` separadamente quando planejados. Paginação deve percorrer todas as páginas e ser testada para uma/múltiplas/final/vazia/cursor ausente/erro intermediário. Batch respeita limite documentado ou configuração validada.

### Auth e retry

Implementar somente a estratégia comprovada. Token renovável permite uma renovação e um retry controlados após `401`; nova falha encerra. Não há loops de login/refresh/retry.

Retry limitado apenas para falhas transitórias e operações seguras. `429` respeita `Retry-After` quando disponível. `4xx` funcional, mapping e validation errors não recebem retry cego.

### Correlação, idempotência e loop

Preparar `ERP_ID <-> ID_LOGICO <-> TOOL_ID`. Nome nunca é identidade; IDs físicos não são hardcoded. Create/update/upsert seguem contrato e projeto; `PUT` não prova upsert.

Fluxo bidirecional respeita ownership, origem da mudança, conflito e prevenção de loop do Passo 05.

### Configuração e segurança

Filial, depósito, tabela, representante, tenant, cliente, marca, ID comercial e credencial concretos não podem ser hardcoded. Criar apenas requisitos/configuração tipada sem valores reais.

Nunca versionar, imprimir, logar ou inserir secret em fixture. Logs estruturados devem redigir credenciais e evitar payload pessoal desnecessário.

## Testes obrigatórios

Criar, conforme aplicável:

- unitários;
- transformação e mapper;
- contrato/DTO;
- flows com clients mockados;
- auth;
- paginação;
- retry/rate limit;
- erros;
- validação de configuração.

Testes normais não usam rede externa. Fixtures são sintéticas, determinísticas, sem secrets e sem PII real desnecessária. A Base Mestra pode inspirar variedade sem copiar volume inteiro.

## TypeScript e dependências

Respeitar package manager, TypeScript, `tsconfig`, framework, lint, formatter, build e testes existentes. Não fazer upgrade amplo nem adicionar dependência para operação trivial. Preferir tipagem explícita e evitar `any`; exceção exige justificativa.

Usar somente comandos existentes/descobertos no projeto. Não introduzir linter ou formatter apenas para a combinação.

## Outputs de uma execução real

Gerar código na arquitetura física aprovada e, na memória da combinação:

```text
erps/<erp-slug>/integracoes/<ferramenta-slug>/MANIFESTO-DA-IMPLEMENTACAO.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-DESENVOLVIMENTO.md
```

Usar:

- `parceiros/modelos/desenvolvimento/MODELO-MANIFESTO-DA-IMPLEMENTACAO.yaml`;
- `parceiros/modelos/desenvolvimento/MODELO-RELATORIO-DE-DESENVOLVIMENTO.md`.

Atualizar somente o `PENDENCIAS.md` canônico da combinação quando necessário.

## Vigência e implementação existente

Congelar/referenciar os inputs antes de desenvolver. Mudança posterior pode gerar `IMPLEMENTACAO_POTENCIALMENTE_OBSOLETA`.

Se código ou outputs já existirem, comparar fontes, versão, Passo 05, testes, decisões humanas e alterações manuais válidas. Não sobrescrever cegamente nem regravar sem mudança material.

## Fronteira externa

O Passo 06 não executa sincronização, não popula Base Mestra e não faz `POST`, `PUT`, `PATCH` ou `DELETE` em ERP ou ferramenta.

Consulta read-only excepcional só pode ocorrer quando documentada, necessária e autorizada, com ambiente resolvido e segredos seguros. Não transformar a etapa em HML.

Não criar runtime 24/7, banco, Docker, deploy ou Passo 07 nesta etapa estrutural. Uma execução real só cria infraestrutura estritamente necessária ao código local e aprovada pela arquitetura.

## Bug versus divergência

- decisão clara, implementação incorreta: `BUG_DE_IMPLEMENTACAO`; corrigir no Passo 06;
- campo/semântica upstream comprovadamente inválido: `DIVERGENCIA_DE_PROJETO`; retornar ao menor passo responsável;
- contrato e projeto incompatíveis: registrar `DIVERGENCIA_DE_CONTRATO`, sem alterar o contrato;
- arquitetura física insuficiente ou conflitante: `DIVERGENCIA_DE_ARQUITETURA`.

## Gate final obrigatório

Retornar exatamente:

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

`PRONTO_PARA_EXECUCAO_HML: SIM` exige todos os critérios de `documentacao/16-DESENVOLVIMENTO-DE-INTEGRACOES.md`, inclusive nenhuma decisão fundamental pendente, nenhuma divergência bloqueante, nenhum secret e nenhuma escrita HML.

Cobertura parcial justificada é aceita apenas no escopo homologável aprovado pelo Passo 05, com itens não implementados e impactos explícitos.

## Status e auditoria

Usar somente:

- `CONCLUIDA`: implementação local suficiente, validações aplicáveis aprovadas, auditoria aprovada e gate coerente;
- `PENDENTE`: falta corrigível de código, teste, decisão, fonte ou configuração;
- `BLOQUEADA`: gate upstream inválido, arquitetura insuficiente ou impedimento externo.

Execução produtora e auditoria são separadas. Durante auditoria, código e artefatos auditados ficam imutáveis. Achado reprova e é corrigido apenas em nova execução produtora, seguida de nova auditoria.

Commit e push nunca são automáticos.

## Cenários de validação A-AJ

| Cenário | Resultado obrigatório |
|---|---|
| A. Passo 05 diz `M -> MASCULINO` e o código implementa isso | Válido |
| B. Código escolhe campo diferente sem alterar Passo 05 | Inválido; `DIVERGENCIA_DE_PROJETO` |
| C. Client do ERP é reutilizável entre ferramentas | Válido |
| D. Client da ferramenta é reutilizável entre ERPs | Válido |
| E. Um client mistura auth dos dois sistemas e toda a integração | Suspeito/inválido sem justificativa |
| F. Mapper ERP -> ferramenta fica na combinação | Válido |
| G. Toda integração em classe/arquivo monolítico | Inválido |
| H. Paginação lê somente a primeira página | Inválido |
| I. `401` causa loop infinito | Inválido |
| J. `401` usa refresh e retry controlados | Válido |
| K. `429` respeita política documentada | Válido |
| L. `404` funcional recebe retries cegos | Inválido |
| M. `null` vira zero sem regra | Inválido |
| N. Enum desconhecido recebe fallback inventado | Inválido |
| O. Filial real de cliente fica hardcoded | Inválido |
| P. `branchId` é parâmetro requerido sem valor real | Válido |
| Q. Secret entra em fixture | Inválido |
| R. Log imprime bearer token | Inválido |
| S. Testes usam mocks/fixtures, sem HML | Válido |
| T. Passo 06 sincroniza produtos reais | Inválido |
| U. Teste prova campo upstream inexistente | Retornar ao menor passo responsável |
| V. Teste prova somente bug no mapper | Corrigir no Passo 06 |
| W. Outra ferramenta reutiliza `ERP_REUSABLE` do mesmo ERP | Válido |
| X. Outro ERP reutiliza `TOOL_REUSABLE` da mesma ferramenta | Válido |
| Y. Código e testes passam sem divergência bloqueante | Candidato a `PRONTO_PARA_EXECUCAO_HML: SIM` |
| Z. Passo 06 declara integração homologada | Inválido |
| AA. Nome de produto é usado como correlação | Inválido |
| AB. Correlação usa ERP ID, ID lógico e Tool ID | Válido |
| AC. Grade aberta e Pack usam mesma transformação sem prova | Inválido |
| AD. Mapper monetário perde casas decimais | Inválido |
| AE. `false` recebe default `true` por lógica falsy | Inválido |
| AF. Contrato muda e o código ignora vigência | Inválido |
| AG. Cobertura parcial válida é implementada e o restante registrado | Válido |
| AH. Dependência pesada é adicionada para operação trivial | Inválido sem forte justificativa |
| AI. Implementação cria modelo universal especulativo | Inválido |
| AJ. Arquitetura real do repositório é reutilizada | Válido |

## Validações antes do retorno

1. confirmar que o escopo de código corresponde ao Passo 05;
2. conferir arquitetura e separação das quatro responsabilidades;
3. validar ausência de hardcode de cliente e secrets;
4. executar comandos reais de build/typecheck/lint/test;
5. validar testes obrigatórios e ausência de rede externa normal;
6. validar manifesto e relatório;
7. validar `PENDENCIAS.md` sem duplicação;
8. executar Harness aplicável nos artefatos documentais;
9. executar `git diff --check`;
10. executar auditoria semântica independente;
11. confirmar nenhuma escrita HML;
12. retornar status e gate completos.

## Como executar (operador)

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-06-DESENVOLVER-INTEGRACAO.md

Continue a jornada ERP parceiro da combinação já identificada e execute somente o Passo 06.

Transforme o projeto aprovado do Passo 05 em código executável e testado.

Descubra automaticamente ERP, ferramenta, gates, mapping, transformations, plan, capacidades, contrato, regras, Base Mestra, código reutilizável, arquitetura do repositório e comandos de validação existentes.

Valide primeiro o Passo 05 e a vigência do projeto.

Implemente exatamente as decisões aprovadas. Não troque campo, direção, evento, identidade, ownership ou transformação silenciosamente.

Se encontrar erro no próprio código, classifique BUG_DE_IMPLEMENTACAO e corrija no Passo 06.
Se comprovar erro ou insuficiência do projeto, classifique DIVERGENCIA_DE_PROJETO e retorne ao menor passo responsável.

Separe SHARED_CORE, ERP_REUSABLE, TOOL_REUSABLE e COMBINATION_SPECIFIC conforme a necessidade concreta e a arquitetura existente.

Não criar mega modelo universal ou abstrações especulativas.
Não executar sincronização ou HML.
Não executar POST, PUT, PATCH ou DELETE em ERP ou ferramenta.
Não criar banco, deploy, runtime 24/7 ou Passo 07.
Não hardcodar cliente, IDs físicos ou credenciais.
Não versionar ou imprimir secrets.
Não alterar contrato homologado, Harness ou manifestos de ferramenta.

Crie testes locais com mocks, fakes e fixtures sintéticas.
Execute os comandos reais de build, typecheck, lint e test do projeto.

Gere na memória da combinação:
- MANIFESTO-DA-IMPLEMENTACAO.yaml
- RELATORIO-DE-DESENVOLVIMENTO.md

Atualize PENDENCIAS.md somente quando necessário.

Retorne STATUS DA ETAPA e gate final completo, terminando no máximo em PRONTO_PARA_EXECUCAO_HML: SIM.
Não declare INTEGRACAO_HOMOLOGADA.
Não faça commit.
Não faça push.
Não inicie etapa posterior.
```

### PARE DE COPIAR AQUI

## Retorno obrigatório

```text
STATUS DA ETAPA: CONCLUIDA | PENDENTE | BLOQUEADA

ARQUITETURA_EXECUTAVEL_EXISTENTE: SIM | NAO | PARCIAL

GATE DE ENTRADA:
- ERP_IDENTIFICADO
- FERRAMENTA_HOMOLOGADA
- PASSO_05_APTO
- PROJETO_VIGENTE

ARQUITETURA E ESCOPO:
<decisao fisica, quatro responsabilidades e arquivos alcançados>

IMPLEMENTACAO:
<componentes, flows, mappers, transformers, auth, paginacao, retry, configuracao e correlacao>

TESTES E VALIDACOES:
<comandos, exit codes e resultados>

OUTPUTS:
- MANIFESTO-DA-IMPLEMENTACAO.yaml
- RELATORIO-DE-DESENVOLVIMENTO.md
- PENDENCIAS.md: INALTERADO | ATUALIZADO

DIVERGENCIAS E PENDENCIAS:
<itens e menor passo responsavel>

GATE FINAL:
<todos os 23 campos obrigatorios>

HARNESS:
<resultado e exit codes>

AUDITORIA: APROVADA | REPROVADA | BLOQUEADA

PROXIMA ACAO PERMITIDA:
aguardar etapa posterior oficialmente publicada; não executar HML, commit ou push automaticamente.
```
