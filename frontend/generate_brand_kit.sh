#!/bin/bash
# Script para gerar kit completo da marca WSS+13

echo "🚀 Gerando Kit de Marca WSS+13..."

# Criar template HTML para preview
cat > preview_logos.html << 'HTML_EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WSS+13 Brand Kit Preview</title>
    <style>
        body { 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: #f5f5f7;
            margin: 0;
            padding: 40px;
        }
        .container { max-width: 1200px; margin: 0 auto; }
        .header { text-align: center; margin-bottom: 50px; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px; }
        .logo-card { 
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            text-align: center;
        }
        .logo-main {
            width: 200px;
            height: 200px;
            background: linear-gradient(135deg, #007aff 0%, #0056cc 100%);
            border-radius: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: white;
            margin: 0 auto 20px;
            box-shadow: 0 20px 40px rgba(0, 122, 255, 0.3);
        }
        .logo-wss { font-size: 36px; font-weight: 700; letter-spacing: -1px; margin-bottom: -5px; }
        .logo-plus { font-size: 24px; font-weight: 300; letter-spacing: 1px; }
        .logo-white {
            background: white;
            border: 2px solid #e5e5e7;
        }
        .logo-white .logo-wss, .logo-white .logo-plus { color: #007aff; }
        .banner {
            width: 100%;
            height: 120px;
            background: linear-gradient(135deg, #007aff 0%, #0056cc 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            position: relative;
            overflow: hidden;
        }
        .banner::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 200px;
            height: 100%;
            background: rgba(255,255,255,0.1);
            transform: skewX(-15deg);
        }
        .banner-content { z-index: 1; text-align: center; }
        .banner-logo { font-size: 28px; font-weight: 700; margin-bottom: 5px; }
        .banner-tagline { font-size: 14px; opacity: 0.9; }
        .favicon {
            width: 64px;
            height: 64px;
            background: linear-gradient(135deg, #007aff 0%, #0056cc 100%);
            border-radius: 12px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: white;
            margin: 0 auto 20px;
        }
        .favicon .logo-wss { font-size: 16px; font-weight: 700; margin-bottom: -2px; }
        .favicon .logo-plus { font-size: 12px; font-weight: 300; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>WSS+13 Brand Kit</h1>
            <p>WebSmart Sistema - Kit Completo de Identidade Visual</p>
        </div>
        
        <div class="grid">
            <!-- Logo Principal -->
            <div class="logo-card">
                <h3>Logo Principal (1024x1024px)</h3>
                <div class="logo-main">
                    <div class="logo-wss">WSS</div>
                    <div class="logo-plus">+13</div>
                </div>
                <p>Fundo gradiente azul</p>
            </div>
            
            <!-- Logo WhatsApp -->
            <div class="logo-card">
                <h3>Logo WhatsApp (500x500px)</h3>
                <div class="logo-main logo-white">
                    <div class="logo-wss">WSS</div>
                    <div class="logo-plus">+13</div>
                </div>
                <p>Fundo branco, logo azul</p>
            </div>
            
            <!-- Banner LinkedIn -->
            <div class="logo-card">
                <h3>Banner LinkedIn (1584x396px)</h3>
                <div class="banner">
                    <div class="banner-content">
                        <div class="banner-logo">WSS+13</div>
                        <div class="banner-tagline">WebSmart Sistema</div>
                    </div>
                </div>
                <p>Banner profissional</p>
            </div>
            
            <!-- Capa Facebook -->
            <div class="logo-card">
                <h3>Capa Facebook (820x312px)</h3>
                <div class="banner" style="height: 100px;">
                    <div class="banner-content">
                        <div class="banner-logo">WSS+13</div>
                        <div class="banner-tagline">Soluções Inteligentes</div>
                    </div>
                </div>
                <p>Capa para redes sociais</p>
            </div>
            
            <!-- Post Instagram -->
            <div class="logo-card">
                <h3>Post Instagram (1080x1080px)</h3>
                <div class="logo-main">
                    <div class="logo-wss">WSS</div>
                    <div class="logo-plus">+13</div>
                </div>
                <p>Post quadrado para feed</p>
            </div>
            
            <!-- Favicon -->
            <div class="logo-card">
                <h3>Favicon (512x512px)</h3>
                <div class="favicon">
                    <div class="logo-wss">WSS</div>
                    <div class="logo-plus">+13</div>
                </div>
                <p>Ícone para navegador</p>
            </div>
        </div>
    </div>
</body>
</html>
HTML_EOF

echo "✅ Template HTML criado: preview_logos.html"

# Criar arquivo de especificações
cat > brand_specs.md << 'SPECS_EOF'
# WSS+13 Brand Specifications

## Cores Oficiais
- **Azul Principal:** #007aff
- **Azul Escuro:** #0056cc
- **Branco:** #ffffff
- **Cinza Claro:** #f5f5f7

## Tipografia
- **Fonte Principal:** -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif
- **WSS:** Font-weight 700 (Bold)
- **+13:** Font-weight 300 (Light)

## Dimensões dos Assets
1. **Logo Principal:** 1024x1024px
2. **Logo WhatsApp:** 500x500px
3. **Banner LinkedIn:** 1584x396px
4. **Capa Facebook:** 820x312px
5. **Post Instagram:** 1080x1080px
6. **Favicon:** 512x512px

## Uso das Cores
- **Fundo Gradiente:** linear-gradient(135deg, #007aff 0%, #0056cc 100%)
- **Texto sobre azul:** Branco (#ffffff)
- **Logo sobre branco:** Azul principal (#007aff)
SPECS_EOF

echo "✅ Especificações criadas: brand_specs.md"

# Criar script para converter HTML em PNG (usando wkhtmltopdf/wkhtmltoimage se disponível)
cat > convert_to_png.sh << 'CONVERT_EOF'
#!/bin/bash
# Script para converter HTML em PNG

echo "🖼️ Para converter HTML em PNG, instale:"
echo "sudo apt install wkhtmltopdf"
echo ""
echo "Depois execute:"
echo "wkhtmltoimage --width 1024 --height 1024 preview_logos.html logos/logo_main.png"
echo "wkhtmltoimage --width 500 --height 500 preview_logos.html logos/logo_whatsapp.png"
CONVERT_EOF

chmod +x convert_to_png.sh

echo "✅ Script de conversão criado: convert_to_png.sh"
echo ""
echo "🎉 Kit de marca WSS+13 gerado com sucesso!"
echo "📂 Arquivos criados:"
echo "   - preview_logos.html (Preview visual)"
echo "   - brand_specs.md (Especificações)"
echo "   - convert_to_png.sh (Script de conversão)"
echo ""
echo "🌐 Para visualizar: firefox preview_logos.html"
