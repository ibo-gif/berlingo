import 'package:flutter/material.dart';
import '../models/language_model.dart';
import '../services/language_service.dart';
import 'lesson_screen.dart';

class LevelScreen extends StatefulWidget {
  final String? languageCode;

  const LevelScreen({Key? key, this.languageCode}) : super(key: key);

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  late UserProgress progress;
  late Language language;
  late List<Lesson> lessons;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final langCode = widget.languageCode ?? 'en';
    language = LanguageData.languages
        .firstWhere((l) => l.code == langCode);
    progress = await ProgressService.loadProgress(langCode);
    lessons = LanguageData.getLessonsForLanguage(langCode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${language.flag} ${language.name}'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ваш прогресс',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Уровень ${progress.currentLevel}/8',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Опыт',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${progress.experience}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Разделы (8 уровней):',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      final lesson = lessons[index];
                      final isCompleted = progress.isLevelCompleted(lesson.levelNumber);
                      final isLocked = lesson.levelNumber > progress.currentLevel;
                      final isCurrent = lesson.levelNumber == progress.currentLevel;

                      return GestureDetector(
                        onTap: isLocked
                            ? null
                            : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LessonScreen(
                                lesson: lesson,
                                languageCode: widget.languageCode ?? 'en',
                              ),
                            ),
                          ).then((_) {
                            _loadData();
                          });
                        },
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: isCurrent ? 4 : 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: isCurrent 
                                  ? Colors.blue.shade400 
                                  : Colors.grey.shade300,
                              width: isCurrent ? 2 : 1,
                            ),
                          ),
                          color: isLocked 
                              ? Colors.grey.shade100 
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: isCompleted
                                        ? Colors.green.shade400
                                        : isCurrent
                                            ? Colors.blue.shade400
                                            : Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: isCompleted
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 28,
                                          )
                                        : isLocked
                                            ? const Icon(
                                                Icons.lock,
                                                color: Colors.white,
                                                size: 24,
                                              )
                                            : Text(
                                                '${lesson.levelNumber}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        lesson.title,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: isLocked
                                              ? Colors.grey.shade500
                                              : Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        lesson.description,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: isLocked
                                              ? Colors.grey.shade400
                                              : Colors.grey.shade600,
                                        ),
                                      ),
                                      if (isCurrent)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8),
                                          child: Text(
                                            'Нажмите для начала →',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.blue.shade400,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  if (progress.currentLevel > 8)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        border: Border.all(
                          color: Colors.green.shade300,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.celebration,
                            color: Colors.green.shade600,
                            size: 40,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Поздравляем! 🎉',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Вы успешно завершили все 8 уровней!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green.shade700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Общий опыт: ${progress.experience}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
