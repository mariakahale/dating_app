import 'package:flutter/material.dart';
import 'package:savethedate/ui/core/globals.dart';

class OnboardingProgressBar extends StatelessWidget {
  final int currentStep; // e.g., 1 to 4

  const OnboardingProgressBar({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    double progress = currentStep / 4;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 8,
        backgroundColor: const Color.fromARGB(255, 255, 206, 204),
        valueColor: const AlwaysStoppedAnimation<Color>(myRed),
      ),
    );
  }
}
