# Integrar um cliente

## Quando usar

Use esta jornada quando existe um cliente real que utiliza um ERP e precisa ser integrado a uma ferramenta E-Catálogos.

Antes de seguir esta jornada, consulte `documentacao/09-RESOLUCAO-DE-CONTEXTO-DE-INTEGRACAO.md` para confirmar que a combinação ERP x ferramenta já está publicada no Passo 09 e que o cenário é realmente de reutilização para cliente.

## Regra principal

Antes de iniciar uma integração de cliente, a fábrica deve verificar se existe integração publicada para a combinação:

```text
ERP
+
Ferramenta E-Catálogos
```

Consulte `comece-aqui/integrar-erp/ERPS-INTEGRADOS.md`.

### Se a integração existir

Reutilize a integração publicada e trate somente as particularidades necessárias do cliente.

Não reconstrua o adaptador, não reanalise profundamente o ERP e não exija uma base comercial completa de desenvolvimento quando a combinação já estiver publicada.

### Se a integração não existir

Não desenvolva silenciosamente uma nova integração dentro da jornada de cliente.

Volte primeiro para:

`comece-aqui/integrar-erp/erp-parceiro/00-COMECE-AQUI.md`

## Visão da jornada futura

Quando for preparada e homologada, esta jornada poderá incluir etapas para:

- identificar o cliente;
- selecionar o ERP;
- selecionar a ferramenta E-Catálogos;
- verificar compatibilidade;
- registrar o ambiente;
- fornecer credenciais;
- identificar particularidades;
- aplicar configurações;
- testar conexão;
- testar módulos;
- testar fluxos de ida e volta;
- homologar o cliente;
- ativar a integração;
- documentar a configuração final.

Esses itens são somente a visão da jornada. Eles não representam passos disponíveis e não autorizam execução.

Quando esta jornada vier a ser liberada, ela deverá usar o adaptador publicado e trabalhar apenas com as credenciais, o ambiente e as particularidades do cliente.

## Disponibilidade

**JORNADA AINDA NÃO LIBERADA PARA EXECUÇÃO.**
