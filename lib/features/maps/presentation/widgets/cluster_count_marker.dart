import 'package:flutter/material.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/shared/extensions/color_extensions.dart';

class ClusterCountMarker extends StatelessWidget {
  const ClusterCountMarker(this.count, {super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.iconLG,
      height: AppSizes.iconLG,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.green.alphaF(0.75),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.alphaF(0.25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
