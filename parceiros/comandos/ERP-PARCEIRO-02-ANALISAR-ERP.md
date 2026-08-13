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

Ordem obrigatoria de resolucao antes de criar/complementar/alterar memoria:

1. identificar e normalizar ERP;
2. verificar se ERP ja e conhecido;
3. identificar e normalizar ferramenta E-Catalogos;
4. verificar se ferramenta ja e conhecida;
5. verificar se ferramenta esta HOMOLOGADA_PARA_INTEGRACOES;
6. verificar se combinacao ERP x ferramenta ja existe;
7. somente entao decidir criacao, reutilizacao, complementacao, retomada ou bloqueio.

Estados minimos a registrar:

- ERP_CONHECIDO: SIM | NAO | IDENTIDADE_AMBIGUA
- FERRAMENTA_CONHECIDA: SIM | NAO | IDENTIDADE_AMBIGUA
- FERRAMENTA_HOMOLOGADA: SIM | NAO
- COMBINACAO_ERP_FERRAMENTA_EXISTE: SIM | NAO

Normalizacao deve impedir duplicidades por grafia/capitalizacao/prefixo quando houver evidencia suficiente.

Se a identidade nao puder ser determinada com seguranca, registrar IDENTIDADE_AMBIGUA e solicitar ao operador somente o dado minimo para desambiguar.

## Resolucao de identidade e destino de memoria

Antes de escrever artefatos, resolver automaticamente:

1. `erp-slug`
2. `ferramenta-slug`
3. tipo do artefato (geral do ERP ou especifico da combinacao)

Arquitetura oficial da memoria:

- conhecimento reutilizavel do ERP: `erps/<erp-slug>/`
- conhecimento da combinacao ERP x ferramenta: `erps/<erp-slug>/integracoes/<ferramenta-slug>/`
- evidencia operacional da execucao (Harness): `parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/`

Nao exigir que o operador informe caminhos de escrita.

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
3. Memoria funcional da ferramenta, quando existir (`ferramentas/<ferramenta-slug>/CENARIOS-FUNCIONAIS.md`).
4. Memoria de regras de negocio da ferramenta, quando existir (`ferramentas/<ferramenta-slug>/REGRAS-DE-NEGOCIO.md`).
5. Evidencias runtime autorizadas e evidencias da execucao existente do Passo 01.
6. Regras adicionais fornecidas pelo operador.

Regra: o ERP se adapta ao contrato da ferramenta. Nunca alterar contrato homologado para facilitar o ERP.

Regra complementar: funcionalidade da ferramenta nao equivale automaticamente a endpoint de mesmo nome no ERP. Modo funcional orienta dados/capacidades necessarias e nao autoriza inventar endpoint por nome.

## Reutilizacao obrigatoria antes da analise profunda

Verificar primeiro:

- ERP ja conhecido?
	- SIM: validar/reutilizar conhecimento existente e complementar com evidencia quando necessario.
	- NAO: criar novo contexto de memoria do ERP sem alterar outros ERPs.
- Combinacao ERP x ferramenta ja existente?
	- SIM: nao sobrescrever automaticamente; classificar como retomada, complementacao, atualizacao ou reanalise.
	- NAO: criar contexto especifico da combinacao.

Proibido regenerar cegamente artefato existente sem diagnostico de necessidade.

Decisao automatica obrigatoria:

- ferramenta desconhecida -> direcionar para jornada Nova Ferramenta;
- ferramenta conhecida e nao homologada -> bloquear ERP Parceiro ate homologacao;
- ferramenta homologada + ERP desconhecido -> novo conhecimento de ERP + nova combinacao ERP x ferramenta;
- ferramenta homologada + ERP conhecido + combinacao inexistente -> reutilizar ERP valido e criar somente nova combinacao;
- combinacao ja existente -> nao regenerar/sobrescrever cegamente; resolver retomada, complementacao, atualizacao ou reutilizacao;
- combinacao ja homologada em contexto de cliente -> resolver para ERP Cliente/reutilizacao.

## Camadas da etapa

Esta etapa possui duas camadas:

1. Analise documental (obrigatoria): Swagger/OpenAPI, documentacao oficial e arquivos fornecidos.
2. Validacao tecnica controlada (quando houver credenciais e autorizacao): confirmar comportamento real da API sem escrita comercial.

Quando houver `CENARIOS-FUNCIONAIS.md` da ferramenta, incluir leitura obrigatoria para cobertura funcional por modo/cenario, preservando classificacao entre FONTE_TECNICA, FONTE_FUNCIONAL, EVIDENCIA_RUNTIME e INFERENCIA.

Quando houver `REGRAS-DE-NEGOCIO.md`, a analise deve combinar:

CONTRATO_TECNICO
+
CENARIOS_FUNCIONAIS
+
REGRAS_DE_NEGOCIO
+
EVIDENCIA_RUNTIME
->
CAPACIDADES_DO_ERP

Nao basta concluir que o ERP possui campo parecido. Para cada regra relevante, responder se o ERP consegue fornecer ou receber os dados necessarios para sustentar a regra comercial da ferramenta.

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

### 9) Regras de negocio

Para cada regra comercial relevante, registrar o ID da regra, dados necessarios, capacidade comprovada do ERP, evidencia, impacto e status.

Exemplos obrigatorios de raciocinio:

- regra de preco por tabela/regiao + ERP com apenas preco unico: cobertura nao completa, ainda que exista campo preco;
- regra de grade fechada com pack/composicao + ERP com apenas tamanho: `PENDENTE_DE_EVIDENCIA` ou gap, conforme a evidencia;
- regra de integracao no momento de exportacao: investigar evento/rota/estado da ferramenta e dados recebidos pelo ERP, sem inferir que pedido criado equivale a pedido exportado.

Esta etapa nao produz o mapeamento final de implementacao.

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

Quando houver memoria funcional da ferramenta, incluir cobertura funcional por modo/cenario com colunas equivalentes a:

- MODO
- DADOS_NECESSARIOS
- CAPACIDADES_DISPONIVEIS_NO_ERP
- CAPACIDADES_FALTANTES
- IMPACTO
- EVIDENCIA

Estados conceituais de impacto por modo:

- BLOQUEIA_MODO
- DEGRADA_MODO
- NAO_IMPACTA_MODO
- PENDENTE_DE_EVIDENCIA

Ausencia de capacidade em um modo especifico nao bloqueia automaticamente toda a integracao.

Quando houver memoria de regras de negocio, a mesma matriz deve conseguir expressar, sem estrutura paralela desnecessaria:

- REGRA_DE_NEGOCIO (preferencialmente por ID `RN-*`)
- DADOS_NECESSARIOS
- CAPACIDADE_ERP
- EVIDENCIA
- IMPACTO
- STATUS

Nao copiar textos inteiros de `REGRAS-DE-NEGOCIO.md` para a matriz.

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

## Mudanca de fontes upstream

Se Swagger/documentacao oficial mudar, aplicar fluxo controlado:

1. detectar mudanca upstream;
2. identificar conhecimento afetado;
3. invalidar/reavaliar dependencias necessarias;
4. atualizar conscientemente com evidencia;
5. preservar historico via Git/Harness.

Nao sobrescrever silenciosamente conhecimento derivado.

Documentacao nova nao significa ERP novo:

- se ERP ja conhecido, registrar ERP_CONHECIDO: SIM e FONTE_DIFERENTE: SIM;
- avaliar se e fonte complementar, nova versao, possivel mudanca upstream ou redundante;
- mudanca de fonte nao autoriza sobrescrita silenciosa.

## Saidas minimas esperadas de uma execucao real

Como conjunto minimo da etapa, a execucao real deve produzir:

- ERP (`erps/<erp-slug>/`):
	- `ANALISE-DO-ERP.md`
	- `CAPACIDADES-DO-ERP.md`
	- `FONTES.md`
- Combinacao (`erps/<erp-slug>/integracoes/<ferramenta-slug>/`):
	- `MATRIZ-ERP-FERRAMENTA.md` (incluindo cobertura funcional por modo/cenario quando existir `CENARIOS-FUNCIONAIS.md` e cobertura por regra comercial quando existir `REGRAS-DE-NEGOCIO.md`, por referencia de ID e sem duplicacao integral)
	- `PENDENCIAS.md`

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

Em execucao real, artefatos operacionais (manifesto/checkpoint/auditoria/evidencias/estado) pertencem ao contexto de execucao em `parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/`.

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
