import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app_by_dn/object/thongtin_object.dart';

class ThongTinProvider {
  static Future<List<ThongTinObject>> get(String email) async {
    List<ThongTinObject> ThongTin = [];
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    ThongTin = snapshot.docs
        .map((json) =>
            ThongTinObject.formJson(json.data() as Map<String, dynamic>))
        .toList();
    return ThongTin;
  }

  static Future<List<ThongTinObject>> getData() async {
    List<ThongTinObject> ThongTinALL = [];
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    ThongTinALL = snapshot.docs
        .map((json) =>
            ThongTinObject.formJson(json.data() as Map<String, dynamic>))
        .toList();
    return ThongTinALL;
  }
}
