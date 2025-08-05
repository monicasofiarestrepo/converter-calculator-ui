import 'package:converter_ui/presentation/components/background.dart';
import 'package:converter_ui/presentation/components/main_calculator.dart';
import 'package:converter_ui/data/providers/theme_mode_provider.dart';
import 'package:converter_ui/core/theme/dorado_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Screen1 extends ConsumerWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkModeActivatedProvider);

    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(
                isDark ? Icons.wb_sunny : Icons.nightlight_round,
                color: DoradoColors.textColor,
              ),
              onPressed: () {
                final newValue = !isDark;
                ref.read(isDarkModeActivatedProvider.notifier).state = newValue;
                newValue ? DoradoColors.setDarkTheme() : DoradoColors.setLightTheme();
              },
            ),
          ),
           Center(
            child: MainCalculator(),
          ),
        ],
      ),
    );
  }
}
