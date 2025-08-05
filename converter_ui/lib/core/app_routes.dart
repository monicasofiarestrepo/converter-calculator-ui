import 'package:converter_ui/core/theme/dorado_colors.dart';
import 'package:converter_ui/presentation/screens/splash_screen.dart';
import 'package:converter_ui/presentation/screens/screen1.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String screen1 = '/screen1';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case screen1:
        return MaterialPageRoute(builder: (_) => const Screen1());
      default:
        return MaterialPageRoute(
          builder: (_) =>  Scaffold(
            body: Center(child: Text('Ruta no encontrada', style: TextStyle(color: DoradoColors.textColor))),
          ),
        );
    }
  }
}
