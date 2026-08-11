# IA de Apoio da Fábrica de Integrações — Referência Normativa

Este documento explica como a Fábrica de Integrações E-Catálogos funciona internamente, permitindo que uma IA de Apoio compreenda a estrutura, as regras e os limites sem presumir acesso direto ao repositório.

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

Fluxo planejado:

```
01. Apresentar/analisar ERP
    - Entender nome, versão, ambiente
    - Localizar documentação
    - Validar acesso (se houver)
    
02. Analisar ERP x Contrato
    - Comparar capacidades do ERP com contrato homologado
    - Identificar módulos sobrepostos
    - Definir direções (ida, volta, bidirecional)
    
03. Base Comercial de Homologação
    - Definir clientes/empresas de teste
    - SKUs, variantes, packs
    - Estoque, movimentação, preço
    - Criar base DENTRO DO ERP de homologação
    
04. Validação da Base
    - Confirmar dados importados
    - Confirmar visibilidade na ferramenta
    
05. Mapeamento
    - Definir campo por campo ERP → ferramenta
    - Definir transformações (se houver)
    - Documentar exceções
    
06. Desenvolvimento
    - Criar adaptador código
    - Implementar sincronização
    - Implementar tratamento de erro
    - Implementar retry/rate limit
    
07. Testes por Módulo
    - Testar cada fluxo isolado
    - Estoque, pedido, cliente, etc
    
08. Testes Ponta a Ponta
    - Testar ida e volta (se bidirecional)
    - Validar idempotência
    - Validar prevenção de loops
    
09. Homologação
    - Auditoria final
    - Aprovação para reutilização
    
10. Documentação
    - Registrar integração como reutilizável
    - Preparar para clientes
```

**Saída**: Integração reutilizável entre ERP e ferramenta, homologada e documentada.

**IMPORTANTE**: Nunca pule para desenvolvimento sem Base Comercial estar criada e validada NO ERP real. Base é pré-requisito de desenvolvimento.

#### Jornada 3: ERP Cliente

**Objetivo**: Usar integração já homologada com cliente real.

**Pré-requisito**: Combinação ERP x ferramenta já deve estar homologada em ERP Parceiro.

Fluxo:

```
01. Validar homologação
    - Confirmar que a combinação ERP x ferramenta já existe
    
02. Reutilizar adaptador
    - Usar código/configuração já testada
    - NÃO reconstruir
    - NÃO fazer novo adaptador por "sugestão"
    
03. Credenciais do cliente
    - Conectar ao ambiente real do cliente
    
04. Sincronização inicial
    - Importar dados reais do cliente
    
05. Validação de correlação
    - Confirmar que IDs/chaves batem
    - Confirmar que dados chegam corretamente
    
06. Ativação
    - Ligar integração em produção
```

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

| Situação | Jornada |
|----------|---------|
| Ferramenta não homologada | Nova Ferramenta (bloqueie outras) |
| Ferramenta homologada + ERP novo | ERP Parceiro |
| Ferramenta homologada + ERP existente, combinação não homologada | ERP Parceiro |
| Ferramenta homologada + combinação homologada + cliente | ERP Cliente |
| Documentação redundante de algo homologado | Recebida, não altera contrato |

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

### Atualmente Liberadas

**Nova Ferramenta**:
- Passo 01: Apresentar e Analisar Ferramenta
- Passo 02: Cadastrar Ferramenta
- Passo 03: Validar Ferramenta

**ERP Parceiro**:
- Passo 01: Apresentar e Analisar ERP (entrada/triagem apenas)

### Futuras (não executáveis agora)

- ERP Parceiro Passos 02-09
- ERP Cliente Passos 01-06

Quando uma etapa não existe ou não está liberada, registre como lacuna no Harness. Não improvise fluxo permanente silenciosamente.

## 8. PRINCÍPIOS DE DESENVOLVIMENTO

Se o executor criar integração (em ERP Parceiro passo 06 no futuro), deve respeitar:

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
5. Se APROVADO e resolução permitir: preparar para Passo 02 (quando existir)

### Cenário 3: Cliente com ERP já integrado

1. Operador menciona: "Cliente X, ERP Y, Ferramenta Z"
2. Resolução central: combinação já existe? Se sim → ERP Cliente
3. Se não → ERP Parceiro (ir integrar antes)
4. Fluxo Cliente retém dados reais de cliente, reutiliza adaptador

### Cenário 4: Executor tentou pular etapa

1. Codex inicia desenvolvimento em ERP Parceiro Passo 02 (futuro)
2. Mas Base Comercial ainda não foi criada
3. IA de Apoio: BLOQUEADO
4. Motivo: "Base Comercial de Homologação é pré-requisito antes de desenvolvimento"
5. Encaminhar para Passo anterior

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
