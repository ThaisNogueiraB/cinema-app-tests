*** Settings ***
Documentation  Testes de cinemas da API Cinema App
Resource    ../support/base.robot

Suite Setup    Criar Sessao
Test Teardown    Limpar Dados de Teste

*** Test Cases ***
CT-060 - Criar cinema com dados validos
    [Documentation]    Testa criação de cinema com dados válidos
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    Criar dados validos para cinema
    ${response}=    Criar Cinema    ${theater_data}    ${token}
    Validar Cinema Criado    ${response}

CT-064 - Obter cinema por id
    [Documentation]    Testa busca de cinema por ID
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    Criar dados validos para cinema
    ${create_theater_response}    ${theater_id}=    Criar Cinema E Obter ID    ${theater_data}    ${token}
    ${response}=    Buscar Cinema por ID    ${theater_id}
    Validar Cinema Encontrado    ${response}

CT-059 - Obter todos os cinemas
    [Documentation]    Testa busca de todos os cinemas
    ${response}=    Buscar Todos Cinemas
    Status Should Be    200    ${response}

CT-065 - Alterar nome cinema com dados validos
    [Documentation]    Testa atualização de dados do cinema
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    Criar dados validos para cinema
    ${create_theater_response}    ${theater_id}=    Criar Cinema E Obter ID    ${theater_data}    ${token}
    Criar dados para atualização de cinema
    ${response}=    Atualizar Cinema    ${theater_id}    ${updated_theater}    ${token}
    Status Should Be    200    ${response}

CT-067 - Deletar Cinema
    [Documentation]    Testa exclusão de cinema
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    Criar dados validos para cinema
    ${create_theater_response}    ${theater_id}=    Criar Cinema E Obter ID    ${theater_data}    ${token}
    ${response}=    Deletar Cinema    ${theater_id}    ${token}
    Validar Cinema Deletado    ${response} 