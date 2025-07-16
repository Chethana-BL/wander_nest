import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/features/campsite/data/models/geo_location.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/campsite/presentation/providers/campsite_providers.dart';
import 'package:wander_nest/features/filters/domain/entities/filter_enums.dart';
import 'package:wander_nest/features/filters/domain/entities/filter_state.dart';
import 'package:wander_nest/features/filters/presentation/providers/campsite_filter_notifier.dart';
import 'package:wander_nest/shared/providers/filtered_campsites_provider.dart';

void main() {
  final testCampsites = [
    Campsite(
      id: '1',
      name: 'Alpha Camp',
      isCloseToWater: true,
      isCampFireAllowed: true,
      hostLanguages: ['EN', 'DE'],
      pricePerNight: 50,
      photoUrl: 'photo1.jpg',
      geoLocation: const GeoLocation(lat: 0.0, long: 0.0),
    ),
    Campsite(
      id: '2',
      name: 'Delta Camp',
      isCloseToWater: false,
      isCampFireAllowed: false,
      hostLanguages: ['French'],
      pricePerNight: 30,
      photoUrl: 'photo2.jpg',
      geoLocation: const GeoLocation(lat: 1.0, long: 1.0),
    ),
    Campsite(
      id: '3',
      name: 'Beta Camp',
      isCloseToWater: false,
      isCampFireAllowed: true,
      hostLanguages: ['EN'],
      pricePerNight: 80,
      photoUrl: 'photo3.jpg',
      geoLocation: const GeoLocation(lat: 2.0, long: 2.0),
    ),
  ];

  ProviderContainer makeContainer({
    FilterState? filter,
    List<Campsite>? campsites,
  }) {
    final container = ProviderContainer(
      overrides: [
        sortedCampsiteListProvider.overrideWithValue(
          campsites ?? testCampsites,
        ),
        campsiteFilterProvider.overrideWith((ref) {
          final notifier = CampsiteFilterNotifier();
          notifier.state = filter ?? const FilterState();
          return notifier;
        }),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('filteredCampsitesProvider', () {
    test('returns all campsites when no filters are applied', () {
      final container = makeContainer();
      final result = container.read(filteredCampsitesProvider);
      expect(result, testCampsites);
    });

    test('filters by isCloseToWater', () {
      final filter = const FilterState(waterFilter: WaterFilter.nearWater);
      final container = makeContainer(filter: filter);
      final result = container.read(filteredCampsitesProvider);
      expect(result.length, 1);
      expect(result.first.name, 'Alpha Camp');
    });

    test('filters by isCampFireAllowed', () {
      final filter = const FilterState(
        campfireFilter: CampfireFilter.notAllowed,
      );
      final container = makeContainer(filter: filter);
      final result = container.read(filteredCampsitesProvider);
      expect(result.length, 1);
      expect(result.first.name, 'Delta Camp');
    });

    test('filters by hostLanguages', () {
      final filter = const FilterState(hostLanguages: ['DE']);
      final container = makeContainer(filter: filter);
      final result = container.read(filteredCampsitesProvider);
      expect(result.length, 1);
      expect(result.first.name, 'Alpha Camp');
    });

    test('filters by priceRange', () {
      final filter = const FilterState(priceRange: RangeValues(40, 60));
      final container = makeContainer(filter: filter);
      final result = container.read(filteredCampsitesProvider);
      expect(result.length, 1);
      expect(result.first.name, 'Alpha Camp');
    });

    test('applies multiple filters together', () {
      final filter = const FilterState(
        waterFilter: WaterFilter.noWater,
        campfireFilter: CampfireFilter.allowed,
        hostLanguages: ['EN'],
        priceRange: RangeValues(70, 90),
      );
      final container = makeContainer(filter: filter);
      final result = container.read(filteredCampsitesProvider);
      expect(result.length, 1);
      expect(result.first.name, 'Beta Camp');
    });

    test('returns empty list when no campsites match', () {
      final filter = const FilterState(
        waterFilter: WaterFilter.nearWater,
        campfireFilter: CampfireFilter.notAllowed,
      );
      final container = makeContainer(filter: filter);
      final result = container.read(filteredCampsitesProvider);
      expect(result, isEmpty);
    });
  });
}
