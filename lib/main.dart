import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stockup/db_funtions.dart/sale_funtion.dart';
import 'package:stockup/models/brands/brand_model.dart';
import 'package:stockup/models/businessprofile/business_profile.dart';
import 'package:stockup/models/notification/notification_model.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:stockup/models/sales/sale_/sales_model.dart';
import 'package:stockup/models/sales/sale_item/product_sale_model.dart';
import 'package:stockup/screens/splash_screen.dart';
// import 'package:stockup/models/sales/sale/sales_model.dart';
import 'notifications/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  periodicCheck();
  await notificationIntialize();
  Hive.registerAdapter(NotificationModelAdapter());
  Hive.registerAdapter(BusinessProfileAdapter());
  Hive.registerAdapter(BrandModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());

  Hive.registerAdapter(ProductSaleModelAdapter());
  Hive.registerAdapter(SalesModelAdapter());
  // await Hive.openBox<ProductSaleModel>(SALE_PRODUCT);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black, foregroundColor: Colors.white),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
            ),
            navigationBarTheme:
                const NavigationBarThemeData(backgroundColor: Colors.black),
            textTheme: const TextTheme(
                bodyMedium: TextStyle(color: Colors.white, fontSize: 30)),
            cardTheme: const CardTheme(color: Colors.black)),
        home: const SplashScreen());
  }
}
