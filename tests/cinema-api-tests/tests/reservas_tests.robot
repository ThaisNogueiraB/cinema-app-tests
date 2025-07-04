*** Settings ***
Documentation  Testes de reservas da API Cinema App
Resource    ../support/base.robot

Suite Setup    Criar Sessao
Test Setup    Limpar Dados de Teste
Test Teardown    Limpar Dados de Teste

*** Test Cases ***
CT-033 - Criar reserva com dados validos
    [Documentation]    Testa criação de reserva com dados válidos
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    # Criar filme, cinema e sessão primeiro
    Criar dados validos para filme
    ${movie_response}    ${movie_id}=    Criar Filme E Obter ID    ${movie_data}    ${token}
    Criar dados validos para cinema
    ${theater_response}    ${theater_id}=    Criar Cinema E Obter ID    ${theater_data}    ${token}
    Criar dados da sessao com IDs existentes    ${movie_id}    ${theater_id}
    ${session_response}    ${session_id}=    Criar Sessao E Obter ID    ${session_data}    ${token}
    # Criar dados da reserva com ID real da sessão
    Criar dados da reserva com ID de sessao existente    ${session_id}
    ${response}=    Criar Reserva    ${reservation_data}    ${token}
    Validar Reserva Criada    ${response}

CT-037 - Obter reserva por id
    [Documentation]    Testa busca de reserva por ID
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    # Criar filme, cinema e sessão primeiro
    Criar dados validos para filme
    ${movie_response}    ${movie_id}=    Criar Filme E Obter ID    ${movie_data}    ${token}
    Criar dados validos para cinema
    ${theater_response}    ${theater_id}=    Criar Cinema E Obter ID    ${theater_data}    ${token}
    Criar dados da sessao com IDs existentes    ${movie_id}    ${theater_id}
    ${session_response}    ${session_id}=    Criar Sessao E Obter ID    ${session_data}    ${token}
    # Criar dados da reserva com ID real da sessão
    Criar dados da reserva com ID de sessao existente    ${session_id}
    ${response}    ${reservation_id}=    Criar Reserva E Obter ID    ${reservation_data}    ${token}
    ${response}=    Buscar Reserva por ID    ${reservation_id}    ${token}
    Validar Reserva Encontrada    ${response}

CT-031 - Obter todas as reservas
    [Documentation]    Testa busca de todas as reservas
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    ${response}=    Buscar Todas Reservas    ${token}
    Status Should Be    200    ${response}

CT-038 - Alterar reserva com dados validos
    [Documentation]    Testa atualização de dados da reserva
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    # Criar filme, cinema e sessão primeiro
    Criar dados validos para filme
    ${movie_response}    ${movie_id}=    Criar Filme E Obter ID    ${movie_data}    ${token}
    Criar dados validos para cinema
    ${theater_response}    ${theater_id}=    Criar Cinema E Obter ID    ${theater_data}    ${token}
    Criar dados da sessao com IDs existentes    ${movie_id}    ${theater_id}
    ${session_response}    ${session_id}=    Criar Sessao E Obter ID    ${session_data}    ${token}
    # Criar dados da reserva com ID real da sessão
    Criar dados da reserva com ID de sessao existente    ${session_id}
    ${response}    ${reservation_id}=    Criar Reserva E Obter ID    ${reservation_data}    ${token}
    Criar dados para atualização de reserva
    ${response}=    Atualizar Reserva    ${reservation_id}    ${updated_reservation}    ${token}
    Status Should Be    200    ${response}

CT-042 - Cancelar Reserva
    [Documentation]    Testa cancelamento de reserva
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    # Criar filme, cinema e sessão primeiro
    Criar dados validos para filme
    ${movie_response}    ${movie_id}=    Criar Filme E Obter ID    ${movie_data}    ${token}
    Criar dados validos para cinema
    ${theater_response}    ${theater_id}=    Criar Cinema E Obter ID    ${theater_data}    ${token}
    Criar dados da sessao com IDs existentes    ${movie_id}    ${theater_id}
    ${session_response}    ${session_id}=    Criar Sessao E Obter ID    ${session_data}    ${token}
    # Criar dados da reserva com ID real da sessão
    Criar dados da reserva com ID de sessao existente    ${session_id}
    ${response}    ${reservation_id}=    Criar Reserva E Obter ID    ${reservation_data}    ${token}
    ${response}=    Cancelar Reserva    ${reservation_id}    ${token}
    Validar Reserva Cancelada    ${response} 