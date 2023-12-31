import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:ridex/screens/home/dev/devdash.dart';

import '../../../services/auth.dart';
import '../../../services/providers/UserInfoProvider.dart';
import 'Profile/Profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    var userInfo = Provider.of<UserInfoProvider>(context);
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profile(
                          name: userInfo.userName,
                          phoneNumber: userInfo.phone,
                        )));
          },
          child: Container(
            color: Colors.grey[300],
            width: wt,
            height: ht * 0.06,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(wt * 0.03, 0, 0, 0),
                  child: Text(
                    "Profile",
                    style: TextStyle(fontSize: 18),
                  ),
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(wt * 0.01, ht * 0.005, wt * 0.01, 0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DevDash()));
            },
            child: Container(
              // decoration: ,
              color: Colors.grey[300],
              width: wt,
              height: ht * 0.06,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(wt * 0.03, 0, 0, 0),
                    child: Text(
                      "Dev",
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(wt * 0.01, ht * 0.005, wt * 0.01, 0),
          child: InkWell(
            onTap: () async {
              var email = user!.email;
              if (email != null) AuthSerivice().Passwordreset(email, context);
            },
            child: Container(
              // decoration: ,
              color: Colors.grey[300],
              width: wt,
              height: ht * 0.06,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(wt * 0.03, 0, 0, 0),
                    child: Text(
                      "Send reset password link ",
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(wt * 0.01, ht * 0.005, wt * 0.01, 0),
          child: InkWell(
            onTap: () async => AuthSerivice().signOut(),
            child: Container(
              // decoration: ,
              color: Colors.grey[300],
              width: wt,
              height: ht * 0.06,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(wt * 0.03, 0, 0, 0),
                    child: Text(
                      "Log Out",
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
