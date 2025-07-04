# 🎬 Cinema App - Suíte Completa de Testes

> **Projeto de Testes Automatizados e Manuais para a Aplicação Cinema App**  
> Desenvolvido com Robot Framework, Playwright e Postman para garantir qualidade e confiabilidade da aplicação.

## 📋 Índice

- [🎯 Sobre o Projeto](#-sobre-o-projeto)
- [🏗️ Arquitetura](#️-arquitetura)
- [🛠️ Tecnologias Utilizadas](#️-tecnologias-utilizadas)
- [📁 Estrutura do Projeto](#-estrutura-do-projeto)
- [⚙️ Pré-requisitos](#️-pré-requisitos)
- [🚀 Instalação e Configuração](#-instalação-e-configuração)
- [🧪 Executando os Testes](#-executando-os-testes)
- [📊 Relatórios e Resultados](#-relatórios-e-resultados)
- [🔄 CI/CD Pipeline](#-cicd-pipeline)
- [📚 Documentação](#-documentação)
- [🐛 Solução de Problemas](#-solução-de-problemas)
- [🤝 Contribuição](#-contribuição)
- [📄 Licença](#-licença)

## 🎯 Sobre o Projeto

O **Cinema App** é uma aplicação completa de gerenciamento de cinema que permite:
- 🎫 Reserva de ingressos
- 🎬 Gerenciamento de filmes
- 🏢 Administração de cinemas
- 🎭 Controle de sessões
- 👥 Gestão de usuários
- 🔐 Sistema de autenticação

Este repositório contém uma **suíte completa de testes** que abrange:

### ✅ **Testes Automatizados de API**
- Testes de endpoints REST
- Validação de respostas JSON
- Testes de autenticação e autorização
- Cobertura de CRUD completo

### ✅ **Testes Automatizados de Frontend**
- Testes de interface do usuário
- Validação de fluxos de navegação
- Testes de responsividade
- Automação de cenários de negócio

### ✅ **Testes Manuais**
- Casos de teste estruturados
- Cenários exploratórios
- Validação de experiência do usuário
- Documentação de bugs encontrados

## 🏗️ Arquitetura

```
cinema-app-tests/
├── 📁 tests/
│   ├── 📁 cinema-api-tests/          # Testes automatizados da API
│   ├── 📁 cinema-frontend-tests/     # Testes automatizados do Frontend
│   └── 📁 cinema-manual-tests/       # Testes manuais e documentação
├── 📁 docs/                          # Documentação e mapas mentais
├── 📁 Issues/                        # Bugs e issues encontrados
├── 📁 resultados/                    # Relatórios de execução
└── 📁 results/                       # Resultados de CI/CD
```

## 🛠️ Tecnologias Utilizadas

### **Automação de Testes**
- **Robot Framework** - Framework principal de automação
- **Playwright** - Automação de navegadores
- **RequestsLibrary** - Testes de API REST
- **JSONLibrary** - Manipulação de dados JSON

### **Ferramentas de Teste Manual**
- **Postman** - Testes de API e documentação
- **Swagger** - Documentação da API
- **MongoDB** - Banco de dados

### **Infraestrutura**
- **Python 3.8+** - Linguagem base
- **Node.js** - Runtime para aplicação
- **Git** - Controle de versão
- **GitHub Actions** - CI/CD

## 📁 Estrutura do Projeto

### **Testes de API (`tests/cinema-api-tests/`)**
```
cinema-api-tests/
├── 📁 keywords/                    # Keywords específicas
│   ├── auth_keywords.resource      # Autenticação e login
│   ├── usuarios_keywords.resource  # Gestão de usuários
│   ├── filmes_keywords.resource    # Gestão de filmes
│   ├── cinemas_keywords.resource   # Gestão de cinemas
│   ├── sessoes_keywords.resource   # Gestão de sessões
│   └── reservas_keywords.resource  # Gestão de reservas
├── 📁 tests/                       # Casos de teste
│   ├── auth_tests.robot           # Testes de autenticação
│   ├── usuarios_tests.robot       # Testes de usuários
│   ├── filmes_tests.robot         # Testes de filmes
│   ├── cinemas_tests.robot        # Testes de cinemas
│   ├── sessoes_tests.robot        # Testes de sessões
│   └── reservas_tests.robot       # Testes de reservas
└── 📁 support/                    # Configurações e recursos
    ├── base.robot                 # Configuração base
    ├── 📁 common/                 # Keywords comuns
    └── 📁 variables/              # Variáveis globais
```

### **Testes de Frontend (`tests/cinema-frontend-tests/`)**
```
cinema-frontend-tests/
├── 📁 tests/                      # Testes organizados
│   ├── login_tests.robot          # Testes de autenticação
│   ├── filmes_tests.robot         # Testes de filmes
│   ├── reserva_tests.robot        # Testes de reservas
│   └── sessao_tests.robot         # Testes de sessões
├── 📁 keywords/                   # Keywords específicas
│   ├── login_keywords.resource    # Keywords de login
│   ├── filmes_keywords.resource   # Keywords de filmes
│   ├── reserva_keywords.resource  # Keywords de reservas
│   └── sessao_keywords.resource   # Keywords de sessões
├── 📁 support/                    # Configurações
│   ├── base.robot                 # Configuração base
│   ├── 📁 common/                 # Keywords compartilhadas
│   ├── 📁 variables/              # Variáveis de configuração
│   └── 📁 fixtures/               # Dados de teste
└── 📁 browser/                    # Screenshots e traces
    ├── 📁 screenshot/             # Screenshots de falhas
    └── 📁 traces/                 # Traces do Playwright
```

### **Testes Manuais (`tests/cinema-manual-tests/`)**
```
cinema-manual-tests/
├── API Cinema App.postman_collection.json    # Coleção Postman
├── Cinema app.postman_environment.json       # Ambiente Postman
├── API Cinema App.postman_test_run.json      # Execução de testes
└── README.md                                 # Documentação
```

## ⚙️ Pré-requisitos

### **Sistema Operacional**
- Windows 10/11, macOS 10.15+, ou Linux (Ubuntu 18.04+)

### **Software Necessário**
- **Python 3.8+** - [Download Python](https://www.python.org/downloads/)
- **Node.js 14+** - [Download Node.js](https://nodejs.org/)
- **Git** - [Download Git](https://git-scm.com/)
- **MongoDB** - [Download MongoDB](https://www.mongodb.com/try/download/community)

### **Ferramentas de Teste**
- **Postman** - [Download Postman](https://www.postman.com/downloads/)
- **Chrome/Chromium** - Para testes de frontend

## 🚀 Instalação e Configuração

### **1. Clone o Repositório**
```bash
git clone https://github.com/seu-usuario/cinema-app-tests.git
cd cinema-app-tests
```

### **2. Configurar Ambiente Python**
```bash
# Criar ambiente virtual
python -m venv venv

# Ativar ambiente virtual
# Windows (PowerShell):
venv\Scripts\Activate
# Windows (CMD):
venv\Scripts\activate.bat
# Linux/Mac:
source venv/bin/activate

# Instalar dependências
pip install -r requirements.txt
```

### **3. Configurar Aplicação Backend**
```bash
# Navegar para o diretório da aplicação
cd ../cinema-challenge-back

# Instalar dependências Node.js
npm install

# Configurar variáveis de ambiente
cp .env.example .env
# Editar .env com suas configurações

# Iniciar aplicação
npm start
```

### **4. Configurar Aplicação Frontend**
```bash
# Em outro terminal, navegar para o frontend
cd ../cinema-challenge-front

# Instalar dependências
npm install

# Iniciar aplicação
npm run dev
```

### **5. Verificar Configuração**
```bash
# Verificar se Robot Framework está instalado
robot --version

# Verificar se Playwright está configurado
playwright install
```

## 🧪 Executando os Testes

### **Testes de API**

#### **Executar Todos os Testes de API**
```bash
# Navegar para o diretório de testes de API
cd tests/cinema-api-tests

# Executar todos os testes
robot .

# Executar com relatório detalhado
robot -d reports .
```


### **Testes de Frontend**

#### **Executar Todos os Testes de Frontend**
```bash
# Navegar para o diretório de testes de frontend
cd tests/cinema-frontend-tests

# Executar todos os testes
robot .

# Executar em modo headless (CI/CD)
robot --variablefile support/variables/cinema_variable_ci.robot .
```

### **Testes Manuais**

#### **Configurar Postman**
1. Abrir Postman
2. Importar coleção: `tests/cinema-manual-tests/API Cinema App.postman_collection.json`
3. Importar ambiente: `tests/cinema-manual-tests/Cinema app.postman_environment.json`
4. Configurar variável `baseUrl` no ambiente: `http://localhost:3000/api/v1`

#### **Executar Testes Manuais**
1. Selecionar ambiente correto no Postman
2. Executar requisições conforme cenários da coleção
3. Verificar respostas e status codes
4. Documentar bugs encontrados

### **Executar Suíte Completa**
```bash
# Executar script de CI/CD
./run_tests_ci.sh

# Ou executar manualmente
robot -d results tests/cinema-api-tests/
robot -d results tests/cinema-frontend-tests/
```

## 📊 Relatórios e Resultados

### **Relatórios Automatizados**
Após a execução dos testes, os seguintes relatórios são gerados:

- **`log.html`** - Log detalhado da execução
- **`report.html`** - Relatório executivo com métricas
- **`output.xml`** - Dados estruturados para integração
- **`screenshot/`** - Screenshots de falhas (frontend)

### **Acessar Relatórios**
```bash
# Abrir relatório no navegador
# Windows:
start reports/report.html
# Linux/Mac:
open reports/report.html
```

## 🔄 CI/CD Pipeline

### **GitHub Actions**
O projeto inclui pipeline de CI/CD configurado para:

1. **Build e Teste Automático**
   - Execução em pull requests
   - Validação de qualidade de código
   - Execução de testes automatizados

2. **Deploy Automático**
   - Deploy em ambiente de staging
   - Execução de testes de regressão
   - Notificações de status

### **Configuração do Pipeline**
```yaml
# .github/workflows/tests.yml
name: Testes Automatizados

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'
    
    - name: Install dependencies
      run: |
        pip install -r requirements.txt
        playwright install
    
    - name: Run API Tests
      run: |
        robot -d results tests/cinema-api-tests/
    
    - name: Run Frontend Tests
      run: |
        robot -d results tests/cinema-frontend-tests/
    
    - name: Upload test results
      uses: actions/upload-artifact@v3
      with:
        name: test-results
        path: results/
```

### **Executar Pipeline Localmente**
```bash
# Executar script de CI/CD local
./run_tests_ci.sh

# Verificar resultados
ls -la results/
```

## 📚 Documentação

### **Documentação Técnica**
- **Mapas Mentais**: `docs/mapamental-cinemaapp-*.xmind`
- **Planos de Teste**: `docs/Plano de Testes – API Cinema App.pdf`
- **Relatórios**: `docs/Relatório de Testes - Cinema App.pdf`
- **User Stories**: `docs/USER-STORIES.md`

### **Documentação da API**
- **Swagger UI**: http://localhost:3000/api/v1/docs/
- **Postman Collection**: `tests/cinema-manual-tests/API Cinema App.postman_collection.json`

### **Guias de Uso**
- **Testes de API**: `tests/cinema-api-tests/README.md`
- **Testes de Frontend**: `tests/cinema-frontend-tests/README.md`
- **Testes Manuais**: `tests/cinema-manual-tests/README.md`


## 🤝 Contribuição

### **Como Contribuir**
1. **Fork** o projeto
2. **Crie** uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. **Commit** suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. **Push** para a branch (`git push origin feature/AmazingFeature`)
5. **Abra** um Pull Request

### **Padrões de Código**
- Seguir convenções do Robot Framework
- Documentar keywords e variáveis
- Incluir testes para novas funcionalidades
- Manter cobertura de testes >90%

### **Reportar Bugs**
1. Verificar se o bug já foi reportado
2. Criar issue com template adequado
3. Incluir logs e screenshots
4. Descrever passos para reprodução

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.


**Desenvolvido com ❤️ pela QA Thais Nogueira**  
*Última atualização: Julho 2025*