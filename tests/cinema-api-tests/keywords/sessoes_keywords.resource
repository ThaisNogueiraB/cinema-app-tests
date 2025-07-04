*** Settings ***
Documentation  Keywords para operações de sessões da API Cinema App
Library    DateTime
Library    Collections
Library    RequestsLibrary

Resource    ./filmes_keywords.resource
Resource    ./cinemas_keywords.resource

*** Keywords ***

Criar dados da sessao com IDs existentes
    [Arguments]    ${movie_id}    ${theater_id}
    ${session_data}=    Create Dictionary    movie=${movie_id}    theater=${theater_id}    datetime=2025-06-27T16:59:40.815Z    fullPrice=15    halfPrice=7.5
    Set Test Variable    ${session_data}

Criar dados para atualização de sessao
    ${updated_session}=    Create Dictionary    movie=${movie_id}    theater=${theater_id}    datetime=2025-06-28T20:18:51.260Z    fullPrice=20    halfPrice=10
    Set Test Variable    ${updated_session}

Criar Sessao API
    [Arguments]    ${session_data}    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}
    ${response}=    POST On Session    cinemaApp    /sessions    json=${session_data}    headers=${headers}
    RETURN    ${response}

Criar Sessao E Obter ID
    [Arguments]    ${session_data}    ${token}
    ${response}=    Criar Sessao API    ${session_data}    ${token}
    ${session_id}=    Get From Dictionary    ${response.json()["data"]}    _id
    Set Test Variable    ${session_id}
    RETURN    ${response}    ${session_id}

Buscar Sessao por ID
    [Arguments]    ${session_id}
    ${response}=    GET On Session    cinemaApp    /sessions/${session_id}
    RETURN    ${response}

Buscar Todas Sessoes
    ${response}=    GET On Session    cinemaApp    /sessions
    RETURN    ${response}

Atualizar Sessao
    [Arguments]    ${session_id}    ${session_data}    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}
    ${response}=    PUT On Session    cinemaApp    /sessions/${session_id}    json=${session_data}    headers=${headers}
    RETURN    ${response}

Deletar Sessao
    [Arguments]    ${session_id}    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    DELETE On Session    cinemaApp    /sessions/${session_id}    headers=${headers}
    RETURN    ${response}

Validar Sessao Criada
    [Arguments]    ${response}
    Status Should Be    201    ${response}

Validar Sessao Encontrada
    [Arguments]    ${response}
    Status Should Be    200    ${response}

Validar Sessao Deletada
    [Arguments]    ${response}
    Status Should Be    200    ${response} 