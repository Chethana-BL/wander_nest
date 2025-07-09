import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/core/constants/app_icons.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/features/filters/presentation/providers/campsite_filter_notifier.dart';

class FilterActionIcon extends ConsumerWidget {
  const FilterActionIcon({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(campsiteFilterProvider);

    final appliedCount = filter.activeFilterCount;

    return Stack(
      children: [
        IconButton(icon: const Icon(AppIcons.filter), onPressed: onPressed),
        if (appliedCount > 0)
          Positioned(
            right: AppSizes.spaceXS,
            top: AppSizes.spaceXS,
            child: CircleAvatar(
              radius: 9,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Text(
                '$appliedCount',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
