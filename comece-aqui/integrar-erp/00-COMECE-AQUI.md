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

A jornada ERP parceiro possui os Passos 01 a 09 disponiveis, conforme `comece-aqui/integrar-erp/erp-parceiro/00-COMECE-AQUI.md`. O Passo 06 termina em `PRONTO_PARA_EXECUCAO_HML`; o Passo 07 executa e valida tecnicamente em HML; o Passo 08 executa homologacao funcional manual assistida por IA e pode levar a `INTEGRACAO_HOMOLOGADA: SIM` somente apos auditoria independente aprovada; o Passo 09 consolida e publica a integracao homologada e pode levar a `INTEGRACAO_PUBLICADA: SIM` e `DISPONIVEL_PARA_CLIENTE: SIM` somente apos auditoria independente aprovada. A jornada ERP cliente possui os Passos 01 a 06 liberados, roteiro completo; o Passo 03 somente projeta a instalacao, o Passo 04 materializa em HML o que foi projetado, o Passo 05 valida essa materializacao e o Passo 06 executa o go-live em producao e registra a memoria de fechamento -- nenhum dos tres (04, 05, 06) se autoaprova.
