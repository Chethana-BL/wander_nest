import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/features/campsite/data/datasources/campsite_api_service.dart';
import 'package:wander_nest/features/campsite/data/models/campsite.dart';

/// Provider for the CampsiteApiService instance
/// This service is responsible for fetching campsite data from the API.
final campsiteApiServiceProvider = Provider<CampsiteApiService>((ref) {
  return CampsiteApiService();
});

/// Raw campsite list fetched from the API
final campsiteListProvider = FutureProvider<List<Campsite>>((ref) async {
  final apiService = ref.watch(campsiteApiServiceProvider);
  return apiService.fetchCampsites();
});

/// Sorted campsite list (by label)
final sortedCampsiteListProvider = Provider<List<Campsite>>((ref) {
  final asyncValue = ref.watch(campsiteListProvider);

  return asyncValue.maybeWhen(
    data: (list) {
      list.sort(
        (a, b) => a.label.toLowerCase().compareTo(b.label.toLowerCase()),
      );
      return list;
    },
    orElse: () => [],
  );
});
