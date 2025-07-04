*** Settings ***
Documentation  Keywords para autenticação da API Cinema App
Library    Collections
Library    RequestsLibrary

*** Variables ***
${USER_EMAIL}    usuario@teste.com
${USER_PASSWORD}    teste123
${ADMIN_EMAIL}    admin@example.com
${ADMIN_PASSWORD}    admin123

*** Keywords ***
Criar dados validos para usuario
    ${user_data}=    Create Dictionary    name=Usuario Teste    email=usuario@teste.com    password=teste123
    ${email}=    Get From Dictionary   ${user_data}    email
    ${password}=    Get From Dictionary    ${user_data}    password
    Set Test Variable    ${user_data}
    Set Test Variable    ${email}
    Set Test Variable    ${password}
    ${headers}=    Create Dictionary    Content-Type=application/json    Accept=application/json
    ${response}=    POST On Session    cinemaApp    /auth/register    json=${user_data}    headers=${headers}
    RETURN    ${response}

Criar dados validos para administrador
    ${admin_data}=    Create Dictionary    name=Admin User    email=admin@example.com    password=admin123    role=admin
    ${email_admin}=    Get From Dictionary    ${admin_data}    email
    ${password_admin}=    Get From Dictionary    ${admin_data}    password
    Set Test Variable    ${admin_data}
    Set Test Variable    ${email_admin}
    Set Test Variable    ${password_admin}
    ${headers}=    Create Dictionary    Content-Type=application/json    Accept=application/json
    ${response}=    POST On Session    cinemaApp    /setup/admin    json=${admin_data}    headers=${headers}
    RETURN    ${response}


Fazer Login
    [Arguments]    ${email}    ${password}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${body}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    cinemaApp    /auth/login    json=${body}    headers=${headers}
    RETURN    ${response}

Fazer Login Usuario
    ${response}=    Fazer Login    ${email}    ${password}
    RETURN    ${response}

Fazer Login Admin
    ${response}=    Fazer Login    ${email_admin}    ${password_admin}
    RETURN    ${response}

Obter Token Usuario
    ${login_response}=    Fazer Login Usuario
    ${token}=    Get From Dictionary    ${login_response.json()["data"]}    token
    RETURN    ${token}

Obter Token Admin
    ${login_response}=    Fazer Login Admin
    ${token}=    Get From Dictionary    ${login_response.json()["data"]}    token
    RETURN    ${token}


Validar Usuario Criado
    [Arguments]    ${response}
    Status Should Be    201    ${response}
    Dictionary Should Contain Key    ${response.json()}    success
    Dictionary Should Contain Key    ${response.json()}    data

Validar Usuario Administrador Criado
    [Arguments]    ${response}
    Status Should Be    201    ${response}
    Dictionary Should Contain Key    ${response.json()}    success
    Dictionary Should Contain Key    ${response.json()}    data

Validar Login Bem Sucedido
    [Arguments]    ${response}
    Status Should Be    200    ${response}
    Dictionary Should Contain Key    ${response.json()}    success
    Dictionary Should Contain Key    ${response.json()}    data
    Dictionary Should Contain Key    ${response.json()["data"]}    token

Validar Login Invalido
    [Arguments]    ${response}
    Status Should Be    401    ${response} 