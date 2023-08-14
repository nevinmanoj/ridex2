// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridex/screens/home/groups/GroupExpanded/Map/MapPageMain.dart';
import 'package:ridex/screens/home/groups/GroupExpanded/Members/membersPageMain.dart';
import 'package:ridex/services/providers/locationProvider.dart';
import 'package:ridex/shared/constants.dart';

import 'GrpExpBackButton.dart';
import 'locationButton.dart';

class GroupExpandedMain extends StatefulWidget {
  String id;
  String name;
  GroupExpandedMain({required this.id, required this.name});

  @override
  State<GroupExpandedMain> createState() => _GroupExpandedMainState();
}

class _GroupExpandedMainState extends State<GroupExpandedMain> {
  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    var user = Provider.of<User?>(context);

    return DefaultTabController(
        length: 2,
        child: ChangeNotifierProvider(
          create: (_) => LocationProvider(),
          builder: (context, child) {
            // var location = Provider.of<LocationProvider>(context);
            return Scaffold(
              appBar: AppBar(
                leading: GrpExpBackBtn(
                  id: widget.id,
                ),
                // leading: IconButton(
                //   icon: Icon(Icons.arrow_back),
                //   onPressed: () {
                //     // location.disableLocation(
                //     //     uid: user!.uid, context: context, groupId: widget.id);
                //     Navigator.of(context).pop(); // Navigate back
                //   },
                // ),
                actions: [
                  LocationButton(
                    groupId: widget.id,
                  )
                ],
                title: Text(widget.name),
                centerTitle: true,
                backgroundColor: primaryAppColor,
                bottom: TabBar(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3,
                  indicatorColor: secondaryAppColor,
                  labelColor: secondaryAppColor,
                  unselectedLabelColor: Color(0xff778585),
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Members",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            width: wt * 0.02,
                          ),
                          Icon(Icons.people)
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Map",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            width: wt * 0.02,
                          ),
                          Icon(Icons.map_outlined)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  MembersPageMain(
                    id: widget.id,
                  ),
                  MapPageMain(
                    id: widget.id,
                  )
                ],
              ),
            );
          },
        ));
  }
}
