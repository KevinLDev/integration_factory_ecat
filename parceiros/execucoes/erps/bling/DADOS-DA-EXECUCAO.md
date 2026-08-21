# DADOS-DA-EXECUCAO — Bling (ERP parceiro)

## Identificação

- ERP: Bling
- Slug normalizado: bling
- Ferramenta alvo: Força de Vendas
- Jornada: ERP parceiro (`INTEGRAR_ERP_PARCEIRO`)
- Etapa: 01-APRESENTAR-ERP
- Comando executado: `parceiros/comandos/ERP-PARCEIRO-01-APRESENTAR-ERP.md`
- Documento operacional correspondente: `comece-aqui/integrar-erp/erp-parceiro/01-APRESENTAR-ERP.md`

## Resolução central de contexto aplicada

Consultada antes de qualquer decisão: `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`.

- `FERRAMENTA_CONHECIDA`: SIM — Força de Vendas existe em `ferramentas/forca-de-vendas/`.
- `FERRAMENTA_HOMOLOGADA`: SIM — verificado via manifesto vigente
  `parceiros/execucoes/ferramentas/forca-de-vendas/manifestos/PASSO-03.yaml`, revalidado nesta
  execução com `scripts/harness/harness.cmd manifest` (saída: `VIGENCIA_CALCULADA: VALIDO`,
  `GATE_ATENDIDO: TRUE`, `REUTILIZAVEL_COMO_GATE: TRUE`). Campos confirmados:
  `resultado.status=CONCLUIDA`, `resultado.auditoria_vigente.resultado=APROVADA`,
  `resultado.resultado_tecnico=APTO_PARA_INTEGRACOES`, `resultado.prontidao=HOMOLOGADA_PARA_INTEGRACOES`.
- `ERP_CONHECIDO`: NAO — busca por "bling" (case-insensitive) em todo o repositório, fora de `.git/`,
  não retornou nenhum artefato prévio. `erps/` contém apenas `.gitkeep`. `erps-integrados/README.md`
  confirma "Nenhum ERP publicado até o momento."
- `COMBINACAO_ERP_FERRAMENTA_EXISTE`: NAO — decorrência direta do item anterior.
- Contexto informado explicitamente pelo operador: NAO_INFORMADO como "parceiro" ou "cliente"; o
  pedido original foi genérico ("fazer uma integração entre o ERP Bling e a força de vendas").
- Regra de resolução aplicada (Cenário B — `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`):
  "Ferramenta homologada + ERP novo" → jornada de **ERP parceiro**.
- Nenhum documento redundante recebido: não havia contrato homologado prévio do Bling para comparar.

## Fontes recebidas ou localizadas

- Documentação oficial do ERP: OpenAPI/Swagger completo da "Bling API" (`openapi: 3.0.0`,
  `info.version: "3.0"`), fornecido pelo operador diretamente na sessão de chat (anexo `api bling.txt`).
  - **Ainda não persistido no repositório.** A cópia oficial para
    `parceiros/execucoes/erps/bling/referencias/documentacao-oficial/` fica para o Passo 02
    (Analisar ERP), para não antecipar análise profunda nesta etapa, conforme a restrição do
    comando `ERP-PARCEIRO-01-APRESENTAR-ERP.md`.
  - Observação de qualidade de dados: o texto recebido apresenta padrão de mojibake em várias
    descrições (ex.: `sessÃ£o`, `integraÃ§Ã£o`, `disponibiliza`), típico de UTF-8 decodificado
    incorretamente como Latin-1/CP1252 na origem/exportação. Isso é um **PENDÊNCIA** a resolver no
    Passo 02: confirmar a codificação correta com a fonte oficial (`developer.bling.com.br`) antes de
    tratar qualquer texto descritivo como verdade semântica; não foi feita nenhuma correção silenciosa.
  - Servers documentados no OpenAPI: produção `https://api.bling.com.br/Api/v3`; "ambiente de teste da
    documentação" `https://developer.bling.com.br/api/bling`.
  - Autenticação documentada: OAuth2 `authorizationCode`, `authorizationUrl`/`tokenUrl`/`refreshUrl` em
    `https://bling.com.br/Api/v3/oauth/...` (produção) e uma variante `-Docs` apontando `tokenUrl`/
    `refreshUrl` para `developer.bling.com.br`.
- Documentação da ferramenta: nenhuma nova enviada nesta sessão. Força de Vendas já possui contrato
  homologado interno (`ferramentas/forca-de-vendas/`); nenhum documento seria necessário mesmo se
  reenviado (regra de documento redundante).
- Referência histórica conhecida, mas não materializada: `AGENTS.md` (Seção 7) cita "integrações
  Pipedream entre Bling e Força de Vendas" como referência histórica. `referencias-historicas/README.md`
  já prevê a pasta `referencias-historicas/bling-forca-pipedream/`, mas ela **não existe/não foi
  populada** neste repositório até esta data. Registrado como pendência para busca ativa no Passo 02.

## Credenciais (somente presença, nunca valores)

- Credenciais do ERP (Bling): **FORNECIDAS** — `client_id`, `client_secret` e `redirect_uri`
  (`http://localhost:3000/callback`) foram fornecidos pelo operador diretamente na sessão.
- Credenciais da ferramenta (Força de Vendas): **NAO_FORNECIDAS** nesta sessão.
- Nenhum valor de credencial foi reproduzido neste arquivo nem em qualquer artefato versionado.

## Ambiente de homologação/teste

- **NAO_FORNECIDO** como ambiente dedicado de homologação/sandbox.
- O que existe: acesso de uma conta Bling real do operador (empresa "eCatalogos"), usada apenas para um
  teste técnico pontual e informal de autenticação OAuth2, fora desta jornada, contra a API de
  **produção** do Bling (`api.bling.com.br`) — não um ambiente de teste dedicado.
- Esse teste está registrado separadamente, sem valores de segredo, em:
  `analises/notas-tecnicas/2026-08-20-bling-conflito-processo-oficial.md`.
- O OpenAPI do Bling também documenta um "ambiente de teste da documentação"
  (`developer.bling.com.br/api/bling`), ainda não validado por nenhum teste real nesta sessão.

## Execução técnica fora de ordem (registrada para transparência)

Antes da execução formal deste Passo 01, o operador solicitou e autorizou um teste técnico isolado do
fluxo OAuth2 do Bling, fora da jornada oficial. O resultado (sucesso na segunda tentativa, após correção
de credenciais pelo operador) está integralmente documentado em
`analises/notas-tecnicas/2026-08-20-bling-conflito-processo-oficial.md`, incluindo:

- confirmação de que o par client_id/client_secret corrigido autentica corretamente;
- emissão de `access_token` (validade 6h) e `refresh_token`;
- duas chamadas de leitura bem-sucedidas (`GET /situacoes/modulos`, `GET /empresas/me/dados-basicos`).

Este Passo 01 não reutiliza esse teste como evidência de análise técnica da API (isso pertence ao
Passo 02 em diante); ele é citado aqui apenas para manter rastreabilidade completa da sessão.

## Regras adicionais informadas pelo operador

- Nenhuma regra adicional explícita além do já registrado acima.

## Restrições respeitadas nesta etapa

- Não foi iniciado desenvolvimento de integração.
- Não foi criada base comercial de homologação.
- Não foi feita análise profunda da API do Bling (isso é escopo do Passo 02).
- Nenhum artefato canônico de `ferramentas/forca-de-vendas/` foi lido como gravável nem alterado.
- Nenhum valor real de credencial foi persistido em artefato versionado.
