import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stockup/db_funtions.dart/brand_funtions.dart';
import 'package:stockup/db_funtions.dart/product_funtion.dart';
import 'package:stockup/db_funtions.dart/product_sale_funtion.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:stockup/models/sales/sale_item/product_sale_model.dart';
import 'package:stockup/screens/custemwidgets.dart';

class AddProductToSale extends StatefulWidget {
  const AddProductToSale({super.key});

  @override
  State<AddProductToSale> createState() => _AddProductToSaleState();
}

String hello = "iam";

String? seletedbrand;
String? selectedproduct;
List<ProductModel> productList = [];
TextEditingController _quatity = TextEditingController();
TextEditingController _price = TextEditingController();
int? price;
String brandId = generateId();

class _AddProductToSaleState extends State<AddProductToSale> {
  @override
  Widget build(BuildContext context) {
    log("build$hello");
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ValueListenableBuilder(
                  valueListenable: brandListnotifier,
                  builder: (context, brandmodellist, widget) {
                    return DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                        ),
                        hint: const Text("Brand"),
                        isExpanded: true,
                        style: const TextStyle(color: Colors.black),
                        items: brandmodellist.map((value) {
                          return DropdownMenuItem(
                              value: value.brandId,
                              child: Text(value.brandname,
                                  style: const TextStyle(color: Colors.black)));
                        }).toList(),
                        value: seletedbrand,
                        onChanged: (selectedvalue) {
                          setState(() {
                            seletedbrand = selectedvalue;
                            log(seletedbrand!);
                            productList = getProductListByid(seletedbrand!);
                            print(productList);
                            selectedproduct = null;
                            _price.text = "";
                          });
                        });
                  }),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                  ),
                  hint: const Text("Select Item"),
                  value: selectedproduct,
                  items: productList.map((element) {
                    return DropdownMenuItem(
                        value: element.productId,
                        child: Text(element.productame));
                  }).toList(),
                  onChanged: (selectedValue) {
                    setState(() {
                      selectedproduct = selectedValue;
                      price = getPricebyproduct(selectedproduct!);
                      log(price.toString());
                      _price.text = price.toString() ?? "";
                    });
                  }),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(child: field(_price, "price", "Price")),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(child: field(_quatity, "Quantity", "No of Items"))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustemElevatedButton(
                  ButtonName: "Add product",
                  actionFuntion: () {
                    _addProductButton();
                  })
            ],
          ),
        ),
      ),
    );
  }

  void _addProductButton() {
    final productId = selectedproduct;
    final int quantity = int.parse(_quatity.text);
    final totalPrice = int.parse(_price.text) * int.parse(_quatity.text);

    if (productId == null || quantity <= 0) {
      customsnackbar(context, "Invalid input. Check fields.", Colors.red);
      return;
    }

    final product = getProductByProductId(productId);

    int currentindex = currentIndex(productId);

    final totalSaleQuantity = TotalSaleQuantity(productId);

    if (totalSaleQuantity + quantity > product.quatity) {
      customsnackbar(
          context,
          "Insufficient stock. Available: ${product.quatity - totalSaleQuantity}",
          Colors.red);
      return;
    }

    if (currentindex != -1) {
      CustumAlertDialog(
        context: context,
        title: "Product Exist",
        subtitle: "product Already exist in sale",
        noButton: "add new",
        yesButton: "update",
        yesonPressed: () {
          ProductSaleModel existingProduct =
              productSaleNotifier.value[currentindex];
          ProductSaleModel updatedProduct = ProductSaleModel(
              productId: existingProduct.productId,
              price: existingProduct.price + totalPrice,
              quantity: existingProduct.quantity + quantity);
          List<ProductSaleModel> updatedList = [...productSaleNotifier.value];
          updatedList[currentindex] = updatedProduct;
          productSaleNotifier.value = updatedList;
          popTwice(context);
        },
        noonpressed: () {
          setState(() {
            seletedbrand = null;
            selectedproduct = null;
            _quatity.clear();
            _price.clear();
          });
          Navigator.pop(context);
        },
      );
    } else {
      var saleProduct = ProductSaleModel(
          productId: productId, price: totalPrice, quantity: quantity);

      //   try {
      updatedAddSaleProduct(saleProduct);
      Navigator.pop(context);
      //   } catch (e) {
      //     custumSnackBarException(e, context);

      //     log(total_price.toString());
      //   }
      // }
      setState(() {
        seletedbrand = null;
        selectedproduct = null;
        _quatity.clear();
        _price.clear();
      });
    }
  }
}
