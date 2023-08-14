import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class LocationMarkerOptions with ChangeNotifier {
  TurnOnHeadingUpdate headingOption = TurnOnHeadingUpdate.always;
  FollowOnLocationUpdate followOption = FollowOnLocationUpdate.always;
  LocationMarkerOptions(
      {required TurnOnHeadingUpdate hOption,
      required FollowOnLocationUpdate fOption}) {
    headingOption = hOption;
    followOption = fOption;
  }
  void changeOption() {
    if (headingOption == TurnOnHeadingUpdate.always) {
      headingOption = TurnOnHeadingUpdate.never;
      followOption = FollowOnLocationUpdate.never;
    } else {
      headingOption = TurnOnHeadingUpdate.always;
      followOption = FollowOnLocationUpdate.always;
    }
    notifyListeners();
  }
}
