# Memoria de ERPs e Combinacoes

## 1. Objetivo

Esta regra define a arquitetura oficial de memoria tecnica para jornadas de ERP parceiro.

Ela separa claramente:

- conhecimento reutilizavel do ERP;
- conhecimento especifico da combinacao ERP x ferramenta;
- evidencia operacional temporal da execucao controlada pelo Harness.

## 2. Unidade de conhecimento e unidade de homologacao

- Unidade de conhecimento geral: ERP.
- Unidade de homologacao reutilizavel: combinacao ERP x ferramenta.

Exemplo conceitual:

- ERP A x Ferramenta X homologado nao implica ERP A x Ferramenta Y homologado.

## 3. Memoria reutilizavel do ERP

Conhecimento que independe da ferramenta pertence ao contexto do ERP:

`erps/<erp-slug>/`

Artefatos:

- `ANALISE-DO-ERP.md`
- `CAPACIDADES-DO-ERP.md`
- `FONTES.md`

Responsabilidades:

- `ANALISE-DO-ERP.md`: autenticacao, token/refresh, ambientes, arquitetura API, paginacao, limites e comportamentos gerais reutilizaveis.
- `CAPACIDADES-DO-ERP.md`: modulos/recursos, operacoes, rotas, capacidades, restricoes e estado de evidencia.
- `FONTES.md`: inventario de Swagger/OpenAPI, documentacao, PDFs e evidencias de teste autorizado com versao/data/hash/caminho quando disponivel.

## 4. Memoria da combinacao ERP x ferramenta

Conhecimento dependente da ferramenta pertence ao contexto da combinacao:

`erps/<erp-slug>/integracoes/<ferramenta-slug>/`

Artefatos:

- `MATRIZ-ERP-FERRAMENTA.md`
- `PENDENCIAS.md`

Responsabilidades:

- `MATRIZ-ERP-FERRAMENTA.md`: requisito da ferramenta, capacidade ERP, direcao, compatibilidade, adaptacao, gap e referencia de evidencia.
- `PENDENCIAS.md`: lacunas, divergencias, incompatibilidades, bloqueios e decisoes pendentes da combinacao especifica.

## 5. Evidencia operacional da execucao (Harness)

Nao misturar conhecimento canonicamente reutilizavel com artefatos operacionais temporais.

Execucoes devem manter evidencias em estrutura dedicada de execucao, conceitualmente equivalente a:

`parceiros/execucoes/erps/<erp-slug>/<ferramenta-slug>/`

Inclui, quando aplicavel:

- manifestos;
- checkpoints;
- auditorias;
- evidencias;
- estado da execucao;
- retomada.

## 6. Resolucao de identidade antes de escrever

Antes de criar, complementar ou alterar qualquer memoria de ERP, a etapa deve consultar primeiro o repositorio e seguir a ordem obrigatoria:

1. identificar e normalizar o ERP;
2. verificar se o ERP ja e conhecido;
3. identificar e normalizar a ferramenta E-Catalogos;
4. verificar se a ferramenta ja e conhecida;
5. verificar se a ferramenta esta `HOMOLOGADA_PARA_INTEGRACOES`;
6. verificar se a combinacao ERP x ferramenta ja existe;
7. somente entao decidir criacao, reutilizacao, complementacao, retomada ou bloqueio.

Estados minimos:

- `ERP_CONHECIDO`: `SIM` | `NAO` | `IDENTIDADE_AMBIGUA`
- `FERRAMENTA_CONHECIDA`: `SIM` | `NAO` | `IDENTIDADE_AMBIGUA`
- `FERRAMENTA_HOMOLOGADA`: `SIM` | `NAO`
- `COMBINACAO_ERP_FERRAMENTA_EXISTE`: `SIM` | `NAO`

Normalizacao obrigatoria:

- evitar duplicidade por grafia/capitalizacao/prefixo (ex.: Bling, bling, BLING, ERP Bling -> mesma identidade canonica quando houver evidencia suficiente);
- aplicar o mesmo criterio para ferramentas;
- se nao houver evidencia suficiente para unificacao, registrar `IDENTIDADE_AMBIGUA` e solicitar ao operador apenas o dado minimo para desambiguar.

Somente depois decidir destino de escrita.

## 7. Reutilizacao e nao sobrescrita cega

E proibido comportamento de sobrescrita cega do tipo "apagar e gerar novamente" sem diagnostico.

Regras:

- Novo ERP: criar contexto proprio sem alterar ERPs existentes.
- Mesmo ERP + nova ferramenta: reutilizar conhecimento geral valido do ERP e criar contexto especifico da nova combinacao.
- Mesmo ERP + mesma ferramenta: nao regenerar automaticamente; decidir entre retomada, complementacao, atualizacao ou reanalise.
- Nova capacidade descoberta: complementar o conhecimento com evidencia; nao destruir capacidades anteriores validas.

Decisao automatica obrigatoria:

- Ferramenta desconhecida -> direcionar para jornada Nova Ferramenta.
- Ferramenta conhecida e nao homologada -> bloquear ERP parceiro ate homologacao.
- Ferramenta homologada + ERP desconhecido -> novo conhecimento de ERP + nova combinacao ERP x ferramenta.
- Ferramenta homologada + ERP conhecido + combinacao inexistente -> reutilizar ERP valido e criar somente nova combinacao.
- Combinacao ja existente -> nao regenerar/sobrescrever cegamente; resolver retomada, complementacao, atualizacao ou reutilizacao.
- Combinacao ja homologada em contexto de cliente -> resolver para ERP Cliente/reutilizacao.

## 8. Mudanca de fonte upstream

Quando fonte oficial mudar (Swagger/documentacao):

1. detectar mudanca upstream;
2. identificar conhecimento afetado;
3. invalidar/reavaliar dependencias necessarias;
4. atualizar conscientemente com evidencia;
5. preservar historico via Git/Harness.

Nao sobrescrever silenciosamente conhecimento derivado homologado.

Documentacao nova nao implica ERP novo:

- se o ERP ja for conhecido, classificar `ERP_CONHECIDO: SIM` e `FONTE_DIFERENTE: SIM`;
- avaliar se a fonte e complementar, nova versao, possivel mudanca upstream ou redundante;
- mudanca de fonte nao autoriza sobrescrita silenciosa.

## 9. Relacao com o Passo 02

No Passo 02 de ERP parceiro, os cinco artefatos continuam obrigatorios, mas com destino separado:

- ERP (`erps/<erp-slug>/`):
  - `ANALISE-DO-ERP.md`
  - `CAPACIDADES-DO-ERP.md`
  - `FONTES.md`
- Combinacao (`erps/<erp-slug>/integracoes/<ferramenta-slug>/`):
  - `MATRIZ-ERP-FERRAMENTA.md`
  - `PENDENCIAS.md`

O operador nao precisa informar caminhos de escrita.

## 10. Guardrails permanentes

- Nao alterar contrato homologado da ferramenta para acomodar ERP.
- Nao concluir `NAO_SUPORTADO` sem evidencia suficiente de ausencia real.
- Nao transformar fluxo conceitual em proxima etapa executavel automatica.
- Nao misturar conhecimento canonicamente reutilizavel com evidencia operacional temporal.
