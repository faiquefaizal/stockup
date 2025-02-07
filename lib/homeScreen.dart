import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockup/screens/add.dart';
import 'package:stockup/screens/custemwidgets.dart';
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
  final screens = [
    const Home(),
    const Dashboard(),
    const Items(),
    const Profile()
  ];

  void _onItemSelected(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        height: 65,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BuildNavItem(
              icon: Icons.home,
              label: "Home",
              index: 0,
              currentIndex: _index,
              onTap: _onItemSelected,
            ),
            BuildNavItem(
              icon: Icons.dashboard_outlined,
              label: "Dashboard",
              index: 1,
              currentIndex: _index,
              onTap: _onItemSelected,
            ),
            SizedBox(width: 40),
            BuildNavItem(
              icon: Icons.inventory,
              label: "Items",
              index: 2,
              currentIndex: _index,
              onTap: _onItemSelected,
            ),
            BuildNavItem(
              icon: Icons.person,
              label: "Profile",
              index: 3,
              currentIndex: _index,
              onTap: _onItemSelected,
            ),
          ],
        ),
      )
      // BottomNavigationBar(
      //     backgroundColor: Colors.black,
      //     selectedItemColor: Colors.white,
      //     unselectedItemColor: Colors.grey,
      //     onTap: (index) => setState(() {
      //           _index = index;
      //         }),
      //     currentIndex: _index,
      //     items: const [
      //       BottomNavigationBarItem(
      //         // backgroundColor: Colors.black,
      //         icon: Icon(Icons.home),
      //         label: "Home",
      //       ),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.dashboard_outlined), label: "Dashboard"),
      //       // BottomNavigationBarItem(icon: Icon(Icons.add), label: "add"),
      //       BottomNavigationBarItem(
      //           icon: Icon(FontAwesomeIcons.box), label: "items"),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.shopify_rounded), label: "profile"),
      //     ]),
      ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Add()));
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
