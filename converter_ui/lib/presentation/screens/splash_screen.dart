import 'package:converter_ui/core/theme/dorado_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/screen1');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DoradoColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset(
                'lib/core/assets/logo_el_dorado.png',
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(height: 24),
            // const Text(
            //   'EL DORADO',
            //   style: TextStyle(
            //     fontSize: 32,
            //     fontWeight: FontWeight.w800,
            //     color: DoradoColors.primary,
            //     letterSpacing: 1.5,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
