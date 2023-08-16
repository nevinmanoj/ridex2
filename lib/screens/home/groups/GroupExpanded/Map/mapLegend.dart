import 'package:flutter/material.dart';
import 'package:googleapis/bigquerydatatransfer/v1.dart';
import 'package:googleapis/chat/v1.dart';

class MapLegend extends StatefulWidget {
  List<String> names;
  List colors;
  MapLegend({required this.names, required this.colors});

  @override
  State<MapLegend> createState() => _MapLegendState();
}

class _MapLegendState extends State<MapLegend> {
  double h = 40;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black.withOpacity(01),
        ),
      ),
      // duration: Duration(milliseconds: 500),
      height: h,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                if (isExpanded) {
                  h = 40;
                } else {
                  h = 200;
                }
                isExpanded = !isExpanded;
              });
            },
            child: Center(
                child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 3),
                Text(
                  "Active Members",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                Spacer(flex: 2),
              ],
            )),
          ),
          isExpanded
              ? Container(
                  // duration: Duration(milliseconds: 10),
                  height: h - 40,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < widget.names.length; i++)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                            child: Row(
                              children: [
                                Text(widget.names[i]),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (isExpanded) {
                                        h = 50;
                                      } else {
                                        h = 200;
                                      }
                                      isExpanded = !isExpanded;
                                    });
                                  },
                                  child: Icon(
                                    Icons.circle,
                                    color: widget.colors[i + 1],
                                  ),
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                )
              : Container(),
          Spacer(),
          // Center(
          //   child: InkWell(
          //       onTap: () {
          //         setState(() {
          //           if (isExpanded) {
          //             h = 50;
          //           } else {
          //             h = 200;
          //           }
          //           isExpanded = !isExpanded;
          //         });
          //       },
          //       child: Text(isExpanded ? "Show Less" : "Show More")),
          // ),
        ],
      ),
    );
  }
}
