# Referências históricas

Esta área guarda implementações anteriores que ajudam a entender problemas reais já enfrentados pela E-Catálogos.

## Regra principal

**Referência histórica não é arquitetura oficial da Fábrica de Integrações.**

Flows/steps antigos podem ser analisados para extrair regras, cenários, erros recorrentes e requisitos, mas não devem ser copiados automaticamente como padrão estrutural.

## Primeiro conjunto previsto

```text
referencias-historicas/
└── bling-forca-pipedream/
```

Os flows antigos entre Bling e Força podem ensinar sobre clientes, produtos, variantes, SKUs, packs, estoque, pedidos, status, pagamento, retry, rate limit, correlação e estorno.

Toda regra encontrada apenas no legado deve ser validada contra documentação/API atual ou evidência real antes de virar regra oficial da fábrica.
