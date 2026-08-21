# DIAGNOSTICO-CORRECAO — 2026-08-21

## Motivo

O operador, ao revisar o Passo 03, apontou duas correções:

1. A conta Bling usada em toda esta jornada **não é uma conta de cliente futuro** — é a conta do
   próprio ambiente de ERP parceiro (E-Catálogos) usada para construir e homologar a combinação
   reutilizável. Vários artefatos usaram a expressão "conta Bling do cliente"/"conta real do cliente",
   o que está semanticamente errado nesta fase da jornada (não existe cliente ainda) e poderia induzir
   um leitor futuro a pensar que a fábrica misturou a jornada de ERP parceiro com a jornada de ERP
   cliente.
2. O operador pediu verificação técnica real sobre se `ProdutosEstruturas` do Bling sustenta
   "grade fechada com pack/composição fixa" (`RN-FDV-GRA-002`), classificado como `PENDENTE_DE_EVIDENCIA`
   na primeira passada dos Passos 02/03.

## Classificação da origem

- Item 1: `ORIGEM_PASSO_02` e `ORIGEM_PASSO_03` — terminologia introduzida nos dois passos, sem
  impacto técnico (não altera nenhuma capacidade, gap ou classificação; é uma imprecisão de linguagem).
- Item 2: `ORIGEM_PASSO_02` — a primeira passada da Etapa 02 classificou `ProdutosEstruturas` com
  profundidade insuficiente (`RELEVANTE_INDIRETO`, sem reexame do schema `ProdutosEstruturaDTO`/
  `ProdutosComponenteDTO`). O reexame nesta correção usou exatamente a mesma fonte já persistida
  (`bling-openapi-v3.json`, hash inalterado) — não houve mudança de fonte, apenas leitura mais profunda
  da fonte já disponível.

## O que foi reexaminado (item 2)

Releitura mecânica de `ProdutosEstruturaDTO`, `ProdutosComponenteDTO`, `ProdutosComponenteProdutoDTO` e
dos 6 endpoints de `/produtos/estruturas` diretamente do arquivo persistido
`parceiros/execucoes/erps/bling/referencias/documentacao-oficial/bling-openapi-v3.json` (mesmo hash
`7C87BD357977A3B05063BF7FB5044F7D1B8E3BBFC20DDDD179995EDF191D5DBB` registrado desde o Passo 02).

Achado: a combinação `formato: "E"` (produto com composição) + `lancamentoEstoque: "M"` (estoque
lançado somente no componente) modela estruturalmente uma grade fechada: um produto pai vendável como
uma única unidade comercial, cujos componentes (`componentes[].produto.id` + `quantidade`) têm
quantidade fixa, e cujo estoque real é consumido apenas dos componentes — exatamente o comportamento
que `RN-FDV-GRA-002` exige (pack/composição pré-definida).

Duas ressalvas permanecem, agora mais precisas (não eliminadas, apenas isoladas):

- (a) a documentação não afirma explicitamente que uma variação (que já é um Produto filho via
  `formato: V`) pode ser componente de uma estrutura de composição de outro produto — inferido da
  generalidade do schema (`componente.produto` é só `{id}`), não de texto explícito;
- (b) comportamento em runtime não foi testado nesta análise documental (fica para o Passo 07).

## Artefatos corrigidos

| Artefato | Tipo de correção | Hash anterior | Hash novo |
|---|---|---|---|
| `erps/bling/CAPACIDADES-DO-ERP.md` | Item 1 (terminologia) + Item 2 (reexame ProdutosEstruturas) | `02703C93336945644D32D497C5349938DE46B3A5AB58886BEA71630FA68A3B48` | `F093835E275E8D7C6667CB683EADD7BECF34A8309B1C9EDE91438DB57EAD93C9` |
| `erps/bling/integracoes/forca-de-vendas/MATRIZ-ERP-FERRAMENTA.md` | Item 2 (linha `RN-FDV-GRA-001/002` dividida e reclassificada) | `0E68563489F8C59B7520F90766598AED0052DFE7ED2FCB36182E7F9B2207702F` | `3D3AD4090FEFE114D741964393AF6441A08A4D3E56AF9C93B825341D96C1F403` |
| `erps/bling/integracoes/forca-de-vendas/PLANO-DE-HOMOLOGACAO.md` | Item 1 + Item 2 (GAP-001 resolvido, `PENDENCIAS_BLOQUEANTES` 2→1) | `B6A66D54824F2694A7F729CC193E97CE81A198EF718DAF83DFA7AC0A2CE2B354` | `036501607CB7C39B457674AA7574E3A215AF380A2E806324CF4ABC74955DB857` |
| `erps/bling/integracoes/forca-de-vendas/BASE-COMERCIAL-PLANEJADA.yaml` | Item 2 (gap GAP-001 marcado resolvido) | `9A610348076F2D42E4D3C08BA85EDFDAF0490024FE86B6A276C0215A490F50D7` | `994CF0BDD48370954F1B947C30FA8E9152739A8524821D7CBB2EF9D6CBB28ECA` |

Nenhum artefato canônico da ferramenta (`ferramentas/forca-de-vendas/*`) foi tocado. Nenhuma fonte
mudou — apenas a profundidade de leitura da mesma fonte já persistida.

## Impacto no gate

- `PENDENCIAS_BLOQUEANTES` do Passo 03: 2 → **1** (resta apenas confirmar unidades de negócio/filiais,
  diretamente checável na própria conta do ERP parceiro).
- `PRONTO_PARA_CRIAR_BASE_REAL` permanece `NAO` (ainda resta a pendência de filiais), mas a cobertura
  de produtos planejados sobe de 180/200 para 200/200 prontos para materialização.

## Auditorias vigentes após esta correção

- Passo 02: `parceiros/execucoes/erps/bling/forca-de-vendas/auditorias/AUDITORIA-ETAPA-02-REVALIDACAO-20260821.md`
  (substitui `AUDITORIA-ETAPA-02.md` como gate vigente; o original permanece preservado como histórico).
- Passo 03: `parceiros/execucoes/erps/bling/forca-de-vendas/auditorias/AUDITORIA-ETAPA-03-REVALIDACAO-20260821.md`
  (substitui `AUDITORIA-ETAPA-03.md` como gate vigente; o original permanece preservado como histórico).

## Observação para a fábrica (meta)

Este ciclo é um exemplo real do que a metodologia já previa: uma primeira passada documental pode
classificar algo como `PENDENTE_DE_EVIDENCIA` por profundidade insuficiente de leitura, não por
ausência real de informação. A correção veio de reler a **mesma fonte já persistida** com mais cuidado,
não de uma fonte nova — reforça o valor de manter a fonte bruta versionada (`bling-openapi-v3.json`)
para permitir exatamente esse tipo de revisão sem depender do histórico de chat.
