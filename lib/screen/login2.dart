import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_by_dn/object/thongtin_object.dart';
import 'package:todo_app_by_dn/provider/thongtin_provider.dart';

import 'package:todo_app_by_dn/screen/regissterr_green.dart';
import 'package:todo_app_by_dn/screen/vieccanlam_screen.dart';
import '../provider/theme_provider.dart';
import 'forgot_passwork_screen.dart';
import 'main_screen.dart';
import 'package:file/local.dart';

class LoginSecond extends StatefulWidget {
  const LoginSecond({super.key});

  @override
  State<LoginSecond> createState() => _LoginSecondState();
}

class _LoginSecondState extends State<LoginSecond> {
  final txtEmail = TextEditingController();
  final txtPass = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _obscureText = true;
  final email = LocaleText('email');
  final matkhau = LocaleText('matkhau');

  Future<void> Login(String email, String matkhau) async {
    try {
      final _user = await _auth.signInWithEmailAndPassword(
          email: txtEmail.text, password: txtPass.text);
      _auth.authStateChanges().listen((event) {
        if (event != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: languages[3],
              message: 'Bạn đã đăng nhập thành công',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.success,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      });
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: languages[2],
          message: 'Email hoặc mật khẩu không chính xác',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  bool ktraEmail(String email) {
    bool isvalid = EmailValidator.validate(email);
    return isvalid;
  }

  @override
  void initState() {
    super.initState();
  }

  List<String> languages = [];
  void douuu() {
    final lang = Localizations.localeOf(context).languageCode.toString();
    if (lang == 'vi') {
      languages = [
        'Mật khẩu',
        'Cảnh báo',
        'Thông báo',
        'Chúc mừng',
      ];
    } else {
      languages = [
        'Password',
        'Warnning',
        'Notification',
        'Congratulation',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    douuu();
    return WillPopScope(
        child: Scaffold(
          body: Container(
            width: double.infinity,
            color: Colors.deepPurple,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                LocaleText(
                  'dangnhap',
                  style: GoogleFonts.beVietnamPro(
                      color: Colors.white, fontSize: 40),
                ),
                LocaleText(
                  'loichuc',
                  style: GoogleFonts.beVietnamPro(
                      color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60)),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 300),
                            child: LocaleText(
                              'email',
                              style: GoogleFonts.beVietnamPro(
                                  fontSize: 18, color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Container(
                              decoration: BoxDecoration(
                                  // color: Colors.grey[200],
                                  border: Border.all(color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: TextField(
                                  controller: txtEmail,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email',
                                      hintStyle:
                                          TextStyle(color: Colors.deepPurple),
                                      prefixIcon: Icon(
                                        Icons.mail,
                                        color: Colors.deepPurple,
                                      )),
                                  style: TextStyle(
                                      color: Colors.deepPurple, fontSize: 17),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(right: 265),
                              child: LocaleText(
                                'matkhau',
                                style: GoogleFonts.beVietnamPro(
                                    fontSize: 18, color: Colors.black),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: TextField(
                                  style: TextStyle(
                                      color: Colors.deepPurple, fontSize: 17),
                                  controller: txtPass,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: languages[0],
                                      hintStyle:
                                          TextStyle(color: Colors.deepPurple),
                                      prefixIcon: Icon(
                                        Icons.password,
                                        color: Colors.deepPurple,
                                      ),
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
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 240, top: 10),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword()));
                                },
                                child: LocaleText(
                                  'quenmatkhau',
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: GestureDetector(
                              onTap: () async {
                                if (txtEmail.text == "" || txtPass.text == "") {
                                  final snackBar = SnackBar(
                                    /// need to set following properties for best effect of awesome_snackbar_content
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: languages[1],
                                      message:
                                          'Bạn vui lòng nhập đầy đủ tất cả các ô',

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
                                      title: languages[1],
                                      message:
                                          'Bạn chưa nhập đúng định dạng email',

                                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                      contentType: ContentType.warning,
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);
                                  return;
                                }

                                Login(txtEmail.text, txtPass.text);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                    child: LocaleText(
                                  'dangnhap',
                                  style: GoogleFonts.beVietnamPro(
                                      fontSize: 18, color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LocaleText(
                                'chuacotaikhoan',
                                style: GoogleFonts.beVietnamPro(
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()));
                                },
                                child: LocaleText('dangky',
                                    style: GoogleFonts.beVietnamPro(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          LocaleText(
                            'lang',
                            style: GoogleFonts.beVietnamPro(
                                color: Colors.deepPurple, fontSize: 16),
                          ),
                          Consumer<ThemeProvider>(
                              builder: (context, provider, child) {
                            return DropdownButton<String>(
                                value: provider.currentLangugae,
                                items: [
                                  DropdownMenuItem<String>(
                                      value: 'VNE',
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/vietnam.png',
                                            height: 40,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'VNE',
                                            style: GoogleFonts.beVietnamPro(
                                                color: Colors.deepPurple),
                                          )
                                        ],
                                      )),
                                  DropdownMenuItem(
                                      value: 'ENG',
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/unitedkingdom.png',
                                            height: 40,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'ENG',
                                            style: GoogleFonts.beVietnamPro(
                                                color: Colors.deepPurple),
                                          )
                                        ],
                                      )),
                                ],
                                onChanged: (String? value) {
                                  if (value == 'VNE') {
                                    provider.changeLanguage(value!);
                                    LocaleNotifier.of(context)?.change('vi');
                                  }
                                  if (value == 'ENG') {
                                    provider.changeLanguage(value!);
                                    LocaleNotifier.of(context)?.change('en');
                                  }
                                });
                          })
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
