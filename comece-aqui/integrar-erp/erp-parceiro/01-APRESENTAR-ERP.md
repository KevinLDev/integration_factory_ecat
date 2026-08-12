# 01 — Apresentar um ERP parceiro

## Quando usar

Use esta etapa quando o operador quer iniciar uma jornada de ERP parceiro com dados simples do ERP e da ferramenta alvo, sem ainda desenvolver integração.

## O que você precisa ter antes

- Nome do ERP.
- Nome da ferramenta alvo.
- Documentação oficial do ERP.
- Swagger/OpenAPI do ERP, se houver.
- Documentação da ferramenta, se houver.
- Credenciais somente se o acesso autorizado exigir.
- Indicação de ambiente de homologação ou teste, se houver.
- Regras adicionais ou contexto operacional, se houver.

## O que esta etapa faz

- consulta primeiro a resolução central de contexto;
- identifica o ERP informado;
- identifica a ferramenta alvo;
- verifica se a ferramenta já está homologada para integrações;
- verifica se o ERP ou a combinação ERP x ferramenta já existem na estrutura;
- confirma se o cenário realmente deve seguir ERP parceiro;
- registra documentação e fontes fornecidas;
- registra apenas a presença das credenciais, nunca os valores;
- registra a existência de ambiente de homologação ou teste;
- prepara o espaço de execução futura quando houver ERP real;
- deixa claro o próximo passo permitido.

Regra de credenciais desta etapa: o Passo 01 registra apenas presença de credenciais. Isso não proíbe a IA executora de receber/usar credenciais reais em etapas futuras oficialmente liberadas quando necessário e autorizado. Em qualquer etapa, valores reais não podem ser persistidos em artefatos versionados.

## O que você NÃO precisa fazer manualmente

- criar pasta de execução;
- copiar modelos;
- renomear pastas;
- criar arquivos de estado;
- mover documentos apenas para a etapa funcionar;
- decidir sozinho se o cenário é parceiro, cliente ou nova ferramenta.

## O que mandar para o chat do Codex

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-01-APRESENTAR-ERP.md

ERP informado:
[NOME_DO_ERP]

Ferramenta alvo:
[NOME_DA_FERRAMENTA]

Contexto informado pelo operador:
[ERP PARCEIRO | ERP CLIENTE | NAO_INFORMADO]

Documentação do ERP:
[CAMINHOS_OU_URLS]

Swagger/OpenAPI do ERP, se houver:
[CAMINHOS_OU_URLS]

Documentação da ferramenta, se houver:
[CAMINHOS_OU_URLS]

Credenciais do ERP:
[FORNECIDAS | NAO_FORNECIDAS]

Credenciais da ferramenta:
[FORNECIDAS | NAO_FORNECIDAS]

Ambiente de homologação/teste:
[FORNECIDO | NAO_FORNECIDO]

Regras adicionais:
[SE HOUVER]

Execute somente o Passo 01 da jornada de ERP parceiro.
Use a resolução central existente em documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md antes de qualquer decisão.
Não inicie ERP real.
Não use Bling como execução real.
Não faça análise profunda da API.
Não crie base comercial.
Não desenvolva integração.
Se a ferramenta não estiver HOMOLOGADA_PARA_INTEGRACOES, bloqueie a jornada de ERP parceiro e encaminhe para Nova Ferramenta.
Se o cenário apontar para ERP Cliente/reutilização, não siga ERP Parceiro.
Se houver documento redundante de ferramenta ou ERP já homologado, informe que o documento recebido não é necessário nesta execução e reutilize o contrato homologado interno.
Registre apenas a presença das credenciais, nunca os valores.

Nesta etapa, credencial é somente indicador de presença no retorno. Uso técnico de credencial real, quando aplicável, depende de etapa oficialmente liberada e autorização do operador.
```

### PARE DE COPIAR AQUI

Substitua todos os campos entre colchetes antes de enviar.

## Exemplo preenchido

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-01-APRESENTAR-ERP.md

ERP informado:
ERP X

Ferramenta alvo:
Força de Vendas

Contexto informado pelo operador:
ERP PARCEIRO

Documentação do ERP:
Swagger do ERP X; manual de integração; exemplos de payload

Swagger/OpenAPI do ERP, se houver:
swagger-erp-x.yaml

Documentação da ferramenta, se houver:
comece-aqui/integrar-nova-ferramenta/03-VALIDAR-FERRAMENTA-CADASTRADA.md

Credenciais do ERP:
FORNECIDAS

Credenciais da ferramenta:
NAO_FORNECIDAS

Ambiente de homologação/teste:
FORNECIDO

Regras adicionais:
Não usar produção. Não desenvolver integração.

Execute somente o Passo 01 da jornada de ERP parceiro.
Use a resolução central existente em documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md antes de qualquer decisão.
Não inicie ERP real.
Não use Bling como execução real.
Não faça análise profunda da API.
Não crie base comercial.
Não desenvolva integração.
Se a ferramenta não estiver HOMOLOGADA_PARA_INTEGRACOES, bloqueie a jornada de ERP parceiro e encaminhe para Nova Ferramenta.
Se o cenário apontar para ERP Cliente/reutilização, não siga ERP Parceiro.
Se houver documento redundante de ferramenta ou ERP já homologado, informe que o documento recebido não é necessário nesta execução e reutilize o contrato homologado interno.
Registre apenas a presença das credenciais, nunca os valores.

Nesta etapa, credencial é somente indicador de presença no retorno. Uso técnico de credencial real, quando aplicável, depende de etapa oficialmente liberada e autorização do operador.
```

## O que a IA fará

- consultará a resolução central antes de qualquer análise profunda;
- decidirá se o cenário é de ERP parceiro, ERP cliente ou nova ferramenta;
- confirmará se a ferramenta está homologada para integrações;
- identificará se o ERP ou a combinação ERP x ferramenta já existem na estrutura;
- registrará apenas presença de credenciais, ambiente e documentos;
- informará se um documento redundante foi recebido e por que ele não é necessário;
- indicará o próximo passo permitido ou o bloqueio correspondente.

## Como interpretar documentos redundantes

Se o operador enviar Swagger de uma ferramenta já homologada, a resposta deve registrar:

```text
FERRAMENTA ENCONTRADA NA ESTRUTURA
DOCUMENTO RECEBIDO: NÃO NECESSÁRIO NESTA EXECUÇÃO
```

E deve reutilizar o contrato homologado interno.

O mesmo princípio vale para ERP homologado quando aplicável.

## Regra futura da base comercial

A jornada de ERP parceiro, quando avançar para etapas posteriores, deverá preparar a base comercial de homologação antes do desenvolvimento da integração.

Sequência futura registrada, mas não implementada nesta etapa:

1. analisar ERP x contrato homologado da ferramenta;
2. gerar Base Comercial de Homologação;
3. aplicar padrão determinístico de nomes, IDs, SKUs, códigos de barras e demais chaves;
4. respeitar os formatos aceitos pela ferramenta e pelo ERP;
5. criar ou importar a base no ERP;
6. validar a base;
7. somente depois liberar mapeamento e desenvolvimento.

## Resultado esperado

O retorno deve deixar claro:

- ferramenta encontrada ou não;
- ferramenta homologada ou não;
- ERP encontrado ou não;
- combinação homologada ou não;
- cenário resolvido;
- próxima jornada compatível;
- se houve documento redundante e por que ele não é necessário;
- se as credenciais foram apenas informadas como presença.

## Critérios de aceite desta etapa

Só concluir se a etapa registrar corretamente a resolução de contexto, sem iniciar ERP real, sem análise profunda da API e sem criar base comercial.

## Próximo documento

Aguarde o próximo documento operacional da jornada de ERP parceiro.