import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stockup/db_funtions.dart/product_funtion.dart';
import 'package:stockup/db_funtions.dart/product_sale_funtion.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:stockup/screens/custemwidgets.dart';
part 'product_sale_model.g.dart';

@HiveType(typeId: 4)
class ProductSaleModel extends HiveObject {
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

void addProductFromProductDetailPage(ProductModel pro, BuildContext context) {
  final product = getProductByProductId(pro.productId);

  int currentindex = currentIndex(pro.productId);

  final totalSaleQuantity = TotalSaleQuantity(pro.productId);

  if (totalSaleQuantity + 1 > product.quatity) {
    customsnackbar(
        context,
        "Insufficient stock. Available: ${product.quatity - totalSaleQuantity}",
        Colors.red);
    return;
  }

  if (currentindex != -1) {
    ProductSaleModel existingProduct = productSaleNotifier.value[currentindex];
    ProductSaleModel updatedProduct = ProductSaleModel(
        productId: existingProduct.productId,
        price: existingProduct.price + pro.sellingPrice,
        quantity: existingProduct.quantity + 1);
    List<ProductSaleModel> updatedList = [...productSaleNotifier.value];
    updatedList[currentindex] = updatedProduct;
    productSaleNotifier.value = updatedList;
  } else {
    var saleProduct = ProductSaleModel(
        productId: pro.productId, price: pro.sellingPrice, quantity: 1);

    updatedAddSaleProduct(saleProduct);
  }
}
