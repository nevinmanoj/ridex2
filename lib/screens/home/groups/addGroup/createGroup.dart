// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridex/screens/home/groups/GroupExpanded/GroupExpandedMain.dart';
import 'package:ridex/services/database.dart';
import 'package:ridex/services/providers/UserInfoProvider.dart';

import '../../../../shared/constants.dart';

class CreateGroup extends StatefulWidget {
  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final _formKey = GlobalKey<FormState>();
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
                value!.isEmpty ? 'Title cannot be empty' : null,
            // initialValue: remarks,
            cursorColor: primaryAppColor,
            cursorWidth: 1,
            onChanged: (value) {},
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
              hintText: 'Group Title',
            ),
          ),
        ),
        ElevatedButton(
            style: buttonDecoration,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                String groupId = await DatabaseService(uid: user!.uid)
                    .createGroup(
                        title: nameController.text, name: userInfo.userName);
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GroupExpandedMain(
                              id: groupId,
                              name: nameController.text,
                            )));
              }
            },
            child: Text("Create"))
      ]),
    );
  }
}
