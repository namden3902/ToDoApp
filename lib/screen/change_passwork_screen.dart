import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app_by_dn/object/thongtin_object.dart';
import 'package:todo_app_by_dn/provider/thongtin_provider.dart';
import 'package:todo_app_by_dn/screen/login2.dart';

class ChangePasswork extends StatefulWidget {
  String? email;
  String? matkhau;
  ChangePasswork({this.email, this.matkhau});

  @override
  State<ChangePasswork> createState() =>
      _ChangePassworkState(email: email, matkhau: matkhau);
}

class _ChangePassworkState extends State<ChangePasswork> {
  String? email;
  String? matkhau;
  _ChangePassworkState({this.email, this.matkhau});

  TextEditingController txtPassnew = TextEditingController();
  TextEditingController txtPassnewrw = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance.currentUser;
  bool _obscureText = true;
  bool _oobscureText1 = true;
  bool _oobscureText2 = true;
  int temp1 = 0;
  int temp2 = 0;

  var docID;
  var querySnapshots;

  List<String> hint = [];
  void ngonngu() {
    final lang = Localizations.localeOf(context).languageCode.toString();
    if (lang == 'vi') {
      hint = ['Mật khẩu mới', 'Nhập lại mật khẩu mới'];
    } else {
      hint = ['New password', 'Re-enter new password'];
    }
  }

  Future<void> updateMatKhau(String matkhau) {
    return users.doc(docID).update({'matkhau': matkhau});
  }

  @override
  Widget build(BuildContext context) {
    ngonngu();
    return FutureBuilder<List<ThongTinObject>>(
      future: ThongTinProvider.get(
          FirebaseAuth.instance.currentUser!.email!.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ThongTinObject> thongTin = snapshot.data!;
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                      ),
                      color: Colors.deepPurple,
                    ),
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 180, top: 120),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: LocaleText(
                                  'doimk',
                                  style: GoogleFonts.beVietnamPro(
                                      fontSize: 25, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Lottie.asset('assets/register.json')
                    ]),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                          // color: Colors.grey[200],
                          border: Border.all(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: TextField(
                          controller: txtPassnew,
                          obscureText: _oobscureText1,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: hint[0],
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _oobscureText1 = !_oobscureText1;
                                  });
                                },
                                child: Icon(_oobscureText1
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              )),
                          style: TextStyle(fontSize: 17),
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
                          // color: Colors.grey[200],
                          border: Border.all(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: TextField(
                          controller: txtPassnewrw,
                          obscureText: _oobscureText2,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: hint[1],
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _oobscureText2 = !_oobscureText2;
                                  });
                                },
                                child: Icon(_oobscureText2
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              )),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 38,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: () async {
                        //Kiểm tra ô trống
                        if (txtPassnew.text == "" || txtPassnewrw == "") {
                          final snackBar = SnackBar(
                            /// need to set following properties for best effect of awesome_snackbar_content
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Cảnh báo',
                              message: 'Bạn vui lòng nhập đủ tất cả các ô',

                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                              contentType: ContentType.warning,
                            ),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                          return;
                        }

                        //Kiểm tra độ dài mật khẩu mới
                        if (txtPassnew.text.length < 6) {
                          final snackBar = SnackBar(
                            /// need to set following properties for best effect of awesome_snackbar_content
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Oh không',
                              message: 'Mật khẩu phải có ít nhất 6 ký tự',

                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                              contentType: ContentType.failure,
                            ),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                          return;
                        }
                        //Kiểm tra trùng khớp
                        if (txtPassnew.text != txtPassnewrw.text) {
                          final snackBar = SnackBar(
                            /// need to set following properties for best effect of awesome_snackbar_content
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Oh không',
                              message:
                                  'Mật khẩu mới và nhập lại mật khẩu mới không trùng khớp với nhau',

                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                              contentType: ContentType.failure,
                            ),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                          return;
                        } else {
                          final user = await _auth
                              ?.updatePassword(txtPassnew.text)
                              .then((value) {
                            updateMatKhau(txtPassnew.text);
                            FirebaseAuth.instance.signOut();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginSecond()),
                              ModalRoute.withName('/'),
                            );
                            final snackBar = SnackBar(
                              /// need to set following properties for best effect of awesome_snackbar_content
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Chúc mừng',
                                message:
                                    'Cập nhập lai mật khẩu thành công, vui lòng đăng nhập lại',

                                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                contentType: ContentType.success,
                              ),
                            );
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          }).catchError((error) {
                            final snackBar = SnackBar(
                              /// need to set following properties for best effect of awesome_snackbar_content
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Thông báo',
                                message: 'Cập nhập mật khẩu không thành công',

                                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                contentType: ContentType.failure,
                              ),
                            );
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: LocaleText(
                            'thaydoi',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
              child: SpinKitRing(
            size: 40,
            color: Colors.deepPurple,
          ));
        }
      },
    );
  }
}
