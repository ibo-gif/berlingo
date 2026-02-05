import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/language_model.dart';

class LanguageData {
  static final List<Language> languages = [
    Language(
      code: 'en',
      name: 'Английский',
      flag: '🇬🇧',
      description: 'Learn English from basics',
    ),
    Language(
      code: 'zh',
      name: 'Китайский',
      flag: '🇨🇳',
      description: 'Learn Mandarin Chinese',
    ),
    Language(
      code: 'ko',
      name: 'Корейский',
      flag: '🇰🇷',
      description: 'Learn Korean language',
    ),
    Language(
      code: 'es',
      name: 'Испанский',
      flag: '🇪🇸',
      description: 'Learn Spanish language',
    ),
    Language(
      code: 'fr',
      name: 'Французский',
      flag: '🇫🇷',
      description: 'Learn French language',
    ),
    Language(
      code: 'de',
      name: 'Немецкий',
      flag: '🇩🇪',
      description: 'Learn German language',
    ),
    Language(
      code: 'ja',
      name: 'Японский',
      flag: '🇯🇵',
      description: 'Learn Japanese language',
    ),
    Language(
      code: 'ru',
      name: 'Русский',
      flag: '🇷🇺',
      description: 'Learn Russian language',
    ),
  ];

  static List<Lesson> getLessonsForLanguage(String languageCode) {
    final baseLessons = _generateLessonsFromTemplate(languageCode);
    return baseLessons;
  }

  static List<Lesson> _generateLessonsFromTemplate(String languageCode) {
    final Map<String, List<Map<String, dynamic>>> lessonsTemplate = {
      'en': [
        {
          'id': 1,
          'level': 1,
          'title': 'Приветствие',
          'description': 'Изучите основные приветствия',
          'questions': const [
            {
              'id': 1,
              'type': 'multiple',
              'question': 'Как сказать "Привет"?',
              'options': ['Hello', 'Goodbye', 'Thank you', 'Please'],
              'correctAnswer': 'Hello',
              'explanation': 'Hello - это стандартное приветствие на английском',
            },
            {
              'id': 2,
              'type': 'multiple',
              'question': 'Как ответить на приветствие?',
              'options': ['Hi, how are you?', 'No', 'Stop', 'Help'],
              'correctAnswer': 'Hi, how are you?',
              'explanation': 'Так люди обычно отвечают на приветствие',
            },
          ]
        },
        {
          'id': 2,
          'level': 2,
          'title': 'Знакомство',
          'description': 'Научитесь представляться',
          'questions': const [
            {
              'id': 3,
              'type': 'multiple',
              'question': 'Как сказать "Меня зовут..."?',
              'options': ['My name is...', 'I like...', 'I am...', 'My friend...'],
              'correctAnswer': 'My name is...',
              'explanation': 'My name is - стандартный способ представиться',
            },
          ]
        },
        {
          'id': 3,
          'level': 3,
          'title': 'Повседневные фразы',
          'description': 'Полезные выражения',
          'questions': const [
            {
              'id': 4,
              'type': 'multiple',
              'question': 'Как сказать "Спасибо"?',
              'options': ['Thank you', 'Please', 'Sorry', 'Excuse me'],
              'correctAnswer': 'Thank you',
              'explanation': 'Thank you - выражение благодарности',
            },
          ]
        },
        {
          'id': 4,
          'level': 4,
          'title': 'Вежливые слова',
          'description': 'Вежливость в общении',
          'questions': const [
            {
              'id': 5,
              'type': 'multiple',
              'question': 'Как вежливо попросить?',
              'options': ['Please', 'Quickly', 'Never', 'Always'],
              'correctAnswer': 'Please',
              'explanation': 'Please - вежливый способ просить',
            },
          ]
        },
        {
          'id': 5,
          'level': 5,
          'title': 'Извинения',
          'description': 'Как извиниться',
          'questions': const [
            {
              'id': 6,
              'type': 'multiple',
              'question': 'Как сказать "Извините"?',
              'options': ['Sorry', 'Yes', 'No', 'Maybe'],
              'correctAnswer': 'Sorry',
              'explanation': 'Sorry - способ извиниться',
            },
          ]
        },
        {
          'id': 6,
          'level': 6,
          'title': 'Вопросы и ответы',
          'description': 'Как задавать вопросы',
          'questions': const [
            {
              'id': 7,
              'type': 'multiple',
              'question': 'Как спросить "Как дела?"',
              'options': ['How are you?', 'Where are you?', 'What is this?', 'Who are you?'],
              'correctAnswer': 'How are you?',
              'explanation': 'How are you? - стандартный вопрос о самочувствии',
            },
          ]
        },
        {
          'id': 7,
          'level': 7,
          'title': 'Расширенный словарь',
          'description': 'Новые слова и выражения',
          'questions': const [
            {
              'id': 8,
              'type': 'multiple',
              'question': 'Как сказать "Пока"?',
              'options': ['Goodbye', 'Hello', 'Wait', 'Come'],
              'correctAnswer': 'Goodbye',
              'explanation': 'Goodbye - это прощание на английском',
            },
          ]
        },
        {
          'id': 8,
          'level': 8,
          'title': 'Финальный уровень',
          'description': 'Итоговый тест всех знаний',
          'questions': const [
            {
              'id': 9,
              'type': 'multiple',
              'question': 'Что означает "Nice to meet you"?',
              'options': ['Рад познакомиться', 'До свидания', 'Спасибо', 'Пожалуйста'],
              'correctAnswer': 'Рад познакомиться',
              'explanation': 'Nice to meet you - способ выразить радость от встречи',
            },
            {
              'id': 10,
              'type': 'multiple',
              'question': 'Завершите диалог: "How are you?" - "..."',
              'options': ['I am fine, thank you', 'Goodbye', 'Hello', 'Please'],
              'correctAnswer': 'I am fine, thank you',
              'explanation': 'Стандартный ответ на вопрос о самочувствии',
            },
          ]
        },
      ],
      'zh': [
        {
          'id': 1,
          'level': 1,
          'title': '基本问候',
          'description': '学习基本问候',
          'questions': const [
            {
              'id': 1,
              'type': 'multiple',
              'question': '如何说"你好"?',
              'options': ['你好 (Nǐ hǎo)', '谢谢', '对不起', '再见'],
              'correctAnswer': '你好 (Nǐ hǎo)',
              'explanation': '你好是中文的基本问候',
            },
          ]
        },
      ],
      'ko': [
        {
          'id': 1,
          'level': 1,
          'title': '기본 인사',
          'description': '기본 인사 배우기',
          'questions': const [
            {
              'id': 1,
              'type': 'multiple',
              'question': '"안녕하세요"는 무엇을 의미합니까?',
              'options': ['안녕하세요 (Hello)', '감사합니다', '미안합니다', '안녕히 가세요'],
              'correctAnswer': '안녕하세요 (Hello)',
              'explanation': '안녕하세요는 한국어의 기본 인사문입니다',
            },
          ]
        },
      ],
    };

    final template = lessonsTemplate[languageCode] ?? lessonsTemplate['en']!;
    
    return template.map((lessonMap) {
      final questions = (lessonMap['questions'] as List)
          .map((q) => Question(
            id: q['id'],
            type: q['type'],
            question: q['question'],
            options: List<String>.from(q['options']),
            correctAnswer: q['correctAnswer'],
            explanation: q['explanation'],
          ))
          .toList();

      return Lesson(
        id: lessonMap['id'],
        levelNumber: lessonMap['level'],
        languageCode: languageCode,
        title: lessonMap['title'],
        description: lessonMap['description'],
        questions: questions,
      );
    }).toList();
  }
}

class ProgressService {
  static const String _prefix = 'berlingo_';

  static Future<void> saveProgress(String languageCode, UserProgress progress) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${_prefix}progress_$languageCode';
    final data = {
      'language': languageCode,
      'currentLevel': progress.currentLevel,
      'experience': progress.experience,
      'completedLevels': progress.completedLevels,
    };
    await prefs.setString(key, jsonEncode(data));
  }

  static Future<UserProgress> loadProgress(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${_prefix}progress_$languageCode';
    final data = prefs.getString(key);
    
    if (data == null) {
      return UserProgress(languageCode: languageCode);
    }

    final json = jsonDecode(data) as Map<String, dynamic>;
    final progress = UserProgress(
      languageCode: languageCode,
      currentLevel: json['currentLevel'] ?? 1,
      experience: json['experience'] ?? 0,
      completedLevels: Map<int, bool>.from(
        (json['completedLevels'] as Map).cast<String, bool>().map(
          (key, value) => MapEntry(int.parse(key), value),
        ),
      ),
    );
    return progress;
  }

  static Future<List<String>> loadSelectedLanguages() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('${_prefix}selected_languages') ?? [];
  }

  static Future<void> saveSelectedLanguages(List<String> languages) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('${_prefix}selected_languages', languages);
  }
}
