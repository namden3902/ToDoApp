import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app_by_dn/screen/login2.dart';
import 'package:todo_app_by_dn/screen/main_screen.dart';
import 'package:todo_app_by_dn/screen/profile_screen.dart';
import 'package:todo_app_by_dn/screen/vieccanlam_screen.dart';
import 'package:todo_app_by_dn/screen/viechoathanh_screen.dart';
import 'package:todo_app_by_dn/screen/voice_add_screen.dart';

class NavigationDrawer extends StatefulWidget {
  String? email;
  String? matkhau;
  NavigationDrawer({this.email, this.matkhau});

  @override
  State<NavigationDrawer> createState() =>
      _NavigationDrawerState(emaill: email, matkhau: matkhau);
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String? emaill;
  String? matkhau;
  _NavigationDrawerState({this.emaill, this.matkhau});
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
                              emaill.toString(),
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
              title: const Text(
                'Trang chủ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MainScreen(
                          email: emaill,
                          matkhau: matkhau,
                        )));
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
              title: const Text(
                'Thêm bằng giọng nói',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VoicAdd(
                          email: emaill,
                          matkhau: matkhau,
                        )));
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
              title: const Text(
                'Tài khoản',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Profile(
                          email: emaill,
                          matkhau: matkhau,
                        )));
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
              title: const Text(
                'Đăng xuất',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginSecond()));
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
