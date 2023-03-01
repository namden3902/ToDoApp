import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app_by_dn/object/thongtin_object.dart';
import 'package:todo_app_by_dn/provider/thongtin_provider.dart';
import 'package:todo_app_by_dn/screen/login2.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  CollectionReference uSers = FirebaseFirestore.instance.collection('users');
  CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications');
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtHoten = TextEditingController();
  TextEditingController txtMatkhau = TextEditingController();
  TextEditingController txtRWMatkhau = TextEditingController();
  List<ThongTinObject> thongTin = [];
  void _loadThongTin() async {
    final data = await ThongTinProvider.getData();
    setState(() {});
    thongTin = data;
  }

  List<String> hint = [];
  void douuu() {
    final lang = Localizations.localeOf(context).languageCode.toString();
    if (lang == 'vi') {
      hint = ['Email', 'Họ và tên', 'Mật khẩu', 'Nhập lại mật khẩu'];
    } else {
      hint = ['Email', 'Full name', 'Password', 'Re-enter password'];
    }
  }

  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _dieukien = true;

  @override
  void initState() {
    super.initState();
    _loadThongTin();
  }

  Future<void> addUser() {
    return uSers.add({
      'email': txtEmail.text,
      'hoten': txtHoten.text,
      'matkhau': txtMatkhau.text
    });
  }

  bool ktraEmail(String email) {
    bool isvalid = EmailValidator.validate(email);
    return isvalid;
  }

  Future<void> addNoti() {
    return notifications.add({
      'email': FirebaseAuth.instance.currentUser!.email!.toString(),
      'trangthai': false,
      'hour': '',
      'minute': ''
    });
  }

  @override
  Widget build(BuildContext context) {
    douuu();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90)),
                  color: Colors.deepPurple),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 180, top: 120),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: LocaleText('dangki',
                                style: GoogleFonts.beVietnamPro(
                                    fontSize: 30, color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Lottie.asset('assets/register.json')
                ],
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint[0],
                        hintStyle: TextStyle(color: Colors.deepPurple)),
                    style: TextStyle(fontSize: 17, color: Colors.deepPurple),
                    controller: txtEmail,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint[1],
                        hintStyle: TextStyle(color: Colors.deepPurple)),
                    style: TextStyle(fontSize: 17, color: Colors.deepPurple),
                    controller: txtHoten,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: TextField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint[2],
                        hintStyle: TextStyle(color: Colors.deepPurple),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.deepPurple,
                          ),
                        )),
                    style: TextStyle(fontSize: 17, color: Colors.deepPurple),
                    controller: txtMatkhau,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: TextField(
                    obscureText: _obscureText2,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint[3],
                        hintStyle: TextStyle(color: Colors.deepPurple),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText2 = !_obscureText2;
                            });
                          },
                          child: Icon(
                            _obscureText2
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.deepPurple,
                          ),
                        )),
                    style: TextStyle(fontSize: 17, color: Colors.deepPurple),
                    controller: txtRWMatkhau,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () async {
                  if (txtEmail.text == "" ||
                      txtHoten.text == "" ||
                      txtMatkhau.text == "" ||
                      txtRWMatkhau.text == "") {
                    final snackBar = SnackBar(
                      /// need to set following properties for best effect of awesome_snackbar_content
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Cảnh báo',
                        message: 'Bạn vui lòng nhập đầy đủ tất cả các ô',

                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.warning,
                      ),
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                    return;
                  }
                  if (ktraEmail(txtEmail.text) == false) {
                    final snackBar = SnackBar(
                      /// need to set following properties for best effect of awesome_snackbar_content
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Thông báo',
                        message: 'Email không đúng định dạng',

                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.failure,
                      ),
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                    return;
                  } else {
                    for (int i = 0; i < thongTin.length; i++) {
                      if (txtEmail.text == thongTin[i].email) {
                        _dieukien = false;
                      }
                    }
                    if (_dieukien == false) {
                      final snackBar = SnackBar(
                        /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Thông báo',
                          message: 'Email đã được sử dụng để đăng ký trước đó',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          contentType: ContentType.warning,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                      return;
                    }
                  }
                  if (txtMatkhau.text.length < 6) {
                    final snackBar = SnackBar(
                      /// need to set following properties for best effect of awesome_snackbar_content
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Thông báo',
                        message: 'Mật khẩu phải có ý nhất 6 ký tự',

                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.failure,
                      ),
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                    return;
                  }
                  if (txtMatkhau.text != txtRWMatkhau.text) {
                    final snackBar = SnackBar(
                      /// need to set following properties for best effect of awesome_snackbar_content
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Thông báo',
                        message:
                            'Mật khẩu và nhập lại mật khẩu không trùng khớp',

                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.failure,
                      ),
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                    return;
                  }
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: txtEmail.text, password: txtMatkhau.text);
                    if (newUser != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginSecond()));
                      final snackBar = SnackBar(
                        /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Chúc mừng',
                          message: 'Bạn đã đăng ký tài khoản thành công',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          contentType: ContentType.success,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                      addUser();
                      addNoti();
                    }
                  } catch (e) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginSecond()));
                    final snackBar = SnackBar(
                      /// need to set following properties for best effect of awesome_snackbar_content
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Thông báo',
                        message: 'Đăng ký tài khoản không thành công',

                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.failure,
                      ),
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: LocaleText('dangki',
                        style: GoogleFonts.beVietnamPro(
                            color: Colors.white, fontSize: 20)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LocaleText('dacotaikhaon',
                    style: GoogleFonts.beVietnamPro(
                        fontSize: 14, color: Colors.black)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginSecond()));
                  },
                  child: LocaleText('dangnhapp',
                      style: GoogleFonts.beVietnamPro(
                          color: Colors.deepPurple, fontSize: 14)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
