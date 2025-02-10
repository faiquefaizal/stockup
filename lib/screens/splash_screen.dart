import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stockup/db_funtions.dart/brand_funtions.dart';
import 'package:stockup/db_funtions.dart/business_profile.dart';
import 'package:stockup/db_funtions.dart/notification_funtion.dart';
import 'package:stockup/db_funtions.dart/product_funtion.dart';
import 'package:stockup/db_funtions.dart/sale_funtion.dart';
import 'package:stockup/home_screen.dart';
import 'package:stockup/models/brands/brand_model.dart';
import 'package:stockup/models/businessprofile/business_profile.dart';
import 'package:stockup/models/notification/notification_model.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:stockup/models/sales/sale_/sales_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gotomainscreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Image.asset("assets/Stock UP.png"),
        ));
  }

  Future<void> gotomainscreen() async {
    await Future.delayed(const Duration(seconds: 3));
    await intializeBoxes();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}

Future<void> intializeBoxes() async {
  await Hive.openBox<BusinessProfile>(BUSINESS_PROFILE_BOX);
  await Hive.openBox<BrandModel>(BRAND_BOX);
  await Hive.openBox<NotificationModel>(NOTIFICATION_BOX);
  await Hive.openBox<ProductModel>(PRODUCT_BOX);
  await Hive.openBox<SalesModel>(SALE_BOX);
  getBrand();
  getAllSales();
  getProducts();
  getnotification();
  getProfileData();
}
