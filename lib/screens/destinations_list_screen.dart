import 'package:flutter/material.dart';
import 'package:travel_app/data/destinations_data.dart';
import 'package:travel_app/widgets/destination_card.dart';
import 'package:travel_app/widgets/custom_search_bar.dart';
import 'package:travel_app/models/destination.dart';
import 'package:travel_app/widgets/back_to_safe_screen_button.dart';

class DestinationsListScreen extends StatefulWidget {
  const DestinationsListScreen({super.key});

  @override
  State<DestinationsListScreen> createState() => _DestinationsListScreenState();
}

class _DestinationsListScreenState extends State<DestinationsListScreen> {
  String _searchQuery = '';
  String _selectedSeason = 'Toutes';
  RangeValues _priceRange = const RangeValues(0, 5000);

  final List<String> _seasons = [
    'Toutes',
    'Printemps',
    'Été',
    'Automne',
    'Hiver',
  ];

  List<Destination> get _filteredDestinations {
    var destinations = DestinationsData.getDestinations();

    if (_searchQuery.isNotEmpty) {
      destinations = destinations.where((dest) {
        final searchLower = _searchQuery.toLowerCase();
        return dest.name.toLowerCase().contains(searchLower) ||
            dest.country.toLowerCase().contains(searchLower) ||
            dest.description.toLowerCase().contains(searchLower);
      }).toList();
    }

    if (_selectedSeason != 'Toutes') {
      destinations = destinations
          .where((dest) => dest.bestSeason == _selectedSeason)
          .toList();
    }

    destinations = destinations
        .where(
          (dest) =>
              dest.price >= _priceRange.start && dest.price <= _priceRange.end,
        )
        .toList();

    return destinations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toutes les Destinations'),
        leading: const BackToSafeScreenButton(
          fallbackRoute: 'home',
          tooltip: "Retour à l'accueil",
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomSearchBar(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // Season Filter
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _seasons.length,
              itemBuilder: (context, index) {
                final season = _seasons[index];
                final isSelected = _selectedSeason == season;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(season),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedSeason = season;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          // Price Range
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Budget: ${_priceRange.start.round()}\$ - ${_priceRange.end.round()}\$',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                RangeSlider(
                  values: _priceRange,
                  min: 0,
                  max: 5000,
                  divisions: 50,
                  labels: RangeLabels(
                    '${_priceRange.start.round()}\$',
                    '${_priceRange.end.round()}\$',
                  ),
                  onChanged: (values) {
                    setState(() {
                      _priceRange = values;
                    });
                  },
                ),
              ],
            ),
          ),
          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredDestinations.length} destinations trouvées',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          // Destinations Grid
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isTablet = constraints.maxWidth > 600;
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isTablet ? 3 : 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _filteredDestinations.length,
                  itemBuilder: (context, index) {
                    return DestinationCard(
                      destination: _filteredDestinations[index],
                      onTap: () {
                        context.pushNamed(
                          'destination_detail',
                          pathParameters: {
                            'id': _filteredDestinations[index].id,
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
