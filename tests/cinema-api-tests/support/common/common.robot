*** Settings ***
Documentation   Keywords e variaveis para uso geral 
Resource        ../base.robot    

*** Keywords ***
# ===== VALIDAÇÕES COMUNS =====
Validar Status 201
    [Arguments]    ${response}
    Status Should Be    201    ${response}

Validar Status 200
    [Arguments]    ${response}
    Status Should Be    200    ${response}

Validar Status 401
    [Arguments]    ${response}
    Status Should Be    401    ${response}

Validar Resposta JSON
    [Arguments]    ${response}
    Dictionary Should Contain Key    ${response.json()}    success
    Dictionary Should Contain Key    ${response.json()}    data







# ===== AUTENTICAÇÃO HELPER =====
Obter Token Admin Para Limpeza
    TRY
        ${token}=    Obter Token Admin Para Limpeza
        RETURN    ${token}
    EXCEPT    AS    ${error}
        ${create_response}=    Criar Admin Se Necessario
        ${token}=    Obter Token Admin Para Limpeza
        RETURN    ${token}
    END

Criar Admin Se Necessario
    TRY
        ${token}=    Obter Token Admin Para Limpeza
        RETURN    ${token}
    EXCEPT    AS    ${error}
        ${create_response}=    Criar Admin Se Necessario
        ${token}=    Obter Token Admin Para Limpeza
        RETURN    ${token}
    END

# ===== LIMPEZA ESPECÍFICA =====
Limpar Usuario Por Email
    [Arguments]    ${email}
    TRY
        ${admin_token}=    Obter Token Admin Para Limpeza
        ${headers}=    Create Dictionary    Authorization=Bearer ${admin_token}
        ${users_response}=    GET On Session    cinemaApp    /users    headers=${headers}
        ${users}=    Get From Dictionary    ${users_response.json()["data"]}    users
        FOR    ${user}    IN    @{users}
            ${user_email}=    Get From Dictionary    ${user}    email
            IF    '${user_email}' == '${email}'
                ${user_id}=    Get From Dictionary    ${user}    _id
                DELETE On Session    cinemaApp    /users/${user_id}    headers=${headers}
                Log    Usuário removido: ${email}
            END
        END
    EXCEPT    AS    ${error}
        Log    Erro: ${error}
        Log    Stack trace: ${error}
    END

Limpar Filme Por ID
    [Arguments]    ${movie_id}
    TRY
        ${admin_token}=    Obter Token Admin Para Limpeza
        ${headers}=    Create Dictionary    Authorization=Bearer ${admin_token}
        DELETE On Session    cinemaApp    /movies/${movie_id}    headers=${headers}
        Log    Filme removido: ${movie_id}
    EXCEPT    AS    ${error}
        Log    Erro: ${error}
        Log    Stack trace: ${error}
    END

Limpar Cinema Por ID
    [Arguments]    ${theater_id}
    TRY
        ${admin_token}=    Obter Token Admin Para Limpeza
        ${headers}=    Create Dictionary    Authorization=Bearer ${admin_token}
        DELETE On Session    cinemaApp    /theaters/${theater_id}    headers=${headers}
        Log    Cinema removido: ${theater_id}
    EXCEPT    AS    ${error}
        Log    Erro: ${error}
        Log    Stack trace: ${error}
    END
