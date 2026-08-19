import 'package:flutter/material.dart';
import 'package:travel_app/widgets/back_to_safe_screen_button.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Mes favoris'),
      leading: const BackToSafeScreenButton(fallbackRoute: 'home'),
    ),
    body: const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_border, size: 64),
            SizedBox(height: 16),
            Text('Aucun favori pour le moment.', textAlign: TextAlign.center),
            SizedBox(height: 8),
            Text(
              'Explorez les destinations pour préparer votre sélection.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
