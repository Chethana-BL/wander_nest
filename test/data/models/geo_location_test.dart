import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/data/models/geo_location.dart';

void main() {
  group('GeoLocation', () {
    test('should create GeoLocation with valid lat/long directly', () {
      const geo = GeoLocation(lat: 45.0, long: 90.0);
      expect(geo.lat, 45.0);
      expect(geo.long, 90.0);
    });

    test('should convert to LatLng', () {
      const geo = GeoLocation(lat: 12.0, long: 34.0);
      final latLng = geo.toLatLng;
      expect(latLng.latitude, geo.lat);
      expect(latLng.longitude, geo.long);
    });

    test('should keep valid coordinates unchanged from JSON', () {
      final json = {'lat': 45.0, 'long': 100.0};
      final geo = GeoLocation.fromJson(json);
      expect(geo.lat, 45.0);
      expect(geo.long, 100.0);
    });

    test('should normalize invalid Web Mercator coordinates from JSON', () {
      // Approx 1000000 meters in Mercator → ~8.983 degrees
      final json = {'lat': 1000000.0, 'long': 1000000.0};
      final geo = GeoLocation.fromJson(json);

      expect(geo.lat, closeTo(8.983, 0.1));
      expect(geo.long, closeTo(8.983, 0.1));
    });

    test('should treat two GeoLocations with same values as equal', () {
      const geo1 = GeoLocation(lat: 10.0, long: 20.0);
      const geo2 = GeoLocation(lat: 10.0, long: 20.0);
      expect(geo1, equals(geo2));
    });

    test('should not equal GeoLocation with different values', () {
      const geo1 = GeoLocation(lat: 10.0, long: 20.0);
      const geo2 = GeoLocation(lat: 15.0, long: 25.0);
      expect(geo1 == geo2, isFalse);
    });
  });
}
