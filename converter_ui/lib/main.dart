import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/dorado_theme.dart';
import 'package:converter_ui/core/app_routes.dart';
import 'core/theme/dorado_colors.dart';

void main() {
  DoradoColors.setLightTheme();
  runApp(
    const ProviderScope( 
      child: MainApp(),    
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Dorado',
      theme: doradoTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
