# Diagnóstico de correção — leitura de governança do Passo 04 (Bling x Força de Vendas)

```text
TIPO: CORRECAO_DE_INTERPRETACAO_DE_GOVERNANCA
NAO_INVALIDA_TRABALHO_TECNICO: SIM
```

## O que estava errado

Durante a preparação do Passo 04 (Materializar Base de Homologação) desta combinação, assumi que a
regra do `AGENTS.md` Seção 3 — "a primeira execução real de cada combinação (Passos 04, 05 e 06) exige
auditoria independente PROFUNDA e nenhuma das três se autoaprova" — se aplicava ao **Passo 04 da
jornada ERP PARCEIRO** (a etapa em execução aqui). Essa suposição foi registrada, sem verificação
literal do texto completo, em:

- `erps/bling/homologacao/BASE-MESTRA-MATERIALIZADA.yaml` (campo `metadata.observacoes`, texto original:
  "STATUS DA ETAPA permanece PENDENTE ate auditoria independente PROFUNDA, conforme AGENTS.md Secao 3
  (primeira execucao real da combinacao nao se autoaprova)");
- `erps/bling/integracoes/forca-de-vendas/RELATORIO-DE-MATERIALIZACAO.md` (resumo executivo e critérios
  para próxima etapa, mesma alegação);
- `parceiros/execucoes/erps/bling/forca-de-vendas/auditorias/AUDITORIA-ETAPA-03-REVALIDACAO-RUNTIME-20260821.md`,
  linha final: "lembrando que a primeira execução real desta combinação exige auditoria independente
  **PROFUNDA** (`AGENTS.md` Seção 3), diferente do padrão `NORMAL` usado até aqui" — este arquivo é um
  registro histórico de auditoria já `APROVADA`/`CONCLUIDA` e **não foi reescrito**, por regra do
  `AGENTS.md` Seção 11.1 (não apagar nem reescrever relatórios históricos). Esta observação presente
  aqui serve para deixar o registro público de que aquela frase final está superada.

## Releitura literal do `AGENTS.md` Seção 3

Trecho completo (grifo nas partes relevantes):

> "...os Passos 01 a 09 da jornada de ERP parceiro... estao disponiveis para operacao. O Passo 07
> executa e valida tecnicamente em HML; o Passo 08 homologa funcionalmente...; o Passo 09 consolida e
> publica a integracao homologada... **A homologacao da combinacao so pode registrar
> `INTEGRACAO_HOMOLOGADA: SIM` apos auditoria independente aprovada do Passo 08. A publicacao... apos
> auditoria independente aprovada do Passo 09.** Na jornada de ERP cliente, o Passo 01 resolve
> contexto/elegibilidade... o Passo 04 materializa em HML o que o Passo 03 projetou, o Passo 05 valida
> tecnica e funcionalmente essa materializacao e o Passo 06 executa o go-live em producao... **A
> primeira execucao real de cada combinacao (Passos 04, 05 e 06) exige auditoria independente PROFUNDA
> e nenhuma das tres se autoaprova.**"

A frase sobre "Passos 04, 05 e 06" aparece gramaticalmente encaixada dentro do parágrafo que descreve a
**jornada de ERP CLIENTE**, não a jornada de ERP PARCEIRO. Confirmação cruzada em
`comece-aqui/integrar-erp/erp-parceiro/00-COMECE-AQUI.md`:

> "O Passo 08 homologa funcionalmente... e pode levar a `INTEGRACAO_HOMOLOGADA: SIM` somente apos
> auditoria independente aprovada. O Passo 09 consolida e publica... e pode levar a
> `INTEGRACAO_PUBLICADA: SIM`... somente apos auditoria independente aprovada."

Nenhuma menção a exigência de auditoria independente aparece nesse documento para os Passos 01 a 07 da
jornada ERP PARCEIRO. Também não há qualquer menção a "audit", "independente" ou "PROFUNDA" em
`parceiros/comandos/ERP-PARCEIRO-04-MATERIALIZAR-BASE-HOMOLOGACAO.md` nem em
`comece-aqui/integrar-erp/erp-parceiro/04-MATERIALIZAR-BASE-HOMOLOGACAO.md` (busca literal, zero
ocorrências).

## Conclusão

Para a jornada **ERP PARCEIRO** (a jornada desta execução):

| Etapa | Exige auditoria independente? |
|---|---|
| Passos 01-07 | NÃO — autoauditoria `NORMAL`, divulgada como não independente, é o padrão já usado e validado nos Passos 01, 02 e 03 |
| Passo 08 (homologação funcional) | SIM — obrigatória para `INTEGRACAO_HOMOLOGADA: SIM` |
| Passo 09 (publicação) | SIM — obrigatória para `INTEGRACAO_PUBLICADA: SIM` / `DISPONIVEL_PARA_CLIENTE: SIM` |

A regra "Passos 04, 05, 06 exigem auditoria independente PROFUNDA, nenhuma se autoaprova" pertence à
jornada **ERP CLIENTE** (materializar em HML / validar HML / go-live em produção), uma jornada distinta
que ainda não foi iniciada para esta combinação.

**Isso não invalida nenhum trabalho técnico já realizado no Passo 04** — os 14 campos customizados e as
35 categorias/subcategorias continuam reais, criados e reconsulta-confirmados; o achado sobre
Vendedores não-criáveis via API continua válido. O único ajuste é de **processo**: este Passo 04 admite
autoauditoria `NORMAL` divulgada, no mesmo padrão dos Passos 01-03, em vez de ficar bloqueado esperando
uma auditoria independente que a regra nunca exigiu para esta etapa.

`STATUS DA ETAPA` continua `PENDENTE` nesta rodada — não por exigência de auditoria independente, mas
porque `MATERIALIZACAO: PARCIAL_JUSTIFICADA` (produtos, clientes, vendedores reais e pedidos ainda não
materializados; ver `P04-001` e `P04-002` no relatório de materialização).

## Artefatos corrigidos nesta rodada (edição direta, ainda não auditados/fechados)

- `erps/bling/homologacao/BASE-MESTRA-MATERIALIZADA.yaml`
- `erps/bling/integracoes/forca-de-vendas/RELATORIO-DE-MATERIALIZACAO.md`

## Artefato histórico não alterado (registro de superação apenas)

- `parceiros/execucoes/erps/bling/forca-de-vendas/auditorias/AUDITORIA-ETAPA-03-REVALIDACAO-RUNTIME-20260821.md`
  — texto original preservado; a frase final sobre exigência de auditoria independente PROFUNDA para o
  Passo 04 desta combinação está superada por este diagnóstico.
