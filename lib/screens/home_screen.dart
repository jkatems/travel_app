import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/data/destinations_data.dart';
import 'package:travel_app/widgets/destination_card.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  const HomeScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final popularDestinations = DestinationsData.getDestinations()
        .take(3)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Explorer'),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth > 600;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Section
                Container(
                  height: isTablet ? 400 : 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade700, Colors.blue.shade300],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -50,
                        right: -50,
                        child: Icon(
                          Icons.flight_takeoff,
                          size: 200,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.explore,
                              size: 80,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Explorez le Monde',
                              style: Theme.of(context).textTheme.headlineLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Découvrez des destinations incroyables',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Destinations Populaires',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: popularDestinations.length,
                          itemBuilder: (context, index) {
                            return DestinationCard(
                              destination: popularDestinations[index],
                              onTap: () {
                                context.pushNamed(
                                  'destination_detail',
                                  pathParameters: {
                                    'id': popularDestinations[index].id,
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Quick Actions
                      Text(
                        'Actions Rapides',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      GridView.count(
                        crossAxisCount: isTablet ? 4 : 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.5,
                        children: [
                          _buildQuickAction(
                            context,
                            icon: Icons.search,
                            label: 'Explorer',
                            color: Colors.orange,
                            onTap: () => context.goNamed('favorites'),
                          ),
                          _buildQuickAction(
                            context,
                            icon: Icons.book_online,
                            label: 'Réserver',
                            color: Colors.green,
                            onTap: () => context.goNamed('booking'),
                          ),
                          _buildQuickAction(
                            context,
                            icon: Icons.favorite,
                            label: 'Favoris',
                            color: Colors.red,
                            onTap: () => context.goNamed('map'),
                          ),
                          _buildQuickAction(
                            context,
                            icon: Icons.map,
                            label: 'Carte',
                            color: Colors.purple,
                            onTap: () => context.goNamed('destinations'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.3),
                color.withValues(alpha: 0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
