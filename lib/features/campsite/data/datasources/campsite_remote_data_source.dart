import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wander_nest/core/config/api_endpoints.dart';
import 'package:wander_nest/core/exceptions/app_exception.dart';
import 'package:wander_nest/core/network/api_executor.dart';
import 'package:wander_nest/features/campsite/data/datasources/campsite_data_source.dart';
import 'package:wander_nest/features/campsite/data/models/campsite_model.dart';

class CampsiteRemoteDataSource implements CampsiteDataSource {
  CampsiteRemoteDataSource({required this.baseUrl, http.Client? client})
    : client = client ?? http.Client();
  final http.Client client;
  final String baseUrl;

  @override
  Future<List<CampsiteModel>> fetchCampsites() async {
    return ApiExecutor.run(() async {
      final response = await client.get(
        Uri.parse('$baseUrl/${ApiEndpoints.campsites}'),
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((e) => CampsiteModel.fromJson(e)).toList();
      } else {
        throw AppException.unexpected('Server error: ${response.statusCode}');
      }
    });
  }
}
