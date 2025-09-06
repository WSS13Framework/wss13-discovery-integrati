log_info "Criando servidor WSS+13..."
cat > server.js << 'SERVER_EOF'
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(helmet());
app.use(cors());
app.use(express.json());

// Templates WSS+13
const templates = [
    {
        id: 1,
        name: "WhatsApp Business Automation",
        description: "Automatiza atendimento, qualificação de leads e agendamentos via WhatsApp",
        category: "comunicacao",
        roi: "340%",
        implementation_time: "2 dias",
        keywords: ["whatsapp", "atendimento", "vendas", "leads", "comunicacao"]
    },
    {
        id: 2,
        name: "Sistema de Correção de Erros",
        description: "Detecta e corrige automaticamente erros de digitalização em dados",
        category: "dados",
        roi: "300%",
        implementation_time: "3 dias",
        keywords: ["erro", "dados", "planilha", "digitacao", "manual"]
    },
    {
        id: 3,
        name: "CRM Integration Master",
        description: "Sincroniza dados entre sistemas e elimina trabalho manual",
        category: "integracao",
        roi: "280%",
        implementation_time: "3 dias",
        keywords: ["crm", "sistema", "integracao", "dados", "manual"]
    }
];

// Rota principal
app.get('/', (req, res) => {
    const domain = req.get('host');
    const protocol = req.get('x-forwarded-proto') || 'http';
    
    res.send(\`
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WSS+13 - Sistema Online na Digital Ocean</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; 
            background: linear-gradient(135deg, #007aff 0%, #0056cc 100%);
            color: white;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }
        
        .logo { 
            width: 120px; 
            height: 120px; 
            background: rgba(255,255,255,0.2); 
            border-radius: 24px; 
            display: flex; 
            flex-direction: column; 
            align-items: center; 
            justify-content: center; 
            margin-bottom: 30px;
            font-weight: 700;
        }
        
        h1 { font-size: 3rem; margin-bottom: 20px; }
        p { font-size: 1.2rem; margin-bottom: 30px; opacity: 0.9; }
        
        .btn { 
            background: white; 
            color: #007aff; 
            padding: 15px 30px; 
            border: none; 
            border-radius: 12px; 
            font-size: 16px; 
            font-weight: 600; 
            cursor: pointer; 
            margin: 10px;
            text-decoration: none;
            display: inline-block;
            transition: transform 0.3s ease;
        }
        
        .btn:hover { transform: translateY(-2px); }
        
        .domain-info {
            background: rgba(255,255,255,0.1);
            padding: 20px;
            border-radius: 12px;
            margin-top: 40px;
            max-width: 600px;
        }
    </style>
</head>
<body>
    <div class="logo">
        <div style="font-size: 24px;">WSS</div>
        <div style="font-size: 16px; opacity: 0.9;">+13</div>
    </div>
    
    <h1>🌊 WSS+13 Online na Digital Ocean!</h1>
    <p>WebSmart Sistema - Transformando dores operacionais em soluções automatizadas</p>
    
    <div>
        <a href="/api/status" class="btn">📡 Status da API</a>
        <a href="/api/templates" class="btn">📋 Ver Templates</a>
        <a href="https://n8n.ws13.com.br" class="btn">🔧 N8N Workflows</a>
    </div>
    
    <div class="domain-info">
        <h3>🌐 Informações do Sistema</h3>
        <p><strong>Domínio:</strong> \${domain}</p>
        <p><strong>Protocolo:</strong> \${protocol.toUpperCase()}</p>
        <p><strong>Servidor:</strong> Digital Ocean</p>
        <p><strong>Status:</strong> ✅ Online e Funcionando</p>
        <p><strong>Desenvolvedor:</strong> Marcos Sea</p>
        <p><strong>Templates Disponíveis:</strong> \${templates.length}</p>
    </div>
</body>
</html>
    \`);
});

// API de status
app.get('/api/status', (req, res) => {
    res.json({
        status: 'online',
        service: 'WSS+13 - WebSmart Sistema',
        version: '1.0.0',
        developer: 'Marcos Sea',
        platform: 'Digital Ocean',
        domain: req.get('host'),
        timestamp: new Date().toISOString(),
        templates_available: templates.length,
        uptime: process.uptime()
    });
});

// API de templates
app.get('/api/templates', (req, res) => {
    res.json({
        total: templates.length,
        templates: templates
    });
});

// Health check
app.get('/health', (req, res) => {
    res.status(200).json({ 
        status: 'healthy', 
        timestamp: new Date().toISOString(),
        uptime: process.uptime()
    });
});

// Iniciar servidor
app.listen(PORT, '0.0.0.0', () => {
    console.log(\`🌊 WSS+13 rodando na porta \${PORT}\`);
});
SERVER_EOF

# 9. Instalar PM2 para produção
log_info "Configurando PM2..."
sudo npm install -g pm2
pm2 start server.js --name "wss13"
pm2 startup
pm2 save
log_success "PM2 configurado!"

# 10. Configurar Nginx
log_info "Configurando Nginx..."
sudo tee /etc/nginx/sites-available/wss13 << 'NGINX_EOF'
server {
    listen 80;
    server_name ws13.com.br www.ws13.com.br;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

server {
    listen 80;
    server_name api.ws13.com.br;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

server {
    listen 80;
    server_name n8n.ws13.com.br;
    
    location / {
        proxy_pass http://localhost:5678;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
NGINX_EOF

# 11. Ativar site
sudo ln -s /etc/nginx/sites-available/wss13 /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
log_success "Nginx configurado!"

# 12. Mostrar informações finais
log_success "Deploy concluído!"
echo ""
echo "🌊 WSS+13 - Deploy Completo!"
echo "================================"
echo "📍 Servidor: Digital Ocean"
echo "🌐 Domínio: ws13.com.br"
echo "📡 API: http://$(curl -s ifconfig.me):3000"
echo "🔧 PM2: pm2 status"
echo "📝 Logs: pm2 logs wss13"
echo ""
echo "📋 Próximos passos:"
echo "1. Configurar DNS no painel da Digital Ocean"
echo "2. Apontar ws13.com.br para IP: $(curl -s ifconfig.me)"
echo "3. Configurar SSL: sudo certbot --nginx -d ws13.com.br"
echo ""
log_success "Sistema WSS+13 pronto para produção!"
