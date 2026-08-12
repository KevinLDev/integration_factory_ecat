# 02 — Analisar ERP contra contrato homologado da ferramenta

## Quando usar

Use esta etapa quando o Passo 01 da jornada de ERP parceiro já foi concluido e a ferramenta alvo esta homologada para integracoes.

Esta etapa faz analise tecnica profunda do ERP contra o contrato homologado interno da ferramenta E-Catalogos.

## Antes de comecar

Confirme na execucao ativa:

- Passo 01 do ERP parceiro concluido;
- ferramenta com gate de homologacao atendido (`HOMOLOGADA_PARA_INTEGRACOES`);
- contexto resolvido como ERP parceiro;
- documentacao oficial suficiente do ERP para analise.

Sem esses requisitos, a etapa deve retornar `BLOQUEADA` ou `PENDENTE`, sem inventar capacidade.

## Auto-descoberta do contexto

O operador nao precisa repetir informacoes que ja existem na execucao.

Antes de solicitar novos dados, o executor deve descobrir automaticamente:

- ERP informado no Passo 01;
- ferramenta alvo;
- contexto resolvido;
- documentos/Swagger ja fornecidos;
- execucao ativa;
- estado do Passo 01;
- status de homologacao da ferramenta alvo.

Solicitar ao operador somente o que estiver realmente ausente.

Ordem obrigatoria de resolucao antes de criar/complementar/alterar memoria:

1. identificar e normalizar ERP;
2. verificar se ERP ja e conhecido;
3. identificar e normalizar ferramenta;
4. verificar se ferramenta ja e conhecida;
5. verificar se ferramenta esta HOMOLOGADA_PARA_INTEGRACOES;
6. verificar se a combinacao ERP x ferramenta ja existe;
7. somente entao decidir criacao, reutilizacao, complementacao, retomada ou bloqueio.

Estados minimos:

- ERP_CONHECIDO: SIM | NAO | IDENTIDADE_AMBIGUA
- FERRAMENTA_CONHECIDA: SIM | NAO | IDENTIDADE_AMBIGUA
- FERRAMENTA_HOMOLOGADA: SIM | NAO
- COMBINACAO_ERP_FERRAMENTA_EXISTE: SIM | NAO

Normalizacao deve evitar duplicidade por grafia/capitalizacao/prefixo quando houver evidencia suficiente.

Se houver ambiguidade de identidade, registrar IDENTIDADE_AMBIGUA e pedir ao operador apenas a informacao minima para desambiguar.

## Memoria tecnica da etapa

Antes de escrever artefatos, o executor deve resolver automaticamente identidade e destino:

- ERP (`erp-slug`)
- ferramenta (`ferramenta-slug`)
- artefato geral do ERP ou artefato especifico da combinacao

Arquitetura oficial:

- conhecimento reutilizavel do ERP: `erps/<erp-slug>/`
- conhecimento da combinacao ERP x ferramenta: `erps/<erp-slug>/integracoes/<ferramenta-slug>/`
- memoria funcional da ferramenta (quando existir): `ferramentas/<ferramenta-slug>/CENARIOS-FUNCIONAIS.md`
- evidencia operacional temporal (Harness): `parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/`

O operador nao precisa informar caminho de salvamento.

## O que esta etapa faz

- valida gate de entrada da etapa;
- executa duas camadas: analise documental + validacao tecnica controlada;
- analisa autenticacao, ambientes, modulos, endpoints, schemas, limites e eventos do ERP;
- identifica operacoes reais por modulo (ler, criar, atualizar, excluir, evento/webhook quando houver);
- compara o ERP com o contrato homologado da ferramenta;
- consulta memoria funcional da ferramenta quando existir para medir cobertura funcional por modo/cenario;
- classifica direcoes possiveis por capacidade (ERP -> ferramenta, ferramenta -> ERP, bidirecional, somente leitura, nao suportado, pendente de evidencia);
- registra gaps e necessidades de adaptacao sem alterar contrato homologado;
- registra pendencias explicitas para lacunas sem evidencia;
- produz artefatos tecnicos da etapa para auditoria futura.

Tambem deve verificar reutilizacao antes da analise profunda:

- ERP ja conhecido: reutilizar conhecimento valido e complementar quando necessario.
- ERP novo: criar contexto proprio sem sobrescrever outro ERP.
- Combinacao ERP x ferramenta ja existente: nao sobrescrever cegamente; decidir retomada, complementacao, atualizacao ou reanalise.
- Combinacao nova: criar contexto especifico da combinacao.

Decisao automatica:

- ferramenta desconhecida -> direcionar para jornada Nova Ferramenta;
- ferramenta conhecida e nao homologada -> bloquear ERP Parceiro ate homologacao;
- ferramenta homologada + ERP desconhecido -> novo conhecimento de ERP + nova combinacao;
- ferramenta homologada + ERP conhecido + combinacao inexistente -> reutilizar ERP valido e criar somente combinacao;
- combinacao ja existente -> nao regenerar cegamente; resolver retomada/complementacao/atualizacao/reutilizacao;
- combinacao homologada em contexto de cliente -> resolver para ERP Cliente/reutilizacao.

Camada 1 (obrigatoria): leitura documental de Swagger/OpenAPI, documentacao oficial e arquivos fornecidos.

Camada 2 (quando houver credenciais e autorizacao): validacao tecnica controlada do comportamento real da API, sem escrita comercial.

## O que esta etapa NAO faz

- nao cria Base Comercial;
- nao desenvolve integracao;
- nao cria mapeamento final de implementacao;
- nao inicia Passo 03;
- nao altera contrato homologado da ferramenta.

No Passo 02, continuam bloqueadas operacoes com efeito de escrita comercial (criacao/alteracao/exclusao de dados de negocio), mesmo que documentadas.

## O que mandar para o chat do Codex

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-02-ANALISAR-ERP.md

Analise o ERP apresentado no Passo 01 contra a ferramenta selecionada.
Use os documentos e Swagger ja fornecidos na execucao.

Se algum dado obrigatorio estiver ausente apos auto-descoberta, solicite somente o faltante.

Opcional (fallback, so se necessario):
ERP informado: [NOME_DO_ERP]
Ferramenta alvo: [NOME_DA_FERRAMENTA]
Contexto informado pelo operador: [ERP PARCEIRO | ERP CLIENTE | NAO_INFORMADO]
Documentacao oficial do ERP (arquivos/links): [CAMINHOS_OU_URLS]
Swagger/OpenAPI do ERP, se houver: [CAMINHOS_OU_URLS]

Regras adicionais:
[SE HOUVER]

Execute somente o Passo 02 da jornada ERP parceiro.
Nao crie Base Comercial.
Nao desenvolva integracao.
Nao inicie Passo 03.
Se gate de entrada falhar, retorne BLOQUEADA ou PENDENTE com evidencia.
```

### PARE DE COPIAR AQUI

Substitua os campos entre colchetes antes de enviar.

## Exemplo preenchido

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-02-ANALISAR-ERP.md

Analise o ERP apresentado no Passo 01 contra a ferramenta selecionada.
Use os documentos e Swagger ja fornecidos na execucao.

Se algum dado obrigatorio estiver ausente apos auto-descoberta, solicite somente o faltante.

Regras adicionais:
Nao usar producao.

Execute somente o Passo 02 da jornada ERP parceiro.
Nao crie Base Comercial.
Nao desenvolva integracao.
Nao inicie Passo 03.
Se gate de entrada falhar, retorne BLOQUEADA ou PENDENTE com evidencia.
```

## O que a IA fara

- validara o gate de entrada;
- comparara capacidades do ERP com o contrato homologado da ferramenta;
- executara validacao tecnica controlada quando houver credenciais e autorizacao;
- classificara direcoes e compatibilidade por modulo/capacidade;
- registrara gaps, adaptacoes necessarias e pendencias com evidencia;
- preparara saidas tecnicas auditaveis sem iniciar implementacao.

## Politica de validacao tecnica controlada

Quando houver credenciais e autorizacao em execucao real:

- permitido por padrao: autenticacao/token, refresh, GET, HEAD, OPTIONS e operacoes explicitamente nao mutaveis;
- POST somente para autenticacao/token ou operacao comprovadamente sem efeito comercial;
- bloqueado nesta etapa: POST/PUT/PATCH/DELETE com efeito de escrita comercial.

## Evidencia: documentado x testado

Cada capacidade/rota relevante deve registrar:

- DOCUMENTADO (SIM/NAO)
- TESTADO (SIM/NAO)
- HTTP_STATUS
- RESULTADO
- EVIDENCIA

Estados de resultado:

- CONFIRMADO_EM_RUNTIME
- CONFIRMADO_POR_DOCUMENTACAO
- DIVERGENTE
- FALHOU_NO_TESTE
- PENDENTE_DE_EVIDENCIA
- NAO_SUPORTADO

`NAO_SUPORTADO` exige evidencia suficiente de ausencia real. Ausencia no Swagger, sozinha, nao fecha `NAO_SUPORTADO`.

Falha de runtime (ex.: 401 em rota documentada) deve ser `FALHOU_NO_TESTE` com pendencia explicita de investigacao.

## Autenticacao e refresh

Quando autorizado em execucao real, registrar:

- auth_type, endpoint, headers e scopes;
- token obtido (sem valor), expiracao e refresh suportado ou nao;
- refresh endpoint e comportamento de rotacao quando houver;
- diferencas entre ambientes.

Retorno seguro esperado:

- `AUTENTICACAO: SUCESSO`
- `TOKEN: OBTIDO`
- `REFRESH: SUPORTADO` (quando aplicavel)

Nunca retornar valor real de token/secret.

Automacao permanente de renovacao de token pertence a camada futura de runtime/servidor, nao ao Passo 02.

## Fronteira dos artefatos da execucao real

- ERP (`erps/<erp-slug>/`):
	- `ANALISE-DO-ERP.md`: visao geral tecnica (auth, ambientes, arquitetura API, limites e comportamentos gerais);
	- `CAPACIDADES-DO-ERP.md`: catalogo de capacidades por modulo/operacao/rota com estado de evidencia e fonte;
	- `FONTES.md`: inventario de fontes documentais e testes autorizados (versao/data/hash/caminho quando disponivel).
- Combinacao (`erps/<erp-slug>/integracoes/<ferramenta-slug>/`):
	- `MATRIZ-ERP-FERRAMENTA.md`: comparacao requisito da ferramenta x capacidade do ERP, direcao, compatibilidade e gap; quando houver `CENARIOS-FUNCIONAIS.md`, incluir cobertura funcional por modo/cenario sem tratar modo como endpoint de ERP;
	- `PENDENCIAS.md`: lacunas, divergencias, duvidas e bloqueios com impacto e evidencia da combinacao.

Evitar duplicar a mesma analise nos cinco arquivos.

Falhas pontuais de rota nao impedem produzir os artefatos; devem ser registradas com estado e pendencia correspondente.

Se fontes oficiais aparentarem mudanca de versao/conteudo, tratar como mudanca upstream: registrar a nova fonte, identificar impacto e atualizar conscientemente sem sobrescrita silenciosa.

Documentacao nova nao significa ERP novo: se ERP ja conhecido, tratar como ERP_CONHECIDO: SIM e FONTE_DIFERENTE: SIM e avaliar se e fonte complementar, nova versao, possivel mudanca upstream ou redundante.

## O que devo receber

No retorno final, espere:

- `STATUS DA ETAPA` (`CONCLUIDA`, `PENDENTE` ou `BLOQUEADA`);
- resumo tecnico do que foi analisado;
- evidencias/fontes usadas;
- pendencias e bloqueios;
- gate de saida da etapa;
- proxima acao permitida.

## Proxima acao permitida

Mesmo com a etapa concluida, nao assumir automaticamente "Base Comercial" como proxima execucao. Sempre consultar a proxima etapa oficialmente liberada pelos documentos atuais da jornada.

Ao concluir, consultar `comece-aqui/integrar-erp/erp-parceiro/00-COMECE-AQUI.md` (ou equivalente atual) para identificar a proxima etapa oficialmente liberada.