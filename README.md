# Travel Explorer App

Une application Flutter multi-écrans pour explorer et réserver des destinations de voyage.

## Fonctionnalités

-  **Écran d'accueil** : Destinations populaires, actions rapides
-  **Liste des destinations** : Recherche, filtrage par saison et budget
-  **Détails des destinations** : Informations complètes, activités, réservation
-  **Formulaire de réservation** : Validation complète (3 champs minimum)
-  **Thème clair/sombre** : Basculement dynamique
-  **Responsive** : Adaptation mobile et tablette

## Widgets Utilisés

- ListView, GridView, Stack, Card, SliverAppBar
- TextFormField, DropdownButtonFormField, RangeSlider
- FilterChip, Chip, AlertDialog
- Et plus...

## Widgets Réutilisables

- `DestinationCard` : Carte de destination
- `CustomSearchBar` : Barre de recherche
- `RatingStars` : Étoiles de notation

## Installation

1. Assurez-vous d'avoir Flutter installé
2. Clonez le dépôt : `git clone [url-du-repo]`
3. Installez les dépendances : `flutter pub get`
4. Lancez l'application : `flutter run`

## Captures d'écran

![alt text](images/photo_1_2026-08-17_16-41-49.jpg) ![alt text](images/photo_2_2026-08-17_16-41-49.jpg) ![alt text](images/photo_3_2026-08-17_16-41-49.jpg) ![alt text](images/photo_4_2026-08-17_16-41-49.jpg) ![alt text](images/photo_5_2026-08-17_16-41-49.jpg) ![alt text](images/photo_6_2026-08-17_16-41-49.jpg)

## Technologies

- Flutter 3.0+
- GoRouter pour la navigation
- Google Fonts
- Material Design 3

## Structure du Projet

lib/

├── models/  Modèles de données

├── data/ # Données mockées

├── screens/ # Écrans de l'application

├── widgets/ # Widgets réutilisables

├── theme/ # Thèmes clair/sombre

└── router/ # Configuration de la navigation