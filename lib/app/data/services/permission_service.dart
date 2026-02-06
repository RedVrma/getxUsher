import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService extends GetxService {
  Future<bool> hasPhysicalAndLocation() async {
    // Check current status without showing a popup
    var activity = await Permission.activityRecognition.status;
    var location = await Permission.location.status;
    return activity.isGranted && location.isGranted;
  }

  Future<bool> requestBasePermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.activityRecognition,
      Permission.location,
    ].request();

    return statuses.values.every((status) => status.isGranted);
  }
}