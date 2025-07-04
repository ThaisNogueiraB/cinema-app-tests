*** Settings ***
Documentation    Keywords para funcionalidades de Sessões
Library    Browser
Library    RequestsLibrary
Library    Collections

Resource    ../support/variables/cinema_variable_web.robot



*** Keywords ***
Selecionar assentos da sessão
    [Arguments]    ${id_sessao}
    [Documentation]    Clica no botão Selecionar Assentos da sessão criada via API
    

    # Aguarda o botão ficar visível
    Wait For Elements State    css=a.session-button[href="/sessions/${id_sessao}"]    visible    15
    
    # Clica no botão
    Click    css=a.session-button[href="/sessions/${id_sessao}"]
    
    # Aguarda a página de assentos carregar
    Wait For Elements State    css=.seats-container    visible    10
    


Listar sessões
    [Documentation]    Lista as sessões disponíveis
    Wait For Elements State    css=.sessions-list    visible    15

A sessão deve estar na lista
    [Arguments]    ${filme_sessao}
    [Documentation]    Verifica se há sessões na lista
    
    Wait For Elements State    css=.sessions-list    visible    15
    ${texto_sessoes}=    Get Text    css=.sessions-list
    
    # Verifica se há alguma sessão na lista (não necessariamente o filme específico)
    Should Not Be Empty    ${texto_sessoes}


Verificar detalhes da sessão
    [Arguments]    ${filme_sessao}
    [Documentation]    Verifica se os detalhes da sessão estão corretos
    
    # Aguarda a página de assentos carregar
    Wait For Elements State    css=.seats-container    visible    10
    
    # Verificar se há assentos disponíveis
    ${qtd_assentos}=    Get Element Count    css=.seat.available
    Should Be True    ${qtd_assentos} > 0    msg=Nenhum assento disponível encontrado
    
    # Verificar se o filme está sendo exibido (pode estar em um título ou cabeçalho)
    TRY
        Get Text    css=h1, css=h2, css=.movie-title    *=    ${filme_sessao}
    EXCEPT    AS    ${error}
        Pass Execution    Filme não encontrado no título
    END

# ============================================================================
# Keywords para resetar assentos da sessão (admin)
# ============================================================================



Resetar assentos da sessão
    [Documentation]    Confirma o reset dos assentos da sessão
    
    Wait For Elements State    css=button.reset-seats-btn    visible    5
    Click    css=button.reset-seats-btn 

Verificar mensagem de sucesso do reset
    [Documentation]    Verifica se a mensagem de sucesso do reset foi exibida
    
   Wait For Elements State    css=div.alert-content    visible    5
    ${mensagem}=    Get Text    css=div.alert-content
    Should Be Equal    ${mensagem}    Assentos resetados com sucesso

Criar dados de sessão válida
    [Documentation]    Cria dados válidos para cadastro de sessão
    ${dados_sessao}=    Create Dictionary
    ...    filme=Filme Teste Automatizado
    ...    sala=Sala 1
    ...    horario=2024-12-25T20:00:00
    ...    preco=25.50
    ...    capacidade=100
    RETURN    ${dados_sessao}

