import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SaleCompletd extends StatelessWidget {
  Function oncomplition;
  SaleCompletd({super.key, required this.oncomplition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Lottie.asset("assets/success_animation.json", repeat: false,
              onLoaded: (animation) {
        log("started");
        Future.delayed(animation.duration, () {
          log("Animation completed. Triggering oncomplition...");
          oncomplition();
        });
      })),
    );
  }
}
