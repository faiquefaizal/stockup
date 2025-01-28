import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stockup/db_funtions.dart/brand_funtions.dart';
import 'package:stockup/db_funtions.dart/product_funtion.dart';
import 'package:stockup/db_funtions.dart/product_sale_funtion.dart';
import 'package:stockup/models/brands/brand_model.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:stockup/models/sales/sale_item/product_sale_model.dart';
import 'package:stockup/screens/add.dart';
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
    log("build${hello}");
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
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                        hint: Text("Brand"),
                        isExpanded: true,
                        style: TextStyle(color: Colors.black),
                        items: brandmodellist.map((value) {
                          return DropdownMenuItem(
                              value: value.brandId,
                              child: Text(value.brandname,
                                  style: TextStyle(color: Colors.black)));
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
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  hint: Text("Select Item"),
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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(child: field(_price, "price", "Price")),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: field(_quatity, "Quantity", "No of Items"))
                ],
              ),
              SizedBox(
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
    final product_Id = selectedproduct;
    final quantity = _quatity.text;
    final total_price = int.parse(_price.text) * int.parse(_quatity.text);
    var saleProduct = ProductSaleModel(
      productId: product_Id!,
      price: total_price,
      quantity: int.parse(quantity),
    );
    try {
      addSaleProduct(saleProduct);
      Navigator.pop(context);
      setState(() {
        seletedbrand = null;
        selectedproduct = null;
        _quatity.clear();
        _price.clear();
      });
    } catch (e) {
      custumSnackBarException(e, context);

      log(total_price.toString());
    }
  }
}
