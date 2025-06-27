import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/data/datasources/remote/campsite_api_service.dart';
import 'package:wander_nest/data/models/campsite.dart';

/// Provider for the CampsiteApiService instance
/// This service is responsible for fetching campsite data from the API.
final campsiteApiServiceProvider = Provider<CampsiteApiService>((ref) {
  return CampsiteApiService();
});

/// Raw campsite list fetched from the API
final campsiteListProvider = FutureProvider<List<Campsite>>((ref) async {
  final apiService = ref.watch(campsiteApiServiceProvider);
  final campsites = await apiService.fetchCampsites();
  return campsites;
});

/// Sorted campsite list (by label)
final sortedCampsiteListProvider = Provider<List<Campsite>>((ref) {
  final asyncValue = ref.watch(campsiteListProvider);

  return asyncValue.maybeWhen(
    data:
        (list) => [...list]..sort(
          (a, b) => a.label.toLowerCase().compareTo(b.label.toLowerCase()),
        ),
    orElse: () => [],
  );
});
