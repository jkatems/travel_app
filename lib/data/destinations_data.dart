import 'package:travel_app/models/destination.dart';

class DestinationsData {
  static List<Destination> getDestinations() {
    return [
      Destination(
        id: '1',
        name: 'Santorini',
        country: 'Grèce',
        description:
            'Santorini est une île des Cyclades dans la mer Égée. Elle a été dévastée par une éruption volcanique au 16ème siècle avant JC, façonnant à jamais son paysage accidenté. Les maisons blanchies à la chaux et les églises aux dômes bleus s\'accrochent aux falaises spectaculaires.',
        imageUrl: 'assets/images/santorini.jpg',
        rating: 4.8,
        reviewCount: 2456,
        price: 1250.0,
        activities: [
          'Randonnée',
          'Plongée',
          'Dégustation de vin',
          'Coucher de soleil',
        ],
        bestSeason: 'Été',
        daysRecommended: 5,
      ),
      Destination(
        id: '2',
        name: 'Tokyo',
        country: 'Japon',
        description:
            'Tokyo, la capitale animée du Japon, associe styles ultramodernes et traditionnels, des gratte-ciels illuminés aux temples historiques. La ville est célèbre pour sa cuisine de rue, ses quartiers commerçants et sa culture pop vibrante.',
        imageUrl: 'assets/images/tokyo.jpg',
        rating: 4.9,
        reviewCount: 3210,
        price: 1800.0,
        activities: ['Shopping', 'Temples', 'Cuisine', 'Technologie'],
        bestSeason: 'Printemps',
        daysRecommended: 7,
      ),
      Destination(
        id: '3',
        name: 'Banff',
        country: 'Canada',
        description:
            'Banff est une ville de l\'Alberta, dans le parc national de Banff, au cœur des Rocheuses. Ses montagnes majestueuses, ses sources thermales et ses lacs turquoise en font un paradis pour les amoureux de la nature.',
        imageUrl: 'assets/images/banff.jpg',
        rating: 4.7,
        reviewCount: 1876,
        price: 1500.0,
        activities: ['Ski', 'Randonnée', 'Vélo', 'Sources thermales'],
        bestSeason: 'Hiver',
        daysRecommended: 6,
      ),
      Destination(
        id: '4',
        name: 'Marrakech',
        country: 'Maroc',
        description:
            'Marrakech est une ville marocaine imprégnée d\'histoire et de culture. La médina fortifiée, les souks colorés, les palais mauresques et les jardins luxuriants offrent une expérience sensorielle unique.',
        imageUrl: 'assets/images/marrakech.jpg',
        rating: 4.6,
        reviewCount: 1543,
        price: 800.0,
        activities: ['Souks', 'Architecture', 'Cuisine', 'Désert'],
        bestSeason: 'Automne',
        daysRecommended: 4,
      ),
      Destination(
        id: '5',
        name: 'Queenstown',
        country: 'Nouvelle-Zélande',
        description:
            'Queenstown, située sur les rives du lac Wakatipu, est réputée pour ses sports d\'aventure. Saut à l\'élastique, saut en parachute, jet boat et randonnées attendent les voyageurs intrépides.',
        imageUrl: 'assets/images/queenstown.jpg',
        rating: 4.9,
        reviewCount: 2010,
        price: 2200.0,
        activities: ['Saut à l\'élastique', 'Jet boat', 'Randonnée', 'Ski'],
        bestSeason: 'Printemps',
        daysRecommended: 7,
      ),
      Destination(
        id: '6',
        name: 'Bali',
        country: 'Indonésie',
        description:
            'Bali est une île paradisiaque connue pour ses forêts verdoyantes, ses rizières en terrasses, ses plages de sable blanc et ses temples hindous millénaires. Un havre de paix et de spiritualité.',
        imageUrl: 'assets/images/bali.jpg',
        rating: 4.5,
        reviewCount: 5432,
        price: 950.0,
        activities: ['Surf', 'Yoga', 'Temples', 'Plages'],
        bestSeason: 'Été',
        daysRecommended: 10,
      ),
    ];
  }

  static Destination? getDestinationById(String id) {
    for (final destination in getDestinations()) {
      if (destination.id == id) return destination;
    }
    return null;
  }
}
