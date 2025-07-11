import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/core/config/environment.dart';

final environmentProvider = Provider<EnvironmentConfig>((ref) {
  const env = String.fromEnvironment('ENV', defaultValue: 'dev');
  const currentApiVersion = 'v1';

  switch (env) {
    case 'prod':
      return const EnvironmentConfig(
        type: EnvironmentType.prod,
        baseUrl: 'https://api.yourprod.com', // Sample Prod Url
        apiVersion: currentApiVersion,
      );
    case 'staging':
      return const EnvironmentConfig(
        type: EnvironmentType.staging,
        baseUrl: 'https://api.yourstaging.com', // Sample staging Url
        apiVersion: currentApiVersion,
      );
    case 'dev':
    default:
      return const EnvironmentConfig(
        type: EnvironmentType.dev,
        baseUrl: 'https://62ed0389a785760e67622eb2.mockapi.io/spots',
        apiVersion: currentApiVersion,
      );
  }
});
