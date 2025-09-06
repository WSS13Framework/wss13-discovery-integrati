#!/bin/bash

echo "🌐 Configurando DNS para ws13.com.br"

# A Records principais
echo "Configurar estes A Records no painel DNS:"
echo "ws13.com.br          → IP_DO_DROPLET"
echo "app.ws13.com.br      → IP_DO_DROPLET" 
echo "api.ws13.com.br      → IP_DO_DROPLET"
echo "portal.ws13.com.br   → IP_DO_DROPLET"
echo "n8n.ws13.com.br      → IP_DO_DROPLET"

# CNAME Records
echo "www.ws13.com.br      → ws13.com.br"
echo "*.ws13.com.br        → ws13.com.br"
