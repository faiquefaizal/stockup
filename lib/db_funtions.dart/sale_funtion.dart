// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:stockup/db_funtions.dart/product_funtion.dart';
// import 'package:stockup/models/product/product_model.dart';
// import 'package:stockup/models/sales/sale/sales_model.dart';

// ValueNotifier<List<SalesModel>> salenotifier = ValueNotifier([]);
// const SALE_BOX = "salebox";
// Future<void> addSale(SalesModel value) async {
//   var salebox = await Hive.openBox<SalesModel>(SALE_BOX);
//   var productbox = await Hive.openBox<ProductModel>(PRODUCT_BOX);
//   var product = productbox.values.firstWhere((item) {
//     return item.productId == value.productId;
//   }, orElse: () => throw Exception("product no found"));

//   if (value.quantity <= product.quatity) {
//     salebox.add(value);
//     product.quatity = (product.quatity - value.quantity);
//     productbox.put(product.productId, product);
//     productsnotifier.notifyListeners();
//     getAllSales();
//   } else {
//     throw Exception("Product is out of Stock");
//   }
// }

// void getAllSales() {
//   var box = Hive.box<SalesModel>(SALE_BOX);
//   salenotifier.value.clear();
//   salenotifier.value.addAll(box.values);
//   log(box.values.toString());
// }
import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:stockup/db_funtions.dart/product_funtion.dart';
import 'package:stockup/db_funtions.dart/product_sale_funtion.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:stockup/models/sales/sale_/sales_model.dart';
import 'package:stockup/models/sales/sale_item/product_sale_model.dart';
import 'package:stockup/screens/add.dart';

ValueNotifier<List<SalesModel>> salenotifier = ValueNotifier([]);
const SALE_BOX = "salebox";
Future<void> addSale(SalesModel value) async {
  var box = Hive.box<SalesModel>(SALE_BOX);
  var productBox = Hive.box<ProductModel>(PRODUCT_BOX);
  var productIds =
      value.saleProducts.map((element) => element.productId).toList();
  await box.put(value.saleId, value);
  for (int i = 0; i < productIds.length; i++) {
    var productToUpdate = productBox.get(productIds[i]);
    if (productToUpdate != null) {
      productToUpdate.quatity -= value.saleProducts[i].quantity;
      productBox.put(productIds[i], productToUpdate);
      productsnotifier.notifyListeners();
      getAllSales();
      log("sale completed");
    } else {
      throw Exception("Product Not Found to make Sale");
    }
  }
}

void getAllSales() {
  salenotifier.value.clear();
  var box = Hive.box<SalesModel>(SALE_BOX);
  salenotifier.value.addAll(box.values);
  // log(box.values.toString());
  salenotifier.notifyListeners();
}

void deleteSale(int index) {
  var box = Hive.box<SalesModel>(SALE_BOX);
  box.deleteAt(index);
  getAllSales();
}

SalesModel getsaleByindex(int index) {
  var box = Hive.box<SalesModel>(SALE_BOX);
  var sales = box.values;
  var sale = box.getAt(index);
  return sale!;
}

void editSale(SalesModel sale) {
  var box = Hive.box<SalesModel>(SALE_BOX);
  box.put(sale.saleId, sale);
  getAllSales();
  // log("edited");
}

double getTotalSales() {
  var box = Hive.box<SalesModel>(SALE_BOX);
  var sales = salenotifier.value;
  return sales.fold(0, (pre, value) => pre + value.totalSalePrice);
}

int getTotalnoofproducts() {
  var box = Hive.box<SalesModel>(SALE_BOX);
  var sales = salenotifier.value;
  int totalquantity = sales
      .expand((sale) => sale.saleProducts)
      .fold(0, (pre, cur) => pre + cur.quantity);
  // log(totalquantity.toString());

  return totalquantity;
}

int getProfit() {
  var sales = salenotifier.value;
  var saleProductId = sales
      .expand((value) => value.saleProducts)
      .map((value) => value.productId);
  var box = Hive.box<ProductModel>(PRODUCT_BOX);
  var productBox = box.values;
  // int sellingPrice = productBox
  //     .where((value) => saleProductId.contains(value.productId))
  //     .map((value) => value.sellingPrice)
  //     .fold(0, (a, b) => a + b);

  int sellingPrice = productBox
      .where((value) => saleProductId.contains(value.productId))
      .map((element) {
    int quantity = sales
        .expand((value) => value.saleProducts)
        .where((product) => element.productId == product.productId)
        .fold(0, (a, b) => a + b.quantity);

    return element.sellingPrice * quantity;
  }).fold(0, (pre, cur) => pre + cur);

  // log("Selling ${sellingPrice.toString()}");

  int buyingPrice = productBox
      .where((value) => saleProductId.contains(value.productId))
      .map((element) {
    int quatity = sales
        .expand((value) => value.saleProducts)
        .where((product) => element.productId == product.productId)
        .fold(0, (a, b) => a + b.quantity);

    return element.price * quatity;
  }).fold(0, (a, b) => a + b);

  // int buyingPrice = productBox
  //     .where((value) => saleProductId.contains(value.productId))
  //     .map((value) => value.price)
  //     .fold(0, (a, b) => a + b);
  // log("buyingPrice${buyingPrice.toString()}");
  int profit = sellingPrice - buyingPrice;
  // log(profit.toString());

  return profit;
}

String formatdate(DateTime date) {
  return DateFormat("yyyy-MM-dd").format(date);
}

List<String> getSaleDate() {
  var salebox = Hive.box<SalesModel>(SALE_BOX);
  var sales = salebox.values;
  var saleDates = sales
      .map((element) {
        String formatedDate;
        formatedDate = formatdate(element.saleDate);
        return formatedDate;
      })
      .toSet()
      .toList();
  return saleDates;
}

List<FlSpot> saleGraphList() {
  var sales = salenotifier.value;
  var saleDates = sales
      .map((element) {
        String formatedDate;
        formatedDate = formatdate(element.saleDate);
        return formatedDate;
      })
      .toSet()
      .toList();

  var totalSaleByDate = saleDates.map((element) {
    return {
      "date": element,
      "totalSale": sales
          .where((value) => formatdate(value.saleDate) == element)
          .fold(0, (cur, pre) => cur + pre.totalSalePrice.toInt())
    };
  }).toList();
  totalSaleByDate.sort((a, b) => DateTime.parse(a["date"] as String)
      .compareTo(DateTime.parse(b["date"] as String)));
  List<FlSpot> spot = [];
  for (int i = 0; i < totalSaleByDate.length; i++) {
    // double x = DateTime.parse(totalSaleByDate[i]["date"] as String)
    //     .millisecondsSinceEpoch
    //     .toDouble();
    double x = i.toDouble();
    double y = (totalSaleByDate[i]["totalSale"] as int) / 1000.toDouble();
    spot.add(FlSpot(x, y));
    log(totalSaleByDate.toString());
  }

  // return totalSaleByDate;
  log(spot.toString());
  return spot;
}

// List<FlSpot> saleGraphList() {
//   // Use a local copy to avoid concurrent modification
//   var sales = List.from(salenotifier.value ?? []);

//   if (sales.isEmpty) {
//     return [];
//   }

//   // Format dates with error handling
//   String formatDate(DateTime date) {
//     try {
//       return DateFormat('yyyy-MM-dd').format((date));
//     } catch (e) {
//       return '1970-01-01'; // Fallback date
//     }
//   }

//   // Extract unique dates
//   var saleDates = sales.map((e) => formatDate(e.saleDate)).toSet().toList();

//   // Calculate total sales per date
//   var totalSaleByDate = saleDates.map((date) {
//     num total = sales
//         .where((sale) => formatDate(sale.saleDate) == date)
//         .fold(0, (sum, sale) => sum + (sale.totalSalePrice ?? 0).toInt());
//     return {"date": date, "totalSale": total};
//   }).toList();

//   // Sort with date parsing error handling
//   log(totalSaleByDate.toString());
//   totalSaleByDate.sort((a, b) {
//     try {
//       final dateA = DateTime.parse(a["date"] as String);
//       final dateB = DateTime.parse(b["date"] as String);
//       return dateA.compareTo(dateB);
//     } catch (e) {
//       return 0;
//     }
//   });

//   // Build FlSpot list safely
//   List<FlSpot> spot = [];
//   for (int i = 0; i < totalSaleByDate.length; i++) {
//     dynamic totalSaleValue = totalSaleByDate[i]["totalSale"];
//     double y = (totalSaleValue is num) ? totalSaleValue.toDouble() / 1000 : 0.0;
//     spot.add(FlSpot(i.toDouble(), y));
//   }
//   log(spot.toString());

//   return spot;
// }

List<String> getAllSaleDate() {
  var box = Hive.box<SalesModel>(SALE_BOX);
  var sales = box.values;
  var dates = sales
      .map((value) => DateFormat("dd-MMM").format(value.saleDate))
      .toSet()
      .toList();

  dates.sort(
    (a, b) => a.compareTo(b),
  );
  // print(dates);
  // log(dates.toString());
  return dates;
}
