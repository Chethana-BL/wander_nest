import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/features/campsite/presentation/providers/campsite_providers.dart';

final priceRangeProvider = Provider<RangeValues>((ref) {
  final campsites = ref.watch(sortedCampsiteListProvider);

  if (campsites.isEmpty) return const RangeValues(0, 1000);

  final prices = campsites.map((c) => c.pricePerNight).toList();
  final min = prices.reduce((a, b) => a < b ? a : b);
  final max = prices.reduce((a, b) => a > b ? a : b);
  return RangeValues(min, max);
});

final hostLanguagesProvider = Provider<List<String>>((ref) {
  final campsites = ref.watch(sortedCampsiteListProvider);

  final allLanguages =
      campsites
          .expand((c) => c.hostLanguages)
          .toSet()
          .map((lang) => lang.toUpperCase())
          .toList()
        ..sort();
  return allLanguages;
});
