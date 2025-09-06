#!/usr/bin/env python3
# wss13-intelligent-matcher.py

import json
import re
from datetime import datetime, timedelta

class WSS13IntelligentMatcher:
    def __init__(self):
        self.load_template_database()
        
    def load_template_database(self):
        """Carrega base de templates"""
        try:
            with open('/home/sea/wss13-templates/template-database.json', 'r') as f:
                self.db = json.load(f)
        except:
            # Fallback se arquivo não existir
            self.db = self.create_default_database()
    
    def create_default_database(self):
        """Cria base padrão de templates"""
        return {
            "templates": {
                "sheets_automation": {
                    "name": "Google Sheets Automation Pro",
                    "category": "sheets",
                    "pain_points": ["planilha", "excel", "dados", "manual", "copiar"],
                    "roi_potential": 9,
                    "complexity": "baixa"
                },
                "crm_integration": {
                    "name": "CRM Integration Master", 
                    "category": "crm",
                    "pain_points": ["crm", "cliente", "vendas", "lead", "contato"],
                    "roi_potential": 8,
                    "complexity": "media"
                },
                "ai_chatbot": {
                    "name": "AI Customer Support Bot",
                    "category": "ai", 
                    "pain_points": ["chatbot", "atendimento", "suporte", "ia", "automatico"],
                    "roi_potential": 10,
                    "complexity": "alta"
                },
                "email_automation": {
                    "name": "Email Marketing Automation",
                    "category": "email",
                    "pain_points": ["email", "marketing", "campanha", "newsletter", "follow-up"],
                    "roi_potential": 7,
                    "complexity": "media"
                },
                "ecommerce_automation": {
                    "name": "E-commerce Order Processing",
                    "category": "ecommerce", 
                    "pain_points": ["pedidos", "estoque", "loja", "vendas online", "fulfillment"],
                    "roi_potential": 8,
                    "complexity": "media"
                }
            }
        }
    
    def analyze_user_pain(self, user_data):
        """Analisa dor do usuário e encontra melhor template"""
        pain_text = f"{user_data.get('pain_description', '')} {user_data.get('company_type', '')} {user_data.get('processes', '')}".lower()
        
        template_scores = {}
        
        for template_id, template in self.db['templates'].items():
            score = 0
            
            # Score baseado em palavras-chave
            for keyword in template['pain_points']:
                if keyword in pain_text:
                    score += 2
            
            # Score baseado em ROI potential
            score += template['roi_potential'] * 0.1
            
            # Ajuste por complexidade vs tamanho da empresa
            company_size = user_data.get('company_size', 'pequena')
            if company_size == 'pequena' and template['complexity'] == 'baixa':
                score += 1
            elif company_size == 'grande' and template['complexity'] == 'alta':
                score += 1
            
            template_scores[template_id] = {
                'template': template,
                'score': score,
                'match_reasons': self.get_match_reasons(pain_text, template)
            }
        
        # Retornar top 3 templates
        sorted_templates = sorted(template_scores.items(), 
                                key=lambda x: x[1]['score'], 
                                reverse=True)
        
        return sorted_templates[:3]
    
    def get_match_reasons(self, pain_text, template):
        """Explica por que o template foi escolhido"""
        reasons = []
        for keyword in template['pain_points']:
            if keyword in pain_text:
                reasons.append(f"Resolve problema com {keyword}")
        return reasons
    
    def prepare_trial_template(self, template_id, user_data):
        """Prepara template com limitações de trial"""
        template = self.db['templates'][template_id]
        
        trial_config = {
            'template_name': template['name'],
            'user_email': user_data.get('email'),
            'trial_start': datetime.now().isoformat(),
            'trial_end': (datetime.now() + timedelta(days=7)).isoformat(),
            'limitations': {
                'max_executions': 50,
                'trial_days': 7,
                'features_disabled': ['external_webhooks', 'premium_integrations']
            },
            'tracking': {
                'executions_used': 0,
                'last_execution': None,
                'conversion_probability': self.calculate_conversion_probability(user_data)
            }
        }
        
        return trial_config
    
    def calculate_conversion_probability(self, user_data):
        """Calcula probabilidade de conversão"""
        score = 0.5  # Base 50%
        
        # Empresa maior = maior probabilidade
        if user_data.get('company_size') == 'media':
            score += 0.2
        elif user_data.get('company_size') == 'grande':
            score += 0.3
        
        # Dor específica = maior probabilidade
        if len(user_data.get('pain_description', '')) > 50:
            score += 0.1
        
        # Budget definido = maior probabilidade
        if user_data.get('budget') and user_data.get('budget') != 'nao_sei':
            score += 0.15
        
        return min(score, 0.95)  # Máximo 95%

# Teste do sistema
if __name__ == "__main__":
    matcher = WSS13IntelligentMatcher()
    
    # Simular dados de usuário
    user_data = {
        'name': 'João Silva',
        'email': 'joao@empresa.com',
        'company': 'Tech Solutions',
        'company_size': 'pequena',
        'pain_description': 'Gastamos muito tempo copiando dados entre planilhas do Excel e Google Sheets',
        'processes': 'vendas, financeiro',
        'budget': 'ate_1000'
    }
    
    print("�� ANÁLISE WSS+13:")
    print(f"Usuário: {user_data['name']}")
    print(f"Dor: {user_data['pain_description']}")
    print()
    
    matches = matcher.analyze_user_pain(user_data)
    
    print("📊 TOP 3 TEMPLATES RECOMENDADOS:")
    for i, (template_id, data) in enumerate(matches, 1):
        template = data['template']
        print(f"{i}. {template['name']}")
        print(f"   Score: {data['score']:.1f}")
        print(f"   ROI Potential: {template['roi_potential']}/10")
        print(f"   Complexidade: {template['complexity']}")
        print(f"   Motivos: {', '.join(data['match_reasons'])}")
        print()
    
    # Preparar trial do melhor template
    best_template_id = matches[0][0]
    trial_config = matcher.prepare_trial_template(best_template_id, user_data)
    
    print("🧪 CONFIGURAÇÃO DE TRIAL:")
    print(f"Template: {trial_config['template_name']}")
    print(f"Duração: {trial_config['limitations']['trial_days']} dias")
    print(f"Execuções: {trial_config['limitations']['max_executions']}")
    print(f"Probabilidade conversão: {trial_config['tracking']['conversion_probability']:.1%}")
    
    print("\n📧 DADOS PARA EMAIL:")
    print(f"Para: {user_data['email']}")
    print(f"Assunto: 🎯 Seu Template Personalizado WSS+13 - {trial_config['template_name']}")
    print(f"Template ID: {best_template_id}")
