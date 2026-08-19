import 'package:flutter/material.dart';

/// A grid that selects its column count from the available screen width.
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double minItemWidth;
  final int maxColumns;
  final double childAspectRatio;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.minItemWidth = 180,
    this.maxColumns = 3,
    this.childAspectRatio = 1,
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final columns = (constraints.maxWidth / minItemWidth)
          .floor()
          .clamp(1, maxColumns)
          .toInt();
      return GridView.count(
        crossAxisCount: columns,
        shrinkWrap: shrinkWrap,
        physics: physics,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
        children: children,
      );
    },
  );
}
