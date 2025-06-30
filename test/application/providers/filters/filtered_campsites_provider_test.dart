import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/application/providers/campsite_provider.dart';
import 'package:wander_nest/application/providers/filters/campsite_filter_model.dart';
import 'package:wander_nest/application/providers/filters/campsite_filter_notifier.dart';
import 'package:wander_nest/application/providers/filters/filtered_campsites_provider.dart';
import 'package:wander_nest/data/models/campsite.dart';
import 'package:wander_nest/data/models/geo_location.dart';

void main() {
  final testCampsites = [
    Campsite(
      id: '1',
      label: 'Alpha Camp',
      isCloseToWater: true,
      isCampFireAllowed: true,
      hostLanguages: ['EN', 'DE'],
      pricePerNight: 50,
      photo: 'photo1.jpg',
      createdAt: DateTime(2023, 1, 1),
      geoLocation: const GeoLocation(lat: 0.0, long: 0.0),
    ),
    Campsite(
      id: '2',
      label: 'Delta Camp',
      isCloseToWater: false,
      isCampFireAllowed: false,
      hostLanguages: ['French'],
      pricePerNight: 30,
      photo: 'photo2.jpg',
      createdAt: DateTime(2023, 2, 1),
      geoLocation: const GeoLocation(lat: 1.0, long: 1.0),
    ),
    Campsite(
      id: '3',
      label: 'Beta Camp',
      isCloseToWater: false,
      isCampFireAllowed: true,
      hostLanguages: ['EN'],
      pricePerNight: 80,
      photo: 'photo3.jpg',
      createdAt: DateTime(2023, 3, 1),
      geoLocation: const GeoLocation(lat: 2.0, long: 2.0),
    ),
  ];

  ProviderContainer makeContainer({
    CampsiteFilter? filter,
    List<Campsite>? campsites,
  }) {
    final container = ProviderContainer(
      overrides: [
        sortedCampsiteListProvider.overrideWithValue(
          campsites ?? testCampsites,
        ),
        campsiteFilterProvider.overrideWith((ref) {
          final notifier = CampsiteFilterNotifier();
          notifier.state = filter ?? const CampsiteFilter();
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
      final filter = const CampsiteFilter(isCloseToWater: true);
      final container = makeContainer(filter: filter);
      final result = container.read(filteredCampsitesProvider);
      expect(result.length, 1);
      expect(result.first.label, 'Alpha Camp');
    });

    test('filters by isCampFireAllowed', () {
      final filter = const CampsiteFilter(isCampFireAllowed: false);
      final container = makeContainer(filter: filter);
      final result = container.read(filteredCampsitesProvider);
      expect(result.length, 1);
      expect(result.first.label, 'Delta Camp');
    });

    test('filters by hostLanguages', () {
      final filter = const CampsiteFilter(hostLanguages: ['DE']);
      final container = makeContainer(filter: filter);
      final result = container.read(filteredCampsitesProvider);
      expect(result.length, 1);
      expect(result.first.label, 'Alpha Camp');
    });

    test('filters by priceRange', () {
      final filter = const CampsiteFilter(priceRange: RangeValues(40, 60));
      final container = makeContainer(filter: filter);
      final result = container.read(filteredCampsitesProvider);
      expect(result.length, 1);
      expect(result.first.label, 'Alpha Camp');
    });

    test('applies multiple filters together', () {
      final filter = const CampsiteFilter(
        isCloseToWater: false,
        isCampFireAllowed: true,
        hostLanguages: ['EN'],
        priceRange: RangeValues(70, 90),
      );
      final container = makeContainer(filter: filter);
      final result = container.read(filteredCampsitesProvider);
      expect(result.length, 1);
      expect(result.first.label, 'Beta Camp');
    });

    test('returns empty list when no campsites match', () {
      final filter = const CampsiteFilter(
        isCloseToWater: true,
        isCampFireAllowed: false,
      );
      final container = makeContainer(filter: filter);
      final result = container.read(filteredCampsitesProvider);
      expect(result, isEmpty);
    });
  });
}
