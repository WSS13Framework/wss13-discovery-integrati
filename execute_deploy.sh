#!/bin/bash

echo "🚀 Executando Deploy WSS+13 na Digital Ocean"
echo "============================================="

# 1. Mostrar configurações DNS
echo "📋 1. CONFIGURAÇÕES DNS NECESSÁRIAS:"
./dns_config.sh

echo ""
echo "⏳ Aguarde 5 segundos antes de continuar..."
sleep 5

# 2. Executar deploy completo
echo "🌊 2. EXECUTANDO DEPLOY COMPLETO:"
./deploy_wss13_complete.sh

echo ""
echo "⏳ Aguarde 3 segundos..."
sleep 3

# 3. Configurar SSL (opcional)
echo "🔒 3. CONFIGURAR SSL? (s/n)"
read -r ssl_choice
if [[ "$ssl_choice" == "s" ]]; then
    ./ssl_setup.sh
fi

echo ""
echo "✅ Deploy WSS+13 finalizado!"
echo "🌐 Acesse: http://$(curl -s ifconfig.me)"
