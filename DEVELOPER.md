# Документация разработчика Berlingo

## 🏗 Архитектура приложения

```
Berlingo App
├── Presentation (UI Layer)
│   ├── HomeScreen - Выбор языков
│   ├── LevelScreen - Выбор разделов (1-8)
│   └── LessonScreen - Прохождение вопросов
├── Business Logic (Services Layer)
│   ├── LanguageService - Управление данными
│   └── ProgressService - Сохранение прогресса
└── Data (Models Layer)
    ├── Language - Модель языка
    ├── Lesson - Модель урока
    ├── Question - Модель вопроса
    └── UserProgress - Модель прогресса пользователя
```

## 📊 Модели данных

### Language
```dart
Language {
  code: String,        // 'en', 'zh', 'ko', 'es', 'fr', 'de', 'ja', 'ru'
  name: String,        // 'Английский', 'Китайский', ...
  flag: String,        // '🇬🇧', '🇨🇳', ...
  description: String  // 'Learn English from basics'
}
```

### Lesson
```dart
Lesson {
  id: int,              // Уникальный ID
  levelNumber: int,     // 1-8
  languageCode: String, // 'en', 'zh', ...
  title: String,        // 'Приветствие'
  description: String,  // 'Изучите основные приветствия'
  questions: List<Question> // Список вопросов
}
```

### Question
```dart
Question {
  id: int,                 // Уникальный ID в уроке
  type: String,            // 'multiple' - множественный выбор
  question: String,        // Текст вопроса
  options: List<String>,   // 4 варианта ответа
  correctAnswer: String,   // Правильный ответ
  explanation: String      // Объяснение ответа
}
```

### UserProgress
```dart
UserProgress {
  languageCode: String,    // Код языка
  currentLevel: int,       // Текущий уровень (1-9, 9 = завершено)
  experience: int,         // Общий опыт (XP)
  completedLevels: Map<int, bool> // {1: true, 2: true, ...}
}
```

## 🔄 Поток данных

### Запуск приложения
1. `main.dart` - инициализирует приложение
2. `HomeScreen` - загружает список языков
3. Пользователь выбирает языки
4. Список сохраняется в `SharedPreferences`

### Выбор языка
1. `HomeScreen` - отображает выбранные языки
2. Нажатие на язык → `LevelScreen`
3. `LevelScreen` загружает прогресс пользователя
4. Отображает 8 разделов с прогрессом

### Прохождение урока
1. `LevelScreen` → выбор раздела → `LessonScreen`
2. `LessonScreen` загружает вопросы раздела
3. Пользователь отвечает на все вопросы
4. После завершения - сохраняется прогресс
5. `LevelScreen` обновляется с новым прогрессом

## 💾 Сохранение данных

Используется `SharedPreferences` для локального хранения:

```dart
// Сохранение прогресса
key: 'berlingo_progress_en'
value: JSON {
  language: 'en',
  currentLevel: 3,
  experience: 200,
  completedLevels: {1: true, 2: true}
}

// Сохранение выбранных языков
key: 'berlingo_selected_languages'
value: ['en', 'zh', 'ko']
```

## 🎨 Дизайн UI

### Цветовая схема
- **Primary**: Colors.blue (#2196F3)
- **Success**: Colors.green
- **Error**: Colors.red
- **Background**: Colors.white / Colors.grey.shade100

### Material Design 3
- Использование `ColorScheme.fromSeed()`
- Кастомные `Shape` с `RoundedRectangleBorder`
- `Card` для контейнеров
- `LinearProgressIndicator` для прогресса

## 🧪 Тестирование

### Unit тесты (пока не реализованы)
```bash
flutter test
```

### Widget тесты (пример для HomeScreen)
```dart
testWidgets('HomeScreen shows languages', (WidgetTester tester) async {
  await tester.pumpWidget(const BerlingoApp());
  expect(find.byType(Card), findsWidgets);
});
```

### Интеграционные тесты
```bash
flutter drive --target=test_driver/app.dart
```

## 📱 Возможности платформы (Platform Channels)

Сейчас не используются, но можно добавить:
- Уведомления (notifications)
- Речь (text-to-speech для проверки произношения)
- Камера (для распознавания текста)

Пример:
```dart
static const platform = MethodChannel('com.berlingo.app/native');

Future<void> speak(String text) async {
  try {
    await platform.invokeMethod('speak', {'text': text});
  } catch (e) {
    print('Failed to invoke: $e');
  }
}
```

## 🚀 Производительность

### Оптимизации уже реализованные:
- ✅ `ListView` с `shrinkWrap: true` для вложенных списков
- ✅ `GridView` с `NeverScrollableScrollPhysics` для встроенных гридов
- ✅ Минимизация перестраиваний виджетов (setState)
- ✅ Эффективное использование памяти

### Возможные улучшения:
- Добавить `PageView` для плавной прокрутки между разделами
- Использовать `GetX` или `Provider` для управления состоянием
- Кэшировать загруженные данные
- Ленивая загрузка изображений

## 📦 Зависимости

```yaml
dependencies:
  flutter: sdk: flutter
  cupertino_icons: ^1.0.2  # iOS-стиль иконки
  sqflite: ^2.3.0          # База данных SQL
  path: ^1.8.3             # Работа с путями
  provider: ^6.0.0         # Управление состоянием (зарезервировано)
  shared_preferences: ^2.2.0 # Локальное хранилище
```

## 🔧 Конфигурация

### pubspec.yaml
- `version: 1.0.0+1` - версия и build number
- `flutter.uses-material-design: true` - Material Design
- `assets` - загрузка ресурсов

### android/app/build.gradle
- `compileSdkVersion: 34` - Android SDK 34
- `minSdkVersion: 21` - Поддержка Android 5.0+
- `targetSdkVersion: 34` - Таргетный SDK

### AndroidManifest.xml
- `package: com.berlingo.app` - package name
- `android.icon` - иконка приложения
- `android.label` - название приложения

## 📚 Классы и методы

### LanguageService
```dart
static List<Lesson> getLessonsForLanguage(String languageCode)
  - Возвращает 8 уроков для языка

static Future<void> saveProgress(String languageCode, UserProgress progress)
  - Сохраняет прогресс пользователя

static Future<UserProgress> loadProgress(String languageCode)
  - Загружает прогресс пользователя
```

### ProgressService
```dart
static Future<void> saveProgress(...)
  - Сохраняет прогресс в SharedPreferences

static Future<UserProgress> loadProgress(...)
  - Загружает прогресс из SharedPreferences

static Future<List<String>> loadSelectedLanguages()
  - Загружает выбранные языки

static Future<void> saveSelectedLanguages(List<String>)
  - Сохраняет выбранные языки
```

## 🌍 Добавление новых языков

1. Добавить в `LanguageData.languages`:
```dart
Language(
  code: 'vi',
  name: 'Вьетнамский',
  flag: '🇻🇳',
  description: 'Learn Vietnamese',
),
```

2. Добавить уроки в `_generateLessonsFromTemplate()`:
```dart
'vi': [
  // 8 уроков с вопросами
]
```

3. Все остальное работает автоматически!

## 🎯 Будущие функции

- [ ] Мультиплеер режим
- [ ] Система достижений (badges)
- [ ] Ежедневные задачи (daily challenges)
- [ ] Словарь слов (word bank)
- [ ] Произношение (speech recognition)
- [ ] Переводы (translations)
- [ ] Синхронизация с облаком
- [ ] Темная тема
- [ ] Локализация интерфейса

---

**Спасибо за участие в разработке Berlingo! 🚀**
