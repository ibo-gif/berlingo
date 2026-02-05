import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/lesson_screen.dart';
import 'screens/level_screen.dart';

void main() {
  runApp(const BerlingoApp());
}

class BerlingoApp extends StatelessWidget {
  const BerlingoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berlingo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
      routes: {
        '/level': (context) => const LevelScreen(),
        '/lesson': (context) => const LessonScreen(),
      },
    );
  }
}
