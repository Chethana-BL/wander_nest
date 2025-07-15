enum AppExceptionType { network, parsing, unexpected }

class AppException implements Exception {
  AppException._(this.type, [this.message, this.stackTrace]);

  factory AppException.network([String? msg, StackTrace? st]) =>
      AppException._(AppExceptionType.network, msg, st);

  factory AppException.parsing([String? msg, StackTrace? st]) =>
      AppException._(AppExceptionType.parsing, msg, st);

  factory AppException.unexpected([String? msg, StackTrace? st]) =>
      AppException._(AppExceptionType.unexpected, msg, st);

  final String? message; // Optional debug message
  final AppExceptionType type;
  final StackTrace? stackTrace;

  @override
  String toString() => 'AppException($type): $message';
}
