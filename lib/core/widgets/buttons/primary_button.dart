import 'package:flutter/material.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fullWidth = true,
    this.safeArea = true,
  });

  final String label;
  final VoidCallback onPressed;
  final bool fullWidth;
  final bool safeArea;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final button = SizedBox(
      height: AppSizes.buttonHeight,
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radius),
          ),
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          textStyle: Theme.of(context).textTheme.titleMedium,
        ),
        child: Text(label),
      ),
    );

    return safeArea
        ? SafeArea(
          minimum: const EdgeInsets.all(AppSizes.padding),
          child: button,
        )
        : button;
  }
}
