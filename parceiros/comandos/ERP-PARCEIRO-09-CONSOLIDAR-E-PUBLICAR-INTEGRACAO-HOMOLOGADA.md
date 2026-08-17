# ERP Parceiro - Passo 09 - Consolidar e publicar integracao homologada

## Finalidade

Transformar exatamente a baseline homologada no Passo 08 em release oficial, versionada, rastreavel e reutilizavel pela Fabrica.

O Passo 09 encerra a jornada ERP Parceiro.

## Resultado do Passo 09

O produtor prepara publicacao, mas nao se auto-publica definitivamente.

## Doutrina obrigatoria

Antes de executar, ler integralmente:

- `AGENTS.md` e `parceiros/AGENTS.md`;
- `parceiros/00-GUIA-DE-EXECUCAO.md`;
- `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md`;
- `documentacao/16-DESENVOLVIMENTO-DE-INTEGRACOES.md`;
- `documentacao/17-VALIDACAO-TECNICA-DE-INTEGRACOES-EM-HML.md`;
- `documentacao/18-HOMOLOGACAO-FUNCIONAL-DE-INTEGRACOES.md`;
- `documentacao/19-PUBLICACAO-DE-INTEGRACOES-HOMOLOGADAS.md`;
- `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`;
- documentos dos Passos 01 a 08 aplicaveis;
- modelos em `parceiros/modelos/publicacao/`;
- manifesto/checkpoint e estado vigentes da combinacao;
- catalogo operacional em `erps-integrados/README.md`.

## Gate de entrada obrigatorio

Resolver e registrar:

```text
ERP_IDENTIFICADO: SIM | NAO
FERRAMENTA_HOMOLOGADA: SIM | NAO
GATES_UPSTREAM_EXIGIDOS: ATENDIDOS | NAO_ATENDIDOS
PASSO_08_INTEGRACAO_HOMOLOGADA: SIM | NAO
PASSO_08_AUDITORIA_APROVADA: SIM | NAO
BASELINE_HOMOLOGADA_VIGENTE: SIM | NAO
VERSAO_RELEASE_CANDIDATA: DEFINIDA | NAO_DEFINIDA
```

`PASSO_08_INTEGRACAO_HOMOLOGADA: SIM` e `PASSO_08_AUDITORIA_APROVADA: SIM` sao obrigatorios.

Sem esse gate, encerrar com `STATUS DA ETAPA: BLOQUEADA`.

## Auto-descoberta obrigatoria

Antes de perguntar ao operador, descobrir automaticamente:

1. ERP, ferramenta, slugs e combinacao ativos;
2. estado, manifestos, auditorias e checkpoint;
3. resultados vigentes dos Passos 01 a 08;
4. baseline homologada e seus hashes;
5. capacidades e restricoes comprovadas por P2-P8;
6. contrato de configuracao exigido para ERP Cliente;
7. riscos de reuso (hardcodes, segredos, acoplamento);
8. estado atual do catalogo operacional.

Solicitar ao operador somente o que nao puder ser inferido com seguranca.

## Definicao operacional de publicacao

Publicar no Passo 09 significa:

- congelar baseline homologada;
- versionar release;
- consolidar capacidades e restricoes comprovadas;
- declarar contrato de configuracao;
- registrar catalogo operacional por referencia;
- produzir handoff para ERP Cliente.

Publicar no Passo 09 nao significa deploy, producao, cliente configurado, trafego real ou runtime ativo.

## Regra fundamental

```text
HOMOLOGADO == PUBLICADO
```

Se qualquer artefato homologado divergir da baseline:

```text
INTEGRACAO_PUBLICADA: NAO
```

e retornar ao menor passo responsavel.

## Versionamento

SemVer adaptado a release homologada:

```text
MAJOR.MINOR.PATCH
```

Regras minimas:

- primeira publicacao: `1.0.0`;
- `PATCH`: ajuste compativel;
- `MINOR`: nova capacidade compativel;
- `MAJOR`: breaking change.

SemVer nao pula validacao. Mudanca executavel, semantica ou funcional exige nova candidata e retorno aos passos necessarios antes de publicar.

Release publicada e imutavel.

## Consolidacao de capacidades

Consolidar somente capacidades comprovadas por P2-P8 usando apenas:

- `SUPORTADO`;
- `SUPORTADO_COM_RESTRICAO`;
- `NAO_SUPORTADO`;
- `NAO_APLICAVEL`.

`PARCIAL_JUSTIFICADO` e proibido no catalogo de capacidades publicadas.

Cada capacidade deve registrar quando aplicavel:

- direcao;
- restricoes;
- pre-condicoes;
- dependencias;
- referencia ao escopo homologado.

## Contrato de configuracao

Declarar requisitos de configuracao para ERP Cliente sem valores reais.

Separar:

- `CONFIGURACAO_REUTILIZAVEL`;
- `CONFIGURACAO_DO_CLIENTE`.

Segredos devem ser declarados como requisito, por exemplo `SECRET_REQUIRED`, nunca com valor real.

## Reutilizacao e seguranca

Bloquear hardcodes indevidos de:

- CNPJ, empresa e cliente especifico;
- IDs HML/teste/Base Mestra em configuracao reutilizavel;
- filial, vendedor e tabela de teste;
- localhost e URL local;
- senha, token, refresh token, API key, cookie e sessao.

IDs historicos podem existir em evidencias de homologacao, nao no pacote reutilizavel da release.

## Fonte de verdade

Fonte tecnica canonica:

```text
erps/<erp-slug>/integracoes/<ferramenta-slug>/
```

Controle de execucao e auditoria:

```text
parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/
```

Catalogo humano/operacional:

```text
erps-integrados/
```

Nao transformar `erps-integrados/` em segunda fonte tecnica.

## Idempotencia de publicacao

Se mesma combinacao + mesma baseline + mesma versao ja estiver publicada:

- nao duplicar catalogo;
- nao gerar nova versao;
- nao reescrever release;
- retornar `JA_PUBLICADA` com integridade confirmada.

## Lifecycle minimo

Preparar metadado simples:

- `ATIVA`;
- `DEPRECATED`;
- `RETIRADA`.

Nao implementar motor de lifecycle.

## Failure routing minimo

Classificacoes oficiais do Passo 09:

- `ARTEFATO_HOMOLOGADO_DIVERGENTE` -> menor passo responsavel;
- `BASELINE_08_INVALIDO` -> passo responsavel pela invalidacao;
- `CAPACIDADE_PUBLICADA_NAO_COMPROVADA` -> Passo 02, 05, 07 ou 08 conforme causa;
- `HARDCODE_CLIENTE_DETECTADO` -> Passo 06 se implementacao, Passo 09 se pacote declarativo;
- `SEGREDO_PERSISTIDO` -> bloqueio imediato e menor responsavel;
- `CATALOGO_INCONSISTENTE` -> Passo 09;
- `PACOTE_PUBLICACAO_INCOMPLETO` -> Passo 09.

O Passo 09 nao corrige silenciosamente upstream.

## Outputs de uma execucao real

Na fonte tecnica da combinacao:

```text
erps/<erp-slug>/integracoes/<ferramenta-slug>/MANIFESTO-DA-INTEGRACAO-PUBLICADA.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/CONTRATO-DE-CONFIGURACAO-DA-RELEASE.yaml
erps/<erp-slug>/integracoes/<ferramenta-slug>/RELATORIO-DE-PUBLICACAO.md
```

Nos controles Harness, quando aplicavel:

```text
parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/manifestos/PASSO-09.yaml
parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/CHECKPOINT-DA-EXECUCAO.yaml
```

No catalogo operacional:

```text
erps-integrados/
```

com ponteiros para a fonte tecnica canonica.

## Gate da execucao produtora

```text
BASELINE_HOMOLOGADA_INTEGRA: SIM | NAO
VERSAO_RELEASE_DEFINIDA: SIM | NAO
CAPACIDADES_CONSOLIDADAS: SIM | NAO
CONTRATO_CONFIGURACAO_DEFINIDO: SIM | NAO
REUTILIZAVEL: SIM | NAO
SEGREDOS_EMBUTIDOS: NAO
IDS_HML_INDEVIDOS: NAO
DADOS_CLIENTE_EMBUTIDOS: NAO
CATALOGO_OPERACIONAL_ATUALIZADO: SIM | NAO
PUBLICACAO_PREPARADA: SIM | NAO
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS DA ETAPA: PENDENTE | BLOQUEADA
INTEGRACAO_HOMOLOGADA: SIM
INTEGRACAO_PUBLICADA: NAO
DISPONIVEL_PARA_CLIENTE: NAO
EM_PRODUCAO: NAO
```

## Promocao pos-auditoria independente

Somente apos auditoria aprovada:

```text
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
INTEGRACAO_HOMOLOGADA: SIM
INTEGRACAO_PUBLICADA: SIM
DISPONIVEL_PARA_CLIENTE: SIM
EM_PRODUCAO: NAO
```

## Fronteiras proibidas

- nao criar Passo 10;
- nao publicar combinacao real nesta materializacao;
- nao configurar cliente real;
- nao executar producao;
- nao executar deploy/runtime/monitoramento definitivo;
- nao implementar orquestrador executavel;
- nao criar registry, npm package, docker ou infraestrutura de runtime.

## Como chamar

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-09-CONSOLIDAR-E-PUBLICAR-INTEGRACAO-HOMOLOGADA.md

Continue a jornada ERP parceiro da combinacao ja identificada e execute somente o Passo 09.

Confirme obrigatoriamente:
- PASSO_08_INTEGRACAO_HOMOLOGADA: SIM
- PASSO_08_AUDITORIA_APROVADA: SIM

Congele baseline homologada exata.
Nao permita publicar artefato diferente do homologado.

Use SemVer para release homologada sem pular validacao.

Consolide capacidades somente com:
SUPORTADO
SUPORTADO_COM_RESTRICAO
NAO_SUPORTADO
NAO_APLICAVEL

Nao use PARCIAL_JUSTIFICADO.

Gere:
- MANIFESTO-DA-INTEGRACAO-PUBLICADA.yaml
- CONTRATO-DE-CONFIGURACAO-DA-RELEASE.yaml
- RELATORIO-DE-PUBLICACAO.md
- manifesto/checkpoint genericos do Harness quando aplicaveis

Atualize o catalogo operacional por referencia sem criar segunda fonte tecnica.

Nao execute homologacao funcional novamente.
Nao altere codigo, mapeamento ou transformacao silenciosamente.
Nao use cliente real.
Nao execute producao.
Nao implemente deploy/runtime/orquestrador.

Finalize como execucao produtora do Passo 09 com:
PUBLICACAO_PREPARADA: SIM | NAO
AUDITORIA: AGUARDANDO_INDEPENDENTE
STATUS DA ETAPA: PENDENTE | BLOQUEADA
INTEGRACAO_HOMOLOGADA: SIM
INTEGRACAO_PUBLICADA: NAO
DISPONIVEL_PARA_CLIENTE: NAO
EM_PRODUCAO: NAO

Nao execute auditoria aprovadora nesta mesma execucao.
Nao faca commit.
Nao faca push.
```

### PARE DE COPIAR AQUI
