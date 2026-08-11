# AUDITAR-ETAPA — Comando genérico de auditoria (Parceiros)

## Finalidade

Executar auditoria obrigatória de uma etapa da jornada de Parceiros usando o princípio de confiança zero.

## Como chamar

```text
Execute integralmente:
parceiros/auditorias/AUDITAR-ETAPA.md

Execução: <ferramenta e/ou ERP>
Etapa alvo: <nome exato da etapa/comando>
Tipo solicitado: <AUTO|NORMAL|PROFUNDA>
Fontes originais: <arquivos oficiais>
Artefatos da etapa: <lista de arquivos produzidos>
Comando auditado: <arquivo do comando da etapa>
```

## Instrução para o Codex

```text
Codex,

audite a etapa informada aplicando:
- parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md
- comando da etapa auditada
- critérios de aceite da etapa auditada

Antes da análise semântica:
1. localizar estado, manifestos e eventual checkpoint;
2. em retomada, validar a linha de base do checkpoint antes de continuar;
3. executar os validadores aplicáveis de scripts/harness/;
4. resolver AUTO para NORMAL ou PROFUNDA usando os gatilhos das regras de auditoria;
5. registrar o modo e seu motivo;
6. declarar o conjunto imutável e suas saídas de controle.

Regras obrigatórias:
1. Tratar artefatos da etapa como não confiáveis até verificação com evidência.
2. Comparar independentemente fonte original, comando, critérios, artefatos e estado.
3. Não validar arquivo gerado apenas contra outro arquivo gerado.
4. AUDITORIA É SOMENTE LEITURA DOS ARTEFATOS AUDITADOS.
5. Declarar os artefatos auditados e registrar tamanho, data de modificação e hash SHA-256 antes das verificações.
6. Durante a auditoria, não editar artefatos da etapa, completar informação ausente, regenerar arquivos, corrigir inconsistências, alterar contrato nem alterar análise para fazer o teste passar.
7. Se encontrar qualquer problema, registrar exatamente o achado, reprovar a auditoria e deixar a etapa pendente, sem fazer a correção.
8. Automatizar verificações objetivas com scripts/harness/ sempre que aplicável e registrar comando, exit code e resultado.
9. Validar conteúdo e semântica; igualdade de contagens, sozinha, não comprova cobertura nem fidelidade.
10. Gerar um novo relatório persistente na execução auditada, preservando auditorias anteriores e identificando revalidações.
11. Somente após concluir as verificações, atualizar em ESTADO-DA-EXECUCAO.md os campos estritamente autorizados de resultado da auditoria, status da etapa, prontidão quando aplicável e relatórios vigentes, sem corrigir conteúdo técnico.
12. Recalcular a integridade dos artefatos auditados ao final e reprovar se algum deles tiver sido alterado durante a auditoria.
13. Aplicar o gate especializado do comando auditado; auditoria aprovada não implica automaticamente etapa concluída quando houver resultado técnico ou prontidão adicional.
14. Recalcular a vigência do manifesto e de todas as dependências; o valor armazenado sozinho não libera a etapa.
15. Em auditoria NORMAL, analisar o delta semântico e escalar para PROFUNDA antes da decisão se surgir divergência não explicada, falta de rastreabilidade ou perda de confiança.
16. Nunca executar o Passo 03 em modo NORMAL.
17. Ao atingir o timebox, persistir checkpoint e retornar EXECUCAO: PAUSADA_COM_CHECKPOINT sem publicar resultado final ou alterar o status da etapa.
18. Não regravar manifesto ou checkpoint sem mudança material apenas para atualizar timestamp.
```

## Ordem obrigatória de comparação para a Etapa 02

Em modo `NORMAL`, validar nesta ordem:

1. manifesto, auditoria e hashes vigentes da Etapa 01;
2. identidade da fonte original por hash;
3. delta e comparação semântica dos canônicos com a Etapa 01 aprovada;
4. `parceiros/comandos/02-CADASTRAR-FERRAMENTA.md` e seus critérios;
5. consulta pontual à fonte quando a rastreabilidade exigir.

Em modo `PROFUNDA`, validar nesta ordem:

1. fonte original da ferramenta;
2. artefatos aprovados da Etapa 01;
3. `parceiros/comandos/02-CADASTRAR-FERRAMENTA.md`;
4. critérios de aceite do comando 02;
5. artefatos canônicos produzidos.

Não limitar a auditoria a presença de arquivos ou igualdade de contagens. Conferir também:

- conteúdo e rastreabilidade;
- pendências e divergências preservadas;
- operações e suas identidades;
- módulos e capacidades;
- dependências entre entidades;
- bidirecionalidade por direção, operações de suporte e lacunas contratuais;
- ausência de informação inventada.

## Ordem obrigatória de comparação para a Etapa 03

Ao auditar `03-VALIDAR-FERRAMENTA-CADASTRADA`, usar modo `PROFUNDA` e validar nesta ordem:

1. documentação oficial original da ferramenta;
2. artefatos e auditoria aprovados da Etapa 01;
3. manifesto recalculado como `VALIDO` e `parceiros/comandos/02-CADASTRAR-FERRAMENTA.md`;
4. relatório final vigente e aprovado da auditoria da Etapa 02, identificado pelo estado, pelo manifesto e confirmado contra o histórico;
5. estado da execução anterior à auditoria;
6. os sete artefatos canônicos atuais e sua integridade contra os hashes finais da auditoria vigente da Etapa 02;
7. `parceiros/comandos/03-VALIDAR-FERRAMENTA-CADASTRADA.md` e seus critérios de aceite;
8. `ferramentas/<slug>/HOMOLOGACAO-PARA-INTEGRACOES.md`.

Não aceitar o relatório do Passo 03 como prova de si mesmo. Repetir de forma independente as verificações semânticas, a cobertura por módulo/operação, a rastreabilidade e a classificação de prontidão.

### Conjunto protegido da Etapa 03

Declarar como artefatos imutáveis e calcular SHA-256 inicial e final de:

- `ferramentas/<slug>/README.md`;
- `ferramentas/<slug>/CONTRATO-DA-FERRAMENTA.yaml`;
- `ferramentas/<slug>/MODULOS.md`;
- `ferramentas/<slug>/DEPENDENCIAS.md`;
- `ferramentas/<slug>/BIDIRECIONALIDADE.md`;
- `ferramentas/<slug>/PENDENCIAS.md`;
- `ferramentas/<slug>/FONTES.md`;
- `ferramentas/<slug>/HOMOLOGACAO-PARA-INTEGRACOES.md`.

As fontes oficiais, análises, auditorias anteriores e demais evidências são somente leitura. `ESTADO-DA-EXECUCAO.md` não integra o conjunto imutável apenas porque receberá, ao final, a atualização controlada de auditoria, status, prontidão e relatórios vigentes. O relatório de auditoria deve registrar exatamente esse delta.

### Decisão especializada da Etapa 03

A auditoria avalia a fidelidade e o processo do Passo 03, separadamente do resultado técnico do contrato:

| Resultado técnico | Auditoria | Status final | Prontidão |
|---|---|---|---|
| `APTO_PARA_INTEGRACOES` | `APROVADA` | `CONCLUIDA` | `HOMOLOGADA_PARA_INTEGRACOES` |
| `NAO_APTO_PARA_INTEGRACOES` | `REPROVADA` | `PENDENTE` | `NAO_HOMOLOGADA` |
| qualquer | `REPROVADA` | `PENDENTE` | `NAO_HOMOLOGADA` |
| qualquer | `BLOQUEADA` | `BLOQUEADA` | `AGUARDANDO_AUDITORIA` ou `NAO_HOMOLOGADA`; nunca homologada |

Defeito no contrato corretamente detectado e fundamentado deve ser distinguido de falha do relatório, mas ambos impedem o atendimento dos critérios de homologação e exigem auditoria `REPROVADA`. Omissão, distorção, falta de cobertura/evidência ou alteração de entrada protegida também reprova a auditoria.

## Checklist base da auditoria

Validar, quando aplicável:

- [ ] tipo de auditoria e motivo registrados;
- [ ] manifesto recalculado como vigente e dependências com hashes íntegros;
- [ ] checkpoint de retomada validado, quando existir;
- [ ] scripts determinísticos, comandos e exit codes registrados;
- [ ] delta identificado e analisado;
- [ ] nenhum downstream obsoleto tratado como vigente;
- [ ] fontes obrigatórias utilizadas;
- [ ] cobertura da fonte original;
- [ ] ausências e extras/invenções;
- [ ] contagens e consistência;
- [ ] conteúdo e semântica dos itens contados;
- [ ] rastreabilidade por evidência;
- [ ] preenchimentos sem evidência;
- [ ] uso correto de `NAO_DOCUMENTADO`;
- [ ] divergências registradas;
- [ ] critérios de aceite da etapa;
- [ ] consistência de `ESTADO-DA-EXECUCAO.md`;
- [ ] resultado técnico e prontidão consistentes com o gate da etapa;
- [ ] arquivos obrigatórios;
- [ ] encoding UTF-8;
- [ ] ausência de avanço indevido de etapa;
- [ ] alterações dentro do escopo;
- [ ] evidências anexadas no relatório;
- [ ] hashes dos artefatos auditados inalterados entre o início e o fim.

## Resultado obrigatório

### Se aprovada e todos os gates especializados estiverem atendidos

```text
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
```

Para o Passo 03, esse resultado exige também:

```text
RESULTADO TECNICO: APTO_PARA_INTEGRACOES
PRONTIDAO: HOMOLOGADA_PARA_INTEGRACOES
```

Se a validação do Passo 03 resultar `NAO_APTO_PARA_INTEGRACOES`, o resultado correto é:

```text
RESULTADO TECNICO: NAO_APTO_PARA_INTEGRACOES
AUDITORIA: REPROVADA
PRONTIDAO: NAO_HOMOLOGADA
STATUS DA ETAPA: PENDENTE
```

### Se reprovada

```text
AUDITORIA: REPROVADA
STATUS DA ETAPA: PENDENTE
```

Qualquer problema no artefato produzido pela etapa, no processo ou nos critérios de aceite exige esse resultado, observada a regra especializada das etapas validadoras. A correção pertence a uma execução posterior do comando da etapa; depois dela, execute uma nova auditoria independente que valide todos os critérios do modo aplicável. Falha semântica ou perda de confiança exige modo `PROFUNDA`.

### Se bloqueada

```text
AUDITORIA: BLOQUEADA
STATUS DA ETAPA: BLOQUEADA
```

## Saída obrigatória ao operador

Informar:

1. escopo auditado;
2. tipo da auditoria, motivo e eventual escalonamento;
3. vigência do manifesto e das dependências;
4. validações executadas, scripts e exit codes;
5. critérios aprovados/reprovados;
6. divergências encontradas;
7. pendências;
8. resultado final da auditoria;
9. status final da etapa;
10. resultado técnico e prontidão, quando aplicável;
11. se a próxima etapa está liberada;
12. eventual pausa e caminho do checkpoint.

Se a próxima etapa ainda não possuir documento operacional homologado em `comece-aqui/`, não indicar arquivo futuro ou inexistente. Informar que o operador deve aguardar a preparação do próximo passo.
