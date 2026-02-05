import 'package:flutter/material.dart';
import '../models/language_model.dart';
import '../services/language_service.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  final String languageCode;

  const LessonScreen({
    Key? key,
    required this.lesson,
    required this.languageCode,
  }) : super(key: key);

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with TickerProviderStateMixin {
  late int currentQuestionIndex;
  late UserProgress progress;
  late Map<int, String?> answers;
  late AnimationController _animationController;
  bool showResult = false;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    currentQuestionIndex = 0;
    answers = {};
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    progress = await ProgressService.loadProgress(widget.languageCode);
    setState(() {});
  }

  void _selectAnswer(String answer) {
    if (showResult) return;

    final question = widget.lesson.questions[currentQuestionIndex];
    isCorrect = answer == question.correctAnswer;
    answers[currentQuestionIndex] = answer;

    setState(() {
      showResult = true;
    });

    _animationController.forward();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (currentQuestionIndex < widget.lesson.questions.length - 1) {
        _nextQuestion();
      } else {
        _showCompletionDialog();
      }
    });
  }

  void _nextQuestion() {
    _animationController.reset();
    setState(() {
      currentQuestionIndex++;
      showResult = false;
    });
  }

  void _showCompletionDialog() {
    final correctAnswers = answers.values
        .asMap()
        .entries
        .where((entry) =>
            entry.value ==
            widget.lesson.questions[entry.key].correctAnswer)
        .length;

    progress.completeLevel(widget.lesson.levelNumber);
    ProgressService.saveProgress(widget.languageCode, progress);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Уровень завершен!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Правильных ответов: $correctAnswers/${widget.lesson.questions.length}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              correctAnswers == widget.lesson.questions.length
                  ? 'Отлично! Все ответы верны! ⭐'
                  : 'Хорошо! Продолжайте занятия!',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text(
                    'Награда за завершение:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '+100 опыта',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Готово'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.lesson.questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / widget.lesson.questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.lesson.title} - Раздел ${widget.lesson.levelNumber}'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                '${currentQuestionIndex + 1}/${widget.lesson.questions.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Вопрос ${currentQuestionIndex + 1}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            question.question,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children: question.options.asMap().entries.map((entry) {
                      final index = entry.key;
                      final option = entry.value;
                      final isSelected = answers[currentQuestionIndex] == option;
                      final isCorrectAnswer = option == question.correctAnswer;

                      Color bgColor = Colors.white;
                      Color borderColor = Colors.grey.shade300;
                      Color textColor = Colors.black87;

                      if (showResult) {
                        if (isCorrectAnswer) {
                          bgColor = Colors.green.shade50;
                          borderColor = Colors.green.shade400;
                          textColor = Colors.green.shade700;
                        } else if (isSelected && !isCorrect) {
                          bgColor = Colors.red.shade50;
                          borderColor = Colors.red.shade400;
                          textColor = Colors.red.shade700;
                        }
                      } else if (isSelected) {
                        bgColor = Colors.blue.shade50;
                        borderColor = Colors.blue.shade400;
                        textColor = Colors.blue.shade700;
                      }

                      return GestureDetector(
                        onTap: !showResult ? () => _selectAnswer(option) : null,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: bgColor,
                            border: Border.all(
                              color: borderColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: borderColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: showResult && isCorrectAnswer
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 18,
                                        )
                                      : showResult &&
                                              isSelected &&
                                              !isCorrect
                                          ? const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 18,
                                            )
                                          : Text(
                                              String.fromCharCode(65 + index),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: textColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  if (showResult)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            border: Border.all(color: Colors.blue.shade200),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Объяснение:',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                question.explanation,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
