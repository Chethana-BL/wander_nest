import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/shared/providers/filtered_campsites_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedCampsitesProvider = Provider<List<Campsite>>((ref) {
  final searchQuery = ref.watch(searchQueryProvider).trim().toLowerCase();
  final filteredCampsites = ref.watch(filteredCampsitesProvider);

  if (searchQuery.isEmpty) return filteredCampsites;

  return filteredCampsites
      .where((c) => c.name.toLowerCase().contains(searchQuery))
      .toList();
});
