import 'package:flutter/material.dart';
import 'package:stockup/screens/add.dart';
import 'package:stockup/screens/custemwidgets.dart';
import 'package:stockup/screens/dashboard.dart';
import 'package:stockup/screens/home.dart';
import 'package:stockup/screens/items.dart';
import 'package:stockup/screens/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      resizeToAvoidBottomInset: false,
      body: screens[_index],
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        height: 65,
        shape: const CircularNotchedRectangle(),
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
            const SizedBox(width: 40),
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Add()));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
