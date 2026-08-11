# Como funcionam as etapas

## Separação por jornada

### 1. Nova ferramenta E-Catálogos

Prepara o contrato canônico de uma ferramenta da própria E-Catálogos.

Etapas disponíveis:

1. apresentar e analisar a ferramenta;
2. cadastrar a ferramenta;
3. validar e homologar tecnicamente o contrato para integrações.

O Passo 03 mantém separados:

- resultado técnico;
- auditoria;
- status da etapa;
- prontidão para integrações.

Somente `APTO_PARA_INTEGRACOES` com auditoria aprovada permite `HOMOLOGADA_PARA_INTEGRACOES`. O próximo passo após o Passo 03 ainda não está disponível para operação.

### 2. ERP parceiro

Terá etapas próprias para analisar um ERP, mapear suas capacidades contra o contrato da ferramenta, desenvolver, testar e homologar uma integração reutilizável.

Essa jornada ainda não possui passos operacionais liberados.

Quando for liberada, deverá bloquear o uso de qualquer ferramenta que não possua Passo 03 concluído, auditoria 03 aprovada e prontidão `HOMOLOGADA_PARA_INTEGRACOES`.

### 3. ERP cliente

Terá etapas próprias para verificar uma combinação ERP + ferramenta já homologada, aplicar configurações e validar as particularidades de um cliente real.

Essa jornada ainda não possui passos operacionais liberados. Se não existir integração homologada para a combinação necessária, o trabalho deverá voltar primeiro à jornada de ERP parceiro.

## Regra de avanço

Uma etapa só libera a próxima quando:

- existir comando técnico e documento operacional humano homologado;
- `STATUS DA ETAPA: CONCLUIDA`;
- a auditoria obrigatória estiver aprovada.

## Papel das três etapas disponíveis

- Passo 01: analisar e compreender tecnicamente a ferramenta.
- Passo 02: cadastrar oficialmente o contrato canônico da ferramenta para reuso na fábrica.
- Passo 03: validar se o contrato é fiel, rastreável e seguro para futuros mapeamentos com ERPs.

## Estado persistente

Cada execução mantém no mínimo, quando aplicável:

- `DADOS-DA-EXECUCAO.md`;
- `ESTADO-DA-EXECUCAO.md`.

Esses arquivos são a continuidade oficial entre sessões.
