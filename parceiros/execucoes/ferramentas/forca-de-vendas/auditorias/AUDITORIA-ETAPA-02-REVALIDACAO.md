# AUDITORIA-ETAPA-02 — Revalidação da Força de Vendas

## Natureza desta auditoria

- Etapa auditada: `02-CADASTRAR-FERRAMENTA`
- Execução: `parceiros/execucoes/ferramentas/forca-de-vendas/`
- Tipo: revalidação integral e independente da auditoria anterior
- Motivo: a primeira auditoria alterou artefatos auditados antes de emitir `AUDITORIA-ETAPA-02.md`, violando a separação entre execução e auditoria.
- Efeito sobre o histórico: o relatório anterior foi preservado, mas seu resultado `APROVADA` não é aceito como evidência válida do gate de qualidade.

Esta revalidação foi executada em modo somente leitura sobre os artefatos canônicos. Nenhum achado foi corrigido durante a auditoria.

## Regras aplicadas

1. `parceiros/AGENTS.md`
2. `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`
3. `parceiros/auditorias/AUDITAR-ETAPA.md`
4. `parceiros/comandos/02-CADASTRAR-FERRAMENTA.md`

## Ordem das fontes utilizadas

### 1. Fonte original

1. `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.pdf`
   - SHA-256: `2C8AAB2659BCF8974905912024E86A0B7D1053FB55E2A5FE727785FC1AD01BFB`
   - metadados conferidos diretamente: 87 páginas, PDF 1.7, A4, não criptografado;
   - texto reextraído diretamente do PDF em pasta temporária;
   - páginas 3, 9, 26, 46, 61, 80 e 87 renderizadas e inspecionadas visualmente como amostra distribuída da fonte.
2. `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.extraido.txt`, usado como apoio, não como substituto da fonte original.

### 2. Artefatos aprovados da Etapa 01

1. `analises/ferramentas/forca-de-vendas/01-analise-documentacao.md`
2. `analises/ferramentas/forca-de-vendas/01-inventario-operacoes.md`
3. `analises/ferramentas/forca-de-vendas/01-matriz-bidirecionalidade-modulos.md`
4. `parceiros/execucoes/ferramentas/forca-de-vendas/DADOS-DA-EXECUCAO.md`
5. `parceiros/execucoes/ferramentas/forca-de-vendas/ESTADO-DA-EXECUCAO.md` em seu estado anterior a esta revalidação
6. `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-01.md`

### 3. Comando e critérios de aceite da Etapa 02

- `parceiros/comandos/02-CADASTRAR-FERRAMENTA.md`
- seção `Critérios de aceite` do mesmo comando

### 4. Artefatos canônicos auditados

1. `ferramentas/forca-de-vendas/README.md`
2. `ferramentas/forca-de-vendas/CONTRATO-DA-FERRAMENTA.yaml`
3. `ferramentas/forca-de-vendas/MODULOS.md`
4. `ferramentas/forca-de-vendas/DEPENDENCIAS.md`
5. `ferramentas/forca-de-vendas/BIDIRECIONALIDADE.md`
6. `ferramentas/forca-de-vendas/PENDENCIAS.md`
7. `ferramentas/forca-de-vendas/FONTES.md`

## Linha de base de integridade dos artefatos auditados

| Arquivo | Bytes | Última modificação antes da auditoria | SHA-256 inicial |
|---|---:|---|---|
| `BIDIRECIONALIDADE.md` | 18135 | 2026-08-07T12:48:50.4562275-03:00 | `9C631097CCE389784041B34F2978BD43E2AB745FA46738170FF3FF602F2DFDF2` |
| `CONTRATO-DA-FERRAMENTA.yaml` | 56215 | 2026-08-07T12:45:28.6840733-03:00 | `6729F380EFBE5494A45069D05754C4094DC25C7E7FC7208FC68213933EBC168E` |
| `DEPENDENCIAS.md` | 682 | 2026-08-07T12:48:27.7298945-03:00 | `AB436C855E1C96B4233F2266ABDD524BA790962C78C6F05B002D33B9ED76FB74` |
| `FONTES.md` | 3 | 2026-08-07T12:45:28.8342984-03:00 | `F1945CD6C19E56B3C1C78943EF5EC18116907A4CA1EFC40A57D48AB1DB7ADFC5` |
| `MODULOS.md` | 5436 | 2026-08-07T12:45:28.7989621-03:00 | `0E088F9A3F36CE1A7B458B0AAEDF4CCA03609B400607FCB7382815C27E4DB653` |
| `PENDENCIAS.md` | 2913 | 2026-08-07T12:48:50.4582227-03:00 | `AD6CFCD8BAE159063099768567B1060E853431080877834EFD303921235BFABB` |
| `README.md` | 759 | 2026-08-07T12:45:28.5454867-03:00 | `C763B50688443A1368EFB874662F67CA2E9A86534FE65748416D99EA019A6968` |

## Validações executadas

### Fonte original e identidades de operação

- operações extraídas diretamente do PDF: **90**;
- rotas únicas extraídas diretamente do PDF: **47**;
- operações no inventário aprovado da Etapa 01: **90**;
- operações no YAML canônico: **90**;
- diferença de identidades método + rota entre PDF e inventário: **0**;
- diferença de identidades método + rota entre inventário e YAML: **0**;
- IDs de operação únicos no YAML: **90/90**.

### Conteúdo das operações no YAML

- os campos `modulo`, `metodo`, `rota`, `finalidade`, `correlacao`, `sucesso_documentado`, `erros_documentados` e `rastreabilidade` coincidem com o inventário aprovado para as 90 operações;
- todas as 90 rastreabilidades contêm o método e a rota correspondentes;
- todos os caminhos de `referencias_origem` existentes no YAML resolvem para arquivos presentes.

### YAML

- mecanismo: `powershell-yaml` 0.4.12 baixado e extraído somente em diretório temporário;
- execução: importação em processo filho com `-ExecutionPolicy Bypass`, sem alterar política global, de usuário ou da máquina;
- resultado sintático: **VÁLIDO**;
- estrutura parseada: 26 módulos, 90 operações e 7 pendências;
- problema semântico: `operacoes_total` é nulo para `Autenticação` e `Imagens`, embora exista uma operação em cada módulo.

### Conteúdo além de contagens

- módulos comparados por nome, contagem e operações;
- bidirecionalidade comparada por módulo, direção, operação de suporte, correlação, confirmação, limitações, idempotência, loop, conflito e reprocessamento;
- dependências comparadas contra a seção 7 da análise aprovada e contra os campos/entidades da fonte original;
- pendências comparadas contra as seções 9, 10 e 11 da análise aprovada e contra as inconsistências da fonte original;
- rastreabilidade canônica conferida até os artefatos da Etapa 01 e o PDF.

### Integridade, encoding e segredos

- todos os sete artefatos canônicos decodificam como UTF-8 estrito;
- nenhuma evidência de JWT, chave privada ou atribuição de segredo real foi encontrada nos canônicos;
- os hashes finais dos sete artefatos são idênticos à linha de base inicial.

## Achados

### ACHADO-01 — `FONTES.md` está vazio

- Evidência: arquivo com 3 bytes, contendo somente a marca de encoding, sem conteúdo útil.
- Violação: o comando 02 exige a cadeia `cadastro canônico -> artefatos aprovados do Passo 01 -> execução -> auditoria -> documentação oficial` em `FONTES.md`.
- Impacto: o arquivo obrigatório existe apenas nominalmente; a rastreabilidade canônica não está materializada no artefato destinado a ela.
- Ação durante a auditoria: nenhuma correção realizada.

### ACHADO-02 — Totais de operações ausentes em dois módulos

- `Autenticação`: total declarado vazio/nulo; total real = 1 (`POST /auth`).
- `Imagens`: total declarado vazio/nulo; total real = 1 (`POST /images`).
- Evidência: a falha ocorre em `CONTRATO-DA-FERRAMENTA.yaml` e em `MODULOS.md`.
- Impacto: o cadastro não representa integralmente os módulos aprovados, apesar de o total global permanecer 90.
- Ação durante a auditoria: nenhuma correção realizada.

### ACHADO-03 — 26 operações documentadas não estão mapeadas em nenhuma direção

A comparação de conteúdo encontrou 26 operações presentes no PDF, no inventário e no YAML de operações, mas ausentes tanto de `ERP -> ferramenta` quanto de `ferramenta -> ERP` na bidirecionalidade canônica:

1. Campanhas: `DELETE /campaigns`;
2. Clientes: `POST /clients`, `PUT /clients`;
3. Condições de pagamento: `DELETE /payment-conditions/{erpId}`;
4. Filiais: `DELETE /branches/{erpId}`;
5. Gêneros: `DELETE /genders/{erpId}`;
6. Imagens: `POST /images`;
7. Linhas: `DELETE /lines`;
8. Métodos de pagamento: `DELETE /payment-methods/{erpId}`;
9. Preços: `DELETE /prices/{erpId}`;
10. Prepostos: `GET /agents`, `POST /agents`, `PUT /agents`, `DELETE /agents`;
11. Prazos de entregas: `DELETE /deadlines/{erpId}`;
12. Regiões: `DELETE /regions/{erpId}`;
13. Representantes: `GET /representatives`, `POST /representatives`, `PUT /representatives`, `DELETE /representatives`, `PATCH /representatives/clients`;
14. Transportadoras: `DELETE /carriers/{erpId}`;
15. Vendedores: `GET /sellers`, `POST /sellers`, `PUT /sellers/{erpId}`, `PATCH /sellers/clients`.

A fonte original descreve explicitamente as finalidades de consulta, criação, atualização, exclusão, upload ou vínculo dessas operações. A omissão afeta `BIDIRECIONALIDADE.md`, `MODULOS.md` e a seção `bidirecionalidade` do YAML.

A matriz aprovada da Etapa 01 contém a mesma omissão. Isso não valida o cadastro: o comando 02 determina que uma contradição entre artefato aprovado e fonte original seja registrada e leve a `PENDENTE` ou `BLOQUEADA`, sem correção silenciosa.

### ACHADO-04 — Dependências não foram preservadas integralmente

`DEPENDENCIAS.md` reduziu a análise aprovada a cinco cadeias genéricas. Entre as relações explícitas da Etapa 01 que deixaram de ser representadas de forma verificável estão:

- dependência de `brands` em `companyErpId`;
- dependências corporativas/relacionais de `genders`, `deadlines`, `payment-methods`, `payment-conditions`, `price-tables`, `carriers` e `branches`;
- referências de `products` a `branchErpId`, `brandErpId`, `deadlineErpId`, `genderErpId`, `categoryErpId`, `productSubcategoryErpId`, `campaignErpId`, `lineErpId` e `productColors`;
- chaves explícitas de `variants -> productErpId`, `skus -> variantErpId` e `prices -> skuErpId + priceTableErpId`.

Além disso, o YAML contém apenas quatro dependências genéricas e não inclui a quinta cadeia registrada em `DEPENDENCIAS.md` para pedido/confirmação de integração/status.

### ACHADO-05 — Pendências e divergências foram preservadas apenas parcialmente

Os sete IDs canônicos correspondem à lista numerada da seção 11 da análise, mas houve perda de conteúdo e de divergências registradas nas demais seções aprovadas:

- `PEND-001` não explicita a lacuna de escopos do JWT;
- `PEND-002` não mantém explicitamente timeout e a política de retry/backoff em seu título/descrição;
- política de conflito e estratégia de reprocessamento seguro não possuem pendência estável própria;
- não há registro específico para inconsistência de status code versus mensagem;
- não há registro específico para a divergência de visibilidade de produto;
- não há registro específico para a descrição incorreta de sucesso em `PUT /brands`;
- não há registro específico para a ausência de sucesso explícito em `POST /brands` e `POST /subcategories`;
- erros tipográficos documentados foram reduzidos a uma referência genérica de nomenclatura.

Consequentemente, a quantidade `7` publicada no README e no YAML não representa todas as lacunas e divergências que o comando 02 determinou preservar sem desaparecimento silencioso.

### ACHADO-06 — Estado anterior e auditoria anterior não são evidência válida de conclusão

- `AUDITORIA-ETAPA-02.md` registra aprovação depois de artefatos auditados terem sido alterados no mesmo ciclo.
- `ESTADO-DA-EXECUCAO.md` e `DADOS-DA-EXECUCAO.md` ainda refletiam essa aprovação processualmente inválida no início da revalidação.
- `ESTADO-DA-EXECUCAO.md` indicava um arquivo do Passo 03 que não existe; também não existe documento operacional homologado correspondente em `comece-aqui/`.
- Esta auditoria atualiza somente o resultado e o gate no estado. `DADOS-DA-EXECUCAO.md` não foi corrigido durante a auditoria e permanece como inconsistência registrada.

## Resultado por critério de aceite do comando 02

1. Etapa 01 concluída no estado persistido: **APROVADO FORMALMENTE**
2. Auditoria da Etapa 01 aprovada no estado persistido: **APROVADO FORMALMENTE**, com contradição de bidirecionalidade agora evidenciada contra a fonte
3. Pasta canônica criada: **APROVADO**
4. `README.md` válido: **REPROVADO** — referencia `FONTES.md` vazio e publica contagem incompleta de pendências
5. `CONTRATO-DA-FERRAMENTA.yaml` válido: **REPROVADO** — sintaxe válida, conteúdo com dois totais nulos e falhas semânticas
6. Todos os módulos aprovados representados: **REPROVADO** — dois módulos sem total de operações
7. Todas as operações aprovadas representadas no inventário estruturado: **APROVADO** — 90/90 identidades
8. Todas as rotas aprovadas representadas: **APROVADO** — 47/47 rotas
9. Dependências preservadas: **REPROVADO**
10. Bidirecionalidade preservada e validada contra a fonte: **REPROVADO**
11. Pendências preservadas e identificadas: **REPROVADO**
12. Nenhuma informação inventada: **APROVADO quanto a endpoints/rotas**, sem neutralizar as omissões encontradas
13. Rastreabilidade mantida: **REPROVADO** — `FONTES.md` vazio e divergências sem cadeia completa
14. Markdown em UTF-8: **APROVADO**
15. Nenhuma credencial persistida: **APROVADO**
16. Auditoria do Passo 02 executada: **APROVADO**
17. Auditoria do Passo 02 aprovada: **REPROVADO**

## Configuração e ferramentas temporárias

- PSGallery no estado atual: **não registrada**; portanto não aparece como `Trusted`.
- Evidência no repositório sobre a execução anterior: somente a menção de parse com `powershell-yaml` no relatório anterior; não há registro de `Set-PSRepository` nem do valor anterior da política.
- Não é possível determinar com segurança se a execução anterior alterou a PSGallery ou qual era um valor anterior. Nenhum valor foi inventado e nenhuma restauração foi tentada.
- Políticas de execução após a validação: `Undefined` em MachinePolicy, UserPolicy, Process, CurrentUser e LocalMachine.
- Nenhum módulo/pacote foi instalado e nenhuma configuração global ou de usuário foi alterada.
- O parser YAML e o Poppler foram usados somente a partir de diretórios temporários locais.

## Resultado final da reauditoria

`AUDITORIA: REPROVADA`

`STATUS DA ETAPA: PENDENTE`

## Próxima ação

Os problemas devem ser corrigidos em uma execução posterior do comando da Etapa 02 e, depois, submetidos a uma nova auditoria integral. Nenhuma etapa seguinte está liberada. Como ainda não existe documento operacional homologado do próximo passo em `comece-aqui/`, o operador deve aguardar sua preparação antes de qualquer avanço.
