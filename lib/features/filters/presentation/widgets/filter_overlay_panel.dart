import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/core/constants/app_icons.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/features/filters/domain/entities/filter_enums.dart';
import 'package:wander_nest/features/filters/domain/entities/filter_state.dart';
import 'package:wander_nest/features/filters/presentation/providers/campsite_filter_notifier.dart';
import 'package:wander_nest/features/filters/presentation/providers/filter_options_providers.dart';
import 'package:wander_nest/features/filters/presentation/widgets/dropdown_filter_option.dart';
import 'package:wander_nest/features/filters/presentation/widgets/language_filter_selector.dart';
import 'package:wander_nest/features/filters/presentation/widgets/price_range_slider.dart';
import 'package:wander_nest/shared/extensions/string_extension.dart';

class FilterOverlayPanel extends ConsumerStatefulWidget {
  const FilterOverlayPanel({super.key});

  @override
  ConsumerState<FilterOverlayPanel> createState() =>
      _CampsiteFilterSheetMobileState();
}

class _CampsiteFilterSheetMobileState
    extends ConsumerState<FilterOverlayPanel> {
  late FilterState _localFilter;
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
    final allLanguages = ref.watch(hostLanguagesProvider);

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
                      _localFilter = FilterState.initial();
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
            DropdownFilterOption<WaterFilter>(
              title: 'Close to Water',
              icon: AppIcons.water,
              value: _localFilter.waterFilter,
              options: WaterFilter.values,
              labelBuilder: (v) => v.name.capitalizeFirst(),
              onChanged: (value) {
                setState(() {
                  _localFilter = _localFilter.copyWith(waterFilter: value);
                });
              },
            ),

            // Campfire toggle
            DropdownFilterOption<CampfireFilter>(
              title: 'Campfire Allowed',
              icon: AppIcons.campfire,
              value: _localFilter.campfireFilter,
              options: CampfireFilter.values,
              labelBuilder: (v) => v.name.capitalizeFirst(),
              onChanged: (value) {
                setState(() {
                  _localFilter = _localFilter.copyWith(campfireFilter: value);
                });
              },
            ),

            // Host languages
            LanguageFilterSelector(
              allLanguages: allLanguages,
              selectedLanguages: _localFilter.hostLanguages,
              onSelectionChanged: (selected) {
                setState(() {
                  _localFilter = _localFilter.copyWith(
                    hostLanguages: selected.isNotEmpty ? selected : [],
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
