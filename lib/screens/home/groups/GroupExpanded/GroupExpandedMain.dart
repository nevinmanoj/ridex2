// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ridex/screens/home/groups/GroupExpanded/Map/MapPageMain.dart';
import 'package:ridex/screens/home/groups/GroupExpanded/Members/membersPageMain.dart';
import 'package:ridex/shared/constants.dart';

import 'locationButton.dart';

class GroupExpandedMain extends StatefulWidget {
  String id;
  String name;
  GroupExpandedMain({required this.id, required this.name});

  @override
  State<GroupExpandedMain> createState() => _GroupExpandedMainState();
}

class _GroupExpandedMainState extends State<GroupExpandedMain> {
  bool loc = false;
  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop(); // Navigate back
              },
            ),
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
              MapPageMain()
            ],
          ),
        ));
  }
}
