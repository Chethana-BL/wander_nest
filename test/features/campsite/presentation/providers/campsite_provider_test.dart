import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wander_nest/features/campsite/data/models/campsite_model.dart';
import 'package:wander_nest/features/campsite/data/models/geo_location.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/campsite/presentation/providers/campsite_providers.dart';

import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockCampsiteRemoteDataSource mockDataSource;
  late ProviderContainer container;

  final mockCampsites = [
    CampsiteModel(
      id: '1',
      label: 'Beta Camp',
      photo: 'https://example.com/photo.jpg',
      isCloseToWater: true,
      isCampFireAllowed: true,
      hostLanguages: ['EN'],
      pricePerNight: 500,
      createdAt: DateTime.parse('2023-01-01'),
      geoLocation: const GeoLocation(lat: 20.0, long: 30.0),
    ),
    CampsiteModel(
      id: '2',
      label: 'Alpha Camp',
      photo: 'https://example.com/photo.jpg',
      isCloseToWater: false,
      isCampFireAllowed: true,
      hostLanguages: ['DE'],
      pricePerNight: 700,
      createdAt: DateTime.parse('2023-01-01'),
      geoLocation: const GeoLocation(lat: 40.0, long: 50.0),
    ),
  ];

  setUp(() {
    mockDataSource = MockCampsiteRemoteDataSource();

    container = ProviderContainer(
      overrides: [campsiteDataSourceProvider.overrideWithValue(mockDataSource)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('campsiteListProvider', () {
    test('returns data from mock API', () async {
      when(
        mockDataSource.fetchCampsites(),
      ).thenAnswer((_) async => mockCampsites);

      final result = await container.read(campsiteListProvider.future);

      expect(result.length, 2);
      expect(result[0].name, 'Beta Camp');
      expect(result[1].name, 'Alpha Camp');
    });

    test('handles API error gracefully', () async {
      when(mockDataSource.fetchCampsites()).thenThrow(Exception('API error'));

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
    test('returns list sorted by name', () async {
      when(
        mockDataSource.fetchCampsites(),
      ).thenAnswer((_) async => mockCampsites);

      await container.read(campsiteListProvider.future);
      final sorted = container.read(sortedCampsiteListProvider);

      expect(sorted.first.name, 'Alpha Camp');
      expect(sorted.last.name, 'Beta Camp');
    });

    test('returns empty list when no data', () async {
      when(mockDataSource.fetchCampsites()).thenAnswer((_) async => []);

      await container.read(campsiteListProvider.future);
      final sorted = container.read(sortedCampsiteListProvider);

      expect(sorted, isEmpty);
    });

    test('does not mutate the original mock list', () async {
      when(
        mockDataSource.fetchCampsites(),
      ).thenAnswer((_) async => mockCampsites);

      final original = List<Campsite>.from(
        mockCampsites.map((m) => Campsite.fromModel(m)),
      );

      await container.read(campsiteListProvider.future);
      container.read(sortedCampsiteListProvider);

      expect(Campsite.fromModel(mockCampsites[0]).name, original[0].name);
      expect(Campsite.fromModel(mockCampsites[1]).name, original[1].name);
    });
  });
}
