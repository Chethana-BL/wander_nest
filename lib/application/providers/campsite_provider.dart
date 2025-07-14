import 'package:flutter/material.dart';
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

final priceRangeProvider = Provider<RangeValues>((ref) {
  final campsites = ref.watch(sortedCampsiteListProvider);

  if (campsites.isEmpty) return const RangeValues(0, 1000);

  final prices = campsites.map((c) => c.pricePerNight).toList();
  final min = prices.reduce((a, b) => a < b ? a : b);
  final max = prices.reduce((a, b) => a > b ? a : b);
  return RangeValues(min, max);
});
