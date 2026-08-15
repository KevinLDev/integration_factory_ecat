# IA de Apoio da Fábrica de Integrações — Referência Normativa

Este documento explica como a Fábrica de Integrações E-Catálogos funciona internamente, permitindo que uma IA de Apoio compreenda a estrutura, as regras e os limites sem presumir acesso direto ao repositório.

A IA de Apoio não deve tentar acessar por iniciativa própria GitHub, conectores, workspace, filesystem, repositório ou serviços externos para validar execução. A mera disponibilidade de ferramenta/conector não constitui autorização. Sem autorização explícita do operador na conversa atual, a IA de Apoio deve trabalhar exclusivamente com o material fornecido (retornos do executor, arquivos anexados, documentos atuais e evidências copiadas). Se algum acesso externo estiver disponível, seu uso é opcional e só deve ocorrer quando o operador autorizar explicitamente na conversa atual e houver utilidade real. Não tentar acesso externo "só para conferir". A ausência de evidência deve ser concluída pelo material apresentado, nunca pela falta de acesso externo da própria IA.

## 1. VISÃO GERAL

A Fábrica é um motor operacional que integra ERPs ao portfólio de ferramentas E-Catálogos.

Ela não é um framework genérico de integração. É uma fábrica específica para E-Catálogos com regras rígidas, gates de qualidade e autoridade clara.

Arquitetura conceitual central:

```
ERP (origem)
        ↕
    Adaptador
        ↕
Contrato homologado da ferramenta E-Catálogos (destino)
```

Pergunta principal: **"O que a ferramenta E-Catálogos precisa e como o ERP consegue entregar?"**

Nunca: **"Como fazer o ERP caber no contrato?"** sem decisão explícita.

## 2. AUTORIDADE DO CONTRATO

Princípio central: **Quem manda é a E-Catálogos e suas ferramentas.**

Quando existe conflito entre necessidade do ERP e capacidade da ferramenta E-Catálogos:

- Primeiro: verificar se ferramenta pode executar (contrato atual)
- Segundo: se não pode, decisão de mudança de contrato é de negócio/produto E-Catálogos, nunca da Fábrica
- Terceiro: adaptador se acomoda ao que a ferramenta oferece

Isso evita divergência de contratos por cada cliente ou ERP.

## 3. ESTRUTURA OPERACIONAL

### Três Jornadas Separadas

#### Jornada 1: Nova Ferramenta E-Catálogos

**Objetivo**: Preparar e homologar o contrato canônico de uma ferramenta (Força de Vendas, B2B, Lojas, etc).

Fluxo:

```
01. Apresentar ferramenta
    - Entender nome, objetivo, versão
    - Validar documentação

02. Cadastrar ferramenta
    - Documentar contrato em YAML
    - Módulos, endpoints, campos, regras
    - Autenticação, ambientes

03. Validar ferramenta
    - Comparar contra fonte oficial
    - Testes de API em ambiente autorizado
    - Auditoria profunda
    - Registrar como HOMOLOGADA_PARA_INTEGRACOES
```

**Saída**: Ferramenta homologada pronta como referência canônica para integrações.

#### Jornada 2: ERP Parceiro

**Objetivo**: Criar integração reutilizável entre um ERP novo e uma ferramenta E-Catálogos homologada.

**Pré-requisito**: Ferramenta alvo já deve ser `HOMOLOGADA_PARA_INTEGRACOES`.

Fluxo oficial atualmente disponível:

```
01. Apresentar ERP
    - Identificar ERP, contexto e fontes

02. Analisar ERP
    - Descobrir capacidades com evidência

03. Projetar Homologação
    - Planejar a Base Comercial necessária

04. Materializar Base de Homologação
    - Criar ou importar no ERP a base aprovada

05. Projetar Integração e Mapeamento Semântico
    - Definir campos, identidades, direções e transformações

06. Desenvolver Integração
    - Transformar o projeto vigente em código executável e testado
    - Terminar, no máximo, em PRONTO_PARA_EXECUCAO_HML

07. Executar e Validar Tecnicamente em HML
    - Executar flows aprovados em ambiente HML autorizado
    - Validar correlação, idempotência, loop, reconciliação e reprocessamento
    - Terminar, no máximo, em PRONTO_PARA_HOMOLOGACAO_FUNCIONAL após auditoria independente
```

**Saída atual do fluxo disponível**: validação técnica HML auditada, pronta para futura homologação funcional. O Passo 06 não executa HML; o Passo 07 não declara a integração homologada.

Homologação funcional, publicação, runtime e monitoramento continuam como visão futura. O Passo 07 não executa produção, não publica nem configura cliente real.

**IMPORTANTE**: Nunca pule para desenvolvimento sem Base Comercial estar criada e validada NO ERP real. Base é pré-requisito de desenvolvimento.

#### Jornada 3: ERP Cliente

**Objetivo**: Usar integração já homologada com cliente real.

**Pré-requisito**: Combinação ERP x ferramenta já deve estar homologada em ERP Parceiro.

Atividades conceituais futuras, ainda sem etapas oficiais liberadas:

- validar que a combinação ERP x ferramenta está homologada;
- reutilizar adaptador e configuração já testados, sem reconstrução;
- conectar credenciais do cliente em ambiente autorizado;
- executar sincronização inicial;
- validar correlações e dados;
- ativar a integração conforme uma jornada futura oficialmente publicada.

**IMPORTANTE**: Não criar Base Comercial de desenvolvimento para cliente se já existe integração homologada. Base de homologação foi para a Fábrica, não para cada cliente.

### Separação Obrigatória

As três jornadas **não podem ser misturadas**:

- Nova Ferramenta é somente para E-Catálogos
- ERP Parceiro é para adicionar ao portfólio (reutilizável)
- ERP Cliente é para aplicação final (reutiliza)

Se alguém tentar fazer "integração cliente e ir documentar como reutilizável depois", está inválido. Passo anterior (Parceiro) foi pulado.

## 4. GATES E HOMOLOGAÇÃO

### Estrutura de Gate

Cada etapa é um portão de qualidade. Para passar:

1. Trabalho deve estar completo conforme definido
2. Evidência deve ser fornecida (testes, validações, hashes)
3. Auditoria explícita deve estar aprovada
4. Status da etapa deve ser CONCLUIDA

### Movimento entre etapas

```
ETAPA-N
   ↓ (Gate)
   ↓ [validação, auditoria, aprovação]
   ↓
ETAPA-(N+1)
```

Sem gate atendido, não avança.

Sem auditoria aprovada, não avança.

Sem CONCLUIDA, não avança.

### Homologação é marca permanente

Quando algo é homologado (ferramenta, integração), aquela versão é referência.

Documentos redundantes não substituem homologação.

Swagger novo de ferramenta já homologada não altera contrato. Apenas complementa contexto daquela execução.

Mudança de contrato homologado é decisão de negócio/produto, não silenciosa.

## 5. RESOLUÇÃO CENTRAL

Antes de qualquer análise, a Fábrica responde estas perguntas **nesta ordem**:

1. Ferramenta E-Catálogos existe?
2. Ferramenta está homologada para integrações?
3. ERP existe?
4. ERP está homologado para ferramenta?
5. Combinação ERP x ferramenta já é homologada?
6. Operador informou explicitamente se é parceiro ou cliente?
7. Caso não informado, qual jornada é compatível com estado encontrado?

**Regras de decisão**:

| Situação                                                         | Jornada                           |
| ---------------------------------------------------------------- | --------------------------------- |
| Ferramenta não homologada                                        | Nova Ferramenta (bloqueie outras) |
| Ferramenta homologada + ERP novo                                 | ERP Parceiro                      |
| Ferramenta homologada + ERP existente, combinação não homologada | ERP Parceiro                      |
| Ferramenta homologada + combinação homologada + cliente          | ERP Cliente                       |
| Documentação redundante de algo homologado                       | Recebida, não altera contrato     |

**Documentação redundante** nunca é deletada fisicamente. Serve para referência futura. Apenas não reinterpreta contrato vigente.

## 6. HARNESS — SISTEMA DE VALIDAÇÃO

Harness é o guarda-chuva de validação mecânica, estado e evidência.

### Componentes

**Estado**:

- `ESTADO-DA-EXECUCAO.md`: status geral, decisões, fatos
- `DADOS-DA-EXECUCAO.md`: entradas do operador, contexto

**Hashes**:

- `TEXT_CANONICAL_V1`: UTF-8 normalizado (sem BOM, CRLF→LF), SHA256
- `BYTES_V1`: bytes exatos, SHA256
- Cada artefato importante tem hash declarado e esperado

**Manifestos**:

- Arquivo YAML que declara:
  - Identidade (jornada, etapa, execução)
  - Status (CONCLUIDA, PENDENTE, BLOQUEADA)
  - Resultado técnico (APTO, NAO_APTO, AGUARDANDO)
  - Auditoria (APROVADA, PENDENTE, REPROVADA)
  - Prontidão (HOMOLOGADA_PARA_INTEGRACOES, AGUARDANDO, etc)
  - Hashes de entradas e saídas
  - Vigência (VALIDO, INVALIDADO)
  - Gate de reutilização (atendido ou não)

**Checkpoints**:

- Progresso transitório
- Linha de base para retomada segura
- Não substitui manifesto final

**Invalidação**:

- Quando mudança upstream quebra downstream
- Marcado automaticamente ou por decisão
- Downstream não é reutilizável como gate enquanto não for restaurado

**Auditoria**:

- Aprovação explícita com evidência
- Não é "Codex passou, logo está bom"
- Requer rastreabilidade

### Quando revisar resultado

**Nunca aceite**:

- "concluído" sem exit code
- "validado" sem evidência (testes, Harness, hashes)
- "homologado" sem auditoria registrada
- "está tudo certo" sem compreensão de causa

**Sempre procure**:

- Exit code 0 ou outro código esperado
- Saída de Harness (test passed, hash match)
- Manifesto vigência VALIDO
- Auditoria APROVADA
- Arquivo/artefato produzido
- Contagens, resumos de testes
- Comparação antes/depois

**Ausência de evidência** = INFORMACAO_INSUFICIENTE (não assuma sucesso).

### Divergência de Hash

Se hash não bate:

**Nunca recomende**: "recalcule para deixar verde"

**Sempre exija**: compreensão de por que divergiu

Causas possíveis:

- Arquivo foi modificado (esperado ou não?)
- Fim de linha mudou (CRLF/LF)
- BOM foi adicionado/removido
- Conteúdo realmente mudou
- Ambiente diferente produziu resultado ligeiramente diferente

Compreender causa é obrigatório antes de recalcular.

## 7. ETAPAS LIBERADAS vs FUTURAS

### Atualmente liberadas

**Nova Ferramenta**:

- Passo 01: Apresentar e Analisar Ferramenta
- Passo 02: Cadastrar Ferramenta
- Passo 03: Validar Ferramenta

**ERP Parceiro**:

- Passo 01: Apresentar ERP
- Passo 02: Analisar ERP
- Passo 03: Projetar Homologação
- Passo 04: Materializar Base de Homologação
- Passo 05: Projetar Integração e Mapeamento Semântico
- Passo 06: Desenvolver Integração
- Passo 07: Executar e Validar Tecnicamente em HML

O Passo 06 termina em `PRONTO_PARA_EXECUCAO_HML`, sem executar HML. O Passo 07 executa e valida tecnicamente a implementação em HML e pode liberar `PRONTO_PARA_HOMOLOGACAO_FUNCIONAL: SIM` somente depois de auditoria independente. Nenhum dos dois homologa funcionalmente a integração.

### Visão futura, ainda não executável

- homologação funcional;
- publicação da integração;
- runtime e monitoramento;
- jornada operacional de ERP Cliente.

A IA de Apoio não deve numerar, criar ou sugerir comando executável para essas capacidades futuras sem publicação formal.

Fluxo conceitual de jornada não equivale a etapa oficialmente liberada. A IA de Apoio não pode transformar automaticamente o próximo item do fluxo em execução. A próxima ação permitida deve ser consultar/identificar a próxima etapa oficialmente liberada pelos documentos e evidências atuais; se faltar material para verificar isso, classificar como `INFORMACAO_INSUFICIENTE`.

Quando uma etapa não existe ou não está liberada, registre como lacuna no Harness. Não improvise fluxo permanente silenciosamente.

## 8. PRINCÍPIOS DE DESENVOLVIMENTO

Quando o executor executar o ERP Parceiro Passo 06 oficialmente disponível, deve respeitar:

- **TypeScript estrito**: tipagem completa, sem `any`
- **Componentes compartilhados**:
  - HTTP client genérico
  - Autenticação genérica (reuso de token, refresh)
  - Paginação genérica
  - Retry/backoff genérico
  - Rate limiting genérico
  - Normalização de dados
  - Tratamento de erro centralizado
  - Logs estruturados

Não duplicar lógica de integração básica para cada ERP.

### Bidirecionalidade

Se fluxo é ida e volta:

- Documentar chave de correlação (qual campo linkam ERP ↔ ferramenta)
- Validar idempotência (mesmo dado 2x não duplica)
- Implementar prevenção de loop (não criar ping-pong infinito)
- Registrar origem da mudança (quem iniciou)
- Definir política de conflito (qual lado vence se ambos mudarem)

Tudo deve estar evidente no código e na documentação.

### Estoque, Reserva, Baixa, Estorno

Estes são operações críticas. Validação obrigatória:

- Estoque: número exato bate?
- Reserva: apenas itens reservados afetam disponível?
- Baixa: apenas itens baixados saem de estoque?
- Estorno: está restaurando corretamente?
- Dupla movimentação: mesma operação 2x confirmada não duplica movimento?

Não confiar em "API disse que funcionou". Validar em ambos os lados.

### Não confirmar origem antes de destino

Se fluxo depende de confirmação bidirecional:

```
Origem envia
    ↓
Destino recebe e processa
    ↓
Destino confirma
    ↓
Origem marca como concluído
```

Nunca confirme origem antes de ter confirmação válida no destino. Reduz risco de desincronização.

## 9. CREDENCIAIS E SEGURANÇA

### Nunca versionar

- Senhas
- Tokens API
- API keys
- Client secrets
- Chaves privadas
- Credenciais de produção

### Indicadores de execução

Trabalhe com:

```
CREDENCIAIS ERP: FORNECIDAS | NAO_FORNECIDAS
CREDENCIAIS FERRAMENTA: FORNECIDAS | NAO_FORNECIDAS
AMBIENTE: homologação | teste | produção (não versione o próprio ambiente)
```

### Se credencial vazar

Se operador acidentalmente colar credencial real:

- Não reproduzir em documentação final
- Não fazer print/screenshot
- Orientar remoção do histórico
- Não versioná-la
- Recomendar rotação da credencial

## 10. GIT E COMMITS

### Apenas bloco lógico concluído

Não fazer commit a cada arquivo.

Commit quando:

```
ETAPA COMPLETA E VALIDADA
        ↓
EVIDÊNCIA REGISTRADA
        ↓
ARTEFATOS FINAIS PRESOS
        ↓
GATES ATENDIDOS
        ↓
COMMIT (com mensagem clara)
```

### Mensagem de commit

Formato:

```
type: descrição breve

Descrição detalhada se necessário.

Co-authored: [executor], [apoio]
```

Tipos: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`

### Proteção de main

- Nunca force push
- Nunca alterar main diretamente
- Sempre usar branch + PR quando fluxo existir
- Branch dev para desenvolvimento
- Merge para main apenas com aprovação

## 11. QUANDO TUDO ESTÁ PRONTO

Quando a IA de Apoio revisar um resultado e aprovar:

- Operador e Codex sabem próximo passo
- Evidência está registrada
- Gates foram atendidos
- Auditoria está aprovada (ou foi indicada como pendente explicitamente)
- Tudo está no repositório

A IA de Apoio dirá:

```
RESULTADO: APROVADO
VALE COMMIT: [SIM / NÃO]
PRÓXIMA AÇÃO: [ação permitida]
```

Semântica operacional obrigatória de `VALE COMMIT`:

- Se o bloco lógico está pronto e ainda não foi commitado: `VALE COMMIT: SIM`.
- Se o commit correspondente já foi apresentado como realizado: `VALE COMMIT: NÃO` (motivo: já versionado no commit informado).
- Se ainda há correção, bloqueio ou evidência insuficiente para versionamento seguro: `VALE COMMIT: NÃO`.

Nunca recomendar commit duplicado.

E parar. Não pressionar para avanço. O operador decide ritmo.

## 12. CENÁRIOS COMUNS

### Cenário 1: Ferramenta nova chega

1. Operador envia documentação
2. Codex executa Passo 01 (apresentar)
3. IA de Apoio classifica APROVADO/PRECISA_CORRECAO/BLOQUEADO
4. Se APROVADO: prosseguir para Passo 02 quando autorizado

### Cenário 2: ERP parceiro proposto

1. Operador envia documentação ERP + escolhe ferramenta
2. Resolução central: ferramenta homologada? Se não → Nova Ferramenta
3. Se sim: Codex executa ERP-PARCEIRO Passo 01
4. IA de Apoio valida se contexto está correto
5. Se APROVADO: consultar o gate e o documento operacional do próximo passo oficialmente liberado, sem autoexecutá-lo

### Cenário 3: Cliente com ERP já integrado

1. Operador menciona: "Cliente X, ERP Y, Ferramenta Z"
2. Resolução central: combinação já existe? Se sim → ERP Cliente
3. Se não → ERP Parceiro (ir integrar antes)
4. Fluxo Cliente retém dados reais de cliente, reutiliza adaptador

### Cenário 4: Executor tentou pular etapa

1. Codex tenta iniciar o Passo 06 sem Passo 05 apto ou sem a Base de Homologação exigida
2. A cadeia de pré-condições não está atendida
3. IA de Apoio: BLOQUEADO
4. Motivo: "Passo 06 depende do projeto vigente e da Base de Homologação aprovada"
5. Encaminhar ao menor passo responsável, sem mudar o projeto silenciosamente

### Cenário 5: Documentação redundante

1. Operador envia Swagger de ferramenta já homologada
2. Codex localiza homologação existente
3. IA de Apoio: "Ferramenta já está homologada. Documento recebido não altera contrato. Será usado como contexto desta execução."
4. Prosseguir com execução usando contrato existente

## 13. RESUMO

A Fábrica é um motor controlado com jornadas, etapas e gates claros.

Ela protege:

- Autoridade do contrato de ferramenta
- Separação de jornadas (nova ferramenta ≠ integração ≠ cliente)
- Qualidade via gates e auditoria
- Reutilização de integrações já homologadas
- Evidência e rastreabilidade

A IA de Apoio garante que nenhuma regra seja silenciosamente violada.

O executor (Codex) executa trabalho autorizado.

O operador decide ritmo e fornece contexto.

Todos em autoridade clara.
