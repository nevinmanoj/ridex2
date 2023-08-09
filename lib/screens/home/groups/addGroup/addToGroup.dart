// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridex/screens/home/groups/GroupExpanded/GroupExpandedMain.dart';
import 'package:ridex/services/database.dart';
import 'package:ridex/services/providers.dart';

import '../../../../shared/constants.dart';

class AddToGroup extends StatefulWidget {
  @override
  State<AddToGroup> createState() => _AddToGroupState();
}

class _AddToGroupState extends State<AddToGroup> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    var userInfo = Provider.of<UserInfoProvider>(context);
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Column(children: [
        Container(
          height: 50,
          width: 300,
          decoration: addInputDecoration,
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: TextFormField(
            controller: nameController,
            validator: (value) =>
                value!.isEmpty ? 'Code cannot be empty' : null,
            // initialValue: remarks,
            cursorColor: primaryAppColor,
            cursorWidth: 1,
            onChanged: (value) {},
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
              hintText: 'Group Code',
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                String? gname = await DatabaseService(uid: user!.uid)
                    .addToGroup(
                        id: nameController.text, name: userInfo.userName);
                // print(gname);
                if (gname == null) {
                  setState(() {
                    Future.delayed(Duration(seconds: 2), () {
                      setState(() {
                        error = '';
                      });
                    });
                    error = "invalid group code";
                  });
                } else {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GroupExpandedMain(
                                id: nameController.text,
                                name: gname,
                              )));
                }
              }
            },
            child: Text("Join")),
        Text(
          error,
          style: TextStyle(color: Colors.red),
        )
      ]),
    );
  }
}
