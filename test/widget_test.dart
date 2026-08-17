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
}
