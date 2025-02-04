import 'package:hive_flutter/hive_flutter.dart';
import 'package:stockup/models/sales/sale_item/product_sale_model.dart';
part 'sales_model.g.dart';

@HiveType(typeId: 3)
class SalesModel extends HiveObject {
  @HiveField(0)
  String custumerName;
  @HiveField(1)
  String phoneNumber;
  @HiveField(2)
  DateTime saleDate;
  @HiveField(3)
  int productCount;
  @HiveField(4)
  double totalSalePrice;
  @HiveField(5)
  String saleId;
  @HiveField(6)
  List<ProductSaleModel> saleProducts;
  SalesModel(
      {required this.custumerName,
      required this.phoneNumber,
      required this.saleDate,
      required this.productCount,
      required this.totalSalePrice,
      required this.saleId,
      required this.saleProducts});
}
