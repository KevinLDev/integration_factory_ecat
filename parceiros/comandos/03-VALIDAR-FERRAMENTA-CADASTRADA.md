# 03 — Validar ferramenta cadastrada para integrações

## Finalidade

Homologar tecnicamente o contrato canônico de uma ferramenta E-Catálogos para uso confiável em futuros mapeamentos e integrações com ERPs.

Esta etapa responde:

> O contrato canônico representa fielmente a ferramenta e está tecnicamente pronto para ser utilizado como fonte confiável nas futuras integrações com ERPs?

As responsabilidades são distintas:

- Passo 01: descobrir o que existe tecnicamente na ferramenta;
- Passo 02: cadastrar o contrato canônico oficial dentro da fábrica;
- Passo 03: verificar se esse contrato é fiel, suficiente, rastreável e seguro para orientar integrações futuras.

O Passo 03 é uma homologação técnica para integrações. Ele não substitui nem repete a auditoria do Passo 02: a auditoria 02 verifica a execução do cadastro; o Passo 03 avalia a prontidão do resultado final como contrato operacional para ERP.

## Pré-requisitos obrigatórios

Este passo só pode executar quando, na execução correspondente à ferramenta:

1. o Passo 02 estiver com `STATUS DA ETAPA: CONCLUIDA`;
2. a auditoria final vigente da Etapa 02 estiver `APROVADA`.

A auditoria vigente deve ser a evidência válida mais recente após qualquer correção ou reauditoria. O Codex deve:

- localizar o relatório vigente indicado em `ESTADO-DA-EXECUCAO.md`;
- conferir o histórico preservado de auditorias da Etapa 02;
- confirmar que o relatório vigente corresponde à versão atual dos artefatos canônicos;
- não selecionar uma auditoria antiga apenas porque ela contém o texto `APROVADA`;
- retornar `BLOQUEADA` se houver ambiguidade sobre qual auditoria é a vigente.

Se qualquer pré-requisito não estiver atendido:

```text
STATUS DA ETAPA: BLOQUEADA
```

O Passo 03 não pode executar, refazer ou corrigir o Passo 02 automaticamente.

## Como o operador chama a etapa

```text
Execute integralmente:

parceiros/comandos/03-VALIDAR-FERRAMENTA-CADASTRADA.md

Ferramenta:
<NOME_DA_FERRAMENTA>

Continue a execução existente.

Não avance para outra jornada.
```

O operador informa apenas a ferramenta. O Codex deve localizar automaticamente a execução, o estado, as fontes e os artefatos correspondentes. Se houver mais de uma execução compatível e não for possível escolher com segurança, retornar `BLOQUEADA` sem adivinhar.

## Entradas esperadas

- nome da ferramenta;
- execução existente da ferramenta;
- documentação oficial original já referenciada;
- artefatos aprovados do Passo 01;
- cadastro canônico produzido no Passo 02;
- comando e critérios de aceite do Passo 02;
- auditoria final vigente e aprovada do Passo 02;
- estado atual da execução;
- este comando e seus critérios de prontidão.

O operador não deve ser obrigado a informar caminhos que possam ser descobertos de forma inequívoca no estado e nos artefatos persistentes.

## Fontes obrigatórias e ordem de autoridade

Usar conjuntamente:

1. documentação oficial original da ferramenta;
2. artefatos aprovados do Passo 01;
3. cadastro canônico produzido no Passo 02;
4. `parceiros/comandos/02-CADASTRAR-FERRAMENTA.md` e seus critérios de aceite;
5. auditoria final vigente e aprovada do Passo 02;
6. `ESTADO-DA-EXECUCAO.md` atual;
7. este comando e seus critérios de prontidão.

A documentação oficial continua sendo a autoridade final. Um arquivo gerado não pode ser validado apenas por concordar com outro arquivo gerado. Divergências devem ser verificadas até a fonte original sempre que ela estiver disponível.

## Contrato sob validação — somente leitura

Os sete artefatos canônicos abaixo são entradas protegidas e imutáveis durante todo o Passo 03:

```text
ferramentas/<slug>/README.md
ferramentas/<slug>/CONTRATO-DA-FERRAMENTA.yaml
ferramentas/<slug>/MODULOS.md
ferramentas/<slug>/DEPENDENCIAS.md
ferramentas/<slug>/BIDIRECIONALIDADE.md
ferramentas/<slug>/PENDENCIAS.md
ferramentas/<slug>/FONTES.md
```

Também são somente leitura durante esta etapa: documentação oficial, artefatos do Passo 01, comando do Passo 02, auditoria vigente do Passo 02 e demais evidências usadas como fonte.

### Protocolo obrigatório de integridade

Antes de qualquer validação semântica:

1. declarar os sete caminhos resolvidos;
2. confirmar a existência dos sete arquivos;
3. calcular SHA-256 dos bytes de cada arquivo;
4. registrar caminho, tamanho e hash inicial em `HOMOLOGACAO-PARA-INTEGRACOES.md`;
5. quando a auditoria vigente do Passo 02 contiver hashes finais, comparar a linha de base atual com eles e registrar o resultado.

Depois da validação semântica e antes da auditoria do Passo 03:

1. recalcular os sete hashes;
2. registrar os hashes finais;
3. comparar cada hash final com o respectivo hash inicial;
4. exigir igualdade integral.

Se qualquer artefato canônico mudar:

- não restaurar, corrigir nem regravar o arquivo;
- registrar a divergência como falha de integridade;
- usar `RESULTADO TECNICO: NAO_APTO_PARA_INTEGRACOES`;
- usar `STATUS DA ETAPA: PENDENTE` após a auditoria aplicável.

## Instrução para o Codex

```text
Codex,

valide o contrato canônico da ferramenta para uso futuro em integrações com ERPs.

1. Localize a execução e valide os pré-requisitos do Passo 02.
2. Resolva a auditoria final vigente e aprovada do Passo 02 sem escolher evidência histórica inválida.
3. Trate os sete artefatos canônicos como somente leitura.
4. Registre a linha de base SHA-256 antes da validação semântica.
5. Compare semanticamente fonte oficial, Passo 01 aprovado, Passo 02 e contrato canônico.
6. Não invente dados e preserve NAO_DOCUMENTADO quando a fonte não definir algo.
7. Gere ferramentas/<slug>/HOMOLOGACAO-PARA-INTEGRACOES.md.
8. Recalcule os hashes e confirme que os sete canônicos permaneceram idênticos.
9. Encerre a fase de execução com prontidão provisória e congele o relatório.
10. Execute a auditoria oficial como atividade separada via parceiros/auditorias/AUDITAR-ETAPA.md.
11. Só conclua a etapa e homologue a ferramenta se o quality gate triplo for atendido.

Não corrija o contrato durante esta etapa, não crie integração de ERP e não avance para outra jornada.
```

## Fluxo obrigatório da etapa

1. localizar inequivocamente a execução;
2. validar os pré-requisitos;
3. localizar e validar a auditoria vigente do Passo 02;
4. declarar todas as fontes e entradas protegidas;
5. iniciar o relatório e registrar os hashes iniciais;
6. executar a validação semântica completa;
7. registrar achados e decidir o resultado técnico;
8. recalcular e comparar os hashes finais;
9. finalizar `HOMOLOGACAO-PARA-INTEGRACOES.md`;
10. registrar estado transitório e prontidão provisória;
11. congelar o relatório e encerrar a fase de execução;
12. iniciar uma auditoria separada e somente leitura via `parceiros/auditorias/AUDITAR-ETAPA.md`;
13. aplicar o quality gate especializado do Passo 03;
14. atualizar somente os campos de controle autorizados no estado;
15. retornar um dos status finais permitidos.

## Validação semântica completa

Contagens são verificações auxiliares; igualdade de contagens não comprova fidelidade. Todos os itens descobertos nas fontes devem ser comparados por conteúdo e significado.

### Identidade da ferramenta

Validar, quando aplicável:

- nome;
- slug;
- responsável;
- versão;
- especificação;
- base URL;
- ambientes conhecidos.

### Autenticação

Validar, quando documentado:

- tipo;
- operação de autenticação;
- campos necessários;
- retorno;
- token;
- expiração;
- renovação;
- lacunas explicitamente documentadas.

### Módulos

Validar que:

- todos os módulos aprovados estão representados;
- nenhum módulo foi inventado;
- a responsabilidade de cada módulo é fiel à fonte;
- as operações correspondentes estão completas e associadas corretamente.

### Operações

Cada operação aprovada deve ser rastreável e comparada semanticamente. Validar, quando documentado:

- identificador;
- módulo;
- método;
- rota;
- finalidade;
- parâmetros de path, query e headers específicos;
- campos e obrigatoriedade;
- request body;
- response body;
- códigos de sucesso;
- erros;
- paginação;
- upload e download;
- enumerações;
- correlação;
- fonte original.

Quando a fonte não possuir uma informação, `NAO_DOCUMENTADO` deve permanecer explícito. Não preencher lacunas por inferência, convenção REST, verbo HTTP, padrão de outro endpoint ou memória de conversa.

## Cobertura para futuras integrações

Responder explicitamente no relatório:

> Uma IA que futuramente receber a documentação de um ERP consegue utilizar este contrato canônico para mapear ERP x ferramenta sem reconstruir o entendimento da ferramenta do zero?

Verificar, quando aplicável:

- módulos e operações disponíveis;
- entidades e campos;
- identificadores e chaves de correlação;
- relações e dependências entre entidades;
- ordem necessária sustentada por evidência;
- possibilidades de criação, atualização, consulta e exclusão;
- confirmação de integração;
- capacidades de ida e de volta;
- limitações.

O relatório deve distinguir claramente:

- o que é suportado com evidência;
- o que é `NAO_SUPORTADO_PELA_API` com evidência;
- o que é `NAO_DOCUMENTADO`;
- o que permanece pendente ou não confirmado.

Não exigir que todas as funções sejam bidirecionais.

## Bidirecionalidade

Validar cada módulo nas duas perspectivas:

```text
ERP -> ferramenta
ferramenta -> ERP
```

Para cada direção, verificar:

- operações específicas que sustentam a capacidade;
- finalidade documentada dessas operações;
- chave de correlação;
- confirmação de integração;
- idempotência;
- prevenção de loop;
- política de conflito;
- reprocessamento;
- limitações.

Nunca considerar uma direção suportada apenas pela existência de um verbo HTTP. Sem evidência suficiente, preservar `NAO_DOCUMENTADO` ou a pendência correspondente.

## Dependências

Validar se as dependências necessárias para um futuro integrador entender entidades, relações e ordem estão representadas com evidência.

Exemplos meramente conceituais, que não devem virar regra genérica:

```text
empresa -> marca -> categoria -> produto
produto -> variante -> SKU -> preço
```

Usar somente relações sustentadas pelas fontes da ferramenta analisada. O entendimento deve permanecer no repositório e não depender da memória de uma conversa.

## Pendências

Validar se todas as pendências conhecidas estão preservadas e contêm, quando aplicável:

- identificador estável;
- origem;
- descrição;
- impacto;
- evidência;
- classificação de bloqueio.

Pendência não impede automaticamente a homologação. Uma pendência pode ser não impeditiva quando estiver explícita, possuir impacto conhecido e não tornar inseguro o uso do contrato no mapeamento futuro.

Se não for possível determinar com segurança se uma pendência bloqueia, não inventar classificação. Registrar achado e usar `NAO_APTO_PARA_INTEGRACOES` até existir evidência ou decisão válida.

## Rastreabilidade

Deve ser possível navegar conceitualmente:

```text
Contrato canônico
        ↓
artefato aprovado do Passo 01
        ↓
execução persistente
        ↓
documentação oficial
```

Para operações relevantes, deve ser possível voltar à evidência original. Se a rastreabilidade estiver quebrada, o resultado técnico obrigatório é `NAO_APTO_PARA_INTEGRACOES`.

## Artefato obrigatório do Passo 03

Criar, somente quando este comando for futuramente executado:

```text
ferramentas/<slug>/HOMOLOGACAO-PARA-INTEGRACOES.md
```

Esse arquivo não substitui nem modifica o contrato. Ele registra a homologação técnica do contrato para uso nas jornadas de ERP.

Estrutura mínima:

```text
# Homologação para Integrações

## Identificação
## Fontes utilizadas
## Integridade dos artefatos canônicos
## Validação da autenticação
## Validação dos módulos
## Validação das operações
## Validação das correlações
## Validação das dependências
## Validação da bidirecionalidade
## Validação das pendências
## Validação da rastreabilidade
## Prontidão para mapeamento com ERP
## Restrições conhecidas
## Achados
## Resultado técnico
```

O relatório deve registrar evidência por critério e cobertura por módulo/operação, ou estrutura equivalente que permita provar que o conjunto descoberto foi comparado integralmente.

O resultado técnico deve ser exatamente um destes:

```text
APTO_PARA_INTEGRACOES
NAO_APTO_PARA_INTEGRACOES
```

Não utilizar resultado técnico ambíguo.

## Significado de `APTO_PARA_INTEGRACOES`

Não significa API perfeita nem ausência total de pendências. Significa conjuntamente:

- o contrato representa fielmente a fonte;
- lacunas e limitações estão explícitas;
- módulos e operações estão rastreáveis;
- um futuro mapeamento com ERP pode usar o contrato como fonte operacional confiável;
- não existem lacunas ocultas conhecidas que tornem o mapeamento inseguro.

## Tratamento de problemas

Se o Passo 03 encontrar erro, omissão, invenção, perda de rastreabilidade ou insuficiência no contrato:

1. não corrigir o artefato;
2. registrar o achado, a evidência, o artefato responsável e o impacto;
3. identificar a etapa que precisa ser revisitada;
4. usar `RESULTADO TECNICO: NAO_APTO_PARA_INTEGRACOES`;
5. manter `PRONTIDAO: NAO_HOMOLOGADA`;
6. retornar `STATUS DA ETAPA: PENDENTE` após a auditoria aplicável.

Se a correção pertencer ao cadastro canônico, orientar nova execução do Passo 02. Depois da correção e de uma nova auditoria válida do Passo 02, o Passo 03 deve ser executado novamente desde o início.

Uma nova execução do Passo 03 pode atualizar o relatório de homologação antes de congelá-lo para nova auditoria. Auditorias anteriores devem permanecer preservadas no histórico; o relatório nunca pode ser corrigido durante uma auditoria.

## Estado e prontidão para integrações

`ESTADO-DA-EXECUCAO.md` deve manter separadamente:

- resultado técnico do Passo 03;
- resultado da auditoria do Passo 03;
- status final da etapa;
- prontidão para integrações;
- relatório vigente de homologação;
- relatório vigente de auditoria.

Estados de prontidão permitidos:

```text
NAO_HOMOLOGADA
AGUARDANDO_AUDITORIA
HOMOLOGADA_PARA_INTEGRACOES
```

Regras:

- antes de resultado apto: `NAO_HOMOLOGADA`;
- resultado apto, relatório congelado e auditoria ainda não concluída: `AGUARDANDO_AUDITORIA`;
- resultado não apto ou auditoria reprovada: `NAO_HOMOLOGADA`;
- auditoria bloqueada após resultado apto: permanecer `AGUARDANDO_AUDITORIA`, sem avanço;
- somente a auditoria final aprovada de resultado apto pode registrar `HOMOLOGADA_PARA_INTEGRACOES`.

`AGUARDANDO_AUDITORIA` é estado transitório interno, não um quarto status final. O retorno final continua limitado a `CONCLUIDA`, `PENDENTE` ou `BLOQUEADA`.

## Auditoria obrigatória do Passo 03

Depois de finalizar o relatório e os hashes finais, encerrar a fase de execução e registrar:

- se o resultado técnico for `APTO_PARA_INTEGRACOES`: `PRONTIDAO: AGUARDANDO_AUDITORIA`;
- se o resultado técnico for `NAO_APTO_PARA_INTEGRACOES`: `PRONTIDAO: NAO_HOMOLOGADA`.

Nos dois casos, o relatório deve ser congelado e submetido à auditoria separada. Resultado não apto não pode usar prontidão transitória de possível homologação.

Em seguida, iniciar como atividade separada:

```text
parceiros/auditorias/AUDITAR-ETAPA.md
```

A auditoria deve aplicar `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md` e o gate especializado do Passo 03.

Conjunto imutável mínimo durante a auditoria:

- os sete artefatos canônicos;
- `HOMOLOGACAO-PARA-INTEGRACOES.md`.

As fontes oficiais, análises aprovadas, auditoria vigente do Passo 02 e demais evidências são somente leitura. `ESTADO-DA-EXECUCAO.md` fica fora do conjunto imutável apenas para a atualização controlada dos campos de auditoria, status, prontidão e relatórios vigentes após todas as verificações.

A auditoria deve calcular hashes iniciais e finais do conjunto imutável e reprovar se qualquer arquivo mudar durante a auditoria. Mesmo quando o relatório registra corretamente um resultado técnico negativo, os critérios de homologação não foram atendidos: a auditoria deve ser `REPROVADA`, a etapa deve permanecer `PENDENTE` e a ferramenta não pode ser homologada.

## Quality gate especializado

Só permitir simultaneamente:

```text
RESULTADO TECNICO: APTO_PARA_INTEGRACOES
AUDITORIA: APROVADA
PRONTIDAO: HOMOLOGADA_PARA_INTEGRACOES
STATUS DA ETAPA: CONCLUIDA
```

Matriz obrigatória:

| Resultado técnico | Auditoria | Status final | Prontidão |
|---|---|---|---|
| `APTO_PARA_INTEGRACOES` | `APROVADA` | `CONCLUIDA` | `HOMOLOGADA_PARA_INTEGRACOES` |
| `NAO_APTO_PARA_INTEGRACOES` | `REPROVADA` | `PENDENTE` | `NAO_HOMOLOGADA` |
| qualquer | `REPROVADA` | `PENDENTE` | `NAO_HOMOLOGADA` |
| qualquer | `BLOQUEADA` | `BLOQUEADA` | `AGUARDANDO_AUDITORIA` ou `NAO_HOMOLOGADA`; nunca homologada |

A auditoria verifica de forma independente a fidelidade e o processo do Passo 03. Ela não transforma um contrato tecnicamente não apto em apto, e qualquer inconsistência ou critério de homologação não atendido exige reprovação.

## Regra para futuras jornadas de ERP parceiro

Uma ferramenta só pode ser usada como origem ou destino em uma futura jornada de ERP parceiro quando possuir conjuntamente:

```text
RESULTADO TECNICO: APTO_PARA_INTEGRACOES
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
PRONTIDAO: HOMOLOGADA_PARA_INTEGRACOES
```

Caso contrário, a jornada de ERP parceiro deve retornar `BLOQUEADA` para essa ferramenta. Este comando não cria nem executa comandos de ERP parceiro.

## Proteção da máquina

É proibido:

- instalar pacotes persistentemente apenas para validar arquivos;
- alterar persistentemente a PowerShell ExecutionPolicy;
- registrar, confiar ou alterar PSGallery;
- alterar PATH;
- instalar módulos globais;
- alterar configuração do sistema.

Usar primeiro recursos já disponíveis. Se um auxiliar for indispensável, usar recurso temporário/local, registrar seu uso e removê-lo ao final. Nunca alterar a máquina silenciosamente.

## O que não deve fazer

O Passo 03 não pode:

- alterar os sete artefatos canônicos;
- corrigir silenciosamente achados do Passo 02;
- alterar documentação oficial, artefatos do Passo 01 ou auditorias anteriores;
- executar o Passo 02 automaticamente;
- criar integração, adaptador ou código de ERP;
- criar base comercial;
- testar API real sem autorização específica;
- preencher lacunas por inferência;
- apagar ou reclassificar pendências sem evidência;
- incluir ou persistir credenciais;
- avançar para outra jornada;
- avançar para o Passo 04 ou qualquer etapa posterior;
- alterar configuração persistente da máquina.

## Critérios de aceite

Só concluir se todos os critérios aplicáveis estiverem comprovados:

- [ ] Passo 02 concluído;
- [ ] auditoria válida e vigente do Passo 02 aprovada;
- [ ] documentação oficial localizada;
- [ ] artefatos aprovados do Passo 01 localizados;
- [ ] sete artefatos canônicos localizados;
- [ ] hashes iniciais registrados;
- [ ] identidade validada;
- [ ] autenticação validada;
- [ ] todos os módulos comparados;
- [ ] todas as operações comparadas semanticamente;
- [ ] cobertura direcional validada;
- [ ] correlações validadas;
- [ ] dependências validadas;
- [ ] pendências validadas;
- [ ] rastreabilidade validada;
- [ ] `NAO_DOCUMENTADO` preservado;
- [ ] nenhum dado inventado;
- [ ] nenhum artefato canônico alterado;
- [ ] hashes finais iguais aos iniciais;
- [ ] `HOMOLOGACAO-PARA-INTEGRACOES.md` criado;
- [ ] resultado técnico explícito;
- [ ] auditoria do Passo 03 executada;
- [ ] auditoria somente leitura;
- [ ] auditoria aprovada para concluir;
- [ ] prontidão registrada corretamente;
- [ ] Markdown UTF-8;
- [ ] nenhuma credencial persistida;
- [ ] nenhuma configuração persistente da máquina alterada.

## Retorno obrigatório do Codex

### Se concluir

```text
RESULTADO TECNICO: APTO_PARA_INTEGRACOES
AUDITORIA: APROVADA
PRONTIDAO: HOMOLOGADA_PARA_INTEGRACOES
STATUS DA ETAPA: CONCLUIDA

RESUMO:
<resumo objetivo da homologação>

ARQUIVOS CRIADOS/ALTERADOS:
<relatório de homologação, relatório de auditoria e atualização controlada do estado>

VALIDACOES EXECUTADAS:
<lista das verificações semânticas, de rastreabilidade e integridade>

PENDENCIAS:
<pendências não impeditivas preservadas, se houver>

PROXIMA ACAO:
Não existe próxima etapa operacional liberada. Aguarde a criação e homologação do próximo documento.
```

### Se o contrato não estiver apto ou a auditoria reprovar

```text
RESULTADO TECNICO: <APTO_PARA_INTEGRACOES ou NAO_APTO_PARA_INTEGRACOES>
AUDITORIA: REPROVADA
PRONTIDAO: NAO_HOMOLOGADA
STATUS DA ETAPA: PENDENTE

RESUMO:
<o que foi validado>

ACHADOS:
1. <problema, evidência e artefato responsável>
2. <problema, evidência e artefato responsável>

ETAPA A REVISITAR:
<etapa responsável pela correção>

PROXIMA ACAO:
Corrija os achados na etapa responsável, obtenha a auditoria exigida e execute novamente o Passo 03 desde o início.
```

### Se estiver bloqueada

```text
AUDITORIA DA ETAPA 03: <NAO_EXECUTADA ou BLOQUEADA>
PRONTIDAO: <NAO_HOMOLOGADA ou AGUARDANDO_AUDITORIA>
STATUS DA ETAPA: BLOQUEADA

MOTIVO DO BLOQUEIO:
<causa objetiva e evidência>

O QUE FOI VALIDADO:
<lista>

O QUE PRECISA ACONTECER PARA DESBLOQUEAR:
1. <ação>
2. <ação>

PROXIMA ACAO:
Não avance para outra jornada até resolver o bloqueio.
```

## Próxima ação

A conclusão do Passo 03 torna a ferramenta elegível para futuras jornadas de ERP, mas não cria nem libera automaticamente uma etapa posterior. O operador deve aguardar a criação e homologação do próximo documento operacional.
