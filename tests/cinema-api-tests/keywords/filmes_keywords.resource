*** Settings ***
Documentation  Keywords para operações de filmes da API Cinema App
Library    RequestsLibrary
Library    Collections

*** Keywords ***

Criar dados validos para filme
    ${movie_data}=    Create Dictionary    title=Como treinar o seu dragao    
    ...    synopsis=esta é a sinopse do novo filme    
    ...    director=nome do diretor    genres=["Animation"]    
    ...    duration=150    classification=livre    
    ...    poster=poster    
    ...    releaseDate=2025-06-26
    Set Test Variable    ${movie_data}

Criar dados para atualização de filme
    ${updated_movie}=    Create Dictionary    title=Filme Atualizado    synopsis=sinopse atualizada    director=diretor    genres=["Drama"]    duration=130    classification=livre    poster=poster    releaseDate=2025-06-26
    Set Test Variable    ${updated_movie}

Criar Filme
    [Arguments]    ${movie_data}    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}
    ${response}=    POST On Session    cinemaApp    /movies    json=${movie_data}    headers=${headers}
    RETURN    ${response}

Criar Filme E Obter ID
    [Arguments]    ${movie_data}    ${token}
    ${response}=    Criar Filme    ${movie_data}    ${token}
    ${movie_id}=    Get From Dictionary    ${response.json()["data"]}    _id
    Set Test Variable    ${movie_id}
    RETURN    ${response}    ${movie_id}

Buscar Filme por ID
    [Arguments]    ${movie_id}
    ${response}=    GET On Session    cinemaApp    /movies/${movie_id}
    RETURN    ${response}

Buscar Todos Filmes
    ${response}=    GET On Session    cinemaApp    /movies
    RETURN    ${response}

Atualizar Filme
    [Arguments]    ${movie_id}    ${movie_data}    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}
    ${response}=    PUT On Session    cinemaApp    /movies/${movie_id}    json=${movie_data}    headers=${headers}
    RETURN    ${response}

Deletar Filme
    [Arguments]    ${movie_id}    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    DELETE On Session    cinemaApp    /movies/${movie_id}    headers=${headers}
    RETURN    ${response}

Validar Filme Criado
    [Arguments]    ${response}
    Status Should Be    201    ${response}

Validar Filme Encontrado
    [Arguments]    ${response}
    Status Should Be    200    ${response}

Validar Filme Deletado
    [Arguments]    ${response}
    Status Should Be    200    ${response} 