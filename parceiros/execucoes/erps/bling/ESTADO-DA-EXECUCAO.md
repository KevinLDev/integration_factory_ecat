# ESTADO-DA-EXECUCAO — Bling (ERP parceiro)

- ERP: Bling
- Ferramenta alvo: Força de Vendas
- Etapa atual: 04-MATERIALIZAR-BASE-HOMOLOGACAO
- Status da etapa atual: PENDENTE (materialização parcial, justificada)
- Tipo de auditoria desta etapa: NORMAL (não independente — independência só é exigida nos Passos 08/09
  desta jornada, ver `parceiros/execucoes/erps/bling/forca-de-vendas/DIAGNOSTICO-CORRECAO-GOVERNANCA-20260821.md`)
- Etapas concluídas vigentes: 01-APRESENTAR-ERP; 02-ANALISAR-ERP; 03-PROJETAR-HOMOLOGACAO (nível
  combinação Bling x Força de Vendas, evidência em `parceiros/execucoes/erps/bling/forca-de-vendas/`)
- Etapa em andamento (parcial): 04-MATERIALIZAR-BASE-HOMOLOGACAO — ver
  `parceiros/execucoes/erps/bling/forca-de-vendas/ESTADO-DA-EXECUCAO.md` para o detalhe completo
- Jornada: ERP parceiro (`INTEGRAR_ERP_PARCEIRO`)

## Execução atual do Passo 03

```text
ERP_IDENTIFICADO: SIM
FERRAMENTA_HOMOLOGADA: SIM
PASSO_02_APTO: SIM
PLANO_DE_HOMOLOGACAO: GERADO
BASE_COMERCIAL_PLANEJADA: GERADA
COBERTURA_PLANEJADA: PARCIAL_JUSTIFICADA
PENDENCIAS_BLOQUEANTES: 0
SNAPSHOT_DAS_FONTES: REGISTRADO
PRONTO_PARA_CRIAR_BASE_REAL: SIM
```

- Estratégia: base comercial materializada dentro do Bling (conta do próprio ERP parceiro, não de
  cliente) via `CamposCustomizados` (camada de complemento) + cadastro manual de vendedores no painel;
  200 produtos em 6 famílias; 12 cenários planejados (11 viáveis, 1 gap definitivo e permanente).
- **Duas correções aplicadas em 2026-08-21**: (1) documental — terminologia "conta do cliente" →
  "conta do ERP parceiro"; `ProdutosEstruturas` confirmado por schema para grade fechada
  (`DIAGNOSTICO-CORRECAO-20260821.md`); (2) runtime, a pedido do operador — chamada real confirmou
  rotação de `refresh_token` e que a conta tem 1 depósito/0 canais de venda, resolvendo a pendência de
  Filiais como `NAO_APLICAVEL` para esta homologação (`DIAGNOSTICO-CORRECAO-RUNTIME-20260821.md`).
  `PENDENCIAS_BLOQUEANTES` 2→1→**0**.
- Relatórios vigentes: `erps/bling/integracoes/forca-de-vendas/PLANO-DE-HOMOLOGACAO.md`,
  `BASE-COMERCIAL-PLANEJADA.yaml`; auditoria vigente em
  `parceiros/execucoes/erps/bling/forca-de-vendas/auditorias/AUDITORIA-ETAPA-03-REVALIDACAO-RUNTIME-20260821.md`;
  manifesto em `parceiros/execucoes/erps/bling/manifestos/PASSO-03.yaml`.

## Execução atual do Passo 04 (parcial, 2026-08-21)

```text
AMBIENTE_AUTORIZADO: SIM
MATERIALIZACAO: PARCIAL_JUSTIFICADA
RECONSULTA: APROVADA
COBERTURA_CRIADA_NO_ERP: PARCIAL_JUSTIFICADA
FALHAS_BLOQUEANTES: 0
PRONTO_PARA_VALIDACAO_NA_FERRAMENTA: NAO
```

- Materializado e reconsulta-confirmado: 14 campos customizados + 10 categorias + 25 subcategorias
  (49 registros reais no Bling).
- Achado empírico: `Vendedores` não pode ser criado via API (confirma `PEND-BLING-FDV-008`).
- Ainda falta: 200 produtos, variações, 20 clientes, preços, estoques, pedidos, vendedores reais
  (cadastro manual pelo operador).
- Detalhe completo: `parceiros/execucoes/erps/bling/forca-de-vendas/ESTADO-DA-EXECUCAO.md`,
  `erps/bling/integracoes/forca-de-vendas/RELATORIO-DE-MATERIALIZACAO.md`.
- Manifesto: `parceiros/execucoes/erps/bling/manifestos/PASSO-04.yaml`
  (`VIGENCIA_CALCULADA: VALIDO`; `REUTILIZAVEL_COMO_GATE: FALSE` até a materialização avançar).

## Histórico — Passo 02 (análise do ERP)

- ERP_ANALISADO: SIM
- COMPARACAO_COM_FERRAMENTA: CONCLUIDA
- CAPACIDADES_IDENTIFICADAS: SIM
- GAPS_IDENTIFICADOS: SIM (9/26 módulos `NAO_SUPORTADO`; 1/26 `PENDENTE_DE_EVIDENCIA` restante — Linhas)
- PENDENCIAS_BLOQUEANTES: SIM (bloqueavam decisões do Passo 03; todas resolvidas em 2026-08-21)
- PRONTO_PARA_PROXIMA_ETAPA_OFICIAL: SIM
- Achado crítico: Marca, Região e Tabela de Preço não têm recurso de API dedicado no Bling (verificado
  mecanicamente) — impacta diretamente o modelo comercial territorial da Força de Vendas.
- Relatórios vigentes do Passo 02 (revalidado em 2026-08-21, documental + runtime):
  - `erps/bling/ANALISE-DO-ERP.md` (corrigido), `erps/bling/CAPACIDADES-DO-ERP.md` (corrigido),
    `erps/bling/FONTES.md`
  - `erps/bling/integracoes/forca-de-vendas/MATRIZ-ERP-FERRAMENTA.md` (corrigido)
  - `erps/bling/integracoes/forca-de-vendas/PENDENCIAS.md` (corrigido — `PEND-BLING-FDV-006` e `012`
    resolvidas com evidência de runtime; 12 de 14 seguem abertas)
  - `parceiros/execucoes/erps/bling/forca-de-vendas/DADOS-DA-EXECUCAO.md`,
    `parceiros/execucoes/erps/bling/forca-de-vendas/ESTADO-DA-EXECUCAO.md`
  - Auditoria vigente do Passo 02: `parceiros/execucoes/erps/bling/forca-de-vendas/auditorias/AUDITORIA-ETAPA-02-REVALIDACAO-RUNTIME-20260821.md`
    (`AUDITORIA: APROVADA`, tipo `NORMAL`, não independente); auditorias anteriores preservadas como
    histórico
  - Manifesto vigente: `parceiros/execucoes/erps/bling/manifestos/PASSO-02.yaml`
    (`REUTILIZAVEL_COMO_GATE: TRUE`, validado com `harness.cmd manifest`)

## Histórico — Passo 01 (resolução de contexto)

- Ferramenta encontrada: SIM (Força de Vendas)
- Ferramenta homologada para integrações: SIM (`PRONTIDAO: HOMOLOGADA_PARA_INTEGRACOES`, revalidado
  novamente nesta sessão via `parceiros/execucoes/ferramentas/forca-de-vendas/manifestos/PASSO-03.yaml`)
- ERP encontrado na estrutura (antes do Passo 01): NAO — Bling era ERP novo para a fábrica
- Cenário resolvido: **ERP PARCEIRO** (Cenário B da resolução central: ferramenta homologada + ERP novo)
- Credenciais do ERP: FORNECIDAS (somente presença registrada; valores nunca persistidos)
- Credenciais da ferramenta: NAO_FORNECIDAS
- Ambiente de homologação/teste dedicado: NAO_FORNECIDO (existe apenas acesso de produção real de uma
  conta Bling do operador, usado em teste técnico pontual fora desta jornada)
- Relatórios vigentes do Passo 01: `parceiros/execucoes/erps/bling/DADOS-DA-EXECUCAO.md`;
  auditoria em `parceiros/execucoes/erps/bling/auditorias/AUDITORIA-ETAPA-01.md`
  (`AUDITORIA: APROVADA`, tipo `NORMAL`, não independente); manifesto em
  `parceiros/execucoes/erps/bling/manifestos/PASSO-01.yaml`.
- Nota técnica relacionada (fora da jornada, teste de autenticação):
  `analises/notas-tecnicas/2026-08-20-bling-conflito-processo-oficial.md`

## Pendências do Passo 01 — situação após o Passo 02

1. ~~Persistir a documentação oficial (OpenAPI/Swagger da Bling API v3) em
   `parceiros/execucoes/erps/bling/referencias/documentacao-oficial/`~~ — **RESOLVIDA**: arquivo real
   localizado no ambiente do operador e persistido nesta execução (ver `erps/bling/FONTES.md`).
2. ~~Investigar e corrigir/confirmar a codificação de caracteres (mojibake)~~ — **RESOLVIDA**: o arquivo
   fonte real está corretamente em UTF-8; o mojibake era exclusivo da colagem no chat (ver
   `erps/bling/FONTES.md`).
3. Buscar/confirmar material da integração histórica Pipedream Bling ↔ Força de Vendas — **AINDA
   ABERTA**; `referencias-historicas/bling-forca-pipedream/` continua não populada. Não bloqueou o
   Passo 02 (a análise documental não depende dela), mas pode ser valiosa para o Passo 03/05.
4. ~~Iniciar o mapeamento ERP x contrato homologado da ferramenta~~ — **FEITO** nesta execução do
   Passo 02 (nível módulo; ver `PEND-BLING-FDV-014` para o que ainda falta em profundidade).

## Restrições operacionais mantidas

- Base Comercial parcialmente criada **no ERP real**: apenas campos customizados e
  categorias/subcategorias; produtos/clientes/pedidos ainda não.
- Nenhuma integração foi desenvolvida (Passo 05+ não iniciado).
- O contrato homologado da Força de Vendas não foi alterado.
- Nenhum valor de credencial foi persistido em artefato versionado.

## Próxima etapa permitida

- Continuar a materialização do Passo 04 (produtos/clientes/pedidos) em rodada futura, reaproveitando
  os 49 registros já criados (idempotência: não recriar), ou
- `05-PROJETAR-INTEGRACAO-E-MAPEAMENTO`
  (`parceiros/comandos/ERP-PARCEIRO-05-PROJETAR-INTEGRACAO-E-MAPEAMENTO.md`) com o escopo atual, a
  critério do operador.
- Nenhuma das duas se autoexecuta; aguarda instrução explícita do operador. O Passo 04 desta jornada
  **não** exige auditoria independente PROFUNDA — essa exigência (`AGENTS.md` Seção 3) é escopada à
  jornada ERP CLIENTE e aos Passos 08/09 desta própria jornada (ver
  `parceiros/execucoes/erps/bling/forca-de-vendas/DIAGNOSTICO-CORRECAO-GOVERNANCA-20260821.md`).
