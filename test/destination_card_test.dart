import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/data/destinations_data.dart';
import 'package:travel_app/widgets/destination_card.dart';

void main() {
  testWidgets('DestinationCard shows data and handles taps', (tester) async {
    var tapped = false;
    final destination = DestinationsData.getDestinationById('1')!;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DestinationCard(
            destination: destination,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Santorini'), findsOneWidget);
    expect(find.text('Grèce'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    await tester.tap(find.byType(DestinationCard));
    expect(tapped, isTrue);
  });
}
