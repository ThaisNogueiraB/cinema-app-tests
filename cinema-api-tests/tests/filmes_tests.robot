*** Settings ***
Documentation  Testes de filmes da API Cinema App
Resource    ../support/base.robot

Suite Setup    Criar Sessao
Test Setup    Limpar Dados de Teste
Test Teardown    Limpar Dados de Teste

*** Test Cases ***
CT-020 - Criar filmes com dados validos
    [Documentation]    Testa criação de filme com dados válidos
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    Criar dados validos para filme
    ${response}    ${movie_id}=    Criar Filme E Obter ID    ${movie_data}    ${token}
    Validar Filme Criado    ${response}

CT-025 - Obter filme por id
    [Documentation]    Testa busca de filme por ID
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    Criar dados validos para filme
    ${create_movie_response}    ${movie_id}=    Criar Filme E Obter ID    ${movie_data}    ${token}
    ${response}=    Buscar Filme por ID    ${movie_id}
    Validar Filme Encontrado    ${response}

CT-019 - Obter todos os filmes
    [Documentation]    Testa busca de todos os filmes
    ${response}=    Buscar Todos Filmes
    Status Should Be    200    ${response}

CT-026 - Alterar nome filme com dados validos
    [Documentation]    Testa atualização de dados do filme
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    Criar dados validos para filme
    ${create_movie_response}    ${movie_id}=    Criar Filme E Obter ID    ${movie_data}    ${token}
    Criar dados para atualização de filme
    ${response}=    Atualizar Filme    ${movie_id}    ${updated_movie}    ${token}
    Status Should Be    200    ${response}

CT-028 - Deletar Filme
    [Documentation]    Testa exclusão de filme
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    Criar dados validos para filme
    ${create_movie_response}    ${movie_id}=    Criar Filme E Obter ID    ${movie_data}    ${token}
    ${response}=    Deletar Filme    ${movie_id}    ${token}
    Validar Filme Deletado    ${response} 