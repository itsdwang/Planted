import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:planted/login/login.dart';

class LocalNotificiation extends StatefulWidget {
  @override
  _LocalNotificiationState createState() => _LocalNotificiationState();
}

class _LocalNotificiationState extends State<LocalNotificiation> {
  FlutterLocalNotificationsPlugin notifications =
      new FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('plant');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    notifications.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );

  Future<void> _showNotification(title, body, id) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        id, title, body,
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await notifications.show(id, title, body, platformChannelSpecifics);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
