import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockup/db_funtions.dart/brand_funtions.dart';
import 'package:stockup/db_funtions.dart/product_funtion.dart';
import 'package:stockup/db_funtions.dart/product_sale_funtion.dart';
import 'package:stockup/db_funtions.dart/sale_funtion.dart';
import 'package:stockup/models/brands/brand_model.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:stockup/models/sales/sale_/sales_model.dart';
import 'package:stockup/models/sales/sale_item/product_sale_model.dart';

import 'package:stockup/screens/add_product_to_sale.dart';
import 'package:stockup/screens/custemwidgets.dart';
import 'package:stockup/screens/sale_completd.dart';

class Add extends StatefulWidget {
  Add({super.key});
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

  TextEditingController _datecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Sale",
                  style: TextStyle(fontSize: 60, color: Colors.black),
                ),
                fieledvalidation(
                    _custemernamecontroller, "Custemer Name", "Name", (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter a Name";
                  }
                  if (value.length < 6) {
                    return "Name must be at least 6 characters long";
                  }
                  return null;
                }),
                SizedBox(
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
                SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _datecontroller,
                    decoration: InputDecoration(
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
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: ValueListenableBuilder(
                      valueListenable: productSaleNotifier,
                      builder: (context, products, child) {
                        if (products.isEmpty) {
                          return SizedBox.shrink();
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              var saleProducts = products[index];
                              ProductModel productDetails =
                                  getProductNameFromId(saleProducts.productId);

                              return Dismissible(
                                  background: Container(
                                    color: Colors.red,
                                    child: Icon(Icons.delete),
                                  ),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    setState(() {
                                      productSaleNotifier.value.removeAt(index);
                                    });
                                  },
                                  key: Key(saleProducts.productId),
                                  child: Card(
                                    color: Colors.white,
                                    child: ListTile(
                                      title: Text(
                                        productDetails.productame,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                          "Qty:  ${saleProducts.quantity} X ${productDetails.sellingPrice} =${saleProducts.price}"),
                                    ),
                                  ));
                            });
                      }),
                ),
                Center(
                    child: CustemElevatedButtonWithIcon(
                  icon: Icons.add_circle,
                  ButtonName: "Add product",
                  actionFuntion: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddProductToSale()));
                  },
                  background: Colors.white,
                  foreground: Colors.black,
                )),
                ValueListenableBuilder(
                  valueListenable: productSaleNotifier,
                  builder: (context, products, child) {
                    total = products.fold(
                        0,
                        (previoesvalue, current) =>
                            previoesvalue! + current.price);
                    return Text(
                      (total == null) ? "Total: ₹ 0" : "Total: ₹ ${total}",
                      style: TextStyle(
                          fontSize: 50,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
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
                SizedBox(
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
    List<ProductSaleModel> productList = productSaleNotifier.value;
    int quatity = productList.length;
    var sale = SalesModel(
        custumerName: custumerName,
        phoneNumber: phoneNumber,
        saleDate: saleDate,
        productCount: quatity,
        totalSalePrice: totalsale,
        saleId: saleId,
        saleProducts: productList);
    try {
      await addSale(sale);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SaleCompletd(oncomplition: () {
                _custemernamecontroller.clear();
                _custemernumbercontroller.clear();
                _datecontroller.clear();
                date = null;
                total = 0;
                productSaleNotifier.value.clear();
                productSaleNotifier.notifyListeners();
                Navigator.pop(context);
              })));
    } catch (e) {
      String errormessage = e.toString().replaceFirst("Exception", "");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(8),
          backgroundColor: Colors.red,
          padding: EdgeInsets.all(8),
          content: Text(
            "Error: ${errormessage}",
            style: TextStyle(fontSize: 15),
          )));
    }
  }
}
