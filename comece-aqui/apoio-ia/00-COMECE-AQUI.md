# IA de Apoio da Fábrica de Integrações

## Para que serve

A IA de Apoio é uma segunda inteligência que acompanha sua execução no Codex/GitHub Copilot.

Enquanto o Codex trabalha dentro do VS Code com acesso ao repositório, a IA de Apoio trabalha em paralelo, revisando, validando e diagnosticando problemas a partir de informações que você fornece.

**A IA de Apoio NÃO é autoridade sobre a Fábrica.** Ela trabalha dentro de uma hierarquia rígida de regras definida na documentação.

## Fluxo esperado

```
1. Você abre um documento de jornada em comece-aqui/
2. Você envia o prompt para o Codex no VS Code
3. Codex executa o trabalho e retorna evidências
4. Você copia o retorno e envia à IA de Apoio
5. IA de Apoio revisa, classifica e orienta o próximo passo
6. Você volta ao Codex com correção ou avanço
7. Ciclo se repete até conclusão
```

## Referência normativa

Toda a estrutura, regras, jornadas, gates, harness e políticas da Fábrica estão documentadas em:

`documentacao/10-IA-DE-APOIO-DA-FABRICA.md`

A IA de Apoio utiliza esse documento como fonte de autoridade.

## Como começar uma sessão

### Passo 1: Prepare a IA de Apoio

Copie o conteúdo entre as marcações `COPIE A PARTIR DAQUI` e `PARE DE COPIAR AQUI` do arquivo:

`comece-aqui/apoio-ia/PROMPT-IA-DE-APOIO.md`

### Passo 2: Crie uma nova conversa

Abra uma sessão nova em ChatGPT, Claude, Gemini ou outra IA externa.

Cole o prompt que você copiou.

Aguarde a IA confirmar que estará no papel de IA de Apoio da Fábrica.

Ela responderá algo como:

> "Estou preparado para atuar como IA de Apoio da Fábrica de Integrações. Inicie a solicitação no Codex/Copilot dentro do VS Code e me envie o primeiro retorno da execução."

### Passo 3: Execute no Codex

No VS Code, abra o documento operacional na jornada correta:

- `comece-aqui/integrar-nova-ferramenta/01-APRESENTAR-FERRAMENTA.md` (Nova Ferramenta)
- `comece-aqui/integrar-erp/erp-parceiro/01-APRESENTAR-ERP.md` (ERP Parceiro)
- etc.

Copie o texto entre `COPIE A PARTIR DAQUI` e `PARE DE COPIAR AQUI`.

Substitua todos os campos entre colchetes.

Envie ao Codex no chat do VS Code.

### Passo 4: Acompanhe a execução

O Codex executará o trabalho autorizado para aquela etapa.

Quando o Codex retornar, ele fornecerá:

- `STATUS DA ETAPA:` (CONCLUIDA, PENDENTE, BLOQUEADA)
- Artefatos criados/modificados
- Evidências (hashes, testes, validações)
- Próximo passo permitido

### Passo 5: Revise com a IA de Apoio

Copie o retorno completo do Codex.

Cole na conversa com a IA de Apoio.

A IA de Apoio responderá com:

- **RESULTADO:** classificação do que aconteceu (APROVADO, PRECISA_DE_CORRECAO, BLOQUEADO, INFORMACAO_INSUFICIENTE)
- **O QUE FOI FEITO:** resumo da execução
- **EVIDÊNCIAS:** validações encontradas
- **PROBLEMAS:** se houver
- **PRÓXIMA AÇÃO PERMITIDA:** orientação de avanço
- **VALE COMMIT:** se deve versionar agora
- **PROMPT PARA O EXECUTOR:** se houver ação de correção

### Passo 6: Continue o ciclo

Se a IA de Apoio indicar `APROVADO`:

- siga a orientação de próxima ação;
- execute a próxima etapa no Codex quando autorizado;
- retorne com o resultado.

Se indicar `PRECISA_DE_CORRECAO`:

- use o `PROMPT PARA O EXECUTOR` gerado;
- envie para o Codex fazer a correção;
- retorne novamente à IA de Apoio para revisão.

Se indicar `BLOQUEADO`:

- resolva o impedimento indicado;
- quando resolvido, execute novamente ou avance conforme orientado.

## O que NÃO fazer

**Nunca envie para a IA de Apoio:**

- Senhas, tokens, API keys, secrets
- Credenciais reais de produção

A IA de Apoio trabalha apenas com indicadores como:

```
CREDENCIAIS ERP: FORNECIDAS
CREDENCIAIS FERRAMENTA: FORNECIDAS
```

**Nunca ignore a IA de Apoio quando ela indicar BLOQUEADO.**

Se está bloqueado, há um motivo válido. A IA de Apoio está protegendo a Fábrica de passos inválidos.

## Entenda as classificações

### APROVADO

A etapa foi executada corretamente com evidências.

Próxima ação: avanço, novo passo, ou conclusão.

### PRECISA_DE_CORRECAO

O trabalho iniciou, mas há divergência de resultado ou escopo.

Próxima ação: corrigir usando o prompt indicado.

### BLOQUEADO

O trabalho não pode continuar porque:

- pré-requisito não foi atendido;
- gate foi violado;
- etapa posterior tentou ser executada antes da anterior;
- contrato foi alterado indevidamente;
- evidência de qualidade está ausente.

Próxima ação: resolver o impedimento.

### INFORMACAO_INSUFICIENTE

O retorno não forneceu evidência suficiente para classificar.

Exemplos:

- Codex diz "concluído" sem testes;
- Harness não foi rodado;
- Manifesto não foi validado;
- Saída sem exit code.

Próxima ação: solicitar evidência completa ao Codex.

## Memória oficial

A memória oficial da Fábrica **é o repositório**.

Não é a conversa com a IA de Apoio.

Tudo que é importante permanece no repositório:

- `ESTADO-DA-EXECUCAO.md`
- `DADOS-DA-EXECUCAO.md`
- `MANIFESTO-DA-ETAPA.yaml`
- `CHECKPOINT-DA-EXECUCAO.yaml`
- Artefatos producidos
- Auditorias
- Evidências

A conversa com a IA de Apoio é temporária. Use-a para entender e ajudar, não para armazenar decisões.

## Documentos complementares

Se quiser entender profundamente como a Fábrica funciona:

`documentacao/10-IA-DE-APOIO-DA-FABRICA.md`

Esse documento explica os princípios, limitações, jornadas, gates, harness e políticas da Fábrica.

## Prontidão

Quando terminar de preparar a IA de Apoio, você estará pronto para:

- executar etapas;
- revisar trabalho;
- diagnosticar problemas;
- orientar correções;
- decidir quando é seguro versionar.

Bom trabalho!
