*** Settings ***
Documentation  Keywords para operações de reservas da API Cinema App
Library    DateTime
Library    Collections
Library    RequestsLibrary

Resource    ./filmes_keywords.resource
Resource    ./cinemas_keywords.resource
Resource    ./sessoes_keywords.resource

*** Keywords ***

Criar dados da reserva com ID de sessao existente
    [Arguments]    ${session_id}
    ${seat}=    Create Dictionary    row=A    number=${10}    type=full
    ${seats}=    Create List    ${seat}
    ${reservation_data}=    Create Dictionary    session=${session_id}    seats=${seats}    paymentMethod=credit_card
    Set Test Variable    ${reservation_data}

Criar dados para atualização de reserva
    ${updated_reservation}=    Create Dictionary    status=cancelled    paymentStatus=cancelled
    Set Test Variable    ${updated_reservation}

Criar Reserva
    [Arguments]    ${reservation_data}    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}
    ${response}=    POST On Session    cinemaApp    /reservations    json=${reservation_data}    headers=${headers}
    RETURN    ${response}

Criar Reserva E Obter ID
    [Arguments]    ${reservation_data}    ${token}
    ${response}=    Criar Reserva    ${reservation_data}    ${token}
    ${reservation_id}=    Get From Dictionary    ${response.json()["data"]}    _id
    Set Test Variable    ${reservation_id}
    RETURN    ${response}    ${reservation_id}

Buscar Reserva por ID
    [Arguments]    ${reservation_id}    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    cinemaApp    /reservations/${reservation_id}    headers=${headers}
    RETURN    ${response}

Buscar Todas Reservas
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    cinemaApp    /reservations    headers=${headers}
    RETURN    ${response}

Buscar Reservas do Usuario
    [Arguments]    ${user_id}    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    cinemaApp    /reservations?user_id=${user_id}    headers=${headers}
    RETURN    ${response}

Atualizar Reserva
    [Arguments]    ${reservation_id}    ${reservation_data}    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}
    ${response}=    PUT On Session    cinemaApp    /reservations/${reservation_id}    json=${reservation_data}    headers=${headers}
    RETURN    ${response}

Cancelar Reserva
    [Arguments]    ${reservation_id}    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    DELETE On Session    cinemaApp    /reservations/${reservation_id}    headers=${headers}
    RETURN    ${response}

Validar Reserva Criada
    [Arguments]    ${response}
    Status Should Be    201    ${response}

Validar Reserva Encontrada
    [Arguments]    ${response}
    Status Should Be    200    ${response}

Validar Reserva Cancelada
    [Arguments]    ${response}
    Status Should Be    200    ${response} 