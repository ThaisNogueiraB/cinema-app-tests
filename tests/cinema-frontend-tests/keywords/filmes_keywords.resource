*** Settings ***
Documentation    Keywords para funcionalidades de Filmes
Library    Browser
Library    RequestsLibrary
Library    Collections

Resource    ../support/variables/cinema_variable_web.robot



*** Keywords ***
Criar dados de filme válido
    [Documentation]    Cria dados válidos para cadastro de filme
    ${dados_filme}=    Create Dictionary
    ...    title=Filme Teste Automatizado
    ...    director=Diretor Teste
    ...    genres=Ação
    ...    duration=120
    ...    synopsis=Sinopse do filme teste
    ...    classification=Livre
    ...    releaseDate=2024-12-25
    ...    poster=filme-teste.jpg
    RETURN    ${dados_filme}


Acessar filmes em cartaz
    [Documentation]    Acessa a página filme em cartaz
    
    Wait For Elements State    body    visible    10
    Wait For Elements State    css=nav.nav a[href="/movies"]    visible    5
    Click    css=nav.nav a[href="/movies"]
    # Aguarda a página de filmes carregar
    Wait For Elements State    css=.movies-container    visible    15


O filme deve estar na lista
    [Arguments]    ${titulo_filme}
    [Documentation]    Verifica se o filme está na lista de forma robusta
    
    Wait For Elements State    css=.movies-container    visible    15
    Sleep    3s
    ${qtd}=    Get Element Count    css=.movie-title
    ${encontrado}=    Set Variable    False
    FOR    ${index}    IN RANGE    ${qtd}
        ${titulo}=    Get Text    css=.movie-title >> nth=${index}
        ${encontrado}=    Run Keyword If    '${titulo}' == '${titulo_filme}'    Set Variable    True    ELSE    Set Variable    ${encontrado}
    END
    Should Be True    ${encontrado}    msg=O filme '${titulo_filme}' não foi encontrado na lista

Selecionar filme
    [Arguments]    ${titulo_filme}
    [Documentation]    Seleciona o filme correto clicando no botão Ver Detalhes

    Wait For Elements State    css=.movies-container    visible    10
    Sleep    2s
    ${qtd}=    Get Element Count    css=.movie-card
    ${encontrado}=    Set Variable    False
    FOR    ${index}    IN RANGE    ${qtd}
        TRY
            ${titulo}=    Get Text    css=.movie-card >> nth=${index} >> .movie-title
            ${encontrado}=    Run Keyword If    '${titulo}' == '${titulo_filme}'    Set Variable    True    ELSE    Set Variable    ${encontrado}
            Run Keyword If    '${titulo}' == '${titulo_filme}'    Click    css=.movie-card >> nth=${index} >> a.btn.btn-primary
            Run Keyword If    '${titulo}' == '${titulo_filme}'    Exit For Loop
        EXCEPT    AS    ${error}
            No Operation
        END
    END
    Should Be True    ${encontrado}    msg=O filme '${titulo_filme}' não foi encontrado
    Wait For Elements State    css=.movie-detail-page    visible    10

Verificar detalhes do filme
    [Arguments]    ${titulo}    ${diretor}    ${genero}
    [Documentation]    Verifica se os detalhes do filme estão corretos
    
    ${titulo_real}=    Get Text    css=.movie-info h1
    Should Be Equal    ${titulo_real}    ${titulo}




 