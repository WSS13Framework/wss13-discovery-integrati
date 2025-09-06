#!/usr/bin/env python3
# Sistema de Matching WSS+13

import json
import os
from pathlib import Path

class WSS13TemplateMatcher:
    def __init__(self):
        self.base_path = "/root/n8n-templates-collection/"
        self.categories = {
            "planilhas": {
                "keywords": ["planilha", "excel", "sheets", "dados", "tabela"],
                "paths": ["*[Ss]heet*", "*[Ee]xcel*", "*Google*"],
                "priority": 1.0
            },
            "crm": {
                "keywords": ["crm", "cliente", "vendas", "lead", "contato"],
                "paths": ["*CRM*", "*[Ss]ales*", "*[Cc]ustomer*"],
                "priority": 1.2
            },
            "email": {
                "keywords": ["email", "marketing", "campanha", "newsletter"],
                "paths": ["*[Ee]mail*", "*[Mm]arketing*", "*[Mm]ail*"],
                "priority": 1.1
            },
            "ia": {
                "keywords": ["ia", "inteligencia", "chatbot", "openai", "gpt"],
                "paths": ["*OpenAI*", "*AI*", "*GPT*", "*chat*"],
                "priority": 1.3
            }
        }
    
    def analyze_pain(self, pain_description):
        """Analisa a dor e encontra categoria"""
        pain_lower = pain_description.lower()
        scores = {}
        
        for category, config in self.categories.items():
            score = 0
            for keyword in config["keywords"]:
                if keyword in pain_lower:
                    score += config["priority"]
            scores[category] = score
        
        # Retorna categoria com maior score
        best_category = max(scores, key=scores.get) if max(scores.values()) > 0 else "geral"
        return best_category, scores[best_category]
    
    def get_templates_for_category(self, category):
        """Retorna templates da categoria"""
        if category not in self.categories:
            return []
        
        templates = []
        for path_pattern in self.categories[category]["paths"]:
            # Simular busca (você vai implementar com find real)
            templates.append({
                "name": f"Template {category.title()}",
                "path": f"{self.base_path}{path_pattern}",
                "category": category
            })
        
        return templates[:3]  # Top 3

# Teste
matcher = WSS13TemplateMatcher()
pain = "Gastamos muito tempo copiando dados entre planilhas"
category, score = matcher.analyze_pain(pain)
templates = matcher.get_templates_for_category(category)

print(f"Dor: {pain}")
print(f"Categoria: {category} (Score: {score})")
print("Templates sugeridos:")
for t in templates:
    print(f"- {t['name']}")
