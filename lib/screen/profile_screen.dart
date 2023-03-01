import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_by_dn/screen/change_passwork_screen.dart';
import 'package:todo_app_by_dn/screen/change_profile_screen.dart';

import '../dif/drawer.dart';

class Profile extends StatefulWidget {
  Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  _ProfileState({
    Key? key,
  });

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
          title: LocaleText(
            'taikhoan',
            style: GoogleFonts.beVietnamPro(fontSize: 25),
          ),
          bottom: TabBar(
            indicator: BoxDecoration(
                color: Colors.deepPurple[300],
                borderRadius: BorderRadius.circular(8)),
            tabs: [
              Tab(
                child:
                    LocaleText('thongtin', style: GoogleFonts.beVietnamPro()),
              ),
              Tab(
                child: LocaleText('doimk', style: GoogleFonts.beVietnamPro()),
              ),
            ],
            controller: _controller,
          ),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
        drawer: Drawww(),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          child: TabBarView(
              controller: _controller,
              children: [ChangeProfiel(), ChangePasswork()]),
        ));
  }
}
