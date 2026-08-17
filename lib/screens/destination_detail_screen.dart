import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/models/destination.dart';
import 'package:travel_app/widgets/rating_stars.dart';

class DestinationDetailScreen extends StatelessWidget {
  final Destination destination;

  const DestinationDetailScreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: IconButton(
              tooltip: 'Retour aux destinations',
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed('destinations');
                }
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    destination.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.blue.shade700,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(destination.name),
            ),
          ),
          SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isTablet = constraints.maxWidth > 600;

                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Location and Rating
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.red.shade700),
                          const SizedBox(width: 8),
                          Text(
                            destination.country,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          RatingStars(rating: destination.rating),
                          const SizedBox(width: 4),
                          Text('(${destination.reviewCount})'),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Description
                      Text(
                        'À propos',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        destination.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),

                      // Info Cards
                      if (isTablet)
                        GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1.5,
                          children: [
                            _buildInfoCard(
                              context,
                              icon: Icons.calendar_today,
                              label: 'Saison idéale',
                              value: destination.bestSeason,
                            ),
                            _buildInfoCard(
                              context,
                              icon: Icons.timer,
                              label: 'Durée recommandée',
                              value: '${destination.daysRecommended} jours',
                            ),
                            _buildInfoCard(
                              context,
                              icon: Icons.euro,
                              label: 'Budget moyen',
                              value: '${destination.price}\$',
                            ),
                          ],
                        )
                      else
                        Column(
                          children: [
                            _buildInfoCard(
                              context,
                              icon: Icons.calendar_today,
                              label: 'Saison idéale',
                              value: destination.bestSeason,
                            ),
                            const SizedBox(height: 12),
                            _buildInfoCard(
                              context,
                              icon: Icons.timer,
                              label: 'Durée recommandée',
                              value: '${destination.daysRecommended} jours',
                            ),
                            const SizedBox(height: 12),
                            _buildInfoCard(
                              context,
                              icon: Icons.attach_money,
                              label: 'Budget moyen',
                              value: '${destination.price}\$',
                            ),
                          ],
                        ),

                      const SizedBox(height: 24),

                      // Activities
                      Text(
                        'Activités populaires',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: destination.activities.map((activity) {
                          return Chip(
                            avatar: const Icon(Icons.check_circle, size: 18),
                            label: Text(activity),
                            backgroundColor: Colors.blue.shade50,
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 32),

                      // Book Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.pushNamed(
                              'booking',
                              queryParameters: {
                                'destinationId': destination.id,
                              },
                            );
                          },
                          icon: const Icon(Icons.book_online),
                          label: const Text('Réserver ce voyage'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
