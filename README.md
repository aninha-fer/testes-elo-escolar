# Testes Elo Escolar

Projeto acadêmico de automação de testes funcionais da aplicação **Elo Escolar**, desenvolvido com Robot Framework e SeleniumLibrary.

Os cenários cobrem login, alunos, profissionais, turmas e validações de conflitos de agenda.

## Estrutura

- `tests/`: cenários automatizados em arquivos `.robot`.
- `resources/comum.resource`: configurações de acesso e palavras-chave compartilhadas.
- `resultados/`: relatórios e arquivos gerados pela execução.

## Como executar

Pré-requisitos: Python e Google Chrome instalados.

1. Instale as dependências:

   ```bash
   pip install robotframework robotframework-seleniumlibrary
   ```

2. Em `resources/comum.resource`, configure a URL do ambiente de teste e as credenciais de um usuário de teste.

3. Execute os cenários:

   ```bash
   robot -d resultados tests/
   ```

Os relatórios da execução serão salvos em `resultados/`.
