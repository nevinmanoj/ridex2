import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridex/shared/constants.dart';

import '../../../services/providers.dart';
import 'GroupExpanded/GroupExpandedMain.dart';
import 'addGroup/addGroupMain.dart';

class GroupsMain extends StatefulWidget {
  @override
  State<GroupsMain> createState() => _GroupsMainState();
}

class _GroupsMainState extends State<GroupsMain> {
  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    final user = Provider.of<User?>(context);
    var userInfo = Provider.of<UserInfoProvider>(context);
    List grpKeys = List.from(userInfo.groups.keys);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryAppColor,
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return AddGroupMain();
                });
          },
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: grpKeys.length,
            itemBuilder: (_, i) {
              return Padding(
                padding:
                    EdgeInsets.fromLTRB(wt * 0.03, ht * 0.01, wt * 0.03, 0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(wt * 0.05, 0, 0, 0),
                  width: wt,
                  height: ht * 0.08,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GroupExpandedMain(
                                  id: grpKeys[i],
                                  name: userInfo.groups[grpKeys[i]],
                                ))),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userInfo.groups[grpKeys[i]],
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
