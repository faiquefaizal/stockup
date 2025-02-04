import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stockup/db_funtions.dart/product_funtion.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:stockup/models/sales/sale_item/product_sale_model.dart';

ValueNotifier<List<ProductSaleModel>> productSaleNotifier = ValueNotifier([]);
const SALE_PRODUCT = "saleProduct";
void addSaleProduct(ProductSaleModel saleItem) {
  // var box = Hive.box<ProductSaleModel>(SALE_PRODUCT);
  var productbox = Hive.box<ProductModel>(PRODUCT_BOX);
  var product = productbox.values
      .firstWhere((value) => value.productId == saleItem.productId);

  if (product.quatity > saleItem.quantity) {
    productSaleNotifier.value.add(saleItem);
    productSaleNotifier.notifyListeners();
  } else {
    throw Exception("The Product is out of Stock");
  }
}

updatedAddSaleProduct(ProductSaleModel saleItem) {
  productSaleNotifier.value.add(saleItem);
  productSaleNotifier.notifyListeners();
}
// void getAllSaleProducts(String id) {
//   var box = Hive.box<ProductSaleModel>(SALE_PRODUCT);
//   productSaleNotifier.value.clear();
//   var products = box.values.where((value) => value.saleId == id);
//   productSaleNotifier.value.addAll(products);
//   productSaleNotifier.notifyListeners();
// }

// void deleteSaleProduct(ProductSaleModel value) {
//   var box = Hive.box<ProductSaleModel>(SALE_PRODUCT);
//   box.delete(value.productId);
//   getAllSaleProducts(value.saleId);
// }
// int checkSaleProduct(String id) {
//   var totalquatity = productSaleNotifier.value
//       .where((value) => value.productId == id)
//       .fold(0, (a, b) => a + b.quantity);
//   // return totalquatity;
// Hive.box(pr)

// }
// if(){

// }
//   final totalSaleQuantity = productSaleNotifier.value
//       .where((item) => item.productId == product_Id)
//       .fold(0, (sum, item) => sum + item.quantity);

//   // Check if stock is sufficient for the new total
//   if (totalSaleQuantity + quantity > product.stock) {
//     custumSnackBar(
//       "Insufficient stock. Available: ${product.stock - totalSaleQuantity}",
//       context
//     );
//     return;
//   }
//   final totalSaleQuantity = productSaleNotifier.value
//       .where((item) => item.productId == product_Id)
//       .fold(0, (sum, item) => sum + item.quantity);
int currentIndex(String id) {
  return productSaleNotifier.value
      .indexWhere((product) => product.productId == id);
}

int TotalSaleQuantity(String id) {
  int value = productSaleNotifier.value
      .where((item) => item.productId == id)
      .fold(0, (sum, item) => sum + item.quantity);
  return value;
}
