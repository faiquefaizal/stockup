import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset("assets/Stock UP.png"),
    ));
  }

  Future<void> gotomainscreen() async {
    await Future.delayed(Duration(seconds: 5));

    // NAv
  }
}
