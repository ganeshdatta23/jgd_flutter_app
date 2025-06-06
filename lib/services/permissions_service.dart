import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  Future<bool> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      status = await Permission.location.request();
    }
    return status.isGranted;
  }

  Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      status = await Permission.camera.request();
    }
    return status.isGranted;
  }

  Future<Map<Permission, PermissionStatus>> requestRequiredPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
    ].request();
    return statuses;
  }
} 