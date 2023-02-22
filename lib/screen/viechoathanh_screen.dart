import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../object/todolist_object.dart';
import '../provider/todolist_provider.dart';

class ViecHoanThanh extends StatefulWidget {
  String? email;
  ViecHoanThanh({this.email});

  @override
  State<ViecHoanThanh> createState() => _ViecHoanThanhState(email: email);
}

class _ViecHoanThanhState extends State<ViecHoanThanh> {
  String? email;
  _ViecHoanThanhState({this.email});
  CollectionReference TDL = FirebaseFirestore.instance.collection('todolist');
  var docID;
  var querySnapshots;
  bool trangthai = true;

  Future<void> deleteToDo(var docID, bool delete) {
    return TDL.doc(docID).update({'trangthaixoa': delete});
  }

  List<Color> lstColor = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ToDoObject>>(
      future: ToDoProvider.getAllCompleted(email.toString(), trangthai),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ToDoObject> toDoOJ = snapshot.data!;
          toDoOJ.sort(((a, b) => a.douutien.compareTo(b.douutien)));
          return Scaffold(
              body: Stack(
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Lottie.asset('assets/completed.json', fit: BoxFit.cover),
              ),
              ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 100),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Số việc đã hoàn thành',
                                style: GoogleFonts.beVietnamPro(fontSize: 20),
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
                          )),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: toDoOJ.length,
                          itemBuilder: (context, index) {
                            return Padding(
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
                                        setState(() {});
                                      }),
                                      icon: Icons.delete,
                                      backgroundColor: Colors.deepOrangeAccent,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color:
                                          lstColor[toDoOJ[index].douutien - 1],
                                      borderRadius: BorderRadius.circular(8.0)),
                                  height: 48,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        toDoOJ[index].noidung.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ],
              )
            ],
          ));
        }
        return Center(
            child: SpinKitWave(
          size: 40,
          color: Colors.deepPurple,
        ));
      },
    );
  }
}
