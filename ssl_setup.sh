#!/bin/bash

echo "🔒 Configurando SSL para ws13.com.br"

# Instalar Certbot
sudo apt update
sudo apt install -y certbot python3-certbot-nginx

# Gerar certificados SSL para todos os subdomínios
sudo certbot --nginx -d ws13.com.br -d www.ws13.com.br
sudo certbot --nginx -d api.ws13.com.br
sudo certbot --nginx -d portal.ws13.com.br  
sudo certbot --nginx -d n8n.ws13.com.br

# Configurar auto-renovação
echo "0 12 * * * /usr/bin/certbot renew --quiet" | sudo crontab -

echo "✅ SSL configurado para todos os subdomínios!"

echo "🔒 Configurando SSL para ws13.com.br"

# Instalar Certbot
sudo apt update
sudo apt install -y certbot python3-certbot-nginx

# Gerar certificados SSL para todos os subdomínios
sudo certbot --nginx -d ws13.com.br -d www.ws13.com.br
sudo certbot --nginx -d api.ws13.com.br
sudo certbot --nginx -d portal.ws13.com.br  
sudo certbot --nginx -d n8n.ws13.com.br

# Configurar auto-renovação
echo "0 12 * * * /usr/bin/certbot renew --quiet" | sudo crontab -

echo "✅ SSL configurado para todos os subdomínios!"
