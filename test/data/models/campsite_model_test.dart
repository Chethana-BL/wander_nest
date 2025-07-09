import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/features/campsite/data/models/campsite.dart';
import 'package:wander_nest/features/campsite/data/models/geo_location.dart';

void main() {
  group('Campsite Model', () {
    final mockGeoLocation = const GeoLocation(lat: 42.5, long: 21.0);

    final mockJson = {
      'id': '4321',
      'label': 'Forest Edge',
      'photo': 'https://example.com/photo.jpg',
      'createdAt': '2022-09-12T07:54:12.574Z',
      'hostLanguages': ['EN', 'DE'],
      'pricePerNight': 2500.0,
      'isCloseToWater': true,
      'isCampFireAllowed': false,
      'geoLocation': {'lat': mockGeoLocation.lat, 'long': mockGeoLocation.long},
    };

    test('fromJson returns valid Campsite object', () {
      final campsite = Campsite.fromJson(mockJson);

      expect(campsite.id, '4321');
      expect(campsite.label, 'Forest Edge');
      expect(campsite.pricePerNight, 2500.0);
      expect(campsite.isCloseToWater, true);
      expect(campsite.isCampFireAllowed, false);
      expect(campsite.hostLanguages, ['EN', 'DE']);
      expect(campsite.createdAt, DateTime.parse('2022-09-12T07:54:12.574Z'));
      expect(campsite.photo, 'https://example.com/photo.jpg');
      expect(campsite.geoLocation.lat, mockGeoLocation.lat);
      expect(campsite.geoLocation.long, mockGeoLocation.long);
    });
    test('toJson returns correct JSON map', () {
      final campsite = Campsite.fromJson(mockJson);
      final json = campsite.toJson();

      expect(json['id'], '4321');
      expect(json['label'], 'Forest Edge');
      expect(json['photo'], 'https://example.com/photo.jpg');
      expect(json['createdAt'], '2022-09-12T07:54:12.574Z');
      expect(json['hostLanguages'], ['EN', 'DE']);
      expect(json['pricePerNight'], 2500.0);
      expect(json['isCloseToWater'], true);
      expect(json['isCampFireAllowed'], false);

      final geoLocation = json['geoLocation'] as GeoLocation;
      expect(geoLocation.lat, mockGeoLocation.lat);
      expect(geoLocation.long, mockGeoLocation.long);
    });
  });
}
