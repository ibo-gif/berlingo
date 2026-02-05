@echo off
REM Berlingo APK Build Script for Windows
REM Скрипт для автоматизации сборки APK на Windows

setlocal enabledelayedexpansion

echo.
echo ╔════════════════════════════════════════╗
echo ║  🎓 Berlingo - APK Build Script       ║
echo ║  Автоматическая сборка приложения    ║
echo ╚════════════════════════════════════════╝
echo.

REM Проверка Flutter
flutter --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Ошибка: Flutter не установлен или не в PATH
    echo    Установите Flutter с https://flutter.dev
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('flutter --version') do set flutter_version=%%i
echo ✓ Flutter найден: %flutter_version%
echo.

REM Перейти в директорию проекта
cd /d "%~dp0"
echo 📁 Работаю в: %cd%
echo.

REM Очистка
echo 🧹 Очистка проекта...
call flutter clean

REM Установка зависимостей
echo 📦 Установка зависимостей...
call flutter pub get

REM Сборка APK
echo.
echo 🔨 Сборка Release APK...
echo    Это может занять 2-5 минут...
echo.

call flutter build apk --release

if errorlevel 1 (
    echo ❌ Ошибка при сборке APK
    pause
    exit /b 1
)

echo.
echo ✅ Сборка завершена!
echo.

REM Проверка результата
if exist "build\app\outputs\flutter-apk\app-release.apk" (
    for /F "usebackq" %%A in ('build\app\outputs\flutter-apk\app-release.apk') do set apk_size=%%~zA
    setlocal enabledelayedexpansion
    set /a size_mb=!apk_size! / 1024 / 1024
    
    echo ╔════════════════════════════════════════╗
    echo ║ ✅ Berlingo.apk успешно собран!      ║
    echo ╚════════════════════════════════════════╝
    echo.
    echo 📱 Файл: build\app\outputs\flutter-apk\app-release.apk
    echo 📊 Размер: !size_mb! MB
    echo.
    echo 🚀 Установка на устройство:
    echo    adb install build\app\outputs\flutter-apk\app-release.apk
    echo.
    echo 💡 Или скопируйте APK на телефон вручную
) else (
    echo ❌ Ошибка: APK файл не найден!
    echo    Проверьте логи выше
    pause
    exit /b 1
)

echo.
echo ═══════════════════════════════════════════
echo 🎓 Berlingo готов к установке!
echo ═══════════════════════════════════════════
echo.
pause
