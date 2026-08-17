# Memoria canonica de clientes

Esta pasta e reservada para memoria oficial da jornada ERP Cliente.

## Regra

- Nao duplicar codigo, mapeamento generico ou artefatos tecnicos da release publicada.
- Referenciar a fonte canonica em `erps/<erp-slug>/integracoes/<ferramenta-slug>/`.
- Persistir somente contexto, inventario, decisoes, configuracao sem segredo e evidencias da instalacao do cliente.

## Estrutura alvo por combinacao

```text
clientes/<cliente-slug>/integracoes/<erp-slug>--<ferramenta-slug>/
```

Exemplos de artefatos do Passo 01:

- `CONTEXTO-DO-CLIENTE.yaml`
- `INVENTARIO-DE-MATERIAIS.yaml`
- `RELATORIO-DE-RESOLUCAO-DE-CONTEXTO.md`

## Seguranca

- Nao persistir secrets reais.
- Nao persistir tokens, senhas, API keys ou cookies.
- Registrar apenas presenca/requisito de credencial quando aplicavel.