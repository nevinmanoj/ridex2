import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:provider/provider.dart';

import '../../../../../services/providers/MyLocMapOptionProvider.dart';
import '../../../../../shared/constants.dart';

class MapControls extends StatefulWidget {
  @override
  State<MapControls> createState() => _MapControlsState();
}

class _MapControlsState extends State<MapControls> {
  @override
  Widget build(BuildContext context) {
    var markerOption = Provider.of<LocationMarkerOptions>(context);
    return Positioned(
      bottom: 15,
      right: 15,
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryAppColor, shape: CircleBorder()),
                onPressed: markerOption.changeOption,
                child: Icon(
                    markerOption.headingOption == TurnOnHeadingUpdate.never
                        ? Icons.my_location
                        : Icons.explore)),
            // Icons.my_location
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //   height: 60,
          //   width: 60,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //   ),
          //   child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //           backgroundColor: primaryAppColor, shape: CircleBorder()),
          //       onPressed: () {},
          //       child: const Icon(Icons.document_scanner_outlined)),
          // ),
        ],
      ),
    );
  }
}
