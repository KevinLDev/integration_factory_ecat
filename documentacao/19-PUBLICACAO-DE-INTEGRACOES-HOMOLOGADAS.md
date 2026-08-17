# 19 - Publicacao de integracoes homologadas

## 1. Objetivo

Este documento define o padrao global do ERP Parceiro - Passo 09 - Consolidar e Publicar Integracao Homologada.

Sequencia oficial vigente:

```text
PASSO 01 -> identifica o ERP
PASSO 02 -> comprova capacidades do ERP
PASSO 03 -> projeta homologacao e base
PASSO 04 -> materializa Base de Homologacao
PASSO 05 -> projeta mapeamento semantico
PASSO 06 -> desenvolve e testa localmente
PASSO 07 -> executa e valida tecnicamente em HML
PASSO 08 -> homologa funcionalmente o uso da ferramenta
PASSO 09 -> consolida e publica a integracao homologada
```

O Passo 09 encerra a jornada ERP Parceiro.

## 2. O que significa publicar

Publicar significa:

- congelar baseline homologada do Passo 08;
- criar identidade e versionamento da release;
- consolidar capacidades e restricoes comprovadas;
- declarar contrato de configuracao da release;
- comprovar reutilizacao sem acoplamento de cliente;
- registrar a release no catalogo operacional;
- preparar handoff para a jornada ERP Cliente.

Publicar nao significa:

- deploy;
- producao;
- cliente configurado;
- trafego real;
- sincronizacao de cliente;
- runtime ativo.

## 3. Fronteira obrigatoria entre Passo 08 e Passo 09

Passo 08:

- valida funcionalmente com execucao manual assistida por IA;
- produz evidencias funcionais;
- depende de auditoria independente para registrar `INTEGRACAO_HOMOLOGADA: SIM`.

Passo 09:

- nao executa nova homologacao funcional;
- nao redesenvolve integracao;
- nao altera silenciosamente codigo, mapeamento ou regras;
- consolida, versiona e publica exatamente o baseline homologado.

## 4. Regra fundamental de baseline

Regra obrigatoria:

```text
HOMOLOGADO == PUBLICADO
```

A release so pode ser publicada se todos os artefatos homologados no Passo 08 permanecerem identicos segundo a politica de hash vigente.

Se qualquer artefato homologado divergir:

```text
INTEGRACAO_PUBLICADA: NAO
```

E a execucao deve retornar ao menor passo responsavel.

## 5. Baseline homologado minimo

Para publicar, a release deve rastrear no minimo:

- commit/hash da implementacao vigente;
- hashes de `MAPEAMENTO-SEMANTICO.yaml`;
- hashes de `REGRAS-DE-TRANSFORMACAO.yaml`;
- hash de `PLANO-DA-INTEGRACAO.md`;
- manifesto vigente do Passo 08;
- relatorio de homologacao funcional;
- auditoria independente vigente do Passo 08;
- contrato vigente da ferramenta;
- referencias ERP aplicaveis.

A politica de hash e vigencia deve reutilizar os mecanismos ja definidos no Harness.

## 6. Versionamento da release

O Passo 09 usa SemVer adaptado a release homologada:

```text
MAJOR.MINOR.PATCH
```

Regras minimas:

- primeira publicacao: `1.0.0`;
- `PATCH`: ajuste compativel sem quebra de contrato de configuracao;
- `MINOR`: nova capacidade compativel comprovada;
- `MAJOR`: breaking change funcional, semantica ou de configuracao.

SemVer nao autoriza pular validacao. Qualquer mudanca executavel, semantica ou funcional gera nova candidata, com retorno aos passos necessarios antes do Passo 09.

Release publicada e imutavel.

## 7. Capacidades publicadas

O Passo 09 consolida somente capacidades comprovadas por P2-P8.

Status permitidos:

- `SUPORTADO`;
- `SUPORTADO_COM_RESTRICAO`;
- `NAO_SUPORTADO`;
- `NAO_APLICAVEL`.

`PARCIAL_JUSTIFICADO` nao e permitido no catalogo de capacidades publicadas. Quando parcial, usar `SUPORTADO_COM_RESTRICAO` com restricoes explicitas.

Cada capacidade deve declarar, quando aplicavel:

- direcao;
- restricoes;
- pre-condicoes;
- dependencias;
- referencia ao escopo homologado.

## 8. Contrato de configuracao da release

A release deve declarar requisitos da futura jornada ERP Cliente sem valores reais.

Exemplos de requisitos:

- credenciais ERP;
- credenciais ferramenta;
- tenant e empresa;
- filial;
- tabela de preco;
- vendedor ou preposto;
- feature flags;
- webhook;
- de-paras autorizados;
- parametros obrigatorios e opcionais.

Separar explicitamente:

- `CONFIGURACAO_REUTILIZAVEL`;
- `CONFIGURACAO_DO_CLIENTE`.

## 9. Reutilizacao e acoplamento proibido

A release deve ser reutilizavel por multiplos clientes da mesma combinacao ERP x ferramenta.

Bloquear hardcodes indevidos de:

- CNPJ;
- empresa ou cliente especifico;
- IDs HML;
- filial, vendedor e tabela de teste;
- IDs da Base Mestra como configuracao permanente;
- localhost ou URL local;
- token, senha, API key e outros segredos.

IDs historicos podem permanecer somente em evidencia de homologacao, nunca na configuracao reutilizavel da release.

## 10. Politica de segredos

Segredo real na release e proibido.

Permitido:

```text
ERP_API_TOKEN: SECRET_REQUIRED
```

Proibido:

```text
ERP_API_TOKEN: <valor real>
```

Validar tambem ausencia de `Authorization`, refresh token, API key, senha, cookie e sessao.

## 11. Fonte de verdade e catalogo

Fonte tecnica canonica da integracao:

```text
erps/<erp-slug>/integracoes/<ferramenta-slug>/
```

Artefatos de execucao e auditoria:

```text
parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/
```

`erps-integrados/` e catalogo humano/operacional e nao pode virar segunda fonte tecnica.

## 12. Semantica produtora e pos-auditoria

A execucao produtora do Passo 09 nao se auto-publica definitivamente.

Gate da execucao produtora:

```text
PUBLICACAO_PREPARADA: SIM | NAO
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS DA ETAPA: PENDENTE | BLOQUEADA
INTEGRACAO_HOMOLOGADA: SIM
INTEGRACAO_PUBLICADA: NAO
DISPONIVEL_PARA_CLIENTE: NAO
EM_PRODUCAO: NAO
```

Somente apos auditoria independente aprovada:

```text
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
INTEGRACAO_HOMOLOGADA: SIM
INTEGRACAO_PUBLICADA: SIM
DISPONIVEL_PARA_CLIENTE: SIM
EM_PRODUCAO: NAO
```

## 13. Handoff para ERP Cliente

O Passo 09 entrega, no minimo:

- ERP, ferramenta, slug e versao publicada;
- capacidades e restricoes;
- contrato de configuracao;
- requisitos de credenciais;
- parametros obrigatorios e opcionais;
- compatibilidade;
- baseline homologado e referencias tecnicas.

A jornada ERP Cliente nao deve reexecutar P1-P9.

## 14. Resolucao central

Comportamento esperado do resolvedor:

- combinacao `PUBLICADA` -> encaminhar para ERP Cliente;
- combinacao `HOMOLOGADA` no Passo 08 e nao publicada -> encaminhar para Passo 09;
- combinacao ainda nao homologada -> manter ERP Parceiro no menor passo necessario.

## 15. Idempotencia de publicacao

Se a mesma combinacao, baseline e versao ja estiver publicada, o Passo 09 deve:

- nao duplicar catalogo;
- nao gerar nova versao;
- nao reescrever release;
- retornar `JA_PUBLICADA` com integridade confirmada.

## 16. Alteracoes apos publicacao e lifecycle

Release publicada e imutavel. Mudancas posteriores exigem nova versao candidata e retorno ao menor passo responsavel.

Metadados minimos de lifecycle:

- `ATIVA`;
- `DEPRECATED`;
- `RETIRADA`.

O Passo 09 nao cria motor de lifecycle, automacao de migracao, scheduler ou runtime.

## 17. Failure routing minimo

Classificacoes obrigatorias do Passo 09:

- `ARTEFATO_HOMOLOGADO_DIVERGENTE`;
- `BASELINE_08_INVALIDO`;
- `CAPACIDADE_PUBLICADA_NAO_COMPROVADA`;
- `HARDCODE_CLIENTE_DETECTADO`;
- `SEGREDO_PERSISTIDO`;
- `CATALOGO_INCONSISTENTE`;
- `PACOTE_PUBLICACAO_INCOMPLETO`.

Cada classificacao deve apontar o menor passo responsavel sem corrigir silenciosamente upstream no Passo 09.

## 18. Harness no Passo 09

O Harness pode validar mecanicamente:

- existencia e estrutura de arquivos;
- manifesto e hashes;
- baseline e versao;
- referencias internas;
- capacidades e contrato de configuracao;
- statuses e gates;
- consistencia de catalogo;
- padroes de segredo e hardcode indevido.

O Harness nao prova comportamento funcional da integracao. Isso permanece responsabilidade de P7 e P8.
