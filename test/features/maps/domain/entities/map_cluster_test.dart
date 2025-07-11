import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:wander_nest/features/campsite/data/models/geo_location.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/maps/domain/entities/map_cluster.dart';

void main() {
  group('MapCluster', () {
    final campsite1 = Campsite(
      id: '1',
      name: 'Alpha Camp',
      photoUrl: 'photo1.jpg',
      isCloseToWater: true,
      isCampFireAllowed: true,
      hostLanguages: ['English'],
      pricePerNight: 50.0,
      geoLocation: const GeoLocation(lat: 10.0, long: 20.0),
    );
    final campsite2 = Campsite(
      id: '2',
      name: 'Beta Camp',
      photoUrl: 'photo2.jpg',
      isCloseToWater: false,
      isCampFireAllowed: false,
      hostLanguages: ['Spanish'],
      pricePerNight: 60.0,
      geoLocation: const GeoLocation(lat: 11.0, long: 21.0),
    );

    test('should create a MapCluster with correct properties', () {
      final cluster = MapCluster(
        position: const LatLng(10.0, 20.0),
        campsites: [campsite1, campsite2],
        isCluster: true,
      );

      expect(cluster.position.latitude, 10.0);
      expect(cluster.position.longitude, 20.0);
      expect(cluster.campsites, [campsite1, campsite2]);
      expect(cluster.isCluster, true);
    });

    test('count returns the number of campsites', () {
      final cluster = MapCluster(
        position: const LatLng(0, 0),
        campsites: [campsite1, campsite2],
        isCluster: true,
      );
      expect(cluster.count, 2);
    });

    test('firstCampsite returns the first campsite', () {
      final cluster = MapCluster(
        position: const LatLng(0, 0),
        campsites: [campsite1, campsite2],
        isCluster: false,
      );
      expect(cluster.firstCampsite, campsite1);
    });

    test('isCluster is false for single campsite', () {
      final cluster = MapCluster(
        position: const LatLng(0, 0),
        campsites: [campsite1],
        isCluster: false,
      );
      expect(cluster.isCluster, false);
      expect(cluster.count, 1);
      expect(cluster.firstCampsite, campsite1);
    });
  });
}
