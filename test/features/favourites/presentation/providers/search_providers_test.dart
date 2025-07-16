import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/features/campsite/data/models/geo_location.dart';

import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/campsite/presentation/providers/search_providers.dart';
import 'package:wander_nest/shared/providers/filtered_campsites_provider.dart';

void main() {
  group('searchedCampsitesProvider', () {
    final testCampsites = [
      Campsite(
        id: '1',
        name: 'Alpha Camp',
        isCloseToWater: true,
        isCampFireAllowed: true,
        hostLanguages: ['EN', 'DE'],
        pricePerNight: 50,
        photoUrl: 'photo1.jpg',
        geoLocation: const GeoLocation(lat: 10.0, long: 20.0),
      ),
      Campsite(
        id: '2',
        name: 'Delta Camp',
        isCloseToWater: false,
        isCampFireAllowed: false,
        hostLanguages: ['French'],
        pricePerNight: 30,
        photoUrl: 'photo2.jpg',
        geoLocation: const GeoLocation(lat: 20.0, long: 40.0),
      ),
      Campsite(
        id: '3',
        name: 'Beta Camp',
        isCloseToWater: false,
        isCampFireAllowed: true,
        hostLanguages: ['EN'],
        pricePerNight: 80,
        photoUrl: 'photo3.jpg',
        geoLocation: const GeoLocation(lat: 30.0, long: 60.0),
      ),
    ];

    test('returns all campsites when search query is empty', () {
      final container = ProviderContainer(
        overrides: [
          filteredCampsitesProvider.overrideWithValue(testCampsites),
          searchQueryProvider.overrideWith((ref) => ''),
        ],
      );

      final result = container.read(searchedCampsitesProvider);
      expect(result, testCampsites);
    });

    test(
      'returns a matching campsite for partial name match (case-insensitive)',
      () {
        final container = ProviderContainer(
          overrides: [
            filteredCampsitesProvider.overrideWithValue(testCampsites),

            searchQueryProvider.overrideWith((ref) => 'delta'),
          ],
        );

        final result = container.read(searchedCampsitesProvider);
        expect(result.length, 1);
        expect(result.first.name, 'Delta Camp');
      },
    );

    test(
      'returns matching campsites for partial name match (case-insensitive)',
      () {
        final container = ProviderContainer(
          overrides: [
            filteredCampsitesProvider.overrideWithValue(testCampsites),

            searchQueryProvider.overrideWith((ref) => 'camp'),
          ],
        );

        final result = container.read(searchedCampsitesProvider);
        expect(result.length, 3);
        expect(result[0].name, 'Alpha Camp');
        expect(result[1].name, 'Delta Camp');
        expect(result[2].name, 'Beta Camp');
      },
    );

    test('returns empty list when no campsite matches the search', () {
      final container = ProviderContainer(
        overrides: [
          filteredCampsitesProvider.overrideWithValue(testCampsites),
          searchQueryProvider.overrideWith((ref) => 'gamma'),
        ],
      );

      final result = container.read(searchedCampsitesProvider);
      expect(result, isEmpty);
    });
  });
}
