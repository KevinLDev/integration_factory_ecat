# 01 — Apresentar e analisar uma ferramenta E-Catálogos

## Finalidade

Ensinar ao Codex o que é a nova ferramenta e fazê-lo analisar integralmente sua documentação **sem criar integração e sem cadastrar estrutura definitiva ainda**.

## Quando usar

Use uma única vez para cada nova ferramenta E-Catálogos que ainda não exista na fábrica.

## Como chamar esta etapa — NÃO EDITE ESTE COMANDO

Este arquivo é uma regra fixa do Harness. O operador **não cria pasta, não copia modelo, não preenche este arquivo e não informa caminho de pasta de execução**.

O operador deve informar no prompt, no mínimo, nome da nova ferramenta, além dos arquivos/dados adicionais pedidos quando aplicável.

Exemplo:

```text
Execute integralmente:
parceiros/comandos/01-APRESENTAR-E-ANALISAR-FERRAMENTA.md

Nova ferramenta: <NOME>
Objetivo: <RESUMO>
Documentação: <ANEXOS OU CAMINHOS>
Informações adicionais: <SE HOUVER>
```

Ao receber a solicitação, o Codex deve:

1. criar automaticamente uma nova execução para a ferramenta se ainda não existir;
2. criar automaticamente, quando necessário, a estrutura persistente da execução;
3. registrar em `DADOS-DA-EXECUCAO.md` os dados fornecidos pelo operador;
4. criar/ler e atualizar `ESTADO-DA-EXECUCAO.md`;
5. organizar ou referenciar a documentação fornecida sem exigir que o operador mova arquivos manualmente apenas para obedecer à estrutura;
6. localizar automaticamente os artefatos produzidos pelas etapas anteriores;
7. resolver identificadores simbólicos como `[NOME_DA_FERRAMENTA]`, `[NOME_DO_ERP]` e `[CAMINHO_...]` usando o prompt atual, o estado persistente, a documentação e os artefatos existentes;
8. nunca pedir ao operador para criar/copiar/renomear pastas ou preencher placeholders dentro deste comando;
9. retornar `PENDENTE` somente quando uma informação realmente necessária não puder ser descoberta nas fontes ou no ambiente.

### Estado persistente

O Codex é responsável por manter automaticamente a memória da execução. Ao concluir ou interromper esta etapa, deve atualizar `ESTADO-DA-EXECUCAO.md` na execução correspondente, registrando no mínimo: etapa atual, status, ferramenta, ERP quando aplicável, artefatos gerados/consultados, pendências, bloqueios e próximo documento permitido.

## Arquivos que devem estar disponíveis

No mínimo, a documentação oficial. Quando existir OpenAPI/Swagger em JSON ou YAML, forneça também o arquivo bruto; ele deve ser preferido para inventário técnico, mantendo PDF/site como fonte complementar.

Se esta etapa exigir acesso autenticado, utilize apenas o arquivo de credenciais indicado na pasta da execução. Não reproduza os valores em relatórios ou respostas.

## Instrução para o Codex

```text
Codex,

estamos iniciando o cadastro de uma ferramenta da E-Catálogos na Fábrica de Integrações.

Ferramenta: [NOME_DA_FERRAMENTA]
Objetivo informado: [OBJETIVO_RESUMIDO_DA_FERRAMENTA]
Documentação oficial: [CAMINHO_DOCUMENTACAO_OFICIAL]
OpenAPI/Swagger bruto, se houver: [CAMINHO_OPENAPI_SWAGGER_JSON_YAML]
Exemplos reais, se houver: [CAMINHO_EXEMPLOS_REAIS]
Regras adicionais, se houver: [CAMINHO_REGRAS_DE_NEGOCIO_EXTRAS]

Nesta etapa NÃO implemente integração e NÃO adapte a ferramenta a nenhum ERP.

Leia integralmente as fontes fornecidas e produza um inventário técnico fiel da ferramenta. O objetivo é entender o contrato que os futuros ERPs deverão atender.

Registre todas as conclusões em arquivos persistentes. Não dependa da memória desta conversa.

Se uma informação não estiver documentada, marque como pendência. Não faça suposições silenciosas.
```

## Regras obrigatórias desta etapa

1. A E-Catálogos e a ferramenta E-Catálogos alvo definem o contrato de destino/origem da integração. O ERP deve ser adaptado a esse contrato, e não o contrário.
2. Não invente endpoints, campos, enums, relacionamentos, regras comerciais, limites, autenticação ou comportamentos que não estejam sustentados pela documentação ou por evidência real do ambiente.
3. Toda suposição necessária deve ser registrada como **PENDÊNCIA** e nunca implementada silenciosamente como verdade.
4. Integrações devem ser avaliadas como **bidirecionais por padrão** para todo módulo aplicável: ERP → ferramenta e ferramenta → ERP. Se uma das APIs não suportar uma direção/operação, registre explicitamente `NAO_SUPORTADO_PELA_API`, com evidência.
5. Para qualquer fluxo bidirecional, identificar e documentar: chave de correlação, idempotência, prevenção de loop, política de conflito e como reconhecer alterações originadas pela própria integração.
6. Credenciais reais podem ser disponibilizadas ao Codex **somente nos arquivos de credenciais locais da execução**, como `credenciais-erp.env` e `credenciais-ferramenta.env`, quando forem necessárias à execução. O Codex pode lê-las e utilizá-las para autenticar, mas não deve copiá-las para código-fonte, relatórios, documentação final, exemplos, logs persistentes ou respostas. Nunca exiba o valor completo de um segredo. Esses arquivos devem permanecer fora do versionamento conforme o `.gitignore`.
7. Não alterar contratos compartilhados ou estrutura comum para “fazer caber” um ERP sem justificar a necessidade e registrar impacto.
8. Quando houver documentação original e arquivos gerados, sempre validar o resultado contra a fonte original; não validar um arquivo gerado usando apenas outro arquivo gerado.
9. Erro isolado de um registro não deve ser escondido. Registrar sucesso, ignorado, pendência e erro separadamente.
10. Não avance para a próxima etapa se existir pendência impeditiva.
11. Inventário por operação deve ser extraído da fonte original da própria operação. É proibido preencher campos técnicos apenas por inferência baseada em verbo HTTP, módulo, padrão de outros endpoints, convenção REST ou arquivo gerado anteriormente.
12. Para cada operação, quando existente na fonte original daquela operação, registrar: descrição; path parameters; query parameters; headers específicos; request body; campos obrigatórios; response body; códigos HTTP; erros; schema/modelo; enums; exemplos; paginação; correlação.
13. Se a fonte não informar um campo da operação, registrar explicitamente `NAO_DOCUMENTADO`.
14. Frases genéricas (por exemplo: "200/201 conforme módulo", "Body JSON conforme schema do módulo", "page/limit quando aplicável", "erpId ou variação por entidade") só podem aparecer como observação complementar, nunca substituindo o contrato documentado da operação.
15. Cada operação deve conter rastreabilidade verificável para a fonte original (preferencialmente página, seção, módulo e rota, ou equivalente disponível).
16. Bidirecionalidade por módulo não pode ser inferida apenas pelo verbo HTTP. A existência de GET + POST/PUT/PATCH não é evidência suficiente.
17. Para cada direção, listar as operações específicas que sustentam a capacidade e justificar pela finalidade/contrato da operação na fonte. Sem evidência suficiente, usar `CAPACIDADE_NAO_CONFIRMADA` ou `NAO_SUPORTADO_PELA_API`, conforme o caso.
18. Antes de marcar `CONCLUIDA`, validar o inventário técnico diretamente contra a documentação original. Não validar arquivo gerado apenas contra outro arquivo gerado.
19. Todos os arquivos Markdown da etapa devem permanecer em UTF-8. Não converter documentação para ASCII nem remover acentos como solução de encoding.

## O Codex deve obrigatoriamente identificar

### Identidade e ambiente
- nome/versionamento da API, se informado;
- URL(s) base;
- ambientes conhecidos;
- tipo de autenticação;
- forma de renovação/expiração de credencial quando documentada.

### Inventário da API
- todos os módulos/tags encontrados;
- todos os endpoints;
- métodos HTTP;
- path/query/header parameters;
- request body;
- response body;
- códigos HTTP documentados;
- schemas/modelos;
- enums;
- exemplos;
- paginação;
- upload/download de arquivos;
- limites/rate limits se documentados.

### Comportamento de negócio
- entidades principais;
- dependências entre entidades;
- ordem provável de cadastro baseada em dependências **com evidência**;
- chaves externas como `erpId` ou equivalentes;
- operações de criação/consulta/atualização/exclusão disponíveis;
- vínculos entre entidades;
- regras explícitas de pedidos, estoque, preço, clientes, representantes etc.

### Bidirecionalidade
Para cada módulo, registre quais operações da própria ferramenta permitem:
- receber dados de ERP;
- fornecer dados para ERP;
- consultar por chave de correlação;
- confirmar integração/estado, quando houver.

Não declarar “bidirecional suportado” apenas porque existem GET e POST genéricos; indicar exatamente quais operações sustentam cada direção.

## Artefato obrigatório

Criar:

```text
analises/ferramentas/<slug-da-ferramenta>/01-analise-documentacao.md
```

O relatório deve conter:

1. fontes analisadas;
2. inventário de módulos;
3. inventário completo de endpoints;
4. autenticação;
5. schemas e entidades;
6. dependências;
7. paginação/rate limits;
8. operações disponíveis por módulo;
9. pontos relevantes para bidirecionalidade;
10. divergências encontradas entre fontes;
11. pendências/perguntas;
12. contagens totais de rotas, métodos e schemas quando possível.

## Critérios de aceite

Só concluir se:

- [ ] todas as fontes fornecidas foram lidas;
- [ ] o inventário de endpoints foi concluído;
- [ ] módulos foram identificados sem inventar categorias;
- [ ] autenticação foi registrada;
- [ ] dependências conhecidas foram registradas;
- [ ] lacunas foram explicitadas;
- [ ] o relatório persistente foi criado;
- [ ] nenhuma implementação de ERP foi iniciada.
- [ ] o inventário técnico por operação foi preenchido por leitura direta da fonte original de cada operação;
- [ ] campos ausentes por operação foram marcados como `NAO_DOCUMENTADO`;
- [ ] cada operação possui rastreabilidade para localização verificável na fonte original;
- [ ] a bidirecionalidade por módulo foi justificada por operações/finalidade, sem inferência apenas por verbo HTTP;
- [ ] a validação final foi feita diretamente contra a documentação original (não apenas entre artefatos gerados);
- [ ] todos os Markdown da etapa permanecem em UTF-8.

## Retorno obrigatório do Codex

Ao finalizar, o Codex deve terminar a resposta com **um e somente um** dos estados abaixo.

### Se a etapa estiver concluída

```text
STATUS DA ETAPA: CONCLUIDA

RESUMO:
<resumo objetivo do que foi realizado>

ARQUIVOS CRIADOS/ALTERADOS:
<lista de arquivos; se nenhum, informar "nenhum">

VALIDACOES EXECUTADAS:
<lista do que foi conferido/testado>

PENDENCIAS:
Nenhuma pendência impeditiva.

PROXIMA ACAO:
Pode me enviar o próximo documento: <nome exato do próximo arquivo>.
```

### Se ainda faltar informação ou ajuste

```text
STATUS DA ETAPA: PENDENTE

RESUMO:
<o que foi possível concluir>

PONTOS QUE AINDA PRECISAM SER AJUSTADOS:
1. <ponto>
2. <ponto>

O QUE PRECISO DO OPERADOR:
1. <informação/arquivo/decisão necessária>
2. <informação/arquivo/decisão necessária>

PROXIMA ACAO:
Ainda precisamos ajustar os pontos informados acima antes de seguir para a próxima documentação.
```

### Se existir impedimento técnico

```text
STATUS DA ETAPA: BLOQUEADA

MOTIVO DO BLOQUEIO:
<causa objetiva e evidência>

O QUE FOI VALIDADO:
<lista>

O QUE PRECISA ACONTECER PARA DESBLOQUEAR:
1. <ação>
2. <ação>

PROXIMA ACAO:
Não envie a próxima documentação até que o bloqueio seja resolvido.
```

**Regra:** nunca usar `CONCLUIDA` apenas porque os arquivos foram criados. O estado `CONCLUIDA` só pode ser usado quando todos os critérios de aceite da etapa tiverem sido realmente verificados.

### Próximo documento se concluído

`parceiros/comandos/02-CADASTRAR-FERRAMENTA.md`
