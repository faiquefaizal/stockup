import 'package:hive_flutter/hive_flutter.dart';
part 'product_model.g.dart';

@HiveType(typeId: 2)
class ProductModel {
  @HiveField(0)
  String productame;

  @HiveField(1)
  int price;

  @HiveField(2)
  int sellingPrice;

  @HiveField(3)
  String ram;

  @HiveField(4)
  String color;

  @HiveField(5)
  String storage;

  @HiveField(6)
  String os;

  @HiveField(7)
  String screenSize;

  @HiveField(8)
  String brandId;

  @HiveField(9)
  int quatity;

  @HiveField(10)
  String imagePath;

  @HiveField(11)
  String productId;
  ProductModel(
      {required this.productame,
      required this.price,
      required this.sellingPrice,
      required this.ram,
      required this.color,
      required this.storage,
      required this.os,
      required this.screenSize,
      required this.brandId,
      required this.quatity,
      required this.imagePath,
      required this.productId});
}
