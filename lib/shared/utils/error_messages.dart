import 'package:wander_nest/core/exceptions/app_exception.dart';

/// A helper class to convert AppExceptions into user-readable messages.
class ErrorMessages {
  static String fromException(AppException exception) {
    switch (exception.type) {
      case AppExceptionType.network:
        return 'Please check your internet connection.';
      case AppExceptionType.parsing:
        return 'Failed to load the data.';
      case AppExceptionType.unexpected:
        return 'Something unexpected happened.';
    }
  }

  static String from(Object error) {
    if (error is AppException) {
      return fromException(error);
    }
    return 'An error occurred. Please try again.';
  }
}
