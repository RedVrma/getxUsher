import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx/app/data/providers/health_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/services/permission_service.dart';

class HomeController extends GetxController {
  final HealthProvider healthProvider;
  final PermissionService permService;

  HomeController({
    required this.healthProvider,
    required this.permService,
  });


  var isloading = false.obs;

  final steps = 0.obs;
  final calories = 0.0.obs;

  final stepGoal = 10000;
  final calorieGoal = 2500.0;

  double get stepPercent => (steps.value / stepGoal).clamp(0.0, 1.0);
  double get caloriePercent => (calories.value / calorieGoal).clamp(0.0, 1.0);

  @override
  void onReady() {
    super.onReady();
    initFlow();
  }

  Future<void> initFlow() async {
    isloading(true);
    try {
      // 1. System Permissions (Activity/Location)
      bool basePerms = await permService.requestBasePermissions();
      if (!basePerms) {
        _showPermissionDialog();
        return;
      }

      // 2. Health/Google Fit Permissions
      bool healthAuth = await healthProvider.requestPermissions();
      if (!healthAuth) {
        Get.snackbar("Sync Error", "Google Fit access is required");
        return;
      }

      // 3. Only if both passed, fetch
      await fetchData();
    } finally {
      isloading(false);
    }
  }

  void _showPermissionDialog() {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(8.0),
      title: "Settings Required",
      middleText: "Activity and Location are needed to sync your steps correctly.",
      textConfirm: "Open Settings",
      onConfirm: () {
        openAppSettings();
        Get.back();
      },
    );
  }

  Future<void> fetchData() async { // Changed to Future<void>
    isloading(true);
    steps.value = await healthProvider.fetchSteps();
    calories.value = await healthProvider.fetchTotalCalories();
    isloading(false);
  }

  void increment() => steps.value++;
}
