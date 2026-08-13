# Memoria de regras de negocio das ferramentas E-Catalogos

## Proposito

Esta camada formaliza regras comerciais das ferramentas E-Catalogos como conhecimento complementar e rastreavel.

Ela nao substitui o contrato tecnico homologado nem a evidencia runtime.

## Camadas semanticas obrigatorias

### Contrato tecnico

- define o que a API expoe e aceita;
- descreve endpoints, schemas, campos e operacoes tecnicas.

### Cenario funcional

- descreve como modos e fluxos sao usados na ferramenta;
- orienta necessidades de dados e cobertura de homologacao funcional.

### Regra de negocio

- descreve restricoes, relacoes e comportamento comercial esperado;
- define quando um dado e obrigatorio em termos comerciais;
- define efeitos de visibilidade, aprovacao, exportacao e separacao comercial.

### Evidencia runtime

- registra o que foi efetivamente observado em execucao autorizada;
- e a prova operacional de comportamento real.

### Inferencia

- conclusao derivada pela Fabrica quando a fonte nao prova diretamente;
- deve permanecer marcada como inferencia ate confirmacao.

## Regra de nao equivalencia

Nunca tratar essas camadas como equivalentes.

Regras de negocio, cenarios funcionais e contrato tecnico podem convergir, mas cada afirmacao deve manter sua origem e seu nivel de evidencia.

## Autoridade e conflitos

Regra permanente:

- regras de negocio nao sobrescrevem silenciosamente o contrato tecnico.
- `FONTE_REGRA_DE_NEGOCIO` prova a regra comercial documentada, mas nao prova endpoint, schema ou comportamento runtime.
- o contrato tecnico continua sendo a autoridade sobre o que a API expoe e aceita.
- a evidencia runtime continua sendo a prova superior do que foi efetivamente executado no ambiente autorizado.

Quando houver conflito entre regra e capacidade tecnica:

- nao inventar endpoint;
- nao inventar campo;
- nao declarar compatibilidade completa sem evidencia.

Classificacao minima recomendada:

- REGRA_DOCUMENTADA
- CAPACIDADE_TECNICA_PENDENTE_DE_EVIDENCIA

## Exemplo de conflito 1

Regra documentada indica funcionalidade comercial.

Swagger nao contem endpoint equivalente.

Resultado:

- manter REGRA_DOCUMENTADA;
- registrar CAPACIDADE_TECNICA_PENDENTE_DE_EVIDENCIA;
- abrir pendencia de comprovacao tecnica.

## Exemplo de conflito 2

Fonte funcional/regra afirma que determinada parte ainda nao foi implementada no painel naquele momento.

Resultado:

- manter ressalva visivel;
- nao promover para CONFIRMADO_EM_RUNTIME;
- nao converter expectativa futura em funcionalidade atual.

## Exemplo de conflito 3

Regra de exportacao de pedido existe.

API possui rotas de pedido, mas sem prova clara de qual evento/rota representa exportacao oficial.

Resultado:

- nao inferir evento de exportacao por nome;
- registrar pendencia de correlacao evento/estado/exportacao.

## Aplicacao na jornada ERP parceiro

### Passo 02

Analisa capacidade do ERP para sustentar:

- contrato tecnico;
- cenarios funcionais;
- regras de negocio;
- evidencia runtime disponivel.

### Passo 03

Planeja cobertura de:

- campos;
- cenarios funcionais;
- regras comerciais;
- relacoes entre entidades.

O plano deve registrar as fontes efetivamente usadas, com versao ou hash somente quando disponivel, para permitir verificacao posterior de vigencia.

### Passo 04

Materializa o plano aprovado.

Nao reanalisa regras de negocio na execucao de materializacao.

Antes de escrever, compara o plano com o snapshot das fontes registrado no Passo 03. Divergencia relevante ou falta de evidencia suficiente deve resultar em `PLANO_POTENCIALMENTE_OBSOLETO`, bloqueio da materializacao e retorno para revalidacao minima do Passo 03. O Passo 04 nao corrige nem reprojeta o plano.

## Regras de rastreabilidade

Cada afirmacao relevante deve registrar:

- tipo de camada semantica;
- fonte usada;
- status de evidencia;
- impacto quando nao confirmada.

## Resultado esperado

A Fabrica passa a manter camada oficial de regras de negocio sem romper autoridade tecnica do contrato homologado e sem inventar capacidade de API.
