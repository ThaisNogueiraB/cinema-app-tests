*** Settings ***
Documentation    Testes de Sessões do Cinema App
Resource         ../support/base.robot
Library    OperatingSystem

Test Setup       Setup Test Environment
Test Teardown    Teardown Test Environment
Suite Setup      Silenciar InsecureRequestWarning

*** Test Cases ***
CTW-025: Listagem pública de sessões via interface
    [tags]    lista-sessao
    
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
    Listar sessões
    A sessão deve estar na lista   ${data}[title]

CTW-026: Visualizar detalhes de sessão via interface
    [tags]    detalhes-sessao
    
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
    Verificar detalhes da sessão    ${data}[title]

CTW-055: Resetar assentos da sessão via interface (admin)
    [tags]    resetar-assentos-admin
    
    # Garante que o usuário admin existe
    Criar usuário admin - API

    # Login com dados de administrador
    ${data}=    Criar login admin válido
    
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
    
    Resetar assentos da sessão
    Verificar mensagem de sucesso do reset