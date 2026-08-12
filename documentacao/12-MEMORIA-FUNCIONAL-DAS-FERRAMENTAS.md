# Memoria funcional das ferramentas E-Catalogos

## Proposito

Esta regra oficial define a camada de memoria funcional das ferramentas E-Catalogos.

Ela complementa o conhecimento tecnico ja existente e nao substitui o contrato tecnico homologado da ferramenta.

## Escopo

Toda ferramenta E-Catalogos pode acumular conhecimento por fonte tecnica, funcional e runtime autorizado.

Fontes aceitas:

- Swagger/OpenAPI;
- documentacao tecnica;
- PDF;
- video;
- screenshot;
- tutorial;
- regra fornecida pelo operador;
- evidencia runtime autorizada.

A Fabrica deve identificar a ferramenta informada pelo operador e registrar o conhecimento no contexto correto da ferramenta.

Exemplos de destinos por ferramenta:

- `ferramentas/forca-de-vendas/`
- `ferramentas/b2b/`
- `ferramentas/lojas/`

Regra de isolamento:

- nunca misturar conhecimento funcional de ferramentas diferentes.

## Modelo de autoridade das fontes

Classificacao obrigatoria:

- FONTE_TECNICA: prova API, contrato, operacao e schema.
- FONTE_FUNCIONAL: prova uso, fluxo, experiencia e cenario.
- EVIDENCIA_RUNTIME: prova comportamento tecnico observado em execucao autorizada.
- INFERENCIA: hipotese ainda nao comprovada por fonte tecnica/funcional/runtime.

A classificacao deve ser preservada nos artefatos da ferramenta.

## Tipo da afirmacao semantica

Além da classificacao da fonte, cada afirmacao funcional deve indicar, quando aplicavel, o tipo semantico da afirmacao produzida:

- OBSERVADO_NA_FONTE_FUNCIONAL: comportamento diretamente sustentado por video/manual/screenshot/tutorial.
- DERIVADO_PELA_FABRICA: conclusao tecnica ou necessidade de dados inferida a partir do comportamento observado, sem declarar observacao literal da fonte.
- REQUISITO_DE_HOMOLOGACAO: cenario que a Fabrica define para prova futura de cobertura funcional.
- INFERENCIA: hipotese ainda nao confirmada.

Regra de consistencia:

- derivacao ou requisito de homologacao nao podem ser apresentados como fato observado;
- o tipo da afirmacao nao substitui a classificacao da fonte (FONTE_TECNICA, FONTE_FUNCIONAL, EVIDENCIA_RUNTIME, INFERENCIA).

Exemplo de limite:

- um video de uso com codigo de barras nao autoriza inventar endpoint tecnico como `GET /barcode` sem prova tecnica.

## Relacao entre memoria funcional e contrato tecnico

O contrato homologado da ferramenta continua autoridade tecnica.

Artefatos funcionais, como `CENARIOS-FUNCIONAIS.md`, sao complementares e nao autorizam alteracao silenciosa de contrato.

Nao alterar automaticamente, por observacao visual isolada:

- `CONTRATO-DA-FERRAMENTA.yaml`
- `MODULOS.md`
- `BIDIRECIONALIDADE.md`
- `DEPENDENCIAS.md`

Se uma fonte funcional sugerir possivel divergencia tecnica:

- registrar pendencia para avaliacao futura;
- manter rastreabilidade da fonte que originou a pendencia;
- nao alterar contrato sem processo explicito.

## Regra funcionalidade nao equivale a endpoint

Funcionalidade da ferramenta e capacidade de API do ERP sao camadas diferentes.

Regra central:

`FUNCIONALIDADE_DA_FERRAMENTA != ENDPOINT_DE_MESMO_NOME_NO_ERP`

Uma experiencia funcional da ferramenta exige que o ERP forneca dados/capacidades necessarias, e nao um endpoint com nome identico ao modo funcional.

## Cobertura funcional por modo

Quando existir memoria funcional da ferramenta, a analise de combinacao ERP x ferramenta deve registrar cobertura funcional por modo/cenario usando, no minimo:

- MODO
- DADOS_NECESSARIOS
- CAPACIDADES_DISPONIVEIS_NO_ERP
- CAPACIDADES_FALTANTES
- IMPACTO
- EVIDENCIA

Estados conceituais de impacto:

- BLOQUEIA_MODO
- DEGRADA_MODO
- NAO_IMPACTA_MODO
- PENDENTE_DE_EVIDENCIA

Ausencia de capacidade para um modo especifico nao bloqueia automaticamente toda a integracao.

## Ferramentas futuras

A regra e generica e reutilizavel.

Se o operador iniciar uma nova ferramenta (por exemplo, B2B ou Lojas), a Fabrica deve registrar o conhecimento funcional apenas no diretorio da ferramenta corretamente resolvida, sem pre-criacao de ferramentas fora da execucao atual.

## Rastreabilidade minima

Cada bloco funcional registrado deve apontar as fontes usadas com nivel suficiente para auditoria conceitual.

Quando o material for binario (video, imagem, captura), nao e obrigatorio copiar o arquivo para o Git nesta camada; e suficiente registrar referencia conceitual rastreavel (nome da fonte, contexto, data quando disponivel).