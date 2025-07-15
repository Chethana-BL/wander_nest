import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/core/exceptions/app_exception.dart';
import 'package:wander_nest/core/network/api_executor.dart';

void main() {
  group('ApiExecutor', () {
    test('returns result on success', () async {
      final result = await ApiExecutor.run(() async => 'ok');
      expect(result, 'ok');
    });

    test('throws AppException.parsing on FormatException', () async {
      final call = ApiExecutor.run(
        () async => throw const FormatException('Invalid'),
      );
      expect(
        () => call,
        throwsA(
          isA<AppException>().having(
            (e) => e.type,
            'type',
            AppExceptionType.parsing,
          ),
        ),
      );
    });

    test('throws AppException.unexpected on generic exception', () async {
      final call = ApiExecutor.run(() async => throw Exception('Unknown'));
      expect(
        () => call,
        throwsA(
          isA<AppException>().having(
            (e) => e.type,
            'type',
            AppExceptionType.unexpected,
          ),
        ),
      );
    });
  });
}
