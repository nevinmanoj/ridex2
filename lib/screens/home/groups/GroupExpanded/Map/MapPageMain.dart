import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:ridex/screens/home/groups/GroupExpanded/Map/MapControls.dart';
import 'package:ridex/shared/Db.dart';

import '../../../../../services/providers/MyLocMapOptionProvider.dart';
import 'MyLocMarker.dart';

class MapPageMain extends StatefulWidget {
  String id;
  MapPageMain({required this.id});
  @override
  State<MapPageMain> createState() => _MapPageMainState();
}

class _MapPageMainState extends State<MapPageMain> {
  double zoom = 15;
  LocationMarkerHeading heading =
      LocationMarkerHeading(heading: 0, accuracy: 0);

  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;

    var user = Provider.of<User?>(context);
    // var location = Provider.of<LocationProvider>(context);
    bool locEnabled = false;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("$groupsDb/${widget.id}/members")
            .snapshots(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var list = snap.data!.docs;
          // print(location.locEnabled);
          list.sort((a, b) {
            if (a.id == user!.uid) {
              return -1; // 'a' comes before 'b'
            } else if (b.id == user.uid) {
              return 1; // 'b' comes before 'a'
            } else {
              return 0; // No change in order
            }
          });

          List<Widget> markers = [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
          ];
          for (var doc in list) {
            if (doc.data()['locEnabled']) {
              String latitude = doc.data()['latitude'];
              String longitude = doc.data()['longitude'];
              String heading = doc.data()['heading'];
              if (latitude != "null" &&
                  longitude != "null" &&
                  heading != "null") {
                if (doc.id == user!.uid) {
                  locEnabled = true;
                  // markers.add(CurrentLocationLayer(
                  //   followOnLocationUpdate: FollowOnLocationUpdate.always,
                  //   turnOnHeadingUpdate: headingOption,
                  //   style: const LocationMarkerStyle(
                  //     marker: DefaultLocationMarker(
                  //       child: Icon(
                  //         Icons.navigation,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     // markerSize: const Size(20, 20),
                  //     markerDirection: MarkerDirection.heading,
                  //   ),
                  // ));
                } else {
                  markers.add(
                    createMarker(
                        position: LocationMarkerPosition(
                          latitude: double.parse(latitude),
                          longitude: double.parse(longitude),
                          accuracy: 0,
                        ),
                        heading: LocationMarkerHeading(
                            heading: double.parse(heading), accuracy: 0),
                        color: Colors.cyan),
                  );
                }
              }
            }
          }

          return ChangeNotifierProvider<LocationMarkerOptions>(
              create: (context) => LocationMarkerOptions(
                  fOption: FollowOnLocationUpdate.always,
                  hOption: TurnOnHeadingUpdate.always),
              builder: (context, child) {
                return FlutterMap(
                  options: MapOptions(
                    onPositionChanged: (position, hasGesture) => {},
                    center: LatLng(10.000081581192912, 76.29059452482811),
                    zoom: zoom,
                  ),
                  nonRotatedChildren: [
                    MapControls(),
                  ],
                  children: [
                    ...markers,
                    locEnabled ? MyLocMarker() : Container()
                  ],
                );
              });
        });
  }
}

Widget createMarker(
    {required LocationMarkerPosition position,
    required LocationMarkerHeading? heading,
    required Color color}) {
  return AnimatedLocationMarkerLayer(
    position: position,
    heading: heading,
    style: LocationMarkerStyle(
      // marker: Icon(
      //   Icons.navigation,
      //   color: Colors.green,
      // ),
      marker: DefaultLocationMarker(
        color: color,
        child: Container(),
      ),
      // markerSize: const Size(20, 20),
      markerDirection: MarkerDirection.heading,
    ),
  );
}
