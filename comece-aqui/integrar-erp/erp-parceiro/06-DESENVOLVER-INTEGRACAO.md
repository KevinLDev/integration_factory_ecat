# 06 - Desenvolver integração

## Quando usar

Use esta etapa somente quando o Passo 05 da combinação ERP x ferramenta estiver concluído, auditado e vigente, com `PRONTO_PARA_DESENVOLVIMENTO: SIM`.

O Passo 06 transforma as decisões do projeto em código executável e testado. Ele não executa HML e não homologa a integração.

## Objetivo oficial

```text
PASSO 05 -> decide
PASSO 06 -> implementa e testa localmente
```

Resultado máximo:

```text
PRONTO_PARA_EXECUCAO_HML: SIM
```

O Passo 07 oficialmente publicado executa e valida tecnicamente em HML a implementação aprovada. Ele não é iniciado automaticamente pelo Passo 06 e não homologa funcionalmente a integração.

## Pré-requisitos

- ERP identificado sem ambiguidade;
- ferramenta homologada para integrações;
- Passos 01 a 05 concluídos e vigentes conforme controles aplicáveis;
- Passo 05 auditado e apto;
- `PRONTO_PARA_DESENVOLVIMENTO: SIM`;
- `MAPEAMENTO-SEMANTICO.yaml`;
- `REGRAS-DE-TRANSFORMACAO.yaml`;
- `PLANO-DA-INTEGRACAO.md`;
- pendências bloqueantes compatíveis com o gate;
- fontes e snapshots relevantes vigentes.

Se qualquer upstream relevante mudou, não desenvolva sobre projeto possivelmente obsoleto. Retorne ao menor passo responsável.

## O que o operador precisa ter

O operador precisa apenas indicar a combinação que deseja desenvolver e fornecer decisão realmente ambígua e bloqueante quando solicitada.

Não precisa repetir caminhos, contrato, capacidades, Base Mestra, mapeamento, transformações, plano ou arquitetura já presentes no repositório.

Não envie credenciais no prompt. Se uma consulta read-only excepcional for necessária e autorizada, o executor deve usar mecanismo seguro e transitório.

Se a combinação não puder ser descoberta de forma inequívoca, informe apenas o ERP e a ferramenta reais. Não preencha caminhos internos, IDs, tokens ou valores de cliente.

## O que você não precisa fazer manualmente

- criar diretórios de código ou escolher uma arquitetura física;
- copiar os modelos para a pasta da combinação;
- localizar package manager, `tsconfig` ou comandos de teste;
- repetir inputs já persistidos pelo Passo 05;
- criar manifesto, relatório ou arquivo de estado;
- separar manualmente código compartilhado, ERP, ferramenta e combinação.

## Onde fornecer arquivos adicionais

Anexe ou informe o caminho no workspace somente quando o executor solicitar uma fonte realmente ausente. O executor deve organizar a referência no contexto correto. Nunca coloque credenciais, tokens ou secrets em arquivo versionado.

## Arquivos utilizados

O executor localiza automaticamente:

- memória geral do ERP;
- Base Mestra de homologação;
- matriz, pendências, plano de homologação, Base planejada e relatório de materialização;
- `MAPEAMENTO-SEMANTICO.yaml`;
- `REGRAS-DE-TRANSFORMACAO.yaml`;
- `PLANO-DA-INTEGRACAO.md`;
- contrato, cenários, regras e homologação da ferramenta;
- código, configuração e testes reutilizáveis;
- package manager, TypeScript, workspaces e comandos reais do projeto.

## O que a etapa faz

- valida Passo 05 e vigência do projeto;
- inspeciona a arquitetura executável real;
- define o escopo físico mínimo de código;
- separa `SHARED_CORE`, `ERP_REUSABLE`, `TOOL_REUSABLE` e `COMBINATION_SPECIFIC`;
- reutiliza componentes existentes antes de criar novos;
- implementa clients, mappers, transformers e flows necessários;
- implementa auth, paginação, retry/rate limit, configuração, correlação, idempotência e observabilidade conforme o projeto;
- cria fixtures sintéticas e testes locais;
- executa build, typecheck, lint e test existentes;
- diferencia bug próprio de divergência upstream;
- gera manifesto e relatório de desenvolvimento;
- atualiza `PENDENCIAS.md` somente quando necessário;
- retorna gate de prontidão para HML.

## O que a etapa não faz

- não redescobre o mapeamento;
- não muda decisão do Passo 05 escondida no código;
- não altera contrato da ferramenta;
- não executa sincronização ou HML;
- não executa `POST`, `PUT`, `PATCH` ou `DELETE` externo;
- não cria Base Mestra;
- não cria banco, deploy ou runtime 24/7;
- não cria mega modelo universal;
- não hardcoda cliente, ID físico ou secret;
- não executa Passo 07;
- não declara integração homologada;
- não faz commit ou push automaticamente.

## Arquitetura lógica

### SHARED_CORE

Somente infraestrutura realmente genérica e comprovadamente compartilhável.

### ERP_REUSABLE

Auth, HTTP, DTOs, paginação, rate limit e erros próprios do ERP, reutilizáveis entre ferramentas.

### TOOL_REUSABLE

Client, DTOs e operações homologadas da ferramenta, reutilizáveis entre ERPs.

### COMBINATION_SPECIFIC

Mappers, transformações, flows, direções, eventos e composição específicos da combinação.

Não misturar as responsabilidades num client único sem justificativa arquitetural concreta.

## Segurança

- secrets nunca entram em código, fixture, manifesto, relatório ou log;
- configurações de cliente são parâmetros sem valores reais;
- logs devem redigir credenciais e evitar payload pessoal desnecessário;
- testes normais usam mocks/fakes e não rede externa;
- nenhuma escrita HML ocorre nesta etapa.

## O que mandar para o chat do Codex

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-06-DESENVOLVER-INTEGRACAO.md

Desenvolva a integração da combinação ERP x ferramenta já identificada na execução atual.

Execute somente o Passo 06.

Descubra automaticamente todo o contexto persistido, o Passo 05, o mapping, as transformations, o plan, as capacidades, o contrato, as regras, a Base Mestra, o código reutilizável e a arquitetura do repositório.

Valide o Passo 05 e a vigência antes de criar ou alterar código.

Implemente exatamente as decisões do Passo 05.
Não escolha campo, direção, evento, identidade, ownership ou transformação diferente silenciosamente.

Separe SHARED_CORE, ERP_REUSABLE, TOOL_REUSABLE e COMBINATION_SPECIFIC sem overengineering.

Crie testes locais com mocks, fakes e fixtures sintéticas.
Use package manager, TypeScript, build, lint e testes existentes.

Não executar HML ou sincronização.
Não executar POST, PUT, PATCH ou DELETE em sistemas externos.
Não criar banco, deploy, runtime 24/7 ou Passo 07.
Não alterar contrato, Harness ou manifestos de ferramenta.
Não hardcodar cliente, IDs físicos ou credenciais.
Não persistir ou imprimir secrets.

Gere:
- MANIFESTO-DA-IMPLEMENTACAO.yaml
- RELATORIO-DE-DESENVOLVIMENTO.md

Atualize PENDENCIAS.md somente quando necessário.

Retorne STATUS DA ETAPA, validações e gate final completo.
O resultado máximo é PRONTO_PARA_EXECUCAO_HML: SIM, nunca INTEGRACAO_HOMOLOGADA.

Não faça commit.
Não faça push.
Não inicie etapa posterior.
```

### PARE DE COPIAR AQUI

## Exemplo preenchido

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-06-DESENVOLVER-INTEGRACAO.md

Desenvolva a integração da combinação ERP X com a Ferramenta Y já identificada na execução atual.

Use somente o contexto e as decisões aprovadas no repositório. Valide a vigência do Passo 05, descubra a arquitetura executável existente, reutilize os componentes disponíveis e implemente apenas o escopo aprovado.

Não execute rede externa, HML ou sincronização. Use mocks e fixtures sintéticas. Não use valores reais de cliente ou secrets.

Gere o manifesto e o relatório de desenvolvimento, execute as validações reais do projeto e retorne o gate completo de prontidão para HML.

Não faça commit, push ou etapa posterior.
```

O exemplo usa nomes fictícios. Substitua-os pela combinação real sem incluir credenciais.

## O que a IA fará

1. resolverá ERP, ferramenta, combinação e estado;
2. validará Passo 05, manifesto, auditoria e vigência;
3. inspecionará arquitetura, package manager, TypeScript e testes;
4. descobrirá componentes reutilizáveis;
5. definirá o escopo mínimo de arquivos;
6. implementará as quatro responsabilidades sem misturá-las;
7. criará clients somente quando necessários;
8. implementará mappers e transformers do Passo 05;
9. implementará flows, auth, paginação, retry, configuração e correlação aplicáveis;
10. criará fixtures e testes locais;
11. executará build/typecheck/lint/test reais;
12. classificará bugs e divergências;
13. gerará manifesto, relatório e eventual atualização de pendências;
14. executará Harness/auditoria aplicáveis e retornará o gate.

## Artefatos esperados

Na memória da combinação:

```text
MANIFESTO-DA-IMPLEMENTACAO.yaml
RELATORIO-DE-DESENVOLVIMENTO.md
PENDENCIAS.md (somente se necessário)
```

O código fica no caminho físico definido pela arquitetura executável real do repositório. Se ela for insuficiente, a etapa deve bloquear a criação arbitrária e registrar a decisão faltante.

## Como testar

Confirmar, conforme aplicável:

- testes unitários;
- testes de transformação e mapper;
- contrato/DTO;
- flows com clients mockados;
- auth;
- paginação completa;
- retry/rate limit;
- erros;
- configuração;
- build, typecheck e lint existentes;
- ausência de rede externa, secrets e hardcode de cliente.

## Cenários de interpretação

| Situação                                          | Resultado                 |
| ------------------------------------------------- | ------------------------- |
| Código implementa exatamente enum do Passo 05     | Válido                    |
| Código troca campo upstream por conveniência      | `DIVERGENCIA_DE_PROJETO`  |
| Mapper possui bug contra regra clara              | Corrigir no Passo 06      |
| Client do ERP é reutilizado em outra ferramenta   | Válido                    |
| Client da ferramenta é reutilizado em outro ERP   | Válido                    |
| Paginação lê apenas primeira página               | Falha                     |
| `401` cria loop                                   | Falha                     |
| `401` tem renovação/retry controlados             | Válido                    |
| Secret aparece em fixture ou log                  | Falha bloqueante          |
| Testes usam mocks e fixtures sintéticas           | Válido                    |
| Passo 06 sincroniza dados reais                   | Falha de escopo           |
| Código e testes passam sem divergência bloqueante | Candidato a prontidão HML |

## Resultado esperado

O retorno deve conter:

- `STATUS DA ETAPA: CONCLUIDA | PENDENTE | BLOQUEADA`;
- arquitetura executável encontrada e utilizada;
- gate de entrada e vigência;
- componentes criados/reutilizados por responsabilidade;
- flows, mappers, transformers e configurações;
- testes e comandos com exit codes;
- outputs;
- divergências e pendências;
- gate final completo;
- auditoria;
- próxima ação permitida sem autoexecução.

## Como interpretar falhas

| Situação                         | Encaminhamento                                                                 |
| -------------------------------- | ------------------------------------------------------------------------------ |
| Passo 05 ou upstream inválido    | Voltar ao menor passo responsável                                              |
| Arquitetura física insuficiente  | `BLOQUEADA`; registrar decisão necessária                                      |
| Regra do Passo 05 impossível     | `DIVERGENCIA_DE_PROJETO`; não improvisar                                       |
| Bug de implementação             | Corrigir no Passo 06 e testar novamente                                        |
| Build/typecheck/lint/test falha  | `PENDENTE`; corrigir código local                                              |
| Secret encontrado                | Bloquear publicação, remover exposição e tratar incidente sem reproduzir valor |
| Cobertura opcional não suportada | Manter escopo parcial justificado e registrar impacto                          |

## Status, auditoria e continuação

Criar arquivos não basta. `CONCLUIDA` exige código local suficiente, validações aplicáveis aprovadas, auditoria aprovada e gate coerente.

Se a auditoria encontrar problema, usar `AUDITORIA: REPROVADA` e `STATUS DA ETAPA: PENDENTE`; corrigir somente em nova execução produtora e reauditar.

`PRONTO_PARA_EXECUCAO_HML: SIM` não significa integração homologada nem autoriza execução automática.

## Próximo documento

O próximo documento oficial é:

`comece-aqui/integrar-erp/erp-parceiro/07-EXECUTAR-E-VALIDAR-TECNICAMENTE-EM-HML.md`

O Passo 07 só pode ser iniciado por decisão do operador, com ambientes HML comprovados e autorização explícita. Ele não homologa funcionalmente, publica ou executa produção.
