*** Settings ***
Documentation  Keywords para operações de usuários da API Cinema App
Library    RequestsLibrary

*** Keywords ***
Criar dados para atualização
    ${updated_data}=    Create Dictionary    name=Nome Teste      
    Set Test Variable    ${updated_data}



Buscar Usuario por ID
    [Arguments]    ${user_id}    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    cinemaApp    /users/${user_id}    headers=${headers}
    RETURN    ${response}

Buscar Todos Usuarios
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    cinemaApp    /users    headers=${headers}
    RETURN    ${response}

Atualizar Usuario
    [Arguments]    ${user_id}    ${user_data}    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}
    ${response}=    PUT On Session    cinemaApp    /users/${user_id}    json=${user_data}    headers=${headers}
    RETURN    ${response}

Deletar Usuario
    [Arguments]    ${user_id}    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    DELETE On Session    cinemaApp    /users/${user_id}    headers=${headers}
    RETURN    ${response}

Validar Usuario Criado
    [Arguments]    ${response}
    Status Should Be    201    ${response}

Validar Usuario Encontrado
    [Arguments]    ${response}
    Status Should Be    200    ${response}

Validar Usuario Deletado
    [Arguments]    ${response}
    Status Should Be    200    ${response}

Validar Usuario Administrador Criado
    [Arguments]    ${response}
    Status Should Be    201    ${response} 