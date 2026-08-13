# AUDITORIA DA ETAPA 02 — REVALIDAÇÃO DAS REGRAS DE NEGÓCIO

```text
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA
PRONTIDAO GLOBAL: NAO_HOMOLOGADA ATE REVALIDACAO DO PASSO 03
USO EM ERP PARCEIRO: BLOQUEADO ATE REVALIDACAO DO PASSO 03
```

## Identificação

- Ferramenta: Força de Vendas
- Etapa auditada: `02-CADASTRAR-FERRAMENTA`
- Comando auditado: `parceiros/comandos/02-CADASTRAR-FERRAMENTA.md`
- Motivo: revalidar a incorporação legítima de uma fonte complementar de regras de negócio que alterou `FONTES.md`
- Tipo resolvido: `PROFUNDA`
- Data: 2026-08-13
- Checkpoint: inexistente; não houve retomada por checkpoint
- Manifesto avaliado antes do delta de controle: `PASSO-02.yaml`, declarado `VALIDO`, calculado `INVALIDADO_POR_SAIDA_ALTERADA`, exit code `2`

A auditoria é profunda porque esta é a primeira homologação da nova fonte complementar e existe divergência explicada de hash. O relatório histórico `AUDITORIA-ETAPA-02-REEXECUCAO-POS-PASSO-03.md` foi preservado sem alteração.

## Separação de escopo

### Artefatos auditados imutáveis

1. `ferramentas/forca-de-vendas/README.md`
2. `ferramentas/forca-de-vendas/CONTRATO-DA-FERRAMENTA.yaml`
3. `ferramentas/forca-de-vendas/MODULOS.md`
4. `ferramentas/forca-de-vendas/DEPENDENCIAS.md`
5. `ferramentas/forca-de-vendas/BIDIRECIONALIDADE.md`
6. `ferramentas/forca-de-vendas/PENDENCIAS.md`
7. `ferramentas/forca-de-vendas/FONTES.md`
8. `ferramentas/forca-de-vendas/REGRAS-DE-NEGOCIO.md`

Os sete primeiros são os canônicos protegidos do Passo 02. `REGRAS-DE-NEGOCIO.md` foi congelado como entrada complementar consumida nesta revalidação; ele não é uma oitava saída canônica nem substitui a fonte técnica.

### Fontes de autoridade somente leitura

- PDF oficial e extração textual vinculada da API;
- artefatos e auditoria vigente do Passo 01;
- comando e critérios de aceite do Passo 02;
- especificação fornecida pelo operador para a incorporação de `FDV - Regras de Negócio`;
- regras do Harness e de auditoria;
- estado e manifesto anteriores ao delta de controle;
- auditorias históricas dos Passos 02 e 03.

### Saídas de controle permitidas

1. este novo relatório;
2. após o rehash final, os campos autorizados de `ESTADO-DA-EXECUCAO.md`;
3. após o rehash final, os campos de auditoria, entradas, hashes, validações mecânicas e vigência de `PASSO-02.yaml`.

Nenhum artefato auditado foi corrigido, regenerado ou formatado durante a auditoria.

## Autoridade e limitação da nova fonte

A nova fonte foi classificada como `FONTE_REGRA_DE_NEGOCIO`: conhecimento funcional/comercial complementar fornecido pelo operador. Ela não representa automaticamente mudança de Swagger, endpoint, método, payload, autenticação ou versão técnica da API.

O pacote com os 23 HTMLs e seus ZIPs não está disponível nesta sessão. Por isso, esta auditoria não afirma ter recalculado os dois hashes informados, reinspecionado os HTMLs nem verificado cada documento byte a byte. A evidência disponível e efetivamente usada foi:

- a especificação aprovada e fornecida pelo operador, que descreve os 23 temas e as regras a consolidar;
- o registro de proveniência em `FONTES.md`;
- o ZIP externo informado como `8816f5836a39619e8acc67baf321af3a33bddab4b25d321ae6ec22c19ba479d3`;
- o ZIP interno informado como `cd07f127927b35f8d307331c88aeb5df2100e3f2f8e3c785ccc11c08a1f553ec`;
- a declaração explícita de que hashes individuais dos HTMLs não foram informados nem inventados;
- a memória consolidada `REGRAS-DE-NEGOCIO.md`.

Essa limitação não transforma os hashes informados em hashes verificados. A auditoria aprova a incorporação e a classificação conforme a decisão documentada do operador, sem sobreafirmar a evidência disponível.

## Diagnóstico da invalidação e procedimento oficial

`FONTES.md` integra `saidas[]` de `PASSO-02.yaml` com `hash_mode: TEXT_CANONICAL_V1`. Seu hash canônico mudou legitimamente de `288D052320320FCC332D26027E9452F87A7FAF69DD25BCF0B0ADE0F7AF42DCF8` para `D193FA427A8C597BD0349F40A8816C4B57763806A7BF14FEF7471DF5BCDA4E89`; por isso o Harness calculou `INVALIDADO_POR_SAIDA_ALTERADA`.

O Harness possui comandos somente leitura para `hash`, `files`, `manifest`, `checkpoint` e `selftest`; não existe comando automático de reescrita ou reconciliação de manifesto. O procedimento oficial encontrado é:

1. encerrar a fase produtora e congelar a baseline;
2. executar auditoria nova e independente;
3. preservar relatórios históricos;
4. somente após todas as verificações, atualizar o delta estritamente controlado de estado e manifesto;
5. recalcular o manifesto;
6. reexecutar semanticamente o downstream alcançável.

Não existe hash agregado, hash próprio do manifesto ou `produced_hash`. O checkpoint não participa da cadeia e não existe nesta execução. A auditoria vigente possui hash próprio no manifesto e precisa ser substituída pelo novo relatório. `PASSO-03.yaml` referencia o Passo 02 por manifesto upstream e por hashes individuais esperados, portanto será reexecutado somente depois de o Passo 02 voltar a ser um gate válido.

## Integridade das fontes técnicas

| Fonte | Bytes | Modo | SHA-256 | Resultado |
|---|---:|---|---|---|
| PDF oficial | 1.526.436 | `BYTES_V1` | `2C8AAB2659BCF8974905912024E86A0B7D1053FB55E2A5FE727785FC1AD01BFB` | IGUAL À BASELINE |
| Extração textual vinculada | 113.964 | `TEXT_CANONICAL_V1` | `A4B16B88AE820A2B543F72C18FD0908E843C01D948B22BECEB63F8EA9A2B1D5F` | IGUAL À BASELINE |
| Manifesto do Passo 01 | — | Harness | vigência calculada `VALIDO` | gate atendido; exit `0` |

## Baseline imutável e rehash final

Os hashes desta tabela são por bytes exatos. O rehash final foi executado depois de todas as verificações semânticas e antes de qualquer saída de controle.

| Artefato | Bytes | Modificação capturada | SHA-256 inicial | SHA-256 final | Integridade |
|---|---:|---|---|---|---|
| `README.md` | 4.201 | `2026-08-11T08:18:45.3527179-03:00` | `FFF8B40745E26B626124D7137EEE1BAD939AC4B109D5D4E69219C97A42AD0B03` | `FFF8B40745E26B626124D7137EEE1BAD939AC4B109D5D4E69219C97A42AD0B03` | IGUAL |
| `CONTRATO-DA-FERRAMENTA.yaml` | 675.498 | `2026-08-11T08:28:21.3712151-03:00` | `870FCC6D206010B39CCF734B5012B053E8C69767804C7E048914834F6A2D3062` | `870FCC6D206010B39CCF734B5012B053E8C69767804C7E048914834F6A2D3062` | IGUAL |
| `MODULOS.md` | 11.705 | `2026-08-11T07:50:03.4473694-03:00` | `2AA31B1BCD845FE1E0DA48904C6345A7D2708D8457AA8D195BBE6FCDC20EE68A` | `2AA31B1BCD845FE1E0DA48904C6345A7D2708D8457AA8D195BBE6FCDC20EE68A` | IGUAL |
| `DEPENDENCIAS.md` | 8.901 | `2026-08-11T08:18:45.3557096-03:00` | `24DA857807A3D9D862170294A79ACEA969E92D90619A33CC2CCA8EF1E115EFE0` | `24DA857807A3D9D862170294A79ACEA969E92D90619A33CC2CCA8EF1E115EFE0` | IGUAL |
| `BIDIRECIONALIDADE.md` | 32.213 | `2026-08-11T07:47:48.9413766-03:00` | `82AD52AC8A6E3EF8AC1962BAA7658A25C8803B224F2DECC613B0BB5FE5850848` | `82AD52AC8A6E3EF8AC1962BAA7658A25C8803B224F2DECC613B0BB5FE5850848` | IGUAL |
| `PENDENCIAS.md` | 13.748 | `2026-08-11T07:54:05.7043805-03:00` | `D189723EBCB538160CF56EB12D04049F2E495175EBD108F2BF2775D46128BB15` | `D189723EBCB538160CF56EB12D04049F2E495175EBD108F2BF2775D46128BB15` | IGUAL |
| `FONTES.md` | 8.593 | `2026-08-13T08:47:09.8525511-03:00` | `D193FA427A8C597BD0349F40A8816C4B57763806A7BF14FEF7471DF5BCDA4E89` | `D193FA427A8C597BD0349F40A8816C4B57763806A7BF14FEF7471DF5BCDA4E89` | IGUAL |
| `REGRAS-DE-NEGOCIO.md` | 8.512 | `2026-08-13T08:47:09.8505546-03:00` | `99990B2C6A9C389F6C4BCA1295AE01A2C7898ADAA92D4968F21273E83CE61BEE` | `99990B2C6A9C389F6C4BCA1295AE01A2C7898ADAA92D4968F21273E83CE61BEE` | IGUAL |

Alterações durante a auditoria: **0/8**.

Hashes canônicos relevantes para o manifesto:

- `FONTES.md`: `D193FA427A8C597BD0349F40A8816C4B57763806A7BF14FEF7471DF5BCDA4E89`;
- `REGRAS-DE-NEGOCIO.md`: `6B34D6E2CDD4D1672766635D1A8F263D5C66FDD6E93A1C549C3DC391A3A7A9CD`.

## Validações mecânicas executadas

| Verificação | Resultado | Exit code |
|---|---|---:|
| `harness.cmd files` nos sete canônicos e em `REGRAS-DE-NEGOCIO.md` | 8/8 `OK` | 0 |
| Contagem e unicidade do contrato | 90 operações / 90 IDs únicos | 0 |
| Contagem e unicidade da bidirecionalidade | 90 operações / 90 IDs únicos | 0 |
| Contagem e unicidade de pendências | 20 pendências / 20 IDs únicos | 0 |
| Contagem e unicidade das regras | 74 regras / 74 IDs `RN-FDV-*` únicos | 0 |
| Hash do PDF oficial contra o esperado | `IGUAL` | 0 |
| Hash canônico da extração contra o esperado | `IGUAL` | 0 |
| `harness.cmd manifest PASSO-01.yaml` | `VALIDO`, gate atendido | 0 |
| `harness.cmd manifest PASSO-02.yaml` antes do delta | `INVALIDADO_POR_SAIDA_ALTERADA` | 2 esperado |
| `harness.cmd manifest PASSO-02.yaml` após o delta | `VALIDO`, gate atendido e reutilizável | 0 |
| Varredura de segredos potenciais em `FONTES.md` e `REGRAS-DE-NEGOCIO.md` | 0 ocorrências | 0 |

Uma primeira tentativa de regex esperava IDs no formato inexistente `RN-000` e retornou exit `2`; ela foi identificada como erro do teste, não do artefato. A validação foi repetida com a convenção documentada `RN-FDV-<DOMINIO>-<SEQUENCIAL_3>` e aprovou 74/74, exit `0`.

## Validação semântica independente

### Classificação e proveniência

- `FONTES.md` registra `FDV - Regras de Negócio` como `FONTE_REGRA_DE_NEGOCIO`, fornecida pelo operador e não versionada como binário.
- Os dois hashes de ZIP aparecem como **informados**, não como recalculados.
- A quantidade de 23 HTMLs está registrada; hashes individuais permanecem ausentes e não foram inventados.
- A fonte complementar não substitui PDF, extração, Swagger, contrato nem evidência runtime.

### Memória e cautelas

- A memória cobre a estrutura pedida: papéis, clientes, regiões, tabelas, marcas, produtos, grades, disponibilidade, prazo, origem, filial, pedidos, exportação, prepostos, Link Ecommerce, orçamentos, métodos de compra, painel, Curva ABC, dependências, runtime pendente e ressalvas.
- As 74 regras são concisas, identificadas por convenção estável e não copiam integralmente os 23 documentos.
- As relações entre cliente, região, tabela, produto, marca, prazo, grade, representante, preposto, pedido, exportação e orçamento estão descritas como funcionais/comerciais, sem cardinalidade de banco inventada.
- `REGRA_DOCUMENTADA` permanece distinta de `CONFIRMADO_EM_RUNTIME`.
- A ressalva de Regiões não confirmadas no painel naquele momento foi preservada.
- Criação de pedido não foi equiparada automaticamente à exportação.
- Funcionalidades como Curva ABC e métodos de compra não foram convertidas em endpoints homônimos.

### Contrato e canônicos técnicos

- `git diff` entre os sete canônicos mostrou alteração somente em `FONTES.md`.
- `CONTRATO-DA-FERRAMENTA.yaml`, `README.md`, `MODULOS.md`, `DEPENDENCIAS.md`, `BIDIRECIONALIDADE.md` e `PENDENCIAS.md` permanecem idênticos à baseline protegida.
- Nenhum método HTTP, rota ou URL foi declarado em `REGRAS-DE-NEGOCIO.md`.
- Não existe conflito técnico real que exija reprojetar o contrato. Regras funcionais e capacidade técnica continuam em camadas distintas; qualquer confirmação runtime futura permanece sujeita a evidência.

## Critérios de aceite

| Critério | Resultado |
|---|---|
| Passo 01 vigente e aprovado | APROVADO |
| Fonte técnica oficial íntegra | APROVADO |
| Nova fonte classificada como complementar | APROVADO |
| Proveniência registrada sem inventar hashes | APROVADO |
| `FONTES.md` contém a nova fonte | APROVADO |
| `REGRAS-DE-NEGOCIO.md` é memória complementar | APROVADO |
| Regra documentada não promovida a runtime | APROVADO |
| Nenhum endpoint inventado | APROVADO |
| Ressalvas e pendências preservadas | APROVADO |
| Contrato técnico inalterado | APROVADO |
| Seis demais canônicos técnicos inalterados | APROVADO |
| Contagens e IDs consistentes | APROVADO |
| UTF-8 e Markdown válidos | APROVADO |
| Nenhuma credencial persistida | APROVADO |
| Integridade antes/depois | APROVADO — 8/8 |

## Divergências e pendências

- Divergência impeditiva: **0**.
- Conflito real entre regra de negócio e contrato técnico: **0**.
- Endpoints, payloads ou comportamentos runtime inventados: **0**.
- Pendências contratuais existentes: 20, preservadas sem alteração.
- Limitação de evidência desta sessão: os ZIPs e 23 HTMLs não estão presentes; seus hashes permanecem registrados apenas como informados pelo operador.
- O Passo 03 permanece downstream invalidado até reexecução e nova auditoria profunda; a aprovação do Passo 02 não restaura sozinha a prontidão global.

## Delta de controle autorizado

Baseline anterior às saídas de controle:

- `ESTADO-DA-EXECUCAO.md`: 3.719 bytes; SHA-256 por bytes `7E722602A929ADADF72B02BF2229D05C64612D499BA27D964F46753F28C16DCF`;
- `PASSO-02.yaml`: 8.007 bytes; SHA-256 por bytes `EDCC35BC6F96044D0A8C7D1790F8AB444A51E35C5AC6D60599AD00D3C32A644B`.

Após todas as verificações e o rehash final, fica autorizado:

1. apontar a auditoria vigente do Passo 02 para este relatório, com tipo `PROFUNDA` e resultado `APROVADA`;
2. atualizar o hash canônico protegido de `FONTES.md`;
3. registrar `REGRAS-DE-NEGOCIO.md` em `entradas[]`, com `TEXT_CANONICAL_V1`, para que futuras mudanças invalidem P2 e o downstream;
4. substituir a auditoria histórica em `saidas[]` por este novo relatório e seu hash;
5. incluir a memória e este relatório nas validações mecânicas aplicáveis;
6. manter `resultado.status: CONCLUIDA` e `vigencia.estado: VALIDO` somente se o Harness pós-controle aprovar;
7. atualizar o estado para registrar o novo relatório P2 e bloquear temporariamente a prontidão até a revalidação do Passo 03.

Não é autorizado alterar o Passo 01, o contrato ou qualquer outro canônico técnico.

## Resultado final

```text
AUDITORIA: APROVADA
STATUS DA ETAPA: CONCLUIDA

PASSO 02: VALIDO E REUTILIZAVEL COMO GATE
PASSO 03: REEXECUCAO E AUDITORIA PROFUNDA OBRIGATORIAS
PRONTIDAO GLOBAL: NAO_HOMOLOGADA ATE PASSO 03
USO EM ERP PARCEIRO: BLOQUEADO ATE PASSO 03
```

O conteúdo auditado permite reconciliar a vigência do Passo 02. A prontidão técnica anterior só poderá permanecer depois de uma nova execução semântica do Passo 03, baseada no Passo 02 novamente válido.
