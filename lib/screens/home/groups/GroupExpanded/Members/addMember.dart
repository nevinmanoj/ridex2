// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ridex/services/toast.dart';

class AddMembers extends StatefulWidget {
  String id;
  AddMembers({required this.id});

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Center(child: Text("Scan QR to add Group")),
      content: SizedBox(
        width: wt * 0.9,
        height: ht * 0.3,
        child: Column(
          children: [
            QrImageView(
              data: widget.id,
              // version: QrVersions.auto,
              size: 200.0,
            ),
            InkWell(
              onLongPress: () async {
                await Clipboard.setData(ClipboardData(text: widget.id));
                showToast(context: context, msg: "Code copied to Clipboard");
              },
              child: Text(
                widget.id,
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
