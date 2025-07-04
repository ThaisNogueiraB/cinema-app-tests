# 🎬 Cinema App - Testes Automatizados

Este projeto contém testes automatizados para o aplicativo de cinema usando Robot Framework com Playwright.

## 📋 Pré-requisitos

- **Python 3.8+**
- **Node.js 14+**
- **Git**

## 🚀 Configuração Inicial

### 1. Clone o repositório
```bash
git clone <url-do-repositorio>
cd Cinemaapp-front
```

### 2. Configurar ambiente virtual Python
```bash
# Criar ambiente virtual
python -m venv .venv

# Ativar ambiente virtual
# Windows (PowerShell):
.venv\Scripts\Activate
# Windows (CMD):
.venv\Scripts\activate.bat
# Linux/Mac:
source .venv/bin/activate
```

### 3. Instalar dependências Python
```bash
pip install -r requirements.txt
```

### 4. Instalar dependências Node.js
```bash
cd ../docs/cinema-challenge-back
npm install
```

### 5. Iniciar servidores
Execute o script para iniciar automaticamente os servidores:
```bash
start_servers.bat
```

Ou inicie manualmente:
```bash
# Terminal 1 - API Server (porta 3000)
cd ../docs/cinema-challenge-back
npm start

# Terminal 2 - Web Server (porta 3002)
cd ../docs/cinema-challenge-back
npm run dev
```

## 🧪 Executando os Testes

### Executar todos os testes
```bash
robot tests/
```



## 📁 Estrutura do Projeto

```
cinema-frontend-tests/
├── 📁 tests/                    # Testes organizados por funcionalidade
│   ├── login_tests.robot        # Testes de autenticação
│   ├── filmes_tests.robot       # Testes de filmes
│   ├── reserva_tests.robot      # Testes de reservas
│   └── sessao_tests.robot       # Testes de sessões
│
├── 📁 keywords/                 # Keywords específicas por funcionalidade
│   ├── login_keywords.resource  # Keywords de login
│   ├── filmes_keywords.resource # Keywords de filmes
│   ├── reserva_keywords.resource # Keywords de reservas
│   └── sessao_keywords.resource # Keywords de sessões
│
├── 📁 support/                  # Configurações e recursos compartilhados
│   ├── base.robot              # Configuração base dos testes
│   ├── 📁 common/              # Keywords compartilhadas
│   │   └── common.resource     # Keywords globais
│   ├── 📁 variables/           # Variáveis de configuração
│   │   └── cinema_variable_web.robot
│   └── 📁 fixtures/            # Dados de teste
│       └── cinema_data.json    # Massa de dados
│
├── 📁 browser/                 # Screenshots e traces (gerados automaticamente)
│   ├── screenshot/             # Screenshots de falhas
│   └── traces/                 # Traces do Playwright
│
├── start_servers.bat           # Script para iniciar servidores
├── robot.yaml                  # Configuração do Robot Framework
├── requirements.txt            # Dependências Python
└── README.md                   # Este arquivo
```

## 🔧 Configurações

### URLs dos Servidores
- **Web Server**: http://localhost:3002
- **API Server**: http://localhost:3000/api/v1



### Variáveis de Ambiente
As principais variáveis estão definidas em `support/variables/cinema_variable_web.robot`:
- `${BASE_URL}`: URL do servidor web
- `${API_URL}`: URL da API
- `${BROWSER}`: Navegador a ser usado
- `${TIMEOUT}`: Timeout padrão

## 📊 Relatórios

Após a execução dos testes, os relatórios são gerados automaticamente:

- **Log detalhado**: `log.html`
- **Relatório executivo**: `report.html`
- **Output XML**: `output.xml`
- **Screenshots**: `browser/screenshot/` (em caso de falha)

## 🎯 Testes Disponíveis

### Testes de Login
- **CTW-001**: Login com credenciais válidas
- **CTW-002**: Login com credenciais inválidas
- **CTW-003**: Logout do sistema

### Testes de Filmes
- **CTW-010**: Listagem de filmes em cartaz
- **CTW-011**: Visualizar detalhes de filme
- **CTW-012**: Buscar filme por título

### Testes de Reservas
- **CTW-020**: Listagem de reservas do usuário
- **CTW-021**: Realizar reserva de sessão
- **CTW-022**: Cancelar reserva

### Testes de Sessões
- **CTW-025**: Listagem pública de sessões
- **CTW-026**: Visualizar detalhes de sessão
- **CTW-055**: Resetar assentos (admin)


### Screenshots
Screenshots são capturados automaticamente em caso de falha na pasta `browser/screenshot/`.





Para dúvidas ou problemas:
1. Verifique a seção "Solução de Problemas"
2. Execute `robot test_connectivity.robot`
3. Verifique os logs em `log.html`
4. Consulte a documentação do Robot Framework

---

**Desenvolvido com ❤️ usando Robot Framework