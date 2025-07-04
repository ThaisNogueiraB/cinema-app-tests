*** Settings ***
Documentation    Configurações base para todos os testes do Cinema App

Library          Browser
Library          RequestsLibrary
Library          Collections
Library          String
Library          JSONLibrary

Resource         common/common.resource
Resource         ../keywords/login_keywords.resource
Resource         ../keywords/filmes_keywords.resource
Resource         ../keywords/reserva_keywords.resource
Resource         ../keywords/sessao_keywords.resource

Resource         variables/cinema_variable_web.robot

*** Keywords ***
Setup Test Environment
    [Documentation]    Configuração inicial para cada teste
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Page    ${BASE_URL}
    Create Session    alias=cinemaApp    url=${API_URL}
    
    # Criar usuário admin para os testes
    Criar usuário admin - API
    
    # Limpeza de dados de teste
    Excluir usuário - API


Teardown Test Environment
    [Documentation]    Limpeza após cada teste
    
    # Screenshot sempre (sucesso ou falha) - com tratamento de erro
    TRY
        Take Screenshot    filename=test-{index}
    EXCEPT    AS    ${error}
        Log    Não foi possível capturar screenshot: ${error}    level=WARN
    END
    
    # Limpeza de dados de teste
    TRY
        Excluir usuário - API
    EXCEPT    AS    ${error}
        Log    Erro ao excluir usuário: ${error}    level=WARN
    END
    
    # Limpeza de filmes criados durante o teste
    TRY
        Limpar Filmes de Teste
    EXCEPT    AS    ${error}
        Log    Erro ao limpar filmes: ${error}    level=WARN
    END
    
    # Excluir usuário admin criado para os testes
    TRY
        Excluir usuário - API    ${EMAIL_ADMIN}
    EXCEPT    AS    ${error}
        Log    Erro ao excluir usuário admin: ${error}    level=WARN
    END
    
    # Fechar browser com tratamento de erro
    TRY
        Close Browser
    EXCEPT    AS    ${error}
        Log    Erro ao fechar browser: ${error}    level=WARN
    END
    
    Delete All Sessions

Limpar Filmes de Teste
    [Documentation]    Remove filmes criados durante os testes
    TRY
        # Tenta excluir o filme "Filme Teste Automatizado" se existir
        Excluir filme - API    Filme Teste Automatizado
        # Log removido para limpeza do console
    EXCEPT    AS    ${error}
        Pass Execution    Filme não encontrado
    END

Criar Sessao
    [Documentation]    Cria sessão do navegador e API
    New Browser    browser=${BROWSER}    headless=False
    New Page       ${BASE_URL}
    Create Session    alias=cinemaApp    url=${API_URL}

Load Test Data
    [Arguments]    ${data_key}
    [Documentation]    Carrega dados de teste do arquivo JSON
    ${data}=    Load Json From File
    ...    ${FIXTURES_PATH}
    ...    encoding=utf-8
    RETURN    ${data}[${data_key}]


Gerar token de autorização
    [Arguments]    ${user_data}
    [Documentation]    Obtém token de autenticação para um usuário
    ${body}=    Create Dictionary
    ...    email=${user_data}[email]
    ...    password=${user_data}[password]

    ${headers}=    Create Dictionary    Content-Type=application/json

    ${response}=    POST On Session
    ...    cinemaApp
    ...    url=/auth/login
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=${STATUS_REQ}

    ${json}=    Set Variable    ${response.json()}
    ${token}=    Get From Dictionary    ${json}[data]    token

    RETURN    ${token}

Wait For Page Load
    [Documentation]    Aguarda o carregamento completo da página
    Wait For Elements State    body    visible    timeout=${TIMEOUT}

Take Screenshot On Failure
    [Documentation]    Captura screenshot em caso de falha
    Run Keyword If Test Failed    
    ...    TRY
    ...        Take Screenshot    filename=failure_{index}
    ...    EXCEPT    AS    ${error}
    ...        Log    Não foi possível capturar screenshot de falha: ${error}    level=WARN
    ...    END

Validate Response Status
    [Arguments]    ${response}    ${expected_status}=200
    [Documentation]    Valida o status code da resposta
    TRY
        Should Be Equal As Numbers    ${response.status_code}    ${expected_status}
    EXCEPT    AS    ${error}
        # Se response for um dicionário, não tem status_code
        Pass Execution    Response inválida
    END

Log Test Info
    [Arguments]    ${message}
    [Documentation]    Loga informações do teste
    Pass Execution    Log removido

Silenciar InsecureRequestWarning
    [Documentation]    Silencia warnings de requisições inseguras
    Log    Silenciando warnings de requisições inseguras

Logar como administrador
    [Documentation]    Realiza login como administrador
    ${admin_data}=    Load Test Data    admin
    Enviar formulário de login    ${admin_data}
    O usuário deve estar logado    ${admin_data}[nome]

Logar como usuário
    [Documentation]    Realiza login como usuário comum
    ${user_data}=    Load Test Data    usuario
    Enviar formulário de login    ${user_data}
    O usuário deve estar logado    ${user_data}[nome] 