import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockup/db_funtions.dart/brand_funtions.dart';
import 'package:stockup/db_funtions.dart/product_funtion.dart';
import 'package:stockup/db_funtions.dart/product_sale_funtion.dart';
import 'package:stockup/db_funtions.dart/sale_funtion.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:stockup/models/sales/sale_/sales_model.dart';
import 'package:stockup/models/sales/sale_item/product_sale_model.dart';

import 'package:stockup/screens/add_product_to_sale.dart';
import 'package:stockup/screens/custemwidgets.dart';
import 'package:stockup/screens/sale_completd.dart';

class Add extends StatefulWidget {
  const Add({super.key});
  @override
  State<Add> createState() => _AddState();
}

String? SaleId;

class _AddState extends State<Add> {
  final _form = GlobalKey<FormState>();
  final _custemernamecontroller = TextEditingController();

  final _custemernumbercontroller = TextEditingController();
  // final _quatitycontroller = TextEditingController();
  // final _productname = TextEditingController();
  final _pricecontroller = TextEditingController();
  String? selectedBrand;
  List<ProductModel> productList = [];
  String? selectedProduct;
  int? total;
  int? quantity;
  int? PriceItem;
  DateTime? date;

  final TextEditingController _datecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _form,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add Sale",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                fieledvalidation(
                    _custemernamecontroller, "Custemer Name", "Name", (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter a Name";
                  }
                  if (value.length < 5) {
                    return "Name must be at least 5 characters long";
                  }
                  return null;
                }),
                const SizedBox(
                  height: 10,
                ),
                fieledvalidation(
                    _custemernumbercontroller, "Phone number", "Number",
                    (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter a number";
                  }
                  if (value.length != 10) {
                    return "Enter a valid 10-digit phone number";
                  }
                  return null;
                }, inputtype: TextInputType.phone),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _datecontroller,
                    decoration: const InputDecoration(
                        labelText: "DATE",
                        prefixIcon: Icon(Icons.calendar_month),
                        border: OutlineInputBorder()),
                    readOnly: true,
                    onTap: () {
                      Datedialog(context);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select a date";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ValueListenableBuilder(
                    valueListenable: productSaleNotifier,
                    builder: (context, products, child) {
                      if (products.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            var saleProducts = products[index];
                            ProductModel productDetails =
                                getProductNameFromId(saleProducts.productId);

                            return Dismissible(
                                background: Container(
                                  color: Colors.red,
                                  child: const Icon(Icons.delete),
                                ),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  setState(() {
                                    productSaleNotifier.value.removeAt(index);
                                  });
                                },
                                key: Key(saleProducts.productId),
                                child: Card(
                                  color: Colors.grey[850], // Darker background
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    title: Text(
                                      productDetails.productame,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      "Qty:  ${saleProducts.quantity} X ${productDetails.sellingPrice} =${saleProducts.price}",
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 20),
                                    ),
                                  ),
                                ));
                          });
                    }),
                Center(
                    child: CustemElevatedButtonWithIcon(
                  icon: Icons.add_circle,
                  ButtonName: "Add product",
                  actionFuntion: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddProductToSale()));
                  },
                  background: Colors.black,
                  foreground: Colors.white,
                )),
                ValueListenableBuilder(
                  valueListenable: productSaleNotifier,
                  builder: (context, products, child) {
                    total = products.fold(
                        0,
                        (previoesvalue, current) =>
                            previoesvalue! + current.price);
                    return Text(
                      (total == null) ? "Total: ₹ 0" : "Total: ₹ $total",
                      style: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    );
                  },
                ),
                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: CustemElevatedButton(
                        ButtonName: "Add Sale",
                        actionFuntion: () {
                          if (_form.currentState!.validate()) {
                            addSaleButton();
                          }
                        })),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Datedialog(BuildContext context) async {
    date = await showDatePicker(
        context: context,
        currentDate: DateTime.now(),
        firstDate: DateTime(2025),
        lastDate: DateTime(2100));
    if (date != null) {
      setState(() {
        var formated = DateFormat("dd-MM-yyyy").format(date!);
        // _datecontroller.text = date.toString().split(" ")[0];
        _datecontroller.text = formated;
      });
    }
  }

  Future<void> addSaleButton() async {
    String custumerName = _custemernamecontroller.text.trim();
    String phoneNumber = _custemernumbercontroller.text.trim();
    DateTime saleDate = date!;

    double totalsale = total!.toDouble();
    String saleId = generateId();
    // List<ProductSaleModel> productList = productSaleNotifier.value;
    List<ProductSaleModel> productList =
        List<ProductSaleModel>.from(productSaleNotifier.value);

    log(productList.length.toString());
    for (var element in productList) {
      var s = element.quantity;
      log(s.toString());
    }
    int quatity = productList.length;
    if (productList.isEmpty) {
      customsnackbar(context, "Add Product First", Colors.red);
      return;
    }
    var sale = SalesModel(
      custumerName: custumerName,
      phoneNumber: phoneNumber,
      saleDate: saleDate,
      productCount: quatity,
      totalSalePrice: totalsale,
      saleId: saleId,
      saleProducts: List<ProductSaleModel>.from(
          productSaleNotifier.value), // Create a copy here
    );

    log("lastcheckbeforesale${productList.length.toString()}");
    log("lastcheckbeforesaleinmodel${sale.saleProducts.length.toString()}");
    try {
      await addSale(sale);
      log("lastcheckAftersale${productList.length.toString()}");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SaleCompletd(oncomplition: () {
                _custemernamecontroller.clear();
                _custemernumbercontroller.clear();
                _datecontroller.clear();
                date = null;
                total = 0;
                productSaleNotifier.value.clear();
                productSaleNotifier.notifyListeners();
                popTwice(context);
              })));
    } catch (e) {
      String errormessage = e.toString().replaceFirst("Exception", "");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(8),
          backgroundColor: Colors.red,
          padding: const EdgeInsets.all(8),
          content: Text(
            "Error: $errormessage",
            style: const TextStyle(fontSize: 15),
          )));
    }
  }
}
