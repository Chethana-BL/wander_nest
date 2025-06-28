import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/data/models/campsite.dart';
import 'package:wander_nest/presentation/widgets/home/campsite_card.dart';

class HomeCompactLayout extends ConsumerWidget {
  const HomeCompactLayout({super.key, required this.campsites});

  final List<Campsite> campsites;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget content = const Center(child: Text('No Campsites Available'));

    if (campsites.isNotEmpty) {
      content = ListView.separated(
        padding: const EdgeInsets.all(AppSizes.padding),
        itemCount: campsites.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSizes.space),
        itemBuilder: (context, index) {
          final campsite = campsites[index];
          return CampsiteCard(campsite: campsite);
        },
      );
    }

    return content;
  }
}
