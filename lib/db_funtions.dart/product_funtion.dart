import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stockup/db_funtions.dart/sale_funtion.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:flutter/foundation.dart';

const PRODUCT_BOX = "productbox";
ValueNotifier<List<ProductModel>> productsnotifier = ValueNotifier([]);
Future<void> addProduct(ProductModel value) async {
  var box = Hive.box<ProductModel>(PRODUCT_BOX);

  await box.put(value.productId, value);
  getProducts();
}

void getProducts() {
  productsnotifier.value.clear();
  var box = Hive.box<ProductModel>(PRODUCT_BOX);

  productsnotifier.value.addAll(box.values);
  productsnotifier.notifyListeners();
}

ProductModel? getProductById(int index) {
  var box = Hive.box<ProductModel>(PRODUCT_BOX);
  var product = box.getAt(index);
  return product;
}

Future<void> editProducts(ProductModel value) async {
  var box = Hive.box<ProductModel>(PRODUCT_BOX);
  await box.put(value.productId, value);
  getProducts();
  await stockCheckNotification();
}

Future<void> deleteProduct(int index) async {
  var box = Hive.box<ProductModel>(PRODUCT_BOX);
  await box.deleteAt(index);
  getProducts();
}

List<ProductModel> getProductListByid(String id) {
  var box = Hive.box<ProductModel>(PRODUCT_BOX);
  var products = box.values;
  var productlist = products.where((value) {
    return value.brandId.toLowerCase().contains(id.toLowerCase());
  }).toList();
  return productlist;
}

int getPricebyproduct(String productId) {
  var box = Hive.box<ProductModel>(PRODUCT_BOX);
  var product = box.values;
  var price = product.firstWhere((value) => value.productId == productId);
  return price.sellingPrice;
}

ProductModel getProductNameFromId(String id) {
  var box = Hive.box<ProductModel>(PRODUCT_BOX);
  var products = box.values;
  var product = products.firstWhere((value) => value.productId == id);
  return product;
}

ProductModel getProductByProductId(String id) {
  var box = Hive.box<ProductModel>(PRODUCT_BOX);
  var product = box.get(id);
  return product!;
}

bool productCheck(ProductModel product) {
  var box = Hive.box<ProductModel>(PRODUCT_BOX);
  var products = box.values;
  return products.any((value) =>
      value.productame.toLowerCase() == product.productame.toLowerCase() &&
      value.productId != product.productId);
}
