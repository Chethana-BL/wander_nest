import 'package:flutter/material.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/shared/extensions/color_extensions.dart';

class AppTaglineBanner extends StatelessWidget {
  const AppTaglineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceSM),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.padding),
        decoration: BoxDecoration(
          color: color.alphaF(0.05),
          borderRadius: BorderRadius.circular(AppSizes.radius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.park_outlined, color: color),
            const SizedBox(width: AppSizes.spaceSM),
            Flexible(
              child: Text(
                'Discover, Filter & Book Serene Campsites Easily',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
