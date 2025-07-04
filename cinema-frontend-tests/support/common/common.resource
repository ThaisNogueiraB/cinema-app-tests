*** Settings ***
Documentation    Keywords específicas do Cinema App

Resource         ../../keywords/login_keywords.resource
Resource         ../../keywords/filmes_keywords.resource
Resource         ../../keywords/sessao_keywords.resource
Resource         ../../keywords/reserva_keywords.resource
Resource         ../variables/cinema_variable_web.robot

Library    JSONLibrary
Library    RequestsLibrary
Library    Collections
Library    String

*** Keywords ***
# Keywords específicas do Cinema App
Logar como administrador
    ${data}    Load Json From File
    ...    ${FIXTURES_PATH}
    ...    encoding=utf-8

    Enviar formulário de login   ${data}[admin]
    O usuário deve estar logado   ${data}[admin][nome]

Logar como usuário
    ${data}    Load Json From File
    ...    ${FIXTURES_PATH}
    ...    encoding=utf-8

    Enviar formulário de login    ${data}[usuario]
    O usuário deve estar logado   ${data}[usuario][nome]

Criar usuário - API
    [Arguments]    ${tipo_usuario}
    # Garante que a sessão está criada
    Create Session    alias=cinemaApp    url=${API_URL}
    ${data}=    Load Json From File    ${FIXTURES_PATH}    encoding=utf-8
    ${body}=    Set Variable    ${data}[${tipo_usuario}]
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${resposta}=    POST On Session
    ...    cinemaApp
    ...    url=/auth/register
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=any
    # Log removido para limpeza do console
    RETURN    ${resposta.json()}

Login usuário - API
    [Arguments]    ${tipo_usuario}

    Criar usuário - API    ${tipo_usuario}

    ${data}=    Load Json From File    ${FIXTURES_PATH}    encoding=utf-8
    ${body}=    Set Variable    ${data}[${tipo_usuario}-login]

    ${resposta}  POST On Session
        ...          alias=cinemaApp
        ...          url=/auth/login
        ...          json=${body}
        ...          expected_status=${STATUS_REQ}

    Set Test Variable    ${RESPOSTA}    ${resposta.json()}

    ${token}=   Get From Dictionary    ${RESPOSTA}[data]    token
    ${token_parte}    Split String    ${token}    ${SPACE}
    Set Test Variable    ${TOKEN}    ${token_parte}[0]

    # Log removido para limpeza do console

Gerar token usuario - API
    [Arguments]    ${user}

    ${body}=    Create Dictionary
    ...         email=${user}[email]
    ...         password=${user}[password]

    ${headers}=    Create Dictionary    Content-Type=application/json

    ${response}=    POST On Session
    ...             cinemaApp
    ...             url=/auth/login
    ...             json=${body}
    ...             headers=${headers}
    ...             expected_status=${STATUS_REQ}

    ${json}=    Set Variable    ${response.json()}
    ${token}=   Get From Dictionary   ${json}[data]    token

    Set Suite Variable    ${token_login}    ${token}
    RETURN    ${token}

Criar filme - API
    [Arguments]    ${tipo_filme}
    
    # Garante que a sessão está criada
    Create Session    alias=cinemaApp    url=${API_URL}
    
    # Login como admin para obter token
    Login Admin - API

    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json

    ${data}    Load Json From File
    ...    ${FIXTURES_PATH}
    ...    encoding=utf-8

    ${body}    Set Variable    ${data}[${tipo_filme}]

    # Primeiro, tentar buscar o filme pelo título
    ${resposta_busca}=    GET On Session
        ...    alias=cinemaApp
        ...    url=/movies
        ...    headers=${headers}
        ...    expected_status=any
    
    ${filmes}=    Set Variable    ${resposta_busca.json()}[data]
    ${filme_encontrado}=    Set Variable    False
    ${filme_id}=    Set Variable    None
    
    FOR    ${filme}    IN    @{filmes}
        ${titulo}=    Get From Dictionary    ${filme}    title
        IF    '${titulo}' == '${body}[title]'
            ${filme_id}=    Get From Dictionary    ${filme}    _id
            ${filme_encontrado}=    Set Variable    True
            BREAK
        END
    END
    
    IF    ${filme_encontrado}
        Set Test Variable    ${FILME_ID}    ${filme_id}
    ELSE

        TRY
            ${resposta}  POST On Session
                ...          alias=cinemaApp
                ...          url=/movies
                ...          json=${body}
                ...          expected_status=any
                ...          headers=${headers}
            
            Set Test Variable    ${RESPOSTA}    ${resposta.json()}
            
            # Verifica se a criação foi bem-sucedida
            ${success}=    Get From Dictionary    ${RESPOSTA}    success
        EXCEPT    AS    ${error}
            Set Test Variable    ${RESPOSTA}    ${error}
        END
        
        # Retorna o ID do filme criado para uso posterior
        TRY
            ${filme_id}=    Get From Dictionary    ${RESPOSTA}[data]    _id
            Set Test Variable    ${FILME_ID}    ${filme_id}
        EXCEPT    AS    ${error}
            # Se não houver chave 'data', tenta acessar diretamente
            TRY
                ${filme_id}=    Get From Dictionary    ${RESPOSTA}    _id
                Set Test Variable    ${FILME_ID}    ${filme_id}
            EXCEPT    AS    ${error2}
                Set Test Variable    ${FILME_ID}    None
            END
        END
    END

Login Admin - API
    [Arguments]    ${email}=admin@example.com    ${senha}=admin123
    
    # Garante que a sessão está criada
    Create Session    alias=cinemaApp    url=${API_URL}
    
    # Tenta criar admin primeiro (pode falhar se já existir)
    TRY
        ${admin_data}=    Create Dictionary
        ...    name=Admin Teste
        ...    email=${email}
        ...    password=${senha}
        
        ${headers}=    Create Dictionary    Content-Type=application/json
        
        ${create_response}=    POST On Session
        ...    cinemaApp
        ...    url=/setup/admin
        ...    json=${admin_data}
        ...    headers=${headers}
        ...    expected_status=any
        
        # Log removido para limpeza do console
    EXCEPT    AS    ${error}
        Pass Execution    Admin já existe
    END
    
    # Faz login com o admin
    ${login_data}=    Create Dictionary
    ...    email=${email}
    ...    password=${senha}
    
    ${headers}=    Create Dictionary    Content-Type=application/json
    
    ${login_response}=    POST On Session
    ...    cinemaApp
    ...    url=/auth/login
    ...    json=${login_data}
    ...    headers=${headers}
    ...    expected_status=any
    
    ${login_json}=    Set Variable    ${login_response.json()}
    
    # Extrai o token
    ${token}=    Get From Dictionary    ${login_json}[data]    token
    Set Test Variable    ${TOKEN}    ${token}

Criar theater - API
    [Arguments]    ${nome}=Sala 1    ${capacidade}=100    ${tipo}=standard
    [Documentation]    Cria um theater via API ou busca se já existe
    
    # Garante que a sessão está criada
    Create Session    alias=cinemaApp    url=${API_URL}
    
    # Login como admin para obter token
    Login Admin - API

    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json

    # Primeiro, tentar buscar o theater pelo nome
    ${resposta_busca}=    GET On Session
        ...    alias=cinemaApp
        ...    url=/theaters
        ...    headers=${headers}
        ...    expected_status=any
    
    ${theaters}=    Set Variable    ${resposta_busca.json()}[data]
    ${theater_encontrado}=    Set Variable    False
    ${theater_id}=    Set Variable    None
    
    FOR    ${theater}    IN    @{theaters}
        ${theater_nome}=    Get From Dictionary    ${theater}    name
        IF    '${theater_nome}' == '${nome}'
            ${theater_id}=    Get From Dictionary    ${theater}    _id
            ${theater_encontrado}=    Set Variable    True
            BREAK
        END
    END
    
    IF    ${theater_encontrado}
        Set Test Variable    ${THEATER_ID}    ${theater_id}
    ELSE
        ${body}=    Create Dictionary
        ...    name=${nome}
        ...    capacity=${capacidade}
        ...    type=${tipo}

        TRY
            ${resposta}=    POST On Session
                ...    alias=cinemaApp
                ...    url=/theaters
                ...    json=${body}
                ...    headers=${headers}
                ...    expected_status=any
                
            Set Test Variable    ${RESPOSTA}    ${resposta.json()}
            
            # Verifica se a criação foi bem-sucedida
            ${success}=    Get From Dictionary    ${RESPOSTA}    success
        EXCEPT    AS    ${error}
            Set Test Variable    ${RESPOSTA}    ${error}
        END
        
        # Retorna o ID do theater criado para uso posterior
        TRY
            ${theater_id}=    Get From Dictionary    ${RESPOSTA}[data]    _id
            Set Test Variable    ${THEATER_ID}    ${theater_id}
        EXCEPT    AS    ${error}
            # Se não houver chave 'data', tenta acessar diretamente
            TRY
                ${theater_id}=    Get From Dictionary    ${RESPOSTA}    _id
                Set Test Variable    ${THEATER_ID}    ${theater_id}
            EXCEPT    AS    ${error2}
                Set Test Variable    ${THEATER_ID}    None
            END
        END
    END

Criar sessao - API
    [Arguments]    ${datetime}=2024-12-25T20:00:00Z    ${fullPrice}=25.50    ${halfPrice}=12.75
    [Documentation]    Cria uma sessão via API usando o FILME_ID e THEATER_ID criados anteriormente
    
    # Garante que a sessão está criada
    Create Session    alias=cinemaApp    url=${API_URL}
    
    # Login como admin para obter token
    Login Admin - API

    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json

    ${body}=    Create Dictionary
    ...    movie=${FILME_ID}
    ...    theater=${THEATER_ID}
    ...    datetime=${datetime}
    ...    fullPrice=${fullPrice}
    ...    halfPrice=${halfPrice}

    TRY
        ${resposta}=    POST On Session
            ...    alias=cinemaApp
            ...    url=/sessions
            ...    json=${body}
            ...    headers=${headers}
            ...    expected_status=any
        
        Set Test Variable    ${RESPOSTA}    ${resposta.json()}
        
        # Verifica se a criação foi bem-sucedida baseado no conteúdo da resposta
        ${success}=    Get From Dictionary    ${RESPOSTA}    success
    EXCEPT    AS    ${error}
        Set Test Variable    ${RESPOSTA}    ${error}
    END
    
    # Retorna o ID da sessão criada para uso posterior
    TRY
        ${sessao_id}=    Get From Dictionary    ${RESPOSTA}[data]    _id
        Set Test Variable    ${SESSAO_ID}    ${sessao_id}
    EXCEPT    AS    ${error}
        # Se não houver chave 'data', tenta acessar diretamente
        TRY
            ${sessao_id}=    Get From Dictionary    ${RESPOSTA}    _id
            Set Test Variable    ${SESSAO_ID}    ${sessao_id}
        EXCEPT    AS    ${error2}
            Set Test Variable    ${SESSAO_ID}    None
        END
    END

Criar reserva - API
    [Arguments]    ${quantidade}=2    ${tipoIngresso}=Inteira
    [Documentation]    Cria uma reserva via API usando o SESSAO_ID criado anteriormente
    
    # Garante que a sessão está criada
    Create Session    alias=cinemaApp    url=${API_URL}
    
    # Login como admin para obter token
    Login Admin - API
    
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json
    
    ${body}=    Create Dictionary
    ...    sessaoId=${SESSAO_ID}
    ...    quantidade=${quantidade}
    ...    tipoIngresso=${tipoIngresso}
    
    ${resposta}=    POST On Session
    ...    alias=cinemaApp
    ...    url=/reservations
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=any
    
    Set Test Variable    ${RESPOSTA}    ${resposta.json()}
    TRY
        ${reserva_id}=    Get From Dictionary    ${RESPOSTA}[data]    _id
        Set Test Variable    ${RESERVA_ID}    ${reserva_id}
    EXCEPT    AS    ${error}
        Set Test Variable    ${RESERVA_ID}    None
    END

Excluir filme - API
    [Arguments]    ${nome_filme}

    Login Admin - API

    ${resposta}    GET On Session
        ...          alias=cinemaApp
        ...          url=/movies
        ...          expected_status=${STATUS_REQ}

    Set Test Variable    ${RESPOSTA}    ${resposta.json()}

    TRY
        ${filmes}=    Get From Dictionary    ${RESPOSTA}    data
    EXCEPT    AS    ${error}
        # Se não houver chave 'data', tenta acessar diretamente
        TRY
            ${filmes}=    Get From Dictionary    ${RESPOSTA}    movies
        EXCEPT    AS    ${error2}
            # Se não houver 'movies', tenta usar a resposta diretamente
            ${filmes}=    Set Variable    ${RESPOSTA}
        END
    END

    ${id}=    Set Variable    None
    FOR    ${filme}    IN    @{filmes}
        TRY
            ${nome}=    Get From Dictionary    ${filme}    title
        EXCEPT    AS    ${error3}
            ${nome}=    Get From Dictionary    ${filme}    titulo
        END
        IF    '''${nome}''' == '''${nome_filme}'''
            ${id}=    Get From Dictionary    ${filme}    _id
            BREAK
        END
    END

    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}

    DELETE On Session
    ...          alias=cinemaApp
    ...          url=/movies/${id}
    ...          headers=${headers}
    ...          expected_status=${STATUS_REQ}

Excluir sessao - API
    [Arguments]    ${nome_sessao}

    
    Login usuário - API    admin

    ${resposta}    GET On Session
        ...          alias=cinemaApp
        ...          url=/sessoes
        ...          expected_status=${STATUS_REQ}

    Set Test Variable    ${RESPOSTA}    ${resposta.json()}

    TRY
        ${sessoes}=    Get From Dictionary    ${RESPOSTA}    data
    EXCEPT    AS    ${error}
        # Se não houver chave 'data', tenta acessar diretamente
        TRY
            ${sessoes}=    Get From Dictionary    ${RESPOSTA}    sessions
        EXCEPT    AS    ${error2}
            # Se não houver 'sessions', tenta usar a resposta diretamente
            ${sessoes}=    Set Variable    ${RESPOSTA}
        END
    END

    ${id}=    Set Variable    None
    FOR    ${sessao}    IN    @{sessoes}
        TRY
            ${nome}=    Get From Dictionary    ${sessao}    name
        EXCEPT    AS    ${error3}
            ${nome}=    Get From Dictionary    ${sessao}    nome
        END
        IF    '''${nome}''' == '''${nome_sessao}'''
            ${id}=    Get From Dictionary    ${sessao}    _id
            BREAK
        END
    END

    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}

    DELETE On Session
    ...          alias=cinemaApp
    ...          url=/sessoes/${id}
    ...          headers=${headers}
    ...          expected_status=${STATUS_REQ}

Criar usuário admin - API
    [Arguments]    ${nome}=Admin Teste    ${email}=admin@example.com    ${senha}=admin123
    [Documentation]    Cria um usuário admin via API usando o endpoint de setup
    
    # Sempre cria a sessão (sobrescreve se já existir)
    Create Session    alias=cinemaApp    url=${API_URL}
    
    # Dados do usuário admin
    ${body}=    Create Dictionary
    ...    name=${nome}
    ...    email=${email}
    ...    password=${senha}
    
    ${headers}=    Create Dictionary    Content-Type=application/json
    
    # Usar o endpoint de setup para criar admin (só funciona em desenvolvimento)
    ${response}=    POST On Session
    ...    cinemaApp
    ...    url=/setup/admin
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=any
    
    ${json_response}=    Set Variable    ${response.json()}
    RETURN    ${json_response}

Criar usuário de teste - API
    [Arguments]    ${nome}=Usuário Teste    ${email}=usuario.teste@email.com    ${senha}=senha123
    [Documentation]    Cria um usuário de teste via API usando o endpoint de registro público

    # Sempre cria a sessão (sobrescreve se já existir)
    Create Session    alias=cinemaApp    url=${API_URL}

    # Dados do usuário de teste
    ${body}=    Create Dictionary
    ...    name=${nome}
    ...    email=${email}
    ...    password=${senha}

    ${headers}=    Create Dictionary    Content-Type=application/json

    # Usar o endpoint público de registro
    ${response}=    POST On Session
    ...    cinemaApp
    ...    url=/auth/register
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=any

    ${json_response}=    Set Variable    ${response.json()}
    RETURN    ${json_response}

    
Excluir usuário - API
    [Arguments]    ${email_usuario}=${EMAIL_CADASTRO}
    [Documentation]    Exclui usuário específico via API autenticando como admin
    
    # Sempre cria a sessão (sobrescreve se já existir)
    Create Session    alias=cinemaApp    url=${API_URL}
    
    # Login como admin para obter token
    ${admin_email}=    Set Variable    ${EMAIL_ADMIN}
    ${admin_senha}=    Set Variable    ${SENHA_ADMIN}
    ${body}=    Create Dictionary    email=${admin_email}    password=${admin_senha}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${login_response}=    POST On Session    cinemaApp    /auth/login    json=${body}    headers=${headers}    expected_status=any
    ${login_json}=    Set Variable    ${login_response.json()}
    ${token}=    Get From Dictionary    ${login_json}[data]    token
    ${auth_header}=    Create Dictionary    Authorization=Bearer ${token}
    
    TRY
        # Buscar todos os usuários com autenticação
        ${response}=    GET On Session    cinemaApp    /users    headers=${auth_header}    expected_status=any
        ${json_response}=    Set Variable    ${response.json()}
        
        # A API retorna { success: true, data: [...], count: X, pagination: {...} }
        ${usuarios}=    Get From Dictionary    ${json_response}    data
        
        ${id}=    Set Variable    None
        FOR    ${usuario}    IN    @{usuarios}
            ${usuario_email}=    Get From Dictionary    ${usuario}    email
            IF    '${usuario_email}' == '${email_usuario}'
                ${id}=    Get From Dictionary    ${usuario}    _id
                BREAK
            END
        END
        
        # Excluir usuário se encontrado
        IF    $id != None
            DELETE On Session
            ...    alias=cinemaApp
            ...    url=/users/${id}
            ...    headers=${auth_header}
            ...    expected_status=any
        END
        
    EXCEPT    AS    ${error}
        # Silenciar erros de exclusão
        Log    Erro silenciado na exclusão: ${error}    console=False
    END



