import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/core/exceptions/app_exception.dart';
import 'package:wander_nest/shared/utils/error_messages.dart';

void main() {
  group('ErrorMessages', () {
    test('returns correct message for network exception', () {
      final msg = ErrorMessages.from(AppException.network());
      expect(msg, 'Please check your internet connection.');
    });

    test('returns correct message for parsing exception', () {
      final msg = ErrorMessages.from(AppException.parsing());
      expect(msg, 'Failed to load the data.');
    });

    test('returns correct message for unexpected exception', () {
      final msg = ErrorMessages.from(AppException.unexpected());
      expect(msg, 'Something unexpected happened.');
    });

    test('returns correct message for non AppException error', () {
      final msg = ErrorMessages.from(Error());
      expect(msg, 'An error occurred. Please try again.');
    });
  });
}
