import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:wecare_flutter/constants.dart';

class NotificationService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late String currentTimeZone;
  //initilize

  Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("logo");

    IOSInitializationSettings iosInitializationSettings =
        const IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  }

  //Instant Notifications
  Future instantNofitication() async {
    var android = const AndroidNotificationDetails(
      'id',
      'channel',
      channelDescription: 'description',
      priority: Priority.high,
      importance: Importance.max,
    );

    var ios = const IOSNotificationDetails();

    var platform = NotificationDetails(android: android, iOS: ios);

    await _flutterLocalNotificationsPlugin.show(
        0, "Demo instant notification", "Tap to do something", platform,
        payload: "Welcome to demo app");
  }

  //Image notification
  Future imageNotification() async {
    var bigPicture = const BigPictureStyleInformation(
      DrawableResourceAndroidBitmap("ic_launcher"),
      largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
      contentTitle: "Demo image notification",
      summaryText: "This is some text",
      htmlFormatContent: true,
      htmlFormatContentTitle: true,
    );

    var android = AndroidNotificationDetails('id', 'channel',
        channelDescription: 'description', styleInformation: bigPicture);

    var platform = NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.show(
        0, "Demo Image notification", "Tap to do something", platform,
        payload: "Welcome to demo app");
  }

  //Stylish Notification
  Future stylishNotification() async {
    var android = const AndroidNotificationDetails(
      'id',
      'channel',
      channelDescription: 'description',
      color: Colors.deepOrange,
      enableLights: true,
      enableVibration: true,
      largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
      styleInformation: MediaStyleInformation(
        htmlFormatContent: true,
        htmlFormatTitle: true,
      ),
    );

    var platform = new NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.show(
        0, "Demo Stylish notification", "Tap to do something", platform);
  }

  //Sheduled Notification

  Future sheduledNotification(
    int idNotification,
    String title,
    String description,
    DateTime time,
  ) async {
    var android = const AndroidNotificationDetails(
      '12',
      'channel',
      channelDescription: 'description',
      color: primaryColor,
      priority: Priority.high,
      importance: Importance.max,
      styleInformation: MediaStyleInformation(
        htmlFormatContent: true,
        htmlFormatTitle: true,
      ),
    );

    var ios = const IOSNotificationDetails();

    var platform = NotificationDetails(android: android, iOS: ios);

    Duration duration = Duration(
      hours: time.hour - DateTime.now().hour,
      minutes: time.minute - DateTime.now().minute,
    );

    _flutterLocalNotificationsPlugin.zonedSchedule(
      idNotification,
      title,
      description,
      tz.TZDateTime.now(tz.getLocation('Asia/Bangkok')).add(duration),
      platform,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  //Cancel notification
  Future cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
