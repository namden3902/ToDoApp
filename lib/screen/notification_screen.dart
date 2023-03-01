import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:todo_app_by_dn/dif/notification.dart';
import 'package:todo_app_by_dn/object/notification_object.dart';
import 'package:todo_app_by_dn/provider/notification_provider.dart';
import '../dif/drawer.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class _NotificationScreenState extends State<NotificationScreen> {
  _NotificationScreenState({
    Key? key,
  });

  CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications');

  String hour = TimeOfDay.now().hour.toString();
  String miniute = TimeOfDay.now().minute.toString();
  bool thongbao = false;
  bool _visibility = false;
  var docID;
  var querySnapshots;

  void setGio() {
    if (TimeOfDay.now().hour < 10) {
      hour = '0' + TimeOfDay.now().hour.toString();
    } else {
      hour = TimeOfDay.now().hour.toString();
    }
    if (TimeOfDay.now().minute < 10) {
      miniute = '0' + TimeOfDay.now().minute.toString();
    } else {
      miniute = TimeOfDay.now().minute.toString();
    }
  }

  void ngonngu() {
    List<String> douutien = [];
    if (Locales.init == 'vi') {
      douutien = ['Cao', 'Trung bình', 'Thấp'];
    } else {
      douutien = ['Hight', 'Medium', 'Low'];
    }
  }

  Future<void> updateThongbao(bool trangthai, String hour, String minute) {
    return notifications
        .doc(docID)
        .update({'trangthai': trangthai, 'hour': hour, 'minute': miniute});
  }

  Future<void> updateTTTB(bool trangthai) {
    return notifications.doc(docID).update({'trangthai': trangthai});
  }

  @override
  void initState() {
    super.initState();
    setGio();
    ngonngu();
    // loadNoti();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NotificationObject>>(
      future: NotificationProvider.get(
          FirebaseAuth.instance.currentUser!.email!.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<NotificationObject> noti = snapshot.data!;
          return Scaffold(
              appBar: AppBar(
                title: LocaleText(
                  'thongbao',
                  style: GoogleFonts.beVietnamPro(
                      color: Colors.white, fontSize: 25),
                ),
                backgroundColor: Colors.deepPurple,
                centerTitle: true,
              ),
              drawer: Drawww(),
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: 400,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    LocaleText(
                                      'titileofnoti',
                                      style: GoogleFonts.beVietnamPro(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepPurple),
                                    ),
                                    LocaleText(
                                      'noidung',
                                      style: GoogleFonts.beVietnamPro(
                                        color: Colors.deepPurple,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 70,
                                ),
                                LiteRollingSwitch(
                                    width: 80,
                                    value: noti[0].trangthai,
                                    textOff: '',
                                    textOn: '',
                                    iconOn: Icons.notifications,
                                    iconOff: Icons.notifications_none,
                                    textOnColor: Colors.white,
                                    textOffColor: Colors.white,
                                    colorOn: Colors.deepPurple,
                                    colorOff: Colors.grey,
                                    onTap: () {},
                                    onDoubleTap: () {},
                                    onSwipe: () {},
                                    onChanged: (bool state) async {
                                      _visibility = state;
                                      thongbao = state;
                                      querySnapshots =
                                          await notifications.get();
                                      for (var snapshot
                                          in querySnapshots.docs) {
                                        if (noti[0].email ==
                                            snapshot['email']) {
                                          docID = snapshot.id;
                                        }
                                      }
                                      if (state) {
                                        setGio();
                                        updateThongbao(
                                            !noti[0].trangthai,
                                            TimeOfDay.now().hour.toString(),
                                            TimeOfDay.now().minute.toString());

                                        Noti.stopShowNotification(
                                            fln:
                                                flutterLocalNotificationsPlugin);
                                        Noti.showDailyNotification(
                                            hour: TimeOfDay.now().hour,
                                            mininute: TimeOfDay.now().minute,
                                            title: 'Thông báo',
                                            body:
                                                'Thông báo lặp lại, chạy thử thôi á mà',
                                            fln:
                                                flutterLocalNotificationsPlugin);
                                        setState(() {});
                                      } else {
                                        setGio();
                                        updateTTTB(!noti[0].trangthai);

                                        Noti.stopShowNotification(
                                            fln:
                                                flutterLocalNotificationsPlugin);
                                        setState(() {});
                                      }
                                      print(
                                          'Current State of SWITCH IS: $state');
                                    })
                              ],
                            ),
                            Visibility(
                              visible: noti[0].trangthai,
                              child: Column(
                                children: [
                                  Divider(
                                    color: Colors.deepPurple,
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 200),
                                    child: LocaleText(
                                      'thoigian',
                                      style: GoogleFonts.beVietnamPro(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepPurple),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      querySnapshots =
                                          await notifications.get();
                                      for (var snapshot
                                          in querySnapshots.docs) {
                                        if (noti[0].email ==
                                            snapshot['email']) {
                                          docID = snapshot.id;
                                        }
                                      }
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) {
                                        if (value!.hour < 10) {
                                          hour = '0' + value.hour.toString();
                                        } else {
                                          hour = value.hour.toString();
                                        }
                                        if (value.minute < 10) {
                                          miniute =
                                              '0' + value.minute.toString();
                                        } else {
                                          miniute = value.minute.toString();
                                        }
                                        Noti.showDailyNotification(
                                            hour: value.hour,
                                            mininute: value.minute,
                                            title: 'Thông báo',
                                            body:
                                                'Thông báo lặp lại, chạy thử thôi á mà',
                                            fln:
                                                flutterLocalNotificationsPlugin);
                                        updateThongbao(
                                            noti[0].trangthai,
                                            value.hour.toString(),
                                            value.minute.toString());
                                        setState(() {});
                                      }).onError((error, stackTrace) {
                                        hour = TimeOfDay.now().hour.toString();
                                        miniute =
                                            TimeOfDay.now().minute.toString();
                                        Noti.showDailyNotification(
                                            hour: TimeOfDay.now().hour,
                                            mininute: TimeOfDay.now().minute,
                                            title: 'Test thông báo daily',
                                            body: 'body',
                                            fln:
                                                flutterLocalNotificationsPlugin);
                                        updateThongbao(
                                            noti[0].trangthai,
                                            TimeOfDay.now().hour.toString(),
                                            TimeOfDay.now().minute.toString());
                                        setState(() {});
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 200),
                                      child: Text(
                                        noti[0].hour.toString() +
                                            ':' +
                                            noti[0].minute.toString(),
                                        style: GoogleFonts.beVietnamPro(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple,
                                            fontSize: 30),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ));
        }
        return Text('');
      },
    );
  }
}
