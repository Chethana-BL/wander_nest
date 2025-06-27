import 'package:flutter/material.dart';
import 'package:wander_nest/data/models/campsite.dart';
import 'package:wander_nest/presentation/widgets/home/home_compact_layout.dart';
import 'package:wander_nest/presentation/widgets/home/home_wide_layout.dart';

class ResponsiveCampsiteView extends StatelessWidget {
  const ResponsiveCampsiteView({super.key, required this.campsites});

  final List<Campsite> campsites;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 600;

        return isCompact
            ? HomeCompactLayout(campsites: campsites)
            : HomeWideLayout(campsites: campsites, width: constraints.maxWidth);
      },
    );
  }
}
