import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';

class ToDoObject {
  final String email;
  final int id;
  final String noidung;
  final int douutien;
  final String thoigianlam;
  final bool trangthai;
  final bool trangthaixoa;
  ToDoObject(this.email, this.id, this.noidung, this.douutien, this.thoigianlam,
      this.trangthai, this.trangthaixoa);
  ToDoObject.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        id = json['id'],
        noidung = json['noidung'],
        douutien = json['douutien'],
        thoigianlam = json['thoigianlam'],
        trangthai = json['trangthai'],
        trangthaixoa = json['trangthaixoa'];
  Map<String, Object> toJson() {
    return {
      'email': email,
      'id': id,
      'noidung': noidung,
      'douutien': douutien,
      'thoigianlam': thoigianlam,
      'trangthai': trangthai,
      'trangthaixoa': trangthaixoa
    };
  }
}

class ToDoID {
  final int id;
  ToDoID(this.id);
  ToDoID.fromJson(Map<String, dynamic> json) : id = json['id'];
  Map<String, Object> toJson() {
    return {'id': id};
  }
}
