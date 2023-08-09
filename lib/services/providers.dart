import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../shared/Db.dart';

class UserInfoProvider with ChangeNotifier {
  User? user;
  UserInfoProvider({required this.user}) {
    if (user != null) _init();
  }
  String _userName = "";
  String _phno = "";
  Map groups = {};

  String get userName => _userName;
  String get phone => _phno;

  void setUser(User? usr) {
    print("switching user to ${usr!.email} from ${user!.email}");
    user = usr;
    _init();
  }

  Future<void> _init() async {
    if (user != null) {
      final docRef = FirebaseFirestore.instance.collection(db).doc(user!.uid);

      docRef.snapshots().listen((snapshot) {
        if (snapshot.exists) {
          _userName = snapshot.data()!['Name'];
          _phno = snapshot.data()!['PhoneNumber'];
          groups = snapshot.data()!['groups'];
        } else {
          _userName = "";
          _phno = "";
          groups = {};
        }
        notifyListeners();
      });
    }
  }
}
