// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ridex/services/providers/locationProvider.dart';

import '../../../../shared/constants.dart';

class LocationButton extends StatefulWidget {
  final String groupId;
  LocationButton({required this.groupId});

  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    var location = Provider.of<LocationProvider>(context);

    return Row(
      children: [
        const Icon(Icons.location_on),
        Switch(
            inactiveTrackColor: Colors.grey,
            activeTrackColor: Color.fromRGBO(158, 91, 4, 1),
            activeColor: secondaryAppColor,
            value: location.locEnabled,
            onChanged: (v) async {
              location.changeLocEnabled(v);
              // location.locEnabled = v;

              if (location.locEnabled) {
                await location.enableLocation(
                    context: context, uid: user!.uid, groupId: widget.groupId);
                // await enableLocation(user!.uid);
              } else {
                await location.disableLocation(
                    uid: user!.uid, context: context, groupId: widget.groupId);
              }
              // location.locEnabled = loc;
            }),
        // ElevatedButton(
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => ParentWidget()));
        //     },
        //     child: Text("data"))
      ],
    );
  }
}
