import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stockup/db_funtions.dart/product_funtion.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:stockup/models/sales/sale_item/product_sale_model.dart';
import 'package:stockup/screens/add.dart';

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
