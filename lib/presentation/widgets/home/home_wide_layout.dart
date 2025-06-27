import 'package:flutter/material.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/data/models/campsite.dart';
import 'package:wander_nest/presentation/widgets/home/campsite_card_tile.dart';

class HomeWideLayout extends StatelessWidget {
  const HomeWideLayout({
    super.key,
    required this.campsites,
    required this.width,
  });

  final List<Campsite> campsites;
  final double width;

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = width ~/ 300;

    return Padding(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: GridView.builder(
        itemCount: campsites.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: AppSizes.space,
          crossAxisSpacing: AppSizes.space,
          childAspectRatio: 0.95,
        ),
        itemBuilder: (context, index) {
          final campsite = campsites[index];
          return CampsiteCardTile(campsite: campsite);
        },
      ),
    );
  }
}
