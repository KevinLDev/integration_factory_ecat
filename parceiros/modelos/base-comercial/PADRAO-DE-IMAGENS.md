# Padrao de imagens para base comercial de homologacao

## 1. Objetivo

Definir biblioteca logica reutilizavel de imagens para homologacao, sem versionar binarios nesta etapa.

## 2. Identidade logica

Padrao recomendado:

- IMG-STD-001
- IMG-STD-002
- IMG-STD-003
- IMG-PLACEHOLDER-001

Cenario explicito adicional:

- SEM_IMAGEM

## 3. Regras de uso

- imagem pode ser reutilizada entre produtos;
- imagem nao precisa ser exclusiva por produto;
- parametros e cobertura funcional sao mais importantes que variedade fotografica;
- alguns produtos devem testar multiplas imagens;
- alguns produtos devem testar ausencia total de imagem;
- placeholder e diferente de ausencia de imagem;
- imagem por cor/variacao so quando ferramenta e ERP suportarem.

### 3.1 Cardinalidade baseline para HOMOLOGACAO (quando imagem for aplicavel)

Para base de 200 produtos e quando imagem for relevante na combinacao:

- 45 produtos com 1 imagem;
- 45 produtos com 2 imagens;
- 45 produtos com 3 imagens;
- 45 produtos com 4 imagens;
- 10 produtos com SEM_IMAGEM;
- 10 produtos com IMG-PLACEHOLDER-001.

Objetivo de teste:

- cobertura de galeria 1/2/3/4;
- ausencia real de imagem;
- placeholder distinto de ausencia.

Regra:

- este baseline e condicional e nao universal;
- se a ferramenta nao usa imagem, a distribuicao nao e obrigatoria;
- se ERP nao suporta imagem e ferramenta nao exige, nao e gap;
- se ferramenta exige imagem e ERP nao suporta, registrar gap/impacto.

Reuso continua permitido dentro da distribuicao (ex.: IMG-STD-001 e IMG-STD-002 reutilizadas em multiplos produtos).

## 4. Metadados minimos

Cada referencia logica de imagem deve permitir registrar:

- image_id_logico;
- origem (biblioteca interna, operador, outra origem autorizada);
- checksum quando disponivel;
- formato (png/jpg/webp etc.);
- cenarios cobertos.

## 5. Imagens fornecidas pelo operador

Quando o operador fornecer imagens futuramente:

- atribuir id logico da biblioteca de homologacao;
- registrar metadados de rastreabilidade;
- nao depender do nome original do arquivo como semantica de negocio.

Exemplo conceitual:

- arquivo recebido: DX9136-VARIAS-1.png
- identidade logica: IMG-STD-001

## 6. Escopo desta etapa

Este documento define apenas o padrao.

Nao inclui:

- adicao de binarios no repositorio;
- inferencia de conteudo visual inexistente;
- execucao de upload em API.
