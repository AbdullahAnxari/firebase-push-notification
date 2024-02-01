import '../lib.dart';

class AndroidPermission {
  // Notification permission
  static Future<bool> notificationPermission() async {
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      debugPrint('Permission Granted');
      return true;
    } else {
      debugPrint('Permission Denied');
      return false;
    }
  }
}
