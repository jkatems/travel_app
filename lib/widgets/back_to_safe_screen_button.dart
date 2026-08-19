import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackToSafeScreenButton extends StatelessWidget {
  final String fallbackRoute;
  final String tooltip;

  const BackToSafeScreenButton({
    super.key,
    required this.fallbackRoute,
    this.tooltip = 'Retour',
  });

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: tooltip,
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      if (context.canPop()) {
        context.pop();
      } else {
        context.goNamed(fallbackRoute);
      }
    },
  );
}
