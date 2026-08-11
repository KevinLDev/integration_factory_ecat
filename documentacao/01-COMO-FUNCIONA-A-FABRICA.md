# Como funciona a Fábrica de Integrações

## Componentes principais

1. **Regras globais**: `AGENTS.md`.
2. **Portas de entrada humanas**: `comece-aqui/`.
3. **Regras da trilha de parceiros**: `parceiros/AGENTS.md`.
4. **Comandos técnicos por etapa**: `parceiros/comandos/`.
5. **Auditoria obrigatória**: `parceiros/auditorias/`.
6. **Execuções persistentes**: `parceiros/execucoes/`.
7. **Artefatos técnicos de ERP**: `erps/`.
8. **Catálogo de ERPs homologados**: `erps-integrados/`.

## Papel do Harness

O Harness organiza o trabalho em jornadas e etapas com regras, critérios de aceite, estado persistente, validação e auditoria.

As jornadas têm responsabilidades diferentes:

- ferramenta E-Catálogos define, prepara e homologa tecnicamente o contrato canônico para integrações;
- ERP parceiro produz integração reutilizável;
- ERP cliente reutiliza integração homologada e registra particularidades do cliente.

## Papel do Codex

O operador escolhe sua jornada em `comece-aqui/00-COMECE-AQUI.md` e fornece contexto e documentação. Quando houver etapa liberada, o Codex executa o comando interno correspondente, cria a estrutura necessária, mantém o estado e produz os artefatos.

## O que não muda

- não inventar endpoint, regra ou campo;
- não misturar as jornadas;
- não executar etapa sem documento operacional homologado;
- não depender da memória do chat;
- só avançar quando a etapa estiver concluída e auditada.
