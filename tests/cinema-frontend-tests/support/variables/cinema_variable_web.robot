*** Settings ***
Documentation    


*** Variables ***
# URLs da aplicação
${BASE_URL}       http://localhost:3002
${API_URL}        http://localhost:3000/api/v1

# Configurações do navegador
${BROWSER}        chromium
${HEADLESS}       False
${TIMEOUT}        30s

# Status codes para requisições
${STATUS_REQ}     any

# Credenciais padrão
${EMAIL_ADMIN}    admin@example.com
${SENHA_ADMIN}    admin123
${EMAIL_USER}     test@example.com
${SENHA_USER}     password123
${EMAIL_CADASTRO}    usuario.teste@email.com

# Caminhos dos arquivos
${FIXTURES_PATH}  ${EXECDIR}/tests/cinema-frontend-tests/support/fixtures/cinema_data.json

# Elementos da interface web
${LOGIN_EMAIL_FIELD}    id=email
${LOGIN_PASSWORD_FIELD}    id=password
${LOGIN_BUTTON}    id=login-button
${LOGOUT_BUTTON}    id=logout-button

# Mensagens de validação
${LOGIN_SUCCESS_MSG}    Login realizado com sucesso
${LOGIN_ERROR_MSG}    Email ou senha inválidos
${LOGOUT_SUCCESS_MSG}    Logout realizado com sucesso

# Timeouts específicos
${ELEMENT_TIMEOUT}    10s
${PAGE_LOAD_TIMEOUT}    20s
${AJAX_TIMEOUT}    15s 