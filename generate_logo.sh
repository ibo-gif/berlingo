#!/bin/bash

# 🎨 Berlingo Logo Generator
# Скрипт для конвертации SVG логотипа в PNG

echo "🎨 Generating Berlingo Logo..."
echo ""

# Проверка ImageMagick/Inkscape
if command -v convert &> /dev/null; then
    echo "✓ ImageMagick найден"
    echo ""
    echo "Создаю логотип в разных размерах..."
    
    # Размер 512x512 (основной)
    convert -background none logo.svg -resize 512x512 -gravity center -extent 512x512 logo_512.png
    echo "✓ Создан: logo_512.png (512x512)"
    
    # Размер 256x256 (средний)
    convert -background none logo.svg -resize 256x256 -gravity center -extent 256x256 logo_256.png
    echo "✓ Создан: logo_256.png (256x256)"
    
    # Размер 128x128 (маленький)
    convert -background none logo.svg -resize 128x128 -gravity center -extent 128x128 logo_128.png
    echo "✓ Создан: logo_128.png (128x128)"
    
    # Размер 192x192 (приложение Android)
    convert -background none logo.svg -resize 192x192 -gravity center -extent 192x192 ic_launcher.png
    echo "✓ Создан: ic_launcher.png (192x192)"
    
    # С белым фоном для печати
    convert -background white logo.svg -resize 512x512 -gravity center -extent 512x512 logo_white_bg.png
    echo "✓ Создан: logo_white_bg.png (512x512 с белым фоном)"
    
elif command -v inkscape &> /dev/null; then
    echo "✓ Inkscape найден"
    echo ""
    echo "Создаю логотип в разных размерах..."
    
    # Размер 512x512
    inkscape logo.svg -o logo_512.png -w 512 -h 512
    echo "✓ Создан: logo_512.png (512x512)"
    
    # Размер 256x256
    inkscape logo.svg -o logo_256.png -w 256 -h 256
    echo "✓ Создан: logo_256.png (256x256)"
    
    # Размер 128x128
    inkscape logo.svg -o logo_128.png -w 128 -h 128
    echo "✓ Создан: logo_128.png (128x128)"
    
    # Размер 192x192
    inkscape logo.svg -o ic_launcher.png -w 192 -h 192
    echo "✓ Создан: ic_launcher.png (192x192)"
else
    echo "❌ Ошибка: ImageMagick или Inkscape не установлены"
    echo ""
    echo "Установите один из них:"
    echo "  Ubuntu/Debian: sudo apt install imagemagick"
    echo "  macOS: brew install imagemagick"
    echo "  Windows: choco install imagemagick"
    exit 1
fi

echo ""
echo "═══════════════════════════════════════"
echo "✅ Логотипы созданы успешно!"
echo "═══════════════════════════════════════"
echo ""
echo "Созданные файлы:"
echo "  📄 logo_512.png   - Основной логотип (512x512)"
echo "  📄 logo_256.png   - Средний размер (256x256)"
echo "  📄 logo_128.png   - Маленький размер (128x128)"
echo "  📄 ic_launcher.png - Для Android (192x192)"
echo "  📄 logo_white_bg.png - С белым фоном (512x512)"
echo ""
echo "💡 Отправьте logo_512.png на GitHub!"
