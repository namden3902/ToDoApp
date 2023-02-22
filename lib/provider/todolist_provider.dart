import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_by_dn/object/todolist_object.dart';

class ToDoProvider {
  static Future<List<ToDoID>> getID() async {
    List<ToDoID> ToDoo = [];
    final snapshot = await FirebaseFirestore.instance
        .collection('todolist')
        .orderBy('id', descending: true)
        .get();
    ToDoo = snapshot.docs
        .map((json) => ToDoID.fromJson(json.data() as Map<String, dynamic>))
        .toList();
    return ToDoo;
  }

  static Future<List<ToDoObject>> getAll(
      String email, bool TrangThai, String ngaythang) async {
    List<ToDoObject> ToDooo = [];
    final snapshot = await FirebaseFirestore.instance
        .collection('todolist')
        .where('email', isEqualTo: email)
        .where('trangthaixoa', isEqualTo: TrangThai)
        .where('trangthai', isEqualTo: TrangThai)
        .where('thoigianlam', isEqualTo: ngaythang)
        .get();
    ToDooo = snapshot.docs
        .map((json) => ToDoObject.fromJson(json.data() as Map<String, dynamic>))
        .toList();
    return ToDooo;
  }

  static Future<List<ToDoObject>> getLater(
      String email, bool TrangThai, String ngaythang) async {
    List<ToDoObject> ToDooo = [];
    final snapshot = await FirebaseFirestore.instance
        .collection('todolist')
        .where('email', isEqualTo: email)
        .where('trangthaixoa', isEqualTo: TrangThai)
        .where('trangthai', isEqualTo: TrangThai)
        .where('thoigianlam', isNotEqualTo: ngaythang)
        .get();
    ToDooo = snapshot.docs
        .map((json) => ToDoObject.fromJson(json.data() as Map<String, dynamic>))
        .toList();
    return ToDooo;
  }

  static Future<List<ToDoObject>> getAllCompleted(
      String email, bool TrangThai) async {
    List<ToDoObject> ToDooo = [];
    final snapshot = await FirebaseFirestore.instance
        .collection('todolist')
        .where('email', isEqualTo: email)
        .where('trangthai', isEqualTo: TrangThai)
        .where('trangthaixoa', isEqualTo: false)
        .get();
    ToDooo = snapshot.docs
        .map((json) => ToDoObject.fromJson(json.data() as Map<String, dynamic>))
        .toList();
    return ToDooo;
  }
}
