import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app_by_dn/screen/profile_screen.dart';
import 'package:todo_app_by_dn/screen/vieccanlam_screen.dart';
import 'package:todo_app_by_dn/screen/viechoathanh_screen.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../dif/drawer.dart';

class MainScreen extends StatefulWidget {
  String? email;
  String? matkhau;
  MainScreen({Key? key, required this.email, required this.matkhau})
      : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  State<MainScreen> createState() =>
      _MainScreenState(email: email, matkhau: matkhau);
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  String? email;
  String? matkhau;
  _MainScreenState({Key? key, required this.email, required this.matkhau});
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
          'Trang chủ',
          style:
              GoogleFonts.beVietnamPro(fontSize: 40, color: Colors.deepPurple),
        ),
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        bottom: TabBar(
          indicator: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(25)),
          tabs: [
            Tab(
              text: 'Việc cần làm',
              icon: WidgetAnimator(
                atRestEffect: WidgetRestingEffects.swing(),
                child: Icon(Icons.assignment),
              ),
            ),
            Tab(
              text: 'Việc đã hoàn thành',
              icon: WidgetAnimator(
                  atRestEffect: WidgetRestingEffects.swing(),
                  child: Icon(Icons.assignment_turned_in)),
            ),
          ],
          controller: _controller,
        ),
      ),
      drawer: NavigationDrawer(
        email: email,
        matkhau: matkhau,
      ),
      body: Container(
          decoration: BoxDecoration(color: Colors.grey[300]),
          child: TabBarView(
            controller: _controller,
            children: [
              ViecCanLam(
                email: email,
              ),
              ViecHoanThanh(
                email: email,
              )
            ],
          )),
    );
  }
}
