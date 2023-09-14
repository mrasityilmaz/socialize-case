import 'package:permission_handler/permission_handler.dart';

final class PermissionService {
  factory PermissionService() => instance;

  PermissionService._internal();

  static final PermissionService instance = PermissionService._internal();

  Future<bool?> checkGalleryPermission() async {
    final bool? permissionStatus = await Permission.photos.status.then((value) {
      if (value.isGranted || value.isLimited) {
        return true;
      } else if (value.isPermanentlyDenied) {
        return null;
      } else {
        return false;
      }
    });

    if (permissionStatus == true) {
      return true;
    } else if (permissionStatus == false) {
      return await Permission.photos.request().then((value) {
        if (value.isGranted || value.isLimited) {
          return true;
        } else if (value.isPermanentlyDenied) {
          return null;
        } else {
          return false;
        }
      });
    } else {
      return null;
    }
  }
}
