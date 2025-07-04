*** Settings ***
Documentation    Keywords para funcionalidades de Reservas
Library    Browser
Library    RequestsLibrary
Library    Collections

Resource    ../support/variables/cinema_variable_web.robot

*** Keywords ***

Criar dados de reserva válida
    [Documentation]    Cria dados válidos para cadastro de reserva
    ${dados_reserva}=    Create Dictionary
    ...    sessao=Filme Teste - 20:00
    ...    quantidade=2
    ...    tipoIngresso=Inteira
    RETURN    ${dados_reserva}

Criar dados de atualização de reserva
    [Arguments]    ${quantidade}=3    ${tipoIngresso}=Meia
    [Documentation]    Cria dados para atualização de reserva
    ${novos_dados}=    Create Dictionary
    ...    quantidade=${quantidade}
    ...    tipoIngresso=${tipoIngresso}
    RETURN    ${novos_dados}

Acessar página de reservas
    [Documentation]    Acessa a página de reservas do usuário
    Wait For Elements State    css=a[href="/reservations"]    visible    10
    Click    css=a[href="/reservations"]
    Wait For Elements State    css=.reservations-container    visible    10
     
Fazer nova reserva
    [Arguments]    ${reserva_data}
    [Documentation]    Cria uma nova reserva via interface

    # Clicar no primeiro assento disponível da Fileira A
    Wait For Elements State    css=button.seat.available[title="Fileira A, Assento 1 - Status: available"]    visible    5
    Click                      css=button.seat.available[title="Fileira A, Assento 1 - Status: available"]


    # Clicar em continuar para pagamento
    Wait For Elements State    css=button.checkout-button    visible    5
    Click    css=button.checkout-button

    # Selecionar método de pagamento Cartão de Crédito
    Wait For Elements State    css=div.payment-method >> text=Cartão de Crédito    visible    5
    Click    css=div.payment-method >> text=Cartão de Crédito

    # Finalizar compra
    Wait For Elements State    css=button.btn-checkout >> text=Finalizar Compra    visible    5
    Click    css=button.btn-checkout >> text=Finalizar Compra
 


A reserva deve ser criada com sucesso
    [Arguments]    ${sessao_reserva}
    [Documentation]    Verifica se a reserva foi criada com sucesso

    # Aguardar feedback de sucesso
    Wait For Elements State    css=.confirmation-header h1    visible    5
    ${mensagem}=    Get Text    css=.confirmation-header h1
    Should Be Equal    ${mensagem}    Reserva Confirmada!

    # Clicar no botão "Visualizar Minhas Reservas" dentro da confirmação
    Wait For Elements State    css=a.btn.btn-primary[href="/reservations"]    visible    5
    Click    css=a.btn.btn-primary[href="/reservations"]
 
    Sleep    2s
    # Aguarda a lista de reservas carregar
    Wait For Elements State    css=.reservations-container    visible    10


    

Listar reservas
    [Documentation]    Lista as reservas disponíveis
    Wait For Elements State    css=.reservations-header h1    visible    5
    ${titulo}=    Get Text    css=.reservations-header h1
    Should Be Equal    ${titulo}    Minhas Reservas


A reserva deve estar na lista
    [Arguments]    ${sessao_reserva}
    [Documentation]    Verifica se a reserva está na lista
    
    Wait For Elements State    css=.reservations-header h1    visible    10
    ${titulo}=    Get Text    css=.reservations-header h1
    Should Be Equal    ${titulo}    Minhas Reservas
    
    # Verificar se a reserva está na página
    ${page_content}=    Get Text    body
    Should Contain    ${page_content}    ${sessao_reserva}




 