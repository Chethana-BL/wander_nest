import 'package:flutter/material.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/home_compact_layout.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/home_wide_layout.dart';

class ResponsiveCampsiteView extends StatelessWidget {
  const ResponsiveCampsiteView({
    super.key,
    required this.campsites,
    required this.filteredCampsites,
  });

  final List<Campsite> campsites;
  final List<Campsite> filteredCampsites;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 600;

        return isCompact
            ? HomeCompactLayout(
              campsites: campsites,
              filteredCampsites: filteredCampsites,
            )
            : HomeWideLayout(
              campsites: campsites,
              filteredCampsites: filteredCampsites,
              width: constraints.maxWidth,
            );
      },
    );
  }
}
