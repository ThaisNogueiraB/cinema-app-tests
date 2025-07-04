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

### Executar testes específicos por tag
```bash
# Testes de login
robot --include "login" tests/

# Testes de filmes
robot --include "filmes" tests/

# Testes de reservas
robot --include "reserva" tests/

# Testes de sessões
robot --include "sessao" tests/

# Testes de administrador
robot --include "admin" tests/
```

### Executar teste específico
```bash
# Por nome do arquivo
robot tests/login_tests.robot

# Por tag específica
robot --include "criar-reserva" tests/reserva_tests.robot

# Por nome do teste
robot --test "CTW-020: Listagem de reservas do usuário via interface" tests/reserva_tests.robot
```



## 📁 Estrutura do Projeto

```
src/
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

### Configurações do Navegador
- **Browser**: Chromium
- **Headless**: False (para visualizar os testes)
- **Timeout**: 30s

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

## 🐛 Solução de Problemas

### Erro de Conexão
Se os testes falharem com erro de conexão:
1. Verifique se os servidores estão rodando
2. Execute `start_servers.bat` para reiniciar
3. Aguarde os servidores inicializarem completamente

### Erro de SESSAO_ID
Se houver erro relacionado ao SESSAO_ID:
1. Verifique se a API está respondendo
2. Verifique se o usuário admin foi criado corretamente
3. Verifique se o filme e sessão foram criados

### Erro de Timeout
Se houver erro de timeout:
1. Aumente o valor de `${TIMEOUT}` nas variáveis
2. Verifique a velocidade da conexão
3. Considere executar em modo headless

### Screenshots
Screenshots são capturados automaticamente em caso de falha na pasta `browser/screenshot/`.

## 📝 Tags dos Testes

- `login`: Testes de autenticação
- `filmes`: Testes de filmes
- `reserva`: Testes de reservas
- `sessao`: Testes de sessões
- `admin`: Testes que requerem privilégios de administrador
- `lista-sessao`: Listagem de sessões
- `detalhes-sessao`: Detalhes de sessão
- `criar-reserva`: Criação de reservas
- `listagem-reservas`: Listagem de reservas

## 🔄 Comandos Úteis

### Limpar relatórios antigos
```bash
# Windows
del /q *.html *.xml
rmdir /s /q browser\screenshot browser\traces

# Linux/Mac
rm -f *.html *.xml
rm -rf browser/screenshot browser/traces
```

### Executar testes em modo headless
```bash
robot --variable HEADLESS:True tests/
```

### Executar testes com output detalhado
```bash
robot --console verbose tests/
```

### Executar testes específicos com retry
```bash
robot --rerunfailed output.xml tests/
```

## 🤝 Contribuição

1. **Mantenha a estrutura de pastas** conforme definido
2. **Use tags apropriadas** nos testes
3. **Documente novas keywords** com `[Documentation]`
4. **Execute os testes** antes de fazer commit
5. **Siga o padrão de nomenclatura** dos testes (CTW-XXX)
6. **Adicione screenshots** em caso de falha

## 📞 Suporte

Para dúvidas ou problemas:
1. Verifique a seção "Solução de Problemas"
2. Execute `robot test_connectivity.robot`
3. Verifique os logs em `log.html`
4. Consulte a documentação do Robot Framework

---

**Desenvolvido com ❤️ usando Robot Framework + Playwright** 