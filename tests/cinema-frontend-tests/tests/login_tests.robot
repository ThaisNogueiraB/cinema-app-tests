*** Settings ***
Documentation    Testes de Login do Cinema App
Resource         ../support/base.robot

Test Setup       Setup Test Environment
Test Teardown    Teardown Test Environment
Suite Setup      Silenciar InsecureRequestWarning

*** Test Cases ***
CTW-001: Cadastro de usuário válido via interface

    [tags]    cadastro
    
    ${dados_cadastro}=    Criar dados de cadastro válido
    Acessar tela de cadastro
    Preencher campos de cadastro    ${dados_cadastro}
    Clicar em cadastrar
    O usuário deve ser cadastrado com sucesso    ${dados_cadastro}[nome]

CTW-007: Login com dados válidos via interface
    [tags]    login

    # Garante que o usuário existe
    Criar usuário de teste - API    usuario

    ${data}=    Criar login válido
    Acessar tela de login
    Enviar formulário de login    ${data}
    O usuário deve estar logado   ${data}[nome]
    ${token_login}=    Gerar token de autorização    ${data}


CTW-012: Visualizar dados do perfil do usuário via interface
    [tags]    perfil
    
    # Garante que o usuário existe
    Criar usuário de teste - API    Usuário Teste

    # Login com os mesmos dados do usuário criado
    ${data}=    Criar login válido
    
    Acessar tela de login
    Enviar formulário de login    ${data}
    O usuário deve estar logado   ${data}[nome]
    
    Acessar página de perfil
    Verificar dados do perfil    ${data}[nome]    ${data}[email]

CTW-015: Atualizar dados do perfil via interface
    [tags]    atualizar-perfil

    # Garante que o usuário existe
    Criar usuário de teste - API    Usuário Teste

    # Login com os mesmos dados do usuário criado
    ${data}=    Criar login válido
    Acessar tela de login
    Enviar formulário de login    ${data}
    O usuário deve estar logado   ${data}[nome]
    
    Acessar página de perfil
    ${novos_dados}=    Criar dados de atualização de perfil
    Atualizar dados do perfil    ${novos_dados}
    # Verificar nome atualizado e email original (que não pode ser alterado)
    Verificar dados do perfil    ${novos_dados}[nome]    ${data}[email]
    
    # Screenshot de sucesso
    Take Screenshot    filename=CTW-015-sucesso-{index}

 