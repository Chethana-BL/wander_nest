import 'package:flutter/material.dart';
import 'package:wander_nest/data/models/campsite.dart';
import 'package:wander_nest/presentation/screens/campsite_detail_screen.dart';

Route _fadeSlideRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      final offsetTween = Tween(
        begin: const Offset(0, 0.1),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOut));
      final fadeTween = Tween<double>(begin: 0, end: 1.0);

      return SlideTransition(
        position: animation.drive(offsetTween),
        child: FadeTransition(
          opacity: animation.drive(fadeTween),
          child: child,
        ),
      );
    },
  );
}

/// Navigates to the campsite detail screen with fade + slide animation
void navigateToCampsiteDetail(BuildContext context, Campsite campsite) {
  Navigator.of(
    context,
  ).push(_fadeSlideRoute(CampsiteDetailScreen(campsite: campsite)));
}
