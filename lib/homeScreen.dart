import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockup/screens/add.dart';
import 'package:stockup/screens/dashboard.dart';
import 'package:stockup/screens/home.dart';
import 'package:stockup/screens/items.dart';
import 'package:stockup/screens/profile.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _index = 0;
  final screens = [Home(), Dashboard(), Add(), Items(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: (index) => setState(() {
                _index = index;
              }),
          currentIndex: _index,
          items: [
            BottomNavigationBarItem(
              // backgroundColor: Colors.black,
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined), label: "Dashboard"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "add"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.box), label: "items"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopify_rounded), label: "profile"),
          ]),
    );
  }
}
