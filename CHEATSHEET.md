# 🚀 Flutter & Android Быстрая Справка

## ⚡ Самые важные команды

### Установка & Запуск
```bash
flutter pub get              # Установить зависимости
flutter run                  # Запустить на устройстве/эмуляторе
flutter run -v              # Запустить с логами
```

### Сборка APK
```bash
flutter build apk --release         # Универсальный APK
flutter build apk --release \
  --target-platform android-arm64   # Только для ARM64
```

### Очистка
```bash
flutter clean               # Удалить build файлы
flutter pub get            # Переустановить зависимости
```

### Анализ & Форматирование
```bash
flutter analyze             # Проверить ошибки
dart format .              # Отформатировать код
```

---

## 📁 Структура проекта

```
lib/
├── main.dart               # Главное приложение
├── models/                 # Модели данных
├── screens/                # UI экраны
└── services/               # Бизнес логика

android/
├── app/                    # Конфигурация приложения
├── build.gradle            # Build скрипты
└── settings.gradle         # Gradle параметры
```

---

## 🔧 Полезные команды

```bash
# Информация о системе
flutter doctor                  # Проверить установку
flutter --version              # Версия Flutter
dart --version                 # Версия Dart

# Устройства
flutter devices               # Список подключенных устройств
adb devices                   # ADB устройства
adb install app.apk          # Установить APK

# APK & Bundle
flutter build apk --release     # Release APK
flutter build appbundle --release # Для Google Play

# Отладка
flutter logs                  # Просмотр логов
flutter run --verbose        # Детализированный вывод
flutter run --profile        # Профиль производительности
```

---

## 📱 Установка APK на телефон

### ADB (быстрый способ)
```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Ручная установка
1. Скопируйте APK на телефон
2. Откройте файловый менеджер
3. Нажмите на APK файл
4. Подтвердите установку

---

## 🐛 Решение проблем

```bash
# Flutter не найден
export PATH="$PATH:/path/to/flutter/bin"

# Ошибки при сборке
flutter clean && flutter pub get && flutter run

# AndroidSDK проблемы
flutter doctor --android-licenses
yes | flutter doctor --android-licenses

# Обновить Flutter
flutter upgrade

# Обновить зависимости
flutter pub upgrade
```

---

## 📊 Размеры изображений

| Экран | Размер | Ориентация |
|-------|--------|-----------|
| Phone | 360x800 | Portrait |
| Tablet | 600+ | Portrait/Landscape |
| Desktop | 1000+ | Landscape |

---

## 🎯 Требования проекта

- Flutter: 3.0+
- Dart: 3.0+
- Android SDK: 21+ (Android 5.0+)
- Java: 11+

---

## 💾 Локальное хранилище

```dart
SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setString('key', 'value');  // Сохранить
String? value = prefs.getString('key'); // Загрузить
await prefs.remove('key');              // Удалить
```

---

## 🌐 Цвета Material Design 3

```dart
Colors.blue           // Primary
Colors.green          // Success
Colors.red            // Error
Colors.grey           // Secondary
Colors.white          // Background
Colors.black          // Text
```

---

## 📦 Зависимости в pubspec.yaml

```yaml
dependencies:
  flutter: sdk: flutter
  shared_preferences: ^2.2.0
  provider: ^6.0.0          # State management
  sqflite: ^2.3.0          # Database
```

---

## 🔗 Полезные ссылки

- [Flutter.dev](https://flutter.dev)
- [Dart.dev](https://dart.dev)
- [Material Design](https://material.io)
- [Android Developers](https://developer.android.com)
- [GitHub Berlingo](https://github.com/ibo-gif/berlingo)

---

## ✅ Before Release Checklist

- [ ] Версия обновлена в pubspec.yaml
- [ ] Нет console ошибок
- [ ] Протестировано на разных устройствах
- [ ] Иконка приложения установлена
- [ ] Все 8 уровней работают
- [ ] Сохранение прогресса работает
- [ ] Нет утечек памяти

---

**Удачи в разработке! 🚀**
