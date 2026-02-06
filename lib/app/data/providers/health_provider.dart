import 'package:health/health.dart';

class HealthProvider {
  final Health health = Health();

  Future<bool> requestPermissions() async {
    final types = [HealthDataType.STEPS, HealthDataType.ACTIVE_ENERGY_BURNED];
    return await health.requestAuthorization(types);
  }

  Future<int> fetchSteps() async {
    var now = DateTime.now();
    var midnight = DateTime(now.year, now.month, now.day);
    var data  = await health.getTotalStepsInInterval(midnight, now);
    if(data == null){
      return -1;
    }else{
      return data;
    }
  }

  Future<double> fetchTotalCalories() async {
    var now = DateTime.now();
    var midnight = DateTime(now.year, now.month, now.day);

    // Fetching ACTIVE_ENERGY_BURNED specifically
    List<HealthDataPoint> dataPoints = await health.getHealthDataFromTypes(
        types: [HealthDataType.TOTAL_CALORIES_BURNED],startTime: midnight,endTime: now
    );

    double totalCalories = 0;

    for (var point in dataPoints) {
      var value = point.value;

      if (value is NumericHealthValue) {
        totalCalories += value.numericValue.toDouble();
      }
    }
    return totalCalories;
  }
}