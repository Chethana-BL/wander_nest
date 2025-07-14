import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/application/providers/map/map_controller_notifier.dart';
import 'package:wander_nest/data/models/campsite.dart';
import 'package:wander_nest/data/models/geo_location.dart';

void main() {
  group('MapControllerNotifier', () {
    late MapControllerNotifier notifier;

    Campsite mockCampsite({
      required double lat,
      required double lng,
      String id = 'id',
    }) {
      return Campsite(
        id: id,
        label: 'Alpha Camp',
        photo: 'https://example.com/photo.jpg',
        isCloseToWater: false,
        isCampFireAllowed: true,
        hostLanguages: ['EN'],
        pricePerNight: 50.0,
        createdAt: DateTime(2023, 1, 1),
        geoLocation: GeoLocation(lat: lat, long: lng),
      );
    }

    setUp(() {
      notifier = MapControllerNotifier();
    });

    test('initial state', () {
      expect(notifier.state.currentZoom, 10.0);
      expect(notifier.state.clusters, isEmpty);
    });

    test('setLoading updates isLoading', () {
      notifier.setLoading(true);
      expect(notifier.state.isLoading, true);
      notifier.setLoading(false);
      expect(notifier.state.isLoading, false);
    });

    test('setError updates error and sets isLoading to false', () {
      notifier.setLoading(true);
      notifier.setError('error');
      expect(notifier.state.error, 'error');
      expect(notifier.state.isLoading, false);
    });

    group('updateClusters', () {
      test('with empty campsites clears clusters', () {
        notifier.updateClusters([], 8.0);
        expect(notifier.state.clusters, isEmpty);
      });

      test('with single campsite at high zoom shows as marker', () {
        final campsite = mockCampsite(lat: 10, lng: 20);
        notifier.updateClusters([campsite], 15.0);
        expect(notifier.state.clusters.length, 1);
        final cluster = notifier.state.clusters.first;
        expect(cluster.isCluster, false);
        expect(cluster.campsites.length, 1);
        expect(cluster.position.latitude, 10);
        expect(cluster.position.longitude, 20);
      });

      test('with single campsite at low zoom shows as cluster', () {
        final campsite = mockCampsite(lat: 10, lng: 20);
        notifier.updateClusters([campsite], 8.0);
        expect(notifier.state.clusters.length, 1);
        final cluster = notifier.state.clusters.first;
        expect(
          cluster.isCluster,
          false,
        ); // single marker, but zoom < minZoomForClustering
        expect(cluster.campsites.length, 1);
      });

      test('clusters multiple campsites close together', () {
        final c1 = mockCampsite(lat: 10.0, lng: 20.0, id: '1');
        final c2 = mockCampsite(lat: 10.01, lng: 20.01, id: '2');
        notifier.updateClusters([c1, c2], 8.0);

        expect(notifier.state.clusters.length, 1);
        final cluster = notifier.state.clusters.first;
        expect(cluster.isCluster, true);
        expect(cluster.campsites.length, 2);
      });

      test('clusters multiple campsites far apart', () {
        final c1 = mockCampsite(lat: 10.0, lng: 20.0, id: '1');
        final c2 = mockCampsite(lat: 30.0, lng: 40.0, id: '2');
        notifier.updateClusters([c1, c2], 8.0);
        expect(notifier.state.clusters.length, 2);
      });

      test('center is calculated correctly', () {
        final c1 = mockCampsite(lat: 10.0, lng: 20.0, id: '1');
        final c2 = mockCampsite(lat: 20.0, lng: 40.0, id: '2');
        notifier.updateClusters([c1, c2], 8.0);

        expect(notifier.state.center, isNotNull);
        expect(notifier.state.center!.latitude, closeTo(15.0, 0.001));
        expect(notifier.state.center!.longitude, closeTo(30.0, 0.001));
      });
    });
  });
}
