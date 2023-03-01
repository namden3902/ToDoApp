import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app_by_dn/screen/profile_screen.dart';
import 'package:todo_app_by_dn/screen/vieccanlam_screen.dart';
import 'package:todo_app_by_dn/screen/viechoathanh_screen.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:todo_app_by_dn/dif/drawer.dart';

class MainScreen extends StatefulWidget {
  MainScreen({
    Key? key,
  }) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  _MainScreenState({
    Key? key,
  });
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
        title: LocaleText('trangchu',
            style: GoogleFonts.beVietnamPro(fontSize: 25)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        bottom: TabBar(
          indicator: BoxDecoration(
              color: Colors.deepPurple[300],
              borderRadius: BorderRadius.circular(8)),
          tabs: [
            Tab(
              icon: WidgetAnimator(
                atRestEffect: WidgetRestingEffects.swing(),
                child: Icon(Icons.assignment),
              ),
              child: LocaleText(
                'vieccanlam',
                style: GoogleFonts.beVietnamPro(fontSize: 15),
              ),
            ),
            Tab(
              icon: WidgetAnimator(
                  atRestEffect: WidgetRestingEffects.swing(),
                  child: Icon(Icons.assignment_turned_in)),
              child: LocaleText(
                'viecdahoanthanh',
                style: GoogleFonts.beVietnamPro(fontSize: 15),
              ),
            ),
          ],
          controller: _controller,
        ),
      ),
      drawer: Drawww(),
      body: Container(
          decoration: BoxDecoration(color: Colors.grey[300]),
          child: TabBarView(
            controller: _controller,
            children: [ViecCanLam(), ViecHoanThanh()],
          )),
    );
  }
}
