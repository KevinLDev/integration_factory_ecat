# Catálogo de ERPs integrados

Esta pasta é o catálogo oficial, operacional e humano dos ERPs homologados pela Fábrica de Integrações.

O catálogo deve responder:

- quais ERPs estão homologados;
- com quais ferramentas E-Catálogos;
- quais módulos são suportados;
- qual é o status;
- qual versão ou configuração foi homologada;
- onde estão os artefatos técnicos correspondentes.

## Estado atual

**Nenhum ERP homologado até o momento.**

Força de Vendas não é ERP. É uma ferramenta E-Catálogos.

## Diferença entre `erps/` e `erps-integrados/`

### `erps/`

Contém os artefatos técnicos reais das integrações de ERP.

Exemplo futuro:

`erps/linx/forca-de-vendas/`

Poderá conter código, adaptadores, mapeamentos, testes, documentação técnica, contratos específicos e configuração reutilizável.

### `erps-integrados/`

Contém somente o catálogo operacional do que já foi homologado.

Não duplique código, adaptadores ou outros artefatos técnicos nesta pasta. Cada registro futuro deve apontar para os artefatos correspondentes em `erps/`.
