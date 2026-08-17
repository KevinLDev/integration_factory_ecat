# Regras de Auditoria — Jornada de Parceiros (V1)

## Finalidade

Definir uma camada obrigatória, genérica e reutilizável de auditoria para qualquer etapa da jornada de Parceiros.

## Princípio de confiança zero

Todo artefato produzido por etapa deve ser tratado como **NÃO CONFIÁVEL** até ser auditado com evidência.

A auditoria deve comparar independentemente:

1. fonte original;
2. comando da etapa;
3. critérios de aceite da etapa;
4. artefatos produzidos;
5. estado persistente da execução.

Regra crítica: um artefato gerado não valida outro artefato gerado sozinho.

## Fonte, manifesto e confiança reutilizável

A fonte original continua sendo a autoridade final. Manifesto, auditoria e hashes formam um índice verificável da versão aprovada; não constituem nova prova semântica e não substituem a fonte.

Um resultado só pode ser reutilizado quando o manifesto for recalculado como `VALIDO`, a auditoria vigente estiver aprovada e fontes, entradas, saídas e dependências mantiverem os hashes esperados. Uma divergência de hash invalida a reutilização; ela não apaga o resultado histórico nem prova, sozinha, que o conteúdo histórico estava semanticamente errado.

A vigência deve ser calculada pelos validadores de `scripts/harness/`. O valor armazenado no manifesto nunca basta. Mudança upstream propaga `INVALIDADO_POR_MUDANCA_UPSTREAM` ao downstream dependente sem reescrever relatórios antigos.

## Separação obrigatória entre execução e auditoria

**AUDITORIA É SOMENTE LEITURA DOS ARTEFATOS AUDITADOS.**

Antes de iniciar as verificações, a auditoria deve declarar o conjunto exato de artefatos auditados e registrar uma linha de base de integridade com caminho, tamanho e hash SHA-256. Ao final, deve recalcular e comparar todos os hashes. Até o encerramento da auditoria é proibido, inclusive quando a alteração pareça simples ou objetiva:

- editar qualquer artefato da etapa;
- completar informação ausente;
- regenerar arquivos;
- corrigir inconsistências;
- alterar contrato;
- alterar análise para fazer o teste passar;
- substituir um artefato por outra versão;
- executar formatador, gerador ou conversor que regrave o artefato auditado.

A auditoria deve separar explicitamente:

1. **artefatos auditados imutáveis**: arquivos cujo conteúdo está sendo auditado e deve manter o mesmo SHA-256;
2. **fontes de autoridade somente leitura**: documentação e evidências usadas para comparação, que também não podem ser alteradas;
3. **saídas de controle permitidas**: arquivos e campos que a auditoria está autorizada a criar ou atualizar.

A auditoria pode escrever somente saídas de controle fora do conjunto auditado:

1. durante o trabalho, o checkpoint transitório, sem publicar resultado parcial como final;
2. um novo relatório persistente de auditoria;
3. após concluir todas as verificações, os campos estritamente autorizados em `ESTADO-DA-EXECUCAO.md`: resultado da auditoria, status da etapa, prontidão quando aplicável, relatórios vigentes e registro da etapa concluída quando o gate permitir; e
4. após concluir todas as verificações, os campos de controle do manifesto da etapa: tipo e resultado da auditoria, auditoria vigente, hashes auditados e vigência.

Estado e manifesto devem ter sua linha de base e seu delta final registrados no relatório. A verificação sem mudança material não deve regravar o manifesto nem alterar timestamp. O manifesto não inclui hash próprio e o checkpoint nunca participa da cadeia de vigência.

Essa atualização de estado não pode corrigir conteúdo técnico, completar evidência nem reescrever artefatos da etapa. Para uma reauditoria, o novo relatório deve ser distinto do anterior ou preservar explicitamente o histórico e o motivo da revalidação; uma auditoria anterior inválida não pode ser sobrescrita silenciosamente.

Ao final, a auditoria deve comparar a integridade dos artefatos auditados com a linha de base inicial. Qualquer alteração durante a auditoria constitui falha de processo e reprova a auditoria.

## Tratamento obrigatório de achados

Se a auditoria encontrar qualquer problema de conteúdo, cobertura, evidência, rastreabilidade, consistência ou critério de aceite:

```text
AUDITORIA: REPROVADA
STATUS DA ETAPA: PENDENTE
```

A auditoria deve registrar exatamente o problema e sua evidência, sem corrigi-lo. A correção deve ocorrer em uma execução posterior do comando da etapa. Depois da correção, uma nova auditoria independente deve validar todos os critérios do modo aplicável. Falha semântica ou perda de confiança exige modo profundo.

### Regra para etapas validadoras

Em uma etapa validadora, como o Passo 03, distinguir no relatório:

- defeito no contrato sob validação, corretamente detectado e fielmente registrado: determina `NAO_APTO_PARA_INTEGRACOES`, auditoria `REPROVADA`, prontidão `NAO_HOMOLOGADA` e etapa `PENDENTE`, porque o critério de homologação não foi atendido;
- omissão, distorção, conclusão sem evidência, cobertura insuficiente, alteração de entrada protegida ou violação do comando validador: também reprova a auditoria e deve ser identificada como falha do próprio Passo 03.

A auditoria avalia independentemente a fidelidade do relatório validador, registra a natureza do achado e não corrige o contrato. Ela não transforma resultado técnico negativo em positivo e não libera prontidão sem o gate especializado.

Use `AUDITORIA: BLOQUEADA` e `STATUS DA ETAPA: BLOQUEADA` somente quando um impedimento externo ou técnico não permitir concluir a própria auditoria. Uma deficiência encontrada no artefato auditado é reprovação, não bloqueio.

## Modos de auditoria

O modo deve ser resolvido antes da análise semântica e registrado no checkpoint, quando houver, e obrigatoriamente no manifesto e no relatório. `AUTO` pode ser solicitado como resolução, mas nunca é persistido como modo final.

### Auditoria normal

Só pode ser usada quando existe upstream aprovado e recalculado como vigente, os hashes de fonte, entradas, saídas e dependências coincidem e nenhum gatilho de auditoria profunda está presente.

Ela prioriza:

1. validadores determinísticos;
2. integridade e estrutura;
3. consistência entre manifesto, estado e auditoria vigente;
4. delta da alteração;
5. análise semântica do que mudou;
6. consulta pontual à fonte para resolver evidência.

Divergência não explicada, rastreabilidade insuficiente ou perda de confiança escala a execução para auditoria profunda antes da decisão. Auditoria profunda nunca pode ser reduzida a normal para economizar tempo.

### Auditoria profunda

Inclui comparação semântica ampla e independente com a fonte original. É obrigatória, no mínimo, em:

- primeira interpretação ou homologação de uma nova fonte;
- primeira homologação final de ferramenta ou ERP;
- mudança da fonte oficial;
- mudança estrutural relevante;
- divergência não explicada;
- falha grave ou semântica;
- perda de confiança determinada pelo Harness;
- exigência explícita do operador ou do comando.

Na jornada atual de ferramenta:

- Passo 01 inicial ou correção após falha semântica: `PROFUNDA`;
- Passo 02: pode ser `NORMAL` contra Passo 01 aprovado e vigente, salvo gatilho profundo;
- Passo 03: sempre `PROFUNDA`.

## Leitura por delta

Se os hashes da fonte, do upstream aprovado e da auditoria vigente permanecerem idênticos, priorize manifesto, estado, artefatos diretamente necessários e delta. Não releia integralmente a fonte sem gatilho.

Volte à fonte completa quando um hash mudar, houver divergência ou dúvida semântica, faltar rastreabilidade ou a auditoria profunda for obrigatória. Scripts não substituem interpretação semântica.

## Validação contra fontes independentes

A auditoria deve validar conteúdo e significado contra a fonte de autoridade aplicável, e não apenas presença de arquivos, igualdade de contagens ou concordância entre artefatos gerados.

Para a Etapa 02, a ordem depende do modo resolvido.

### Etapa 02 em auditoria normal

1. validar deterministicamente o manifesto, a auditoria e os hashes vigentes da Etapa 01;
2. confirmar a identidade da fonte oficial por hash;
3. comparar semanticamente o delta e os artefatos canônicos com a Etapa 01 aprovada;
4. validar o comando `02-CADASTRAR-FERRAMENTA` e seus critérios de aceite;
5. consultar a fonte original pontualmente quando a rastreabilidade exigir.

### Etapa 02 em auditoria profunda

1. fonte original da ferramenta;
2. artefatos aprovados da Etapa 01;
3. comando `02-CADASTRAR-FERRAMENTA`;
4. critérios de aceite do comando;
5. artefatos canônicos produzidos.

Em ambos os modos, contagens não substituem conteúdo, rastreabilidade, pendências, operações, módulos, dependências e bidirecionalidade. A fonte original continua soberana, e um artefato gerado nunca valida outro sozinho.

### Ordem obrigatória para a Etapa 03

Toda auditoria da Etapa 03 é `PROFUNDA`.

Para `03-VALIDAR-FERRAMENTA-CADASTRADA`, comparar independentemente, nesta ordem:

1. documentação oficial original da ferramenta;
2. artefatos e auditoria aprovados da Etapa 01;
3. `parceiros/comandos/02-CADASTRAR-FERRAMENTA.md`;
4. auditoria final vigente e aprovada da Etapa 02, resolvida pelo estado e pelo histórico;
5. estado da execução anterior à auditoria;
6. os sete artefatos canônicos atuais e sua integridade contra a auditoria vigente da Etapa 02;
7. `parceiros/comandos/03-VALIDAR-FERRAMENTA-CADASTRADA.md` e seus critérios de aceite;
8. `HOMOLOGACAO-PARA-INTEGRACOES.md` produzido.

O relatório do Passo 03 não pode validar a si mesmo. A auditoria deve repetir verificações semânticas e de rastreabilidade diretamente contra as fontes de autoridade.

Durante a auditoria da Etapa 03, o conjunto imutável mínimo contém os sete artefatos canônicos e `HOMOLOGACAO-PARA-INTEGRACOES.md`. `ESTADO-DA-EXECUCAO.md` fica fora desse conjunto somente para a atualização controlada posterior às verificações; o delta autorizado deve ser registrado no relatório.

## Escopo mínimo da auditoria

Para a etapa auditada, validar, quando aplicável:

- fontes obrigatórias utilizadas;
- cobertura da fonte original;
- itens ausentes;
- itens extras/inventados;
- contagens;
- conteúdo e semântica dos itens contados;
- rastreabilidade;
- preenchimento sem evidência;
- campos que deveriam estar como `NAO_DOCUMENTADO`;
- divergências não registradas;
- critérios de aceite;
- consistência do estado persistente;
- resultado técnico e prontidão, quando aplicável;
- presença de arquivos obrigatórios;
- encoding UTF-8;
- avanço indevido para próxima etapa;
- alterações fora do escopo;
- evidência das conclusões;
- integridade dos artefatos auditados antes e depois da auditoria.

## Quality Gate obrigatório

Uma etapa só pode permanecer com `STATUS DA ETAPA: CONCLUIDA` quando a auditoria obrigatória resultar `APROVADA` **e** todos os gates especializados do comando estiverem atendidos.

Para etapas sem gate especializado:

`AUDITORIA: APROVADA` -> `STATUS DA ETAPA: CONCLUIDA`

Para o Passo 03, aplicar obrigatoriamente:

| Resultado técnico           | Auditoria   | Status final | Prontidão                                                    |
| --------------------------- | ----------- | ------------ | ------------------------------------------------------------ |
| `APTO_PARA_INTEGRACOES`     | `APROVADA`  | `CONCLUIDA`  | `HOMOLOGADA_PARA_INTEGRACOES`                                |
| `NAO_APTO_PARA_INTEGRACOES` | `REPROVADA` | `PENDENTE`   | `NAO_HOMOLOGADA`                                             |
| qualquer                    | `REPROVADA` | `PENDENTE`   | `NAO_HOMOLOGADA`                                             |
| qualquer                    | `BLOQUEADA` | `BLOQUEADA`  | `AGUARDANDO_AUDITORIA` ou `NAO_HOMOLOGADA`; nunca homologada |

`AGUARDANDO_AUDITORIA` é estado transitório de prontidão e nunca um status final da etapa.

Se houver problema no artefato produzido pela etapa, no processo auditado ou nos critérios de aceite — observada a distinção para etapas validadoras definida acima —:

- `AUDITORIA: REPROVADA`
- `STATUS DA ETAPA: PENDENTE`

Se houver impedimento externo/técnico:

- `AUDITORIA: BLOQUEADA`
- `STATUS DA ETAPA: BLOQUEADA`

A auditoria deve atualizar `ESTADO-DA-EXECUCAO.md`.

## Relatório persistente obrigatório

Toda auditoria deve gerar um arquivo persistente na execução auditada.

O relatório deve conter no mínimo:

- etapa auditada;
- tipo de auditoria e motivo da seleção;
- fontes originais;
- manifesto utilizado e checkpoint, quando houver;
- hashes e vigência das dependências upstream;
- comando auditado;
- artefatos auditados;
- critérios de aceite;
- validações realizadas;
- contagens comparadas;
- divergências encontradas;
- informações sem evidência;
- pendências;
- resultado de cada critério;
- resultado final da auditoria;
- resultado técnico e prontidão, quando aplicável;
- evidências utilizadas.
- scripts determinísticos executados, comandos, exit codes e resultados;
- delta analisado e eventual escalonamento de normal para profunda;
- pausa ou retomada por checkpoint, quando houver.

## Automação na V1

Antes da análise semântica, executar os validadores aplicáveis de `scripts/harness/`. Sempre que a validação for objetiva ou mecânica, automatizar e registrar comando, exit code e resultado.

Os scripts são somente leitura dos artefatos de negócio por padrão, não contêm análise semântica e não substituem a auditoria. Validadores temporários recorrentes devem ser promovidos a scripts reutilizáveis quando generalizáveis.

Na V1, os Passos 01 a 09 da jornada ERP parceiro estao oficialmente disponiveis. Implementar somente validadores necessarios, objetivos e generalizaveis para as etapas em uso; a publicacao de um comando nao torna obrigatorio antecipar um validador especifico nem permite substituir a auditoria semantica.

## Timebox e pausa segura

O orçamento por execução contínua é de até 25 minutos para auditoria normal e até 40 minutos para auditoria profunda.

Ao se aproximar do limite:

1. concluir a unidade lógica atual;
2. persistir checkpoint, hashes e último ponto seguro;
3. registrar a próxima fase;
4. retornar `EXECUCAO: PAUSADA_COM_CHECKPOINT`.

A pausa não é `AUDITORIA: BLOQUEADA`, não é reprovação e não publica status final. Na retomada, conferir novamente toda a linha de base antes de continuar.

## Cobertura de auditoria para ERP parceiro

A arquitetura da auditoria deve permitir validar, conforme a etapa aplicavel dos Passos 01 a 09:

- mapeamentos;
- campos obrigatórios;
- bidirecionalidade;
- idempotência;
- prevenção de loop;
- duplicidade;
- retry/backoff;
- rate limit;
- dry-run;
- testes;
- evidências;
- homologação.

Implementar validadores deterministicos especificos somente quando forem necessarios e generalizaveis, preservando a analise semantica independente. O Passo 07 executa e valida tecnicamente em HML; sua primeira execucao HML real por combinacao exige auditoria `PROFUNDA`, separada da execucao produtora. O Passo 08 homologa funcionalmente e, para a primeira homologacao funcional real de uma combinacao, a auditoria independente tambem deve ser `PROFUNDA`. O Passo 09 consolida/publica a integracao homologada e, para a primeira publicacao real de uma combinacao, a auditoria independente tambem deve ser `PROFUNDA`. Runtime e monitoramento permanecem capacidades futuras.
