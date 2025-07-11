enum EnvironmentType { dev, staging, prod }

class EnvironmentConfig {
  const EnvironmentConfig({
    required this.type,
    required this.baseUrl,
    required this.apiVersion,
  });
  final EnvironmentType type;
  final String baseUrl;
  final String apiVersion;

  String get fullApiUrl => '$baseUrl/$apiVersion';
}
