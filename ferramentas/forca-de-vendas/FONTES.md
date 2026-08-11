# Fontes e cadeia de rastreabilidade

## Autoridade técnica

A documentação oficial da ferramenta E-Catálogos é a fonte técnica primária. Os artefatos do Passo 01 e os canônicos do Passo 02 são sínteses rastreáveis e não substituem a fonte original. A extração textual é apenas um índice mecânico derivado do PDF.

## Fonte oficial original

1. `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.pdf`
   - papel: autoridade técnica primária;
   - identidade publicada: Força de Vendas, API 1.0.0, OAS 3.0;
   - bytes: 1.526.436;
   - SHA-256 vigente: `2C8AAB2659BCF8974905912024E86A0B7D1053FB55E2A5FE727785FC1AD01BFB`.
2. `parceiros/execucoes/ferramentas/forca-de-vendas/referencias/documentacao-oficial/Documentacao_API_Forca_de_Vendas.extraido.txt`
   - papel: apoio reproduzível de busca e comparação operação por operação;
   - autoridade: derivada do PDF, nunca independente dele;
   - bytes: 113.964;
   - SHA-256 vigente: `A4B16B88AE820A2B543F72C18FD0908E843C01D948B22BECEB63F8EA9A2B1D5F`.

## Passo 01 corrigido e aprovado — baseline vigente

1. `analises/ferramentas/forca-de-vendas/01-analise-documentacao.md`
   - papel: síntese corrigida de identidade, 26 módulos, dependências, divergências e 20 pendências;
   - SHA-256 aprovado: `90399B66E0F92172D0B4807C40BD97DD3ABE7DEFBE8DFB0EBBD7E351170C9AD9`.
2. `analises/ferramentas/forca-de-vendas/01-inventario-operacoes.md`
   - papel: fonte intermediária por operação, com 90 identidades método + rota, 47 rotas, parâmetros, bodies, responses, schemas, paginação, enum, upload, dependências e rastreabilidade;
   - SHA-256 aprovado: `3CEC7DF7C4AF0270CD6986812B59697239429C37964CAEC2EA6C424203AC7F5E`.
3. `analises/ferramentas/forca-de-vendas/01-matriz-bidirecionalidade-modulos.md`
   - papel: matriz corrigida de 66 operações em `ERP -> ferramenta` e 24 em `ferramenta -> ERP`, união 90/90;
   - SHA-256 aprovado: `0D0B2C7A833D2A7AB8AF4DD1E4D46C6F04E3F6CF9DC662F33FEF7B0124669324`.
4. `parceiros/execucoes/ferramentas/forca-de-vendas/DADOS-DA-EXECUCAO.md`
   - papel: identidade, fontes e contexto persistente da execução;
   - SHA-256 aprovado no gate vigente do Passo 01: `1A8CD4E66EAF731CA8A463577DE3EE34F0A2605341DBD359086F30D774919B5D`.
5. `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-01-POS-CORRECOES-PASSO-03.md`
   - papel: **gate vigente** do Passo 01 corrigido;
   - resultado: `AUDITORIA: APROVADA` e `STATUS DA ETAPA: CONCLUIDA`;
   - substitui como gate, sem apagar, `AUDITORIA-ETAPA-01.md`.
6. `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-01.md`
   - papel: auditoria histórica do ciclo anterior;
   - não é a baseline vigente após as correções pós-Passo 03.

## Diagnóstico que originou a reconstrução

`parceiros/execucoes/ferramentas/forca-de-vendas/DIAGNOSTICO-CORRECAO-POS-PASSO-03.md`

- papel: classificar a origem das divergências encontradas no Passo 03 sem executar etapa ou auditoria;
- `DIAG-001`: redução estrutural das 90 operações atribuída ao Passo 02;
- `DIAG-011`: condição de pagamento e método de pagamento, com parcela do Passo 02 materializada em `DEPENDENCIAS.md`;
- `DIAG-013`: região e tabela de preço, com as grafias conflitantes preservadas e vinculadas a `PEND-005`;
- ambiguidades da fonte e demais correções do Passo 01 permanecem refletidas no inventário, na matriz e em `PENDENCIAS.md`;
- SHA-256 preservado: `5770C7D5FFD13CCDD014D72AF2C8683C56F3C6ECB88CDF9201E3F84559A651B8`.

## Execução e regras da reexecução do Passo 02

1. `AGENTS.md`
2. `parceiros/AGENTS.md`
3. `parceiros/comandos/02-CADASTRAR-FERRAMENTA.md`
4. `comece-aqui/integrar-nova-ferramenta/02-CADASTRAR-FERRAMENTA.md`
5. `parceiros/execucoes/ferramentas/forca-de-vendas/DADOS-DA-EXECUCAO.md`
6. `parceiros/execucoes/ferramentas/forca-de-vendas/ESTADO-DA-EXECUCAO.md`
7. os sete artefatos canônicos reconstruídos em `ferramentas/forca-de-vendas/`.

Durante a fase produtora, os sete canônicos podem ser corrigidos. Eles somente se tornam uma baseline aprovada depois de congelados e submetidos a uma nova auditoria integral, somente leitura, do Passo 02. Este documento não declara essa auditoria como executada ou aprovada.

## Auditorias históricas do Passo 02

1. `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-02.md`
   - resultado registrado: `APROVADA`;
   - valor atual: histórico processualmente inválido por alteração de artefatos durante a auditoria.
2. `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-02-REVALIDACAO.md`
   - resultado: `REPROVADA`;
   - papel: revalidação somente leitura que registrou seis achados do cadastro histórico.
3. `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-02-POS-CORRECOES.md`
   - resultado histórico: `APROVADA`;
   - valor atual: preservado como gate do ciclo anterior, mas superado após a correção e mudança da baseline do Passo 01.

Nenhum desses três relatórios históricos valida os canônicos desta reexecução. O relatório vigente da nova auditoria do Passo 02 deverá ser resolvido exclusivamente por `ESTADO-DA-EXECUCAO.md` depois que essa auditoria existir e terminar.

## Evidências históricas do Passo 03, somente leitura

1. `ferramentas/forca-de-vendas/HOMOLOGACAO-PARA-INTEGRACOES.md`
   - resultado histórico preservado: `NAO_APTO_PARA_INTEGRACOES`;
   - não foi alterado nesta reexecução do Passo 02.
2. `parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-03.md`
   - resultado histórico preservado: `AUDITORIA: REPROVADA` e `STATUS DA ETAPA: PENDENTE`;
   - papel: evidência dos achados que deram origem ao diagnóstico, não gate do Passo 02.

Essas evidências não autorizam executar o Passo 03, homologar a ferramenta ou iniciar jornada de ERP.

## Cadeia por artefato canônico

| Artefato | Síntese intermediária vigente | Evidência original ou de controle |
|---|---|---|
| `README.md` | análise, inventário e contagens do Passo 01 corrigido | PDF oficial e auditoria vigente do Passo 01 |
| `CONTRATO-DA-FERRAMENTA.yaml` | análise, inventário, matriz, 20 pendências e diagnóstico | PDF por operação; `DIAG-001`; comando do Passo 02 |
| `MODULOS.md` | inventário e matriz corrigida | índice, finalidades e operações no PDF |
| `DEPENDENCIAS.md` | seção 7 da análise e inventário corrigidos | campos dos requests e responses no PDF; `DIAG-011` e `DIAG-013` |
| `BIDIRECIONALIDADE.md` | matriz corrigida e inventário por operação | finalidades textuais no PDF; 66 + 24, união 90/90 |
| `PENDENCIAS.md` | seções 9, 10 e 11 da análise corrigida | lacunas, conflitos e ambiguidades no PDF; sequência `PEND-001` a `PEND-020` |
| `FONTES.md` | execução, comando, baseline vigente, diagnóstico e histórico | todos os itens acima |

## Regra de vigência

- Fonte oficial tem precedência sobre sínteses geradas.
- Somente os quatro artefatos corrigidos do Passo 01 e `AUDITORIA-ETAPA-01-POS-CORRECOES-PASSO-03.md` formam a baseline aprovada usada nesta reconstrução.
- As auditorias antigas do Passo 02 e a reprovação histórica do Passo 03 permanecem evidência, não aprovação dos canônicos atuais.
- Contagens iguais não substituem comparação semântica.
- Até nova auditoria aprovada do Passo 02 e futura reexecução aprovada do Passo 03, a prontidão global permanece `NAO_HOMOLOGADA` e o uso em ERP parceiro permanece `BLOQUEADO`.
