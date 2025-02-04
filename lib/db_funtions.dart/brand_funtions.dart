import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stockup/models/brands/brand_model.dart';

const BRAND_BOX = "brand";
ValueNotifier<List<BrandModel>> brandListnotifier = ValueNotifier([]);

Future<void> addBrand(BrandModel value) async {
  var box = Hive.box<BrandModel>(BRAND_BOX);
  await box.add(value);
  log("Added brand: $value");
  getBrand();
}

void getBrand() {
  brandListnotifier.value.clear();

  var box = Hive.box<BrandModel>(BRAND_BOX);

  brandListnotifier.value.addAll(box.values);

  var data = box.values;
  brandListnotifier.notifyListeners();
  log(" data $data");
}

String findBrand(String id) {
  var box = Hive.box<BrandModel>(BRAND_BOX);
  final data = box.values;

  final brand = data.firstWhere(
    (element) => element.brandId == id,
  );

  return brand.brandname;
}

Future<void> deleteBrand(int index) async {
  var box = Hive.box<BrandModel>(BRAND_BOX);
  await box.deleteAt(index);
  getBrand();
}

Future<void> editBrand(int index, String brand) async {
  var box = Hive.box<BrandModel>(BRAND_BOX);
  var currentvalue = box.getAt(index);
  if (currentvalue == null) {
    return log("no index");
  }
  await box.putAt(
      index, BrandModel(brandname: brand, brandId: currentvalue.brandId));
  getBrand();
}

String generateId() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}

List<BrandModel> getBrandList() {
  var box = Hive.box<BrandModel>(BRAND_BOX);
  return box.values.toList();
}

List<BrandModel> getAllBrand() {
  var box = Hive.box<BrandModel>(BRAND_BOX);
  return box.values.toList();
}
