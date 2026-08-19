import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/data/destinations_data.dart';

void main() {
  group('DestinationsData', () {
    test('retourne les six destinations proposées', () {
      expect(DestinationsData.getDestinations(), hasLength(6));
    });

    test('recherche une destination par son identifiant', () {
      final destination = DestinationsData.getDestinationById('1');

      expect(destination, isNotNull);
      expect(destination!.name, 'Santorini');
    });

    test('retourne null lorsqu’une destination est inconnue', () {
      expect(DestinationsData.getDestinationById('inconnue'), isNull);
    });
  });
}
