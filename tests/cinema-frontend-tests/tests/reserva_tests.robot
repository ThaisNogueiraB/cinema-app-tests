*** Settings ***
Documentation    Testes de Reservas do Cinema App
Resource         ../support/base.robot
Library    OperatingSystem

Test Setup       Setup Test Environment
Test Teardown    Teardown Test Environment
Suite Setup      Silenciar InsecureRequestWarning

*** Test Cases ***
CTW-020: Listagem de reservas do usuário via interface
    [tags]    listagem-reservas
    
    # Garante que o usuário existe
    Criar usuário de teste - API    Usuário Teste

    # Login com os mesmos dados do usuário criado
    ${data}=    Criar login válido
    
    Acessar tela de login
    Enviar formulário de login    ${data}
    O usuário deve estar logado   ${data}[nome]

    # Garante que há filmes, theaters e sessões disponíveis
    Criar filme - API    filme-teste
    Criar theater - API
    Criar sessao - API
    
    # Obter dados do filme criado
    ${data}=    Criar dados de filme válido
    
    Acessar página de reservas
    Listar reservas
    

CTW-021: Realizar reserva de sessão com assento disponível via interface
    [tags]    criar-reserva
    
    # Garante que o usuário existe
    Criar usuário de teste - API    Usuário Teste

    # Login com os mesmos dados do usuário criado
    ${data}=    Criar login válido
    
    Acessar tela de login
    Enviar formulário de login    ${data}
    O usuário deve estar logado   ${data}[nome]

    # Garante que há filmes, theaters e sessões disponíveis
    Criar filme - API    filme-teste
    Criar theater - API
    Criar sessao - API
    
    # Obter dados do filme criado
    ${data}=    Criar dados de filme válido
    Acessar filmes em cartaz
    Selecionar filme    ${data}[title] 
    
    Selecionar assentos da sessão    ${SESSAO_ID}


    # Criar dados de reserva
    ${reserva_data}=    Criar dados de reserva válida
    
    Fazer nova reserva    ${reserva_data}
    A reserva deve ser criada com sucesso    ${data}[title]
    A reserva deve estar na lista    ${data}[title]



 