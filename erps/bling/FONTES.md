# Fontes e cadeia de rastreabilidade — Bling

## Autoridade técnica

A documentação oficial do Bling é a fonte técnica primária. Os artefatos abaixo (`ANALISE-DO-ERP.md`,
`CAPACIDADES-DO-ERP.md` e a matriz da combinação) são sínteses rastreáveis e não substituem a fonte
original.

## Fontes oficiais

1. `parceiros/execucoes/erps/bling/referencias/documentacao-oficial/bling-openapi-v3.json`
   - papel: autoridade técnica primária (especificação OpenAPI 3.0.0 completa da Bling API, título
     "Bling API", `info.version: "3.0"`);
   - origem: arquivo fornecido pelo operador (`api bling.txt`, localizado em
     `C:\Users\kevin\Downloads\api bling.txt` no ambiente do operador), copiado para o repositório
     nesta execução;
   - bytes: 782.661;
   - SHA-256 vigente (`TEXT_CANONICAL_V1`): `7C87BD357977A3B05063BF7FB5044F7D1B8E3BBFC20DDDD179995EDF191D5DBB`;
   - contagens verificadas mecanicamente (script Python ad hoc sobre o JSON, nesta execução):
     162 paths únicos, 407 component schemas, 65 parameters reutilizáveis, 257 operações HTTP
     (GET/POST/PUT/PATCH/DELETE), 43 valores distintos de `x-api-resource`.
2. `parceiros/execucoes/erps/bling/referencias/documentacao-oficial/Referencia-API-Bling.pdf`
   - papel: documentação oficial complementar em PDF ("API | Bling - Referência da API"), localizada
     pelo operador em `C:\Users\kevin\OneDrive\Desktop\imgsEcat\API _ Bling - Referência da API.pdf`,
     copiada para o repositório nesta execução;
   - bytes: 26.132.323;
   - SHA-256 vigente (`BYTES_V1`): `E3F30732C3667C1B89005799B2DEFC681B4ED942A7A5311B18D4D776D606418E`;
   - papel nesta análise: registrado como fonte oficial complementar disponível; **não foi extraído/lido
     integralmente nesta execução** (26 MB, formato visual). A especificação OpenAPI é estruturalmente
     mais completa e foi usada como fonte primária para esta análise. Se uma futura etapa precisar de
     texto explicativo que só exista no PDF (ex.: exemplos de fluxo, capturas de tela, texto
     introdutório), extrair sob demanda e registrar aqui.

## Observação sobre codificação de caracteres (resolve pendência do Passo 01)

O Passo 01 registrou como pendência um padrão de mojibake (ex.: `sessÃ£o`) observado no texto colado
diretamente no chat. Ao localizar e copiar o arquivo real (`api bling.txt`) para o repositório nesta
execução, confirmou-se que **o arquivo fonte em disco está corretamente codificado em UTF-8** (ex.:
`"description": "A sessão abaixo contém a documentação das API's que o Bling disponibiliza."`,
verificado byte a byte). O mojibake foi um artefato exclusivo da colagem no chat, não da fonte oficial.
Esta pendência do Passo 01 está **RESOLVIDA**: a fonte oficial persistida neste repositório é a
autoridade técnica, não o texto colado no chat.

## Evidência runtime (fora da jornada formal, referenciada por transparência)

Um teste técnico isolado do fluxo OAuth2 (fora desta jornada, registrado em
`analises/notas-tecnicas/2026-08-20-bling-conflito-processo-oficial.md`) confirmou em runtime real:

- `POST /Api/v3/oauth/token`: HTTP 200, `token_type=bearer`, `expires_in=21600` (6h), `refresh_token`
  presente;
- `GET /Api/v3/situacoes/modulos`: HTTP 200;
- `GET /Api/v3/empresas/me/dados-basicos`: HTTP 200.

Essas evidências são citadas em `ANALISE-DO-ERP.md` e `CAPACIDADES-DO-ERP.md` como
`CONFIRMADO_EM_RUNTIME` apenas para essas três chamadas específicas. Todas as demais 254 operações do
Bling permanecem `CONFIRMADO_POR_DOCUMENTACAO` (não testadas em runtime nesta execução), conforme a
política de validação técnica controlada do Passo 02 (GET/HEAD/OPTIONS e autenticação são permitidos;
POST/PUT/PATCH/DELETE com efeito comercial são bloqueados nesta etapa).

## Fontes da ferramenta (contrato homologado, autoridade canônica)

1. `ferramentas/forca-de-vendas/README.md`
2. `ferramentas/forca-de-vendas/MODULOS.md`
3. `ferramentas/forca-de-vendas/DEPENDENCIAS.md`
4. `ferramentas/forca-de-vendas/BIDIRECIONALIDADE.md`
5. `ferramentas/forca-de-vendas/PENDENCIAS.md`
6. `ferramentas/forca-de-vendas/REGRAS-DE-NEGOCIO.md`
7. `ferramentas/forca-de-vendas/CENARIOS-FUNCIONAIS.md`
8. `ferramentas/forca-de-vendas/CONTRATO-DA-FERRAMENTA.yaml` (consultado seletivamente para campos
   específicos; não lido integralmente nesta execução — arquivo de 675 KB. Ver nota de escopo em
   `ANALISE-DO-ERP.md`.)

## Execução anterior desta jornada

- Passo 01: `parceiros/execucoes/erps/bling/DADOS-DA-EXECUCAO.md`,
  `parceiros/execucoes/erps/bling/ESTADO-DA-EXECUCAO.md`,
  `parceiros/execucoes/erps/bling/auditorias/AUDITORIA-ETAPA-01.md`,
  `parceiros/execucoes/erps/bling/manifestos/PASSO-01.yaml`.

## Regra de vigência

- Fonte oficial (OpenAPI + PDF) tem precedência sobre as sínteses deste Passo 02.
- Nenhuma equivalência entre identificadores, capacidade, direção ou regra comercial foi inferida sem
  evidência textual do OpenAPI, do PDF (quando consultado) ou de teste runtime autorizado.
- Ausência de recurso/schema/campo no OpenAPI é registrada como ausência verificada mecanicamente
  (busca programática sobre os 162 paths e 407 schemas), não como suposição.
