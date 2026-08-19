import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/screens/home_screen.dart';
import 'package:travel_app/screens/favorites_screen.dart';
import 'package:travel_app/screens/map_screen.dart';
import 'package:travel_app/screens/destinations_list_screen.dart';
import 'package:travel_app/screens/destination_detail_screen.dart';
import 'package:travel_app/screens/booking_form_screen.dart';
import 'package:travel_app/data/destinations_data.dart';
import 'package:travel_app/models/destination.dart';

class AppRouter {
  static GoRouter createRouter(VoidCallback toggleTheme) {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => HomeScreen(toggleTheme: toggleTheme),
        ),
        GoRoute(
          path: '/destinations',
          name: 'destinations',
          builder: (context, state) => const DestinationsListScreen(),
        ),
        GoRoute(
          path: '/favorites',
          name: 'favorites',
          builder: (context, state) => const FavoritesScreen(),
        ),
        GoRoute(
          path: '/map',
          name: 'map',
          builder: (context, state) => const MapScreen(),
        ),
        GoRoute(
          path: '/destination/:id',
          name: 'destination_detail',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            final destination = DestinationsData.getDestinationById(id);
            return destination == null
                ? const _NotFoundScreen()
                : DestinationDetailScreen(destination: destination);
          },
        ),
        GoRoute(
          path: '/booking',
          name: 'booking',
          builder: (context, state) {
            final destinationId = state.uri.queryParameters['destinationId'];
            Destination? destination;
            if (destinationId != null) {
              destination = DestinationsData.getDestinationById(destinationId);
            }
            return BookingFormScreen(destination: destination);
          },
        ),
      ],
      errorBuilder: (context, state) => const _NotFoundScreen(),
    );
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Page introuvable'),
      leading: IconButton(
        tooltip: "Retour à l'accueil",
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.goNamed('home'),
      ),
    ),
    body: Center(
      child: ElevatedButton(
        onPressed: () => context.goNamed('home'),
        child: const Text("Retour à l'accueil"),
      ),
    ),
  );
}
