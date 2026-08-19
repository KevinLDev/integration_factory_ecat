# AGENTS.md — Constituição da Fábrica de Integrações E-Catálogos

Este arquivo contém as regras globais e permanentes para qualquer agente que trabalhe neste repositório.

Ele funciona como **porta de entrada do Harness**. Não é uma enciclopédia e não substitui os guias, comandos, documentação oficial das APIs nem os `AGENTS.md` mais específicos encontrados em subpastas.

## 1. Escopo físico autorizado

O agente está autorizado a trabalhar **somente dentro do repositório `fabrica-de-integracoes` atualmente aberto no workspace**.

### Permitido

- ler arquivos deste repositório;
- criar arquivos e diretórios dentro deste repositório;
- editar arquivos dentro deste repositório;
- executar comandos necessários ao projeto dentro deste workspace;
- utilizar Git para este repositório;
- consultar documentação e ambientes externos quando a etapa permitir e o operador fornecer/acesso estiver autorizado.

### Proibido sem autorização explícita do operador

- alterar arquivos fora deste repositório;
- alterar qualquer outro repositório da E-Catálogos;
- executar comandos Git em outro repositório;
- excluir ou renomear repositórios remotos;
- alterar configurações da organização GitHub;
- executar `git push --force` ou equivalentes;
- sobrescrever histórico Git;
- apagar branches remotas;
- fazer push direto na `main` quando houver fluxo de branch/PR definido;
- contornar proteções de branch ou regras do GitHub.

Se uma tarefa exigir alteração fora deste repositório, **pare e solicite autorização explícita**.

## 2. Hierarquia de instruções do repositório

Antes de modificar qualquer arquivo:

1. leia este `AGENTS.md` da raiz;
2. procure por outro `AGENTS.md` na árvore da pasta em que irá trabalhar;
3. leia o guia operacional correspondente;
4. leia o documento de comando da etapa;
5. leia o estado e os artefatos existentes da execução;
6. consulte as fontes técnicas originais necessárias.

Um `AGENTS.md` mais específico complementa as regras globais dentro do seu escopo. Ele não deve ser usado para enfraquecer regras de segurança, evidência ou isolamento definidas aqui.

## 3. Escopo funcional atual

A Fábrica possui três jornadas operacionais claramente separadas:

1. **integrar uma nova ferramenta E-Catálogos**;
2. **integrar um ERP parceiro ao portfólio da E-Catálogos**;
3. **integrar um cliente utilizando um ERP já suportado**.

As jornadas reutilizam contratos, adaptadores e conhecimento compartilhado, mas não devem misturar responsabilidades:

- a jornada de ferramenta prepara e homologa tecnicamente o contrato canônico de um produto da E-Catálogos;
- a jornada de ERP parceiro produz uma integração reutilizável e homologada;
- a jornada de ERP cliente aplica uma integração homologada e trata somente as particularidades do cliente.

Neste momento, os Passos 01, 02 e 03 da jornada de nova ferramenta, os Passos 01 a 09 da jornada de ERP parceiro e os Passos 01 a 06 da jornada de ERP cliente estao disponiveis para operacao. O Passo 07 executa e valida tecnicamente em HML; o Passo 08 homologa funcionalmente em modelo manual assistido por IA, sem automacao de navegador e sem observer realtime; o Passo 09 consolida e publica a integracao homologada para reutilizacao, sem executar producao. A homologacao da combinacao so pode registrar `INTEGRACAO_HOMOLOGADA: SIM` apos auditoria independente aprovada do Passo 08. A publicacao da combinacao so pode registrar `INTEGRACAO_PUBLICADA: SIM` e `DISPONIVEL_PARA_CLIENTE: SIM` apos auditoria independente aprovada do Passo 09. Na jornada de ERP cliente, o Passo 01 resolve contexto/elegibilidade, o Passo 02 analisa a realidade comercial e tecnica, o Passo 03 projeta a instalacao sem materializar configuracao, o Passo 04 materializa em HML o que o Passo 03 projetou, o Passo 05 valida tecnica e funcionalmente essa materializacao e o Passo 06 executa o go-live em producao e registra a memoria de fechamento -- esta e a primeira etapa de toda a fabrica que escreve em producao. A primeira execucao real de cada combinacao (Passos 04, 05 e 06) exige auditoria independente PROFUNDA e nenhuma das tres se autoaprova. Com o Passo 06, o roteiro de 6 passos da jornada ERP cliente fica completo; nao ha Passo 07 dessa jornada. A relação vigente de etapas de ERP parceiro fica em `comece-aqui/integrar-erp/erp-parceiro/00-COMECE-AQUI.md`.

## 4. Conceitos que nunca podem ser confundidos

- **Ferramenta E-Catálogos:** produto/plataforma da E-Catálogos, como Força de Vendas, B2B ou Lojas/Vestuário.
- **ERP parceiro:** sistema externo cuja API será adaptada ao contrato da ferramenta E-Catálogos e homologada para reutilização.
- **Cliente:** empresa que posteriormente utilizará uma integração já homologada, com suas configurações e particularidades.

## 5. Autoridade do contrato

A ferramenta E-Catálogos é a referência canônica.

```text
ERP <-> adaptador do ERP <-> contrato da ferramenta E-Catálogos
```

A pergunta principal não é "como integrar tudo que o ERP possui?".

A pergunta é:

> "O que a ferramenta E-Catálogos precisa e como o ERP consegue atender a esse contrato?"

Não altere contratos compartilhados da E-Catálogos apenas para "fazer caber" um ERP sem decisão explícita, registrada e aprovada.

## 6. Hierarquia das fontes técnicas

Ao concluir fatos técnicos, priorize a seguinte ordem:

1. documentação oficial atual da ferramenta/ERP e OpenAPI/Swagger fornecido;
2. evidência obtida do ambiente/API autorizado;
3. testes reproduzíveis executados pela fábrica;
4. decisões de negócio explicitamente registradas e aprovadas;
5. documentação gerada pela própria fábrica;
6. implementações históricas/legadas, apenas como referência.

Nunca use documentação gerada pela fábrica como única prova para validar outro artefato gerado pela própria fábrica quando a fonte original estiver disponível.

## 7. Implementações históricas

Flows, steps e códigos antigos — incluindo integrações Pipedream entre Bling e Força de Vendas — são **referência histórica**, não arquitetura oficial.

Eles podem ser usados para identificar:

- regras de negócio reais;
- problemas já encontrados;
- dependências;
- paginação;
- retry/rate limit;
- correlação;
- SKU/variante/pack;
- estoque, reserva, baixa e estorno;
- criação versus atualização;
- status e campos personalizados.

Não copie automaticamente sua arquitetura, organização, dependência do Pipedream ou decisões específicas como padrão genérico da fábrica.

## 8. Regras técnicas permanentes

1. Não invente endpoints, campos, enums, relacionamentos, autenticação, limites ou regras comerciais.
2. Toda conclusão técnica relevante deve ser rastreável à documentação original, ambiente real autorizado ou evidência de teste.
3. Toda suposição não comprovada deve virar **PENDÊNCIA**.
4. Todo módulo aplicável deve ser analisado nas duas direções: ERP -> ferramenta e ferramenta -> ERP.
5. Bidirecionalidade não significa que toda operação existe. Use `NAO_SUPORTADO_PELA_API` quando houver evidência de limitação.
6. Para fluxos bidirecionais, documente chave de correlação, idempotência, prevenção de loop, origem da alteração e política de conflito.
7. Antes de implementar integração, produza mapeamento ERP x ferramenta com evidências.
8. Diferencie sucesso, ignorado, pendência, bloqueio e erro. Não esconda falhas para homologar.
9. Teste módulo isolado antes do end-to-end.
10. Verifique explicitamente estoque, reserva, baixa, estorno e cancelamento para evitar dupla movimentação.
11. Nunca confirme integração na origem antes de existir confirmação válida no destino quando o fluxo depender dessa garantia.
12. Prefira TypeScript estrito e componentes compartilhados para HTTP, autenticação, paginação, retry/backoff, rate limit, normalização, logs e erros quando a fase de implementação começar.

### 8.1 Homologação da ferramenta para integrações

O Passo 03 é a homologação técnica do contrato canônico para uso em integrações com ERP.

Cadastro canônico aprovado no Passo 02 não significa automaticamente que a ferramenta está pronta para uma jornada de ERP.

Uma ferramenta só pode ser usada como origem ou destino na jornada de ERP parceiro quando possuir conjuntamente:

```text
RESULTADO TECNICO: APTO_PARA_INTEGRACOES
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
PRONTIDAO: HOMOLOGADA_PARA_INTEGRACOES
```

O Passo 03 deve tratar os sete artefatos canônicos do Passo 02 como somente leitura, validar sua fidelidade e suficiência contra a fonte oficial e registrar resultado técnico separado da auditoria, do status da etapa e da prontidão. Ele não pode alterar esses artefatos nem corrigir silenciosamente seus achados; qualquer correção deve retornar ao Passo 02 e passar por nova auditoria válida dessa etapa.

Se qualquer condição do gate estiver ausente, a jornada de ERP parceiro deve retornar `BLOQUEADA` para essa ferramenta. Essa regra não autoriza criar ou improvisar comandos de ERP ainda inexistentes.

## 9. Credenciais e segredos

Credenciais reais podem ser fornecidas ao agente quando forem necessárias para o ambiente autorizado.

O agente pode utilizar usuário, senha, token, API key, client id, client secret, refresh token e outros segredos necessários à execução.

Política de papéis:

- IA executora (Codex/GitHub Copilot no workspace autorizado) pode receber e usar credenciais reais para autenticação, obtenção/renovação de token, chamadas de API, testes, desenvolvimento e homologação, quando isso estiver dentro da jornada/etapa liberada.
- IA de Apoio externa não deve depender de valores reais de secrets e deve operar com indicadores de presença quando aplicável.

Regra fundamental:

- usar credencial durante execução não autoriza persistir credencial em artefatos versionados.

Quando precisar persistir localmente, deve criar automaticamente arquivo apropriado, como:

```text
credenciais-erp.env
credenciais-ferramenta.env
```

Regras:

- o operador não precisa criar esses arquivos manualmente;
- nunca mover segredos para arquivos versionados;
- nunca copiar valores secretos para código-fonte;
- nunca registrar valores reais de secrets em markdown/yaml/json versionados, manifestos, checkpoints, auditorias, relatórios, evidências, commits, mensagens de commit ou histórico Git;
- não reproduzir valores completos em relatórios, documentação final, exemplos ou logs persistentes;
- evitar imprimir secrets em terminal/logs e redigir qualquer exposição acidental antes de persistir evidência (ex.: `Authorization: Bearer [REDACTED]`);
- não repetir valores reais de secrets nas respostas ao operador; quando for necessário confirmar uso/autenticação, retornar apenas indicador de estado ou valor redigido;
- receber credencial não amplia autorização de processo: jornada, etapa, gates e escopo continuam soberanos;
- se secret for exposto em artefato persistente, registrar incidente sem reproduzir valor e orientar rotação/tratamento sem reescrever histórico automaticamente;
- respeitar o `.gitignore`.

## 10. Operação orientada por comandos

O operador fornece intenção, nomes, arquivos, documentação e dados conhecidos.

O operador **não deve precisar**:

- criar pasta de execução;
- copiar modelos;
- renomear pastas;
- criar arquivos de estado;
- organizar referências manualmente apenas para o comando funcionar;
- preencher placeholders dentro dos comandos.

O agente deve criar/localizar automaticamente a execução e organizar os artefatos necessários dentro do repositório.

A porta de entrada humana da fábrica é:

```text
comece-aqui/00-COMECE-AQUI.md
```

O operador escolhe ali a jornada adequada antes de receber qualquer instrução de etapa.

### 10.1 Paridade entre comando técnico e documento operacional

Todo comando técnico liberado para operação deve possuir um documento humano correspondente na jornada correta de `comece-aqui/`.

Paridade atual:

```text
parceiros/comandos/01-APRESENTAR-E-ANALISAR-FERRAMENTA.md
-> comece-aqui/integrar-nova-ferramenta/01-APRESENTAR-FERRAMENTA.md

parceiros/comandos/02-CADASTRAR-FERRAMENTA.md
-> comece-aqui/integrar-nova-ferramenta/02-CADASTRAR-FERRAMENTA.md

parceiros/comandos/03-VALIDAR-FERRAMENTA-CADASTRADA.md
-> comece-aqui/integrar-nova-ferramenta/03-VALIDAR-FERRAMENTA-CADASTRADA.md

parceiros/comandos/ERP-PARCEIRO-01-APRESENTAR-ERP.md
-> comece-aqui/integrar-erp/erp-parceiro/01-APRESENTAR-ERP.md

parceiros/comandos/ERP-PARCEIRO-02-ANALISAR-ERP.md
-> comece-aqui/integrar-erp/erp-parceiro/02-ANALISAR-ERP.md

parceiros/comandos/ERP-PARCEIRO-03-PROJETAR-HOMOLOGACAO.md
-> comece-aqui/integrar-erp/erp-parceiro/03-PROJETAR-HOMOLOGACAO.md

parceiros/comandos/ERP-PARCEIRO-04-MATERIALIZAR-BASE-HOMOLOGACAO.md
-> comece-aqui/integrar-erp/erp-parceiro/04-MATERIALIZAR-BASE-HOMOLOGACAO.md

parceiros/comandos/ERP-PARCEIRO-05-PROJETAR-INTEGRACAO-E-MAPEAMENTO.md
-> comece-aqui/integrar-erp/erp-parceiro/05-PROJETAR-INTEGRACAO-E-MAPEAMENTO.md

parceiros/comandos/ERP-PARCEIRO-06-DESENVOLVER-INTEGRACAO.md
-> comece-aqui/integrar-erp/erp-parceiro/06-DESENVOLVER-INTEGRACAO.md

parceiros/comandos/ERP-PARCEIRO-07-EXECUTAR-E-VALIDAR-TECNICAMENTE-EM-HML.md
-> comece-aqui/integrar-erp/erp-parceiro/07-EXECUTAR-E-VALIDAR-TECNICAMENTE-EM-HML.md

parceiros/comandos/ERP-PARCEIRO-08-HOMOLOGAR-FUNCIONALMENTE-INTEGRACAO.md
-> comece-aqui/integrar-erp/erp-parceiro/08-HOMOLOGAR-FUNCIONALMENTE-INTEGRACAO.md

parceiros/comandos/ERP-PARCEIRO-09-CONSOLIDAR-E-PUBLICAR-INTEGRACAO-HOMOLOGADA.md
-> comece-aqui/integrar-erp/erp-parceiro/09-CONSOLIDAR-E-PUBLICAR-INTEGRACAO-HOMOLOGADA.md

parceiros/comandos/ERP-CLIENTE-01-RESOLVER-CONTEXTO-DO-CLIENTE.md
-> comece-aqui/integrar-erp/erp-cliente/01-RESOLVER-CONTEXTO-DO-CLIENTE.md

parceiros/comandos/ERP-CLIENTE-02-ANALISAR-REALIDADE-COMERCIAL-E-TECNICA-DO-CLIENTE.md
-> comece-aqui/integrar-erp/erp-cliente/02-ANALISAR-REALIDADE-COMERCIAL-E-TECNICA-DO-CLIENTE.md

parceiros/comandos/ERP-CLIENTE-03-PROJETAR-INSTALACAO-DO-CLIENTE.md
-> comece-aqui/integrar-erp/erp-cliente/03-PROJETAR-INSTALACAO-DO-CLIENTE.md

parceiros/comandos/ERP-CLIENTE-04-MATERIALIZAR-INSTALACAO-EM-HML.md
-> comece-aqui/integrar-erp/erp-cliente/04-MATERIALIZAR-INSTALACAO-EM-HML.md

parceiros/comandos/ERP-CLIENTE-05-VALIDAR-HML-E-PREPARAR-PRODUCAO.md
-> comece-aqui/integrar-erp/erp-cliente/05-VALIDAR-HML-E-PREPARAR-PRODUCAO.md

parceiros/comandos/ERP-CLIENTE-06-GO-LIVE-E-VALIDAR-PRODUCAO.md
-> comece-aqui/integrar-erp/erp-cliente/06-GO-LIVE-E-VALIDAR-PRODUCAO.md
```

Documentos operacionais de ERP devem ficar em uma destas jornadas:

```text
comece-aqui/integrar-erp/erp-parceiro/
comece-aqui/integrar-erp/erp-cliente/
```

Na jornada de ERP parceiro, os Passos 01 a 09 disponiveis e suas rotas operacionais vigentes sao publicados em `comece-aqui/integrar-erp/erp-parceiro/00-COMECE-AQUI.md`.

Uma etapa não está pronta para operação sem seu documento humano correspondente, homologado e localizado na jornada correta.

### 10.2 Padrão dos documentos operacionais

Todo documento operacional que possuir texto para enviar ao Codex deve usar exatamente estas marcações:

```text
### COPIE A PARTIR DAQUI

[texto a enviar]

### PARE DE COPIAR AQUI
```

O operador deve copiar somente o conteúdo entre as marcações. Campos entre colchetes são placeholders que devem ser substituídos; os colchetes não devem ser enviados.

Todo passo operacional futuro de ERP parceiro ou ERP cliente deve informar, quando aplicável:

- quando usar;
- pré-requisitos;
- o que o operador precisa ter;
- quais arquivos fornecer;
- onde colocar os arquivos;
- informações que precisa preencher;
- o que não precisa fazer manualmente;
- prompt exato para o Codex;
- `COPIE A PARTIR DAQUI`;
- `PARE DE COPIAR AQUI`;
- exemplo preenchido;
- o que a IA fará;
- arquivos ou artefatos esperados;
- como testar;
- resultado esperado;
- como interpretar erros;
- o que fazer se houver falha;
- status da etapa;
- auditoria;
- quando pode continuar;
- próximo documento.

Quando a etapa possuir comportamento testável, o teste deve fazer parte da documentação operacional. Não basta orientar o operador a apenas “executar o comando”.

## 11. Memória persistente

A memória oficial da fábrica não é o chat.

Toda informação necessária à continuidade deve ser persistida em arquivos, contratos, relatórios, configurações, testes ou evidências dentro do repositório.

Cada execução deve possuir, no mínimo, quando aplicável:

```text
DADOS-DA-EXECUCAO.md
ESTADO-DA-EXECUCAO.md
```

Quando houver homologação técnica da ferramenta, o estado deve registrar separadamente resultado técnico, auditoria, status da etapa, prontidão para integrações e relatórios vigentes. `AGUARDANDO_AUDITORIA` é estado transitório de prontidão, não status final de etapa.

Se uma nova sessão do Codex começar, ela deve conseguir continuar o trabalho lendo o repositório.

### 11.1 Manifesto de etapa e vigência

Cada resultado reutilizável deve possuir manifesto compacto baseado em `parceiros/modelos/MANIFESTO-DA-ETAPA.yaml`. O manifesto é artefato de controle: registra identidade, etapa, status, auditoria vigente e seu tipo, resultado técnico e prontidão quando aplicáveis, fontes, entradas e saídas com caminho e SHA-256, dependências upstream e vigência. Ele não substitui fonte, artefato, estado ou auditoria.

Um resultado aprovado só pode ser reutilizado quando seu manifesto for recalculado como `VALIDO`, a auditoria registrada continuar aprovada e vigente e todos os hashes atuais coincidirem com os esperados. O valor de vigência armazenado sozinho nunca libera avanço. Mudança em fonte, entrada, auditoria ou saída upstream invalida a etapa dependente e o downstream alcançável como `INVALIDADO_POR_MUDANCA_UPSTREAM` ou classificação mais específica.

Não apague nem reescreva relatórios históricos para representar invalidação. Resultado histórico e vigência atual são dimensões separadas. Hash comprova identidade dos bytes, não correção semântica; a hierarquia de fontes da seção 6 permanece soberana.

### 11.2 Checkpoint e retomada

`CHECKPOINT-DA-EXECUCAO.yaml` registra somente progresso transitório: tarefa e fase atuais, fases concluídas, próxima fase, linha de base, arquivos produzidos e protegidos, auditoria iniciada, último ponto seguro e motivo de pausa. Ele não substitui `ESTADO-DA-EXECUCAO.md` e não participa da cadeia de vigência.

Ao retomar uma execução interrompida:

1. leia o checkpoint;
2. recalcule os hashes da linha de base e dos arquivos protegidos;
3. verifique se houve mudança externa;
4. continue do último ponto seguro somente se os hashes coincidirem;
5. se divergirem, não continue nem reinicie automaticamente; registre a divergência e solicite decisão quando necessária;
6. nunca presuma que a execução interrompida terminou.

`EXECUCAO: PAUSADA_COM_CHECKPOINT` é marcador operacional, não um quarto `STATUS DA ETAPA`, e não altera resultado de auditoria, prontidão ou gate.

### 11.3 Validação determinística e leitura por delta

Execute primeiro os validadores reutilizáveis de `scripts/harness/`. Eles cobrem somente verificações mecânicas, retornam saída e exit code determinísticos, funcionam sem IA, são somente leitura dos artefatos de negócio por padrão e não contêm análise semântica. A IA permanece responsável por significado, evidência e exceções.

Quando fonte, upstream aprovado e auditoria mantiverem exatamente os hashes vigentes, priorize manifesto, estado, artefatos diretamente necessários e delta. Volte à fonte completa quando um hash mudar, houver divergência ou dúvida semântica, faltar rastreabilidade ou a auditoria profunda for obrigatória. Serena, Graphify e outros MCPs podem acelerar o trabalho, mas nunca são dependência do Harness.

### 11.4 Timebox seguro

O orçamento por execução contínua é de até 25 minutos para tarefa ou auditoria normal e até 40 minutos para auditoria profunda. Ao se aproximar do limite, conclua a unidade lógica atual, persista checkpoint e hashes, registre a próxima fase e retorne `EXECUCAO: PAUSADA_COM_CHECKPOINT`.

O timebox não autoriza abortar no meio de uma escrita ou validação crítica, omitir evidência, publicar resultado incompleto nem criar loop de revalidação. Ultrapassá-lo deve ser exceção justificada.

## 12. Git e alterações

Antes de alterações relevantes:

- confirme que o diretório atual pertence a este repositório;
- confira a branch atual;
- preserve mudanças existentes que não façam parte da tarefa;
- não faça alterações destrutivas para "limpar" o workspace;
- não use `reset --hard`, force push ou comandos equivalentes sem autorização explícita.

Quando o fluxo Git da fábrica estiver configurado, trabalhe em branch própria e utilize Pull Request para integrar alterações à `main`.

## 13. Retorno e qualidade

Cada comando define seus critérios de aceite e formato de retorno.

Use somente:

- `CONCLUIDA`;
- `PENDENTE`;
- `BLOQUEADA`.

Nunca marque `CONCLUIDA` apenas porque arquivos foram criados.

Uma etapa só está concluída quando os critérios de aceite foram realmente verificados com evidência.

## 14. Uso da pasta ferramentas e utilitários técnicos

A pasta `ferramentas/` é reservada exclusivamente para ferramentas/produtos da E-Catálogos (por exemplo: Força de Vendas, B2B, Lojas/Vestuário).

Não instalar nessa pasta:

- utilitários técnicos temporários;
- bibliotecas auxiliares de parsing/extração;
- binários de suporte (por exemplo, PDF extractors);
- artefatos técnicos que não representem produtos da E-Catálogos.

Quando um utilitário temporário for necessário:

1. usar diretório temporário do sistema ou outro local técnico apropriado;
2. não misturar utilitário técnico com artefatos de negócio da fábrica;
3. não versionar binários temporários;
4. limpar o recurso após o uso quando aplicável.

Utilitários reutilizáveis do Harness pertencem a `scripts/harness/`. Não instale dependências para executá-los nem recrie como script temporário uma validação mecânica recorrente que já possua implementação genérica.
