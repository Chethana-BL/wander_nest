import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/core/themes/app_theme.dart';
import 'package:wander_nest/features/campsite/presentation/screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: CampingSiteApp()));
}

class CampingSiteApp extends StatelessWidget {
  const CampingSiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wander Nest',
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const HomeScreen(),
    );
  }
}
