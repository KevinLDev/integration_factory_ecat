# AGENTS.md — Jornada de Parceiros

Este arquivo complementa o `AGENTS.md` da raiz para qualquer trabalho realizado dentro de `parceiros/`.

Leia primeiro o `AGENTS.md` da raiz. Todas as regras globais continuam válidas.

## 1. Objetivo da jornada

Esta pasta reúne as regras e os comandos técnicos da trilha de parceiros. Na experiência humana de `comece-aqui/`, o trabalho está separado em duas jornadas: preparar uma ferramenta E-Catálogos e integrar um ERP parceiro ao portfólio.

A trilha de parceiros transforma uma ferramenta E-Catálogos documentada e um ERP parceiro documentado em uma integração reutilizável, testada, homologada e documentada. A configuração de um cliente é uma terceira jornada, separada, e não deve ser incorporada silenciosamente a esta trilha.

O fluxo conceitual é:

```text
Ferramenta E-Catálogos
        ↓
entender e cadastrar o contrato
        ↓
validar contra a fonte oficial
        ↓
ERP parceiro
        ↓
analisar capacidades
        ↓
mapear ERP x ferramenta
        ↓
criar base comercial de homologação
        ↓
gerar integração bidirecional
        ↓
testar módulos
        ↓
homologar ponta a ponta
        ↓
documentar integração reutilizável
```

## 2. Ordem obrigatória

A jornada deve ser executada por etapas e cada etapa funciona como portão de qualidade.

Etapas operacionais atualmente disponíveis na jornada de ERP parceiro:

```text
01 APRESENTAR ERP
02 ANALISAR ERP
03 PROJETAR HOMOLOGAÇÃO
04 MATERIALIZAR BASE DE HOMOLOGAÇÃO
05 PROJETAR INTEGRAÇÃO E MAPEAMENTO SEMÂNTICO
```

Não pule etapa concluindo implicitamente trabalho que pertence a um comando posterior.

Enquanto um comando ainda não existir ou não estiver validado, registre isso como lacuna do Harness; não improvise um fluxo permanente silenciosamente.

A jornada de nova ferramenta possui os Passos 01 a 03 disponíveis. A jornada de ERP parceiro possui os Passos 01 a 05 disponíveis, com a relação vigente publicada em `comece-aqui/integrar-erp/erp-parceiro/00-COMECE-AQUI.md`. Ainda não existe Passo 06 oficial ou executável de ERP parceiro, e a jornada de ERP cliente ainda não está liberada para operação.

## 3. Interface com o operador

O operador chama um comando e fornece o mínimo necessário para identificar a execução.

Exemplo:

```text
Execute integralmente:
parceiros/comandos/01-APRESENTAR-E-ANALISAR-FERRAMENTA.md

Nova ferramenta: Força de Vendas
Objetivo: ferramenta de força de vendas da E-Catálogos
Documentação: <arquivos/anexos/caminhos>
```

O operador não precisa informar a pasta de execução.

O agente deve:

1. localizar uma execução existente quando ela for inequívoca;
2. criar automaticamente uma execução quando a etapa inicial exigir;
3. registrar dados recebidos;
4. persistir estado;
5. organizar/referenciar documentação sem exigir trabalho de Explorer do operador;
6. retornar `PENDENTE` somente quando a informação necessária realmente não puder ser descoberta.

## 4. Ferramenta E-Catálogos primeiro

Antes de integrar qualquer ERP, a ferramenta E-Catálogos alvo precisa estar compreendida, cadastrada e validada.

O cadastro da ferramenta deve ser baseado em fonte oficial e registrar, quando aplicável:

- autenticação;
- ambientes;
- módulos/tags;
- endpoints e métodos;
- parâmetros;
- requests/responses;
- schemas;
- enums;
- paginação;
- erros;
- dependências;
- chaves externas/correlação;
- operações disponíveis;
- regras explícitas de negócio.

O cadastro não é considerado confiável para integrações até ser comparado novamente com a fonte oficial pelo Passo 03 e aprovado pelo gate de homologação.

O Passo 03 é a homologação técnica do contrato canônico para uso em integrações com ERP. Durante essa homologação, os sete artefatos canônicos produzidos no Passo 02 são entradas somente leitura: o Passo 03 não pode alterá-los nem corrigir silenciosamente seus achados; qualquer correção deve retornar ao Passo 02 e passar por nova auditoria válida dessa etapa.

Uma ferramenta só pode ser usada na jornada de ERP parceiro quando possuir conjuntamente:

```text
RESULTADO TECNICO: APTO_PARA_INTEGRACOES
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
PRONTIDAO: HOMOLOGADA_PARA_INTEGRACOES
```

Sem esse gate, a jornada de ERP parceiro deve retornar `BLOQUEADA` para a ferramenta, sem improvisar validação ou corrigir silenciosamente o contrato.

## 5. ERP parceiro

Ao receber um ERP parceiro, não implemente imediatamente.

Primeiro produza inventário técnico e depois mapeamento contra o contrato da ferramenta E-Catálogos.

Para cada capacidade relevante, identifique:

- endpoint/operação em ambos os lados;
- direção;
- campos de origem e destino;
- tipos;
- obrigatoriedade;
- transformação;
- dependências;
- chave de correlação;
- criação versus atualização;
- idempotência;
- prevenção de loop;
- limitações;
- evidência usada.

Sem evidência suficiente, registre `PENDENTE`.

## 6. Base comercial de homologação

Quando o ERP parceiro estiver vazio ou incompleto, crie apenas a base necessária para provar os contratos e cenários da ferramenta E-Catálogos.

Exemplos de entidades possíveis:

- clientes;
- produtos;
- categorias;
- marcas;
- cores;
- tamanhos;
- variantes;
- SKUs;
- filiais;
- representantes;
- tabelas de preço;
- preços;
- estoque;
- métodos/condições de pagamento;
- pedidos e status.

A lista final vem do contrato da ferramenta e do mapeamento aprovado. Não popule entidades apenas porque o ERP as possui.

Registre IDs e cenários criados para que os testes posteriores sejam reproduzíveis.

## 7. Bidirecionalidade

Todo módulo aplicável deve ser avaliado nas duas direções.

Para cada direção, responda explicitamente:

- como identificar alteração nova;
- como correlacionar registros;
- como decidir criar versus atualizar;
- como impedir duplicação;
- como impedir loop;
- qual sistema prevalece em conflito;
- como registrar falha parcial;
- como reprocessar com segurança.

Se uma operação não existir em uma das APIs, registre a limitação com evidência. Não simule suporte inexistente.

## 8. Testes obrigatórios

Os testes devem validar comportamento, não apenas status HTTP.

Quando aplicável, cubra:

- autenticação;
- leitura;
- criação;
- atualização;
- paginação;
- transformação;
- campos obrigatórios;
- dependências;
- correlação;
- duplicidade;
- idempotência;
- prevenção de loop;
- rate limit;
- retry/backoff;
- timeout;
- erro isolado;
- reprocessamento;
- dry-run;
- fluxo ponta a ponta.

Produtos devem considerar dependências como variante/SKU/preço/estoque quando existirem.

Pedidos e estoque devem validar explicitamente se o ERP reserva, baixa ou movimenta estoque automaticamente e como ocorre o estorno/cancelamento.

## 9. Evidências históricas

Ao analisar flows antigos do Pipedream, trate-os como fonte de cenários e regras reais, não como padrão arquitetural.

Se uma regra aparecer apenas no legado e não estiver comprovada na API/documentação atual, marque-a como hipótese/pendência até validar.

## 10. Estado da execução

Cada etapa deve atualizar `ESTADO-DA-EXECUCAO.md` com pelo menos:

- ferramenta;
- ERP quando aplicável;
- etapa atual;
- status;
- etapas concluídas;
- fontes consultadas;
- artefatos produzidos;
- validações realizadas;
- pendências;
- bloqueios;
- próxima etapa permitida.

Para o Passo 03, registrar separadamente:

- resultado técnico: `APTO_PARA_INTEGRACOES` ou `NAO_APTO_PARA_INTEGRACOES`;
- resultado da auditoria;
- status final da etapa;
- prontidão: `NAO_HOMOLOGADA`, `AGUARDANDO_AUDITORIA` ou `HOMOLOGADA_PARA_INTEGRACOES`;
- relatório vigente de homologação;
- relatório vigente de auditoria.

`AGUARDANDO_AUDITORIA` é estado transitório interno e não substitui os status finais `CONCLUIDA`, `PENDENTE` ou `BLOQUEADA`.

A próxima etapa só pode ser liberada com `STATUS DA ETAPA: CONCLUIDA`.

## 10.1 Artefatos de controle da execução

Nas execuções desta trilha, os manifestos reais ficam em `parceiros/execucoes/<tipo>/<slug>/manifestos/PASSO-<NN>.yaml` e seguem `parceiros/modelos/MANIFESTO-DA-ETAPA.yaml`. O checkpoint transitório segue `parceiros/modelos/CHECKPOINT-DA-EXECUCAO.yaml` e fica na própria execução. O agente cria e mantém esses controles; o operador não os prepara manualmente.

Antes de executar, retomar ou avançar, verifique deterministicamente a vigência do manifesto da etapa e de suas dependências. `STATUS DA ETAPA: CONCLUIDA` não libera downstream se o manifesto estiver ausente, invalidado ou com hash divergente.

Aplicam-se o protocolo global de retomada, leitura por delta e timebox do `AGENTS.md`. Para auditorias, use exclusivamente os modos e gatilhos definidos em `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`.

## 10.2 Separação entre execução e auditoria

**AUDITORIA É SOMENTE LEITURA DOS ARTEFATOS AUDITADOS.**

Execução e auditoria são atividades separadas. Depois que a auditoria começa, é proibido:

- editar artefatos da etapa;
- completar informação ausente;
- regenerar arquivos;
- corrigir inconsistências;
- alterar contrato;
- alterar análise para fazer o teste passar.

A auditoria deve declarar previamente seu conjunto de artefatos, registrar sua integridade e verificar ao final que nenhum deles mudou. As únicas saídas de controle permitidas são as definidas em `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md`: checkpoint transitório quando houver; novo relatório; e, somente depois das verificações, deltas estritamente autorizados no estado e no manifesto. Esses controles ficam fora do conjunto auditado e nunca podem corrigir conteúdo técnico.

Se qualquer problema for encontrado, o resultado obrigatório é:

```text
AUDITORIA: REPROVADA
STATUS DA ETAPA: PENDENTE
```

O problema deve ser registrado exatamente como encontrado e não pode ser corrigido durante a auditoria. A correção ocorre em execução posterior do mesmo comando da etapa; concluída a correção, uma nova auditoria independente deve validar todos os critérios do modo aplicável. Falha semântica ou perda de confiança exige auditoria `PROFUNDA`.

A auditoria deve comparar fonte original, comando, critérios de aceite, artefatos produzidos e estado. Um artefato gerado não pode validar outro artefato gerado sozinho, e igualdade de contagens não substitui a validação de conteúdo, rastreabilidade, pendências, operações, módulos, dependências e bidirecionalidade.

## 11. Documentação operacional obrigatória (comece-aqui)

Todo novo comando operacional criado em `parceiros/comandos/` deve possuir documento humano correspondente na jornada correta de `comece-aqui/`.

Paridade atual:

- `parceiros/comandos/01-APRESENTAR-E-ANALISAR-FERRAMENTA.md` → `comece-aqui/integrar-nova-ferramenta/01-APRESENTAR-FERRAMENTA.md`;
- `parceiros/comandos/02-CADASTRAR-FERRAMENTA.md` → `comece-aqui/integrar-nova-ferramenta/02-CADASTRAR-FERRAMENTA.md`;
- `parceiros/comandos/03-VALIDAR-FERRAMENTA-CADASTRADA.md` → `comece-aqui/integrar-nova-ferramenta/03-VALIDAR-FERRAMENTA-CADASTRADA.md`.

Para comandos de ERP, o documento operacional correspondente deve ficar em:

- `comece-aqui/integrar-erp/erp-parceiro/`, quando homologar uma integração reutilizável de ERP;
- `comece-aqui/integrar-erp/erp-cliente/`, quando configurar um cliente sobre uma integração já suportada.

A paridade operacional vigente dos Passos 01 a 05 de ERP parceiro é publicada em `comece-aqui/integrar-erp/erp-parceiro/00-COMECE-AQUI.md`.

Uma etapa não deve ser considerada pronta para uso operacional enquanto o documento correspondente não existir, não estiver homologado e não estiver na jornada correta.

Todo documento operacional de ERP parceiro ou ERP cliente deve seguir integralmente o padrão definido em `AGENTS.md`, incluindo, quando aplicável, pré-requisitos, insumos, prompt exato, exemplo preenchido, artefatos esperados, testes, tratamento de falhas, status, auditoria, critério de avanço e próximo documento.

Se o documento possuir prompt para IA, deve obrigatoriamente usar a sinalização:

- `### COPIE A PARTIR DAQUI`;
- `### PARE DE COPIAR AQUI`.

O operador deve copiar somente o conteúdo entre essas marcações e substituir todos os campos entre colchetes antes de enviar. Uma etapa operacional não está pronta sem essa sinalização quando houver prompt.
