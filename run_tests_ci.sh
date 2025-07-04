#!/bin/bash

# Script para executar testes Robot Framework no ambiente CI/CD
set -e

echo "=== Configurando ambiente CI/CD para Robot Framework ==="

# Criar diretório de resultados
mkdir -p results

# Configurar variáveis de ambiente para CI/CD
export DISPLAY=:99
export HEADLESS=true
export BROWSER=chromium

echo "=== Executando testes de API ==="
# Executar testes de API primeiro
robot -d results --exclude frontend tests/cinema-api-tests/

echo "=== Executando testes de Frontend ==="
# Executar testes de frontend com configuração headless
robot -d results \
    --variablefile tests/cinema-frontend-tests/support/variables/cinema_variable_ci.robot \
    tests/cinema-frontend-tests/

echo "=== Executando testes manuais (se existirem) ==="
# Executar outros testes se existirem
if [ -d "tests/cinema-manual-tests" ]; then
    robot -d results tests/cinema-manual-tests/
fi

echo "=== Testes concluídos ==="
echo "Relatórios disponíveis em: results/" 