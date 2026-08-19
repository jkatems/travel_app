// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/main.dart';
import 'package:travel_app/screens/booking_form_screen.dart';
import 'package:travel_app/screens/destinations_list_screen.dart';

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

    await tester.drag(
      find.byType(SingleChildScrollView).first,
      const Offset(0, -250),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Santorini').first);
    await tester.pumpAndSettle();
    expect(find.text('À propos'), findsOneWidget);

    await tester.tap(find.byTooltip('Retour aux destinations'));
    await tester.pumpAndSettle();
    expect(find.text('Travel Explorer'), findsOneWidget);
  });

  testWidgets('search and booking validation work', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: DestinationsListScreen()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Tokyo');
    await tester.pumpAndSettle();
    expect(find.text('Tokyo'), findsWidgets);
    expect(find.text('Santorini'), findsNothing);

    await tester.pumpWidget(const MaterialApp(home: BookingFormScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Confirmer la réservation'));
    await tester.pumpAndSettle();
    expect(find.text('Veuillez entrer votre nom'), findsOneWidget);
    expect(find.text('Veuillez entrer votre email'), findsOneWidget);
    expect(find.text('Veuillez entrer votre numéro'), findsOneWidget);
  });
}
