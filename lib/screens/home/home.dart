// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/constants.dart';
import 'groups/groupsMain.dart';
import 'settings/settings.dart';

// var x = Icons.calendar_month;
List<String> navOptions = ["Groups", "Listx", "Details", "Settings"];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    GroupsMain(),
    SettingsScreen(),
    SettingsScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,

      body: SafeArea(
        child: Container(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_2),
            label: navOptions[0],
            backgroundColor: primaryAppColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.five_g_outlined),
            label: navOptions[1],
            backgroundColor: primaryAppColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: navOptions[2],
            backgroundColor: primaryAppColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: navOptions[3],
            backgroundColor: primaryAppColor,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: secondaryAppColor,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
