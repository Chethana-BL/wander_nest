import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wander_nest/features/campsite/data/models/campsite.dart';
import 'package:wander_nest/features/campsite/data/models/geo_location.dart';
import 'package:wander_nest/features/campsite/presentation/providers/campsite_provider.dart';
import 'package:wander_nest/features/filters/presentation/providers/price_range_provider.dart';

import '../../mocks/mocks.mocks.dart';

void main() {
  late MockCampsiteApiService mockApi;
  late ProviderContainer container;

  final mockCampsites = [
    Campsite(
      id: '1',
      label: 'Beta Camp',
      photo: 'url1',
      isCloseToWater: true,
      isCampFireAllowed: true,
      hostLanguages: ['EN'],
      pricePerNight: 500,
      createdAt: DateTime.parse('2023-01-01'),
      geoLocation: const GeoLocation(lat: 20.0, long: 30.0),
    ),
    Campsite(
      id: '2',
      label: 'Alpha Camp',
      photo: 'url2',
      isCloseToWater: false,
      isCampFireAllowed: true,
      hostLanguages: ['DE'],
      pricePerNight: 700,
      createdAt: DateTime.parse('2023-01-02'),
      geoLocation: const GeoLocation(lat: 40.0, long: 50.0),
    ),
  ];

  setUp(() {
    mockApi = MockCampsiteApiService();

    container = ProviderContainer(
      overrides: [campsiteApiServiceProvider.overrideWithValue(mockApi)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('campsiteListProvider', () {
    test('returns data from mock API', () async {
      when(mockApi.fetchCampsites()).thenAnswer((_) async => mockCampsites);

      final result = await container.read(campsiteListProvider.future);

      expect(result.length, 2);
      expect(result[0].label, 'Beta Camp');
      expect(result[1].label, 'Alpha Camp');
    });

    test('handles API error gracefully', () async {
      when(mockApi.fetchCampsites()).thenThrow(Exception('API error'));

      final asyncValue = await container
          .read(campsiteListProvider.future)
          .then<AsyncValue<List<Campsite>>>(
            (_) => container.read(campsiteListProvider),
            onError: (error) => container.read(campsiteListProvider),
          );

      expect(asyncValue, isA<AsyncValue<List<Campsite>>>());
      expect(asyncValue.hasError, true);
    });
  });

  group('sortedCampsiteListProvider', () {
    test('returns list sorted by label', () async {
      when(mockApi.fetchCampsites()).thenAnswer((_) async => mockCampsites);

      await container.read(campsiteListProvider.future);
      final sorted = container.read(sortedCampsiteListProvider);

      expect(sorted.first.label, 'Alpha Camp');
      expect(sorted.last.label, 'Beta Camp');
    });

    test('returns empty list when no data', () async {
      when(mockApi.fetchCampsites()).thenAnswer((_) async => []);

      await container.read(campsiteListProvider.future);
      final sorted = container.read(sortedCampsiteListProvider);

      expect(sorted, isEmpty);
    });

    test('does not mutate original list', () async {
      when(mockApi.fetchCampsites()).thenAnswer((_) async => mockCampsites);

      final original = List<Campsite>.from(mockCampsites);
      await container.read(campsiteListProvider.future);
      container.read(sortedCampsiteListProvider);

      expect(mockCampsites[0].label, original[0].label);
      expect(mockCampsites[1].label, original[1].label);
    });
  });

  group('priceRangeProvider', () {
    test('returns correct price range', () async {
      when(mockApi.fetchCampsites()).thenAnswer((_) async => mockCampsites);

      await container.read(campsiteListProvider.future);
      final range = container.read(priceRangeProvider);

      expect(range.start, 500);
      expect(range.end, 700);
    });

    test('returns default range when no campsites', () async {
      when(mockApi.fetchCampsites()).thenAnswer((_) async => []);

      await container.read(campsiteListProvider.future);
      final range = container.read(priceRangeProvider);

      expect(range.start, 0);
      expect(range.end, 1000);
    });
  });
}
