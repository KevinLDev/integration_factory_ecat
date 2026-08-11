# DADOS-DA-EXECUCAO — Força de Vendas

## Identificação

- Nome da ferramenta: Força de Vendas
- Slug normalizado: forca-de-vendas
- Empresa responsável: E-Catálogos
- Objetivo resumido da ferramenta: API oficial de integração da ferramenta de força de vendas da E-Catálogos
- Versão conhecida da API/documentação: 1.0.0 (OAS 3.0, conforme documentação PDF)

## Fontes recebidas ou localizadas

- Documentação oficial (fonte primária): `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.pdf`
- Extração textual direta da fonte primária (UTF-8): `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.extraido.txt`
- OpenAPI/Swagger bruto: não fornecido separadamente
- Manuais/PDFs/TXTs adicionais: nenhum
- Exemplos reais: exemplos de request/response contidos no próprio PDF
- Regras de negócio adicionais: nenhuma adicional fornecida
- URLs de referência identificadas no PDF:
  - Base da API: `https://forca-de-vendas.api.e-catalogos.net`
  - Site: `https://e-catalogos.net`

## Ambiente

- URL base conhecida: `https://forca-de-vendas.api.e-catalogos.net`
- Ambiente conhecido: NAO_IDENTIFICADO (a documentação apresenta um server/base, sem separar homologação/produção)
- Tipo de autenticação conhecido: JWT via `POST /auth` (email, password, key)
- Aplicação do JWT nas demais operações: a interface exibe `Authorize`, mas nome/formato do header e prefixo são `NAO_DOCUMENTADO`; não assumir `Bearer`
- Renovação/expiração/escopos de credencial: `NAO_DOCUMENTADO`

## Informações fornecidas pelo operador

- Execução: primeira execução real da V1 da Fábrica de Integrações
- Etapa solicitada: `parceiros/comandos/01-APRESENTAR-E-ANALISAR-FERRAMENTA.md`
- Ferramenta: Força de Vendas
- Restrições explícitas:
  - não integrar com ERP nesta etapa;
  - não criar adaptador;
  - não usar flows antigos do Pipedream como fonte;
  - não avançar para o passo 02;
  - não inventar endpoints/campos/regras fora da documentação oficial.

## Ciclo corretivo controlado após o Passo 03

- O Passo 01 foi concluído e auditado em ciclo histórico anterior.
- O Passo 03 encontrou falhas semânticas materiais nos artefatos derivados; o diagnóstico `DIAGNOSTICO-CORRECAO-POS-PASSO-03.md` atribuiu causas ao Passo 01, ao Passo 02, a ambos e à própria fonte oficial.
- Este ciclo reabre somente o Passo 01 para tratar `ORIGEM_PASSO_01`, a parcela do Passo 01 em `ORIGEM_AMBOS` e o registro fiel das ambiguidades oficiais.
- A auditoria histórica `AUDITORIA-ETAPA-01.md` permanece preservada, mas foi superada como gate vigente depois das correções.
- Os Passos 02 e 03 não foram executados neste ciclo; seus artefatos, auditorias e resultados permanecem históricos.
- Os sete artefatos canônicos e `HOMOLOGACAO-PARA-INTEGRACOES.md` permanecem congelados.

## Informações descobertas automaticamente

- Módulos/tags identificados: 26 (Autenticação, Categorias, Campanhas, Clientes, Condições de pagamento, Cores, Companhias, Filiais, Gêneros, Imagens, Linhas, Marcas, Métodos de pagamento, Pedidos, Preços, Prepostos, Produtos, Prazos de entregas, Regiões, Representantes, Skus, Subcategorias, Tabelas de preço, Transportadoras, Variantes, Vendedores)
- Operações documentadas: 90
- Rotas únicas documentadas: 47
- Schemas listados no bloco final: 27
- Marcadores `*` de obrigatoriedade no catálogo de components: 185, preservados sem projeção automática nos bodies de operação
- Operações paginadas documentadas com `page` e `limit`: 21
- Identificadores publicados incluem `erpId`, `productErpId`, `clientErpId`, `number`, `code` e outras chaves; nenhuma equivalência ou correlação predominante é assumida sem evidência da própria operação
- Operações com dados técnicos documentados no inventário por operação: 90
- Lacunas do inventário: registradas por operação como `NAO_DOCUMENTADO` ou `AMBIGUO`, sem usar uma contagem textual de ocorrências como substituto de validação semântica
- Pendências documentais do Passo 01 corrigido: 20 (`PEND-001` a `PEND-020`)
- Cadastro canônico histórico, não alterado neste ciclo: `ferramentas/forca-de-vendas/`
- Artefato estruturado canônico histórico, congelado: `ferramentas/forca-de-vendas/CONTRATO-DA-FERRAMENTA.yaml`
- Pendências canônicas históricas permanecem 14 (`PEND-001` a `PEND-014`) até uma futura reexecução autorizada do Passo 02
- Histórico da Etapa 02:
  - primeira auditoria: resultado histórico invalidado por alteração de artefatos durante a auditoria;
  - revalidação somente leitura: `AUDITORIA: REPROVADA`, registrada em `AUDITORIA-ETAPA-02-REVALIDACAO.md`;
  - execução posterior do comando 02: seis achados corrigidos e submetidos a nova auditoria; o resultado vigente deve ser consultado em `ESTADO-DA-EXECUCAO.md`.

## Lacunas e divergências ainda não resolvidas na fonte

- O Passo 01 corrigido registra 20 pendências estáveis em `01-analise-documentacao.md`, com aplicação por operação no inventário e na matriz.
- Elas abrangem autenticação sem formato/header comprovado, resiliência, idempotência, loop, conflito, reprocessamento, nomenclaturas, inconsistências HTTP, required de components sem vínculo normativo aos bodies, enums não formalizados e ambiguidades específicas.
- Permanecem explicitamente ambíguos: sete conflitos rota/path; quatro atualizações sem transporte seguro do alvo; associação de `POST /images` ao produto; e ponte `code`/`erpId`/`sellerErpId` de vendedores.
- O registro dessas lacunas evita suposição silenciosa. Ele não corrige nem atualiza automaticamente as 14 pendências do cadastro canônico histórico.
