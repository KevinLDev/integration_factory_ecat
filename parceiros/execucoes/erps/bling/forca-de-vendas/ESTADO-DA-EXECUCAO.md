# ESTADO-DA-EXECUCAO — Combinação Bling x Força de Vendas

- ERP: Bling
- Ferramenta: Força de Vendas
- Etapa atual: 04-MATERIALIZAR-BASE-HOMOLOGACAO
- Status da etapa atual: PENDENTE (materialização parcial, justificada — ver abaixo)
- Tipo de auditoria desta etapa: NORMAL (não independente — ver
  `DIAGNOSTICO-CORRECAO-GOVERNANCA-20260821.md` sobre por que independência não é exigida aqui)
- Etapas concluídas vigentes (jornada ERP parceiro, combinação Bling x Força de Vendas):
  01-APRESENTAR-ERP (nível ERP, em `parceiros/execucoes/erps/bling/`); 02-ANALISAR-ERP;
  03-PROJETAR-HOMOLOGACAO (nível combinação)
- Etapa em andamento: 04-MATERIALIZAR-BASE-HOMOLOGACAO (nível combinação, parcial)

## Execução atual do Passo 04 (2026-08-21)

```text
AMBIENTE_AUTORIZADO: SIM
PLANO_VALIDO: SIM
VIGENCIA_DO_PLANO: VIGENTE
BASE_MESTRA: CRIADA
MATERIALIZACAO: PARCIAL_JUSTIFICADA
RECONSULTA: APROVADA
CORRELACOES: VALIDAS
DEPENDENCIAS: VALIDAS
COBERTURA_CRIADA_NO_ERP: PARCIAL_JUSTIFICADA
FALHAS_BLOQUEANTES: 0
PRONTO_PARA_VALIDACAO_NA_FERRAMENTA: NAO
```

## Resumo técnico do Passo 04 (estado atual, parcial)

- Ambiente: conta Bling do ERP parceiro (eCatalogos, app_id 386879), tratada como `DEV_AUTORIZADO` por
  decisão explícita do operador — Bling não expõe base URL de sandbox separada.
- **Materializado e confirmado por reconsulta real (49 registros):**
  - 14 campos customizados (12 em Produtos, 2 em Contatos) — cobre Marca, Cor, Gênero, Campanha, Linha,
    Tipo Comercial, Disponibilidade, Prazo de Entrega, Origem Comercial, 3 Tabelas de Preço, Papel
    Comercial do Vendedor, Região do Cliente.
  - 10 categorias + 25 subcategorias, com vínculo `categoriaPai` correto.
- **Achado empírico importante:** `Vendedores` não pode ser criado via API — testado criando um
  `Contato` com `tiposContato=[Vendedor]`; não apareceu em `GET /vendedores`. Confirma
  `PEND-BLING-FDV-008` com evidência real, não apenas inferência de schema.
- **Ainda não materializado nesta rodada:** 200 produtos, variações/SKUs, 20 clientes, preços,
  estoques, pedidos, vendedores reais (estes últimos exigem cadastro manual no painel do Bling pelo
  operador, fora do alcance de automação por API).

## Correção de governança aplicada em 2026-08-21

Durante a preparação deste Passo 04, foi assumido por engano que a regra do `AGENTS.md` Seção 3
("Passos 04, 05, 06 exigem auditoria independente PROFUNDA, nenhuma se autoaprova") se aplicava a esta
etapa. Releitura literal confirmou que essa regra é escopada à jornada **ERP CLIENTE** (materializar em
HML / validar HML / go-live) e, na jornada ERP PARCEIRO, à independência exigida apenas nos Passos 08 e
09. O Passo 04 do ERP PARCEIRO admite autoauditoria `NORMAL` divulgada, mesmo padrão dos Passos 01-03.
Detalhe completo: `DIAGNOSTICO-CORRECAO-GOVERNANCA-20260821.md`. Isso não invalidou nenhum trabalho
técnico já realizado — apenas corrigiu o texto explicativo sobre o motivo de `STATUS DA ETAPA` seguir
`PENDENTE` (que é: materialização parcial, não bloqueio de auditoria).

## Relatórios vigentes do Passo 04

- Base Mestra materializada: `erps/bling/homologacao/BASE-MESTRA-MATERIALIZADA.yaml`
- Relatório de materialização: `erps/bling/integracoes/forca-de-vendas/RELATORIO-DE-MATERIALIZACAO.md`
- Auditoria vigente: `auditorias/AUDITORIA-ETAPA-04.md` (`AUDITORIA: APROVADA`, tipo `NORMAL`, não
  independente — aprova o que foi executado nesta rodada parcial, não uma conclusão da etapa)
- Diagnóstico de correção de governança: `DIAGNOSTICO-CORRECAO-GOVERNANCA-20260821.md`
- Evidências brutas (sem segredos): `evidencias/passo04-log-campos-customizados-20260821.json`,
  `evidencias/passo04-log-categorias-20260821.json`,
  `evidencias/passo04-evidencia-teste-vendedor-20260821.json`
- Manifesto: `parceiros/execucoes/erps/bling/manifestos/PASSO-04.yaml`
  (`VIGENCIA_CALCULADA: VALIDO`; `REUTILIZAVEL_COMO_GATE: FALSE` — esperado, porque
  `resultado.status` é `PENDENTE`, não `CONCLUIDA`, até a materialização avançar)

## Pendências abertas do Passo 04

| ID | Descrição | Bloqueia o quê |
|---|---|---|
| P04-001 | Vendedores/Representantes/Prepostos reais exigem cadastro manual no painel do Bling (API confirmada como não suficiente) | Vínculo cliente-vendedor; requer ação do operador humano |
| P04-002 | Produtos (200), variações/SKUs, clientes (20), preços, estoques e pedidos (100) ainda não materializados | `MATERIALIZACAO: COMPLETA`; continuação em rodada futura |

## Histórico — Passo 03 (projeção de homologação, concluído em 2026-08-21)

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

- Estratégia: base comercial materializada **dentro do próprio Bling** — conta do ambiente de ERP
  parceiro (E-Catálogos), não de cliente futuro. `CamposCustomizados` é a camada de complemento para
  tudo que o Bling não modela nativamente.
- 200 produtos planejados em 6 famílias (60+20+40+40+20+20), sem redução do contrato da ferramenta.
- 12 cenários planejados; 11 com cobertura viável, 1 gap definitivo e permanente (conversão automática
  de orçamento em pedido — `GAP-002`, sem endpoint no Bling).
- Duas correções aplicadas em 2026-08-21: `DIAGNOSTICO-CORRECAO-20260821.md` (documental) e
  `DIAGNOSTICO-CORRECAO-RUNTIME-20260821.md` (runtime — rotação de `refresh_token` confirmada; Filiais
  `NAO_APLICAVEL` para esta conta).
- Auditoria vigente: `auditorias/AUDITORIA-ETAPA-03-REVALIDACAO-RUNTIME-20260821.md` (`APROVADA`,
  `NORMAL`, não independente). Nota: a frase final desse arquivo sobre exigência de auditoria
  independente PROFUNDA para o Passo 04 está superada — ver `DIAGNOSTICO-CORRECAO-GOVERNANCA-20260821.md`.
- Manifesto: `parceiros/execucoes/erps/bling/manifestos/PASSO-03.yaml`
  (`REUTILIZAVEL_COMO_GATE: TRUE`, validado com `harness.cmd manifest`)

## Histórico — Passo 02 (análise do ERP, revalidado em 2026-08-21)

- 26 módulos comparados; 8 `COMPATIVEL_COM_ADAPTACAO`, 5 `PARCIAL`, 9 `NAO_SUPORTADO`,
  1 `PENDENTE_DE_EVIDENCIA` (Linhas, `PEND-BLING-FDV-007`), 1 `N/A` (Autenticação).
- Auditoria vigente: `auditorias/AUDITORIA-ETAPA-02-REVALIDACAO-RUNTIME-20260821.md` (`APROVADA`).

## Restrições operacionais mantidas

- Nenhuma integração foi desenvolvida (Passo 05+ não iniciado).
- Escritas comerciais reais no Bling: apenas campos customizados e categorias/subcategorias — nenhum
  produto, cliente, vendedor real ou pedido foi criado ainda.
- Nenhum valor de credencial foi persistido em artefato versionado.
- O contrato homologado da Força de Vendas não foi alterado.

## Próxima etapa permitida

- Continuar a materialização do Passo 04 (produtos/clientes/pedidos) em rodada futura, ou
- `05-PROJETAR-INTEGRACAO-E-MAPEAMENTO` (`parceiros/comandos/ERP-PARCEIRO-05-PROJETAR-INTEGRACAO-E-MAPEAMENTO.md`)
  com o escopo atual, a critério do operador.
- Nenhuma das duas se autoexecuta; aguarda instrução explícita do operador.
