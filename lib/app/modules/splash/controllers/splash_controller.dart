import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animController;

  // Animation pieces
  late Animation<double> pinOpacity;
  late Animation<double> textScale;
  late Animation<double> subtitleOpacity;

  @override
  void onInit() {
    super.onInit();
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // 1. Pin appears (0% to 40% of time)
    pinOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animController, curve: const Interval(0.0, 0.4, curve: Curves.easeIn)),
    );

    // 2. "boozin" text scales up (40% to 70% of time)
    textScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: animController, curve: const Interval(0.4, 0.7, curve: Curves.easeInOutBack)),
    );

    // 3. "Fitness" text fades in (70% to 100% of time)
    subtitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animController, curve: const Interval(0.7, 1.0, curve: Curves.easeIn)),
    );

    // Start animation and then navigate
    animController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.offAllNamed(Routes.HOME);
      });
    });
  }

  @override
  void onClose() {
    animController.dispose();
    super.onClose();
  }
}