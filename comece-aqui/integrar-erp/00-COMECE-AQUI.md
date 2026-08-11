# Integrar ERP

Existem duas jornadas de ERP diferentes. Escolha de acordo com o objetivo real.

Antes de qualquer análise profunda de documentos fornecidos pelo operador, a Fábrica deve consultar a camada central de resolução de contexto:

`documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`

Essa regra central resolve se o cenário pertence à jornada de ERP parceiro, à jornada de ERP cliente ou se o operador está trazendo documentação redundante de algo já homologado.

## ERP parceiro

Use quando queremos adicionar um ERP ao portfólio de integrações da E-Catálogos.

A ferramenta E-Catálogos alvo precisa estar previamente homologada para integrações pelo Passo 03 da jornada de ferramenta.

Se a ferramenta alvo ainda não estiver homologada, a resolução central deve redirecionar primeiro para a jornada de nova ferramenta.

```text
ERP parceiro
      ↕
adaptador homologado
      ↕
ferramenta E-Catálogos
```

Entrada da jornada:

`comece-aqui/integrar-erp/erp-parceiro/00-COMECE-AQUI.md`

## ERP cliente

Use quando um cliente real utiliza um ERP e precisa usar uma integração compatível com uma ferramenta E-Catálogos.

A jornada de cliente deve preferencialmente reutilizar uma integração de ERP já homologada.

Se a combinação ERP x ferramenta já estiver homologada, a jornada de cliente deve reutilizar essa integração em vez de reconstruí-la.

Entrada da jornada:

`comece-aqui/integrar-erp/erp-cliente/00-COMECE-AQUI.md`

## Não confunda

```text
integrar ERP parceiro
≠
configurar o ERP de um cliente
```

As duas jornadas estão descritas para orientação, mas ainda não possuem passos operacionais liberados.
