import 'package:wander_nest/core/exceptions/app_exception.dart';
import 'package:wander_nest/shared/utils/logger.dart';

class ApiExecutor {
  // Runs any async API call and handles errors uniformly
  static Future<T> run<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on FormatException catch (e) {
      Logger.logError('Parsing error', e);
      throw AppException.parsing(e.toString());
    } on Exception catch (e) {
      Logger.logError('Generic network/unexpected error', e);
      throw AppException.unexpected(e.toString());
    }
  }
}
