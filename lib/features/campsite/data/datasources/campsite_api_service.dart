import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wander_nest/features/campsite/data/models/campsite.dart';

class CampsiteApiService {
  CampsiteApiService({http.Client? client}) : client = client ?? http.Client();
  static const _baseUrl =
      'https://62ed0389a785760e67622eb2.mockapi.io/spots/v1';
  final http.Client client;

  Future<List<Campsite>> fetchCampsites() async {
    try {
      final response = await client.get(Uri.parse('$_baseUrl/campsites'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Campsite.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load campsites: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Campsite fetch error: $e');
    }
  }
}
