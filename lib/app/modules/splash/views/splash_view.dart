import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color automatically adapts to ThemeMode.system
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Stage 1: The Orange Pin
            FadeTransition(
              opacity: controller.pinOpacity,
              child: const Icon(Icons.location_on, size: 80, color: Colors.orange),
            ),
            const SizedBox(height: 20),

            // Stage 2: Main Logo Text
            ScaleTransition(
              scale: controller.textScale,
              child: FadeTransition(
                opacity: controller.pinOpacity, // Appears with the pin or slightly after
                child: const Text(
                  "boozin",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -2,
                  ),
                ),
              ),
            ),

            // Stage 3: Subtitle
            FadeTransition(
              opacity: controller.subtitleOpacity,
              child: Text(
                "Fitness",
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  letterSpacing: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}