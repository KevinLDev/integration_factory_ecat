# AUDITORIA DA ETAPA 03 — PROJETAR HOMOLOGAÇÃO (Bling x Força de Vendas)

```text
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
TIPO DE AUDITORIA: NORMAL
```

## Identificação

- Combinação: Bling x Força de Vendas
- Etapa auditada: `03-PROJETAR-HOMOLOGACAO`
- Comando auditado: `parceiros/comandos/ERP-PARCEIRO-03-PROJETAR-HOMOLOGACAO.md`
- Artefatos técnicos auditados: `erps/bling/integracoes/forca-de-vendas/PLANO-DE-HOMOLOGACAO.md`,
  `erps/bling/integracoes/forca-de-vendas/BASE-COMERCIAL-PLANEJADA.yaml`
- Tipo: `NORMAL`
- Data: 2026-08-21

## Aviso de independência (transparência obrigatória)

**Esta auditoria NÃO é independente** — mesma ressalva dos Passos 01 e 02. Reforço adicional: esta
etapa fixa decisões de arquitetura (campos customizados como camada de complemento, materialização
manual de vendedores) que vão orientar o Passo 04 real. Recomenda-se revisão independente antes de
qualquer materialização real na conta Bling do cliente.

## Verificação de gate de entrada

| Critério | Verificação | Resultado |
|---|---|---|
| ERP identificado sem ambiguidade | Bling, slug `bling`, sem outro ERP com nome semelhante na estrutura | CONFORME |
| Ferramenta identificada sem ambiguidade | Força de Vendas, slug `forca-de-vendas` | CONFORME |
| Ferramenta com prontidão HOMOLOGADA_PARA_INTEGRACOES | Revalidado nesta auditoria: `harness.cmd manifest parceiros/execucoes/ferramentas/forca-de-vendas/manifestos/PASSO-03.yaml` | `VIGENCIA_CALCULADA: VALIDO`, `REUTILIZAVEL_COMO_GATE: TRUE` |
| Passo 02 do ERP parceiro concluído em nível suficiente | Revalidado nesta auditoria: `harness.cmd manifest parceiros/execucoes/erps/bling/manifestos/PASSO-02.yaml` | `VIGENCIA_CALCULADA: VALIDO`, `REUTILIZAVEL_COMO_GATE: TRUE` |
| Memória técnica do ERP existente | `erps/bling/ANALISE-DO-ERP.md`, `CAPACIDADES-DO-ERP.md` presentes | CONFORME |
| Análise da combinação existente | `erps/bling/integracoes/forca-de-vendas/MATRIZ-ERP-FERRAMENTA.md`, `PENDENCIAS.md` presentes | CONFORME |
| Capacidades/gaps suficientes para planejar | 26 módulos classificados na matriz, 14 pendências específicas registradas | CONFORME |

## Verificação de conteúdo (amostragem)

| Afirmação verificada | Método | Resultado |
|---|---|---|
| Soma das quantidades das 6 famílias = 200 produtos planejados | Recálculo mecânico (script Python) sobre `BASE-COMERCIAL-PLANEJADA.yaml` | Confirmado: 60+20+40+40+20+20 = 200 |
| `BASE-COMERCIAL-PLANEJADA.yaml` é JSON/YAML-compatível válido | `json.load` nesta auditoria | Confirmado, sem erro de sintaxe |
| Todo gap com adaptação está marcado como `COMPATIVEL_COM_ADAPTACAO`/`PENDENTE_DE_EVIDENCIA`, nunca como `COMPATIVEL` puro | Releitura da seção "Gaps e restrições" do plano | Confirmado — nenhuma cobertura fingida encontrada |
| `PRONTO_PARA_CRIAR_BASE_REAL: NAO` é consistente com `PENDENCIAS_BLOQUEANTES: 2` | Releitura do gate final do plano | Consistente — regra do comando ("não marcar SIM quando houver pendência bloqueante") respeitada |
| Nenhum endpoint/campo foi inventado para preencher gap | Cruzamento das adaptações propostas (campos customizados, cadastro manual no painel) contra `CAPACIDADES-DO-ERP.md` | Confirmado — toda adaptação usa capacidade real já catalogada (`CamposCustomizados`, cadastro manual no painel do Bling), nenhuma capacidade nova foi suposta |
| `REGRAS_DE_NEGOCIO_CONSIDERADAS` usa IDs reais de `REGRAS-DE-NEGOCIO.md`, sem IDs inventados | Amostragem de 10 IDs citados no plano (`RN-FDV-MAR-001`, `RN-FDV-PRE-001`, `RN-FDV-GRA-002`, `RN-FDV-ORC-004` etc.) contra o arquivo fonte | Confirmado — todos os IDs amostrados existem em `ferramentas/forca-de-vendas/REGRAS-DE-NEGOCIO.md` |

## Verificação de conformidade com o comando

| Critério do comando | Verificação | Resultado |
|---|---|---|
| Não executar operações comerciais no ERP | Nenhuma chamada HTTP foi feita nesta etapa | CONFORME |
| Não usar credenciais | Nenhuma credencial foi lida ou usada nesta etapa | CONFORME |
| Não chamar APIs externas | Confirmado | CONFORME |
| Perfil HOMOLOGACAO (não MINIMA) | Baseline de 200 produtos mantido, com desvio justificado apenas em Filiais e Regiões | CONFORME |
| Registrar desvios do baseline com motivo | Seção "Desvios do baseline" presente com 3 entradas justificadas | CONFORME |
| Gerar os dois outputs obrigatórios na pasta da combinação | `erps/bling/integracoes/forca-de-vendas/PLANO-DE-HOMOLOGACAO.md` e `BASE-COMERCIAL-PLANEJADA.yaml` | CONFORME |
| Não criar Passo 04 | Nenhum artefato de `comece-aqui/integrar-erp/erp-parceiro/04-*` foi tocado | CONFORME |
| Não alterar contrato homologado da ferramenta | `ferramentas/forca-de-vendas/*` não foi escrito | CONFORME |
| Registrar snapshot das fontes sem inventar hash/versão | Tabela de snapshot no plano usa `NAO_DISPONIVEL` explicitamente onde não recalculado, e hashes reais onde recalculado | CONFORME |

## Achados

1. O plano preserva a soberania do contrato da ferramenta: nenhuma necessidade da Força de Vendas foi
   removida para "caber" no Bling — onde o Bling não suporta nativamente, a cobertura vem de uma
   camada de complemento real (campos customizados + cadastro manual), não de redução de escopo.
2. As duas pendências bloqueantes (`GAP-001`, `GAP-003`) são reais e específicas, não genéricas —
   ambas exigem uma confirmação factual concreta antes do Passo 04, e o plano já isola exatamente quais
   20+180 produtos dependem delas.
3. `CEN-010` (conversão automática de orçamento em pedido) foi corretamente registrado como gap
   definitivo (não `PENDENTE_DE_EVIDENCIA`), pois a ausência de endpoint é uma ausência estrutural já
   confirmada na Etapa 02, não uma dúvida a esclarecer.
4. A decisão de não reaproveitar o campo fiscal `tributacao.origem` para a separação comercial
   nacional/importado (`GAP-005` do plano) é uma escolha de design defensável e explicitamente
   registrada como decisão, não como limitação — evita confundir dado fiscal com dado comercial no
   futuro Passo 06.
5. `BASE-COMERCIAL-PLANEJADA.yaml` usa amostras representativas por família em vez de enumerar os 200
   produtos individualmente; isso é aderente ao propósito de planejamento (não de materialização) e
   está declarado explicitamente em `metadata.observacoes`, não apresentado como se fosse a base
   completa.

## Gate final (conforme exigido pelo comando)

```text
ERP_IDENTIFICADO: SIM
FERRAMENTA_IDENTIFICADA: SIM
FERRAMENTA_HOMOLOGADA: SIM
PASSO_02_APTO: SIM
MEMORIA_ERP_PRESENTE: SIM
MATRIZ_PRESENTE: SIM

PLANO_DE_HOMOLOGACAO: GERADO (erps/bling/integracoes/forca-de-vendas/PLANO-DE-HOMOLOGACAO.md)
BASE_COMERCIAL_PLANEJADA: GERADA (erps/bling/integracoes/forca-de-vendas/BASE-COMERCIAL-PLANEJADA.yaml)

COBERTURA_PLANEJADA: PARCIAL_JUSTIFICADA
PENDENCIAS_BLOQUEANTES: 2
SNAPSHOT_DAS_FONTES: REGISTRADO
PRONTO_PARA_CRIAR_BASE_REAL: NAO
```

## Resultado

- AUDITORIA: APROVADA (tipo NORMAL, não independente — ver aviso acima)
- STATUS DA ETAPA: CONCLUIDA
- Próxima ação permitida: aguardar próxima etapa oficialmente publicada na jornada ERP parceiro
  (Passo 04 — Materializar Base de Homologação). Não iniciada automaticamente.
