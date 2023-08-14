import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../services/providers/locationProvider.dart';

class GrpExpBackBtn extends StatefulWidget {
  String id;
  GrpExpBackBtn({required this.id});

  @override
  State<GrpExpBackBtn> createState() => _GrpExpBackBtnState();
}

class _GrpExpBackBtnState extends State<GrpExpBackBtn> {
  @override
  Widget build(BuildContext context) {
    var location = Provider.of<LocationProvider>(context);
    var user = Provider.of<User?>(context);
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        location.disableLocation(
            uid: user!.uid, context: context, groupId: widget.id);
        Navigator.of(context).pop(); // Navigate back
      },
    );
  }
}
