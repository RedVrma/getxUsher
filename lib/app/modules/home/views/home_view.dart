import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "Hi!",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isloading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHealthCard(
                context: context,
                title: "steps".tr,
                currentLabel: "${controller.steps.value}",
                goalLabel: "15,000",
                percent: (controller.steps.value / 15000).clamp(0, 1),
                icon: Icons
                    .directions_walk,
              ),
              buildHealthCard(
                context: context,
                title: "calories_burned".tr,
                currentLabel: "${controller.calories.value.toInt()}",
                goalLabel: "1000",
                percent: (controller.calories.value / 1000).clamp(0, 1),
                icon: Icons.local_fire_department,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildHealthCard({
    required BuildContext context,
    required String title,
    required String currentLabel,
    required String goalLabel,
    required double percent,
    required IconData icon,
  }) {
    //Theme switching...
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color foregroundColor = isDark ? Colors.white : Colors.black;
    Color cardColor = isDark
        ? const Color(0xFF232323)
        : const Color(0xFFF0F0F0);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$title: $currentLabel",
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Icon(icon, color: foregroundColor, size: 40),
            ],
          ),
          const SizedBox(height: 20),
          // The Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 12,
              backgroundColor: foregroundColor.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("0", style: TextStyle(color: foregroundColor, fontSize: 12)),
              Text(
                "Goal: $goalLabel",
                style: TextStyle(color: foregroundColor, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
