import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app_by_dn/main.dart';

import '../dif/notification.dart';

class Notificationn extends StatefulWidget {
  const Notificationn({super.key});

  @override
  State<Notificationn> createState() => _NotificationState();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@override
class _NotificationState extends State<Notificationn> {
  @override
  void initState() {
    super.initState();
    Noti.initalize(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: TextButton(
            child: Text('Click'),
            onPressed: () {
              Noti.showNotification(
                  title: 'Tesst',
                  body: 'Hello',
                  fln: flutterLocalNotificationsPlugin);
            },
          ),
        ),
      ),
    );
  }
}
