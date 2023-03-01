import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:todo_app_by_dn/screen/login2.dart';
import 'package:todo_app_by_dn/screen/main_screen.dart';
import 'package:todo_app_by_dn/screen/notification_screen.dart';
import 'package:todo_app_by_dn/screen/profile_screen.dart';
import 'package:todo_app_by_dn/screen/settings.dart';

import 'package:todo_app_by_dn/screen/voice_add_screen.dart';

class Drawww extends StatefulWidget {
  Drawww({
    Key? key,
  }) : super(key: key);

  @override
  State<Drawww> createState() => _DrawwwState();
}

class _DrawwwState extends State<Drawww> {
  _DrawwwState({
    Key? key,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          decoration: BoxDecoration(color: Colors.deepPurple),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    buildHeader(context),
                    buildMenuItems(context),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget buildHeader(BuildContext context) => Container();
  Widget buildMenuItems(BuildContext context) => Container(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50)),
                        ),
                      ),
                      Image.asset('assets/background.jpg'),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/60111.jpg'),
                              radius: 50,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              FirebaseAuth.instance.currentUser!.email!
                                          .toString() ==
                                      null
                                  ? ''
                                  : FirebaseAuth.instance.currentUser!.email
                                      .toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: const LocaleText(
                'trangchu',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MainScreen()));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: Colors.white,
                height: 2,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.mic,
                color: Colors.white,
              ),
              title: const LocaleText(
                'thembangiongnoi',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => VoicAdd()));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: Colors.white,
                height: 2,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: const LocaleText(
                'taikhoan',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: Colors.white,
                height: 2,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              title: const LocaleText(
                'thongbao',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => NotificationScreen()));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: Colors.white,
                height: 2,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: const LocaleText(
                'caidat',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: Colors.white,
                height: 2,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const LocaleText(
                'dangxuat',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginSecond()),
                  ModalRoute.withName('/'),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: Colors.white,
                height: 2,
              ),
            ),
          ],
        ),
      );
}
