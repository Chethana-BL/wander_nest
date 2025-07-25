import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:wander_nest/features/campsite/data/models/geo_location.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/maps/domain/entities/map_cluster.dart';
import 'package:wander_nest/features/maps/presentation/providers/map_providers.dart';
import 'package:wander_nest/features/maps/presentation/providers/map_state.dart';
import 'package:wander_nest/shared/providers/filtered_campsites_provider.dart';

final mockCampsite = Campsite(
  id: '1',
  name: 'Alpha Camp',
  photoUrl: 'https://example.com/photo.jpg',
  isCloseToWater: true,
  isCampFireAllowed: true,
  hostLanguages: ['English'],
  pricePerNight: 20.0,
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
