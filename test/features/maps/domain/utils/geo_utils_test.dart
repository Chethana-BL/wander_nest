import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/features/campsite/data/models/geo_location.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/maps/domain/utils/geo_utils.dart';

void main() {
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
  group('GeoUtils', () {
    test('calculateCenter returns correct center for multiple campsites', () {
      final center = GeoUtils.calculateCenter(testCampsites);

      expect(center.latitude, closeTo(20.0, 0.0001));
      expect(center.longitude, closeTo(40.0, 0.0001));
    });

    test('calculateCenter handles empty list gracefully', () {
      expect(() => GeoUtils.calculateCenter([]), throwsA(isA<ArgumentError>()));
    });
  });
}
