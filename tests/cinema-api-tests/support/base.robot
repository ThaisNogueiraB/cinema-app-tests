*** Settings ***
Documentation  arquivos base para requisiçoes 
Library     Collections
Library    RequestsLibrary
Library    OperatingSystem

Resource    ../support/common/common.robot
Resource    ../support/variables/cinema_variables.robot
Resource    ../keywords/auth_keywords.resource
Resource    ../keywords/usuarios_keywords.resource
Resource    ../keywords/filmes_keywords.resource
Resource    ../keywords/cinemas_keywords.resource
Resource    ../keywords/sessoes_keywords.resource
Resource    ../keywords/reservas_keywords.resource

*** Keywords ***
Criar Sessao
    Create Session    cinemaApp    ${BASE_URL} 

Limpar Dados de Teste
    TRY
        Log    Iniciando limpeza de dados de teste...
        
        # Tentar obter token de admin, se falhar, criar admin temporário para limpeza
        TRY
            ${admin_token}=    Obter Token Admin
            Log    Token admin obtido: ${admin_token}
        EXCEPT    AS    ${error}
            Log    Erro ao obter token admin, criando admin temporário para limpeza: ${error}
            ${create_response}=    Criar dados validos para administrador
            Log    Admin temporário criado para limpeza
            ${admin_token}=    Obter Token Admin
            Log    Token admin obtido após criação temporária: ${admin_token}
        END
        
        ${headers}=    Create Dictionary    Authorization=Bearer ${admin_token}
        
        # Limpar reservas
        Log    Limpando reservas...
        TRY
            ${reservations_response}=    GET On Session    cinemaApp    /reservations    headers=${headers}
            Log    Response reservas: ${reservations_response.text}
            ${reservations}=    Get From Dictionary    ${reservations_response.json()["data"]}    reservations
            FOR    ${reservation}    IN    @{reservations}
                ${reservation_id}=    Get From Dictionary    ${reservation}    _id
                Log    Deletando reserva: ${reservation_id}
                DELETE On Session    cinemaApp    /reservations/${reservation_id}    headers=${headers}
            END
        EXCEPT    AS    ${error}
            Log    Erro ao limpar reservas: ${error}
        END
        
        # Limpar sessões
        Log    Limpando sessões...
        TRY
            ${sessions_response}=    GET On Session    cinemaApp    /sessions    headers=${headers}
            Log    Response sessões: ${sessions_response.text}
            ${sessions}=    Get From Dictionary    ${sessions_response.json()["data"]}    sessions
            FOR    ${session}    IN    @{sessions}
                ${session_id}=    Get From Dictionary    ${session}    _id
                Log    Deletando sessão: ${session_id}
                DELETE On Session    cinemaApp    /sessions/${session_id}    headers=${headers}
            END
        EXCEPT    AS    ${error}
            Log    Erro ao limpar sessões: ${error}
        END
        
        # Limpar filmes
        Log    Limpando filmes...
        TRY
            ${movies_response}=    GET On Session    cinemaApp    /movies    headers=${headers}
            Log    Response filmes: ${movies_response.text}
            ${movies}=    Get From Dictionary    ${movies_response.json()["data"]}    movies
            FOR    ${movie}    IN    @{movies}
                ${movie_id}=    Get From Dictionary    ${movie}    _id
                Log    Deletando filme: ${movie_id}
                DELETE On Session    cinemaApp    /movies/${movie_id}    headers=${headers}
            END
        EXCEPT    AS    ${error}
            Log    Erro ao limpar filmes: ${error}
        END
        
        # Limpar cinemas
        Log    Limpando cinemas...
        TRY
            ${theaters_response}=    GET On Session    cinemaApp    /theaters    headers=${headers}
            Log    Response cinemas: ${theaters_response.text}
            ${theaters}=    Get From Dictionary    ${theaters_response.json()}    data
            FOR    ${theater}    IN    @{theaters}
                ${theater_id}=    Get From Dictionary    ${theater}    _id
                Log    Deletando cinema: ${theater_id}
                DELETE On Session    cinemaApp    /theaters/${theater_id}    headers=${headers}
            END
        EXCEPT    AS    ${error}
            Log    Erro ao limpar cinemas: ${error}
        END
        
        # Limpar usuários (exceto o admin temporário se foi criado)
        Log    Limpando usuários de teste...
        Log    Procurando usuários com email: ${USER_EMAIL} ou ${ADMIN_EMAIL}
        TRY
            ${users_response}=    GET On Session    cinemaApp    /users    headers=${headers}
            Log    Response users: ${users_response.text}
            ${response_json}=    Set Variable    ${users_response.json()}
            Log    Response JSON completo: ${response_json}
            
            # Verificar se a resposta tem a estrutura esperada
            IF    'data' in $response_json
                ${data}=    Get From Dictionary    ${response_json}    data
                Log    Data da resposta: ${data}
                
                # Tentar diferentes possíveis chaves para a lista de usuários
                IF    'users' in $data
                    ${users}=    Get From Dictionary    ${data}    users
                    Log    Usuários encontrados na chave 'users': ${users}
                ELSE IF    'user' in $data
                    ${users}=    Get From Dictionary    ${data}    user
                    Log    Usuários encontrados na chave 'user': ${users}
                ELSE
                    ${users}=    Set Variable    ${data}
                    Log    Usando data diretamente como lista de usuários: ${users}
                END
                
                IF    $users is not None
                    Log    Total de usuários encontrados: ${users.__len__()}
                    FOR    ${user}    IN    @{users}
                        ${user_email}=    Get From Dictionary    ${user}    email
                        Log    Verificando usuário: ${user_email}
                        IF    '${user_email}' == '${USER_EMAIL}' or '${user_email}' == '${ADMIN_EMAIL}'
                            ${user_id}=    Get From Dictionary    ${user}    _id
                            Log    Deletando usuário de teste: ${user_email} (ID: ${user_id})
                            ${delete_response}=    DELETE On Session    cinemaApp    /users/${user_id}    headers=${headers}
                            Log    Resposta do DELETE: ${delete_response.status_code}
                        ELSE
                            Log    Usuário ${user_email} não é de teste, mantendo...
                        END
                    END
                ELSE
                    Log    Nenhum usuário encontrado ou estrutura inesperada
                END
            ELSE
                Log    Resposta não contém 'data', estrutura inesperada: ${response_json}
            END
        EXCEPT    AS    ${error}
            Log    Erro ao limpar usuários: ${error}
        END
        
        Log    Limpeza de dados concluída!
    EXCEPT    AS    ${error}
        Log    Erro ao limpar dados: ${error}
        Log    Stack trace: ${error}
    END

