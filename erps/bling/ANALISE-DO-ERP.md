# ANALISE-DO-ERP — Bling

## Identificação

- ERP: Bling
- Especificação: OpenAPI 3.0.0, título "Bling API", `info.version: "3.0"`
- Fonte: ver `FONTES.md`

## 1) Autenticação

- Mecanismo: **OAuth2, fluxo `authorizationCode`**, documentado em `components.securitySchemes.OAuth2`
  e `OAuth2-Docs`.
- Endpoints (ambiente de produção, `OAuth2`):
  - `authorizationUrl`: `https://bling.com.br/Api/v3/oauth/authorize`
  - `tokenUrl`: `https://bling.com.br/Api/v3/oauth/token`
  - `refreshUrl`: `https://bling.com.br/Api/v3/oauth/token`
- Endpoints (ambiente de documentação/teste, `OAuth2-Docs`): mesma `authorizationUrl`, mas `tokenUrl`/
  `refreshUrl` apontando para `https://developer.bling.com.br/api/bling/oauth/token`.
- `security` global do documento exige ambos os esquemas (`OAuth2` e `OAuth2-Docs`) — `scopes` vazios em
  ambos no OpenAPI (Bling não publica nomes de escopo aqui; o token obtido em runtime trouxe uma lista
  de IDs numéricos em `scope`, não nomes — `NAO_DOCUMENTADO` na especificação, apenas observado em
  runtime).
- **AUTENTICACAO: SUCESSO** (`CONFIRMADO_EM_RUNTIME`, fora desta jornada formal — ver `FONTES.md`).
- **TOKEN: OBTIDO** — `token_type=bearer`, `expires_in=21600` segundos (6 horas), aplicado via header
  `Authorization: Bearer <access_token>` (confirmado em runtime pelas duas chamadas de teste bem-
  sucedidas).
- **REFRESH: SUPORTADO** (`CONFIRMADO_EM_RUNTIME` em 2026-08-21) — endpoint de refresh é o mesmo
  `tokenUrl` (`grant_type=refresh_token`, padrão OAuth2). Testado de fato: `POST /oauth/token` com
  `grant_type=refresh_token` retornou HTTP 200, novo `access_token` (`expires_in=21600`) e **um novo
  `refresh_token`, diferente do anterior** — o Bling **rotaciona** o `refresh_token` a cada renovação.
  Implicação de design para o Passo 06: a implementação real precisa persistir o `refresh_token` mais
  recente a cada uso; reutilizar um já consumido quebra a próxima renovação. Evidência:
  `parceiros/execucoes/erps/bling/forca-de-vendas/evidencias/evidencia-filiais-depositos-canais-20260821.json`.
- Diferença de ambientes: a especificação lista dois `servers`: produção
  (`https://api.bling.com.br/Api/v3`) e "Ambiente de teste da documentação"
  (`https://developer.bling.com.br/api/bling`). O teste runtime realizado usou o fluxo de autorização de
  produção (`bling.com.br`) e retornou dados de uma conta real, não um sandbox dedicado — ver
  `PENDENCIAS.md` desta pasta.

## 2) Ambientes

| Ambiente | Base URL | Observação |
|---|---|---|
| Produção | `https://api.bling.com.br/Api/v3` | Confirmado em runtime (empresa "eCatalogos" autenticada). |
| Teste da documentação | `https://developer.bling.com.br/api/bling` | Descrito no OpenAPI como "Ambiente de teste da documentação"; não testado nesta execução; não está claro se é um sandbox funcional isolado ou apenas o servidor que hospeda a doc interativa (`PENDENTE_DE_EVIDENCIA`). |

Não há evidência de um ambiente de homologação/sandbox comercial separado (com dados fictícios,
isolado de produção) documentado nesta especificação.

**Estado real da conta de homologação (verificado em runtime, 2026-08-21)**: a conta Bling do ERP
parceiro usada nesta jornada tem `GET /depositos` → 1 depósito ("Geral", padrão) e `GET /canais-venda`
→ 0 canais configurados. Ou seja, hoje não há cenário multi-filial/multi-canal nesta conta para
observar. Isso resolveu `PEND-BLING-FDV-006` como `NAO_APLICAVEL` para esta homologação (não como
limitação da API) — ver `PENDENCIAS.md` da combinação.

## 3) Arquitetura geral da API

- REST sobre HTTPS, payloads JSON.
- Cada operação carrega `x-api-resource` e `x-api-action` (extensões proprietárias do Bling) que
  identificam de forma estável o recurso/ação lógicos, independentemente do path HTTP. Usado como chave
  primária de correlação nesta análise em vez do path bruto.
- 162 paths únicos, 257 operações HTTP, 43 `x-api-resource` distintos, 407 component schemas, 65
  parameters reutilizáveis (contagens mecânicas, ver `FONTES.md`).
- Distribuição de operações por método (contagem mecânica): ver `CAPACIDADES-DO-ERP.md`.

## 4) Paginação

- Parâmetros padrão: `pagina` (query, inteiro, `default: 1`, `minimum: 1`) e `limite` (query, inteiro,
  `default: 100`, `minimum: 1`).
- **Sem valor máximo documentado** para `limite` (`maximum` ausente no schema) — possível limite
  server-side não documentado (`PENDENTE_DE_EVIDENCIA`).
- Aplicado de forma consistente nos endpoints de listagem (`ObterMultiplos`) verificados.

## 5) Formato de erro

- Schema `Error` (dentro de `ErrorResponse`), com `type` (enum fechado: `BAD_REQUEST`,
  `VALIDATION_ERROR`, `MISSING_REQUIRED_FIELD_ERROR`, `EMPTY_REQUEST_BODY`, `INVALID_REQUEST_BODY`,
  `INVALID_APIKEY_ERROR`, `UNAUTHORIZED`, `UNAUTHENTICATED`, `FORBIDDEN`, `RESOURCE_NOT_FOUND`,
  `METHOD_NOT_ALLOWED`, `TOO_MANY_REQUESTS`, `UNKNOWN_ERROR`, `SERVER_ERROR`, `NOT_IMPLEMENTED`),
  `message`, `description` e `fields[]` (erro por campo, com `code`/`msg`/`element`/`namespace`/
  `collection`).
- Formato de erro consistente e bem tipado — mais estruturado que o observado no contrato atual da
  Força de Vendas (que registra `PEND-010`: inconsistência entre status HTTP e mensagem).

## 6) Limites (rate limit, tamanho, timeout)

- `TOO_MANY_REQUESTS` existe como `type` de erro documentado, confirmando que o Bling aplica rate
  limit, mas **nenhum número de quota, janela de tempo, header `X-RateLimit-*` ou política de
  retry/backoff é documentado nesta especificação** (busca mecânica por `rate limit`/`x-ratelimit`
  no JSON: 0 ocorrências). `PENDENTE_DE_EVIDENCIA` quanto ao valor exato.
- Tamanho máximo de payload, número máximo de itens em operações de "múltiplos" (ex.:
  `idsProdutos[]`, `idsContatos[]`) e timeout de requisição: não documentados nesta especificação.

## 7) Eventos (webhook/callback)

- Busca mecânica por `webhook`, `callback` e `evento` no JSON completo: **0 ocorrências**.
- **NAO_SUPORTADO** (por ausência de evidência estrutural) — a API do Bling, nesta especificação, é
  inteiramente baseada em polling (GET). Não há mecanismo de notificação push para mudanças (ex.: novo
  pedido, alteração de estoque). O recurso `Notificacoes` existe, mas é sobre notificações internas do
  sistema Bling ao usuário (ex.: mudanças regulatórias fiscais), não eventos de integração.
- Implicação direta para a jornada futura: qualquer sincronização Bling → Força de Vendas precisará de
  estratégia de polling (com paginação e algum filtro de data de alteração, quando disponível por
  recurso) em vez de assinatura de eventos.

## 8) Observação estrutural relevante para a combinação com Força de Vendas

O Bling é um ERP genérico completo (fiscal, financeiro, logístico, produção), com módulos sem
equivalente em uma ferramenta de força de vendas (Notas Fiscais, Contas a Pagar/Receber, Caixas e
Bancos, Ordens de Produção, Borderôs). Apenas um subconjunto dos 43 recursos é relevante para o
contrato da Força de Vendas — ver `CAPACIDADES-DO-ERP.md` (seção "Recursos relevantes") e a matriz da
combinação.

Verificação mecânica importante (busca por termo nos 162 paths e 407 schemas do Bling): **não existem
recursos dedicados de Marca, Cor, Região, Tabela de Preço, Gênero, Campanha ou Preposto** no Bling — só
existem como campo de texto livre (`marca` em Produto), referência de ID sem CRUD próprio
(`ProdutosLinhaProdutoDTO`), ou não existem. Isso é tratado com profundidade na matriz da combinação
(`erps/bling/integracoes/forca-de-vendas/MATRIZ-ERP-FERRAMENTA.md`), por ser um conjunto de gaps
estruturais relevantes, não uma lacuna documental.

## 9) Escopo desta análise

- Este documento e `CAPACIDADES-DO-ERP.md` foram produzidos a partir da leitura integral do OpenAPI
  (162 paths, 407 schemas) e de buscas mecânicas complementares sobre o mesmo arquivo (ver comandos em
  `FONTES.md`/histórico da execução).
- `CONTRATO-DA-FERRAMENTA.yaml` da Força de Vendas (675 KB) foi consultado seletivamente por módulo/
  operação relevante, não lido integralmente linha a linha nesta execução; a base usada foi
  prioritariamente `MODULOS.md`, `DEPENDENCIAS.md`, `BIDIRECIONALIDADE.md`, `PENDENCIAS.md`,
  `REGRAS-DE-NEGOCIO.md` e `CENARIOS-FUNCIONAIS.md`, que já são sínteses aprovadas e auditadas desses
  675 KB.
- Validação técnica em runtime (Camada 2 do Passo 02) foi limitada a autenticação + duas chamadas GET
  de baixo risco, por decisão de manter o escopo mínimo necessário nesta etapa; **nenhuma outra rota
  foi testada em runtime**. Isso é uma decisão de escopo explícita, não uma limitação da API.
