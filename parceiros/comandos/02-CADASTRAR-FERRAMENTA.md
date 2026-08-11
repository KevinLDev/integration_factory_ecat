# 02 — Cadastrar ferramenta E-Catálogos como contrato canônico

## Finalidade

Transformar o conhecimento **aprovado** no Passo 01 em cadastro oficial, canônico e reutilizável da ferramenta dentro da Fábrica de Integrações.

Em termos práticos, este passo responde:

> como a análise aprovada passa a existir oficialmente como contrato canônico da ferramenta na fábrica.

## Pré-requisitos obrigatórios

Este passo só pode executar se, na execução da ferramenta:

1. `STATUS DA ETAPA 01: CONCLUIDA`
2. `AUDITORIA ETAPA 01: APROVADA`

Se qualquer pré-requisito não estiver atendido:

`STATUS DA ETAPA: BLOQUEADA`

Regra: o Passo 02 não corrige/refaz silenciosamente o Passo 01.

## Como o operador chama a etapa

```text
Execute integralmente:
parceiros/comandos/02-CADASTRAR-FERRAMENTA.md

Ferramenta: <NOME_DA_FERRAMENTA>
Continue a execução existente.
Não avance para a próxima etapa.
```

## Entradas esperadas

- nome da ferramenta;
- execução existente da ferramenta;
- artefatos aprovados do Passo 01;
- comando e auditoria da etapa 01;
- documentação oficial já referenciada na execução.

## Fontes permitidas e ordem de uso

Usar prioritariamente os artefatos **aprovados** do Passo 01:

1. `01-analise-documentacao.md`
2. `01-inventario-operacoes.md`
3. `01-matriz-bidirecionalidade-modulos.md`
4. `DADOS-DA-EXECUCAO.md`
5. `ESTADO-DA-EXECUCAO.md`
6. `AUDITORIA-ETAPA-01.md`

Fonte original (documentação oficial) permanece obrigatória para rastreabilidade e validação final.

Regra: o Passo 02 não deve reinterpretar a API inteira do zero.

Se houver contradição entre artefato aprovado e fonte original:

- não corrigir silenciosamente;
- registrar divergência;
- marcar `PENDENTE` ou `BLOQUEADA` conforme gravidade/evidência.

## Instrução para o Codex

```text
Codex,

cadastre oficialmente a ferramenta como contrato canônico da fábrica com base no conhecimento aprovado da etapa 01.

1. Valide pré-requisitos de status e auditoria da etapa 01.
2. Use como base os artefatos aprovados da etapa 01.
3. Gere os artefatos canônicos em ferramentas/<slug-da-ferramenta>/.
4. Preserve rastreabilidade para operação, módulo, fonte e pendências.
5. Não invente campos, regras ou capacidades.
6. Registre NAO_DOCUMENTADO quando faltar definição relevante.
7. Atualize o estado para AGUARDANDO_AUDITORIA após gerar os artefatos.
8. Execute a auditoria oficial da etapa via parceiros/auditorias/AUDITAR-ETAPA.md.
9. Só finalize como CONCLUIDA se a auditoria da etapa 02 estiver APROVADA.
```

## O que deve fazer

Quando executado, criar:

`ferramentas/<slug-da-ferramenta>/`

com:

- `README.md`
- `CONTRATO-DA-FERRAMENTA.yaml`
- `MODULOS.md`
- `DEPENDENCIAS.md`
- `BIDIRECIONALIDADE.md`
- `PENDENCIAS.md`
- `FONTES.md`

### Conteúdo mínimo por artefato

#### README.md

Visão rápida da ferramenta, contendo quando aplicável:

- nome;
- empresa responsável;
- slug;
- versão da API;
- especificação;
- base URL;
- autenticação;
- quantidade de módulos;
- quantidade de operações;
- quantidade de rotas;
- status do cadastro;
- quantidade de pendências;
- links para os demais artefatos canônicos.

#### CONTRATO-DA-FERRAMENTA.yaml

Artefato principal estruturado e legível por máquina, contendo quando aplicável:

- identidade da ferramenta;
- API;
- autenticação;
- módulos;
- operações;
- correlações;
- capacidades por direção;
- dependências;
- pendências;
- referências de origem.

Regras:

- cada operação com identificação estável e rastreabilidade;
- YAML sintaticamente válido;
- não inventar valores;
- usar `NAO_DOCUMENTADO` ou referência à pendência correspondente quando faltar definição.

#### MODULOS.md

Visão humana dos módulos e capacidades principais, sem duplicar integralmente o YAML.

#### DEPENDENCIAS.md

Dependências conhecidas entre entidades, baseadas em evidência aprovada do Passo 01.

#### BIDIRECIONALIDADE.md

Por módulo, registrar:

- ERP -> ferramenta;
- ferramenta -> ERP;
- operações que sustentam cada direção;
- correlação;
- confirmação de integração;
- limitações;
- lacunas de idempotência;
- prevenção de loop;
- conflito;
- reprocessamento.

Sem evidência, não declarar capacidade.

#### PENDENCIAS.md

Registrar pendências com identificador estável (`PEND-001`, `PEND-002`, ...), contendo:

- título;
- descrição;
- origem;
- impacto;
- se bloqueia etapas futuras;
- evidência/rastreabilidade.

Nenhuma lacuna do Passo 01 pode desaparecer silenciosamente.

#### FONTES.md

Cadeia de rastreabilidade:

cadastro canônico -> artefatos aprovados do Passo 01 -> execução -> auditoria -> documentação oficial.

## O que não deve fazer

Este passo não pode:

- analisar ERP;
- criar integração;
- criar adaptador;
- gerar código de sincronização;
- testar APIs reais;
- criar base comercial;
- resolver regras ausentes por inferência;
- apagar pendências;
- modificar documentação oficial;
- incluir credenciais;
- avançar para o Passo 03;
- alterar artefatos do Passo 01 apenas para “fazer passar”.

## Regras de rastreabilidade

1. Cada operação do contrato canônico deve apontar para origem verificável.
2. Toda síntese no cadastro deve apontar para artefatos aprovados do Passo 01.
3. Divergências devem ser registradas explicitamente com evidência.
4. Não usar um artefato gerado como única prova para validar outro.

## Critérios de aceite

Só concluir se:

- [ ] Etapa 01 concluída;
- [ ] Auditoria da Etapa 01 aprovada;
- [ ] pasta canônica criada;
- [ ] `README.md` válido;
- [ ] `CONTRATO-DA-FERRAMENTA.yaml` válido;
- [ ] todos os módulos aprovados representados;
- [ ] todas as operações aprovadas representadas;
- [ ] todas as rotas aprovadas representadas;
- [ ] dependências preservadas;
- [ ] bidirecionalidade preservada;
- [ ] pendências preservadas e identificadas;
- [ ] nenhuma informação inventada;
- [ ] rastreabilidade mantida;
- [ ] Markdown em UTF-8;
- [ ] nenhuma credencial persistida;
- [ ] auditoria do Passo 02 executada;
- [ ] auditoria do Passo 02 aprovada.

## Auditoria obrigatória e quality gate

Após gerar o cadastro canônico, o estado da etapa deve ser provisoriamente:

`AGUARDANDO_AUDITORIA`

Em seguida, executar:

`parceiros/auditorias/AUDITAR-ETAPA.md`

Resultado obrigatório para manter etapa concluída:

- `AUDITORIA: APROVADA` -> `STATUS DA ETAPA: CONCLUIDA`
- `AUDITORIA: REPROVADA` -> `STATUS DA ETAPA: PENDENTE`
- `AUDITORIA: BLOQUEADA` -> `STATUS DA ETAPA: BLOQUEADA`

## Retorno obrigatório do Codex

### Se concluir

```text
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA

RESUMO:
<resumo do cadastro canônico gerado>

ARQUIVOS CRIADOS/ALTERADOS:
<lista>

VALIDACOES EXECUTADAS:
<lista>

PENDENCIAS:
<pendências remanescentes, se não impeditivas>

PROXIMA ACAO:
Pode me enviar o próximo documento: parceiros/comandos/03-VALIDAR-FERRAMENTA-CADASTRADA.md
```

### Se faltar ajuste

```text
AUDITORIA: REPROVADA
STATUS DA ETAPA: PENDENTE

RESUMO:
<o que foi feito>

PONTOS QUE AINDA PRECISAM SER AJUSTADOS:
1. <ponto>
2. <ponto>

PROXIMA ACAO:
Ainda precisamos ajustar os pontos acima antes de seguir.
```

### Se bloqueada

```text
AUDITORIA: BLOQUEADA
STATUS DA ETAPA: BLOQUEADA

MOTIVO DO BLOQUEIO:
<causa e evidência>

O QUE PRECISA ACONTECER PARA DESBLOQUEAR:
1. <ação>
2. <ação>

PROXIMA ACAO:
Não envie a próxima documentação até resolver o bloqueio.
```

## Próxima etapa permitida (quando concluída)

`parceiros/comandos/03-VALIDAR-FERRAMENTA-CADASTRADA.md`
