*** Settings ***
Documentation  Keywords para operações de cinemas da API Cinema App
Library    RequestsLibrary
Library    Collections

*** Keywords ***

Criar dados validos para cinema
    ${theater_data}=    Create Dictionary    name=Sala 1    
    ...    capacity=150    type=IMAX
    Set Test Variable    ${theater_data}

Criar dados para atualização de cinema
    ${updated_theater}=    Create Dictionary    name=Sala 2   
    ...    capacity=200    type=3D
    Set Test Variable    ${updated_theater}

Criar Cinema
    [Arguments]    ${theater_data}    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}
    ${response}=    POST On Session    cinemaApp    /theaters    json=${theater_data}    headers=${headers}
    Log    ${response.text}
    RETURN    ${response}

Criar Cinema E Obter ID
    [Arguments]    ${theater_data}    ${token}
    ${response}=    Criar Cinema    ${theater_data}    ${token}
    ${theater_id}=    Get From Dictionary    ${response.json()["data"]}    _id
    Set Test Variable    ${theater_id}
    RETURN    ${response}    ${theater_id}

Buscar Cinema por ID
    [Arguments]    ${theater_id}
    ${response}=    GET On Session    cinemaApp    /theaters/${theater_id}
    RETURN    ${response}

Buscar Todos Cinemas
    ${response}=    GET On Session    cinemaApp    /theaters
    RETURN    ${response}

Atualizar Cinema
    [Arguments]    ${theater_id}    ${theater_data}    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}
    ${response}=    PUT On Session    cinemaApp    /theaters/${theater_id}    json=${theater_data}    headers=${headers}
    RETURN    ${response}

Deletar Cinema
    [Arguments]    ${theater_id}    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    DELETE On Session    cinemaApp    /theaters/${theater_id}    headers=${headers}
    RETURN    ${response}

Validar Cinema Criado
    [Arguments]    ${response}
    Status Should Be    201    ${response}

Validar Cinema Encontrado
    [Arguments]    ${response}
    Status Should Be    200    ${response}

Validar Cinema Deletado
    [Arguments]    ${response}
    Status Should Be    200    ${response}