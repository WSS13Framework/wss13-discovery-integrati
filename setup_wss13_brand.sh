#!/usr/bin/env bash
set -euo pipefail

BRAND_DIR="wss13-brand"
LOGOS_DIR="$BRAND_DIR/assets/logos"
ICONS_DIR="$BRAND_DIR/assets/icons"
CSS_DIR="$BRAND_DIR/css"

echo "==> Criando estrutura de pastas..."
mkdir -p "$LOGOS_DIR" "$ICONS_DIR" "$CSS_DIR"

ensure_dep() {
  local bin="$1"
  local pkg="$2"
  if ! command -v "$bin" >/dev/null 2>&1; then
    echo "==> Dependência '$bin' não encontrada. Instalando pacote '$pkg'..."
    sudo apt update
    sudo apt install -y "$pkg"
  fi
}

echo "==> Verificando dependências (Inkscape e ImageMagick)..."
ensure_dep inkscape inkscape

# Detecta o comando do ImageMagick
CONVERT_CMD=""
if command -v magick >/dev/null 2>&1; then
  CONVERT_CMD="magick convert"
elif command -v convert >/dev/null 2>&1; then
  CONVERT_CMD="convert"
else
  echo "==> ImageMagick não encontrado. Instalando..."
  sudo apt update
  sudo apt install -y imagemagick
  if command -v magick >/dev/null 2>&1; then
    CONVERT_CMD="magick convert"
  else
    CONVERT_CMD="convert"
  fi
fi

echo "==> Escrevendo SVG do logo principal (512x512, gradiente azul, WSS +13)..."
cat > "$LOGOS_DIR/wss13-logo.svg" << 'SVG'
<?xml version="1.0" encoding="UTF-8"?>
<svg width="512" height="512" viewBox="0 0 512 512" role="img" aria-label="WSS+13 - WebSmart Sistema" xmlns="http://www.w3.org/2000/svg">
  <title>WSS+13 - WebSmart Sistema</title>
  <desc>Marca quadrada com cantos arredondados, gradiente azul e textos "WSS" em cima e "+13" embaixo.</desc>
  <defs>
    <linearGradient id="g1" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#007aff"/>
      <stop offset="100%" stop-color="#0056cc"/>
    </linearGradient>
  </defs>
  <rect x="16" y="16" width="480" height="480" rx="64" fill="url(#g1)"/>
  <g fill="#ffffff" font-family="-apple-system,system-ui,'Segoe UI',Roboto,Ubuntu,Cantarell,'Noto Sans',sans-serif" font-weight="800" text-anchor="middle">
    <text x="256" y="220" font-size="160" letter-spacing="4">WSS</text>
    <text x="256" y="380" font-size="140" letter-spacing="2">+13</text>
  </g>
</svg>
SVG

echo "==> Escrevendo SVG do logo branco (para fundos escuros, fundo transparente)..."
cat > "$LOGOS_DIR/wss13-logo-white.svg" << 'SVG'
<?xml version="1.0" encoding="UTF-8"?>
<svg width="512" height="512" viewBox="0 0 512 512" role="img" aria-label="WSS+13 - marca branca" xmlns="http://www.w3.org/2000/svg">
  <title>WSS+13 - Marca Branca</title>
  <desc>Marca em branco para fundos escuros: contorno arredondado e textos em branco.</desc>
  <rect x="16" y="16" width="480" height="480" rx="64" fill="none" stroke="#ffffff" stroke-width="22"/>
  <g fill="#ffffff" font-family="-apple-system,system-ui,'Segoe UI',Roboto,Ubuntu,Cantarell,'Noto Sans',sans-serif" font-weight="800" text-anchor="middle">
    <text x="256" y="220" font-size="160" letter-spacing="4">WSS</text>
    <text x="256" y="380" font-size="140" letter-spacing="2">+13</text>
  </g>
</svg>
SVG

echo "==> Escrevendo SVG do logo horizontal (ícone + texto)..."
cat > "$LOGOS_DIR/wss13-logo-horizontal.svg" << 'SVG'
<?xml version="1.0" encoding="UTF-8"?>
<svg width="1024" height="256" viewBox="0 0 1024 256" role="img" aria-label="WSS+13 - logo horizontal" xmlns="http://www.w3.org/2000/svg">
  <title>WSS+13 - Logo Horizontal</title>
  <defs>
    <linearGradient id="g1" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#007aff"/>
      <stop offset="100%" stop-color="#0056cc"/>
    </linearGradient>
  </defs>
  <!-- Ícone quadrado com cantos arredondados -->
  <rect x="16" y="30" width="196" height="196" rx="28" fill="url(#g1)"/>
  <!-- Letras dentro do ícone -->
  <g fill="#ffffff" font-family="-apple-system,system-ui,'Segoe UI',Roboto,Ubuntu,Cantarell,'Noto Sans',sans-serif" font-weight="800" text-anchor="middle">
    <text x="114" y="120" font-size="70" letter-spacing="3">WSS</text>
    <text x="114" y="185" font-size="64" letter-spacing="1">+13</text>
  </g>
  <!-- Texto do lado direito -->
  <g font-family="-apple-system,system-ui,'Segoe UI',Roboto,Ubuntu,Cantarell,'Noto Sans',sans-serif" font-weight="800" fill="#111827">
    <text x="240" y="150" font-size="124" letter-spacing="2">WSS+13</text>
  </g>
</svg>
SVG

echo "==> Escrevendo CSS de marca..."
cat > "$CSS_DIR/brand.css" << 'CSS'
:root {
  --wss-primary: #007aff;
  --wss-primary-dark: #0056cc;
  --wss-bg: #0b1220;
  --wss-text: #111827;
  --wss-muted: #6b7280;
  --wss-white: #ffffff;
  --wss-shadow: 0 10px 25px rgba(0,0,0,0.12);
  --wss-radius: 16px;
  --wss-transition: 220ms cubic-bezier(.2,.8,.2,1);
}

@media (prefers-color-scheme: dark) {
  :root {
    --wss-text: #e5e7eb;
    --wss-bg: #0b1220;
  }
}

* { box-sizing: border-box; }
html, body { height: 100%; }
body {
  margin: 0; padding: 0;
  font-family: -apple-system, system-ui, "Segoe UI", Roboto, Ubuntu, Cantarell, "Noto Sans", sans-serif;
  color: var(--wss-text);
  background: linear-gradient(180deg, #0f172a 0%, #0b1220 100%);
}

/* Utilitários */
.container { max-width: 1100px; margin: 0 auto; padding: 32px; }
.grid { display: grid; gap: 24px; }
.grid-2 { grid-template-columns: repeat(2, minmax(0, 1fr)); }
@media (max-width: 768px) { .grid-2 { grid-template-columns: 1fr; } }
.card {
  background: rgba(255,255,255,0.06);
  border: 1px solid rgba(255,255,255,0.08);
  backdrop-filter: blur(8px);
  border-radius: var(--wss-radius);
  padding: 20px;
  box-shadow: var(--wss-shadow);
}

/* Logos */
.logo {
  display: inline-block;
  border-radius: 12px;
  transition: transform var(--wss-transition), box-shadow var(--wss-transition), filter var(--wss-transition);
  will-change: transform;
}
.logo:hover {
  transform: translateY(-2px) scale(1.02);
  box-shadow: 0 14px 36px rgba(0,0,0,0.18);
}

/* Tamanhos sugeridos */
.logo--sm { width: 64px; height: auto; }
.logo--md { width: 128px; height: auto; }
.logo--lg { width: 256px; height: auto; }
.logo--xl { width: clamp(200px, 40vw, 512px); height: auto; }

/* Efeito brilho suave no hover (apenas em imagens) */
.logo--shine {
  position: relative;
  overflow: hidden;
}
.logo--shine::after {
  content: "";
  position: absolute;
  top: -100%; left: -150%;
  width: 120%; height: 300%;
  transform: rotate(25deg);
  background: linear-gradient(90deg, rgba(255,255,255,0.0) 0%, rgba(255,255,255,0.15) 50%, rgba(255,255,255,0.0) 100%);
  transition: transform 800ms ease;
}
.logo--shine:hover::after {
  transform: translateX(180%) rotate(25deg);
}

/* Texto */
.h1 {
  font-size: clamp(28px, 5vw, 44px);
  margin: 0 0 8px 0;
  color: #e5e7eb;
}
.p {
  color: var(--wss-muted);
  font-size: clamp(14px, 2.2vw, 18px);
  margin: 0 0 20px 0;
}

/* Botão */
.btn {
  display: inline-flex; align-items: center; gap: 10px;
  background: linear-gradient(135deg, var(--wss-primary), var(--wss-primary-dark));
  color: var(--wss-white);
  text-decoration: none;
  border: none;
  padding: 12px 18px;
  border-radius: 12px;
  font-weight: 700;
  transition: transform var(--wss-transition), box-shadow var(--wss-transition), filter var(--wss-transition);
}
.btn:hover { transform: translateY(-1px); filter: brightness(1.05) saturate(1.05); }
.btn:active { transform: translateY(0); }

/* Responsividade extra para as artes */
.logo-row {
  display: flex; flex-wrap: wrap; gap: 16px; align-items: center;
}
.logo-box {
  display: grid; place-items: center;
  background: rgba(255,255,255,0.03);
  border: 1px dashed rgba(255,255,255,0.12);
  border-radius: 14px;
  padding: 16px;
}
CSS

echo "==> Escrevendo manifest PWA (site.webmanifest)..."
cat > "$BRAND_DIR/site.webmanifest" << 'JSON'
{
  "name": "WSS+13 - WebSmart Sistema",
  "short_name": "WSS+13",
  "start_url": "/",
  "scope": "/",
  "display": "standalone",
  "background_color": "#0056cc",
  "theme_color": "#0056cc",
  "icons": [
    {
      "src": "assets/icons/android-chrome-192x192.png",
      "sizes": "192x192",
      "type": "image/png",
      "purpose": "any"
    },
    {
      "src": "assets/icons/android-chrome-512x512.png",
      "sizes": "512x512",
      "type": "image/png",
      "purpose": "any maskable"
    }
  ]
}
JSON

echo "==> Escrevendo HTML de exemplo..."
cat > "$BRAND_DIR/index.html" << 'HTML'
<!doctype html>
<html lang="pt-BR">
<head>
  <meta charset="utf-8">
  <title>WSS+13 - Identidade Visual</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="theme-color" content="#0056cc">
  <link rel="manifest" href="site.webmanifest">
  <link rel="icon" type="image/x-icon" href="assets/icons/favicon.ico">
  <link rel="apple-touch-icon" sizes="180x180" href="assets/icons/apple-touch-icon.png">
  <link rel="icon" type="image/png" sizes="192x192" href="assets/icons/android-chrome-192x192.png">
  <link rel="icon" type="image/png" sizes="512x512" href="assets/icons/android-chrome-512x512.png">
  <link rel="stylesheet" href="css/brand.css">
</head>
<body>
  <div class="container">
    <h1 class="h1">WSS+13 (WebSmart Sistema)</h1>
    <p class="p">Pacote de marca completo: logos (principal, branco, horizontal), favicons, manifest, CSS e HTML de exemplo.</p>

    <div class="grid grid-2">
      <div class="card">
        <h2 class="h1" style="font-size:28px;">Logo principal</h2>
        <div class="logo-box">
          <img class="logo logo--xl logo--shine" src="assets/logos/wss13-logo-512.png" alt="Logo WSS+13 principal">
        </div>
        <div class="logo-row" style="margin-top:12px;">
          <a class="btn" href="assets/logos/wss13-logo.svg" download>Baixar SVG</a>
          <a class="btn" href="assets/logos/wss13-logo-512.png" download>Baixar PNG 512</a>
        </div>
      </div>

      <div class="card">
        <h2 class="h1" style="font-size:28px;">Logo branco (fundo escuro)</h2>
        <div class="logo-box" style="background:#0b1220;">
          <img class="logo logo--xl logo--shine" src="assets/logos/wss13-logo-white-512.png" alt="Logo WSS+13 branco">
        </div>
        <div class="logo-row" style="margin-top:12px;">
          <a class="btn" href="assets/logos/wss13-logo-white.svg" download>Baixar SVG branco</a>
          <a class="btn" href="assets/logos/wss13-logo-transparent-512.png" download>PNG transparente</a>
        </div>
      </div>

      <div class="card">
        <h2 class="h1" style="font-size:28px;">Logo horizontal</h2>
        <div class="logo-box" style="background:#fff;">
          <img class="logo logo--lg logo--shine" src="assets/logos/wss13-logo-horizontal.png" alt="Logo WSS+13 horizontal">
        </div>
        <div class="logo-row" style="margin-top:12px;">
          <a class="btn" href="assets/logos/wss13-logo-horizontal.svg" download>Baixar SVG horizontal</a>
          <a class="btn" href="assets/logos/wss13-logo-horizontal.png" download>Baixar PNG</a>
        </div>
      </div>

      <div class="card">
        <h2 class="h1" style="font-size:28px;">Favicons & Manifest</h2>
        <ul class="p">
          <li>favicon.ico (16/32/48)</li>
          <li>apple-touch-icon.png (180x180)</li>
          <li>android-chrome-192x192.png</li>
          <li>android-chrome-512x512.png</li>
        </ul>
        <div class="logo-row">
          <a class="btn" href="site.webmanifest" download>site.webmanifest</a>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
HTML

echo "==> Exportando PNGs a partir dos SVGs (via Inkscape)..."
# Logo principal
inkscape "$LOGOS_DIR/wss13-logo.svg" -o "$LOGOS_DIR/wss13-logo-512.png" -w 512 -h 512

# Logo branco (PNG transparente)
inkscape "$LOGOS_DIR/wss13-logo-white.svg" -o "$LOGOS_DIR/wss13-logo-white-512.png" -w 512 -h 512
cp "$LOGOS_DIR/wss13-logo-white-512.png" "$LOGOS_DIR/wss13-logo-transparent-512.png"

# Logo horizontal
inkscape "$LOGOS_DIR/wss13-logo-horizontal.svg" -o "$LOGOS_DIR/wss13-logo-horizontal.png" -w 1024

echo "==> Gerando ícones (Android, Apple e favicon)..."
# Android
inkscape "$LOGOS_DIR/wss13-logo.svg" -o "$ICONS_DIR/android-chrome-512x512.png" -w 512 -h 512
inkscape "$LOGOS_DIR/wss13-logo.svg" -o "$ICONS_DIR/android-chrome-192x192.png" -w 192 -h 192

# Apple touch (PNG 180x180)
inkscape "$LOGOS_DIR/wss13-logo.svg" -o "$ICONS_DIR/apple-touch-icon.png" -w 180 -h 180

# Favicon .ico (16, 32, 48) a partir do PNG 512
$CONVERT_CMD "$ICONS_DIR/android-chrome-512x512.png" -resize 48x48 "$ICONS_DIR/favicon-48.png"
$CONVERT_CMD "$ICONS_DIR/android-chrome-512x512.png" -resize 32x32 "$ICONS_DIR/favicon-32.png"
$CONVERT_CMD "$ICONS_DIR/android-chrome-512x512.png" -resize 16x16 "$ICONS_DIR/favicon-16.png"
$CONVERT_CMD "$ICONS_DIR/favicon-16.png" "$ICONS_DIR/favicon-32.png" "$ICONS_DIR/favicon-48.png" "$ICONS_DIR/favicon.ico"
rm -f "$ICONS_DIR/favicon-16.png" "$ICONS_DIR/favicon-32.png" "$ICONS_DIR/favicon-48.png"

echo "==> Estrutura criada:"
if command -v tree >/dev/null 2>&1; then
  tree -I ".git" "$BRAND_DIR"
else
  find "$BRAND_DIR" -maxdepth 3 -type f -print | sed "s#^#$PWD/#"
fi

echo
echo "Pronto! Abra $BRAND_DIR/index.html no navegador para ver o resultado."
echo "Dica: sirva localmente com 'xdg-open $BRAND_DIR/index.html' ou use um servidor estático."
