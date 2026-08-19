// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:travel_app/main.dart';

void main() {
  testWidgets('navigation and destination images work', (tester) async {
    await tester.pumpWidget(const TravelApp());
    await tester.pumpAndSettle();

    expect(find.text('Travel Explorer'), findsOneWidget);
    expect(find.byType(Image), findsWidgets);

    await tester.tap(find.byIcon(Icons.dark_mode));
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );

    final explorer = find.text('Explorer');
    await tester.ensureVisible(explorer);
    await tester.pumpAndSettle();
    await tester.tap(explorer);
    await tester.pumpAndSettle();
    expect(find.text('Toutes les Destinations'), findsOneWidget);

    await tester.tap(find.text('Santorini').first);
    await tester.pumpAndSettle();
    expect(find.text('À propos'), findsOneWidget);

    await tester.tap(find.byTooltip('Retour aux destinations'));
    await tester.pumpAndSettle();
    expect(find.text('Toutes les Destinations'), findsOneWidget);

    await tester.tap(find.byTooltip("Retour à l'accueil"));
    await tester.pumpAndSettle();
    expect(find.text('Travel Explorer'), findsOneWidget);

    final booking = find.text('Réserver');
    await tester.ensureVisible(booking);
    await tester.pumpAndSettle();
    await tester.tap(booking);
    await tester.pumpAndSettle();
    expect(find.text('Formulaire de réservation'), findsOneWidget);

    await tester.tap(find.byTooltip("Retour à l'accueil"));
    await tester.pumpAndSettle();
    expect(find.text('Travel Explorer'), findsOneWidget);
  });

  testWidgets('search and booking validation work', (tester) async {
    await tester.pumpWidget(const TravelApp());
    await tester.pumpAndSettle();

    final explorer = find.text('Explorer');
    await tester.ensureVisible(explorer);
    await tester.tap(explorer);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Tokyo');
    await tester.pumpAndSettle();
    expect(find.text('Tokyo'), findsOneWidget);
    expect(find.text('Santorini'), findsNothing);

    await tester.tap(find.byTooltip("Retour à l'accueil"));
    await tester.pumpAndSettle();
    final booking = find.text('Réserver');
    await tester.ensureVisible(booking);
    await tester.tap(booking);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Confirmer la réservation'));
    await tester.pumpAndSettle();
    expect(find.text('Veuillez entrer votre nom'), findsOneWidget);
    expect(find.text('Veuillez entrer votre email'), findsOneWidget);
    expect(find.text('Veuillez entrer votre numéro'), findsOneWidget);
  });
}
