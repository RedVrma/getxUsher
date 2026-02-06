import 'package:flutter_test/flutter_test.dart';
import 'package:getx/app/data/providers/health_provider.dart';
import 'package:getx/app/data/services/permission_service.dart';
import 'package:getx/app/modules/home/controllers/home_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockHealthProvider extends Mock implements HealthProvider {}
class MockPermissionService extends Mock implements PermissionService {}

void main() {
  late HomeController controller;
  late MockHealthProvider mockHealth;
  late MockPermissionService mockPerms;

  setUp(() {
    mockHealth = MockHealthProvider();
    mockPerms = MockPermissionService();

    // You can now instantiate the controller directly!
    controller = HomeController(
      healthProvider: mockHealth,
      permService: mockPerms,
    );
  });

  test('fetchData updates steps and calories', () async {
    when(() => mockHealth.fetchSteps()).thenAnswer((_) async => 100);
    when(() => mockHealth.fetchTotalCalories()).thenAnswer((_) async => 5.0);

    await controller.fetchData();

    expect(controller.steps.value, 100);
    expect(controller.calories.value, 5.0);
    expect(controller.isloading.value, false);
  });

}