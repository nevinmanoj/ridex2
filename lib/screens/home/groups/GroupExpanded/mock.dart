// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import '../../../../shared/Db.dart';

// class MockData extends StatefulWidget {
//   const MockData({super.key});

//   @override
//   State<MockData> createState() => _MockDataState();
// }

// class _MockDataState extends State<MockData> {
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//         onPressed: () async {
//           for (int i = 0; i < 5; i++) {
//             FirebaseFirestore.instance
//                 .collection("$groupsDb/test/members")
//                 .doc("$i")
//                 .set({"locEnabled": true}, SetOptions(merge: true));
//           }
//           for (int j = 0; j < 10; j++) {
//             for (int i = 0; i < 5; i++) {
//               await Future.delayed(Duration(microseconds: 300), () async {
//                 await FirebaseFirestore.instance
//                     .collection("$groupsDb/test/members")
//                     .doc("$i")
//                     .set({
//                   "longitude": "${76.28 + ((i + 1) * j / 1000)}",
//                   "latitude": "${10 + ((i + 1) * j / 2000)}",
//                   "heading": "${0}",
//                 }, SetOptions(merge: true));
//               });
//             }
//           }
//         },
//         icon: Icon(Icons.compass_calibration));
//   }
// }
