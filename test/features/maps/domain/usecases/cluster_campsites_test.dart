import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/features/campsite/data/models/geo_location.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/maps/domain/usecases/cluster_campsites.dart';

void main() {
  group('ClusterCampsites', () {
    final clusterCampsites = ClusterCampsites();
    final lowZoom = 8.0;
    final highZoom = 15.0;

    Campsite mockCampsite({required double lat, required double lng}) {
      return Campsite(
        id: '1',
        name: 'Alpha Camp',
        isCloseToWater: true,
        isCampFireAllowed: true,
        hostLanguages: ['EN', 'DE'],
        pricePerNight: 50,
        photoUrl: 'photo1.jpg',
        geoLocation: GeoLocation(lat: lat, long: lng),
      );
    }

    test('returns empty cluster list when campsites list is empty', () {
      final result = clusterCampsites([], 10.0);
      expect(result, isEmpty);
    });

    test(
      'returns individual markers for campsites when zoom is high enough',
      () {
        final campsite = mockCampsite(lat: 10.0, lng: 20.0);
        final result = clusterCampsites([campsite], highZoom);

        expect(result.length, 1);
        expect(result.first.isCluster, false);
        expect(result.first.campsites.first, campsite);
      },
    );

    test(
      'returns a cluster when zoom is low and multiple campsites are close',
      () {
        final campsite1 = mockCampsite(lat: 10.001, lng: 20.001);
        final campsite2 = mockCampsite(lat: 10.002, lng: 20.002);

        final result = clusterCampsites([campsite1, campsite2], lowZoom);

        expect(result.length, 1);
        expect(result.first.isCluster, true);
        expect(result.first.count, 2);
      },
    );

    test(
      'returns a cluster when zoom is low and multiple campsites are distant',
      () {
        final campsite1 = mockCampsite(lat: 10.0, lng: 20.0);
        final campsite2 = mockCampsite(lat: 50.0, lng: 80.0);

        final result = clusterCampsites([campsite1, campsite2], lowZoom);

        expect(result.length, 2);
        expect(result.every((c) => c.isCluster), isFalse);
      },
    );
  });
}
