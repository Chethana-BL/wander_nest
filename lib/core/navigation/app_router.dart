import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/campsite/presentation/screens/campsite_detail_screen.dart';
import 'package:wander_nest/features/campsite/presentation/screens/home_screen.dart';
import 'package:wander_nest/features/favourites/presentation/screens/favourite_campsites_page.dart';
import 'package:wander_nest/features/maps/presentation/screens/map_screen.dart';

import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.homeName,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.map,
      name: AppRoutes.mapName,
      builder: (context, state) => const MapScreen(),
    ),
    GoRoute(
      path: AppRoutes.favourites,
      name: AppRoutes.favouritesName,
      builder: (context, state) => const FavouriteCampsitesPage(),
    ),
    GoRoute(
      path: AppRoutes.campsiteDetail,
      name: AppRoutes.campsiteDetailName,
      pageBuilder: (context, state) {
        final campsite = state.extra as Campsite;

        return CustomTransitionPage(
          child: CampsiteDetailScreen(campsite: campsite),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween(
              begin: const Offset(0.0, 0.1),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOut));
            final fadeTween = Tween<double>(begin: 0, end: 1);

            return SlideTransition(
              position: animation.drive(tween),
              child: FadeTransition(
                opacity: animation.drive(fadeTween),
                child: child,
              ),
            );
          },
        );
      },
    ),
  ],
);
