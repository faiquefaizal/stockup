import 'package:flutter/material.dart';
import 'package:stockup/screens/aboutus_page.dart';
import 'package:stockup/screens/brand.dart';
import 'package:stockup/screens/businesPage.dart';
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
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Account",
            style: TextStyle(fontSize: 70, color: Colors.black),
          ),
          custemcard("Business Profile", () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Businespage()));
          }),
          custemcard("Brands", () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Brands(),
            ));
          }),
          custemcard("Transactions", () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const TransactionsPage()));
          }),
          custemcard("About", () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const AboutusPage()));
          }),
        ],
      )),
    );
  }
}
