import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationDetails {
  /// Notification details for Android.
  final AndroidNotificationDetails android;

  /// Notification details for iOS.
  final IOSNotificationDetails iOS;

  const NotificationDetails(this.android, this.iOS);
}
