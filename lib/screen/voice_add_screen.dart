import 'package:avatar_glow/avatar_glow.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:todo_app_by_dn/dif/drawer.dart';

import '../object/todolist_object.dart';
import '../provider/todolist_provider.dart';

class VoicAdd extends StatefulWidget {
  VoicAdd({
    Key? key,
  }) : super(key: key);
  @override
  State<VoicAdd> createState() => _VoicAddState();
}

class _VoicAddState extends State<VoicAdd> {
  _VoicAddState({
    Key? key,
  });

  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  final _auth = FirebaseFirestore.instance;
  final grbController = GroupButtonController();
  CollectionReference TDL = FirebaseFirestore.instance.collection('todolist');
  int? id;
  String thoigianlam = "";
  bool trangthai = false;
  bool trangthaixoa = false;
  int? douutien;
  List<String> duutien = [];
  List<String> thoigianlamm = [];
  void douuu() {
    final lang = Localizations.localeOf(context).languageCode.toString();
    if (lang == 'vi') {
      duutien = ['Cao', 'Trung bình', 'Thấp'];
      thoigianlamm = ['Hôm nay', 'Để sau'];
    } else {
      duutien = ['Hight', 'Medium', 'Low'];
      thoigianlamm = ['Today', 'Later'];
    }
  }

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _loadID();
  }

  List<ToDoID> toDO = [];

  void _loadID() async {
    final data = await ToDoProvider.getID();
    setState(() {});
    toDO = data;
  }

  Future<void> addToDo() {
    return TDL.add({
      'email': FirebaseAuth.instance.currentUser!.email!.toString(),
      'id': id,
      'noidung': _lastWords,
      'douutien': douutien,
      'thoigianlam': thoigianlam,
      'trangthai': trangthai,
      'trangthaixoa': trangthaixoa
    }).then((value) {
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Chúc mừng',
          message: 'Bạn đã thêm thành công !',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return;
    });
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    douuu();
    return Scaffold(
      appBar: AppBar(
        title: LocaleText(
          'thembangiongnoi',
          style: GoogleFonts.beVietnamPro(fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawww(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: LocaleText(
                _speechToText.isListening
                    ? '$_lastWords'
                    : _speechEnabled
                        ? 'tittle1'
                        : 'microerror',
                style: GoogleFonts.beVietnamPro(),
              ),
            ),
            Container(
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 180),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: LocaleText(
                        'douutien',
                        style: GoogleFonts.beVietnamPro(color: Colors.white),
                      ),
                    ),
                  ),
                  GroupButton(
                      options: GroupButtonOptions(
                        borderRadius: BorderRadius.circular(8),
                        unselectedColor: Colors.grey[50],
                        selectedColor: Colors.white,
                        unselectedTextStyle: GoogleFonts.beVietnamPro(
                            color: Colors.deepPurple[100]),
                        selectedTextStyle:
                            GoogleFonts.beVietnamPro(color: Colors.deepPurple),
                        buttonWidth: 80,
                      ),
                      buttons: duutien,
                      isRadio: true,
                      onSelected: (value, index, isSelected) {
                        douutien = index + 1;
                      }),
                  Padding(
                    padding: const EdgeInsets.only(right: 160),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: LocaleText(
                        'tglam',
                        style: GoogleFonts.beVietnamPro(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 73),
                    child: GroupButton(
                        options: GroupButtonOptions(
                          borderRadius: BorderRadius.circular(8),
                          unselectedColor: Colors.grey[50],
                          selectedColor: Colors.white,
                          unselectedTextStyle: GoogleFonts.beVietnamPro(
                              color: Colors.deepPurple[100]),
                          selectedTextStyle: GoogleFonts.beVietnamPro(
                              color: Colors.deepPurple),
                          buttonWidth: 80,
                        ),
                        buttons: thoigianlamm,
                        isRadio: true,
                        onSelected: (value, index, isSelected) {
                          if (index == 0) {
                            thoigianlam = DateTime.now().toString();
                          }
                          if (index == 1) {
                            thoigianlam = "";
                          }
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: GestureDetector(
                onTap: () async {
                  if (douutien == null ||
                      _lastWords == "" ||
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
                  _lastWords = '';
                  Navigator.pop(context);
                  _loadID();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: LocaleText('them',
                        style: GoogleFonts.beVietnamPro(
                            color: Colors.white, fontSize: 15)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed:
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
