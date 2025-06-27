import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/data/models/campsite.dart';

void main() {
  group('Campsite Model', () {
    final mockJson = {
      'id': '4321',
      'label': 'Forest Edge',
      'photo': 'https://example.com/photo.jpg',
      'createdAt': '2022-09-12T07:54:12.574Z',
      'hostLanguages': ['EN', 'DE'],
      'pricePerNight': 25.0,
      'isCloseToWater': true,
      'isCampFireAllowed': false,
    };

    test('fromJson returns valid Campsite object', () {
      final campsite = Campsite.fromJson(mockJson);

      expect(campsite.id, '4321');
      expect(campsite.label, 'Forest Edge');
      expect(campsite.pricePerNight, 25.0);
      expect(campsite.isCloseToWater, true);
      expect(campsite.isCampFireAllowed, false);
      expect(campsite.hostLanguages, ['EN', 'DE']);
      expect(campsite.createdAt, DateTime.parse('2022-09-12T07:54:12.574Z'));
      expect(campsite.photo, 'https://example.com/photo.jpg');
    });

    test('toJson returns correct map', () {
      final campsite = Campsite.fromJson(mockJson);
      final json = campsite.toJson();

      expect(json, mockJson);
    });
  });
}
