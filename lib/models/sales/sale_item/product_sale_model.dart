import 'package:hive_flutter/hive_flutter.dart';
part 'product_sale_model.g.dart';

@HiveType(typeId: 4)
class ProductSaleModel {
  @HiveField(0)
  String productId;
  @HiveField(1)
  int price;
  @HiveField(2)
  int quantity;
  ProductSaleModel({
    required this.productId,
    required this.price,
    required this.quantity,
  });
}
