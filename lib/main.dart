import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_by_dn/dif/notification.dart';
import 'package:todo_app_by_dn/provider/theme_provider.dart';
import 'package:todo_app_by_dn/screen/login2.dart';
import 'package:todo_app_by_dn/screen/main_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic("NITO");
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await Noti.initalize(flutterLocalNotificationsPlugin);
  await Locales.init(['vi', 'en']);
  runApp(ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider()..initialize(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    getDeviceToke();
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return LocaleBuilder(
          builder: (locales) => MaterialApp(
              themeMode: provider.themeMode,
              localizationsDelegates: Locales.delegates,
              supportedLocales: Locales.supportedLocales,
              locale: locales,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              title: 'Flutter Demo',
              home: FirebaseAuth.instance.currentUser == null
                  ? LoginSecond()
                  : MainScreen()));
    });
  }

  Future<void> getDeviceToke() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    String tokennn = token.toString();
    print("Token: $tokennn");
  }
}

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}
