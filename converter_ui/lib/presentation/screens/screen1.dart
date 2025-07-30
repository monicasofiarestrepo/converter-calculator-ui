import 'package:converter_ui/presentation/components/background.dart';
import 'package:converter_ui/presentation/components/main_calculator.dart';
import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Center(
            child: MainCalculator(),
          ),
        ],
      ),
    );
  }
}
