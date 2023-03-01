import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app_by_dn/object/notification_object.dart';
import 'package:todo_app_by_dn/object/thongtin_object.dart';

class NotificationProvider {
  static Future<List<NotificationObject>> get(String email) async {
    List<NotificationObject> Noti = [];
    final snapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .where('email', isEqualTo: email)
        .get();
    Noti = snapshot.docs
        .map((json) =>
            NotificationObject.formJson(json.data() as Map<String, dynamic>))
        .toList();
    return Noti;
  }
}
