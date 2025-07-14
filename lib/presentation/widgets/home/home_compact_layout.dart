import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:wander_nest/application/providers/filters/campsite_filter_notifier.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/data/models/campsite.dart';
import 'package:wander_nest/presentation/widgets/filter_panel/active_filter_chips.dart';
import 'package:wander_nest/presentation/widgets/home/campsite_card.dart';
import 'package:wander_nest/presentation/widgets/home/home_empty_campsite.dart';
import 'package:wander_nest/presentation/widgets/home/result_summary_banner.dart';

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

    Widget content = const NoCampsiteFound();

    if (filteredCampsites.isNotEmpty) {
      content = AnimationLimiter(
        child: ListView.separated(
          padding: const EdgeInsets.all(AppSizes.padding),
          itemCount: filteredCampsites.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSizes.space),
          itemBuilder: (context, index) {
            final campsite = filteredCampsites[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 400),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(child: CampsiteCard(campsite: campsite)),
              ),
            );
          },
        ),
      );
    }

    return Column(
      children: [
        if (!filter.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: AppSizes.padding),
            child: ActiveFilterChips(),
          ),
        if (filteredCampsites.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: AppSizes.padding),
            child: ResultSummaryBanner(
              totalCount: campsites.length,
              filteredCount: filteredCampsites.length,
            ),
          ),
        Expanded(child: content),
      ],
    );
  }
}
