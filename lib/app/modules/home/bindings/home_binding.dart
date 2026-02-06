import 'package:get/get.dart';
import 'package:getx/app/data/providers/health_provider.dart';

import '../../../data/services/permission_service.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<HealthProvider>(() => HealthProvider());
    Get.lazyPut<PermissionService>(() => PermissionService());

    Get.lazyPut<HomeController>(() => HomeController(
      healthProvider: Get.find<HealthProvider>(),
      permService: Get.find<PermissionService>(),
    ));
  }
}
