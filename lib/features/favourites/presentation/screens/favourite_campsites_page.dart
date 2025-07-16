import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/campsite/presentation/providers/campsite_providers.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/campsite_card.dart';
import 'package:wander_nest/features/favourites/presentation/providers/favourites_provider.dart';
import 'package:wander_nest/shared/widgets/animated_lists.dart';

class FavouriteCampsitesPage extends ConsumerWidget {
  const FavouriteCampsitesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCampsites = ref.watch(sortedCampsiteListProvider);
    final favouriteIds = ref.watch(favouritesProvider).toSet();

    final favourites =
        allCampsites
            .where((campsite) => favouriteIds.contains(campsite.id))
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Your Favourites')),
      body:
          favourites.isEmpty
              ? const Center(
                child: Text('No favourites yet. Tap the heart icon to add.'),
              )
              : LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 600;
                  return isWide
                      ? AnimatedGridView<Campsite>(
                        items: favourites,
                        maxWidth: constraints.maxWidth,
                        itemBuilder:
                            (context, campsite) =>
                                CampsiteCard(campsite: campsite),
                      )
                      : AnimatedListView<Campsite>(
                        items: favourites,
                        itemBuilder:
                            (context, campsite) =>
                                CampsiteCard(campsite: campsite),
                      );
                },
              ),
    );
  }
}
