import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/application/providers/campsite_provider.dart';
import 'package:wander_nest/data/models/campsite.dart';

import 'campsite_filter_notifier.dart';

/// [filteredCampsitesProvider] filters the list of campsites based on the current filter settings.
/// It listens to the `campsiteListProvider` for the full list of campsites
/// and the `campsiteFilterProvider` for the current filter settings.
final filteredCampsitesProvider = Provider<List<Campsite>>((ref) {
  final allCampsites = ref
      .watch(campsiteListProvider)
      .maybeWhen(data: (data) => data, orElse: () => <Campsite>[]);
  final filter = ref.watch(campsiteFilterProvider);

  return allCampsites.where((c) {
    // Handle Close to Water true/false
    if (filter.isCloseToWater == true && !c.isCloseToWater) return false;
    if (filter.isCloseToWater == false && c.isCloseToWater) return false;

    // Handle Campfire Allowed true/false
    if (filter.isCampFireAllowed == true && !c.isCampFireAllowed) return false;
    if (filter.isCampFireAllowed == false && c.isCampFireAllowed) return false;

    // Host languages
    if (filter.hostLanguages != null && filter.hostLanguages!.isNotEmpty) {
      final matchesLanguage = c.hostLanguages.any(
        (lang) => filter.hostLanguages!.any(
          (fLang) => fLang.toLowerCase() == lang.toLowerCase(),
        ),
      );
      if (!matchesLanguage) return false;
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
