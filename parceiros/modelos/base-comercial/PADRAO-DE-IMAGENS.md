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
