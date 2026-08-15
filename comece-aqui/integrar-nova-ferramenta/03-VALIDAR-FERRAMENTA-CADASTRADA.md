# 03 — Validar ferramenta cadastrada

## Quando usar

Use depois que o cadastro canônico da ferramenta tiver sido concluído e aprovado no Passo 02.

Esta etapa verifica se o contrato representa fielmente a ferramenta e se pode ser usado com segurança em futuros mapeamentos com ERPs.

## Antes de começar

Confirme na execução da ferramenta:

- `STATUS DA ETAPA 02: CONCLUIDA`;
- auditoria final vigente do Passo 02: `APROVADA`.

Se esses pré-requisitos não estiverem atendidos, o Passo 03 será bloqueado. Ele não executará nem corrigirá o Passo 02 automaticamente.

## Preciso enviar algum arquivo novo?

Normalmente, não.

O Passo 03 usa a documentação oficial, os artefatos aprovados do Passo 01, o cadastro canônico, a auditoria vigente do Passo 02 e o estado já existentes no repositório.

Se alguma fonte obrigatória não puder ser localizada, o Codex informará exatamente o que falta.

## O que preciso informar

- nome da ferramenta;
- instrução para continuar a execução existente.

## O que não preciso fazer manualmente

- localizar ou listar todos os arquivos da execução;
- calcular hashes;
- comparar módulos e operações;
- editar o contrato canônico;
- criar o relatório de homologação;
- executar a auditoria separadamente;
- criar arquivos de estado;
- instalar pacotes ou alterar a máquina.

## O que mandar para o chat do Codex

### COPIE A PARTIR DAQUI

```text
Execute integralmente:

parceiros/comandos/03-VALIDAR-FERRAMENTA-CADASTRADA.md

Ferramenta:
[NOME DA FERRAMENTA]

Continue a execução existente.

Não avance para outra jornada.
```

### PARE DE COPIAR AQUI

Substitua `[NOME DA FERRAMENTA]` pelo nome real antes de enviar. Os colchetes são marcadores e não devem permanecer no prompt final.

Exemplo:

```text
Execute integralmente:

parceiros/comandos/03-VALIDAR-FERRAMENTA-CADASTRADA.md

Ferramenta:
Força de Vendas

Continue a execução existente.

Não avance para outra jornada.
```

## O que a IA fará

- localizar e validar os pré-requisitos da execução;
- tratar os sete artefatos canônicos como somente leitura;
- registrar hashes antes e depois da validação;
- comparar semanticamente o contrato com as fontes originais e aprovadas;
- verificar rastreabilidade, autenticação, módulos, operações, correlações, dependências, bidirecionalidade e pendências;
- criar `ferramentas/<slug>/HOMOLOGACAO-PARA-INTEGRACOES.md`;
- executar a auditoria do Passo 03 como atividade separada e somente leitura;
- registrar o resultado técnico, a auditoria, o status e a prontidão.

A IA não corrigirá o contrato durante esta etapa.

## O que devo receber

O retorno deve informar separadamente:

- `RESULTADO TECNICO`: `APTO_PARA_INTEGRACOES` ou `NAO_APTO_PARA_INTEGRACOES`;
- `AUDITORIA`: `APROVADA`, `REPROVADA` ou `BLOQUEADA`;
- `PRONTIDAO`: `NAO_HOMOLOGADA`, `AGUARDANDO_AUDITORIA` ou `HOMOLOGADA_PARA_INTEGRACOES`;
- `STATUS DA ETAPA`: `CONCLUIDA`, `PENDENTE` ou `BLOQUEADA`;
- resumo, validações, achados e próxima ação.

Quando executado, o principal artefato técnico será:

`ferramentas/<slug>/HOMOLOGACAO-PARA-INTEGRACOES.md`

## Como interpretar o resultado

- `APTO_PARA_INTEGRACOES` + auditoria `APROVADA` + prontidão `HOMOLOGADA_PARA_INTEGRACOES` + etapa `CONCLUIDA`: ferramenta homologada para futuras integrações;
- `NAO_APTO_PARA_INTEGRACOES` + etapa `PENDENTE`: o contrato possui problema ou insuficiência que precisa ser tratado;
- auditoria `REPROVADA` + etapa `PENDENTE`: a validação ou seu relatório não passou pelo quality gate;
- auditoria `BLOQUEADA` + etapa `BLOQUEADA`: a auditoria não pôde ser concluída;
- pré-requisito ausente + etapa `BLOQUEADA`: volte à etapa indicada e resolva o bloqueio.

Mesmo quando o relatório fundamenta corretamente `NAO_APTO_PARA_INTEGRACOES`, os critérios de homologação não foram atendidos: a auditoria reprova o gate, a ferramenta continua não homologada e a etapa permanece `PENDENTE`.

## O que acontece se encontrar problema

O Passo 03 registra:

- o problema;
- a evidência;
- o artefato responsável;
- a etapa que precisa ser revisitada.

Ele não corrige o contrato. Se o problema pertencer ao cadastro canônico, o operador deverá retornar ao Passo 02. Depois da correção e de nova auditoria válida do Passo 02, execute novamente o Passo 03.

## Quando a ferramenta está pronta para integrar com ERP

Somente quando o operador receber conjuntamente:

```text
RESULTADO TECNICO: APTO_PARA_INTEGRACOES
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
PRONTIDAO: HOMOLOGADA_PARA_INTEGRACOES
```

Se qualquer uma dessas quatro condições estiver ausente, a ferramenta não pode ser utilizada em uma jornada de ERP parceiro.

Pendências não impeditivas podem permanecer, desde que estejam explícitas, rastreáveis e não tornem inseguro o uso do contrato.

## Próxima ação

A ferramenta homologada fica elegível para a resolução de contexto de integrações com ERP. Consulte `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md` para escolher a jornada e o menor passo responsável.

O Passo 03 não executa outra jornada automaticamente. Se o contexto resolver um ERP novo ou uma combinação ainda não homologada, a jornada ERP parceiro possui os Passos 01 a 07 disponíveis e deve começar pelo menor passo aplicável; nunca pule diretamente para o Passo 06.
