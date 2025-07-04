*** Settings ***
Documentation    Testes de Filmes do Cinema App
Resource         ../support/base.robot

Test Setup       Setup Test Environment
Test Teardown    Teardown Test Environment
Suite Setup      Silenciar InsecureRequestWarning

*** Test Cases ***
CTW-018: Listagem de filmes via interface (público)

    [tags]    listagem-filmes
    
    # Garante que o usuário existe
    Criar usuário de teste - API    Usuário Teste

    # Login com os mesmos dados do usuário criado
    ${data}=    Criar login válido
    
    Acessar tela de login
    Enviar formulário de login    ${data}
    O usuário deve estar logado   ${data}[nome]

    # Garante que há filmes disponíveis
    Criar filme - API    filme-teste
    ${data}=    Criar dados de filme válido
    Acessar filmes em cartaz
    O filme deve estar na lista    Filme Teste Automatizado

CTW-019: Visualizar detalhes de filme via interface
    [tags]    visualizar-filmes
    
    # Garante que o usuário existe
    Criar usuário de teste - API    Usuário Teste

    # Login com os mesmos dados do usuário criado
    ${data}=    Criar login válido
    
    Acessar tela de login
    Enviar formulário de login    ${data}
    O usuário deve estar logado   ${data}[nome]

    # Garante que há filmes disponíveis
    Criar filme - API    filme-teste
    ${data}=    Criar dados de filme válido
    
    Acessar filmes em cartaz
    Selecionar filme    ${data}[title]
    Verificar detalhes do filme    ${data}[title]    ${data}[director]    ${data}[genres]

 