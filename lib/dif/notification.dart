// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Noti {
  static Future initalize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = new AndroidInitializationSettings('logo');
    var initializationsSettings =
        new InitializationSettings(android: androidInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  //Thông báo từng công việc
  static Future showNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidNotificationDetails =
        new AndroidNotificationDetails(
      'notification_test',
      'channelName',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    var not = NotificationDetails(android: androidNotificationDetails);
    // await fln.showDailyAtTime(id, title, body, Time(16, 54, 00), not);
    await fln.show(id, title, body, not);
    // //Bật ứng dụng
    // await fln.periodicallyShow(
    //     id, title, body, RepeatInterval.everyMinute, not);
  }

  //Thông báo lặp lại
  static Future showDailyNotification(
      {required int hour,
      required int mininute,
      var id = 1,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidNotificationDetails =
        new AndroidNotificationDetails(
      'notification_test',
      'channelName',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    var not = NotificationDetails(android: androidNotificationDetails);
    await fln.showDailyAtTime(id, title, body, Time(hour, mininute, 00), not);
  }

  //Ngừng thông báo lặp lại
  static Future stopShowNotification(
      {required FlutterLocalNotificationsPlugin fln}) async {
    await fln.cancel(1);
  }
}
