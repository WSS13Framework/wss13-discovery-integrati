#!/usr/bin/env python3
import http.server
import socketserver
import json
import sys

# Porta configurável via argumento ou padrão
PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 5001

def analyze_wss13(data):
    """Simula análise WSS+13 completa"""
    user_name = data.get('user_name', 'Usuário')
    pain_point = data.get('pain_point', 'Dor não especificada')
    email = data.get('email', 'usuario@empresa.com')
    
    # Template recomendado baseado na dor
    if 'excel' in pain_point.lower() or 'sheets' in pain_point.lower():
        template = {
            'name': 'Google Sheets Automation Pro',
            'id': 'sheets_automation',
            'score': 1.9,
            'roi_potential': 9,
            'complexity': 'baixa'
        }
    elif 'suporte' in pain_point.lower() or 'atendimento' in pain_point.lower():
        template = {
            'name': 'AI Customer Support Bot',
            'id': 'support_bot',
            'score': 1.0,
            'roi_potential': 10,
            'complexity': 'alta'
        }
    else:
        template = {
            'name': 'CRM Integration Master',
            'id': 'crm_integration',
            'score': 0.8,
            'roi_potential': 8,
            'complexity': 'media'
        }
    
    # Gera resultado completo
    result = {
        'user_analysis': {
            'name': user_name,
            'pain_point': pain_point,
            'email': email
        },
        'recommended_templates': [
            template,
            {
                'name': 'AI Customer Support Bot',
                'id': 'support_bot',
                'score': 1.0,
                'roi_potential': 10,
                'complexity': 'alta'
            },
            {
                'name': 'CRM Integration Master',
                'id': 'crm_integration',
                'score': 0.8,
                'roi_potential': 8,
                'complexity': 'media'
            }
        ],
        'trial_configuration': {
            'template_id': template['id'],
            'template_name': template['name'],
            'duration_days': 7,
            'executions_limit': 50,
            'conversion_probability': 0.75
        },
        'email_data': {
            'to': email,
            'subject': f"🎯 Seu Template Personalizado WSS+13 - {template['name']}",
            'template_id': template['id']
        }
    }
    
    # Print formatado para o console
    print(f"\n🔮 ANÁLISE WSS+13:")
    print(f"Usuário: {user_name}")
    print(f"Dor: {pain_point}")
    print(f"\n📊 TOP 3 TEMPLATES RECOMENDADOS:")
    for i, t in enumerate(result['recommended_templates'][:3], 1):
        print(f"{i}. {t['name']}")
        print(f"   Score: {t['score']}")
        print(f"   ROI Potential: {t['roi_potential']}/10")
        print(f"   Complexidade: {t['complexity']}")
        print(f"   Motivos: ")
    
    print(f"\n🧪 CONFIGURAÇÃO DE TRIAL:")
    print(f"Template: {result['trial_configuration']['template_name']}")
    print(f"Duração: {result['trial_configuration']['duration_days']} dias")
    print(f"Execuções: {result['trial_configuration']['executions_limit']}")
    print(f"Probabilidade conversão: {result['trial_configuration']['conversion_probability']*100}%")
    
    print(f"\n📧 DADOS PARA EMAIL:")
    print(f"Para: {result['email_data']['to']}")
    print(f"Assunto: {result['email_data']['subject']}")
    print(f"Template ID: {result['email_data']['template_id']}")
    
    return result

class WSS13Handler(http.server.SimpleHTTPRequestHandler):
    def do_POST(self):
        if self.path == '/analyze':
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            
            try:
                data = json.loads(post_data)
                result = analyze_wss13(data)
                
                self.send_response(200)
                self.send_header('Content-type', 'application/json')
                self.send_header('Access-Control-Allow-Origin', '*')
                self.end_headers()
                self.wfile.write(json.dumps(result, indent=2).encode())
            except Exception as e:
                self.send_response(500)
                self.send_header('Content-type', 'application/json')
                self.end_headers()
                error_msg = {'error': str(e)}
                self.wfile.write(json.dumps(error_msg).encode())
        else:
            self.send_response(404)
            self.end_headers()
    
    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        self.end_headers()
    
    def do_GET(self):
        if self.path == '/':
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            html_content = '''
            <!DOCTYPE html>
            <html>
            <head>
                <title>WSS+13 Discovery API</title>
                <style>
                    body { font-family: Arial, sans-serif; margin: 40px; }
                    .endpoint { background: #f5f5f5; padding: 10px; margin: 10px 0; border-radius: 5px; }
                    code { background: #333; color: #fff; padding: 2px 5px; border-radius: 3px; }
                </style>
            </head>
            <body>
                <h1>🔮 WSS+13 Discovery Integration API</h1>
                <p>API para análise de descoberta WSS+13</p>
                
                <div class="endpoint">
                    <h3>POST /analyze</h3>
                    <p>Analisa dados do usuário e retorna templates recomendados</p>
                    <p>Exemplo de payload:</p>
                    <pre>
{
  "user_name": "João Silva",
  "email": "joao@empresa.com",
  "pain_point": "Gastamos muito tempo copiando dados entre planilhas"
}
                    </pre>
                </div>
            </body>
            </html>
            '''
            self.wfile.write(html_content.encode())
        else:
            super().do_GET()

if __name__ == "__main__":
    # Testa dados de exemplo
    test_data = {
        'user_name': 'João Silva',
        'email': 'joao@empresa.com',
        'pain_point': 'Gastamos muito tempo copiando dados entre planilhas do Excel e Google Sheets'
    }
    
    analyze_wss13(test_data)
    
    # Tenta criar o servidor com tratamento de erro
    try:
        with socketserver.TCPServer(("", PORT), WSS13Handler) as httpd:
            print(f"\n✅ Servidor WSS+13 rodando na porta {PORT}")
            print(f"🌐 Acesse: http://localhost:{PORT}")
            print(f"📡 Endpoint: POST http://localhost:{PORT}/analyze")
            print("\n[Pressione Ctrl+C para parar]")
            httpd.serve_forever()
    except OSError as e:
        if "Address already in use" in str(e):
            print(f"\n❌ Erro: Porta {PORT} já está em uso!")
            print(f"💡 Tente uma das opções:")
            print(f"   1. Execute: sudo lsof -i :{PORT}")
            print(f"   2. Mate o processo: sudo kill -9 [PID]")
            print(f"   3. Use outra porta: python3 {sys.argv[0]} 5001")
            print(f"   4. Ou tente: python3 {sys.argv[0]} 8000")
        else:
            print(f"❌ Erro ao iniciar servidor: {e}")
    except KeyboardInterrupt:
        print("\n\n👋 Servidor encerrado!")