*** Settings ***
Documentation    Teste para configurar usuários admin e de teste via API
Resource         ../support/base.robot

Test Setup       Setup Test Environment
Test Teardown    Teardown Test Environment

*** Test Cases ***
Setup: Criar usuário admin via API
    [Documentation]    Cria um usuário admin para os testes
    [tags]    setup    admin
    
    ${result}=    Criar usuário admin - API
    # Log removido para limpeza do console

