import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:berlingo/main.dart';

void main() {
  testWidgets('App launches and shows home screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BerlingoApp());

    // Verify that the app title is displayed
    expect(find.text('Berlingo - Изучайте языки'), findsOneWidget);
    expect(find.text('Добро пожаловать!'), findsOneWidget);

    // Verify that language cards are displayed
    expect(find.byType(Card), findsWidgets);
  });

  testWidgets('Language selection works', (WidgetTester tester) async {
    await tester.pumpWidget(const BerlingoApp());

    // Find and tap the first language card (English)
    final langCards = find.byType(Card);
    expect(langCards, findsWidgets);

    // Tap first language
    await tester.tap(langCards.first);
    await tester.pumpAndSettle();

    // Verify selection worked (card should show blue border)
    // This would require more complex testing of the state
  });

  testWidgets('Navigation to level screen works', (WidgetTester tester) async {
    await tester.pumpWidget(const BerlingoApp());

    // Select a language first
    await tester.tap(find.byType(Card).first);
    await tester.pumpAndSettle();

    // Navigation would happen in a more integrated test
  });
}
