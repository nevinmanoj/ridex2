// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'joinToGroup.dart';
import 'createGroup.dart';

class AddGroupMain extends StatefulWidget {
  const AddGroupMain({super.key});

  @override
  State<AddGroupMain> createState() => _AddGroupMainState();
}

class _AddGroupMainState extends State<AddGroupMain> {
  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return AlertDialog(
      content: SizedBox(
        width: wt * 0.9,
        height: ht * 0.5,
        child: Column(
          children: [
            Spacer(),
            Text("Create a New Group"),
            CreateGroup(),
            Spacer(),
            Text("OR"),
            Spacer(),
            Text("Join a Group"),
            AddToGroup(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
