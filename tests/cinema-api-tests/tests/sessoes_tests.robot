*** Settings ***
Documentation  Testes de sessões da API Cinema App
Resource    ../support/base.robot

Suite Setup    Criar Sessao
Test Setup    Limpar Dados de Teste
Test Teardown    Limpar Dados de Teste

*** Test Cases ***
CT-045- Criar sessao com dados validos
    [Documentation]    Testa criação de sessão com dados válidos
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    # Criar filme e cinema primeiro
    Criar dados validos para filme
    ${movie_response}    ${movie_id}=    Criar Filme E Obter ID    ${movie_data}    ${token}
    Criar dados validos para cinema
    ${theater_response}    ${theater_id}=    Criar Cinema E Obter ID    ${theater_data}    ${token}
    # Criar dados da sessão com IDs reais
    Criar dados da sessao com IDs existentes    ${movie_id}    ${theater_id}
    ${response}=    Criar Sessao API    ${session_data}    ${token}
    Validar Sessao Criada    ${response}

CT-049 - Obter sessao por id
    [Documentation]    Testa busca de sessão por ID
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    # Criar filme e cinema primeiro
    Criar dados validos para filme
    ${movie_response}    ${movie_id}=    Criar Filme E Obter ID    ${movie_data}    ${token}
    Criar dados validos para cinema
    ${theater_response}    ${theater_id}=    Criar Cinema E Obter ID    ${theater_data}    ${token}
    # Criar dados da sessão com IDs reais
    Criar dados da sessao com IDs existentes    ${movie_id}    ${theater_id}
    ${response}    ${session_id}=    Criar Sessao E Obter ID    ${session_data}    ${token}
    ${response}=    Buscar Sessao por ID    ${session_id}
    Validar Sessao Encontrada    ${response}

CT-044 - Obter todas as sessoes
    [Documentation]    Testa busca de todas as sessões
    ${response}=    Buscar Todas Sessoes
    Status Should Be    200    ${response}

CT-051 - Alterar sessao com dados validos
    [Documentation]    Testa atualização de dados da sessão
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    # Criar filme e cinema primeiro
    Criar dados validos para filme
    ${movie_response}    ${movie_id}=    Criar Filme E Obter ID    ${movie_data}    ${token}
    Criar dados validos para cinema
    ${theater_response}    ${theater_id}=    Criar Cinema E Obter ID    ${theater_data}    ${token}
    # Criar dados da sessão com IDs reais
    Criar dados da sessao com IDs existentes    ${movie_id}    ${theater_id}
    ${response}    ${session_id}=    Criar Sessao E Obter ID    ${session_data}    ${token}
    Criar dados para atualização de sessao
    ${response}=    Atualizar Sessao    ${session_id}    ${updated_session}    ${token}
    Status Should Be    200    ${response}

CT-052 - Deletar Sessao
    [Documentation]    Testa exclusão de sessão
    ${create_response}=    Criar dados validos para administrador
    ${token}=    Obter Token Admin
    # Criar filme e cinema primeiro
    Criar dados validos para filme
    ${movie_response}    ${movie_id}=    Criar Filme E Obter ID    ${movie_data}    ${token}
    Criar dados validos para cinema
    ${theater_response}    ${theater_id}=    Criar Cinema E Obter ID    ${theater_data}    ${token}
    # Criar dados da sessão com IDs reais
    Criar dados da sessao com IDs existentes    ${movie_id}    ${theater_id}
    ${response}    ${session_id}=    Criar Sessao E Obter ID    ${session_data}    ${token}
    ${response}=    Deletar Sessao    ${session_id}    ${token}
    Validar Sessao Deletada    ${response} 