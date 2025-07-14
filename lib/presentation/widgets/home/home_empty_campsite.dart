import 'package:flutter/material.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/shared/extensions/color_extensions.dart';

class NoCampsiteFound extends StatelessWidget {
  const NoCampsiteFound({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingLG),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Icon(
                  Icons.search_off,
                  size: AppSizes.iconXL,
                  color: Theme.of(context).colorScheme.onSurface.alphaF(0.6),
                ),
                const SizedBox(height: AppSizes.paddingSM),
                Text(
                  'No Capsite Found',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.alphaF(0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Try adjusting your filters or search criteria.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.alphaF(0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
