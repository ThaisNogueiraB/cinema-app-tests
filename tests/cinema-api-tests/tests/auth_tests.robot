*** Settings ***
Documentation  Testes de autenticação da API Cinema App
Resource    ../support/base.robot

Suite Setup    Criar Sessao
Test Setup    Limpar Dados de Teste
Test Teardown    Limpar Dados de Teste

*** Test Cases ***
CT-001 - Cadastro user com dados validos
    [Documentation]    Cadastra usuário com dados válidos
    ${response}=    Criar dados validos para usuario
    auth_keywords.Validar Usuario Criado    ${response}

Criar administrador
    [Documentation]    Cadastra administrador com dados validos 
    ${response}=    Criar dados validos para administrador
    auth_keywords.Validar Usuario Administrador Criado    ${response}

CT-007 - Login com dados validos
    [Tags]    loginvalido
    [Documentation]    Testa login com credenciais válidas
    ${create_response}=    Criar dados validos para usuario
    Status Should Be    201    ${create_response}
    ${response}=    Fazer Login Usuario
    Validar Login Bem Sucedido    ${response}

Login com dados admin
    [Documentation]    Testa login de administrador com credenciais válidas
    ${create_response}=    Criar dados validos para administrador
    Status Should Be    201    ${create_response}
    ${response}=    Fazer Login Admin
    Validar Login Bem Sucedido    ${response}
