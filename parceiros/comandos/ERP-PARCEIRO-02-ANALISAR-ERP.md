# ERP Parceiro — Passo 02 — Analisar ERP contra contrato homologado da ferramenta

## Finalidade

Executar a analise tecnica profunda do ERP apresentado no Passo 01 contra o contrato homologado interno da ferramenta E-Catalogos selecionada.

Esta etapa prepara decisao tecnica confiavel para as proximas etapas oficiais, sem iniciar Base Comercial, desenvolvimento ou homologacao final.

## Quando usar

Use quando o contexto ja foi resolvido para ERP parceiro e o Passo 01 da mesma execucao ja terminou.

## Gate de entrada obrigatorio

Antes de qualquer analise, validar e registrar:

1. Passo 01 da execucao ERP parceiro concluido.
2. Ferramenta alvo com `HOMOLOGADA_PARA_INTEGRACOES`.
3. Contexto resolvido como ERP parceiro (nao ERP cliente).
4. Documentacao oficial do ERP suficiente para analise.

Se algum requisito falhar:

- `STATUS DA ETAPA: BLOQUEADA` quando a etapa nao pode prosseguir com seguranca.
- `STATUS DA ETAPA: PENDENTE` quando falta informacao recuperavel pelo operador.

Nao inventar capacidades para forcar conclusao.

## Auto-descoberta obrigatoria do contexto

Antes de pedir novos dados ao operador, descobrir automaticamente na estrutura da execucao:

- ERP apresentado no Passo 01;
- ferramenta alvo;
- contexto resolvido;
- documentos e Swagger ja fornecidos;
- execucao ativa;
- estado do Passo 01;
- gate de homologacao da ferramenta.

Solicitar ao operador somente dados realmente faltantes apos essa leitura.

## Como o operador chama a etapa

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-02-ANALISAR-ERP.md

Analise o ERP apresentado no Passo 01 contra a ferramenta selecionada.
Use os documentos e Swagger ja fornecidos na execucao.

Se faltar algum dado obrigatorio apos auto-descoberta, solicite somente o faltante.

Campos opcionais (fallback, se necessario):
ERP informado: <NOME_DO_ERP>
Ferramenta alvo: <NOME_DA_FERRAMENTA>
Contexto informado: <ERP PARCEIRO | ERP CLIENTE | NAO_INFORMADO>
Documentacao do ERP: <CAMINHOS_OU_URLS>
Swagger/OpenAPI: <CAMINHOS_OU_URLS>
Regras adicionais: <SE HOUVER>

Execute somente o Passo 02 da jornada ERP parceiro.
Nao crie Base Comercial.
Nao desenvolva integracao.
Nao inicie Passo 03.
```

## Fontes permitidas e autoridade

1. Contrato homologado interno da ferramenta alvo (autoridade canonica).
2. Documentacao oficial do ERP (Swagger/OpenAPI/arquivos oficiais).
3. Evidencias da execucao existente do Passo 01.
4. Regras adicionais fornecidas pelo operador.

Regra: o ERP se adapta ao contrato da ferramenta. Nunca alterar contrato homologado para facilitar o ERP.

## Camadas da etapa

Esta etapa possui duas camadas:

1. Analise documental (obrigatoria): Swagger/OpenAPI, documentacao oficial e arquivos fornecidos.
2. Validacao tecnica controlada (quando houver credenciais e autorizacao): confirmar comportamento real da API sem escrita comercial.

## Escopo tecnico da analise

### 1) Autenticacao

Quando houver evidencia, registrar:

- mecanismo, endpoint, credenciais requeridas;
- token, refresh, expiracao, headers, scopes;
- diferencas por ambiente.

Quando houver credenciais e autorizacao em execucao real, validar autenticacao em runtime e registrar sem expor segredo:

- AUTENTICACAO: SUCESSO | FALHOU_NO_TESTE
- TOKEN: OBTIDO | NAO_OBTIDO
- REFRESH: SUPORTADO | NAO_SUPORTADO | PENDENTE_DE_EVIDENCIA

### 2) Ambientes

Registrar producao/homologacao/sandbox/teste, URLs e diferencas conhecidas.

### 3) Modulos e recursos

Cobrir os modulos relevantes ao contrato da ferramenta, por exemplo:

- produtos, variacoes, categorias, marcas;
- clientes, representantes/vendedores;
- tabelas de preco, precos;
- estoque, filiais, condicoes de pagamento;
- pedidos e status;
- outros modulos necessarios ao contrato.

Nao presumir modulo ausente nem presente sem evidencia.

### 4) Endpoints por capacidade

Para cada capacidade relevante, registrar quando disponivel:

- metodo, rota, finalidade;
- parametros e filtros;
- paginacao;
- body de entrada;
- resposta de saida;
- IDs/chaves/codigos externos;
- operacoes realmente suportadas.

### 5) Schemas e campos

Registrar campos obrigatorios/opcionais, tipos, enums, formatos, chaves, relacionamentos e restricoes, sempre com evidencia.

### 6) Limites

Registrar rate limit, paginação, tamanhos maximos, limites de campo, timeout, restricoes de leitura/escrita e restricoes por ambiente quando houver evidencia.

### 7) Eventos

Quando aplicavel: webhook, callback, eventos e necessidade de polling.

### 8) Dependencias

Registrar dependencias sustentadas pelas fontes (ex.: marca antes de produto), sem inventar ordem nao comprovada.

## Politica de validacao tecnica controlada

Quando houver credenciais e autorizacao:

- permitido por padrao: autenticacao/token, refresh, GET, HEAD, OPTIONS e operacoes explicitamente nao mutaveis;
- POST somente para autenticacao/token ou operacao comprovadamente sem efeito comercial;
- bloqueado nesta etapa: criacao/alteracao/exclusao comercial (POST/PUT/PATCH/DELETE com efeito real de negocio).

Operacao documentada de escrita pode ser registrada como capacidade, mas nao deve ser executada no Passo 02.

## Modelo de capacidades e direcoes

Para cada modulo/capacidade relevante, classificar suporte do ERP em:

- LER
- CRIAR
- ATUALIZAR
- EXCLUIR
- EVENTO/WEBHOOK (quando houver)

Depois classificar direcao possivel frente ao contrato da ferramenta:

- ERP -> FERRAMENTA
- FERRAMENTA -> ERP
- BIDIRECIONAL
- SOMENTE LEITURA
- NAO_SUPORTADO
- PENDENTE_DE_EVIDENCIA

Direcao so pode ser marcada quando houver operacoes reais que a sustentem.

## Matriz ERP x Ferramenta

Produzir comparacao explicita com colunas equivalentes a:

- MODULO
- CAPACIDADE_EXIGIDA_PELA_FERRAMENTA
- CAPACIDADE_DISPONIVEL_NO_ERP
- DIRECAO_POSSIVEL
- COMPATIBILIDADE
- GAP
- EVIDENCIA_FONTE

Status recomendados de compatibilidade:

- COMPATIVEL
- COMPATIVEL_COM_ADAPTACAO
- PARCIAL
- NAO_SUPORTADO
- PENDENTE_DE_EVIDENCIA

## Evidencia por capacidade/rota

Para cada capacidade/rota relevante, registrar:

- DOCUMENTADO: SIM/NAO
- TESTADO: SIM/NAO
- HTTP_STATUS: <codigo ou NA>
- RESULTADO: <estado>
- EVIDENCIA_FONTE: <referencia>

Estados de resultado:

- CONFIRMADO_EM_RUNTIME
- CONFIRMADO_POR_DOCUMENTACAO
- DIVERGENTE
- FALHOU_NO_TESTE
- PENDENTE_DE_EVIDENCIA
- NAO_SUPORTADO

Regras:

- `NAO_SUPORTADO` exige evidencia suficiente de ausencia real.
- Ausencia no Swagger, sozinha, implica `PENDENTE_DE_EVIDENCIA`.
- Se rota documentada falhar em teste (ex.: 401), registrar `FALHOU_NO_TESTE` e abrir pendencia (token/scope/permissao/ambiente/documentacao).
- Se documentacao e runtime divergirem, registrar `DIVERGENTE` com as duas evidencias preservadas.

## Adaptacoes

Registrar necessidade de adaptacao sem implementar:

- diferenca de nomes de campos;
- diferenca de IDs/chaves;
- enums/status divergentes;
- formatos de data/hora;
- modelos de paginacao;
- SKU/variacao;
- estoque por filial;
- preco por tabela;
- PF/PJ.

## Pendencias

Toda lacuna sem evidencia deve virar pendencia explicita, com impacto e fonte faltante.

## Politica de credenciais

Em execucao real futura desta etapa:

- receber/usar credencial autorizada = permitido;
- reproduzir/persistir secret = proibido.

Preferir variaveis de ambiente, secret store ou arquivo local ignorado pelo Git.

Se usar arquivo local para secret, confirmar antes com mecanismo equivalente a `git check-ignore`.

Nunca registrar valor real de secret em markdown, yaml/json versionado, manifesto, checkpoint, auditoria, relatorio, commit, mensagem de commit ou retorno final.

Se houver suporte a refresh, registrar conceitualmente:

- REFRESH_DOCUMENTADO
- REFRESH_TESTADO
- REFRESH_ENDPOINT
- EXPIRACAO
- REFRESH_TOKEN_ROTACIONA
- RESULTADO

O Passo 02 nao implementa servico permanente de renovacao de token; isso pertence a futura camada de runtime/servidor.

## Saidas minimas esperadas de uma execucao real

Como conjunto minimo da etapa, a execucao real deve produzir artefatos equivalentes a:

- ANALISE-DO-ERP.md
- CAPACIDADES-DO-ERP.md
- MATRIZ-ERP-FERRAMENTA.md
- PENDENCIAS.md
- FONTES.md

Esses artefatos devem separar claramente fato, fonte, inferencia e pendencia.

Evitar duplicacao de analise entre os cinco artefatos.

Falhas de rota nao impedem a producao dos artefatos; devem ser registradas com estado/evidencia e pendencia quando aplicavel.

## Gate de saida da etapa

Responder explicitamente:

- ERP_ANALISADO: SIM/NAO
- COMPARACAO_COM_FERRAMENTA: CONCLUIDA/PENDENTE/BLOQUEADA
- CAPACIDADES_IDENTIFICADAS: SIM/NAO
- GAPS_IDENTIFICADOS: SIM/NAO
- PENDENCIAS_BLOQUEANTES: SIM/NAO
- PRONTO_PARA_PROXIMA_ETAPA_OFICIAL: SIM/NAO

Importante: nao nomear automaticamente a proxima etapa como Base Comercial. Indicar apenas consulta a proxima etapa oficialmente liberada.

## O que nao deve fazer

Nao pode:

- criar Base Comercial;
- desenvolver integracao;
- criar mapeamento final de implementacao;
- iniciar Passo 03;
- alterar contrato homologado da ferramenta;
- alterar Harness;
- alterar manifestos existentes de Forca;
- inventar endpoint, enum, campo, limite ou regra comercial.

## Preparacao para Harness e auditoria futura

Esta etapa deve nascer auditavel, com previsao de:

- manifesto de etapa;
- checkpoint de retomada;
- hashes portaveis;
- invalidação por mudanca upstream;
- auditoria semantica baseada em evidencia;
- timebox seguro.

Nesta tarefa estrutural, nao criar execucao real nem manifesto real de ERP.

## Retorno obrigatorio do Codex

```text
STATUS DA ETAPA: CONCLUIDA | PENDENTE | BLOQUEADA

GATE DE ENTRADA:
- PASSO_01_CONCLUIDO: SIM/NAO
- FERRAMENTA_HOMOLOGADA: SIM/NAO
- CENARIO_ERP_PARCEIRO: SIM/NAO
- DOCUMENTACAO_SUFICIENTE: SIM/NAO

RESUMO TECNICO:
<resumo objetivo>

CAPACIDADES POR MODULO:
<sintese>

DIRECOES POSSIVEIS:
<sintese>

MATRIZ ERP x FERRAMENTA:
<resumo + caminho do artefato>

GAPS E ADAPTACOES:
<lista>

PENDENCIAS:
<lista>

FONTES USADAS:
<lista>

GATE DE SAIDA:
- ERP_ANALISADO: SIM/NAO
- COMPARACAO_COM_FERRAMENTA: CONCLUIDA/PENDENTE/BLOQUEADA
- CAPACIDADES_IDENTIFICADAS: SIM/NAO
- GAPS_IDENTIFICADOS: SIM/NAO
- PENDENCIAS_BLOQUEANTES: SIM/NAO
- PRONTO_PARA_PROXIMA_ETAPA_OFICIAL: SIM/NAO

PROXIMA ACAO PERMITIDA:
consultar/identificar a proxima etapa oficialmente liberada da jornada ERP parceiro em comece-aqui/integrar-erp/erp-parceiro/00-COMECE-AQUI.md (ou equivalente atual).
```