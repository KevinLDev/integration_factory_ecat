# Estrutura do projeto

## Raiz

- `AGENTS.md`: regras globais da fábrica.
- `README.md`: visão rápida e apontamento para a entrada humana.
- `documentacao/`: explicações conceituais sobre como e por que a fábrica funciona.
- `comece-aqui/`: instruções sobre o que o operador deve fazer agora.
- `scripts/harness/`: validadores mecânicos genéricos, sem regras de negócio e sem dependências externas.

## Portas de entrada operacionais

```text
comece-aqui/
├── 00-COMECE-AQUI.md
├── integrar-nova-ferramenta/
│   ├── 00-COMECE-AQUI.md
│   ├── 01-APRESENTAR-FERRAMENTA.md
│   ├── 02-CADASTRAR-FERRAMENTA.md
│   └── 03-VALIDAR-FERRAMENTA-CADASTRADA.md
└── integrar-erp/
    ├── 00-COMECE-AQUI.md
    ├── ERPS-INTEGRADOS.md
    ├── erp-parceiro/
    │   └── 00-COMECE-AQUI.md
    └── erp-cliente/
        └── 00-COMECE-AQUI.md
```

## Trilha técnica de parceiros

- `parceiros/AGENTS.md`: regras específicas da trilha.
- `parceiros/comandos/`: comandos técnicos internos executados pelo Codex.
- `parceiros/auditorias/`: regras e comando de auditoria.
- `parceiros/execucoes/`: memória persistente de cada execução.
- `parceiros/modelos/`: modelos internos para o Codex.

Controles de continuidade e vigência:

```text
parceiros/modelos/
├── MANIFESTO-DA-ETAPA.yaml
└── CHECKPOINT-DA-EXECUCAO.yaml

parceiros/execucoes/<tipo>/<slug>/
├── ESTADO-DA-EXECUCAO.md
├── CHECKPOINT-DA-EXECUCAO.yaml     # somente quando houver tarefa transitória
└── manifestos/
    ├── PASSO-01.yaml
    ├── PASSO-02.yaml
    └── PASSO-03.yaml
```

O estado registra a situação oficial, o manifesto prova vigência por hashes e dependências, e o checkpoint permite retomar progresso transitório. Nenhum dos três substitui os demais.

## Domínio, catálogo e histórico

- `ferramentas/`: artefatos canônicos das ferramentas/produtos E-Catálogos.
- `erps/`: artefatos técnicos reais das integrações de ERP, como código, adaptadores, mapeamentos, testes e configuração reutilizável.
- `clientes/`: memória canônica da jornada ERP Cliente por cliente e combinação, sem duplicar o core técnico de `erps/`.
- `erps-integrados/`: catálogo operacional e humano das integrações de ERP homologadas; não duplica artefatos técnicos.
- `referencias-historicas/`: legado e referências históricas.
