import 'package:flutter/material.dart';
import 'package:wander_nest/core/themes/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wander Nest',
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const Scaffold(
        body: Center(
          child: Text(
            'Hello \n Welcome to Wander Nest!',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
