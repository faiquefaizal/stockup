import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:flutter/foundation.dart';

const PRODUCT_BOX = "productbox";
ValueNotifier<List<ProductModel>> productsnotifier = ValueNotifier([]);
Future<void> addProduct(ProductModel value) async {
  var box = await Hive.openBox<ProductModel>(PRODUCT_BOX);

  await box.put(value.productId, value);
  getProducts();
}

Future<void> getProducts() async {
  productsnotifier.value.clear();
  var box = await Hive.openBox<ProductModel>(PRODUCT_BOX);

  productsnotifier.value.addAll(box.values);
  productsnotifier.notifyListeners();
}

Future<ProductModel?> getProductById(int index) async {
  var box = await Hive.openBox<ProductModel>(PRODUCT_BOX);
  var product = box.getAt(index);
  return product;
}

Future<void> editProducts(ProductModel value) async {
  var box = await Hive.openBox<ProductModel>(PRODUCT_BOX);
  box.put(value.productId, value);
  getProducts();
}

Future<void> deleteProduct(int index) async {
  var box = await Hive.openBox<ProductModel>(PRODUCT_BOX);
  box.deleteAt(index);
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
