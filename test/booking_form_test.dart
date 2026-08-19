import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/screens/booking_form_screen.dart';

void main() {
  testWidgets('booking form validates and confirms a complete reservation', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: BookingFormScreen()));

    await tester.tap(find.text('Confirmer la réservation'));
    await tester.pump();
    expect(find.text('Veuillez entrer votre nom'), findsOneWidget);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Amina Mbuyi');
    await tester.enterText(fields.at(1), 'amina@example.com');
    await tester.enterText(fields.at(2), '0812345678');
    await tester.tap(find.text('Confirmer la réservation'));
    await tester.pumpAndSettle();

    expect(find.text('Réservation confirmée'), findsOneWidget);
    expect(find.text('Nom: Amina Mbuyi'), findsOneWidget);
  });
}
