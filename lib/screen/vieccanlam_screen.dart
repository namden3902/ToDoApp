import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app_by_dn/object/todolist_object.dart';
import 'package:todo_app_by_dn/provider/thongtin_provider.dart';
import 'package:todo_app_by_dn/provider/todolist_provider.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../dif/notification.dart';

class ViecCanLam extends StatefulWidget {
  ViecCanLam({
    Key? key,
  }) : super(key: key);

  @override
  State<ViecCanLam> createState() => _ViecCanLamState();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class _ViecCanLamState extends State<ViecCanLam> {
  _ViecCanLamState({
    Key? key,
  });
  final _auth = FirebaseFirestore.instance;
  final grbController = GroupButtonController();
  final _grbController = GroupButtonController();
  CollectionReference TDL = FirebaseFirestore.instance.collection('todolist');
  int? id;
  TextEditingController txtND = TextEditingController();
  TextEditingController txtTD = TextEditingController();
  bool trangthai = false;
  bool trangthaixoa = false;
  int? douutien;
  DateTime selectedDate = DateTime.now();
  String thoigianlam = "";
  var docID;
  var querySnapshots;
  int selected = 0;
  List<ToDoID> toDO = [];
  String ngaythang = "";
  void _loadID() async {
    final data = await ToDoProvider.getID();
    setState(() {});
    toDO = data;
  }

  List<String> duutien = [];
  List<String> thoigianlamm = [];
  String hint = '';
  void douuu() {
    final lang = Localizations.localeOf(context).languageCode.toString();
    if (lang == 'vi') {
      duutien = [
        'Cao',
        'Trung bình',
        'Thấp',
      ];
      hint = 'Ghi vào đây việc bạn cần làm';
      thoigianlamm = ['Hôm nay', 'Để sau'];
    } else {
      hint = 'Write here what you need to do';
      duutien = ['Hight', 'Medium', 'Low'];
      thoigianlamm = ['Today', 'Later'];
    }
  }

  void _taongaythang() async {
    ngaythang = DateTime.now().year.toString();
    if (DateTime.now().month < 10) {
      ngaythang = ngaythang + '-0' + DateTime.now().month.toString();
    } else {
      ngaythang = ngaythang + '-' + DateTime.now().month.toString();
    }
    if (DateTime.now().day < 10) {
      ngaythang = ngaythang + '-0' + DateTime.now().day.toString();
    } else {
      ngaythang = ngaythang + '-' + DateTime.now().day.toString();
    }
    ngaythang = ngaythang + ' 00:00:00.000';
  }

  List<Color> lstColor = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent
  ];
  @override
  void initState() {
    super.initState();
    _loadID();
    _taongaythang();
    Noti.initalize(flutterLocalNotificationsPlugin);
  }

  Future<void> addToDo() {
    return TDL.add({
      'email': FirebaseAuth.instance.currentUser!.email!.toString(),
      'id': id,
      'noidung': txtND.text.toString(),
      'douutien': douutien,
      'thoigianlam': thoigianlam,
      'trangthai': trangthai,
      'trangthaixoa': trangthaixoa
    });
  }

  Future<void> addTodoCopy(
      String _noidung, int _douutien, String _thoigianlam) {
    return TDL.add({
      'email': FirebaseAuth.instance.currentUser!.email!.toString(),
      'id': id,
      'noidung': _noidung,
      'douutien': _douutien,
      'thoigianlam': _thoigianlam,
      'trangthai': trangthai,
      'trangthaixoa': trangthaixoa
    });
  }

  Future<void> updateToDo(var docID, bool checked) {
    return TDL.doc(docID).update({'trangthai': checked});
  }

  Future<void> deleteToDo(var docID, bool delete) {
    return TDL.doc(docID).update({'trangthaixoa': delete});
  }

  Future<void> updateNoiDung(
      var docID, String noidung, int? douutien, String thoigianlam) {
    return TDL.doc(docID).update(
        {'noidung': noidung, 'douutien': douutien, 'thoigianlam': thoigianlam});
  }

  Future<void> _showDiaglog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: Image.asset(
              'assets/goodjob.jpg',
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    douuu();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          txtND.clear();
          showDialog(
              context: context,
              builder: ((BuildContext context) {
                return AlertDialog(
                  title: LocaleText('addtodo',
                      style: GoogleFonts.beVietnamPro(
                          fontSize: 25, color: Colors.white)),
                  content: SingleChildScrollView(
                    child: SizedBox(
                      height: 250,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                height: 100,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 190, top: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Lottie.asset('assets/writting.json',
                                      fit: BoxFit.cover),
                                ),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none, hintText: hint),
                                style: GoogleFonts.beVietnamPro(
                                    fontSize: 16, color: Colors.black),
                                controller: txtND,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 190),
                            child: LocaleText(
                              'douutien',
                              style: GoogleFonts.beVietnamPro(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                          Row(
                            children: [
                              GroupButton(
                                options: GroupButtonOptions(
                                  borderRadius: BorderRadius.circular(8),
                                  unselectedColor: Colors.grey[50],
                                  selectedColor: Colors.white,
                                  unselectedTextStyle: GoogleFonts.beVietnamPro(
                                      color: Colors.deepPurple[100],
                                      fontSize: 12),
                                  selectedTextStyle: GoogleFonts.beVietnamPro(
                                      color: Colors.deepPurple, fontSize: 12),
                                ),
                                buttons: duutien,
                                isRadio: true,
                                onSelected: (value, index, isSelected) =>
                                    douutien = index + 1,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 170),
                            child: LocaleText(
                              'tglam',
                              style: GoogleFonts.beVietnamPro(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                          Row(
                            children: [
                              GroupButton(
                                  options: GroupButtonOptions(
                                    borderRadius: BorderRadius.circular(8),
                                    unselectedColor: Colors.grey[50],
                                    selectedColor: Colors.white,
                                    unselectedTextStyle:
                                        GoogleFonts.beVietnamPro(
                                            color: Colors.deepPurple[100],
                                            fontSize: 12),
                                    selectedTextStyle: GoogleFonts.beVietnamPro(
                                        color: Colors.deepPurple, fontSize: 12),
                                  ),
                                  buttons: thoigianlamm,
                                  isRadio: true,
                                  onSelected: (value, index, isSelected) {
                                    if (index == 0) {
                                      thoigianlam = ngaythang;
                                    } else {
                                      thoigianlam = "";
                                    }
                                  })
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          if (douutien == null ||
                              txtND.text == "" ||
                              thoigianlam == null) {
                            final snackBar = SnackBar(
                              /// need to set following properties for best effect of awesome_snackbar_content
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Cảnh báo',
                                message:
                                    'Bạn vui lòng nhập đầy đủ nội dung và chọn mức độ ưu tiên phù hợp',

                                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                contentType: ContentType.warning,
                              ),
                            );
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                            return;
                          }
                          id = toDO.length + 1;
                          addToDo();
                          txtND.clear();
                          douutien = null;
                          Navigator.pop(context);
                          _loadID();
                        },
                        child: LocaleText(
                          'them',
                          style: GoogleFonts.beVietnamPro(
                              color: Colors.white, fontSize: 18),
                        ))
                  ],
                  backgroundColor: Colors.deepPurple,
                );
              }));
        },
        child: Lottie.asset('assets/add2.json'),
        backgroundColor: Colors.white,
      ),
      body: WillPopScope(
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<ToDoObject>>(
                    future: ToDoProvider.getAll(
                        FirebaseAuth.instance.currentUser!.email.toString(),
                        trangthai,
                        ngaythang),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ToDoObject> toDoOJ = snapshot.data!;
                        toDoOJ
                            .sort(((a, b) => a.douutien.compareTo(b.douutien)));
                        return Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 150),
                                      child: Row(
                                        children: [
                                          LocaleText(
                                            'homnay',
                                            style: GoogleFonts.beVietnamPro(
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          CircleAvatar(
                                            child: Text(
                                              toDoOJ.length.toString(),
                                              style: GoogleFonts.beVietnamPro(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: Colors.deepPurple,
                                          )
                                        ],
                                      ),
                                    ),
                                    PopupMenuButton(
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                            onTap: () async {
                                              querySnapshots = await TDL.get();
                                              for (int i = 0;
                                                  i < toDoOJ.length;
                                                  i++) {
                                                for (var snapshot
                                                    in querySnapshots.docs) {
                                                  if (toDoOJ[i].id ==
                                                      snapshot['id']) {
                                                    docID = snapshot.id;
                                                  }
                                                }
                                                updateToDo(docID, !trangthai);
                                              }
                                              setState(() {});
                                            },
                                            child: Row(
                                              children: [
                                                LocaleText(
                                                  'hoanthanhtatca',
                                                  style:
                                                      GoogleFonts.beVietnamPro(
                                                          color: Colors.white),
                                                ),
                                                Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                )
                                              ],
                                            )),
                                        PopupMenuItem(
                                            onTap: () async {
                                              querySnapshots = await TDL.get();
                                              for (int i = 0;
                                                  i < toDoOJ.length;
                                                  i++) {
                                                for (var snapshot
                                                    in querySnapshots.docs) {
                                                  if (toDoOJ[i].id ==
                                                      snapshot['id']) {
                                                    docID = snapshot.id;
                                                  }
                                                }
                                                deleteToDo(
                                                    docID, !trangthaixoa);
                                              }
                                              setState(() {});
                                            },
                                            child: Row(
                                              children: [
                                                LocaleText(
                                                  'xoatatca',
                                                  style:
                                                      GoogleFonts.beVietnamPro(
                                                          color: Colors.white),
                                                ),
                                                Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ))
                                      ],
                                      color: Colors.deepPurple,
                                    )
                                  ],
                                )),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: toDoOJ.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Slidable(
                                      endActionPane: ActionPane(
                                        motion: StretchMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: ((context) async {
                                              bool delete = true;
                                              querySnapshots = await TDL.get();
                                              for (var snapshot
                                                  in querySnapshots.docs) {
                                                if (toDoOJ[index].id ==
                                                    snapshot['id']) {
                                                  docID = snapshot.id;
                                                }
                                              }
                                              deleteToDo(docID, delete);
                                              // setState(() {});
                                            }),
                                            icon: Icons.delete,
                                            backgroundColor:
                                                Colors.deepOrangeAccent,
                                          ),
                                          SlidableAction(
                                            onPressed: ((context) async {
                                              // setState(() {});
                                              _loadID();
                                              id = toDO.length + 1;
                                              addTodoCopy(
                                                  toDoOJ[index].noidung,
                                                  toDoOJ[index].douutien,
                                                  toDoOJ[index].thoigianlam);
                                            }),
                                            icon: Icons.copy,
                                            backgroundColor: Colors.redAccent,
                                          ),
                                        ],
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          txtND.text =
                                              toDoOJ[index].noidung.toString();
                                          grbController.selectIndex(
                                              toDoOJ[index].douutien - 1);
                                          douutien = toDoOJ[index].douutien;
                                          if (toDoOJ[index].thoigianlam ==
                                              ngaythang) {
                                            _grbController.selectIndex(0);
                                          }
                                          if (toDoOJ[index].thoigianlam !=
                                                  ngaythang ||
                                              toDoOJ[index].thoigianlam == '') {
                                            _grbController.selectIndex(1);
                                          }
                                          thoigianlam =
                                              toDoOJ[index].thoigianlam;
                                          showDialog(
                                              context: context,
                                              builder: ((BuildContext context) {
                                                return AlertDialog(
                                                  title: LocaleText('thaydoi',
                                                      style: GoogleFonts
                                                          .beVietnamPro(
                                                              fontSize: 25,
                                                              color: Colors
                                                                  .white)),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: SizedBox(
                                                      height: 250,
                                                      child: Column(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8)),
                                                                height: 100,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            190,
                                                                        top: 8),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                  child: Lottie.asset(
                                                                      'assets/writting.json',
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                              ),
                                                              TextField(
                                                                decoration: InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        'Ghi vào đây việc bạn cần làm'),
                                                                style: GoogleFonts
                                                                    .beVietnamPro(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .black),
                                                                controller:
                                                                    txtND,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 190),
                                                            child: LocaleText(
                                                              'douutien',
                                                              style: GoogleFonts
                                                                  .beVietnamPro(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              GroupButton(
                                                                controller:
                                                                    grbController,
                                                                options:
                                                                    GroupButtonOptions(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  unselectedColor:
                                                                      Colors.grey[
                                                                          50],
                                                                  selectedColor:
                                                                      Colors
                                                                          .white,
                                                                  unselectedTextStyle: GoogleFonts.beVietnamPro(
                                                                      color: Colors
                                                                              .deepPurple[
                                                                          100],
                                                                      fontSize:
                                                                          12),
                                                                  selectedTextStyle: GoogleFonts.beVietnamPro(
                                                                      color: Colors
                                                                          .deepPurple,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                buttons:
                                                                    duutien,
                                                                isRadio: true,
                                                                onSelected: (value,
                                                                        index,
                                                                        isSelected) =>
                                                                    douutien =
                                                                        index +
                                                                            1,
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 170),
                                                            child: LocaleText(
                                                              'tglam',
                                                              style: GoogleFonts
                                                                  .beVietnamPro(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              GroupButton(
                                                                  controller:
                                                                      _grbController,
                                                                  options:
                                                                      GroupButtonOptions(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    unselectedColor:
                                                                        Colors.grey[
                                                                            50],
                                                                    selectedColor:
                                                                        Colors
                                                                            .white,
                                                                    unselectedTextStyle: GoogleFonts.beVietnamPro(
                                                                        color: Colors.deepPurple[
                                                                            100],
                                                                        fontSize:
                                                                            12),
                                                                    selectedTextStyle: GoogleFonts.beVietnamPro(
                                                                        color: Colors
                                                                            .deepPurple,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  buttons:
                                                                      thoigianlamm,
                                                                  isRadio: true,
                                                                  onSelected:
                                                                      (value,
                                                                          index,
                                                                          isSelected) {
                                                                    if (index ==
                                                                        0) {
                                                                      thoigianlam =
                                                                          ngaythang;
                                                                    } else {
                                                                      thoigianlam =
                                                                          "";
                                                                    }
                                                                  })
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          if (douutien ==
                                                                  null ||
                                                              txtND.text ==
                                                                  "") {
                                                            final snackBar =
                                                                SnackBar(
                                                              /// need to set following properties for best effect of awesome_snackbar_content
                                                              elevation: 0,
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              content:
                                                                  AwesomeSnackbarContent(
                                                                title:
                                                                    'Cảnh báo',
                                                                message:
                                                                    'Bạn chưa nhập đẩy đủ nội dung',

                                                                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                contentType:
                                                                    ContentType
                                                                        .warning,
                                                              ),
                                                            );
                                                            ScaffoldMessenger
                                                                .of(context)
                                                              ..hideCurrentSnackBar()
                                                              ..showSnackBar(
                                                                  snackBar);
                                                            return;
                                                          }
                                                          querySnapshots =
                                                              await TDL.get();
                                                          for (var snapshot
                                                              in querySnapshots
                                                                  .docs) {
                                                            if (toDoOJ[index]
                                                                    .id ==
                                                                snapshot[
                                                                    'id']) {
                                                              docID =
                                                                  snapshot.id;
                                                            }
                                                          }
                                                          updateNoiDung(
                                                              docID,
                                                              txtND.text
                                                                  .toString(),
                                                              douutien,
                                                              thoigianlam);
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                          txtND.clear();
                                                        },
                                                        child: LocaleText(
                                                          'thaydoi',
                                                          style: GoogleFonts
                                                              .beVietnamPro(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .white),
                                                        ))
                                                  ],
                                                  backgroundColor:
                                                      Colors.deepPurple,
                                                );
                                              }));
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: lstColor[
                                                toDoOJ[index].douutien - 1],
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                  value:
                                                      toDoOJ[index].trangthai,
                                                  onChanged:
                                                      (bool? value) async {
                                                    bool checked = value!;
                                                    querySnapshots =
                                                        await TDL.get();
                                                    for (var snapshot
                                                        in querySnapshots
                                                            .docs) {
                                                      if (toDoOJ[index].id ==
                                                          snapshot['id']) {
                                                        docID = snapshot.id;
                                                      }
                                                    }
                                                    updateToDo(docID, checked);
                                                    if (checked) {
                                                      Noti.showNotification(
                                                          title: 'Thông báo',
                                                          body:
                                                              'Bạn đã hoàn thành việc:' +
                                                                  toDoOJ[index]
                                                                      .noidung,
                                                          fln:
                                                              flutterLocalNotificationsPlugin);
                                                    }
                                                    setState(() {});
                                                  }),
                                              Text(
                                                toDoOJ[index]
                                                    .noidung
                                                    .toString(),
                                                style: GoogleFonts.beVietnamPro(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        );
                      }
                      if (snapshot.hasError) {
                        return Text('data');
                      }
                      return Center(
                          child: SpinKitRing(
                        size: 40,
                        color: Colors.deepPurple,
                      ));
                    },
                  ),
                  FutureBuilder<List<ToDoObject>>(
                    future: ToDoProvider.getLater(
                        FirebaseAuth.instance.currentUser!.email!.toString(),
                        trangthai,
                        ngaythang),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ToDoObject> toDoLT = snapshot.data!;
                        toDoLT
                            .sort(((a, b) => a.douutien.compareTo(b.douutien)));
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 170),
                                        child: Row(
                                          children: [
                                            LocaleText(
                                              'desau',
                                              style: GoogleFonts.beVietnamPro(
                                                  fontSize: 20),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            CircleAvatar(
                                              child: Text(
                                                toDoLT.length.toString(),
                                                style: GoogleFonts.beVietnamPro(
                                                    color: Colors.white),
                                              ),
                                              backgroundColor:
                                                  Colors.deepPurple,
                                            )
                                          ],
                                        ),
                                      ),
                                      PopupMenuButton(
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                              onTap: () async {
                                                querySnapshots =
                                                    await TDL.get();
                                                for (int i = 0;
                                                    i < toDoLT.length;
                                                    i++) {
                                                  for (var snapshot
                                                      in querySnapshots.docs) {
                                                    if (toDoLT[i].id ==
                                                        snapshot['id']) {
                                                      docID = snapshot.id;
                                                    }
                                                  }
                                                  updateToDo(docID, !trangthai);
                                                }
                                                setState(() {});
                                              },
                                              child: Row(
                                                children: [
                                                  LocaleText(
                                                    'hoanthanhtatca',
                                                    style: GoogleFonts
                                                        .beVietnamPro(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                  Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                  )
                                                ],
                                              )),
                                          PopupMenuItem(
                                              onTap: () async {
                                                querySnapshots =
                                                    await TDL.get();
                                                for (int i = 0;
                                                    i < toDoLT.length;
                                                    i++) {
                                                  for (var snapshot
                                                      in querySnapshots.docs) {
                                                    if (toDoLT[i].id ==
                                                        snapshot['id']) {
                                                      docID = snapshot.id;
                                                    }
                                                  }
                                                  deleteToDo(
                                                      docID, !trangthaixoa);
                                                }
                                                setState(() {});
                                              },
                                              child: Row(
                                                children: [
                                                  LocaleText(
                                                    'xoatatca',
                                                    style: GoogleFonts
                                                        .beVietnamPro(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                  Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  )
                                                ],
                                              ))
                                        ],
                                        color: Colors.deepPurple,
                                      )
                                    ],
                                  )),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: toDoLT.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Slidable(
                                        endActionPane: ActionPane(
                                          motion: StretchMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: ((context) async {
                                                bool delete = true;
                                                querySnapshots =
                                                    await TDL.get();
                                                for (var snapshot
                                                    in querySnapshots.docs) {
                                                  if (toDoLT[index].id ==
                                                      snapshot['id']) {
                                                    docID = snapshot.id;
                                                  }
                                                }
                                                deleteToDo(docID, delete);
                                              }),
                                              icon: Icons.delete,
                                              backgroundColor:
                                                  Colors.deepOrangeAccent,
                                            ),
                                          ],
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            txtND.text = toDoLT[index]
                                                .noidung
                                                .toString();
                                            grbController.selectIndex(
                                                toDoLT[index].douutien - 1);
                                            douutien = toDoLT[index].douutien;
                                            if (toDoLT[index].thoigianlam ==
                                                ngaythang) {
                                              _grbController.selectIndex(0);
                                            }
                                            if (toDoLT[index].thoigianlam !=
                                                    ngaythang ||
                                                toDoLT[index].thoigianlam ==
                                                    '') {
                                              _grbController.selectIndex(1);
                                            }
                                            thoigianlam =
                                                toDoLT[index].thoigianlam;
                                            showDialog(
                                                context: context,
                                                builder:
                                                    ((BuildContext context) {
                                                  return AlertDialog(
                                                    title: LocaleText('thaydoi',
                                                        style: GoogleFonts
                                                            .beVietnamPro(
                                                                fontSize: 25,
                                                                color: Colors
                                                                    .white)),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: SizedBox(
                                                        height: 250,
                                                        child: Column(
                                                          children: [
                                                            Stack(
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                  height: 100,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              190,
                                                                          top:
                                                                              8),
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8)),
                                                                    child: Lottie.asset(
                                                                        'assets/writting.json',
                                                                        fit: BoxFit
                                                                            .cover),
                                                                  ),
                                                                ),
                                                                TextField(
                                                                  decoration: InputDecoration(
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintText:
                                                                          hint),
                                                                  style: GoogleFonts.beVietnamPro(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                                  controller:
                                                                      txtND,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          190),
                                                              child: LocaleText(
                                                                'douutien',
                                                                style: GoogleFonts
                                                                    .beVietnamPro(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                GroupButton(
                                                                  controller:
                                                                      grbController,
                                                                  options:
                                                                      GroupButtonOptions(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    unselectedColor:
                                                                        Colors.grey[
                                                                            50],
                                                                    selectedColor:
                                                                        Colors
                                                                            .white,
                                                                    unselectedTextStyle: GoogleFonts.beVietnamPro(
                                                                        color: Colors.deepPurple[
                                                                            100],
                                                                        fontSize:
                                                                            12),
                                                                    selectedTextStyle: GoogleFonts.beVietnamPro(
                                                                        color: Colors
                                                                            .deepPurple,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  buttons:
                                                                      duutien,
                                                                  isRadio: true,
                                                                  onSelected: (value,
                                                                          index,
                                                                          isSelected) =>
                                                                      douutien =
                                                                          index +
                                                                              1,
                                                                )
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          170),
                                                              child: LocaleText(
                                                                'tglam',
                                                                style: GoogleFonts
                                                                    .beVietnamPro(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                GroupButton(
                                                                    controller:
                                                                        _grbController,
                                                                    options:
                                                                        GroupButtonOptions(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      unselectedColor:
                                                                          Colors
                                                                              .grey[50],
                                                                      selectedColor:
                                                                          Colors
                                                                              .white,
                                                                      unselectedTextStyle: GoogleFonts.beVietnamPro(
                                                                          color: Colors.deepPurple[
                                                                              100],
                                                                          fontSize:
                                                                              12),
                                                                      selectedTextStyle: GoogleFonts.beVietnamPro(
                                                                          color: Colors
                                                                              .deepPurple,
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                    buttons:
                                                                        thoigianlamm,
                                                                    isRadio:
                                                                        true,
                                                                    onSelected:
                                                                        (value,
                                                                            index,
                                                                            isSelected) {
                                                                      if (index ==
                                                                          0) {
                                                                        thoigianlam =
                                                                            ngaythang;
                                                                      } else {
                                                                        thoigianlam =
                                                                            "";
                                                                      }
                                                                    })
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () async {
                                                            if (douutien ==
                                                                    null ||
                                                                txtND.text ==
                                                                    "") {
                                                              final snackBar =
                                                                  SnackBar(
                                                                /// need to set following properties for best effect of awesome_snackbar_content
                                                                elevation: 0,
                                                                behavior:
                                                                    SnackBarBehavior
                                                                        .floating,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                content:
                                                                    AwesomeSnackbarContent(
                                                                  title:
                                                                      'Cảnh báo',
                                                                  message:
                                                                      'Bạn chưa nhập đẩy đủ nội dung',

                                                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                  contentType:
                                                                      ContentType
                                                                          .warning,
                                                                ),
                                                              );
                                                              ScaffoldMessenger
                                                                  .of(context)
                                                                ..hideCurrentSnackBar()
                                                                ..showSnackBar(
                                                                    snackBar);
                                                              return;
                                                            }
                                                            querySnapshots =
                                                                await TDL.get();
                                                            for (var snapshot
                                                                in querySnapshots
                                                                    .docs) {
                                                              if (toDoLT[index]
                                                                      .id ==
                                                                  snapshot[
                                                                      'id']) {
                                                                docID =
                                                                    snapshot.id;
                                                              }
                                                            }
                                                            updateNoiDung(
                                                                docID,
                                                                txtND.text
                                                                    .toString(),
                                                                douutien,
                                                                thoigianlam);
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                            txtND.clear();
                                                          },
                                                          child: LocaleText(
                                                            'thaydoi',
                                                            style: GoogleFonts
                                                                .beVietnamPro(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18),
                                                          ))
                                                    ],
                                                    backgroundColor:
                                                        Colors.deepPurple,
                                                  );
                                                }));
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: lstColor[
                                                  toDoLT[index].douutien - 1],
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                    value:
                                                        toDoLT[index].trangthai,
                                                    onChanged:
                                                        (bool? value) async {
                                                      bool checked = value!;
                                                      querySnapshots =
                                                          await TDL.get();
                                                      for (var snapshot
                                                          in querySnapshots
                                                              .docs) {
                                                        if (toDoLT[index].id ==
                                                            snapshot['id']) {
                                                          docID = snapshot.id;
                                                        }
                                                      }
                                                      updateToDo(
                                                          docID, checked);
                                                      if (checked) {
                                                        Noti.showNotification(
                                                            title: 'Thông báo',
                                                            body: 'Bạn đã hoàn thành việc:' +
                                                                toDoLT[index]
                                                                    .noidung,
                                                            fln:
                                                                flutterLocalNotificationsPlugin);
                                                      }
                                                      setState(() {});
                                                    }),
                                                Text(
                                                  toDoLT[index]
                                                      .noidung
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        );
                      }
                      return Text("");
                    },
                  ),
                ],
              ),
            ],
          ),
          onWillPop: () async {
            return false;
          }),
    );
  }
}
