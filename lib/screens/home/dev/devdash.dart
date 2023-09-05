// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/Db.dart';
import '../../../shared/constants.dart';
import 'test.dart';

class DevDash extends StatefulWidget {
  const DevDash({super.key});

  @override
  State<DevDash> createState() => _DevDashState();
}

class _DevDashState extends State<DevDash> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        centerTitle: true,
        title: Text("Dev Dashboard"),
      ),
      body: Center(
          child: Column(children: [
        ElevatedButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Test())),
            child: Text("test")),
        ElevatedButton(
            onPressed: () async {
              // for (int i = 0; i < 5; i++) {
              //   await FirebaseFirestore.instance
              //       .collection('$groupsDb/test/members')
              //       .doc("$i")
              //       .set({
              //     'isAdmin': false,
              //     "longitude": "null",
              //     "latitude": "null",
              //     "heading": "null",
              //     "name": "dev $i",
              //     "locEnabled": false
              //   });
              // }
            },
            child: Icon(Icons.upload))
      ])),
    );
  }
}
