# Status e auditoria

## Status de etapa

- **CONCLUIDA**: etapa concluída com critérios atendidos.
- **PENDENTE**: falta informação/ajuste corrigível.
- **BLOQUEADA**: há impedimento técnico/externo.

## Auditoria obrigatória

A auditoria da V1 segue confiança zero:

- artefato produzido não é assumido como correto sem verificação;
- comparação deve incluir fonte original, comando, critérios, artefatos e estado.

Existem dois modos de auditoria:

- **NORMAL**: exige manifesto upstream aprovado e vigente, executa verificações determinísticas, analisa hashes, estrutura, consistência e o delta semântico;
- **PROFUNDA**: realiza comparação semântica ampla e independente com a fonte original.

Os gatilhos e a seleção do modo ficam em `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`. O Passo 03 é sempre profundo. Hash permite provar que a versão não mudou; não prova correção semântica.

Status histórico e vigência atual são dimensões diferentes. Uma etapa anteriormente aprovada pode ficar `INVALIDADO_POR_MUDANCA_UPSTREAM` sem que seu relatório histórico seja reescrito.

## Quality gate

Uma etapa só pode permanecer como `CONCLUIDA` quando:

- `AUDITORIA: APROVADA`

Se a auditoria reprovar:

- `AUDITORIA: REPROVADA`
- etapa deve ficar `PENDENTE`.

Se estiver bloqueada:

- `AUDITORIA: BLOQUEADA`
- etapa deve ficar `BLOQUEADA`.

## Resultado técnico e prontidão do Passo 03

O Passo 03 possui dimensões separadas:

- resultado técnico: `APTO_PARA_INTEGRACOES` ou `NAO_APTO_PARA_INTEGRACOES`;
- resultado da auditoria;
- status final da etapa;
- prontidão: `NAO_HOMOLOGADA`, `AGUARDANDO_AUDITORIA` ou `HOMOLOGADA_PARA_INTEGRACOES`.

`AGUARDANDO_AUDITORIA` é estado transitório, não status final.

| Resultado técnico | Auditoria | Status | Prontidão |
|---|---|---|---|
| `APTO_PARA_INTEGRACOES` | `APROVADA` | `CONCLUIDA` | `HOMOLOGADA_PARA_INTEGRACOES` |
| `NAO_APTO_PARA_INTEGRACOES` | `REPROVADA` | `PENDENTE` | `NAO_HOMOLOGADA` |
| qualquer | `REPROVADA` | `PENDENTE` | `NAO_HOMOLOGADA` |
| qualquer | `BLOQUEADA` | `BLOQUEADA` | `AGUARDANDO_AUDITORIA` ou `NAO_HOMOLOGADA`; nunca homologada |

Mesmo quando a validação fundamenta corretamente que o contrato não está apto, o critério de homologação não foi atendido. A auditoria reprova o gate, a etapa permanece pendente e a ferramenta não é homologada.
