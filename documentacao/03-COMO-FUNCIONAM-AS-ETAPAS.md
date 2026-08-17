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

Somente `APTO_PARA_INTEGRACOES` com auditoria aprovada permite `HOMOLOGADA_PARA_INTEGRACOES`. A ferramenta homologada fica disponível ao resolvedor central de contexto; isso não inicia automaticamente outra jornada.

### 2. ERP parceiro

Possui etapas próprias para identificar e analisar um ERP, projetar e materializar a Base de Homologação, mapear a integração e desenvolver uma implementação reutilizável.

Os Passos 01 a 09 estao disponiveis em ordem. O Passo 06 termina em `PRONTO_PARA_EXECUCAO_HML`; o Passo 07 executa e valida tecnicamente a implementacao em HML; o Passo 08 homologa funcionalmente a combinacao em modelo manual assistido por IA, sem automacao de navegador; o Passo 09 consolida e publica a combinacao homologada para reutilizacao por cliente.

A jornada deve bloquear o uso de qualquer ferramenta que nao possua Passo 03 concluido, auditoria 03 aprovada e prontidao `HOMOLOGADA_PARA_INTEGRACOES`. O Passo 07 so pode liberar prontidao para homologacao funcional depois de auditoria independente aprovada. O Passo 08 so pode liberar `INTEGRACAO_HOMOLOGADA: SIM` depois de auditoria independente aprovada do proprio Passo 08. O Passo 09 so pode liberar `INTEGRACAO_PUBLICADA: SIM` e `DISPONIVEL_PARA_CLIENTE: SIM` depois de auditoria independente aprovada do proprio Passo 09.

### 3. ERP cliente

Terá etapas próprias para verificar uma combinação ERP + ferramenta já homologada, aplicar configurações e validar as particularidades de um cliente real.

Essa jornada ainda não possui passos operacionais liberados. Se não existir integração homologada para a combinação necessária, o trabalho deverá voltar primeiro à jornada de ERP parceiro.

## Regra de avanço

Uma etapa só libera a próxima quando:

- existir comando técnico e documento operacional humano homologado;
- `STATUS DA ETAPA: CONCLUIDA`;
- a auditoria obrigatória estiver aprovada.

## Papel das três etapas de Nova Ferramenta

- Passo 01: analisar e compreender tecnicamente a ferramenta.
- Passo 02: cadastrar oficialmente o contrato canônico da ferramenta para reuso na fábrica.
- Passo 03: validar se o contrato é fiel, rastreável e seguro para futuros mapeamentos com ERPs.

## Estado persistente

Cada execução mantém no mínimo, quando aplicável:

- `DADOS-DA-EXECUCAO.md`;
- `ESTADO-DA-EXECUCAO.md`.

Esses arquivos são a continuidade oficial entre sessões.
