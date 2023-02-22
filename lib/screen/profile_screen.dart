import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_by_dn/screen/change_passwork_screen.dart';
import 'package:todo_app_by_dn/screen/change_profile_screen.dart';

import '../dif/drawer.dart';

class Profile extends StatefulWidget {
  String? email;
  String? matkhau;
  Profile({this.email, this.matkhau});

  @override
  State<Profile> createState() => _ProfileState(email: email, matkhau: matkhau);
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  String? email;
  String? matkhau;
  _ProfileState({this.email, this.matkhau});

  late TabController _controller;
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Tài khoản',
            style: GoogleFonts.beVietnamPro(
                fontSize: 40, color: Colors.deepPurple),
          ),
          bottom: TabBar(
            indicator: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(25)),
            tabs: [
              Tab(
                text: 'Thông tin',
              ),
              Tab(
                text: 'Đổi mật khẩu',
              ),
            ],
            controller: _controller,
          ),
          backgroundColor: Colors.grey[300],
          centerTitle: true,
        ),
        drawer: NavigationDrawer(
          email: email,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          child: TabBarView(controller: _controller, children: [
            ChangeProfiel(email: email),
            ChangePasswork(
              email: email,
              matkhau: matkhau,
            )
          ]),
        ));
  }
}
