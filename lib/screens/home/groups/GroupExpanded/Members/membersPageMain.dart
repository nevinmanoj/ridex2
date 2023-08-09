// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridex/shared/Db.dart';

import 'You.dart';

class MembersPageMain extends StatefulWidget {
  String id;
  MembersPageMain({required this.id});

  @override
  State<MembersPageMain> createState() => _MembersPageMainState();
}

class _MembersPageMainState extends State<MembersPageMain> {
  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    var user = Provider.of<User?>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("$groupsDb/${widget.id}/members")
            .snapshots(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var list = snap.data!.docs;
          list.sort((a, b) {
            if (a.id == user!.uid) {
              return -1; // 'a' comes before 'b'
            } else if (b.id == user.uid) {
              return 1; // 'b' comes before 'a'
            } else {
              return 0; // No change in order
            }
          });

          // List<Map<String, dynamic>> data = list
          //     .map((document) => document.data() as Map<String, dynamic>)
          //     .toList();
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, i) {
                if (i == 0) {
                  return YouInGroup(
                    data: list[i],
                  );
                }
                return Padding(
                  padding:
                      EdgeInsets.fromLTRB(wt * 0.03, ht * 0.01, wt * 0.03, 0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(wt * 0.05, 0, 0, 0),
                    width: wt,
                    height: ht * 0.08,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            list[i]['name'],
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Spacer(),
                        list[i]['isAdmin']
                            ? Padding(
                                padding: EdgeInsets.only(right: wt * 0.03),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "admin",
                                      style: TextStyle(color: Colors.green),
                                    )),
                              )
                            : Container(),
                        Padding(
                          padding: EdgeInsets.only(right: wt * 0.0),
                          child: list[i]['locEnabled']
                              ? Icon(Icons.location_on)
                              : Icon(Icons.location_off),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
