import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/application/providers/campsite_provider.dart';
import 'package:wander_nest/application/providers/filters/campsite_filter_notifier.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/shared/extensions/color_extensions.dart';

class ActiveFilterChips extends ConsumerWidget {
  const ActiveFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(campsiteFilterProvider);
    final initialPriceRange = ref.watch(priceRangeProvider);
    final filterNotifier = ref.read(campsiteFilterProvider.notifier);

    if (filter.isEmpty) {
      return const SizedBox.shrink();
    }

    final chips = <Widget>[];

    if (filter.isCloseToWater != null) {
      chips.add(
        _buildFilterChip(
          context,
          filter.isCloseToWater == true
              ? 'Close to Water'
              : 'Not Close to Water',
          () => filterNotifier.toggleWaterFilter(null),
        ),
      );
    }

    if (filter.isCampFireAllowed != null) {
      chips.add(
        _buildFilterChip(
          context,
          filter.isCampFireAllowed == true
              ? 'Campfire Allowed'
              : 'Campfire Not Allowed',
          () => filterNotifier.toggleCampfireFilter(null),
        ),
      );
    }

    if (filter.hostLanguages != null && filter.hostLanguages!.isNotEmpty) {
      for (final lang in filter.hostLanguages!) {
        chips.add(
          _buildFilterChip(context, lang, () {
            final newList = List<String>.from(filter.hostLanguages!);
            newList.remove(lang);
            filterNotifier.updateHostLanguages(
              newList.isEmpty ? null : newList,
            );
          }),
        );
      }
    }

    if (filter.priceRange != null && filter.priceRange != initialPriceRange) {
      chips.add(
        _buildFilterChip(
          context,
          'Price: €${filter.priceRange!.start.round()} - \$${filter.priceRange!.end.round()}',
          () => filterNotifier.updatePriceRange(
            initialPriceRange.start,
            initialPriceRange.end,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
      child: Wrap(
        spacing: AppSizes.spaceSM,
        runSpacing: AppSizes.spaceXS,
        children: [
          ...chips,
          ActionChip(
            label: const Text('Clear All'),
            onPressed: filterNotifier.resetFilters,
            backgroundColor: Theme.of(context).colorScheme.error.alphaF(0.1),
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    VoidCallback onDeleted,
  ) {
    return Chip(
      label: Text(label),
      onDeleted: onDeleted,
      deleteIcon: const Icon(Icons.close),
      deleteIconColor: Theme.of(context).colorScheme.onSurface.alphaF(0.7),
      backgroundColor: Theme.of(context).colorScheme.primary.alphaF(0.1),
    );
  }
}
