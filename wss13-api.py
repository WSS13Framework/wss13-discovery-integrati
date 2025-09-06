#!/usr/bin/env python3
# wss13-api.py - API para integração com N8N

from flask import Flask, request, jsonify
import json
import sys
import os

# Adicionar o diretório atual ao path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

# Importar a classe diretamente do arquivo
exec(open('wss13-intelligent-matcher.py').read())

app = Flask(__name__)

@app.route('/api/analyze-user', methods=['POST'])
def analyze_user():
    """Endpoint para analisar usuário e retornar template"""
    try:
        matcher = WSS13IntelligentMatcher()
        user_data = request.json
        
        # Analisar e encontrar templates
        matches = matcher.analyze_user_pain(user_data)
        best_match = matches[0] if matches else None
        
        if not best_match:
            return jsonify({'error': 'Nenhum template encontrado'}), 404
        
        template_id, match_data = best_match
        trial_config = matcher.prepare_trial_template(template_id, user_data)
        
        response = {
            'user': user_data,
            'recommended_template': {
                'id': template_id,
                'name': match_data['template']['name'],
                'category': match_data['template']['category'],
                'score': match_data['score'],
                'reasons': match_data['match_reasons']
            },
            'trial_config': trial_config,
            'email_data': {
                'to': user_data.get('email'),
                'subject': f"🎯 Seu Template Personalizado WSS+13 - {match_data['template']['name']}",
                'template_download_url': f"https://wss13.com.br/download/{template_id}",
                'trial_dashboard_url': f"https://wss13.com.br/trial/{template_id}"
            }
        }
        
        return jsonify(response)
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/test', methods=['GET'])
def test():
    """Endpoint de teste"""
    return jsonify({'status': 'WSS+13 API funcionando!', 'version': '1.0'})

if __name__ == '__main__':
    print("🚀 Iniciando WSS+13 API...")
    print("📡 Endpoints disponíveis:")
    print("   POST /api/analyze-user - Analisar usuário e retornar template")
    print("   GET  /api/test - Teste da API")
    print("�� Acesse: http://localhost:5000")
    
    app.run(debug=True, host='0.0.0.0', port=5000)
