import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/application/providers/campsite_provider.dart';
import 'package:wander_nest/application/providers/filters/campsite_filter_model.dart';
import 'package:wander_nest/application/providers/filters/campsite_filter_notifier.dart';
import 'package:wander_nest/core/constants/app_icons.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/presentation/widgets/filters/dropdown_filter_option.dart';
import 'package:wander_nest/presentation/widgets/filters/language_filter_selector.dart';
import 'package:wander_nest/presentation/widgets/filters/price_range_slider.dart';

class FilterOverlayPanel extends ConsumerStatefulWidget {
  const FilterOverlayPanel({super.key});

  @override
  ConsumerState<FilterOverlayPanel> createState() =>
      _CampsiteFilterSheetMobileState();
}

class _CampsiteFilterSheetMobileState
    extends ConsumerState<FilterOverlayPanel> {
  late CampsiteFilter _localFilter;
  late RangeValues _localPriceRange;

  @override
  void initState() {
    super.initState();
    final globalFilter = ref.read(campsiteFilterProvider);
    final globalPriceRange = ref.read(priceRangeProvider);

    _localFilter = globalFilter;
    _localPriceRange = _localFilter.priceRange ?? globalPriceRange;
  }

  void _applyFilters() {
    ref.read(campsiteFilterProvider.notifier).setFilter(_localFilter);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final priceRange = ref.watch(priceRangeProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filters', style: Theme.of(context).textTheme.titleMedium),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _localFilter = const CampsiteFilter();
                      _localPriceRange = priceRange;
                    });
                  },
                  child: const Text('Clear All'),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.space),

            // Water toggle: Yes / No / Any
            DropdownFilterOption(
              title: 'Close to Water',
              icon: AppIcons.water,
              value: _localFilter.isCloseToWater,
              onChanged: (value) {
                setState(() {
                  _localFilter = _localFilter.copyWith(isCloseToWater: value);
                });
              },
            ),

            // Campfire toggle
            DropdownFilterOption(
              title: 'Campfire Allowed',
              icon: AppIcons.campfire,
              value: _localFilter.isCampFireAllowed,
              onChanged: (value) {
                setState(() {
                  _localFilter = _localFilter.copyWith(
                    isCampFireAllowed: value,
                  );
                });
              },
            ),

            // Host languages
            LanguageFilterSelector(
              selectedLanguages: _localFilter.hostLanguages ?? [],
              onSelectionChanged: (selected) {
                setState(() {
                  _localFilter = _localFilter.copyWith(
                    hostLanguages: selected.isEmpty ? null : selected,
                  );
                });
              },
            ),

            const SizedBox(height: AppSizes.space),

            // Price slider
            PriceRangeSlider(
              currentRange: _localPriceRange,
              min: priceRange.start,
              max: priceRange.end,
              onChanged: (range) {
                setState(() {
                  _localPriceRange = range;
                  _localFilter = _localFilter.copyWith(priceRange: range);
                });
              },
            ),

            const SizedBox(height: AppSizes.space),

            ElevatedButton(
              onPressed: _applyFilters,
              child: const Text('Apply Filters'),
            ),
          ],
        ),
      ),
    );
  }
}
