*** Settings ***
Documentation    Keywords para funcionalidades de Login
Library    Browser
Library    RequestsLibrary
Library    Collections

Resource    ../support/variables/cinema_variable_web.robot

*** Keywords ***
Criar dados de cadastro válido
    [Documentation]    Cria dados válidos para cadastro de usuário
    ${dados_cadastro}=    Create Dictionary
    ...    nome=Usuário Teste
    ...    email=usuario.teste@email.com
    ...    senha=senha123
    RETURN    ${dados_cadastro}

Acessar tela de cadastro
    [Documentation]    Acessa a tela de cadastro de usuário

    Go To    ${BASE_URL}/register
    Wait For Elements State    css=.register-container >> h1    visible    5
    Get Text                   css=.register-container >> h1    equal      Cadastro
    
Preencher campos de cadastro
    [Arguments]    ${dados_cadastro}
    [Documentation]    Preenche os campos do formulário de cadastro como uma pessoa digitando
    Fill Text    id=name    ${dados_cadastro}[nome]
    Sleep    1s
    Fill Text    id=email   ${dados_cadastro}[email]
    Sleep    1s
    Fill Text    id=password    ${dados_cadastro}[senha]
    Sleep    1s
    Fill Text    id=confirmPassword    ${dados_cadastro}[senha]
    Sleep    1s

Clicar em cadastrar
    [Documentation]    Clica no botão de cadastrar
    Click    css=.btn.btn-primary >> text=Cadastrar

O usuário deve ser cadastrado com sucesso
    [Arguments]    ${nome_usuario}
    [Documentation]    Verifica se o cadastro foi realizado com sucesso
    
    Wait For Elements State   css=.home-container >> text=Welcome to Cinema App    visible    5

Acessar tela de login
    [Documentation]    Acessa a tela de login de usuário

    Go To    ${BASE_URL}/login
    Wait For Elements State    css=.login-header >> h1    
    ...    visible    5
    Get Text                   css=.login-header >> h1    
    ...    equal      Login
    

Criar login válido
    [Documentation]    Retorna dados válidos para login de usuário de teste
    ${cadastro}=    Criar dados de cadastro válido
    ${login}=    Create Dictionary
    ...    email=${cadastro}[email]
    ...    password=${cadastro}[senha]
    ...    nome=${cadastro}[nome]
    RETURN    ${login}

Criar login admin válido
    [Documentation]    Retorna dados válidos para login de administrador
    ${login}=    Create Dictionary
    ...    email=admin@example.com
    ...    password=admin123
    ...    nome=Administrador
    RETURN    ${login}


Enviar formulário de login
    [Arguments]    ${user_data}
    [Documentation]    Preenche o formulário de login como uma pessoa digitando

    Fill Text    id=email    ${user_data}[email]
    Sleep    1s
    Fill Text    id=password    ${user_data}[password]
    Sleep    1s
    
    # Verificar se o botão está visível e habilitado
    Wait For Elements State    css=.btn.btn-primary.login-btn    visible    5
    Wait For Elements State    css=.btn.btn-primary.login-btn    enabled    5
    
    Click    css=.btn.btn-primary.login-btn

O usuário deve estar logado
    [Arguments]    ${nome_usuario}
    [Documentation]    Verifica se o login  foi realizado com sucesso
    Wait For Elements State   css=.home-container >> text=Welcome to Cinema App    visible    5

O usuário deve ver mensagem de erro
    [Arguments]    ${mensagem}
    Wait For Elements State    text=${mensagem}    visible


Acessar página de perfil

    [Documentation]    Acessa a página de perfil do usuário
    Click    css=a[href="/profile"] >> text=Perfil
    Wait For Elements State    css=.profile-header h1 >> text=Meu Perfil    visible    5

Verificar dados do perfil
    [Arguments]    ${nome}    ${email}
    [Documentation]    Verifica se os dados do perfil estão corretos
    ${valor_nome}=    Get Property    css=input[placeholder="Seu nome completo"]    value
    Should Be Equal    ${valor_nome}    ${nome}
    ${valor_email}=    Get Property    css=#email    value
    Should Be Equal    ${valor_email}    ${email}


Criar dados de atualização de perfil
    [Arguments]    ${nome}=Teste alterado    ${email}=teste@teste.com
    [Documentation]    Cria dados para atualização do perfil do usuário
    ${novos_dados}=    Create Dictionary
    ...    nome=${nome}
    ...    email=${email}
    RETURN    ${novos_dados}

Atualizar dados do perfil
    [Arguments]    ${novos_dados}
    [Documentation]    Atualiza apenas o campo de nome e salva

    Wait For Elements State    css=input[placeholder="Seu nome completo"]    visible    5
    Fill Text    css=input[placeholder="Seu nome completo"]    ${novos_dados}[nome]

    # Log para debug
    # Log removido para limpeza do console
    # Log removido para limpeza do console

    Wait For Elements State    css=button[title="Salvar alterações"]    enabled    5
    Click    css=button[title="Salvar alterações"]

    Wait For Elements State    css=.success-modal h2    visible    5
    ${mensagem}=    Get Text    css=.success-modal h2
    Should Be Equal    ${mensagem}    Sucesso!  


Fazer logout
    Click    id=user-menu
    Click    id=logout-button
    Wait For Elements State    id=email    visible

Limpar usuário via interface
    [Arguments]    ${email_usuario}=${EMAIL_CADASTRO}
    [Documentation]    Tenta limpar usuário via interface web como fallback
    TRY
        # Ir para página de administração (se existir)
        Go To    ${BASE_URL}/admin
        Sleep    2s
        
        # Tentar encontrar e excluir o usuário na interface
        ${user_row}=    Get Element    css=tr[data-email="${email_usuario}"]
        IF    ${user_row} is not None
            Click    css=tr[data-email="${email_usuario}"] .btn-delete
            Click    css=.modal .btn-confirm
        END
        
    EXCEPT    AS    ${error}
        # Silenciar erros de limpeza via interface
        Log    Erro silenciado na limpeza via interface: ${error}    console=False
    END







