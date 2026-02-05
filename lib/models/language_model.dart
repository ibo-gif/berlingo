class Language {
  final String code;
  final String name;
  final String flag;
  final String description;

  Language({
    required this.code,
    required this.name,
    required this.flag,
    required this.description,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      code: json['code'],
      name: json['name'],
      flag: json['flag'],
      description: json['description'],
    );
  }
}

class Lesson {
  final int id;
  final int levelNumber;
  final String languageCode;
  final String title;
  final String description;
  final List<Question> questions;

  Lesson({
    required this.id,
    required this.levelNumber,
    required this.languageCode,
    required this.title,
    required this.description,
    required this.questions,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      levelNumber: json['level'],
      languageCode: json['language'],
      title: json['title'],
      description: json['description'],
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
    );
  }
}

class Question {
  final int id;
  final String type;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanation;

  Question({
    required this.id,
    required this.type,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      type: json['type'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'],
      explanation: json['explanation'],
    );
  }
}

class UserProgress {
  final String languageCode;
  int currentLevel;
  int experience;
  final Map<int, bool> completedLevels;

  UserProgress({
    required this.languageCode,
    this.currentLevel = 1,
    this.experience = 0,
    Map<int, bool>? completedLevels,
  }) : completedLevels = completedLevels ?? {};

  void completeLevel(int level) {
    completedLevels[level] = true;
    if (level >= currentLevel) {
      currentLevel = level + 1;
    }
    experience += 100;
  }

  bool isLevelCompleted(int level) {
    return completedLevels[level] ?? false;
  }
}
