*** Settings ***
Documentation  Testes de usuários da API Cinema App
Resource    ../support/base.robot

Suite Setup    Criar Sessao
Test Setup    Limpar Dados de Teste
Test Teardown    Limpar Dados de Teste

*** Test Cases ***
CT-071 - Obter usuario por ID
    [Documentation]    Testa busca de usuário por ID
    ${create_admin_response}=    Criar dados validos para administrador
    ${create_response}=    Criar dados validos para usuario
    ${user_id}=    Get From Dictionary    ${create_response.json()["data"]}    _id
    ${token}=    Obter Token Admin
    ${response}=    Buscar Usuario por ID    ${user_id}    ${token}
    Validar Usuario Encontrado    ${response}

CT-070 - Obter todos os usuarios
    [Documentation]    Testa busca de todos os usuários
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    ${response}=    Buscar Todos Usuarios    ${token}
    Status Should Be    200    ${response}

CT-072 - Atualizar Usuario
    [Documentation]    Testa atualização de dados do usuário
    ${create_admin_response}=    Criar dados validos para administrador
    ${create_response}=    Criar dados validos para usuario
    ${user_id}=    Get From Dictionary    ${create_response.json()["data"]}    _id
    ${token}=    Obter Token Admin
    Criar dados para atualização
    ${response}=    Atualizar Usuario    ${user_id}    ${updated_data}    ${token}
    Status Should Be    200    ${response}

CT-074 - Deletar Usuario
    [Documentation]    Testa exclusão de usuário
    ${create_admin_response}=    Criar dados validos para administrador
    ${create_user_response}=    Criar dados validos para usuario
    ${user_id}=    Get From Dictionary    ${create_user_response.json()["data"]}    _id
    ${token}=    Obter Token Admin
    ${response}=    Deletar Usuario    ${user_id}    ${token}
    Validar Usuario Deletado    ${response} 