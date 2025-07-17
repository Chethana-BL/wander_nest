import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/core/navigation/app_router.dart';
import 'package:wander_nest/core/themes/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: CampingSiteApp()));
}

class CampingSiteApp extends StatelessWidget {
  const CampingSiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Wander Nest',
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
