import 'package:flutter/material.dart';
import 'package:stockup/screens/aboutus_page.dart';
import 'package:stockup/screens/brand.dart';
import 'package:stockup/screens/busines_page.dart';
import 'package:stockup/screens/custemwidgets.dart';
import 'package:stockup/screens/transactions_page.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Account",
              style: TextStyle(
                fontSize: 40,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            custemcard("Business Profile", () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Businespage()));
            }),
            custemcard("Brands", () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Brands(),
              ));
            }),
            custemcard("Transactions", () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TransactionsPage()));
            }),
            custemcard("About", () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AboutusPage()));
            }),
          ],
        ),
      )),
    );
  }
}
