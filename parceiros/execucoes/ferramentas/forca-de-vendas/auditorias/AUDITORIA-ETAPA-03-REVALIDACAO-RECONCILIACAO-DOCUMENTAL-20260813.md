# AUDITORIA DA ETAPA 03 — REVALIDAÇÃO INDEPENDENTE DA RECONCILIAÇÃO DOCUMENTAL

```text
RESULTADO TECNICO: APTO_PARA_INTEGRACOES
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
PRONTIDAO: HOMOLOGADA_PARA_INTEGRACOES
```

## Identificação

- Ferramenta: Força de Vendas
- Jornada: `INTEGRAR_NOVA_FERRAMENTA`
- Etapa auditada: `03-VALIDAR-FERRAMENTA-CADASTRADA`
- Comando auditado: `parceiros/comandos/03-VALIDAR-FERRAMENTA-CADASTRADA.md`
- Relatório técnico auditado: `ferramentas/forca-de-vendas/HOMOLOGACAO-PARA-INTEGRACOES.md`
- Motivo: alteração legítima do handoff documental posterior à homologação, realizada e congelada em execução anterior
- Tipo de auditoria: `PROFUNDA`
- Data: 2026-08-13
- Checkpoint: inexistente
- Natureza desta execução: nova auditoria independente, separada da correção produtora

Pergunta auditada:

> A alteração legítima no comando técnico do Passo 03 mantém o Passo 03 semanticamente correto, auditável e apto para continuar homologando o Força de Vendas para uso nas jornadas de ERP?

Resposta independente: **SIM**. A alteração é exclusivamente documental, atua no roteamento posterior à homologação, não altera contrato, capacidades, critérios técnicos, pendências ou gate e é compatível com o resolvedor central vigente.

## Separação entre produção e auditoria

A correção dos documentos terminou antes desta execução. Os 15 documentos corrigidos foram congelados por hash antes da leitura auditora e permaneceram somente leitura. Nenhum SHA de controle foi reconciliado antes da conclusão da auditoria semântica e do rehash do conjunto protegido.

Durante esta auditoria:

- o comando alterado foi tratado como input protegido;
- contrato, canônicos, regras, cenários, homologação e fontes foram somente leitura;
- nenhuma correção foi aplicada aos 15 documentos;
- nenhum endpoint, código, Passo 07, chamada de API ou credencial foi criado ou usado;
- nenhuma auditoria histórica foi sobrescrita;
- nenhum manifesto foi alterado antes deste parecer.

## Procedimento oficial identificado

As regras vigentes determinam o seguinte procedimento para o Passo 03:

1. toda auditoria do Passo 03 é `PROFUNDA`;
2. os sete canônicos, a memória complementar declarada e a homologação formam o conjunto imutável auditado;
3. o comando e as fontes são inputs somente leitura;
4. alteração de input invalida mecanicamente a vigência e exige nova auditoria, não simples troca de hash;
5. `HOMOLOGACAO-PARA-INTEGRACOES.md` só deve ser regenerado se seu conteúdo técnico deixar de ser verdadeiro;
6. uma nova auditoria deve ser criada em arquivo distinto e a anterior deve permanecer histórica;
7. após aprovação e estabilização dos outputs, podem ser atualizados somente os campos de controle necessários em `ESTADO-DA-EXECUCAO.md` e `PASSO-03.yaml`;
8. textos declarados no manifesto usam `TEXT_CANONICAL_V1`; o PDF usa `BYTES_V1`;
9. o manifesto não inclui hash próprio e checkpoint não participa da cadeia de vigência;
10. não existe manifesto ou checkpoint downstream que exija reconciliação adicional.

## Vigência antes da revalidação

| Manifesto | Vigência calculada | Gate | Reutilizável | Exit code |
|---|---|---|---|---:|
| `PASSO-01.yaml` | `VALIDO` | `TRUE` | `TRUE` | 0 |
| `PASSO-02.yaml` | `VALIDO` | `TRUE` | `TRUE` | 0 |
| `PASSO-03.yaml` | `INVALIDADO_POR_ENTRADA_ALTERADA` | `TRUE` | `FALSE` | 2 |

A única divergência do Passo 03 era a entrada `parceiros/comandos/03-VALIDAR-FERRAMENTA-CADASTRADA.md`:

- hash esperado, `TEXT_CANONICAL_V1`: `C94D72C3E3FC266834C8EF39BE3BE710E01A7A8DD6E21D4B055C378133C79F94`;
- hash auditado atual, `TEXT_CANONICAL_V1`: `CA1570DF82A263DC65DDD4FCEEAF9638066EC6E7C8C908481AC49AC85D48FD2D`.

A invalidação foi aceita como correta e permaneceu ativa durante toda a fase auditora.

## Classificação formal da mudança

| Dimensão | Classificação |
|---|---|
| Tipo | `MUDANCA_DOCUMENTAL_DE_HANDOFF` |
| Escopo | `PROCESSO / ROTEAMENTO APOS HOMOLOGACAO` |
| Impacto no contrato | `NENHUM_CONFIRMADO` |
| Impacto na homologação técnica | `NENHUM_SEMANTICO` |
| Impacto nos outputs P3 | homologação preservada; auditoria vigente precisa de sucessora para a nova baseline |

O diff do comando contém exatamente duas substituições documentais:

1. a ferramenta homologada passa a retornar ao resolvedor central, que escolhe a jornada e o menor passo responsável;
2. a conclusão deixa explícito que o Passo 03 não cria integração ERP, não inicia jornada ERP e não salta gates.

Nenhuma seção de contrato, critério técnico, validação, segurança, auditoria, resultado técnico ou gate foi alterada.

## Baseline dos 15 documentos congelados

Os hashes abaixo usam SHA-256 por bytes exatos (`BYTES_V1`). O rehash imediatamente anterior à criação deste relatório coincidiu em 15/15 itens.

| Documento | SHA-256 inicial e pré-controle |
|---|---|
| `README.md` | `55A21CA031585615BA963AE26753CAAB04EBA3326B41FC3BA22368DF1E2E7DAB` |
| `comece-aqui/integrar-erp/00-COMECE-AQUI.md` | `349AF16FF736E7F3D331F4D9C492C395D71ECBE9A744B191ABF31A8C4BFFB596` |
| `comece-aqui/integrar-erp/erp-parceiro/04-MATERIALIZAR-BASE-HOMOLOGACAO.md` | `184C5BA61B5D446BBCF6D01DD3818F42A5166A658CDE396380F7083402FC6EA0` |
| `comece-aqui/integrar-nova-ferramenta/00-COMECE-AQUI.md` | `F70E5D90CA64505ADD505FBE722CB9C819852B8A65BCB7CF20EC1A5DF730D8C1` |
| `comece-aqui/integrar-nova-ferramenta/03-VALIDAR-FERRAMENTA-CADASTRADA.md` | `255D3BAAEF061E94E447BF70377FB9A9B95DA0A266D8B1E7979768400A6946A8` |
| `documentacao/00-VISAO-GERAL.md` | `20ADE9B132B1609637A4CD182EB45D474FB92F313377AFE8D815E3E2C2B93AAF` |
| `documentacao/03-COMO-FUNCIONAM-AS-ETAPAS.md` | `0E47AC2810B9A0D3A65C740390A6DB371F5D9C5F80131E05FCBF62E637C511B7` |
| `documentacao/07-CONTEXTO-INICIAL-DO-PROJETO.md` | `49AAB78CBB4E78911C19A22759F4E52AFAEF677D4BA41FD26B98F9929E327234` |
| `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md` | `34334C793544EF6A43AEE46F5D766580E5F1705985D8D23635DDCB61779108B7` |
| `documentacao/10-IA-DE-APOIO-DA-FABRICA.md` | `E31C581B9E3362DC06442C7300F1103D6AA68B6AA6ED7CE065C2DFF9278AD7B1` |
| `parceiros/00-GUIA-DE-EXECUCAO.md` | `B29937128A9229E2888F8EB2982F6CC4A458B3295E6D17F117114D010F543F01` |
| `parceiros/01-COMO-USAR-OS-COMANDOS.md` | `C941AA8BCAAC47D91769887C0263C4C17D6619E79C266BD38525B507572F9912` |
| `parceiros/auditorias/00-REGRAS-DE-AUDITORIA.md` | `A7C12CA06338EA6929569C1A633B31BE070C15CA3F9A559C9CB132C3AC2ABD2A` |
| `parceiros/comandos/03-VALIDAR-FERRAMENTA-CADASTRADA.md` | `CA1570DF82A263DC65DDD4FCEEAF9638066EC6E7C8C908481AC49AC85D48FD2D` |
| `parceiros/comandos/ERP-PARCEIRO-04-MATERIALIZAR-BASE-HOMOLOGACAO.md` | `36E3EADB559E6CC01472C643944E02FC27C958EEC3D41A45B4315CC6B9D17C9F` |

## Baseline imutável do Passo 03

Os hashes desta tabela também são por bytes exatos. O rehash após as verificações semânticas coincidiu em 9/9 itens.

| Artefato | SHA-256 inicial e final da fase auditora | Resultado |
|---|---|---|
| `ferramentas/forca-de-vendas/README.md` | `FFF8B40745E26B626124D7137EEE1BAD939AC4B109D5D4E69219C97A42AD0B03` | IGUAL |
| `ferramentas/forca-de-vendas/CONTRATO-DA-FERRAMENTA.yaml` | `870FCC6D206010B39CCF734B5012B053E8C69767804C7E048914834F6A2D3062` | IGUAL |
| `ferramentas/forca-de-vendas/MODULOS.md` | `2AA31B1BCD845FE1E0DA48904C6345A7D2708D8457AA8D195BBE6FCDC20EE68A` | IGUAL |
| `ferramentas/forca-de-vendas/DEPENDENCIAS.md` | `24DA857807A3D9D862170294A79ACEA969E92D90619A33CC2CCA8EF1E115EFE0` | IGUAL |
| `ferramentas/forca-de-vendas/BIDIRECIONALIDADE.md` | `82AD52AC8A6E3EF8AC1962BAA7658A25C8803B224F2DECC613B0BB5FE5850848` | IGUAL |
| `ferramentas/forca-de-vendas/PENDENCIAS.md` | `D189723EBCB538160CF56EB12D04049F2E495175EBD108F2BF2775D46128BB15` | IGUAL |
| `ferramentas/forca-de-vendas/FONTES.md` | `D193FA427A8C597BD0349F40A8816C4B57763806A7BF14FEF7471DF5BCDA4E89` | IGUAL |
| `ferramentas/forca-de-vendas/REGRAS-DE-NEGOCIO.md` | `99990B2C6A9C389F6C4BCA1295AE01A2C7898ADAA92D4968F21273E83CE61BEE` | IGUAL |
| `ferramentas/forca-de-vendas/HOMOLOGACAO-PARA-INTEGRACOES.md` | `A2AB08E30FFC8D3BE98BA02B471FA3A9B986DFBFC7151C7F58D99DAA98452068` | IGUAL |

## Fontes e validação técnica profunda

| Evidência | Modo | SHA-256 | Resultado |
|---|---|---|---|
| PDF oficial | `BYTES_V1` | `2C8AAB2659BCF8974905912024E86A0B7D1053FB55E2A5FE727785FC1AD01BFB` | igual à baseline aprovada |
| Extração textual vinculada | `TEXT_CANONICAL_V1` | `A4B16B88AE820A2B543F72C18FD0908E843C01D948B22BECEB63F8EA9A2B1D5F` | igual à baseline aprovada |
| Contrato | `TEXT_CANONICAL_V1` | `DDDE41534986D6228A332C2A214ECBD7C052B3DB0FADED5BE3ACB96D76A79B85` | igual ao manifesto vigente |
| Homologação | `TEXT_CANONICAL_V1` | `62505ADC813E7334A6464DD88CA2FB13AFC9288FCC2ECF7A3CECEB000B94DE77` | igual ao manifesto vigente |

Comparações independentes executadas:

- 26 módulos no escopo;
- 90 operações identificadas na extração e 90 IDs `OP-*` únicos no inventário, na matriz e no contrato;
- diferenças entre os quatro conjuntos normalizados por método e rota: 0;
- 47 rotas únicas;
- métodos: 12 `DELETE`, 24 `GET`, 7 `PATCH`, 25 `POST` e 22 `PUT`;
- direções: 66 `ERP -> ferramenta` e 24 `ferramenta -> ERP`;
- divergências entre IDs, operações e direções: 0;
- 20 pendências e 20 IDs únicos;
- 74 regras comerciais e 74 IDs únicos;
- estados de autenticação não documentados continuam explícitos;
- cenários funcionais continuam separados do contrato técnico;
- a memória de negócio continua complementar, sem promover regra documental a runtime e sem inventar rota.

Uma primeira invocação do teste de contagem de regras usou um padrão nominal inadequado, incompatível com os IDs `RN-FDV-*`, e produziu um falso negativo mecânico. O teste foi repetido com o padrão canônico do arquivo e aprovou 74/74 IDs únicos. Nenhum artefato foi alterado por essa repetição.

## Auditoria semântica A–T

| Item | Evidência e conclusão | Resultado |
|---|---|---|
| A | Identidade, finalidade e escopo continuam sendo os do Passo 03 da jornada Nova Ferramenta. | APROVADO |
| B | Critérios de fidelidade, suficiência, segurança, pendências e gate não mudaram. | APROVADO |
| C | Contrato permaneceu idêntico nos modos por bytes e texto canônico. | APROVADO |
| D | As 90 operações, 47 rotas e distribuição de métodos permaneceram iguais. | APROVADO |
| E | As 66 operações ERP para ferramenta e 24 no sentido inverso permanecem coerentes. | APROVADO |
| F | As 20 pendências permanecem visíveis e nenhuma foi artificialmente resolvida. | APROVADO |
| G | O handoff exige resolvedor e menor passo responsável; nenhum gate é pulado. | APROVADO |
| H | A ferramenta homologada retorna explicitamente ao resolvedor central. | APROVADO |
| I | O resolvedor, e não o Passo 03, decide a jornada seguinte. | APROVADO |
| J | Nova Ferramenta não cria nem autoexecuta ERP Parceiro. | APROVADO |
| K | Não há salto direto para ERP Parceiro Passo 06. | APROVADO |
| L | ERP Parceiro mantém seus próprios Passos 01–06 e seus gates. | APROVADO |
| M | Homologação da ferramenta não equivale a integração ERP homologada. | APROVADO |
| N | Passo 07 não existe e não foi autorizado. | APROVADO |
| O | HML e homologação funcional permanecem posteriores ao Passo 06 e futuras. | APROVADO |
| P | A ferramenta continua soberana sobre seu contrato canônico. | APROVADO |
| Q | Nenhuma autorização operacional adicional foi introduzida. | APROVADO |
| R | Nenhum secret ou valor sensível foi introduzido. | APROVADO |
| S | Nenhum gate, resultado técnico ou requisito de auditoria foi flexibilizado. | APROVADO |
| T | O novo handoff é compatível com o resolvedor central e com a escolha do menor caminho. | APROVADO |

Resultado da matriz: **20/20 APROVADO**.

## Classificação dos outputs e controles

| Item | Classificação | Tratamento |
|---|---|---|
| `HOMOLOGACAO-PARA-INTEGRACOES.md` | `INALTERADO_E_AINDA_VALIDO` | não regenerar nem alterar timestamp |
| `AUDITORIA-ETAPA-03-REVALIDACAO-REGRAS-DE-NEGOCIO-20260813.md` | `INCOMPATIVEL` apenas no papel de auditoria vigente da nova baseline | preservar integralmente como `HISTORICO_VALIDO` |
| este relatório | nova auditoria vigente | registrar como nova saída P3 após seu hash final |
| `ESTADO-DA-EXECUCAO.md` | `PRECISA_ATUALIZACAO_DOCUMENTAL` | atualizar somente referências de auditoria e vigência |
| `PASSO-03.yaml` | `PRECISA_ATUALIZACAO_DOCUMENTAL` | reconciliar integralmente os campos autorizados depois desta aprovação |

Não existe motivo semântico ou normativo para regenerar a homologação. Seu conteúdo não contém o handoff substituído, seu resultado técnico continua verdadeiro e seus hashes permanecem iguais.

## Contrato e homologação antes/depois

| Artefato | Modo | Antes | Depois da fase auditora | Resultado |
|---|---|---|---|---|
| Contrato | `BYTES_V1` | `870FCC6D206010B39CCF734B5012B053E8C69767804C7E048914834F6A2D3062` | `870FCC6D206010B39CCF734B5012B053E8C69767804C7E048914834F6A2D3062` | INALTERADO |
| Contrato | `TEXT_CANONICAL_V1` | `DDDE41534986D6228A332C2A214ECBD7C052B3DB0FADED5BE3ACB96D76A79B85` | `DDDE41534986D6228A332C2A214ECBD7C052B3DB0FADED5BE3ACB96D76A79B85` | INALTERADO |
| Homologação | `BYTES_V1` | `A2AB08E30FFC8D3BE98BA02B471FA3A9B986DFBFC7151C7F58D99DAA98452068` | `A2AB08E30FFC8D3BE98BA02B471FA3A9B986DFBFC7151C7F58D99DAA98452068` | INALTERADA |
| Homologação | `TEXT_CANONICAL_V1` | `62505ADC813E7334A6464DD88CA2FB13AFC9288FCC2ECF7A3CECEB000B94DE77` | `62505ADC813E7334A6464DD88CA2FB13AFC9288FCC2ECF7A3CECEB000B94DE77` | INALTERADA |

## Sucessão histórica

Permanecem preservados, sem reescrita:

- `AUDITORIA-ETAPA-03.md`, auditoria inicial reprovada;
- `AUDITORIA-ETAPA-03-REEXECUCAO-20260811.md`, reexecução aprovada;
- `AUDITORIA-ETAPA-03-REVALIDACAO-REGRAS-DE-NEGOCIO-20260813.md`, revalidação aprovada para a baseline anterior;
- snapshots existentes em `auditorias/historico/`.

Este relatório sucede somente o papel de auditoria vigente. Ele não altera o valor histórico das auditorias anteriores.

## Limitações

- `pdfinfo`, `pdftoppm` e interpretador Python não estavam disponíveis no ambiente; por isso não houve nova renderização visual do PDF nesta execução.
- Não foi instalada dependência nem alterada a máquina para contornar essa limitação.
- A identidade byte a byte do PDF foi comprovada, a extração textual vinculada manteve seu hash, as 90 operações foram comparadas independentemente e as auditorias profundas anteriores da mesma fonte foram consultadas.
- Os ZIPs e 23 HTMLs da fonte comercial não estão presentes nesta sessão; seus hashes permanecem registrados como informados, sem alegação de reinspeção byte a byte.

Essas limitações não afetam a conclusão sobre o delta auditado, que é documental, nem introduzem evidência técnica nova ou divergente.

## Delta de controle autorizado

Baselines anteriores às saídas de controle:

- `ESTADO-DA-EXECUCAO.md`: 4.587 bytes; SHA-256 por bytes `B2CC8629B36D15AA2DA8479FF3FEDBF00696B3FD5043A712D77AC5194B120166`;
- `PASSO-03.yaml`: 7.868 bytes; SHA-256 por bytes `EC9A45A0F3140A6E216CF869E9DD4850E4CB09A4DB618D0CE686041844234FB9`.

Somente depois desta aprovação fica autorizado:

1. registrar este relatório como auditoria vigente no estado;
2. registrar a auditoria anterior como preservada e superada apenas em vigência;
3. ajustar a descrição de vigência do Passo 03 para a revalidação profunda do comando reconciliado;
4. substituir no manifesto o hash da entrada do comando pelo valor completo auditado;
5. substituir caminho e hash da auditoria vigente em `resultado.auditoria_vigente` e `saidas[]`;
6. substituir o caminho da auditoria nas três listas de `validacoes_mecanicas`;
7. manter inalterados homologação, fontes, memória de negócio, dependências P1/P2, gate, resultado técnico, status, prontidão, tipo de auditoria e demais hashes;
8. manter `vigencia.estado: VALIDO` e `motivo: null` somente se o Harness pós-controle calcular `VALIDO`, gate `TRUE`, reutilização `TRUE` e exit 0.

Não é autorizado alterar P1, P2, contrato, homologação, canônicos, cenários, regras, Harness ou os 15 documentos congelados.

## Gate final da auditoria

```text
RESULTADO TECNICO: APTO_PARA_INTEGRACOES
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
PRONTIDAO: HOMOLOGADA_PARA_INTEGRACOES
```

A auditoria profunda conclui que a mudança documental mantém o Passo 03 correto e apto. A reutilização do gate somente será restaurada depois do delta de controle autorizado e da revalidação determinística final do manifesto.
