import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/features/campsite/data/models/campsite.dart';
import 'package:wander_nest/features/campsite/presentation/providers/campsite_provider.dart';
import 'package:wander_nest/features/filters/domain/entities/filter_enums.dart';
import 'package:wander_nest/features/filters/presentation/providers/campsite_filter_notifier.dart';

/// [filteredCampsitesProvider] filters the list of campsites based on the current filter settings.
/// It listens to the [campsiteListProvider] for the full list of campsites
/// and the [campsiteFilterProvider] for the current filter settings.
final filteredCampsitesProvider = Provider<List<Campsite>>((ref) {
  final sortedCampsites = ref.watch(sortedCampsiteListProvider);
  final filter = ref.watch(campsiteFilterProvider);

  return sortedCampsites.where((c) {
    // Handle Close to Water true/false
    // Water filter
    if (filter.waterFilter == WaterFilter.nearWater && !c.isCloseToWater) {
      return false;
    }
    if (filter.waterFilter == WaterFilter.noWater && c.isCloseToWater) {
      return false;
    }

    // Campfire filter
    if (filter.campfireFilter == CampfireFilter.allowed &&
        !c.isCampFireAllowed) {
      return false;
    }
    if (filter.campfireFilter == CampfireFilter.notAllowed &&
        c.isCampFireAllowed) {
      return false;
    }

    // Host languages
    if (filter.hostLanguages.isNotEmpty) {
      if (!c.hostLanguages.any(
        (lang) => filter.hostLanguages
            .map((f) => f.toLowerCase())
            .contains(lang.toLowerCase()),
      )) {
        return false;
      }
    }

    // Price range
    if (filter.priceRange != null) {
      if (c.pricePerNight < filter.priceRange!.start ||
          c.pricePerNight > filter.priceRange!.end) {
        return false;
      }
    }

    return true;
  }).toList();
});
