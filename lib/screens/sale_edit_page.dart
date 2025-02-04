import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockup/db_funtions.dart/product_funtion.dart';
import 'package:stockup/db_funtions.dart/product_sale_funtion.dart';
import 'package:stockup/db_funtions.dart/sale_funtion.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:stockup/models/sales/sale_/sales_model.dart';
import 'package:stockup/models/sales/sale_item/product_sale_model.dart';

import 'package:stockup/screens/add_product_to_sale.dart';
import 'package:stockup/screens/custemwidgets.dart';

class SaleEditPage extends StatefulWidget {
  int index;
  SaleEditPage({super.key, required this.index});
  @override
  State<SaleEditPage> createState() => _SaleEditPageState();
}

class _SaleEditPageState extends State<SaleEditPage> {
  final _custemernamecontroller = TextEditingController();

  final _custemernumbercontroller = TextEditingController();

  final _pricecontroller = TextEditingController();

  List<ProductSaleModel> productList = [];
  String? saleId;
  int? total;

  DateTime? date;

  final TextEditingController _datecontroller = TextEditingController();
  @override
  void initState() {
    _loadSale();

    super.initState();
  }

  _loadSale() {
    var sale = getsaleByindex(widget.index);
    _custemernamecontroller.text = sale.custumerName;

    _custemernumbercontroller.text = sale.phoneNumber;
    // final _quatitycontroller = TextEditingController();
    // final _productname = TextEditingController();
    _pricecontroller.text = sale.totalSalePrice.toString();
    productList = sale.saleProducts;
    date = sale.saleDate;
    total = sale.totalSalePrice.toInt();
    productSaleNotifier.value = List.from(sale.saleProducts);
    _datecontroller.text = DateFormat('yyyy-MM-dd').format(sale.saleDate);

    saleId = sale.saleId;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Edit Sale",
                style: TextStyle(fontSize: 60, color: Colors.black),
              ),
              field(_custemernamecontroller, "Custemer Name", "Name"),
              const SizedBox(
                height: 10,
              ),
              field(_custemernumbercontroller, "Phone number", "Number"),
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
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: productSaleNotifier,
                    builder: (context, products, child) {
                      return ListView.builder(
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
                                  color: Colors.white,
                                  child: ListTile(
                                    title: Text(
                                      productDetails.productame,
                                      style: const TextStyle(
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
                      builder: (context) => const AddProductToSale()));
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
                    (total == null) ? "Total: ₹ 0" : "Total: ₹ $total",
                    style: const TextStyle(
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
                      ButtonName: "Edit Sale",
                      actionFuntion: () async {
                        await editSaleButton();
                      })),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Datedialog(BuildContext context) async {
    log("hello");
    date = await showDatePicker(
        context: context,
        currentDate: DateTime.now(),
        firstDate: DateTime(2025),
        lastDate: DateTime(2100));
    if (date != null) {
      setState(() {
        _datecontroller.text = date.toString().split(" ")[0];
      });
    }
  }

  Future<void> editSaleButton() async {
    String custumerName = _custemernamecontroller.text.trim();
    String phoneNumber = _custemernumbercontroller.text.trim();
    DateTime saleDate = date!;

    double totalsale = total!.toDouble();
    List<ProductSaleModel> productList = productSaleNotifier.value;
    int quatity = productList.length;
    var sale = SalesModel(
        custumerName: custumerName,
        phoneNumber: phoneNumber,
        saleDate: saleDate,
        productCount: quatity,
        totalSalePrice: totalsale,
        saleId: saleId!,
        saleProducts: productList);
    try {
      await editSale(sale);
      log("funtionpressed");
      customsnackbar(context, "Sale Edited", Colors.green);
      Navigator.of(context).pop();
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
