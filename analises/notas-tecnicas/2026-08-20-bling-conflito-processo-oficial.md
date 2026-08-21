# Nota técnica — conflito entre pedido do operador e processo oficial (Bling)

## Status

Este documento é uma nota informal de registro de conflito, para revisão futura do operador.
Não é um artefato de etapa da jornada de ERP parceiro nem substitui o Passo 01.

- Data: 2026-08-20
- ERP envolvido: Bling
- Ferramenta alvo: Força de Vendas

## O que foi pedido

O operador pediu para testar imediatamente a autenticação OAuth2 do Bling (client_id, client_secret,
redirect_uri já fornecidos) e confirmar se o fluxo de autorização/token funciona, antes de qualquer
outra coisa.

## Conflito identificado com o processo oficial

1. `erps-integrados/README.md` confirma que **nenhum ERP está publicado** até o momento — Bling seria
   o primeiro ERP parceiro real da fábrica.
2. `comece-aqui/integrar-erp/erp-parceiro/00-COMECE-AQUI.md` exige, como pré-condição, que a ferramenta
   alvo esteja `HOMOLOGADA_PARA_INTEGRACOES`. Verificado: Força de Vendas está homologada
   (`parceiros/execucoes/ferramentas/forca-de-vendas/auditorias/AUDITORIA-ETAPA-03-REVALIDACAO-REGRAS-DE-NEGOCIO-20260813.md`
   → `AUDITORIA: APROVADA`, `STATUS DA ETAPA: CONCLUIDA`, `PRONTIDAO: HOMOLOGADA_PARA_INTEGRACOES`). Essa
   pré-condição está satisfeita.
3. Porém, o template do Passo 01 (`comece-aqui/integrar-erp/erp-parceiro/01-APRESENTAR-ERP.md`) contém,
   tanto no bloco genérico quanto no exemplo preenchido, a instrução explícita:
   - "Não inicie ERP real."
   - "Não use Bling como execução real."
   - "Não faça análise profunda da API."
   - "Não desenvolva integração."
4. Pelo desenho da jornada, execução técnica real (chamadas HTTP autenticadas contra o Bling) só é
   prevista a partir do Passo 07 (`07-EXECUTAR-E-VALIDAR-TECNICAMENTE-EM-HML.md`), depois de Passos
   01→06 (apresentar, analisar, projetar homologação, materializar base de homologação, projetar
   mapeamento semântico, desenvolver integração).
5. `README.md` reforça que "a primeira execução real de cada combinação (Passos 04, 05 e 06) exige
   auditoria independente PROFUNDA".
6. Nenhum artefato de `erps/`, `erps-integrados/` ou `parceiros/execucoes/erps/` menciona Bling até esta
   data — ou seja, o Passo 01 formal desta combinação (Bling x Força de Vendas) ainda não foi executado.

Ou seja: testar autenticação real contra o Bling agora, sem passar pelos Passos 01–06, é uma execução
fora da ordem prevista pela metodologia da fábrica para ERP parceiro.

## Decisão tomada nesta sessão

O operador, ciente do conflito (apresentado via pergunta direta), decidiu:

> "registra esses conflitos pra mim para eu dar uma olhada depois, mas pode seguir com o que eu pedi
> em relação à integração"

Ou seja: registrar o conflito (este documento) e prosseguir mesmo assim com o teste técnico de
autenticação, como pedido, fora da trilha auditada.

## Como o teste foi conduzido para não corromper o Harness

- Nenhum artefato canônico de `ferramentas/forca-de-vendas/`, `erps/` ou `erps-integrados/` foi criado,
  alterado ou usado como gate.
- O Passo 01 (Apresentar ERP) **não** foi executado formalmente — este teste não deve ser confundido
  com ele nem usado para preencher retroativamente seu resultado.
- Os valores reais de `client_id`/`client_secret` foram gravados apenas em
  `.tmp/bling-auth-test/credenciais-erp.env`, caminho coberto por duas regras do `.gitignore`
  (`.tmp/` e `**/credenciais-erp.env`) — nunca versionado.
- Os tokens obtidos (se houver) ficam em `.tmp/bling-auth-test/tokens.local.json`, também fora do
  controle de versão.
- Chamadas de teste feitas contra a API real do Bling foram limitadas a endpoints de leitura, sem
  efeito colateral (`GET /situacoes/modulos`, `GET /empresas/me/dados-basicos`).

## Resultado do teste informal de autenticação

- 1ª tentativa (credenciais originais fornecidas pelo operador): falhou com `access_denied` — "The user
  denied access to your application". O operador reportou em seguida que houve uma correção de
  credenciais do lado do Bling.
- 2ª tentativa (credenciais corrigidas, mesmo redirect_uri): **sucesso completo**.
  - `POST /Api/v3/oauth/token` retornou `200`, `token_type=bearer`, `expires_in=21600` (6h),
    `refresh_token` presente.
  - `GET /Api/v3/situacoes/modulos` -> `200`.
  - `GET /Api/v3/empresas/me/dados-basicos` -> `200`, empresa autenticada: `eCatalogos`
    (CPF 993.510.450-80, e-mail kevinlima.ecatalogos@gmail.com).
  - Evidência bruta (sem segredos) em `.tmp/bling-auth-test/resultado.json` (não versionado).
  - Tokens reais em `.tmp/bling-auth-test/tokens.local.json` (não versionado).
- Conclusão técnica: o par client_id/client_secret corrigido, o redirect_uri
  `http://localhost:3000/callback` e o fluxo Authorization Code do Bling funcionam ponta a ponta contra
  a API real de produção do Bling (`https://api.bling.com.br`), incluindo emissão de `refresh_token`.
- Isso **não substitui** nenhuma etapa oficial da jornada de ERP parceiro; é só confirmação técnica
  informal de que a credencial funciona, feita fora de ordem a pedido do operador.

## Pendência para o operador

Quando o operador "der uma olhada depois", as decisões em aberto são:

1. Formalizar (ou não) o Passo 01 da jornada de ERP parceiro para o Bling, agora que a autenticação
   real já foi validada informalmente fora da ordem prevista.
2. Decidir se o teste técnico feito aqui pode ser reaproveitado como evidência dentro de uma futura
   auditoria (o Harness normalmente trata execução fora de etapa como não vinculante, então
   provavelmente precisará ser refeito formalmente dentro do Passo correspondente, com rastreabilidade
   própria).
3. Confirmar se este arquivo deve ser arquivado, apagado ou movido para dentro da futura pasta de
   execução do Bling quando ela existir.
