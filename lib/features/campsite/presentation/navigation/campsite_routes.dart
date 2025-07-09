import 'package:flutter/material.dart';
import 'package:wander_nest/core/navigation/navigation_helpers.dart';
import 'package:wander_nest/features/campsite/data/models/campsite.dart';
import 'package:wander_nest/features/campsite/presentation/screens/campsite_detail_screen.dart';

/// Navigates to the campsite detail screen with fade + slide animation
void navigateToCampsiteDetail(BuildContext context, Campsite campsite) {
  Navigator.of(
    context,
  ).push(fadeSlideRoute(CampsiteDetailScreen(campsite: campsite)));
}
