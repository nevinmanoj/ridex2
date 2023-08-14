import 'package:flutter/material.dart';

import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:googleapis/container/v1.dart';
import 'package:ridex/services/database.dart';
import 'package:ridex/services/toast.dart';

class LocationProvider with ChangeNotifier {
  bool locEnabled = false;
  StreamSubscription? positionStreamSubscription;
  void changeLocEnabled(value) {
    locEnabled = value;
    notifyListeners();
  }

  Future enableLocation(
      {required String uid,
      required BuildContext context,
      required String groupId}) async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        locEnabled = false;

        showToast(context: context, msg: 'Location services are disabled.');

        notifyListeners();
        return;
      }

      // Check if the app has permission to access location
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showToast(context: context, msg: 'Location permissions are denied.');

          locEnabled = false;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        showToast(
            context: context,
            msg:
                'Location permissions are permanently denied, cannot request permissions.');

        locEnabled = false;
        notifyListeners();
        return;
      }

      // Geolocator.getServiceStatusStream().listen((event) {
      //   print(event);
      // });
      DatabaseService(uid: uid)
          .changeLocationStatus(enabled: true, groupId: groupId);

      positionStreamSubscription = Geolocator.getPositionStream(
              locationSettings:
                  LocationSettings(accuracy: LocationAccuracy.high))
          .listen((pos) {
        DatabaseService(uid: uid).uploadLocation(
            groupId: groupId,
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

  Future disableLocation(
      {required String uid,
      required BuildContext context,
      required String groupId}) async {
    try {
      positionStreamSubscription!.cancel();
      DatabaseService(uid: uid)
          .changeLocationStatus(enabled: false, groupId: groupId);
      DatabaseService(uid: uid).uploadLocation(
          groupId: groupId,
          latitude: "null",
          longitude: "null",
          heading: "null");
    } catch (e) {
      print(e);
    }
  }
}
