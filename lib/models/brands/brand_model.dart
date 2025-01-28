import 'package:hive_flutter/hive_flutter.dart';
part 'brand_model.g.dart';

@HiveType(typeId: 1)
class BrandModel {
  @HiveField(0)
  String brandname;
  @HiveField(1)
  String brandId;
  BrandModel({required this.brandname, required this.brandId});
}
