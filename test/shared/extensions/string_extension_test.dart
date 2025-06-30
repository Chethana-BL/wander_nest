import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/shared/extensions/string_extension.dart';

void main() {
  group('StringCasingExtension', () {
    test('capitalizeFirst capitalizes the first letter', () {
      expect('hello'.capitalizeFirst(), 'Hello');
    });

    test('capitalizeFirst returns same string if already capitalized', () {
      expect('Hello'.capitalizeFirst(), 'Hello');
    });

    test('capitalizeFirst handles empty string', () {
      expect(''.capitalizeFirst(), '');
    });

    test('capitalizeFirst does not affect non-letter first character', () {
      expect('1hello'.capitalizeFirst(), '1hello');
    });
  });

  group('StringUrlExtension', () {
    test('secureUrl converts http to https', () {
      expect('http://example.com'.secureUrl(), 'https://example.com');
    });

    test('secureUrl leaves https unchanged', () {
      expect('https://example.com'.secureUrl(), 'https://example.com');
    });

    test('secureUrl leaves non-http URLs unchanged', () {
      expect('ftp://example.com'.secureUrl(), 'ftp://example.com');
    });

    test('secureUrl handles empty string', () {
      expect(''.secureUrl(), '');
    });
  });
}
