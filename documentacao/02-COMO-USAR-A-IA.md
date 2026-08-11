# Como usar a IA na Fábrica (Codex no VS Code)

## Regra prática

Use sempre o Codex dentro do workspace da fábrica.

## Fluxo simples

1. Abra `comece-aqui/00-COMECE-AQUI.md`.
2. Escolha entre nova ferramenta, ERP parceiro ou ERP cliente.
3. Confirme que a jornada possui um passo operacional liberado.
4. Envie o prompt delimitado no documento operacional da etapa.
5. O Codex executa somente o comando técnico correspondente.
6. O Codex atualiza estado e artefatos no repositório.
7. Você decide a continuação com base no status e na auditoria.

## O que enviar ao Codex

- os nomes pedidos pelo documento operacional;
- o objetivo;
- a documentação oficial;
- os dados adicionais que você já conhece.

## O que não fazer

- não pedir “faça uma integração” sem escolher uma jornada e uma etapa liberada;
- não criar pastas manuais para “ajudar” o comando;
- não editar manualmente arquivos internos de execução;
- não usar uma jornada de cliente para criar silenciosamente uma integração de ERP ainda não homologada.

## Resultado esperado por etapa

Cada etapa termina com um status formal:

- `CONCLUIDA`;
- `PENDENTE`;
- `BLOQUEADA`.
