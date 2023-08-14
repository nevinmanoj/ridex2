import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../shared/Db.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  Future updateUserInfo(String label, String data) async {
    return await FirebaseFirestore.instance.collection(db).doc(uid).set({
      label: data,
    }, SetOptions(merge: true));
  }

  Future createGroupsMap() async {
    return await FirebaseFirestore.instance
        .collection(db)
        .doc(uid)
        .set({"groups": {}}, SetOptions(merge: true));
  }

  Future<String> createGroup({required title, required name}) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection(groupsDb).doc();

    await docRef.set({
      "title": title,
    }, SetOptions(merge: true));
    FirebaseFirestore.instance
        .collection('$groupsDb/${docRef.id}/members')
        .doc(uid)
        .set({
      'isAdmin': true,
      "longitude": "null",
      "latitude": "null",
      "heading": "null",
      "name": name,
      "locEnabled": false
    });
    await FirebaseFirestore.instance
        .collection(db)
        .doc(uid)
        .update({"groups.${docRef.id}": title});

    return docRef.id;
  }

  Future addToGroup({required String id, required String name}) async {
    DocumentSnapshot docSnapshot =
        await FirebaseFirestore.instance.collection(groupsDb).doc(id).get();
    if (!docSnapshot.exists) {
      print("sdsdfsdfsdfsdf");
      return null;
    }

    DocumentReference docRef =
        FirebaseFirestore.instance.collection(groupsDb).doc(id);
    var grpData = await docRef.get();

    if (grpData.data() == null) {
      return null;
    } else {
      await FirebaseFirestore.instance
          .collection('$groupsDb/${docRef.id}/members')
          .doc(uid)
          .set({
        'isAdmin': false,
        "longitude": "null",
        "latitude": "null",
        "heading": "null",
        "name": name,
        "locEnabled": false
      });
      await FirebaseFirestore.instance
          .collection(db)
          .doc(uid)
          .update({"groups.${docRef.id}": grpData['title']});
      return grpData['title'];
    }
  }

  Future changeLocationStatus({required bool enabled, required groupId}) async {
    await FirebaseFirestore.instance
        .collection("$groupsDb/$groupId/members")
        .doc(uid)
        .set({"locEnabled": enabled}, SetOptions(merge: true));
  }

  Future uploadLocation(
      {required String longitude,
      required String latitude,
      required String heading,
      required groupId}) async {
    await FirebaseFirestore.instance
        .collection("$groupsDb/$groupId/members")
        .doc(uid)
        .set({
      "longitude": longitude,
      "latitude": latitude,
      "heading": heading,
    }, SetOptions(merge: true));
  }
}
