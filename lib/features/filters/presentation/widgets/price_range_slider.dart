import 'package:flutter/material.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';

class PriceRangeSlider extends StatelessWidget {
  const PriceRangeSlider({
    super.key,
    required this.currentRange,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final RangeValues currentRange;
  final double min;
  final double max;
  final ValueChanged<RangeValues> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.paddingXS),
          child: Text(
            'Price Range (€${currentRange.start.round()} - €${currentRange.end.round()})',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        RangeSlider(
          values: currentRange,
          min: min,
          max: max,
          divisions: ((max - min) ~/ 20),
          labels: RangeLabels(
            '€${currentRange.start.round()}',
            '€${currentRange.end.round()}',
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
