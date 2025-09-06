#!/bin/bash

echo "🧪 Testando WSS+13 Sistema..."

# Testar API Status
echo "📡 Testando API Status..."
curl -s http://localhost:5000/api/status | jq '.' || echo "❌ API não está respondendo"

# Testar Templates
echo "📋 Testando Templates..."
curl -s http://localhost:5000/api/templates | jq '.total' || echo "❌ Templates não carregaram"

# Testar Descoberta (simulação)
echo "🤖 Testando Análise de Dor..."
curl -X POST http://localhost:5000/api/discover \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Teste User",
    "email": "teste@empresa.com",
    "whatsapp": "(11) 99999-9999",
    "company": "Empresa Teste",
    "pain": "Gastamos muito tempo copiando dados entre planilhas"
  }' | jq '.' || echo "❌ Análise não funcionou"

echo "✅ Testes concluídos!"
