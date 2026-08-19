# Modelo - Relatorio de validacao HML e preparacao para producao do cliente

> Modelo global do ERP Cliente - Passo 05.

## Regras de uso

- validar somente a instancia deste cliente; nao re-homologar a integracao generica ERP x ferramenta;
- nao materializar nem corrigir configuracao -- achados retornam ao Passo 04 (materializacao) ou ao Passo 03 (projeto);
- nao usar automacao de navegador, observer realtime ou monitoramento de eventos de interface em tempo real;
- nao usar producao;
- nao persistir segredo;
- `PARCIALMENTE_APROVADO` proibido como status de cenario;
- a execucao produtora nunca se autoaprova -- encerra com `AUDITORIA: AGUARDANDO_INDEPENDENTE`.

# Identificacao

| Campo | Valor |
|---|---|
| Cliente | `<nome>` |
| Cliente slug | `<slug>` |
| ERP | `<nome>` |
| ERP slug | `<slug>` |
| Ferramenta | `<nome>` |
| Ferramenta slug | `<slug>` |
| Combinacao | `<erp-slug>--<ferramenta-slug>` |
| Versao release | `<versao-ou-NA>` |

# Gate de entrada

```text
PASSO_04_CONCLUIDO: SIM | NAO
AUDITORIA_PASSO_04: APROVADA | NAO_APROVADA
PRONTO_PARA_VALIDACAO_HML: SIM | NAO
PLANO_E_MATERIALIZACAO_VIGENTES: SIM | NAO | EVIDENCIA_INSUFICIENTE
OPERADOR_HUMANO_DISPONIVEL: SIM | NAO
```

# Resumo da validacao

| Item | Valor |
|---|---|
| Validacao tecnica HML (cliente) | `APROVADA \| PARCIAL_JUSTIFICADA \| REPROVADA \| BLOQUEADA` |
| Criterios de aceite atendidos | `SIM \| PARCIAL \| NAO` |
| Homologacao funcional (cliente) | `APROVADA \| REPROVADA \| BLOQUEADA` |
| Cenarios criticos reprovados/pendentes | `<quantidade>` |
| Cenarios altos reprovados | `<quantidade>` |
| Escrita em producao | `NAO` |
| Segredo persistido | `NAO` |

# Cenarios

| ID | Capacidade | Area funcional | Criticidade | Ator | Status | Classificacao da falha | Menor passo responsavel |
|---|---|---|---|---|---|---|---|
| `<scenario_id>` | `<capacidade>` | `<area>` | `CRITICO \| ALTO \| MEDIO \| BAIXO` | `<perfil>` | `APROVADO \| REPROVADO \| BLOQUEADO \| NAO_APLICAVEL \| PENDENTE \| PENDENTE_DE_EVIDENCIA` | `<classificacao-ou-NENHUMA>` | `<passo-ou-NA>` |

## Roteiro por cenario

```text
CENARIO: <scenario_id>
PRE-CONDICOES: <lista>
FACA: <passo a passo>
OBSERVE: <campos e comportamentos>
CONFIRME: <resultado no destino, quando aplicavel>
EVIDENCIA SOLICITADA: <screenshot/IDs/horario/descricao>
```

## Retorno manual registrado

```text
CENARIO: <scenario_id>
EXECUTADO: SIM | NAO
RESULTADO_OBSERVADO: <texto>
IDS: ferramenta=<id> ; erp=<id>
EVIDENCIAS: <lista>
OBSERVACOES: <texto>
```

# Politica de criticidade aplicada

> Qualquer cenario `CRITICO` com status `REPROVADO`, `PENDENTE`, `PENDENTE_DE_EVIDENCIA` ou `BLOQUEADO` impede `PRONTO_PARA_PRODUCAO: SIM`. Para cenarios `ALTO`, o limite e zero reprovado. Nao homologar por percentual.

# Pendencias

## Bloqueantes

- `<pendencia-bloqueante-ou-NA>`

## Nao bloqueantes

- `<pendencia-nao-bloqueante-ou-NA>`

# Auditoria independente exigida

```text
TIPO_EXIGIDO: PROFUNDA
MOTIVO: Primeira validacao real desta combinacao de cliente
RESULTADO: AGUARDANDO_INDEPENDENTE
```

# Seguranca

- segredo persistido: `NAO`;
- escrita em producao: `NAO`.

# Status final da execucao produtora

```text
VALIDACAO_TECNICA_HML_CLIENTE: APROVADA | PARCIAL_JUSTIFICADA | REPROVADA | BLOQUEADA
HOMOLOGACAO_FUNCIONAL_CLIENTE: APROVADA | REPROVADA | BLOQUEADA
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS_DA_ETAPA: PENDENTE
PRONTO_PARA_PRODUCAO: NAO
PROXIMO_PASSO: AUDITORIA_INDEPENDENTE_PASSO_05
```

> Somente a auditoria independente `PROFUNDA` aprovada pode promover `AUDITORIA: APROVADA`, `STATUS_DA_ETAPA: CONCLUIDA` e `PRONTO_PARA_PRODUCAO: SIM`.
