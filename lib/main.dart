import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stockup/db_funtions.dart/product_sale_funtion.dart';
import 'package:stockup/db_funtions.dart/sale_funtion.dart';
import 'package:stockup/homeScreen.dart';
import 'package:stockup/models/brands/brand_model.dart';
import 'package:stockup/models/businessprofile/business_profile.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:stockup/models/sales/sale_/sales_model.dart';
import 'package:stockup/models/sales/sale_item/product_sale_model.dart';
// import 'package:stockup/models/sales/sale/sales_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BusinessProfileAdapter());
  Hive.registerAdapter(BrandModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(SalesModelAdapter());
  Hive.registerAdapter(ProductSaleModelAdapter());

  // await Hive.openBox<ProductSaleModel>(SALE_PRODUCT);
  await Hive.openBox<SalesModel>(SALE_BOX);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.black, foregroundColor: Colors.white),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
          ),
          navigationBarTheme:
              NavigationBarThemeData(backgroundColor: Colors.black),
          textTheme: TextTheme(
              bodyMedium: TextStyle(color: Colors.white, fontSize: 30)),
          cardTheme: CardTheme(color: Colors.black)),
      home: Homescreen(),
    );
  }
}
