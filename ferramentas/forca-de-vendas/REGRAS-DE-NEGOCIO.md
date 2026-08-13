# Regras de negocio - Forca de Vendas

## Fonte e natureza

- FONTE_REGRA_DE_NEGOCIO: pacote externo fornecido pelo operador, intitulado conceitualmente FDV - Regras de Negocio.
- Conteudo: 23 documentos HTML.
- Classificacao: REGRA_DOCUMENTADA.
- Esta memoria e consolidada e nao copia integralmente os documentos.
- Os HTMLs nao receberam hashes individuais nesta tarefa; a proveniencia disponivel permanece registrada em `ferramentas/forca-de-vendas/FONTES.md` pelos hashes dos pacotes externo e interno informados pelo operador.
- Salvo ressalva explicita, os itens `RN-FDV-*` abaixo permanecem `REGRA_DOCUMENTADA` e nao `CONFIRMADO_EM_RUNTIME`.

Convencao de tags de regra (estavel e simples):

- RN-FDV-<DOMINIO>-<SEQUENCIAL_3>

Exemplos:

- RN-FDV-PAP-001
- RN-FDV-CLI-001
- RN-FDV-PRE-001
- RN-FDV-PROD-001
- RN-FDV-PED-001

## Papeis e hierarquia

- RN-FDV-PAP-001: empresa/distribuidora administra a operacao.
- RN-FDV-PAP-002: usuarios administrativos gerenciam painel e permissoes.
- RN-FDV-PAP-003: representante e vendedor principal.
- RN-FDV-PAP-004: preposto e vendedor auxiliar vinculado a representante.
- RN-FDV-PAP-005: cliente/lojista e comprador.
- RN-FDV-PAP-006: representante e preposto possuem fluxos/permissoes diferentes.

## Clientes

- RN-FDV-CLI-001: clientes precisam estar cadastrados e vinculados.
- RN-FDV-CLI-002: listagem operacional privilegia clientes ativos.
- RN-FDV-CLI-003: vinculo com representante/preposto influencia visibilidade.
- RN-FDV-CLI-004: cliente participa de tabela/regiao/fluxo comercial.

## Regioes

- RN-FDV-REG-001: regioes podem agrupar estados/cidades.
- RN-FDV-REG-002: regiao se relaciona a tabela de preco.
- RN-FDV-REG-003: ha regra contra sobreposicao.
- RN-FDV-REG-004: influencia escopo e visibilidade comercial.

## Tabelas de preco

- RN-FDV-PRE-001: tabelas podem variar por regiao/estado.
- RN-FDV-PRE-002: mesmo produto pode ter preco diferente por tabela.
- RN-FDV-PRE-003: ausencia de produto em tabela pode ocultar item da compra.
- RN-FDV-PRE-004: tabela participa diretamente da visibilidade comercial.

## Marcas

- RN-FDV-MAR-001: produto deve possuir marca.
- RN-FDV-MAR-002: marca participa da visibilidade.
- RN-FDV-MAR-003: marca se relaciona a tabela/regiao/estado conforme regra documentada.
- RN-FDV-MAR-004: marca pode impactar prazo de entrega.

## Produtos

- RN-FDV-PROD-001: regra considera atributos comerciais como nome, referencia, tipo, nacional/importado, genero, categoria, subcategoria, marca, pronta entrega, nao pronta entrega, grade, tabela, disponibilidade e prazo.
- RN-FDV-PROD-002: formato de referencia exibido em exemplo funcional nao vira requisito universal de API sem evidencia tecnica.

## Grades

- RN-FDV-GRA-001: grade aberta permite quantidade por tamanho.
- RN-FDV-GRA-002: grade fechada possui pack/composicao pre-definida.
- RN-FDV-GRA-003: diferenca entre grade aberta e fechada e regra comercial, nao apenas campo tecnico.

## Disponibilidade / pronta entrega

- RN-FDV-DISP-001: pronta entrega e nao pronta entrega afetam disponibilidade comercial.
- RN-FDV-DISP-002: disponibilidade influencia regra de prazo e comportamento de compra.

## Prazo de entrega

- RN-FDV-PRA-001: prazo e selecionado na finalizacao.
- RN-FDV-PRA-002: prazo possui data inicial/final.
- RN-FDV-PRA-003: prazo pode estar vinculado a marcas.
- RN-FDV-PRA-004: prazo e obrigatorio para envio segundo regra documentada.
- RN-FDV-PRA-005: nao pronta entrega pode restringir prazos anteriores a disponibilidade.
- RN-FDV-PRA-006: pronta entrega tende a maior flexibilidade.
- RN-FDV-PRA-007: prazo nao equivale automaticamente a agendamento logistico.

## Nacional x Importado

- RN-FDV-ORI-001: fluxo comercial separa produtos nacionais e importados.
- RN-FDV-ORI-002: pedido/orcamento pode resultar em documentos separados.
- RN-FDV-ORI-003: Link Ecommerce tem tratamento separado por origem.

## Filial

- RN-FDV-FIL-001: filial participa do contexto comercial quando aplicavel.
- RN-FDV-FIL-002: disponibilidade e operacao podem variar por filial conforme regra documentada.

## Pedidos

- RN-FDV-PED-001: pedido nasce como pendente.
- RN-FDV-PED-002: criacao do pedido nao equivale a exportacao.
- RN-FDV-PED-003: exportacao representa envio oficial para distribuidora/fabrica.
- RN-FDV-PED-004: pedido de representante pode ser revisado/exportado.
- RN-FDV-PED-005: pedido de preposto depende de representante principal segundo a fonte.
- RN-FDV-PED-006: pedido de Link Ecommerce fica pendente ate aprovacao/exportacao.
- RN-FDV-PED-007: nao assumir integracao no evento de criacao quando regra exige exportacao posterior.

## Exportacao de pedidos

- RN-FDV-EXP-001: exportacao e marco comercial distinto da criacao.
- RN-FDV-EXP-002: exportacao exige estado/acao de envio oficial.

## Prepostos e representantes

- RN-FDV-RP-001: representante e preposto possuem papeis e permissoes distintos.
- RN-FDV-RP-002: relacao representante -> preposto impacta aprovacao/exportacao.

## Link Ecommerce

- RN-FDV-LINK-001: possui fluxo proprio de aprovacao/exportacao conforme regra documentada.
- RN-FDV-LINK-002: tratamento nacional/importado pode ser separado no fluxo.

## Orcamentos

- RN-FDV-ORC-001: orcamento e documento comercial preliminar.
- RN-FDV-ORC-002: orcamento nao e exportado enquanto orcamento.
- RN-FDV-ORC-003: orcamento pode ser editado respeitando disponibilidade.
- RN-FDV-ORC-004: orcamento pode ser convertido em pedido.
- RN-FDV-ORC-005: apos conversao, segue regras de pedido.
- RN-FDV-ORC-006: separacao nacional/importado tambem se aplica.

## Metodos de compra

- RN-FDV-MOD-001: Pedido Normal/Filtros Avancados e experiencia funcional.
- RN-FDV-MOD-002: Passo a Passo e experiencia funcional.
- RN-FDV-MOD-003: Galeria e experiencia funcional.
- RN-FDV-MOD-004: Referencias e experiencia funcional.
- RN-FDV-MOD-005: Codigo de Barras e experiencia funcional.
- RN-FDV-MOD-006: Replicar e experiencia funcional.
- RN-FDV-MOD-007: Modo Direto e experiencia funcional.
- RN-FDV-MOD-008: Link Ecommerce e experiencia funcional.
- RN-FDV-MOD-009: funcionalidade da ferramenta nao implica endpoint equivalente no ERP.

## Painel administrativo

- RN-FDV-ADM-001: painel administrativo gerencia regras, acessos e fluxo operacional.

## Relatorios / Curva ABC

- RN-FDV-ABC-001: Curva ABC depende de pedidos registrados.
- RN-FDV-ABC-002: agrupamentos podem envolver marcas, produtos, categorias, clientes, representantes, prepostos, referencias e variantes.
- RN-FDV-ABC-003: massa comercial precisa diversidade minima para nao inutilizar relatorios.
- RN-FDV-ABC-004: nao exige endpoint ERP chamado Curva ABC.

## Dependencias entre regras

Relacoes funcionais/comerciais documentadas:

- CLIENTE -> REGIAO -> TABELA_DE_PRECO
- TABELA_DE_PRECO -> PRODUTO -> PRECO/VISIBILIDADE
- PRODUTO -> MARCA
- MARCA -> PRAZO_DE_ENTREGA
- PRODUTO -> DISPONIBILIDADE -> PRAZO_DE_ENTREGA
- PRODUTO -> GRADE -> TAMANHOS/PACK
- REPRESENTANTE -> PREPOSTO
- REPRESENTANTE/PREPOSTO -> CLIENTE
- PEDIDO -> CLIENTE -> REPRESENTANTE/PREPOSTO
- PEDIDO -> EXPORTACAO
- ORCAMENTO -> CONVERSAO -> PEDIDO

Observacao:

- essas relacoes sao funcionais/comerciais, nao diagrama de banco de dados.

## Pontos ainda nao confirmados em runtime

- RC-FDV-RUN-001: funcionamento de Regioes no painel em periodo referido pela fonte.
- RC-FDV-RUN-002: evento/rota exata que representa exportacao oficial de pedido.
- RC-FDV-RUN-003: separacao nacional/importado em todos os fluxos e variacoes de interface.
- RC-FDV-RUN-004: restricoes finais de prazo por marca/disponibilidade em todas as combinacoes.

## Divergencias / ressalvas

- RS-FDV-001: a propria fonte registra que parte de Regioes ainda nao estava implementada no painel naquele momento.
- RS-FDV-002: regra comercial documentada nao confirma endpoint tecnico equivalente.
- RS-FDV-003: regra documentada nao confirma automaticamente comportamento runtime.
- RS-FDV-004: conflitos entre regra e capacidade tecnica devem virar pendencia, sem sobrescrever contrato homologado.

## Glossario semantico minimo

- REGRA_DOCUMENTADA: regra comercial sustentada pela fonte funcional/regra.
- CAPACIDADE_TECNICA_PENDENTE_DE_EVIDENCIA: requisito de API ainda sem prova suficiente.
- IMPLEMENTACAO_FUNCIONAL_NAO_CONFIRMADA: ressalva explicita de funcionalidade nao confirmada no runtime.
