# ERP Parceiro - Passo 03 - Projetar homologacao da combinacao

## Finalidade

Produzir plano concreto de homologacao e base comercial planejada para uma combinacao ERP x ferramenta, com cobertura rastreavel e sem executar criacao real no ERP.

## Escopo

Esta etapa e somente planejamento.

Nao executar operacoes comerciais em ERP.

Nao usar credenciais.

Nao chamar APIs externas.

## Gate de entrada obrigatorio

Antes de qualquer escrita, validar e registrar:

1. ERP identificado sem ambiguidade.
2. Ferramenta identificada sem ambiguidade.
3. Ferramenta com prontidao HOMOLOGADA_PARA_INTEGRACOES.
4. Passo 02 do ERP parceiro concluido em nivel suficiente.
5. Memoria tecnica do ERP existente.
6. Analise da combinacao ERP x ferramenta existente.
7. Capacidades e gaps suficientes para planejar homologacao.

Se algum requisito falhar, retornar PENDENTE ou BLOQUEADA com evidencia, sem inventar fatos.

## Auto-descoberta obrigatoria

Resolver automaticamente, antes de planejar:

- ERP e ferramenta;
- slugs;
- estado da execucao;
- resultado do Passo 02;
- memoria geral do ERP;
- memoria da combinacao;
- contrato tecnico da ferramenta;
- cenarios funcionais da ferramenta;
- regras de negocio da ferramenta, quando existir;
- matriz ERP x ferramenta;
- pendencias/gaps;
- padrao global de massa comercial;
- modelo de base e convencoes globais.

Nao criar pasta duplicada de ERP/ferramenta.

Seguir resolucao central e arquitetura de memoria oficial do repositorio.

## Entradas minimas esperadas

- ferramentas/<ferramenta-slug>/CONTRATO-DA-FERRAMENTA.yaml
- ferramentas/<ferramenta-slug>/CENARIOS-FUNCIONAIS.md (quando existir)
- ferramentas/<ferramenta-slug>/REGRAS-DE-NEGOCIO.md (quando existir)
- ferramentas/<ferramenta-slug>/HOMOLOGACAO-PARA-INTEGRACOES.md
- erps/<erp-slug>/ANALISE-DO-ERP.md
- erps/<erp-slug>/CAPACIDADES-DO-ERP.md
- erps/<erp-slug>/integracoes/<ferramenta-slug>/MATRIZ-ERP-FERRAMENTA.md
- erps/<erp-slug>/integracoes/<ferramenta-slug>/PENDENCIAS.md
- documentacao/13-PADRAO-GLOBAL-DE-MASSA-COMERCIAL.md
- parceiros/modelos/base-comercial/PADRAO-BASE-COMERCIAL.md
- parceiros/modelos/base-comercial/CONVENCAO-DE-IDENTIFICADORES.md
- parceiros/modelos/base-comercial/PADRAO-DE-IMAGENS.md
- parceiros/modelos/base-comercial/MODELO-BASE-HOMOLOGACAO.yaml
- parceiros/modelos/base-comercial/MODELO-PLANO-DE-HOMOLOGACAO.md

Se algum item nao existir, registrar PENDENTE_DE_EVIDENCIA ou GAP aplicavel.

## Regras normativas obrigatorias

- Quem manda e a ferramenta E-Catalogos.
- Funcionalidade da ferramenta nao equivale a endpoint de mesmo nome no ERP.
- Regra de negocio nao equivale a capacidade tecnica nem a comportamento confirmado em runtime.
- Nao remover necessidade da ferramenta para acomodar ERP.
- Incompatibilidade vira gap com impacto rastreavel.
- Nao transformar catalogo global em checklist universal.

Cobertura obrigatoria do planejamento:

CAMPOS
+
CENARIOS_FUNCIONAIS
+
REGRAS_COMERCIAIS
+
RELACOES_ENTRE_ENTIDADES

## Perfil

Perfil padrao desta etapa:

- HOMOLOGACAO

MINIMA nao substitui homologacao.

ESTRESSE e opcional/futuro.

Baseline operacional recomendado para HOMOLOGACAO (ERP Parceiro):

- PRODUTOS: 200
- CLIENTES: 20
- MARCAS: 10
- CATEGORIAS: 10
- SUBCATEGORIAS: 25
- LINHAS: 8 (quando aplicavel)
- TIPOS: 5 (quando aplicavel)
- GENEROS: ate 5 valores relevantes suportados
- CAMPANHAS: 4 (quando aplicavel)
- FILIAIS: 3 (quando suportado/relevante)
- TABELAS_DE_PRECO: 3 (quando suportado/relevante)
- CONDICOES_DE_PAGAMENTO: 5 (quando suportado/relevante)
- VENDEDORES: 10 (quando suportado/relevante)
- REPRESENTANTES: 5 (quando suportado/relevante)
- PREPOSTOS: 5 (quando suportado/relevante)
- TRANSPORTADORAS: 5 (quando suportado/relevante)
- PEDIDOS: 100 (quando aplicavel)

Regra:

- TARGET_PRODUTOS_PADRAO = 200.
- Pode aumentar quando cobertura exigir.
- Reduzir abaixo de 200 exige justificativa concreta registrada.

## Processamento obrigatorio

1. Validar contexto e gate de entrada.
2. Localizar Passo 02 da execucao ativa.
3. Carregar baseline HOMOLOGACAO da Fabrica.
4. Carregar contrato tecnico da ferramenta.
5. Carregar cenarios funcionais da ferramenta quando existir.
6. Carregar regras de negocio da ferramenta quando existir.
7. Carregar memoria tecnica do ERP.
8. Carregar matriz da combinacao e pendencias.
9. Determinar dimensoes do baseline aplicaveis na combinacao.
10. Identificar gaps e impactos por modo/cenario/regra.
11. Selecionar cenarios e regras de negocio necessarios para a combinacao.
12. Preservar baseline forte sempre que possivel e remover apenas dimensoes realmente irrelevantes.
13. Definir familias, repeticao, relacoes e volume derivados de cobertura.
14. Definir entidades comerciais necessarias (somente aplicaveis).
15. Definir estrategia de identificadores logicos estaveis.
16. Definir estrategia de EAN/codigo quando aplicavel.
17. Definir estrategia de imagens quando aplicavel.
18. Definir dependencias (DAG) de materializacao futura.
19. Registrar desvios de baseline com justificativa obrigatoria.
20. Registrar snapshot das fontes efetivamente usadas, com hash/versao somente quando disponivel.
21. Gerar PLANO-DE-HOMOLOGACAO.md da combinacao.
22. Gerar BASE-COMERCIAL-PLANEJADA.yaml da combinacao.
23. Validar cobertura planejada e impossibilidades declaradas.
24. Executar Harness aplicavel aos artefatos gerados.
25. Retornar gate final da etapa.

## Regras de cobertura e volume

- quantidade fixa universal e proibida;
- volume deve ser derivado de cobertura;
- cenario relevante nao deve ficar em unico registro sem justificativa;
- combinacao inteligente e desejada, sem eliminar repeticao critica;
- dados sem motivo de homologacao devem ser evitados.

Para HOMOLOGACAO de ERP Parceiro, evitar reducao agressiva de volume abaixo do baseline sem limitacao comprovada.

Aprovacao sem diversidade e invalida (ex.: 200 produtos equivalentes sem variacao comercial relevante).

Para produtos, considerar quando aplicavel: nacional/importado, pronta entrega/nao pronta entrega, grade aberta/fechada, marcas, categorias, tabelas, disponibilidades e atributos opcionais.

Para clientes, considerar quando aplicavel: regioes, tabelas, representantes, prepostos, condicoes comerciais, ativos e cenarios controlados de inatividade para listagem/visibilidade.

## Cenarios comerciais orientados a regra

Quando aplicaveis e sustentados pelas fontes, o plano deve conseguir representar:

1. mesmo produto com precos distintos por tabela/regiao;
2. produto presente em uma tabela e ausente em outra;
3. grade aberta com quantidades por tamanho;
4. grade fechada com pack/composicao fixa;
5. pronta entrega compativel com prazo;
6. nao pronta entrega com disponibilidade futura restringindo prazo anterior;
7. prazos diferentes por marca;
8. separacao nacional/importado;
9. origens representante/preposto preservando aprovacao/exportacao;
10. orcamento convertido em pedido, quando aplicavel.

ERP sem capacidade suficiente gera gap ou pendencia; nao gera cobertura ficticia.

## Rastreabilidade de regras

`PLANO-DE-HOMOLOGACAO.md` deve registrar `REGRAS_DE_NEGOCIO_CONSIDERADAS`.

Cada cenario/familia relevante deve possuir:

- `cenario_tags`
- `regra_tags`

Usar IDs estaveis publicados em `REGRAS-DE-NEGOCIO.md`, sem copiar a memoria inteira nem criar IDs aleatorios.

## Diversidade para relatorios

Quando pedidos fizerem parte da combinacao, os 100 pedidos do baseline devem variar suficientemente produtos, marcas, categorias, subcategorias, clientes, representantes, prepostos, referencias, variantes, quantidades e valores.

Nao exigir dados perfeitos de Curva ABC e nao exigir endpoint `Curva ABC` no ERP.

## Snapshot das fontes

O plano deve registrar as fontes efetivamente usadas para contrato tecnico, cenarios funcionais, regras de negocio, analise/capacidades do ERP, matriz e padrao de massa.

Para cada fonte, registrar caminho e, quando disponivel no repositorio, versao, SHA-256 e modo de hash. Nao inventar valores ausentes. O snapshot sera usado pelo Passo 04 para verificar se o plano continua vigente.

## EAN/codigo

- so planejar quando ferramenta/cenario exigir;
- se nao exigir, ausencia nao e gap;
- quando exigir, distinguir CODIGO_REAL e CODIGO_SINTETICO_HML;
- manter determinismo, formato, checksum e unicidade conforme combinacao;
- nao implementar gerador nesta etapa.

## Imagens

- seguir padrao de imagens global;
- usar referencias logicas quando necessario;
- SEM_IMAGEM e diferente de IMG-PLACEHOLDER-001;
- nao adicionar binarios.

Quando imagem for aplicavel em base de 200 produtos, baseline de cardinalidade recomendado:

- 45 com 1 imagem
- 45 com 2 imagens
- 45 com 3 imagens
- 45 com 4 imagens
- 10 SEM_IMAGEM
- 10 IMG-PLACEHOLDER-001

Reuso de imagens e permitido e desejavel.

## Outputs obrigatorios desta etapa

Gerar na memoria da combinacao:

- erps/<erp-slug>/integracoes/<ferramenta-slug>/PLANO-DE-HOMOLOGACAO.md
- erps/<erp-slug>/integracoes/<ferramenta-slug>/BASE-COMERCIAL-PLANEJADA.yaml

Nao gerar esses planos na memoria geral do ERP.

## Idempotencia e retomada

Se output ja existir:

- nao sobrescrever cegamente;
- detectar execucao anterior e mudanca legitima;
- respeitar checkpoint/harness;
- preservar decisoes humanas anteriores.

## Gate final obrigatorio

Retornar explicitamente:

- ERP_IDENTIFICADO: SIM | NAO
- FERRAMENTA_HOMOLOGADA: SIM | NAO
- PASSO_02_APTO: SIM | NAO
- PLANO_DE_HOMOLOGACAO: GERADO | BLOQUEADO
- BASE_COMERCIAL_PLANEJADA: GERADA | BLOQUEADA
- COBERTURA_PLANEJADA: COMPLETA | PARCIAL_JUSTIFICADA | INSUFICIENTE
- PENDENCIAS_BLOQUEANTES: <quantidade>
- SNAPSHOT_DAS_FONTES: REGISTRADO | INSUFICIENTE
- PRONTO_PARA_CRIAR_BASE_REAL: SIM | NAO

Nao marcar PRONTO_PARA_CRIAR_BASE_REAL como SIM quando houver pendencia bloqueante.

Se houver desvio de baseline, PLANO-DE-HOMOLOGACAO.md deve conter secao DESVIOS DO BASELINE com entidade, baseline, planejado e motivo.

## Fronteiras explicitas

- Esta etapa pode produzir plano parcial justificado.
- Gap nao apaga planejamento da parte viavel.
- Esta etapa nao implementa Passo 04.
- Esta etapa nao inicia automaticamente etapa futura.

## Como executar (operador)

### COPIE A PARTIR DAQUI

```text
Execute integralmente:
parceiros/comandos/ERP-PARCEIRO-03-PROJETAR-HOMOLOGACAO.md

Continue a execucao atual da jornada ERP parceiro e projete a homologacao da combinacao ERP x ferramenta.

Use auto-descoberta de contexto no repositorio.

Nao pedir novamente nome do ERP, ferramenta, autenticacao, capacidades, matriz ou fontes ja registradas.

Se faltar informacao bloqueante, solicitar somente o dado faltante e classificar o restante com PENDENTE_DE_EVIDENCIA quando aplicavel.

Passo 03 = planejamento.

Nao criar dados no ERP.
Nao executar POST/PUT/PATCH/DELETE comercial.
Nao usar credenciais.
Nao chamar APIs externas.
Nao desenvolver integracao.
Nao criar Passo 04.
Nao alterar contrato homologado da ferramenta.
Nao alterar Harness.
Nao alterar manifestos existentes.

Registrar no plano o snapshot das fontes efetivamente usadas, incluindo regras de negocio, sem inventar hashes ou versoes.

Gerar obrigatoriamente:
- PLANO-DE-HOMOLOGACAO.md
- BASE-COMERCIAL-PLANEJADA.yaml

na pasta da combinacao:
erps/<erp-slug>/integracoes/<ferramenta-slug>/

Executar Harness aplicavel e retornar gate final da etapa.
```

### PARE DE COPIAR AQUI

## Saida obrigatoria do retorno

STATUS DA ETAPA: CONCLUIDA | PENDENTE | BLOQUEADA

GATE DE ENTRADA:
- ERP_IDENTIFICADO: SIM/NAO
- FERRAMENTA_IDENTIFICADA: SIM/NAO
- FERRAMENTA_HOMOLOGADA: SIM/NAO
- PASSO_02_APTO: SIM/NAO
- MEMORIA_ERP_PRESENTE: SIM/NAO
- MATRIZ_PRESENTE: SIM/NAO

ARTEFATOS GERADOS:
- PLANO_DE_HOMOLOGACAO: <caminho ou BLOQUEADO>
- BASE_COMERCIAL_PLANEJADA: <caminho ou BLOQUEADO>

COBERTURA:
- COBERTURA_PLANEJADA: COMPLETA | PARCIAL_JUSTIFICADA | INSUFICIENTE
- MODOS_AFETADOS: <resumo>
- REGRAS_DE_NEGOCIO_CONSIDERADAS: <IDs ou NAO_APLICAVEL>

GAPS E PENDENCIAS:
- <lista resumida>

GATE FINAL:
- PRONTO_PARA_CRIAR_BASE_REAL: SIM/NAO
- PENDENCIAS_BLOQUEANTES: <quantidade>
- SNAPSHOT_DAS_FONTES: REGISTRADO/INSUFICIENTE

PROXIMA ACAO PERMITIDA:
- aguardar proxima etapa oficialmente publicada na jornada ERP parceiro (sem autoexecucao).
