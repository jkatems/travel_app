import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/data/destinations_data.dart';
import 'package:travel_app/widgets/back_to_safe_screen_button.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final destinations = DestinationsData.getDestinations();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carte des destinations'),
        leading: const BackToSafeScreenButton(fallbackRoute: 'home'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: destinations.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final destination = destinations[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.location_on),
              title: Text(destination.name),
              subtitle: Text(destination.country),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.pushNamed(
                'destination_detail',
                pathParameters: {'id': destination.id},
              ),
            ),
          );
        },
      ),
    );
  }
}
