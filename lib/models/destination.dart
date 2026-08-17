class Destination {
  final String id;
  final String name;
  final String country;
  final String description;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final double price;
  final List<String> activities;
  final String bestSeason;
  final int daysRecommended;

  const Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.activities,
    required this.bestSeason,
    required this.daysRecommended,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'price': price,
      'activities': activities,
      'bestSeason': bestSeason,
      'daysRecommended': daysRecommended,
    };
  }

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      rating: json['rating'],
      reviewCount: json['reviewCount'],
      price: json['price'],
      activities: List<String>.from(json['activities']),
      bestSeason: json['bestSeason'],
      daysRecommended: json['daysRecommended'],
    );
  }
}
