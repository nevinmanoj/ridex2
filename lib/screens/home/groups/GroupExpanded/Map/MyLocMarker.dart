import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:provider/provider.dart';

import '../../../../../services/providers/MyLocMapOptionProvider.dart';

class MyLocMarker extends StatefulWidget {
  @override
  State<MyLocMarker> createState() => _MyLocMarkerState();
}

class _MyLocMarkerState extends State<MyLocMarker> {
  @override
  Widget build(BuildContext context) {
    var markerOption = Provider.of<LocationMarkerOptions>(context);
    return CurrentLocationLayer(
      followOnLocationUpdate: markerOption.followOption,
      turnOnHeadingUpdate: markerOption.headingOption,
      style: const LocationMarkerStyle(
        marker: DefaultLocationMarker(
          child: Icon(
            Icons.navigation,
            color: Colors.white,
          ),
        ),
        // markerSize: const Size(20, 20),
        markerDirection: MarkerDirection.heading,
      ),
    );
  }
}
