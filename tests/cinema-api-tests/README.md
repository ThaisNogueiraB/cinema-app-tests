# 🎬 Cinema App - Testes Automatizados

Este diretório contém a suíte completa de testes automatizados para a API Cinema App, desenvolvida em Robot Framework.

## 📁 Estrutura do Projeto

```
cinema-api-tests/
├── keywords/                    # Keywords específicas 
│   ├── auth_keywords.resource      # Autenticação e login
│   ├── usuarios_keywords.resource  # Gestão de usuários
│   ├── filmes_keywords.resource    # Gestão de filmes
│   ├── cinemas_keywords.resource   # Gestão de cinemas
│   ├── sessoes_keywords.resource   # Gestão de sessões
│   └── reservas_keywords.resource  # Gestão de reservas
├── tests/                      # Casos de teste organizados 
│   ├── auth_tests.robot           # Testes de autenticação
│   ├── usuarios_tests.robot       # Testes de usuários
│   ├── filmes_tests.robot         # Testes de filmes
│   ├── cinemas_tests.robot        # Testes de cinemas
│   ├── sessoes_tests.robot        # Testes de sessões
│   └── reservas_tests.robot       # Testes de reservas
├── support/                    # Recursos de suporte
│   ├── base.robot                 # Configuração base e imports
│   ├── common/                    # Keywords comuns
│   │   └── common.robot              # Validações, autenticação e limpeza
│   └── variables/                  # Variáveis globais
├── reports/                     # Relatórios de execução
│   ├── log.html
│   ├── output.xml
│   └── report.html
└── README.md                    # Este arquivo
```

## 🚀 Como Executar os Testes

### Pré-requisitos
- Python 3.7+
- Robot Framework
- Biblioteca RequestsLibrary

## 🏠 Executando os Testes Localmente


#### 1. **Configurar Ambiente**
```bash
# Criar ambiente virtual
python -m venv venv

# Ativar (Windows)
venv\Scripts\activate.bat

# Instalar dependências
pip install robotframework robotframework-requests robotframework-jsonlibrary
```

#### 2. **Executar Testes**
```bash
# Todos os testes
robot cinema-app-tests/
```

#### 3. **Verificar Resultados**
```bash
# Abrir relatório
start cinema-app-tests/reports/report.html
```

### ✅ Checklist Rápido
- [ ] API rodando em `http://localhost:3000`
- [ ] Ambiente virtual ativo `(venv)`
- [ ] `robot --version` funciona
- [ ] Está na pasta `Cinemaapp`


```

## 📋 Descrição dos Módulos

### 🔐 Autenticação (`auth_keywords.resource`)
- **Login de usuário comum**: Autenticação com credenciais válidas
- **Login de administrador**: Autenticação com privilégios admin
- **Criar usuário comum**: Cadastro de usuário regular
- **Criação de administrador**: Setup inicial do sistema

### 👥 Usuários (`usuarios_keywords.resource`)
- **Buscar usuário**: Consulta por ID ou email
- **Atualizar usuário**: Modificação de dados
- **Excluir usuário**: Remoção de registros
- **Listar usuários**: Consulta paginada

### 🎬 Filmes (`filmes_keywords.resource`)
- **Criar filme**: Cadastro com título, descrição, duração
- **Buscar filme**: Consulta por ID
- **Atualizar filme**: Modificação de dados
- **Excluir filme**: Remoção de registros
- **Listar filmes**: Consulta paginada

### 🏢 Cinemas (`cinemas_keywords.resource`)
- **Criar cinema**: Cadastro com nome, endereço, capacidade
- **Buscar cinema**: Consulta por ID
- **Atualizar cinema**: Modificação de dados
- **Excluir cinema**: Remoção de registros
- **Listar cinemas**: Consulta paginada

### 🎭 Sessões (`sessoes_keywords.resource`)
- **Criar sessão**: Agendamento com filme, cinema, data/hora
- **Buscar sessão**: Consulta por ID
- **Atualizar sessão**: Modificação de dados
- **Excluir sessão**: Remoção de registros
- **Listar sessões**: Consulta paginada

### 🎫 Reservas (`reservas_keywords.resource`)
- **Criar reserva**: Booking com sessão, assentos, usuário
- **Buscar reserva**: Consulta por ID
- **Atualizar reserva**: Modificação de dados
- **Cancelar reserva**: Cancelamento de booking
- **Listar reservas**: Consulta paginada


## 📊 Relatórios

Os relatórios são gerados automaticamente na pasta `reports/`:
- **log.html**: Log detalhado da execução
- **output.xml**: Dados estruturados para integração
- **report.html**: Relatório executivo com métricas




Para dúvidas ou problemas:
1. Verifique os logs de execução
2. Consulte a documentação da API
3. Execute testes individuais para isolamento
4. Verifique a conectividade com a API

---

**Desenvolvido por Thais Nogueira usando Robot Framework** 