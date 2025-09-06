#!/bin/bash
# setup-wss13-system-complete.sh

echo "🏗️ Criando sistema WSS+13 completo..."

# Criar estrutura local de templates
mkdir -p ~/wss13-templates/{crm,sheets,email,ai,automation,ecommerce}

# Simular base de templates com categorias reais
cat > ~/wss13-templates/template-database.json << 'EOF'
{
  "templates": {
    "crm_integration": {
      "name": "CRM Integration Master",
      "category": "crm",
      "pain_points": ["crm desorganizado", "leads perdidos", "vendas manuais"],
      "roi_potential": 8,
      "complexity": "media",
      "trial_limitations": {
        "max_executions": 50,
        "trial_days": 7,
        "disabled_features": ["external_webhooks"]
      }
    },
    "sheets_automation": {
      "name": "Google Sheets Automation Pro",
      "category": "sheets",
      "pain_points": ["planilhas manuais", "copiar dados", "sincronização"],
      "roi_potential": 9,
      "complexity": "baixa",
      "trial_limitations": {
        "max_executions": 100,
        "trial_days": 14,
        "disabled_features": ["advanced_formulas"]
      }
    },
    "email_marketing": {
      "name": "Email Marketing Automation",
      "category": "email",
      "pain_points": ["email manual", "campanhas", "follow-up"],
      "roi_potential": 7,
      "complexity": "media",
      "trial_limitations": {
        "max_executions": 30,
        "trial_days": 7,
        "disabled_features": ["bulk_sending"]
      }
    },
    "ai_chatbot": {
      "name": "AI Customer Support Bot",
      "category": "ai",
      "pain_points": ["atendimento manual", "chatbot", "suporte"],
      "roi_potential": 10,
      "complexity": "alta",
      "trial_limitations": {
        "max_executions": 25,
        "trial_days": 5,
        "disabled_features": ["custom_training"]
      }
    },
    "ecommerce_automation": {
      "name": "E-commerce Order Processing",
      "category": "ecommerce",
      "pain_points": ["pedidos manuais", "estoque", "fulfillment"],
      "roi_potential": 8,
      "complexity": "media",
      "trial_limitations": {
        "max_executions": 75,
        "trial_days": 10,
        "disabled_features": ["inventory_sync"]
      }
    }
  }
}
EOF

echo "✅ Base de templates criada!"
