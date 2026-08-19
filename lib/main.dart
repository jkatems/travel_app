import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/router/app_router.dart';
import 'package:travel_app/theme/app_theme.dart';

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatefulWidget {
  const TravelApp({super.key});

  @override
  State<TravelApp> createState() => _TravelAppState();
}

class _TravelAppState extends State<TravelApp> {
  ThemeMode _themeMode = ThemeMode.light;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.createRouter(_toggleTheme);
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Travel Explorer',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
