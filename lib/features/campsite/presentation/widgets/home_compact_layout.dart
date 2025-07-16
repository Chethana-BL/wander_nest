import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/campsite/presentation/providers/search_providers.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/campsite_card.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/home_empty_campsite.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/result_summary_banner.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/search_bar.dart';
import 'package:wander_nest/features/filters/domain/entities/filter_state.dart';
import 'package:wander_nest/features/filters/presentation/providers/campsite_filter_notifier.dart';
import 'package:wander_nest/features/filters/presentation/widgets/active_filter_chips.dart';
import 'package:wander_nest/shared/widgets/animated_lists.dart';

class HomeCompactLayout extends ConsumerWidget {
  const HomeCompactLayout({
    super.key,
    required this.campsites,
    required this.filteredCampsites,
  });

  final List<Campsite> campsites;
  final List<Campsite> filteredCampsites;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(campsiteFilterProvider);
    final search = ref.watch(searchQueryProvider);

    Widget content = const NoCampsiteFound();

    if (filteredCampsites.isNotEmpty) {
      content = AnimatedListView<Campsite>(
        items: filteredCampsites,
        itemBuilder: (context, campsite) => CampsiteCard(campsite: campsite),
      );
    }

    return Column(
      children: [
        SearchBarWidget(
          onChanged:
              (value) => ref.read(searchQueryProvider.notifier).state = value,
          searchText: search,
        ),
        if (!filter.isDefault)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizes.paddingSM),
            child: ActiveFilterChips(),
          ),
        if (filteredCampsites.isNotEmpty)
          ResultSummaryBanner(
            totalCount: campsites.length,
            filteredCount: filteredCampsites.length,
          ),
        Expanded(child: content),
      ],
    );
  }
}
