import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:wander_nest/application/providers/filters/filtered_campsites_provider.dart';
import 'package:wander_nest/application/providers/map/map_providers.dart';
import 'package:wander_nest/application/providers/map/map_state.dart';
import 'package:wander_nest/data/models/campsite.dart';
import 'package:wander_nest/data/models/geo_location.dart';
import 'package:wander_nest/data/models/map_cluster.dart';

final mockCampsite = Campsite(
  id: '1',
  label: 'Alpha Camp',
  photo: 'https://example.com/photo.jpg',
  isCloseToWater: true,
  isCampFireAllowed: true,
  hostLanguages: ['English'],
  pricePerNight: 20.0,
  createdAt: DateTime(2023, 1, 1),
  geoLocation: const GeoLocation(lat: 0.0, long: 0.0),
);

final mockCluster = MapCluster(
  position: const LatLng(0.0, 0.0),
  campsites: [mockCampsite],
  isCluster: true,
);

void main() {
  group('mapControllerProvider', () {
    test('provides initial MapState', () {
      final container = ProviderContainer();
      final state = container.read(mapControllerProvider);
      expect(state, isA<MapState>());
      expect(state.currentZoom, isNotNull);
      expect(state.clusters, isA<List<MapCluster>>());
    });

    test('can update clusters via notifier', () {
      final container = ProviderContainer();
      final notifier = container.read(mapControllerProvider.notifier);

      final campsites = [mockCampsite];
      notifier.updateClusters(campsites, 10.0);

      final state = container.read(mapControllerProvider);
      expect(state.clusters, isA<List<MapCluster>>());
    });
  });

  group('mapClustersProvider', () {
    testWidgets('returns empty list when filtered campsites are empty', (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [
          // Override filteredCampsitesProvider to return empty list
          filteredCampsitesProvider.overrideWith((ref) => []),
        ],
      );

      final clusters = container.read(mapClustersProvider);
      expect(clusters.value, isEmpty);
    });
  });
}
