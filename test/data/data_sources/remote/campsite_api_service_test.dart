import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:wander_nest/features/campsite/data/datasources/campsite_api_service.dart';
import 'package:wander_nest/features/campsite/data/models/campsite.dart';

void main() {
  group('CampsiteApiService', () {
    final mockJson = jsonEncode([
      {
        'id': '1',
        'label': 'Camp Alpha',
        'photo': 'https://example.com/photoA.jpg',
        'isCloseToWater': true,
        'isCampFireAllowed': true,
        'hostLanguages': ['EN'],
        'pricePerNight': 40,
        'createdAt': '2023-01-01T00:00:00.000',
        'geoLocation': {'lat': 12.34, 'long': 56.78},
      },
      {
        'id': '2',
        'label': 'Camp Beta',
        'photo': 'https://example.com/photoB.jpg',
        'isCloseToWater': false,
        'isCampFireAllowed': false,
        'hostLanguages': ['EN', 'DE'],
        'pricePerNight': 60,
        'createdAt': '2023-02-01T00:00:00.000',
        'geoLocation': {'lat': 89.43, 'long': 54.32},
      },
    ]);

    test('returns list of Campsite when API call is successful', () async {
      final mockClient = MockClient((request) async {
        return http.Response(mockJson, 200);
      });

      final apiService = CampsiteApiService(client: mockClient);

      final result = await apiService.fetchCampsites();

      expect(result, isA<List<Campsite>>());
      expect(result.length, 2);
      expect(result[0].label, 'Camp Alpha');
      expect(result[0].photo, 'https://example.com/photoA.jpg');
      expect(result[0].isCloseToWater, true);
      expect(result[0].isCampFireAllowed, true);
      expect(result[0].hostLanguages, ['EN']);
      expect(result[0].pricePerNight, 40);
      expect(result[0].createdAt, DateTime.parse('2023-01-01T00:00:00.000'));
      expect(result[0].geoLocation.lat, 12.34);
      expect(result[0].geoLocation.long, 56.78);

      expect(result[1].id, '2');
      expect(result[1].label, 'Camp Beta');
      expect(result[1].photo, 'https://example.com/photoB.jpg');
      expect(result[1].isCloseToWater, false);
      expect(result[1].isCampFireAllowed, false);
      expect(result[1].hostLanguages, ['EN', 'DE']);
      expect(result[1].pricePerNight, 60);
      expect(result[1].createdAt, DateTime.parse('2023-02-01T00:00:00.000'));
      expect(result[1].geoLocation.lat, 89.43);
      expect(result[1].geoLocation.long, 54.32);
    });

    test('throws exception when status code is not 200', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      final apiService = CampsiteApiService(client: mockClient);

      expect(() async => await apiService.fetchCampsites(), throwsException);
    });

    test('throws exception on network error', () async {
      final mockClient = MockClient((request) async {
        throw Exception('No Internet');
      });

      final apiService = CampsiteApiService(client: mockClient);

      expect(() async => await apiService.fetchCampsites(), throwsException);
    });
  });
}
