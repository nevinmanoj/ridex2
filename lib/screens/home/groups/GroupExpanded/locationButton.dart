// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:ridex/services/database.dart';
import 'package:ridex/services/toast.dart';

import '../../../../shared/constants.dart';

class LocationButton extends StatefulWidget {
  final String groupId;
  LocationButton({required this.groupId});

  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  bool loc = false;
  StreamSubscription? positionStreamSubscription;

  Future enableLocation(uid) async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          loc = false;
        });
        showToast(context: context, msg: 'Location services are disabled.');
        print(loc);
        return;
      }

      // Check if the app has permission to access location
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showToast(context: context, msg: 'Location permissions are denied.');
          setState(() {
            loc = false;
          });

          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        showToast(
            context: context,
            msg:
                'Location permissions are permanently denied, cannot request permissions.');
        setState(() {
          loc = false;
        });

        return;
      }

      // Geolocator.getServiceStatusStream().listen((event) {
      //   print(event);
      // });
      DatabaseService(uid: uid)
          .changeLocationStatus(enabled: true, groupId: widget.groupId);
      positionStreamSubscription = Geolocator.getPositionStream(
              locationSettings:
                  LocationSettings(accuracy: LocationAccuracy.high))
          .listen((pos) {
        // setState(() {
        //   _locationMessage =
        DatabaseService(uid: uid).uploadLocation(
            groupId: widget.groupId,
            latitude: pos.latitude.toString(),
            longitude: pos.longitude.toString(),
            heading: pos.heading.toString());
        print(
            'Latitude: ${pos.latitude}, Longitude: ${pos.longitude},${pos.heading}');
        // });
      });
    } catch (e) {
      print(e);
    }
  }

  Future disableLocation(uid) async {
    try {
      positionStreamSubscription!.cancel();
      DatabaseService(uid: uid)
          .changeLocationStatus(enabled: false, groupId: widget.groupId);
      DatabaseService(uid: uid).uploadLocation(
          groupId: widget.groupId,
          latitude: "null",
          longitude: "null",
          heading: "null");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    return Row(
      children: [
        const Icon(Icons.location_on),
        Switch(
            inactiveTrackColor: Colors.grey,
            activeTrackColor: Color.fromRGBO(158, 91, 4, 1),
            activeColor: secondaryAppColor,
            value: loc,
            onChanged: (v) async {
              setState(() {
                loc = v;
              });
              if (loc) {
                await enableLocation(user!.uid);
              } else {
                disableLocation(user!.uid);
              }
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
