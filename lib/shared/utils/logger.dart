import 'package:flutter/foundation.dart';

class Logger {
  Logger._();

  /// Logs general info
  static void logInfo(String message) {
    if (kDebugMode) {
      print('[INFO] $message');
    }
  }

  /// Logs warning
  static void logWarning(String message) {
    if (kDebugMode) {
      print('[WARNING] $message');
    }
  }

  /// Logs error with optional stacktrace
  static void logError(String message, Object error, [StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('[ERROR] $message: $error');
      if (stackTrace != null) {
        print(stackTrace);
      }
    }
  }
}
