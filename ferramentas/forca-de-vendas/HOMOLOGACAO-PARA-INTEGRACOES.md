# Homologação para Integrações — Força de Vendas

## Identificação

- Ferramenta: Força de Vendas
- Slug: `forca-de-vendas`
- Etapa: `03-VALIDAR-FERRAMENTA-CADASTRADA`
- Data da validação: 2026-08-10
- Comando aplicado: `parceiros/comandos/03-VALIDAR-FERRAMENTA-CADASTRADA.md`
- Resultado técnico: `NAO_APTO_PARA_INTEGRACOES`
- Prontidão antes da auditoria: `NAO_HOMOLOGADA`
- Etapas a revisitar: Passo 01 e, depois, Passo 02

Este relatório avalia se o contrato canônico atual pode orientar um futuro mapeamento ERP x ferramenta sem exigir que a documentação oficial seja reinterpretada do zero. Ele não altera nem substitui os sete artefatos canônicos.

## Fontes utilizadas

### Fonte oficial

1. `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.pdf`
   - bytes: 1.526.436;
   - SHA-256: `2C8AAB2659BCF8974905912024E86A0B7D1053FB55E2A5FE727785FC1AD01BFB`;
   - identidade preservada: Força de Vendas, versão 1.0.0, OAS 3.0;
   - o hash permanece igual ao registrado pela auditoria vigente do Passo 02.
2. `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.extraido.txt`
   - bytes: 113.964;
   - SHA-256: `A4B16B88AE820A2B543F72C18FD0908E843C01D948B22BECEB63F8EA9A2B1D5F`;
   - páginas 1 a 87 presentes;
   - usada para comparação mecânica por operação, sem substituir a autoridade do PDF.

Não foram instalados pacotes. Como Poppler e Python não estavam disponíveis nesta execução, a validação utilizou a extração UTF-8 já vinculada ao PDF, conferiu a identidade do PDF por SHA-256 e comparou o conteúdo diretamente com os artefatos. A auditoria vigente do Passo 02 registra que esse mesmo PDF foi reextraído e inspecionado visualmente antes do congelamento da baseline atual.

### Artefatos aprovados e controles anteriores

1. `analises/ferramentas/forca-de-vendas/01-analise-documentacao.md`
2. `analises/ferramentas/forca-de-vendas/01-inventario-operacoes.md`
3. `analises/ferramentas/forca-de-vendas/01-matriz-bidirecionalidade-modulos.md`
4. `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-01.md`
5. `parceiros/comandos/02-CADASTRAR-FERRAMENTA.md`
6. `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-02-POS-CORRECOES.md`
7. `parceiros/execucoes/ferramentas/forca-de-vendas/ESTADO-DA-EXECUCAO.md`
8. os sete artefatos canônicos em `ferramentas/forca-de-vendas/`.

A auditoria vigente do Passo 02 foi resolvida pelo estado e pelo histórico. `AUDITORIA-ETAPA-02.md` permanece inválida como gate por alteração durante a auditoria; `AUDITORIA-ETAPA-02-REVALIDACAO.md` permanece como revalidação reprovada anterior; `AUDITORIA-ETAPA-02-POS-CORRECOES.md` é a evidência vigente e aprovada.

## Integridade dos artefatos canônicos

Os sete caminhos foram resolvidos antes da validação semântica. A baseline atual coincide 7/7 com os hashes finais da auditoria vigente do Passo 02.

| Artefato | Bytes | SHA-256 inicial | SHA-256 final | Resultado |
|---|---:|---|---|---|
| `ferramentas/forca-de-vendas/README.md` | 902 | `15DA506C8B3CDBE7D4DB757FBE7295C06D86B133A7F1DBA346831AF721F1EAB7` | `15DA506C8B3CDBE7D4DB757FBE7295C06D86B133A7F1DBA346831AF721F1EAB7` | IDÊNTICO |
| `ferramentas/forca-de-vendas/CONTRATO-DA-FERRAMENTA.yaml` | 64.409 | `0E4E9C8A6835CB67D22BE7262477711DBA117A4411A9DBF2E2F39A8DCF64B91F` | `0E4E9C8A6835CB67D22BE7262477711DBA117A4411A9DBF2E2F39A8DCF64B91F` | IDÊNTICO |
| `ferramentas/forca-de-vendas/MODULOS.md` | 5.847 | `3D719CFC6149B5BD656CF91296C0EEB405B62FC1943E01AEF0F8C305C7A905C0` | `3D719CFC6149B5BD656CF91296C0EEB405B62FC1943E01AEF0F8C305C7A905C0` | IDÊNTICO |
| `ferramentas/forca-de-vendas/DEPENDENCIAS.md` | 3.522 | `4E7476042220B4B834B4EC73B0F10EE33EB4A4664EDBE8EB2D5B5614E986A712` | `4E7476042220B4B834B4EC73B0F10EE33EB4A4664EDBE8EB2D5B5614E986A712` | IDÊNTICO |
| `ferramentas/forca-de-vendas/BIDIRECIONALIDADE.md` | 19.354 | `9BA0335D7E768E7995CEAE47B3F9239FC4B31DD062697672525306CD0B65B049` | `9BA0335D7E768E7995CEAE47B3F9239FC4B31DD062697672525306CD0B65B049` | IDÊNTICO |
| `ferramentas/forca-de-vendas/PENDENCIAS.md` | 9.816 | `7653891DD21FA4022E6C595A04C8178819678733383EDC3FCFC9CBFDF4B799B0` | `7653891DD21FA4022E6C595A04C8178819678733383EDC3FCFC9CBFDF4B799B0` | IDÊNTICO |
| `ferramentas/forca-de-vendas/FONTES.md` | 3.801 | `F2BDF339BF8400D5C302D05A8327C091D43591EB18210ECF48390AAD81BE2506` | `F2BDF339BF8400D5C302D05A8327C091D43591EB18210ECF48390AAD81BE2506` | IDÊNTICO |

Resultado: nenhum artefato canônico foi alterado durante a execução do Passo 03.

## Validação da autenticação

Confirmado na fonte e no contrato:

- endpoint `POST /auth`;
- corpo com `email`, `password` e `key`;
- retorno JWT em `resource.token`;
- expiração, renovação e escopos não documentados, preservados em `PEND-001`.

Achado impeditivo: o inventário do Passo 01 afirma `Token JWT (Bearer), conforme seção Authorize` nas outras 89 operações. A extração oficial não publica o texto `Bearer` nem define o formato do header `Authorization`. O formato deve permanecer `NAO_DOCUMENTADO` até nova evidência oficial; a afirmação atual é uma inferência não comprovada.

## Validação dos módulos

- módulos na fonte, inventário, YAML, `MODULOS.md` e `BIDIRECIONALIDADE.md`: 26;
- soma declarada de operações por módulo: 90;
- operações reais agrupadas por módulo: 90;
- módulos com total divergente: 0;
- módulos inventados ou ausentes: 0.

A cobertura nominal dos módulos foi aprovada. Ela não compensa as divergências semânticas por operação descritas abaixo.

## Validação das operações

### Cobertura nominal

- operações método + rota na fonte: 90, todas únicas;
- operações método + rota no inventário: 90, todas únicas;
- operações método + rota no YAML: 90, todas únicas;
- rotas únicas: 47;
- operações ausentes ou extras por identidade: 0;
- distribuição por método: 12 `DELETE`, 24 `GET`, 7 `PATCH`, 25 `POST` e 22 `PUT`;
- comparação dos oito campos resumidos do YAML com o inventário: 720 comparações, sem diferença, demonstrando que o YAML reproduz o inventário.

Essa concordância não prova fidelidade: o inventário contém erros e omissões que foram propagados ao contrato.

### Parâmetros path e query

Comparação conservadora contra cada bloco oficial identificou 16 operações divergentes, pelo menos 22 parâmetros omitidos e um valor espúrio:

- query: `OP-002`, `OP-007`, `OP-010`, `OP-020`, `OP-034`, `OP-038`, `OP-046`, `OP-064`, `OP-087`;
- path: `OP-019`, `OP-026`, `OP-049`, `OP-061`, `OP-066`, `OP-067`, `OP-071`;
- `GET /agents`: o inventário registra o valor espúrio `Vendas` e omite `page`, `limit` e `name`.

Exemplos:

- `GET /categories` e `GET /clients` omitem `name`;
- `GET /payment-conditions` omite `page` e `limit`;
- `GET /branches` usa `NAO_DOCUMENTADO`, embora a fonte publique `page`, `limit` e `name`;
- `PUT /representatives` publica `erpId * string (path)` em uma rota sem placeholder, mas o inventário usa `NAO_DOCUMENTADO` e `PEND-006` não inclui essa operação.

### Request bodies

Doze operações possuem corpo truncado ou substituído por corpo de resposta/erro:

`OP-008`, `OP-017`, `OP-025`, `OP-028`, `OP-036`, `OP-054`, `OP-068`, `OP-070`, `OP-073`, `OP-074`, `OP-077`, `OP-090`.

A comparação de chaves encontrou pelo menos 32 chaves oficiais ausentes e 13 chaves extras. Exemplos inequívocos:

| Operação | Fonte oficial | Inventário aprovado |
|---|---|---|
| `PUT /colors/products/{productErpId}` | lista com `colorErpId` | resposta `productColorsDeleted/count` usada como request |
| `POST /images` | `multipart/form-data`, campo obrigatório `images` | mensagem de erro usada como request |
| `PATCH /products/visible` | `productErpId`, `isVisibleB2B`, `isVisibleForca` | resposta de erro usada como request |
| `PATCH /representatives/clients` | `clientErpId`, `representativeErpId` | resposta `created/ignored` usada como request |
| `PATCH /skus/stock` | `erpId`, `stockB2B`, `stockForca` | mensagem de sucesso usada como request |
| `PATCH /skus/grid` | `reference`, `grid`, `value`, `quantity` | mensagem de erro 500 usada como request |
| `PATCH /sellers/clients` | `sellerErpId`, `clientErpId`, `companyErpId` | mensagem de erro usada como request |

Também foram observadas perdas em `POST /clients`, `POST /genders` e `POST /skus`, além de mistura de resposta no request de `PUT /subcategories`.

### Respostas e códigos HTTP

O contrato diverge da fonte em 25 operações e omite ao menos 38 ocorrências de códigos documentados:

`OP-005`, `OP-012`, `OP-016`, `OP-017`, `OP-018`, `OP-021`, `OP-026`, `OP-030`, `OP-031`, `OP-037`, `OP-039`, `OP-041`, `OP-042`, `OP-043`, `OP-050`, `OP-053`, `OP-054`, `OP-058`, `OP-064`, `OP-066`, `OP-073`, `OP-074`, `OP-075`, `OP-079`, `OP-083`.

Exemplos:

- `PUT /colors/products/{productErpId}`: fonte `200`, `404`, `500`; inventário e YAML usam erros `NAO_DOCUMENTADO`;
- `PATCH /skus/stock`: fonte `200`, `404`, `500`; erros `NAO_DOCUMENTADO`;
- `PATCH /skus/grid`: fonte `200`, `500`; erros `NAO_DOCUMENTADO`;
- há descrições com ruído de interface, como `Media type` e `Controls Accept header`, tratadas como conteúdo contratual.

### Schemas, obrigatoriedade, paginação, enum e upload

- a fonte lista 27 schemas e contém 185 marcadores de obrigatoriedade no bloco de schemas;
- o inventário registra `campos obrigatórios: NAO_DOCUMENTADO` em 90/90 operações;
- o YAML não possui campos estruturados de schema ou obrigatoriedade;
- a fonte mostra 21 operações com `page` e `limit`; o inventário registra 17 e omite paginação em `OP-010`, `OP-020`, `OP-034` e `OP-046`;
- `GET /sellers` publica `SHOWROOM` e `COORDINATOR`; os valores não foram preservados no inventário nem no YAML;
- `POST /images` publica `images * array<string>` em `multipart/form-data`; o campo obrigatório não foi preservado.

## Validação das correlações

Dez operações contêm 17 tokens de correlação sem ocorrência no bloco da própria operação oficial:

`OP-016`, `OP-017`, `OP-019`, `OP-028`, `OP-041`, `OP-054`, `OP-068`, `OP-074`, `OP-088`, `OP-090`.

Casos de maior impacto:

- `PATCH /sellers/clients`: fonte `sellerErpId`, `clientErpId`, `companyErpId`; contrato omite `sellerErpId` e acrescenta `erpId`, `productErpId`, `skuErpId`, `priceTableErpId`, `categoryErpId`, `brandErpId`, `variantErpId` e `branchErpId`;
- `PATCH /skus/grid`: a fonte usa `reference` e grade; o contrato registra `erpId, skuErpId` e omite `reference`;
- `POST /sellers`: a fonte usa `code` e `companyErpId`, enquanto a atualização usa `/sellers/{erpId}`; a estratégia segura de criar versus atualizar não está documentada;
- `POST /images`: o request contém apenas `images`, mas a finalidade declara associação a produto; não está documentado como o produto é informado ou inferido.

Essas divergências impedem definir com segurança criação versus atualização, deduplicação e correlação.

## Validação das dependências

As cadeias gerais de catálogo e pedidos estão presentes, mas o contrato não materializa de forma operacional, entre outras:

- `payment-conditions -> paymentMethodErpId`;
- `clients -> representativesErpIds`;
- `regions -> priceTablesErpId`;
- associação de imagens ao produto;
- vínculo de cores depois da existência do produto;
- correlação de criação de vendedor por `code` versus atualização por `erpId`.

As dependências incompletas são consequência dos campos e bodies ausentes ou incorretos e afetam a ordem e o mapeamento futuros.

## Validação da bidirecionalidade

- módulos com as duas perspectivas registradas: 26/26;
- operações classificadas em `ERP -> ferramenta`: 66;
- operações classificadas em `ferramenta -> ERP`: 24;
- união das direções: 90/90;
- operações extras, ausentes ou duplicadas entre direções: 0;
- módulos com correlação, confirmação, limitação, idempotência, loop, conflito, reprocessamento e status: 26/26.

A cobertura direcional nominal foi aprovada. A capacidade operacional não foi homologada porque bodies, parâmetros e correlações incorretos tornam inseguras várias operações classificadas. Idempotência, prevenção de loop, conflito e reprocessamento continuam `NAO_DOCUMENTADO`.

## Validação das pendências

As 14 pendências `PEND-001` a `PEND-014` existem, possuem identificação, origem, impacto, classificação e evidência. Para o gate do Passo 03:

| ID | Classificação nesta validação |
|---|---|
| `PEND-001` | Não impeditiva para mapear autenticação básica; expiração, refresh e escopos impedem operação prolongada sem decisão. |
| `PEND-002` | Não impeditiva para mapear; rate limit, timeout e retry devem ser resolvidos antes da homologação da integração. |
| `PEND-003` | Não impeditiva para mapear; impede retries seguros até decisão de idempotência. |
| `PEND-004` | Não impeditiva para mapear; impede sincronização bidirecional até desenho de origem e prevenção de loop. |
| `PEND-005` | Impeditiva para os campos afetados; nenhuma nomenclatura pode ser normalizada por inferência. |
| `PEND-006` | Impeditiva no estado atual; rotas não podem ser construídas com segurança e a pendência omite `PUT /representatives`. |
| `PEND-007` | Não impeditiva isoladamente; o PDF é utilizável, mas a ausência do OpenAPI reduz a força da validação estrutural. |
| `PEND-008` | Não impeditiva para mapear; impede concorrência bidirecional sem política de conflito. |
| `PEND-009` | Não impeditiva para mapear; impede reprocessamento automático seguro. |
| `PEND-010` | Impeditiva para o tratamento dos erros afetados até confirmação. |
| `PEND-011` | Impeditiva no estado atual; afeta o mapeamento de visibilidade e o request correspondente está incorreto. |
| `PEND-012` | Não impeditiva globalmente; a resposta de `PUT /brands` não pode ser usada como regra até confirmação. |
| `PEND-013` | Impeditiva para validar sucesso de `POST /brands` e `POST /subcategories`. |
| `PEND-014` | Impeditiva para normalizar os campos afetados; preservar a grafia oficial ou obter confirmação. |

Além delas, foram encontrados achados não registrados: autenticação Bearer não comprovada, `PUT /representatives` ausente de `PEND-006`, associação de imagens ao produto não documentada e divergências sistemáticas de parâmetros, bodies, respostas e correlações.

## Validação da rastreabilidade

- caminhos de `referencias_origem` no YAML: 9/9 existentes;
- cadeia física PDF -> Passo 01 -> Passo 02 -> canônicos: existente;
- rastreabilidade por identidade método + rota: 90/90;
- rastreabilidade semântica: reprovada.

O YAML possui `id` mais oito campos resumidos por operação e remete ao inventário por `referencias_origem` e `FONTES.md`. Essa composição só seria suficiente se o inventário fosse completo e fiel. Como ele contém as divergências demonstradas, uma IA futura precisaria voltar ao PDF e reconstruir parâmetros, bodies, schemas, códigos, enums e correlações.

## Prontidão para mapeamento com ERP

Resposta à pergunta obrigatória:

> Uma IA que futuramente receber a documentação de um ERP consegue utilizar este contrato canônico para mapear ERP x ferramenta sem reconstruir o entendimento da ferramenta do zero?

**Não.** A cobertura nominal permite localizar módulos e operações, mas o conteúdo operacional contém omissões, inferências e bodies incorretos. Usá-lo como fonte normativa produziria mapeamentos errados ou obrigaria nova interpretação da documentação oficial.

Por isso:

- futuras jornadas de ERP parceiro permanecem bloqueadas para esta ferramenta;
- nenhuma integração, adaptador ou código de ERP foi criado;
- nenhuma etapa posterior foi iniciada.

## Restrições conhecidas

1. Não usar o YAML ou o inventário atual como fonte normativa de parâmetros, bodies, schemas, códigos HTTP, enums ou correlações.
2. Não assumir Bearer ou formato do header de autenticação sem fonte oficial adicional.
3. Não construir as rotas de `PEND-006` por inferência.
4. Não implementar visibilidade de produtos, upload de imagens, vínculos de vendedores/clientes ou grade/estoque de SKU a partir dos bodies atuais.
5. Não normalizar grafias divergentes nem escolher política de idempotência, loop, conflito ou reprocessamento sem decisão explícita.

## Achados

### ACHADO-03-001 — Contrato operacional insuficiente

- Evidência: o YAML mantém somente `id` e oito campos resumidos por operação; os detalhes ficam no inventário, que contém divergências materiais.
- Artefatos responsáveis: `01-inventario-operacoes.md` e `CONTRATO-DA-FERRAMENTA.yaml`.
- Impacto: exige reconstrução contra o PDF e impede mapeamento confiável.
- Etapas a revisitar: Passo 01 e Passo 02.

### ACHADO-03-002 — Parâmetros e paginação omitidos

- Evidência: 16 operações divergentes, ao menos 22 parâmetros omitidos e valor espúrio `Vendas` em `GET /agents`.
- Artefatos responsáveis: inventário do Passo 01 e canônicos derivados.
- Impacto: filtros e rotas seriam construídos incorretamente.
- Etapas a revisitar: Passo 01 e Passo 02.

### ACHADO-03-003 — Request bodies incorretos

- Evidência: 12 operações divergentes, ao menos 32 chaves oficiais ausentes e 13 extras; respostas/erros foram usados como requests.
- Artefatos responsáveis: inventário do Passo 01 e canônicos derivados.
- Impacto: payloads e transformações futuros seriam incorretos.
- Etapas a revisitar: Passo 01 e Passo 02.

### ACHADO-03-004 — Códigos e respostas incompletos

- Evidência: 25 operações divergentes e ao menos 38 ocorrências de códigos documentados omitidas.
- Artefatos responsáveis: inventário do Passo 01 e YAML.
- Impacto: classificação de sucesso, erro e retry não é confiável.
- Etapas a revisitar: Passo 01 e Passo 02.

### ACHADO-03-005 — Correlações sem evidência

- Evidência: 10 operações com 17 tokens sem ocorrência no bloco oficial; `OP-090` omite `sellerErpId` e acrescenta identificadores alheios.
- Artefatos responsáveis: inventário, YAML e `BIDIRECIONALIDADE.md`.
- Impacto: criação versus atualização, deduplicação e vínculos podem usar chaves erradas.
- Etapas a revisitar: Passo 01 e Passo 02.

### ACHADO-03-006 — Schemas, obrigatoriedade, enum e upload não preservados

- Evidência: 27 schemas e 185 marcadores de obrigatoriedade na fonte; 90/90 operações com obrigatoriedade `NAO_DOCUMENTADO`; enum e campo obrigatório de upload ausentes.
- Artefatos responsáveis: inventário do Passo 01 e YAML.
- Impacto: campos e validação de payload não são suficientes para mapeamento.
- Etapas a revisitar: Passo 01 e Passo 02.

### ACHADO-03-007 — Inferência de autenticação

- Evidência: `Bearer` é afirmado em 89 operações do inventário, mas não foi localizado na fonte oficial.
- Artefato responsável: inventário do Passo 01.
- Impacto: formato de autenticação pode ser implementado sem evidência.
- Etapas a revisitar: Passo 01 e Passo 02.

### ACHADO-03-008 — Pendências conhecidas incompletas

- Evidência: `PEND-006` omite `PUT /representatives`; associação de imagens ao produto e correlação `code`/`erpId` de vendedores não estão tratadas como lacunas próprias.
- Artefatos responsáveis: `PENDENCIAS.md`, YAML e dependências canônicas.
- Impacto: lacunas conhecidas ficam ocultas para a futura jornada.
- Etapas a revisitar: Passo 01 e Passo 02.

## Resultado técnico

```text
RESULTADO TECNICO: NAO_APTO_PARA_INTEGRACOES
PRONTIDAO: NAO_HOMOLOGADA
STATUS DA FASE DE EXECUCAO: PENDENTE
AUDITORIA DA ETAPA 03: AGUARDANDO_EXECUCAO_SEPARADA
```

Os sete canônicos permaneceram imutáveis. O resultado negativo decorre de conteúdo semântico inexato e insuficiente, não de falha de integridade ou ausência de pré-requisito.

## Próxima ação

1. Reexecutar o Passo 01 para corrigir o inventário contra a documentação oficial, registrar todas as novas divergências e realizar nova auditoria integral do Passo 01.
2. Reexecutar o Passo 02 para corrigir os canônicos a partir do inventário aprovado, preservar detalhes operacionais suficientes e realizar nova auditoria integral do Passo 02.
3. Reexecutar o Passo 03 desde o início.

Não avance para outra jornada, não execute o Passo 04 e não use esta ferramenta em ERP parceiro enquanto o gate de homologação não for atendido.
