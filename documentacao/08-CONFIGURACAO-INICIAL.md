# Configuração inicial do repositório

Este documento descreve apenas a preparação inicial da máquina/repositório. Não faz parte da sequência operacional de integração.

## Workspace

Abra no VS Code/Cursor somente a pasta do repositório `fabrica-de-integracoes`.

Não abra como workspace uma pasta-pai contendo vários repositórios da E-Catálogos.

## GitHub

Preferencialmente, utilize um repositório privado dedicado na organização da E-Catálogos.

A conta utilizada não precisa ser Owner da organização. O acesso deve ser limitado ao necessário para este repositório.

## Primeira publicação

Depois que o repositório remoto existir, configure o `origin`, crie uma branch inicial de trabalho e publique os arquivos da fábrica.

Proteções recomendadas para `main`:

- Pull Request obrigatório;
- bloquear force push;
- bloquear exclusão da branch;
- checks obrigatórios quando CI existir;
- revisão/aprovação antes do merge, quando possível.

## Codex

Ao abrir o repositório, o Codex deve começar lendo `AGENTS.md` e os `AGENTS.md` específicos da pasta em que trabalhar.
