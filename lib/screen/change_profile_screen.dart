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

class ChangeProfiel extends StatefulWidget {
  ChangeProfiel({
    Key? key,
  }) : super(key: key);
  @override
  State<ChangeProfiel> createState() => _ChangeProfielState();
}

class _ChangeProfielState extends State<ChangeProfiel> {
  _ChangeProfielState({
    Key? key,
  });
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController txtHoTen = TextEditingController();
  int temp1 = 0;
  var docID;
  var querySnapshots;
  Future<void> updateThongTin(String hoten) {
    return users.doc(docID).update({'hoten': hoten});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ThongTinObject>>(
        future: ThongTinProvider.get(
          FirebaseAuth.instance.currentUser!.email!.toString(),
        ),
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
                          bottomRight: Radius.circular(80),
                        ),
                        color: Colors.deepPurple,
                      ),
                      child: Stack(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 180, top: 50),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 80),
                                  child: LocaleText(
                                    'thongtin',
                                    style: GoogleFonts.beVietnamPro(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Lottie.asset('assets/profile.json')
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        height: 250,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 270),
                                    child: Text(
                                      'Email:',
                                      style: GoogleFonts.beVietnamPro(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          // color: Colors.grey[200],
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: TextField(
                                          enabled: false,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: thongTin[0].email),
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 180),
                                    child: LocaleText(
                                      'tenngdung',
                                      style: GoogleFonts.beVietnamPro(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          // color: Colors.grey[200],
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: TextField(
                                          controller: txtHoTen,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: temp1 == 0
                                                  ? thongTin[0].hoten
                                                  : ""),
                                          style: TextStyle(fontSize: 17),
                                          onTap: () {
                                            temp1 == 0;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () async {
                          querySnapshots = await users.get();
                          for (var snapshot in querySnapshots.docs) {
                            if (thongTin[0].email == snapshot['email']) {
                              docID = snapshot.id;
                            }
                          }
                          if (txtHoTen.text == "") {
                            final snackBar = SnackBar(
                              /// need to set following properties for best effect of awesome_snackbar_content
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Thông báo',
                                message:
                                    'Không có gì thay đổi để tiến hành cập nhập',

                                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                contentType: ContentType.failure,
                              ),
                            );
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                            return;
                          } else {
                            updateThongTin(txtHoTen.text).then((value) {
                              final snackBar = SnackBar(
                                /// need to set following properties for best effect of awesome_snackbar_content
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Chúc mừng',
                                  message:
                                      'Bạn đã cập nhập thông tin thành công',

                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                  contentType: ContentType.success,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              setState(() {
                                txtHoTen.text = '';
                              });

                              return;
                            }).onError((error, stackTrace) => null);
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
                              'capnhap',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
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
          return Text('');
        });
  }
}
