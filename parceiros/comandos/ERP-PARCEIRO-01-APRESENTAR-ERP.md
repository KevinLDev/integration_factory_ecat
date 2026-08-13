# ERP Parceiro — Passo 01 — Apresentar ERP

## Finalidade

Entrar com um ERP na jornada oficial de ERP parceiro sem duplicar a resolução central de contexto e sem iniciar integração, base comercial ou desenvolvimento.

## Quando usar

Use quando houver um ERP a ser estudado para eventual integração reutilizável com uma ferramenta E-Catálogos.

## Pré-requisitos obrigatórios

- Documento operacional correspondente em `comece-aqui/integrar-erp/erp-parceiro/01-APRESENTAR-ERP.md`.
- Resolução central já criada em `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`.
- Ferramenta alvo identificada pelo operador ou pela estrutura da fábrica.

## Como chamar esta etapa — NÃO EDITE ESTE COMANDO

O operador não cria pasta, não copia modelo e não reimplementa a resolução central dentro do prompt.

Exemplo:

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-01-APRESENTAR-ERP.md

ERP:
[NOME_DO_ERP]

Ferramenta alvo:
[NOME_DA_FERRAMENTA]

Documentação do ERP:
[ANEXOS OU CAMINHOS]

Documentação da ferramenta, se houver:
[ANEXOS OU CAMINHOS]

Credenciais do ERP:
[FORNECIDAS | NAO_FORNECIDAS]

Credenciais da ferramenta:
[FORNECIDAS | NAO_FORNECIDAS]

Ambiente de homologação/teste:
[FORNECIDO | NAO_FORNECIDO]

Contexto informado pelo operador:
[ERP PARCEIRO | ERP CLIENTE | NAO_INFORMADO]

Regras adicionais:
[SE HOUVER]
```

## O que o Codex deve fazer

1. Ler a resolução central antes de qualquer decisão.
2. Identificar ERP, ferramenta alvo, contexto explícito e documentos fornecidos.
3. Verificar se a ferramenta está `HOMOLOGADA_PARA_INTEGRACOES`.
4. Verificar se o ERP existe na estrutura ou foi apenas informado para entrada.
5. Verificar se a combinação ERP x ferramenta já é conhecida ou homologada.
6. Decidir se o cenário segue ERP parceiro, ERP cliente ou nova ferramenta, sem duplicar a lógica central.
7. Registrar apenas presença de credenciais e ambiente, nunca seus valores.
8. Registrar documentos redundantes como não necessários nesta execução, sem sobrescrever homologação.
9. Preparar o espaço de execução futura apenas se houver um ERP real e contexto de parceiro compatível.
10. Não iniciar ERP real, não usar Bling como execução real, não desenvolver integração e não criar base comercial agora.

## Regras de decisão

- Ferramenta não homologada: bloquear ERP parceiro e encaminhar para nova ferramenta.
- Ferramenta homologada + ERP novo: permitir ERP parceiro.
- ERP conhecido + combinação nova: permitir ERP parceiro.
- Combinação homologada + contexto cliente: encaminhar para ERP cliente/reutilização.
- Documento redundante de ativo homologado: ignorar operacionalmente e reutilizar o contrato interno.

## Saída esperada

O retorno deve terminar com um destes estados:

```text
STATUS DA ETAPA: CONCLUIDA
STATUS DA ETAPA: PENDENTE
STATUS DA ETAPA: BLOQUEADA
```

Quando apropriado, o retorno deve mencionar:

- ferramenta encontrada ou não;
- ferramenta homologada ou não;
- ERP encontrado ou não;
- combinação homologada ou não;
- cenário resolvido;
- próxima jornada compatível;
- credenciais apenas como `FORNECIDAS` ou `NAO_FORNECIDAS`;
- se houve documento redundante e por que ele não é necessário.

## Regra futura da base comercial

Registrar como regra da jornada, mas não implementar nesta etapa:

1. analisar ERP x contrato homologado da ferramenta;
2. gerar Base Comercial de Homologação;
3. aplicar padrão determinístico de nomes, IDs, SKUs e códigos de barras;
4. respeitar os formatos aceitos pela ferramenta e pelo ERP;
5. criar ou importar a base no ERP;
6. validar a base;
7. só então liberar mapeamento e desenvolvimento.

## Critério de aceite

Conclua somente se a resolução de contexto central tiver sido aplicada e o resultado não iniciar ERP real, integração nem base comercial.
